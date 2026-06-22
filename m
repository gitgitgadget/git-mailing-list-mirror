Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31A433F580
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 19:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782158169; cv=none; b=knz+KWtdp5wqG6qy3og7nKsavLxYObyQuEDtzqv/fvt4Ue5Q6c+fmaxR96klUESvNLmUxF7GrLRy24FyoZQDH2KDY3oI+9g4HUxkGhSgnvgAEp27nDlSInGgsEiHYgUpOT2xSIvJ1ksEOJviBiaajlZbTv0NaxCyw+xq3zFV8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782158169; c=relaxed/simple;
	bh=img9klOCdlBX8Xl6TP0DZC2mCed0wqGZhUu3L5LZN+s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nUMkikFRpMk5HDC07tVOauW97HK7HKEx/FFny3DmLL1lN1a/c9Klni6uYJdCVfHyiN4uyvSsVVg1FpWumRmW3Xi+A6o4BPlQF34hw3OmUS6sZGI3UeJ2q9JPWU48eekYCEeigFoqOOfSyVpovwBGSkDw9Fv54/Pq9SwJdKmbIL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LFD1+VR4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dv92cwaH; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LFD1+VR4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dv92cwaH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id AC84B1D0014D;
	Mon, 22 Jun 2026 15:56:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 22 Jun 2026 15:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782158166; x=1782244566; bh=CFyhIqupzx
	46g3H6CzPaXh1tP2HUgTdUJjbRiOgBo5M=; b=LFD1+VR4S3ZRucXB6ujaVyyTtp
	iKC6vu8NSukun8s8fAiXRt1rGxfZ79kq0PT3byexR5sY7wc84IigdkncmOPZwC/Y
	uwMNDzZ079qwwojPrsQVQNZawFCF9gOpScskwwoeARogH2bnRzExEiE7UKbECl7p
	wsz0OKbJ1nDY8IWMqlct3+JSHCdCLYyfq4N7sr6PUrCbLTNn/C+VW6Hb9UufZdQN
	IbBdK757XSbcX7j1ABBjvXZzEOG2fegNptNT9OjNDo1fwU0fkDyxhk9omyiH9GB7
	/y4yZo2hB8X77JLYZCOdfx3eSiwEFPJyPuZpZQvcXzM3WrJpaYqKJ0nFYGtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782158166; x=1782244566; bh=CFyhIqupzx46g3H6CzPaXh1tP2HUgTdUJjb
	RiOgBo5M=; b=dv92cwaHGFMllTninCUWI060u8IanIWwfCbS2UD8T0rLywztwAL
	4KBq6Q2zyc9EDhml8H1l2impxVxrGxIWxoZTozeCw9HHQwTqc+cZmQp5w1oSIhGk
	hCbauWKK1vEBNrfM2LZEKDhnZ0zvEOLdyMnCUZ25k10IcVpadEDRKL+6ey5aOzqP
	6Vhgu7zzW0ZrnpihKDX972yoqX1JOtsE1LG51rEH7iN9FxxQ2i+c5lrIeLeHazb+
	RjtcArhyMV/dt3jR4rn9zS0GZiWCGc1FIAcECRBZTEiTqkY0Vbylz9ku0NdzvKf8
	qkqx/1lktvA5iDhzqiI/sTy1wdA+UiLHVKg==
X-ME-Sender: <xms:VpM5an_TDxWv21af6Z8QdYUVkhfUmq6AyXHsLttdSX7xewiesFUWdQ>
    <xme:VpM5aqvnA64rqsg2t42Vyj6w7v7laVlvMzd1m6qTJxEvoPW3nqHE7hEe3KrdUNMVl
    FfrWQK8mGP_Wn_iEOyNGUX5sDy9k8Kup_xxT7k22MDN8PVi9lc8ZA>
X-ME-Received: <xmr:VpM5aqBTW-OikY1BeFXpsZo3Ipxd7vp3IWMbexWvGTxlJ8Y8srwoSbergLtyETFtJoy-Ru_jSWD7siVs2czzeDyfBSGN4rAPBecJhOA>
X-ME-Proxy-Cause: dmFkZTEJnoR/yJGcZEPzBd0t5cV70nWrtK6kChGgvGGH1IF3iZUx/GFKRT8BEPGFLf3vEx
    l7VsgksEnWF37z56m0/U02Q5EFWH8DqPLKThwpYmNOUt5KB+p1IMw9KWjRe7tzpcYx7wmX
    4U9B/aF2+uhc+sSYNMWgCr0EeaRVbq0x7XDz8mLJldRftKUEv30emoNw8TekMTe/4PWgpQ
    lcGN+7ZKdb2dW6sV1WCX7hGAB5T8ZVZw8n0zysCo9023NbKz1r62QX6X3Qy0lOh50E8rJl
    bI1AwOcUM84O8157vLzjRcg0zq5zE5CZ9pIk5RlO2h3wwWb7AyKruHhdnnM66qOCkNc/Op
    O7oLliSx7S5sYILNFO9I2IBZfkzv1pHh3v8191vIv1dH8wojEuGwvwkDzq2QhVH8MRLu6P
    X/OVesizZC4iBuei6O/TBGrDcg/H0GB/yfMGYBLhIfbEt85rbtvoHeoPKIcJNh++oKh5xY
    T4eGytXpSF5jcTurVZVafwi5HrT2RlQXw7oIR9hIDj42hAiSl608as89h8m7ETl2eDwfez
    WEOs9bOhX26tcsc23ZymbpDL8/SqtCG9SoNMYmjoIbV4FuZopd4Bx15JJDX5XMg/B6EUTI
    piQbiitZPvuZP5iNaNZ4j51JkQ9xSH/kya0B2Jw2jo74bdYGFj4CKO/hbQWQ
X-ME-Proxy: <xmx:VpM5aiVppIv7vtroiJ2wtlivJ5FYYC374KXRA6vwAZZzEleARgtCkA>
    <xmx:VpM5aoA41dxYhfiqIS41Zn3yUq4lv0EN3GvfpapZTKnkwt27KT5YIQ>
    <xmx:VpM5al9cIvxUs73df9RSQHuK5MvSjpFm0YSQd3wi5itWN60VUWqBow>
    <xmx:VpM5avHBHUt75jpqeaY99Jdve9deTteM-P9JN7Amb7e4_Fbj7icDsg>
    <xmx:VpM5athBb-rnWFIhiZAsjTe-b1Lc3YQiwRtL19nUC1e8-0kn5FdL58in>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 15:56:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 1/2] branch: suggest <remote>/<branch> on upstream slip
In-Reply-To: <21684539debaf433b6b63404e1a7622a5cc33283.1781262619.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 12 Jun 2026
	11:10:18 +0000")
References: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
	<21684539debaf433b6b63404e1a7622a5cc33283.1781262619.git.gitgitgadget@gmail.com>
Date: Mon, 22 Jun 2026 12:56:04 -0700
Message-ID: <xmqq1pdytkmj.fsf@gitster.g>
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
> "git branch --set-upstream-to origin main" reads the trailing word as
> the local branch to operate on and dies with "branch 'main' does not
> exist", pointing at the wrong problem.

When 'main' does not exist locally,

    $ git branch --set-upstream-to "$anything" main

would fail before even looking at the "$anything" (which is supposed
to specify the new_upstream for the named local branch 'main').  The
operation is to set the upstream for 'main', and if 'main' does not
exist, doesn't the user deserve the error that says 'main' does not
exist, no matter what "$anything" is, whether it is a well-formed or
ill-formed remote tracking branch name?

So it is unclear, at least to me, why "branch 'main' does not exist"
is an inappropriate message, mostly because these three lines does
not clearly tell me what the user _expected_ the command line to do.

When 'main' does exist, but named upstream "$anything" does not, we
get

    $ git branch sample master ;# make sure the thing exists
    $ git branch --set-upstream-to origin sample
    fatal: the requested upstream branch 'origin' does not exist
    hint:
    hint: If you are planning on basing your work on an upstream
    hint: branch that already exists at the remote, you may need to
    hint: run "git fetch" to retrieve it.
    hint:
    hint: If you are planning to push out a new local branch that
    hint: will track its remote counterpart, you may want to use
    hint: "git push -u" to set the upstream config as you push.
    hint: Disable this message with "git config set advice.setUpstreamFailure false"

which does sound clear enough to me, even though it does not exactly
say "Even though upstream branch 'origin' does not exist, 'origin'
is a nickname for a remote, perhaps you meant to say
origin/something?"

I do not doubt you are trying to address a real issue, but the above
three-line description does not tell me what that problem is.

Now I do not regularly use --set-upstream-to, so I may be missing an
obvious common mistake modes, but a couple of my attempts to make
bad command invocations seem to give me reasonable responses:

    $ git branch --set-upstream-to ko/master sample
    branch 'sample' set up to track 'ko/master'.

OK, both are well formed so no problem.

    $ git branch --set-upstream-to ko/mastre sample
    fatal: the requested upstream branch 'ko/mastre' does not exist
    hint:
    hint: If you are planning on basing your work on an upstream
    hint: branch that already exists at the remote, you may need to
    hint: run "git fetch" to retrieve it.
    hint:
    hint: If you are planning to push out a new local branch that
    hint: will track its remote counterpart, you may want to use
    hint: "git push -u" to set the upstream config as you push.
    hint: Disable this message with "git config set advice.setUpstreamFailure false"

Misspelt upstream branch name diagnosed correctly, just like the
case where I gave 'origin', which does not exist, either.
