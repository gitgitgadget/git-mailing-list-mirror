Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DEF320F
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752313900; cv=none; b=t05GLIc/QxvKEGB0LlPTtvTOkyb7TXVwxdAGE2szI4H1dRzoqesFHJF7gyXv+FWjdOph2W4/wln/IoSdPGmKh/Sf2dQhcUAqb/Ys/7qpFDfTFtYhy1+oZoAYROFerD+ErCiXVNCuCDS14MPOB6ei7441QihsZFcGVmqtdxlTp9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752313900; c=relaxed/simple;
	bh=nY244iA7jXDnYv6LFlxMWzOn4M0ouhxNCUuRsXXAbkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5Qk2RGLx3M7qO4SobchQPP1iJnxix9F/E1IOvU8Bub+XVI8zFemCANdsV7eaKI3vdt7dc1gvZo+AF+R1PDG4cGiTddIqKzflOLetMYTxX5raK6EiKe1G1dXcCydaWmOACamWxx3QgqO367M8XU7BERjq5Xv22ApPuvLGDIKJYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpwXyFYz; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpwXyFYz"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so2645468b3a.0
        for <git@vger.kernel.org>; Sat, 12 Jul 2025 02:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752313898; x=1752918698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOSm2mWMrVu6SiRsbAZ/sp5lSpRwqs4krM39TJfnf8k=;
        b=ZpwXyFYznUY88i+e2U9Ql8ezBRTGvbBoLzUTnVGJp0y9jxZYMCkcboZoIQaMuqefAs
         xLD8m+jOecGDwL0Om4AM4QPJX9668TO5N87a4R8lnflzDmAsVKbQXYJ/t3IkvV75Y427
         Nf7+n5CauHc9QguqEsTg7rYBg0NzAAVujqpacTFImB3KX+sMI2evvznW9bxgipIMU+Iy
         WRZiOoV1TRTxzQhHPqnJOIPSJt1K3yN1lKidmnVX34a5wv2GDuFiED7+w+feVApa/fQs
         1D647DTYpThCDlZNrLXdUTzisJYk1jHKHuEt+AMGsZVgvj4QWKT05SNngGPsla5FTviV
         tVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752313898; x=1752918698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOSm2mWMrVu6SiRsbAZ/sp5lSpRwqs4krM39TJfnf8k=;
        b=DgJ33vmMWdX8dgNgz85e7D1hHlwS93ywIdtZTcB7MXwsNs6HFfEq94MTJCnvgHPYOv
         y3oCPqiuFLg8iUY9Kr/srd7s/Nm0WzyojQIQW8IvWmdMLmjE0OQVITYwnCupxtmgaQov
         tMGQIK5QfkuMqJij0BZh3FUvddwAjzfgDUmtz+2fBhmv5FsvnAJ9dxCdKwTwtovaMVR/
         VC3+1OBrvf96AA7uMdiQF393qPIxIh4BV5emQbr6ChDmqkxmkHzeaUHh/nVoQNibwk5r
         PuiPZbnaBH7nhpR60HBhDwoEIazbgQSS3h48suXX+7DBTjUhRWfvGmtNFWIcilAqMpwd
         ePWQ==
X-Gm-Message-State: AOJu0YyUocu2Et4ZVPQtpLxnbW73g1+wqYD93nfWlQ2kLiEfP1q+3x99
	2HOLZKq/yGFQ4BAg1Se5hJPgOwT6CmuMzFyHTiEgzIxzQJRg7mFIw6MXNtDs0CCC1Tg=
X-Gm-Gg: ASbGnctsYgZeVqfazotZZOHOKb8nkuPtrdWRurxzCqeD+hX67k0tIanSx8LBMaLzAGY
	lVFKpzFsH7SbhAZTQURqzT2ddrUD0XN3ygppAGQy3JFyeG9jJGUWfPz53xOolyUmUdBtwrLSSVP
	lNL/40sPPJustA4SjM/r795Wvlspl5mm5jIQ+X4draglWi5wB9NBTaBpvXbcQMCffAp8bKATyYv
	N8hb/XoIrd+dhZtQ3Mk5oXvnNl1MTPxXbyUuWQZx/ts9rTkcg1+cFAmYaUCyJ5/GQ964byNsT3X
	1W0AjJnGIaRVRvcvwekXwzIUrtDCcEW4uSdigd4Wp7Ieu6Jl4MSUDFSNhr8wMVGuj937E8Odvtg
	IVHzwj0a4avg2yq/FlH9l41BfcZQb72VpD32KLwDIhuAXrx34CzsYat+RE69LYlTCXLWyY42tg2
	yLXYaDZiff4ObeYKRQ6NVQnCBf4hT4ZQ==
X-Google-Smtp-Source: AGHT+IFavYCfM2tl6JxyMTRYxBLIYG0mhpGH+WAjzr9MTz13kidQ2ntOY2XvLVEaAqxjTss5TQ0OYg==
X-Received: by 2002:a05:6a00:b70f:b0:748:e1e4:71ec with SMTP id d2e1a72fcca58-74ee2556e2bmr8146407b3a.12.1752313897570;
        Sat, 12 Jul 2025 02:51:37 -0700 (PDT)
Received: from localhost.localdomain (awork062145.netvigator.com. [203.198.28.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1d507sm7095680b3a.83.2025.07.12.02.51.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Jul 2025 02:51:37 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: yldhome2d2@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	stolee@gmail.com,
	Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: [PATCH v6 5/5] bloom: optimize multiple pathspec items in revision
Date: Sat, 12 Jul 2025 17:51:29 +0800
Message-Id: <20250712095129.24642-1-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <A25E64EE-CABB-498D-8B34-27588B349FAC@gmail.com>
References: <A25E64EE-CABB-498D-8B34-27588B349FAC@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

With these optimizations, we get some improvements for multi-pathspec runs
of 'git log'. First, in the Git repository we see these modest results:

Benchmark 1: old
 Time (mean ± σ):      73.1 ms ±   2.9 ms
 Range (min … max):    69.9 ms …  84.5 ms    42 runs

Benchmark 2: new
 Time (mean ± σ):      55.1 ms ±   2.9 ms
 Range (min … max):    51.1 ms …  61.2 ms    52 runs

Summary
 'new' ran
   1.33 ± 0.09 times faster than 'old'

But in a larger repo, such as the LLVM project repo below, we get even
better results:

Benchmark 1: old
 Time (mean ± σ):      1.974 s ±  0.006 s
 Range (min … max):    1.960 s …  1.983 s    10 runs

Benchmark 2: new
 Time (mean ± σ):     262.9 ms ±   2.4 ms
 Range (min … max):   257.7 ms … 266.2 ms    11 runs

Summary
 'new' ran
   7.51 ± 0.07 times faster than 'old'

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 revision.c           | 21 +++++++++++----------
 t/t4216-log-bloom.sh | 23 ++++++++++++++---------
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/revision.c b/revision.c
index 1614c6ce0d..cf7198c0ea 100644
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
@@ -733,13 +732,15 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	if (!revs->pruning.pathspec.nr)
 		return;
 
-	revs->bloom_keyvecs_nr = 1;
-	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
+	revs->bloom_keyvecs_nr = revs->pruning.pathspec.nr;
+	CALLOC_ARRAY(revs->bloom_keyvecs, revs->bloom_keyvecs_nr);
 
-	if (convert_pathspec_to_bloom_keyvec(&revs->bloom_keyvecs[0],
-					     &revs->pruning.pathspec.items[0],
-					     revs->bloom_filter_settings))
-		goto fail;
+	for (int i = 0; i < revs->pruning.pathspec.nr; i++) {
+		if (convert_pathspec_to_bloom_keyvec(&revs->bloom_keyvecs[i],
+						     &revs->pruning.pathspec.items[i],
+						     revs->bloom_filter_settings))
+			goto fail;
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
2.39.5 (Apple Git-154)

