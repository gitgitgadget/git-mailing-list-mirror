From: y@google.com
Subject: [PATCH 2/4] revisions passed to cherry-pick should be in "default" order
Date: Sun, 12 Aug 2012 23:27:18 -0700
Message-ID: <50289e50.a19f320a.5d99.3fdfSMTPIN_ADDED@gmr-mx.google.com>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
 <1344839240-17402-1-git-send-email-y>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 08:27:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0o7k-000715-E5
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 08:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157Ab2HMG1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 02:27:31 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:64689 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364Ab2HMG13 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 02:27:29 -0400
Received: by obbwc20 with SMTP id wc20so2563650obb.1
        for <git@vger.kernel.org>; Sun, 12 Aug 2012 23:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Wf1VH2nirchYYP1mrKGymWjYXipfMALADs2jepuufOo=;
        b=n15s3x5kINf6C2PDiYBBs4pF/0r7GIW89kMpsPoUER62aguWoj04Uhoo2n9iCeN4pW
         lS37AjINaWUCG8H1bnWhQJgztjPJ0SXcBkddaaWXBibDllpLmmlf+F/ZbC8Le3vQxBzL
         916WCndolDA83d0gr25kN3q8adIhuPiMLe6XafbA4oDu2wAMKczln9BC7XjWvPZOgpB2
         GGsJ0S0Pq8zD+SDIRN+244CklQS3nkCcdSr0qZ37npEAfTFgQ52uMQzaa07ojlrOKQu2
         CXjguXlPWFXSjfX/JNFhPf9Qnt3PZ+Dz+Nkl/2XcT2/OUxPQYunoGFRLOhl/B6uh9HvI
         1asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=Wf1VH2nirchYYP1mrKGymWjYXipfMALADs2jepuufOo=;
        b=HS5sJ+9h2bDUL/vH+U1KLrGUBkcBJbwpJoBWVe/U2gOJKky1veLB9GgOMUtEIUUHpP
         oG/trHNB58CVmf+Sh0gAoGWgjKIUlRW2uQdqlF8GHCb0dXGYC3dF2DZ2dbUH5Jh5uq40
         P7pmmq1pxXKBlXi9tqYMW1uyy9Kd4pszHKjPcUCgQzXB9HFM1A4RwY2vaHEU3DbBSS6l
         uxv6Tm2GIjx4QowhVCVgiOGhWM+WWsadU/PwtaLINCkZL9Sv4T/y1kWnlB7hGv5blV8W
         Ot2FTpiIwfIxkti5SNK289CJJqHi8e8kP107ciyiGKgS7ekAigmLolY0nVonfqEU2LWK
         tPGg==
Received: by 10.43.12.198 with SMTP id pj6mr2644979icb.8.1344839249025;
        Sun, 12 Aug 2012 23:27:29 -0700 (PDT)
Received: by 10.43.12.198 with SMTP id pj6mr2644970icb.8.1344839248972;
        Sun, 12 Aug 2012 23:27:28 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id xd1si1964744igb.1.2012.08.12.23.27.28
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Sun, 12 Aug 2012 23:27:28 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 73629100047;
	Sun, 12 Aug 2012 23:27:28 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id EFE08C1A15; Sun, 12 Aug 2012 23:27:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1344839240-17402-1-git-send-email-y>
X-Gm-Message-State: ALoCoQkkVL+sUoR2x1iNNoHTbj9+Rs49PQ6qUgVRiMKt8AcxwhxOXiuXJT7dhO+xGeJn4TCe+W5dlrfLhzQErWGY/HN6mVlNVb5cdrE/YJLFDsIo2azr35O3BvrHi2bXeqSp64LjwvRtYdTjdeGWHa4q9jaBZEh5v29N5igJFVCosW/qskLg+zWEljUwoM/6IAN4vuSidZFH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203322>

From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>

'git cherry-pick' internally sets the --reverse option while walking
revisions, so that 'git cherry-pick branch@{u}..branch' will apply the
revisions starting at the oldest one. If no uninteresing revisions are
given, --no-walk is implied. Still, the documentation for 'git
cherry-pick --stdin' uses the following example:

 git rev-list --reverse master -- README | git cherry-pick -n --stdin

The above would seem to reverse the revisions in the output (which it
does), and then pipe them to 'git cherry-pick', which would reverse
them again and apply them in the wrong order. The same problem occurs
when supplying revisions explicitly on the command line instead of
sending them to stdin.

Because of the sorting-by-date that is done by the revision walker
(even with the implied --no-walk), the ordering in the output from
'git rev-list' in the example above is effectively ignored, and the
above actually works most of the time. However, if revisions share a
commit date (as can easily happen as a result of rebasing), they do
get applied out-of-order.

Update the documentation not to suggest reversing the input to 'git
cherry-pick'. Also update test cases where the inputs are reversed.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 Documentation/git-cherry-pick.txt   | 2 +-
 t/t3508-cherry-pick-many-commits.sh | 2 +-
 t/t3510-cherry-pick-sequence.sh     | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 0e170a5..454e205 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -181,7 +181,7 @@ EXAMPLES
 	are in next but not HEAD to the current branch, creating a new
 	commit for each new change.
 
-`git rev-list --reverse master -- README | git cherry-pick -n --stdin`::
+`git rev-list master -- README | git cherry-pick -n --stdin`::
 
 	Apply the changes introduced by all commits on the master
 	branch that touched README to the working tree and index,
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 75f7ff4..020baaf 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -164,7 +164,7 @@ test_expect_success 'cherry-pick --stdin works' '
 	git checkout -f master &&
 	git reset --hard first &&
 	test_tick &&
-	git rev-list --reverse first..fourth | git cherry-pick --stdin &&
+	git rev-list first..fourth | git cherry-pick --stdin &&
 	git diff --quiet other &&
 	git diff --quiet HEAD other &&
 	check_head_differs_from fourth
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index f4e6450..9e28910 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -400,7 +400,7 @@ test_expect_success '--continue of single-pick respects -x' '
 
 test_expect_success '--continue respects -x in first commit in multi-pick' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick -x picked anotherpick &&
+	test_must_fail git cherry-pick -x anotherpick picked &&
 	echo c >foo &&
 	git add foo &&
 	git cherry-pick --continue &&
@@ -430,7 +430,7 @@ test_expect_success '--signoff is not automatically propagated to resolved confl
 
 test_expect_success '--signoff dropped for implicit commit of resolution, multi-pick case' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick -s picked anotherpick &&
+	test_must_fail git cherry-pick -s anotherpick picked &&
 	echo c >foo &&
 	git add foo &&
 	git cherry-pick --continue &&
-- 
1.7.11.1.104.ge7b44f1
