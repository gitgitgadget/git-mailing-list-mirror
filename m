Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657F319F103
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 05:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742448293; cv=none; b=os5s2nES/9qGRgTNixbZfWawzzvVqkqADY8cbFj32vPSk8jPTGld53yfBaN8SAY5FcSHu4c7Ob1cMJIcDAC3piVMrUgLna0BQi9Hl292EwjCQT/OmtIdsKxu9EssbIiET7qMhPHPxyNFeGqkujGG4kcbe0C9BEkQSfHF8h9neCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742448293; c=relaxed/simple;
	bh=C9iJFdBM/dMrUmgaYMjZY86QqRvby7xlZm4B1vlZpMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZcq+ffupJSswvnli+AexSqDRNtdm5Mts6/vj7T9e50CDOc+GUweHgFNdFWW7IL/aW2o9ShlJr7uYs8yJs4mE9XFBQrfMWFW4ORYcOoAIcFXHhWNMJ7zQyZ2HsR/y9xHF0DP1FQDXefBCtFm/+2QwY4FqKMdqO4qyIS2PYjtleA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X6EDnDQi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WJHxTNm/; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X6EDnDQi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WJHxTNm/"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 525E325401E9;
	Thu, 20 Mar 2025 01:24:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 20 Mar 2025 01:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742448290; x=1742534690; bh=OxFeWtdZpu
	R/n8j57/y7z+Mh55eiMMrLGTLM+DTk91U=; b=X6EDnDQiDl8Zr310detaJwYDEh
	B68n9qZTONFs/Z5MxRwcPSnLZD2D8WCkvprMYd63+1xQjCwOcDKDK72oPtdAepVF
	sld06qRRSc9EKVw3F2s0DZb/DM5MHp+XqT7YG2mUrTTjSI67oyQvBkitCqrG09Yy
	QED5YmwtycU9cSDUBm9xUqLyaPxuKs1J15HPk0+Lhh2ftknUlRloy2Sqp2VOrUEC
	bne7kTXqiKSmJpdaYKegMa7Da3tDRO9J1bqa0SSLTc3O8tmT+3/7yhsG6Ui++8ys
	M5n7PinMhOlCycuHu5/GpQjripjgs/v3PEHRSrUhdKnRKBQDouL1RgDxrVmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742448290; x=1742534690; bh=OxFeWtdZpuR/n8j57/y7z+Mh55eiMMrLGTL
	M+DTk91U=; b=WJHxTNm/ARWkj/cdUuy1pTvW7KOZr+Hcb8sip84yfHv1CCV+gIj
	NFuOjdOUvQy+ooc0xLCVFtbGfKoXNaWGtqi5ZVYcZE72STZuwhNAuhDdQ20/HErA
	DJRwcEJzqNLy/E4PKdj+5O+0S7c60YxGGCECv38gj7XNEerMG6D9M3YEPL1rXy/G
	nt2JDnRFgQ3lnRcZuGofC6a9aJjv/PckG7yG2MaQJjrlOj/fFcydbnpNA0XKJCds
	iLqIPGFJ20sOegnqYLO1O8n1MTJIHf1Dzc0cSOt7CWcLtWAiJo27uWqnO+53OI8G
	iLibmsaqZA2LsITz2++HZ8m7mwwIAKvlfcQ==
X-ME-Sender: <xms:oabbZ6ttnhdezeO3xOZCKMhFU00JI7leFRBpZGcqH3AWnBdEeKGjCA>
    <xme:oabbZ_dvlhChqK0Qt5au1N5355tlzCEQsLCMruUKy883zxGaYupBnEQ5ff-VWHX7A
    5obzIvPFUmX5w-ZQg>
X-ME-Received: <xmr:oabbZ1zuuZnseCd7U2yOWugpeNZNOm8EvVsMv0Z5bQTDEkJe97J7Gk49Tm__I6wNyHTY1PYvXSoRgSHpzozyVf7KQnYmm1sJmCPGf4FmR8tILYo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:oabbZ1ORBEo3XhtLIoQmA9BTRYF_ijQNT4g7qRkSqBhq5f6WFHeVKw>
    <xmx:oabbZ682Ss19vPj8N_xgU6LXsaqrrT00KXRZwzxGZ8M1MO9tceW8PA>
    <xmx:oabbZ9Ue9cFFYwPxpBy4RvFjUuPgE3ahFND6IvoOSfouYQKNtEE9BA>
    <xmx:oabbZzcQC2QshxYbXM6qnKXvE6CBeO3SPlFHeMsLcbHr56_WDPhyPQ>
    <xmx:oqbbZ-bOY5pXuqsaKEgaC3Z2L8Fhe1fP72cHE97DYlo6SP_uJ0ZYzr0I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 01:24:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4641276b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 05:24:48 +0000 (UTC)
Date: Thu, 20 Mar 2025 06:24:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] http.c: introduce `set_long_from_env()` for
 convenience
Message-ID: <Z9umnwmhZTZ82SnU@pks.im>
References: <cover.1742336481.git.me@ttaylorr.com>
 <cover.1742423021.git.me@ttaylorr.com>
 <2e39a78e87edaf8f9842e510d05047dce647f4af.1742423021.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e39a78e87edaf8f9842e510d05047dce647f4af.1742423021.git.me@ttaylorr.com>

On Wed, Mar 19, 2025 at 06:23:50PM -0400, Taylor Blau wrote:
> diff --git a/http.c b/http.c
> index 0cbcb079b2..17b676a1d5 100644
> --- a/http.c
> +++ b/http.c
> @@ -1256,10 +1256,30 @@ static void set_from_env(char **var, const char *envname)
>  	}
>  }
>  
> +static void set_long_from_env(long *var, const char *envname)
> +{
> +	const char *val = getenv(envname);
> +	if (val) {
> +		long tmp;
> +		char *endp;
> +		int saved_errno = errno;
> +
> +		errno = 0;
> +		tmp = strtol(val, &endp, 10);
> +
> +		if (errno)
> +			warning_errno(_("failed to parse %s"), envname);
> +		else if (*endp || endp == val)
> +			warning(_("failed to parse %s"), envname);
> +		else
> +			*var = tmp;
> +
> +		errno = saved_errno;
> +	}
> +}

The `saved_errno` dance feels a bit unnecessary, but other than that I'm
okay with this approach of only printing a warning instead of dying
right away.

The other patches look good to me, too, thanks!

Patrick
