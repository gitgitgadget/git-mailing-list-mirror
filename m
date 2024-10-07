Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285382AD05
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728299540; cv=none; b=dCqv6VLGWn+QV9vnduY8e5z8OmApUTBFYr9IpTMorKTUiaa2YfLK2u5dSg5ncqe8hISnAsrkMOFHWeGCHTCnFf+oWGzTjjFfac8RAv8BE773e0WtSptI7V2YVKgmkGza1KZblEW0CUla7asHWX/9TTCzeEccv4hU+QfE7BuHyEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728299540; c=relaxed/simple;
	bh=HTXSs1Eyy9mEvoTLoyzuLq09bGpc9tJIV9TB+CVHWKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umhSW8us+2LqHVLg3/zUc4EZuQXMVLFHlcn7xDAB5ocYgPN1hUWmXa4sDWvooJyWC7BVwRHTvzIono14g3SY5RvPRBdgnmijDndTd6EIqtcuqBE/fs4GAyzVCAKqUtA5IfmFGUGLFS/y0kju1+4OCzxZguDx6Y84hMV0bAKauL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rrsWXQHo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lsoSpRL+; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rrsWXQHo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lsoSpRL+"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 22D8B25400BC;
	Mon,  7 Oct 2024 07:12:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 07 Oct 2024 07:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728299537; x=1728385937; bh=ma2eVetPwL
	aZVZGhCMg6UOzQWMP/CmhcD6hDnGxlNQw=; b=rrsWXQHoFeg74Icm3joUm5jO+0
	6I19QIWe4524YtsEdp5BILVDgXfunYwULBQzudLVDxYh8WofPSNlYvN5ysDC2EOr
	iarIbbTo4DspxOfTmQVcpTLhZUG8VqdACHIsSALXBWnd3okBORWWvyGIeoSEflV9
	Ncla+KsvZ9AKb9Ek/l40NKI4LbU23SaVHecA/hit1uCT4IwOfk1SleMenUMFPGrX
	0lmBN9peFhuq7aG4NtKKhtU/t8EoJM/9RHBd4Ma/MiMmVYJYkS2TBK8qDymQpq32
	OvpSyaARGkKJnS5QAOTq8S3LmGC4n6eGZQm4/Whf/cqNNmnwd2bS3L+t+dCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728299537; x=1728385937; bh=ma2eVetPwLaZVZGhCMg6UOzQWMP/
	CmhcD6hDnGxlNQw=; b=lsoSpRL+WFg1KaC5Z7mQLNWfyXMjO2+4AT8AtzoNjGrb
	BSyxOdMh5442e0xcsx4QWaO4VR0DEMCxw50rYsj/Bf90NjkU6BVV1ABWkqJQcERD
	WGMh+QrjrFUQuLxslHYjIttWpAFEouCC8g2cYz7m1UU0aesVZDKqKGgXggg7DPZA
	KpWnCSPZF2IVEf+4+5zfQWnyLZRYMYcXIrMirH4ckxG34A1C6lYUY31u3NFnedAN
	vcAcsbwwhA9BIpB6QpKg67FNPmZtwolczSMgozG50VY9UQiW4CNtQ3TcT9WEBq3f
	oh6CNsH8fIarvuj7v5/su6Tcp1dGeFhuLfgYxEUNcw==
X-ME-Sender: <xms:EcIDZ6fdDvcJYiDcw3SfqLOrhNYEXtfDp5LR2JMRiRdCPCdPkrEB7g>
    <xme:EcIDZ0OGYvz4x7-XuKb-eGh07wIjk8STGu6c9rI8p9uGp4ZA8QWlnjYrLX118mFYW
    2mYW4Mom8oBsCZBIg>
X-ME-Received: <xmr:EcIDZ7i0t9FzLDYLcfN_C3GW6fCkE77nGadODkKC7sXTGHIPgkZXW3JjPWYedAo-NNiUeF9OKdSv4spkbgULHSrmO6AjsKnX90-w79MjA-00dNnl_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:EcIDZ3-uGMY399olNJ3SvJiUB-KJETjbrVxWfjKxFGlFuZ-Exey7VQ>
    <xmx:EcIDZ2sqoMC0eML_AlXSTTN3e9OosJuH5AaJZA-ev9_Qk17XbNblBQ>
    <xmx:EcIDZ-HN2E-dTsTxgenxZcifupLy92G9B9JDRiZeH8Hcz7yJCH-84A>
    <xmx:EcIDZ1NgUSTyv-5UrYXbMa5_NJ6Yhczo61rsZJeAdoOnHCY0Xat5EA>
    <xmx:EcIDZ6Ku_ljS7UQKHoO9mY_XwwBCGU-YdsilqmSSFnvw4vbfqrC9iDFM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 07:12:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9ec466e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 11:11:17 +0000 (UTC)
Date: Mon, 7 Oct 2024 13:12:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v6 0/2] [Outreachy][Patch v2] t3404: avoid losing exit
 status to pipes
Message-ID: <ZwPCDAjeQVf4VFc_@pks.im>
References: <pull.1805.v5.git.git.1728298308.gitgitgadget@gmail.com>
 <pull.1805.v6.git.git.1728299466.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1805.v6.git.git.1728299466.gitgitgadget@gmail.com>

On Mon, Oct 07, 2024 at 11:11:04AM +0000, Usman Akinyemi via GitGitGadget wrote:
> Changes since v5:
> 
>  * Remove spaces between redirect to conform with git style.

Thanks, this version looks good to me now.

Patrick
