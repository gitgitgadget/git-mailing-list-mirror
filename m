From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] gpg-interface: check gpg signature creation status
Date: Tue, 14 Jun 2016 16:47:35 -0700
Message-ID: <xmqqporj72p4.fsf@gitster.mtv.corp.google.com>
References: <26353a3d-e495-075f-4f84-b34a2420a6cf@drmicha.warpmail.net>
	<8e08b63b58302b6e7fe91f0dfb5b476781bfd37d.1465915311.git.git@drmicha.warpmail.net>
	<xmqq60tbaba5.fsf@gitster.mtv.corp.google.com>
	<20160614215019.GB22334@sigill.intra.peff.net>
	<20160614222633.GA32020@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	ZhenTian <loooseleaves@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 15 01:47:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCy3g-0007ZX-Bw
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 01:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbcFNXrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 19:47:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60953 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751332AbcFNXrj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 19:47:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C4CD021470;
	Tue, 14 Jun 2016 19:47:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O2Oj4BYCjuOBdEtmm/PMwKLUOcM=; b=bEyhk3
	QoBq1VQ1ehUhq5MRgQ/iz3FQcg7MxEGB7yZ9W1HTSNrqYwc4VR83B9LjGhF6jNC/
	hTk9wrIu6wDy857vnqifajhpmOzOAb6W7P1gpLL3oJOirUjcrOoI91HJ50i+eBV3
	lB9EOIpbNypDIdMMG46cgTvRaUgNN+sIUNzLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p30PUGcdl5gScQ2MPyuUONrAvwUT/OA+
	B+udpnAC3+v5ZYG9+wb1bxlf3JJwBfJo5eH7YkG/RIo6PAgVagjs68lZ+YNOtTRF
	+Z8LiZVH8PmaroZqFlD6JvrbWxzuNorcY90stjyu9P5fg/UQBMTab+08V+yrCi5K
	gvUGuFik6sY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BDEDE2146F;
	Tue, 14 Jun 2016 19:47:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D1DB2146E;
	Tue, 14 Jun 2016 19:47:37 -0400 (EDT)
In-Reply-To: <20160614222633.GA32020@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 14 Jun 2016 18:26:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5FAACD24-328A-11E6-8B21-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297347>

Jeff King <peff@peff.net> writes:

> I'm still undecided on whether it is a better approach than making
> sure the stdout we got looks sane. In particular I'd worry that it
> would make things harder for somebody trying to plug in something
> gpg-like (e.g., if you wanted to do something exotic like call a
> program which fetched the signature from a remote device or
> something).  But it's probably not _that_ hard for such a script
> to emulate --status-fd.

I share the same thinking, but at the same time, it already is a
requirement to give --status-fd output that is close enough on the
signature verification side, isn't it?
