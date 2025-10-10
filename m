Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E99215077
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760099310; cv=none; b=sIiiadaqHpxE3TiWUFdHYWcIpovr8FAkpVu2j7L2QBF+tZI2DZjxvoDPX7Qifa4/3fjRzDFTLokrV7B2oGZf9mrY6+Mg8OHnvxFa463k2ZRNcUSiV5FHX7LPy0ASXU/uvkKNXl7eCYETsrl8v70R27mLt3bk2QnbxJz2IbTESFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760099310; c=relaxed/simple;
	bh=wXROZjBvLevcdDb5SkOFJcZ8cM7HJlNEUu9Bn8V5src=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yum567oPtvvqVcjCLL4vXJXOW8ePgujdnB2bntdqaPEPJrj3Xlw8/r+cHlULi68gnsnnh3nntomyBDD8MOb5WDJJjNXnsGDBKTaEBrmp+J5qPXdff3SoaUpC4Mt467e19654ulCHTibVPNd8eeh0d1CSo8kmv5RHMIOhkXmRtno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nuEfufkG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BecbXjZ5; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nuEfufkG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BecbXjZ5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B2223EC0214;
	Fri, 10 Oct 2025 08:28:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 10 Oct 2025 08:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760099307; x=1760185707; bh=GbkqDVCBNb
	F5tyz/DR0BDAr9n/jrqmOOAO68hNab1/M=; b=nuEfufkGiTTmNIqjC954nUl9pq
	C7ZJ8vGjZwJ8RGK8PFv+Bdb9BvnqnyVrAiq3jD+xRUEnorQBhaHuLiUxJCgC9y67
	ZENiWFS3F/0XjYf58T2n338ti45a8ExUgkUFcS2U2LM+INh1Q33/hVCm0fGgkcO5
	CIRtaL/1XMqhiPKywgymtDhdZoGjJ02QEbJxl5OlNmLVlMJmkONqLDJftnkXoSZe
	DJU6P7N0rzNmTqS+p05siPYJ+6rBAvqIRUpqUxzelvjBBuJROS3fISs3JnKqoiDQ
	KUPo9rrkkbzNDQt+D06yA5x4MIadvMM1G7zOUwUdEptwTTK+ppFWUQwS7T6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760099307; x=1760185707; bh=GbkqDVCBNbF5tyz/DR0BDAr9n/jrqmOOAO6
	8hNab1/M=; b=BecbXjZ5Mv1hVC95F28KGpez6KoZuer0MfhwG5ikliKvRjlkufa
	bV/W+sHzb9yATyCn/yCESY974ieUcZAQ7PcnZy3zrkuI/JB1SujwalOw9ZWUG9/K
	nmo25If0nvzzmrv2yBwW7UKk2CX6YZNoXARtopIaBP3jLnbfStMzNu79Wk5hQK/d
	4mzOYnmxZwZztWZH4sjVd9sn/Os+AxAKTlBbg1yXrJgkgm7RqG7+4M4ficox+J4O
	NjJwzVyDOz1nR3jcDPWR77d56YB9zccRsdbex4x1OafgkkvriRV3Dez4bMT5xvj5
	k0Kk5/zqgagd64SQ7uzxRQT+gprib72h5Sg==
X-ME-Sender: <xms:6_voaBS-RVI9OrVGZvnADhMloIsYnxdCN7tmYDzoMXP_nIKhVm2xpA>
    <xme:6_voaOcnWTrGC60CmbW3nj_63rt-7SNcAdWq5DtPAne-JqE-ZWbFV7exK0zniemgb
    uJXJyF7cHmT8KL1ps4HM_4ZkTa_J339u3QI1Y2VLV9VeZN2R_H26Q>
X-ME-Received: <xmr:6_voaArihlX1XPaNXO07SBpiojnVWPjNyUn_fs3usuDoz-8H1yt1K8QLXz-aw511WiNT57a_NOit9dKUepFrCDw1yQ7hye0kNC4HMTa_8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeltdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:6_voaP-pqIoeLMzWwV6onjBb6mR_O5dil14fAi0pwy9INgcUyVhBkw>
    <xmx:6_voaMdKFdIHUYIVRZSokPyEE4_y8-oFTEYxrwhAn0fEghNLrqkfVw>
    <xmx:6_voaJK_46Q8S5ZY_Y8rRJ07Gp6VgmU6mznrAR7MubbT9TQQuyp4_Q>
    <xmx:6_voaMgzthee349U-6M8V4839VDu6ThOHDUrdwUUsaAJSMr-OVCerA>
    <xmx:6_voaKtS6Hmzt85Ji4-319rSDcAQJe3i_fBb2kSX5F8Ny_eRhGHGL5ZU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 08:28:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 777b7946 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 12:28:25 +0000 (UTC)
Date: Fri, 10 Oct 2025 14:28:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 40/49] builtin/repack.c: introduce `struct
 write_pack_opts`
Message-ID: <aOj75uPA6cFW9WhN@pks.im>
References: <cover.1759097191.git.me@ttaylorr.com>
 <109109618687efeb932bee7dd5882557ab0576f4.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <109109618687efeb932bee7dd5882557ab0576f4.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:09:51PM -0400, Taylor Blau wrote:
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 5fed79e826..6df7c88085 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -138,9 +138,7 @@ static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
>  	return finish_command(cmd);
>  }
>  
> -static int write_filtered_pack(const struct pack_objects_args *args,
> -			       const char *destination,
> -			       const char *pack_prefix,
> +static int write_filtered_pack(struct write_pack_opts *opts,
>  			       struct existing_packs *existing,
>  			       struct string_list *names)

Is there any reason why the new argument isn't marked as `const`?

Patrick
