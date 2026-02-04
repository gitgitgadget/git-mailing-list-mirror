Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14A339E6E1
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 23:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770247576; cv=none; b=i30rV843Da/fdMMk5TOEcMdnu+W3a4Bc9TkoAdRHloY99qq7/2UGvppmgmaQt1qRIDj8KMmFCmdAwaLuLeMDSfQd0GB1tM60M2sVBqJl03TsWRdMaOwBbrm3gsaPiLQFMd9BPIKc7QqENIwPgLOkBhKnZvs7OdG4NfOGU2Mk3FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770247576; c=relaxed/simple;
	bh=ONyJwS3pTvvyeQSKSlfY70OqhgMjPhxZWiM3UZbuSMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FHAXIl3jS9A/G10Q7csDoH0cz1IuAT53LuTg4p01x2sWrupvRVBQ9THO3UF0S3Q0W3Bkel9sB/hO00OHXKPzKOQCOl2KYmO3OznJZf6uKSVLAVXVyFjUIN4seSmzNnhQcVCwZjVCOSvOI5U+/5Ps+5dxHu5pwt94yHxP51G04nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EPlYNp92; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MKyvn8Ay; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EPlYNp92";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MKyvn8Ay"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0011BEC0575;
	Wed,  4 Feb 2026 18:26:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 04 Feb 2026 18:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770247574; x=1770333974; bh=/mQxJcsSU6
	XgADubxsyf3kAtfGnzcb0DDUWAWMN18RA=; b=EPlYNp920X8VHZAnGMNJDHd6gf
	sV+mgMBzZA6wRWG8gz4bYrzh2tr2h/TsSst+Gd8NQJ1A34swbGOGd0KWFCgjQP+D
	if4k+CxhAxIYinHz+w1Qe/1hD4nQQ+qYm7UjoCuAC9/xssTk5rb1prmGHLEwcFl8
	DPzqEErYtgXZjxVv/A7VbExHsDrxPfsBGCPQ8M2Qv5BfX1ICb9Zremon8LVp1lGk
	dUNpM5g9QbkVhZc6tkW3aIAd7AZDLzzS+3FcKJyV2P+SLyNMfnsNc/JghRfzx2Kj
	gft8fPc4ot0dMOEQH1IbgTJa2MTucnD24uc/3emwcJx5/1LzYUKo5MjHFNOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770247574; x=1770333974; bh=/mQxJcsSU6XgADubxsyf3kAtfGnzcb0DDUW
	AWMN18RA=; b=MKyvn8Ay93l7LZyY8c25uVAbhg8ataiMzf8uz1pyueJR37gRZVs
	yJVPYwsNZ3RQOdft7cJ5ml80hGoAIHtJ2BfByGpCaet3XiRnMeZpkKmZpIez22AI
	vYCaGSSa8Tm2QOTukKXwb9R6BXvo9LBCDsWuI9DXo3jsVEEcJmhr42jHpVJJlLUa
	eBgg2YDAx7niOnK/DkQ022sUEOPtrkfUi0wC+30ncgfdd4hkha6wVirekUfuolyR
	eSUO/Y7VGwQo1+LStxuv6ATBEf5HjClMSNEJTqnZsN+M3vbNgoSnWJ8hLdm87KRu
	hmF+CmeTUw+vz/YQvw19PtSSStePNzcCLfQ==
X-ME-Sender: <xms:ltWDaQ2jW8-nOqU0tu73MmFi2ytM_k1AcLqx7V_bcEVmMzPi0YTxjA>
    <xme:ltWDaSHbrJcKOLxIDqz2bZ380US8vTBlEnjcOyAuoJp7RFbVwymkBODzAETUNYzsX
    Rj8ZN9-66i9H37MIszIBZY2pE7uiGmrZRhHgB9ICom6lgj_x9rK_A>
X-ME-Received: <xmr:ltWDad4Az-90mYFoS9Rox-IViaCeVMMUhtWnLQkSwim66Yjs9ww3YtjljFTaBL1uQPNfBhIccZS5_iwkcplF7paKp4d_YMJ9DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeefjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:ltWDaYvgsj8OyPYqiNuHRF6veZ_9XaL-o9zR0aK5yrk2XtYb0QAm9g>
    <xmx:ltWDae6ySwzfxh0w0mONu0s02vCAu0tYi1xWo7BpG_lbpaWsF8tnYQ>
    <xmx:ltWDaTVR--RkNkaDr0PqRM9ZAbpZDQkmsVKB5Fme2lHqPvxlewsHAg>
    <xmx:ltWDaQ9FvqQ3vzxD5uwu1bb8pcxlHQ9MrqZ5FNVgk0gJr4ufHcd7Jw>
    <xmx:ltWDaZaoSvuTVYJHlhlrVQdBV5_J9IXOWFGoaPdslG_Iwp2BTw6wY4pH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 18:26:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 02/11] config-batch: create parse loop and unknown command
In-Reply-To: <ecd26a0f1fad5615aea07a388e34f02e9f33b870.1770214803.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 04 Feb 2026
	14:19:54 +0000")
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
	<ecd26a0f1fad5615aea07a388e34f02e9f33b870.1770214803.git.gitgitgadget@gmail.com>
Date: Wed, 04 Feb 2026 15:26:13 -0800
Message-ID: <xmqqv7gcm6p6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static struct command commands[] = {
> +	/* unknown_command must be last. */
> +	{
> +		.name = "",
> +		.fn   = unknown_command,
> +	},
> +};

A useful trick is to deliberately omit the trailing comma after the
element that MUST be last.  You did that for the __NR enum element
in a later step.

> +#define COMMAND_COUNT ((size_t)(sizeof(commands) / sizeof(*commands)))

Isn't this ARRAY_SIZE(commands)?


> +	while (!(res = process_command(repo)));

Please write an empty statement on its own line, i.e.

	while (!(res = process_command(repo)))
		;

