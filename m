From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 17/25] t5500, t5539: tests for shallow depth since a specific date
Date: Tue, 23 Feb 2016 20:44:55 +0700
Message-ID: <1456235103-26317-18-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:47:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDIf-0000xz-F5
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbcBWNqh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:46:37 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32964 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbcBWNqe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:46:34 -0500
Received: by mail-pf0-f175.google.com with SMTP id q63so112568261pfb.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ixk91sxUBCEJZv0k3CIlHzLBlf5cQ+R1Vxwl1ws3dSE=;
        b=V+D+VXbreoBA1wCvP5SwSmqPekN7zZUe8T1+LyvUvs5Kje+fl7I9ehIqVtzUbMBmIo
         2bu7dkWVpESUf4fP8yRYWA9nCiCVyNJkkuXz3ycXrx3cvqClAO/Rn20ryBOhp555iNEe
         Nbx/oi6JHFOZhparnXacSbx6HEn83cfQzKmsJj33lTSOSitszfx5n8K9ghJ5vr7LcYvu
         dCbfDeZ7Khi/PbM3bH3K0J+uLto0K0BD+H4Il6h/bdvOWdFPwIlKs49evUMJutKfe3m4
         cEaYuIyDlUqpj0aDJ1flof6E8sF241Egbi3wawX6jAYsC3h5pioAYS5R/z773Czz3afT
         2Ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=ixk91sxUBCEJZv0k3CIlHzLBlf5cQ+R1Vxwl1ws3dSE=;
        b=glCOoVNm1GtkzNgoN/ee606NckXddVTJEsuHXrTTRUjh/HQq9rnVVzdFcczbUPrfys
         T3lhWryglgPCpaEHJi7LZ5QCZ74592RgHF/nAF4e/C5Z84SE7dceZ7wcO+u3AP1yLmu+
         u+2JSejBZtafU+ZZNaGFEaqjLkLk7jKHnD+YdnGOmpFFswjHnG/0xOfKG+GmIeoSyQPi
         DhxSA54HzWIOw0udso03L3lLl8wvkWFxGWrRVkYH7VqeoBXKHuVqRoNb6wleqpvCqyA9
         U+rqYhrCxNiHytG5eHo0Oc6dz7sDH3C5JaoylOOtCVWJWjAG1oY6ZaafPS2gv/J8P+nD
         j7rQ==
X-Gm-Message-State: AG10YORG+kZkaeZM9mk25e0jpyiPe1Yi1Z+ZfI+AW0IsmaAfVZob5kjpd6OVLWDyq1yjzQ==
X-Received: by 10.98.7.146 with SMTP id 18mr46364860pfh.47.1456235194467;
        Tue, 23 Feb 2016 05:46:34 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 79sm44414568pfq.65.2016.02.23.05.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:46:32 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:47:03 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287069>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5500-fetch-pack.sh         | 24 ++++++++++++++++++++++++
 t/t5539-fetch-http-shallow.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index e5f83bf..26f050d 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -637,4 +637,28 @@ test_expect_success MINGW 'fetch-pack --diag-url c=
:repo' '
 	check_prot_path c:repo file c:repo
 '
=20
+test_expect_success 'clone shallow since ...' '
+	test_create_repo shallow-since &&
+	(
+	cd shallow-since &&
+	GIT_COMMITTER_DATE=3D"100000000 +0700" git commit --allow-empty -m on=
e &&
+	GIT_COMMITTER_DATE=3D"200000000 +0700" git commit --allow-empty -m tw=
o &&
+	GIT_COMMITTER_DATE=3D"300000000 +0700" git commit --allow-empty -m th=
ree &&
+	git clone --shallow-since "300000000 +0700" "file://$(pwd)/." ../shal=
low11 &&
+	git -C ../shallow11 log --pretty=3Dtformat:%s HEAD >actual &&
+	echo three >expected &&
+	test_cmp expected actual
+	)
+'
+
+test_expect_success 'fetch shallow since ...' '
+	git -C shallow11 fetch --shallow-since "200000000 +0700" origin &&
+	git -C shallow11 log --pretty=3Dtformat:%s origin/master >actual &&
+	cat >expected <<-\EOF &&
+	three
+	two
+	EOF
+	test_cmp expected actual
+'
+
 test_done
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow=
=2Esh
index 37a4335..6d77ca7 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -73,5 +73,31 @@ test_expect_success 'no shallow lines after receivin=
g ACK ready' '
 	)
 '
=20
+test_expect_success 'clone shallow since ...' '
+	test_create_repo shallow-since &&
+	(
+	cd shallow-since &&
+	GIT_COMMITTER_DATE=3D"100000000 +0700" git commit --allow-empty -m on=
e &&
+	GIT_COMMITTER_DATE=3D"200000000 +0700" git commit --allow-empty -m tw=
o &&
+	GIT_COMMITTER_DATE=3D"300000000 +0700" git commit --allow-empty -m th=
ree &&
+	mv .git "$HTTPD_DOCUMENT_ROOT_PATH/shallow-since.git" &&
+	git clone --shallow-since "300000000 +0700" $HTTPD_URL/smart/shallow-=
since.git ../shallow11 &&
+	git -C ../shallow11 log --pretty=3Dtformat:%s HEAD >actual &&
+	echo three >expected &&
+	test_cmp expected actual
+	)
+'
+
+test_expect_success 'fetch shallow since ...' '
+	git -C shallow11 fetch --shallow-since "200000000 +0700" origin &&
+	git -C shallow11 log --pretty=3Dtformat:%s origin/master >actual &&
+	cat >expected <<-\EOF &&
+	three
+	two
+	EOF
+	test_cmp expected actual
+'
+
+
 stop_httpd
 test_done
--=20
2.7.1.532.gd9e3aaa
