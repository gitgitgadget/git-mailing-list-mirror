Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DBD38BF61
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341504; cv=none; b=Q/VWT7gH7MTcG+cM+6WltUzPMiy/7E68NLEYKy5gH02FFYjOfq+Rh7IKxkH5wOQZXDadVGdgQpbzFSJe7fKCxerOQrVmY4IkythyMjSr8gcGbRjBztuHP/IqdXX9/p7uf3/r2SL7zeKQRZELRLHpIq0Rpb1+CiA4B6pBUsYrK78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341504; c=relaxed/simple;
	bh=jnBODvlat48pD7cmxCJ1Iv+lOVbYgiedQxJX20lRCIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8NHeZ56uYanlp7ezxnWOapJ/ZHh/9KmFZRvO7BoLQdXlW5I1ch7QuEEKCHEioN1YNQPzYjs/e+aPTHgbLifPF4kgF2GATN533gHenOMMWQFYjw4Y/POkneF0l0RIpOPI18ZkPep4yAT0pnlAkRTf90NJibrs3STbRjPKXgYC8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k/thTvRo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XFXZyeWg; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k/thTvRo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XFXZyeWg"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7F69CEC01E1;
	Tue, 24 Mar 2026 04:38:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 24 Mar 2026 04:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774341497; x=1774427897; bh=39tctibbN6
	uee1bxSUtECzwXym9rXH6Z1F8UMeLhWrk=; b=k/thTvRo/uK3czQy4IS68rNMeF
	XIFPY345FkyHqYvkDSnLb0NVJUZEjln4yIXRlnVWMYUnKeh5xPZ0mpiB3MJChYd5
	sDK8uPceYuBrv2brXN6v1FAuIaydBcDI8w0HViCx7OAkm+GeEEALGrkd8kLk6eRe
	NY5huOviRPrmi9En1xPF7dK1vqcUWo2D2SSPoGGCv6E2vlLyUSD0XwOzhiTk6frM
	qksAokGDzeGCi9SVaFgoGYat5gKkJPjhPrcjesPXXv9tD+IgyYuE6ADLEr3aKvZa
	6eP71NZf+X9LUCGcZ5LOqiih/LAGOq3yAgHfiCXQNUqtz5Pd5c0OBQLy5Hrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774341497; x=1774427897; bh=39tctibbN6uee1bxSUtECzwXym9rXH6Z1F8
	UMeLhWrk=; b=XFXZyeWgWaBsrdeoXjgQZAZeV3Ot4eGM2bjRs9574lQ8w/JeEsz
	YvO4mRlIUXE6XFhDvsWDMnQRbb7Zb1A3Bdq7FOqa+QfsIWZPdxqziSGifR7d3fyQ
	PO5qDSXQFYQaT3mrajsP/aK2ILfKnQpnmxyc5KR0+1P6jhgS+0XTmqIhaZB+kCss
	wuf0zhABeaLQgBuJPCN3lEN0VY+GuH1/dvBveB/Ng+He2gGWHUvFOvW7qdmR1UC9
	FnzDOdtkbwCo5EtQxJOyl54SSbvKJyT6dAD9xiREaoqxjyK0VaPivGLD9Ecoz5ln
	52TZudUp29yR6Qsbn6sxEJt8qYm0I3uxsmQ==
X-ME-Sender: <xms:eU3CadMf4tJ3h9i9C4fMsAZi_csMHwBWASr2kb4R_63Q2KgSIn7j4Q>
    <xme:eU3CaW0FkF46H2B0yhTAV_UjOwdErZEgsQtn8LUaRDGxtoe2RPf96KcHOH9KWM9a5
    5zLpCPegny8YeUNolAkGFmW2iQI45gKERjhh2BGaSGOKTCTv5sNfg>
X-ME-Received: <xmr:eU3CaUnQwNF7hOn3hxu9MeqdyqaZngNoV2rG8eHfKUoe3bxuH6Ne-cOIKpYcjO4D7wl18h-1Zb8BQteCo6op9yvrULfDnHR_TSaPejJwZFm1eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdduuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvmhhilhihshhhrg
    hffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggs
    ohhrrgdrtghomh
X-ME-Proxy: <xmx:eU3CaVVvJ2HsGAl-ho0V7O-GdizmNodirJbUeOHRxRPNe_ctBbv5nQ>
    <xmx:eU3CaSuCQlm16nirCy8ytjfOO5x8PRSP7cYVytTwzPShXfz4O3yyEw>
    <xmx:eU3CaQZo5A9D3KsI2FSd_FX-tMV69BBRRpSTsTALlF_QWJB3QIrMcw>
    <xmx:eU3CaZX2dmmskwrY4BD6ytHBvsSKxyBcNGFyFG9v_-7rorI7fPOJRw>
    <xmx:eU3CaUrCBKkpYLdP0aEwHLnTLnIkCQkL3PNF6w92qqFtEN7-Cb58waZV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 04:38:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f43d48e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 08:38:15 +0000 (UTC)
Date: Tue, 24 Mar 2026 09:38:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 10/10] hook: show disabled hooks in "git hook list"
Message-ID: <acJNdKyz-ISsq4fJ@pks.im>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-11-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320115211.177351-11-adrian.ratiu@collabora.com>

On Fri, Mar 20, 2026 at 01:52:11PM +0200, Adrian Ratiu wrote:
> diff --git a/hook.c b/hook.c
> index aa08c38c27..0e09b9a2bb 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -119,6 +119,7 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
>  struct hook_config_cache_entry {
>  	char *command;
>  	enum config_scope scope;
> +	unsigned int disabled:1;
>  };
>  
>  /*

Curious, this is now a single-bit int. I still would have expected a
proper bool here :)

> diff --git a/hook.h b/hook.h
> index 92e9faf9bb..7c8c3d471e 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -31,6 +31,7 @@ struct hook {
>  			const char *friendly_name;
>  			const char *command;
>  			enum config_scope scope;
> +			unsigned int disabled:1;
>  		} configured;
>  	} u;

Same here, I would expect a proper bool.

Patrick
