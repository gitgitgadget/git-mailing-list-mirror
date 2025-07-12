Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6252749F6
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752312976; cv=none; b=H2y4Xkz55UH5bfdcY5NOayWPe/OD4yuqXdcUrXg6SaJQWSFzHCQjtrt7TEy+EsEnpryOSoXQvYwTcMFHIJ4er5q1UtxSmPiMAV8xNg8AjdCimac5hYOmfpjBHbvVDgNllSszpCC0wUtanYQ4LaCqwUbg3wBxQsEy55AyP6iRLfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752312976; c=relaxed/simple;
	bh=GZMjaUleiWDa9WDDEAMTv8+AxhJOT8SPFUiKH1mmrQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RyanpQFtvYUChm1SBel2YYgh7wJRC/3S3nR1jM1D79alGsSABFLRPX3tfGiCuClOUPzTt6QCxMhNGFINmyBtCX6ungTobRonqQtrhWGfvttc9dW8dZLSf3rtoPDKGjgd/rr2LHu3BdBypvg7cG/CB1ZtA+RQFy2ZvBrpAwyh9GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B24/bEuG; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B24/bEuG"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-75001b1bd76so510729b3a.2
        for <git@vger.kernel.org>; Sat, 12 Jul 2025 02:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752312975; x=1752917775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Li0JkMQ6OFFjFTiFt4UP1f0qi4P22iZIzzZhnE6GHA=;
        b=B24/bEuG7DPgButVGsqAx/lQgQaQ/+AmWcoJP0rTWGNxOwhDyLJ4oLuFmBfM0XPyJR
         Au5JRz4DuUoGuvVphWox9r5cQumhntRtsAsuGMJEfj212SDdLB15eHJhCV/MdAHWpFXx
         xKdloLp+/H0HF6gXU6MW7d8HszkqRzhFTQWJy2ic4+6VDQ443C0+zBs2d13jwgrx2eaR
         o95VtzSJXmwZVziGrgfKkTokS1wXOEbYkFMiKwTjgDJRHdAfveeNx8/bkxNFKukMUa1B
         OwHgyATIEXF9mSiq3kSogfw76NSUnOZZN89NX2Ji/UNNFxCLfJCucBl+TddbQlK+6U9F
         nd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752312975; x=1752917775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Li0JkMQ6OFFjFTiFt4UP1f0qi4P22iZIzzZhnE6GHA=;
        b=KU8mcgDfTTWZjam2iOgFBsfHcCYGVwGjY0lveaMXEc5LHE3ChITOxc0jp6+d8fMPg2
         YWk+5Va2ip2OqXWzglNjgGrG5exR+5efQQwuehCyle6+uJ24IuY5u872E102pmEk2ZIW
         sY4M2Ezcc5mj4lZ9r4B9RiAJ4kN2grZe5T4qMkRHiP76dRmfMdx9LhZNsq8Ndhvcd3Um
         ptyT1smD6bf7o9Mnm35sfeUoGETCAcyh3x+dNlZtMATejoAJ13CMa6xFqFDwuSJpJ1y1
         CYF6ljSwAnXL7qdbWP5mhGkufJV26QrGXCcazB4bh1GaQc+T0tFiGI5xmh2IqehspdS4
         5NFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgZtMUJPgyn8zgzNvwArIqecjprsD2jTU9+BW3wasUhuFQvZ1VeL5SXC56UgGM4Q4WbrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSE3xFRGzic1QXn+GPv1kaydnhz2k5tq/XJMfeduOYZikKD9N+
	aeiDVXitkyamdz4ho8Vz3aJK26JksKqXj+bgXEduHGFrog4Fug82PQMn
X-Gm-Gg: ASbGncvM4psrzW+XsYPNdk6X5QIxxInWp+pbBRy3YRKqRpz95vqRd7E+VoreQNmbrCG
	Om5t4JCJyOMtxvKWEsjcNbRGAhTwox5vQY5wZumUOLKATyfEc2/65/tAmE5I/sAOnrutb8EaAuF
	Z/eqEeAGPHAZfyZHkfIkfiO3X9jaGVHK0TJOkUidHIV7vBGOuX1GqShyLb71/sTlbryMuJf9ao3
	yA0gxSrk3eKrrnG7rmSMxhvgM4s0jW4oK0sLELgtmrc3l/ZiMMkh1Ffnbg2cpITi+IDZ+tJyxsM
	lFon9fvQP88QXiK24sdLKjxXko2cyro3yBa651j8jYT3hOEQpMUzfG41mH+GNHydu95UDAYO0gz
	gHO4GubaSRUfaVJ31jsJ/yeKJMrNWMSKkm7+gO0YwODgOIXh/8AaDZPMo/3QMuxT0oZcwaCHjEs
	7W10UGEYGgyZ0zYIMqloNNHKtoCGxyqg==
X-Google-Smtp-Source: AGHT+IGn8mrM/fYcs5z/ZQyWxztj8wj5WFbxp09mhU+Su1AjvdNPEvVXUirC3S/JWJphLYDcnvgffA==
X-Received: by 2002:a05:6a00:cd3:b0:742:a77b:8c4 with SMTP id d2e1a72fcca58-74ee03a0d9bmr9592289b3a.3.1752312974494;
        Sat, 12 Jul 2025 02:36:14 -0700 (PDT)
Received: from localhost.localdomain (awork062176.netvigator.com. [203.198.28.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b43dsm7126997b3a.79.2025.07.12.02.36.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Jul 2025 02:36:14 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: yldhome2d2@gmail.com
Cc: 502024330056@smail.nju.edu.cn,
	git@vger.kernel.org,
	gitster@pobox.com,
	toon@iotcl.com,
	stolee@gmail.com
Subject: [PATCH v6 5/5] To enable optimize multiple pathspec items in revision traversal, return 0 if all pathspec item is literal in forbid_bloom_filters(). Add for loops to initialize and check each pathspec item's bloom_keyvec when optimization is possible.
Date: Sat, 12 Jul 2025 17:35:17 +0800
Message-Id: <20250712093517.17907-6-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250712093517.17907-1-yldhome2d2@gmail.com>
References: <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
 <20250712093517.17907-1-yldhome2d2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

