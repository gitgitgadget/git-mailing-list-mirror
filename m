From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] verify-commit: scriptable commit signature verification
Date: Fri, 13 Jun 2014 10:06:10 -0700
Message-ID: <xmqqbntw4u4d.fsf@gitster.dls.corp.google.com>
References: <cover.1402063795.git.git@drmicha.warpmail.net>
	<cc5fd1d554e0357dfb514e3f9ad100d98c16d4d5.1402063796.git.git@drmicha.warpmail.net>
	<20140613080229.GJ7908@sigill.intra.peff.net>
	<539ACA8A.90108@drmicha.warpmail.net>
	<20140613110901.GB14066@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 19:06:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvUvl-0000SX-Kh
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 19:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840AbaFMRGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 13:06:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54902 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753746AbaFMRGR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 13:06:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E0F91ED48;
	Fri, 13 Jun 2014 13:06:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rds3h0HPrp1KDIYCDQWecoS/02I=; b=ZGp5HY
	BzOU87q9LkEF4LJY0TlGoYB+UOXWTf5U50/4DbC+qb1Lp7o7werYrGXd+cYoMkiz
	vfcOEs54SNeo/U40m9ixfv2cROT+AyDCLC7sNib6aJe64Os5vvvjTt+eBjBBpscV
	zMONMWl24eCMcBYa3QSo5zBAFrpTR2T4J8zJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UdR8oL65T/4zALUhcPGwqut14XLnEFts
	TBa4uYsmoR25bCPXms4IDpNmEvddkJRhOpMNQ1Hq3CL1Iwggzj1I/9vTn0KDtFsT
	70R0afj6wup4hcCz/SdP67JdMduskIelpVVzbmSVMYdl0Fkb5pufdEBg/QYqcLC7
	h7pSiRPVFUk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 625F91ED46;
	Fri, 13 Jun 2014 13:06:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 382BB1ED3F;
	Fri, 13 Jun 2014 13:06:12 -0400 (EDT)
In-Reply-To: <20140613110901.GB14066@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 13 Jun 2014 07:09:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 05755878-F31D-11E3-BBB3-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251614>

Jeff King <peff@peff.net> writes:

> I realize this isn't really your itch to scratch. It's just that when I
> see a description like "verify a commit", I wonder what exactly "verify"
> means.

I think that is an important point.  If a tool only verifies the
signature of the commit when conceivably other aspect of it could
also be verified but we cannot decide how or we decide we should not
dictate one-way-fits-all, using a generic name "verify-commit" or
"verify" without marking that it is currently only on the signature
clearly somewhere might close the door to the future.

    git verify <object>::
        Verify whatever we currently deem is appropriate for the
        given type of object.

    git verify --gpg-signature::
	Verify the GPG signature for a signed tag, a signed commit,
        or a merge with signed tags.

    git verify --commit-author <committish>::
	Verify the GPG signer matches the "author " header of the
	commit.

and more, perhaps?
