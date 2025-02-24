Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9B113B298
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419768; cv=none; b=gHrksxaeC+8Su0LGWq9IhXCE5uKo1d+xjWVgYRECTDF3aFDs2EjrYPtVy3uoqCIVrlkesnel0/s9Ji8A69a8VGaLjQs9FQhlhuslmAdfY2uSRDdPXkJWvJu3A4TRqGEXH11RYJunwzu7isXrjUkyW3oKLRHTQxmVesu+E9bmvA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419768; c=relaxed/simple;
	bh=AkyuaNlUuPJd1vD9OgvtnG9XDgymbTtDdMt4wAfb+i0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=huso9X08K01bXC5Ebx+xpHnD7YXB09ziuPlGIHWdrgS604/yWejulNOxXaBpso4sRH/hw59mSkc9x7cHujnr/e8U/JSSW5ZCwCHSzaROA75Yg8oI+GxXEocb2ssNIXhn304xxL5XCtXSn9F+9hYeR3po8LcnSO7CekfPwFD3nQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AQKFbUJ6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gq2OT86R; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AQKFbUJ6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gq2OT86R"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 026C11380EBA;
	Mon, 24 Feb 2025 12:56:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 24 Feb 2025 12:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740419760; x=1740506160; bh=qWmi2aPFLt
	Dz+mnGl/9oaoDE4s4ExmyZvcWagIPVxa4=; b=AQKFbUJ62p4HiO62shBIuOIxVk
	nBBBRifhlQXzvotaw524eLnFEvc9pkPXaw+zK9iqnGQ7kbQYhb+wB/Dyuyt4Izjx
	HwfU0whbk0+tzNeWD3wStaNf7XtyGkWYSVwlSKCF86mPiPTyrWYZR5OgJk7MmyKw
	TTR2J6BKu0JdfzqZ/ZEJ8LIplOdD690nTppNhc6UbTZEox2cpgdNS6k8hxmS2GhP
	5+iCfmL5TaCor2tadVTTgF+Dc6bEaGfw7mXVd8Z0Khcyg3HK7Dnb9qXwMhin4Q7E
	K78naqhTh+H3PTGohfyWcyien4fUIml1O2KTkA5dZtffCgPb56O1/bk2Q20A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740419760; x=1740506160; bh=qWmi2aPFLtDz+mnGl/9oaoDE4s4ExmyZvcW
	agIPVxa4=; b=Gq2OT86RZLTwD+aetpfIW83bKj2LzoGfLN8/ibaqVJtGOPL48Su
	bbzpEXban9JmFgznl5N0wWyKf9+xicBBwsJJWvP+kV5SSzs9QNVDGIft393jQW0T
	7H+gPwQXqPhAQa9akDNhsHaf+7y3S8z5bQ/k8BL4tJkz1+58TjhZKZdxvsUb2Ody
	tpY2LJASzUUe4Q+SaMCinDG8oyEa+Jeqjj+m2VBVOwd8BEVCi6xxt2lmyf1i5RSP
	UaOHQvI21eAhhE/RIoI+hTb0OXGqu13cjlPgZd+lCZzCok5fQDA5LUgn/gLHtqVN
	WquN7Ln53zYyl3eBpva0xm7xzEXuMQvh69w==
X-ME-Sender: <xms:r7K8Z4KhXBWk-ttrKbCQkMd2iC1yYN6w_1eo9JNi50Y98oYtbgsScA>
    <xme:r7K8Z4KsWTkt2OxeLzFYdBOjUWzSOnUpam4MV1kdXu_5nWLPzy-NZxM7XLabZo2TF
    Pr44aF67S3WALumMQ>
X-ME-Received: <xmr:r7K8Z4uXY7eFD9lVSsAQ9jBzHyObtfI-lruVWHz96xBYvYpLlbGEykdPXiUENATF5OJFO1N5ksijAwwrEYGlKI2I9LZNzifp-NtiFYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhhfohhrihhjih
    elkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:r7K8Z1bUlRKJLOTP7smH2N9aM2mlFaqaUEe-3G71nVO21dP4qj5OZg>
    <xmx:r7K8Z_ZwHBZz8YhMQc--KjOidFe7OpWxRO6nPHtBc3IOf51A2NtWXg>
    <xmx:r7K8ZxC5R--GvZFvt7COXwcXPiZyy_l_nOKZ9RxRtibZb0v64s73EQ>
    <xmx:r7K8Z1a9Kz_gVH_OA187enjwrm_h4Jnpo3mtYTBKuxgW8Y0E81GDVg>
    <xmx:sLK8Z6z1modk_HeQoy4JBH7N4txWMUPsg-5YqF2Fx2Ju0ZtzVxQ1JHq7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 12:55:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/4] t/unit-tests: implement clar specific oid helper
 functions
In-Reply-To: <20250224152704.70289-2-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Mon, 24 Feb 2025 16:27:01 +0100")
References: <20250220082959.10854-1-kuforiji98@gmail.com>
	<20250224152704.70289-1-kuforiji98@gmail.com>
	<20250224152704.70289-2-kuforiji98@gmail.com>
Date: Mon, 24 Feb 2025 09:55:58 -0800
Message-ID: <xmqqwmdf5is1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> -static int get_oid_arbitrary_hex_algop(const char *hex, struct object_id *oid,
> +static void cl_parse_oid(const char *hex, struct object_id *oid,
>  				       const struct git_hash_algo *algop)
>  {
>  	int ret;
>  	size_t sz = strlen(hex);
>  	struct strbuf buf = STRBUF_INIT;
>  
> -	if (!check(sz <= algop->hexsz)) {
> -		test_msg("BUG: hex string (%s) bigger than maximum allowed (%lu)",
> -			 hex, (unsigned long)algop->hexsz);
> -		return -1;
> -	}
> +	cl_assert(sz <= algop->hexsz);
>  
>  	strbuf_add(&buf, hex, sz);
>  	strbuf_addchars(&buf, '0', algop->hexsz - sz);
>  
> -	ret = get_oid_hex_algop(buf.buf, oid, algop);
> -	if (!check_int(ret, ==, 0))
> -		test_msg("BUG: invalid hex input (%s) provided", hex);
> +	cl_assert_equal_i(get_oid_hex_algop(buf.buf, oid, algop), 0);
>  
>  	strbuf_release(&buf);
> -	return ret;
>  }

As you are not returning "ret" and making the function void, you
made "int ret" an unused variable that needs removing.

Thanks.
