Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B05B273D76
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374895; cv=none; b=u6u/OZ8/fZOYE2nv+aGFr3SdZm7lYhh64nVW0VHWcOQW15V8BihW4iGhfC4Lv3INkiW8aJElYi/Xbi6aPOKPrRGjIERdoEYuns8Pr9XALf9iT9nP0WEZxLq8mZ33lLmmu+kHo9S3ESC/J/DsGJ8C9YFRpuUwiVIMqZKNFI6FIt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374895; c=relaxed/simple;
	bh=LpxiV+340yAttVysiTheEWKsxPAy4b0NZ1pY411Ymkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b104eztTGIPfX1OuSuiSjSfDoN2dFFv7t6G+6Vo772broNCBbyukHzvtUSoB5U+qRsO6RXRBA2EaAy8/qPyo9tCJB3hvTGRev4NLvNNe+SasrUuVMXX7UpmT+CBRtp4u5uGBrMEmH3XN4lO0g/j8fwNiIPH5HUeQtj2iG0QMzKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dVoUf6NL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nhIuQkwQ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dVoUf6NL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nhIuQkwQ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 17F2C140035A;
	Tue,  1 Jul 2025 09:01:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 01 Jul 2025 09:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751374891; x=1751461291; bh=U+MQWkJ1nL
	oiWtKg0MjBQ80BDpsAzrI9OXOuzSka2GU=; b=dVoUf6NLatUIjIc6HE+jPzbZ4I
	F0fjfG/zcbPhq1HgNqxUx7yCdFYeWjd9i3vV7WWkOSvJIjj4xVBGjhccZ/aewh3Y
	ob+Wi7wPVqTGSjnfr561Ku5/iJUguTky7pFBJ6vpY62Z7SMKExSVYtdfcSwMTMsd
	1AwRbGzQfEUN8fVdOGxeJAgbYGOgEd1CGBwhMTT22XBgVWeKAVxELUOy2fvjOERn
	YNnml2iGsX8TqmFSiftpcg4D7O8Orsb5iKbUZLmGUvTfLmc4ViI9lgBMT9j2FhVJ
	yI44YcmiSkIXpPiJjFalK9Yw7NjvTeteN9Wj+jAUN6IdhCy/dB9uBJdvN3aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751374891; x=1751461291; bh=U+MQWkJ1nLoiWtKg0MjBQ80BDpsAzrI9OXO
	uzSka2GU=; b=nhIuQkwQK2fdgzzTP+5xfCfSxkLE7Efk8HIOKn5BNggtm3rnMlx
	yQi7o9fVXx0/iP5OlgFD9nCxy13PUeTa7vSWYg2izMw9YVJID/00K+mHOulVFKIg
	/jAt9jIzofcHE8dCREaOPQETmSG69G/ssJdcmNqqmSxYxcCtZE64CrqNF2erxtM+
	4PTlJzIg3I7bulb2ahpEK+UWVUheX+HrSs+LEK286H/uQFjcwS9qC0cuVhxkotqR
	1IQQEqZ4TNJCZ22yj4cyABPtjDkjLPHuEq+ZE7QKKnJ3NHQWf5koeXzrsow1tVk8
	esSs+HwAcx+Q3guFu2eX9iIPRPCQ91Zi1pA==
X-ME-Sender: <xms:KtxjaCyUup1VceNExpLvwk59TDvB2STAnqBzg4-gbaPHGr90WaSTCg>
    <xme:KtxjaOS6FtLF_7LMkEuW8oF3ZmXkFTSyTOahoTXvxYXVvYpxFaS5JztdSlEJCnlR0
    Jlo-eDyMDNJEeo08w>
X-ME-Received: <xmr:KtxjaEXDJtnU9gc-hMsoaqj7RLV6CTBPKsQ-LmCi0VGlU_CftZXo0-tKvxyp9z70euzqvTvzOKP4g4xW-0eCMH8xEDlxwWRB2zN0F1igcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomhdprhgtphhtthhopehshhihrghmthhhrghkkhgrrhdttddu
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgihuhdrtghhrghnuggvkhgrrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:KtxjaIiOcGfRU4vyIgI5xu1lsQIjz2Xr5pT8T1TMMyzpQ-6a891gBg>
    <xmx:KtxjaECknrwVtPGhUD_wA6s37IjtHGHsKLDqwblVdAJzjoGlm5bb-g>
    <xmx:KtxjaJILBEPzaZdX5YdYXsrc3YjBHS-vCn93Lz9B7vhf4jK3B6-7qQ>
    <xmx:KtxjaLCqU-T2hMVbu8RmuhdoLqsd1lm-gbeotxvZudmAdApK2VKNww>
    <xmx:K9xjaIz2gxdYqQXPTR5B6X5aWA9dw44LeXTo7xFf7BcKFaBLwutl9n9O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 09:01:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 179532e5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 13:01:27 +0000 (UTC)
Date: Tue, 1 Jul 2025 15:01:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org,
	shyamthakkar001@gmail.com, shejialuo@gmail.com
Subject: Re: [GSOC PATCH v2 1/2] repository: move
 'repository_format_precious_objects' to repo scope
Message-ID: <aGPcJMfBCJuQLdtu@pks.im>
References: <cover.1751296633.git.ayu.chandekar@gmail.com>
 <995389d6229df0c2a76ee4ba57e663a43abb4540.1751296633.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <995389d6229df0c2a76ee4ba57e663a43abb4540.1751296633.git.ayu.chandekar@gmail.com>

On Mon, Jun 30, 2025 at 10:11:04PM +0530, Ayush Chandekar wrote:
> The 'extensions.preciousObjects' setting when set true, prevents
> operations that might drop objects from the object storage.
> This setting is populated in the global variable
> 'repository_format_precious_objects'.
> Move this global variable to repo scope by adding it to struct
> `repository` and also refactor all the occurences accordingly.

Tiny nit: the line wrapping of this paragraph is a bit weird -- it
should generally wrap at 72 characters and paragraphs are typically
separated from one another by an empty newline.

> diff --git a/repository.c b/repository.c
> index 9b3d6665fc..62709d1c91 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -284,6 +284,7 @@ int repo_init(struct repository *repo,
>  	repo_set_ref_storage_format(repo, format.ref_storage_format);
>  	repo->repository_format_worktree_config = format.worktree_config;
>  	repo->repository_format_relative_worktrees = format.relative_worktrees;
> +	repo->repository_format_precious_objects = format.precious_objects;
>  
>  	/* take ownership of format.partial_clone */
>  	repo->repository_format_partial_clone = format.partial_clone;

The list of variables that we copy from `format` grows longer and
longer. I wonder whether it would make sense to embed a `struct
repository_format` in the repository and then copy over the whole
structure?

Patrick
