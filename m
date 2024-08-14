Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCCB1B32AD
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646172; cv=none; b=Mo6n+d9qS0hc4VpakHvpxNycZ+WggufHbpadDFw4lK5aVKhVW/IVAQ+rWs0UTXj6gUbbR1+J5V9m2KRgJS05Wa5N6x7SxBTNQUWKoigQv+BzQFgtT2eX0+DPXhXfi0P8mmdX6tHEjkPeTTYgUb/YH39/yq15pE9iRSmvrCMe5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646172; c=relaxed/simple;
	bh=xdILeDOgJB5Nz/s7yQzvCaexQou54S8uMO5DmBNE2sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClvgVYz3syM9L9RSdj57qp5eRzcE4fP0a6l+G1MmGkUHsU8gdLmf6MHrtMjw3BYYprGpZq2hNuralNGegv1Zi638xu8/yR17aR6744v+9u/EW7SXITrHwFZPiA4fzAe82lj4ZhiqU2PJafukLwXJXvDAmqyvHVK6Kpt0yD+DDsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ppaELywj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W0G6aq1F; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ppaELywj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W0G6aq1F"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 007F0114AB8D;
	Wed, 14 Aug 2024 10:36:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 14 Aug 2024 10:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723646168; x=1723732568; bh=0XPGd96p3K
	iSFt2Cd08EhywyJjTon454rKXcOmMuzN0=; b=ppaELywj7WsoJA+X3TP30xbwY+
	nM49IbZcL1p3e5q1zPmtAcXdnM52u86uVyIQIRbCavgZzqTZVFoq6ZES7f5zshWT
	fvAuYemSczj7nZ/RNl5luY7tSRiN5cDBvrfp/TW5Pm83r3Sy+xoKniPL0C3VLpP4
	4HMfpYxe/LCwCzCjIiVS9p/XJ1lcseeIgPX8BcRWX48B4L56KGAjhMGk/oFGKASI
	RC3qxxPvt77cIU0SyiPO+pUo4KP+ynP2TKxxEwbSdLPdPYni924nu+e9cZY9y50P
	7qT5USoYVuVwT1Osm+H3AiW4QnSQlR7TpzDzCIL1OCEqkIVtGPC3eYjPlliA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723646168; x=1723732568; bh=0XPGd96p3KiSFt2Cd08EhywyJjTo
	n454rKXcOmMuzN0=; b=W0G6aq1FNhCxxO5zh4O02D7/mRMXGnAPbx4MwI0RTBNr
	BxtxXR/qmuZ20MjF3x+Y4TuT3Zp4UR/rLzKkJhqktTamjXpcs+h0gKTOdZaGZBJZ
	3gDVeqWYnz/LBucWCLQBpVIBSDnza8X1ifidflqM9zRgiOpz34cf5VtDrinSFI67
	V6h9zBzeSB4Y+wYN7dG5ddNNdySvzleOmmjsTchdAHYPFosuEc4DFNXrbWVp/WVN
	t7BOWgSHizTWjKQUoYUDKjSp/taEoPxYWIETNn3BnWWqQqzj/shmjhLOnqeNu5zp
	DzKPAuNR7UOa9zn87wGWKS6aQ4912CGbd7s/hKjb1A==
X-ME-Sender: <xms:2MC8ZqIkSUupD0TmuguaEPtQDIKp48xQ0ntKEkCltOqn5dk1hXiq9Q>
    <xme:2MC8ZiJBXE7nSzfT-Ah8tZB_S69J0zsWG1ajqZX3prZStNFwFkWZ-ktU63LhX-6Ri
    if0OeEUA0QBDK4phA>
X-ME-Received: <xmr:2MC8ZqufhL4mRNMSlMeXv1nYM9QAyv1yKA-yDe8P3vxlL5jm5Oj9CtCERG5IFRk1SbyMikWfWoju5C-eIP0phCr_LVefzTQCtgLc_6uSAUPnbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhope
    gsrhhirghnmhhlhihlvghssehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:2MC8ZvYJcwZGaG64Ac8-6KEsgVWzJn8tYTU_ITKjgqlqoQ_6z6E28A>
    <xmx:2MC8ZhYG-tiffQVgCwlqF71z_C6-n8t8ql01FXyOSPTZ26zdgGevdA>
    <xmx:2MC8ZrD3GjWb9FNBRkBySEnb5c5IPl4euDvLCT_4uLugyAdH94EWhA>
    <xmx:2MC8ZnYn4T9cSmKJcNEqUjpOE4UMsjUOxbM1HeikCPAxmcSJBWQOGQ>
    <xmx:2MC8ZgXvh2YAghAQJ5PUNrRVw99dNB_j1lPdT94HBqpR25WOIzGh-Fdg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 10:36:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d2dd549e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 14:35:46 +0000 (UTC)
Date: Wed, 14 Aug 2024 16:36:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Brian Lyles <brianmlyles@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase: apply and cleanup autostash when rebase fails to
 start
Message-ID: <ZrzA0yp45w9NuTp2@tanuki>
References: <pull.1772.git.1723641747309.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1772.git.1723641747309.gitgitgadget@gmail.com>

On Wed, Aug 14, 2024 at 01:22:27PM +0000, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> If "git rebase" fails to start after stashing the user's uncommitted
> changes then it forgets to restore the stashed changes and remove state

s/remove/& the/

> directory. To make matters worse running "git rebase --abort" to apply

s/worse/&,/

> the stashed changes and cleanup the state directory fails because the

s/cleanup/& of/

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index e3a8e74cfc2..ac23c4ddbb0 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -526,6 +526,23 @@ static int rebase_write_basic_state(struct rebase_options *opts)
>  	return 0;
>  }
>  
> +static int cleanup_autostash(struct rebase_options *opts)
> +{
> +	int ret;
> +	struct strbuf dir = STRBUF_INIT;
> +	const char *path = state_dir_path("autostash", opts);
> +
> +	if (!file_exists(path))
> +		return 0;
> +	ret = apply_autostash(path);
> +	strbuf_addstr(&dir, opts->state_dir);
> +	if (remove_dir_recursively(&dir, 0))
> +		ret = error_errno(_("could not remove '%s'"), opts->state_dir);

This seems somewhat dangerous to me though. Should we really delete the
autostash directory in case applying the autostash has failed?

> @@ -1851,9 +1871,14 @@ run_rebase:
>  
>  cleanup:
>  	strbuf_release(&buf);
> +	strbuf_release(&msg);
>  	strbuf_release(&revisions);
>  	rebase_options_release(&options);
>  	free(squash_onto_name);
>  	free(keep_base_onto_name);
>  	return !!ret;
> +
> +cleanup_autostash:
> +	ret |= !!cleanup_autostash(&options);
> +	goto cleanup;
>  }

It's somewhat curious of a code flow to jump backwards. It might be
easier to reason about the flow if we kept track of a variable
`autostash_needs_cleanup` that we set such that all jumps can go to the
`cleanup` label instead.

Patrick
