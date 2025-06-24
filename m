Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F28462
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750782026; cv=none; b=q3od9jCBaFDIRdc8k2xQ2gPvJoKiv/ANre2uX4Mo22tKz3+HC5ct+aAb7GfFkpV2WzqlDjtbhX/03/ROsEzyaUE7UfEk6zYWoFa3m4/J4BPJex/w/4m3qYn2f/G/Awzm6z0tADnwzWafNTGnGE+//1lavM90NQUC6eQhLMV5tIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750782026; c=relaxed/simple;
	bh=JdKSpex7fkaW4O5EoQk0Z1hccVx8/kDlhDgxhapUjaQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PcNnx6pMSuw8rcx2osc0x9Zg/kVvVAeG4Sth5JuVR65Xlu+RjQyEP8mdMe72AP58GY9p6JUYX2DLPNVXeGpz0sWl0VOGH7A6H2YWLl0Ln4iH5XYSG3nIS5gNCyyNSToUNYBL3Jk4BSVBYJXhKbH+4yiHuLakQx7yGE2MAtc38YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JwftwI4H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HSeD+2wd; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JwftwI4H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HSeD+2wd"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CB6957A01AD;
	Tue, 24 Jun 2025 12:20:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 24 Jun 2025 12:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750782023;
	 x=1750868423; bh=0+dJ2OlAobOvsBken1yt0lJUrFx9i7Y6A2c58s94AHQ=; b=
	JwftwI4H0VBZAga2WIWHFwKsu2dV9dCfpVgeKEJx1gE1xVRCOHht807WnZLit455
	nl/VkPBenU94zCjgq6XbSJgmaUs61dFIoSsjZpymusGLiZtFn05753JPjuZKvi+i
	cEw4xSxUnt++v1XZnR5YCEYmKzNzb2q43OCqrpm/NNEU84xD5NnT7M8QWKZWIJTG
	g2li8clBoYqTWhodH9AKQ0DK/KWPF9AgoHlxnvkiLSzjO4N9fjTDl/it1bs1u1Nn
	YMyH0JMvxPTODJqXBU4X4mqOgMLqrsd/yuyK9bFD0w5I4NS7w38R3io30ertUiw/
	1owhXEM5EZTNqi67gSiPdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750782023; x=
	1750868423; bh=0+dJ2OlAobOvsBken1yt0lJUrFx9i7Y6A2c58s94AHQ=; b=H
	SeD+2wdJO9+/It1iWGKYJKOIb+2pMoSRYBt2g7MWJxXnQGRzo0+XPVkYO2Nmozw8
	dq/DGX1HM9IKmwJvmaOYrNIW0nINIedhqTsJY3TulEWDpq0is92K6KwDeIzM/vvn
	R7x1tQ/J61tRN7mNg8Brt0Tlt0ZO+7+fjRSlvyXIVCFhHyG/VUDtCeNUe6lEwSJJ
	VEkba0DeAmdxmOizqOH7LW0odV1wC2A9tNobLaaKBIRJPuHWL19+wFITk/SU21F/
	li2tP9e4sQ3WwpwX+viVy2wTD1imvxZSIBv1t8tzaL0Ydr7ScNchTX4Qx1m/bYYu
	UjdYfHBQQgTVFTwrzj18g==
X-ME-Sender: <xms:R9BaaKl49I7T5599YsQk9jr1lr6bCVXRa3uQ7IbAA-GofuOwZ--GQQ>
    <xme:R9BaaB1SQZT5vCV8ix7Xod8SV_cB8PrkfptOjTF7f9b8FrTpktVianPcziMdU4zCu
    pxcKq_JsrUq7CMdCQ>
X-ME-Received: <xmr:R9BaaIpcsp9eg7Kelj5_eXZKki5Orp_KF9SJgvFf2aMgyL3jvHB1vluGOzQ1ph_bZMUFbDt2AlcrIDYFWkVqHn3MhsyzS-xRiy_Awqc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtdefhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:R9BaaOnOMH6oPE7K9ZSPqqfP6MyEym-PA2UJN1XQbv7S7Mlsu8T77g>
    <xmx:R9BaaI0zvZ2Kl3sFKdKZd8sbhjg3xhrOq6Ezxq9Fla_VdBplLlvsoA>
    <xmx:R9BaaFs9wnKDzDAWIesJvucrKnYqz1XPdw6qxkfsoX0CYX9J_-IrwQ>
    <xmx:R9BaaEVzVUy7Qm4uEQCNd2O8iMNG1kEFt7SAr62jzW2najGlq42h2Q>
    <xmx:R9BaaMgNoeWCuvsVNJQwtWnaooA3Qc3yqM-df-9LJTmmXNYkBurFVtEj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 12:20:23 -0400 (EDT)
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
Date: Tue, 24 Jun 2025 09:20:22 -0700
Message-ID: <xmqq5xgl1589.fsf@gitster.g>
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
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  daemon.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Hmph.  Wouldn't it a much smaller change and fix to discard 2/3 and
most of the 3/3 and instead make a siginterrupt() call to tell the
system to interrupt us when SIGCHLD is received only on platforms
where siginterrupt() is available?  Use of sigaction() does not seem
to be buying us anything for the purpose of this series.

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
