Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DC33D1AA6
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987063; cv=none; b=OXQRBaA51XVfU80Ex4ZsDjqcMgMewNP3r5A30aE25UE8ZfzbtfyYtg5w4oNbvuf026ooV8fosoodFb7aB/llv0dhAvWrTskRzwYpkQmF5Ac0jpTizEX9BJ1z6/eK+xS3yZh2bL+YG3ttUDG+Z+sRWAa2SpvVN+qNHXnboF31BkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987063; c=relaxed/simple;
	bh=gTk3pnMndl8kRghExdYU7JEY8IVVaJMimbs3E4sxuKQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bN+36Xv1V4Wdun10wdpntLRsgdE8vwKk6as8u5F/jO/+7p1bP8ge4vRGYb62tAaq3WlTEuuqGGHZr5e16gvxil7VRclBjVNK2F7hG1E7AxFJgdl/jawbNF1IQaQMSmq2mxvgMWUkeu1QWOn7h684FBV5EHx6qCSmzZzsLI82Go8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mun7EKvB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WpgTdb6r; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mun7EKvB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WpgTdb6r"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 074FBEC0120;
	Wed,  9 Sep 2026 16:50:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 09 Sep 2026 16:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788987053; x=1789073453; bh=ohm0OrakUM
	Z/cJ02wIiQQwHynyErlF4Vn2Ky8ViEwTQ=; b=mun7EKvBNGW7emfDPmxraHZMhQ
	MLH+zVpqqksaoe3E6cY78QgfuqRK/TpTgm/fXO9HV5EvW7AuV+5ITd5PyAezVapS
	KVMeR3v5evknCILagKcjBqMbwDq6BoeYe4LTMtIDpIMQ0GwPZC6X+YMH1jSa9Sr8
	G5I0TR880ieGSWWIfBUKGOHwjpYRS07kFyrvvNhgEYsV7ks5NVQwisV/u7alQfCb
	FC5Q91fa67BAPmywF1Zkmu+FF8Uw/KCyWwFta5VuCtrMLg8QhdrSqJ+tTFu7xAKy
	slrEjnam0F1IyqH/1Muff6HYj5s3RzP3ZxTmZhplzoVtXhXaj8PR3RpTnHFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788987053; x=1789073453; bh=ohm0OrakUMZ/cJ02wIiQQwHynyErlF4Vn2K
	y8ViEwTQ=; b=WpgTdb6rHEJu8nPJTQa0G88GkpAouTqVQiK/EpMoC+08CgWkfX/
	PJaXA8DtQdcRlyTgOUyD24aY0OXn70NxKEg08QPs6QvbTK8h55T48JDo+gzqLRmr
	VBhfS7ysbDYeQ/AmQdkDeNea3vhtjA8dDteQM/pfAVfXL2l1lOjBlpFmULg/jqPY
	LXmRgN5KmYIelV6hj9Ifj/wRsEvii24hHvOUokTSuEkfKdoHWX8tMrdU9xUcU/Z4
	G56uskFWCQqC+W6OoNwtxRJFYt4cig8XBLCfpGivlzl0zbgYVpwzoIl82++7XD47
	3UH9hf1G7NM1uySzqpSzFwbZStPlolVU0eg==
X-ME-Sender: <xms:rMahaoGxhMpvuv9UVZS3Mj1V0pnpqoNfeNdmOOQ1HNoCBPxQFSYx0g>
    <xme:rMahalC7VuoRiG_MjP9SzIsFbzzOJg9zaisDBWDxtu0_-HvmLTwL1IAtsXrPU_wrU
    JplDp-Uz4dnX9jmC6LjxBJ_3qB6JTqW6Ddv7SQgy2sqcNc8Psg0Iw>
X-ME-Received: <xmr:rMahar_7uglTcvDqRNh2XJ5RMwk25Ze7n1dw4eS1JTWqGxYTWtq58W4QdSkoMSVKvnucGa5xgzz8LyZHr-jIp0i1eQmRLAqtKoMW>
X-ME-Proxy-Cause: dmFkZTEU/TOGuaToat/ekHAVC4p1Z1qpWEAfVvPoOB5xPREjuVf0lm0wzu2SEmPicnNZ2U
    gU2+QJYk1S7H7Y7s20Tj7+7GrP9L0rhoI6uu/91mvbnYpzJtNR7W3Owvdr0SGO0Qeb+WKV
    /GUU0ONBxXb1uaCoz6VtjOeLtNOl2GbScVVhbBBzbtTYwEF7stwOvhdr90npb+UOgdVz+t
    pDd/hNHyTh5HzjEkyjMlu4C4KagPo3dMwsFKFK22AKfoCwlmOLKvM4EnP9pueOxZN14DOC
    CcXQZIzRZg7Q/rCeYTFBBkaqdX8EpcQwosAfdzl7/NDgnyMGKC3/zokDk+baPx4M3A0deQ
    978XqJXbYXLLEPsA0rbBGtmxHbnRB5jOLnbXn1socprFYdrWQJvjCxXO3GhbSDVt0aSISP
    BiPRrbbCmW/zeJWQGGkcYaDRhJl1nt5q0emOYPTyRGnausaVE9whBn05U/98Dhk94jPpBf
    EPl8gQv2OvX0V7/gEzW2CXrUQbMYDJkkcuNcBdYwpotdaTeANbIzv3x86QT9oO3vhqLa4u
    q0KlZkVf4/7M9I0cOu3jJEPPcvz2d5IRCHapXaBDlM3kUAIh750Q0P/5UJEjU7gtKXZSij
    XU6rIxrb0RBB4+R9pK1jaU6gWm/DRiVUjcoVTheY7lZp+uoHeVrMwfC+i21Q
X-ME-Proxy: <xmx:rMahahA6zLxRhtdz2mHoR1z2N4XLJJMf_EoPYLN_EFnLi7LjpEv1xg>
    <xmx:rMahagToVKwj0wh7VFkuCHcyvsh6N8shX2xusqMCDjaprE-texz00Q>
    <xmx:rMahaouAepN4TwX33VTK_FWWdGc86S5ePu7rY3kEVSHmw1LVI7C2XA>
    <xmx:rMahas0T0vJ7Fc3wnl5bKylHf8JouaFyZ6h5vXZuY7YpmDwuEh1dDg>
    <xmx:rcahanOaZd6denPM4G0dijMkhHf7OTKMwwqdhGi1O7vbfLbLTZx5jtpE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 16:50:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Vsevolod Myalitsin <ub4nal@mail.ru>
Cc: git@vger.kernel.org,  gitster@pobox.me,  peff@peff.net,
  ben.knoble@gmail.org
Subject: Re: [PATCH v3] advice: use global config for default branch name
In-Reply-To: <20270829004959.90983-1-ub4nal@mail.ru> (Vsevolod Myalitsin's
	message of "Sun, 29 Aug 2027 03:49:58 +0300")
References: <20270829004959.90983-1-ub4nal@mail.ru>
Date: Wed, 09 Sep 2026 13:50:50 -0700
Message-ID: <xmqqse3ip2s5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vsevolod Myalitsin <ub4nal@mail.ru> writes:

> Some advice messages suggest disabling the advice with
> "git config set advice.<name> false", even when the
> corresponding configuration should be set at a different scope.
>
> Add a scope hint to advice settings so that the suggested
> command uses the appropriate config scope.
>
> Pass the advice setting itself to vadvise() instead of passing
> its fields separately. Use NULL for advise() calls that are not
> associated with an advice setting.

"""Use this new mechanism to suggest setting advice.defaultBranchName 
in per-user configuration, not in per-repository configuration, as
it is way too late once a repository is initialized.""" or something
along that line is missing here.

> +enum advice_scope {
> +	ADVICE_SCOPE_LOCAL = 0,
> +	ADVICE_SCOPE_GLOBAL,
> +	ADVICE_SCOPE_SYSTEM,
> +};
> +
> +struct advice_setting {
>  	const char *key;
> +	enum advice_scope scope_hint;
>  	enum advice_level level;
> -} advice_setting[] = {
> +};

Looking good.

> +static struct advice_setting advice_setting[] = {
>  	[ADVICE_ADD_EMBEDDED_REPO]			= { "addEmbeddedRepo" },
>  	[ADVICE_ADD_EMPTY_PATHSPEC]			= { "addEmptyPathspec" },
>  	[ADVICE_ADD_IGNORED_FILE]			= { "addIgnoredFile" },
> @@ -51,7 +60,7 @@ static struct {
>  	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir" },
>  	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName" },
>  	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
> -	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName" },
> +	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName", ADVICE_SCOPE_GLOBAL },
>  	[ADVICE_DETACHED_HEAD]				= { "detachedHead" },
>  	[ADVICE_DIVERGING]				= { "diverging" },
>  	[ADVICE_FETCH_SET_HEAD_WARN]			= { "fetchRemoteHEADWarn" },
> @@ -96,18 +105,31 @@ static struct {
>  
>  static const char turn_off_instructions[] =
>  N_("\n"
> -   "Disable this message with \"git config set advice.%s false\"");
> +   "Disable this message with \"git config set%s advice.%s false\"");
>  
> -static void vadvise(const char *advice, int display_instructions,
> -		    const char *key, va_list params)
> +static void vadvise(const char *advice,
> +	const struct advice_setting *setting, va_list params)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	const char *cp, *np;
>  
>  	strbuf_vaddf(&buf, advice, params);
>  
> -	if (display_instructions)
> -		strbuf_addf(&buf, turn_off_instructions, key);
> +	if (setting && setting->level == 0) {
> +		const char *scope = "";
> +		switch (setting->scope_hint) {
> +			case ADVICE_SCOPE_LOCAL:
> +				break;
> +			case ADVICE_SCOPE_GLOBAL:
> +				scope = " --global";
> +				break;
> +			case ADVICE_SCOPE_SYSTEM:
> +				scope = " --system";
> +				break;
> +		}

Style.  In our codebase, switch and case are indented to the same
tabstop.

> +		strbuf_addf(&buf, turn_off_instructions,
> +				scope, setting->key);
> +	}
>  
>  	for (cp = buf.buf; *cp; cp = np) {
>  		np = strchrnul(cp, '\n');
> @@ -126,7 +148,7 @@ void advise(const char *advice, ...)
>  {
>  	va_list params;
>  	va_start(params, advice);
> -	vadvise(advice, 0, "", params);
> +	vadvise(advice, NULL, params);
>  	va_end(params);
>  }
>  
> @@ -155,8 +177,7 @@ void advise_if_enabled(enum advice_type type, const char *advice, ...)
>  		return;
>  
>  	va_start(params, advice);
> -	vadvise(advice, !advice_setting[type].level, advice_setting[type].key,
> -		params);
> +	vadvise(advice, &advice_setting[type], params);
>  	va_end(params);
>  }

The change to narrow the interface into vadvise() needs to be
described in the proposed log message.

Ideally, this would be a three-patch series.  API change to
vadvise() would come first, and then the introduction of advice
scope mechanism, and finally making defaultBranchName a global
scope variable.

Other than that, the end shape looks good to me.

Thanks.
