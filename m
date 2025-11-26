Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BFD34107C
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764187767; cv=none; b=qdQQSesLZLR7FbYoq51qGnyIordCfAB5QVxeYvao5huZwvnjmzLsmsbNZR1xGAU7AnnlPbaed5F2Qnpyq0ARNi1nMAEnqRWYv2LubJT1C53Zg0oKA2TbASIeP93J9fkiPNCPxwa43AQYVGe4wm1z8HTmeVGR2bdz593hUUXndZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764187767; c=relaxed/simple;
	bh=8YDKZXIcq2S1Jyo8h6yFmP9B7/++sSGjcPQnWva4cPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fwoxvyzo3+peLl61sMTf3Wjq5jjWym2UtLzjPMBxutaVFTAMi8ioPfqxyblg9kC6l4E+reqm4F3OwlwFM/B+3l1G6T50TFcu+Gf2sv75eBzIc7M04hZ/Jp20yucty/qZrDOu4rYbQpFKgdwjbZkRPaJn9OBTr4/OSwXXCeh0XCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IkC5TMYY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fD6gjCMD; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IkC5TMYY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fD6gjCMD"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B1201D0016F;
	Wed, 26 Nov 2025 15:09:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 26 Nov 2025 15:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764187764; x=1764274164; bh=HHo7yzsAwg
	hZF8gajpmMkoyket88ZHgei5BFNI8PBls=; b=IkC5TMYYzw3ScR2mbyGWNZKf3d
	Ew6JO/v1AMGBGMUSKmclMxtMQrtU4xqQuhH12ESlXyHzyfPXYQiHUcB3udJRz7G8
	nVnAPk5RgEos3vWNYYDMmM7FZLWMnNJoJAvZAetZOvCgbARu501Yd0Ms7vccy35U
	XSmMSOmzP3bDx/Z82qI8zMeheE9vJkX2n+wBYWmsWeELM2qr5sdpFIAbmeGq87O8
	xpcnoaj/r0YoJE8kkhbl+fMuw9O4P9ZnRQmyEVLksGfQ7Yx6oX3zrrX1Muoop+b4
	hU47XYyz7KIegzG86oXAI1u49WH6S2mmPLGWQZPkZQ+Bo9jGZ30L5s/MKWKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764187764; x=1764274164; bh=HHo7yzsAwghZF8gajpmMkoyket88ZHgei5B
	FNI8PBls=; b=fD6gjCMDU0HWQbPve7Xl+oRRrOCcBso37yR0LGqsqRliIZgwz56
	8K+pZ8ZOUmpk14OtuZQRS5z7RrNGTzSGKzHdge8BGcJp2dEYq4y2alwh21C9P2rz
	aNiUM41KkbhDSFLRSjxTQEcwOgGNwOdrQYA5FTC5r8d7R95FYZ6r5iS/hBBPWKOE
	P2CHJpnLMOFDUcKR4hrOgN18ju5Zen1u6BymEP9eO7s2Jwrf18gOJKYAOb15Oole
	hpU395omZNtc+30ZEvYBQYNcABNxm9etdsxrFV/yOG91q4y0v7h/FkTlKmxLIu7v
	GDHBmAaZbfYr7FYEpskYp5YYy2m0EQ3M/wQ==
X-ME-Sender: <xms:dF4naYQMcUBzZtEvNoeBnyPOZXhU6F2WRoh1GPZ0lZyIuhdqR7z7Ow>
    <xme:dF4nacysP2Yi3f-QWeizTgr1oyIu-4GI_2fcT-rLzP1gDCrD2pI1AMOllX5eyjQKO
    4w9t0Uhs1CpXIyQ4bj_3vc7Imcq683Px60TpPXRqMf9BbxGP3reFA>
X-ME-Received: <xmr:dF4naa3oVWAOIOywaVH1g4aqNBoytTlv1had27HcEtr38iqazxM9CRvIQXMxyWFxDwVkZXjX1ES5LVaEdO8qd1nnDkuNUh5o2iMU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeehvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmfihikhhtohhrtddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dF4naa6NO5IegoQ5jW9bj0iJO4LvkwGFPftf-Rlfb7v_57hqEdSYxQ>
    <xmx:dF4nadXcTvIC5cYglvgWEjxT1tf7jWkN2_kUVa9YDMiVsMDHn9DfVg>
    <xmx:dF4naZCy7Z4aq_q2R4LChKaOWaGWDVHfibmbzE5Z0apb0_Zgj2-BSg>
    <xmx:dF4nac56TT6-hAxNlXfABgmwOE7JGGUL7F-6yVvXJ82l8ScVGK6ADw>
    <xmx:dF4naSXJZLvgomhiEdDVmLTwBoph3BCcg5KVdM5ASmzQnMAE-dvwEwas>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 15:09:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Wiktor Mis via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Wiktor Mis <mwiktor023@gmail.com>
Subject: Re: [PATCH v2] completion: complete "git -<TAB>" with short options
In-Reply-To: <pull.2100.v2.git.git.1764174391776.gitgitgadget@gmail.com>
	(Wiktor Mis via GitGitGadget's message of "Wed, 26 Nov 2025 16:26:31
	+0000")
References: <pull.2100.git.git.1764052739534.gitgitgadget@gmail.com>
	<pull.2100.v2.git.git.1764174391776.gitgitgadget@gmail.com>
Date: Wed, 26 Nov 2025 12:09:22 -0800
Message-ID: <xmqqh5ugmu8d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Wiktor Mis via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Wiktor Mis <mwiktor023@gmail.com>
>
> "git" itself has completion for long options and cmds, but not short ones
>
> Signed-off-by: Wiktor Mis <mwiktor023@gmail.com>
> ---
>     Add completion for short options

Will queue with a slight update to the log message.  I am unsure if
we want to limit "-<TAB>" to one-letter options or if we want to
include the long ones (the latter is what v2 implements), but let's
see if others have strong opinions.

    completion: complete "git -<TAB>" with short options

    "git" itself has completion for its long options and subcommands,
    but not for its short options.  Add support for them.

    Signed-off-by: Wiktor Mis <mwiktor023@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks.

>  contrib/completion/git-completion.bash | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 73abea31b4..1705ca3323 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3898,7 +3898,7 @@ __git_main ()
>  			;;
>  		esac
>  		case "$cur" in
> -		--*)
> +		-*)
>  			__gitcomp "
>  			--paginate
>  			--no-pager
> @@ -3914,6 +3914,12 @@ __git_main ()
>  			--namespace=
>  			--no-replace-objects
>  			--help
> +			-C
> +			-P
> +			-c
> +			-h
> +			-p
> +			-v
>  			"
>  			;;
>  		*)
>
> base-commit: fd372d9b1a69a01a676398882bbe3840bf51fe72
