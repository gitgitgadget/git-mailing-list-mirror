Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E9039282F
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312834; cv=none; b=J+ot+2fi/TXCzbyjkkAr6RBXjvw6TXG/nN6gvMUq+yek3+j+bb3RuI3Mnmp0910C6z9Q9uzP9ki8LYX4LRoUbj15zrcF49O+STBJYgJVOAEqYlBwk5AgTV1riZyla8iwzSVebXHIe7CSImz7ypVAvPAor3JOVrONxxgv5QfELBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312834; c=relaxed/simple;
	bh=TwEWlcWGsky6BgXHdsbHuPArV6G4fQEVqaPUe8Hhhm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sXIjmBGTZEn/Wtht9Q3Q4ZIj9GpK0KAHHphOtguegkauXtQnKJuAlIGKr8gpxzI9y9cNbQtkzY4E4dWlNcTJTrXGXH2fhfb9Ke8g2v0Yn1hzoe15gb3GaSOl0ZVPlEi5PXgy7KNxx9sFf4hY1ooiLBW66yP2sZXICdupOVQwFY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WlaKeWZa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sp9IkZjX; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WlaKeWZa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sp9IkZjX"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 44DB11D0016D;
	Tue, 13 Jan 2026 09:00:32 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 13 Jan 2026 09:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768312832; x=1768399232; bh=rBhNyoouff
	7iCQaPpFR//dZZMXp99DowBXPrQ3dacTc=; b=WlaKeWZaRqg+5ADWB+q7OXTDhu
	CUvPyE+PoDU8dG29hv2zaSTltyIko6tmObFbyiGxN3QGZVIzTc3321yYHSqUiBoA
	CpVnCZoSi5yDS1zqNJ+ngEQ4XN4Ohfawp1QZdIoAsVrk66pcSQrELzZu/J3dViP/
	W+FT7cQQ5eqnEIsotLE6cWKBmYY3Wt30rrz/GDtylFN7LUWHBrMwxMV7ZcFcY/70
	MbyClkLyt0yRD4AQ8UcRN0IrM3iG1apYY17K+CjZElvxorG8nY64UcYkAFyA5ogt
	OBuzF9WxHHNQBaH4HT+bKwSMX980NbOCFj/5+fEHMF3nWKy8HN8ic6/cjiGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768312832; x=1768399232; bh=rBhNyoouff7iCQaPpFR//dZZMXp99DowBXP
	rQ3dacTc=; b=sp9IkZjXS9Wtqo4PCqrHfqDgJ4g3pkGgqhh0lksROe2rlQ5pDFq
	xInTvEtig9w+/47DSkbFYDqSiowUwbNybIXYwjKclxUi9w4byr2UWwNbTSmwvcrx
	L6tAxUio9kukW7QFiMvsEC+G2tqOH2wP+O/e8ReHzFnKwdndPSmS2z/dEqWsRhs6
	KvYQ+tIfAEYniRQf/Fo9p+M4CO4TKc3X3We+HDCwWMq04677Q9jJhhRu1TbfVSXN
	sVymVi37LA5edYcHl2KKdKoU5FUJBuw7P2S92aPg3pBcfFxi/7otlok+8MIj0tKM
	7QhW4zJHsrx/cvxxcJ3w0NfuF+4xVj2V7iw==
X-ME-Sender: <xms:_09mabvtZLOw42YXAq0sRzgJFCtlwhHHAvfyFY7lHFINwOtYYgHnwA>
    <xme:_09maes-wWDC7v0gjbRtFq9nzjGYPRf_HQ6L8BwtuhHwzLMv-ObjyZePaHM9LON2K
    Gdcv9MgTpmAbboSv7kqHFd3o0nvbVhQLdB3m-aE__ng0SOuWTyGSA>
X-ME-Received: <xmr:_09maRDItoaieXFFZtpHrs_DSeqAsjsOScrKCDVeWqjBWy7Al3_MQX9FEmmXG94I9TBROeTEC5tKzobbjjPWrbor1kVt97uWnVl7U_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddthedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegthhhrihhsugesrghprggthhgvrdhorhhg
    pdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvg
    htpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_09maQP9AHEcDHpMFdQkMkho4FGsLEM7aCAmjINioVKyBu-Rk-SSaA>
    <xmx:_09maaxANSGlo9AIu_X9YAsyPwSgbjeIeAsv4BpZiE0BZ7Bm84qViw>
    <xmx:_09maQVxpBRfZ05smXtcDS7Mrv1yivqpgmXa2lVvrKZZPxcSVALiVg>
    <xmx:_09macP4BIIF0AIIjd9Z0F8gSez6aPQoOWvXc4YF2weCoUgzlU6ayQ>
    <xmx:AFBmaevJf3n7yM87ZYJeOEcDS0JUezCzZeMyxPhuLQG40RRtTA3CvC3V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 09:00:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Emily Shaffer
 <emilyshaffer@google.com>,  Chris Darroch <chrisd@apache.org>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] hook: make stdout_to_stderr optional
In-Reply-To: <20260113115633.230479-1-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Tue, 13 Jan 2026 13:56:33 +0200")
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
Date: Tue, 13 Jan 2026 06:00:30 -0800
Message-ID: <xmqq7btlliip.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> diff --git a/hook.c b/hook.c
> index 35211e5ed7..ebd9d9e26e 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -81,7 +81,7 @@ static int pick_next_hook(struct child_process *cp,
>  		cp->in = -1;
>  	}
>  
> -	cp->stdout_to_stderr = 1;
> +	cp->stdout_to_stderr = hook_cb->options->stdout_to_stderr;
>  	cp->trace2_hook_name = hook_cb->hook_name;
>  	cp->dir = hook_cb->options->dir;

So stdout_to_stderr used to get always forced to 1, but now the
value comes from the hook option, which ...

> diff --git a/hook.h b/hook.h
> index ae502178b9..2488db7133 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -39,6 +39,11 @@ struct run_hooks_opt
>  	 */
>  	unsigned int ungroup:1;
>  
> +	/**
> +	 * Send the hook's stdout to stderr.
> +	 */
> +	unsigned int stdout_to_stderr:1;
> +
>  	/**
>  	 * Path to file which should be piped to stdin for each hook.
>  	 */
> @@ -93,6 +98,7 @@ struct run_hooks_opt
>  #define RUN_HOOKS_OPT_INIT { \
>  	.env = STRVEC_INIT, \
>  	.args = STRVEC_INIT, \
> +	.stdout_to_stderr = 1, \
>  }

... defaults to 1 for everybody, unless a specific caller opts out
by ...

>  struct hook_cb_data {
> diff --git a/transport.c b/transport.c
> index 6d0f02be5d..8f0e5987ab 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1372,6 +1372,7 @@ static int run_pre_push_hook(struct transport *transport,
>  
>  	opt.feed_pipe = pre_push_hook_feed_stdin;
>  	opt.feed_pipe_cb_data = &data;
> +	opt.stdout_to_stderr = 0;

... setting it to 0 in their hook option.

> The last batch of hooks converted to the hook.[ch] API introduced
> a regression because pick_next_hook() always sets stdout_to_stderr
> for its child processes.
>
> Pre-push is the only hook API user which requires stdout_to_stderr
> to be 0, so it can be argued that pre-push needs fixing, however
> this will likely break many pre-push hooks, so it's better to allow
> it to be 0, i.e. to match the previous behavior.

What was the previous behaviour of code paths that ran other hooks?
Was pre-push the only one that didn't divert standard output to
standard error?  This patch does look like a proper regression fix
in that case.  I browsed "git log -p 1627809eef..c65f26fca4" (i.e.,
the change for "Merge branch 'ar/run-command-hook'") and random
sampling (like run_receive_hook() that used run_and_feed_hook(),
which set stdout_to_stderr to 1) seems to indicate that it is the
case.

> We can introduce an extension for the breaking change of all hooks
> sending stdout to stderr, however this just fixes the regression.

Thanks.
