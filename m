From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] fix t5403-post-checkout-hook.sh: built-in test in dash does not have "=="
Date: Thu, 4 Oct 2007 15:32:53 +0200
Message-ID: <20071004133253.GA30393@steel.home>
References: <1190842261-9750-1-git-send-email-jjengla@sandia.gov>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh England <jjengla@sandia.gov>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Oct 04 15:33:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdQp8-00011q-6q
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 15:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499AbXJDNc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 09:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755355AbXJDNc5
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 09:32:57 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:19006 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755306AbXJDNc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 09:32:56 -0400
Received: from tigra.home (Fc941.f.strato-dslnet.de [195.4.201.65])
	by post.webmailer.de (klopstock mo33) (RZmta 13.4)
	with ESMTP id c03382j94DAUcI ; Thu, 4 Oct 2007 15:32:54 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 4843E277AE;
	Thu,  4 Oct 2007 15:32:54 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id B412DC772; Thu,  4 Oct 2007 15:32:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1190842261-9750-1-git-send-email-jjengla@sandia.gov>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAPn7A==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59952>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Josh England, Wed, Sep 26, 2007 23:31:01 +0200:
>  t/t5403-post-checkout-hook.sh |   74 +++++++++++++++++++++++++++++++++++++++++

on Ubuntu, /bin/sh is dash.

 t/t5403-post-checkout-hook.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 487abf3..823239a 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -39,7 +39,7 @@ test_expect_success 'post-checkout receives the right arguments with HEAD unchan
         old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
         new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
         flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
-        test $old = $new -a $flag == 1
+        test $old = $new -a $flag = 1
 '
 
 test_expect_success 'post-checkout runs as expected ' '
@@ -52,7 +52,7 @@ test_expect_success 'post-checkout args are correct with git checkout -b ' '
         old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
         new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
         flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
-        test $old = $new -a $flag == 1
+        test $old = $new -a $flag = 1
 '
 
 test_expect_success 'post-checkout receives the right args with HEAD changed ' '
@@ -60,7 +60,7 @@ test_expect_success 'post-checkout receives the right args with HEAD changed ' '
         old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
         new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
         flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
-        test $old != $new -a $flag == 1
+        test $old != $new -a $flag = 1
 '
 
 test_expect_success 'post-checkout receives the right args when not switching branches ' '
@@ -68,7 +68,7 @@ test_expect_success 'post-checkout receives the right args when not switching br
         old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
         new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
         flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
-        test $old == $new -a $flag == 0
+        test $old = $new -a $flag = 0
 '
 
 test_done
-- 
1.5.3.3.147.g2054
