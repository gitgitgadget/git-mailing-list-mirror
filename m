Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E12256C6A
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206555; cv=none; b=ah5xtRp5kqP6s9Ho8Nq6lTE/F3IhFc1UGP0I/YJ7ucx67rHz6rBg2b7U01wtgy4o0KPA4LhfVmhP3NOZ73woB+19Y/GZXHGE6uh1fyLYvtn30AVWx77v92yAoxtEG8jMPNyBgSC8m0dMjeiLrh2DlGm6Ja9rZ+s21cu+Oi1S5DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206555; c=relaxed/simple;
	bh=C426wCBFGUECsl8gi1Z2+NWn55tFGvmW5dMozc6/+4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SXmbdHc7lw4O51bnfCYmKnmBbOI2ZMDebRx4i0vXCmY1kNNw1THePCUSLGuwJFvtq4yunaJzFYXUdbAcmnv05atIEGQsWMaal1cYKfagflbXQzYmDmm0ISachDERtrVMW10IeqZ4Ti7EVKsCtWGVDSaDkbJUvN1v+KvwUxa1G/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hhTshS07; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MVq6nLzT; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hhTshS07";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MVq6nLzT"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 165BD1140268;
	Mon, 10 Feb 2025 11:55:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 10 Feb 2025 11:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739206552; x=1739292952; bh=rYUa68eb6/
	IE8tDFiVPf0NR1n3Y9RoftWb0nDWVMPBM=; b=hhTshS07fFZhBPQSdlIy3Qiqui
	00IESzzM7xHo8VBlXW0eyufc8pIAJYOian1nP+h5zlx4112oxorZ2nVgfsyTF6gN
	vtS2zP9lkmzwl4nsNLomt5JHP/4Lu205oF8iZOtyB6n+WuRcJ8iAE2nmcw25ALV1
	pu4QAQKdkuBqg4DYIp47iNkaWdu08RK4FNAreDWZcaXahcxhIIPfZUaxgyG1wc+J
	N29TJwMMDFUx0lmQ9s0t27XL56sGXQmvUDbl6ZEqYKH6Wp9m1ilERL+S2UeAt1hp
	mUhlnJ/wtyVTMh5Ge3m6MmjxEV5oY4jHxgK9s6PFyV1VI36twj+beMzbtPsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739206552; x=1739292952; bh=rYUa68eb6/IE8tDFiVPf0NR1n3Y9RoftWb0
	nDWVMPBM=; b=MVq6nLzTxdswoQbcCPML1Axa3gKcBf6rf5u/VsILoa+N1hg4+VP
	ChwWEhRTgB/Ytx9cuiT9dPBwFBkRNGkgJB3choJi5Lf070UIIzYuv3AhY92V+tdF
	OdFL/n4tEYLRpdaEvujVLx8MmU2cU1J2mSAZdnD70U4lGi6qtOQ+HHnv/Ga4+wti
	aNzWFM7aqSBD9RcnjPeTCfIP1yZ13hhycE/YnHc8VMyYAKAyuXhAbMOFppisvFgw
	E1DJ8fSG5x2YusH07psCgUIKPE+zK5FIHQxhbpgnsIanYKyP1t+PmlKWzuH0PJ3s
	1Az+dak6En0nrFvfmapBETKcV2sGo/FzVkA==
X-ME-Sender: <xms:ly-qZ63NudQqc7HUG55shskbbFtN69_rjYWCSADQUooxiiB2_D16lA>
    <xme:ly-qZ9EcWGuMcXZS8AbIC_JWiwnJpjP661wXz738J68pGGBAB-x-4tCKg7zXUtDa4
    TkJx0N2sEZT7X4Lvw>
X-ME-Received: <xmr:ly-qZy5jdKRzceWmxRhk0xUmkxh3_kexpPVwZKG1OGya7cCQYwDRsZEt5midnQp87gl0FI9JWbkCrzzhxWWskm9NPLALy3C9nTDN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrhihurdgthhgrnh
    guvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ly-qZ7369C0MRS1GElj1YpkHqgJxaOKnnfkkYysQLkPgRI3hxvPdWQ>
    <xmx:ly-qZ9FUFPOCWTigZrfxtZUaEcHegNUIOnJr6PCzyX3-KWu8RD3UfA>
    <xmx:ly-qZ09_brPDieoVq0zOjcRJzwH_ZHWWKu9YRLekmvQi_2Imd4VGVQ>
    <xmx:ly-qZynA3v3H-Na1scNavo3KXV-0LfGD2YsKDrr4bYFZRZcaBkvGYg>
    <xmx:mC-qZ9DfYx-aGJYwm2JilMnOq9MBOLWZrd1yONlHVsKkjq2RqqcxugF1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 11:55:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] midx: show progress during QSORT operation
In-Reply-To: <20250210074623.136599-2-ayu.chandekar@gmail.com> (Ayush
	Chandekar's message of "Mon, 10 Feb 2025 13:16:22 +0530")
References: <20250210074623.136599-1-ayu.chandekar@gmail.com>
	<20250210074623.136599-2-ayu.chandekar@gmail.com>
Date: Mon, 10 Feb 2025 08:55:50 -0800
Message-ID: <xmqqzfitbuy1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> Add progress reporting during the QSORT operation in multi-pack-index
> verification. This helps users track the progress of large sorting
> operations.

Hmph.  If the implementation is correct (which I cannot tell), this
needs to explain why it is a bit better than saying nothing.

> +/*
> + * Limit calls to display_progress() for performance reasons.
> + * The interval here was arbitrarily chosen.
> + */
> +#define SPARSE_PROGRESS_INTERVAL (1 << 12)
> +#define midx_display_sparse_progress(progress, n) \
> +	do { \
> +		uint64_t _n = (n); \
> +		if ((_n & (SPARSE_PROGRESS_INTERVAL - 1)) == 0) \
> +			display_progress(progress, _n); \
> +	} while (0)
> +
>  struct pair_pos_vs_id
>  {
>  	uint32_t pos;
>  	uint32_t pack_int_id;
>  };
>  
> +static struct progress *sort_progress;
> +static uint64_t last_max_pos;
> +
>  static int compare_pair_pos_vs_id(const void *_a, const void *_b)
>  {
>  	struct pair_pos_vs_id *a = (struct pair_pos_vs_id *)_a;
>  	struct pair_pos_vs_id *b = (struct pair_pos_vs_id *)_b;

This is a compar callback function used by the sorting machinery,
which is called QSORT but system-provided qsort() implementations
are not necessarily quick-sort [*].

> +	
> +	if (sort_progress) {
> +		uint64_t max_pos = (a->pos > b->pos) ? a->pos : b->pos;
> +		if (max_pos > last_max_pos) {
> +			last_max_pos = max_pos;
> +			midx_display_sparse_progress(sort_progress, last_max_pos);
> +		}
> +	}

So I do not quite understand the assumption this implementation of
the progress meter makes.  

The assumption seems to be that the element in the array with the
highest index MUST not be summoned for comparison until the very end
of the sorting process, but what guarantees that?  Even if we assume
that the qsort() implementation supplied by the system implements
the divide and conquer plain vanilla quicksort, it may divide the
array into half, and then sort the top half first before it sorts
the bottom half, and doing so recursively will give you the
comparison between elements near the end of the array with the
highest index fairly early in the process, no?

And the standard does not even specify what algorithm should
internally be used to implement qsort(3), which our QSORT() macro
eventually calls, so making any assumption on the order the elements
of the array is fed to the compar callback function sounds doubly a
frigile deal.

Thanks.
