Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395A54414
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770848940; cv=none; b=KKiQEFIAONehKfwMAsXtRtC1RFXIaAghI9Q4HkEJiuOJIcLxIzNnxYebsNV8GTG1PTfgva4IEva/NdvmBEgy8nY5tRZMrr0t47pvFDSpwuycezOBB0xdVw2UCQVOE2zulcS0NY/E3QhBh1CJMdoPY/q9iyR3bo3DZFgM3KvA0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770848940; c=relaxed/simple;
	bh=dB+xQmEVLE0E+JINxsJh6REQz3v8g04ByRD/iK2l37Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fFD/Bm9ewnCzAumRliEY2AgSGOBAA/y1yiPYtEeZT95dI7+GZJUwQEf5Qsd7siLhHuJIccKShdIxLQL7vQGQNphaTQcLawy3kowdXU3ZGgg0idf3RsvhpZl/Z7m0dbHLYHW1Z86U3/qARG6DBRtRIUtj4gpor5ic/yrJBgQsmWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vMN2zrGu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q2KujKSn; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vMN2zrGu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q2KujKSn"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D9E407A0168;
	Wed, 11 Feb 2026 17:28:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 11 Feb 2026 17:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770848936;
	 x=1770935336; bh=KmQmEKEFrAjUtA7lQvU6ukE62mnM6cJzzIhSJdcLd3U=; b=
	vMN2zrGuOWKmMA6b1H7NdQjwY5mFTjFb9+SlNHbURVaRSmCj+iApECYJF1nA8WAA
	Rh4qU5D0VtugQLAu/ZLxhl8tLhnZeZSnvMsfE96sBDy9GkMGnIiMDHUnbJnS94En
	n1JhzDt5WPDKSllkmhiOpvdP+wjO9sEhTg1tR8N9ZzY96Gpq2gspKguEOH87/OGz
	ITEZNpLeEI9XGyXq1NOWHcJ1B1zNx39qgRzwcbm29KggjZJsJ1kvpTxOByC8Vw0A
	sLhSsKxgQu3Ai8kvHwb9y97KCpwI/GEYpY3voiWE50/B14tLwEbHHExeO9Prsbkr
	Foom6Mh76Utlonrpk3aX6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770848936; x=
	1770935336; bh=KmQmEKEFrAjUtA7lQvU6ukE62mnM6cJzzIhSJdcLd3U=; b=q
	2KujKSnkeZPIvWjO1wdn5PkbdPXq0qYSGDt5w2aOOQO3yLLciXEyo4gEEknwEWkJ
	D8qhNk2WVQ6UKwCUkqGeP8N5okh4mVD54vU3LMCimgkFWWCTB+Tz+xKSelDu+zEf
	/n3SibYWBcVfsYlZMpjPkzyT+2uDs1yS+ej37fSEZ4pTyzzhKxkLkgxnM2BQdP0G
	inXLMAPIao3YOREou/XlqA/Z5GJ+DPmz56m86mlfyUtRjAgNtQwDh6NRXedlsQ8+
	JCPACnioruwoSiVxje1LbGk5ceyWaIJKmnA4WnwjHEouWk2zfeYYmupktgpcZC+m
	Ahi6e/7KB2KCxV3PQWLcQ==
X-ME-Sender: <xms:qAKNaYfOD5sSLEYtA2DdqygEVvaW_UKbCh7BYwtcmUngy6n-I2h1YQ>
    <xme:qAKNad56LacjqlNQNo0JmVzMMvQ9vq9s0S7oZJKEpoPPhNDS5tD4Jtmjg9HUfq9JX
    7ExVUjskvlnaFqeA3Qbszccb2utXzGn0COYK_bXoK4WE2bAyDukKw>
X-ME-Received: <xmr:qAKNaTUfLBzMONGGaMi3cmM5rfvJ7G5Ab4hTb8na-7MZtNWPFLOwSGj4AkwzY6loDnTmuv3oFGQpBq95jJS_VrceThFliaYYHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhnrghtrghnsehjohhnthgvshdrphgrghgvpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnhhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshht
    vgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qAKNaU5XnEGO1JKe-G2lKNI_kZGLwMoadfRifrmPqqBumQ34wi4avg>
    <xmx:qAKNaWoPX-xiJxxGhKbpn6CvHshyi1EO9uosYITcdQ6-q6yxIi50JQ>
    <xmx:qAKNafnqOr0pLgIuv7uJGjXdi3G4PIuZHW0cp7G49nfctAQfZi_-kA>
    <xmx:qAKNaaM4xhqYKFWxVhhowgVjxx227E8zkyGlz4Ou_y02KcH3U6aO0w>
    <xmx:qAKNaVnmKR7aJoZJwdwq3mS2BJX2W7QWXhmifApjb3G2ncbYgYbo_pIF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 17:28:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: git@vger.kernel.org,  peff@peff.net,  "D . Ben Knoble"
 <benknoble@gmail.com>,  "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 3/3] alias: support non-alphanumeric names via
 subsection syntax
In-Reply-To: <20260211211810.278806-4-jonatan@jontes.page> (Jonatan Holmgren's
	message of "Wed, 11 Feb 2026 22:18:10 +0100")
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
	<20260211211810.278806-1-jonatan@jontes.page>
	<20260211211810.278806-4-jonatan@jontes.page>
Date: Wed, 11 Feb 2026 14:28:54 -0800
Message-ID: <xmqqqzqqrk2h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jonatan Holmgren <jonatan@jontes.page> writes:

>  alias.*::
> +alias.*.command::
> +	Command aliases for the linkgit:git[1] command wrapper. Aliases
> +	can be defined using two syntaxes:
> ++
> +--
> +1. Without a subsection, e.g., `[alias] co = checkout`. The alias
> +   name is limited to ASCII alphanumeric characters and `-`,
> +   and is matched case-insensitively.

OK.  It is obvious to us that the "alias name" in the example is "co";
is it obvious enough for our first-time readers, or would we want to
do something like

	The alias name ("co", in this example) is limited to ...

to be extra clear, I wonder.

> +2. With a subsection, e.g., `[alias "name"] command = value`. The
> +   alias name can contain any characters including UTF-8, and is
> +   matched case-sensitively as raw bytes.

Unlike the previous example that is more realistic, this uses <name>
and <value> placeholders, with `command` that MUST be given verbatim
by the users.  Is that obvious enough to our first-time readers?

Thinking aloud.  How does it look with placeholder filled with
concrete values?

	... e.g., `[alias "co"] command = checkout`.  The alias name
	("co", in this example) can contain any characters ...

This does not look too bad to me.

We do not allow newlines or NULs in the subsection.  NULs may be too
obvious, but newlines might be worth mentioning.  I dunno.

> +--
> ++
> +Examples:
> ++
> +----
> +# Without subsection (ASCII alphanumeric and dash only)
> +[alias]
> +    co = checkout
> +    st = status
> +
> +# With subsection (allows any characters, including UTF-8)
> +[alias "hämta"]
> +    command = fetch
> +[alias "gömma"]
> +    command = stash
> +----

Good examples, even though I do not read Swedish ;-).

> +E.g. after defining `alias.last = cat-file commit HEAD`, the invocation
> +`git last` is equivalent to `git cat-file commit HEAD`.

This is not a new problem (it is an inherited text from before your
change), but I've always found this

	alias.last = cat-file commit HEAD

a poor thing to give to our users, as it does not match anything
they practically can use.  It is different from the valid command
line arguments to define the alias, which is

	$ git config set alias.last "cat-file commit HEAD"

and it is different from the way the result appears in the
configuration file, which is

	[alias] last = cat-file commit HEAD

Also, since the sentences are moved around, I am not sure that the
beginning "E.g." still fits there very well.  Taking them all
together, how about

    With a Git alias defined, e.g.,

	$ git config set alias.last "cat-file commit HEAD"

    you can run `git last` and it invokes `git cat-file commit
    HEAD`.

> diff --git a/alias.c b/alias.c
> index 271acb9bf1..896d0f80a4 100644
> --- a/alias.c
> +++ b/alias.c
> @@ -17,13 +17,33 @@ static int config_alias_cb(const char *key, const char *value,
>  			   const struct config_context *ctx UNUSED, void *d)
>  {
>  	struct config_alias_data *data = d;
> -	const char *p;
> +	const char *subsection, *subkey;
> +	size_t subsection_len;

"subkey" is a confusing name for a variable.

The Synatx section in "git config --help" documentation says that a
configuration file consists of "sections and variables", and a
section can further be divided into subsections.

config.c seems to use "key" as a synonym for "variable" above, and
that is very understandable, because "section.subsection.variable"
or "section.variable" as a whole is what the users and documentation
calls a "configuration variable", and to avoid overloading the two
meanings on the same word "variable", we'd better use a different
name for that last-level thing.

Taken together, in

	[alias] co = checkout
	[alias "ci"] command = commit

it would be the best to call the parts like so:

	section: "alias"
	subsection: "ci"
	key: "co" and "command"

> -	if (!skip_prefix(key, "alias.", &p))
> +	if (parse_config_key(key, "alias", &subsection, &subsection_len,
> +			     &subkey) < 0)
> +		return 0;
> +
> +	/*
> +	 * Two config syntaxes:
> +	 * - alias.name = value   (without subsection, case-insensitive)
> +	 * - [alias "name"]
> +	 *       command = value  (with subsection, case-sensitive)
> +	 */
> +	if (subsection && strcmp(subkey, "command"))
>  		return 0;

OK.  We ignore alias.*.variable where variable is not "command".

>  	if (data->alias) {

When the caller is querying one specific alias ...

> +		int match;
> +
> +		if (subsection)
> +			match = (strlen(data->alias) == subsection_len &&
> +				 !strncmp(data->alias, subsection,
> +					  subsection_len));

... we pick either the one that literally matches the subsection
part (we have already verified that the key is "command"), or ...

> +		else
> +			match = !strcasecmp(data->alias, subkey);

... for a two-level variable, the one that matches variable name
case insensitively.  And when we see hit, ...

> +		if (match) {
>  			FREE_AND_NULL(data->v);
>  			return git_config_string(&data->v,
>  						 key, value);

... we report it to the caller.  Otherwise, when we are listing ...

> @@ -34,7 +54,11 @@ static int config_alias_cb(const char *key, const char *value,
>  		if (!value)
>  			return config_error_nonbool(key);
>  
> -		item = string_list_append(data->list, p);
> +		if (subsection)
> +			item = string_list_append_nodup(data->list,
> +				xmemdupz(subsection, subsection_len));
> +		else
> +			item = string_list_append(data->list, subkey);

... the alias name we create differs between the two- and
three-level names, but otherwise the handling is the same between
the two kinds.

>  		item->util = xstrdup(value);
>  	}

All makes sense.

> diff --git a/help.c b/help.c
> index eccd0c22f8..d7c6011780 100644
> --- a/help.c
> +++ b/help.c
> @@ -21,6 +21,7 @@
>  #include "fsmonitor-ipc.h"
>  #include "repository.h"
>  #include "alias.h"
> +#include "utf8.h"
>  
>  #ifndef NO_CURL
>  #include "git-curl-compat.h" /* For LIBCURL_VERSION only */
> @@ -108,7 +109,7 @@ static void print_command_list(const struct cmdname_help *cmds,
>  
>  	for (i = 0; cmds[i].name; i++) {
>  		if (cmds[i].category & mask) {
> -			size_t len = strlen(cmds[i].name);
> +			size_t len = utf8_strwidth(cmds[i].name);
>  			printf("   %s   ", cmds[i].name);
>  			if (longest > len)
>  				mput_char(' ', longest - len);
> @@ -492,7 +493,7 @@ static void list_all_cmds_help_aliases(int longest)
>  	string_list_sort(&alias_list);
>  
>  	for (i = 0; i < alias_list.nr; i++) {
> -		size_t len = strlen(alias_list.items[i].string);
> +		size_t len = utf8_strwidth(alias_list.items[i].string);
>  		if (longest < len)
>  			longest = len;
>  	}
> @@ -591,8 +592,15 @@ static int git_unknown_cmd_config(const char *var, const char *value,
>  	/* Also use aliases for command lookup */
>  	if (!parse_config_key(var, "alias", &subsection, &subsection_len,
>  			      &key)) {
> -		if (!subsection)
> +		if (subsection) {
> +			/* [alias "name"] command = value */
> +			if (!strcmp(key, "command"))
> +				add_cmdname(&cfg->aliases, subsection,
> +					    subsection_len);
> +		} else {
> +			/* alias.name = value */
>  			add_cmdname(&cfg->aliases, key, strlen(key));
> +		}
>  	}
>  
>  	return 0;

Looks very good.

