Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0042143901F
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457256; cv=none; b=HooawBbbI3AK9Pvl1IuzLzpFF5+Al4W/4aQ3jcqaiGyR+gwXHjYHYlD1ObrSTtRApkN6q4EGi5JQDH2bqsjraDHCWEU3IhPw2T4H67gavyF/W1ZMXjmkf1tqPWSXuCgW+DXVQH0hlJhVZtqRxWhxPK/5hc8D+QcjUqPyfNOolVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457256; c=relaxed/simple;
	bh=PzxEjhd9/Nf7W20qvRznvYeIe5KQxON7uNZys8NGRmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j2PbiVOSH+lKapl7expVBPqxupSsNP9zrRCF1fYRz0luyEsV1kstOqm+VaJzeXA+89B9iO1iVFyx2pBkUXqd8tdHcFqoAAymjbMxPYxhhwksumOU8YBsIunxZW7fEskAJ4621vgt4CrLYbaotD/HpDmQY26t9N5nscdtp/03OfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XB0ers9P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gi3innkY; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XB0ers9P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gi3innkY"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 584C87A0179;
	Thu,  3 Sep 2026 13:40:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 03 Sep 2026 13:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788457252; x=1788543652; bh=sBu1wQnbCs
	MNbKA91BhbE1RGSs7sO0R2q+qsx7tL+4M=; b=XB0ers9PRE5y5b6twOS9WHLwwc
	lKGVWY+UTDjOSFwqDqnb/IbFi4Gb9UeYdcQcCZTUY0VAg3RukaAX1s2ID/z97hGR
	lqr3HUuacEP0MG80ZEV50L2inO6Ag8ny8GXrZdSabNYNZ3JJVz6gpV3q5KaeXgV4
	p9IWx91jZLUAboq1P2dbkYT3haeiUn/zcwUyj5zWpdRi0+tiMfGQOnPI7GNE6Coc
	DTY3Auwj5cyz4P8FpSj6xVHdQ1oV7T0HHu0X+mwq2/zSCOl8JTeILFjR9VATPWSN
	IFrAk2cT7IkC9wllNa9Olt+NpuCoKyJVN3uzEs5U0juO0yAINu+yEl0sKZpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788457252; x=1788543652; bh=sBu1wQnbCsMNbKA91BhbE1RGSs7sO0R2q+q
	sx7tL+4M=; b=gi3innkYsoRCqIOskzOf8hW1PWkvMw2B1VBfmeKUlw/roFIlsh6
	+SuZ0vz3+hkZ86CBGkYV3tkUkFXF4D5RfnDDcnazB6lv66Pl64BjBXIV0rn6U3ss
	j+mS2lsyF/A0eHtKi21KsZViPkBL+cCi6+HlT//SmOX554bgOorPwkfRBPk4u12Y
	uO+GvX+XY1bkMiIrDlL5har8mnkPipOFdgpOepWZn7Bd6zOiMkdGOzz1WHkBYgHH
	d/iT0dznq6ujN5uryBwTUGTruT/AHiivGXUeycFzVD0Aw0HdkjFYvLkk0B2VCp8j
	z+4bNRI5c8KOSrB4PGpuwPeTkS6kh1EXDKQ==
X-ME-Sender: <xms:I7GZamj6CyeEmCTUa8AJlfW3USop3P2W3r5xifwkVvL_GO5HZVv4XQ>
    <xme:I7GZaqtPZGLrWuJLW7HAmt8q-6CrbiFx-ePdDpR79ruBftNk-dtyGYPEaYAEmo18s
    HJ6kMDA0HCoMVkCoLax5N_ZoqBk8nmWBov-Bzr3ezyp29kAQ1xytg>
X-ME-Received: <xmr:I7GZan7osAjx5QoSZLveiMQ_9GOKt0TonbbdNrjcf5eVS3UgrMEEGS5buYW6N4h1zMsLLYkNgIS-seW0MziEweHo7NXnPPWVcA>
X-ME-Proxy-Cause: dmFkZTF9yL5bUa2beVxmhF5DWCjnuIc2jcGh1ZMO6GG0LXZuHhk/Z7hetc/kqJGIImRWaB
    w93wVYg61Jwi/l4eWS1c9hAvE3zBt/ISihoSWtPaviVaU8B28pJNIuT6AKIAveN30bwrAP
    Fi4RG5TBybCv9jsUkR+ep2/7QPVpkipj/syw9G3AeGiYn9DexUyDjAk+VzVTjo0SMhB3bb
    0n2QycL01MqTchMahkgyuyCw1BbGAhRRnr48mp/geY1j2FBdo2mR/hoB72bvqp0dkW8MZN
    T4DBpdby39AD0rn7fDAOiPOBK3jDwjnXvMhzTsFBFFteLWRe1dx3LqVeNlFIXDth3ekXPK
    l0S3/7Vo08LSu98VVWGyMmAqW3C1xIOJ2XgFNj8kbfxigRHxmt90A1aq8UMVuJxTK4Mf0+
    i+hWqZNsMwPP4P1rLzmgv3JeqYORHr/zPh089vxFaUrdko8zb1Vjc8lWPDi8onKA1wFuoz
    eihNbJL32i0CpF9zKx3YdgAhF3aEnrYZaNKKlRkZ3oSUO6wpx2Y42+L/CDvBYNRn5rCZUa
    huvPZYLDC4lG6A2smpc3d5hfcaeqzw4nsi+WWWq10lpxBn1QV/zzSlykjnpobfraOq3xve
    wOuhajwILi9Q1TvQFQGvrj0psmSayWAhUUwJOZ5LiO/d1p2NfQcl324Gexkw
X-ME-Proxy: <xmx:I7GZamOhSSAgOYcOZpQSTvUmIN4_gGwIExfg4IqQN7j50Kqhv6i2Yw>
    <xmx:I7GZalt4Eu7KetZRlA2LlTSCy4rYGeNaTOIxpU_pCPCqa0NRaAXThw>
    <xmx:I7GZapYfE2Nv5pSm6gOj784h5NWuBELzx3BQpO6q4O90qPaR9CD2WA>
    <xmx:I7GZanyt1Z1Mp4dj9sZkTaEwIccpZR-9t-EMQqvSL-txupBxLzWbcA>
    <xmx:JLGZamzqpA3rer3tJW14kfdfUdU8EMRR3IgnxtdHQfun2fPSUewaN7I3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 13:40:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Andrew Pleeter via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>,  Andrew Pleeter <andrewpleeter@gmail.com>
Subject: Re: [PATCH v3] var: support broken-down idents, default key,
 multiple args, and -z
In-Reply-To: <pull.2388.v3.git.git.1788403792962.gitgitgadget@gmail.com>
	(Andrew Pleeter via GitGitGadget's message of "Thu, 03 Sep 2026
	02:49:52 +0000")
References: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
	<pull.2388.v3.git.git.1788403792962.gitgitgadget@gmail.com>
Date: Thu, 03 Sep 2026 10:40:48 -0700
Message-ID: <xmqqbjaecjxb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andrew Pleeter via GitGitGadget" <gitgitgadget@gmail.com> writes:

> - Allow passing multiple variable arguments (e.g., 'git var
>   GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL') to output each variable
>   sequentially.

Yes.  This would be really useful if anybody wants to make it a
component in serious scripting.

>  Documentation/git-var.adoc |  43 ++++++++-
>  builtin/var.c              | 189 ++++++++++++++++++++++++++++++++-----
>  t/t0007-git-var.sh         |  77 +++++++++++++++
>  3 files changed, 284 insertions(+), 25 deletions(-)
>
> diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
> index 697c10aded..30bf2c12a8 100644
> --- a/Documentation/git-var.adoc
> +++ b/Documentation/git-var.adoc
> @@ -9,7 +9,7 @@ git-var - Show a Git logical variable
>  SYNOPSIS
>  --------
>  [synopsis]
> -git var (-l | <variable>)
> +git var (-l [-z] | [-z] <variable>...)

It might make sense to split the two vastly different modes of
operation into separate lines in the synopsis, i.e.,

    git var [-z] -l
    git var [-z] <variable>...

>  VARIABLES
>  ---------
>  `GIT_AUTHOR_IDENT`::
>      The author of a piece of code.

This shows that " of a piece of code" was inherited from the
original, and while it is not your fault, the phrasing is awkward
and misleading.  When a user runs:

    $ git var GIT_AUTHOR_DATE

the command does not look at any particular piece of code or report
when it was written.  We are better off without " of a piece of
code" in this entry (unless we can replace it with something better)
and in all the other new entries.

> +`GIT_AUTHOR_NAME`::
> +    The name of the author of a piece of code.
> +
> +`GIT_AUTHOR_EMAIL`::
> +    The email of the author of a piece of code.
> +
> +`GIT_AUTHOR_DATE`::
> +    The date and timezone of the author of a piece of code.

So let's discuss what we can replace "of a piece of code" with.

The original motivation for GIT_AUTHOR_IDENT (and similarly
GIT_COMMITTER_IDENT) was to give scripts a way to construct a
string that they can pass to 'git hash-object -t commit' to create a
commit object.  GIT_AUTHOR_IDENT is what would appear on the
"author" line (and GIT_COMMITTER_IDENT on the "committer" line) in
the resulting commit object if you were to run 'git commit' right
now.  IDENT has a clear meaning (given above); the other three are
individual fields broken out of it.

Explaining these four (IDENT, NAME, EMAIL, DATE) along those lines
would make it easier for readers to understand.

Here is my attempt:

    GIT_AUTHOR_IDENT::
    GIT_AUTHOR_NAME::
    GIT_AUTHOR_EMAIL::
    GIT_AUTHOR_DATE::
        The authorship information that would be recorded in the
        resulting commit object if you ran 'git commit' right now.
        GIT_AUTHOR_IDENT consists of the author's name, e-mail
        address, and timestamp+timezone.  These three pieces of
        information are available separately as GIT_AUTHOR_NAME,
        GIT_AUTHOR_EMAIL, and GIT_AUTHOR_DATE.

Similarly for GIT_COMMITTER_*.


> +`GIT_DEFAULT_KEY`::
> +    The default commit signing key ID or fingerprint, if configured or enabled.

In the same spirit as the explanation of 'GIT_AUTHOR_IDENT' above,
we could describe this as "the key that would be used to sign the
resulting commit if you were to run 'git commit' right now".  I
wonder if that is easier to reason about.

Yes, I am suggesting moving away from using "DEFAULT" in the name.

> +static char *ident_part(const char *ident, char part)

Use an enum instead of 'char part', unless you derive that single
character directly from end-user input.

> +{
> +	struct ident_split split;
> +
> +	if (!ident)
> +		return NULL;
> +	if (split_ident_line(&split, ident, strlen(ident)))
> +		return NULL;
> +
> +	switch (part) {
> +	case 'n':
> +		if (!split.name_begin || !split.name_end)
> +			return NULL;
> +		return xmemdupz(split.name_begin, split.name_end - split.name_begin);
> +	case 'e':
> +		if (!split.mail_begin || !split.mail_end)
> +			return NULL;
> +		return xmemdupz(split.mail_begin, split.mail_end - split.mail_begin);
> +	case 'd':
> +		if (!split.date_begin)
> +			return NULL;
> +		if (split.tz_end)
> +			return xmemdupz(split.date_begin, split.tz_end - split.date_begin);
> +		if (split.date_end)
> +			return xmemdupz(split.date_begin, split.date_end - split.date_begin);
> +		return NULL;

The line is getting overly long.  Aim to wrap at around ~70 columns.

> +	default:
> +		return NULL;
> +	}
> +}

> +static char *default_key(int ident_flag UNUSED)
> +{
> +	int gpgsign = 0;
> +	char *signing_key = NULL;
> +
> +	if (repo_config_get_string(the_repository, "user.signingkey", &signing_key) == 0 && signing_key && *signing_key)
> +		return signing_key;

An overly long line.

Do not make numeric comparison with 0 as "== 0" or "!= 0".

	if (!repo_config_get_string(the_repository,
				    "user.signingkey", &signing_key) &&
	    signing_key && *signing_key)
		return signing_key;

The reason why you pretend that user.signingkey is not even defined
when it is defined to be an empty string is because otherwise there
won't be a way for a user to override a key defined in per-user
configuration file in per-repository configuration file.  It may
deserve an in-code comment to explain that, or is it too obvious?

I dunno.

By the way, by using repo_config_get_string(), you are willing to
give an error message from config_error_nonbool() when the user has
user.signingkey mistakenly defined as a valueless true, i.e.,

	[user]
		name = A U Thor
		email = au@th.or
		signingkey

I think it is OK to give an error message here, to give the user a
chance to notice and fix the mistake in their configuration file,
and keep going as if the entry did not even exist.  I just wanted to
make sure we are all aware that it is what our new code is doing.

> +	free(signing_key);
> +
> +	if (repo_config_get_bool(the_repository, "commit.gpgsign", &gpgsign) == 0 && gpgsign)
> +		return get_signing_key_id();

I am not sure if this is a good idea.  Whether the "git commit"
command is told to trigger GPG signing via the configuration
variable, or via the "--gpg-sign" command line option, wouldn't the
signing key returned by get_signing_key_id() be used either way?

In other words, I can explain why the previous entry checks the
"user.signingkey" configuration variable, but I cannot give an
explanation why we check the "commit.gpgsign" configuration variable
here.

> @@ -125,10 +203,34 @@ static struct git_var git_vars[] = {
>  		.name = "GIT_COMMITTER_IDENT",
>  		.read = committer,
>  	},
> +	{
> +		.name = "GIT_COMMITTER_NAME",
> +		.read = committer_name,
> +	},
> ...

These are pretty straight-forward additions.  It shows that the
original code structure was designed for extensibility.

> @@ -172,10 +278,11 @@ static struct git_var git_vars[] = {
>  	},
>  };
>  
> -static void list_vars(void)
> +static void list_vars(int null_term)
>  {
>  	struct git_var *ptr;
>  	char *val;
> +	char eol = null_term ? '\0' : '\n';
>  
>  	for (ptr = git_vars; ptr->read; ptr++)
>  		if ((val = ptr->read(0))) {
> @@ -184,10 +291,10 @@ static void list_vars(void)
>  
>  				string_list_split(&list, val, "\n", -1);
>  				for (size_t i = 0; i < list.nr; i++)
> -					printf("%s=%s\n", ptr->name, list.items[i].string);
> +					printf("%s=%s%c", ptr->name, list.items[i].string, eol);

Beware overly long lines.

> @@ -196,6 +303,8 @@ static void list_vars(void)
>  static const struct git_var *get_git_var(const char *var)
>  {
>  	struct git_var *ptr;
> +	if (!strcmp(var, "GIT_SIGNING_KEY"))
> +		var = "GIT_DEFAULT_KEY";

We should be able to do much better than this.  Aim to stick to the
table-driven approach as much as possible.  For example, we could
add a "const char *" member to struct git_var that says it is an
alias to another key, add an entry

	{
		.name = "GIT_SIGNING_KEY",
		.alias = "GIT_DEFAULT_KEY",
		.read = default_key,
	},

there, and teach the enumerating iterator (aka list_vars) to skip an
entry that is an alias (because it would give the user redundant
information) while allowing the locating iterator (aka get_git_var)
to find it.

>  	for (ptr = git_vars; ptr->read; ptr++) {
>  		if (strcmp(var, ptr->name) == 0) {
>  			return ptr;
> @@ -219,30 +331,65 @@ int cmd_var(int argc,
>  	    const char *prefix UNUSED,
>  	    struct repository *repo UNUSED)
>  {
> -	const struct git_var *git_var;
> -	char *val;
> +	struct strvec vars = STRVEC_INIT;
> +	int list = 0;
> +	int null_term = 0;
> +	int i;
>  
>  	show_usage_if_asked(argc, argv, var_usage);
> -	if (argc != 2)
> -		usage(var_usage);
>  
> -	if (strcmp(argv[1], "-l") == 0) {
> -		repo_config(the_repository, show_config, NULL);
> -		list_vars();
> +	for (i = 1; i < argc; i++) {
> +		const char *arg = argv[i];
> +
> +		if (!strcmp(arg, "-l")) {
> +			list = 1;
> +		} else if (!strcmp(arg, "-z")) {
> +			null_term = 1;
> +		} else if (!strcmp(arg, "--")) {
> +			for (i = i + 1; i < argc; i++)
> +				strvec_push(&vars, argv[i]);
> +			break;

Everything else in this loop seems sensible, but this one is iffy.
What makes us need this special casing of "--" and everything that
follows it?

> +		} else if (arg[0] == '-') {
> +			usage(var_usage);
> +		} else {
> +			strvec_push(&vars, arg);
> +		}
> +	}

Have you considered using parse_options() API instead of this
handwritten loop?  You'd only need to recognise two options '-l' and
'-z' into two booleans "int list" and "int null_termination", and
then

	if (list) {
		... barf if something remains in argc/argv[] ...
		
	} else {
		... everyhing in argc/argv[] are vars ...
	}

I do not see why we would even need a vars that is a copy of
argc/argv[] after options are parsed out.

> +	if (!vars.nr)
>  		usage(var_usage);

I do not know if this is friendly for a tool meant primarily for
scripts.  "git var foo bar" would give information about foo and
bar, "git var foo" would give informmation about foo, and it is
natural "git var" alone would give nothing.

This matters because it is plausible to have a list of vars in a
variable and then run "git var -z $variables | xargs -0 ..." to
process the vars and their values.  If you barf for an empty list,
then they need to see if they have nothing in $variable, which
becomes more than "test -z "$variable" because people often take
advantage of the fact that IFS is ignored to write their accumulator
like so

	variable=" "
	for n in ...
	do
		variable="$variable$n "
	done

	case "$variable" in
	*" "word" "*)
		: has the word
		;;
	esac

which means that $variable may not be an empty string.  It is easier
for scripts if "git var <variable>..." did not barf when the number
of <variable>s happens to be zero.

> +test_expect_success 'get multiple variables with -z' '
> +	test_tick &&
> +	printf "%s\0%s\0" "$GIT_AUTHOR_NAME" "$GIT_AUTHOR_EMAIL" >expect &&

Just a trivia, but

	printf "%s\0" "$GIT_AUTHOR_NAME "$GIT_AUTHOR_EMAIL" >expect

would be equivalent.
