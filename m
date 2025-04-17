Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DB81FBEA2
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744928534; cv=none; b=lQZSNxIYvVOQcLttj8lQ1Vif3m7TkutmhDalxNV4ZpZ8b65aB2oAEaMgR7JtvyoJXGdueQeUgAv7o0iqrD4EDgedVvhliehrbqBmZIkNP4kKc7zyPM+7sXpfadtB6kVcxAaCFLYDfqI/IZ/GgLFqsjrnYPKXeP7HecAUtJ4a8BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744928534; c=relaxed/simple;
	bh=rrhMOKiesqGVAWLT1IwoQEjdVMB+VqsAuSLPH5cfknQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TGFhPJbRA8j6LWaPrPsKtf+uhadUHKBevAd27Q75ouHYPa+X8UNn13LvLUjbjaL3mFur0KNnJQf08W0EFuUos4mTUAYXem4tLenPpI3METZTdbPeodPw/ozRLNX7cH0+7+gR+YJp3oi4BIaDYdLTRpNbe4SWBATBqJvtCFzKK7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WSQ6chQo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B2zy2MJ0; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WSQ6chQo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B2zy2MJ0"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 142881140110;
	Thu, 17 Apr 2025 18:22:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 17 Apr 2025 18:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744928531; x=1745014931; bh=A+gdDImClC
	rEajNNN0vi73HffE4JyLh9hgyRG0ElqAU=; b=WSQ6chQoSLM5nrTxg3iV2UU+w4
	YdCmQqa9+yLk5dR9is0tRqhePB5dQw3T6eBw2DvifHxiSV97cqLYj+vBAlDw9o3f
	GeR0GtJoAh1kjoXOCypR+NlP+3R/OLE2TOU2Mnr87DS0RihaP1WPqqctBqlF8CjU
	bSBFhOrOR2pu0YfFA3w0mI3e8Xp5P7gcwqEwR0oo9e7h5fo2xu/7SkmpPq4C2XSS
	amDoBwOOBHnEdQdGqr8zwARn/QbSGf5VyCU2uFh7cklSsT5Dt4yWZh85A8ozPnOL
	fALCPDmJGQDBO6yKBIbnmzpIYBpu92LvZW32mBVcUuY4QJQn5oi8DQjkMftw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744928531; x=1745014931; bh=A+gdDImClCrEajNNN0vi73HffE4JyLh9hgy
	RG0ElqAU=; b=B2zy2MJ0xx46vzZirObxUI33EKKKpHCgzUG9xCjjG9tEqk1fTqp
	vBYI5pUZZzonPMGVVZrXqnd8poRaEsH/KxSVvn5JGugewbmFnJSZmzHZt+wtwAYZ
	2wZZJB0Vcb+tegt9p1ht2oHSOcTBzc/lvoXOomCX3aIGx2Qa8vMDfdsZ0/VOSsqK
	0XxDdxfVIpI/difUk3kDFMl3ogX0Vx+kW+DX6O+lb0ORSGamxYfGguhCDleeDfm/
	kd1/hVzOQOwCXlThKlo/bZzmL03Vk3QLyTDvKyiJ8HYbAzcQvNbeVfmEJQ7NQDvR
	BdgsYBdLz1WgE4dA/DROwELCDRspOY0KaIA==
X-ME-Sender: <xms:E38BaI2cdhWSFMdhDXJc6CAdIYeYF0hvy-YIiwx2HsvCNhwjFuv0Cw>
    <xme:E38BaDFyGZSfaNtzYGvwPbaZnVA04DusjJx5C9B7-eqWlspqTdW2QN6zToUbGVt1r
    KyBppFWlssv9G1jDg>
X-ME-Received: <xmr:E38BaA79-aX5U2bTdLrpiBk9NCU4DzgiH76CEmpXDPjtOM2bJ-MC78s1MnH_r_3leIPb_n3ONQBe0YpkRLV9T9ZAzHqg2x7uLL61>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedtgeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:E38BaB2_lvY7aZTt0XbTtZo0YTEDZga6BkMY4M_lVRSgMKsXzC7yPw>
    <xmx:E38BaLEx4_7s9OUQ9GoX1JwjKpIWBcx_NxqdXkBmM447gI2Dhat04Q>
    <xmx:E38BaK_Kc3OQDlBDMlXntW5uI8P3z_dnDZC7ZFX0GoFPF-QU86iZbQ>
    <xmx:E38BaAkYWD5tvhHBz7b5i1QHjtUVIidDKG3A6YorimD67JZ6TiqZoA>
    <xmx:E38BaIIauyBDDJBaAXYBfUFd56vbmDfTeyQwezQDXzg1B0NONqMo0asW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 18:22:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH 4/4] t/perf/lib-bitmap.sh: avoid test_perf during setup
In-Reply-To: <0906e14c0e55b52573c7e0b632c7c639850700ec.1744924321.git.me@ttaylorr.com>
	(Taylor Blau's message of "Thu, 17 Apr 2025 17:12:23 -0400")
References: <cover.1744924321.git.me@ttaylorr.com>
	<0906e14c0e55b52573c7e0b632c7c639850700ec.1744924321.git.me@ttaylorr.com>
Date: Thu, 17 Apr 2025 15:22:10 -0700
Message-ID: <xmqq8qnye8dp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> In the test_pack_bitmap() helper function, we first repack the
> repository under test for consistency and to eliminate any effects from
> different distributions of objects among packs.
>
> This step is performed with test_perf, so it is repeated
> $GIT_PERF_REPEAT_COUNT number of times. But we do not care about timing
> this portion of the setup phase, and repeating the process does not
> change the outcome.
>
> Use test_expect_success to avoid spending time repeating an idempotent
> portion of the setup for performance tests that use test_pack_bitmap().
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  t/perf/lib-bitmap.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

OK.

>
> diff --git a/t/perf/lib-bitmap.sh b/t/perf/lib-bitmap.sh
> index 55a8feb1dc..fdf5f35f1b 100644
> --- a/t/perf/lib-bitmap.sh
> +++ b/t/perf/lib-bitmap.sh
> @@ -69,7 +69,7 @@ test_partial_bitmap () {
>  }
>  
>  test_pack_bitmap () {
> -	test_perf "repack to disk" '
> +	test_expect_success "repack to disk" '
>  		git repack -ad
>  	'
