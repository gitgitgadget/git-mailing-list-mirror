Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3656A2F0697
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894534; cv=none; b=hYzGgr74wComvAoWEttNM/+WjKx76jD/TtTyKomVQOUma+k0QhmHg23cRFpM4IZkBP+UOLqkH59kO2kkJgWWQVh9okIAIoexxecWXvStAINV6JVQYcucrPy/cF4T4OwzuwMmYvkMkdCMrXZ0Q2swjtj1+0sMmxHcCe99TadVxJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894534; c=relaxed/simple;
	bh=49eQSdMXe3OSKGpKok83zgIezTX5/hrrkff6nLyAPbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYQsfPHFD6Z4ORjAVAydtA3K+BCGGVnKS+kWhnUuhFiOCWIwaE/7vdluEojROXML6soY3o0Pz4lzii7nEaH4VnTL7rIb7YgmcMFtmfYxR0CJ0jtukVpGdfzwqLqyTH5FaLvBq2S33vbsCWTbQwL6Fy9V8gmEzq0j/kYZ04LJYmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qtclFzj8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lt8jd4Ed; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qtclFzj8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lt8jd4Ed"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 36835EC0398;
	Wed,  3 Sep 2025 06:15:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 03 Sep 2025 06:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756894532; x=1756980932; bh=j+UW1kj5IG
	KCUagQK7LJ3ic3I4PWB+uuBoNt1TNkClU=; b=qtclFzj8dx+G5wxJFPYLJLSVmC
	nvRVgAmxWRpizhzq11wjgf96zD8KJ1fnNbMFZa7jgK4nIULjE2gE0HvhkCP5sZCk
	0C1eN0ktgpRspcL/Cw6RdQJRdo3li9tzP2wPMN7p/K7YnxBz6aQ/JkiIgeyDwxCl
	bVRT3zyNyYN75su495ta43jSngjBw72QDVwBuz9fSFikzmWdGVLNao/KGnYM9Q/9
	3vJ02mIroJqn4K49vcAbaaDiaFTO0zpv8p8EZdZgre3vaXJAiu+A85tout+6htDh
	WEFia9fq3orj93RUSvvPewEWWtWzoYmh8LThkita0y+Kh7XnuACTSSVCpVgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756894532; x=1756980932; bh=j+UW1kj5IGKCUagQK7LJ3ic3I4PWB+uuBoN
	t1TNkClU=; b=Lt8jd4EdBvNyiCFoSx3fflhBzGjCSC6BEDytw0LjgmZFLRPL7eR
	mWECkJArfwJCbhyxod/LDBq25pXlSfxJFXRVKu9aYhPhd8XKGGUqiKv/YAtMzlcy
	cCxItnEGis4EqDeHwUZ8euv2totKQrhagsTl+RcVdjhAd4O30i+uhENRQlzRnmpz
	82EKl5is7GU0U1A/bdYdv/dcSPPh/uPLNQR5P1iZods7oxb5BMj3Iy1kxtnMVmMA
	vJraOx4imLORjdR8ZxIoVo3BvM1EXRR9hcoi10/gy0UPIxXEYffYsvjzFDW4UpL1
	qrrOgtz8+CS8N3b6yXiU8pJeXDdwQpJiV3g==
X-ME-Sender: <xms:RBW4aMzNZAiMFK4SiIUrYjiy7qgw-XW5l8NEU54f3x-0r5vI-KJ2DA>
    <xme:RBW4aLx682a0BGIYaW_kugfvOwOHw3d550qu1gz12vvSutR2oP94qBTaL-0M2kkyN
    gdgmWXwofbk6lO6Xg>
X-ME-Received: <xmr:RBW4aExU4UgophDn-nT9iQEyhDA8ZpYFHAJ3U_wZCj9-6YiRXHVGT3WiO9sH6fufkizy_MXjgCVJ6aFh_hzkiGdrLWYj1VRLkOOWAx0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RBW4aFbp0kwGpJRNCXDWmqc1BpDaHxyC7IyyvMBHvl8ote8kbhI6mA>
    <xmx:RBW4aFX3tOaWl5WH6h6rNMTdPELiBbYKrfvybQsIRBaWyDc1-2omwg>
    <xmx:RBW4aDj12N8PQg05tct8Wlo2Dyz-CmfLIppLonbhv0xD9LqAbGW1GQ>
    <xmx:RBW4aDv6wdLL6sDxuGyCOFkUWRmetfZHQUPvJs-egpZW_KpuUA0JqA>
    <xmx:RBW4aNWchDEZrzwTBIdF6THp2EBN5IQ8VfUoIzuThcEMrIJfCIivlM_m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 06:15:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eb2a21e3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 10:15:30 +0000 (UTC)
Date: Wed, 3 Sep 2025 12:15:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 5/6] midx-write: reenable signed comparison errors
Message-ID: <aLgVPx5gOI9ZIRu_@pks.im>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
 <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
 <35302f52285d98c3e7ed7ab4140b4721375bc8a3.1756589007.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35302f52285d98c3e7ed7ab4140b4721375bc8a3.1756589007.git.gitgitgadget@gmail.com>

On Sat, Aug 30, 2025 at 09:23:26PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/midx-write.c b/midx-write.c
> index 1822268ce2..14a0947c46 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1430,6 +1428,9 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
>  	 * have been freed in the previous if block.
>  	 */
>  
> +	if (ctx.num_multi_pack_indexes_before == UINT32_MAX)
> +		die("too many multi-pack-indexes");
> +
>  	CALLOC_ARRAY(keep_hashes, ctx.num_multi_pack_indexes_before + 1);
>  
>  	if (ctx.incremental) {

Should this error message be translated?

Everything else in this commit looks good to me. Thanks for cleaning
these up.

Patrick
