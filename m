Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF80A31F985
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 22:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780438905; cv=none; b=teVivhiQTlrNctS2RHldUHJTunLaZPMUH6T4kM2GVKwoSmzFc8Tv+9F3Drl1HSYQR59AiNcfLQpWIIgEPtKcTttASf6X+U08wW96nPh1PRRdK/BlS2uTWLClXAWjYDFrjzCTAIjsbYMCciDYzMCi5Bl15dS6kKaBS5Drp/Ie6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780438905; c=relaxed/simple;
	bh=m5+JYpTlW6RO28/vVzpB3FniXFwO643VxNshlvC96PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blCkN4JOs8iFSHWTzYS23YpfsKAjZ5U0/TJ5LL1Q4+R/bugpqx1Wsr41HOpLNxzuqvvbs9wBUqjOKw3euYJxKvdAkYVWz374cxXKCMMFzN6WTQ3Hr3m+2C0hOHjFjMKGSHYZnoVMx8tvOLCtUH3kLffZAuTXEVq/qFB/hbFs6mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=UtbH8gSs; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="UtbH8gSs"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7e1916922b9so38884497b3.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 15:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1780438903; x=1781043703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sidx1D0+Roh2zFD8A9tNiQCxOD8EvWoerRE0PvFZ278=;
        b=UtbH8gSsPP0SNiljJfq0V2eLL957TOOw9NHzw5I9DuWSb5BAETd1BQVO+uEYbo8MMR
         oeXce62zV8GwG4NQ505cMJTBl09IbjO7hMqz+Ayaw/1y7L/hrKmWFPCBpxKtE8ggpvOP
         qH1lDzbh1jpNF6DUlTFrYgR0UQxBJKp/tBkLfbmMdj1A+kgs7svDQNl8AwMr7gEAbQN2
         ViYB8ITAK6K/tb9PgUL5X9SJU2c611AdiK5axH04to0AbEisTNQFJdTZMgyMvlwy5DEq
         aCou9oNQxQSl7iCNjTn1iwdp1vkspb/jD2QsFlwouzPTejp5ppqYn0rrfvEZ/bzCuIbO
         O26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780438903; x=1781043703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sidx1D0+Roh2zFD8A9tNiQCxOD8EvWoerRE0PvFZ278=;
        b=dz1jvgk6cigpiebsuTY/NhsrQT4GjipKyPLr/pEUrN/dCltNhgVdDNkms7B9a9qQxi
         6Ea3sqKtBedIIwG2z4N2+FPyeZcBXTTnqjwDxXIEkQ0d7HPm/nEFz3ijvL+DSz8hYNaV
         drfQQu7ZIud+gp1/Hhu57rGOGlSs/4OixmECXpJjtqk9i0l+XU2tMkJcFnEtVaSnR1KE
         3pHXU51LlePjCXgvHYvkQxX+69/W128SaYIE6LohZNQzQT/7pXOUnIqz1OFd9Lu89nbh
         v8jR5hPttv0efgcjx5GF9HpvIh2iW3IyE9QF1GxQ0LDgAwcI7RtavQA3jvmgxfxunImw
         hBMg==
X-Gm-Message-State: AOJu0Yw3UYr1fuIvIK7fy/ANc5AwWy2CnaAG/X9MxwLCX8slBgjTBHkx
	LQXF3uiqIqYHP/x9YMacsKjie1L4IiUsitNUqKC8lPMKwON8Nbcfg1NcFlKPuuGc6WNuMk2geox
	ne1x/pDM=
X-Gm-Gg: Acq92OGOnZg7eorcQf43zr7p+n+0OZ/iMHfQ2Y4N76w8Ozyd/9h4sasNwc6w+DAE8SF
	N5wjk/TfvtxyKbCCOwLUj/mps47W2l09mcNPY6jUAwfZevgXTv4SJDqFZf5eZYziajfzDX+DYr8
	CMspv1cBwYX7jskFH6AYpxGmYptWYikQK2aGVmBwizA4XhHvvZX6iiEmh8KSNtwSFYL3jlsHH2a
	Swiotyhd8TA9xR+CBGf37Or3vtIBZx7B2BHUS+wER67k13+xp3jx9OaeETnVUs7L8cVZSCnsID2
	F4DTR3tElI+LlOiq1pVx3jjIHzA++vDph7Xpue8jDgz4v6hE3Rj9NBTgluIOf7dU4T79eiRcfe5
	i9v8WMEuppaCx+pAzedDROQOLIC9xKe6zaOfUCtRn4uKoVwD76LOq36hYaJffefakH+tw1cMOhe
	MHt76DvnnL4JghsQEiUp0lsYZtbixzVkJlQkunBCeahqdj1HOQLlzfqf90CkxzyYkfvZy5BU4bq
	SVEDsXaU4G0WxPZaYDsDoT/+3HR71Sd39/ho3lY+qzLUmPvsGk6YYWeqolqDkqOGKK3/kpNxt5X
	OOaryYmVNOrgxAVTr0ddEaWj0k0ADxNH/OX2Dg==
X-Received: by 2002:a05:690c:3349:b0:7cf:d8e1:76af with SMTP id 00721157ae682-7ea47dd5626mr9466707b3.16.1780438902692;
        Tue, 02 Jun 2026 15:21:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea23592beasm6386777b3.32.2026.06.02.15.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:21:41 -0700 (PDT)
Date: Tue, 2 Jun 2026 18:21:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/4] pack-objects: support bitmaps and delta-islands with
 `--path-walk`
Message-ID: <cover.1780438896.git.me@ttaylorr.com>
References: <cover.1779923907.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779923907.git.me@ttaylorr.com>

Note to the maintainer:

 * This series is based on 'ds/path-walk-filters' with Patrick's
   'ps/clang-w-glibc-2.43-and-_Generic' merged in. The former has since
   graduated. These are the three remaining patches from my earlier RFC
   after Stolee's series incorporated the filter-related pieces.

Here is a very small reroll of my series to make `--path-walk` work with
reachability bitmaps and delta-islands.

Since the previous round, the only changes are:

 * A new commit making some adjustments to p5311 to facilitate
   performance testing bitmaps in repositories repacked with
   '--path-walk'.

 * Updates to (what is now) the second commit's message, including
   performance results based on the aforementioned changes.

Outside of the above, the series is otherwise unchanged.

Thanks in advance for your review!

Taylor Blau (4):
  t/perf: drop p5311's lookup-table permutation
  pack-objects: support reachability bitmaps with `--path-walk`
  pack-objects: extract `record_tree_depth()` helper
  pack-objects: support `--delta-islands` with `--path-walk`

 Documentation/git-pack-objects.adoc | 12 ++---
 builtin/pack-objects.c              | 68 +++++++++++++++++++++--------
 t/perf/p5311-pack-bitmaps-fetch.sh  | 20 +++++----
 t/t5310-pack-bitmaps.sh             | 36 +++++++++++++++
 t/t5320-delta-islands.sh            | 29 ++++++++++++
 5 files changed, 134 insertions(+), 31 deletions(-)

Range-diff against v1:
-:  ----------- > 1:  52d63e8910e t/perf: drop p5311's lookup-table permutation
1:  3fa8bfbfd59 ! 2:  ffad584a43e pack-objects: support reachability bitmaps with `--path-walk`
    @@ Commit message
            bitmap can answer the request, use it; otherwise fall back to
            path-walk's own enumeration.
     
    +    As a result, we can see significantly reduced pack sizes from p5311
    +    before this commit:
    +
    +        Test                                      HEAD^             HEAD
    +        ----------------------------------------------------------------------------------
    +        5311.38: server (1 days, --path-walk)     2.56(2.52+0.03)   0.01(0.01+0.00) -99.6%
    +        5311.39: size   (1 days, --path-walk)              123.9K            123.9K +0.0%
    +        5311.40: client (1 days, --path-walk)     0.00(0.01+0.00)   0.00(0.00+0.00) =
    +        5311.42: server (2 days, --path-walk)     2.57(2.52+0.05)   0.01(0.01+0.00) -99.6%
    +        5311.43: size   (2 days, --path-walk)              123.9K            123.9K +0.0%
    +        5311.44: client (2 days, --path-walk)     0.00(0.00+0.00)   0.00(0.00+0.00) =
    +        5311.46: server (4 days, --path-walk)     2.58(2.51+0.07)   0.01(0.01+0.00) -99.6%
    +        5311.47: size   (4 days, --path-walk)              123.9K            123.9K +0.0%
    +        5311.48: client (4 days, --path-walk)     0.00(0.00+0.00)   0.00(0.00+0.00) =
    +        5311.50: server (8 days, --path-walk)     2.58(2.53+0.04)   0.02(0.02+0.00) -99.2%
    +        5311.51: size   (8 days, --path-walk)              152.4K            152.4K +0.0%
    +        5311.52: client (8 days, --path-walk)     0.00(0.01+0.00)   0.00(0.01+0.00) =
    +        5311.54: server (16 days, --path-walk)    2.58(2.52+0.05)   0.03(0.02+0.00) -98.8%
    +        5311.55: size   (16 days, --path-walk)             205.3K            205.3K +0.0%
    +        5311.56: client (16 days, --path-walk)    0.01(0.01+0.00)   0.01(0.01+0.00) +0.0%
    +        5311.58: server (32 days, --path-walk)    2.59(2.53+0.06)   0.03(0.03+0.00) -98.8%
    +        5311.59: size   (32 days, --path-walk)             209.3K            209.3K +0.0%
    +        5311.60: client (32 days, --path-walk)    0.01(0.02+0.00)   0.01(0.02+0.00) +0.0%
    +        5311.62: server (64 days, --path-walk)    2.70(2.76+0.06)   0.16(0.24+0.04) -94.1%
    +        5311.63: size   (64 days, --path-walk)               4.1M              4.1M +0.0%
    +        5311.64: client (64 days, --path-walk)    0.44(0.50+0.02)   0.44(0.51+0.02) +0.0%
    +        5311.66: server (128 days, --path-walk)   2.88(3.20+0.05)   0.34(0.65+0.05) -88.2%
    +        5311.67: size   (128 days, --path-walk)              9.0M              9.0M -0.0%
    +        5311.68: client (128 days, --path-walk)   0.93(1.22+0.07)   0.93(1.20+0.08) +0.0%
    +
    +    We get the same size of output pack, but this commit allows us to do so
    +    in a significantly shorter amount of time. Intuitively, we're generating
    +    the same pack (hence the unchanged 'test_size' output from run to run),
    +    but varying how we get there. Before this commit, pack-objects prefers
    +    '--path-walk' to '--use-bitmap-index', so we generate the output pack by
    +    performing a normal '--path-walk' traversal. With this commit, we are
    +    operating over a *repacked* state (that itself was done with a
    +    '--path-walk' traversal), but are able to perform pack-reuse on that
    +    repacked state via bitmaps.
    +
         There is one wrinkle when it comes to '--boundary', which we must not
         pass into the bitmap walk in the presence of both '--path-walk' and
         '--use-bitmap-index'. Path-walk needs boundary commits when it performs
         its own traversal, in order to discover bases for thin packs, but the
    -    bitmap traversal expects the usual non-boundary state. Work around this
    -    by setting `revs->boundary` as late as possible within
    -    `get_object_list_path_walk()`, after any bitmap attempt has either
    -    succeeded or declined to answer the request.
    +    bitmap traversal does not expect this. Work around this by setting
    +    `revs->boundary` as late as possible within the '--path-walk' traversal,
    +    after any bitmap attempt has either succeeded or declined to answer the
    +    request.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
      		use_internal_rev_list = 1;
      		strvec_push(&rp, shallow
     
    + ## t/perf/p5311-pack-bitmaps-fetch.sh ##
    +@@ t/perf/p5311-pack-bitmaps-fetch.sh: test_description='performance of fetches from bitmapped packs'
    + . ./perf-lib.sh
    + 
    + test_fetch_bitmaps () {
    ++	argv=$1
    ++	export argv
    ++
    + 	test_expect_success 'setup test directory' '
    + 		rm -fr * .git
    + 	'
    + 
    + 	test_perf_default_repo
    + 
    +-	test_expect_success 'create bitmapped server repo' '
    ++	test_expect_success "create bitmapped server repo ${argv:+($argv)}" '
    + 		git config pack.writebitmaps true &&
    +-		git repack -ad
    ++		git repack -ad $argv
    + 	'
    + 
    + 	# simulate a fetch from a repository that last fetched N days ago, for
    +@@ t/perf/p5311-pack-bitmaps-fetch.sh: test_fetch_bitmaps () {
    + 	# and assume the first entry in the chain that is N days older than the current
    + 	# HEAD is where the HEAD would have been then.
    + 	for days in 1 2 4 8 16 32 64 128; do
    +-		title=$(printf '%10s' "($days days)")
    ++		title=$(printf '%10s' "($days days${argv:+, $argv})")
    + 		test_expect_success "setup revs from $days days ago" '
    + 			now=$(git log -1 --format=%ct HEAD) &&
    + 			then=$(($now - ($days * 86400))) &&
    +@@ t/perf/p5311-pack-bitmaps-fetch.sh: test_fetch_bitmaps () {
    + 	done
    + }
    + 
    +-test_fetch_bitmaps
    ++for argv in '' --path-walk
    ++do
    ++	test_fetch_bitmaps $argv || return 1
    ++done
    + 
    + test_done
    +
      ## t/t5310-pack-bitmaps.sh ##
     @@ t/t5310-pack-bitmaps.sh: test_bitmap_cases
      
2:  bdae873eaab = 3:  069c50d3370 pack-objects: extract `record_tree_depth()` helper
3:  a642305e3c9 = 4:  ae57607b57f pack-objects: support `--delta-islands` with `--path-walk`

base-commit: 45a9ecee26839cc880fdd5e704339dd3cf4ffc26
-- 
2.54.0.23.gae57607b57f
