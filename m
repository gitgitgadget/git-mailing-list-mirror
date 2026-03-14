Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181F835898
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773507161; cv=none; b=CZjwd6AuiFwbnfto3aTCAT8+8A+4gUJtBGS0mG1rs7DyVCITjLMpDILVnNA/EI3YqYxzUv+LDTbZmgttF9LMlq4D1L5umxY7ugCNCp7PqVwrvb5G8XReqVaENkzTy5HjVhjnR0K7v/wMCLweOCsX8IIGo9KiDx/+q6oP9cO2Sw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773507161; c=relaxed/simple;
	bh=I2ETbO3IRnxQdG6ukOm3T/EERlPHheAbymoYfbLVw5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NqgfSbKphGQaNBoxglf32hoWsxFLl/7kfvKRwcHSr/Q3lPoCvFWLaYVcu0tsaOWozSbh8FFv0G0jpRnfsFF9DBGAyi8HiGoIGZNK712Ls03fTrwh8nm0NSZS6ee4VgG/qVZn3dV4DKNYOextjWoPsXozdBaEXCQZcsYhBkxrKdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gUnNeTZH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G7JXV3EG; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gUnNeTZH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G7JXV3EG"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 41AD27A00AC;
	Sat, 14 Mar 2026 12:52:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sat, 14 Mar 2026 12:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773507159; x=1773593559; bh=b/UhuPrWbU
	yd7i8zO2psMPKmYN4mQLXsm4gkjjpR4l0=; b=gUnNeTZHn05xLPklCJZRzn9JDb
	86cGNoUj1sLaVItJ0Skh0T8qq9czDSSOOYQGQyzvlQXEJowPBWP7jS2j3AlNc6Ht
	7tOk+VSMw7pjgZ1oPvZ2bZRzb80fH7RffuWHTGSV9+2+KZ7EgLcvs81SqIL7z6sH
	mrmAle556Yrz3q5uk1X6qYRaspErWs5zees6Na9OjPp9CPK8IHiWbIcQxHYqYDnh
	/hpTZlXoVTKpoSj/xJWxEq6XEIqDjFYAfEoBhDLiysYKJrGCfiMRDuxWwlhLNnkf
	GhQ+1MZ33e+XVrZquMM1FARRSa/R4zoJdj4OA7TcP8sOLrSTB5XtOmBxD2Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773507159; x=1773593559; bh=b/UhuPrWbUyd7i8zO2psMPKmYN4mQLXsm4g
	kjjpR4l0=; b=G7JXV3EGcTrfSmmrf0/o1ztLNhazzutC8llBngYtIPA4lpRu6oT
	jpni5hThwsP1UEv5vhnepTEg+GPnlrd1GDNYs67lCO+7AgVgljvf0WUo2i3SH/vA
	rUK8je95fJc2iq2lTYSq19V1XyhUX+qyq0OWPL+eFckDuhXUH8X1xEp4B/TN9kiM
	PS2Pt4AgmHvmq0OgSxkde6YEadStx1dega3dYDbsAIpI6CmQFxjoXbBb78/vwNy1
	ks5iSM0+OnN9FI5AtaK3lDLyccsS8zigPny5E0Nz67T6EZeOo3/otSOfBQ9ZnQy2
	Pzkl44Ya4iDNenSXYum2CAXNl9knmiwCC1Q==
X-ME-Sender: <xms:V5K1aT_I06ia2OBiuf_eflSJoMHrukiuGJm1-_yPojqjYMSGAO2twA>
    <xme:V5K1aWudV8csbCrels9CNK6m-bIz3waErV3-n4KWTnMcVvInq0Oc4DPs4WeP0-0fJ
    C67vVRdgHgQeOTWdegzAaV83MvU4zZvxCJxJuosxFIDCjTy_9xTGyA>
X-ME-Received: <xmr:V5K1aWA2Su5goKSx1FmfsxohWfPj7x05CHvgQFVlESvMkNAuaY2gIaWEJxsS5uS1b-ESctpC93RzSHSQU_JH1SheeHsjcda5uA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleefuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepjeekueejgeetveejteegieelueejieejfeeugeeiteeitdelffdvffehieeh
    udefnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:V5K1aeV0E1zZuZiqe1JyJ9dMHcvyke1JHgpC398LecUGagIZN8xSIQ>
    <xmx:V5K1aUC5q7V-CVzZUeHnafBt8IF-yprU3QXUzCFW85sKXvigL3R-DA>
    <xmx:V5K1aR-uIzgHtXDoYcTO0s0PRekuKUq1FyQLueKAqAZM9VP0wwrBLw>
    <xmx:V5K1abEQIORFBjHow8BhxXmFhI8D9locK-yL45sWxgYyyrWTx3vx-g>
    <xmx:V5K1aZgUDUXtgjSaJ8I2FRD3Oj2-ckSbY7PjdPEv_Vd-tu05hfjV-umT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Mar 2026 12:52:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] remote: use plural-only message for diverged branch status
In-Reply-To: <pull.2239.git.git.1773479526823.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Sat, 14 Mar 2026 09:12:06
	+0000")
References: <pull.2239.git.git.1773479526823.gitgitgadget@gmail.com>
Date: Sat, 14 Mar 2026 09:52:37 -0700
Message-ID: <xmqqqzpmwdyi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Drop Q_() singular form and use _() with the plural string only.

I know the commit title talks about plural-only, but please make
sure that the body of the log message carries all the necessary
information to justify the change standalone.  "In the else clause,
both ours and theirs are positive integers so ours+theirs must be at
least 2, hence there is no need to prepare singular and plural
variants of the message", or something to that effect, perhaps.

The patch text and the reasoning behind it does sound familiar and I
vaguely recall discussing about it ;-)

Thanks.


> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>     format_branch_comparison: diverged message has only plural case
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2239%2FHaraldNordgren%2Fformat_branch_comparison__plural-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2239/HaraldNordgren/format_branch_comparison__plural-v1
> Pull-Request: https://github.com/git/git/pull/2239
>
>  remote.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 7ca2a6501b..12136dfa23 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2307,13 +2307,8 @@ static void format_branch_comparison(struct strbuf *sb,
>  				_("  (use \"git pull\" to update your local branch)\n"));
>  	} else {
>  		strbuf_addf(sb,
> -			Q_("Your branch and '%s' have diverged,\n"
> -			       "and have %d and %d different commit each, "
> -			       "respectively.\n",
> -			   "Your branch and '%s' have diverged,\n"
> -			       "and have %d and %d different commits each, "
> -			       "respectively.\n",
> -			   ours + theirs),
> +			_("Your branch and '%s' have diverged,\n"
> +			       "and have %d and %d different commits each, respectively.\n"),
>  			branch_name, ours, theirs);
>  		if (use_divergence_advice && advice_enabled(ADVICE_STATUS_HINTS))
>  			strbuf_addstr(sb,
>
> base-commit: dc6ecd5354dca88d51b6d6562777fc8fc10d77e1
