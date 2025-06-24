Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B5C26CE03
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779455; cv=none; b=FH+lScBxi4cTPYt+zq5DoCqlTKb+tCt6V4v6MpADmmjY6zBpQ9pHOmFo1JLmd9Izqe9go0UtiAPko0HeoWeBxr5PSAMaIqmwK+9nQpOcWghdpp3gvlQZ/73XXd6tpXffosSwaX8d1oTkc6/NlVtdgvQPybxbWHXui2DtFeNMW4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779455; c=relaxed/simple;
	bh=qVMT34LjtN3z7hjklKCDGWiHlsFU/JISykCGeOxiFG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dCphDlZwJpxtj9rlaT6ifrnyhmdOC8jpl+AcFM/yqqRJ8Lg5tDT7duHzCUbukCW1PGwLABTxW45xgQCG8B4RgJJJSZ39hIHIrZju1epw853UuUUQOl2DE7sSfRCpW+agqe+lspn6eqW/I+sHf6+XlZ3TYWLANBUBkpwZvZNlhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FokKs+mx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qfPDA894; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FokKs+mx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qfPDA894"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A6ECA7A0023;
	Tue, 24 Jun 2025 11:37:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 24 Jun 2025 11:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750779452;
	 x=1750865852; bh=FyZ8xtYkm+8XDY4iu0Rm06WExvTMPhI/vpVr3PIuGNs=; b=
	FokKs+mx7LWoB7R7KjnKbcIAuJvyPLxmrnN758KIsAY6t9z51F4joTp3HUBtaR4i
	Hgi3OUGudERmTjji7yg4KJ8N4ibV1fzexTjQyX578hV42U6QKQBPPCZopiU8FDEI
	WlwhyAyUCORpChIxHp7t8dVPIaksZ7lUxCVOAEGHz7IxPHzAd00rPNGRYWKANmq/
	ThVlxEd7gXdRMOt0VIAiZVhnVnEBujDJ4+P0D2L1f4RFLUU9PXBeZFXHnUaHV+A1
	2nlDXf+XRsogvzw1/f0+MuotfalWRXbppmkYIbamBSf2zquv9VCDUgFLMfLVZXME
	jx2qYSt4JwxApQqpr/SJnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750779452; x=
	1750865852; bh=FyZ8xtYkm+8XDY4iu0Rm06WExvTMPhI/vpVr3PIuGNs=; b=q
	fPDA8944Jp0DUii2WW5xmqlSZLgH2xpp0nANPMK2ED2FUXJ6HSjbxCRUquxcimN/
	D0s/1EKwObwGfW6B2525GuMmXt+FD1owZKfOizNVtOZ0lgeh4DAHcnT8F7dslhw2
	X8ke1NHOSIrYcBEB/Bco+VkkJTDI+DvMh7LKvlY9YPdG+h/c/SlFsHoTre2iqQex
	uVd5GlPIGcRU/6punsrcWhZRjv3HOviOJMwIucHhyIpHrOVUD5lVO2+vGAOjHMMV
	DVwXpFSbFEjbecamhtwphZQ2KBnbJnKoxQ5jxhSgug+fkV0VaduFA2QpaQKqr6Dz
	i5xnnf++AWujbyVvdKePg==
X-ME-Sender: <xms:PMZaaKGFwsyEUdA-LKf0iyBt-Ql2wkBJTdt2KSEEF_IUWb6Vm2D1AA>
    <xme:PMZaaLWnQwkKzjv8FQKIdm04b42V69WFbaLuKHT8Sq21pg5xxTJ3c9t5EAH8t7Uor
    Z5DQENeA4i7yphdUg>
X-ME-Received: <xmr:PMZaaEJet0ICT_OEK6PJFa-RMQEpfQOaZxvEEwg6y0LXLq57lh0wSmDPglHTlTrDUjLwobLdxmOoNmb7QNdJmQoSP9KcfqMYxhSxMVU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtddviecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:PMZaaEHafYwhGPNCi2vHFMTFY7xK_AYoqGGth24Yj3caOfGimvDPew>
    <xmx:PMZaaAUY3LEjbPIS0i1dykXj4LIgg-HCtZkQaQpZXlPF4H1o-28-Jw>
    <xmx:PMZaaHNUzXPpRNvg_KQLQraX_tFcNwOsd8AaJQfnSqrGFn_QzDlXxA>
    <xmx:PMZaaH3Y7c7SNU2kXYZOQ_wE4cqPJqKQKxQGrXHsk533KH7sISDruw>
    <xmx:PMZaaIBlnBtxXZ6T7FLG0YY0CIjvwZ9TvcOgqGm6M-GqNNAGnwzLZcNE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 11:37:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
 <carenas@gmail.com>
Subject: Re: [PATCH 2/3] daemon: use sigaction() to install child_handler()
In-Reply-To: <2e8c4643a60e354d24bda9bf364e1b34ce1c45ae.1750774122.git.gitgitgadget@gmail.com>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget"'s message
 of "Tue, 24
	Jun 2025 14:08:41 +0000")
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
	<2e8c4643a60e354d24bda9bf364e1b34ce1c45ae.1750774122.git.gitgitgadget@gmail.com>
Date: Tue, 24 Jun 2025 08:37:30 -0700
Message-ID: <xmqqv7ol177p.fsf@gitster.g>
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
> Replace the call, which hs the added benefit of using BSD semantics
> reliably and therefore not needing the rearming call.

"hs" -> "has"

Hmph, if we do not have to rearm, do we even need to have the
handler at all, now it is a completely empty function?  Presumably
we'll see the answer to this question in the next step?

> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  daemon.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/daemon.c b/daemon.c
> index d1be61fd5789..d870ad2f63c1 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -917,9 +917,7 @@ static void child_handler(int signo UNUSED)
>  	/*
>  	 * Otherwise empty handler because systemcalls will get interrupted
>  	 * upon signal receipt
> -	 * SysV needs the handler to be rearmed
>  	 */
> -	signal(SIGCHLD, child_handler);
>  }
>  
>  static int set_reuse_addr(int sockfd)
> @@ -1121,6 +1119,7 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
>  static int service_loop(struct socketlist *socklist)
>  {
>  	struct pollfd *pfd;
> +	struct sigaction sa;
>  
>  	CALLOC_ARRAY(pfd, socklist->nr);
>  
> @@ -1129,7 +1128,10 @@ static int service_loop(struct socketlist *socklist)
>  		pfd[i].events = POLLIN;
>  	}
>  
> -	signal(SIGCHLD, child_handler);
> +	sigemptyset(&sa.sa_mask);
> +	sa.sa_flags = SA_NOCLDSTOP | SA_RESTART;
> +	sa.sa_handler = child_handler;
> +	sigaction(SIGCHLD, &sa, NULL);
>  
>  	for (;;) {
>  		check_dead_children();
