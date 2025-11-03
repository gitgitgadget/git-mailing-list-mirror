Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4A1D9324
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178429; cv=none; b=dD0XDqDwhBoLDnaA64J9wpOXhUZxN4ZuAGNXQzzhxsbrb2J4v+Zenw7e4rfqhxblzvZ7wUbBxSLSpncoxbrgEdwKwcqE/XVXCG39E3UHFKyz49W7qJPjjqAyVJwpMa8+eb2awO00KfjBfqVztKMHHb3Cyrj+evUJj1UnKyFBf68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178429; c=relaxed/simple;
	bh=UyiPKv4ArfDL55X68nwN85MakMalI+izahViCQpL5ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQlvIWJe2IDCBTbdYnDwxUWvQ69RjifBspUghIQcrEsDXq7JePJFfOex6zHHOGayzIo1RNYTp1Cekhe/yzx0Eb5mqHs3uEWs2vQws3wc36imuFQ34X0Ayz2rxXyFvPIs9yZxkauUsIUNqtjyJaKBdL125WZWpWsnYA+gd6s7WOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AmAjOLGY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zt9DgomV; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AmAjOLGY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zt9DgomV"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 855C71D001A8;
	Mon,  3 Nov 2025 09:00:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 03 Nov 2025 09:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762178425; x=1762264825; bh=BNciQppWn3
	1verGSNFx9Q12TOWsM4RzOvpGYD9RMpTQ=; b=AmAjOLGYPHUoT9Wd0b9t9zc/VN
	6EN9taHKb2FYIGB53I+50isaFS+7RrsKX10OzjPREXGKhigkAsaggo7wy38X3eJS
	hdpA1aetVlCeqwUcj2wb1anS7XFOT9WNVZwJNMWukd1VXowFfnGLZRi+JT03lg3M
	zu5gKYQ7qIlMSkOVOSswFgc/ezUST12YYYXoa1SqMFUX9TSACSma7GN3iD7IJnqJ
	Nr8SV1u/HyTSmUxRfHHvSTJgnbWwRCZB4S9SsO6rHig3yuQsjtXdTpQ7SIPfCHlq
	1LZoJd9AvmYmlQ1NVef9Ks98102hTg3lvzQJQWwzpyqMahlM41JuYjgA5rzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762178425; x=1762264825; bh=BNciQppWn31verGSNFx9Q12TOWsM4RzOvpG
	YD9RMpTQ=; b=zt9DgomVCZW1NPGnIluBZy9liQVHWGpw6vtVhwlGlZxkj2Km8pH
	hVlsJY0UMk3x7QFnewZndC2XqHuPHVeNpyVHmN5gEYOm1EyG7RTKQhMF4Ny7mZYx
	Lb5o0uOEyFida8GkiylJ+wX+saGYeqHxz8rmvliXkgKIK0BIdwkMi9bzafNnDXZg
	WinlvHzCGOJeR9Y7oY5JaJJP/WxLqzYJp+ryB8733Bl7Voqv+wYpKGdu8eBQogfp
	nrJEJNrjmqtV7nK0Ou1/cdoqGRAOQ17vPLb9EZaVixbRR7bhvOl6q2+3lDLBDipM
	RVMbqe+0zymieagrPybaUBnEl6g53iGG7TA==
X-ME-Sender: <xms:ebUIaZXgsuXDU7p6Y7j836waoFhj6_12iQhTJtywRLYd3gXUHU0Bfw>
    <xme:ebUIafkc35oaDcDc-A-68jpJQAwNSdDn4e-eocb6Nst_qm7w95owaXsBkAzbVoR7q
    EEfTWkRKyUIS5mWD6U9bHIoL9uKpP1XwK0qOvUC3hpOtpFGF23mUMY>
X-ME-Received: <xmr:ebUIaTAC3Dzimis-pxYPKUg6J39zDAWJAEpZThiFesYCWhoA3tK400C0AvwIBUZHp7Oqtcm3lQu2fGZEGP2oOD9Xdc8FVH1SlMdAu1u0nypN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeekfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ebUIaXdXvl8VZUeYzOoHWo3uXvjB-SnGh5__n8qLshSXRNMFn4Twyw>
    <xmx:ebUIaWKlGoRp4XLaByfxDEmczFwqCAd1wpx_RNJynkHh_8-50OOLvA>
    <xmx:ebUIaSdi3j9OHtaIRyQ7YpXXthNMpydQpudzRYSEmGinDatU2oO0eQ>
    <xmx:ebUIaV2HZycqYPJ27gc5r1_BP4x4JXotY0AmJkk33NlT7SXz6nLTjg>
    <xmx:ebUIaeEcU9j5xodmbEx-liKNfWDVIOFjbd064x3Qk8mFYmKom6bQRpw3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 09:00:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d2399518 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 3 Nov 2025 14:00:22 +0000 (UTC)
Date: Mon, 3 Nov 2025 15:00:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] reftable/stack: add function to check if
 optimization is required
Message-ID: <aQi1c6ZLM-1dqrCI@pks.im>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
 <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-2-a03d53e28d0e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-2-a03d53e28d0e@gmail.com>

On Fri, Oct 31, 2025 at 03:22:22PM +0100, Karthik Nayak wrote:
> The reftable backend, performs auto-compaction as part of its regular

s/,//

> diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
> index d70fcb705d..a875149439 100644
> --- a/reftable/reftable-stack.h
> +++ b/reftable/reftable-stack.h
> @@ -123,6 +123,11 @@ struct reftable_log_expiry_config {
>  int reftable_stack_compact_all(struct reftable_stack *st,
>  			       struct reftable_log_expiry_config *config);
>  
> +/* Check if compaction is required. */
> +int reftable_stack_compaction_required(struct reftable_stack *st,
> +				       bool use_heuristics,
> +				       bool *required);
> +

I think the documentation here could be improved a bit. Somebody not
deeply familiar with reftables wouldn't know what `use_heuristics`
really is supposed to mean.

> diff --git a/reftable/stack.c b/reftable/stack.c
> index 49387f9344..18fa41cd5c 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -1647,6 +1647,31 @@ static int stack_segments_for_compaction(struct reftable_stack *st,
>  	return 0;
>  }
>  
> +int reftable_stack_compaction_required(struct reftable_stack *st,
> +				       bool use_heuristics,
> +				       bool *required)
> +{
> +	struct segment seg;
> +	int err = 0;
> +
> +	if (st->merged->tables_len < 2) {
> +		*required = false;
> +		return 0;
> +	}
> +
> +	if (!use_heuristics) {
> +		*required = true;
> +		return 0;
> +	}
> +
> +	err = stack_segments_for_compaction(st, &seg);
> +	if (err)
> +		return err;
> +
> +	*required = segment_size(&seg) > 0;
> +	return 0;
> +}
> +

All of these conditions make sense.

Patrick
