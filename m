From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] commit -v: strip diffs and submodule shortlogs from the commit message
Date: Thu, 05 Dec 2013 15:10:03 -0800
Message-ID: <xmqqzjoe3nec.fsf@gitster.dls.corp.google.com>
References: <528D385F.2070906@web.de>
	<xmqqpppu65fs.fsf@gitster.dls.corp.google.com>
	<528E7A6E.8080603@web.de>
	<xmqqsiup2y3u.fsf@gitster.dls.corp.google.com>
	<52A0D78E.4030509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Ari Pollak <ari@debian.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Dec 06 00:10:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Voi3l-0005uH-Uv
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 00:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253Ab3LEXKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 18:10:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53095 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755407Ab3LEXKI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 18:10:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF6F558A4C;
	Thu,  5 Dec 2013 18:10:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9u7Ia0eqxw40J8Yx5fjyDzOEG2Q=; b=ODfyIN
	fKOwQNDttrHv0cf/w+i/AwVPiihYi5QTzfdWy9O7ZmjDvu8tgYlkSbJTv39B3A3p
	yc7MjuIhUEm7PiOLI8DwUuB2ef7S1NXwPPQfbvnIdaPjZbRa6EJ+LCRcMPLnfQ3W
	bLudFB6vjSUChcyaGmx3YYBl3pa++m/1xYifM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HIHes8e+QGMlT9fPq/NWk4xxrC0AJU8Y
	qTFC84a98n5d/h7nQ07LnkskoMjXNmy4DtmrcbCrridQVpqiQFO9aJs0L5MrZSfm
	61pAqxc4j5cBEW0xuCZji/S622ApsiNw5md4nLFzOGaytUd/0nvG2DNCPTXZXjEu
	eqQ+XUTSWCA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFEFF58A4A;
	Thu,  5 Dec 2013 18:10:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D08D58A47;
	Thu,  5 Dec 2013 18:10:07 -0500 (EST)
In-Reply-To: <52A0D78E.4030509@web.de> (Jens Lehmann's message of "Thu, 05 Dec
	2013 20:44:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 619E344A-5E02-11E3-B3EE-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238917>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> +		fprintf(s->fp, "%c %s", comment_line_char, cut_line);
> +		strbuf_add_commented_lines(&buf, explanation, strlen(explanation));
> +		fprintf(s->fp, buf.buf);

This is better done with:

	fputs(buf.buf, s->fp);

Already locally tweaked while applying, so no need to resend only
for this change.
