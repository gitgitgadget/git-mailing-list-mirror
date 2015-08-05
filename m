From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/2] tests: fix broken && chains in t1509-root-worktree
Date: Wed,  5 Aug 2015 11:43:50 +0200
Message-ID: <1438767831-1620-1-git-send-email-ps@pks.im>
Cc: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 11:44:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMvF4-0002wz-2y
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 11:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbbHEJoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 05:44:03 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50531 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750968AbbHEJoB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2015 05:44:01 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 68C1320261
	for <git@vger.kernel.org>; Wed,  5 Aug 2015 05:44:00 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Wed, 05 Aug 2015 05:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=wm13NWTB8GdvsfS9RSewuxpx+o
	Q=; b=r49weYkodCSQDCOS0mXXnI/zKwfCBtlTH/EQLjDaslKXO0Cs8s4U3bHs+i
	ETcyY7UMAWiPhgl6gS6FbvGusSSXoCqRi/XTRRIKtunRQXpV0qv36If8CYvd8NM4
	IpbtG0ss1N1XGAvHpuxchsUyNHDcuQrvdbgrWFx3uPhLPWnJE=
X-Sasl-enc: XNOaAh/dK7v6S1BdoYTxie5aObB8DAhAXfWFtv4De7tT 1438767840
Received: from localhost (x5ce10e86.dyn.telefonica.de [92.225.14.134])
	by mail.messagingengine.com (Postfix) with ESMTPA id 088526801B4;
	Wed,  5 Aug 2015 05:43:59 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275362>

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

These two patches have previously been part of my patch series
fixing directory guessing. As Jeff King has been posting a patch
that contains tests for cloning from a server's root without
requiring t1509 I now post these two fixes as separate patches.

 t/t1509-root-worktree.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1509-root-worktree.sh b/t/t1509-root-worktree.sh
index b6977d4..0c80129 100755
--- a/t/t1509-root-worktree.sh
+++ b/t/t1509-root-worktree.sh
@@ -125,7 +125,7 @@ fi
 ONE_SHA1=d00491fd7e5bb6fa28c517a0bb32b8b506539d4d
 
 test_expect_success 'setup' '
-	rm -rf /foo
+	rm -rf /foo &&
 	mkdir /foo &&
 	mkdir /foo/bar &&
 	echo 1 > /foo/foome &&
@@ -218,7 +218,7 @@ unset GIT_WORK_TREE
 
 test_expect_success 'go to /' 'cd /'
 test_expect_success 'setup' '
-	rm -rf /.git
+	rm -rf /.git &&
 	echo "Initialized empty Git repository in /.git/" > expected &&
 	git init > result &&
 	test_cmp expected result
@@ -241,8 +241,8 @@ say "auto bare gitdir"
 
 # DESTROYYYYY!!!!!
 test_expect_success 'setup' '
-	rm -rf /refs /objects /info /hooks
-	rm /*
+	rm -rf /refs /objects /info /hooks &&
+	rm /* &&
 	cd / &&
 	echo "Initialized empty Git repository in /" > expected &&
 	git init --bare > result &&
-- 
2.5.0
