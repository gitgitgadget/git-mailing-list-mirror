From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 23/26] t5500, t5539: tests for shallow depth excluding a ref
Date: Wed, 13 Apr 2016 19:55:07 +0700
Message-ID: <1460552110-5554-24-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:57:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKMG-0004iV-7J
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757569AbcDMM5T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:57:19 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36069 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030842AbcDMM5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:57:16 -0400
Received: by mail-pa0-f67.google.com with SMTP id k3so3877424pav.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tn4xifWU4XeM+QmrJtJZpT1r6DFNW7mG9QGw9fU1tyU=;
        b=JM1wDfXhMfQCgwAkhYhYxut69e3oIR+ZXC+faypU9ZOPjTLTiZiBJah2qWBqpVIyXO
         GOWGqsZPddD4C7rcIdlFN+TkO2SX4vCuF5yTijridQA816WFVehhJvaKy3U7qTlNxqYZ
         XfyDir0kJIiZ1rSYYfRuL/1l1Gl9t4aaKbLKc4W+gXPXSt2NWkwSN4/2ZJiiMQ+IfLfo
         VwPKOCHTP6EaBTknJDYDLo9BGGMwRbpJzW0mUL4gIO/EgHYr5CF5AaxPB7iAotlkzrEb
         ZmqrYiey6lnTSN7sYR3FKXMwMwZwhno3OfNdA7GCII+yLyyWOYUkRHS5GEjoG0EKQUrs
         X6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tn4xifWU4XeM+QmrJtJZpT1r6DFNW7mG9QGw9fU1tyU=;
        b=MFXIRXgEczC8XcO6yvqqvBaYG4hPT20Uu/vld+YOPcxc8I61YUkpEWE7Z08s8MF2l7
         L5u654yAQDkiyvnRPLRh2r6XQ7HVE1H0hDduJjaadF98nRcx4jLgl4Nn0Aj9mQIzWE0X
         Fs5E1KgNbjc7+YkyJfJVVCuDQpBB4DNX+vWzmGipXGwMjly1Pd4YD/5dwUpSaLo/JbQC
         LeJAk78M94YzIR7+QQZW3uHfrESvIAZca5FjSwFlGAQ2ARnFizv1aa32DylMKEJv/W1W
         JV9Ogn5gN0upGIu05ll41aCyQcBE45PfPlvMYynvuHWCpkLxl2cI7Xfrk4mMEHADdOzu
         bOjA==
X-Gm-Message-State: AOPr4FV3mXgqG1nl/FPNfiDrCAtZ4QJWpb7Xgk/RrFPbfaPlY/G/UhlfM0NjiM3oqj0u5w==
X-Received: by 10.67.21.167 with SMTP id hl7mr12597597pad.16.1460552235456;
        Wed, 13 Apr 2016 05:57:15 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id 82sm51038500pfi.78.2016.04.13.05.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:57:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:57:21 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291417>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5500-fetch-pack.sh         | 22 ++++++++++++++++++++++
 t/t5539-fetch-http-shallow.sh | 22 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 26f050d..a3fe5ca 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -661,4 +661,26 @@ test_expect_success 'fetch shallow since ...' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'shallow clone exclude tag two' '
+	test_create_repo shallow-exclude &&
+	(
+	cd shallow-exclude &&
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	git clone --shallow-exclude two "file://$(pwd)/." ../shallow12 &&
+	git -C ../shallow12 log --pretty=3Dtformat:%s HEAD >actual &&
+	echo three >expected &&
+	test_cmp expected actual
+	)
+'
+
+test_expect_success 'fetch exclude tag one' '
+	git -C shallow12 fetch --shallow-exclude one origin &&
+	git -C shallow12 log --pretty=3Dtformat:%s origin/master >actual &&
+	echo three >expected &&
+	echo two  >>expected &&
+	test_cmp expected actual
+'
+
 test_done
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow=
=2Esh
index 6d77ca7..f71573d 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -98,6 +98,28 @@ test_expect_success 'fetch shallow since ...' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'shallow clone exclude tag two' '
+	test_create_repo shallow-exclude &&
+	(
+	cd shallow-exclude &&
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	mv .git "$HTTPD_DOCUMENT_ROOT_PATH/shallow-exclude.git" &&
+	git clone --shallow-exclude two $HTTPD_URL/smart/shallow-exclude.git =
=2E./shallow12 &&
+	git -C ../shallow12 log --pretty=3Dtformat:%s HEAD >actual &&
+	echo three >expected &&
+	test_cmp expected actual
+	)
+'
+
+test_expect_success 'fetch exclude tag one' '
+	git -C shallow12 fetch --shallow-exclude one origin &&
+	git -C shallow12 log --pretty=3Dtformat:%s origin/master >actual &&
+	echo three >expected &&
+	echo two  >>expected &&
+	test_cmp expected actual
+'
=20
 stop_httpd
 test_done
--=20
2.8.0.rc0.210.gd302cd2
