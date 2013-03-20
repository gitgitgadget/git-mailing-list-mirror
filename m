From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH] Documentation: merging a tag is a special case
Date: Wed, 20 Mar 2013 18:53:53 +0100
Message-ID: <1363802033-26868-1-git-send-email-ydroneaud@opteya.com>
References: <1363704914.6289.39.camel@test.quest-ce.net> <7vfvzrjrad.fsf@alter.siamese.dyndns.org>
Cc: Yann Droneaud <ydroneaud@opteya.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 20 18:55:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UINEJ-0005NN-4T
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 18:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147Ab3CTRys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 13:54:48 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:34670 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685Ab3CTRyr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 13:54:47 -0400
Received: from test.quest-ce.net (unknown [37.161.174.182])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 917879402D3;
	Wed, 20 Mar 2013 18:54:39 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2KHsEqd026907;
	Wed, 20 Mar 2013 18:54:25 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2KHs6N9026905;
	Wed, 20 Mar 2013 18:54:06 +0100
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <7vfvzrjrad.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218631>

When asking Git to merge a tag (such as a signed tag or annotated tag),
it will always create a merge commit even if fast-forward was possible.
It's like having --no-ff present on the command line.

It's a difference from the default behavior described in git-merge.txt.
It should be documented as an exception of "FAST-FORWARD MERGE" section
and "--ff" option description.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 Documentation/git-merge.txt     | 9 +++++++++
 Documentation/merge-options.txt | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index c852a26..84bc873 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -170,6 +170,15 @@ happens:
 If you tried a merge which resulted in complex conflicts and
 want to start over, you can recover with `git merge --abort`.
 
+MERGING TAG
+-----------
+
+When merging a tag (annotated or signed), Git will create a merge commit
+even if a fast-forward merge is possible (see above).
+The commit message template will be created from the tag message.
+Additionally, the signature check will be reported as a comment
+if the tag was signed. See also linkgit:git-tag[1].
+
 HOW CONFLICTS ARE PRESENTED
 ---------------------------
 
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 0bcbe0a..70d1ec0 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -26,7 +26,7 @@ set to `no` at the beginning of them.
 --ff::
 	When the merge resolves as a fast-forward, only update the branch
 	pointer, without creating a merge commit.  This is the default
-	behavior.
+	behavior (except when merging a tag).
 
 --no-ff::
 	Create a merge commit even when the merge resolves as a
-- 
1.7.11.7
