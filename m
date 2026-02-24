Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F8D19E97F
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771956473; cv=none; b=Aq1mO1KpzK32IzBgmRI1UZhjUdrpIJHBi3LqjTj9Jc0GrzyQ/LXOUiP5QfpwaGcl2ySDMgxk3OXIWKbwSYpC0b90bJmQLLULi8uX4hXkqzvrB7L8oqpzYk/UYUhqKWifZStTzhR1Z5RzTs3ngcS0xkqslUj5AcUzdXTPx1Gh3oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771956473; c=relaxed/simple;
	bh=F8hTDIId2aLge0nv2202YJgufcG5K58xQD/0qYqeauo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V//xFTRYVyPwmean68CWHsu3tNkyCCkstUSGo+mYPnh2GHC0IhRNo14ByxW24rSijXzzS5ec3qRTn2OUPHg2QJY51+zQzNG2JcYcy1Vju9mk110AjFR/fu113lI6Z2nH53RSqbhlQ/jAbCxSKMUmlUonGxxb1L+pd6z7uI0ynt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E+rzYyTH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rCCFXeUY; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E+rzYyTH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rCCFXeUY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA33E7A0185;
	Tue, 24 Feb 2026 13:07:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 24 Feb 2026 13:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771956470; x=1772042870; bh=K8AJfnHX5D
	2vA5CyW702AMlckeGrAmrQutbR8GibvCg=; b=E+rzYyTHqR8eIhZFsku94/FIJT
	PwfiqvDN/8ov3XCN4pgGbojjBvK/MkxpYTRbzOJb/YB05Z2KVIuQDAYKGSC6f8/E
	qYy1j9YruqSfrwroFjirnxDKs/cXDRNjaIqhywk96ZJeQDe09luJhCwqJdMJpUG0
	kP4JJ1pTBUo/958vlNcBwkLfyLucMv69BdJx+vm/WcL5IBjm9LLgbxlaYgv8/Hrw
	lmUJcV+wpK/fOz2r69+SBoWq7ZAj2UKLxoVOhuPjZ5esMcYkfm24b2mHXRf67LQh
	vh4AreFwJ/uQPVxS+Nn/EoHc0/3CYVvj/vYlGz1KgClZwyiYC4b1cvdkbj7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771956470; x=1772042870; bh=K8AJfnHX5D2vA5CyW702AMlckeGrAmrQutb
	R8GibvCg=; b=rCCFXeUYqHZVNwOm2KdkGdr2Uh0y95FUhAIot42z3F25bYpgQk9
	mOSoq8yJpa/Lanu2d+o2PFcwnZRHoXHxpPn6QDEW1EM6lmzgb700d8mwQDIDrs6F
	Uuo2WQcT0AElg9kqEuoqObFyyBSqJMU5B/Dm89vxq7vRTJIL/HfjiZkCWWLYD1eH
	K+Pi1H61c5m2BIN3p6IG/9A0Q38QzwPYD9n+OIG+jpg7jEO/5N5561v+NKiz8ITN
	3cZ8rw6cOGa/3QR+Oj7oyRQUheMm46z8wMDXkMrrrfyxjxOmmidt9PWGyRpPU1XN
	/r7uUAVooIWkT4d9OHHZ1XnMDnWkUMr6STQ==
X-ME-Sender: <xms:9uidaUzSmIFb4Ztw5gatI-B85j-wcaXgW0JJiyecTzEdEV3voHHLZw>
    <xme:9uidafSSQKQrr__NjIoDE8xqkJYAOxcz39HAjuc680yOURTmAMwF_8ZCPMUGFuPJt
    OyLdhbMq3K1oQ7VtiQHh-OOPmJ0W9-LJ0_L4ZLb-iXC6F9Sv6Hfgw>
X-ME-Received: <xmr:9uidabXXX3IrsneCDloRLysSst9-8Jo-5PWZHiwV-b62VNls6tp3ewFlysxqZSIqKk3VI5y7ZmBcrnPXGUQBFcf--qhLh742bA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedtkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhff
    eggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9uidaRaEl3hRLtOPs_VnAWtrR6qO3oI5_IHdA5LL_2xwkd1jQ4bm0w>
    <xmx:9uidaR03uP6vK7hbPniKgwp5e2qGSACxNUIeY1sdeghco1v4LSeKzw>
    <xmx:9uidaTjTRTnH7pD0KM64WOhyDhznG-09nSlbfdDjATNc5YFL2NHbkg>
    <xmx:9uidaVZSCu45r8eJOMgIcB2cecxL-VNSAWplBv1FQYTq959GzLVDEA>
    <xmx:9uidaZ0MylEF1FBo5owRX2NZVfBrwX0QOZnesppPvjQa3x1jw2mDWGsq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 13:07:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] format-patch: add commitListFormat config
In-Reply-To: <6a0c7aecfd6dc1ee873d5e81110b723fa2d225fb.1771925291.git.mroik@delayed.space>
	(Mirko Faina's message of "Tue, 24 Feb 2026 10:29:02 +0100")
References: <20260224040400.751247-1-mroik@delayed.space>
	<cover.1771925291.git.mroik@delayed.space>
	<6a0c7aecfd6dc1ee873d5e81110b723fa2d225fb.1771925291.git.mroik@delayed.space>
Date: Tue, 24 Feb 2026 10:07:48 -0800
Message-ID: <xmqqqzqaggln.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> +	char* fmt_cover_letter_commit_list;

In this project, asterisk sticks to the variable, not the type,
i.e.,

	char *fmt_cover_letter_commit_list;

I think you got this point right in the previous patch.

> @@ -1052,6 +1054,19 @@ static int git_format_config(const char *var, const char *value,
>  		cfg->config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
>  		return 0;
>  	}
> +	if (!strcmp(var, "format.commitlistformat")) {
> +		struct strbuf tmp = STRBUF_INIT;
> +		strbuf_init(&tmp, 0);
> +		strbuf_addstr(&tmp, "log:");
> +		if (value)
> +			strbuf_addstr(&tmp, value);
> +		else
> +			strbuf_addstr(&tmp, "%s");
> +
> +		git_config_string(&cfg->fmt_cover_letter_commit_list, var, tmp.buf);

What if /etc/gitconfig has "[format] commitListFormat = shortlog",
~/.gitconfig has a different setting, and then .git/config has yet
another setting?  Woudln't cfg->fmt_cover_letter_commit_list at this
point have a copy of the value read from the previous configuration
file?  Without first freeing it, wouldn't we leak the previous value?

    $ git grep -C2 git_config_string\(

gives plenty of precedence, like this one.

builtin/commit.c-	if (!strcmp(k, "commit.cleanup")) {
builtin/commit.c-		FREE_AND_NULL(cleanup_config);
builtin/commit.c:		return git_config_string(&cleanup_config, k, v);
builtin/commit.c-	}
builtin/commit.c-	if (!strcmp(k, "commit.gpgsign")) {

> +		strbuf_release(&tmp);
> +		return 0;
> +	}
>  	if (!strcmp(var, "format.outputdirectory")) {
>  		FREE_AND_NULL(cfg->config_output_directory);
>  		return git_config_string(&cfg->config_output_directory, var, value);
> @@ -2318,6 +2333,13 @@ int cmd_format_patch(int argc,
>  		goto done;
>  	total = list.nr;
>  
> +	if (cover_letter_fmt && (strcmp(cover_letter_fmt, "shortlog") && strncmp(cover_letter_fmt, "log:", 4))) {

Overly long line.

What if it turns out that the --cover-letter option is not given
(and we are dealing with a single-patch topic, so auto setting has
decided that there is no need for cover letter)?  Shouldn't we
continue ignoring the typo on a setting that we are not going to use
anyway?

Stepping back a bit, even if we do not validate the format *here*,
shouldn't the code that does use cover_letter_fmt later in the
control flow *already* be checking the validity of the format and
complaining?  If that happens early enough, perhaps we do not want
to have an extra "early check and die" here.

> +		die(_("--cover-letter: invalid format spec"));
> +	}
> +
> +	if (!cover_letter_fmt)
> +		cover_letter_fmt = cfg.fmt_cover_letter_commit_list;

As I pointed out in my review of [1/2], it is not a crime to set a
value to cover_letter_fmt even when !cover_letter, and the above
line does exactly that ;-).

By the way, the usual technique used in this codebase when handing
configuration and command line option is to these in this order:

 * Initialize a variable to the built-in hardcoded default (e.g.,
   "shortlog") upon variable declaration.

 * Let repo_config() call overwrite that same variable.  This is the
   typical implementation of "if there is no configuration, we use
   the hardcoded default, but the configured value can override it".

 * Then parse_options() overwrites that same variable.

But because we read configuration into a separarte variable (i.e.,
members of cfg structure), this function cannot literally follow the
usual pattern.  But the pattern we instead can follow is this:

	/* initiailize to NULL */
	char *cover_letter_fmt = NULL;

        /* read configuration */
        repo_config(... &cfg);

	/* cover_letter_fmt will point at command line arg */
	parse_options(...);

        /* NULL if no command line argument */
	if (!cover_letter_fmt) {
		/* perhaps configuration has one */
        	cover_letter_fmt = cfg.fmt_cover_letter_commit_list;

                /* otherwise, use hardcoded default */
                if (!cover_letter_fmt)
                	cover_letter_fmt = "shortlog";
	}

