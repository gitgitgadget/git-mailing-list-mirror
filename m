Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0551C84C0
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032498; cv=none; b=B75AzG+n14H6b5GLriZ+hb5rXOcdqBO9Usmp7XSvv2xW0w31Ih+sysVCXtZmJJDzWtwKwPoXI3tR3BVG1Ik1HqeuegVoxCHba7pzbKWYB/izks+gf4VkDb0rhcXi2efs0B0UetwubpckSNAjETA7NvBEjuWjoCPBXoJWUVoDylQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032498; c=relaxed/simple;
	bh=6/iqF5ghwRtFL4p52BSrmz/5InjmkJGpd09ljXY+8II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hn3OVcsriMxPpzUEbK2i8kbRAONf2JyYB96UT//fZB53cg47RmgZKCJ9md98E/rLbRgiFIamK3DYHHhh+hz3LUyCzCtYq2tv4wTfC+bpkANpzpKUcpQFN+ron00aUl7jmRqGnEMYjY8qCtOilQKFOf3736EOP2phKI26K+nSwTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jEuhreSt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LL2MNXfu; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jEuhreSt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LL2MNXfu"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F8C4EC00DF;
	Tue, 21 Oct 2025 03:41:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 21 Oct 2025 03:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761032496; x=1761118896; bh=Sp++pQYIsO
	YlDBBnJ62i3aAxrhZSCeC13T+rzKPRSv4=; b=jEuhreStZx252EVq55BTujzSuj
	1Uicf2txTgdurTFmJKRjgs24mv7nqPTA16RtrosmDPVfOU1EV950Lo6uz9I9qKu2
	zxnetYYXKufVerFGUbOYx+cBMtokEs0zkd9i1GjvaG267lPATJ05bALwIBmjhp0q
	LW+LAQB9ILnPHrKz43ZZvj4puwiVenmX0/b1RxrLbmjy5qn7Ru6Xlyf9LTlTuc6+
	8EohIgfE/GLQJpoyJhmlxakL2dcmqyKf5c3d6vaisy8mDyQWjhns7ObuWW5Qvd4m
	YnGhr3paHbk9lRdfJ1LnQI1eywZkmOVfxQqx3Y9Z4Yka+fYdIXwk+Jq22hgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761032496; x=1761118896; bh=Sp++pQYIsOYlDBBnJ62i3aAxrhZSCeC13T+
	rzKPRSv4=; b=LL2MNXfuQJKVK6x74z8q3N2LYDUKxFTnu9v5S7gipSzw50kcIoZ
	eD3uVVnzPL24m4tMyefjF1uD3339cr5LMPnCjcqtWPirIEjfvCMNsAVMwGvr56kv
	YE5wQebRIJr8s5+rQ/HO+xiVijAVTv7uj5kqNS1qJW7UlZc4HLVtoo+s4eviImAN
	U1zjuc5ufseTjoQDz8hjsst56qLR+IJ1D3hJtNupe1KglMddpdDNqg2kavB6WlHT
	R8EaTSpUD0anjqOElZAFpHaDvxNZGnY4bco9FSs8PDO1RBGxrNl5crMN8DGjXzP5
	kaPP883ac1pBFB32j7DJ1gdhYOjGvdtuhZg==
X-ME-Sender: <xms:MDn3aM8HBGSLJRYqGqXrecO6xN94av0WQJQrM_VDYKZt4l4B9U0eIw>
    <xme:MDn3aHQtQxyamIeFNEQyUYc6Xwv3Jb3shiocvY9sxrSktvNBkUYXFNODt98q8qIUk
    qp-DM3TepAsH_x5_xJFGamGP5xu8aYIqfYeY7rqwqsH5mudkDxmkzw>
X-ME-Received: <xmr:MDn3aFpnfmmw4Bgw6PBJiujqxg6T_Fie8q4XAy7_plgOgRaFe5tKrKGhkSIe2DceVm4qo2oMkpdhufDalVb_e1Cjn8OVa6Vjby_2yj9haXK0yA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegvmhhilhihsh
    hhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhgurghmrgiiihhosehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehp
    hhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprggurhhirghnrdhrrght
    ihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoheprghvrghrrggssehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:MDn3aMmSMdzwFxvrooBk0ZoMvqsvbBk9fgG96hcaMoWarvMcNF_t3Q>
    <xmx:MDn3aGdFyGv5SX_1UnHKPYomEIq-Jf9OCIgasX0mCeTYp6HBWkky_Q>
    <xmx:MDn3aArNNTFTS6nMllY92_Chn4ouGEx3HDVprsR8S1wNd-eQ7DfH6w>
    <xmx:MDn3aINFXsSxexGNxIr9dgkqmTAx-6qnGDeljEsMj6P-rByfKyyr4g>
    <xmx:MDn3aJy_DQodhhpWWLrMdAGvkezXb5wmzgC47XPaA767XTuOyvpizZ16>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 03:41:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3867f082 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 07:41:34 +0000 (UTC)
Date: Tue, 21 Oct 2025 09:41:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 10/10] receive-pack: convert receive hooks to hook API
Message-ID: <aPc5K9j1iMJmiGgu@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-11-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017141544.1538542-11-adrian.ratiu@collabora.com>

On Fri, Oct 17, 2025 at 05:15:44PM +0300, Adrian Ratiu wrote:
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 93b6f28662..18b5f22d44 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
[snip]
> +static int feed_receive_hook(int hook_stdin_fd, struct receive_hook_feed_state *state, int lines_batch_size)

The `lines_batch_size` can be unsigned.

>  {
> -	struct child_process proc = CHILD_PROCESS_INIT;
> -	struct async muxer;
> -	int code;
> -	const char *hook_path = find_hook(the_repository, hook_name);
> +	struct command *cmd = state->cmd;
>  
> -	if (!hook_path)
> -		return 0;
> +	strbuf_reset(&state->buf);
>  
> -	strvec_push(&proc.args, hook_path);
> -	proc.in = -1;
> -	proc.stdout_to_stderr = 1;
> -	proc.trace2_hook_name = hook_name;
> -
> -	if (feed_state->push_options) {
> -		size_t i;
> -		for (i = 0; i < feed_state->push_options->nr; i++)
> -			strvec_pushf(&proc.env,
> -				     "GIT_PUSH_OPTION_%"PRIuMAX"=%s",
> -				     (uintmax_t)i,
> -				     feed_state->push_options->items[i].string);
> -		strvec_pushf(&proc.env, "GIT_PUSH_OPTION_COUNT=%"PRIuMAX"",
> -			     (uintmax_t)feed_state->push_options->nr);
> -	} else
> -		strvec_pushf(&proc.env, "GIT_PUSH_OPTION_COUNT");
> +	/* batch lines to avoid going through run-command's ppoll for each line */
> +	for (int i = 0; i < lines_batch_size; i++) {

And if so, the index here should be unsigned, as well.

Patrick
