Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A84037F743
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 07:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610168; cv=none; b=Y8mHFkykvETttZDxnKxhxkn08ANtkJzLRpWh4UusFfhbjzXFncfAxDZ/+K8yaPQvhIEtO1wJ3bL9sfpk2hvOrQgVhcqra+9kZRszuY6hM9H8wd15TncC8IJtl3B4ALMMlRWgxlHggOFIi/AD27VM8Vav29FHBWGSwlIxtI5WmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610168; c=relaxed/simple;
	bh=JIIxqo/YdcczVbzYw7cDDkQEhQiDXBCvzsID0ngv4PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnYndvURjNZ/YO092gAKLZ3BMrZcL0hOchmoHK2d11xlFHAgnY1Kh4yz04eq3/qju2reZg2p9owdNYjFlOQTbmTekB0VHdTzqUM9qf4mWm9QTNtCiGrsy1mNBizL2xVKI73/zm5LdvDhnKaDMzypNw5e6KmSXJxfzw7z331o5B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Aj/FBqg7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pzvpIfUq; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Aj/FBqg7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pzvpIfUq"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D07F714000F5;
	Wed,  4 Mar 2026 02:42:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 04 Mar 2026 02:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772610166; x=1772696566; bh=EvY4zvoVF/
	DFNUStULluhtaETRDvdXmsACHTb/x4+/I=; b=Aj/FBqg7kcuLEg4hdKL0r6lwkS
	UcS7xx+Gdqpu94mFMC24CHi6f5qhnmUIV4SlphGZ9oD833Mh1a1jCX4dFBm/VqxU
	D/hKuIKTNOgTdbMvWDLtz8PzCNf52jVthodpH2sDkIET6VJrHTJsIN3LHOnehjXK
	141z4FI5bPpfsiPjZDU2jYK6R5Tbu5rCe1YLDtDSdFg7Cya/k+GE6fekf/h6tf3m
	4qFyrqjnWsQVWi6kKhfxAGgryGBtCthlHxrmopf6X8bzjIKNo4nBslXOICdf7e8F
	vYAnm1PtRK/EwF2UgW7JARHitXTzKU1Nnm6lcqIOVg2ubyx2Ii9yKuao/b0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772610166; x=1772696566; bh=EvY4zvoVF/DFNUStULluhtaETRDvdXmsACH
	Tb/x4+/I=; b=pzvpIfUqVguUCmzaZC7yWKYNcllD16fNPJny8zRHsXV2GPU+H33
	nPQRgK0SCLq+SI6czSDuoR/kwuZ3H3s3spL0lqbJIiWtXBg21ug/G+ZQpIATg80N
	70lR+vo8faP7Hz02kEI7CR10YQplPTPLqjbQ5OIwH56JJ6WLNDsDTtNks3e/ApQl
	3Hc0VTXH77Ut3xqRRs2ub9ebNSIHWuXQwBXgs/LmeaAHbzgPLrfw7UNHwVlElLHB
	KFzRmxs0ewE8GbLAawbegTcKFI1mBum41pfLmSGHko+KXOOqGcgCbLseLu8Hts1W
	Fn+jPqNRFsowAh9VJiqqMU6M7D7+YC+b4iA==
X-ME-Sender: <xms:duKnabzwTvO42oWbj-D2RMajCdcuC3Y8b43QhoEsLMtft-cB3_hAQQ>
    <xme:duKnaatfByyQpz4WH9EieeU1h_gYKqzutn5HTw7I_IraPMMapVF4ngt6fIGMQyrxM
    yRO3zsaPpGQRI6_0YtQoUJcI5WvVpUamUmDROKGYsWuV9OiBGCcDQ>
X-ME-Received: <xmr:duKnaStmOQ-8xKWbTMARl0cPUQqva2StgpvMdP-tJprSQ6fBRU2P_xk1C7FwyGVsllOEY3fB75oraU_4VxbVh5CA8ttM12MQX-sHPReR39SLyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhthhhusgesphgruhhl
    ihhsrghgvggvkhdrtghomh
X-ME-Proxy: <xmx:duKnafOlqW-Q38hOHGbY0xFN1a_QHvC0WY5i2995sfOgsd83XYFtoQ>
    <xmx:duKnaQ12uRZLf7e0r87zEmuI35JGkUUHiJrL_v8HxphglxWmTaquHg>
    <xmx:duKnabNylHHMupAKX3GGlcEzID3u2MlMC9uNbIy_XpcalQBTKY2grA>
    <xmx:duKnaQ2yGCACnMSOFYanGAlFiuOe3WUOdykOMgm85dKnOle82st6Cg>
    <xmx:duKnadJhg6UTyeBfNgDk6vnMEtytIB6s1tOITVzmVxdMYEdDZdsO8qsX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 02:42:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e36da36c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Mar 2026 07:42:45 +0000 (UTC)
Date: Wed, 4 Mar 2026 08:42:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v7 02/10] fsmonitor: fix hashmap memory leak in
 fsmonitor_run_daemon
Message-ID: <aaficy025yUqsgN5@pks.im>
References: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
 <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
 <d0bd3e32ca32b4150054ea91aa774a5b2db427e5.1772065643.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0bd3e32ca32b4150054ea91aa774a5b2db427e5.1772065643.git.gitgitgadget@gmail.com>

On Thu, Feb 26, 2026 at 12:27:15AM +0000, Paul Tarjan via GitGitGadget wrote:
> From: Paul Tarjan <github@paulisageek.com>
> 
> The `state.cookies` hashmap is initialized during daemon startup but
> never freed during cleanup in the `done:` label of
> fsmonitor_run_daemon().  Add a hashmap_clear() call to prevent this
> memory leak.
> 
> Signed-off-by: Paul Tarjan <github@paulisageek.com>
> ---
>  builtin/fsmonitor--daemon.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> index bc4571938c..4d52622e24 100644
> --- a/builtin/fsmonitor--daemon.c
> +++ b/builtin/fsmonitor--daemon.c
> @@ -1404,6 +1404,7 @@ static int fsmonitor_run_daemon(void)
>  done:
>  	pthread_cond_destroy(&state.cookies_cond);
>  	pthread_mutex_destroy(&state.main_lock);
> +	hashmap_clear(&state.cookies);
>  	fsm_listen__dtor(&state);
>  	fsm_health__dtor(&state);

Is this actually sufficient? as far as I can see, the cookies are
inserted in `__wait_for_cookie()`, and each cookie also has a name
attached to it that was allocated via a strbuf. So don't we have to
free the name, as well?

Patrick
