Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB14732C85
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752312945; cv=none; b=AgbFQL4IJhE2ib7KNTGGAWkOPAy5u56d8KPdsQ94kMZADpVqYmfQx6H0U2ApDDSu1UfNq4scM95R8A6fjnO5vd0Q5ccr6UpM8daciabu0oA3EtkEwPhpWsASJsQBbMPRwA/Gd33O8kbve7rt0jCWYv8UaDLC28TuPOWqv24q4bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752312945; c=relaxed/simple;
	bh=KqVCMNEVhYFuCUZsnPpAoA9hNTOCTtAI//Zr/w4N834=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rx3qDw5ftpQGGEeL74oU3Qm1TECpAuDLXH73hlpA0DWEKnZXWvAEnXghkFhHyAU15gde2dC3981qKkO1CvbpnnICk/22oZ1NvYVZAQLSjW+8DcJii1VcR39nT1QgHEUVpqmlA8K014dwkjwgv7dLPkNbK4z752KMpB/5HIHsvB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUs/zOnV; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUs/zOnV"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-73972a54919so2640690b3a.3
        for <git@vger.kernel.org>; Sat, 12 Jul 2025 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752312943; x=1752917743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9G6lZw7A5/aW2/cJqsM+sWgC+zuSEi+RiNitQ5PTak=;
        b=SUs/zOnV/1uNoXMSFBEIsAiGu40TjT0MQEVx+TePDU8OgfnQMX2ZVf1y6nfFjFLsPk
         vsPapnwZLuW/igPjoKmER167RjGU3Cgyxyx7nvhKIuzN/CvgvDfRdIkmp5jn/ZhroCrw
         AkQi41gTd1Vh/TuTC4cJgS+opnV8mMzWWUoYc6Qwo6ieH4G5x3pFSr1pUsHUiAX6xkNk
         1OOn7i3Qa10W2zMDDiZ41B5DyAmdnKsR1AzEIfMmd3HB8XPyGCmAEFrpsnY2CvFkoDIh
         1sQRswAlELykRDpL1bg2a+eOO2BtW7z4B1pW622YWwpLi7mmYN3PLUHB2B26u+Du0o7J
         n3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752312943; x=1752917743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9G6lZw7A5/aW2/cJqsM+sWgC+zuSEi+RiNitQ5PTak=;
        b=Apk35BG7TZsT7xQcPYma0BSOLd9bQNBWobdDiVDyhu0p2e+xghiZ9hwpZD6z5kHDBw
         GGTwVQ8OZMaPRQKNjD1INgeSgatr89GY5nW7VItZBjmBs+kdM/+YALn6gnyaaGwuzzp2
         AYZNZJacLr2OAuJs79hJ5OeJuRtixoZfAOxdmZZByuvWK0cnO45EbXCxDg4ebtmgCvM7
         sC7uciURPr4b4p/Czc0oHBRgx2diaAUDjRMMie1RPpPy3bIphl6u6OpISwtKOJ5keRfC
         n2LHTuWt9SGi4tvyKDjag3Lc9piHb6yWHuABi1A+hQ+DuO7miNwUVXMGpiXfhu8CN2VN
         ixIg==
X-Forwarded-Encrypted: i=1; AJvYcCVnONpUndC7aioEIp7EvfGv6X35/NOElhKAGCa49SfGQRzhvefpiGcLNNEyIYo3SpU7Zuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgO+DrwZXIQCn/KbgtaicdVKG0jFfw7ZJ0iFZOWDNPpdOAcGvZ
	M5rAsy7MUs9QoNB4t54izWBhUCCsSwtg19Y2ezM2FDR/iLCKyC4su+L1JXbUfDbMxoo=
X-Gm-Gg: ASbGncvQKagiVzd1+cVuZynoAj4RjJPfL1SERvdrcz8lFcfPpaC9tHa3qpdYOp1rnLB
	xiAq29y1bNh2WzwkX9FvydzPWQN/Q+5i2zd6/POp6Bz2jX5mR4HVjas/WHvaUVjFkr+vVrGc02K
	FJBA6AYR7MivTX4fc85CjcpTPF/GgsT9JK4/mDXmp7XqSv62yn7qMYeMzgnXCA6JU0V2fZPfSmD
	XMYwPn5q13RoRcQ7+ZC2aYZu8b3TyBPyfdRZ19O6OBRrnctuW5lpu6NY+S+XTpbCJtyprGMCm8x
	liFrIxANR8obYEuCi+uFk50RET6Gqmww5GGxzpPoOAYA4INDlMYRv4cVvDSU29oIMsaDTXxV6qs
	O+DdJev2vIn8tYZh+mD2EDUf16yLBNp7y+txhxHkuAgQdFcY4haDIgd4WpGQVHOYmWi8KMNb5Kf
	/xzA4sGmTIRxI+WuywBTJoAxLoe/OpsA==
X-Google-Smtp-Source: AGHT+IEtZtRzhw3+hSSG0WG9S9QCKN9z/a3Y/SgISPwYuK9qyJiOslG3olkZ/hgByljvLeCaIA42EQ==
X-Received: by 2002:a05:6a21:3287:b0:21f:563e:b7e8 with SMTP id adf61e73a8af0-23134a69a39mr8341478637.4.1752312942897;
        Sat, 12 Jul 2025 02:35:42 -0700 (PDT)
Received: from localhost.localdomain (awork062176.netvigator.com. [203.198.28.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b43dsm7126997b3a.79.2025.07.12.02.35.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Jul 2025 02:35:42 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: yldhome2d2@gmail.com
Cc: 502024330056@smail.nju.edu.cn,
	git@vger.kernel.org,
	gitster@pobox.com,
	toon@iotcl.com,
	stolee@gmail.com
Subject: [PATCH v6 0/5] bloom: enable bloom filter optimization for multiple pathspec elements in revision traversal
Date: Sat, 12 Jul 2025 17:35:12 +0800
Message-Id: <20250712093517.17907-1-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
References: <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The revision traversal limited by pathspec has optimization when
the pathspec has only one element, it does not use any pathspec
magic (other than literal), and there is no wildcard. The absence
of optimization for multiple pathspec elements in revision traversal
cause an issue raised by Kai Koponen at
  https://lore.kernel.org/git/CADYQcGqaMC=4jgbmnF9Q11oC11jfrqyvH8EuiRRHytpMXd4wYA@mail.gmail.com/

While it is much harder to lift the latter two limitations,
supporting a pathspec with multiple elements is relatively easy.
Just make sure we hash each of them separately and ask the bloom
filter about them, and if we see none of them can possibly be
affected by the commit, we can skip without tree comparison.

The difference from v5 is:
  - extract convert pathspec item to bloom_keyvec logic to
    a separate function, which simplifies the prepare_to_use_bloom_filter()
    function.
  - fix few bugs in v5.

Below is a comparison of the time taken to run git log on Git and
LLVM repositories before and after applying this patch. These statistics
are given by Derrick Stolee at
  https://lore.kernel.org/git/afb68948-218b-4b56-9faa-29578ef9c73c@gmail.com/

Setup commit-graph:
  $ cd ~/src/git && git commit-graph write --split --reachable --changed-paths
  $ cd ~/src/llvm && git commit-graph write --split --reachable --changed-paths

Running hyperfine [1] on Git repository:

  $ hyperfine --warmup=3 \
  > -n 'old' '~/_git/git-sparse-checkout-clean/git log -100 -- commit.c commit-graph.c' \
  > -n 'new' '~/_git/git/git log -100 -- commit.c commit-graph.c'

Benchmark 1: old
  Time (mean ± σ):      73.1 ms ±   2.9 ms    [User: 48.8 ms, System: 23.9 ms]
  Range (min … max):    69.9 ms …  84.5 ms    42 runs

Benchmark 2: new
  Time (mean ± σ):      55.1 ms ±   2.9 ms    [User: 30.5 ms, System: 24.4 ms]
  Range (min … max):    51.1 ms …  61.2 ms    52 runs

Summary
  'new' ran
    1.33 ± 0.09 times faster than 'old'

And for LLVM:

  $ hyperfine --warmup=3 \
  > -n 'old' '~/_git/git-sparse-checkout-clean/git log -100 -- llvm/lib/Support/CommandLine.cpp llvm/lib/Support/CommandLine.h' \
  > -n 'new' '~/_git/git/git log -100 -- llvm/lib/Support/CommandLine.cpp llvm/lib/Support/CommandLine.h'

Benchmark 1: old
  Time (mean ± σ):      1.974 s ±  0.006 s    [User: 1.877 s, System: 0.097 s]
  Range (min … max):    1.960 s …  1.983 s    10 runs

Benchmark 2: new
  Time (mean ± σ):     262.9 ms ±   2.4 ms    [User: 214.2 ms, System: 48.4 ms]
  Range (min … max):   257.7 ms … 266.2 ms    11 runs

Summary
  'new' ran
    7.51 ± 0.07 times faster than 'old'

[1] https://github.com/sharkdp/hyperfine

Lidong Yan (5):
  bloom: add test helper to return murmur3 hash
  bloom: rename function operates on bloom_key
  bloom: replace struct bloom_key * with struct bloom_keyvec
  revision: make helper for pathspec to bloom keyvec
  To enable optimize multiple pathspec items in revision traversal,
    return 0 if all pathspec item is literal in forbid_bloom_filters().
    Add for loops to initialize and check each pathspec item's
    bloom_keyvec when optimization is possible.

 blame.c               |   2 +-
 bloom.c               |  84 ++++++++++++++++++++++++++---
 bloom.h               |  54 ++++++++++++++-----
 line-log.c            |   5 +-
 revision.c            | 122 +++++++++++++++++++++---------------------
 revision.h            |   6 +--
 t/helper/test-bloom.c |   8 +--
 t/t4216-log-bloom.sh  |  23 ++++----
 8 files changed, 204 insertions(+), 100 deletions(-)

Range-diff against v5:
1:  4d8f60e5ff = 1:  f5ab19063d bloom: add test helper to return murmur3 hash
2:  acee03e397 = 2:  51a180daa6 bloom: rename function operates on bloom_key
3:  d7690bd02c ! 3:  e17249ab4b bloom: replace struct bloom_key * with struct bloom_keyvec
    @@ bloom.h: void bloom_key_fill(struct bloom_key *key, const char *data, size_t len
      void bloom_key_clear(struct bloom_key *key);
      
     +/*
    -+ * bloom_keyvec_fill - Allocate and populate a bloom_keyvec with keys for the
    ++ * bloom_keyvec_new - Allocate and populate a bloom_keyvec with keys for the
     + * given path.
     + *
     + * This function splits the input path by '/' and generates a bloom key for each
    @@ revision.c: static int forbid_bloom_filters(struct pathspec *spec)
      static void prepare_to_use_bloom_filter(struct rev_info *revs)
      {
      	struct pathspec_item *pi;
    -+	struct bloom_keyvec *bloom_keyvec;
      	char *path_alloc = NULL;
    - 	const char *path, *p;
    +-	const char *path, *p;
    ++	const char *path;
      	size_t len;
     -	int path_component_nr = 1;
      
-:  ---------- > 4:  b3c1f5bcd1 revision: make helper for pathspec to bloom keyvec
4:  e577aa1bfd ! 5:  785bd43674 bloom: optimize multiple pathspec items in revision traversal
    @@ Metadata
     Author: Lidong Yan <yldhome2d2@gmail.com>
     
      ## Commit message ##
    -    bloom: optimize multiple pathspec items in revision traversal
    -
         To enable optimize multiple pathspec items in revision traversal,
         return 0 if all pathspec item is literal in forbid_bloom_filters().
         Add for loops to initialize and check each pathspec item's bloom_keyvec
         when optimization is possible.
     
         Add new test cases in t/t4216-log-bloom.sh to ensure
    -      - consistent results between the optimization for multiple pathspec
    -        items using bloom filter and the case without bloom filter
    -        optimization.
    -      - does not use bloom filter if any pathspec item is not literal.
    +     - consistent results between the optimization for multiple pathspec
    +       items using bloom filter and the case without bloom filter
    +       optimization.
    +     - does not use bloom filter if any pathspec item is not literal.
    +
    +    With these optimizations, we get some improvements for multi-pathspec runs
    +    of 'git log'. First, in the Git repository we see these modest results:
    +
    +    Benchmark 1: old
    +     Time (mean ± σ):      73.1 ms ±   2.9 ms
    +     Range (min … max):    69.9 ms …  84.5 ms    42 runs
    +
    +    Benchmark 2: new
    +     Time (mean ± σ):      55.1 ms ±   2.9 ms
    +     Range (min … max):    51.1 ms …  61.2 ms    52 runs
    +
    +    Summary
    +     'new' ran
    +       1.33 ± 0.09 times faster than 'old'
    +
    +    But in a larger repo, such as the LLVM project repo below, we get even
    +    better results:
    +
    +    Benchmark 1: old
    +     Time (mean ± σ):      1.974 s ±  0.006 s
    +     Range (min … max):    1.960 s …  1.983 s    10 runs
    +
    +    Benchmark 2: new
    +     Time (mean ± σ):     262.9 ms ±   2.4 ms
    +     Range (min … max):   257.7 ms … 266.2 ms    11 runs
    +
    +    Summary
    +     'new' ran
    +       7.51 ± 0.07 times faster than 'old'
     
         Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
    +    Signed-off-by: Derrick Stolee <stolee@gmail.com>
     
      ## revision.c ##
     @@ revision.c: static int forbid_bloom_filters(struct pathspec *spec)
    @@ revision.c: static void prepare_to_use_bloom_filter(struct rev_info *revs)
      
     -	revs->bloom_keyvecs_nr = 1;
     -	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
    --	pi = &revs->pruning.pathspec.items[0];
     +	revs->bloom_keyvecs_nr = revs->pruning.pathspec.nr;
     +	CALLOC_ARRAY(revs->bloom_keyvecs, revs->bloom_keyvecs_nr);
    -+	for (int i = 0; i < revs->pruning.pathspec.nr; i++) {
    -+		pi = &revs->pruning.pathspec.items[i];
      
    --	/* remove single trailing slash from path, if needed */
    --	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
    --		path_alloc = xmemdupz(pi->match, pi->len - 1);
    --		path = path_alloc;
    --	} else
    --		path = pi->match;
    -+		/* remove single trailing slash from path, if needed */
    -+		if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
    -+			path_alloc = xmemdupz(pi->match, pi->len - 1);
    -+			path = path_alloc;
    -+		} else
    -+			path = pi->match;
    - 
    --	len = strlen(path);
    --	if (!len)
    +-	if (convert_pathspec_to_bloom_keyvec(&revs->bloom_keyvecs[0],
    +-					     &revs->pruning.pathspec.items[0],
    +-					     revs->bloom_filter_settings))
     -		goto fail;
    -+		len = strlen(path);
    -+		if (!len)
    ++	for (int i = 0; i < revs->pruning.pathspec.nr; i++) {
    ++		if (convert_pathspec_to_bloom_keyvec(&revs->bloom_keyvecs[i],
    ++						     &revs->pruning.pathspec.items[i],
    ++						     revs->bloom_filter_settings))
     +			goto fail;
    - 
    --	revs->bloom_keyvecs[0] =
    --		bloom_keyvec_new(path, len, revs->bloom_filter_settings);
    -+		revs->bloom_keyvecs[i] =
    -+			bloom_keyvec_new(path, len, revs->bloom_filter_settings);
    -+		FREE_AND_NULL(path_alloc);
     +	}
      
      	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
-- 
2.39.5 (Apple Git-154)

