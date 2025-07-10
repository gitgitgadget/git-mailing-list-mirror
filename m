Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57539272E5E
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155719; cv=none; b=BiG17BhVdno5/iAWnvEK8qfwGadT39JAu908djPGO/Sh6H1zGbIgcOosYwx728uYUnMB1I2yhjUdE6TXdDqYhA47lXchmJ0IGMBsxm8LyKpt2BdbVJVKS1QaL+TehO4UmZXOuo7ARdjWVsINxx1urIJ4DMJ/Cabm5FBNd/FciTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155719; c=relaxed/simple;
	bh=6sYbYwJUPfOGzqvj5kOR48f/PFvik9vBZTxYbYt/+MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bcTAZFKL+49aW4einkYxe9hlaE6zxIemci04fMF4gJP8fWP8fJQXfqEHjAa8HKTSLpSealRT8j5OJEnwbiuQUyc8fORbYA86+GB6fKKXtpSc6gU/ZCosN84je3pMjANd28r7gKqg7PUjHNpUg7AJzRsUctvLL5j+r9oCnsJYbHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrAOOEc0; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrAOOEc0"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70e5d953c0bso11941107b3.1
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 06:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752155716; x=1752760516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aP4UN8XZXrNkgK1WugpRCu1JsgxG/2gFstex0qeBKSg=;
        b=RrAOOEc09T2+2liiowuBJqumntdWu60Y11r3QudRORe2ndeiZu84eLZEvSWq/R4c9v
         BK4FsyDcr/iBAGvLyRwx4YzpOuHUoa21+Be0LeXxDqcN7tKDsSmXL5beqyKY9uzUOB6V
         FMId3wg0WT63vMpUxTNrPep3Ep/x3x6w4ytQL/NOn2/l8CIvQwiKaHUe9OomUtg3FGty
         1Ck33jiWqbFeSKCeMwX+k4F6a9PLi06So35hLdFGq3OFLjiNxjD03m5h9d3zetsxm5ei
         l/jTLerVSz2A9v+QeF23Qsw8v2Z9OEj4pK6dnIK3Oloc8AWsrSTaaQaU9QPqApm2t0Yw
         Q6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752155716; x=1752760516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aP4UN8XZXrNkgK1WugpRCu1JsgxG/2gFstex0qeBKSg=;
        b=J4AbbkYrc8raSaD0c3N5o5LGgJl5CV+WrpBoKykKU/92qg8emTZl0C1v5R+BYskI09
         Tq5pWxdT/9XMP2Mm56YjipcTScR/KyRmQPApOZ+5HCgQEagZpqp9T1M/f0Ffur8jt3Gj
         /FCzkUrUmr8HA2OktPjzgPeeFIVmGowzi7PBFE9DInKXzOsUA/7ChMPAEwrIXo3wCi0w
         e5rWrK1dZ8OPg2XBbtr1Pf1d8PAj60auE0HjhbBsoUOJNs7am3HH1tEfDRBhsQ8Bwxx3
         mG0YVJmMZJD6NfXSpe//jhPW1/jhWn6pma6+E2q5OvPz6ExfGwyD6CJv04zB41dCmRW7
         /FCw==
X-Forwarded-Encrypted: i=1; AJvYcCVk3JkBGJLTqQc06DDGbfDUxhojd5+ejUpl1qRYgcUwX1THkUJ4MDpxhMmpNte7UPFx7x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoQ1yOjmDI5/DDo7+ti+AC6w3SNmDhVOltqZjcYeQdWgrW9kBY
	lv3TTU5lb5rXDuFQZtltmEZpQSv/hmhTzoGpOhJ8TT0LQvQcuE1BLEoKhiWdVukf
X-Gm-Gg: ASbGncvauIqZl8m7cdgAjCn6lOtDS1sBxANcH8YfHOtUeJI72nwY48+vYSvBEMdJ91+
	2SyDxWp+4YM41+feahPZSbfFrsYeKqK58X9GCfFhceAPjEGOG4sxzdFMgzf3z9NLsXyEdpCezvS
	lLVkyqsLQ2q4X63KErJ4nQFMeoZ/MeJ+uOfgegsTobAteV3bYVzk3ordY8tlxaO2+D4mQtMf2T3
	cixdwVU0FulaghJ9C8SUHTyhytWcMysqaZmPa3VrRGBp6DmeG5TBJBUanG322Io4kAdZlqzdsPS
	j/VP3bp7pK/82WWP4GNRzalwNmbU/3Khuj9GOyBvYEL68P6dpzrMzD8ASopx06tkrTC7PkF/hn+
	UQODUAlmG4CBA0ZClijyGj4OO2e0sOIuFwwVDCQ==
X-Google-Smtp-Source: AGHT+IFIAYjWfZHvbmxPgiY+SOhEZixeg0a7QajJDFEHEjzLZITcHs7On5tHE/CMcBh4K4IclR+EEA==
X-Received: by 2002:a05:690c:9a85:b0:70f:83af:7db1 with SMTP id 00721157ae682-717c172e051mr56864947b3.19.1752155716163;
        Thu, 10 Jul 2025 06:55:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:c538:4e9c:cfeb:f6ff? ([2600:1700:60ba:9810:c538:4e9c:cfeb:f6ff])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c5d4f854sm2985637b3.17.2025.07.10.06.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 06:55:15 -0700 (PDT)
Message-ID: <2619038e-05f5-4af8-bb20-e4e01138f839@gmail.com>
Date: Thu, 10 Jul 2025 09:55:15 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5.1 4/4] bloom: optimize multiple pathspec items in revision
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: 502024330056@smail.nju.edu.cn, git@vger.kernel.org, gitster@pobox.com,
 toon@iotcl.com
References: <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
 <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
 <20250710084829.2171855-5-502024330056@smail.nju.edu.cn>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250710084829.2171855-5-502024330056@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/10/2025 4:48 AM, Lidong Yan wrote:
> @@ -710,23 +709,26 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
>  	if (!revs->pruning.pathspec.nr)
>  		return;
>  
> -	revs->bloom_keyvecs_nr = 1;
> -	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
> -	pi = &revs->pruning.pathspec.items[0];
> +	revs->bloom_keyvecs_nr = revs->pruning.pathspec.nr;
> +	CALLOC_ARRAY(revs->bloom_keyvecs, revs->bloom_keyvecs_nr);
> +	for (int i = 0; i < revs->pruning.pathspec.nr; i++) {
> +		pi = &revs->pruning.pathspec.items[i];
>  
> -	/* remove single trailing slash from path, if needed */
> -	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
> -		path_alloc = xmemdupz(pi->match, pi->len - 1);
> -		path = path_alloc;
> -	} else
> -		path = pi->match;
> +		/* remove single trailing slash from path, if needed */
> +		if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
> +			path_alloc = xmemdupz(pi->match, pi->len - 1);
> +			path = path_alloc;
> +		} else
> +			path = pi->match;
>  
> -	len = strlen(path);
> -	if (!len)
> -		goto fail;
> +		len = strlen(path);
> +		if (!len)
> +			goto fail;
>  
> -	revs->bloom_keyvecs[0] =
> -		bloom_keyvec_new(path, len, revs->bloom_filter_settings);
> +		revs->bloom_keyvecs[i] =
> +			bloom_keyvec_new(path, len, revs->bloom_filter_settings);
> +		FREE_AND_NULL(path_alloc);
> +	}

Focus on the change to this diff when the patch below is applied on
top of the 3.5/4 I sent earlier, resulting in this diff:

@@ -733,13 +732,14 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	if (!revs->pruning.pathspec.nr)
 		return;
 
-	revs->bloom_keyvecs_nr = 1;
-	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
-
-	if (convert_pathspec_to_filter(&revs->pruning.pathspec.items[0],
-				       &revs->bloom_keyvecs[0],
-				       revs->bloom_filter_settings))
-		goto fail;
+	revs->bloom_keyvecs_nr = revs->pruning.pathspec.nr;
+	CALLOC_ARRAY(revs->bloom_keyvecs, revs->bloom_keyvecs_nr);
+	for (int i = 0; i < revs->pruning.pathspec.nr; i++) {
+		if (convert_pathspec_to_filter(&revs->pruning.pathspec.items[i],
+					       &revs->bloom_keyvecs[i],
+					       revs->bloom_filter_settings))
+			goto fail;
+	}
 
 	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
 		atexit(trace2_bloom_filter_statistics_atexit);

Also, I've included the hyperfine performance output in the commit
message.

Thanks,
-Stolee


--- >8 ---

From fe255b1acfbe90fa8e4c335435ae18ee95e6243c Mon Sep 17 00:00:00 2001
From: Lidong Yan <502024330056@smail.nju.edu.cn>
Date: Thu, 10 Jul 2025 08:04:34 -0400
Subject: [PATCH v5.1 4/4] bloom: optimize multiple pathspec items in revision
 traversal

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
 revision.c           | 22 +++++++++++-----------
 t/t4216-log-bloom.sh | 23 ++++++++++++++---------
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/revision.c b/revision.c
index 4c09b594c55..ca8c1dde8ca 100644
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
@@ -733,13 +732,14 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	if (!revs->pruning.pathspec.nr)
 		return;
 
-	revs->bloom_keyvecs_nr = 1;
-	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
-
-	if (convert_pathspec_to_filter(&revs->pruning.pathspec.items[0],
-				       &revs->bloom_keyvecs[0],
-				       revs->bloom_filter_settings))
-		goto fail;
+	revs->bloom_keyvecs_nr = revs->pruning.pathspec.nr;
+	CALLOC_ARRAY(revs->bloom_keyvecs, revs->bloom_keyvecs_nr);
+	for (int i = 0; i < revs->pruning.pathspec.nr; i++) {
+		if (convert_pathspec_to_filter(&revs->pruning.pathspec.items[i],
+					       &revs->bloom_keyvecs[i],
+					       revs->bloom_filter_settings))
+			goto fail;
+	}
 
 	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
 		atexit(trace2_bloom_filter_statistics_atexit);
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 8910d53cac1..639868ac562 100755
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
2.47.2.vfs.0.2


