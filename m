Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252D51A2C0B
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 05:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055156; cv=none; b=BB70D62ZlviDq3sYrzlPy36V2npIDLiRGsVEpVEnZ2Hhf+Jw3xcb/624QxlCIw0tR1SNsZ/a6f2fJfCRQDRY4XijfpunOXqrf04aUw5gEsy/o6BvpDwnbz+8trF3vcIcuYUeEnJjj2yxjpUUu32yfxT2DbY89cF3lXRxRCQQ6MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055156; c=relaxed/simple;
	bh=qTRKTidmSj1ofAIQX24GcAsqMxIHpAr/NkHQESKBEBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o1Byb75t0Sje2W7YJ4k9CF3D18WFcI6taaokSvYsyX4RWPyH9692nLRSVjmROVRj20QuUfyK0erCEQyXP4UowWMkEQEgHgWiXtPuGJN2V8ax3wFv6OXyC3FfL2cNKydh8pLe/0GDsZQv81FYIb1jkroXUykJEYFL7IeVU61/Uuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o2CN2VTo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TtxE8owO; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o2CN2VTo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TtxE8owO"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2EA49EC00BA;
	Tue, 22 Sep 2026 01:32:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 22 Sep 2026 01:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790055153; x=1790141553; bh=u43AXEn4e+
	SCtup/9WMl7l58Fbiv4XJX+yH0Td8nXVs=; b=o2CN2VTo8NZBmOByYIfUMA/JX+
	AHBVaqb+QHsYAg8v6TE0b830TukshQIvcTlSRhUmLqhABAMNLHLojGqc2uLnC2NZ
	WjLZI5Lvb6zEY8qbGEdz4+hoVfj8fsFTci0BBbFsrwV/Qrv1qxBX6G551jRD2BA2
	tW3Hn9+ENbRCRVDYqdcgzo/qxV8hB9yOr9DSfteyBMoFXcL671wut4F6HzPAJBif
	MvmQFwCvMtN/dYb3QBFkeuwAhQcZY+O9kYl719avNGpEF+HVvWWwM7Bz76UB1CKy
	eN7QJjgf1wsYGQkmjtUCCx/pvkH9xpV4EQ6DQ/k+EjeYEt2DxYgq6G4GQ4LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790055153; x=1790141553; bh=u43AXEn4e+SCtup/9WMl7l58Fbiv4XJX+yH
	0Td8nXVs=; b=TtxE8owO6diy/UX4UM3K8zmVL5/nHC0ZeifHzDGZ9dsrw+j1rOQ
	ZyC09lPJcng3UKaZp11S46ogH+C0mNGHAVgO1c2TGNcFMbem7uTxkZ+cB5pJb0LR
	pfQhl38i3vkznu8VtU8/dBYVuqjJTckQZIr+qewCmrmVYMU5GhKxujy5BJfabDBr
	USlUGViRSYo92tt2eD5NNrf4TNEiNOdajLkkJj3FgqduTSNpaLq1pw+MA9wIqIfl
	fQPOPPoYYcaflfA3jR/T2B7JrsBc4EusqTsMQ2oS7b2OWTjijISf9ZtHmKYzP1fj
	UhZTX0tahxFuYOPrlWXvSTtSMNnVTzVWLog==
X-ME-Sender: <xms:8RKyapRF0pNIRaADuVayAzPCvPk2PPXvKrCIDCR3QyFHBjy4e57JPA>
    <xme:8RKyaqOPTAlHfCevmUX8X_WVrM3ltGyf47XYRK6skeYHpJeE13va9qgK_zQlosiMn
    hSLsWl5FJ4uI8CxjVWbmdOiT4LG__i6OZRHDXeeDdnY5cr-SHJKgLo>
X-ME-Received: <xmr:8RKyasOiZ7fb7pRNVwfqDhhKsf1dMpKu1kVWueaRsspKFgzz9N89QLTxYQVLwZ9-qTWaZHyNR6CFLbJViK4bAmYIWuS6oO-fjMS0>
X-ME-Proxy-Cause: dmFkZTFUHBZDWa3IPVkJyi4DK6ZqjnuQfoLnKs4e7vd3yD7vL/Ml67T02/PFxVmlkCCdls
    TnA8YP8i9k350d8vXvq5/o6Pl81WMRRHDq1K944vhW18WSpD1hr2SviVbzwA5I68xFPzps
    6U9jiqITQKeQH7Hb/OxygdPiLoASq7FN6+QpiPSwKJANHmqmUHaTR/Uh3XKe5CpzhBJ3h8
    yn3twTMPZ+Zf313s1nH0kIWu3dNYwEGYiZjw/d689iZpKvxqMWN+GS5fcAsUG0tBOAfuqH
    n4cUE9G08BgkZ+atBQbqw94T121RYW5TlzyD/NGmuTweK1zJy+M2HaHKOgqeCuGryHJSds
    5KTGEm/Nl7Fr7/A/3CoLyFqSaiYuef3O8yjZ8Zdf3b7PyR/LoGRBEr0DNQlD6SqrqjY+Iv
    m8K2pq03M95KUgHpXBCKUEBs/PkDCBz7Wgh5M2+BvEZNWM/018dyYjIqp7RGldX5pnEk8u
    5JVvw1H80mFxJ8rgLYlZv51KJivl0O9cL6TzeELP/vOJHOj/UNDdNs0DMILsLGobNBc6qD
    ER5f96KHY0ROwGCrdzN4xbhvBxNWmLMbUYYqqWE+qHDMJQwDBpiONbqABquMSveug2sVE4
    wi1XCI4YN3ay2hcFDpUOT9LycRN1PyEM4rjTNLmaKyK+PgSYyrrT45jEJtAQ
X-ME-Proxy: <xmx:8RKyaqsC6kF5L8Oqymo75nUFSOUDmbNvGF7XfERQAfHEGqvBnuVV7A>
    <xmx:8RKyamVADnkjU9OcDfIUZiCr8H6p892sVOqYWSIhD6SAv4xpqO33lA>
    <xmx:8RKyaiuqmVYFvyXHAyg5Xaarhs2q6x4UWwHH5KTG0-76n5V5hrOFmw>
    <xmx:8RKyaiUgx4XHTbaVM-0BeYU6B59rjO2p9nJjWqzWcpExOd9Euy9cSg>
    <xmx:8RKyaqMDagdprCFNLQLApKAoAd58BEOpyIV9sfbCwrZBhr0SA07xYeJq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 01:32:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Colin Hinton <colinlewishinton@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] fetch.c: defer fetch.followRemoteHEAD validation
In-Reply-To: <20260922040047.2567-1-colinlewishinton@gmail.com> (Colin
	Hinton's message of "Mon, 21 Sep 2026 21:00:47 -0700")
References: <20260922040047.2567-1-colinlewishinton@gmail.com>
Date: Mon, 21 Sep 2026 22:32:31 -0700
Message-ID: <xmqqwlsdhmvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Colin Hinton <colinlewishinton@gmail.com> writes:

> Previously, fetch.followRemoteHEAD was validated and any invalid
> value was warned about unconditionally during config parsing.

Early paragraphs that make observation on how the current system
works should be written in present tense.  It is the status quo, so
we shouldn't say "previously" and we do not need to say "currently".

    The value of configuration variable "fetch.followRemoteHEAD is
    validated while the configuration file is being parsed, which
    lead to a warning, even when we do not need to know the value.

> Now store the raw config string instead, and resolve/validate it lazily
> at the one call in do_fetch(), so an irrelevant fetch no longer warns about an unrelated
> config value it never needed.

Well written, except that "an irrelevant fetch" is a bit awkward.
"Irrelevant how, for whom, and why?" is a set of natural questions
that come to readers' minds.  I am guessing that you wanted to say
that "git fetch" does not always need to know the value of the
fetch.followRemoteHEAD configuration variable, perhaps because a
particular invocation of "git fetch" receives specific refspec.
You'd need to find a concise way to say that and replace the
"irrelevant" there.

In any case, it is a very good discipline to avoid dying or making
noises while reading the configuration file and instead complain
only when we know we will use the bad value.

>  struct fetch_config {
>  	enum display_format display_format;
> -	enum follow_remote_head_settings follow_remote_head;
> +	char *follow_remote_head_raw;

OK.  So this is the read the value and keep it as-is.

>  	int all;
>  	int prune;
>  	int prune_tags;
> @@ -178,22 +178,29 @@ static int git_fetch_config(const char *k, const char *v,
>  	if (!strcmp(k, "fetch.followremotehead")) {
>  		if (!v)
>  			return config_error_nonbool(k);

This error still triggers even when the configuration variable is
irrelevant (e.g, "git fetch origin master", i.e., rs->nr != 0).
Dealing with it is well within the scope of the topic, isn't it?
You may be ignoring

	[fetch]
		followremotehead = bogus

when the user runs "git fetch https://over.there/repo master" with
this patch, which may be an improvement, but if the user has a
valueless truth

	[fetch]
		followremotehead

then the same command would die while parsing the configuration
variable, which is not what you wanted to see, right?

> -		else if (!strcmp(v, "never"))
> -			fetch_config->follow_remote_head = FOLLOW_REMOTE_NEVER;
> -		else if (!strcmp(v, "create"))
> -			fetch_config->follow_remote_head = FOLLOW_REMOTE_CREATE;
> -		else if (!strcmp(v, "warn"))
> -			fetch_config->follow_remote_head = FOLLOW_REMOTE_WARN;
> -		else if (!strcmp(v, "always"))
> -			fetch_config->follow_remote_head = FOLLOW_REMOTE_ALWAYS;
> -		else
> -			warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), v);
> +		free(fetch_config->follow_remote_head_raw);
> +		fetch_config->follow_remote_head_raw = xstrdup(v);

Good to see that the code is prepared to see the same variable
defined multiple times in the configuration stream without leaking
earlier values.

> +static enum follow_remote_head_settings get_follow_remote_head(const char *setting)
> +{
> +	if (!strcmp(setting, "never"))
> +		return FOLLOW_REMOTE_NEVER;
> +	else if (!strcmp(setting, "create"))
> +		return FOLLOW_REMOTE_CREATE;
> +	else if (!strcmp(setting, "warn"))
> +		return FOLLOW_REMOTE_WARN;
> +	else if (!strcmp(setting, "always"))
> +		return FOLLOW_REMOTE_ALWAYS;
> +	warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), setting);
> +	return FOLLOW_REMOTE_UNCONFIGURED;
> +}

OK.  So unrecognised are treated as unconfigured, just like before.

>  static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
>  {
>  	BUG_ON_OPT_NEG(unset);
> @@ -1922,7 +1929,7 @@ static int do_fetch(struct transport *transport,
>  	struct ref_update_display_info_array display_array = { 0 };
>  	struct strmap rejected_refs = STRMAP_INIT;
>  	int summary_width = 0;
> -	int follow_remote_head;
> +	int follow_remote_head = 0;
>  
>  	if (tags == TAGS_DEFAULT) {
>  		if (transport->remote->fetch_tags == 2)
> @@ -1938,22 +1945,6 @@ static int do_fetch(struct transport *transport,
>  			goto cleanup;
>  	}
>  
> -	/*
> -	 * NEEDSWORK: By the time this function executes, we have already parsed
> -	 * all such followRemoteHEAD values from the external configuration,
> -	 * potentially emitting warning messages for bogus values.  Ideally, if
> -	 * this fetch ends up not needing to consult these values, then git would
> -	 * not ever output a value warning. (eg: when pulling from a URL directly -
> -	 * rather than a configured remote, or when a remote's followRemoteHEAD
> -	 * overrides the fallback fetch setting)
> -	 */

Good write-up.  We should be able to steal some in our own description.

> @@ -1962,6 +1953,14 @@ static int do_fetch(struct transport *transport,
>  		if (transport->remote->fetch.nr) {
>  			refspec_ref_prefixes(&transport->remote->fetch,
>  					     &transport_ls_refs_options.ref_prefixes);
> +
> +			if (transport->remote->follow_remote_head)
> +				follow_remote_head = transport->remote->follow_remote_head;

The code assumes that remote.*.followRemoteHEAD has been pre-parsed.
Doesn't the code to do so in remote.c::handle_config() share exactly
the same problem as you are fixing here?

> +			else if (config->follow_remote_head_raw)
> +				follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
> +			else
> +				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;

Make a mental note that do_set_head is flipped on ONLY here in this
function.

>  			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
>  				do_set_head = 1;
>  		}

And later, do_set_head is referenced twice.  Once when preparing the
transport options to first discover what refs they have (ls-refs)

	if (do_set_head)
		strvec_push(&transport_ls_refs_options.ref_prefixes,
			    "HEAD");

and then once more to make a set-head call using follow_remote_head.

	if (do_set_head) {
		/*
		 * Way too many cases where this can go wrong so let's just
		 * ignore errors and fail silently for now.
		 */
		set_head(remote_refs, transport->remote, follow_remote_head);
	}

Incidentally, after that "lazily turn configuration string into
follow_remote_head variable" block is left, this is the only place
that follow_remote_head variable is referenced.

Which suggests to me that we can get rid of do_set_head variable, we
can initialize follow_remote_head variable to FOLLOW_REMOTE_NEVER,
and replace these two 

	if (do_set_head)

with

	if (follow_remote_head != FOLLOW_REMOTE_NEVER)

and the resulting code may become a tad easier to follow.

Hmmm?
