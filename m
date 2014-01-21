From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 01/11] git p4 test: wildcards are supported
Date: Tue, 21 Jan 2014 18:16:38 -0500
Message-ID: <1390346208-9207-2-git-send-email-pw@padd.com>
References: <1390346208-9207-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 00:17:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5kZI-0001OK-14
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 00:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274AbaAUXRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 18:17:12 -0500
Received: from honk.padd.com ([74.3.171.149]:46532 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752308AbaAUXRL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 18:17:11 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 3B11E7112;
	Tue, 21 Jan 2014 15:17:11 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 75811200F7; Tue, 21 Jan 2014 18:17:08 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2.364.g6ac45cd
In-Reply-To: <1390346208-9207-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240791>

Since 9d57c4a (git p4: implement view spec wildcards with "p4
where", 2013-08-30), all the wildcard types should be supported.
Change must-fail tests to mark that they now pass.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9809-git-p4-client-view.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index 77f6349..23a827f 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -76,28 +76,28 @@ test_expect_success 'init depot' '
 '
 
 # double % for printf
-test_expect_success 'unsupported view wildcard %%n' '
+test_expect_success 'view wildcard %%n' '
 	client_view "//depot/%%%%1/sub/... //client/sub/%%%%1/..." &&
 	test_when_finished cleanup_git &&
-	test_must_fail git p4 clone --use-client-spec --dest="$git" //depot
+	git p4 clone --use-client-spec --dest="$git" //depot
 '
 
-test_expect_success 'unsupported view wildcard *' '
+test_expect_success 'view wildcard *' '
 	client_view "//depot/*/bar/... //client/*/bar/..." &&
 	test_when_finished cleanup_git &&
-	test_must_fail git p4 clone --use-client-spec --dest="$git" //depot
+	git p4 clone --use-client-spec --dest="$git" //depot
 '
 
-test_expect_success 'wildcard ... only supported at end of spec 1' '
+test_expect_success 'wildcard ... in the middle' '
 	client_view "//depot/.../file11 //client/.../file11" &&
 	test_when_finished cleanup_git &&
-	test_must_fail git p4 clone --use-client-spec --dest="$git" //depot
+	git p4 clone --use-client-spec --dest="$git" //depot
 '
 
-test_expect_success 'wildcard ... only supported at end of spec 2' '
+test_expect_success 'wildcard ... in the middle and at the end' '
 	client_view "//depot/.../a/... //client/.../a/..." &&
 	test_when_finished cleanup_git &&
-	test_must_fail git p4 clone --use-client-spec --dest="$git" //depot
+	git p4 clone --use-client-spec --dest="$git" //depot
 '
 
 test_expect_success 'basic map' '
-- 
1.8.5.2.320.g99957e5
