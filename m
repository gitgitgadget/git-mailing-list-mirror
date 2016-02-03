From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Trick to force setup of a specific configured E-Mail per repo
Date: Wed, 03 Feb 2016 00:01:21 -0800
Message-ID: <xmqqr3gunrxq.fsf@gitster.mtv.corp.google.com>
References: <1454442861-4879-1-git-send-email-alonid@gmail.com>
	<20160203035648.GA20732@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dan Aloni <alonid@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 03 09:01:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQsNV-0003li-Dy
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 09:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843AbcBCIBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 03:01:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59796 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751607AbcBCIBY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 03:01:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9662C326E4;
	Wed,  3 Feb 2016 03:01:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AzGdF/23LTWWh3ddCcpzGIzrml0=; b=OE1/Fp
	qVJ/D9IPsKdlhze8sNANtdMMRQhKS/EToRsZnNqBhWA/HLkkM6cZYGYEBKPPep0/
	M/scgoJXL6JA6PyP/H7wGly69JBWt9+iOig8MZ46r0RNZ8A8JdF9a28kItfXLUK1
	JRtZ6RRlzdOYJwL58g1DkxkcIFJvfxRwtnAQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PFoWPuybMkEHaU9pveiaQvliwhvifVkF
	oSWh/JeC15O5GrA1s2imSbqONworarnjIGRrqjlGhr2Idv/TNX9WEBRIsisH018A
	dYejmQiJ8wkIOwZx8j8Z4Q8PUL2FfURhbT9+BLUmWVIRJmBVJI8XRoJCgG5CWS7p
	NEhPqk3keis=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8E8F9326E3;
	Wed,  3 Feb 2016 03:01:23 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 14351326DF;
	Wed,  3 Feb 2016 03:01:23 -0500 (EST)
In-Reply-To: <20160203035648.GA20732@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 2 Feb 2016 22:56:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 510F51C8-CA4C-11E5-8BDF-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285338>

Jeff King <peff@peff.net> writes:

> Just when I dare to think "somebody cannot possibly be relying on this
> arcane behavior", I am proven wrong. :)

My thoughts, exactly.  This is the kind of thing that makes this
project uncomfortably "interesting"; we cannot make improvements
without risking breaking existing users.

> Could we perhaps do this more cleanly with a new config
> option? Like a "user.guessIdent" which defaults to true, but people can
> set to false. And without that, we do not do any automagic at all; we
> get the values from the GIT_COMMITTER_* environment or the
> user.{name,email} config variables, or we die().

That sounds like an excellent and clean way to do this.
