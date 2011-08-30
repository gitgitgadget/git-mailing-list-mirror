From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] t3903: fix misquoted rev-parse invocation
Date: Tue, 30 Aug 2011 02:06:07 +0200
Message-ID: <fa41d38f9297ca14b61e05033c9d1b5f5a778263.1314662636.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jon Seymour <jon.seymour@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 02:06:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyBqW-0008EI-3R
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 02:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194Ab1H3AGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 20:06:12 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:4282 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754806Ab1H3AGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 20:06:09 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Tue, 30 Aug
 2011 02:06:07 +0200
Received: from localhost.localdomain (188.155.176.28) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.289.1; Tue, 30 Aug
 2011 02:06:07 +0200
X-Mailer: git-send-email 1.7.7.rc0.370.gdcae57
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180379>

!"git ..." hopefully always succeeds because "git ..." is not the name
of any executable.  However, that's not what was intended.  Unquote
it, and while we're at it, also replace ! with test_must_fail since it
is a call to git.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I kind of wonder how many bogus tests we have...

 t/t3903-stash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 7197aae..fcdb182 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -542,7 +542,7 @@ test_expect_success 'ref with non-existent reflog' '
 	echo bar6 > file2 &&
 	git add file2 &&
 	git stash &&
-	! "git rev-parse --quiet --verify does-not-exist" &&
+	test_must_fail git rev-parse --quiet --verify does-not-exist &&
 	test_must_fail git stash drop does-not-exist &&
 	test_must_fail git stash drop does-not-exist@{0} &&
 	test_must_fail git stash pop does-not-exist &&
-- 
1.7.7.rc0.370.gdcae57
