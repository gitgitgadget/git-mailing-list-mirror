Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D330B532
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768223353; cv=none; b=VkUr+upuHCJR9hd75NvjwUePaO1uCodosHLkB7WTWN+e4AZkR+IbVAf+r4xe8U4RP/TOURLt0Rzok+yA5xgLxFhEc38E+RMu6wuWGa0j19RhYGJSq6R8iXmF+zuDymJhlziICcsaSzzpZwZe5Y41Qxkc6Vg5YkOZckH29n43T4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768223353; c=relaxed/simple;
	bh=GRG1O2sqHDvXnDU7d3GPSYK0dYIcPuZ+PXmI8r6GjiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPH5uAaJTgDbb4Inq0ky/Z9XuRl9nVSz+Mp6oCYcbnQSPx30j8txtgwno2Nd6FwoClpuRNSldl/qw+uOikYdabZWo4V2e3uL7f33aLHGIcFZ7vvReljYIaw4R/g+mwOD2tcK5TkHuvf5pH+zlhWYyF7+WHrBlC4fCJhTyvjuI9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DC8KVyLr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TzSuv5FL; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DC8KVyLr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TzSuv5FL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 67437EC00DF;
	Mon, 12 Jan 2026 08:09:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 12 Jan 2026 08:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768223345; x=1768309745; bh=9OQxHmz59o
	2ldDEI6spp81oXu3AYqlLk6PWCFfbTB08=; b=DC8KVyLrs3P4RjDa/jbfp2PuLT
	kNhagh2m9IROHMVCjbonmf15CH9bCdZpp1x31gKfPzh8QEvdm46pI3DNcp5C1icS
	pu7B8MIv5GL+Ux4+cKgweKkz/yzh+H2pVWYBOXFUvVh0DRvwVi/SQAFq/ZF6jq/9
	zsjyLPwdJRSu4KzpXGdq5Fnu5GxKe9waK4YTapNcn4UddhTvLbVlf+ckxPzDl2Am
	YmrHQ+poYw7pqusPH7r6WcISRQyI4z8LF32iymO9Joo11XzpAbFe0JN9qYjfEJtE
	hvTqJ3Qq/gA+i++XK9ssJj04cbVSg0qhOGqZVxgZtvy7b9wNvXONlBKk8yqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768223345; x=1768309745; bh=9OQxHmz59o2ldDEI6spp81oXu3AYqlLk6PW
	CFfbTB08=; b=TzSuv5FLrineJYXTHg7UecRfuwLSlTeRjLrxxzHYxncDjePJ4bT
	Rer2wIzqWDO3Wg6nW6ZGr7qgnTCEiVeshKOjDpuY7AM6XAPKr7UMdjRt/rqc1190
	TWnehYKAuJeNzTrqFi1lBcQMoJ2LJlKL4a3nOzemhuo1CHaO/AkymHYDw9jCJBwk
	pO1hhYpLAiMMX8TNHRNmZHB7P46d+EZ0/3NUwmXpVAMj+DPzWSTCnj6siOy2g/bi
	XY33475JruF2Umemt/uk80kUtOCxH4iuzAZ18t8+ryEsJE5qGTb3TkBm3yTyc/fY
	TMR2jxk4wkNdKMwo5Zr104T7AtURlquYGMg==
X-ME-Sender: <xms:cfJkaYJrnbu9Lf3Jr53lOHi9oJSgb9QLSZkIAxK9kNVeLMzU9cXkpQ>
    <xme:cfJkafmJR9pBot-hdUSKg7Tar3z3Qdo-hFlnlCQqinZtLgXYzY1I1JC989rLj_0a_
    TvRxr_l1Fr3E_f9cCJcrV4ZpLw2HcFJIf9rPk_JSU_RTwdr8ixxfg>
X-ME-Received: <xmr:cfJkaWF9dYo5D2t6QGNvlLv0GUNm_ZnPLvvBDtd3XdlLUtXRHjlfrr-9ThAzoMMCIaTAY4rkwusI9HeZujSoC_vNwWTgsqz_xWRrc2V4Hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirg
    hluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:cfJkafEL4h6yZZ-TBxnL13Vdh2gxY1RO7ZMfgmdl2tFNni9vGjHuZA>
    <xmx:cfJkaTMXh6eRPhghGlUbrwEZQRtaYRYVkYCAoJ7rEdnSv-JScTR91w>
    <xmx:cfJkaeEz8lr9rNjKG1kVLBjTKERyWt3mp-SfFKO4HCqXO9pTGW2X8w>
    <xmx:cfJkaaNG-7Lb0qR_AOveseVTg03tyuvfOewfwN0nNWSeMwdFxHxdwg>
    <xmx:cfJkadCZhYk-_nbVyYvRJwLm-6TezH1-z32KOwyArgjeTwjOdUC2EKXK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 08:09:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a077392 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 13:09:03 +0000 (UTC)
Date: Mon, 12 Jan 2026 14:09:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, shejialuo <shejialuo@gmail.com>
Subject: Re: [PATCH v2 00/17] Fixes and improvements for ref consistency
 checks
Message-ID: <aWTybZHqZC_H3dGS@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
 <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
 <CAOLa=ZShPP3BPXa=YnC-vuX4zF=pUTFdUidZwOdna8bfVTNM9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZShPP3BPXa=YnC-vuX4zF=pUTFdUidZwOdna8bfVTNM9w@mail.gmail.com>

On Mon, Jan 12, 2026 at 06:50:17AM -0500, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > this patch series contains a bunch of fixes and improvements for ref
> > consistency checks. It is structured as follows:
> >
> >   - Patches 1 to 4 contain a couple of cleanups for the consistency
> >     checks done by the "files" backend.
> >
> >   - Patches 5 to 7 introduce checks for root refs for the "files"
> >     backend.
> >
> >   - Patches 9 to 14 introduce infrastructure for shared checks with the
> >     "files" and "reftable" backend.
> >
> >   - Patches 15 to 17 move some ref consistency checks that were still
> >     driven by git-fsck(1) into `git refs verify`.
> >
> 
> I reviewed the series and it already looks good, thanks for fixing some
> of the broken parts and cleaning up.

Thanks for your review!

Patrick
