Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79830184
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774216551; cv=none; b=TEKoMLXcYRgrFyJmNsM6HG4h4UCDk6QzlmURKlACCwxm8Q452mizeKg+au8SM4NgWibWNua/mHlIFvQ80B6yWXEY0KnYlJr5r6iSPAOeQZo+J7H/NeCDsoFFNBtLFhtE5YdDCdgIoTYj2N866oiHop0M3std1UMa/ncGY5R4vW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774216551; c=relaxed/simple;
	bh=kqkalimjJuJ3laEio3bs/h6sA+kNNie0U9KiiEM6oFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XHIzVPnjmhWVTrF+XgnSn0PJM9tLxJAM4VN239bBiDENypn3SLN5Ge/vnSj07BBfvQFvwOD7u8H6gE+xlZwBlJtaLZYtkz18klyfU9b+RHsq7/MpMB6q9GqhwdZcOy8oeCcma47C1SC2qmURU1MSo8sSM3jGdXiqxWKuo0A7eUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IyD62wGm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vblngcFU; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IyD62wGm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vblngcFU"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A12A41400223;
	Sun, 22 Mar 2026 17:55:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sun, 22 Mar 2026 17:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774216549; x=1774302949; bh=h5kw+zVAq5
	EBPeL1AyxTYiSstnwYEMWlppKBSp3XlsU=; b=IyD62wGmjynO3a+agGAi1tKh0Q
	AS5YkmzSFNu8vY0BwHfgn0RN8Necwu55hOOXQ6aul+sbfctPVLz5pQMT3zyNvGbx
	Ko6lqqyRw2y3jI/bqPAo6bAEdu2HcjZ0g/9pwsDpLOOAvccqHqcHACUkJzmkSeHd
	lOfDqAeDxROHHAN/vwmByk6QZfRhi34113EelT4D3WPfmd2ud76uDi4+Z5Vehw4F
	671hU6E+f4VsneNZ7puALfB4xmeA6oLZp96kIup0CoacV/5Mg20fylkVlxTEaL+M
	cniyaRrLgRMdBJOc1D89d8KoBpkkq/lzq8UZeGQR6IeRKAWrkhKoMFzg5xKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774216549; x=1774302949; bh=h5kw+zVAq5EBPeL1AyxTYiSstnwYEMWlppK
	BSp3XlsU=; b=vblngcFUZlABzwYls9xCpNtWt3kEcUaoRhri39RYs3NmEmtbY+0
	rEK+2b/ZGvv0uHmiCFUbgn9QmqsgALZCDCs7wA+Vm/QxAmo07IEooLNHkKu4MUfm
	FIUBoE+3yGUQXG//r+MjVSrf/hD24EMC4sEV7I1uqJOqwWQWGjI+cje2EKiNqRo/
	Gpu6/zw4NaZwKz3jbyI95w0LglhmaahK29wq1/4/ZtcS5nEyEMsYZIiqNq+w/Ecu
	2JC5sGh4dzS2vEUqU3QHDjViTH00K87dpdvunJpcqUtMYJQgDOyEOwqHYz5yPsXU
	S8HjJFNVxktUKbv2fdRbo3jzvAHLavcmP5A==
X-ME-Sender: <xms:ZWXAadQ7UWNiyWB2WscbKmJy5YDiajkj5hKuk1XnzAGjcRkbqtv43g>
    <xme:ZWXAaZD1lEOLBuDHvHFdGV2EID3QrKJclyIFHJHzVPj6DhWD8ztBPQPwjFNvXC4at
    gChn0i5CxwYrWXZHeS1yuXSeG7-iCHLBuPt8hArBeDNkZGVU91j>
X-ME-Received: <xmr:ZWXAaVHKD8fPOFB0RXNUI6lVkNqqYxJ-VkJBSoQ2cx7Mlg9V4be-Sa6AoNYeBlq2EeVCvXvd70uXHM66mzKx4fD7hWwOwqdDsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeileegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegrhihurdgthhgrnh
    guvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshht
    hhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrhigvshhhuggrghgrle
    elsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:ZWXAabBY2UBOMoPA0WE0wvRznOpBCtaiq-xI1JE4WLOZl9cGPllsJQ>
    <xmx:ZWXAaVW3LYy5blKQbQbhChQAnSIGRlLKg-8IpmAZ0aXvpVjhHwVT1w>
    <xmx:ZWXAafrM1sx-D5xQXcu4ansteKSat8X6BU0js074lnbp_BCrIgNH-w>
    <xmx:ZWXAaRQ-8GlgWiGVtXZXr6PS4zLunASHA_6gg80CAI_l6s99g35ATA>
    <xmx:ZWXAab29iy_vFoEsNurQejzs9WhHuykqkc9StVBWd2ZrOmC6D4J7YNBR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Mar 2026 17:55:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Ayush
 Chandekar <ayu.chandekar@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  Jayesh Daga <jayeshdaga99@gmail.com>
Subject: Re: [PATCH] t/t2107-update-index-basic: use test_path_is_missing
In-Reply-To: <pull.2250.git.git.1774197600379.gitgitgadget@gmail.com> (Jayesh
	Daga via GitGitGadget's message of "Sun, 22 Mar 2026 16:40:00 +0000")
References: <pull.2250.git.git.1774197600379.gitgitgadget@gmail.com>
Date: Sun, 22 Mar 2026 14:55:47 -0700
Message-ID: <xmqqpl4v7cm4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: jayesh0104 <jayeshdaga99@gmail.com>

The author identifier (name and email) used here to identify the
author must match the identifier used to sign-off.  You'd probably
need to "git commit --amend --reset-author" this commit with updatec
user.name set to "Jayesh Daga", not "jayesh0104" or something.

>
> Replace a raw '! test -f' check with test_path_is_missing to
> use the standard test helper and improve consistency with
> other tests.
>
> Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
> ---
>  t/t2107-update-index-basic.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
> index cc72ead79f..3bffe5da8a 100755
> --- a/t/t2107-update-index-basic.sh
> +++ b/t/t2107-update-index-basic.sh
> @@ -86,7 +86,7 @@ test_expect_success '.lock files cleaned up' '
>  	# the_index.cache_changed is zero, rollback_lock_file fails
>  	git update-index --refresh --verbose >out &&
>  	test_must_be_empty out &&
> -	! test -f .git/index.lock
> +	test_path_is_missing .git/index.lock
>  	)
>  '
>  
>
> base-commit: 6e8d538aab8fe4dd07ba9fb87b5c7edcfa5706ad
