Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D0B1DFFD
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770752848; cv=none; b=G1qT+ObMBKqfSsT+qu9h8Va3iTpyoGaJayW6UUnZK3+01sAPxp3ygCbrZlm8NxkKLDMFABcTlOEGdchTR/TLFfpLPTpdFwF73BCnyYNh6NoT9ef9eli/+S7803g9KDD740eqYUrPCt35zYVOyA09OjLj6Sv3P0eL6rWhjYxal3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770752848; c=relaxed/simple;
	bh=losM+4nfAqsauBCkl8GxNRKzUL/NmmVxaVrzpU6iq90=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cwi2P5IVxrttwl46ffu7rZ0uiUfdffAfxHXdCr7BDxbNuXPqCUmoYuoqzSYkJNsLhwO8EBWv1BTDoBuEVkx2yMWMdL0TcmsT4E2a/qEa9t4Rgsqit2K9RASEOL1RbcF/HU2L9VD50MlJbXzXZ6mD90qjofo9PuxhelV97gYAdLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZSolP+aO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cVpcUBLH; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZSolP+aO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cVpcUBLH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D81897A00E8;
	Tue, 10 Feb 2026 14:47:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 10 Feb 2026 14:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770752845;
	 x=1770839245; bh=kJOvfUkT18EpwDKFJg3tAx9clcSVVsH6pda67Ex+NTw=; b=
	ZSolP+aOxdE+rzjjBmBElaviR5wLGuB3wVC6gvnctt7PDqedQ02mBnOaX44QckQ4
	QLL/EloXtF6ysxKULb0udtz7OcyOU6OiEEZfuKYXb76n8dQQyLYOYYWCkhd75SXk
	WU88icveVbRllbUD4DtiRch//L3BYp/h5p+HMuspyDdIR7/l0p4lx/a6MA8tHvZH
	G0Ch1+CA4zQXZRaR4tdstgTmXJvKx93Vlxj83AAiBP7n2X8XPo+TiQ/GS7kd7GqO
	tTceqSThZPZpF0Wv/asK3xzCAo4b7dE17Ns2GT0c+du76F8kNSRk80CxzBwLm9+k
	7Nv7CdWtuXPvAGtieL9OmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770752845; x=
	1770839245; bh=kJOvfUkT18EpwDKFJg3tAx9clcSVVsH6pda67Ex+NTw=; b=c
	VpcUBLHGyxmHLrHRc6rdRKT7xe3WdxVCxnRXvKAz2SGLmPkzaDjDJ+ORQTnd3qri
	rE6Sw5mtdLDY+v5GYz1ZBxXo4f/gDZ7OKxK8uQMGr0FT0kzlMkyySba7277e5TP0
	es0B+u+ClNCkARH4q0Smjr+q3lRfZbaxdxO2MiAnHgQ192Cbo8+0BWJH/usMcXFm
	0QQHsSk6UUi6TQdFiLpfPq3Apn00P9gO+BJiNdQRJMtW0xOISjq0sQX5CAcaC9my
	QIHpY4S64OXrjpB0frIreqJWQZBI+731n39OlsBDqsqtvhVzKqb0zdO+uEzIOqlA
	agtpvk2SV2oapZrlMngAw==
X-ME-Sender: <xms:TYuLaVBUuLt2WpmNYwGgodPLmZ_Xsl80UCR7touvb6YNYj6Zq6PUmg>
    <xme:TYuLaXMHbZpURKnUUTsd5Gtt7Jh_-WQKcUIBbbNRS_Eqmc4_5O9-IPaNQZwTiU77M
    nYD2Fk4CdffbeoXKpvegX31oxDfUdSfCMUmZp6phKDNtT-puEaqiw>
X-ME-Received: <xmr:TYuLaabY5JXarfFDnQ8ZZdI9RdpLjpzvnASdtOv93swhTFwCLaUbMhbGtwoGLk6JRRhDQLwpXCYFO3iLpcjFhb09ZWb2qLsHBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtheehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:TYuLaWvSCv7VGfAJ-99fh4GWs3a2COgPzgjgg-QGvnSWTJqAqvsmhg>
    <xmx:TYuLacOIwQ5V5zVmegmhE22-u9L5oNAXKAvNo-xHJOimJwyu-HGu-g>
    <xmx:TYuLad6LOubIjLmfKpI2EPCLELhd5lIle5AZECHAn9Ik3hehRA6Cvg>
    <xmx:TYuLaSR4RyMQmo-PtQC0HX5d9hw0xY-uhZ_Z-gR3UDhIn1cZQdBsIg>
    <xmx:TYuLaX_ZFlTruXMBR_7T8dDISixf3rdmjLg2JWnSTozogMyaAQaMMgF4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 14:47:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: git@vger.kernel.org,  peff@peff.net,  "D . Ben Knoble"
 <benknoble@gmail.com>,  "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/2] alias: support non-alphanumeric names via
 subsection syntax
In-Reply-To: <20260210183110.1151072-3-jonatan@jontes.page> (Jonatan
	Holmgren's message of "Tue, 10 Feb 2026 19:31:10 +0100")
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
	<20260210183110.1151072-1-jonatan@jontes.page>
	<20260210183110.1151072-3-jonatan@jontes.page>
Date: Tue, 10 Feb 2026 11:47:23 -0800
Message-ID: <xmqqv7g4xtx0.fsf@gitster.g>
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

> Git alias names are limited to alphanumeric characters and dashes
> because config variable names are validated by iskeychar(). This

"ASCII alphanumeric", perhaps, as accented alphabet characters are
still alphanumeric ;-).  "because aliases are implemented as config
variable names" is probably an explanation that talks to readers in
terms closer to them (iskeychar() function is an implementation detail).

> prevents non-English speakers from creating aliases in their native
> languages.

True.

> Add support for arbitrary alias names by using config subsections:
>
>     [alias "förgrena"]
>         command = branch
>
> The subsection name is matched as-is (case-sensitive byte comparison),
> while the existing definition without a subsection (e.g.,
> "[alias] co = checkout") remains case-insensitive for backward
> compatibility. This uses existing config infrastructure since
> subsections already support arbitrary bytes, and avoids introducing
> Unicode normalization.
>
> Also teach the help subsystem about the new syntax so that "git help
> -a" properly lists subsection aliases and the autocorrect feature can
> suggest them. Use utf8_strwidth() instead of strlen() for column
> alignment so that non-alphanumeric alias names display correctly.

Either move the last two hunks from [1/2] to this step, or make it a
separate patch [1.5/2] between this and the other steps, and explain
it as a change that breaks compatibility in a way that hopefully
would not affect anybody in practice.  The alias configuration
parser used to be overly loose and took "alias.<subsection>.<key>"
as defining an alias "<subsection>.<key>"; that change tightens the
parser and alias.<subsection>.<key> are silently ignored.  This step
then take alias.<subsection>.command to be defining a new-style
alias that can be invoked as "<subsection>", which is case sensitive
and is not limited to ASCII alphanumeric and dashes.

> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
> ---
>  Documentation/config/alias.adoc | 44 +++++++++++++++++++++-----
>  alias.c                         | 45 ++++++++++++++++++++++-----
>  help.c                          | 12 +++++--
>  t/t0014-alias.sh                | 55 +++++++++++++++++++++++++++++++++
>  4 files changed, 137 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/config/alias.adoc b/Documentation/config/alias.adoc
> index 80ce17d2de..17a548cd64 100644
> --- a/Documentation/config/alias.adoc
> +++ b/Documentation/config/alias.adoc
> @@ -1,12 +1,40 @@
>  alias.*::
> +alias.*.command::
> +	Command aliases for the linkgit:git[1] command wrapper. Aliases
> +	can be defined using two syntaxes:
> ++
> +--
> +1. Without a subsection, e.g., `[alias] co = checkout`. The alias
> +   name is limited to alphanumeric characters and `-` (the same
> +   limitation as configuration variable names), and is matched
> +   case-insensitively.
> +2. With a subsection, e.g., `[alias "name"] command = value`. The
> +   alias name can contain any characters including UTF-8, and is
> +   matched case-sensitively as raw bytes.
> +--
> ++
> +Examples:
> ++
> +----
> +# Without subsection
> +[alias]
> +    co = checkout
> +    st = status
> +
> +# With subsection (allows UTF-8 and special characters)
> +[alias "hämta"]
> +    command = fetch
> +[alias "gömma"]
> +    command = stash
> +----
> ++
> +E.g. after defining `alias.last = cat-file commit HEAD`, the invocation
> +`git last` is equivalent to `git cat-file commit HEAD`. To avoid
> +confusion and troubles with script usage, aliases that
> +hide existing Git commands are ignored except for deprecated
> +commands.  Arguments are split by
> +spaces, the usual shell quoting and escaping are supported.
> +A quote pair or a backslash can be used to quote them.
>  +
>  Note that the first word of an alias does not necessarily have to be a
>  command. It can be a command-line option that will be passed into the
> diff --git a/alias.c b/alias.c
> index c66a6095bb..cfd313ce5d 100644
> --- a/alias.c
> +++ b/alias.c
> @@ -17,21 +17,50 @@ static int config_alias_cb(const char *key, const char *value,
>  			   const struct config_context *ctx UNUSED, void *d)
>  {
>  	struct config_alias_data *data = d;
> -	const char *p;
> +	const char *subsection, *subkey;
> +	size_t subsection_len;
>  
> -	if (!skip_prefix(key, "alias.", &p))
> +	if (parse_config_key(key, "alias", &subsection, &subsection_len,
> +			     &subkey) < 0)
>  		return 0;
>  
> +	/*
> +	 * Two config syntaxes:
> +	 * - alias.name = value        (without subsection, case-insensitive)
> +	 * - [alias "name"]
> +	 *       command = value       (with subsection, case-sensitive)
> +	 */
> +	if (subsection) {
> +		if (strcmp(subkey, "command"))
> +			return 0;

This silently ignores

	[alias "foo"]
		bar = !date

which may or may not be a feature.  If the variable name is "help"
instead of "bar", it certainly is a feature to silently skip it, as
it is not inconceivable that we would add such a variable name in
the future, and because we won't be able to predict the future, not
limiting us to "help" but ignoring anything we do not understand
like this code does may probably be a good thing.  I dunno.

> +	}
> +
>  	if (data->alias) {
> -		if (!strcasecmp(p, data->alias)) {
> +		int match;
> +
> +		if (subsection)
> +			match = (strlen(data->alias) == subsection_len &&
> +				 !strncmp(data->alias, subsection,
> +					  subsection_len));
> +		else
> +			match = !strcasecmp(data->alias, subkey);
> +
> +		if (match) {
>  			FREE_AND_NULL(data->v);
> -			return git_config_string(&data->v,
> -						 key, value);
> +			return git_config_string(&data->v, key, value);
>  		}
>  	} else if (data->list) {
> -		if (value)
> -			string_list_append(data->list, p)->util =
> -				xstrdup(value);
> +		struct string_list_item *item;
> +
> +		if (!value)
> +			return 0;
> +
> +		if (subsection)
> +			item = string_list_append_nodup(data->list,
> +				xmemdupz(subsection, subsection_len));
> +		else
> +			item = string_list_append(data->list, subkey);
> +		item->util = xstrdup(value);

This still silently ignores

	[alias "foo"]
		command

which is a much more grave problem than ignoring alias.foo.bar in
the earlier part of this function.  We would want to preserve the
existing diagnosis on broken configuration.

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
> @@ -590,8 +591,13 @@ static int git_unknown_cmd_config(const char *var, const char *value,
>  
>  	/* Also use aliases for command lookup */
>  	if (!parse_config_key(var, "alias", &subsection, &subsection_len, &key)) {
> -		if (!subsection)
> +		if (subsection) {
> +			if (!strcmp(key, "command"))
> +				add_cmdname(&cfg->aliases, subsection,
> +					    subsection_len);
> +		} else {
>  			add_cmdname(&cfg->aliases, key, strlen(key));
> +		}
>  	}

OK.  Alternatively, out of

	[alias "foo"]
		command = !echo foo
		bar = !echo bar

we _could_ list "foo" (a new style alias) and "foo.bar" (an old
style alias that we have been accepting forever by mistake) for
maximum backward compatibility.  I am still undecided if it is a
good idea.

Thanks.
