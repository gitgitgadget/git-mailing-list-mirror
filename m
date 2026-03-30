Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80B6191F98
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883942; cv=none; b=f08GBZSgKmnLHd8CMI34Kiz1ZU8AmqyyiRZjqJ9plLntf9ha2kibqfMgcrwIdGsQ0npzmfQA8fS+0iOVVdjWgiMbJM75yBzcFFO7lJqaNCCrmrLM1FW/CStdob9du40OeHp3YMMwrdB1ID7RuUYWTNg9HygyfU6Iw2YhWIEz+rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883942; c=relaxed/simple;
	bh=ltSFQRJIhrjtCS/G9zOlo4P5EKUyjp8UEwC98cOPX4k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j9OHm4Uls0Vpy6xgkut/cdFJ7x6NS3KgtN0XWdL7VpqI8oLxhozWfHF4Ux4Ml7FkXCVYRfB9DzI/icdPJujzjI9iugw4iKQWHq9/hGmJ35/E2AFJJSU6fb+NLmlxZa8NSuWcDkpYoKEC0k+8/oyzrRFKcVMNU4xgpdAU2kTNoEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K25DDD/T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hZ8ZnYnC; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K25DDD/T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hZ8ZnYnC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 07C1C7A01F0;
	Mon, 30 Mar 2026 11:19:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 30 Mar 2026 11:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774883939; x=1774970339; bh=J6QWpx4M3N
	a63l0msNbNv8s7+L1lVHji+T2TZHEIeM8=; b=K25DDD/TFoD45c0HsgeOwOYLiz
	dyEUSjJl9GVejCJF6q7ugcskre9nZ7x5w+gnDcUkJGXCr7FswWecY06Yu+XwYtI0
	EVB3rZ5vjfHwAK3brhE4DFufLMphx12pesgl5R0z8hHy5Jz3QYfGjw/vB9ASL6e4
	WzuqqtIXT7Bc5Rk3rN2SUNK+q7Clq+yLse5O2Stchedjkdgx76W8AzK+l3HTzVAW
	3DO6Qdk/yrAtjyI9t0QkuWTUiFNeBAdOAwO2YJSEf7xYR1ocrhmHvdB7VlioKA9F
	GypI0nTZrTxnS9YsePrOnFnxZd9yjmAILPVfL5DJT+cc8yUqVS2nbwshtCGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774883939; x=1774970339; bh=J6QWpx4M3Na63l0msNbNv8s7+L1lVHji+T2
	TZHEIeM8=; b=hZ8ZnYnC7JJjoG2tQ/fwQuWNP64fAcVGlQXFpdPAkaSZSX0kxs7
	I4rm1VgJtOblo2hm30FwO6IjGB/Y02PIUCFpmaeVChicOM6lT3N8qfvYST6JseOp
	DcI0Ed3yNPXGlaKo2YQlkM6D6rWY0uGKkTjlyC65NVoVlrP0BP/HRbV4arOLtHp0
	s3F2plZUw3T/yivWu+Iw7OSsQdej/IMCvyyWgsQf7fpVlWJ9rLqh6EEkLl78137R
	f7RvdcjDYWPT40E9B22o4bc/ylnaeUUEBVrGtn0WKsDCwWChCJ7VOL6Swm7LMyBm
	BcJHlJlXLByM+apTtyfcxiR1bsTpbtKVtdw==
X-ME-Sender: <xms:Y5TKacoF8srQiic4plNXW_v1ScQV7Nk7WS1WIgklZT1C01w86mLThQ>
    <xme:Y5TKaZqzpr9op3Ju1cssF_Kes4IBWMnF0DMg12hmtWwrbJTmj7-IWjwHaiwpBvUil
    9EJ3s-TMf6RbZstkyJpMLifpMmCHhv4fegr4sgdMYorcjQn9Z9XVzo>
X-ME-Received: <xmr:Y5TKaWPiOOumrn0Qls-K5QXt36ccWyRjj3no1HgzLgpQ1mBXYvoAFJoDc0PCFFtfTPzqQrlr43rIqi_G7Grr5G-eiafxBO5WFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehquhgvnhhtihhnrdgsvghrnhgvthessghluhgvfihinhdrtghhpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Y5TKaSxkAakjhO2uDi8PbjVngvjK3d9GlmYcb3ZntgCjt2r7Rc4g4Q>
    <xmx:Y5TKaXtkaGPm5uvfIdRPXnGg_7ccgEfHK25I1oYr4TnSfwDeZXrE-w>
    <xmx:Y5TKaT6Ys7dJcesFbdrAn9xRznZp7xw4stDw_JhvqgwmXkEpdgjaWQ>
    <xmx:Y5TKaeSZUjfWMQXW4iZZwdV09-APJLnGathI1oyKFQN4sru1nuRYug>
    <xmx:Y5TKabmp4B4i7PDXeHw2Xsw26v5JTvYBL7YfYXos1XTGjs3yqGC4g3-r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 11:18:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Quentin Bernet via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Quentin Bernet <quentin.bernet@bluewin.ch>
Subject: Re: [PATCH v2] docs: fix "git stash [push]" documentation
In-Reply-To: <pull.2255.v2.git.git.1774877075694.gitgitgadget@gmail.com>
	(Quentin Bernet via GitGitGadget's message of "Mon, 30 Mar 2026
	13:24:35 +0000")
References: <pull.2255.git.git.1774529148151.gitgitgadget@gmail.com>
	<pull.2255.v2.git.git.1774877075694.gitgitgadget@gmail.com>
Date: Mon, 30 Mar 2026 08:18:58 -0700
Message-ID: <xmqq341hfiql.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Quentin Bernet via GitGitGadget" <gitgitgadget@gmail.com> writes:

> But it also adds "-p" to the list of exceptions, even though it is an
> option argument.

This point I did not notice before, and you are right.  We already
said that we reject non-option arguments, and "-p" is by no means
special among other options.  Good spotting.

>
> -git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
> +git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
>  	     [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
>  	     [--pathspec-from-file=<file> [--pathspec-file-nul]]
> -	     [--] [<pathspec>...]]
> +	     [--] [<pathspec>...]

OK.  So the first '[' was closed after the entire thing, but now it
closes after [push], making it clear that the command word can be
omitted without affecting the remainder.

> @@ -60,10 +60,8 @@ COMMANDS
>  	the description along with the stashed state.
>  +
>  For quickly making a snapshot, you can omit "push".  In this mode,
> -non-option arguments are not allowed to prevent a misspelled
> -subcommand from making an unwanted stash entry.  The two exceptions to this
> -are `stash -p` which acts as alias for `stash push -p` and pathspec elements,
> -which are allowed after a double hyphen `--` for disambiguation.
> +pathspec elements are only allowed after a double hyphen `--`
> +to prevent a misspelled subcommand from making an unwanted stash entry.

OK.  I personally think "for disambiguation" in the original is
clear enough, but the rephrased version is not excessively verbose,
so let's take it.

> -	N_("git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n" \
> +	N_("git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n" \
>  	   "          [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]\n" \
>  	   "          [--pathspec-from-file=<file> [--pathspec-file-nul]]\n" \
> -	   "          [--] [<pathspec>...]]")
> +	   "          [--] [<pathspec>...]")

OK.  Looking ver good.  Does this excatly match what we have in the
documentation?  I think we have a test for it, but I do not offhand
recall it covers "git stash".

Thanks.  Will queue.


>  #define BUILTIN_STASH_SAVE_USAGE \
>  	N_("git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n" \
>  	   "          [-u | --include-untracked] [-a | --all] [<message>]")
>
> base-commit: ce74208c2fa13943fffa58f168ac27a76d0eb789
