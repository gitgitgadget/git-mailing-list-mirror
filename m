Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357AF2080E9
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830598; cv=none; b=PovZ93etNa33kjZ7013mBVNzleFu65KgPjBV947nZ6dmrnD6leFA0hK2pcyXzikdAYBE0TWebrOjk/Bp+VwTbemTjceEX2WKjBDMKaQMWFVccqK/w4ajF5FkWnhY6WSDZwgE0x1LCiukf4wel1FgSMLNST4XxX7L3hlZXhRMhiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830598; c=relaxed/simple;
	bh=4sszxzTwp/3mXbfNKGxhCn68tfoxtI9KDEXOXPdBojo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZTJPHRiRySyHTgAZQ2QDCM8VCg4f65+Rc0l7+8Z/bYT6EufjZL3sDHAaFPycWLKo7wqV+xQi8WBpm0/oyxzJm7+yWuhgTvFkrzMwt7GlmaVB+RW9dl2SBvRWlXB+1P46ivZV4NThvQMxArO3DFnxPmrXC0D4hTynYTwS3GvA+w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiRGva8b; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiRGva8b"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725aa5c597cso4060059b3a.1
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 03:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733830596; x=1734435396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X81mzSILQjyq4OH5bjfAfL/sk0GmWdiBQ0rt5rNZnVM=;
        b=LiRGva8babghx3m3ENQa0D7tLGQAHh+0t/KXWj5YrUoYoEnNyWGRnU6zS/qAH7PH4+
         mBoxjNZESnb5YaDv/v+1VX1ghTPDt8jE2uPRwjTSj1TN2StSfzIEhbosln5X/7k38u8+
         pjGcIu2J8mnJ2I3vDniygWeslG40YvwIP7q2W2mUTz1aulttTA+9FYcu5lFIFYXb3nZr
         RW907YSQkhWteD0MgNeeEmG5MSmgmh6KApEaKpa325SnnYcu4ppZku8hBSvscy7vh1Lw
         E8GUA28U7h9LbyvDdo03Wyhk0X/qZZBynQAZGfQR3oHN8msm1hX4rtogDBCFC5oap/LE
         wpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733830596; x=1734435396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X81mzSILQjyq4OH5bjfAfL/sk0GmWdiBQ0rt5rNZnVM=;
        b=bEqTWF+rxo7n/aWqqCf3QzXqTj54G6QXL9KX7rjjhJZj1qvMwXwLXHFeaWX1pJ1z5h
         67IKW221y4dT1fZLi/U0sHP7wUg3mctLU8QMZBvYsar7MVC7NXMQDn3ePJcVjMlJ4HI8
         FqeW3ROsEiuYWIApY0dcyyecUA4NCCd0kNLOkiiXU5Ol0s7u0xCyrRPEkfi/RlZucOhH
         FPWfQMfTZX6kiIVcAO77TizhVECNPjAqRx/YiP/c3Td++ddEGyOgaK0WrL2X0VmFAx46
         YA4UUnNWkFsksJ/3G0yOfIbLXNT4uF/ZFwWoo3OehcIwTSroeKhKKx9Bh3arSo2m2H7S
         DdOw==
X-Gm-Message-State: AOJu0Yw/uvO5USytyYRSCFs+xXfLWgz40xFCn3KdA4HCJzjwiaS+bIVV
	g2cPXq4grXp0+xKmlraYl6WSX4LDw2uwvVC95QPy4cYlJM4PFI7WeDKI8A==
X-Gm-Gg: ASbGncvxl3dUtw2h1BuZLJwCDzBeMaODBe7pOAjsqEbp71Yhv1aXvTx1CP7T21s5zMQ
	qjjePy+g0vrJ3hYBD1Dw/OlK02GEKcztaL+MdJVwggfZwaBWQ9UG653f/s1qlf7RjMO8PuDCGia
	SZ8+bpLtOV3KFeKNYe11NXd2lKV8b55BnCT9MGT2FUXRdS8w19nKiarwLcmZjQdsOy1iZ7hFOpu
	xZmTgtPiSSEr/vlB4guzvsice6ctRHhue6Irjd8EvLMMdS09l6r7tU2bCFRtqC6FDFFOD3UGf+V
	pQ5khnTsIbiPEJNSKBZcBrrgTX91oUKQwyqCulGlDoiEjw==
X-Google-Smtp-Source: AGHT+IGJf9SIyCsAUO2BsjPQZssC0np6oA5YVQ6v/SoODASDT6oC3lCdea6wVLEWO3kq3IVEd/rgwg==
X-Received: by 2002:a05:6a20:72a1:b0:1db:ebf4:2cb8 with SMTP id adf61e73a8af0-1e1b1b98d5cmr6377173637.38.1733830596083;
        Tue, 10 Dec 2024 03:36:36 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd54aa2399sm2554532a12.39.2024.12.10.03.36.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2024 03:36:35 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 2/8] t5548: refactor to reuse setup_upstream() function
Date: Tue, 10 Dec 2024 19:36:22 +0800
Message-Id: <63042f4d97a4a02e143d6f5b5b61d8158ea5f7d6.1733830410.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1733830410.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com> <cover.1733830410.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Refactor the function setup_upstream_and_workbench(), extracting
create_upstream_template() and setup_upstream() from it. The former is
used to create the upstream repository template, while the latter is
used to rebuild the upstream repository and will be reused in subsequent
commits.

To ensure that setup_upstream() works properly in both local and HTTP
protocols, the HTTP settings have been moved to the setup_upstream() and
setup_upstream_and_workbench() functions.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5548-push-porcelain.sh | 85 +++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 30 deletions(-)

diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index 6282728eaf..a3defd5b75 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -54,29 +54,67 @@ format_and_save_expect () {
 	sed -e 's/^> //' -e 's/Z$//' >expect
 }
 
+create_upstream_template () {
+	git init --bare upstream-template.git &&
+	git clone upstream-template.git tmp_work_dir &&
+	create_commits_in tmp_work_dir A B &&
+	(
+		cd tmp_work_dir &&
+		git push origin \
+			$B:refs/heads/main \
+			$A:refs/heads/foo \
+			$A:refs/heads/bar \
+			$A:refs/heads/baz
+	) &&
+	rm -rf tmp_work_dir
+}
+
+setup_upstream () {
+	if test $# -ne 1
+	then
+		BUG "location of upstream repository is not provided"
+	fi &&
+	rm -rf "$1" &&
+	if ! test -d upstream-template.git
+	then
+		create_upstream_template
+	fi &&
+	git clone --mirror upstream-template.git "$1" &&
+	# The upstream repository provides services using the HTTP protocol.
+	if ! test "$1" = "upstream.git"
+	then
+		git -C "$1" config http.receivepack true
+	fi
+}
+
 setup_upstream_and_workbench () {
+	if test $# -ne 1
+	then
+		BUG "location of upstream repository is not provided"
+	fi &&
+	# Assign the first argument to the variable upstream;
+	# we will use it in the subsequent test cases.
+	upstream="$1"
+
 	# Upstream  after setup : main(B)  foo(A)  bar(A)  baz(A)
 	# Workbench after setup : main(A)
 	test_expect_success "setup upstream repository and workbench" '
-		rm -rf upstream.git workbench &&
-		git init --bare upstream.git &&
-		git init workbench &&
-		create_commits_in workbench A B &&
+		setup_upstream "$upstream" &&
+		rm -rf workbench &&
+		git clone "$upstream" workbench &&
 		(
 			cd workbench &&
+			git update-ref refs/heads/main $A &&
 			# Try to make a stable fixed width for abbreviated commit ID,
 			# this fixed-width oid will be replaced with "<OID>".
 			git config core.abbrev 7 &&
-			git remote add origin ../upstream.git &&
-			git update-ref refs/heads/main $A &&
-			git push origin \
-				$B:refs/heads/main \
-				$A:refs/heads/foo \
-				$A:refs/heads/bar \
-				$A:refs/heads/baz
+			git config advice.pushUpdateRejected false
 		) &&
-		git -C "workbench" config advice.pushUpdateRejected false &&
-		upstream=upstream.git
+		# The upstream repository provides services using the HTTP protocol.
+		if ! test "$upstream" = "upstream.git"
+		then
+			git -C workbench remote set-url origin "$HTTPD_URL/smart/upstream.git"
+		fi
 	'
 }
 
@@ -88,7 +126,7 @@ run_git_push_porcelain_output_test() {
 		;;
 	file)
 		PROTOCOL="builtin protocol"
-		URL_PREFIX="\.\."
+		URL_PREFIX=".*"
 		;;
 	esac
 
@@ -247,10 +285,8 @@ run_git_push_porcelain_output_test() {
 	'
 }
 
-# Initialize the upstream repository and local workbench.
-setup_upstream_and_workbench
+setup_upstream_and_workbench upstream.git
 
-# Run git-push porcelain test on builtin protocol
 run_git_push_porcelain_output_test file
 
 ROOT_PATH="$PWD"
@@ -258,21 +294,10 @@ ROOT_PATH="$PWD"
 . "$TEST_DIRECTORY"/lib-httpd.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 start_httpd
-
-# Re-initialize the upstream repository and local workbench.
-setup_upstream_and_workbench
-
-test_expect_success "setup for http" '
-	git -C upstream.git config http.receivepack true &&
-	upstream="$HTTPD_DOCUMENT_ROOT_PATH/upstream.git" &&
-	mv upstream.git "$upstream" &&
-
-	git -C workbench remote set-url origin $HTTPD_URL/smart/upstream.git
-'
-
 setup_askpass_helper
 
-# Run git-push porcelain test on HTTP protocol
+setup_upstream_and_workbench "$HTTPD_DOCUMENT_ROOT_PATH/upstream.git"
+
 run_git_push_porcelain_output_test http
 
 test_done
-- 
2.47.0.rc1.21.g81e7bd6151

