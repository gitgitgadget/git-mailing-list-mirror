Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7854728DF2E
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137340; cv=none; b=SXKvaC6a9PDmHjTqV6cZU+guAxjWCbjbnXMy710U4pkLA8C8xS6reIL/spQ04qEj8wwyiacssMASVV4XAVCr3TfPhKKcOXa1lbgOeoctAzpaWpBlSdtLQgee60kA78a5BzmDw4ml93rh+MznAEZSzK90psWK8PRgbnuTuIrIjuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137340; c=relaxed/simple;
	bh=3xt82qE/HPjfphF7/SU5SZkifBOkukvU6zo2jNd/vVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHDk9dhUQWIukV2MbCdLoUfBlpYxfelujH2nvC/pa7XQkh1oivLSoPHrmEkqn9bLT9FyQrcjfDYhl/JdlHpUvvbrz+wfZA8xqp9Ur3apdMcAt3MkW938giDx/Jn5e0suCHuQ+k0Ja1M10Pd3wuqB6u9QYTDuqFpw1551AF5gtv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJ0Vu3ij; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJ0Vu3ij"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-748e378ba4fso928886b3a.1
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752137338; x=1752742138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQocF83xyvsr1u8FvrBUXhOfala3AbUPUNIDQqfxRCU=;
        b=PJ0Vu3ijRwOdFrTLlY3avfqGbdld1Yc/81upnnabC/yEE1pc2wj24oMDK50MuyIYJw
         uFty399uMiFbYDXAy9vPmL99D8uVTaAi/rhvDrJrFM4+6ajxNLG7xeYJGEE1EUs731hk
         uvhY8XtsQ+1jJhq+DkwWtiNhi5Ry+aDLxzVZ8YUzTQh6YQyKYOPU/lTTMDjyBC5AVaHN
         rNRt4/F+SpaS6ow6IrrBD98XLZ+d4KM4b/OCR2jNhkBqo3VUVwuSSr3w4vQis87pqCxR
         svCmNTmfWbSxqGcJYLPg5caPn1qh2PkoVGFsrynISZSYGVOE0tBNOZHmMjnfK9baXSYk
         Ep8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137338; x=1752742138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQocF83xyvsr1u8FvrBUXhOfala3AbUPUNIDQqfxRCU=;
        b=RqWFKdY60MJBcrPm8URgvV8OpOOffVZFzBS5a93uWlHxc+pxSpOI9KAyeTp8ZroCjG
         Qz1X0OPtvJuHthaIhOvOjUKbwweNJ5iqjmFg43Z92BSeuYKvcQM8VOrI8KkkQMavWVJI
         QbHwQ47yyyzxc2ICMK/NqPViOyPDEjMjn1Q1VDtBjHOYx1BmTisF10iFE9QqAUSAGtdZ
         vwhYpX+T8m66XVIZM4VadlTOC8iQ0FuNfIhe1bwnQpE/fIV0GfOsKPWGo7WvSri4YrRS
         MKypjuVvTMvXqlj6Y2KBBueKwKBax/09hEPDsnusjt8mthW/ZYmCm+tO3mhKPvOh1Gfx
         8GVA==
X-Forwarded-Encrypted: i=1; AJvYcCUv4l91FXK/ZmdWtFy3sHfKBDbAcBJA890e1AN8Iu9fScLEaM9t28kp6c0GAgNbEEsrgj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVv2YHYNhGX57V1/ZYIvs7PUC6RRSrgazjj0ZLW0dzXbruAG5t
	wGpc6+FkGNEcLSJk11xrVXdXZJORnT3DroY6U/igA9bjcN1z+QZLPwJS
X-Gm-Gg: ASbGncv/1gypPUi9Sm9lf/cbYeTNAVqHk3tBwAXRv7CltBwKL09IMmwa8VRQ1kTdCSI
	bpM+Vhxyxy2MOAQpAfrUv2HEqXUsgFpDzvO3CZ1DOFrS/15JBPWcMVtJKcupxNNtM8U2yD9pp2W
	Fe41Nv91sWJSpCXghFP2nyI3Z6cU99OMX97HAXT3x0wsc5V5E/k6UWQQeFnUPd/iEbqPD0lhUmM
	U6ts8I2h2EddYfYgo4XQB7MvWERKdC+qB5LdtzUX2ruOwIf403GNySw0dWER5fXjNX5T7nSt1jD
	0BmlOwlh+4hQQH4v3WcQq/3e10qsgTW11w8HDcc76+L4cosjyXBOkmAwz7X31I0F4PtA
X-Google-Smtp-Source: AGHT+IFtqhDT2AH3qxF6nuSsLeM/eJmyTJUQNnj8cEFTGGlhmjvruFaFD3412b3u+H9mV4Smv2V4UA==
X-Received: by 2002:a05:6a00:ac8:b0:740:67aa:94ab with SMTP id d2e1a72fcca58-74ea60b15abmr9179758b3a.0.1752137337703;
        Thu, 10 Jul 2025 01:48:57 -0700 (PDT)
Received: from r760 ([188.253.126.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f22d93sm1535777b3a.89.2025.07.10.01.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:48:57 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: yldhome2d2@gmail.com
Cc: 502024330056@smail.nju.edu.cn,
	git@vger.kernel.org,
	gitster@pobox.com,
	toon@iotcl.com
Subject: [PATCH v5 4/4] bloom: optimize multiple pathspec items in revision traversal
Date: Thu, 10 Jul 2025 16:48:29 +0800
Message-ID: <20250710084829.2171855-5-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0.110.g198a7da17c
In-Reply-To: <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
References: <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
 <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To enable optimize multiple pathspec items in revision traversal,
return 0 if all pathspec item is literal in forbid_bloom_filters().
Add for loops to initialize and check each pathspec item's bloom_keyvec
when optimization is possible.

Add new test cases in t/t4216-log-bloom.sh to ensure
  - consistent results between the optimization for multiple pathspec
    items using bloom filter and the case without bloom filter
    optimization.
  - does not use bloom filter if any pathspec item is not literal.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 revision.c           | 38 ++++++++++++++++++++------------------
 t/t4216-log-bloom.sh | 23 ++++++++++++++---------
 2 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/revision.c b/revision.c
index 22bcfab7f9..f25a61bb6c 100644
--- a/revision.c
+++ b/revision.c
@@ -675,12 +675,11 @@ static int forbid_bloom_filters(struct pathspec *spec)
 {
 	if (spec->has_wildcard)
 		return 1;
-	if (spec->nr > 1)
-		return 1;
 	if (spec->magic & ~PATHSPEC_LITERAL)
 		return 1;
-	if (spec->nr && (spec->items[0].magic & ~PATHSPEC_LITERAL))
-		return 1;
+	for (size_t nr = 0; nr < spec->nr; nr++)
+		if (spec->items[nr].magic & ~PATHSPEC_LITERAL)
+			return 1;
 
 	return 0;
 }
@@ -710,23 +709,26 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	if (!revs->pruning.pathspec.nr)
 		return;
 
-	revs->bloom_keyvecs_nr = 1;
-	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
-	pi = &revs->pruning.pathspec.items[0];
+	revs->bloom_keyvecs_nr = revs->pruning.pathspec.nr;
+	CALLOC_ARRAY(revs->bloom_keyvecs, revs->bloom_keyvecs_nr);
+	for (int i = 0; i < revs->pruning.pathspec.nr; i++) {
+		pi = &revs->pruning.pathspec.items[i];
 
-	/* remove single trailing slash from path, if needed */
-	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
-		path_alloc = xmemdupz(pi->match, pi->len - 1);
-		path = path_alloc;
-	} else
-		path = pi->match;
+		/* remove single trailing slash from path, if needed */
+		if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
+			path_alloc = xmemdupz(pi->match, pi->len - 1);
+			path = path_alloc;
+		} else
+			path = pi->match;
 
-	len = strlen(path);
-	if (!len)
-		goto fail;
+		len = strlen(path);
+		if (!len)
+			goto fail;
 
-	revs->bloom_keyvecs[0] =
-		bloom_keyvec_new(path, len, revs->bloom_filter_settings);
+		revs->bloom_keyvecs[i] =
+			bloom_keyvec_new(path, len, revs->bloom_filter_settings);
+		FREE_AND_NULL(path_alloc);
+	}
 
 	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
 		atexit(trace2_bloom_filter_statistics_atexit);
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 8910d53cac..639868ac56 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -66,8 +66,9 @@ sane_unset GIT_TRACE2_CONFIG_PARAMS
 
 setup () {
 	rm -f "$TRASH_DIRECTORY/trace.perf" &&
-	git -c core.commitGraph=false log --pretty="format:%s" $1 >log_wo_bloom &&
-	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.perf" git -c core.commitGraph=true log --pretty="format:%s" $1 >log_w_bloom
+	eval git -c core.commitGraph=false log --pretty="format:%s" "$1" >log_wo_bloom &&
+	eval "GIT_TRACE2_PERF=\"$TRASH_DIRECTORY/trace.perf\"" \
+		git -c core.commitGraph=true log --pretty="format:%s" "$1" >log_w_bloom
 }
 
 test_bloom_filters_used () {
@@ -138,10 +139,6 @@ test_expect_success 'git log with --walk-reflogs does not use Bloom filters' '
 	test_bloom_filters_not_used "--walk-reflogs -- A"
 '
 
-test_expect_success 'git log -- multiple path specs does not use Bloom filters' '
-	test_bloom_filters_not_used "-- file4 A/file1"
-'
-
 test_expect_success 'git log -- "." pathspec at root does not use Bloom filters' '
 	test_bloom_filters_not_used "-- ."
 '
@@ -151,9 +148,17 @@ test_expect_success 'git log with wildcard that resolves to a single path uses B
 	test_bloom_filters_used "-- *renamed"
 '
 
-test_expect_success 'git log with wildcard that resolves to a multiple paths does not uses Bloom filters' '
-	test_bloom_filters_not_used "-- *" &&
-	test_bloom_filters_not_used "-- file*"
+test_expect_success 'git log with multiple literal paths uses Bloom filter' '
+	test_bloom_filters_used "-- file4 A/file1" &&
+	test_bloom_filters_used "-- *" &&
+	test_bloom_filters_used "-- file*"
+'
+
+test_expect_success 'git log with path contains a wildcard does not use Bloom filter' '
+	test_bloom_filters_not_used "-- file\*" &&
+	test_bloom_filters_not_used "-- A/\* file4" &&
+	test_bloom_filters_not_used "-- file4 A/\*" &&
+	test_bloom_filters_not_used "-- * A/\*"
 '
 
 test_expect_success 'setup - add commit-graph to the chain without Bloom filters' '
-- 
2.50.0.107.g33b6ec8c79

