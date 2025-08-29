Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7EC20010A
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483420; cv=none; b=DmakMtwKrUz7Ej8gD/O8Iq7p4m00C/u1O6LyTiX7T/y1YdEC/mAacfAwpvxc/r2ETI/W2TATjPpsgbomOcEaMNeIal3gMrhI96C8OyjH67bYx86/FYUUS6skeAqPFLwknTcjFc8ccdmqmVs7g8dX3OZpSFcBNrxlYZ2X38L87lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483420; c=relaxed/simple;
	bh=kHoTMI8xoAg+5KkHir5kc3+pfS6xIL62jz7Pqcd96ik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jGosioWSDHM/HRVrftlMZVnBnAZjRwqAjAlXVyUxqvzSg4RMwHPX5ZoXajUhPoByHH5LB5ob4get3ak6WfF1pxcPmWAa5/Uzsa+pFsPFMq/TJn2dZZgK94J3xvKiJE37/KbcDKSnRtw5bBBP1nGQJvRCNsOWqeOmY2fdiqPgHnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pom50T0C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bJU1/i1A; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pom50T0C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bJU1/i1A"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 39B397A01F1;
	Fri, 29 Aug 2025 12:03:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 29 Aug 2025 12:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756483418; x=1756569818; bh=Z6zxP8ViAz
	ut0EEY4MUmp5QtvlrkE5jJ8ovx+1IrHdQ=; b=pom50T0CAsmQnLxtvquaHQNYn9
	jlPLXOZIFuoh1IUOpXh7QELcuBYIwxV493qU90/9MKajX0DBfegvQYK60g7bFuj/
	wGoNIFxcx4A6z2rAprP/aOJXDE/QAp4IN4DdAvBMiKc7fKMdGGVRGa9kje3GlLa0
	ztnb9BjIq0+HX8AHv5JYQ2XHS9/53PZMW7dJAO8DKnua+rdBexJHER//WhFxpG1m
	zcBZknjOE/VcJJ8xmTOBTmc0zUMd1eLMGVNUx44FjUS31vo9IQtET+Ls3lcXLKFt
	bWYU8rIwLmbfhGejL3QvsaieARZ8pLLOzBv0Pn/NANyra7XFa90e8M2lUH3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756483418; x=1756569818; bh=Z6zxP8ViAzut0EEY4MUmp5QtvlrkE5jJ8ov
	x+1IrHdQ=; b=bJU1/i1AC61xMpE6kpA1tFKeALe44t9ym75SRC6qqxqIOq+zbY2
	7V1vBQ91Jc9ZcOehh5RWEMTsiPSFGKkW8X4PhF1PI0J6Hh4rg311YH9sSEPBfKaU
	EwhcXKlb6q2cLEZmRyAU+sixFHWNyP+NStKkcmOUfRfvdAkwiU88NOYN/BVSlAZV
	Jmx/g/VY7+LO/6jcaaA/A923hamo8Sl3cQl2X3Y2V+3fNfKiupv3LngwSu6Xs2ls
	IuxZ7NZPR9QRCfiJZa+zqn6CNum0eZaO1MH2h40a5vnssQvy3IZWn6uZZCRzkTKA
	05DPRh70PEJrCpCI3BkvgIoFUSNthr1IQnA==
X-ME-Sender: <xms:Wc-xaLxmGE00n2_k9QWUccp8S4msM5VNfSMyshIXuqa8blFIq9PrDQ>
    <xme:Wc-xaOw4EyCXS83MEkuSbLX0U1XZI1J7PWuqQCPJHrhSfH8EvNrtJLTVoYv45hafc
    GzxeXzmrS0_bZ-ojA>
X-ME-Received: <xmr:Wc-xaLxuhJTt_fHKL2DT3vOCd17Cu7RlXIKuxWkeIvtvh3_fF5m5PXcyly9HpNnOwo3p0GBzLmNP3xgxrW0KKMI78f5NDTjznuTC98I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjuhhlihgrse
    hjvhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Wc-xaAbLRYoJQAFpvUbF5bFNfu5YW7YfGHjg3VtvMtj8g9cQcN4tJA>
    <xmx:Wc-xaEUvo_VQm1gDwiuPRr4L_0b4GRsp8TuFyBRkLsXe1oghIj1Hqg>
    <xmx:Wc-xaGhmyPLBiWTY7YSAEbR6zJ8g3PJkn4UEs8klSCsTVS-xE2bWQg>
    <xmx:Wc-xaKtLpvoWpXjbaG2sb-C6dnNgJrTvOV9N_8K6YPwuEJAGr955sw>
    <xmx:Ws-xaPzP1-MwcAbAUor4IcmnqZaouXcXZ8liby25EqCAa3N6sinrnxNi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 12:03:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 2/5] doc: git-checkout: clarify `git checkout <branch>`
In-Reply-To: <23a738981abd2073c70bbb5dd36eea050065e643.1756467934.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 29 Aug 2025 11:45:31
	+0000")
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
	<pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
	<23a738981abd2073c70bbb5dd36eea050065e643.1756467934.git.gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 09:03:36 -0700
Message-ID: <xmqqv7m6nmhz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  `git checkout [<branch>]`::
> -	To prepare for working on _<branch>_, switch to it by updating
> -	the index and the files in the working tree, and by pointing
> -	`HEAD` at the branch. Local modifications to the files in the
> -	working tree are kept, so that they can be committed to the
> -	_<branch>_.
> +	Switch to _<branch>_. This sets the current branch to <branch> and
> +	updates the files in your working directory. Local changes to
> +	the files in the working tree are kept, so that they can be committed
> +	to the _<branch>_. If the local changes can't be cleanly merged into
> +	the _<branch>_, no changes will be made and the checkout operation will fail.

The condition to stop you is a bit stronger than that.

By default, we would not even attempt to "merge into the branch" at
all.  If your previous HEAD and the branch you are switching to are
different at a path you have local modifications in, then no changes
will be made and the checkout will fail.  With "-m", we try to merge
and this merge can leave conflicts for you to sort out.

> @@ -42,10 +42,8 @@ exactly one remote (call it _<remote>_) with a matching name and
>  $ git checkout -b <branch> --track <remote>/<branch>
>  ------------
>  +
> -You could omit _<branch>_, in which case the command degenerates to
> -"check out the current branch", which is a glorified no-op with
> -rather expensive side-effects to show only the tracking information,
> -if it exists, for the current branch.
> +Running `git checkout` without specifying a branch has no effect except
> +to print out the tracking information for the current branch.

This is much better than the crappy original I wrote years ago.
Thanks.
