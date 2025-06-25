Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1312A1DF256
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867575; cv=none; b=XoeocHLSJOMBKaozt9aVH0ybQNvtJPEUU7GG6DZi9rAJMrQ2HkNe/3x4h8gKgb6Tg+p3+PGL5/cuwZaqNyvf6YAzXmKUwlrfMNS2ZGwTI//El6CxMOxAlrM2RYjAR9MyfqvbM22NVGOwxGXNhFq2IhevSTIscW4m32r0AmpOC4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867575; c=relaxed/simple;
	bh=soO6IxsJBtHv2Z1r7OAz3s675Nmlm/fEDBXLJUYcEW0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M2WFd9RUPfGYEYYtY6LztvuWwGodcS68sNFsx3d2sbgCAS25sOYg4UysV4NYk7gV3jEGjgiuNNtqqDzGEMCnQW3YCkWoH7SgGYE77RtkjUZyhfCPG3lIqnZMC8Y1rDZ4SoRx21hl2y3QzSqFJgsYwSMO92tASHlRXwE3JUdZdO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B9abqtFA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bAPYmXCf; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B9abqtFA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bAPYmXCf"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 230D21400196;
	Wed, 25 Jun 2025 12:06:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 25 Jun 2025 12:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750867572;
	 x=1750953972; bh=VE1UkIBrOw2P9BNids1NvhYWpHkApOhKj33ubZrdIh0=; b=
	B9abqtFA7G9Hj6bxenCTN3+KPJ0Pk897iPI2o/VYs4VXJ9ftg0lFrpE5SGrOgaxE
	wi/TsgZ0zvXM8ZghxEuL9qsIc+1ao/IQnGzLqjFylMAkkfNdacnt2Wm5USVJhhSW
	zaPhBcEtT11XbjekMAuwJJnbdBhPynfDz1FZiFk5Bv349SZdWsBqZkGy2hp3bBZN
	XgnzDdjwo25fzSK6CXCIIOiZpgxaCuOuAWRUq3/B06lJmVA15go05CT3sta2oA+6
	9mxEulyV4OElwSOcWfGON0oLaGzhqHMQPQY0aWVUcZK5FyN0RXR9Cl7w0Ft1CZPy
	IdK/vMKLXuNKTs4vD5cowA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750867572; x=
	1750953972; bh=VE1UkIBrOw2P9BNids1NvhYWpHkApOhKj33ubZrdIh0=; b=b
	APYmXCfo9yQgqQB7533ve3reZNMl8DAbvJ+SNMwSSjUGPlUrqS6YdCsArBLhmR86
	IkfS+S1hK3NEXkFlEOtAmMQvdQRXANSmlYoy1DXvotW5gBhHMa6vONPUlQrsV8m1
	//3FCSmnBHZe8sKRk9lCQFfoPnggeV5btggutPHuArlynw5/P/v2FbmEwI5CIN6n
	H30KNoWzJeI00uJpthzl+1PElu8Q0SPTeVx0hB2Vv4Ft0o3fTY+5tei12f5gKBO8
	iIF4xBRIt4RUd17dQ82EtWgatMHr11zeLi/ezpieyXgPle9p198e445+o+aFehU0
	By48ePepmF5DtDNfWIeTQ==
X-ME-Sender: <xms:cx5caDzKhGticl9FXlbFmvBmIyE-ptFKlspgI0fPri3p8RF6lM3NRQ>
    <xme:cx5caLQfgtTN0Hs7poeklxkl9M2KW_h4Ezb75AS-KNp9IC26ien0o_6h7hI1ktPF6
    LDK01tLT7EGBX4d4Q>
X-ME-Received: <xmr:cx5caNWPM628Dmw39EvlmzqmwJhFEMjmVXO1TX-FrewKYuEPLVHUF62r9h7N9D1K9N9cuPq_jjax9d9d_9Z1L3BL5nlewLGmZQNQ1uM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrthhorh
    gvkhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:dB5caNgHbaW3xfxhw3zAhjWQq_92UCpQGCeOpgEVwqcKAwOFJGJ7iQ>
    <xmx:dB5caFAr3CtqRn2cMal7UTHLdfpcW9f46YmobSqsOkn9VL8t_YDl7w>
    <xmx:dB5caGLtTkpyyqPAT8dmBUSOWH2QvKDf5rvYPwd3lav_CgLtMG4Sdg>
    <xmx:dB5caECw1tFRIezAm2qIMl-P8ypTbqr5-LySQ-kccT-CQTzqobjI5A>
    <xmx:dB5caKCyUuCLUjso3sNvHL54dCcCOMkg9XwLvH31LXt6I0vuGgTJXXtW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 12:06:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
 <carenas@gmail.com>,
  Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 2/3] daemon: use sigaction() to install child_handler()
In-Reply-To: <05d945aa1e546bcc028e215c8e4d174b5e0c32ad.1750836928.git.gitgitgadget@gmail.com>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget"'s message
 of "Wed, 25
	Jun 2025 07:35:27 +0000")
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
	<pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
	<05d945aa1e546bcc028e215c8e4d174b5e0c32ad.1750836928.git.gitgitgadget@gmail.com>
Date: Wed, 25 Jun 2025 09:06:10 -0700
Message-ID: <xmqqfrfnyff1.fsf@gitster.g>
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

> From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
>
> In a future change, the flags used for processing SIGCHLD will need to
> be updated, which is only possible by using sigaction().
>
> Factor out the call to set the signal handler and use sigaction instead
> of signal for the systems that allow that, which has the added benefit
> of using BSD semantics reliably and therefore not needing the rearming
> call.
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  daemon.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/daemon.c b/daemon.c
> index d1be61fd5789..8133bd902157 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -912,14 +912,19 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
>  		add_child(&cld, addr, addrlen);
>  }
>  
> -static void child_handler(int signo UNUSED)
> +static void child_handler(int signo MAYBE_UNUSED)
>  {
>  	/*
> -	 * Otherwise empty handler because systemcalls will get interrupted
> -	 * upon signal receipt
> -	 * SysV needs the handler to be rearmed
> +	 * Otherwise empty handler because systemcalls should get interrupted
> +	 * upon signal receipt.
>  	 */
> -	signal(SIGCHLD, child_handler);
> +#ifdef USE_NON_POSIX_SIGNAL
> +	/*
> +	 * SysV needs the handler to be rearmed, but this is known
> +	 * to trigger infinite recursion crashes at least in AIX.
> +	 */
> +	signal(signo, child_handler);
> +#endif
>  }
>  
>  static int set_reuse_addr(int sockfd)
> @@ -1118,8 +1123,26 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
>  	}
>  }
>  
> +#ifndef USE_NON_POSIX_SIGNAL

Does this #ifndef block with #else lack its #endif probably before
the service_loop() is defined ...

> +static void set_signal_handler(struct sigaction *psa)
> +{
> +	sigemptyset(&psa->sa_mask);
> +	psa->sa_flags = SA_NOCLDSTOP | SA_RESTART;
> +	psa->sa_handler = child_handler;
> +	sigaction(SIGCHLD, psa, NULL);
> +}
> +
> +#else
> +
> +static void set_signal_handler(struct sigaction *psa UNUSED)
> +{
> +	signal(SIGCHLD, child_handler);
> +}

... around here?

I am wondering if it would make it even cleaner to also define
rearm_signal_handler() in this "if sigaction() can be used, do this,
otherwise do that" block, and move the whole thing a bit earlier in
this file.  That way, the primary code paths do not have to see much
of the #ifdef conditionals.  With IPV6 related #ifdef noise already
contaminating the file, it may not be a huge deal, but these crufts
tend to build up unless we tightly control them with discipline.

>  static int service_loop(struct socketlist *socklist)
>  {
> +	struct sigaction sa;
>  	struct pollfd *pfd;
>  
>  	CALLOC_ARRAY(pfd, socklist->nr);
> @@ -1129,7 +1152,7 @@ static int service_loop(struct socketlist *socklist)
>  		pfd[i].events = POLLIN;
>  	}
>  
> -	signal(SIGCHLD, child_handler);
> +	set_signal_handler(&sa);
>  
>  	for (;;) {
>  		check_dead_children();
