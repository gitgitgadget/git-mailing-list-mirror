Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA7D139E
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779810; cv=none; b=qAq+KRhR3UAoAuf1PijooHHRVZxNnRPrssz8+wQmDVixJBLy2IMnuYTFr1z3Y3tlvA8KwbHU2ICVfUjVVc+0OMImmOyxldrCNT23fW88xdb+NxcuHLGShvkL1cfrFwdVoMcU+0qE4UypHG/DC6Qfj31xPLuh6ItUzqtwdROTfjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779810; c=relaxed/simple;
	bh=5cz6JIb4WRME6Zb7ivHGTfty53NOhuAj6gpDUs4nAos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BxGxLEGvH64g5DSS4C4A9nP6Rfp8hBOLhnQ6t+JK07estUzgMjXLsDdS10tuOGaX4OExPxPJrtFHAJjaCN7uTorBF2a/s/RHCP4L1hk9arGbJuq5zgqXzglMjd7+pR3j/wJgqbKB9UpHdnA6Qgcb7SENAr7SiI/Ic3INSTJ1I2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VRdTWz8R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qOtPsTpe; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VRdTWz8R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qOtPsTpe"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2967F7A0161;
	Tue, 24 Jun 2025 11:43:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 24 Jun 2025 11:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750779807;
	 x=1750866207; bh=5JSOnHmyzC0ge3JRbgpduUYuI9916K2Da+c7hIkk0eU=; b=
	VRdTWz8RaaLD/f+06gWI+bW9lc7l1rB8nrlFY/uw9ML/wiJMxoRJXH7bOXmFtp4A
	A9G3cJ/7zlNgdLrCP5H7ocMJCAaxP7VtcbO0KTaWzISES2HWRQYmKty4TKKcMKs8
	QQ0tGL9gJEoUBDMcaRkNxQ24knDaHzbONTW1muvYfQB7NEFXytQvPhHz/F7KqJGT
	jzdE45p+uLHhJOxs+/viqklWO+1Rwc7ZjryAIp2iUsF8DMgqjyi3mYLghSNpKFEo
	4bs2l4qQZBjD+UVCiwDlDkcl9WaHdMtXCYHU1dO7y3SexkdsnP8/oaUDSgR0LJVI
	p8AhWZhYNftaOO5WpucPog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750779807; x=
	1750866207; bh=5JSOnHmyzC0ge3JRbgpduUYuI9916K2Da+c7hIkk0eU=; b=q
	OtPsTpe1b5rg++MTxOTlorqOhbCRHEaxGEIUh5B60SHN4O9qj0HtpfMKxQWej2GZ
	zK/NeKu4z9cz/UkJ//TkDD6lwwO8vxd708FGKYObT8LrAsZhe0bUnW0Sjw0VeyLc
	gwEqQq4LsW974/7EfuN2U2Ekfn45QbCki8/ZSfJUEcxRfidZjluGm3LR+GHZpYrR
	NGWDw0ONaHXQxkR8mCXKuZLKkKyZbvXcHs3hSLc5MDe+0/3c+C/JgUkzBbR3MvbM
	BmgYzpbXnjY1aN4Vgd3Wams/e5PblecczoaKbtm4riArG+IWSuYYYdj2z0UPzQGn
	9fsSOzZAqH4odfGyDlc/w==
X-ME-Sender: <xms:nsdaaOu6viQFNFp21BI21BxaDHZTTBHAzJSh3bwE64zX7ECczAupMQ>
    <xme:nsdaaDfUvmNxG1yxTqOhGex8r9dPVlypTWQMVd855-16geOL5j3Mw8YbIxjA0oucG
    CMFco8vT3Lxwdjjxw>
X-ME-Received: <xmr:nsdaaJwd_jY3q8T5oqVopRU3dvA0fQg6yMDY_XwyLaXS9t29RObycl_AoE7h41fXUZW7-DlP1zKTodxQIprzHVlCbZdJzGGAmhxrxJU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:nsdaaJMvgJE_ZClUGXDpUjghDUTV9djPMcB1k3qUg6wBN8Ur-Rf7dg>
    <xmx:nsdaaO8XGrAzp_URTB1axqeqi_ISZ0CclRqH9ZqCcVlUzVSFIL8bGw>
    <xmx:nsdaaBWH1z_7qA0uCWvhAarD7QE7J-Wi0ePrDCxANHG0fm4YglYuSQ>
    <xmx:nsdaaHfzGgLgLYzWV-sOEDZTxvdj6cfLDxjjHWKkdle8oZILn9b9zg>
    <xmx:n8daaFoZcNiUcVRTEkWLlrLi__tPj533OhNJ2td3vU9Jljk45HDh7dPo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 11:43:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
 <carenas@gmail.com>
Subject: Re: [PATCH 3/3] daemon: explicitly allow EINTR during poll()
In-Reply-To: <a450bdb0066912d135dd242090b012de0bc18180.1750774122.git.gitgitgadget@gmail.com>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget"'s message
 of "Tue, 24
	Jun 2025 14:08:42 +0000")
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
	<a450bdb0066912d135dd242090b012de0bc18180.1750774122.git.gitgitgadget@gmail.com>
Date: Tue, 24 Jun 2025 08:43:25 -0700
Message-ID: <xmqqqzz916xu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Carlo Marcelo Arenas Belón via GitGitGadget"
<gitgitgadget@gmail.com> writes:

> -static void child_handler(int signo UNUSED)
> +static void child_handler(int signo)
>  {
>  	/*
> -	 * Otherwise empty handler because systemcalls will get interrupted
> -	 * upon signal receipt
> +	 * Empty handler because systemcalls should get interrupted
> +	 * upon signal receipt.
>  	 */
> +#ifdef NO_SIGINTERRUPT
> +	/* SysV needs the handler to be rearmed */
> +	signal(signo, child_handler);
> +#endif
>  }

On NO_SIGINTERRUPT systems, signo is UNUSED, isn't it?

Can we abstract this a bit better?  #if/#else/#endif sprinkled
everywhere is simply an eyesore.

>  static int set_reuse_addr(int sockfd)
> @@ -1118,8 +1122,10 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
>  
>  static int service_loop(struct socketlist *socklist)
>  {
> -	struct pollfd *pfd;
> +#ifndef NO_SIGINTERRUPT
>  	struct sigaction sa;
> +#endif
> +	struct pollfd *pfd;
>  	CALLOC_ARRAY(pfd, socklist->nr);
>  
> @@ -1128,14 +1134,22 @@ static int service_loop(struct socketlist *socklist)
>  		pfd[i].events = POLLIN;
>  	}
>  
> +#ifdef NO_SIGINTERRUPT
> +	signal(SIGCHLD, child_handler);
> +#else
>  	sigemptyset(&sa.sa_mask);
>  	sa.sa_flags = SA_NOCLDSTOP | SA_RESTART;
>  	sa.sa_handler = child_handler;
>  	sigaction(SIGCHLD, &sa, NULL);
> +#endif
>  
>  	for (;;) {
>  		check_dead_children();
>  
> +#ifndef NO_SIGINTERRUPT
> +		sa.sa_flags &= ~SA_RESTART;
> +		sigaction(SIGCHLD, &sa, NULL);
> +#endif
>  		if (poll(pfd, socklist->nr, -1) < 0) {
>  			if (errno != EINTR) {
>  				logerror("Poll failed, resuming: %s",
> @@ -1144,6 +1158,10 @@ static int service_loop(struct socketlist *socklist)
>  			}
>  			continue;
>  		}
> +#ifndef NO_SIGINTERRUPT
> +		sa.sa_flags |= SA_RESTART;
> +		sigaction(SIGCHLD, &sa, NULL);
> +#endif
