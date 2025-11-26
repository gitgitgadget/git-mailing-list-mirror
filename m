Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E0C2D7387
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 23:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764201458; cv=none; b=tIjmlE+zKsX1hCmKwSccXzBcuHEusBA7stib/5y4W/WM9LHYCwaRIvF1mfAEbGW7U/UAdrMSoO1c3j2ayAq+lpFpxN1pQ/sPtlRFe5hT+cR/YZz2teUUrOlQLziH65dYrGMOfPe7lScAnOFvSC8Sem/PWy0IHtsGMLARHb3b36A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764201458; c=relaxed/simple;
	bh=lZJdRSo9aycjKzEuiMp0gUJvwUzqLGMN3Qf6wBUyR6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZCT//vimxLlo+4s7RkQzVACX3MRWsU73YY50eIZEB3zmdk8y2Nf8gLDwhiofLK7vnE99E/wqaU+OICf+eqJq9B7NRYqdF9cKy/0wtalyBbbqROrBFAglew74T+RRUcjQniFsedfIrOSnBa1BPOiV+zOEgtJMcDKsw2MyPfRokMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cYYVWY17; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xw97nnvv; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cYYVWY17";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xw97nnvv"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 22EA57A0073;
	Wed, 26 Nov 2025 18:57:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 26 Nov 2025 18:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764201455; x=1764287855; bh=8OtYPar50g
	wCs9qI53e/N7VjcamgaAW5obiBp8NGuFo=; b=cYYVWY17nI9PjTT0sGXjJlNdOJ
	Y3rPpCDVhX7o/ZJ8Embw75kgD5/HlqIlqctsXgpY3XBEsBG9hfV1MCahEcyI/AlQ
	nWSj5XQfl7BMRuWCWk7GmsnCeRqNcKqq8CbADfYTCNJuy8bwRZXhMEzz42n4FgqK
	gtWUYOaGudTQXiAApGDdyGCV93CzSxZAEHwzWBqLnX6k60ahGEeDzcOzSFrzGzxj
	EoyJ62M+iXHCRBFfbCLwvrGqhi6v43/mU4ASBwZQ4e/7tzf7kHxqbdVqH0l5lUA6
	/bcf/BSDS4KbljbWRbkKcAYrCIyaB1GZVkAMYi2b5m1YDed6QulwqEIy4Y3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764201455; x=1764287855; bh=8OtYPar50gwCs9qI53e/N7VjcamgaAW5obi
	Bp8NGuFo=; b=Xw97nnvvSLGKTzYGa+AnUvqx3/E5Dh6sp4WlvJOAcE99cns0PK9
	iJ5eD+9r6TyhI8YG8ZR4AN+q4KTxlVSpWet4cl0wHKNLl6YxHurYHANvIiVxRX5y
	SYrFwcocjVR/seTfjDxrNL7B7WILJLxp1BXT3gy/TQUBFsZ1cS/cLPh71T1AfJ3u
	YTzWQnKkwTDs8uKgoqF3TkhWn2ZejlVIRpFRxOipLqyl9DtJ6etiQqP97wyJtsDE
	2V4n6ax6E2zBpqmVraprBw+k7HBExc1VucbRadW3EK/yWlieVBuzNUpgRGXRJOei
	91u7A1gNXCmcWX9hgW+IABtGd3FjNWFtriQ==
X-ME-Sender: <xms:7pMnaXrvrbGCq1dwtZrIzKcbUn6BtHRL71mUep4OjrlcvZiNPQBgCQ>
    <xme:7pMnaT6XfHtOJpeqkGd4Thy7OHPCGIrx6RSvOnKrotTFGOn7BvI7gQP2446c1j7ke
    xNRaNSbXTa_HK4zKEVN4SMaeAzV24lUXFMy9ndH8yraIsQOGqQv7Q>
X-ME-Received: <xmr:7pMnaWf1WaBhya9iwMiDw0b1IsCT7ovWLn0DgJkRQsLm7s4LaxOrH-YU_fsb5yRFMSGlty7n-QD5SITjG-0VnwN2mQno5kgUnXg8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeehjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtoheprghtthhhvgifhhhughhhvghsleefgeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhn
    sehgmhigrdguvgdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7pMnaQ51azRomAbwT1K0nfQLuMbUOfTLRf9I12Mviy7Zw4cos3aUQw>
    <xmx:7pMnaVs_iDFweXw9KWRkiHPL70dH7bAOs_9e48P-F31T-SiI3THAGw>
    <xmx:7pMnaYgbICSyHKmaKh8fKMKL6lKGlf0Bgh1EfdN2tR2EJOKkJhWMXA>
    <xmx:7pMnaYpEov9Cz3qKWrypFrE2GgH4pZBVHHQnf7ka_APhy8mFXyk1vA>
    <xmx:7pMnaXiid0xrEOrnFrlV7qJHk0GAHvP4vxbAsqE_plZdpcjCNDW8xb0H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 18:57:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  atthewhughes934@gmail.com,
  johannes.schindelin@gmx.de,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/5] scalar: use index.skipHash=true for performance
In-Reply-To: <1c51dbb81485920e9faf336ffbda9d9258e7dfe1.1764195516.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 26 Nov 2025
	22:18:33 +0000")
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
	<1c51dbb81485920e9faf336ffbda9d9258e7dfe1.1764195516.git.gitgitgadget@gmail.com>
Date: Wed, 26 Nov 2025 15:57:33 -0800
Message-ID: <xmqqldjsl53m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
> index 43c210a23d..91d5964b73 100755
> --- a/t/t9210-scalar.sh
> +++ b/t/t9210-scalar.sh
> @@ -246,6 +246,11 @@ test_expect_success 'scalar reconfigure --all with includeIf.onbranch' '
>  '
>  
>  test_expect_success 'scalar reconfigure --all with detached HEADs' '
> +	# This test demonstrates an issue with index.skipHash=true and
> +	# this test variable for the split index. Disable the test variable.
> +	GIT_TEST_SPLIT_INDEX= &&
> +	export GIT_TEST_SPLIT_INDEX &&

Interesting.  I would have expected to see a simple "sane_unset",
instead of exporting an empty setting explicitly.

>  	repos="two three four" &&
>  	for num in $repos
>  	do
