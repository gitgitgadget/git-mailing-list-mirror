Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097003090CD
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875694; cv=none; b=adGCxCfcsGENl3R8sdxtLUDCxLycLq6ZRIrpxypFUYfIB5LyT94UO+tUTv6EZWu2vhW5dF9ZZCkfPxPQhrGw4+B9zcQwU33Zm1y81ALteZE/GeVYX1i+nSN3dO7Lgke1caZ/cLNUdYTG4SefQpdaOwS94MoaAqgvBeNbOtVTyN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875694; c=relaxed/simple;
	bh=STYlPTWQwtXAxZ3EuhtYglwn751pY8h+F7beUC6632s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAPGX+6CR9P6dwcRVzuJLeRUXuBph8I4E1FDAutqtBcsOqEOTEvjcIjwQ3wQ7eKaYD/JUnkery5TmkpK0HxfQcLDi7JobZ2ThKS32wcjIOe08hz9IyOo66x0wfW4QDmDiW8MyTe1W5QgXy+sZ7uoRkyrIMblt4uFc2+CKGrXDMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPAWsrU0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPAWsrU0"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49d05d51553so25253065e9.2
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788875686; x=1789480486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TMEGA66ZG2LLoYJRDx3a5tcP1z+GMt0OeoyOqlGkVOE=;
        b=VPAWsrU0tWEZvcXpu5pkLgE+qh91ykVoNoKAOAYqn+uTLuApfjKMJg3LjEXCrNpjRx
         bnP1nfvhRgxoPr2w/ksQFbLt7LJjCnZOoc5sLu/Uy68hrdDlAuA5z9JQwUwfdFQ9og9o
         kDk5M+Gm9FjqcHjqnFMBjHUB4u89c+mQkdE1qXdGRjdlDLZIF4w/jqVqUyWNY1IhCbGx
         saWnjT+XQctQ9DPqTn07TX+Cd3vsc8aKPc6WDvR/bHIgi+sctPiJMT9IGFf6RWft94lL
         Pm20PBodLEiqRxhCMHh394DW+Imn7+n10vJVHL61cg/kytn4UH6AAQ5CPAD7kO9UF7aA
         4mYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788875686; x=1789480486;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TMEGA66ZG2LLoYJRDx3a5tcP1z+GMt0OeoyOqlGkVOE=;
        b=LFLzvh+bT1E8z+x0AnRnwgUE51X7b5yTSyEga1GSvaOTnUr2Z/bFAZKYcbBt313Hk/
         1PkPZm63t1rtInsZfBZf2m3Zm3GjaQzUg/paRmKBAD5ziphTj44q++0hx4Jrgk723qNu
         nAQjJz6batMSS00EQXEGZP2V9OPEc1j3/aDCnMo72fch9PN3uSdI8JDLfBGImFYAyesq
         0Oh85Rpu/8H/M+CO8AXZ+gJiOxandge+WlS8PdpO7Bt5Eadl1UZMyCPlPXLByDTHRNn5
         Qwe2KbrMxIc5xehAEY4sGIpyXad9ePHGvK4npFQTdUDBYqDGYTJpwzTeCZD9srdHfpOC
         vh0w==
X-Forwarded-Encrypted: i=1; AKwUvBzX0e1OcbTnwh4PQW+LpLzIQ9OXm+GsDFFwtq7yf6p9/rRRSOFiosOOUCMpfsrAnMydWIc=@vger.kernel.org
X-Gm-Message-State: AFuF++l4XlJwg5gyJlfxucPGjFd31VPR4A2U9lxzYfoPW14eJDrIcPn8
	9Llbu4WJufk5580L6X0TJu/vz8Mid7C8xM1xZi0MX6m5aA4EnmH9Xjkq
X-Gm-Gg: AYBFou2q/B7yxosFbQFbD8XsEImcoXaozIT47kncYMe16dHO/S2yiJelO2wFPCYAQq+
	8mc/2IQwU6Z2rUbgoePMUUTcVyyMncJqpAFkMv+qZKX+YF22Dhd01aaCQF1vE4t2kMjsb4Yq3Rc
	ntf5u0YF3CwwdV8WDBGp4nDN+hCN6FDcY3bXCMgxAw1m1vDFs9Bacsaku1kT157BbrLyi7q3mag
	CyzOeYI9dLW6oCvO1auKlRtUqtXCmgT0QHS4Bkx8Sso/b8APPrDr3LQDL+HRdUhz8a9MveE7S7f
	OEVI71CQp7GwcxyojoYFBqOq8qcwQVURJlOKwC2vJoyWRz2BlTMeLUEsGixgZ31s+lPRMGR/xpZ
	PCRBrE5Ob4xf34J2Gc+9K3od5huccRxFUlfP++Djf9KmiEA1On7ZEmIopeGzbwNHc7NV28lnF2j
	UZHGtvyqgvMRbKWxAkP5uU3zAQ2sSiWiVQ2VkEQ5hRnsBGYEgJnBkge+ZDjtdnQ+tNjr0+Wwnd5
	TltdIUDrDDiS0KbjzCmvRNQSzvjH/xDVBBH88HZLSI=
X-Received: by 2002:a05:600c:8b25:b0:49c:fc6e:a3da with SMTP id 5b1f17b1804b1-49cfc6ea704mr270954835e9.25.1788875685578;
        Tue, 08 Sep 2026 06:54:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce551bf7asm320623005e9.2.2026.09.08.06.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 06:54:44 -0700 (PDT)
Message-ID: <1a38944e-9895-474a-a6ad-277638aa49d0@gmail.com>
Date: Tue, 8 Sep 2026 14:54:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] var: support broken-down idents, signing key, multiple
 args, and -z
To: Andrew Pleeter via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 Ben Knoble <ben.knoble@gmail.com>, Andrew Pleeter <andrewpleeter@gmail.com>
References: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
 <pull.2388.v4.git.git.1788840593177.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2388.v4.git.git.1788840593177.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/09/2026 05:09, Andrew Pleeter via GitGitGadget wrote:
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
> - Allow passing multiple variable arguments (e.g., 'git var
>    GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL') to output each variable
>    sequentially.
> - Support '-z' to terminate variable outputs with NUL bytes.
> - Format 'git var -l -z' using the same convention as 'git config
>    list -z' (newline separating key and value, NUL separating entries).
> - Delimit values of multi-valued variables with NUL when '-z' is given.
> - Use parse_options() to strictly require options before arguments.
> - Update Documentation/git-var.adoc and t/t0007-git-var.sh.
> 
> Signed-off-by: Andrew Pleeter <andrewpleeter@gmail.com>
> ---
>      var: support broken-down idents, signing key, multiple args, and -z
>      
>      Teach git var to expose individual identity components and commit
>      signing configuration, and allow querying multiple variables with
>      optional NUL-termination.
>      
>      
>      Changes since v3:
>      =================
>      
>       * Renamed GIT_DEFAULT_KEY to GIT_SIGNING_KEY per feedback from Phillip
>         Wood and Junio C Hamano; dropped the alias mechanism and
>         commit.gpgsign check.
>       * Used parse_options() with PARSE_OPT_STOP_AT_NON_OPTION in
>         builtin/var.c, strictly enforcing that options precede variable
>         arguments.
>       * Adopted git config list -z format (key\nvalue\0) for git var -l -z to
>         prevent ambiguity with = in config keys.
>       * Delimited multi-valued variable outputs (e.g. GIT_CONFIG_GLOBAL) with
>         NUL bytes under -z.
>       * Replaced char part in ident_part() with enum ident_part.
>       * Split synopsis in Documentation/git-var.adoc into separate lines for
>         -l and <variable>..., and removed awkward legacy phrasing ("of a
>         piece of code").
>       * Added tests in t/t0007-git-var.sh covering the new -z format,
>         multi-valued -z, and argument ordering.
> 

That all sounds good, lets look at the code ...

> diff --git a/builtin/var.c b/builtin/var.c
> index cc3a43cde2..6fc037543a 100644
> --- a/builtin/var.c
> +++ b/builtin/var.c
 > [...]> +static char *git_signing_key(int ident_flag UNUSED)
> +{
> +	char *signing_key = NULL;
> +
> +	/*
> +	 * An empty string in user.signingkey allows overriding and
> +	 * clearing a key defined in an outer (e.g. global) config.
> +	 */
> +	if (!repo_config_get_string(the_repository,
> +				    "user.signingkey", &signing_key)) {
> +		if (!signing_key || !*signing_key) {
> +			free(signing_key);
> +			return NULL;
> +		}
> +		return signing_key;
> +	}
> +
> +	signing_key = get_signing_key_id();
> +	if (signing_key && !*signing_key) {
> +		free(signing_key);
> +		return NULL;
> +	}
 > +	return signing_key;
 > +}

Looking at sign_buffer() in gpg-interface.c it looks like git calls 
get_signing_key() to obtain the default key - why are we doing something 
different here? I'm also still curious how this is expected to be used.

> -static void list_vars(void)
> +static void list_vars(int null_term)
>   {
>   	struct git_var *ptr;
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
> -			} else {
> -				printf("%s=%s\n", ptr->name, val);
> -			}
> -			free(val);
> +	char delim = null_term ? '\n' : '=';

We are in control of the variable names and we know they do not 
currently contain '=' so we don't currently need a different format here 
with '-z'. However it is possible that might change in the future (for 
example using "GIT_PAGER:<my-command>" to return the pager for 
"<my-command>" that could be an alias containing '=') so using the same 
format as config keys is probably a good idea. We should document the 
format above.

> +	char eol = null_term ? '\0' : '\n';
> +
> +	for (ptr = git_vars; ptr->read; ptr++) {
> +		char *val = ptr->read(0);
> +
> +		if (!val)
> +			continue;
> +
> +		if (ptr->multivalued && *val) {
> +			struct string_list list = STRING_LIST_INIT_DUP;
> +
> +			string_list_split(&list, val, "\n", -1);

As I said before, I think we should switch to using '\0' instead of '\n' 
when we build the multivalued string so that we can safely handle values 
that contain '\n'.

> +			for (size_t i = 0; i < list.nr; i++)
> +				printf("%s%c%s%c", ptr->name, delim,
> +				       list.items[i].string, eol);
> +			string_list_clear(&list, 0);
> +		} else {
> +			printf("%s%c%s%c", ptr->name, delim, val, eol);
>   		}
> +		free(val);
> +	}
>   }   

> @@ -207,42 +346,76 @@ static const struct git_var *get_git_var(const char *var)
>   static int show_config(const char *var, const char *value,
>   		       const struct config_context *ctx, void *cb)
>   {
> +	int null_term = cb ? *(int *)cb : 0;

This seems unnecessarily complicated, can't we just make sure we always 
pass a non-null pointer cb? Also '\0' is known as NUL, not NULL.

	int *nul_term = cb;
	char term = *nul_term ? '\0' : '\n';
	char delim = *nul_term ? '\n' : '=';

and then use term and delim below.

> +
>   	if (value)
> -		printf("%s=%s\n", var, value);
> +		printf("%s%c%s%c", var, null_term ? '\n' : '=',
> +		       value, null_term ? '\0' : '\n');
>   	else
> -		printf("%s\n", var);
> +		printf("%s%c", var, null_term ? '\0' : '\n');
>   	return git_default_config(var, value, ctx, cb);
>   }
>   
>   int cmd_var(int argc,
>   	    const char **argv,
> -	    const char *prefix UNUSED,
> +	    const char *prefix,
>   	    struct repository *repo UNUSED)
>   {
> -	const struct git_var *git_var;
> -	char *val;
> +	int list = 0;
> +	int null_term = 0;
> +	int i;
> +	struct option options[] = {
> +		OPT_BOOL('l', NULL, &list,
> +			 N_("list all variables")),
> +		OPT_BOOL('z', NULL, &null_term,
> +			 N_("terminate entries with NUL")),

The help is correct, we should use nul_term as the variable name. Using 
parse_options() is a nice improvement.

> +		OPT_END(),
> +	};
>   
> -	show_usage_if_asked(argc, argv, var_usage);
> -	if (argc != 2)
> -		usage(var_usage);
> +	argc = parse_options(argc, argv, prefix, options,
> +			     var_usage, PARSE_OPT_STOP_AT_NON_OPTION);
>   
> -	if (strcmp(argv[1], "-l") == 0) {
> -		repo_config(the_repository, show_config, NULL);
> -		list_vars();
> +	if (list) {
> +		if (argc)
> +			usage_with_options(var_usage, options);
> +		repo_config(the_repository, show_config, &null_term);
> +		list_vars(null_term);
>   		return 0;
>   	}
> +
> +	if (!argc)
> +		usage_with_options(var_usage, options);
> +
> +	for (i = 0; i < argc; i++) {
> +		if (!get_git_var(argv[i]))
> +			usage_with_options(var_usage, options);

Do we really need to walk all the var names here - can't we just error 
out if we see an invalid one later?

> +	}
> +
>   	repo_config(the_repository, git_default_config, NULL);
>   
> -	git_var = get_git_var(argv[1]);
> -	if (!git_var)
> -		usage(var_usage);
> +	for (i = 0; i < argc; i++) {
> +		const struct git_var *git_var = get_git_var(argv[i]);
> +		char *val;
> +
> +		val = git_var->read(IDENT_STRICT);
> +		if (!val)
> +			return 1;

If the user asked for multiple vars to be printed, erroring out because 
one is not set is not very friendly, It would be better to print a blank 
record and continue.

>   
> -	val = git_var->read(IDENT_STRICT);
> -	if (!val)
> -		return 1;
> +		if (git_var->multivalued && null_term && *val) {

Why "*val" ?

> +			struct string_list values = STRING_LIST_INIT_DUP;
>   
> -	printf("%s\n", val);
> -	free(val);
> +			string_list_split(&values, val, "\n", -1);
> +			for (size_t j = 0; j < values.nr; j++) {
> +				const char *s = values.items[j].string;
> +
> +				printf("%s%c", s, '\0');

If we're printing multiple var then the caller has no way to tell if a 
var has multiple values which makes it tricky or impossible to match up 
the values we print to the vars that were requested. We could change the 
output format when multiple vars are requested to print the var name as 
will like we do with '-l', or we could print an extra terminator after a 
multi-valued var and properly document which vars are multi-valued. The 
latter means the caller can match up the values without worrying about 
parsing the var names.

Thanks

Phillip

> +			}
> +			string_list_clear(&values, 0);
> +		} else {
> +			printf("%s%c", val, null_term ? '\0' : '\n');
> +		}
> +		free(val);
> +	}
>   
>   	return 0;
>   }
> diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
> index 2b60317758..27cc595291 100755
> --- a/t/t0007-git-var.sh
> +++ b/t/t0007-git-var.sh
> @@ -276,4 +276,99 @@ test_expect_success '`git var -l` works even without HOME' '
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
>   test_done
> 
> base-commit: 2c3adbb2c475981e340c79fdc5e7f4f9b5d9054e

