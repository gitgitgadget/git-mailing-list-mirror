From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 15/19] t/t5403-post-checkout-hook.sh: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 06:50:28 -0700
Message-ID: <1400593832-6510-16-git-send-email-gitter.spiros@gmail.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 15:51:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkS0-0000e3-Et
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbaETNvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:51:12 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47783 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594AbaETNuy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:50:54 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so341119pbb.33
        for <git@vger.kernel.org>; Tue, 20 May 2014 06:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7OvM3T1vJhYSCsu3KLgoIFh4bRHFFYN8ixKJ0qKgyf0=;
        b=zfpPuD+P2va7qhRV5+FYBWN1JURpc0xq6NcxEayilxV9SFY0OrCQsAMK18qiKAGXzI
         JJEYEllZB5P4XbPQ5OIAOayjF/0x9/cDAQO0XSmjXUxLtfG3HXlAH0CR42GgNXLrweGw
         xOZji15Nx7RZq3OK3yuTBqqEKechG8S8Z9Vcg2AwD1bq/5nYulUY82akIr9UUTdGzGbf
         cpE2OAc1tXmtFbwUWanGMIdU5ACbf5CuuPj9vcJnDNOQvkDPvEB4xL6AaEVkcgJEDJUl
         LJPJrYE46QLy5aipTGIn7jzSpZywMh1DxMLTelu8IrV3hwh5MD0Wv6mwB15XkNzch6Le
         dmtw==
X-Received: by 10.66.181.70 with SMTP id du6mr50156302pac.23.1400593853607;
        Tue, 20 May 2014 06:50:53 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id oe4sm3317286pbb.33.2014.05.20.06.50.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 06:50:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249674>

The interaction with unary operators and operator precedence
for && and || are better known than -a and -o, and for that
reason we prefer them. Replace all existing instances
of -a and -o to save readers from the burden of thinking
about such things.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t5403-post-checkout-hook.sh |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 1753ef2..fc898c9 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -39,7 +39,7 @@ test_expect_success 'post-checkout receives the right arguments with HEAD unchan
 	old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
 	new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
 	flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
-	test $old = $new -a $flag = 1
+	test $old = $new && test $flag = 1
 '
 
 test_expect_success 'post-checkout runs as expected ' '
@@ -52,7 +52,7 @@ test_expect_success 'post-checkout args are correct with git checkout -b ' '
 	old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
 	new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
 	flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
-	test $old = $new -a $flag = 1
+	test $old = $new && test $flag = 1
 '
 
 test_expect_success 'post-checkout receives the right args with HEAD changed ' '
@@ -60,7 +60,7 @@ test_expect_success 'post-checkout receives the right args with HEAD changed ' '
 	old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
 	new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
 	flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
-	test $old != $new -a $flag = 1
+	test $old != $new && test $flag = 1
 '
 
 test_expect_success 'post-checkout receives the right args when not switching branches ' '
@@ -68,7 +68,7 @@ test_expect_success 'post-checkout receives the right args when not switching br
 	old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
 	new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
 	flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
-	test $old = $new -a $flag = 0
+	test $old = $new && test $flag = 0
 '
 
 if test "$(git config --bool core.filemode)" = true; then
-- 
1.7.10.4
