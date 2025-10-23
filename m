Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7251DA0E1
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761248035; cv=none; b=NGCsqR/qv+ddolf/OtHGPCm+IQAL+UF8w6WEWhzp7YkgfRhRjCMm7PSugQbA6CTnKg0FAQUzravoaqJdkgSAzaRhQPCqN4kERmuN8gLRzJ/PVqkBEuJZaxcFRRxfroqFloj2Yg35scLFYf/UhZdxMSiOPzNydkzhBSk1JQW/9lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761248035; c=relaxed/simple;
	bh=V7kkCG6F02cQatNTl7v81PdRthcnYwy8LH9q8ngrfDo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u5PB3S0pYZxSqvarfTzCCYAcKMcDlpoE3dhOURea5MxoG3aeVcdB8z3NhBEK4X52Esy/2mUjub0hSQ3VmrfHf96xukhvjrg/JSdTw88uwPLD7TdPgRiQXzbf9GGJNQlBD4tmppQCLfD+HiBkZ2/qK2NYxM//Oabs2C7VNVhFh/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J0hn8mTI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CeOzhpXH; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J0hn8mTI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CeOzhpXH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CD4191D00149;
	Thu, 23 Oct 2025 15:33:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 23 Oct 2025 15:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761248032; x=1761334432; bh=5RyYZJi0B7
	amtoxBPBJfMJReH+HpPHgwm8E9mOn4D08=; b=J0hn8mTICmvtefmQ9c/o/MUxvo
	LiFMvGzmuaqThd1cvjQD1735C1KQcUXoDgo//h/nvQ+cT7NaKcQIEFQTL71x/iO5
	H7uCBmqB5blGqSNSN6MlFw3zwKmfVKLxVUKFcqFJ46nFbH7qM3N63c3DtpDxqshN
	9KkC7x8LyGYNBmC877l4ia1VKQbGMFlpjt8judPNbWqG1yhPS/s/S6QbwXbQf6ug
	+IQhBngWIaIwuCiCnZ1vyBDEkTOGn3RnaVpdiywey4vetzBc+by+LJ2m1sPMWk/1
	VCIsE6cj03/vPrqJWReWP/xQMs3Zyz0R1Vt4foo7kGVUoZAiuASnkI5RAy1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761248032; x=1761334432; bh=5RyYZJi0B7amtoxBPBJfMJReH+HpPHgwm8E
	9mOn4D08=; b=CeOzhpXHLZy7Tedw54isdPycza0xPszJlKUcDXAGiTwJURoKDZj
	aGZTPemNBigNP1OcNDUEqXl4l8LHZ9O6aKJDQkVBERFi/Tthn5cfhE6ZD5TKU4FP
	bc/x94+ZLADUMP2NrU9Dbd6FPpQK4I28jcE48zyem7sqLZdEbwYUM7CKblQCZD92
	SMe76V5gB7KnIDirjll7/9C2/qu6WlaclZzmj+ahXuJx1tB4y1FVsTDaplI2W8jM
	/ApnHU9gD/ANn+HtMl0sy4yu7SyZWbXr6LnFjIAhGktROXa71gP7gIkUL2MPqwB8
	A0LkXFNmXT4SpuE29DLmfGIQZV0HO+H+wwA==
X-ME-Sender: <xms:IIP6aKyDWPrfHDoAYrcQmguUV02taKngnySvDYy17LfdrK-IQa_xUw>
    <xme:IIP6aPkHeox2iRFBR-Fj--IN4gu8sFHw1qeBbe5rq3GRnhfHgN8A3c6nkeaG6XBnN
    73fJFpQfTz74vg5u9HZJXLqod7_C0e1p8IDLqSwVPmdNwd6YtdkCA>
X-ME-Received: <xmr:IIP6aDnqICFZKM0Gvp8e4Np1CScndq5Kyho4pFTaLzZSOZHN8NPU4o1uISCkc-MY9I30QgNQCdAyqRF__J_OhlV0RxbeCHqX1yiy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:IIP6aBwPL5d0iz406_P6nPVxqlIbRmV8D1yzihzvKHZDw2bwbpL4Fg>
    <xmx:IIP6aIoNderExlV0YpkEd3zzN5ShUOw1tmPNYefdQBrKEO0mU5VCYw>
    <xmx:IIP6aA7EBiTlS4vTh9sa1CF1LhLGWXNrOn0kOLoT48iMOLaImwwlYw>
    <xmx:IIP6aPfpMTc7L_HIlcVSa_jPB3N50Osc2gruzaipqOQGxXzZfuRc3w>
    <xmx:IIP6aOi0XlKLJlGCYOjua-eSa-wabzx4d2nbKZFklPJ9OQIWMUY7WMM0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 15:33:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,
  Elijah Newren <newren@gmail.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 0/4] technical docs in make build
In-Reply-To: <20251016200301.1595204-1-ramsay@ramsayjones.plus.com> (Ramsay
	Jones's message of "Thu, 16 Oct 2025 21:02:57 +0100")
References: <1a72434f-7935-4d0c-868f-03bd24601d4d@ramsayjones.plus.com>
	<20251016200301.1595204-1-ramsay@ramsayjones.plus.com>
Date: Thu, 23 Oct 2025 12:33:50 -0700
Message-ID: <xmqq3479v2e9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Changes in v3:
>
> - old patch #1 discarded since it was separated into its own branch
>   ('rj/doc-missing-technical-docs' in next)
> - tyop in patch #2 (old patch #3)
> - new patch #4
>
> A range diff against v2 is given below.
>
> Note that the two remaining problems (see v2 below) have not been
> addressed but, even without a solution, these patches represent a
> good improvement. ;) (I am still hopeful that an asciidoc guru will
> turn up!)
>
> NOTE: this series is based on the v2-version of the patch #1, which
> in turn is based on commit 6ad8021821 ("The fifth batch", 2025-08-29).

Let's merge this iteration down and if there are things that still
need working, do them on top.

Thanks.
