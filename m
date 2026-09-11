Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B68F457E49
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113484; cv=none; b=ixrOG1gPeF37fI1fV8pE1aNBGNweJcFZDC76PcO+xqs9ZJJ/tnO8keYOjVUY9m/rIuWv2tWMwR8VpZsbmjVjzAzuvQkkK1dhfQI9NDlOnrKpbxO0yTV0/74lLIWh24fzvG4JU1nSaRA8BSgOqN3lmwVLuBxtbbMvTDYKPcs5g+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113484; c=relaxed/simple;
	bh=EzKNoBtOphbYTvI17f0jFiraVo+me/ocHJoGtZ5OAjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa6hPVmM0GmBl5fVttlSSleMGt6to2VISG6DE0+zupu1Kx0zhr7fQJKYz4QV5r5mIwDEUVWOcBDKG6pGiJRSC/vUl4rUIuRZfesfXRvfP3kgXqhBYloVqkgk/UcITdiyeXafFhAm6F24VOJvEwy/XBI4wVHleQWOTAbFML12seQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uUkriQjX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oKpAtk74; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uUkriQjX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oKpAtk74"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id F37D41D000E2;
	Fri, 11 Sep 2026 03:58:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 11 Sep 2026 03:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789113481; x=1789199881; bh=4Mn5gVTeph
	f1YvtoVAOLbiK2aa75hujAePAUuq/8Jgg=; b=uUkriQjXtD/3GSI9092bIgKTUP
	EzZNpklFpeVEooXWzKZG6T82uYs65v+phwWUnar7g8mAWzywBU8pv9zcviKEhUnu
	vTZorAijSS9rj3SZv877N1rcz3RHiJDw8RLJ4eDzD9XuVELxnJQJCINz/iTTRhmH
	ktP9EIdnfjxn5K9wQ4Tc/ojYV3baQPoKz6UHIY6GvrRKOeM741mTsLwiBtYt39C1
	3jetjNzFdBkThpDBDp9EhyT8j750xV2sfQA3GtQtzsuhBeOeCb+x2w8zRfYCxBzt
	tijrdfU3VdQK+K2/hVVR81QTHK5AvUWBvq06wJUGl6bSMhNLk3ZftaCoxPVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789113481; x=1789199881; bh=4Mn5gVTephf1YvtoVAOLbiK2aa75hujAePA
	Uuq/8Jgg=; b=oKpAtk74TeFaE3oNmJ3mlR2Lzj7odq/5XS0rbGwyIZa6qH721xt
	erpvHFZKZLuM3osWaA4g3TzFMkzqVZFWEqB87NPkv0xgwj8n6rWL7+R1H3pd9/wZ
	voYT45YJ9hhXy7kNbrCeMqjHzKAh0iWVVd+MWWeL8+DTM2Mc/8fm//853pCwehYG
	tNp5hk2rrD9T00EZf8mAJITL8v2wDasCBuh2DDVbbeBGuEVn1I3HwpfOq4Ovsu+L
	L4MUI5koUZYaM8Y44IBRTsp286LJbdBe9oyVj3WmuJafL6ivrkPGrOFocKAKIvaU
	7YJ8+0pY9LpvkyW3VzRZMxkC+3ICXTYpejQ==
X-ME-Sender: <xms:ibSjahNB-dC6u_SE3KOju3Y57BhCmPz0ruoMImh6NfmxR1-xqyMZrg>
    <xme:ibSjara-7RONXR9RYcUma8GYpri0Pfw0E6z5sdc-gqfdwkh5D2Gijeot1_H36KUxg
    slekN4ROsKSbGGEkK7NBJ9vsxc7PGuU-OJ0wom9KoeLEPy1WCbGgbU>
X-ME-Received: <xmr:ibSjatq_1-0B5qB6XFcZfX60gXA72yE1BfPZ7M1ZWO8GevgCa1WaUM-2zuu_4v9965Z47g>
X-ME-Proxy-Cause: dmFkZTG0T3qYZCnlgeGmPSqKdxfQZuWtbwGXGUEb6jVmohMDhCrc1dSEfUAdTydR8Jv4sQ
    rP1SFe+9ew2cEWvRt7HIu3zZA2n4daWKLjnfcbrdrFmN736xadqU3TSitML6dtdKL+3dJi
    5iqxGQx6LsTKem32qgSe/ZCveGo4XVFFI/HHTLoDUFXOdhi72sdQDmKBwR+R5LL+t3kNR5
    aYSZVmDqhcz7W57pyd/wV+KpT5ms8U0m3HnVczdH0N3vmL13AAHC/rbp31HOT6Ac2JTnea
    nEBGiPxInvX87X/nZ5ob+dsWZEFwEPYAV2qSN75LhHO3S1lys+SUMybozbRkkY8VOc1OfJ
    9fGUGD5hMMT7cw2LMIYEgNLVErYua7Qbnejz8GyydqzBPm34YrZpMqxHoDa61t7u8OtDWv
    853fG2opo6HuSQjzJ/YhNIIEkQdv9bM37YWFeHLjHgNXGb5zmTF7O4FNsgRsiMuefJT/KG
    S9hc+wkJAKW+v5mkD5bHgHNhHsFgGoS/VqssE8LCQzzFmkZop3Ug3Hv88rolr5LpKFaHL8
    NbidIT71QYmBffo4W371lz+tPcjs/nd2UNFXeJielU6O82GbmphnhwrIEZqtfg2RlH7QDp
    Z4L4+3HQEB3qm8Lp2fnQoyENaWJxKZmFLdmJdjsje3OJ30D61CH7ZRDj4PJw
X-ME-Proxy: <xmx:ibSjanYP_ex0j0qGZ5ynRUJrO1SGGoR0pb-DAqoKzbEC0a7o_PI1Ng>
    <xmx:ibSjatQUzUJehnYN41t9m6LjpZMWPKfxyQwtbWzK0_BRD87eD0UcIg>
    <xmx:ibSjam7XCcjmtf998vgA00zIa_A1dW-vQN9fWz1IPNqPdgxmEFTjPA>
    <xmx:ibSjaqyX-G7A8i9QTjYoK5Py6ym3kd8Nd-FrWMIERqpPwkNvy8wcEQ>
    <xmx:ibSjari_bGxajrsrSzJqJj1dL-U2MLua9LaquQeuoif5YTTEnSzronow>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 03:58:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4be9414e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 07:58:00 +0000 (UTC)
Date: Fri, 11 Sep 2026 09:57:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Souma <git@5ouma.me>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 2/2] builtin/history: sign rewritten commits
Message-ID: <aqO0hsYNgCwm2_UY@pks.im>
References: <20260703145037.69832-1-git@5ouma.me>
 <20260717145142.39478-3-git@5ouma.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717145142.39478-3-git@5ouma.me>

On Fri, Jul 17, 2026 at 02:51:42PM +0000, Souma wrote:
> The history commands create replacement commits directly instead of
> using the sequencer or the commit porcelain. As a result, rewritten
> commits ignore `commit.gpgSign` and cannot be signed on demand.
> 
> Read the signing configuration before parsing options so that it
> establishes the default and later `-S`/`--gpg-sign` or `--no-gpg-sign`
> options override it. Pass the selected key through direct rewrites and
> the replay machinery.
> 
> Sign every newly created commit, including both halves of a split and
> replayed descendants. Dropping the tip creates no replacement commit,
> so there is nothing to sign.

Nit: this sentence doesn't really add much value, I think, as it just
covers a small edge case. It might even briefly derail the reader as
they might wonder whether we ever have to sign with the "drop"
subcommand.

> As with `rebase --gpg-sign`, the signature
> records the attestation of the current committer to the rewritten
> commit while retaining the original author identity; it does not claim
> authorship of commits written by somebody else.
> 
> Document the behavior and add GPG-gated coverage for configuration,
> command-line overrides, last-option-wins precedence, replayed
> descendants, split commits, an explicit signing key, and the
> no-new-commit drop case.

This paragraph doesn't add much value and can be dropped entirely.

> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> index 28b477cd37..8345cced4c 100644
> --- a/Documentation/git-history.adoc
> +++ b/Documentation/git-history.adoc
> @@ -125,6 +125,14 @@ OPTIONS
>  `--reedit-message`::
>  	Open an editor to modify the target commit's message.
>  
> +`-S[<key-id>]`::
> +`--gpg-sign[=<key-id>]`::
> +`--no-gpg-sign`::
> +	GPG-sign rewritten commits. The _<key-id>_ argument is optional and
> +	defaults to the committer identity; if specified, it must be stuck to
> +	the option without a space. `--no-gpg-sign` is useful to countermand
> +	both `commit.gpgSign` configuration and earlier `--gpg-sign`.
> +
>  `--empty=(drop|keep|abort)`::
>  	Control what happens when a commit becomes empty as a result of the
>  	fixup. This can happen in two situations:

This matches what we have in git-rebase(1). Good.

> diff --git a/builtin/history.c b/builtin/history.c
> index d28c1f08bb..97e0d77013 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -105,12 +105,37 @@ enum commit_tree_flags {
>  	COMMIT_TREE_EDIT_MESSAGE = (1 << 0),
>  };
>  
> +static int history_config(const char *var, const char *value,
> +			  const struct config_context *ctx, void *data)
> +{
> +	const char **sign_commit = data;
> +
> +	if (!strcmp(var, "commit.gpgsign")) {
> +		*sign_commit = git_config_bool(var, value) ? "" : NULL;
> +		return 0;
> +	}
> +
> +	return git_default_config(var, value, ctx, NULL);
> +}
> +
> +#define OPT_HISTORY_GPG_SIGN(v) {                 \
> +	.type = OPTION_STRING,                    \
> +	.short_name = 'S',                        \
> +	.long_name = "gpg-sign",                  \
> +	.value = (v),                             \
> +	.argh = N_("key-id"),                     \
> +	.help = N_("GPG-sign rewritten commits"), \
> +	.flags = PARSE_OPT_OPTARG,                \
> +	.defval = (intptr_t)"",                   \
> +}

Style: we don't align the `\` character.

Patrick
