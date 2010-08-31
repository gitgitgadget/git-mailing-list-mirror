From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/2] detached-stash: fix broken test_must_fail calls
Date: Wed,  1 Sep 2010 00:49:20 +1000
Message-ID: <1283266160-11665-3-git-send-email-jon.seymour@gmail.com>
References: <1283266160-11665-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 31 16:49:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqS9Q-0007eb-Ko
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 16:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230Ab0HaOtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 10:49:10 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:61432 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757510Ab0HaOtG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 10:49:06 -0400
Received: by pxi10 with SMTP id 10so2459169pxi.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HodUr1LKku9J91sQwV0nKYxueB4fYbIcyLiCSZQtKM0=;
        b=wLTEHBwS6u4ypirbgtZEvJHGdHoO5ny4jMyJN3o4c8Rp9ag0BAatki31x6o+49Ms/Q
         +/CQUHdpdcW0wVEIz7D1mmNV75DDiBm9x+g0Xu6K7wLga0FoexFH96t8KBw/36GZrp43
         YRXref6gJk3KSYUuGChczMhZxD877zDTjx/R8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TO/SrBwDBNT0Y7pKg7HHxaiIOujB7T2J0Mu98YCqkaTABMy4wZvngIeHyZk1goEbee
         u+7L+02zV1gPFZ5OOIpn3ouNgrEXfQr0psbArc6VujxDFD7yt0VxRiJZ3hmkQ3Wcxtyw
         imJRm8OVedLubM0Uh4aSoq1GwcTkf8kpGFj44=
Received: by 10.114.77.11 with SMTP id z11mr7019995waa.112.1283266146523;
        Tue, 31 Aug 2010 07:49:06 -0700 (PDT)
Received: from localhost.localdomain (124-169-135-9.dyn.iinet.net.au [124.169.135.9])
        by mx.google.com with ESMTPS id d39sm16562703wam.16.2010.08.31.07.49.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 07:49:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.82.g9d57.dirty
In-Reply-To: <1283266160-11665-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154905>

Some tests in detached-stash are calling test_must_fail
in such a way that the arguments to test_must_fail do, indeed, fail
but not in the manner expected by the test.

This patch removes the unnecessary and unhelpful double quotes.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t3903-stash.sh |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index ea9f979..d99f27a 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -435,7 +435,7 @@ test_expect_success 'stash drop - fail early if specified stash is not a stash r
 	git stash &&
 	echo bar > file &&
 	git stash &&
-	test_must_fail "git stash drop $(git rev-parse stash@{0})" &&
+	test_must_fail git stash drop $(git rev-parse stash@{0}) &&
 	git stash pop &&
 	test bar = "$(cat file)" &&
 	git reset --hard HEAD
@@ -449,7 +449,7 @@ test_expect_success 'stash pop - fail early if specified stash is not a stash re
 	git stash &&
 	echo bar > file &&
 	git stash &&
-	test_must_fail "git stash pop $(git rev-parse stash@{0})" &&
+	test_must_fail git stash pop $(git rev-parse stash@{0}) &&
 	git stash pop &&
 	test bar = "$(cat file)" &&
 	git reset --hard HEAD
@@ -462,31 +462,31 @@ test_expect_success 'ref with non-existant reflog' '
 	git add file2 &&
 	git stash &&
 	! "git rev-parse --quiet --verify does-not-exist" &&
-	test_must_fail "git stash drop does-not-exist" &&
-	test_must_fail "git stash drop does-not-exist@{0}" &&
-	test_must_fail "git stash pop does-not-exist" &&
-	test_must_fail "git stash pop does-not-exist@{0}" &&
-	test_must_fail "git stash apply does-not-exist" &&
-	test_must_fail "git stash apply does-not-exist@{0}" &&
-	test_must_fail "git stash show does-not-exist" &&
-	test_must_fail "git stash show does-not-exist@{0}" &&
-	test_must_fail "git stash branch tmp does-not-exist" &&
-	test_must_fail "git stash branch tmp does-not-exist@{0}" &&
+	test_must_fail git stash drop does-not-exist &&
+	test_must_fail git stash drop does-not-exist@{0} &&
+	test_must_fail git stash pop does-not-exist &&
+	test_must_fail git stash pop does-not-exist@{0} &&
+	test_must_fail git stash apply does-not-exist &&
+	test_must_fail git stash apply does-not-exist@{0} &&
+	test_must_fail git stash show does-not-exist &&
+	test_must_fail git stash show does-not-exist@{0} &&
+	test_must_fail git stash branch tmp does-not-exist &&
+	test_must_fail git stash branch tmp does-not-exist@{0} &&
 	git stash drop
 '
 
 test_expect_success 'invalid ref of the form stash@{n}, n >= N' '
 	git stash clear &&
-	test_must_fail "git stash drop stash@{0}" &&
+	test_must_fail git stash drop stash@{0} &&
 	echo bar5 > file &&
 	echo bar6 > file2 &&
 	git add file2 &&
 	git stash &&
-	test_must_fail "git drop stash@{1}" &&
-	test_must_fail "git pop stash@{1}" &&
-	test_must_fail "git apply stash@{1}" &&
-	test_must_fail "git show stash@{1}" &&
-	test_must_fail "git branch tmp stash@{1}" &&
+	test_must_fail git drop stash@{1} &&
+	test_must_fail git pop stash@{1} &&
+	test_must_fail git apply stash@{1} &&
+	test_must_fail git show stash@{1} &&
+	test_must_fail git branch tmp stash@{1} &&
 	git stash drop
 '
 
-- 
1.7.2.80.g22196.dirty
