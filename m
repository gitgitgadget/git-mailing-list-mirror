From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] push: Enhance unspecified push default warning
Date: Mon, 11 Nov 2013 09:02:16 -0800
Message-ID: <xmqqob5qna7b.fsf@gitster.dls.corp.google.com>
References: <CAKYC+eKCsRbF=6HtcY8ZtaafTDpbMFJ1tyWbaZDKrmbzdnOoUw@mail.gmail.com>
	<CAKYC+eLvx1vB1ZDqYK=7Dg68QuCojBdSAVQZMF6HBtfxu_b_aw@mail.gmail.com>
	<xmqqvc08yq4v.fsf@gitster.dls.corp.google.com>
	<1839883487.4893076.1383646619137.JavaMail.root@imag.fr>
	<xmqqk3gl8id0.fsf@gitster.dls.corp.google.com>
	<vpq1u2tb3px.fsf@anie.imag.fr> <20131106234544.GF10302@google.com>
	<vpqtxfo8ow4.fsf@anie.imag.fr>
	<xmqqli0yojp8.fsf@gitster.dls.corp.google.com>
	<527D6805.3050303@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Greg Jacobson <coder5000@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 18:02:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfuse-0007dn-Lh
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 18:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345Ab3KKRCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 12:02:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38495 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040Ab3KKRCW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 12:02:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8850B4FA38;
	Mon, 11 Nov 2013 12:02:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jz0GORndSs4G/nsZhWMRnGHdX6g=; b=mKHiWA
	hmMEM2+F5zoKkbu3rsw473Gu91uvMQhGOo8RmvlJPw1xvR+GhZjNHkluDioRY8PX
	bZYI3T7F7XoiJowsfGoRo/y1Gxm2C1dl7K9x92Rv6+ZfrFtVWDKUiYAlTziioVFG
	WxZzR8euNN+R8po9+39sSO6mr/DGjufS2OooY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=moCLhL25ymXvdp9hd22vmRuu+9ut6SoE
	fEnDBRHTxrQa/EKh6T1gc8sGFqhVUCyb7E6ZT0xtwX+9/OE/ztOKmrU9P+GcHj6o
	x930VY38RSRnveEJ1GUgPlGSGwrTFO31p5Ya7iKQLQ6eEptDdUl+cYE9yQ61CNm0
	iX36GnICijA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74FD14FA37;
	Mon, 11 Nov 2013 12:02:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D92C4FA36;
	Mon, 11 Nov 2013 12:02:20 -0500 (EST)
In-Reply-To: <527D6805.3050303@xiplink.com> (Marc Branchaud's message of "Fri,
	08 Nov 2013 17:39:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 07109F76-4AF3-11E3-808E-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237617>

Marc Branchaud <marcnarc@xiplink.com> writes:

>> -   "In Git 2.0 the new push.default of 'simple' will push only the current\n"
>> -   "branch to the same remote branch used by git pull.   A push will\n"
>> -   "only succeed if the remote and local branches have the same name.\n"
>> +   "In Git 2.0, Git will default to the more conservative 'simple'\n"
>> +   "behavior that only pushes the current branch to the corresponding\n"
>> +   "remote branch used by 'git pull' to update the current branch from.\n"
>
> That reads a bit awkwardly.  How about:
>
> 	In Git 2.0, Git will default to the more conservative 'simple'
> 	behavior, which only pushes the current branch to the corresponding
> 	remote branch that 'git pull' uses to update the current branch.

OK, here is the version of Greg's patch (i.e. for versions before
2.0) with the above.  The endgame patch for 2.0 would change the
line that begins with "In Git 2.0," to:

	Since Git 2.0, Git defaults to the more conservative ...

Is everybody happy with this version?

-- >8 --
From: Greg Jacobson <coder5000@gmail.com>
Date: Fri, 4 Oct 2013 10:20:07 -0400
Subject: [PATCH] push: Enhance unspecified push default warning

When the unset push.default warning message is displayed this may be
the first time many users encounter push.default.

Explain in the warning message in a compact manner what push.default
is and what the change means to the end-user to help the users decide.

Signed-off-by: Greg Jacobson <coder5000@gmail.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Helped-by: Marc Branchaud <marcnarc@xiplink.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/push.c b/builtin/push.c
index 7b1b66c..a73982a 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -174,6 +174,13 @@ N_("push.default is unset; its implicit value is changing in\n"
    "\n"
    "  git config --global push.default simple\n"
    "\n"
+   "When push.default is set to 'matching', git will push local branches\n"
+   "to the remote branches that already exist with the same name.\n"
+   "\n"
+   "In Git 2.0, Git will default to the more conservative 'simple'\n"
+   "behavior, which only pushes the current branch to the corresponding\n"
+   "remote branch that 'git pull' uses to update the current branch.\n"
+   "\n"
    "See 'git help config' and search for 'push.default' for further information.\n"
    "(the 'simple' mode was introduced in Git 1.7.11. Use the similar mode\n"
    "'current' instead of 'simple' if you sometimes use older versions of Git)");
-- 
1.8.5-rc1-310-g1febc12
