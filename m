Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF9917C203
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728289389; cv=none; b=HiRl055Tmi28IUm/RA91N6zxbUsw63fi/b+fGlYR0YJgM14r51smhoAikqT+qee/QeRzhmNfoLC4Ajf6AEsp2yIC6Zuitf4iLLL57tsXkaW8p2dqm4xbDF8IzfNTI3l0KYAK0CfWYyruhsoPu4I8K+mugHq7VoklxDJqNqE9Rds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728289389; c=relaxed/simple;
	bh=hay/9YkP9hOMmX5Oik8ZPBnITK0u02YmXuOC3wEPLGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ds8sfME9vNKXiV36zV5Qmr8qVzlN+fAIlAlQhf/9WpBXnZShenlfUxDK0gAF7JS9IxqOAIjb2Vi86L+flcU7zkfDNEte7yg7wx8iTDtjjPV/qYa297SL7yBpddJNPMuZG/e31ayq2uEhCdjRbX/NQVEI6qJ6PTZ6JIJrWbiPL4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HQLl0Ff2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EOXakUYR; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HQLl0Ff2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EOXakUYR"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 648BD11400D2;
	Mon,  7 Oct 2024 04:23:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 07 Oct 2024 04:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728289387; x=1728375787; bh=ka/R0apcAK
	IU9vjvcAwcrV8WpTais61zs4E43zjpWcY=; b=HQLl0Ff2ST3TMQMqr3kH1qy7VT
	ETzIf8+uiDKssGWQQYJkggjOnUKaIR1hU3ht7gKtOLpzveMp0MucSxQxTFI5SlYh
	HbLzpUT2cR1uNIX8PFpe28V12H6/OzMbcd2voHBHwTLgW0NnXI/rj5EhWzKW0yi2
	+YtCuyk+ovRLhM5CRZwolMfr/qzgxFhXHnJDXsdDd663LBEr5nA2o3PRDNOEyHKE
	381UU79bc9ZZDq4f0Zq0MH1Tw+5ZavovcfAB6skdOJWSpkLXS5KFbHcZpOnsvr09
	iHRFB6nPo3VH/YAL9q+ABbAoDsyf8HgHYbMHk6Vbg5Aer72zybhbo0b/uWBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728289387; x=1728375787; bh=ka/R0apcAKIU9vjvcAwcrV8WpTai
	s61zs4E43zjpWcY=; b=EOXakUYR69+KMl/Ab8l6moWj2MasV4xWUpcbyl0eF3V0
	jREHE2EmZvbsKKtdURw8PaNzxL+PEGEJD/A3PQdYZbr9maFd9oTOFUxkAOmMQmwo
	lveNLtBBi2+8M8e6gSNqy1yFOKsKlgQreCqTHfGq8dTHq9xkQPJGLQhLF6+VbQF9
	7ZdsORiEOBwVR5GTlqySdikfCOpLPnZYN92cFIz0QD2i79xbgeuPGYirmHct2o4w
	WzlXWrFMNW05exypto5ZxmVUiVfFFqrvWVvG/FKFz8OfNifn3C5Z278MFacMsq8w
	zN6ht7aTVCaBcytJppkJ7nby3mhTCfLMYm/kiLqWCw==
X-ME-Sender: <xms:a5oDZ9KXpPShmOHMDEzkY57767xO38sSvIpkizqPqbJ7Nq3vux3LEg>
    <xme:a5oDZ5JsCWSafZ4s2BmYelvDWzC_NZO4e-2d4UB6nUeCbuCm0u5vvJ-xKTNXScuX4
    4iEwZ7a9sHg1_MeZA>
X-ME-Received: <xmr:a5oDZ1u-hrlIE0dUg-bQRBZGNPTMJ8HGgxlybrQfQRGJ43IrCyFvsFxaPkL6nTz30HAEKHJTxfuE6EfXTbTw7rtye4jaXTX8DcuZvgT1n8cs6Let8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsghuphhtpgigihhnghigihhnseduieefrdgtohhmpd
    hrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsmhifihhllh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghho
    ohhglhgvrdgtohhm
X-ME-Proxy: <xmx:a5oDZ-Y6LLiSth_RmJHcOLbsDQGLllWyYdSYszrmLMY8Tz7hMPJbWQ>
    <xmx:a5oDZ0Z8CyRK5hVGcecYe6UnS3wqRtfAqYVbkGqVGYFFC9epawWY1g>
    <xmx:a5oDZyBq-W_OWKkO6XLhrovZZwGMRM07AiSvcXiVT7i3dqyFBSGWrA>
    <xmx:a5oDZyaBqMpxwz5HzPZjGo-1Opnt6cCDhF43l_CiEDIndXSSdAMlTw>
    <xmx:a5oDZzyXOVyduYYZvwp5vr4zDTlizRmY6G4IJ6JHazAjin4_ch6jeEyr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 04:23:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d17b9d1a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 08:22:07 +0000 (UTC)
Date: Mon, 7 Oct 2024 10:23:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: blanet via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	blanet <bupt_xingxin@163.com>
Subject: Re: [PATCH v2 0/5] Support server option from configuration
Message-ID: <ZwOaZkxETwdId9Qg@pks.im>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
 <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>

On Mon, Sep 23, 2024 at 12:17:53PM +0000, blanet via GitGitGadget wrote:
> We have multiple internal repositories configured with a huge number of CI
> tasks, each requiring code preparation (either via clone or fetch). These CI
> tasks, triggered by post-receive hooks, often fetch the same code (usually
> using --depth=1) concurrently.
> 
> To reduce performance impacts on the git server caused by these tasks, we
> want to deploy a special designed pack-objects-hook. This hook would allow
> the packs generated by git-pack-objects to be reused. Since not all
> clone/fetch operations will benefit from this caching (e.g., pulls from
> developers' environments), clients need to pass a special identifier to
> indicate whether caching should be enabled for a particular operation. Using
> server options is a suitable method for this.
> 
> However, server options can only be specified via the command line option
> (via --server-option or -o), which is inconvenient and requires CI script
> modifications. A configuration-based approach is easier to propagate (by
> changing the global configuration ~/.gitconfig) and avoids issues with older
> Git versions that don't support --server-option.
> 
> This patch series introduces a new multi-valued configuration,
> remote.<name>.serverOption, similar to push.pushOption, to specify default
> server options for the corresponding remote.
> 
>  * Patch 1~3 is the main change for introducing the new configuration.
>  * Patch 4 fixes a issue for git-fetch not sending server-options when
>    fetching multiple remotes.
>  * Patch 5 is a minor fix for a server options-related memory leak.

Sorry for taking this long to get back to this patch series. I've given
it another careful read and have a single proposal for improved docs
that you may want to address. But other than those nits this version
looks great to me, thanks!

Patrick
