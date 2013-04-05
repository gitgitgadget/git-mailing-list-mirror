From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] glossary: extend "detached HEAD" description
Date: Fri, 05 Apr 2013 08:19:23 -0700
Message-ID: <7vwqshc8ec.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:01:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWJM-0002u6-Ps
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161744Ab3DEPT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 11:19:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47828 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765545Ab3DEPT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 11:19:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A15D11400B;
	Fri,  5 Apr 2013 15:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=a
	NSFj075kzWapYl0+x84v+dI2QE=; b=JGC+QnVaIO/SXqvUkrMXZGls+4Z9DYETF
	2p2eti/ehkF2sQ/inAzhx4mZEtglp1Bo4nDqK7BvTzKk+P4KDbKOAl5i4xRPees+
	hrGNBIJNrVj/aiWsF6fBq3CHDQUx1mZ6gkAiNWLLd+2nYhT3lgsGpBrQivJlWKI6
	xw/WUUDB14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=BhP03zEFsJfOyNfqlbaWKCpgO6GjXHTPVGpVObdPr74YVz4Vhiv/Bzmu
	pZcTyzoOS76iRvGFnYh3+ZX3akH97piC06HUn2fx0HTiwyhYlfb9JqMXnlnv27wO
	R+WeUQ6EjSdkaCgoaLZfTuU2+/oHkkO0+aFw8Y+C44yjCP+THek=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 997A01400A;
	Fri,  5 Apr 2013 15:19:25 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06ECD14006; Fri,  5 Apr
 2013 15:19:24 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 332FD442-9E04-11E2-9477-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220180>

When we introduced the concept of "detached HEAD", we made sure that
commands that operate on the history of the current branch "just
work" in that state.  They update the HEAD to point at the new
history without affecting any branch when the HEAD is detached, just
like they update the tip of the "current branch" to point at the new
history when HEAD points at a specific branch.

As this is done as the natural extension for these commands, we did
not, we still do not, and we do not want to repeat "A detached HEAD
is updated without affecting any branch" when describing what each
and every one of these commands that operate "on the current branch"
do.  

Add a blanket description to the glossary to cover them instead.
The general principle is that operations to update the branch work
and affect on the HEAD, while operations to update the information
about a branch do not.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Noticed that we describe "commit --amend" as updating "the
   current branch" while reviewing the recent update by CMN, and it
   is shared by all the manual pages of commands that work on "the
   current branch".  "git grep -i detached Documentation/" shows
   very small number of hits, indicating that we do not repeat "if
   detached, only the HEAD is updated".

   I am not absolutely sure if glossary is the best place, but
   something like this may be necessary to help people who are new
   to this state.

 Documentation/glossary-content.txt | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index f928b57..69c90d1 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -100,9 +100,22 @@ to point at the new commit.
 
 [[def_detached_HEAD]]detached HEAD::
 	Normally the <<def_HEAD,HEAD>> stores the name of a
-	<<def_branch,branch>>.  However, git also allows you to <<def_checkout,check out>>
-	an arbitrary <<def_commit,commit>> that isn't necessarily the tip of any
-	particular branch.  In this case HEAD is said to be "detached".
+	<<def_branch,branch>>, and commands that operate on the
+	history HEAD represents operate on the history leading to the
+	tip of the branch the HEAD points at.  However, Git also
+	allows you to <<def_checkout,check out>> an arbitrary
+	<<def_commit,commit>> that isn't necessarily the tip of any
+	particular branch.  The HEAD in such a state is called
+	"detached".
++
+Note that commands that operate on the history of the current branch
+(e.g. `git commit` to build a new history on top of it) still work
+while the HEAD is detached. They update the HEAD to point at the tip
+of the updated history without affecting any branch.  Commands that
+update or inquire information _about_ the current branch (e.g. `git
+branch --set-upstream-to` that sets what remote tracking branch the
+current branch integrates with) obviously do not work, as there is no
+(real) current branch to ask about in this state.
 
 [[def_dircache]]dircache::
 	You are *waaaaay* behind. See <<def_index,index>>.
