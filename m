From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] daemon: return "access denied" if a service is not
 allowed
Date: Thu, 13 Oct 2011 22:01:01 -0700
Message-ID: <7vvcrs181e.fsf@alter.siamese.dyndns.org>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
 <1317678909-19383-1-git-send-email-pclouds@gmail.com>
 <20111012200916.GA1502@sigill.intra.peff.net>
 <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
 <20111013182816.GA17573@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 07:02:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REZuz-0007bQ-Tt
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 07:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247Ab1JNFBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 01:01:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63899 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385Ab1JNFBE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 01:01:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21AA52791;
	Fri, 14 Oct 2011 01:01:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dRZWQTJmfw5BaezYqi0nniW4lng=; b=SmlPDQ
	Eq7UBV+hQ//ehMrlLbYC673BwKoSaohgf/dwyXNQ7t9W0Kxf4LHbp3o58HRgLNSN
	7sJdRAoWSK6z4WezqxGQPNyRKQeKvItFlEViXZz85XHQRmcUHprjm9czF6ctQZX/
	ug88pE7uZPgUokql9pj5IJm/uy0y+/Z0Q3hIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NG3LTQwKa1oEta3znJavYa9gQp3yy/mf
	UZbZwJJWrSuBf/UJn7YdCuKR1Th55dcX07oylhHQqEyp26Kpt6eFUl7Dr0xm+pfV
	In4lUg81DvrRU+GJxjoQapu2dIBxM6SCtiiFySzptqVdn6+IzWTV7ryBYDCpWkGI
	+tjIDhlFsLA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 183042790;
	Fri, 14 Oct 2011 01:01:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99861278D; Fri, 14 Oct 2011
 01:01:02 -0400 (EDT)
In-Reply-To: <20111013182816.GA17573@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 13 Oct 2011 14:28:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 83CD3F0C-F621-11E0-87C4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183537>

Jeff King <peff@peff.net> writes:

> So if we want to do anything, I would think it would be a hook. Except
> that we may or may not have a repo, so it would not be a hook in
> $GIT_DIR/hooks, but rather some script to be run passed on the command
> line, like:
>
>   git daemon --informative-errors=/path/to/hook

I don't think it is necessarily good to have such a variation across
hosting sites. Your "something like this" patch looked like it was giving
a reasonable level of detail, IMO.
