Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345F058598B
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972148; cv=none; b=Fb6ZWM6y5UE1C6C4zhs7vACN1rWPARieC3+Aipcsg8fd3jKDUx58BT5vfOD3w9h7rBAKqtEvp81Xn1X0JWw+Jq7P40wVAaVB2wuFcQ19A/kvicqXckg1WXBdpKpWki6iCxDDVx8JBfPPEQrGOMlFf/XpJUmjBIFjFVgjoRQLc/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972148; c=relaxed/simple;
	bh=q6Rf8VOw2PE+4IQwz/JWhUt5uAFURsYUql522650WQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Beg/ubQ9vtzQHP6jngNq/CYxC4fBiyr9p8cx5BS+r8IRrVKczOJ3sagAzB6wpI5H3hbrH0GWM2bunpDaHXS2LSrW7Bccl+AQc1cUkp1gm6CT+1pEGreoRMTgGIh9Es3QyqeUl3ixf1o8AzQhaUfJ/UVY46oXDDGVmcjoekMmuOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QdDOreE3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VvLEU74q; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QdDOreE3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VvLEU74q"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4BB9C1400140;
	Wed,  9 Sep 2026 12:42:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 09 Sep 2026 12:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788972145; x=1789058545; bh=onA+BTQqfK
	3iFD3t+4j98oRJVB+Dl9Xv3SG7UM4ULBA=; b=QdDOreE3iCmsKnO6BUqRpSPxW1
	a7mytyy29a08eUVvCPuyIxABfLVkbAgn/+RNruoiG5ZUJKr0X7TIBd4c1EGdd//i
	3gKkT1+W9VmWFf8SHKZAgnNmLPno3Q3GITuW05wWt+mZx3khAaS2o6SlpXP4fBYP
	+gIZ1j2xQDIT3lyDKUFG87FNYaAG2/g8o6XNrol9rLOHwdT+KWHQa3hNovIzNpUV
	Fz4vlvBL6SQyACV/x8oqfX0nOyTQ/ktA/gbhiokMVZnaq64X113mYTuAUXNQ0+OE
	m67Za1hTvunZ6a2+8ePeXsTjs5hqLyVT7Elr+AjxdKjlBPx+0GqnWO88mrbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788972145; x=1789058545; bh=onA+BTQqfK3iFD3t+4j98oRJVB+Dl9Xv3SG
	7UM4ULBA=; b=VvLEU74qwu3R7K88dwQIBbiB1P2ctOvXUkaVAzzPx3NJFO/F4Br
	2afXk3gPKbsYp9fa/anZug/YVPFIFmmGA8IBijuHoIEV7nYCQXyBrbuGWPy3OmzU
	66IEqOPAurMsrnv/A/eU1BSo9fl1YQYg1GDM8t17fGa+TiIm4NzOgyDFrSfN2Gl3
	SHpEYaeiCYXhcyDSI5bDLWK87GTrWe+v55U650Sfx3s1vkgCZRdsTPYDPRTbh2F3
	b6otDIRk4xDLAuELHM/bEQhje8KoOqSkDjsqgOB3WUF2R2R/14h4ZDn8BUkaob8j
	0I6rNQkdALgkpxECulr9m4x9RzAio4Pp1Fg==
X-ME-Sender: <xms:cYyhakFVnljXXyIi7VUxGBcn0X2uUjnk3thKmWW3iIjdzGHB87_3bg>
    <xme:cYyhasatV4Cva8zyrD1Bq-V0MS7dDLAfBxou1Un6fqZ_UVQv4pkztGq6GUxnwLOks
    SBWZVdUjdICdWhpJ14Ktra6habOYgTxbYexpXxla27vSWelqwTOi0w>
X-ME-Received: <xmr:cYyhakWfieXo7Q2HUEwgFvR5n5j9Mn3XB24DTpZDEjliNhlI5oGEru6XSx6b8Ksj7bwC0_nPgNRLVSSdwt8W2fic5saFz2ZvVlq->
X-ME-Proxy-Cause: dmFkZTGl2knlJmAhjNnWM5oVPMc0qwbXT/SrrUxnTQmnAi0WIJI/HuXaeYvk/yoyUKPXcH
    alAbZjqEXuAXz+iy/aOTk951Y5LMqYSvOuzoKW7EHA21NEUkUKVcFlAQQ4GaebSeVcGz2o
    F0w18ffXoYdKtztfCOllfuYY3gu6qUmic/oGTT14H+Ma0c4IiTqBIXFBJ0TGBz0ukSSkgj
    qLj9Wr0dn9Ba/Yy+qYfR0OC4c4HBiHCpDQhLwklrHBGNcoECufj0oVm+chs7RNOn50U3dZ
    wk1phuFQhSbig0nXVMXlV2oOVeIyUHTQrdbdeJhIeKtKfB43dNbydogWpyUl9kJtNp4GJ9
    QrqrpY5JYDv85e7FEtM3Gsd1gmJ3BGuzpt5bn4IXCDAOXg3moZwlEuOK5EZMcuvgeW4huv
    7GY8BUz/IRVXjocdS7e+s6wudnB/nyyRQOu34dcDl3HEMZvwrTEnpl3U3K69NaWaH1OeVV
    6o4Y2GSQ7bXYYfDwl1yJX/Gdf2LRwfJeURP2HwHZLoQ/SQJjFJ4tvZvXf6RGvun41OwDSy
    gCBztt3OPRMujqn5p40n4g7fpz3ndg+FcsqTFwaPZlECy22nbyP9kmi+wINowkNfLMWUag
    PDg02fFW2u+g+nAq14OCk7bRCzAcXwZvpI5dmItBD/rwnTeTNGwCwDhK2cvA
X-ME-Proxy: <xmx:cYyhainsNX87A9B8xOgnmyS-WyhhnJL-HM9xONWLAnd91RDQbE3iAw>
    <xmx:cYyhavDxLAguowUhmGziimuobm4NC2BJ90OilzVGfGWWT6ZvIk4X1A>
    <xmx:cYyhahiheOZhmBWZEYclZCSKv9KBtaKslU91t3qH5RPH8IKhFntUXw>
    <xmx:cYyhasx3-1Y9jIrvpbmUijcT5xCIdkD0O8d_pytvzNd0gwWg_7PTog>
    <xmx:cYyhahIVTgdgk0LlKCynEuSkQqyjfLuAqJjgqP5oypCdkhK4Fsak5Evf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 12:42:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Andrew Pleeter via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>,  Andrew Pleeter
 <andrewpleeter@gmail.com>
Subject: Re: [PATCH v6] var: support broken-down idents, signing key,
 multiple args, and -z
In-Reply-To: <pull.2388.v6.git.git.1788917076554.gitgitgadget@gmail.com>
	(Andrew Pleeter via GitGitGadget's message of "Wed, 09 Sep 2026
	01:24:36 +0000")
References: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
	<pull.2388.v6.git.git.1788917076554.gitgitgadget@gmail.com>
Date: Wed, 09 Sep 2026 09:42:23 -0700
Message-ID: <xmqq4ifytlzk.fsf@gitster.g>
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
> -    The author of a piece of code.
> +    The author name, email, and date that would be used if you were to
> +    run `git commit` right now.
> +
> +`GIT_AUTHOR_NAME`::
> +    The author name that would be used if you were to run `git commit`
> +    right now.
> +
> +`GIT_AUTHOR_EMAIL`::
> +    The author email that would be used if you were to run `git commit`
> +    right now.
> +
> +`GIT_AUTHOR_DATE`::
> +    The author date and timezone that would be used if you were to run
> +    `git commit` right now.

This is better than the previous iteration, but wastes reader's time
with full of repetitions.  Have you looked at the one suggested in
https://lore.kernel.org/git/xmqqbjaecjxb.fsf@gitster.g/ for example
to present more information in much more concise way?

>  Most path values contain only one value. However, some can contain multiple
> -values, which are separated by newlines, and are listed in order from highest to
> -lowest priority.  Callers should be prepared for any such path value to contain
> -multiple items.
> +values, which are separated by newlines (or NUL bytes if `-z` is given),
> +and are listed in order from highest to lowest priority. When querying
> +multiple variables, an extra newline (or an extra NUL byte if `-z` is
> +given) is printed after the values of a multi-valued variable to mark the
> +end of its list. (Single-variable queries and `git var -l` do not print
> +an extra delimiter). Callers should be prepared for any such path value to
> +contain multiple items.

This makes it clear that the query forms we had before this change
will produce the same output, and that queries asking for more than
one value use a new format, which is good.

However, I am not sure why we want an extra delimiter only after a
multi-valued variable.  Does it mean that the reading script needs
to be aware of which variables are multi-valued and which are not?
It is not clear whether this extra delimiter is present only when a
potentially multi-valued variable actually has multiple values, or if
we will have the extra delimiter even when such a variable happens to
have only a single (or perhaps zero) value.

Especially given that ...

>  Note that paths are printed even if they do not exist, but not if they are
>  disabled by other environment variables.

... some paths may not be printed even when explicitly requested in
the new "give me values of these variables" form, it appears to me
that the extra delimiter, even with the reader's knowledge of which
variables are multi-valued, does not help identify which value
corresponds to which requested variable.  I can accept, to a limited
degree, the argument that a list of 'val' is less work to parse than
a list of 'var=val' simply because you do not have to strip 'var='
from the front.  However, it looks to me that the proposed format
makes the wrong trade-off by making it harder to match a variable to
its value(s).

> diff --git a/builtin/var.c b/builtin/var.c
> index cc3a43cde2..decada1602 100644
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
> +		return xmemdupz(split.name_begin,
> +				split.name_end - split.name_begin);
> +	case IDENT_MAIL:
> +		return xmemdupz(split.mail_begin,
> +				split.mail_end - split.mail_begin);

This is better in that it no longer returns NULL upon an impossible
condition like the previous iteration did.  Even better, we could
protect ourselves against breakage caused by careless updates to
split_ident_line() and git_*_info() functions we rely on by keep the
check but mark BUG(), e.g.,

                case IDENT_NAME:
        +		if (!split.name_begin || !split.name_end)
        +			BUG("split_ident_line() gave NULL names???");
                        return xmemdupz(split.name_begin,
                                        split.name_end - split.name_begin);

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

I gave ".name_begin/.name_end cannot be NULL with the way you call
the other routines" in my previous response as a mere example, while
hoping that you'd do similar due dilligence to other values.  With
the way committer_date() and author_date() are called (below), can
fmt_ident() ever return an ident without datestamp and timezone,
requiring us to fall back on NULL returns like this?  You are not
passing IDENT_NO_DATE flag anywhere, are you?

>  struct git_var {
>  	const char *name;
>  	char *(*read)(int);
> -	int multivalued;
> +	int (*multiread)(struct string_list *);
>  };
> ...
>  int cmd_var(int argc,
>  	    const char **argv,
> -	    const char *prefix UNUSED,
> +	    const char *prefix,
>  	    struct repository *repo UNUSED)
>  {
> +	int list = 0;
> +	int nul_term = 0;
> +	int ret = 0;
> +	int i;
> +	char term;
> +	struct option options[] = {
> +		OPT_BOOL('l', NULL, &list,
> +			 N_("list all variables")),
> +		OPT_BOOL('z', NULL, &nul_term,
> +			 N_("terminate entries with NUL")),
> +		OPT_END(),
> +	};
>  
> +	argc = parse_options(argc, argv, prefix, options,
> +			     var_usage, PARSE_OPT_STOP_AT_NON_OPTION);
>  
> +	if (list) {
> +		if (argc)
> +			usage_with_options(var_usage, options);
> +		repo_config(the_repository, show_config, &nul_term);
> +		list_vars(nul_term);
>  		return 0;
>  	}

OK.  Using "-l" and having named variables are incompatible.

> +
> +	if (!argc)
> +		usage_with_options(var_usage, options);

And not having named variables without "-l" invites the usage
message.  We used to call usage() that exits with 129 and
usage_with_options() does so, too.

>  	repo_config(the_repository, git_default_config, NULL);
>  
> +	term = nul_term ? '\0' : '\n';
>  
> +	for (i = 0; i < argc; i++) {
> +		const struct git_var *git_var = get_git_var(argv[i]);
>  
> +		if (!git_var)
> +			usage_with_options(var_usage, options);
> +
> +		if (git_var->read) {
> +			char *val = git_var->read(IDENT_STRICT);
> +
> +			if (!val) {
> +				if (argc == 1)
> +					return 1;
> +				ret = 1;
> +				printf("%c", term);
> +				continue;
> +			}

So the idea is when there is a single var on the command line,
missing value gives no output and exit(1), but in the new "more than
one variable" mode, we note the fact that we had one failing
variable, emit a line terminator (NUL or LF) to help readers that
expect one "line" per request.

> +			printf("%s%c", val, term);
> +			free(val);
> +		} else if (git_var->multiread) {
> +			struct string_list list = STRING_LIST_INIT_DUP;
> +			size_t j;
> +
> +			if (git_var->multiread(&list) || !list.nr) {
> +				if (argc == 1) {
> +					string_list_clear(&list, 0);
> +					return 1;
> +				}
> +				ret = 1;
> +				printf("%c", term);

The same for variables that may have multiple values when they lack
any value.

> +			} else {
> +				for (j = 0; j < list.nr; j++)
> +					printf("%s%c", list.items[j].string, term);
> +				if (argc > 1)
> +					printf("%c", term);

So this answers the question I had on ambiguous documentation.  A
variable that can have multiple values (including 0 values) will
have N "lines" of N values, plus an empty "line".


> +			}
> +			string_list_clear(&list, 0);
> +		}
> +	}
>  
> +	return ret;
>  }

And we return "ret" that memorizes if we ever had a failure in the
middle.  When there is no failure, we return 0 that is the value
"ret" was initialized with.

If I were designing this, I'd rather (1) get rid of the "empty line"
convention for multi-valued variables, and (2) model multi-variable
mode more after "-l" mode.  IOW, instead of thinking of the case
where the user gave us two variables like two "git var VARIBLE$N"
calls given back to back, thinking it more like "git var -l | grep
-e VARIABLE1= -e VARIABLE2=".

Thanks.

