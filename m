From: Junio C Hamano <gitster@pobox.com>
Subject: RFD: removing git.spec.in (Re: git 2.8.0 tarball rpmbuild error)
Date: Sat, 02 Apr 2016 20:41:45 -0700
Message-ID: <xmqqshz3fjeu.fsf_-_@gitster.mtv.corp.google.com>
References: <CAHHSH-JrPiXnkdpU0cP6KE46hUr3-ZiSjW5FDMpV2HGmSou8kA@mail.gmail.com>
	<CAFZEwPPQPsk3ERu-h5qk+VZ=f3Ta4oPwgHN=5hTuVH5wxeiPGQ@mail.gmail.com>
	<20160402161636.GD13271@zaya.teonanacatl.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Todd Zullinger <tmz@pobox.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	=?utf-8?B?44Oe44OD44OB44On44Kz5aSq6YOO?= <mebius1080p@gmail.com>,
	Git List <git@vger.kernel.org>
To: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Apr 03 05:41:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amYvE-0004ER-VM
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 05:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbcDCDlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 23:41:50 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54584 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751315AbcDCDlt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 23:41:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B12E5510A8;
	Sat,  2 Apr 2016 23:41:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1oCnAJ+J1qIBFsTWG4sn59jx4W8=; b=Gb3+tS
	L3N9gNqIKwrp/Yd8us5U03Pp47OZvifQeDVPNN/bx/E9ZZa7VyUNynVmY/ZWq+L3
	dy1pCCfylO+vIWEo5pXCiKDuRdqutjG8lUK59dYnJjt7CzK+J40T9u7QRu/34Yn4
	FbvlQ6XvImQKP2mFKDCdIZzpXO4uIRpXJ3CIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wKAnpc4UB/HAwO2oTKRGGyYNJ8C0+NiU
	JUd7nhVl6es8E764H1AP8XCRwM6pWlrROCMH8deKgtEBcx/cCdvM1mlk3y/Hwn6E
	lNdUhu/KTe8+IARiNzY+NnR2t2QAY/hlMV5rkk7halYpmrBmfYSn4z5f+a4YWINn
	SQqi8PR9HSM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A834E510A7;
	Sat,  2 Apr 2016 23:41:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1E561510A5;
	Sat,  2 Apr 2016 23:41:47 -0400 (EDT)
In-Reply-To: <20160402161636.GD13271@zaya.teonanacatl.net> (Todd Zullinger's
	message of "Sat, 2 Apr 2016 12:16:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FDE43F5A-F94D-11E5-879B-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290623>

It is likely that I'll cut 2.8.1 with only the attached patch

    Message-ID: <1459494651-32618-1-git-send-email-Matthieu.Moy@imag.fr>
    aka $gmane/290510

and I'll explicitly mark that this maintenance release is ignorable
by people other than those who build their own RPM packages from my
tree.

I think by now it is very clear that nobody active in the Git
development community tests RPM binaries built with git.spec.in we
have in our tree.  I suspect RPM based distros are using their own
RPM build recipe without paying any attention to what we have in our
tree, and that is why no packager from RPM land gave any bug report
and correction before the release happened.

I'd propose that during the cycle for the next feature release, we'd
remove git.spec.in and stop pretending as if we support RPM packaging.

If a group of people feel strongly against the removal, they are
welcome to form a volunteer group and promise to be responsible for
regularly testing the tip of 'next' so that a breakage like this one
will never slip to the 'master' branch.

Unless we see such a promise from dedicated group of people (whose
size does not have to be more than 1), I think it is more harmful
for us to pretend that we support RPM packaging out of our tree than
being honest about it and removing the (pretense of) support.

Discuss.

Thanks.

-- >8 --
Subject: [PATCH] git.spec.in: use README.md, not README
From: Matthieu Moy <Matthieu.Moy@imag.fr>

The file was renamed in 4ad21f5 (README: use markdown syntax,
2016-02-25), but that commit forgot to update git.spec.in.

Reported-by: Ron Isaacson <isaacson.ljits@gmail.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git.spec.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git.spec.in b/git.spec.in
index d61d537..bfd1cfb 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -146,7 +146,7 @@ rm -rf $RPM_BUILD_ROOT
 %files -f bin-man-doc-files
 %defattr(-,root,root)
 %{_datadir}/git-core/
-%doc README COPYING Documentation/*.txt
+%doc README.md COPYING Documentation/*.txt
 %{!?_without_docs: %doc Documentation/*.html Documentation/howto}
 %{!?_without_docs: %doc Documentation/technical}
 %{_sysconfdir}/bash_completion.d
-- 
2.7.2.334.g35ed2ae.dirty
