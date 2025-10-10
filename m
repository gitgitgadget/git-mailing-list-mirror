Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56412ED872
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095347; cv=none; b=sIA74OxrZA+cultVCtxpAaTs6Bp4bjlLPa44VrgNEIOdQZUJRhyUV5luM+dTjSRupqTpTqva5GWDVazrykcmEJ/sVjTyjn3jX1an4UJz7S0n6Rh4lMSW7+T/ftIZpq7By3D7OEpy6RWwvdp5kqSDp9S9SMfEkO2U4QDwm1qBoUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095347; c=relaxed/simple;
	bh=qxyfCPjCzqpFBXptt2nm/RIom0OcAhdc8BKtOZFD6ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSsxMF99C1ds/yeDzhDUnOi7rL4GS8TOmP3rYP0VkKPEcyW187qrlecaewj6ZxRMW9HSGWMOtPxdRTjTILTxUQ6rdXAtA4Z+x5IKPA7rLkl7AAi9AUDOM7+x2hZJhM53ybwa3vC6gDMBYEJlNYgZVzmfgGRAu6ZVgiDIPX7BBfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PBSuRb5X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L8ZFLetA; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PBSuRb5X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L8ZFLetA"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5B2C140009E;
	Fri, 10 Oct 2025 07:22:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 10 Oct 2025 07:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760095343; x=1760181743; bh=EKvzNFdJ2p
	KfQgAvRILSOwfmbkuYQbErk2tAlRcil28=; b=PBSuRb5XYMhLnPWV8iW2njczSZ
	ID/cHhGp15B8BDE1oxM2J+hcllKO/m5JUp4ZfkC2//KgshaAXyOgfF6mWjBTbjUC
	0ihuaGiEQT86nuR/M9sysn9ygZv4POvlvbtBU4CkfRsie6iRzVkAmzyPwtfMPgS0
	93tYJP2MUexAeE82EGR/h8k0zUg02EwVVNlMqDYZe8pMGXxnaVXnT6dvcVJVnMlw
	JGiSSIVN/sLHh9kjlViFOg1HnlAmcEJEVsXcB6iVRWYMQVnrD3Qm+K5WSTGOno9W
	/Ecm/F7yH5zS0om3A7y8z5dDka6X3NoXSUqtGNT796tufHb4OusCMPVtGtxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760095343; x=1760181743; bh=EKvzNFdJ2pKfQgAvRILSOwfmbkuYQbErk2t
	AlRcil28=; b=L8ZFLetAjKxqj9+8uXUYiZpmNUn9hplQLEsZHjS0ewuBU3UrvzY
	0braZiinFI2Leaqd+ZQTZhsbne7wTr9rIte59psVIXDgSlw8A5iAguQBKRvQsQ65
	VlYc81NI5CE0RGHm6x+LOMSsncWzcWP3MVivTku53ytwI2nFIjV1nBChqdw0H4Uj
	O+++/+6NThAhwLs1tMsu3PUE6CpkqLJtpxK14UHl3xkPl+FIIeNATTecr8cGLwCP
	IYdbDPp6/i/fF4OsxOg/NJhFr0SH4/tx0knrzs234/00CN7pGXdFCFUgD4lIopOd
	7/RQEdyuhPvSZWhINIlyvX6ZQaT0aWBXAGQ==
X-ME-Sender: <xms:b-zoaMZkMBxiivzO2bNKowS5Npm_aLc-N9EiYfGe8EyRm7lrUAsFsQ>
    <xme:b-zoaNZrQO6JH_3glW_L57_ZWD9DN4y2qJt_IMNUdSlI4wJZdlK1VByCw9SU00hPt
    L_8sSd_YLFm_Y3iU6weZO-J9O5uQcWsn4NYaW7qkO0P40tKfO1SMg>
X-ME-Received: <xmr:b-zoaEkk4YNiLwO_koWSM0BDIgTy5iIO5NDdmLYYf9Lz9W-7YPVodBWhy2zOE70vqHyzPIuf-FQy3-AJkiWgJrsnVCJFCXMhTgF9BoLCaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:b-zoaBxSnFagy31foqKoahqJ7zYx45VTL-io5angFJXr_UUuWEA7DA>
    <xmx:b-zoaKOb6jUyDz_DRj_xndn2H6j07Lpv25dzHuvyeF5kWIMCHytS6Q>
    <xmx:b-zoaNShlC6SvHdQaPOVNiFEi4-Fme7pR-whkg4bQ9YSXLw2eCONIg>
    <xmx:b-zoaAYSskF9zsc76_LeXfaCuT9JHL0ig2A8ZnNhMDLFMsCLrEL7pA>
    <xmx:b-zoaCK8IZbCuLeqPediU7oMosj_22unaS3slK5W1e-Qb2DorU6PjtLJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 07:22:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 228df119 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 11:22:22 +0000 (UTC)
Date: Fri, 10 Oct 2025 13:22:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/9] refs: cleanup code around optimization
Message-ID: <aOjsa3UWw3ygo8FU@pks.im>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-2-c7962be584fa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-2-c7962be584fa@gmail.com>

On Fri, Oct 10, 2025 at 12:27:06PM +0200, Karthik Nayak wrote:
> The previous commit, moved all backends to only use/support the
> 'optimize' function within the `ref_store` structure. With this, cleanup
> all references to the 'pack_refs' field of the structure and code around
> it.
> 
> Modify existing documentation in this regard.

Makes sense.

> diff --git a/refs.h b/refs.h
> index 2dd7ac1a16..c6c955d78d 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -514,15 +514,11 @@ struct pack_refs_opts {
>  	struct string_list *includes;
>  };
>  
> -/*
> - * Write a packed-refs file for the current repository.
> - * flags: Combination of the above PACK_REFS_* flags.
> - */
> -int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts);
> -
>  /*
>   * Optimize the ref store. The exact behavior is up to the backend.
>   * For the files backend, this is equivalent to packing refs.
> + *
> + * flags: Combination of the above PACK_REFS_* flags.
>   */
>  int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts);
>  

I don't think it makes sense to carry over this documentation here. If
not already the case, we should document the `struct opts::flags` field
in the structure itself.

Patrick
