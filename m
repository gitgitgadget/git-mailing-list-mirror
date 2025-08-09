Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FC91E2606
	for <git@vger.kernel.org>; Sat,  9 Aug 2025 23:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754783507; cv=none; b=OLx1nfQOaXTi7TH7pfoHIVOHMLIwVuDo+sbjInJ0pFDel4TrG1/4YvMruQrW4nRZvig85Jvo4E4EsKREMmqzJYfFkHZ0A1Jk8pudvJvipPaUYUrW9TMZvbwZwCFx9oVnnxIEbzlyVAHx8Iqko6WRIoznL6LMNkbFatxJ8D57OFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754783507; c=relaxed/simple;
	bh=9hglmvnFU7yfhafO/c1YZkscztONbGXXf8qq4ysj5gM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tvsNuZZ5E5BbjgfnHYt9f6IA0l0RbVSvnMvg/vIH8Bb1xYJbYwAHi8VDPhKuhRyFdoX02Ml79ydLVHoKAN8y5Sgkmc0l8J2Ewtab6CRH7nMMQqkJTksbwFmS34drHfiqM7n6IlEDZ6nBe1q8U/BH0mIHllSI90fc4qNdv5jbgWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MkM5qpvQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HPK6kaow; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MkM5qpvQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HPK6kaow"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A0631400050;
	Sat,  9 Aug 2025 19:51:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 09 Aug 2025 19:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754783504; x=1754869904; bh=QoaJBhYqVC
	SPIhR7Uy12nXtE2Johy1KRkr65Xxy+grw=; b=MkM5qpvQK+LwNvz14mss1TV+x4
	tl8w9cl5osmhCt0OT5fctCcM7ldLkFxXYJc/WpwrP3e0kOD8P1L8tYLfdLls5FPW
	vDp7E4IVkCMvhYSi7mvRKQf3B+M73aQJKbZsWQjOuSa7kDEmOGDTMuW/3YGt/dOG
	PBggj+jiwe196qLULezOJggyj+cVkd32Uaf3gZzw+VMhqB2kJkqDGWNq8l7t6CId
	X1soFYGiYkU5RU0KHudssSDVtatGrZJJCAUSEKWjKppFnapvL0DfrpmUDnyZxtz+
	KMyneE/6OBQrqZcR8M/4A0zr7iUSPRzVa9RWmxWOriP9iOTQyv1MNoydlOJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754783504; x=1754869904; bh=QoaJBhYqVCSPIhR7Uy12nXtE2Johy1KRkr6
	5Xxy+grw=; b=HPK6kaowm1DMmcWC71CaWyFPRPFuzPGr5plhYYVhbaSIgejNHIc
	+RvtaoQ9y5yrHjUTWRdtswQToGWkqdYk/T96UHrCsAd8u+012OYcNv7tjHoliBtr
	bdBDh5TsNFXOeiXTvTSQZsNv0PUMDuA5iORXrtqGhMtJAC40rV+rWx/KcQ4YYLHJ
	MeYW1DYvWmedTSsMi41f8e/9/bazEgyxU6Aii/yXwo13wG8fY11ZsLmWBk16qMBS
	zzlpHY0wm6lwBexKnyMNizRWIIeD6MYjz4k0RGo0WE3NbZexU3eh9cAiqpM1OdBZ
	EAr94Qtia7A+lxztCcm6xvvcfXkvl7MxxHg==
X-ME-Sender: <xms:EN-XaKgrCZHqg8eaOHhtEy0-ZP3dTSYG8aBNJ50Syrlb5ivWaYsMQw>
    <xme:EN-XaGgZE5ANbB-y25X43y_hzUx-CUF2tiYVM92wE1MgYN5JOIqaus0tyWH92JCJi
    Kx_tJQVuM5YzfMyCQ>
X-ME-Received: <xmr:EN-XaIhrdqK8tChJti-HaIwVNlwcXpKVhncn_x-g6t2EC5OOK6rm8it49EpcJ7ibP748Zl4dnf5Qwz-4j-g84IBJuosAevgH4qOJvzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdektdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihlhguhhho
    mhgvvdguvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepthhtrgihlhhorhhrsehgihhthhhusgdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EN-XaOK1fddU7FBy_pFYmknny8w_nnlluLwB2Ze82WNpygGlAeobFA>
    <xmx:EN-XaPHWQ17WI5zQNTiZ1YAJloIhbkFGSWhcOBno1i6Id5eYYozFdQ>
    <xmx:EN-XaKRSZJDPT5DO1ovZ_2i5cjidd6c0jRCSGdkPc-5NkffEcHlLHw>
    <xmx:EN-XaDfJl_v335Ib100Xl_3YveMJXgLD4030Gfo5k988w0aqThvtng>
    <xmx:EN-XaBcSD9d-_kGcI3KPLdpmnX87-8FEa7i8kXelky9ovf1iTenGoFZj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Aug 2025 19:51:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  stolee@gmail.com,  ttaylorr@github.com
Subject: Re: [PATCH v3] bloom: enable bloom filter with wildcard pathspec in
 revision traversal
In-Reply-To: <20250809021642.22195-1-yldhome2d2@gmail.com> (Lidong Yan's
	message of "Sat, 9 Aug 2025 10:16:42 +0800")
References: <xmqqsei1izhs.fsf@gitster.g>
	<20250809021642.22195-1-yldhome2d2@gmail.com>
Date: Sat, 09 Aug 2025 16:51:42 -0700
Message-ID: <xmqqpld45a0h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

> [jc: avoid allocating zero length path in
> convert_pathspec_to_bloom_keyvec()]

This is different from what I did, though.

> @@ -693,19 +698,31 @@ static int convert_pathspec_to_bloom_keyvec(struct bloom_keyvec **out,
>  	size_t len;
>  	int res = 0;
>  
> +	len = pi->nowildcard_len;
> +	if (len != pi->len) {
> +		/*
> +		 * for path like "dir/file*", nowildcard part would be
> +		 * "dir/file", but only "dir" should be used for the
> +		 * bloom filter
> +		 */

A missing full-stop.

> +		while (len > 0 && pi->match[len - 1] != '/')
> +			len--;
> +	}
>  	/* remove single trailing slash from path, if needed */
> -	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
> -		path_alloc = xmemdupz(pi->match, pi->len - 1);
> -		path = path_alloc;
> -	} else
> -		path = pi->match;
> +	if (len > 0 && pi->match[len - 1] == '/')
> +		len--;
>  
> -	len = strlen(path);
>  	if (!len) {
>  		res = -1;
>  		goto cleanup;
>  	}
>  
> +	if (len != pi->len) {
> +		path_alloc = xmemdupz(pi->match, len);
> +		path = path_alloc;
> +	} else
> +		path = pi->match;
> +
>  	*out = bloom_keyvec_new(path, len, settings);
>  
>  cleanup:

Two comments.

 * For a function that finds an error condition in the middle and
   jumps to the "cleanup:" label at the end, it is more future-proof
   to start pessimistic (i.e. initialize 'res' to error(-1)) and
   flip 'res' to success(0) at the very end when everything went
   well.  It would simplify the change necessary when we need to add
   _more_ early error return code paths to the function in the
   future.

   But this flip from "assume success" to "assume failure" is
   something that should be not be done as part of this patch;
   perhaps doing it a separate preliminary clean-up patch is a
   better way to do so.

 * I think the change from v3 (this one) to v4 makes the function
   worse; we found that it is a good practice to have a single place
   to release any resources we temporarily acquired and arrange
   exception handling code to just jump there during the course of
   this project.

   The current implementation may happen to have only one such early
   return (i.e. "len has become 0; we realize that we cannot use the
   Bloom filter"), but adding a new early return in the future would
   be easier if you kept the original arrangement.  The new early
   return condition may have to be computed after we have acquired
   resources we need to release, so it may need more than a simple
   "return -1".
