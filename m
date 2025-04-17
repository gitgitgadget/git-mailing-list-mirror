Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58B520898C
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 22:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744927745; cv=none; b=gJSp7xtgJh9e0/9OIJl+pVYqZNxB3pk5BLk684bcsr+/iRLOzSOwKvvxJiLRM8vIPx1+DFV9NdW91izzZOrl34lI6qMOKddpaRqRlVIZluQnxNRzsc5XoU+hEMwOVxtsiTAYMWNNBcjfCy/MYDLahT+5BDyw0cx3857u8wQ41h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744927745; c=relaxed/simple;
	bh=TLWyskoEMnZ94NKQrEpm2lgmnQHusNU75n7Ya+TXiqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SSjczAJZcpyhuic6P7Jw1VdWvT5S+X0sPQwckZKSlwvBKxgMN+E343IY7KvXzJT7+gavrR1A3ZbsCA/FRuHfiLbHWnX78hcRk3CikI3ujVBMGv94bJ5nBcbDyBCJUIKllcce4Dr3bjk1KF5hSiE2WFH7m3qi0jFq0Ndx1AOcA+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZJt01fXC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GZnFOAMT; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZJt01fXC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GZnFOAMT"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 757A12540168;
	Thu, 17 Apr 2025 18:09:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 17 Apr 2025 18:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744927741; x=1745014141; bh=GcaQjw8Pg7
	sC55qjj1LRJ1OdCBYK8f8AxE86V3lZTvw=; b=ZJt01fXCNY1lHIECi0ZYsAytAv
	SnZDyXM2fay0I31oPFsPHIn97XQ4hnngiLSZeILyzX54yiZe7CJBIDyRhWl7aH44
	0pNiKWuv8O3vfbm3m9mXpp7NA0NDTr1M5yRnvgcq3mokP6Kw2XMgULFJ6U5GyMVp
	Gyds9P6mofhryXmuzwg8PMSTvomxOZ25rqgQZnPcEP+NTLYrlkQvSwsejvovJNuI
	0ePo16chS+GSBC2VtsVwfJtgQmss5uYamuPaUK6bAz+rBHcINn9HPpWEGAMLbbi9
	8sweZeJkP5ri/puUaBW5m/iHik35VJp919wt+mAWKnFR2sJ4dO4CmGZdYFKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744927741; x=1745014141; bh=GcaQjw8Pg7sC55qjj1LRJ1OdCBYK8f8AxE8
	6V3lZTvw=; b=GZnFOAMTX+rIde4xoWHcnNeOC4062A56+0vrSwDYFQ17AKqnJf+
	OSXeejLdRmfMXw1mZTGcf0s05RdqQPUzperCDW1GNsiqVhx/pLJFUKSKZXrpK+i5
	dWTVS6EgRYL1m03P/iXMGSKQxEJ0jAAvlpj2cUF+rjodfb0lAjjodi06P6akHhC0
	q80ACFgI542LTNyMsqKIOf3DhkRS33X2KyKPLQGAIHdqUYqQdp4FZz+Sjc6BBEyr
	DvvK/aUlpDSqUpWJY97iopEQo+IFTyZug2alj19zOzxk3wXW5F65kYqIghnuMoDk
	AQFJpA0z7/8hp9BA5AfnXeJQW5iJmU/2NWA==
X-ME-Sender: <xms:_XsBaOPEXhuPRRi4rG2XRtKweiVKWR-HG8D4tv2_NB22bcSBdCP9rQ>
    <xme:_XsBaM_id29qC1wjcuRLoTceUk7Gk1dEU9WazcaOGGhlf275Fnw_ymn26CbPvn7xs
    dndYNrciRGF6SEj2Q>
X-ME-Received: <xmr:_XsBaFTkBbzPEqZe77Mnwi8FPrPUYlad0yiDiLXjdQXyldjRuq5Zo3YcxzDZ0S7frMIJbmFt2n9gPOY9U99c7seR6MOxScONADrq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedtgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_XsBaOsb-fPSipLGvi2k-RctttoEsKSGQ0ne_SXG-FHTiZSSNsrXOg>
    <xmx:_XsBaGfJDXNETviILRbW6bU0Vnrc3heK9sPJEcMswglslakoBWh2BQ>
    <xmx:_XsBaC3nq91dtY6BUY0_8d8D9WDCFyk1Of75nTFSm1XM_VK9Tc-Iiw>
    <xmx:_XsBaK9t_WkneTn-S34lSpLM0BeI_doV8lDAjxL8x5a-TK3Xnbmxtg>
    <xmx:_XsBaKmPis64zuXfm2CXYF6nqn9LLaquYlBjaSzuMKXdeH_XEm55l6c6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 18:09:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH 2/4] p5312: removed duplicate performance test script
In-Reply-To: <51c4604e16c886d888138f2b513e4d3407b10728.1744924321.git.me@ttaylorr.com>
	(Taylor Blau's message of "Thu, 17 Apr 2025 17:12:17 -0400")
References: <cover.1744924321.git.me@ttaylorr.com>
	<51c4604e16c886d888138f2b513e4d3407b10728.1744924321.git.me@ttaylorr.com>
Date: Thu, 17 Apr 2025 15:08:59 -0700
Message-ID: <xmqqh62me8zo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Subject: Re: [PATCH 2/4] p5312: removed duplicate performance test script

"removed" -> "remove"???

> When the reachability bitmap format learned to read and write a lookup
> table containing the set of commits which received reachability bitmaps,
> commit 761416ef91 (bitmap-lookup-table: add performance tests for lookup
> table, 2022-08-14) added that mirrored p5310 but with reverse indexes
> enabled.

"added that" -> "added a <something> that"???

> Later on in a8dd7e05b1 (config: enable `pack.writeReverseIndex` by
> default, 2023-04-12), we enabled reverse indexes by default, which made
> these two tests indistinguishable from one another. Commit a8dd7e05b1
> should have removed p5312 as a duplicate, but didn't do so.

Or to retain the same coverage, it should have explicitly disabled
reverse index in one of the tests, while allowing the other to use
the reverse index enabled by default, perhaps?

> Correct that by removing p5312 as a functional duplicate of p5310.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  t/perf/p5312-pack-bitmaps-revs.sh | 34 -------------------------------
>  1 file changed, 34 deletions(-)
>  delete mode 100755 t/perf/p5312-pack-bitmaps-revs.sh
>
> diff --git a/t/perf/p5312-pack-bitmaps-revs.sh b/t/perf/p5312-pack-bitmaps-revs.sh
> deleted file mode 100755
> index ceec60656b..0000000000
> --- a/t/perf/p5312-pack-bitmaps-revs.sh
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -#!/bin/sh
> -
> -test_description='Tests pack performance using bitmaps (rev index enabled)'
> -. ./perf-lib.sh
> -. "${TEST_DIRECTORY}/perf/lib-bitmap.sh"
> -
> -test_lookup_pack_bitmap () {
> -	test_expect_success 'start the test from scratch' '
> -		rm -rf * .git
> -	'
> -
> -	test_perf_large_repo
> -
> -	test_expect_success 'setup bitmap config' '
> -		git config pack.writebitmaps true
> -	'
> -
> -	# we need to create the tag up front such that it is covered by the repack and
> -	# thus by generated bitmaps.
> -	test_expect_success 'create tags' '
> -		git tag --message="tag pointing to HEAD" perf-tag HEAD
> -	'
> -
> -	test_perf "enable lookup table: $1" '
> -		git config pack.writeBitmapLookupTable '"$1"'
> -	'
> -
> -	test_pack_bitmap
> -}
> -
> -test_lookup_pack_bitmap false
> -test_lookup_pack_bitmap true
> -
> -test_done
