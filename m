Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0479221577
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101055; cv=none; b=A+7i/dBZBHHs6+BfJ7yMidn+Nky6HRNh7gGpePvlQXGfkZnX2FBsaSSZmq6MI2K8FXMWAd6qHWnuU3kIHx0o0AQP1osvqdm4ASXFiSx2syuz0migVDvCh59Id+ojzvcsy2Guszkg9E0Dl664MeCbUooUfrl73+q7CStHb5BtLoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101055; c=relaxed/simple;
	bh=Teb4jjaLJqwgmMIzKzkX+pXhZEVyjY3mPSWTfrIG9vo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W4b/7RXSlDoJh5nIKWZWAvDruhNACpWwjGzUhFzD0HPHZA8shNCYADhOtsDq+shM9GmOqdaW6qahRI2EJEfiHj3wY5zToHMEjLPWVpCPewK7dVzLJW5NOojr3ZjJ6TnFXl7QKVrLwSkTtzVDDPYirex6m7UOtNS3aMJaFmE9fpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eORfg6/Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dlmFq3sP; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eORfg6/Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dlmFq3sP"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C97DE140039F;
	Fri,  5 Sep 2025 15:37:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 05 Sep 2025 15:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757101051;
	 x=1757187451; bh=v9Dmg1vk9Ya5vto94JqS8N0oKDem60lbLtzTycsA5Io=; b=
	eORfg6/Z6wzz+HR1W+u39O44CDOqaUrKq4KeIjwbF8E82CyQNEuo1ampkE3tFknL
	BzTmi40vYlQvHROttPSIuoo4qmFOX/f5y1xTtbY5ZLesXX/n1CX9ZsCXlWECExBn
	+ES3wBfvBOF07bcf9m+z49Gwq174KR4QskaCyE333ppoIhvidEpWIhe5NYI0YsmN
	cixwpsaxNe4kkCPkVfoIvYjVOWRBgrhdvica7NAN9gybtyNINvFK1GX7WJEAzKG9
	LLmMalFGHLcdszS2DnenyRyZriaSawZAqCIWwgBFr5jyVi0ceDCkzH1AxKH9Sf3R
	HdLMaN9zbRn7yZ4pIgyY6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757101051; x=
	1757187451; bh=v9Dmg1vk9Ya5vto94JqS8N0oKDem60lbLtzTycsA5Io=; b=d
	lmFq3sP1BCWBqXMeAEBJvFB1AOBJDnlyJ7ohKAmUYYI1+rwEl24IurrSUYVjvpUb
	gQe5bjKIF+43u5gU5m0+bZLNYJAodkpyBLFavlySa14CP7M8HTxFExKSF/1Z3o4E
	glB5x1hL1PyW2LFf69iQPmzgQ2Yfy0h/NhEA/oQN4OQk1gnn0PioX0Sxqam68IFT
	qHUxB3V+fEzOcTHstbayMs2c+AFkWa745Ergk8SIzNgK8gwjgfG1QnghdVGuEHEG
	oQ/szgKK35nWpiYzgpZyGXw5Me4zCvdV5UEkbevmOgPNwICh/9BgJJzbwQUZ3Lix
	6IdFoDOp4qFYr8I2FUZPA==
X-ME-Sender: <xms:-zu7aKGGkOi3EtgE8ypy4wUSv_l5ylKZa78mNWdCl7DF1HY9KwggRQ>
    <xme:-zu7aF4G1AaVMSPYuBZAr81AzN0VYk7f4lxmf9JtFC8Qio805SjSoY_l5oGqULUtK
    yGIE5Kmd_uG1oeYUA>
X-ME-Received: <xmr:-zu7aAs4x6G3oC8uzr8BoEpVQyp-h-7zbMPfOGM54doLJRWf5dsbWo_7C8NAswd-BzagZtpu0wQbJYv-v9d2CIFmZAf08OXUv2kexTo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeljeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeggefhudefkeegueeigfejhfejvdejvedtheeguedukefgieelfeeuteejieeu
    leenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnohhurhgrvghllhhmsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-zu7aG70kb9aZXvaGKB0XJyytHKw3r9swktzdzeU5GgktQXFRTspaw>
    <xmx:-zu7aLU0vroSij1s82729WjDPBbV3ywjve73RTl8JpSuTI4gPyXDgw>
    <xmx:-zu7aI8iHntC5L4SAEQztAIYRc7sWtiHcr-Emxjm64HVZwOivgEfYQ>
    <xmx:-zu7aHkX4ndWQWSdIgAQTf2G6sogx8Fp0OoDDoofJRwnP3970cY37g>
    <xmx:-zu7aJXBXesG_Zb5jDIJGgAI0XQCpwERalU48UbuU2ywKkE8aRsyxFIw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 15:37:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?=E3=83=8E=E3=82=A6=E3=83=A9_|_Flare_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?44OO44Km44Op?= | Flare
 <nouraellm@gmail.com>
Subject: Re: [PATCH v6] alloc: fix dangling pointer in alloc_state cleanup
In-Reply-To: <pull.2040.v6.git.git.1757098308277.gitgitgadget@gmail.com>
 (=?utf-8?B?IuODjgnjgqbjg6k=?= | Flare via GitGitGadget"'s message of "Fri,
 05 Sep 2025 18:51:48
	+0000")
References: <pull.2040.v5.git.git.1757007856062.gitgitgadget@gmail.com>
	<pull.2040.v6.git.git.1757098308277.gitgitgadget@gmail.com>
Date: Fri, 05 Sep 2025 12:37:29 -0700
Message-ID: <xmqqh5xg3d3a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"ノウラ | Flare via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =?UTF-8?q?=E3=83=8E=E3=82=A6=E3=83=A9=20=7C=20Flare?=
>  <nouraellm@gmail.com>
>
> All callers of clear_alloc_state() immediately free what they
> cleared, so currently it does not hurt anybody that the
> alloc_state is left in an unreusable state, but it is an
> error-prone API. Replace it with a new function that clears but
> in addition frees the structure, as well as NULLing the pointer
> that points at it and adjust existing callers.
>
> As it is a moral equivalent of FREE_AND_NULL(), except that what it
> frees has internal structure that needs to be cleaned, allow the
> helper to be called twice in a row, by making a call with a pointer
> to a pointer variable that already is NULLed.
>
> While at it, rename allocate_alloc_state() and name the new
> function alloc_state_free_and_null(), to follow more closely the
> function naming convention specified in the CodingGuidelines
> (namely, functions about S are named with S_ prefix and then
> verb).
>
> Signed-off-by: ノウラ | Flare <nouraellm@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>     alloc: fix dangling pointer in alloc_state cleanup
>     
>     cc: Torsten Bögershausen tboegi@web.de cc: Jeff King peff@peff.net
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2040%2Fnouraellm%2Ffix-dangling-pointer-v6
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2040/nouraellm/fix-dangling-pointer-v6
> Pull-Request: https://github.com/git/git/pull/2040

Nicely done.
I see no more need for further changes.

> +	if (!s)
> +	    return;

This must be indented with two tabs, i.e.

	if (!s)
		return;

but the copy I have since yesterday already is formatted that way,
so no need to resend this patch.

Thanks.  Let's mark the topic for 'next'.
