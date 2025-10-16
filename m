Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE21732860C
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611096; cv=none; b=LTPvboZhNf5eSmixj9TzUgLOz630B56sI0YA5enklvyQdDbYnnuBeS128Q4MIC8hGvqBdXqcGP7USG5FkpvUtjYdD+ZH8BeF2gGLe4oLD8S+anPD+0PCCr3FPEzYFzneQVjZVskHBU8Ps4vefZmcgUwRaUAOVLjJ4ffH8M4Asgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611096; c=relaxed/simple;
	bh=QI0cs4ftmH0qY73B3Uauqr8guYwSLhQwsgp5IX4BcaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VETiRY1GU6sOpJ0vZy1uJfjmo/CIL3E1V3O2A6OgwxpBAtLsfvznSlrBubmmxxwY25Ti6yTBYowa/7lKrNPgEscHyNZU/g/uH5kfnsKy086BY7oE0kJbDBcGlkaWRDtVoyU7uyY70QJxNV3pdMlOlANL38Fpi6ovudK92nvOumc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VrhMH4HH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n6WKDDex; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VrhMH4HH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6WKDDex"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DC81514001B8;
	Thu, 16 Oct 2025 06:38:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Oct 2025 06:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760611093; x=1760697493; bh=L+SXs3TKI2
	2IFA2sJtulZzaTMVHexC0RV1ZzvolCyR4=; b=VrhMH4HHqb/JvuwmTF8t0hFuK+
	T4xIKTFRpu7WZf5RqgMrgYysL0WDiMbcC9XThUSAw9MoEbI2f0nc9fsSQqkr3Be6
	gSPYBNWGvXCHiQ8yjIPw5sBkcVa1BQ5cK90tGYQedaKi6HfOzkThcdN59FgcIfFv
	hQmG6SE3TqO+qJNdTd3JPMA3NEsFKis+tfxrXkVDuT9K/XHTqZHb1CesR0Z9FWTG
	pVZ7q9WlXmaWtBH36x0o1PBM9jbTbj+nXM+eZzQqs/mkg9IoKa7x4w8Bs/Jjd7aH
	e2vwwdBJvxTaqVOO1Eep7LqZBm10e6DzefVOD+fh9owLOLUU58LgBX2LwvQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760611093; x=1760697493; bh=L+SXs3TKI22IFA2sJtulZzaTMVHexC0RV1Z
	zvolCyR4=; b=n6WKDDexd6yfO87M50kqlR+uBIv1byENcN0Fs+KIKHIkkTkGz/6
	kQMyyFQyb4EN3VQIkDBw8BJQ22jZ+Bb488PWi+lo5j/vzAMxiZDwdT7gE/oxHTUI
	Ba6IOHWrKUXGxjZT9wjvwzdXZBikuQQl0cczVBbVDmQEd+6ywB7JZ0gQLSg4fUYa
	ORqKrRJpyGzOLx7FmGwTKmLbxgvfWic9szKJjMoNwSQ1Ceme2JdHRX88kpJY775J
	RKwVk5p5T+uvUnrOXGhumlheMdBJ4kJGa4fp4flLpD3LurpNGZdYfoArCTA+nUG6
	1js9bn4FtAlbgPdJdkEMPOJ5CSlVKG6ZOzQ==
X-ME-Sender: <xms:FcvwaEbrnjdlWGNijAIoXbtppceMHznhBagA3edW5pC64J2_qGADxA>
    <xme:FcvwaG0IZcB2tQ3TNMR_34rnfp2VqcnR-3NhluXG424O2bhSbGW8QCHIvXnoeXSTJ
    zM6QMK3r5EC93G1yxNlIa5gEpvB-WHz6QC52e1D3USDGZxIJ4wp>
X-ME-Received: <xmr:FcvwaMWMkC_dNdICx_zEajYAzjyVDKZFLSinWfo0SJITEwdk6tb_j1KRyWzND6oNGb2Rbhs6fcWn9RWM6At2y8BIvMgfympaVSNRy6I2cdzPlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeitdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:FcvwaIVxa6MoI-5C8gA4FtBG7YU1CcLxzzsy4w4K-lXAYBwYgLmx8w>
    <xmx:FcvwaDdPuoP_uNERdE6KCOV-uo_I0vFI8AMX4Bx9uRwLG8oNok95ug>
    <xmx:FcvwaJWlxDyxas_mzu7j4h_DLg3l3dOUPgyVnvE1F4WBhYiwT_wt3w>
    <xmx:FcvwaEdordUZNhU5ARVUOTHz9hIMr68p38miLXldEye_nuv-C_S7zw>
    <xmx:FcvwaITfkiKqNeSJPh3UmKc8BtzwHGSD-bfK0ftF_bPibZx1-L6IWr-->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 06:38:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7c475f00 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 16 Oct 2025 10:38:11 +0000 (UTC)
Date: Thu, 16 Oct 2025 12:38:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com
Subject: Re: [PATCH 0/4] refs: cleanup code around optimizations
Message-ID: <aPDLCqDd7Sri-0xb@pks.im>
References: <20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com>

On Wed, Oct 15, 2025 at 11:25:05PM +0200, Karthik Nayak wrote:
> This is extracted from a recent series I sent [1], which I've since
> dropped to follow up with a different approach. I think these patches
> hold value individually.
> 
> They mostly cleanup code around 'git refs optimize' which was added
> recently in db0babf9b2 (Merge branch 'ms/refs-optimize', 2025-10-02).
> The code in the refs subsystem contains both 'pack-refs' and 'optimize'
> functions, which are one and the same.
> 
> This series unifies this to only retain the 'optimize' functions and
> naming, since it backend generic.
> 
> This is based on top of master 143f58ef75 (Sync with Git 2.51.1,
> 2025-10-15) with 'ps/ref-peeled-tags' merged in.

Thanks, these patches all look good to me, except for the small nits
that Justin has spotted. I guess this can use one more tiny reroll
before it's ready to be merged.

Patrick
