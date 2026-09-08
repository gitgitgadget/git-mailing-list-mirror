Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBD454EECF
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904405; cv=none; b=Cur95t6Lan7u+o3Hk+lcvCflUL5qTHv03V2R4OsSfvIcHeU+IwOefgCz6D32IZybZ9yRtLXP95B7cbnj8LTP09cnIX3pc4mBaTjCVjgIqi+OM9E7dXy8hMJO1bb3NWcdaCvBtc6Mpd4tD+574WqqZuj2dIL5s/zib+iv3YnQ9f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904405; c=relaxed/simple;
	bh=dgwU9EhGHUdb+wO7glF7w8fR7k8Fhd3r2pja+t5xsKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V1NCtIy99bw+A/iacK1gD0NACMpJtaW27gLQ7YyVO6z0D0jPiTAZjm4yY41UOUJH+o+m2H7smEY5sUEgjiJjd8o3+avQ1QOoHtmlRpa4Du/FCNek5mHZw1V4TbtFQdKut0ISgE8spVpyqlpLUrvHFsAwzUebnjKeynCCJiAgIlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O/vvU0hq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mUH7EAyp; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O/vvU0hq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mUH7EAyp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AC5B3EC00A3;
	Tue,  8 Sep 2026 17:53:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 08 Sep 2026 17:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788904402; x=1788990802; bh=T5OvC2aNVv
	y1zjT0y7dHbzmkvPPuD6tclcbNR6JDN9A=; b=O/vvU0hqd539vSmOO81F/Bjyx9
	oMLQnVcZb3vvGAC+iPSOum11iw7oyS2GoHFOGBIfRKcRXXJ2rdzQRlHIIBlWLXiF
	UMkfc8AqHC6rN8IZRwmzyB+ONnOl5BOfRqqlt1+CHxtW3hChiVLvo3tISOoyMbol
	1J9XMt46+ba3jb7xTKAUy8od4wH1AOvGBVmZGLRseUz4cxZWfDgZWBxK+K/5sGDn
	yZFE3wS7hb1sErtb0JW0TNMTmR674YtGyXIqOh5BEkg4sGFtDNRQDDf5AnDA77oW
	d1lug5ydvZqCKAVk0bOR4OrmJ3UF/jL0p9Pzd7qMHV3Es1qYWxoGYiasnF+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788904402; x=1788990802; bh=T5OvC2aNVvy1zjT0y7dHbzmkvPPuD6tclcb
	NR6JDN9A=; b=mUH7EAyprC7kmxtvY2ixUUihEH94PxuT2bCSARH42rlQv6i2HYm
	/ZMHxv4fQ7qTEiGGVlulY4bqUerZ1//6sOGnPhClV3IujdFDGbshcKrvMkmnF7iE
	0PSPfYTGEpOse2avp/+0MTv0ENeN/0TvkteuljhPw8x4cixUWchJfyXohUez6PUy
	52hHMM9sj4Fe8E7SZRM5MhmuraoLYs1kYun+txvzttsFtZeKiSL9OH+RX7BrGfSw
	+Jv9rSYxQk4+mxV0DlbyoRtSYuMNTVYFtmDQApcSQ9dg7aorZfwvJ5CUQ2aoD/rv
	7xzENaXdY5d0UKCD74pr25Nhg2kvGQlXpuw==
X-ME-Sender: <xms:0oOgaqNLd05HncrPSv11fzA2lYcC7AQ_XOMN3umS1JbwmL15u8bnmw>
    <xme:0oOgaoChbDngD2qfIq-h-Eefl1T-RtNFtCskG4mOBCURDZT8QJ-oMX8G8VVmrnlQh
    BVRR6TeHgFhxX89MoUZaRpeQ5oqG01N_G9DsG59Jg2oRSWWwyMF2sM>
X-ME-Received: <xmr:0oOganeB5oHjpJ3hkYN08ppLR9NyBGWDC_RluNG0LCAxaTsu7j5FjyFlZkxem9V6NDwgygVXBKqVBd7BMgzvWYgvv0zv7ik1em1Q>
X-ME-Proxy-Cause: dmFkZTFrO2+OPAuIIzjOoNxcJY2OIXNvTmXumMKXUklmjdqJ1wHDqseqklSO9Z9LbcGzOa
    U6IIKjik02CDbdmhLPxQ9rwLzVPBju85N+wxslI4tpR/SG93Y6KRzA6hRIWZvvRClN3FG4
    /AnUZr5+VcFnxoCbwAbqs5LVVfapd2ib96PM+pxgsRTOnxOeuuRuXubZHYOfg5e0K1yxup
    oLoQro6eVkOA6ahoyGPp2Bl60oSZAGw/cUZtXb10I4SW4FxOphEo3YQBd2B1CThzaBfhfC
    KgkyQ6dtW8J6EnqkqwJe59hZP9yb5qerEOA4WEDfxwqyuam1sYt85EDfluvtTbofob+pMr
    qMM1+nAGfOC8svXZczfXcaEWYMrLVIfKvtl8o9ZHHyXqZNGwps+V3W742GQJZggWTCCuF1
    66D71uyTUGDLBM9P+QqrmJAwxczIqiCJsSjCsBRvBTwJ1esvYwx6xGxG17KyY+bmfmN6uc
    0UCXdGQ4TJzvZTbk/HNOVwQHInJBLjuU4WgygAyWwGHZOuGftlErkaBwFRTyOfl2irYJzz
    gBTmJopF8CSQUR+rbZW+b3tlGiWV6kwSQljUbVDk+0T0ZeKT14pIFUGyrfbk6TKwWRCVAz
    HVSDvbRkEROEue1IkIJ33jRo0qeoRvk/kOPIgt2qa4AYg5cPKHVktLODlR/Q
X-ME-Proxy: <xmx:0oOganMnE2jH6kdkFfOBO-d7hR5y7elNKoQ_fH5uBi5wlmqmlWYwxg>
    <xmx:0oOganKs28X8FVyFdJKmcrXD1L7Hoe2l6rN0pkUWrPKpVt3aSIvIrQ>
    <xmx:0oOganLWRlGpamVjprzK7god6UvF3OpFrXijLAY5LKd7WsvI1KYeQQ>
    <xmx:0oOgah4Lr0_aLHKcdbNvGzBBB4FrrrgNSH5oVn7G641EJpOq0pzimg>
    <xmx:0oOgapSK0tkeRbUxKp2PI6o_xL_75GGFrrtKDHNHkxveqkpB7agreokH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 17:53:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Andrew Pleeter via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>,  Andrew Pleeter
 <andrewpleeter@gmail.com>
Subject: Re: [PATCH v5] var: support broken-down idents, signing key,
 multiple args, and -z
In-Reply-To: <pull.2388.v5.git.git.1788900182711.gitgitgadget@gmail.com>
	(Andrew Pleeter via GitGitGadget's message of "Tue, 08 Sep 2026
	20:43:02 +0000")
References: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
	<pull.2388.v5.git.git.1788900182711.gitgitgadget@gmail.com>
Date: Tue, 08 Sep 2026 14:53:20 -0700
Message-ID: <xmqqpkyntnov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andrew Pleeter via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  VARIABLES
>  ---------
>  `GIT_AUTHOR_IDENT`::
> +    The author.
> +
> +`GIT_AUTHOR_NAME`::
> +    The name of the author.
> +
> +`GIT_AUTHOR_EMAIL`::
> +    The email of the author.
> +
> +`GIT_AUTHOR_DATE`::
> +    The date and timezone of the author.

The above (and the COMMITTER counterparts) gives almost no useful
information.  On the other hand, the description used here ...

> +`GIT_SIGNING_KEY`::
> +    The key that would be used to sign the resulting commit if you were
> +    to run `git commit` right now.

... explains what significance this key has much better.

> @@ -85,9 +127,12 @@ endif::git-default-pager[]
>      The path to the global (per-user) configuration files, if any.
>  
>  Most path values contain only one value. However, some can contain multiple
> -values, which are separated by newlines, and are listed in order from highest to
> -lowest priority.  Callers should be prepared for any such path value to contain
> -multiple items.
> +values, which are separated by newlines (or NUL bytes if `-z` is given),
> +and are listed in order from highest to lowest priority. When querying
> +multiple variables, an extra newline (or an extra NUL byte if `-z` is
> +given) is printed after the values of a multi-valued variable to mark the
> +end of its list. Callers should be prepared for any such path value to
> +contain multiple items.

Hmph.  The added bulk of this description is only because we can now
optionally use NUL delimiting as opposed to LF?  Are we changing the
output in a backward incompatible way for callers that do not pass
the -z option?

For example, "git var -l" output ends like so for me in today's Git:

    $ git var -l | tail -n 3
    GIT_CONFIG_SYSTEM=/home/gitster/g/seen/etc/gitconfig
    GIT_CONFIG_GLOBAL=/home/gitster/.config/git/config
    GIT_CONFIG_GLOBAL=/home/gitster/.gitconfig

    $ git var GIT_CONFIG_GLOBAL
    /home/gitster/.config/git/config
    /home/gitster/.gitconfig

You mention "an extra newline".  Will it appear in the above output
with this version?  If so, wouldn't that be a breaking change?

> +static char *ident_part(const char *ident, enum ident_part part)
> +{
> +	struct ident_split split;
> +
> +	if (!ident)
> +		return NULL;
> +	if (split_ident_line(&split, ident, strlen(ident)))
> +		return NULL;
> +
> +	switch (part) {
> +	case IDENT_NAME:
> +		if (!split.name_begin || !split.name_end)
> +			return NULL;
> +		return xmemdupz(split.name_begin,
> +				split.name_end - split.name_begin);
> +	case IDENT_MAIL:
> +		if (!split.mail_begin || !split.mail_end)
> +			return NULL;
> +		return xmemdupz(split.mail_begin,
> +				split.mail_end - split.mail_begin);
> +	case IDENT_DATE:
> +		if (!split.date_begin)
> +			return NULL;
> +		if (split.tz_end)
> +			return xmemdupz(split.date_begin,
> +					split.tz_end -
> +					split.date_begin);
> +		if (split.date_end)
> +			return xmemdupz(split.date_begin,
> +					split.date_end -
> +					split.date_begin);
> +		return NULL;
> +	default:
> +		return NULL;
> +	}
> +}

In many cases in the above you punt and return NULL, but aren't
there some cases where it clearly is a data error that deserves
die() or a programming error that deserves BUG()?

For example, my quick read of split_ident_line() tells me that it is
impossible for split.name_begin or split.name_end to be NULL if the
function signals success by returning 0.  If I am not misreading the
code, returning NULL when IDENT_NAME is requested in the above code
is sweeping a programming error under the rug.

If the caller passed anything other than IDENT_{NAME,MAIL,DATE}, it
similarly is a programming error.  The default: arm should not hide
it underr the rug by returning NULL, but complain loudly with a
BUG(), no?

> @@ -99,19 +190,21 @@ static char *git_config_val_global(int ident_flag UNUSED)
>  	git_global_config_paths(&user, &xdg);
>  	if (xdg && *xdg) {
>  		normalize_path_copy(xdg, xdg);
> -		strbuf_addf(&buf, "%s\n", xdg);
> +		strbuf_addstr(&buf, xdg);
> +		strbuf_addch(&buf, '\0');
>  	}
>  	if (user && *user) {
>  		normalize_path_copy(user, user);
> -		strbuf_addf(&buf, "%s\n", user);
> +		strbuf_addstr(&buf, user);
> +		strbuf_addch(&buf, '\0');
>  	}

Mental note: we used to use LF at the end, but in this version we
add NUL here.

>  	free(xdg);
>  	free(user);
> -	strbuf_trim_trailing_newline(&buf);
> -	if (buf.len == 0) {
> +	if (!buf.len) {
>  		strbuf_release(&buf);
>  		return NULL;
>  	}
> +	strbuf_addch(&buf, '\0');

And then we add an extra NUL after that.

>  	return strbuf_detach(&buf, &unused);
>  }

> @@ -172,34 +293,35 @@ static struct git_var git_vars[] = {
>  	},
>  };
>  
> -static void list_vars(void)
> +static void list_vars(int nul_term)
>  {
>  	struct git_var *ptr;
> -	char *val;
> -
> -	for (ptr = git_vars; ptr->read; ptr++)
> -		if ((val = ptr->read(0))) {
> -			if (ptr->multivalued && *val) {
> -				struct string_list list = STRING_LIST_INIT_DUP;
> -
> -				string_list_split(&list, val, "\n", -1);
> -				for (size_t i = 0; i < list.nr; i++)
> -					printf("%s=%s\n", ptr->name, list.items[i].string);
> -				string_list_clear(&list, 0);

We used to split at LF (because we used to concatenate with LF in
the git_config_val_globa() that grabs potentially multiple values)
and then showed them one by one.

> -			} else {
> -				printf("%s=%s\n", ptr->name, val);
> -			}
> -			free(val);
> +	char delim = nul_term ? '\n' : '=';
> +	char term = nul_term ? '\0' : '\n';
> +
> +	for (ptr = git_vars; ptr->read; ptr++) {
> +		char *val = ptr->read(0);
> +
> +		if (!val)
> +			continue;
> +
> +		if (ptr->multivalued) {
> +			for (const char *s = val; *s; s += strlen(s) + 1)
> +				printf("%s%c%s%c", ptr->name, delim, s, term);

Now we use each string pieces (s), skip the string we just showed by
advancing the pointer by strlen(s) + 1.  If multi-valued variable
has ever an empty string as one of the possible values, this scheme
would break down, but right now GIT_CONFIG_GLOBAL is the only thing
that is .multivalued, and neither the HOME or XDG path is likely to
be ever empty, so this may be OK, perhaps?  If xdg is defined to be
a non-empty string (i.e., "if (xdg && *xdg)" is taken) but if
calling normalize_path_copy(xdg, xdg) makes it an empty string, then
git_config_val_global() will give "\0/home/gitster/.gitconfig\0\0"
for me (the first NUL is after the empty xdg value, the second NUL
is terminating HOME value, and the third NUL concludes the whole
thing), and then this loop will exit without showing anything (not
just skipping an empty XDG, but hiding perfectly healthy HOME
value).  Is that a concern?

I wonder if we should correct how .multivalued field is handled
before we add more of them.  For example, .multivalued = 1 item
may use something different from .read that uses a string-list
to carry the information

	{
		.name = "GIT_CONFIG_GLOBAL",
		.multiread = git_config_val_global,
	},

	static int git_config_val_global(struct string_list *list)
	{
		git_global_config_paths(...);
		if (xdg available)
			string_list_append(list, xdg);
		if (user availble)
			string_list_append(list, user);
		return 0;
	}
	
and then the above part of the code would look more like

	for (ptr = git_vars; ptr->read || ptr->multiread; ptr++) {

		if (ptr->read) {
			... single read as before ...
		} else (ptr->multiread) {
			struct string_list list = STRING_LIST_INIT;

			ptr->multiread(&list);
			for (size_t i = 0; i < list.nr; i++)
				... use list.items[i].string ...
		}

	}

>  static const struct git_var *get_git_var(const char *var)
>  {
>  	struct git_var *ptr;
> +
>  	for (ptr = git_vars; ptr->read; ptr++) {
> -		if (strcmp(var, ptr->name) == 0) {
> +		if (!strcmp(var, ptr->name))
>  			return ptr;
> -		}
>  	}
>  	return NULL;
>  }

An unrelated change like this is distracting and makes it less
likely for your patch to succeed.  Leave such a clean-up out of a
patch that is about a new feature, or fixing a bug.
