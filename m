Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250F1D5CC7
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740825245; cv=none; b=ho9yasUlByjwEie3YX4yYgIm02hCOO34TcBKUA7zhgr6zSLkO/Ljyn+BM6RgYmQXWTgFGWn7UQDF4wE5on85DB8JhU62lMDmkxjMR6Lcu/dov2SpXZZpPYS+6JRDxBhI1VvQt64784eEYXR2ZJGg7r1ryVKzp0N2WLTNwSzT7gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740825245; c=relaxed/simple;
	bh=zWM+MlAlVsvKq2n1CRx7bN2hEUjYG6T8y32Mo/3FhxQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AG12dvX2v3QNo8azfCdGZGbT31EioRwdAJBhFAGhU16p0Uw2jwzONplk7ot9n0xCFcDOMIw9J8AAtTOvsUZUIVQw4S6vFjl5fW9KRLLx5+bVNi8IVkmRu1+GStHaUkj98nZaEdCUlRYfdnOEsRe+IC3v0jfcgaPYHf/eITcffTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYRguvy7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYRguvy7"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so18635015e9.3
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 02:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740825241; x=1741430041; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/Xq49dtwj+I/a+KF+WwjMWY1l6PXED4Y6NO6tEMoKk=;
        b=DYRguvy7LYQrm2489C3RQXGe7zaNKilVaxz/m++Tb6sWKBIZMALa1xyYYJYdr1+uxJ
         UabBa4tSOnAZnDu9vhNFJt4FS4QwJMK7OJU9Mf1v4xWjPaN8MZu4WQ46+mH0aI16bdzp
         FuFx7Mg007Ru2VQBaAj71GfmoUSCvVzTcFNBPcxRd7sjGXZfTerUEoxH/AjCJL1l46jP
         htt9t452ruxXR+KIfMdKtjnltMhypAriJqzQPpiZFvtyLfz9WeWXXQNzQprSsTL4/52g
         VxhiGO6jyNP8CkD5N6TNowqu+a4QQchdx3Qv+3hisV/uPSm2MJF1wW6RSFUq3zMbixWQ
         9Nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740825241; x=1741430041;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/Xq49dtwj+I/a+KF+WwjMWY1l6PXED4Y6NO6tEMoKk=;
        b=s/l5bG/06qtCvJmrfXpSgsnjnULgO1/L2hU4uG5C7SdMPEggsBI+lBgqqAPAz+7eql
         FeKIb8nAIXMaCKnQ9h1rpVDHyNqcu2Jfg9IesxZfBehH+m3jiSxy0o0KUebBT0xz4HRh
         oCZao+A2UXPt7bZIjh/Wom4jzymYuzDBgwPRMBdY7wiGbKwsl8P5DeS6rvCBbWrmZGBJ
         hVW8h+D4RJ0eic6TbKhuG9nE5ZiG7k4j9V26CwOLxf3GtdKYmPeaVPskP6tKNTC7lR7U
         9IKDXXzvr/4H6HjdQ3Q/02VBMkZoNwCZlq7zDMQioAK56Ye6IJc5jjvKLzaDlX6lREti
         UbuA==
X-Gm-Message-State: AOJu0YxRklaCqI+6FyzevrcYpbvlOO0C/Tj5+AwyUpa5yngFtUh5bgrV
	RDZeL8lTqBpIdFWmQyd2nZ1To10Xubj37u/B6BZPO+zU1UBrVpiphCEEIA==
X-Gm-Gg: ASbGncuoYMc1uXmTUekfin9yGoNQZeDF1LLoEwzMtShgltL7zehkEwpdMNhn7mq+yRs
	ZFoZEHe1jCEn8zhDa0X0a8ja4hzIEZ91qYq9T84LCrYtR/BJXxrdP411DJAjzmFKUmJzzrJ4IPw
	u88/aNHY4meZ+zba0H4W4h03yO0wyNccMS95W9Y1pRA0+nPcA4oNtIwaEbDokdshXZ/k2rDjBSv
	2iGXlVqWVxptzYYd/lbjjaNCYpOkacyX3yRnOUNn0uxPLmHUhCsm8esjUxcziDWq1ILfjuYysiX
	b7KyXhNPUd061Q23TwbJrtGk9XbCw6k8Ovrl2EEt54R6tg==
X-Google-Smtp-Source: AGHT+IGnzXXyQHHhR+aG3j1IOHfs2D9icajKCLKn06uTvxwGFCoP3kRfNfkHO6maAZwn//b8S7UvOQ==
X-Received: by 2002:a05:600c:3ba9:b0:439:a155:549d with SMTP id 5b1f17b1804b1-43ba66e74f8mr53239645e9.12.1740825241424;
        Sat, 01 Mar 2025 02:34:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7371b004sm83792335e9.24.2025.03.01.02.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 02:34:00 -0800 (PST)
Message-Id: <5e198ba5c663cc42ac4dc54413fc5d367486d7c0.1740825238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.v2.git.git.1740825238.gitgitgadget@gmail.com>
References: <pull.1897.git.git.1740489585344.gitgitgadget@gmail.com>
	<pull.1897.v2.git.git.1740825238.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 01 Mar 2025 10:33:57 +0000
Subject: [PATCH v2 2/3] bundle-uri: update bundle clone tests with new refspec
 path
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
    Scott Chacon <schacon@gmail.com>,
    Scott Chacon <schacon@gmail.com>

From: Scott Chacon <schacon@gmail.com>

The update to the bundle-uri unbundling refspec puts all the heads from a
bundle file into refs/bundle/heads instead of directly into refs/bundle/ so
the tests need to be updated to look in the new heirarchy.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---
 t/t5558-clone-bundle-uri.sh | 172 ++++++++++++++++++------------------
 1 file changed, 86 insertions(+), 86 deletions(-)

diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 3816ed5058d..33a7009e9a2 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -58,7 +58,7 @@ test_expect_success 'create bundle' '
 test_expect_success 'clone with path bundle' '
 	git clone --bundle-uri="clone-from/B.bundle" \
 		clone-from clone-path &&
-	git -C clone-path rev-parse refs/bundles/topic >actual &&
+	git -C clone-path rev-parse refs/bundles/heads/topic >actual &&
 	git -C clone-from rev-parse topic >expect &&
 	test_cmp expect actual
 '
@@ -68,9 +68,9 @@ test_expect_success 'clone with bundle that has bad header' '
 	git clone --bundle-uri="clone-from/bad-header.bundle" \
 		clone-from clone-bad-header 2>err &&
 	commit_b=$(git -C clone-from rev-parse B) &&
-	test_grep "trying to write ref '\''refs/bundles/topic'\'' with nonexistent object $commit_b" err &&
+	test_grep "trying to write ref '\''refs/bundles/heads/topic'\'' with nonexistent object $commit_b" err &&
 	git -C clone-bad-header for-each-ref --format="%(refname)" >refs &&
-	test_grep ! "refs/bundles/" refs
+	test_grep ! "refs/bundles/heads/" refs
 '
 
 test_expect_success 'clone with bundle that has bad object' '
@@ -78,8 +78,8 @@ test_expect_success 'clone with bundle that has bad object' '
 	git clone --bundle-uri="clone-from/bad-object.bundle" \
 		clone-from clone-bad-object-no-fsck &&
 	git -C clone-bad-object-no-fsck for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
-	test_write_lines refs/bundles/bad >expect &&
+	grep "refs/bundles/heads/" refs >actual &&
+	test_write_lines refs/bundles/heads/bad >expect &&
 	test_cmp expect actual &&
 
 	# Unbundle fails with fsckObjects set true, but clone can still proceed.
@@ -87,14 +87,14 @@ test_expect_success 'clone with bundle that has bad object' '
 		clone-from clone-bad-object-fsck 2>err &&
 	test_grep "missingEmail" err &&
 	git -C clone-bad-object-fsck for-each-ref --format="%(refname)" >refs &&
-	test_grep ! "refs/bundles/" refs
+	test_grep ! "refs/bundles/heads/" refs
 '
 
 test_expect_success 'clone with path bundle and non-default hash' '
 	test_when_finished "rm -rf clone-path-non-default-hash" &&
 	GIT_DEFAULT_HASH=sha256 git clone --bundle-uri="clone-from/B.bundle" \
 		clone-from clone-path-non-default-hash &&
-	git -C clone-path-non-default-hash rev-parse refs/bundles/topic >actual &&
+	git -C clone-path-non-default-hash rev-parse refs/bundles/heads/topic >actual &&
 	git -C clone-from rev-parse topic >expect &&
 	test_cmp expect actual
 '
@@ -102,7 +102,7 @@ test_expect_success 'clone with path bundle and non-default hash' '
 test_expect_success 'clone with file:// bundle' '
 	git clone --bundle-uri="file://$(pwd)/clone-from/B.bundle" \
 		clone-from clone-file &&
-	git -C clone-file rev-parse refs/bundles/topic >actual &&
+	git -C clone-file rev-parse refs/bundles/heads/topic >actual &&
 	git -C clone-from rev-parse topic >expect &&
 	test_cmp expect actual
 '
@@ -173,12 +173,12 @@ test_expect_success 'clone bundle list (file, no heuristic)' '
 	git -C clone-list-file cat-file --batch-check <oids &&
 
 	git -C clone-list-file for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/merge
-	refs/bundles/right
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/merge
+	refs/bundles/heads/right
 	EOF
 	test_cmp expect actual
 '
@@ -220,10 +220,10 @@ test_expect_success 'clone bundle list (file, all mode, some failures)' '
 	git -C clone-all-some cat-file --batch-check <oids &&
 
 	git -C clone-all-some for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
+	refs/bundles/heads/base
+	refs/bundles/heads/left
 	EOF
 	test_cmp expect actual
 '
@@ -253,7 +253,7 @@ test_expect_success 'clone bundle list (file, all mode, all failures)' '
 	git -C clone-all-fail cat-file --batch-check <oids &&
 
 	git -C clone-all-fail for-each-ref --format="%(refname)" >refs &&
-	! grep "refs/bundles/" refs
+	! grep "refs/bundles/heads/" refs
 '
 
 test_expect_success 'clone bundle list (file, any mode)' '
@@ -282,9 +282,9 @@ test_expect_success 'clone bundle list (file, any mode)' '
 	git -C clone-any-file cat-file --batch-check <oids &&
 
 	git -C clone-any-file for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
+	refs/bundles/heads/base
 	EOF
 	test_cmp expect actual
 '
@@ -313,7 +313,7 @@ test_expect_success 'clone bundle list (file, any mode, all failures)' '
 	git -C clone-any-fail cat-file --batch-check <oids &&
 
 	git -C clone-any-fail for-each-ref --format="%(refname)" >refs &&
-	! grep "refs/bundles/" refs
+	! grep "refs/bundles/heads/" refs
 '
 
 test_expect_success 'negotiation: bundle with part of wanted commits' '
@@ -322,10 +322,10 @@ test_expect_success 'negotiation: bundle with part of wanted commits' '
 	git clone --no-local --bundle-uri="clone-from/A.bundle" \
 		clone-from nego-bundle-part &&
 	git -C nego-bundle-part for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
-	test_write_lines refs/bundles/topic >expect &&
+	grep "refs/bundles/heads/" refs >actual &&
+	test_write_lines refs/bundles/heads/topic >expect &&
 	test_cmp expect actual &&
-	# Ensure that refs/bundles/topic are sent as "have".
+	# Ensure that refs/bundles/heads/topic are sent as "have".
 	tip=$(git -C clone-from rev-parse A) &&
 	test_grep "clone> have $tip" trace-packet.txt
 '
@@ -337,8 +337,8 @@ test_expect_success 'negotiation: bundle with all wanted commits' '
 		--bundle-uri="clone-from/B.bundle" \
 		clone-from nego-bundle-all &&
 	git -C nego-bundle-all for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
-	test_write_lines refs/bundles/topic >expect &&
+	grep "refs/bundles/heads/" refs >actual &&
+	test_write_lines refs/bundles/heads/topic >expect &&
 	test_cmp expect actual &&
 	# We already have all needed commits so no "want" needed.
 	test_grep ! "clone> want " trace-packet.txt
@@ -363,13 +363,13 @@ test_expect_success 'negotiation: bundle list (no heuristic)' '
 		clone-from nego-bundle-list-no-heuristic &&
 
 	git -C nego-bundle-list-no-heuristic for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
+	refs/bundles/heads/base
+	refs/bundles/heads/left
 	EOF
 	test_cmp expect actual &&
-	tip=$(git -C nego-bundle-list-no-heuristic rev-parse refs/bundles/left) &&
+	tip=$(git -C nego-bundle-list-no-heuristic rev-parse refs/bundles/heads/left) &&
 	test_grep "clone> have $tip" trace-packet.txt
 '
 
@@ -395,13 +395,13 @@ test_expect_success 'negotiation: bundle list (creationToken)' '
 		clone-from nego-bundle-list-heuristic &&
 
 	git -C nego-bundle-list-heuristic for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
+	refs/bundles/heads/base
+	refs/bundles/heads/left
 	EOF
 	test_cmp expect actual &&
-	tip=$(git -C nego-bundle-list-heuristic rev-parse refs/bundles/left) &&
+	tip=$(git -C nego-bundle-list-heuristic rev-parse refs/bundles/heads/left) &&
 	test_grep "clone> have $tip" trace-packet.txt
 '
 
@@ -428,10 +428,10 @@ test_expect_success 'negotiation: bundle list with all wanted commits' '
 		clone-from nego-bundle-list-all &&
 
 	git -C nego-bundle-list-all for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
+	refs/bundles/heads/base
+	refs/bundles/heads/left
 	EOF
 	test_cmp expect actual &&
 	# We already have all needed commits so no "want" needed.
@@ -465,7 +465,7 @@ test_expect_success 'clone HTTP bundle' '
 
 	git clone --bundle-uri="$HTTPD_URL/B.bundle" \
 		"$HTTPD_URL/smart/fetch.git" clone-http &&
-	git -C clone-http rev-parse refs/bundles/topic >actual &&
+	git -C clone-http rev-parse refs/bundles/heads/topic >actual &&
 	git -C clone-from rev-parse topic >expect &&
 	test_cmp expect actual &&
 
@@ -476,7 +476,7 @@ test_expect_success 'clone HTTP bundle with non-default hash' '
 	test_when_finished "rm -rf clone-http-non-default-hash" &&
 	GIT_DEFAULT_HASH=sha256 git clone --bundle-uri="$HTTPD_URL/B.bundle" \
 		"$HTTPD_URL/smart/fetch.git" clone-http-non-default-hash &&
-	git -C clone-http-non-default-hash rev-parse refs/bundles/topic >actual &&
+	git -C clone-http-non-default-hash rev-parse refs/bundles/heads/topic >actual &&
 	git -C clone-from rev-parse topic >expect &&
 	test_cmp expect actual
 '
@@ -553,12 +553,12 @@ test_expect_success 'clone bundle list (HTTP, any mode)' '
 	git -C clone-any-http cat-file --batch-check <oids &&
 
 	git -C clone-list-file for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/merge
-	refs/bundles/right
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/merge
+	refs/bundles/heads/right
 	EOF
 	test_cmp expect actual
 '
@@ -641,9 +641,9 @@ test_expect_success 'clone incomplete bundle list (http, creationToken)' '
 	test_cmp expect actual &&
 
 	# We now have only one bundle ref.
-	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
+	refs/bundles/heads/base
 	EOF
 	test_cmp expect refs &&
 
@@ -679,13 +679,13 @@ test_expect_success 'clone incomplete bundle list (http, creationToken)' '
 	test_cmp expect actual &&
 
 	# We now have all bundle refs.
-	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/merge
-	refs/bundles/right
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/merge
+	refs/bundles/heads/right
 	EOF
 	test_cmp expect refs
 '
@@ -721,9 +721,9 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 	test_cmp expect actual &&
 
 	# only received base ref from bundle-1
-	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
+	refs/bundles/heads/base
 	EOF
 	test_cmp expect refs &&
 
@@ -749,10 +749,10 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 	test_cmp expect actual &&
 
 	# received left from bundle-2
-	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
+	refs/bundles/heads/base
+	refs/bundles/heads/left
 	EOF
 	test_cmp expect refs &&
 
@@ -795,12 +795,12 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 
 	# received merge ref from bundle-4, but right is missing
 	# because we did not download bundle-3.
-	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/merge
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/merge
 	EOF
 	test_cmp expect refs &&
 
@@ -862,7 +862,7 @@ test_expect_success 'creationToken heuristic with failed downloads (clone)' '
 	test_cmp expect actual &&
 
 	# All bundles failed to unbundle
-	git -C download-1 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C download-1 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	test_must_be_empty refs &&
 
 	# Case 2: middle bundle does not exist, only two bundles can unbundle
@@ -909,10 +909,10 @@ test_expect_success 'creationToken heuristic with failed downloads (clone)' '
 	test_cmp expect actual &&
 
 	# bundle-1 and bundle-3 could unbundle, but bundle-4 could not
-	git -C download-2 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C download-2 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-EOF &&
-	refs/bundles/base
-	refs/bundles/right
+	refs/bundles/heads/base
+	refs/bundles/heads/right
 	EOF
 	test_cmp expect refs &&
 
@@ -961,11 +961,11 @@ test_expect_success 'creationToken heuristic with failed downloads (clone)' '
 	test_cmp expect actual &&
 
 	# fake.bundle did not unbundle, but the others did.
-	git -C download-3 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C download-3 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/right
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/right
 	EOF
 	test_cmp expect refs
 '
@@ -1083,15 +1083,15 @@ test_expect_success 'creationToken heuristic with failed downloads (fetch)' '
 	test_cmp expect actual &&
 
 	# Check which bundles have unbundled by refs
-	git -C fetch-1 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C fetch-1 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/lefter
-	refs/bundles/merge
-	refs/bundles/right
-	refs/bundles/righter
-	refs/bundles/top
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/lefter
+	refs/bundles/heads/merge
+	refs/bundles/heads/right
+	refs/bundles/heads/righter
+	refs/bundles/heads/top
 	EOF
 	test_cmp expect refs &&
 
@@ -1144,12 +1144,12 @@ test_expect_success 'creationToken heuristic with failed downloads (fetch)' '
 	test_cmp expect actual &&
 
 	# Check which bundles have unbundled by refs
-	git -C fetch-2 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C fetch-2 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/merge
-	refs/bundles/right
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/merge
+	refs/bundles/heads/right
 	EOF
 	test_cmp expect refs &&
 
@@ -1204,13 +1204,13 @@ test_expect_success 'creationToken heuristic with failed downloads (fetch)' '
 	test_cmp expect actual &&
 
 	# Check which bundles have unbundled by refs
-	git -C fetch-3 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C fetch-3 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/lefter
-	refs/bundles/right
-	refs/bundles/righter
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/lefter
+	refs/bundles/heads/right
+	refs/bundles/heads/righter
 	EOF
 	test_cmp expect refs
 '
-- 
gitgitgadget

