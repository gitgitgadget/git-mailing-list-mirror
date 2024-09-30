Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B007DA6F
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699541; cv=none; b=g7UkSsmkSMWnFioAeQMZ8lzzALeVTSTHOeVc9DAuVUytqVaBNEuVaaBL2j6dGXahuH9bR1sJ3u519HWBKPLlMlpC3EW2iPN0ye0JAterUkgArSaoRWNX/tUratSesXvzaT5IBiyZVUPBzSTQ5IhGptO/M9I59f4EbHMImPv5jUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699541; c=relaxed/simple;
	bh=INn/5Skz/D4vlqy+Ic2OtAF7pljMwsiArkYv7Xnt5h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgLD7iqmD5TFV4KvGsK4c4RZY22xfT/w63iL0FBIZuQ+U+z1kiAHt99Gj9YrNAI3W1S5tvvkIP6Z3cdbWq7JbgDj+q9v1cS0dX04enEyrcmB2WDaS+IAawOrVLpMYt1iFmx5Jl26BDcDhoU/XvkSHgDOkO8ikwJtyPRopsFN7H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sH6y1jnG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UxU1G/En; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sH6y1jnG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UxU1G/En"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B562811401C2;
	Mon, 30 Sep 2024 08:32:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 30 Sep 2024 08:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727699537; x=1727785937; bh=n+xpdvawky
	CT0JzEBTkqkmsKFbjdYSIINM/dECDTRiA=; b=sH6y1jnGI5Z7YMwwCVZU0Fcdcz
	IbX7KBnR2TCy+rg045uGy7FRIaCqznyEtED+o2LddYwLYujH1jQnCH5YihRkMq1v
	QAOPiBO3eSIo4eihiQiCF1HzcYkYK9YMZ/N3/WSOaqTD6UxUmFTSEpQNhcUlh5uV
	FXP77L6YNXDwL1aZTdclbiE9nF1sBlYOMBOigTqPs+pFxpF/k3Pco2NUlU3tnuFd
	cTsWYgdyGWhBgSXHGxQfqRGmyPm1mbk0SpbWwi0DwQd0QvGVh+h6BgKfj0d4e0pH
	aUYTUPh7MQwpwvIPvYESEWm1O2qnmi7nSy1eIg8Q+GEZQo0gawFJlYFI3fzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727699537; x=1727785937; bh=n+xpdvawkyCT0JzEBTkqkmsKFbjd
	YSIINM/dECDTRiA=; b=UxU1G/EnyfASx/mcCBRCReYrYpPPhbcGOGvnZJDaA3/j
	yEUa7yO4r9Nxp5fPoT3R3C4PzmyFuohGdb5Sm87UbbR8f4qjav0mGuUGabWFP1Hg
	eQvPVD+dbCamwQaP9phjnUVHcfpmQlgZMzfEIu6SjgNcrAQtRey5t1yR+aUJX5ZS
	MJs29hve7ZvqPOlBesv4ZfNSNnNlvdcjVcfM0ECnDD6xWNXyo2nbIEPJMfDGeyu6
	0kQ1m2Qe/tge3pNTOCsGqVRG9fubASH2tQs+8ORcsS2I8AAwdLlAN7FTOH971vfA
	j3kkBiiGIzbDML/byidSFLInBvOZX90e9NqtfZevQQ==
X-ME-Sender: <xms:UZr6Zu6LvOxjnixZv3Puw3BaBrUEvnVPrBKpsXKgmZYHQyAFDHFoqQ>
    <xme:UZr6Zn6EXd1eQtXXmY74duprdiLnwpSRzFOSlCiPKP4k-vP3H_dzyFz804EFY3PkA
    zvxOfr__t-KZrpP_g>
X-ME-Received: <xmr:UZr6Ztf1YqV9PN53y9FxkPl6dgBy_nj-CwCmLUT9cih0_2ciaGpC3-V0idvr2SfvpnYscTBId3X7q6oVtzkX3mLkv0t223r38NyBlq6untJU97k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:UZr6ZrJCGa0IuVFIxbRKsT4Pvx5g5ezIKipD9zVYPhbKfdJeIAf8dg>
    <xmx:UZr6ZiIWCXpg4OByUqnbBnFw_uUkiIu4qSKBnkftKTTHw_AHBN45OA>
    <xmx:UZr6ZsyU_4NvMz2vYbfperpt-5vuYnLYBLyCfevnDeiZI_zQFFMK0Q>
    <xmx:UZr6ZmI0L1rU3qnhgpl9tWqhJ5v3XbEKv1VGGRI0Etj4Pg4LS1hXtQ>
    <xmx:UZr6ZkjVjShyGyNFpQv6NEtFdTuSRafn3frk0Qbtvc9hSZBCYly8OYnp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 08:32:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3e8ff9ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 12:31:30 +0000 (UTC)
Date: Mon, 30 Sep 2024 14:32:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/2] read-cache: free threaded memory pool
Message-ID: <ZvqaTqegJxow1x-b@pks.im>
References: <pull.1801.git.1727696424.gitgitgadget@gmail.com>
 <9a45b15ea4b9864cd3cff066ecd9281c4539d5f7.1727696424.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a45b15ea4b9864cd3cff066ecd9281c4539d5f7.1727696424.git.gitgitgadget@gmail.com>

On Mon, Sep 30, 2024 at 11:40:23AM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
> 
> In load_cache_entries_threaded(), each thread is allocated its own

s/allocated/allocating/

> memory pool. This pool needs to be cleaned up while closing the threads
> down, or it will be leaked.
> 
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  read-cache.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/read-cache.c b/read-cache.c
> index 764fdfec465..3c078afadbc 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2188,6 +2188,7 @@ static unsigned long load_cache_entries_threaded(struct index_state *istate, con
>  		if (err)
>  			die(_("unable to join load_cache_entries thread: %s"), strerror(err));
>  		mem_pool_combine(istate->ce_mem_pool, p->ce_mem_pool);
> +		free(p->ce_mem_pool);
>  		consumed += p->consumed;
>  	}

Okay. We move over the contents of the pool, but forgot to free the pool
itself. As far as I can see the pool is always allocated and only used
in two functions, both of which assume that it is allocated. So I wonder
why it is allocated in the first place instead of making it a direct
member of `struct load_cache_entries_thread_data`.

Patrick
