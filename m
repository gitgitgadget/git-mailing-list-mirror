Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933D73ADBA5
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786988619; cv=none; b=ftP/oiVIKIpHSLP6ubLNAq4ZLMZpXIoH8p+r0sSbBc/gMuHW7EP/lvIMHtt+DDoQ3XpwUdFjBP3VgMZeoANkfR9aipFOWem1NvCt3xnZhCsQQ242gTRwRLWgzuFxKV2gjZzNG9dtNUcouUKRYCldV6bWcKit7BAsqcQe+7+y2ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786988619; c=relaxed/simple;
	bh=YMcudipO0B79XV2aw/MmECZzx7Z9eLpYMDHAxiiCIa4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gz5aSoSsowIQ8itvZb762Sk0h0/KBBVupAl2Z9JWQ7AJBNulAeSpFcUjfKkImu5aD8zgJB+cAChhajnJE8v09lCdH6CI6f0K+oyBgGqHx3f0cM7jVi8l/7ulAMWBa5QTTanDGdzRfdzApv+A5PYg82xVVY3dp5cxGbQdw+upTh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rwL+SAsC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KKFtVSuz; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rwL+SAsC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KKFtVSuz"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA2F51400062;
	Mon, 17 Aug 2026 13:43:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 17 Aug 2026 13:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786988616; x=1787075016; bh=nCYcQDAkVm
	OXoOaK0/gFpkz3LJyjrprCGsOwumfcJiM=; b=rwL+SAsCmYMJfCi9OliuXnCEH0
	rMNVRgolzkjA5ZvTwxrcIw9EDSm0/1IcqoYdGS6bajDH6SrVBv/Q0n+vFsMeFYI3
	/AmMq1ucKbAKpwmLWgDCT6f2tXYrTmulE+wKZ971OdZe9BV/KRL1ptrzRrRA1HM3
	djk8xqbDDmnLqOTsGKowhhXaYKmEnIibn2Mt2qG+u9cH883jtncLggGlaknb/AxA
	xF8gHLw0njNDagJv2Hd2LuYoui2l4g/5+O0yr52kcmgTx4uEcAfYgKQti2MZ6112
	O+JHzpnjgTja+Ag1f8VdexFvhf83+mEkDdSiH6Ec3v8HOIiZHzMbfFAorzog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786988616; x=1787075016; bh=nCYcQDAkVmOXoOaK0/gFpkz3LJyjrprCGsO
	wumfcJiM=; b=KKFtVSuzn30z6AhmuovfYNZYxEi4JSAeRIAli0zREhHToQS4N6A
	Q3HhDJsPSDJUT/0vD7L5dLZUeVsZQhkp0AKM0YXksvSydhD0mJn4Hi1jp8nTYUp+
	j5dOPkDZQlixP6vQmXnLZr1B3Ou0waCTyJ+tXjNEqwfik8K3OZ7aVYB0aTwf87RH
	T7NzgVxvEwywu7HzxeD60O/dg3CuKQjJjpypZQjxEpKci1OXAImOJmIdEXvigVAA
	LuOMA1gSxgcUz5cOXf+/NWoW8ogzcyd4ZkygjigrwJRzmAiQ2Yffds8mGe9zrhf4
	db8cCAR/m+XEfxTcnXgm4/6RkYHYseEduEw==
X-ME-Sender: <xms:SEiDaulNm6s8PZOoxO-Od4OdWHPZ7OAeVv12Cs0vAPKjM0NMZ3x65w>
    <xme:SEiDastoGJXhPVh854pkAnZ6sTiMUAoj6Hw1YmZJrfgK-Dv8XwucC_P4itWKi9Xr5
    8Xm-ZcV1lMwxrHtzsFnOTaHMpIWrXK3yG6NIUrV0I6rC7T7Z-ykKA>
X-ME-Received: <xmr:SEiDak-TwbEa0Lg-uvIgHqueHP5sw2N2ld1WyyUMZRnHhBkez3PXgGado5aRdeOoR3sg5VpfZzf4PvMYNfLchz6QZTi9WnCF4Q>
X-ME-Proxy-Cause: dmFkZTEMRt5+HQY2HKuj2WxdFbGn5/dlL22iEAvDuyHkQDY7eOgqboQkKpvtlJ8EUl+jol
    2JDDH5H02MivBQusqmXxiNPb41ioJYk7RKuSWLSiS61oUm0Qq4Nl3Zv9E/gxw+oyaUjPrI
    4VezqruKYybbxygi20zUbZPVdgUNGuJv8A5i+hO++wClFD9MKwgzDj3/njdLSGQDF6S2bN
    gPkrtWA0DUQmlg46Tp4smncGB+LKiWX34DFUe2NnlpasNPZjoNhSWt4KpvbDwdWFCGBVku
    2rNBUC4xU10rqApfhfLuxi4vZFJS8TtpCchmNYvOEzzrHHSjepkRwH90+LzCFtHZJBnoS5
    nlpHWqndtCuBzLdEOskF2sws4fX4+xlO0iZ+JZlbVFZ6AK7XPTfa8BCf681dbC+cXOc7tS
    reVagSuQGKZ3mqUuZBhij2KQTHbzSq7svoe9P+2v936+56o5Jn1S2mZzskGBvBkELUPAqj
    BGNoEnw1j/4xc9/jVgnagKiL1SJHZlD9hGeh0MJExrQEgG/4cG0uP/C77CkAhUpQSZ8haM
    d/XAaKThB5QMMIpRmkVCUOqQJb2WDEF4imb4SQr210LVrWvh5J+qgz18xWIJwdZA95mde6
    4byG05MVaVfo7+PV9Zpab0HVeRSUwfUwNylR0IqWqmocXK4TRPvyEiTH1XVg
X-ME-Proxy: <xmx:SEiDauPcOW6oZIbIXeTkyT3kQLjOEX-NYTXxSowjAquzgFrM_hrosA>
    <xmx:SEiDaqG7cJsKMRT67pUKbddO0_oUCSfiWy0xNXWipHzx0AAvzL4ehg>
    <xmx:SEiDakTj-hEj4sjcQVMuPQAets9CQqJNgUzz2cezPRDB9QIfKZQJvQ>
    <xmx:SEiDavsj6-DvOLVmf28x3SvANTjxz3Kf-P5Cac0XWd12hMj5RiEObw>
    <xmx:SEiDaipBCWB_Ao96dsctaFgbSonTl-KrGWSuNw8q-WRM-AK21e5RUXv_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 13:43:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: tilak-raaz <raaztilak07@gmail.com>
Cc: git@vger.kernel.org,  wy@wyuan.org,  ben.knoble@gmail.com
Subject: Re: [PATCH v4] submodule: warn on valueless active config
In-Reply-To: <20260815071829.22190-1-raaztilak07@gmail.com> (tilak-raaz's
	message of "Sat, 15 Aug 2026 12:48:29 +0530")
References: <20260815071829.22190-1-raaztilak07@gmail.com>
Date: Mon, 17 Aug 2026 10:43:34 -0700
Message-ID: <xmqqjypo4p89.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

tilak-raaz <raaztilak07@gmail.com> writes:

> The config parser throws a hard error if 'submodule.active'
> is provided without a value, causing commands to abort.

Why is it a bad thing in the first place?

    $ echo "[submodule] config" >>.git/config
    $ git submodule
    error: missing value for 'submodule.active'

Is this error message not sufficient for users to go on finding
where their configuration file is broken and fixing it?

>  	/* submodule.active is set */
> -	if (!repo_config_get_string_multi(repo, "submodule.active", &sl)) {
> +	if (!repo_config_get_value_multi(repo, "submodule.active", &sl)) {
>  		struct pathspec ps;
>  		struct strvec args = STRVEC_INIT;
>  		const struct string_list_item *item;
>  
>  		for_each_string_list_item(item, sl) {
> +			 if (!item->string) {
> +				config_error_nonbool("submodule.active");
> +				continue;
> +			}

Warning and continuing as if no misconfigured variable existed?  I
do not think it is an improvement.  Without stopping the process,
the early error messages will just scroll away without giving the
chance for the user to notice.

tilak-raaz <raaztilak07@gmail.com> writes:

> The config parser throws a hard error if 'submodule.active'
> is provided without a value, causing commands to abort.
>
> Swap repo_config_get_string_multi() to repo_config_get_value_multi()
> to parse valueless true safely. Use the standard config_error_nonbool()
> helper to emit a warning to the user rather than crashing.
>
> This resolves a NEEDSWORK comment in submodule.c.

NEEDSWORK is different from TODO in that whoever addresses it must
think if what the comment suggests to do is sensible in the first
place.  I do not think it is in this case.  IOW, unlike TODO, there
are two valid ways to resolve NEEDSWORK, (1) analyze the issue and
validate that the suggested change is sensible, and then adjust the
code to match, or (2) analyze the issue and determine that the
suggested change is not a good idea, and then remove (or update) the
comment.

> Signed-off-by: tilak-raaz <raaztilak07@gmail.com>

Documentation/SubmittingPatches::[real-name]???


> (Apologies for the noisy v3; I botched my --amend and accidentally left the commit message in the past tense. This v4 corrects the commit message.)
>
> Regarding causing the command to fail on a malformed config: I investigated returning an error code here, but is_tree_submodule_active() is evaluated as a boolean predicate by its callers (for example, if (!is_tree_submodule_active(...))). Since -1 is truthy in C, returning -1 would cause callers to treat the broken submodule as active.
>
> To avoid changing the existing caller semantics or introducing process termination from this helper, I kept the continue behavior so the malformed entry is skipped after being reported with config_error_nonbool(), while valid entries continue to be processed.

All overly long lines.  Wrap them ~70 columns.

Thanks.
