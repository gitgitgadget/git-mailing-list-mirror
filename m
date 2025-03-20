Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B755218FC74
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 05:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742447640; cv=none; b=GtVGxSUT0Bnsd1besBPP5Tcaonw4J1N8WQNYp0E8P0Uk1JHIBAdKHgi2yxbYxgNLGyVS/UFtRxEVYl0RDl3tqF+XGmeJzZkZ3Wu4u9P9C0o8XQFIfCglppm+Odf0WuGDK5KXvq8X6ncjpRL6XWiRP8txp4TCgBZDlReV6nOAq9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742447640; c=relaxed/simple;
	bh=qpTIqRt0sDI2QkPB7e07q9ErHMpvyFbH4Kx2ebDncM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGq8P7xNKkRH9i7PxBcMJ3MC4Wkrvxv8HSfniXGk8WSILOyWtU6flqltSb5SbcJ1K0YRM/CJ/6BxYZl+DSAgvBRFzGLHRTRT7kt2AJWJNZrygFwrWUu5uwo8CuXLB7eQyzqLEsn5/Nxn2SIHPWSfWfXBTykIN3hgn64DplecjuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ibzSfv9K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oWtAmrA2; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ibzSfv9K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oWtAmrA2"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8A3FD25401D3;
	Thu, 20 Mar 2025 01:13:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 20 Mar 2025 01:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742447635; x=1742534035; bh=DTSKK8zFYT
	wcdhzZh2j16fxY8qpr2MA/VnsF94+9RZo=; b=ibzSfv9KYm9ucImWQYRQDIMWyJ
	kkl/OfCUt1s3k8eW6aEqzZV3eMqDzOleUBUr2RJbthx2K9S+0oSt5pnZi0lzgWgc
	XuKCD9wlRppNcy4bwkliUgQDLPtT9SqqMipjMRFC+wWEdT1cvmgm6Tfb8PioFUZB
	v60xQWWg13+D5gXLyMjjNINsgwRbrmfSHJNi9KEbnbvd4V0GBB9+x4eRL77i97K8
	pljCCYMgUnCm4Lav2FQvtnv/BVtHRFPgg/sIiJndspLYDpfcChhxYjn4R0f9uRX5
	eW1hYTK4wgrf2inHKD3wFDm+q3MpqWaXmRmWDvR0Lu4j28PjkSTlaAjisofw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742447635; x=1742534035; bh=DTSKK8zFYTwcdhzZh2j16fxY8qpr2MA/Vns
	F94+9RZo=; b=oWtAmrA22z0Rh8pEpKrgIadUwn81PbL1MeQplY+E3J3/qMJtz3q
	0a79Qbro3ZOOHTYe+TgyGuWPXJcTTK7gEo4am6Fh41vT/SpqKdqDeKWmdn1fZZxm
	M0glcGQdqcTl4g1Z7Ad2MBnn5RgdhpOOeXAkgWzQA6OmXAuPs5BtAVJW8cBfQu1Y
	JH0IA9mUEMDdch9dEEYl+UEHgGye1RJxIen9c2VOUHZkyC413OWmrfGEvQgDp7Nx
	UCOztEkh+DCffc0ujAOEjYa4iZ16gbS/vqkJ2quCGpQQANMmrW04q9ztkv6KM4M9
	YeuHd6UhCPv7yM7uwOOwuG3XKLPk9IOwYcg==
X-ME-Sender: <xms:E6TbZ-36eji6klMi3ieanVBKQG4MSY-Mgg212eEb0dzWyOelJecMkQ>
    <xme:E6TbZxHhP6qRjvX6gzNlFiOg3a_bsyur01ME4TekYCGZypJRLTtktLvWgKmkD3Twy
    TKTilnk66FdSs7BSA>
X-ME-Received: <xmr:E6TbZ25ydBJvoVsriSVt2SUedwFq_H0qEVgWVps_5rQ8GgFF7itnm7WoSH_-kXhTytN2PxFi0nmE0pvyPsTdiKCfitN9P2OGLTYQG7dc8vOIHlE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:E6TbZ_34rqDzmSiqSxJ8Fr_CN-RXb979oNjDVOxRbe_zMndnalUJIQ>
    <xmx:E6TbZxEWs8mJzOQ9rKl_Pf6SCCBzzaO5OoTOf_mPkeIBgAsUB56z0w>
    <xmx:E6TbZ49Hpl1XtFiNKB1qyXvcN69lfeAq-kGtO6PtvFPnsDCXeQq5uw>
    <xmx:E6TbZ2mDiLBvPGnisY-DogjSIZmQ7m3X4nSyO-9o5LeC-Ak7ciCMxw>
    <xmx:E6TbZ2R0CrcO1rRLmuiyzuWER_nfJvEgU_wnisWq8hHBPoJrkS1y4qIX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 01:13:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 947a4561 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 05:13:51 +0000 (UTC)
Date: Thu, 20 Mar 2025 06:13:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] remote: allow `guess_remote_head()` to suppress
 advice
Message-ID: <Z9ukDuvsLXhYTQAP@pks.im>
References: <fff634dh5qeb4rgjqn7cru7v4a2voj4us4thvwtttxjcdnu2bu@jvv3htcon2ul>
 <20250320014646.2899791-1-jltobler@gmail.com>
 <20250320014646.2899791-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320014646.2899791-2-jltobler@gmail.com>

On Wed, Mar 19, 2025 at 08:46:45PM -0500, Justin Tobler wrote:
> diff --git a/remote.h b/remote.h
> index 6be5031f64..49c7b644bb 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -395,7 +395,7 @@ struct ref *get_local_heads(void);
>   */
>  struct ref *guess_remote_head(const struct ref *head,
>  			      const struct ref *refs,
> -			      int all);
> +			      int all, int quiet);

I think instead of introducing another boolean parameter it would be
preferable to have a preparatory commit that turns `all` into `flags`.

Patrick
