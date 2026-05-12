Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13A74E379B
	for <git@vger.kernel.org>; Tue, 12 May 2026 06:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567796; cv=none; b=riuQkE70OpSJ4nT/RfljyBOiB8JtxYJyf8cR/TTDIpBplH+bGm7V7BRI/dgCgpxzidUiqSZu0hvtOyWf7gkXRQs9OcRA9AaQL1+U5sQYqFBsYMWAw/jsnmpFXeIx0CWMhLDi+XDoDfTPJ4WbQ4afCp4Y40xOLCZc+a8m829z5w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567796; c=relaxed/simple;
	bh=CU1CnSfYJKeDwxyCGHcimJa6jkuAPndlgpUkE019F0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BH7AjidnRem9nA2w9J6HfzNlUPr3PI3FTG1ZHMF3jeOmF7i46fuE+3z2EShKrSB6iBUsttax0SVU5kNhj7PVdgp/oPKFp4WrgL41bvzf4nKBkrv7XbYAdeqiOCmE7pTvpG5TRvALS9atHmqkzX/0iw0JqOZpC1XdjC6jfNv7o0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vyx1XC1J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H8vdm/tC; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vyx1XC1J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H8vdm/tC"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id BACC9EC01D4;
	Tue, 12 May 2026 02:36:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 12 May 2026 02:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778567783; x=1778654183; bh=0ujff+T79m
	UhDztOl431Rq/L4YpEIKxDBOdHY8Y1LlY=; b=Vyx1XC1JiwuNugwEymVLprHDKb
	qGN5Y3oORzXkVX2QmvB6pOJXqzOzSj3R/yDh3SJci3MdePJ7+jNb1KrMx1l+/W2U
	H1bHX/7p2WKVPaogZ1YF3aj1ii9uLaPk5k35UQ8hfIJhIRnyGyItTWiz6CM0PXXO
	D3m7gAl819MEzpei5bDjWlVOMQZOO0R5LkjmVwdRthoN0zNoLAEKidGJrWMmXJqh
	TtzAnsfuLebAFy9kHNnV1BfXWtf5x3fYVHLAAmEErC0G4u2T2+FlDWh/WLJEOM9L
	FTPLhPNNKfaJN1rEvhkRzOe+rNKPuQ0LYDWdFZy94aZj9uIjVVQ3AH5tLeyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778567783; x=1778654183; bh=0ujff+T79mUhDztOl431Rq/L4YpEIKxDBOd
	HY8Y1LlY=; b=H8vdm/tC04GMh1Z4pQnsv3df6ri7UDA9fr2L+D2R7p4uW/KVSCI
	b7BaT42+w1mS4DyV+LjJ6RancPUVT4bIuL/CJffeUzKS7IOheNZd8AC7wAdyr/v2
	aOrwEfP3TIa/Er8SCBU9KOqo8Z2HZ/oI+hWt7r/6wjh6rtq0pqXGwd03axMG5EwF
	S6X3pXdjO45cW4KqjGpjWRGAB5sfjeEhaULrSLgzAfiwnl5IrCkCNKfofc22vHPZ
	Kh2qh8MAV50h7cDcxI0fr8jZOruNK6mrzsfl9s5JQB8hpBNJNXzpg6CMWrDaTHiP
	iNUrB0Y/CXo7bwFgIkc5MXy/AvrnkybTRYg==
X-ME-Sender: <xms:Z8oCasHUHYJr3_X4jJHMheZGba_P8JFhMDu1l4mD1o38rumT4t8KfA>
    <xme:Z8oCaszzlmVdJwTJIHkK23WPhddZ_dmsmyEAE_V3_5ZOWjKLgIctCbBSR8o_F-483
    xWYVTP1AGcJt0Kc1Gje6cStpVmLb35I4U04bWGg3lh5s-iYLHyB>
X-ME-Received: <xmr:Z8oCajge3bzJx-zaGtZ_EeJI5zMX5vhM22rYbB0F7_g_0K2n0n8M_--pRDmnmZzSfJR-6Q4_zRPHmvGMM2y-c9TxxS8ts8bC3JhAIljqxGU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdduudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehmrghilhesrggshhhinhgr
    vhhgrdhnvght
X-ME-Proxy: <xmx:Z8oCanyxtmffLnft9Gxpv3OZCluwoqPrSL4G25QeiZEBOPe1aqcMLg>
    <xmx:Z8oCamJ18NwefnFf0D-rjwuHBUDgqu9ecdsuYAbkEYFQN2fosndM1g>
    <xmx:Z8oCauSHwVjfiQ7agPoO1VmwiC8bpcXw6cWEw9Z7iM24e8ATqJC8fw>
    <xmx:Z8oCauq9gBZcB9KiZqeKMQ9QI4krlHhWbysBZjmTn_YLCr1jTveMTA>
    <xmx:Z8oCagzVQhNy98Nk2mJ1uIceDqm1gJpPDP8pwKJkyxEpr7yEnUhQINcn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 02:36:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a1799fa6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 May 2026 06:36:20 +0000 (UTC)
Date: Tue, 12 May 2026 08:36:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Abhinav Gupta via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Abhinav Gupta <mail@abhinavg.net>
Subject: Re: [PATCH] sequencer: remove todo_add_branch_context.commit
Message-ID: <agLKVn6RF4UBYd_8@pks.im>
References: <pull.2111.git.1778502113485.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2111.git.1778502113485.gitgitgadget@gmail.com>

On Mon, May 11, 2026 at 12:21:53PM +0000, Abhinav Gupta via GitGitGadget wrote:
> From: Abhinav Gupta <mail@abhinavg.net>
> 
> The 'commit' field in 'struct todo_add_branch_context' is unused.
> It's written to, but never read from.
> add_decorations_to_list() gets the commit passed to it explicitly
> as an argument.

To add some historic flavor: the struct has been introduced via
900b50c242 (rebase: add --update-refs option, 2022-07-19), and the
`commit` field was already unused back then.

> diff --git a/sequencer.c b/sequencer.c
> index b7d8dca47f..19839da1e6 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -6409,7 +6409,6 @@ struct todo_add_branch_context {
>  	size_t items_nr;
>  	size_t items_alloc;
>  	struct strbuf *buf;
> -	struct commit *commit;
>  	struct string_list refs_to_oids;
>  };
>  
> @@ -6498,7 +6497,6 @@ static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
>  		ctx.items[ctx.items_nr++] = todo_list->items[i++];
>  
>  		if (item->commit) {
> -			ctx.commit = item->commit;
>  			add_decorations_to_list(item->commit, &ctx);
>  		}

Nit: while at it we could've also dropped the curly braces according to
our coding guidelines. But that alone isn't worth a reroll.

Other than that this is a welcome cleanup, thanks!

Patrick
