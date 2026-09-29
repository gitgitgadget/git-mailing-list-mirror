Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2237E3E1231
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698094; cv=none; b=iWBBPA4pBqt+BC4UMYIsd75jlTCfHOWh8KSNyncA7L5mGNZ6eKDpaBqZMYglaBZvcJiv0JmalmDdcOCUapgL3rcQ8hnBPhNZM5MgaWzhvoh6iwGL8k7ynhn485bJv/5OyydSUHazeWWWfqIZ1Jhqia1UAS4Kayg1tW1MBLneEDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698094; c=relaxed/simple;
	bh=vY/iaReErIiB5MzcNs+o+TN/RIYQRUwUTdUhIhn4BDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWfeg0OcozQja+beBVrrM9vlFXr+dbUIHB6tafaEzE4GyG/IqTn4Gdkk2Cw1GM2MbfyORgbK1foLNTt4ixwuilJsOF5cqyBAsCACsOiiwpkhzlQ0AVMc2bUUymhUkSysTPVOANzpBwhHuXafaBNIPh6jv1qirEbpOhQ/qmILbI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aj8rlKMM; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aj8rlKMM"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4888129c46eso2504822f8f.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 09:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790698090; x=1791302890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ylblueT4bobeIc/eGL0wf4c8/p4JtvOnYYzUwIDEmkI=;
        b=Aj8rlKMMCHF6KAxGlNP3Nu7nZtSEH5QFUS+pWSFHANhZ++/lwk7OUJIjY6ydOT8JAw
         eMsB5pkaczMV1bAMbNVarDLW7IhARPsNX2AztIqbaU3vjiBAVmFYMFCeUT+S9prWtbFQ
         lixBGjyzUc/qdxfvMYZ7VDXwcFVPwA98BHPt9gBI26BQa1ZZcX/R8ctEBPAYYEx8lt3Q
         zNnNXify6KxkJBXPR8men0yumlbw+wXBkieZM4C478ZgQMEYMSURx8MqocBjUgvqtsCf
         gf6py2kcpqBleWUlE9ILG66FAO5+F0Xyp6W/59eVhgQasdKfmfUsYVKPW3ECQaIvkogi
         W0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790698090; x=1791302890;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ylblueT4bobeIc/eGL0wf4c8/p4JtvOnYYzUwIDEmkI=;
        b=HSCD7ok/uGsHa3mOV93I9auUDRfJFRkG0+ITN+xwQRMFIi/x4f0EqrMRLcLMVbSLcl
         Ihm6E612bGlOcrj9DwCqVnwY8eirTZPcnvnDXwxrWlCF8ytOENPJMMSTJet3VP6jEGQ6
         PVLAekYh6flZcvuejDFIECIQYSVkYlJLU0WUC2woLi5lXvdsZNsX9eAUJoD0FhBT2stM
         1EGaKG7xBw2bKKK7w0S7S+e+ZAT7bkzh09tly5pYb5K1GZRW3/fx1FyH6LKlzoCa/WeA
         1KDDdugbh/77EwP4f3XJ18h2uwViyqPXdc0ZcRJCoK7d5+JVZdeQ1HjQFlOURj4B516u
         aWxA==
X-Forwarded-Encrypted: i=1; AKwUvByp3qndlcxPy+Xi1Q5yn/WBdS7mhdgDss8YLJH0U2NI3OGbIkzqFjkfRT+kEH+RpnrtyFg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOw6HBd2GZ0YHoXifOU9ciqobE9t1N+3yIJ0Y5ciKqGMVM/NNm
	zmmXeB7EXdlvUFXjOw/XQRJCwmiCnYthyvAwcqY7EAE5SsxlX8r19rBs
X-Gm-Gg: AYBFou20W2b8HfP1jUu2i25ieZqVnKFDXMVjF2aeEKJtyEKPz5/R8msRAyNMwzUauSC
	be0/wNTC7x7Nmj/7mHDrpLDq/8g8+mtxhfZksCJaPizFape9ROEW6QybUUkeQSs7+OTdXE7c0vS
	IkpL1JmgkRZhrLPnjhtmnF2nGvvZFbhNAJmyWP0VrC5nehWkMgz93sa9gYTxPTpXWmZHd9WfY4l
	XrVVSLnnlvsBL7P75kUtFbG/pTSFGtUQ+OjwssHkBFwGir0pycO85Fh5HWbyruEEJnC8ntBlPZG
	C2lRPWSLAgDdYjhD8r5lBIGz2YcPM4CemM8GL3fc4CACqrS18j9TY4lRjpQuW70uZVGU+dB4Pbs
	yawL4hsOdchqUwCBxfumNtSlkDNQ3yTrwBmr5e+9kpPS7c1SaggRBXkKTTqJFA6bDrXOlIGc3n9
	Ay+mE5pdmY8xM4eOEzXuKtd+fQTvBAjFUVqUIlNyGHsF7ZbtSNSe1HVUmoI5G1AH5I96pwqBXnh
	fxF+7vgU5vwDlCajCQedXkV9qUm366XRuGq5BgeoQsq4zqrS9m13A==
X-Received: by 2002:a05:6000:29c2:b0:488:79d6:a4a6 with SMTP id ffacd0b85a97d-48879d6a64fmr18149334f8f.8.1790698089558;
        Tue, 29 Sep 2026 09:08:09 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af502f40dsm5340412f8f.10.2026.09.29.09.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 09:08:09 -0700 (PDT)
Message-ID: <8453ebd1-77c1-4941-afbf-572f9e7b12c1@gmail.com>
Date: Tue, 29 Sep 2026 17:08:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] stash: expose untracked modes in create
To: Kazumasa Shigeta <kazumasa.shigeta@kanamei.com>, git@vger.kernel.org
Cc: Shabbir Bhojani <shabbir.r.bhojani@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kazumasa

On 29/09/2026 08:42, Kazumasa Shigeta wrote:
> `git stash create` always passes zero for the include_untracked parameter
> of do_create_stash(), even though that helper already supports untracked
> and ignored files and stash push/save expose those modes as
> -u/--include-untracked and -a/--all.
> 
> Teach create to accept the same options and pass the existing mode
> through. Unlike push/save, create continues to only create objects: it
> does not update refs/stash or modify the index or working tree.
> 
> When the selected mode finds no changes, do_create_stash() returns 1.
> Translate that to success so create keeps its existing no-object, empty
> output behavior.

This doesn't seem to match the code changes. The code that prints the 
object id when the stash is successfully created is unchanged, as far as 
I can see what this patch does is change the exit status for "git stash 
create" when there are no changes to stash. Instead of exiting 1, it 
exits 0 even though it does not create a stash. That does not seem like 
a good idea.

> Use normal parse-options semantics, so options may appear after message
> arguments. A message that begins with a dash can be disambiguated with

As "git stash create" concatenates excess arguments to use as the stash 
message we should not be permuting options. "git stash create handle new 
-u flag" should continue to create a stash with the message "handle new 
-u flag" - it should not start stashing untracked files. You should pass 
PARSE_OPT_STOP_AT_NON_OPTION to parse_options() to prevent that.

> I proposed adding both --include-untracked and --all to
> "git stash create" in 2014:
>    <1403856479-37421-1-git-send-email-shigeta@kanamei.co.jp>
> 
> I should also apologize for dropping that thread after receiving review.
> I did not follow up on the comments at the time.  Thanks to those who
> reviewed it then.

Better late than never! I think the idea is fine, but the implementation 
could do with a couple of tweaks so it is as backward compatible as 
possible.

Thanks

Phillip

> Separately, in 2017, Thomas Gummerer added an internal -u path while
> refactoring stash_create in 9ca6326dff29 (stash: refactor stash_create).
> That change explicitly kept the user interface of "git stash create"
> unchanged.
> 
> When "stash create" was later converted to the builtin C implementation
> in d4788af875cc (stash: convert create to builtin), the untracked-file
> handling was carried into the new implementation and remains there today.
> 
> More recently, Shabbir Bhojani proposed exposing --include-untracked:
>    <pull.1892.git.1774768580147.gitgitgadget@gmail.com>
> 
> This patch exposes both existing untracked modes, --include-untracked and
> --all, to "git stash create".
> 
>   Documentation/git-stash.adoc | 18 ++++++----
>   builtin/stash.c              | 36 ++++++++++++++-----
>   t/t3903-stash.sh             | 70 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 109 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
> index fc6a9a0..32f0fd5 100644
> --- a/Documentation/git-stash.adoc
> +++ b/Documentation/git-stash.adoc
> @@ -21,7 +21,7 @@ git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | -
>   git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
>              [-u | --include-untracked] [-a | --all] [<message>]
>   git stash clear
> -git stash create [<message>]
> +git stash create [-u | --include-untracked] [-a | --all] [<message>]
>   git stash store [(-m | --message) <message>] [-q | --quiet] <commit>
>   git stash export (--print | --to-ref <ref>) [<stash>...]
>   git stash import <commit>
> @@ -138,10 +138,12 @@ with no conflicts.
>   `drop [-q | --quiet] [<stash>]`::
>   	Remove a single stash entry from the list of stash entries.
>   
> -`create`::
> +`create [-u | --include-untracked] [-a | --all]`::
>   	Create a stash entry (which is a regular commit object) and
>   	return its object name, without storing it anywhere in the ref
> -	namespace.
> +	namespace.  The `--include-untracked` option includes untracked
> +	files, while `--all` also includes ignored files, without modifying
> +	the working tree.
>   	This is intended to be useful for scripts.  It is probably not
>   	the command you want to use; see "push" above.
>   
> @@ -167,10 +169,11 @@ OPTIONS
>   -------
>   `-a`::
>   `--all`::
> -	This option is only valid for `push` and `save` commands.
> +	When used with the `push` and `save` commands, all ignored and
> +	untracked files are also stashed and then cleaned up with `git clean`.
>   +
> -All ignored and untracked files are also stashed and then cleaned
> -up with `git clean`.
> +When used with the `create` command, ignored and untracked files are included
> +in the stash entry without modifying the working tree.
>   
>   `-u`::
>   `--include-untracked`::
> @@ -179,6 +182,9 @@ up with `git clean`.
>   	all untracked files are also stashed and then cleaned up with
>   	`git clean`.
>   +
> +When used with the `create` command, untracked files are included in the
> +stash entry without modifying the working tree.
> ++
>   When used with the `show` command, show the untracked files in the stash
>   entry as part of the diff.
>   
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 7a98434..57a4750 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -59,7 +59,7 @@
>   	N_("git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n" \
>   	   "          [-u | --include-untracked] [-a | --all] [<message>]")
>   #define BUILTIN_STASH_CREATE_USAGE \
> -	N_("git stash create [<message>]")
> +	N_("git stash create [-u | --include-untracked] [-a | --all] [<message>]")
>   #define BUILTIN_STASH_EXPORT_USAGE \
>   	N_("git stash export (--print | --to-ref <ref>) [<stash>...]")
>   #define BUILTIN_STASH_IMPORT_USAGE \
> @@ -119,6 +119,11 @@ static const char * const git_stash_clear_usage[] = {
>   	NULL
>   };
>   
> +static const char * const git_stash_create_usage[] = {
> +	BUILTIN_STASH_CREATE_USAGE,
> +	NULL
> +};
> +
>   static const char * const git_stash_store_usage[] = {
>   	BUILTIN_STASH_STORE_USAGE,
>   	NULL
> @@ -1643,26 +1648,39 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
>   	return ret;
>   }
>   
> -static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
> +static int create_stash(int argc, const char **argv, const char *prefix,
>   			struct repository *repo UNUSED)
>   {
> -	int ret;
> +	int ret = 0;
> +	int include_untracked = 0;
> +	struct option options[] = {
> +		OPT_BOOL('u', "include-untracked", &include_untracked,
> +			 N_("include untracked files in stash")),
> +		OPT_SET_INT('a', "all", &include_untracked,
> +			    N_("include ignored files in stash"),
> +			    INCLUDE_ALL_FILES),
> +		OPT_END()
> +	};
>   	struct strbuf stash_msg_buf = STRBUF_INIT;
>   	struct stash_info info = STASH_INFO_INIT;
>   	struct pathspec ps;
>   
> -	/* Starting with argv[1], since argv[0] is "create" */
> -	strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash_create_usage, 0);
> +	strbuf_join_argv(&stash_msg_buf, argc, argv, ' ');
>   
>   	memset(&ps, 0, sizeof(ps));
> -	if (!check_changes_tracked_files(&ps))
> -		return 0;
> +	if (!include_untracked && !check_changes_tracked_files(&ps))
> +		goto done;
>   
> -	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
> -			      NULL, 0);
> +	ret = do_create_stash(&ps, &stash_msg_buf, include_untracked, 0, NULL,
> +			      0, &info, NULL, 0);
>   	if (!ret)
>   		printf_ln("%s", oid_to_hex(&info.w_commit));
> +	else if (ret == 1)
> +		ret = 0;
>   
> +done:
>   	free_stash_info(&info);
>   	strbuf_release(&stash_msg_buf);
>   	return ret;
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 7211586..fe34879 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -640,6 +640,76 @@ test_expect_success 'stash create - no changes' '
>   	test_must_be_empty actual
>   '
>   
> +# --all observes every untracked and ignored path in the worktree.  Use one
> +# isolated repository for these checks so unrelated test state is not captured.
> +test_expect_success 'stash create with untracked options' '
> +	test_when_finished "rm -rf stash-create-options" &&
> +	test_create_repo stash-create-options &&
> +	(
> +		cd stash-create-options &&
> +		test_commit base tracked base &&
> +		echo create-ignored >.gitignore &&
> +		git add .gitignore &&
> +		git commit -m ignore &&
> +
> +		git stash create -u >.git/actual &&
> +		test_must_be_empty .git/actual &&
> +		git stash create -a >.git/actual &&
> +		test_must_be_empty .git/actual &&
> +
> +		echo untracked >create-untracked &&
> +		git stash create "without untracked" >.git/actual &&
> +		test_must_be_empty .git/actual &&
> +		short=$(git stash create "create untracked" -u) &&
> +		long=$(git stash create --include-untracked "create untracked") &&
> +		test_cmp_rev "$short^3^{tree}" "$long^3^{tree}" &&
> +		echo untracked >.git/expect &&
> +		git show "$short^3:create-untracked" >.git/actual &&
> +		test_cmp .git/expect .git/actual &&
> +		branch=$(git symbolic-ref --short HEAD) &&
> +		echo "On $branch: create untracked" >.git/expect &&
> +		git show --pretty=%s -s "$short" >.git/actual &&
> +		test_cmp .git/expect .git/actual &&
> +		test_path_is_file create-untracked &&
> +
> +		echo ignored >create-ignored &&
> +		with_untracked=$(git stash create -u "create options") &&
> +		test_must_fail git cat-file -e "$with_untracked^3:create-ignored" &&
> +		short=$(git stash create "create options" -a) &&
> +		long=$(git stash create --all "create options") &&
> +		test_cmp_rev "$short^3^{tree}" "$long^3^{tree}" &&
> +		echo ignored >.git/expect &&
> +		git show "$short^3:create-ignored" >.git/actual &&
> +		test_cmp .git/expect .git/actual &&
> +		test_path_is_file create-untracked &&
> +		test_path_is_file create-ignored &&
> +
> +		echo staged >staged &&
> +		git add staged &&
> +		echo modified >>tracked &&
> +		git diff >.git/before-worktree &&
> +		git diff --cached >.git/before-index &&
> +		git status --porcelain=v1 --ignored >.git/before-status &&
> +		test_must_fail git rev-parse --verify refs/stash >/dev/null 2>&1 &&
> +		STASH_ID=$(git stash create -a -- -create-message) &&
> +		git diff >.git/after-worktree &&
> +		git diff --cached >.git/after-index &&
> +		git status --porcelain=v1 --ignored >.git/after-status &&
> +		test_cmp .git/before-worktree .git/after-worktree &&
> +		test_cmp .git/before-index .git/after-index &&
> +		test_cmp .git/before-status .git/after-status &&
> +		test_must_fail git rev-parse --verify refs/stash >/dev/null 2>&1 &&
> +		echo "On $branch: -create-message" >.git/expect &&
> +		git show --pretty=%s -s "$STASH_ID" >.git/actual &&
> +		test_cmp .git/expect .git/actual
> +	)
> +'
> +
> +test_expect_success 'stash create rejects unknown options' '
> +	test_expect_code 129 git stash create --unknown-option 2>err &&
> +	test_grep "unknown option" err
> +'
> +
>   test_expect_success 'stash branch - no stashes on stack, stash-like argument' '
>   	git stash clear &&
>   	test_when_finished "git reset --hard HEAD" &&

