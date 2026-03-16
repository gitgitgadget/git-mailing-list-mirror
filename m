Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50B0332ED3
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679863; cv=none; b=cKTTZGvHjInCqgHthsyrI37PXmGnmBXs3EZw62Hj/IR/DjAmzjeXkD8Sfn5LLXz55RZFf97NKv34gvlyXLCdHsjT0lXoPMtblVAgJHOEzkM2pGOq3DpE6BzFIIxdXKVQ6aVQO+T6vzppo0U9M0alLWlUgoua928okId4RWeQv8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679863; c=relaxed/simple;
	bh=wKwxzun8NeiCBSRKLGkbaah+oLGp8f7yMAXMjxPn4zM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HX81z0Ci/Id/Ox4Yo5EMgq5aW0zV+0mL0ZJKaDgDpuL7iXSrcYYoebdAvBxCBUWP9h08plbedEowiK8Dsjfzud8MAuzr4vioWR7YYrYtx8y/qJH/GVD19PPRk9f2/3Esrbbn9urcC+r4iCb9CWQfZoHhIlZm1LkRpzJMfx6KMiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bdQnJItK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yTIH0GGT; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bdQnJItK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yTIH0GGT"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EEE731400219;
	Mon, 16 Mar 2026 12:51:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 16 Mar 2026 12:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773679860; x=1773766260; bh=yLbK+NrZDb
	twBTohn+BC+v+ILY/ULpA4+9kLmNKD1kQ=; b=bdQnJItKF7AgsoG5Y4SXzKmiXK
	xIFZbJhQXg+EgkQYQfcOX8Lq0siis7AXbLg2twsSGNd27KX9INsV9GBV432HXBNA
	Kjrl+4yoJOjiV94AmZtAvW2CUEjNXSNsfr+NXpE1KQ0wE1LlrElmkYVhGi4Rixzs
	nOfCdy/lfacfg3mT4qWGzudgdDgP8ppBVZjQog+PRkCnuFM73trSfqvDERbp+c6p
	MAHwleNBKOALtaWy/VREIO5WW5GUcsS35zdH1VqdVag3PZlP3q/nOr9Z6lj+NYEk
	xTtqHN/0ZJ9rfUsYys4g4wlVZDeYmgMgghzviBod9p3C7yiZWRTvKK16F41A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773679860; x=1773766260; bh=yLbK+NrZDbtwBTohn+BC+v+ILY/ULpA4+9k
	LmNKD1kQ=; b=yTIH0GGTzyD+qsrppSA2fhdQJTrjbUa+22OUVJMLe152KrGRyJ7
	PcT7XKeeeLnCV6v8ajBpRu7ZIeILt4oSwpVQXKAP7LYaaDT6kxb9uOeEbEGx97FL
	cSPZshT80+Y3ZWL57g6b3sK8E4wldFSrhLT4G/wvegyprz+9wNP6XjgqHJAae+If
	Bbekk9hD/0p5gwLka4KgZpUVJDVdFPJDLV8aNpV+xsRT3+3iHEvX1Ty/pw8VufJO
	O2+Up+2kfZELPmBVxcLIwA63zqQeSfIFexeCIbCtbvrzcZZedCLnOv2i9ow0hoAY
	SAV9G8FjV1rU3hJJSK51K5xnme2DoKC5HYg==
X-ME-Sender: <xms:9DS4aaXbJWrlt7HXwfEAgVCQsE4re1yd6aR_NLdNC0WeD_R3ullVbg>
    <xme:9DS4aeC6YnmO409wJIPxKPpvTf7461I8hk0RfbRkpTxPTN1LcsJdqWfjVwJGdPe9C
    07wL288oUf_bci-mqLBPHf2e49rlbSrh7BBOg0NffVynh-xinU4W20>
X-ME-Received: <xmr:9DS4abzZ7B2xhk_7P03s18xq7c-0IsP63628NVP-3-Ou3YGKvnWefAR8qkjevJbafJqDb4fLElOMEFxYYJpq1ynyGGBfltZxWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhff
    eggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprhgrshhh
    rghnthhjvggvvddtvdehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:9DS4abAgkjMTM92NaS-TmZlOu5I9W3zNV21Q3_bXuFwalbInYlgkuQ>
    <xmx:9DS4aYaGN2vTlXZf5Jfj3EZWFSYiK4mvq_udt-b6Uy-5t-0S3m756w>
    <xmx:9DS4aTgsmsvftmND_5ds5mhRr6ap8TkBTnG1ttvhzmtRLbb4nOWbIw>
    <xmx:9DS4aa4t0vUoN2WjUyuIreZuScC8e02ZxfwATJopj8QpKi3ZZfKF9Q>
    <xmx:9DS4aSC9UpXJdzS2eVrf63_sIT7QmfXYvd4g7HPSEfBaaZ0p9sQ-dAGV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 12:51:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: PRASHANT S BISHT <prashantjee2025@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] t4200-rerere: use test_path helpers
In-Reply-To: <20260316070812.84760-1-prashantjee2025@gmail.com> (PRASHANT
	S. BISHT's message of "Mon, 16 Mar 2026 12:38:12 +0530")
References: <20260316070812.84760-1-prashantjee2025@gmail.com>
Date: Mon, 16 Mar 2026 09:50:59 -0700
Message-ID: <xmqqqzpjpvkc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

PRASHANT S BISHT <prashantjee2025@gmail.com> writes:

> Convert assertion-style test -[df] checks in t4200-rerere.sh to test_path_* helpers.
>
> Instances were found with:
>
> 	git grep 'test -[def]' t/t4200-rerere.sh

People seem to add the above to their test-path helper patches, but
unless the coverage of the work is fairly thorough and you want to
say "all the similar issues should be found with this command and I
addressed all of them", I do not see much point saying how you found
one of them and addressed it.

You could have used "git grep -e <pattern> -- t/\*.sh", or you could
have been working to fix something in t9200 and noticed these while
you were doing something else to the file.

I do not see it as too huge a deal and it is probably not a cause to
send in another iteration once it is already written, though.

>
> ---

But the lack of sign-off is reason enough to require an update.  

For an "introduction to the project" patch, the change itself is not
as important or interesting than demonstrating that you studied
CodingGuidelines and SubmittingPatches well.


>  t/t4200-rerere.sh | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> index 204325f4d5..1717f407c8 100755
> --- a/t/t4200-rerere.sh
> +++ b/t/t4200-rerere.sh
> @@ -72,7 +72,7 @@ test_expect_success 'nothing recorded without rerere' '
>  	rm -rf .git/rr-cache &&
>  	git config rerere.enabled false &&
>  	test_must_fail git merge first &&
> -	! test -d .git/rr-cache
> +	test_path_is_missing .git/rr-cache
>  '
>  
>  test_expect_success 'activate rerere, old style (conflicting merge)' '
> @@ -84,8 +84,8 @@ test_expect_success 'activate rerere, old style (conflicting merge)' '
>  	sha1=$(sed "s/	.*//" .git/MERGE_RR) &&
>  	rr=.git/rr-cache/$sha1 &&
>  	grep "^=======\$" $rr/preimage &&
> -	! test -f $rr/postimage &&
> -	! test -f $rr/thisimage
> +	test_path_is_missing $rr/postimage &&
> +	test_path_is_missing $rr/thisimage
>  '
>  
>  test_expect_success 'rerere.enabled works, too' '
> @@ -110,8 +110,8 @@ test_expect_success 'set up rr-cache' '
>  
>  test_expect_success 'rr-cache looks sane' '
>  	# no postimage or thisimage yet
> -	! test -f $rr/postimage &&
> -	! test -f $rr/thisimage &&
> +	test_path_is_missing $rr/postimage &&
> +	test_path_is_missing $rr/thisimage &&
>  
>  	# preimage has right number of lines
>  	cnt=$(sed -ne "/^<<<<<<</,/^>>>>>>>/p" $rr/preimage | wc -l) &&
> @@ -167,7 +167,7 @@ test_expect_success 'first postimage wins' '
>  	git show first:a1 | sed "s/To die: t/To die! T/" >expect &&
>  
>  	git commit -q -a -m "prefer first over second" &&
> -	test -f $rr/postimage &&
> +	test_path_is_file $rr/postimage &&
>  
>  	oldmtimepost=$(test-tool chmtime --get -60 $rr/postimage) &&
>  
> @@ -190,14 +190,14 @@ test_expect_success 'rerere clear' '
>  	mv $rr/postimage .git/post-saved &&
>  	echo "$sha1	a1" | tr "\012" "\000" >.git/MERGE_RR &&
>  	git rerere clear &&
> -	! test -d $rr
> +	test_path_is_missing $rr
>  '
>  
>  test_expect_success 'leftover directory' '
>  	git reset --hard &&
>  	mkdir -p $rr &&
>  	test_must_fail git merge first &&
> -	test -f $rr/preimage
> +	test_path_is_file $rr/preimage
>  '
>  
>  test_expect_success 'missing preimage' '
> @@ -205,7 +205,7 @@ test_expect_success 'missing preimage' '
>  	mkdir -p $rr &&
>  	cp .git/post-saved $rr/postimage &&
>  	test_must_fail git merge first &&
> -	test -f $rr/preimage
> +	test_path_is_file $rr/preimage
>  '
>  
>  test_expect_success 'set up for garbage collection tests' '
> @@ -230,16 +230,16 @@ test_expect_success 'set up for garbage collection tests' '
>  
>  test_expect_success 'gc preserves young or recently used records' '
>  	git rerere gc &&
> -	test -f $rr/preimage &&
> -	test -f $rr2/preimage
> +	test_path_is_file $rr/preimage &&
> +	test_path_is_file $rr2/preimage
>  '
>  
>  test_expect_success 'old records rest in peace' '
>  	test-tool chmtime =$just_over_60_days_ago $rr/postimage &&
>  	test-tool chmtime =$just_over_15_days_ago $rr2/preimage &&
>  	git rerere gc &&
> -	! test -f $rr/preimage &&
> -	! test -f $rr2/preimage
> +	test_path_is_missing $rr/preimage &&
> +	test_path_is_missing $rr2/preimage
>  '
>  
>  rerere_gc_custom_expiry_test () {
