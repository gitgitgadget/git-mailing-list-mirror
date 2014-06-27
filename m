From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] verify-commit: scriptable commit signature verification
Date: Fri, 27 Jun 2014 11:36:47 -0700
Message-ID: <xmqqwqc219og.fsf@gitster.dls.corp.google.com>
References: <cover.1402063795.git.git@drmicha.warpmail.net>
	<cc5fd1d554e0357dfb514e3f9ad100d98c16d4d5.1402063796.git.git@drmicha.warpmail.net>
	<20140613080229.GJ7908@sigill.intra.peff.net>
	<539ACA8A.90108@drmicha.warpmail.net>
	<20140613110901.GB14066@sigill.intra.peff.net>
	<xmqqbntw4u4d.fsf@gitster.dls.corp.google.com>
	<20140616195428.GB24376@sigill.intra.peff.net>
	<xmqqk38gpp9v.fsf@gitster.dls.corp.google.com>
	<20140616203956.GA3546@sigill.intra.peff.net>
	<53AD640A.9060006@drmicha.warpmail.net>
	<53AD685A.1030401@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 27 20:37:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0b19-0005WQ-Bi
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 20:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbaF0Sg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 14:36:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61127 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbaF0Sgz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 14:36:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E39A021183;
	Fri, 27 Jun 2014 14:36:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6j9NmCzsYDMZjNKh7h12dIq1vKE=; b=GR08Sr
	5CG/51Rg3DltWiQZ3x0UqR9YkOewrJ0+oA+/dpGGMentrZEUgDomVeIOVA4qK3kE
	Efjmr4JahFXkljKFRfnYx0THCaXb6E9ElhLWhcBS/7zj59zZylukLdyDggbv9o7L
	n0H56CIj69ZdY3fs6P6wpCo+sEFhrX30gGEqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dw2fAw9zVM+Vatd4aYxNMEHbGwkuSU3S
	tLgZqWre8gmApJGDFZ1Dz4P4KYwU7Q1HhuvMUbRzEGo8Z980CjpjSql/wodPaEDn
	Rculuy0mLqQgWoi3Mab0BGdTujHKZ1V0F9INO4+CNMiGngJ3Ey9KDrtzJPy4fQdM
	FyFDTQMUfP4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D89B821182;
	Fri, 27 Jun 2014 14:36:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 33A632117F;
	Fri, 27 Jun 2014 14:36:41 -0400 (EDT)
In-Reply-To: <53AD685A.1030401@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 27 Jun 2014 14:49:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FB2A84E8-FE29-11E3-A4FE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252569>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> A merge commit with embedded signed tag it is, then.
>
> The commit could carry it's own commit signature, couldn't it?

Yes, an integrator can choose to sign a merge he creates, merging
the work by a contributor who gave him a pull-request for a tag
signed by the contributor.  The resulting commit will embed the
contributor's signature to let historians verify the second parent,
as well as the integrator's signature to allow verification of the
merge result.  The integrator does not need to keep the signed tag
used as an implementation detail of transferring the signature of
the contributor, and in general such a signed tag used only to
request pulls is not available to the general public and historians
after such a merge is created.

As these signatures are part of a commit object, "git verify-commit"
would be the logical place to validate them, if we were to do so.
