Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470FE1272C4
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652640; cv=none; b=mzxjadpnGc+8HlBtA7vBVtwgltYTX2FKG+S3RAKmOl5q+HfFeXfjdkW8dquRKH/+uedRxnVrmLZ4qjmpAOUKugcbLOLOEWFGkr5nMIGs8jaOlGLcrIVlJLsYzEej9V51heCQaYqHG8Sw30b3kNgsPcxgNxJFvQDQyT/SQ8UKVEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652640; c=relaxed/simple;
	bh=OKseRskjAQASoheSySlpIe+TI2LyKr/08MCgkgV6e80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQ+zMhZ5/RUWmMqezxoJ+JSVRBLuSKTp7+io4nJ/clE1IDM5tYYIRzOolXwJSVaAtpRylwTbN5bm0Rte/Hjm6YlajEXrJ853UsVeOy+CNblrTctuAc6p2sW4pq0TSNUxdrIfRo6KOzWJaQYYle2XhG/nfF100UC1bnK6WbT967s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ia1ryYba; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia1ryYba"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-565a3910f86so8707341a12.3
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 07:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709652637; x=1710257437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4s4t3p4Sb70CJcejIoR/4sX8S9tht/DQoZtnhp6aRk=;
        b=ia1ryYba6tsxezqA9hvBUmY5SgJd3wW6tohzfuJ2stTOjy8QcO1CaaDwCVL0IPHuzU
         J13MdsM7RLmtuIHmP6bCyBlHPaTdaEM6ZVEoTAX45a+Yuboxp4nwi7FihphPw3xm0nao
         dEVhKDvfJfvA0Ha8hjbbryLFNijJD3z2M4GHEZIG5to+puAD4JTj4+u5zUaGZ3nSwhct
         G1FOz42KIK4vApCuVCdfJDhy32FD0GHfhgbSKob4NFuTJ3xLJ8VluxtYpAqX4pecorQu
         ztw4pavtkAUXAjkWnjAHiu5eUn9CvMFx4mwKYf/6GCIzRmEF5CQa+B2phT8WC4403v2p
         W5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709652637; x=1710257437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4s4t3p4Sb70CJcejIoR/4sX8S9tht/DQoZtnhp6aRk=;
        b=hAVRfMPLuGsYzOVzapNG4Uhg4rsScUa21QeKZtJGHo3EOXncdwaH7QwMQfkkuXpLJG
         vKtQSvPe8J9NbJFyI+jMOVYJVpUFOP5j2Ukvy/zldptgiK41NgQYkm7hU1ohfv8mqFEE
         JV7werH+xS/uz/mwVcjnD0mn7UeTZ4Y+XupuGIPhPEcDOmmpkexNMm80zjW3xJNogUYf
         9u6mifxOEQoNpbZ8I6kfLPbdLYEHz/RBYrSnIupIBLGoY5FAVMPwuu5ympgnnZNpkDIW
         GMQV8rnd/HiQn/7LgT4173g2+dAL4l35ALl9qXlx6V0nJeCGjogirk0gXZLarxJcxsEN
         9c8A==
X-Forwarded-Encrypted: i=1; AJvYcCVvFJclQr06ubS4WzDQU4oecfC6be2I99KVEfP/8x/hg4m8dIWsGWXcnR6QYrCl4aA15VSB1MDUwiGB2TMCDtFM414g
X-Gm-Message-State: AOJu0Yz1WiHtn77/x5FKWrzIzmP6+8BPHnWaAFrcoFPLIo/637hjNVan
	M+j3lfm02tEK1lsK8rRhfk+aSLHep7i7uUitK2SDBzuVR7FAj8iA
X-Google-Smtp-Source: AGHT+IHs6U7o6Cn6qr1y7vvP7wem0IKQQ8w2Ym4wHK2YzVtImXhXHcZWAnA+VJBN8LNl16dnMKIJ2g==
X-Received: by 2002:a17:906:5799:b0:a45:16ea:c46f with SMTP id k25-20020a170906579900b00a4516eac46fmr5346248ejq.54.1709652636193;
        Tue, 05 Mar 2024 07:30:36 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244? ([2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244])
        by smtp.gmail.com with ESMTPSA id qt8-20020a170906ece800b00a453b2261b4sm2638493ejb.184.2024.03.05.07.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 07:30:35 -0800 (PST)
Message-ID: <a3de2b7b-4603-4604-a4d2-938a598e312e@gmail.com>
Date: Tue, 5 Mar 2024 15:30:35 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] show-ref: add --unresolved option
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: John Cai <johncai86@gmail.com>
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John

On 04/03/2024 22:51, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
> 
> For reftable development, it would be handy to have a tool to provide
> the direct value of any ref whether it be a symbolic ref or not.
> Currently there is git-symbolic-ref, which only works for symbolic refs,
> and git-rev-parse, which will resolve the ref. Let's add a --unresolved
> option that will only take one ref and return whatever it points to
> without dereferencing it.

"--unresolved" makes me think of merge conflicts. I wonder if 
"--no-dereference" would be clearer.

Best Wishes

Phillip

> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>      show-ref: add --unresolved option
>      
>      For reftable development, it would be handy to have a tool to provide
>      the direct value of any ref whether it be a symbolic ref or not.
>      Currently there is git-symbolic-ref, which only works for symbolic refs,
>      and git-rev-parse, which will resolve the ref. Let's add a --unresolved
>      option that will only take one ref and return whatever it points to
>      without dereferencing it.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1684%2Fjohn-cai%2Fjc%2Fshow-ref-direct-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1684/john-cai/jc/show-ref-direct-v1
> Pull-Request: https://github.com/git/git/pull/1684
> 
>   Documentation/git-show-ref.txt |  8 ++++++
>   builtin/show-ref.c             | 33 ++++++++++++++++--------
>   t/t1403-show-ref.sh            | 47 ++++++++++++++++++++++++++++++++++
>   3 files changed, 77 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
> index ba757470059..2f9b4de1346 100644
> --- a/Documentation/git-show-ref.txt
> +++ b/Documentation/git-show-ref.txt
> @@ -16,6 +16,7 @@ SYNOPSIS
>   	     [--] [<ref>...]
>   'git show-ref' --exclude-existing[=<pattern>]
>   'git show-ref' --exists <ref>
> +'git show-ref' --unresolved <ref>
>   
>   DESCRIPTION
>   -----------
> @@ -76,6 +77,13 @@ OPTIONS
>   	it does, 2 if it is missing, and 1 in case looking up the reference
>   	failed with an error other than the reference being missing.
>   
> +--unresolved::
> +
> +	Prints out what the reference points to without resolving it. Returns
> +	an exit code of 0 if it does, 2 if it is missing, and 1 in case looking
> +	up the reference failed with an error other than the reference being
> +	missing.
> +
>   --abbrev[=<n>]::
>   
>   	Abbreviate the object name.  When using `--hash`, you do
> diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> index 1c15421e600..58efa078399 100644
> --- a/builtin/show-ref.c
> +++ b/builtin/show-ref.c
> @@ -18,6 +18,7 @@ static const char * const show_ref_usage[] = {
>   	   "             [--] [<ref>...]"),
>   	N_("git show-ref --exclude-existing[=<pattern>]"),
>   	N_("git show-ref --exists <ref>"),
> +	N_("git show-ref --unresolved <ref>"),
>   	NULL
>   };
>   
> @@ -220,11 +221,11 @@ static int cmd_show_ref__patterns(const struct patterns_options *opts,
>   	return 0;
>   }
>   
> -static int cmd_show_ref__exists(const char **refs)
> +static int cmd_show_ref__raw(const char **refs, int show)
>   {
> -	struct strbuf unused_referent = STRBUF_INIT;
> -	struct object_id unused_oid;
> -	unsigned int unused_type;
> +	struct strbuf referent = STRBUF_INIT;
> +	struct object_id oid;
> +	unsigned int type;
>   	int failure_errno = 0;
>   	const char *ref;
>   	int ret = 0;
> @@ -236,7 +237,7 @@ static int cmd_show_ref__exists(const char **refs)
>   		die("--exists requires exactly one reference");
>   
>   	if (refs_read_raw_ref(get_main_ref_store(the_repository), ref,
> -			      &unused_oid, &unused_referent, &unused_type,
> +			      &oid, &referent, &type,
>   			      &failure_errno)) {
>   		if (failure_errno == ENOENT || failure_errno == EISDIR) {
>   			error(_("reference does not exist"));
> @@ -250,8 +251,16 @@ static int cmd_show_ref__exists(const char **refs)
>   		goto out;
>   	}
>   
> +		if (!show)
> +			goto out;
> +
> +		if (type & REF_ISSYMREF)
> +			printf("ref: %s\n", referent.buf);
> +		else
> +			printf("ref: %s\n", oid_to_hex(&oid));
> +
>   out:
> -	strbuf_release(&unused_referent);
> +	strbuf_release(&referent);
>   	return ret;
>   }
>   
> @@ -284,11 +293,12 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
>   	struct exclude_existing_options exclude_existing_opts = {0};
>   	struct patterns_options patterns_opts = {0};
>   	struct show_one_options show_one_opts = {0};
> -	int verify = 0, exists = 0;
> +	int verify = 0, exists = 0, unresolved = 0;
>   	const struct option show_ref_options[] = {
>   		OPT_BOOL(0, "tags", &patterns_opts.tags_only, N_("only show tags (can be combined with heads)")),
>   		OPT_BOOL(0, "heads", &patterns_opts.heads_only, N_("only show heads (can be combined with tags)")),
>   		OPT_BOOL(0, "exists", &exists, N_("check for reference existence without resolving")),
> +		OPT_BOOL(0, "unresolved", &unresolved, N_("print out unresolved value of reference")),
>   		OPT_BOOL(0, "verify", &verify, N_("stricter reference checking, "
>   			    "requires exact ref path")),
>   		OPT_HIDDEN_BOOL('h', NULL, &patterns_opts.show_head,
> @@ -314,16 +324,17 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
>   	argc = parse_options(argc, argv, prefix, show_ref_options,
>   			     show_ref_usage, 0);
>   
> -	die_for_incompatible_opt3(exclude_existing_opts.enabled, "--exclude-existing",
> +	die_for_incompatible_opt4(exclude_existing_opts.enabled, "--exclude-existing",
>   				  verify, "--verify",
> -				  exists, "--exists");
> +				  exists, "--exists",
> +				  unresolved, "--unresolved");
>   
>   	if (exclude_existing_opts.enabled)
>   		return cmd_show_ref__exclude_existing(&exclude_existing_opts);
>   	else if (verify)
>   		return cmd_show_ref__verify(&show_one_opts, argv);
> -	else if (exists)
> -		return cmd_show_ref__exists(argv);
> +	else if (exists || unresolved)
> +		return cmd_show_ref__raw(argv, unresolved);
>   	else
>   		return cmd_show_ref__patterns(&patterns_opts, &show_one_opts, argv);
>   }
> diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
> index 33fb7a38fff..11811201738 100755
> --- a/t/t1403-show-ref.sh
> +++ b/t/t1403-show-ref.sh
> @@ -218,6 +218,16 @@ test_expect_success 'show-ref sub-modes are mutually exclusive' '
>   	test_must_fail git show-ref --exclude-existing --exists 2>err &&
>   	grep "exclude-existing" err &&
>   	grep "exists" err &&
> +	grep "cannot be used together" err &&
> +
> +	test_must_fail git show-ref --exclude-existing --unresolved 2>err &&
> +	grep "exclude-existing" err &&
> +	grep "unresolved" err &&
> +	grep "cannot be used together" err &&
> +
> +	test_must_fail git show-ref --verify --unresolved 2>err &&
> +	grep "verify" err &&
> +	grep "unresolved" err &&
>   	grep "cannot be used together" err
>   '
>   
> @@ -286,4 +296,41 @@ test_expect_success '--exists with existing special ref' '
>   	git show-ref --exists FETCH_HEAD
>   '
>   
> +test_expect_success '--unresolved with existing reference' '
> +	commit_oid=$(git rev-parse refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME) &&
> +	cat >expect <<-EOF &&
> +	ref: $commit_oid
> +	EOF
> +	git show-ref --unresolved refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--unresolved with symbolic ref' '
> +	test_when_finished "git symbolic-ref -d SYMBOLIC_REF_A" &&
> +	cat >expect <<-EOF &&
> +	ref: refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +	EOF
> +	git symbolic-ref SYMBOLIC_REF_A refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
> +	git show-ref --unresolved SYMBOLIC_REF_A >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--unresolved with nonexistent object ID' '
> +	oid=$(test_oid 002) &&
> +	test-tool ref-store main update-ref msg refs/heads/missing-oid-2 $oid $ZERO_OID REF_SKIP_OID_VERIFICATION &&
> +	cat >expect <<-EOF &&
> +	ref: $oid
> +	EOF
> +	git show-ref --unresolved refs/heads/missing-oid-2 >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--unresolved with nonexistent reference' '
> +	cat >expect <<-EOF &&
> +	error: reference does not exist
> +	EOF
> +	test_expect_code 2 git show-ref --unresolved refs/heads/not-exist 2>err &&
> +	test_cmp expect err
> +'
> +
>   test_done
> 
> base-commit: b387623c12f3f4a376e4d35a610fd3e55d7ea907
