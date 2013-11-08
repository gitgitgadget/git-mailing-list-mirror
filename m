From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] push: Enhance unspecified push default warning
Date: Fri, 08 Nov 2013 10:02:43 -0800
Message-ID: <xmqqli0yojp8.fsf@gitster.dls.corp.google.com>
References: <CAKYC+eKCsRbF=6HtcY8ZtaafTDpbMFJ1tyWbaZDKrmbzdnOoUw@mail.gmail.com>
	<CAKYC+eLvx1vB1ZDqYK=7Dg68QuCojBdSAVQZMF6HBtfxu_b_aw@mail.gmail.com>
	<xmqqvc08yq4v.fsf@gitster.dls.corp.google.com>
	<1839883487.4893076.1383646619137.JavaMail.root@imag.fr>
	<xmqqk3gl8id0.fsf@gitster.dls.corp.google.com>
	<vpq1u2tb3px.fsf@anie.imag.fr> <20131106234544.GF10302@google.com>
	<vpqtxfo8ow4.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Greg Jacobson <coder5000@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Nov 08 19:02:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeqOS-0006YZ-6B
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 19:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757912Ab3KHSCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 13:02:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34208 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757457Ab3KHSCr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 13:02:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A16674FD92;
	Fri,  8 Nov 2013 13:02:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5BLWaFEDrb5u+vP22BsUZTzhftA=; b=unzL+V
	68Ik2df/KIHuInLJ4CX0zNZBrRC2iLd6g0PxUdwlLGjpcU2Hc7Idm0aewZ1GmHIU
	BBj1QKbMY3/6bkTG/ydrtyiqmAJMEW1MWRSPzfvqa/KRpTs+18k7oGziahQxu2EY
	ueIKhIoFFCKOph8Qa1zRl4tyoe34Oz+0aLuIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D5L+m+1KEw2aPPAG7vVEDTUl6IlXVibb
	X19L737K3DbsdXtkQ7KE3ld5Gh2ZHZZVvppsSY5Qc+GopwaMiUmPPTT5zxRdOQ8j
	i8tk+vWJd4RfbsZ1DKVG2/3jiOT6IK93F8hVt9Zs73Lu1h/F25Ti/k4dJlYDMPCk
	Eit6Frg8kCI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 905C54FD91;
	Fri,  8 Nov 2013 13:02:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA18C4FD8E;
	Fri,  8 Nov 2013 13:02:45 -0500 (EST)
In-Reply-To: <vpqtxfo8ow4.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	07 Nov 2013 11:52:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F89913BA-489F-11E3-8624-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237460>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> 	When push.default is set to 'matching', git will push local branches
>> 	to remote branches that already exist with the same (matching) name.
>
> Yes, that's better than the original patch (and remains two lines).
> ...
>
>> 	In Git 2.0, git will default to a more conservative 'simple' behavior
>> 	that only pushes the current branch.
>
> That's an option too, but I think mentionning "git pull" was a good
> idea.

OK, I'll tentatively update the draft to read like this, redo the
endgame patch on top and requeue.

 builtin/push.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 5393e28..27c5754 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -174,14 +174,12 @@ N_("push.default is unset; its implicit value is changing in\n"
    "\n"
    "  git config --global push.default simple\n"
    "\n"
-   "When push.default is set to 'matching', git will push all local branches\n"
-   "to the remote branches with the same (matching) name.  This will no\n"
-   "longer be the default in Git 2.0 because a branch could be\n"
-   "unintentionally pushed to a remote.\n"
+   "When push.default is set to 'matching', git will push local branches\n"
+   "to the remote branches that already exist with the same name.\n"
    "\n"
-   "In Git 2.0 the new push.default of 'simple' will push only the current\n"
-   "branch to the same remote branch used by git pull.   A push will\n"
-   "only succeed if the remote and local branches have the same name.\n"
+   "In Git 2.0, Git will default to the more conservative 'simple'\n"
+   "behavior that only pushes the current branch to the corresponding\n"
+   "remote branch used by 'git pull' to update the current branch from.\n"
    "\n"
    "See 'git help config' and search for 'push.default' for further information.\n"
    "(the 'simple' mode was introduced in Git 1.7.11. Use the similar mode\n"
