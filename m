Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3F1566C53
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968187; cv=none; b=tj67JzAHqtF0anBbwlYug6D3/iPioi6itzl4LIg780vKAtpc42d4+IFg1edcXlCRORlL/9qabhpnDBVm2k6FhRuymGHm09UXWo6iURFEY4ccBBbHJFMiFD5KnIz610rfTZ9tdzPR41usgcLhWIoOJUjUtYA8dTiIhtSsJz6nH7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968187; c=relaxed/simple;
	bh=5flX4qaAzE3kfSs+rOVDabnra0Z9Owi5kSFUYjYUixI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cb7wv2A54Rc1Blw7AlEo1Al4x+ICIdPHyQlWQFQR7CASl6/6lIu0yNh3Y4Q8ddcNop6T1WDw+UU+mOm9mydB1R1cR5V0TAzPsgilkjtsRfsiBZMcevuQXNJhD8FfAhj58H1+bcYwKjYChWSI6NuWrkMEUwfVIl8HlbsBu/3F6i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRf1ms+d; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRf1ms+d"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4834977ae75so732250f8f.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788968183; x=1789572983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FfVxQ37Rnuto8uygeMj3brL1IvK84BxyL9IJWkZ9B8Y=;
        b=hRf1ms+dIjAC40dd/LTkFkcIHVE7wFA/TtPduPx8AobAhoe+c+iS4hWe0lWGLP/E5+
         dT1xIe6cN8uQiZuBzFSlkCyLrNFyFxU/woTE1/gXjVvyWyZcuzwctSZ6eCG/MZJCom+R
         FgocdVvqLqX9F/UAeHA2PY+N2ThkUotfp0wWZA06K++q2rT0/hRy2/Vbn/0+Xc/cLm8F
         67X0NTTQJpD7oJdtLpmOP1YLM9IV8rCVW9n7AqQ0JcByrBD8X8ekiQ7MPCmTgW8mPG0S
         OdEWtY3RBL/w47Qpk+Qkv3f9k3g/x+kF4SMV5o3CtwZvcKQx0Hv2fwfb8QuF2HNFqAZD
         TuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788968183; x=1789572983;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FfVxQ37Rnuto8uygeMj3brL1IvK84BxyL9IJWkZ9B8Y=;
        b=KSvluB10NjubQ5piPgTBkmLYeG6JgWwfPQERkhoITpRCqORFoq9tUdlW2ijX7tqo+P
         qCKmK1gN8yGZPadXOKk/Isy/inyUsEWXaktGITPShUIkPdjkBGthY5g4FgTg3bhG5cne
         ydgXEVoF+SMrJ6/lOhYDS7jv9jBgnJsPvZAcfSzqYuZmMfEdycEwSd++DW1fNjH3QyIv
         jZ6AudmuJIIrS6eN81tmVfPNOgPVIjvEzGYpNrcW0RX2jvfH1xcY0nrIMqCGBepjQ/6L
         X4EKotcF7P3ugFj6OewEqLUnfmSt10KVII1cpOJNjpyEcfXFDDRmK8NwqPHjEaGTP7Cy
         E05w==
X-Forwarded-Encrypted: i=1; AKwUvBwMY/u5dOoQomLCvBM2ahjJIeVuxig4riWUs5LJsCQMJRhTXgx0Hq2DscQu+K3pdCMyZSI=@vger.kernel.org
X-Gm-Message-State: AFuF++mEd2LeHVOm2JOc9NhbvNXU2qD04M7ckfWpFXG9JpaMoTv+Ciqa
	f2tnuUNTxaWnz7Q0Boq7wFO9srAI3gpT/SkMQrZEErNoBXB947eixj7t
X-Gm-Gg: AYBFou2MscdHy3n+ozyMovo6bQVxizvgL9/4Y66Oh4S7ZZkn8vM4XVVDhUSTtu0dW8d
	lvELkthF89PDdOZau33wroQHdDAg7LcZWkE39zJd/tQ0Rksur6+ZDsH6DacDk9DQpLfueLXYhP7
	bVpbGsy/q8R7/sUhtNpG6PbZ2EIhw2+CAT/JMMqcM9Pg1N8VKwaV0zjm/BOkE6WOVpzWU0w9yMU
	COc27Q4A4VMA7OW6QKKgznwbkl0fo+MbOvKqq+pJvocu+e6mcHhZCDBD1wE/JFBHbhjLm3G7fiX
	yhmQgB/pipp9GlEQAIeB1p9eFMglYts9SttKJ4q3oW4xuKjKqPmwwj1yFi8SPuRzXtR8WGNMuVd
	n+7mY1T7zTRLZTN1WNTr/f+PBc89zyIsCH619ZI/8+7eezHNCz3jcQKw7dklZ15jyC6MkQ87uNs
	Biiq1jrXj+HU8c8kPB9IRqVWRFLRG5TFwHfwHut6OOGFb5DgmJgWnrmfTXbfVkPhzujqrb6uOho
	XFAJvQialp92OGAlx/02NajKMP7soZCkRYT++3kOZON3bFeyXVJvA==
X-Received: by 2002:a05:6000:40ce:b0:484:3310:710e with SMTP id ffacd0b85a97d-485aae0e2dbmr12736246f8f.26.1788968182913;
        Wed, 09 Sep 2026 08:36:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485958f1493sm33221560f8f.37.2026.09.09.08.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 08:36:22 -0700 (PDT)
Message-ID: <07d1ef05-97df-481a-b647-cbe33a57f902@gmail.com>
Date: Wed, 9 Sep 2026 16:36:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6] var: support broken-down idents, signing key, multiple
 args, and -z
To: Andrew Pleeter via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 Ben Knoble <ben.knoble@gmail.com>, Andrew Pleeter <andrewpleeter@gmail.com>
References: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
 <pull.2388.v6.git.git.1788917076554.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2388.v6.git.git.1788917076554.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew

On 09/09/2026 02:24, Andrew Pleeter via GitGitGadget wrote:
> From: Andrew Pleeter <andrewpleeter@gmail.com>
> 
> While 'git var' exposes GIT_AUTHOR_IDENT and GIT_COMMITTER_IDENT,
> extracting individual components (name, email, or date) currently
> requires callers to manually parse the composite string. Furthermore,
> there is no way to query the resolved commit signing key through
> 'git var', and the command only accepts a single variable at a time.
> 
> Teach 'git var' to expose individual identity components and commit
> signing configuration, and allow querying multiple variables with
> optional NUL-termination:
> 
> - Add GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and GIT_AUTHOR_DATE.
> - Add GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL, and GIT_COMMITTER_DATE.
> - Add GIT_SIGNING_KEY to resolve the key that would be used to sign
>    the resulting commit if you were to run 'git commit' right now.

I'm still curious what the use case for GIT_SIGNING_KEY is. Is the key 
alone enough for the caller to determine if they should be using gpg or 
ssh? I've asked this twice already - when a reviewer asks a question it 
is helpful to rely rather than just sending a new version of the patch.
> - Allow passing multiple variable arguments (e.g., 'git var
>    GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL') to output each variable
>    sequentially.
> - Support '-z' to terminate variable outputs with NUL bytes.
> - Format 'git var -l -z' using the same convention as 'git config
>    list -z' (newline separating key and value, NUL separating entries).
> - Delimit values of multi-valued variables with NUL when '-z' is given,
>    and output an extra delimiter after multi-valued variables when
>    querying multiple variables to disambiguate the stream.
> - When querying multiple variables, print an empty record for any
>    variable that has no value and continue processing remaining variables.
> - Use parse_options() to strictly require options before arguments.
> - Update Documentation/git-var.adoc and t/t0007-git-var.sh.
> 
> Signed-off-by: Andrew Pleeter <andrewpleeter@gmail.com>
> ---

> diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
> index 697c10aded..2c1eaf3cf7 100644
> --- a/Documentation/git-var.adoc
> +++ b/Documentation/git-var.adoc
> @@ -9,12 +9,16 @@ git-var - Show a Git logical variable
>   SYNOPSIS
>   --------
>   [synopsis]
> -git var (-l | <variable>)
> +git var [-z] -l
> +git var [-z] <variable>...
>   
>   DESCRIPTION
>   -----------
> -Prints a Git logical variable. Exits with code 1 if the variable has
> -no value.
> +Prints Git logical variables. Exits with code 1 if any requested
> +variable has no value.

I'm not sure that is very useful when the user asks for more than one 
variable - they can see the value was empty by looking at the output and 
means callers cannot check for fatal errors such as an invalid variable 
name by simply looking for a non-zero exit code.

> When multiple variables are requested, an empty
> +record (a blank line, or an empty NUL-terminated record when `-z` is given)
> +is printed for any variable that has no value, and the command continues
> +processing the remaining variables.
>   
>   OPTIONS
>   -------
> @@ -24,19 +28,65 @@ OPTIONS
>   	as well. (However, the configuration variables listing functionality
>   	is deprecated in favor of `git config list`.)
>   
> +`-z`::
> +	Terminate entries with NUL instead of newline. When used with
> +	`-l`, the variable name and its value are separated by a newline,
> +	and each entry is terminated with a NUL byte.

Good

> @@ -85,9 +135,13 @@ endif::git-default-pager[]
>       The path to the global (per-user) configuration files, if any.
>   
>   Most path values contain only one value. However, some can contain multiple
> -values, which are separated by newlines, and are listed in order from highest to
> -lowest priority.  Callers should be prepared for any such path value to contain
> -multiple items.
> +values, which are separated by newlines (or NUL bytes if `-z` is given),
> +and are listed in order from highest to lowest priority. When querying
> +multiple variables, an extra newline (or an extra NUL byte if `-z` is
> +given) is printed after the values of a multi-valued variable to mark the
> +end of its list.

We should mark each mult-valued varibale in its description so that 
users know when to expect a list.

> (Single-variable queries and `git var -l` do not print
> +an extra delimiter). Callers should be prepared for any such path value to
> +contain multiple items.
>   
>   Note that paths are printed even if they do not exist, but not if they are
>   disabled by other environment variables.

> -static char *git_config_val_global(int ident_flag UNUSED)
> +static int git_config_val_global(struct string_list *list)
>   {
> -	struct strbuf buf = STRBUF_INIT;
>   	char *user, *xdg;
> -	size_t unused;
>   
>   	git_global_config_paths(&user, &xdg);
>   	if (xdg && *xdg) {
>   		normalize_path_copy(xdg, xdg);
> -		strbuf_addf(&buf, "%s\n", xdg);
> +		string_list_append(list, xdg);
>   	}
>   	if (user && *user) {
>   		normalize_path_copy(user, user);
> -		strbuf_addf(&buf, "%s\n", user);
> +		string_list_append(list, user);
>   	}
>   	free(xdg);
>   	free(user);
> -	strbuf_trim_trailing_newline(&buf);
> -	if (buf.len == 0) {
> -		strbuf_release(&buf);
> -		return NULL;
> -	}
> -	return strbuf_detach(&buf, &unused);
> +	return !list->nr;
>   }

This is a nice improvement that could perhaps be split out into a 
separate preparatory change together with the change from a flag to a 
different read function for multi-valued variables below.

>   
>   struct git_var {
>   	const char *name;
>   	char *(*read)(int);
> -	int multivalued;
> +	int (*multiread)(struct string_list *);
>   };

> -static void list_vars(void)
> +static void list_vars(int nul_term)
>   {
>   	struct git_var *ptr;
> -	char *val;
> +	char delim = nul_term ? '\n' : '=';
> +	char term = nul_term ? '\0' : '\n';
>   
> -	for (ptr = git_vars; ptr->read; ptr++)
> -		if ((val = ptr->read(0))) {
> -			if (ptr->multivalued && *val) {
> -				struct string_list list = STRING_LIST_INIT_DUP;
> +	for (ptr = git_vars; ptr->read || ptr->multiread; ptr++) {
> +		if (ptr->read) {
> +			char *val = ptr->read(0);
>   
> -				string_list_split(&list, val, "\n", -1);
> -				for (size_t i = 0; i < list.nr; i++)
> -					printf("%s=%s\n", ptr->name, list.items[i].string);
> -				string_list_clear(&list, 0);
> -			} else {
> -				printf("%s=%s\n", ptr->name, val);
> +			if (val) {
> +				printf("%s%c%s%c", ptr->name, delim, val, term);
> +				free(val);
>   			}
> -			free(val);
> +		} else if (ptr->multiread) {

We should just assume that ptr->multread is set when ptr->read is not, 
or possibly add an else clause that calls BUG().

> +			struct string_list list = STRING_LIST_INIT_DUP;
> +			size_t i;
> +
> +			if (!ptr->multiread(&list)) {
> +				for (i = 0; i < list.nr; i++)
> +					printf("%s%c%s%c", ptr->name, delim,
> +					       list.items[i].string, term);
> +			}
> +			string_list_clear(&list, 0);

>   int cmd_var(int argc,
>   	    const char **argv,
> -	    const char *prefix UNUSED,
> +	    const char *prefix,
>   	    struct repository *repo UNUSED)
 > [...]
> +	for (i = 0; i < argc; i++) {
> +		const struct git_var *git_var = get_git_var(argv[i]);
>   
> -	printf("%s\n", val);
> -	free(val);
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

What's the benefit of this? The caller can see there was an empty value 
so why do we want a non-zero exit code as well. For example, if the 
caller is asking for GIT_CONFIG_SYSTEM and GIT_CONFIG_GLOBAL but the 
user ran the script with GIT_CONFIG_NOSYSTEM then that shouldn't be an 
error - the caller should just not use the system config.

> +				printf("%c", term);
> +				continue;
> +			}
> +			printf("%s%c", val, term);
> +			free(val);
> +		} else if (git_var->multiread) {
> +			struct string_list list = STRING_LIST_INIT_DUP;
> +			size_t j;
> +
> +			if (git_var->multiread(&list) || !list.nr) {

Why are we checking the return value of the function and the list length 
- surely the list length tells us everything we need to know.

> +				if (argc == 1) {
> +					string_list_clear(&list, 0);
> +					return 1;
> +				}
> +				ret = 1;
> +				printf("%c", term);
> +			} else {
> +				for (j = 0; j < list.nr; j++)
> +					printf("%s%c", list.items[j].string, term);
> +				if (argc > 1)
> +					printf("%c", term);
> +			}
> +			string_list_clear(&list, 0);

I think the above can be simplified to

	} else {
		struct string_list list = STRING_LIST_INIT_NODUP;
		
		git_var->multiread(&list);
		if (argc == 1 && !list.nr) {
			return 1;
		}
		for (j = 0; j < list.nr; j++)
			printf("%s%c", list.items[j].string, term);
		if (argc > 1)
			putc(term);

		string_list_clear(&list, 0);
	}

I've not had time to look too closely at the tests, but I did notice 
they use test_cmp() on files containing '\0' which isn't a good idea 
because diff will see them as binary files. We have helpers like 
nul_to_q to translate nul to a printable character. I'm going to be off 
the list from tomorrow until the middle of next week so it will be a few 
days before I look at the next (and hopefully final) version.

Thanks

Phillip

> +		}
> +	}
>   
> -	return 0;
> +	return ret;
>   }
> diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
> index 2b60317758..92b68b9ab4 100755
> --- a/t/t0007-git-var.sh
> +++ b/t/t0007-git-var.sh
> @@ -276,4 +276,127 @@ test_expect_success '`git var -l` works even without HOME' '
>   	)
>   '
>   
> +test_expect_success 'get author identity components' '
> +	test_tick &&
> +	echo "$GIT_AUTHOR_NAME" >expect.name &&
> +	echo "$GIT_AUTHOR_EMAIL" >expect.email &&
> +	echo "$GIT_AUTHOR_DATE" >expect.date &&
> +	git var GIT_AUTHOR_NAME >actual.name &&
> +	git var GIT_AUTHOR_EMAIL >actual.email &&
> +	git var GIT_AUTHOR_DATE >actual.date &&
> +	test_cmp expect.name actual.name &&
> +	test_cmp expect.email actual.email &&
> +	test_cmp expect.date actual.date
> +'
> +
> +test_expect_success 'get committer identity components' '
> +	test_tick &&
> +	echo "$GIT_COMMITTER_NAME" >expect.name &&
> +	echo "$GIT_COMMITTER_EMAIL" >expect.email &&
> +	echo "$GIT_COMMITTER_DATE" >expect.date &&
> +	git var GIT_COMMITTER_NAME >actual.name &&
> +	git var GIT_COMMITTER_EMAIL >actual.email &&
> +	git var GIT_COMMITTER_DATE >actual.date &&
> +	test_cmp expect.name actual.name &&
> +	test_cmp expect.email actual.email &&
> +	test_cmp expect.date actual.date
> +'
> +
> +test_expect_success 'get multiple variables' '
> +	test_tick &&
> +	cat >expect <<-EOF &&
> +	$GIT_AUTHOR_NAME
> +	$GIT_AUTHOR_EMAIL
> +	$GIT_COMMITTER_NAME
> +	$GIT_COMMITTER_EMAIL
> +	EOF
> +	git var GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'get multiple variables with -z' '
> +	test_tick &&
> +	printf "%s\0" "$GIT_AUTHOR_NAME" "$GIT_AUTHOR_EMAIL" >expect &&
> +	git var -z GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'get multi-valued variable with -z' '
> +	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
> +	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" git var -z GIT_CONFIG_GLOBAL >actual &&
> +	printf "%s\0" "$TRASHDIR/foo/git/config" "$TRASHDIR/.gitconfig" >expected &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'git var -l -z' '
> +	git var -l -z >actual &&
> +	tr "\0" "\n" <actual >actual.lines &&
> +	echo "$GIT_AUTHOR_NAME" >expect &&
> +	sed -n "/^GIT_AUTHOR_NAME$/{n;p;}" actual.lines >actual.author &&
> +	test_cmp expect actual.author &&
> +	echo false >expect &&
> +	sed -n "/^core\.bare$/{n;p;}" actual.lines >actual.bare &&
> +	test_cmp expect actual.bare
> +'
> +
> +test_expect_success 'get GIT_SIGNING_KEY with user.signingkey configured' '
> +	test_config user.signingkey "TEST_KEY_ID" &&
> +	echo "TEST_KEY_ID" >expect &&
> +	git var GIT_SIGNING_KEY >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'get GIT_SIGNING_KEY fails when unset' '
> +	test_config user.signingkey "" &&
> +	test_must_fail git var GIT_SIGNING_KEY
> +'
> +
> +test_expect_success 'git var -l lists new variables' '
> +	git var -l >actual &&
> +	test_grep "^GIT_AUTHOR_NAME=" actual &&
> +	test_grep "^GIT_AUTHOR_EMAIL=" actual &&
> +	test_grep "^GIT_AUTHOR_DATE=" actual &&
> +	test_grep "^GIT_COMMITTER_NAME=" actual &&
> +	test_grep "^GIT_COMMITTER_EMAIL=" actual &&
> +	test_grep "^GIT_COMMITTER_DATE=" actual
> +'
> +
> +test_expect_success 'git var -l lists GIT_SIGNING_KEY when configured' '
> +	test_config user.signingkey "TEST_KEY_ID" &&
> +	git var -l >actual &&
> +	test_grep "^GIT_SIGNING_KEY=TEST_KEY_ID" actual
> +'
> +
> +test_expect_success 'options must precede variable arguments' '
> +	test_must_fail git var GIT_AUTHOR_NAME -z
> +'
> +
> +test_expect_success 'get multiple variables with unset variable outputs blank record' '
> +	test_config user.signingkey "" &&
> +	cat >expect <<-EOF &&
> +	$GIT_AUTHOR_NAME
> +
> +	$GIT_COMMITTER_NAME
> +	EOF
> +	test_must_fail git var GIT_AUTHOR_NAME GIT_SIGNING_KEY GIT_COMMITTER_NAME >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'get multiple variables with -z and unset variable' '
> +	test_config user.signingkey "" &&
> +	printf "%s\0\0%s\0" "$GIT_AUTHOR_NAME" "$GIT_COMMITTER_NAME" >expect &&
> +	test_must_fail git var -z GIT_AUTHOR_NAME GIT_SIGNING_KEY GIT_COMMITTER_NAME >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'get multiple variables including multi-valued variable with -z' '
> +	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
> +	printf "%s\0%s\0%s\0\0%s\0" "$GIT_AUTHOR_NAME" \
> +		"$TRASHDIR/foo/git/config" "$TRASHDIR/.gitconfig" \
> +		"$GIT_AUTHOR_EMAIL" >expect &&
> +	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" \
> +		git var -z GIT_AUTHOR_NAME GIT_CONFIG_GLOBAL GIT_AUTHOR_EMAIL >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_done
> 
> base-commit: 2c3adbb2c475981e340c79fdc5e7f4f9b5d9054e

