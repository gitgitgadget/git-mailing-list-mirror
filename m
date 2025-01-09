Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B235C221DB0
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440337; cv=none; b=Q7S6j14nUYc5sWzXHQKB2nG9F3w1Ecv8LOLJKyLUnihLgUrOwlYcyMSxF3tGXvhW/3axB3yggaFM7gTMRQf73oH/Bu5NCKTILtmfI7OgL+QoVPNR5aX/zNt/UeXHfBE8PKjJvQwS5D8MmFN/XvxqSajvolLSsy6uacYxRixnskE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440337; c=relaxed/simple;
	bh=Yb0Z8PEC5u5EWD5DSJxMupImEOEvHpWBxyLoRs+q8vo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C7VwVN3/GGDZV6knUgWnIg0g22l1xOzQ1VRUyA1utKiTbIEQSR2Ej4/QR8nGHcLvqX0L7fqwmDZtHM1SQaKvMVKP9bpgNwmD6pzwPeb30SGjqHf0XppaL2zECxW9E5uQWA7OU6lhl7m2HpMindvt/T5Wku+YP4oClXmGrHItPQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cTthnToC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z9UkqFMf; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cTthnToC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z9UkqFMf"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C5D8B11400B1;
	Thu,  9 Jan 2025 11:32:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 09 Jan 2025 11:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736440334; x=1736526734; bh=thvwnAT4Gf
	Qfzd1vyHy/c4rrCNPHhXohxgvbrm28K70=; b=cTthnToC9bTjZLtmHK4Batmd0c
	ChUUqmy5Rs1kyqo5bmfDnL3pfY38cP00ShBxaKXI9YmUAwXpbPlDcucYQAaRh+lE
	uZMNBMqG8N/4zm9bH8wpQDj4JuO9Mp514aaIZXYyRiTLENSKrILl3i7rBS9HsvfA
	wSvNjdjwjApbdfZ6BUQ1CIQeVitvtQ7qF7quYUlTHMrdo22SUiHYniyaxu92ich+
	ajNXWsYxdAyca6EsaxvGk6xozYzKh324aa+Ahqo8HiDWJ/dIyYHsd6tQADFNh/Hq
	weHZDYPCuDqJPF16i9+XBCriV8ev8XO80CBIh9xbQX8wHTiq0mlOH9DwnSAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736440334; x=1736526734; bh=thvwnAT4GfQfzd1vyHy/c4rrCNPHhXohxgv
	brm28K70=; b=Z9UkqFMfnYscx1+1aNjksPPduqvflzbJR/tAURIzf2FmPbX2HrY
	LjgOFad4/kfXL8l5/GPYckZKn/PBddYpaLaZnTVlQlS5Ft/HTLSqsuu4d5/bnCW9
	S9coxFT+Dh68f6AhHjs/QWORMO/ybVym+OcfiEKk+q/P78g8bZuuTfK2yNufQVC8
	0f5HvnCnnC9PCapBm+ayA+DEx50EEh7Shz8EN2kuRJY6wQ04zAFZ8m0uBlLC0Nur
	/d5ukLtjip1ggTYY5Y+lNPrSZCMbjvNXfPXrKzVylOs1e80W+hLvxNozEu0Npwcx
	OmFenYj9YobvoKrN2eP9B6vx1a8lIBlJZnw==
X-ME-Sender: <xms:Dvp_Z1_yqjBXBDRypZAmKDtb5NRS4w4VMXYdzNtEKmy7M_Xike7ObA>
    <xme:Dvp_Z5uoFGjaOPg96npeQ53JZl2AOpIhHqBBF2NkjUtwNYsZNX2hBvqU8TFETh-Bl
    SUaRFVcZ7vEJp6ufA>
X-ME-Received: <xmr:Dvp_ZzBki7AvBl3MMJ1VR7v1Lmh_fPBpjy9i-LbaQvEp7aNUY31OGUjFkoybGfuXvJZVhcaz2QbDGU9Uob7pgPkATmnxn2StYD0C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghl
    ihhnsehgmhigrdguvgdprhgtphhtthhopeihvgifohhnsehrvghvihdrvghmrghilhdprh
    gtphhtthhopehstghhrggtohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Dvp_Z5c0gKi6OUDgAMKNke1FkMhbG-NEBB39wCWckju8gbzHoFZUDQ>
    <xmx:Dvp_Z6PSTZeVNYy5zxm6fQHHq4HDVIGrhyTA9fCrpBrLrwChUS_iPQ>
    <xmx:Dvp_Z7m9i2CI0nlgRWi0OJz1Q17gTF4R_WuJ-R7-XVO8LbsIDyVLmw>
    <xmx:Dvp_Z0uPHW8jDspVZJTW-KP4Ful3JBBqj-iqQ9MqnSgwJRu29cWHHQ>
    <xmx:Dvp_Z5ePNQ_vBDvoidceYhkxXAapJlnDxOUu3fYxxQ8XOL4wUzBPkTWO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 11:32:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Yongmin <yewon@revi.email>,  Scott Chacon
 <schacon@gmail.com>
Subject: Re: [PATCH v2] help: interpret boolean string values for
 help.autocorrect
In-Reply-To: <pull.1869.v2.git.git.1736419777235.gitgitgadget@gmail.com>
	(Scott Chacon via GitGitGadget's message of "Thu, 09 Jan 2025 10:49:36
	+0000")
References: <pull.1869.git.git.1736364707068.gitgitgadget@gmail.com>
	<pull.1869.v2.git.git.1736419777235.gitgitgadget@gmail.com>
Date: Thu, 09 Jan 2025 08:32:12 -0800
Message-ID: <xmqq5xmoj6cz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/config/help.txt b/Documentation/config/help.txt
> index 610701f9a37..6d9c2e06908 100644
> --- a/Documentation/config/help.txt
> +++ b/Documentation/config/help.txt
> @@ -11,8 +11,9 @@ help.autoCorrect::
>  	If git detects typos and can identify exactly one valid command similar
>  	to the error, git will try to suggest the correct command or even
>  	run the suggestion automatically. Possible config values are:
> -	 - 0 (default): show the suggested command.
> -	 - positive number: run the suggested command after specified
> +	 - 0, false boolean string: show the suggested command (default).
> +	 - 1, true boolean string: run the suggested command immediately.
> +	 - positive number > 1: run the suggested command after specified
>  deciseconds (0.1 sec).
>  	 - "immediate": run the suggested command immediately.
>  	 - "prompt": show the suggestion and prompt for confirmation to run

Not a problem this patch introduces, but it looed funny to see the
second line abut to the left edge of the page there.

In any case, the updated semantics look quite sensible.

> diff --git a/help.c b/help.c
> index 5483ea8fd29..9e0f66c26dc 100644
> --- a/help.c
> +++ b/help.c
> @@ -573,9 +573,21 @@ static int git_unknown_cmd_config(const char *var, const char *value,
>  		} else if (!strcmp(value, "prompt")) {
>  			cfg->autocorrect = AUTOCORRECT_PROMPT;
>  		} else {
> -			int v = git_config_int(var, value, ctx->kvi);
> -			cfg->autocorrect = (v < 0)
> -				? AUTOCORRECT_IMMEDIATELY : v;
> +			int is_bool;
> +			int v = git_config_bool_or_int(var, value, ctx->kvi, &is_bool);
> +			if (is_bool) {
> +				if (v == 0) {
> +					cfg->autocorrect = 0;
> +				} else {
> +					cfg->autocorrect = AUTOCORRECT_IMMEDIATELY;
> +				}
> +			} else {
> +				if (v < 0 || v == 1) {
> +					cfg->autocorrect = AUTOCORRECT_IMMEDIATELY;
> +				} else {
> +					cfg->autocorrect = v;
> +				}
> +			}
>  		}
>  	}

The flow looks nice, but the pre-context of this hunk starts like
this:

		if (!value)
			return config_error_nonbool(var);
		if (!strcmp(value, "never")) {
			cfg->autocorrect = AUTOCORRECT_NEVER;
		} else if (!strcmp(value, "immediate")) {
			cfg->autocorrect = AUTOCORRECT_IMMEDIATELY;
		} else if (!strcmp(value, "prompt")) {

IOW, the new code added at the end of the if/else if/ cascade is way
too late.  

	"[help] autocorrect"

that specifies "true" has already been rejected as an error, with a
now-stale error message saying that the variable is not a Boolean.

We may probably want to use git_parse_maybe_bool_text() upfront,
like

	static int parse_autocorrect(const char *value)
	{
		switch (git_parse_maybe_bool_text(value)) {
	        case 1:
			return AUTOCORRECT_IMMEDIATELY;
		case 0:
			return AUTOCORRECT_NEVER;
		default: /* other random text */
			break;
		}
                if (!strcmp(value, "prompt"))
			return AUTOCORRECT_PROMPT;
		...
		if (!strcmp(value, "prompt"))
			return AUTOCORRECT_PROMPT;

                return 0;
	}

and then in git_unknown_cmd_config(), do something like

	if (!strcmp(var, "help.autocorrect")) {
		int v = parse_autocorrect(value);

                if (!v) {
                	v = git_config_int(var, value, ctx->kvi);
                        if (v < 0)
				v = AUTOCORRECT_IMMEDIATELY;
                }
                cfg->autocorrect = v;
	}

perhaps?
