Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BFF3203B0
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770751684; cv=none; b=NKlvDwfZcF3kiM0W33POHe0ACZMps+dcswKZ+xcDBoyN2jPJu4Z9BItnW6pzkYuTUdV0Ze7J5Va65bjtdcSOdU8zt/dm2erY/LcWYjFII6DAl8hjJ3lm6jCbbivWuP6kKkP8TkZBpEqXr6CdNwiYt2AJ3yqigqGmZ2wRraTXZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770751684; c=relaxed/simple;
	bh=vpbqIvy5My/2SOavwewws1qX+1n4BjOYYJkJ3SPgDsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gy6WBArZBNklFopGOE2FYhajbMUEbeT9tBTcMTSlxdnIWlSauqZ4qU57HPnUVz3nKVDume1IER6Qk3jSLCHfLCV5KiO9oJVu/LW0vAoCP3l5aRbaYtcS20Lexxx1gLSO7cOCcQZ8Vtb3CcUlRu+e3Zmz7tNJcsPY7Nr8PRGK8oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ofJk5TeU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TjBfpVeo; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ofJk5TeU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TjBfpVeo"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 911B21D000F0;
	Tue, 10 Feb 2026 14:28:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 10 Feb 2026 14:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770751681; x=1770838081; bh=ub+QMUUAvg
	Rrck/jUBo0x/ryQb0Z3nS4KP3BtFoeJ1Y=; b=ofJk5TeUC+s8SXVqj8tZ8zsRQI
	SuLOw9lNITzRHTOGeisAQig4FINMYiSJTYWB+3teNUy9O9Tl/3OIbuhyx5LR4gHD
	a7x6rBH1gF9mobTw986Abfah1sEwgIc5sTALALXSu3JjGL1MkegkuV5FbvnEH5/H
	CLgysQfkeRtB3aI9nO/f2ymS1EFVZUpuE4sDlizlSazDUu0o0FAfxCwACSXNmoCR
	brOJui/AjDBegzUT0AfovWNz37ZvQJ77k/HS1vvb5U0kGvG0NNvMKH7mw4Jq/85p
	Mm1m/8YB6KbfNOvu3ozYz5NHg+DXjNZMVNJl3oSggVVao5g/2gk2JkwWsfhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770751681; x=1770838081; bh=ub+QMUUAvgRrck/jUBo0x/ryQb0Z3nS4KP3
	BtFoeJ1Y=; b=TjBfpVeo9BPYPRx7BGtsuiRwBIGWSWknFNnj5VjnA53sSRcf7r/
	JkcS49FQ5tobaCl5PHo4YonFdy/N2den+BpU9vimk4qgf274OKNHQhGDmDL5AEfP
	VQfOwlSZS+eWe9LyFT06QPt+ZDsvpe8EnzhHhpz4xSsgLkDlDWw1099c1CbkFYQj
	JCkg5LfM74UL90N82eNL8xygdPCXg9H+f1Rw7fn183hSuTKx02YQN0zygpzvMRhZ
	N1lOWTgLt6r7FMRYGg1rDfX0oRsALlETW32JCbXHbsKAGJo5542an5AAwsxBhJdK
	iRbGCZGsOHlTkWwf4Z+9j1m/U9IrMS5BU6A==
X-ME-Sender: <xms:wYaLabGhHaGCxx8rAnjXqYGVrm4QrpW4B8NEncPcD08byd6qn2Ju3g>
    <xme:wYaLacAfgL2CbM6Y6f0naY2mBUtNJ75YT3Y_HeHoIZR-RgSUc00Fb1XDuXxb3yjdD
    X7mO8cTPSjFVveNGoVLfYUfYcXtSMhr2bEqDrSeXTgR9wVKjLEqCw>
X-ME-Received: <xmr:wYaLaW9f19nTMJLMS4KeR5monhC1qz3EOarjcrWN5MHTShIhCQWIqB5UgCxXegI-ZzB0kZXdXKwjiJO84F-vSP-lo2nD3nqdyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddthedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhprghgvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wYaLaQDMsmDdwn6ylsSjdXXJLStro7SZRlqk-J0dwkkB4T7bZOBxDg>
    <xmx:wYaLaTSr3kWn9399LXT5bJrabMIIJlnsnOnQMqiYF0C3gdZ5TlCytA>
    <xmx:wYaLafu7v0ic7nYBYfK_mRGjoykWFbudmH9Dn09Ym87OsV5eH6_R9w>
    <xmx:wYaLaX0C8z_Tqx7Ra4RwqvY96k587EuUHp_nOmzUJxOrAfdVeewgMQ>
    <xmx:wYaLaYDPAF3Y_YE6Jm4mR52Bwc5ZS-Q5mZSL2LvNKUbejyMxXhqnIuqc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 14:28:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: git@vger.kernel.org,  peff@peff.net,  "D . Ben Knoble"
 <benknoble@gmail.com>,  "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/2] help: use list_aliases() for alias listing and
 lookup
In-Reply-To: <20260210183110.1151072-2-jonatan@jontes.page> (Jonatan
	Holmgren's message of "Tue, 10 Feb 2026 19:31:09 +0100")
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
	<20260210183110.1151072-1-jonatan@jontes.page>
	<20260210183110.1151072-2-jonatan@jontes.page>
Date: Tue, 10 Feb 2026 11:27:59 -0800
Message-ID: <xmqq3438z9ds.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonatan Holmgren <jonatan@jontes.page> writes:

> help.c has its own get_alias() config callback that duplicates the
> parsing logic in alias.c. Consolidate by teaching list_aliases() to
> also store the alias values (via the string_list util field), then
> use it in list_all_cmds_help_aliases() instead of the private
> callback.
>
> While at it, switch git_unknown_cmd_config() from skip_prefix() to
> parse_config_key() for alias parsing, which properly handles the
> config key structure and prepares for multi-level alias config keys
> in a subsequent commit.
>
> No functional change intended.
>
> Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
> ---
>  alias.c |  4 +++-
>  help.c  | 26 ++++++++------------------
>  2 files changed, 11 insertions(+), 19 deletions(-)
>
> diff --git a/alias.c b/alias.c
> index 1a1a141a0a..c66a6095bb 100644
> --- a/alias.c
> +++ b/alias.c
> @@ -29,7 +29,9 @@ static int config_alias_cb(const char *key, const char *value,
>  						 key, value);
>  		}
>  	} else if (data->list) {
> -		string_list_append(data->list, p);
> +		if (value)
> +			string_list_append(data->list, p)->util =
> +				xstrdup(value);
>  	}

If !value, the original still added p to data->list, but the updated
code discards p when value is not there.  Is that an intended change?

If not,

	} else if (data->list) {
		struct string_list_item *item;

                item = string_list_append(data->list, p);
		if (value)
			item->util = xstrdup(value);
	}

perhaps.

> -static int get_alias(const char *var, const char *value,
> -		     const struct config_context *ctx UNUSED, void *data)
> -{
> -	struct string_list *list = data;
> -
> -	if (skip_prefix(var, "alias.", &var)) {
> -		if (!value)
> -			return config_error_nonbool(var);
> -		string_list_append(list, var)->util = xstrdup(value);
> -	}
> -
> -	return 0;
> -}
> -

A value-less 

	[alias]
		foo

used to get an configuuration error with a friendly message from
help.c:get_alias(), which was removed.  The config_alias_cb() called
by alias.c:list_aliases() either silently ignores foo altogether
(the posted patch) or creates an entry for 'foo' but leaves its
expansion to NULL (the above "silent ignore fix").  Either way,
there needs some new code to compensate for the loss of the error
detection somehow.

> @@ -501,7 +488,7 @@ static void list_all_cmds_help_aliases(int longest)
>  	struct cmdname_help *aliases;
>  	int i;
>  
> -	repo_config(the_repository, get_alias, &alias_list);
> +	list_aliases(&alias_list);
>  	string_list_sort(&alias_list);
>  
>  	for (i = 0; i < alias_list.nr; i++) {

OK.

> @@ -586,7 +573,8 @@ static int git_unknown_cmd_config(const char *var, const char *value,
>  				  void *cb)
>  {
>  	struct help_unknown_cmd_config *cfg = cb;
> -	const char *p;
> +	const char *subsection, *key;
> +	size_t subsection_len;
>  
>  	if (!strcmp(var, "help.autocorrect")) {
>  		int v = parse_autocorrect(value);
> @@ -601,8 +589,10 @@ static int git_unknown_cmd_config(const char *var, const char *value,
>  	}
>  
>  	/* Also use aliases for command lookup */
> -	if (skip_prefix(var, "alias.", &p))
> -		add_cmdname(&cfg->aliases, p, strlen(p));
> +	if (!parse_config_key(var, "alias", &subsection, &subsection_len, &key)) {
> +		if (!subsection)
> +			add_cmdname(&cfg->aliases, key, strlen(key));
> +	}
>  
>  	return 0;
>  }

Arguably, the last two hunks are about preparing for three-level
alias.*.command support.

It is a bit unfortunate that with

    [alias "foo"]
	command = !date
	bar = !echo bar

in your configuration, 

    $ git foo.command
    $ git foo.bar

used to invoke the alias 'foo.command' and 'foo.bar' just fine, but
now with these two preparatory hunks, it no longer is the case and
they are silently ignored.  With the next patch, 'git foo' starts
working in place for 'git foo.command', but 'git foo.bar' has become
forever inaccessible.  I wonder if we want to warn about foo.bar if
not foo.command, or if it is too much?  It is conceivable that we
may add variables like alias.*.help so it may not be a great idea to
warn on anything alias.<subsection>.<key> where <key> is not "command"

Perhaps we can claim that we are fixing a bug that allowed aliases
with a dot in its name by mistake?  I dunno.  No matter what we
claim here, some people will be hit by this behaviour change and
complain about a regression X-<.



