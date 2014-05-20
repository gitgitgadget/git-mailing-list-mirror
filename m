From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 12/19] t/t0026-eol-config.sh: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 06:50:25 -0700
Message-ID: <1400593832-6510-13-git-send-email-gitter.spiros@gmail.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 15:51:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkRy-0000e3-KO
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbaETNux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:50:53 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:43710 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587AbaETNuv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:50:51 -0400
Received: by mail-pd0-f176.google.com with SMTP id p10so338820pdj.21
        for <git@vger.kernel.org>; Tue, 20 May 2014 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I6xqVczgkBXGibju83QRk/Cem4goY9rqxfrXhzy9oyk=;
        b=v/hwh3q2CKDvJ6rdlC4ws4F9eSe4hYiPkaw0SUhDAC2uMeD5pJBGQcEVmLXPd4qeQH
         9YhosFjDFdCql6kDnIX1EO8i32FSNZVCDhYfbRP5ayVjNIOkngSf3/sILr8GGE501cDb
         k6q8IqqibVFMiSXLbvrB/ZGRF2WcigangY3sVuWnnHT8XJ8MvghLGBYOjQqGCD1voh/h
         DDfpmLRSREp6cNQgCpyxj2EnZpW8NSWlBktI8YmdI4AGccUI85JJywVTKjbMdHlYEult
         7c17FkUrk0Xr7p4c343txd0cUPGUE2tvCdpbuTH2YYBnXCTDENswGZFzRqShtCaY7HCA
         5vUw==
X-Received: by 10.66.136.103 with SMTP id pz7mr51234015pab.140.1400593850649;
        Tue, 20 May 2014 06:50:50 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id oe4sm3317286pbb.33.2014.05.20.06.50.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 06:50:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249677>

The interaction with unary operators and operator precedence
for && and || are better known than -a and -o, and for that
reason we prefer them. Replace all existing instances
of -a and -o to save readers from the burden of thinking
about such things.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t0026-eol-config.sh |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t0026-eol-config.sh b/t/t0026-eol-config.sh
index fe0164b..961ee32 100755
--- a/t/t0026-eol-config.sh
+++ b/t/t0026-eol-config.sh
@@ -36,7 +36,7 @@ test_expect_success 'eol=lf puts LFs in normalized file' '
 	! has_cr two &&
 	onediff=`git diff one` &&
 	twodiff=`git diff two` &&
-	test -z "$onediff" -a -z "$twodiff"
+	test -z "$onediff" && test -z "$twodiff"
 '
 
 test_expect_success 'eol=crlf puts CRLFs in normalized file' '
@@ -49,7 +49,7 @@ test_expect_success 'eol=crlf puts CRLFs in normalized file' '
 	! has_cr two &&
 	onediff=`git diff one` &&
 	twodiff=`git diff two` &&
-	test -z "$onediff" -a -z "$twodiff"
+	test -z "$onediff" && test -z "$twodiff"
 '
 
 test_expect_success 'autocrlf=true overrides eol=lf' '
@@ -63,7 +63,7 @@ test_expect_success 'autocrlf=true overrides eol=lf' '
 	has_cr two &&
 	onediff=`git diff one` &&
 	twodiff=`git diff two` &&
-	test -z "$onediff" -a -z "$twodiff"
+	test -z "$onediff" && test -z "$twodiff"
 '
 
 test_expect_success 'autocrlf=true overrides unset eol' '
@@ -77,7 +77,7 @@ test_expect_success 'autocrlf=true overrides unset eol' '
 	has_cr two &&
 	onediff=`git diff one` &&
 	twodiff=`git diff two` &&
-	test -z "$onediff" -a -z "$twodiff"
+	test -z "$onediff" && test -z "$twodiff"
 '
 
 test_done
-- 
1.7.10.4
