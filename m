From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v2 1/5] t0008: remove duplicated test fixture data
Date: Thu, 11 Apr 2013 13:05:09 +0100
Message-ID: <1365681913-7059-1-git-send-email-git@adamspiers.org>
References: <20130411110511.GB24296@pacific.linksys.moosehall>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 14:05:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGFn-0002Se-8E
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934133Ab3DKMFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:05:16 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:59031 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761977Ab3DKMFP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:05:15 -0400
Received: from localhost (2.d.c.d.2.5.f.b.c.0.4.8.0.1.4.d.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:d410:840c:bf52:dcd2])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 9DBC458EB3
	for <git@vger.kernel.org>; Thu, 11 Apr 2013 13:05:14 +0100 (BST)
X-Mailer: git-send-email 1.8.2.1.342.gfa7285d
In-Reply-To: <20130411110511.GB24296@pacific.linksys.moosehall>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220848>

The expected contents of STDOUT for the final --stdin tests can be
derived from the expected contents of STDOUT for the same tests when
--verbose is given, in the same way that test_expect_success_multi
derives this for earlier tests.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 t/t0008-ignores.sh | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 9c1bde1..314a86d 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -575,21 +575,6 @@ cat <<-\EOF >stdin
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
@@ -605,6 +590,7 @@ cat <<-EOF >expected-verbose
 	$global_excludes:2:!globaltwo	b/globaltwo
 	$global_excludes:2:!globaltwo	../b/globaltwo
 EOF
+sed -e 's/.*	//' expected-verbose >expected-default
 
 sed -e 's/^"//' -e 's/\\//' -e 's/"$//' stdin | \
 	tr "\n" "\0" >stdin0
-- 
1.8.2.1.342.gfa7285d
