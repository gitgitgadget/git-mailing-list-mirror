Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA36235B150
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962318; cv=none; b=aRez33QwCuhM4EFd/6iIUPrDgx2YAYYCSoYMCi513I537PlKAUVWdbuuU9kcIyWn5m+KKm41bwsosbSil5Sr0pal0yaNaRKmwcokt5QwzOOuTmRV75o5fXSV1Wki2Wh7QofewMn0aA7NdfE3EvtNgyX4w8OOJ9acq1pLzKCby80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962318; c=relaxed/simple;
	bh=ubOvZXYfqZQtxcyk/Digx2iHDxJCIWphDdP10UVQxyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raSUsp3y06HRRd6rHK5x6z4MhCNqNpZSUqgrOq8T8P2UlaGG7MpHfx2kb2mwippYiQRW1+G8WUbe1b259YsxuN5TAlP8ueCEN4mdY2PCaJTgWXuT8bZaV75P9nbesu/epqYK54gHStDo7eIPajc5NC2BmHPfIXCdGu+A6oteHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d2XeKmQ8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EpLwgQnz; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d2XeKmQ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EpLwgQnz"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id CD3951D000FB;
	Fri,  9 Jan 2026 07:38:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 09 Jan 2026 07:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767962315; x=1768048715; bh=iRMLUl7lW1
	727QykRbTkiSPpZ3NdodbQs0Uk+LhNtNY=; b=d2XeKmQ8jdBjaGiyps8qPuBot/
	mrC8tA9zmW+6/6vwtegUauB7Cosgi90zJd1N2ErtbvqHRCH1O4nx20CiPOiMpAL5
	ubWOtJnJoyq+OimFl4xm26Ug6gdhTgL3kqm4RzjARb8SGW7bx+gfUncDLxz0DP6u
	BwPmMOzz6jmxk4GPUhFkiaifznL9HyNXlBtUuTrzcrjsFv6YTaefuOVFGMrK6ulE
	LAtyhOm7/xo05cGzLLs9Ta9PbXYKOPbVWeOQP4RynuthPE+DnWqXfrYJyXu+eDiR
	wrnzr/yoYke6Tr3/YJ2dyiswi8V0fL9PcXf48BmIz6c6wd4CRH4ucT3XKFFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767962315; x=1768048715; bh=iRMLUl7lW1727QykRbTkiSPpZ3NdodbQs0U
	k+LhNtNY=; b=EpLwgQnzoJ76ZtiAJZrdHCmTPLZGQLjWLmbqir2t214hBOxnVy+
	uIWE+Ch2PGBMC3G5YITAGggMTmuIqLlTWjuh1lLQvt4oFKKyZAKjkuG27QWH2x3G
	JZdzIYLt7DmlPbUg+1tGKaITogIG1fSvl2Tc7Zuul2pbTBZoCKVZ2f9Olt+j0hIm
	lJPLNIey31nvzU2i8RvKAVtjo0rZx3u7MdSAMZQZgXXYlJdeiRMCAJsiA/x6HQrF
	c92BTbNuGGpX5lk862z4A7XJE/GT3CjLXip8nb+VUmEg/radNA1eepvJiJBwiJ4y
	AJB76OsgdiLFI6nJBBKEcipwj+D0ue7kpdg==
X-ME-Sender: <xms:y_ZgaYauMsvZRHIHSpdmdvS52qw1egS84qulrdBbqKCDkIfWVwmnPw>
    <xme:y_ZgaVq3tiPJzlHTdcxHC6CdFvU_ueUyfDhWVgnrTwxzOx7mXjdb5oBpK3fmRXcY6
    1DArbOI2NIYzlnfsG2xVEFu34Sd5-qgQ7zV640ckAMUVFEjR7HmHWQ>
X-ME-Received: <xmr:y_ZgaVPJwltwj5xZjXqUT4Ow73klVf6KOFxiocEttLrjhVVoAtMBmuNGHm-w-JyqTjRAKcKRGoJLl2XBFDjzWmMhJUq72cUclmXQ9ZP4LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehs
    tghhfigrsgeslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhithhgrggughgvthesgh
    hmrghilhdrtghomhdprhgtphhtthhopehophhohhhorhgvlhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:y_ZgaYq4AzRxm08Mt4ZlclfAKUO_85Tqu9JRSmZidV5NBRFGBWcaPw>
    <xmx:y_ZgaSdjTpBys_7lyNqTFJRbSzJK0hpzkjE1GTg2u0tPIkb08DSlbA>
    <xmx:y_ZgaWShtmrEnpzVsoAY9c0Z0If0Z8Y60_HQzoPeQpKYtnGO3bE8sA>
    <xmx:y_ZgaTbrzHiTXuegMewJFGhuGEl7s2cLMZYH4n4uHAiwwEmU5h1FOA>
    <xmx:y_ZgaU6ktL5wiIpmEkqCPJExLhV7hQGQmyigZ-F_i-ZjCn5fkoZQdVEB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:38:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 207c1fc3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:38:33 +0000 (UTC)
Date: Fri, 9 Jan 2026 13:38:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Ondrej Pohorelsky <opohorel@redhat.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
Message-ID: <aWD2x154F5f-c3pL@pks.im>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
 <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
 <fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com>

On Wed, Dec 17, 2025 at 02:23:42PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Even though control sequences that erase characters are quite juicy for
> attack scenarios, where attackers are eager to hide traces of suspicious
> activities, during the review of the side band sanitizing patch series
> concerns were raised that there might be some legimitate scenarios where
> Git server's `pre-receive` hooks use those sequences in a benign way.
> 
> Control sequences to move the cursor can likewise be used to hide tracks
> by overwriting characters, and have been equally pointed out as having
> legitimate users.
> 
> Let's add options to let users opt into passing through those ANSI
> Escape sequences: `sideband.allowControlCharacters` now supports also
> `cursor` and `erase`, and it parses the value as a comma-separated list.

Hm, okay. I don't really see much of a reason to allow these, but now
that the code exists already I don't see a reason why we should remove
those options again.

> diff --git a/sideband.c b/sideband.c
> index fb43008ab7..725e24db0d 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -28,9 +28,43 @@ static struct keyword_entry keywords[] = {
>  static enum {
>  	ALLOW_NO_CONTROL_CHARACTERS = 0,
>  	ALLOW_ANSI_COLOR_SEQUENCES = 1<<0,
> +	ALLOW_ANSI_CURSOR_MOVEMENTS = 1<<1,
> +	ALLOW_ANSI_ERASE = 1<<2,
>  	ALLOW_DEFAULT_ANSI_SEQUENCES = ALLOW_ANSI_COLOR_SEQUENCES,
> -	ALLOW_ALL_CONTROL_CHARACTERS = 1<<1,
> -} allow_control_characters = ALLOW_ANSI_COLOR_SEQUENCES;
> +	ALLOW_ALL_CONTROL_CHARACTERS = 1<<3,
> +} allow_control_characters = ALLOW_DEFAULT_ANSI_SEQUENCES;

Nit, not worth addressing on its own: readability would be helped a bit
if the assignments were all aligned.

        static enum {
                ALLOW_NO_CONTROL_CHARACTERS  = 0,
                ALLOW_ANSI_COLOR_SEQUENCES   = 1<<0,
                ALLOW_ANSI_CURSOR_MOVEMENTS  = 1<<1,
                ALLOW_ANSI_ERASE             = 1<<2,
                ALLOW_DEFAULT_ANSI_SEQUENCES = ALLOW_ANSI_COLOR_SEQUENCES,
                ALLOW_ALL_CONTROL_CHARACTERS = 1<<3,
        } allow_control_characters = ALLOW_DEFAULT_ANSI_SEQUENCES;

> +static inline int skip_prefix_in_csv(const char *value, const char *prefix,
> +				     const char **out)
> +{
> +	if (!skip_prefix(value, prefix, &value) ||
> +	    (*value && *value != ','))
> +		return 0;
> +	*out = value + !!*value;
> +	return 1;
> +}
> +
> +static void parse_allow_control_characters(const char *value)
> +{
> +	allow_control_characters = ALLOW_NO_CONTROL_CHARACTERS;
> +	while (*value) {
> +		if (skip_prefix_in_csv(value, "default", &value))
> +			allow_control_characters |= ALLOW_DEFAULT_ANSI_SEQUENCES;
> +		else if (skip_prefix_in_csv(value, "color", &value))
> +			allow_control_characters |= ALLOW_ANSI_COLOR_SEQUENCES;
> +		else if (skip_prefix_in_csv(value, "cursor", &value))
> +			allow_control_characters |= ALLOW_ANSI_CURSOR_MOVEMENTS;
> +		else if (skip_prefix_in_csv(value, "erase", &value))
> +			allow_control_characters |= ALLOW_ANSI_ERASE;
> +		else if (skip_prefix_in_csv(value, "true", &value))
> +			allow_control_characters = ALLOW_ALL_CONTROL_CHARACTERS;
> +		else if (skip_prefix_in_csv(value, "false", &value))
> +			allow_control_characters = ALLOW_NO_CONTROL_CHARACTERS;

Does it really make sense to also handle "true" and "false" here? I
would expect that those values can only be passed standalone.

> +		else
> +			warning(_("unrecognized value for `sideband."
> +				  "allowControlCharacters`: '%s'"), value);
> +	}
> +}

This could be simplified if we used e.g. `string_list_split()`. But on
the other hand it avoids allocations, so that's a nice benefit.

Patrick
