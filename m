Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A7B33B6E3
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980199; cv=none; b=KGvLJlam/b0PONg8xnyuV6aZM/0AQ50IUcfS+vrql7q53HjX6JvNbQGMKTYSYyYD9+qkDYAJw9Rr8mjl00oqGIBUbp9/yyJxmdNTx3YlYF7ZmiS5T7c2ctdl/umniprG5G9oSqlSOXc8R8mRBVc7RF8Hpa+AHRZf//i5LHuYU9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980199; c=relaxed/simple;
	bh=8PzEu0W0iYR1e5vskILnSf0TD0TU/9fqaFcKm3ygErc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QDQ8OkZUyQO1yqblaDj+/5qi+Fm9xtUWNNyKZfIdx4yrZKY9V29L9KTVaD6Xiy32FYYjWxPb7M+cR1bTsGrxlxOg/qRx+Q0OdaqOyKcGIquDyYWFLL+YSDJ45notEVu26j1Nj1D1Gj0ftJqVXrpO4KpvO1y2Z2HcW+L4eo/ffJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bU55LJfj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ims4Ug4l; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bU55LJfj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ims4Ug4l"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 61C7C1D00179;
	Tue, 31 Mar 2026 14:03:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 31 Mar 2026 14:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774980196; x=1775066596; bh=iprkBc09D0
	o6onqZWM2BqaOlajKhRPrVy6xjudbX8GU=; b=bU55LJfjul7VeNT0JaEQCbYqFl
	FiYFwfHLSbJZtg00SE3uoGhCy+Zc5RyvR0Dsms5asPdTMoJ5J30raYg2mNaChE2h
	DpKkOl9FwtwNHz2GDgucablbyJMdBiO5RkTuwqbWRGfG4Fjfwc2kqSabt32juZj9
	2FYq4NS8ck9A2CffhI5MW//5WcpIO25dLLsK3YW72Jv9hqmJkiEo7HgcSlzqh5mJ
	bX3nZeCa1v+lfIxkT1+/QcQKAMn2G59oU1BVX8erU9pmLVqalh8h/wlyPAcCItg1
	VIY164yCJY/OKAnP/rQvu7p4Vx8jnpU5ALTpjId3dgZL79dNWb1FoZp/INOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774980196; x=1775066596; bh=iprkBc09D0o6onqZWM2BqaOlajKhRPrVy6x
	judbX8GU=; b=Ims4Ug4lFHD1xZy1vPOB6tT07C5Pbyagjf+zJadb1tusj+lyWU2
	2JuhPNfQ/ZwM9SdQV4enR0xlhlOQCHbovXxJ2VrDd36+Kgeg+yjjxBMleNDMQwLe
	fWVgXj7LUPzCWGRKTx3DapKBonqClziLUmiaANNxR8VZQCNVHK/e9uG4e5TyhBgn
	kSczrPB8qJW79waxHiznP4mpUv08HAsjtIoGUTyhoXZGoWsX52oOxmJHcAbM0PHC
	m5u5boaMVSKzm9QlDsehjx7W3Qdxbm/gX1NHSlEd0hA4n0Kcnf56JcNBjGIEeizP
	HaRAOVmcBtFGTwBq5c0fmxR+NysfOrKtQ3Q==
X-ME-Sender: <xms:ZAzMaYac-G93I9HlP2oe0gDAMnYsLT6J7nxd3IedzV3f7N6YPX4OQw>
    <xme:ZAzMaa0A1TomL9hQtfI0U-CvB3JJLe1uCKuH-B0-6J47bJ6HwNKO87gtcqCtUUeTI
    ogdLKFGQVCsb8d2xYJGhWJBoj4XP-ksIxZmIa95GlUf05A-HVQgig>
X-ME-Received: <xmr:ZAzMaQXARkWU6_qN82LfmKmzYyn6T8NbfNIbS2B3F-yOiGwpgMLv8XHooLFvuxyc7ARtCDGGsaatiE4MNIuuUu97YFmD_JjFzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:ZAzMacXDClN27nHcH6ezgR2cF_glR9uXu9FHpulhvGEqDYQ-UeVHfQ>
    <xmx:ZAzMaXfUdcFFKQx3macmuEj-erwMvA4wP0-7B599jddojCot47B85A>
    <xmx:ZAzMadXhU1Zz5SfA6V-zptyS-jQ5HYGgeghHJP12_14ZLWbb4L3Sdw>
    <xmx:ZAzMaYePy3Jf-EMlGMWJ7xWsH4r_5NL0-UIcWS1HrXW7OFs3KwD41A>
    <xmx:ZAzMaS9Jxw9kVjaCB4fSol0Xu2ZGQtW2o5dHRmyv3F0DtU3vQ_sjm-hV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 14:03:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] reftable/system: provide `REFTABLE_INLINE()` macro
In-Reply-To: <20260331-pks-reftable-portability-fixes-v1-1-46bfae55c68c@pks.im>
	(Patrick Steinhardt's message of "Tue, 31 Mar 2026 13:26:47 +0200")
References: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
	<20260331-pks-reftable-portability-fixes-v1-1-46bfae55c68c@pks.im>
Date: Tue, 31 Mar 2026 11:03:14 -0700
Message-ID: <xmqqbjg327x9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Not every compiler knows about the `inline` annotation for functions.
> Consequently, Git knows to define `inline` as an empty macro in case
> it's not available.
>
> In the reftable library though we cannot assume the macro to be
> available as it is usable as a standalone library. Fix this by
> introducing a `REFTABLE_INLINE()` macro via "reftable/system.h" that
> allows the project to use their own definition.

And our `inline` would be used to define REFTABLE_INLINE() in the
context of this project?  Makes sense to me.

> diff --git a/reftable/system.h b/reftable/system.h
> index c54ed4cad6..b15768dbdb 100644
> --- a/reftable/system.h
> +++ b/reftable/system.h
> @@ -15,6 +15,8 @@
>  #include "compat/posix.h"
>  #include "compat/zlib-compat.h"
>  
> +#define REFTABLE_INLINE(type) static inline type
> +
>  /*
>   * Return a random 32 bit integer. This function is expected to return
>   * pre-seeded data.
