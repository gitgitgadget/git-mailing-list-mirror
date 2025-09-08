Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC2C228C9D
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344104; cv=none; b=YVjpDdkuWuBGXrtHOVQdjDZ60ARdq//SHGS8cNBOzR+lXKovFee3VxGY0Ju/FYmkiH93+LTBTQV71Anz6/lrS88NxcmAFhf+F7M34995vfQZ6lbCIVoFQZMPmn8OneU/XhdXz5uavsiMXEKnBdLqde/v0LVgHOskm5l6mIS1u7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344104; c=relaxed/simple;
	bh=MGk4WKl0C6NQ6anje2OYufMEu/gRDUleDGQDOC8n2MY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=argZSpiY42xAsUWBuYDbSmIHJF17TGsd6cn88g2qty9qIHxETf/ogEZ91t7vrPC17wtXYjom6xbZW9afBcZ89Jhw0UbDnJa5wz14T6OriguCYq7WECm9CMwp0bPao4hfutgWNKssxwiEAsyfNau1SiVOOar/VjVG8YkScgqmwEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=z62rVOTn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mZR9o8+R; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="z62rVOTn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZR9o8+R"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 45F951D00118;
	Mon,  8 Sep 2025 11:08:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 08 Sep 2025 11:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757344100; x=1757430500; bh=Kiy4hv5DNK
	GXXcFp/OMtFO3URvH9PoIMHA/lz1L27ec=; b=z62rVOTnd3dGwA20rFZHL3W0x6
	KFr/zV/1ZnY6thXQIqRJOD6i4IXQyzqshGGcW52+oKEo5q/n3SrgGD1/kLh/sWEj
	vxQA0VQmf1mbdmwNM2J5oXJOlO/8AgcCOEHt+A6SoNAa79temz4aQW8lzOGQnmLY
	Jp8d5DGSV+tkOp/Z8yLRxLCFJquVc3oeR1+6jk6rfxW1bjThkUrzDQbtFR47PCgl
	ctnz61q/YamWSmwK+t3R7eAHECDmJJ7ankclu+bBTCdu7fqObIZI1xl+UZ6YSibI
	hPF7ceXzniyzOcLuZYxhCJlpLvMR6KHzqvrsm9mEI2vC9J9q/TVDclyLdh8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757344100; x=1757430500; bh=Kiy4hv5DNKGXXcFp/OMtFO3URvH9PoIMHA/
	lz1L27ec=; b=mZR9o8+RI3tBXy2QL7HxaS+nUPXevxlTiYogirAq7HrwfhgsUAV
	HousfplU4mojtqd51Pdh+ouo60WgDaZZD0l3rUF/1iuJLeSGtg/cROOlifab3aQf
	XOWsioIKNCJ2oTVzg/Dzbalu5MejtYjGsN3jbZJR7gqjhQXfREj8DQW+HhPCy7Fn
	KjD0ShNr5U7y+yvg1sbOxbI+9ms5u4nLz/FoXCTjADP9YbfIZdVVKSyFoixsaAZM
	lX39ttM0Ih2FJlSjJRjLRrHSKYV28axjHBhdZZTJjHJgfaV50CnWQoBH6e8f3VJ+
	1tH59UvmN1dabarckQfX/ErBQgoJULhxAyA==
X-ME-Sender: <xms:Y_G-aCH8Nfd2KCaGDY9DoFTN3n9dqtKek-EABu1vJdhIT8SzKAQbGQ>
    <xme:Y_G-aBIODqhQPMFCf7aUyIJJAiJflB1xYCMfCOJs4PuVtj1Xe0ll26gnNZHLvC94A
    UKSfouqXBC1N_kmvA>
X-ME-Received: <xmr:Y_G-aGlfeXA6GWO9UrpuaQv_mIEZRuqp0yHEaym6rp6LXb5YQb87Gw4Wm77zpu2UV07Cbjhqq8dKeJrPFBwyWGucaC27ojGRxhsMlsM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZPG-aJRDyEAS0qYrM0VHjGR_aKx8gX5yD_5VvG7Fcw15HXxqJE5r0Q>
    <xmx:ZPG-aILRVq6mArb5lHCIyiV3Zn88lN1M19ZzjJqMSS26Q8HGqoIfsQ>
    <xmx:ZPG-aPDmNjbbYIuboOFjwasgzMoLDcf7nxH68EFtV6qyVeYbihvkOg>
    <xmx:ZPG-aBCHLhHxVvdliWJjNzqZnzV4ookmFGndsHXFDjfe3CwK3Js0Vw>
    <xmx:ZPG-aIDKL9FphoMvKqmhA0WkKizwtaOPct3xXU3z3lpXdeVqas_dni_J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 11:08:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 10/17] compat/rust_types.h: define rust primitive types
In-Reply-To: <2a7d5b05c18d4a96f1905b7043d47c62d367cd2a.1757274320.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Sun, 07 Sep 2025
	19:45:13 +0000")
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
	<2a7d5b05c18d4a96f1905b7043d47c62d367cd2a.1757274320.git.gitgitgadget@gmail.com>
Date: Mon, 08 Sep 2025 08:08:18 -0700
Message-ID: <xmqqjz29x9r1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +/*
> + * A typedef for bool is not needed because C bool and Rust bool are
> + * the same if #include <stdbool.h> is used.
> + */
> +
> +typedef uint8_t   u8;
> +typedef uint16_t  u16;
> +typedef uint32_t  u32;
> +typedef uint64_t  u64;
> +
> +typedef int8_t    i8;
> +typedef int16_t   i16;
> +typedef int32_t   i32;
> +typedef int64_t   i64;

The standard guarantees that these are all of the above are exactly
N-bits wide, so I can buy the above types.  But before I can buy the
above typedefs, don't we need to rename existing variables that
squat on these names?

    $ git grep -n -E -e '\<[ui](8|16|32|64)\>'

gives some hits, like

    reftable/record.c:678:	uint8_t i64[8];
    t/helper/test-parse-options.c:123:	uint16_t u16 = 0;
    t/helper/test-parse-options.c:148:		OPT_UNSIGNED(0, "u16", &u16, "get a 16 bit unsigned integer"),

to avoid confusion?  There are handful other hits.

> +typedef float     f32;
> +typedef double    f64;

It may be that they can be used interchangeably in practice on
popular platforms, but are these guaranteed to be equivalent by some
standard?  C only cares about the minimum required range and
precision, so you may have allocated enough bytes thinking you can
fit a f32 but your float may not fit there.

Or does Rust care only about platforms with IEEE 754 and would
refuse to port to other exotic architectures so the above worries
would not apply?

> +typedef size_t    usize;
> +typedef ptrdiff_t isize;

Interesting.  I would have expected, "isize" that is a signed
variant of "usize" to be aliased out of ssize_t (simply because it
is declared that "usize" corresponds to "size_t" on the previous
line), not using ptrdiff_t.

> +typedef uint32_t  rust_char;
> +
> +#endif /* COMPAT_RUST_TYPES_H */
