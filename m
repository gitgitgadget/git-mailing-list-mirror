From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH 4/5] t0008: remove duplicated test fixture data
Date: Thu, 11 Apr 2013 02:59:34 +0100
Message-ID: <1365645575-11428-4-git-send-email-git@adamspiers.org>
References: <20130408181311.GA14903@pacific.linksys.moosehall>
 <1365645575-11428-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 03:59:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ6nr-0007W4-6U
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 03:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072Ab3DKB7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 21:59:47 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:58205 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935721Ab3DKB7j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 21:59:39 -0400
Received: from localhost (5.c.4.3.a.a.9.7.2.0.8.9.d.e.c.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:bced:9802:79aa:34c5])
	by coral.adamspiers.org (Postfix) with ESMTPSA id E70A92EAD5
	for <git@vger.kernel.org>; Thu, 11 Apr 2013 02:59:38 +0100 (BST)
X-Mailer: git-send-email 1.8.2.1.347.g37e0606
In-Reply-To: <1365645575-11428-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220805>

The expected contents of STDOUT for the final --stdin tests can be
derived from the expected contents of STDOUT for the same tests when
--verbose is given, in the same way that test_expect_success_multi
derives this for earlier tests.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 t/t0008-ignores.sh | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 0dd3ef7..80b731a 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -571,21 +571,6 @@ cat <<-\EOF >stdin
 	b/globaltwo
 	../b/globaltwo
 EOF
-cat <<-\EOF >expected-default
-	../one
-	one
-	b/on
-	b/one
-	b/one one
-	b/one two
-	"b/one\"three"
-	b/two
-	b/twooo
-	../globaltwo
-	globaltwo
-	b/globaltwo
-	../b/globaltwo
-EOF
 cat <<-EOF >expected-verbose
 	.gitignore:1:one	../one
 	.gitignore:1:one	one
@@ -601,6 +586,7 @@ cat <<-EOF >expected-verbose
 	$global_excludes:2:!globaltwo	b/globaltwo
 	$global_excludes:2:!globaltwo	../b/globaltwo
 EOF
+sed -e 's/.*	//' expected-verbose >expected-default
 
 sed -e 's/^"//' -e 's/\\//' -e 's/"$//' stdin | \
 	tr "\n" "\0" >stdin0
-- 
1.8.2.1.347.g37e0606
