Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52DC49B202
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142693; cv=none; b=jfDfDYu8iy7heBHKZ/QQVZxJPudUIelCP7TZB2Q9WwiJrhePFRhAlnmGOH0uvwF6MHiC5fHK4leJO89N8G1MeVFgR0FmNDrZnUoehyUIU5KeI5ogAV8UqmVspfG0yMr45iiZAH1rDgm4aB2Eud9VjOY/gtXmJIrZQQvBF1fzTts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142693; c=relaxed/simple;
	bh=J/1sGP+mpdyLf4YyezbY1ioEhDtf1JHZZQMPQV1AXpg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=crMFYJER+w2kCjHkOVnKr6ELuc2UI3/eXQygtIF67uX/qubts40277Fop4aZgWF5wS2tcemYp7g5gTqcPnj5ZH0KXPAILGSiq1ZOTttjkjfmzNHBNHYjyLjh1dAg1oJqnSTsd03W/6ZMvRPrnQ71pDMN33/jTZgCgsguc8Prin4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RXrgiYOd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x0UGQNFh; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RXrgiYOd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x0UGQNFh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D390D1400165;
	Fri, 11 Sep 2026 12:04:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 11 Sep 2026 12:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789142689; x=1789229089; bh=lYhOQCPkCw
	ccfqUYAoV1pGEbFR9102q1YyOf3U5NhQY=; b=RXrgiYOdjLVRiq6vlIxYH8B1A4
	5dN2VCZD2FGNjjJQApAoXhH6JAJx5/W9UvW4HW88WXBqFnYOk3nmLsdvZOpUAzbF
	9dykvxNHIGZ7xtMux/CqzFOXmEJ4z+6qwOjeMhKNdpWNFIEORnubGf4lJEmiH9E0
	U+tJnj0XW7ak3IhhfmWo+ne9JwU7d4GvKyMpHsaXhMZlQNEk+EQge/mRt1rj/ags
	WrqVLWtVIgvnGUr2UG9s+PmY9UMSC9y3w1eSy2JXLp/Rs8P06aEy0MKrHvGVNJ07
	66e0zbyIvXEWvQ+W0iffarbh1JSqO57BIMJe9y0dtTrsUZtMjyfwjBVcorLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789142689; x=1789229089; bh=lYhOQCPkCwccfqUYAoV1pGEbFR9102q1YyO
	f3U5NhQY=; b=x0UGQNFhlRPqiV0PPGaFhK/zPVfcGYgL2jVoN4i2Rjpj6JfObZj
	cB0B7UU2zPQrp4ePqvFoHkGJJJupu8Pl62HQJ0VgkqSq4kKet/xazYL9KI7ugGQM
	K3rDxSPLHrN95aDYx950LITCZqpBEUB0B4IpUBdB/etbrVpc1q9WPM0MpQyMaAnI
	YKlm7epMh9obrqavghRioP4U5C59q4Yv+YyVI2FjD+yOQSB2NPryHMGKgHWl13ot
	X8FedRqaL7CApczOIsujPAUgidaxmDEoefqRvxe4J4WclsUzqcwYy5l3ZYELtasW
	PZDSreh5LkEe7RuV7xEQawhsps76/uFxo4A==
X-ME-Sender: <xms:oSakarnVlD_QYlrCbYMd8jHJAo17ObB_X9c-pR841vp2kRA0xkqtqA>
    <xme:oSakamQtwfDtDmbZiWtFeLm-x7JMRbgPHOup3n6c0K2EGftsyLsbMW1r-wVL5fr9m
    7Ln3HE_7tbWvAcurlIONA4ClV1tMa81TBgQysGq3ervlTy40ct0DE8>
X-ME-Received: <xmr:oSakavAzttWNetXxjc-pemtTtDB9K2cM47gK3vmUxU6Ziy8dV0yXNq61zN1Y3L9Vp2Zjxq73cLM5r4e1WMg453s3DAZcboGNjd5X>
X-ME-Proxy-Cause: dmFkZTGAeERKvnrH06HH06TqRfL5vY5RxPY1rSeJKkDP50OSG+zV0s5NoFIWuoIaxrhXPy
    xLuyoFN47VyaHKR7VrGnoKbDo8vfaX2erIZPH0zhIvDxxjrMs6hF6lNkzh2s3nL3V8TwwW
    twerLT7DDv3kFLuGfmlt64PCXw84aEmXcwwrhC5WVvtKWwOeDNICLtPUKCXcdVpDgK5NvG
    jkFWaMOr/hOWHlxzNsE4hMF/mzH1daMF/5zMM3Pup6ucpSzL9et9VofE5D9jNLqNLthZab
    aQAyipfsaKsfJe6NGsqwTEVbtKiPfBc5oyl4LmRS2rSB6pokdlD5k2F+8s15EJIsnw6RLm
    VwskE5qLnw3wg+s65fu8WwEgoy5qIYDDvK1Ger7iFOy7xWzGLBy+qI8fc4q7x7zB3ky6j8
    1v/cLg4m5l9Ko5sQWxx3G+QKupmhjHIhRdBY/szKjpICkl7j1N8xFBwXgF1xT2+Tv/Id5e
    yScnDAkrWu/cy8+5IvVrJlyg/0IR8+X2AaVs1RWPbmRP+C76ArH5uRGOPpr7TegyAhPGLw
    8HleT3J2HhrvRdGGeMxl/KyyBkQa1iyNXiYUoEsaQo2j8GIRKre5NuidghWCHRlxWTAdmA
    L8v9BNbagUEFIMmYo9s9wBI9CVn3FY3fx1kkWSh0bGNsvY+3/R6e/LqhBbWA
X-ME-Proxy: <xmx:oSakatRASJs7eg5eu6crASR9RVkWmnDOpLLgbuzYCQ67TIfROVAyyQ>
    <xmx:oSakatqN0w0VGWuFWbPXd4VyBeWDg1UtzqwR97aAcvZdgu2wWzDmtw>
    <xmx:oSakavzCDtDDmUHQX9Q-FcSsBLUc8Alv69VQH-Ta-uttN1n5ac7YWg>
    <xmx:oSakaiJ3mo8JdKcGI-kZv9xnUgK2FPB6C6BrCacaj1GNfxHb5QKr_A>
    <xmx:oSakav8jDC1Jh1u01AJcPJkSsybO_tupaDjM14bTHPZ5CUCie0nretTs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 12:04:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [GIT PULL] gitk: discourage AI, color preference dialog
In-Reply-To: <e391e55b-4a23-4b84-8a95-1136449cd171@kdbg.org> (Johannes Sixt's
	message of "Fri, 11 Sep 2026 09:17:06 +0200")
References: <e391e55b-4a23-4b84-8a95-1136449cd171@kdbg.org>
Date: Fri, 11 Sep 2026 09:04:48 -0700
Message-ID: <xmqq8q57dba7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The following changes since commit f1de86371cb85dd09d55070d139e5fcdc595f026:
>
>   Merge branch 'spanish_pr_bis' of github.com:basuradeluis/gitkbis (2026-07-16 10:53:01 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/j6t/gitk.git master
>
> for you to fetch changes up to a6457acb0f56cc2de76bcc12a5d18217973fbba1:
>
>   Merge branch 'js/prefs-color-buttons' (2026-09-04 17:08:34 +0200)

Thanks, pulled.

>
> ----------------------------------------------------------------
> Johannes Sixt (8):
>       gitk: set intitial colors of swatches using the available helper
>       gitk: condense repetitive code around color buttons into foreach loops
>       gitk: show color preferences on the button instead of the label
>       gitk: use more natural language for labels of color preferences
>       gitk: avoid constructing dialog titles from text pieces
>       gitk: move UI for generic colors above diff colors
>       gitk: discourage AI contributions
>       Merge branch 'js/prefs-color-buttons'
>
>  README.md |   7 ++--
>  gitk      | 123 ++++++++++++++++++++++++++++++--------------------------------
>  2 files changed, 63 insertions(+), 67 deletions(-)
