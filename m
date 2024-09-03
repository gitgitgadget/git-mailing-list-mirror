Received: from pfhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C611AD24B
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358188; cv=none; b=DvosRouwufUAT0HP5bgBuLb7ZJ0C1F4j7+m3J93hU0J6cqgziw793ErxjSbM2b9Ccxbs4u2ntEDdVdMjd9cGc2/vT4m74fYzGF1lbMBpjfr9mLrbf96v4DBjD0bm78Z7jCljnEN1DnmwyBRJDJjjANjThOk0bbv+GHNVwyMpORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358188; c=relaxed/simple;
	bh=eoFDx4DWckTZ2gaNHulhdYzDgmCsDCIkkj415ay0uyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8BDSaBkbN26EcCPFT7u9eBtG1TUUVucsKdaEt/9IznXwgRp4IKjd29ikiAwF5FP2edOUa9i1+FlZ1hn9DRhmEkT+MBGRHi/Nu5loTFbz+SIy5USuGzCpSeyEc+Vmro37w1X/GmWU/TukkcL0eSm4wkwEFdG7Xi935r3pJ+pUyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pm2W/nyH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UkhcnPwn; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pm2W/nyH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UkhcnPwn"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA43A1140351;
	Tue,  3 Sep 2024 06:09:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 03 Sep 2024 06:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725358185; x=1725444585; bh=Y9tsf6Cauh
	9Wif4y3Hzigk44c4D18F9jwINumq7m5iM=; b=Pm2W/nyHcj+KwLbnb4Kaajjq9L
	ZBphFLpVJLtD3hMc1FU1tNmM4KfiiCV4l+c0ksDRtdTelOqCTEEXWnXh/YFOI2/f
	makolk/+4xUYnWo0Dl6o8SNCgd4RusE1xrxNbKjtel1fWJ+zhYslXFhKjly5nbPc
	en/FXRePsew7DrE/lQR1emiasKuB4FyES5zXvYfXoHKvVKbrZALaikUeOlk7exDJ
	ez8ilc8fe49MJ6dr9LQxXQG5cbSZ94+vc9McR4tHSKLzvmCX/hQE1HDU9xYEdE98
	mDuiZJiBZTKAUGzUh9XauOraPPJ0X8DOvcO1LeCDhGr7au15KlVjv5Pbq7Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725358185; x=1725444585; bh=Y9tsf6Cauh9Wif4y3Hzigk44c4D1
	8F9jwINumq7m5iM=; b=UkhcnPwnmFkeSnaGoPMfjneuV60Ng0gN4nB3XmXZ9I/h
	s4E34f6EyV+e+sZT9bxTfWe2DkkngBpaCOhKS0R1rE9U9NsahXjKfuLrZgCHT8gC
	qhKmvgvOCo0F6WRlj6694Hr0bazKdNyVEyWWxFM/G+fkPaKdjppRajw/9PWITlaA
	a9hqFH6QhWxy6pGvx/kgLtVjtk8PMbMwRjxVRuWW6DHSBYUgBsigSYZ2aq9+hnCa
	PauyLOSFKTBrAtTbE+D++1/hjIgoJ4Q3JD9IsQvhYUMrYVed/oT661hu/LB1RsnC
	aJNukiVr3Khx6WewKy3KZvE/3VpNokFxEXiaz67O2g==
X-ME-Sender: <xms:aeDWZoLo4wj0k_ZqDK5qRIy8gszBryEH3HXTjLAIxoAwEfRRsBn_OA>
    <xme:aeDWZoLnvOffNGD53v02VD374cxlVbYPbUymibymv37jx0E2n5BOrOO_MikLgwtXZ
    GSFW3mU-Wucao2lQA>
X-ME-Received: <xmr:aeDWZou2pYJUTWIxkc4TrD_G1bQgIdwO-D0eMDLV4J23hJ5YGggdxe8U-FIcguHtTfz1dAeDZ71cIv4E6thKV3PzCPEahSuVkkGVOkUJzUK38w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiudelueel
    gfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsuhhpthgpgihinhhggihinhesudeifedrtghomhdprhgtphhtthhopehjohhnrghthh
    grnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopeigihhnghigihhnrdig
    giessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopegsmhifihhllhesghhoohhglh
    gvrdgtohhm
X-ME-Proxy: <xmx:aeDWZlYHl5kdds4IWaZVx-dy5_fkqwlXCsFjBf5-rq1XPpVznDz6Zg>
    <xmx:aeDWZvYncannsY-8g35nwLsMQuf6Ve0p0ki6AB6RzgRnpY1OoUxvEw>
    <xmx:aeDWZhCkw3oeIRtopfBPC9194JbnfBZj8xUy-wHHX5orMUL5ItEm5w>
    <xmx:aeDWZlbMEJwhKtAVaZU4iqyFDmQoXKqkH1ueRcNTSEiVyRrEoQGSvA>
    <xmx:aeDWZkNyBNDrhCuilBImX_Q_BIEGR5PMGX-rXaIGBH5qeQcNS4z-6-d9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 06:09:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 30e28bfd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 10:09:37 +0000 (UTC)
Date: Tue, 3 Sep 2024 12:09:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	blanet <bupt_xingxin@163.com>, Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH 2/4] builtin/fetch.c: add fetch.serverOption configuration
Message-ID: <ZtbgZiVNrWVMBIWr@pks.im>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
 <7e2d5c504d762bb9cdb9ca008b92d349d81c194b.1725279236.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e2d5c504d762bb9cdb9ca008b92d349d81c194b.1725279236.git.gitgitgadget@gmail.com>

On Mon, Sep 02, 2024 at 12:13:54PM +0000, Xing Xin via GitGitGadget wrote:
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index c297569a473..d49dff8a76a 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -2231,7 +2241,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  			 N_("accept refs that update .git/shallow")),
>  		OPT_CALLBACK_F(0, "refmap", &refmap, N_("refmap"),
>  			       N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg),
> -		OPT_STRING_LIST('o', "server-option", &server_options, N_("server-specific"), N_("option to transmit")),
> +		OPT_STRING_LIST('o', "server-option", &option_server_options, N_("server-specific"),
> +				N_("option to transmit")),
>  		OPT_IPVERSION(&family),
>  		OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
>  				N_("report that we have only objects reachable from this object")),
> @@ -2272,6 +2283,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	argc = parse_options(argc, argv, prefix,
>  			     builtin_fetch_options, builtin_fetch_usage, 0);
>  
> +	server_options = option_server_options.nr ?
> +			 &option_server_options : &config_server_options;
> +
>  	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
>  		config.recurse_submodules = recurse_submodules_cli;
>  

Doesn't this mean that `server_options` will never be `NULL`? Why do we
have the new checks for whether or not `server_options` is set, like
e.g. in the next hunk.

> @@ -2418,8 +2432,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  			result = 1;
>  			goto cleanup;
>  		}
> -		if (server_options.nr)
> -			gtransport->server_options = &server_options;
> +		if (server_options && server_options->nr)
> +			gtransport->server_options = server_options;
>  		result = transport_fetch_refs(gtransport, NULL);
>  
>  		oidset_iter_init(&acked_commits, &iter);
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 1ef540f73d3..ae25400010e 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -368,17 +368,45 @@ test_expect_success 'ref advertisement is filtered during fetch using protocol v
>  test_expect_success 'server-options are sent when fetching' '
>  	test_when_finished "rm -f log" &&
>  
> -	test_commit -C file_parent four &&
> -
> +	# Specify server options from command line
>  	GIT_TRACE_PACKET="$(pwd)/log" git -C file_child -c protocol.version=2 \
>  		fetch -o hello -o world origin main &&
> +	test_grep "server-option=hello" log &&
> +	test_grep "server-option=world" log &&
> +	rm -f log &&
>  
> -	git -C file_child log -1 --format=%s origin/main >actual &&
> -	git -C file_parent log -1 --format=%s >expect &&
> -	test_cmp expect actual &&
> +	# Specify server options from fetch.serverOption config
> +	GIT_TRACE_PACKET="$(pwd)/log" git -C file_child -c protocol.version=2 \
> +		-c fetch.serverOption=hello -c fetch.serverOption=world \
> +		fetch origin main &&
> +	test_grep "server-option=hello" log &&
> +	test_grep "server-option=world" log &&
> +	rm -f log &&
>  
> -	grep "server-option=hello" log &&
> -	grep "server-option=world" log
> +	# Cmdline server options take a higher priority
> +	GIT_TRACE_PACKET="$(pwd)/log" git -C file_child -c protocol.version=2 \
> +		-c fetch.serverOption=hello -c fetch.serverOption=world \
> +		fetch -o foo=bar origin main &&
> +	test_grep ! "server-option=hello" log &&
> +	test_grep ! "server-option=world" log &&
> +	test_grep "server-option=foo=bar" log
> +'

I think it makes more sense to check for the new behaviour in new tests
exclusively. Otherwise one is left wondering whether any of the old
behaviour changed.

Patrick
