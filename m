From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: Do not require tags to be annotated
Date: Sun, 08 Sep 2013 10:41:12 -0700
Message-ID: <xmqqr4cx1u7u.fsf@gitster.dls.corp.google.com>
References: <522A36AA.3050701@gmail.com>
	<xmqqeh91wrvq.fsf@gitster.dls.corp.google.com>
	<CAHGBnuP6w8rvoz+h2Xase1ApY_kpZh4X=VF6LY4O0r7RS0UayA@mail.gmail.com>
	<xmqqsixgvci1.fsf@gitster.dls.corp.google.com>
	<CAHGBnuNKrtGSoOYS1T0VH=tGvKUW0XKFnWf_WNvZkOriGurgpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 00:55:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJAMW-0004gb-FP
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 00:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003Ab3IIWzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 18:55:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42482 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755836Ab3IIWzF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 18:55:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B0454030A;
	Mon,  9 Sep 2013 22:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=ggtEG8c4vkkiKfWgginYTPUQt1w=; b=lQ33/Zsr4rSRFCBfP5rc
	2KX+mjYKcjeUqqNg444+acyqOpCk9LB2F2TbB1MtUoSKZnU8qL8ImQJstMv4fQHd
	jOWg/Qy6RiT0U03QmPiAxp0Y98ctVRuZVuaJGbU33/F1zJWXPMK9u7/tyd8orXFw
	kJ0QIWXhcNtf/DXHigOvbWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=N3kZLBUEGaJ8+A7fyOmq+dQIPU04USD6nrwy/xrlbYzZMx
	XaubopEj42fDRYEoBKmDuMNm/dFemmTcM5joDEXDgXzjHNbEP4JpZ0XH7Ua6kSLB
	Vx6UvK4MIhsJJn9XZ+QOIALKnThE0TGd++0C1BHxGzqFCZR5/M51o0pPHQ87k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECD6B40309;
	Mon,  9 Sep 2013 22:55:04 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B082340301;
	Mon,  9 Sep 2013 22:55:02 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DCB8C928-19A2-11E3-A746-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234393>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Which raises another question on my side: Isn't it tedious for you to
> both update DEF_VER *and* tag a version? Wouldn't it probably be less
> error prove (in the sense of keeping DEF_VER and tagged version in
> sync) to remove DEF_VER completely and just die if all ways to derive
> a Git version fail?

I do not see how it will fly well.  Some people want to build out of
tarballs without having any "describe", and DEF_VER and version were
added for that specific purpose.

>> a case where you have your own tag that points at the exact version
>> as I tagged?  In such a case, do you have a preference on which tag
>
> No. I always carry patches on top.

That answer sidesteps the real issue; which one would you prefer if
there are two or more tags?  "describe" updated with your patch
would consider both and I think it favours the annotated one over
lightweight.  If it matches the preferred order then G-V-N with you
patch would help your workflow; otherwise you would still need a
different way, e.g. making sure what you want it to use is always
used by doing the ">version" thing.
