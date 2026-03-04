Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1130C610
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 06:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772607468; cv=none; b=DTJjAUVoggS0D2jIyCxBzNKS46XBCOtMWU4tnwsUDVSnRDo+/6HJ2RNZSRpSlen9TRelp+qp1OWlFPALSO3vlFcGguHFnJqO2N33S0fJozegn0ef/pEF8MgfFp//Za9yctaab7lxA+j2XcPUtd1CaGK1cdvGmWQMtObl6iWo31A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772607468; c=relaxed/simple;
	bh=3LSpPGpuo92TubDEDpPi8Olo4eEURfKGp9Rb4QcWdJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugHtx0D7iHMONlo55WG8HdYCizcULPTxBGsP9US/f3zju3XWFqYcq1Aju7dH+obHDWOV/Q9jR7Bhc33Klebg0Xb/EtC8HDwb6kq93w4HydqdmWsBMgw+jwcTvMwVuGkoV2J9GQBnc1DnWlehqFvY5vPSMFzLX36gw6UG7exIGO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vh7Gs4x0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wADrCu2R; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vh7Gs4x0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wADrCu2R"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 13A6A1400169;
	Wed,  4 Mar 2026 01:57:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 04 Mar 2026 01:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772607466; x=1772693866; bh=JuoIE6EWzV
	nXj5DDz5slDTZUC7RGBj2f/iANusmVjwI=; b=Vh7Gs4x0GhC5gWXN0pGMySsxbA
	ZOHpozOE5E4ug0VjCDuoq4OHH+ReaDtUkk4m7yDu9q2tqwM/azCtEmbWpwachqd5
	VYOgx40vJxpcBWPQ4WBpNuqbZkfM5P297sI2dm10JHJG03ecy8JNDUE72JuIQAMM
	hGh2kUhdcniQYLuwaWckNPdzG9+xBeT6AEUZA/bOgcnfC50afa9UGsz70CrLXL9/
	Q+BF2/8uLY8RbqHC37Ktxe0pQU5IR0jTkeqi8F4bqP7fCIoPKnQbsPZafRn0Gigc
	Gi1gbd4hS/TNNFtALpqmCQbXLIVLAs6CtNPqN2yk2zQGoE8JHob/302UaXmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772607466; x=1772693866; bh=JuoIE6EWzVnXj5DDz5slDTZUC7RGBj2f/iA
	NusmVjwI=; b=wADrCu2RUStv0GTHONOh8t+gJ80KEyTt2ASOjRFk7BjW/GlTK+4
	l8YL+06oLhgz6vkcYWrxILU7WdA3qStpERSjlDJcpvtSvedRuncYlU3eQTSGCjtK
	/rG/4DvIzNECpJhD1hAWIRbkVKZrDr4v5SqKgJdwIjTnXy3F5mzyrM3TxDv6T49z
	BHz03DyNRSz3P/jVoQKC2zyFM0/yBDi0qyidQnJxrTlOjnCPoIpfJNqXDuD6+KeZ
	8sAG2ewPVO6SoTdFB/vsqpJ1TZISgC3fqoaxHnt4MmOd3UCqp7Q4x0mm+Lu1UvX8
	FujObL6eVmdHekSGfr98q48vJ0dOth788sQ==
X-ME-Sender: <xms:6denaR3OySj1_BPU4rwCyeBAkN3f5TZNNC1n5CIHgtQueYQcQicoRQ>
    <xme:6denaeFvaq7kZVR8HoQc8O_MVa9JQiDG_wie2mdLy2HKDGkBDw_B5mq1v_kWXkoE1
    -woQ_BNz_CdN-AY1dFZNsUTpLe8KFilYZLQH12pK7Le1l8rXwzk2Cc>
X-ME-Received: <xmr:6denafi-iln7CmapUvDARHQ-4vMAuqC6fC2CSu9Dmp4J0XTRZ0YWcChs-b6rrnWyuD9Em49jdBNRclcsVXdgGo5Qo1EpkEp9U9kTS1ES8LK26Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhhfohhrih
    hjihelkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:6denaZ9oIAy_UZ885ZhDIErxa-L0xY6XXlGB9-jWOkrjGUKqxH5KcA>
    <xmx:6denaWrjJYYo0VoH5-rfYPRhqTtvdP9ZlnHWEPrIvRio-QL4OjF19A>
    <xmx:6denaY_7wldJl9X5NeqKtvxjVW8wJJDeqRCZPRRwn6C46j3zVmltFw>
    <xmx:6denaaVIcFEIY4EBFbTrLDB44bQ9hh3bcC-JjVAnwqvVtzcxfyZ2fA>
    <xmx:6tenaemiv15OFbXAI5RhUvp9mbWe19xRk-Xpdz6avoY6I59uienHq4ey>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 01:57:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba0acdec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Mar 2026 06:57:43 +0000 (UTC)
Date: Wed, 4 Mar 2026 07:57:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/5] builtin/rev-list: migrate missing_objects cleanup
 to oidmap_clear_with_free()
Message-ID: <aafX5CmP82WYFyIb@pks.im>
References: <20260227234213.17633-1-kuforiji98@gmail.com>
 <20260302200018.75731-1-kuforiji98@gmail.com>
 <20260302200018.75731-3-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302200018.75731-3-kuforiji98@gmail.com>

On Mon, Mar 02, 2026 at 09:00:14PM +0100, Seyi Kuforiji wrote:
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index ddea8aa251..ab5f69826c 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -88,9 +88,19 @@ static int arg_print_omitted; /* print objects omitted by filter */
>  
>  struct missing_objects_map_entry {
>  	struct oidmap_entry entry;
> -	const char *path;
> +	char *path;
>  	unsigned type;
>  };
> +
> +static void free_missing_objects_entry(void *e)

Nit: this should be called `missing_objects_map_entry_free()` according
to our coding guidelines.

Patrick
