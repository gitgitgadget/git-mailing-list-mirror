Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E7E295DAC
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770747382; cv=none; b=ANa/YQzqtLvFqbkWpfqkg0g4hY4r8h2K8cP+V6yxv24n4ZGbRp0RJqWmLJeijMfcMzMgsLdld9iR9IrQThpC6Oxoy1hl21eS//IquMC2Ug7vnvyZ0e28uqsMqpO/2RQhpAEOG7O9rJ1y+bMZnkHjNUf5iPJ0MjcUhq0YI4WBd90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770747382; c=relaxed/simple;
	bh=Ksqc3e/egJloktTtxFZqFwqZLMhnQrpknsJnWCrMeh0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JJsGj43eSinEhgGzJ/emifhr7yadkjK/SA6Ie796gdkSqN119mdv9BoXQk4+Twb167xQc3P/jS+uGD391LZgakd1kMTZ1QPJACm4ymVFyGZVIUbzXP0cP+Dowd64B8XBAw2BAuuuL1is8sjd/pgR2Q+p0R2xf4Z4ZqitzP7NWSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WhAUPKPL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZFJBE6OV; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WhAUPKPL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZFJBE6OV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B2F7E1D000AE;
	Tue, 10 Feb 2026 13:16:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 10 Feb 2026 13:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770747379; x=1770833779; bh=pr6mVMKkR9
	aUO5zMqJHO9XtKGQBemzSWETz7kowmkFU=; b=WhAUPKPLVK1E6MmASfgW9j+kQw
	KVIWZM1Yy/Q+5u8lmpoAf3KP871U9M1M4jKKqQaiQ0eTnL6vm2HPh3/8hyvVn6sD
	Rxzqy05n8Lp3uuz54vkvwtFlOXAnXCe9xf72HipMBqvqYc5Y5OX0RLODPf1VrI3D
	Er+BcQCW/Wb7SCKepTb7UxR7M9/IGeCaWwVuF0JtBR1Bs/aFvp3JFIB4hNdDUqlD
	2IhT0p/uq8p5r8oFiwk4zW2JlqQNSmX5gfaDGv3zdHMas/Rwkt8N8iFFFlnDZnuH
	dXf/imKuxGLS1JIppkDEQQv2iq/UC59nZ7pt0gAwLlY8dMjyWlHJ51IBWx1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770747379; x=1770833779; bh=pr6mVMKkR9aUO5zMqJHO9XtKGQBemzSWETz
	7kowmkFU=; b=ZFJBE6OVxlgKCVd8h5WxVrx6qGMN009xinm+HFHJ4HzGcbxuagD
	F7xF8fJ9GZlVqQ5n5N3jwPjb6M4Rk3Tn48a7sxWeM+71u53rZVg6aKmfYgCNdKMY
	vcyv6ud30Zvm1W3607lyO850V8ROIuQni1BcaV8wMaZ4kAFUzf3eDypyqWJmOA0Z
	X/1YX01H8Nt0nafoHZI1Em9jdrOvp6owZz51oiL3EtRymt+7iSwI9l/QT59htGVw
	jf3m+GFbQOowTmeApRX04B+yD7zBhTRnOmL2miBculIcvmEvvq58LiqsaqZVjF1B
	WZpnG2LG42HlxDWeoA1fVvG7/9pCxm7ijOA==
X-ME-Sender: <xms:83WLaTYcZIfO3_tOZaAXy0IepH3F5XMffobF2d6QXfDKUEt8oQ8shw>
    <xme:83WLaZZH788w-nuP6tjSusad-8mlKy0DbtL7a5YrhxWwXQlPCLzpFe4GvheHqgNjr
    Eh-Lobc7o21HVyuZMhHhqu-sYqM4ijZ-gyYWubjqhHiJXERSmOqWA>
X-ME-Received: <xmr:83WLaa9MZANve-bPcwSCEmbEcoNH4fYjpkYKnFCTZ2THT_zwXsuKgBk9yonktiYF5rHL2DArp3TEy88SYv8Ddu7ivVwNe1F4fA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhgrnhgurhgrkhhrsehpmhdrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:83WLaYjuDdvS5LHs3THHz8WCvMswAwrs34ldQPVw9WFkP6P3u5RxCg>
    <xmx:83WLaaf13Ut9AFYa6-VcP-HPo_alQtv5RfNccevylWkdVk0gGGAOyw>
    <xmx:83WLafrvv061hjlTaLuKNDNOKgAgXTgeDvhap4JA3Vxtr55HNRAAeA>
    <xmx:83WLafDctocxCJ4vsOHpyp7dsF9Vhc18aKqeXI-h5V2GDstSNM9O5A>
    <xmx:83WLaf-4bRUj7rvbaoh2mZZOSiLGy9xik80d2AS2KAVQa6rICNfjHKtu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 13:16:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Chandra Kethi-Reddy via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chandra Kethi-Reddy <chandrakr@pm.me>
Subject: Re: [PATCH] add: support pre-add hook
In-Reply-To: <pull.2045.git.1770737573475.gitgitgadget@gmail.com> (Chandra
	Kethi-Reddy via GitGitGadget's message of "Tue, 10 Feb 2026 15:32:53
	+0000")
References: <pull.2045.git.1770737573475.gitgitgadget@gmail.com>
Date: Tue, 10 Feb 2026 10:16:17 -0800
Message-ID: <xmqqldh0zcpa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Chandra Kethi-Reddy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -576,6 +579,17 @@ int cmd_add(int argc,
>  		string_list_clear(&only_match_skip_worktree, 0);
>  	}
>  
> +	if (!show_only && !no_verify) {
> +		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> +
> +		strvec_pushf(&opt.env, "GIT_INDEX_FILE=%s",
> +			     repo_get_index_file(repo));
> +		if (run_hooks_opt(repo, "pre-add", &opt)) {
> +			exit_status = 1;
> +			goto finish;
> +		}
> +	}
> +
>  	transaction = odb_transaction_begin(repo->objects);
>  
>  	ps_matched = xcalloc(pathspec.nr, 1);

Hmph, unless I am confused, I am a bit disappointed.  The code
snippet whose beginning we can see in the post context is
preparation for determining which paths are going to be updated, and
this new code happens before anything is added to the in-core index.

The hook takes no clue from anything derived from the command line,
not even the pathspec (or list of individual paths computed using
the pathspec by the command) or the mode of operation like '-u' or
'--renormalize'.  I am not sure how effective a decision the invoked
hook can make to approve or deny in this lack of information.

Also I am not sure what good it is doing to pass GIT_INDEX_FILE as
an environment variable.  If this were a hook that is invoked by
"git commit", which may be doing a partial commit "git commit [-o]
path", the command involves multiple on-disk index files to allow
the changes to named paths jump over already added changes to other
paths, but "git add path" is always inclusive of already added
changes, and does not use anything but the main index file being
used.

So,...
