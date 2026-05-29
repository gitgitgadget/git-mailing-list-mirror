Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C8B3B3883
	for <git@vger.kernel.org>; Fri, 29 May 2026 21:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780090116; cv=none; b=mWZTe+WXBXEhi5WIhnYWVVfBZS89hYCxXCaawKckZNbBd4wRzOTa1Yva7L/PM5enblgM6uWXPxWE8kK8031mf2X/ns01t0RqwOquTXzyqIFbRaihBFf6U1ijC//Ia5SGwWBFWT5LnUkh+mrRewYFyFzFm8M2qtkOsjmCVypx5LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780090116; c=relaxed/simple;
	bh=wx/jHeJUzhyhOg2NsF9EcMOJMQDwtS48RcXWLfLxr48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrKdU1CqsM4ypkhUEFvfm0pUIsWZgl397mwHtGcPAQISf5BkOsFjkx2DI2WKoHivhMDWcZ544gaMSyGSil8W6gkbvemiNm9PnmfNXh/pRdXi7cVzqUiXyFLdR1pEt+eVe5Odpm39DNaXQvLCnNpqy+6G70KCCTAVnlGdUgbvGJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=spNK+dDx; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spNK+dDx"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ccda0ac4fcso21550436d6.2
        for <git@vger.kernel.org>; Fri, 29 May 2026 14:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780090113; x=1780694913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJQlr/81Rg9in99c5Ybu2kNk+iSgZfC1rl2SeZUvXj4=;
        b=spNK+dDx3j01MYnm2HFu+obupnHOTZ/Y4nIxfarVHKXNy+ion8GsB4/JdAcFw+F4Jz
         OvivkWt2o4mxbiiklQcXCqQp7KWdryB0FMn2aIIFIYWk0tEZOYikjwWPZRKQeDleYQNI
         dqkSQ8ZGhDG7CLKKp/pKdPxXek9N4s4mp/9P6LD2IYCGNS0iuUDJRXjXS4nylDSxDh26
         3MOuvJoyd0mvlxT2+StnpvAaPhd8N32IJU79LEOUfOZusY9DPXKUFDNuqFxHmjFSiNKR
         W1g24Cn0KPPaekb8i6BlKF0MjKa3Txv1qG1JX4aM+1UCw3dvkM147mhdYx1rkbn1XUwJ
         kOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780090113; x=1780694913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJQlr/81Rg9in99c5Ybu2kNk+iSgZfC1rl2SeZUvXj4=;
        b=k5okY8WT9Gi610Pv7dXa+4simN/sbPZcYRqP6stZo9lnTss3si3UexX3NblAIUNqkB
         4k6bsj4ZDSEEzLf4UznBp9C47F4Nda/Pwi+W2GzgHzY7pZT2nAokMbIw7Ka+lMMWj7nM
         cq1CLVv/ILpPZO7KzEzO5eFTKNpR/5qT0Q4UcA0z2/1HCa855wwyhEVyo7fQJ8TL0Ebt
         mFyA/DW+Ymko3OUSHurbC7sF4arlxnBYKUac1B6F0JmAl433658bLN1YPym0sP3yd5an
         /Iq0NZzeK3U4Bg0ioUVNpw8C1Ug2n1W0zukgmX4gVG5UbefUbt77pW3twDVQhyxIvzPJ
         t7gA==
X-Gm-Message-State: AOJu0YxevLjEwdlX/rs+U8TO91j/K1pV2ymSO+yW+8uZAuUCiBF5xsOB
	yVBGWp5oK5tA7iDWl9z3BPalsCWhLBG0uEEyXYCJ52Mq05pFqF9zsCVS
X-Gm-Gg: Acq92OG3CNoF3zO6Mf7TwM0Al1HZ9pvByVjS56b1KbQQ+rjHvx7wenOPvnSk1fLWs38
	/GfzVgUI6GJj0oG3UMS1iyxoJJV16H0kf04oX1V2CUsI1R9atj3jgq3btldtYifIXq3QEQ1Om6Q
	QzpMNd+kgok05t/m8n7sBpxG3NKN/YTQsfRuFYQrlTWlYQ/5Ou001zugdgsmaKoJWMGDSFEdxA5
	x6wipJ3l/IINqtuzaalJL9RryaFnrMPTbbrUMw086ZKs+nOv61h8vwYMxjyfBSFt4a96igskucC
	6yX2qYBedVwXYCUK1bmWeA6y4GLKBnWvugCbBbJ7dUdSD7NoPBqkN48xipY8VTE4SOk8ggfBX0b
	0+8VYp/6xDy+woyH2PFWwEBYS0LNF5dr25bXShp7d9ScJ+P/SxMV/MrWX+jI/p38Lj3IsBzMtIr
	SblG2rAT7mbsV3Gt8mhSWDellcFWgegBavfiTEuY7J8BbCgEr9MmefY6o6V4MIaQDfJjHMu6Fdw
	zo+XOr7
X-Received: by 2002:a05:620a:a192:10b0:914:aef6:f972 with SMTP id af79cd13be357-9153d93bb50mr187124085a.12.1780090113375;
        Fri, 29 May 2026 14:28:33 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91532650e85sm306761385a.42.2026.05.29.14.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 14:28:32 -0700 (PDT)
Message-ID: <2d68fdb2-ac05-4331-b53e-53c2e9a2b3d4@gmail.com>
Date: Fri, 29 May 2026 17:28:32 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] pack-objects: support bitmaps and delta-islands with
 `--path-walk`
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
References: <cover.1779923907.git.me@ttaylorr.com>
 <a708e23d-e0c2-48c9-86e9-1227f12edd53@gmail.com>
 <22a7e32f-f645-4f00-bc5b-6b4309e483c2@gmail.com>
 <ahnx/oBWe9yyBZFg@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ahnx/oBWe9yyBZFg@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/29/2026 4:07 PM, Taylor Blau wrote:
> On Fri, May 29, 2026 at 01:26:33PM -0400, Derrick Stolee wrote:
>> On 5/28/26 11:28 AM, Derrick Stolee wrote:
>>> On 5/27/26 7:18 PM, Taylor Blau wrote:
>>
>>> Do you have any end-to-end performance data to demonstrate that these
>>> changes are effective at scale? Are we still producing packfiles with the
>>> pack-file compression and now with .bitmap files? How does this impact
>>> the performance of a clone or fetch when using a bitmap index at read
>>> time?
>>
>> Here's my attempt to use our existing performance tests to analyze the
>> impact of this series.
>>
>> Running p5311 against the base of this topic and this topic with
>> GIT_TEST_PACK_PATH_WALK=1, I get this output:
> 
> Yikes. That's not great, but see below for what I think is going on.
> 
> (As an aside, we can focus in on either lookup=true or lookup=false,
> since these are just controlling whether or not the bitmap lookup table
> is written. On a repository as small as git.git, this shouldn't make a
> huge difference either way. I have a separate series to make this the
> default and to clean up the t/perf suite accordingly, but haven't sent
> it to the list yet.)
> 
>> Test                                     HEAD~3    HEAD
>> -----------------------------------------------------------------
>> [...]
> 
> I think this is either the primary reason why you're not seeing an
> improvement here, or at least related to it...
> 
>> Do you have a good feeling for why the path-walk feature doesn't
>> make a huge change in these test scenarios?
> 
> I think the problem is that we're relying on the TEST_ variable to tell
> pack-objects to generate a pack using --path-walk, but treat it as a
> fallback.
> 
> I suspect that since p5311 invokes repack *without* the '--path-walk'
> option, we end up in this case within cmd_pack_objects():
> 
> 	if (path_walk < 0) {
> 		if (use_bitmap_index > 0 ||
> 		    !use_internal_rev_list)
> 			path_walk = 0;
> 		else if (the_repository->gitdir &&
> 			 the_repository->settings.pack_use_path_walk)
> 			path_walk = 1;
> 		else
> 			path_walk = git_env_bool("GIT_TEST_PACK_PATH_WALK", 0);
> 	}
> 
> , where `path_walk` is *not* set, but `use_bitmap_index` is since p5311
> set the 'pack.writeBitmaps' configuration (as a separate aside, this
> should really prefer the non-deprecated 'repack.writeBitmaps' variant).
I see. When `--use-bitmap-index` is specified, then the test variable is
ignored. So my tests aren't actually measuring the intended end state.

> So in that case, we fall back to `path_walk = 0`, and don't even bother
> reading the `GIT_TEST_PACK_PATH_WALK` variable.
> 
> If I modify the perf test like so:
> 
> --- 8< ---
> diff --git a/t/perf/p5311-pack-bitmaps-fetch.sh b/t/perf/p5311-pack-bitmaps-fetch.sh
> index 047efb995d6..1c9c99216e3 100755
> --- a/t/perf/p5311-pack-bitmaps-fetch.sh
> +++ b/t/perf/p5311-pack-bitmaps-fetch.sh
> @@ -13,7 +13,7 @@ test_fetch_bitmaps () {
>  	test_expect_success 'create bitmapped server repo' '
>  		git config pack.writebitmaps true &&
>  		git config pack.writeBitmapLookupTable '"$1"' &&
> -		git repack -ad
> +		git repack -ad --path-walk
>  	'
> 
>  	# simulate a fetch from a repository that last fetched N days ago, for
> --- >8 ---
> , then I can get significantly improved results when running without the
> GIT_TEST_PACK_PATH_WALK variablle (here I'm truncating the
> 'lookup=false' case, which performs nearly identically):
> 
>     Test                                       HEAD~3            HEAD
>     ------------------------------------------------------------------------------------
>     5311.4: server   (1 days) (lookup=true)    2.57(2.52+0.04)   0.03(0.02+0.00) -98.8%
>     5311.5: size     (1 days)                           153.4K            153.4K +0.0%
>     5311.6: client   (1 days) (lookup=true)    0.00(0.01+0.00)   0.00(0.01+0.00) =
>     5311.8: server   (2 days) (lookup=true)    2.60(2.55+0.04)   0.02(0.02+0.00) -99.2%
>     5311.9: size     (2 days)                           153.4K            153.4K +0.0%
>     5311.10: client   (2 days) (lookup=true)   0.00(0.01+0.00)   0.00(0.01+0.00) =
>     5311.12: server   (4 days) (lookup=true)   2.60(2.54+0.05)   0.03(0.03+0.00) -98.8%
>     5311.13: size     (4 days)                          209.0K            209.0K +0.0%
>     5311.14: client   (4 days) (lookup=true)   0.01(0.02+0.00)   0.01(0.01+0.00) +0.0%
>     5311.16: server   (8 days) (lookup=true)   2.58(2.53+0.04)   0.03(0.03+0.00) -98.8%
>     5311.17: size     (8 days)                          209.0K            209.0K +0.0%
>     5311.18: client   (8 days) (lookup=true)   0.01(0.01+0.00)   0.01(0.02+0.00) +0.0%
>     5311.20: server  (16 days) (lookup=true)   2.58(2.52+0.05)   0.03(0.03+0.00) -98.8%
>     5311.21: size    (16 days)                          209.0K            209.0K +0.0%
>     5311.22: client  (16 days) (lookup=true)   0.01(0.02+0.00)   0.01(0.01+0.00) +0.0%
>     5311.24: server  (32 days) (lookup=true)   2.61(2.58+0.03)   0.03(0.02+0.01) -98.9%
>     5311.25: size    (32 days)                          212.9K            212.9K +0.0%
>     5311.26: client  (32 days) (lookup=true)   0.01(0.02+0.00)   0.02(0.02+0.00) +100.0%
>     5311.28: server  (64 days) (lookup=true)   2.72(2.79+0.06)   0.19(0.30+0.03) -93.0%
>     5311.29: size    (64 days)                            4.5M              4.5M -0.0%
>     5311.30: client  (64 days) (lookup=true)   0.49(0.58+0.02)   0.48(0.56+0.04) -2.0%
>     5311.32: server (128 days) (lookup=true)   2.90(3.21+0.09)   0.35(0.70+0.04) -87.9%
>     5311.33: size   (128 days)                            9.4M              9.5M +0.4%
>     5311.34: client (128 days) (lookup=true)   0.98(1.27+0.08)   0.98(1.33+0.06) +0.0%
> 
> My reading here is that we get significantly smaller packs (i.e. all
> 'test_size' tests drop from HEAD~3 to HEAD) in the same amount of time
> (i.e. that all 'test_perf' tests are roughly flat).

The sizes don't shrink, and in one case increases by a small amount. I'm
happy to count those cases as noise from multi-threaded delta calculations
being less deterministic.

The _time_ taken to compute the packfiles is what decreases, though, which
is promising.

> That lines up with my expectation here, which is that even though we're
> using bitmaps at read time, that's effectively seeding the verbatim pack
> reuse over a significantly smaller pack, producing a much smaller output
> pack as a result.

Can you double-check this reasoning with my read of the data? The size
isn't changing, but the computation time is.

> As to whether we should modify the perf suite to test this, naturally I
> think we should. Likely that looks like modifying p5313 to re-run
> `test_all_with_args` with '--use-bitmap-index' after repacking with
> --path-walk and generating bitmaps like so (untested):
> 
> --- 8< ---
> diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
> index 46a6cd32d24..663717982b1 100755
> --- a/t/perf/p5313-pack-objects.sh
> +++ b/t/perf/p5313-pack-objects.sh
> @@ -22,6 +22,21 @@ test_expect_success 'create rev input' '
>  	EOF
>  '
> 
> +test_repack_with_args () {
> +	args="$@"
> +	export args
> +
> +	test_perf "repack with $args" '
> +		git repack -adf $args
> +	'
> +
> +	test_size "repack size with $args" '
> +		gitdir=$(git rev-parse --git-dir) &&
> +		pack=$(ls $gitdir/objects/pack/pack-*.pack) &&
> +		test_file_size "$pack"
> +	'
> +}
> +
I see that these tests are extracted from test_all_... below:

>  test_all_with_args () {
>  	parameter=$1
>  	export parameter
> @@ -52,23 +67,22 @@ test_all_with_args () {
>  	test_size "shallow pack size with $parameter" '
>  		test_file_size out
>  	'
> -
> -	test_perf "repack with $parameter" '
> -		git repack -adf $parameter
> -	'
> -
> -	test_size "repack size with $parameter" '
> -		gitdir=$(git rev-parse --git-dir) &&
> -		pack=$(ls $gitdir/objects/pack/pack-*.pack) &&
> -		test_file_size "$pack"
> -	'
>  }

Because the --use-bitmap-index and --write-bitmap-index args
aren't appropriate across these different commands.

nit: the diff would be more obvious if test_repack_with_args
was defined after test_all_with_args so the hunk of existing
tests wouldn't appear in the diff.

>  for version in 1 2
>  do
> -	test_all_with_args --name-hash-version=$version
> +	arg="--name-hash-version=$version" &&
> +
> +	test_all_with_args "$arg" &&
> +	test_repack_with_args "$arg" || return 1
>  done
> 
>  test_all_with_args --path-walk
> +test_repack_with_args --path-walk
> +
> +# inverted order here: we want to test using reachability bitmaps on a
> +# pack written with --path-walk
> +test_repack_with_args --path-walk --write-bitmap-index
> +test_all_with_args --use-bitmap-index

So this allows us to test all of the different modes.

> --- >8 ---
> 
> I don't have a strong opinion on whether or not we should include that
> in this series or elsewhere.
I'm interested to see some results of your new p5313 test
to make sure that we are getting expected size changes for
the repack, since the p5311 tests were more focused on the
thin fetch pack (and didn't show a change in size).

For that, I'd be interested to see this test be included in
a patch for future reference, too.

Thanks,
-Stolee

