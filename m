From: Max Kirillov <max@max630.net>
Subject: [PATCH] blame: add test case for using tag object as a final ref
Date: Wed, 18 Nov 2015 07:36:32 +0200
Message-ID: <1447824992-28520-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 06:36:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyvQG-00008X-6s
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 06:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbbKRFgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 00:36:42 -0500
Received: from p3plsmtpa11-08.prod.phx3.secureserver.net ([68.178.252.109]:48127
	"EHLO p3plsmtpa11-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750810AbbKRFgm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2015 00:36:42 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa11-08.prod.phx3.secureserver.net with 
	id itcb1r00B5B68XE01tcfJt; Tue, 17 Nov 2015 22:36:41 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: 20151117232237.GA29014@sigill.intra.peff.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281440>

It was discovered [1] that 1b0d40000a broke blaming starting from tag object.
Add test which verifies such blaming works.

[1] http://mid.gmane.org/20151117224809.GE27862@sigill.intra.peff.net

Signed-off-by: Max Kirillov <max@max630.net>
---
Thank you. Sorry, I should have noticed that obj ended up unused.

Adding test case for it. Looks ok after the fix.
 t/annotate-tests.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index b1673b3..093832f 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -68,6 +68,13 @@ test_expect_success 'blame 1 author' '
 	check_count A 2
 '
 
+test_expect_success 'blame by tag objects' '
+	git tag -m "test tag" testTag &&
+	git tag -m "test tag #2" testTag2 testTag &&
+	check_count -h testTag A 2 &&
+	check_count -h testTag2 A 2
+'
+
 test_expect_success 'setup B lines' '
 	echo "2A quick brown fox jumps over the" >>file &&
 	echo "lazy dog" >>file &&
-- 
2.3.4.2801.g3d0809b
