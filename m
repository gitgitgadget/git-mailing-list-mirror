Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451F0160860
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722462752; cv=none; b=ZZVyShja7O/Y0p9PlPZnDfwJW+aw0wroTKEH7Eh1LItfPMS3qvT7Q3nwI1W9PuPORJynrQFN14WbZsWrMdBqe5knNXr6JIhjjvjKaepsjXsDVgurfHCL+qLXMTv9Gn3zNiQV0Bl57bT5VAfAvYz9I/XIneKXvBZREgW8pev1k4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722462752; c=relaxed/simple;
	bh=aX1hfDfeXbx1lK3HtWFLM89V7mNRSSk8MFVbHEiLGkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ty/T9UYoTogc8jc5MRkG4vKRclMfzTy4dUwo9OXRNfp0X2crTrAhEhbkBwHDHhvHaRDToJMz5ru86PB7y9/1i9+HysqPODmvUG9JMvWBuvqKjsISMdJHo5A6Bdpwjqsx1VRkX0KAq4d+P0l/W4hcufA36Zzk1BsuyA6M8SrO1wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7LU5wB5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7LU5wB5"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428243f928fso26844885e9.0
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 14:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722462748; x=1723067548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bLWibALzAw9cOAsZfWHvpv4+9qQ3h7y9+x1xBNBFWbs=;
        b=k7LU5wB5iGa9bIU4yVtDLJdL2faimvGrXrDgjf76M4holVJScB0qQqz908Bh81wnTx
         QiNJRLBz7oMlCD1Udm2zeBKNLB9rUZIWmZHuOBLNPjoMETnvaJyJDegTu2BuT3qhglcO
         sC5xF1KWxKa/xA4WsI81Zh7eCp79g7NU4nFPJazda/aOZgJT6/2qF85Gq1UXHjq7iwbI
         zXPJWH8J7F3oxPWrm4EMj/QHLhq3zLRzM4WjxmW7c0EJuB19otD7joHB1YqYn/JmJTA/
         C6+BSnCP70Prwss71fw4k2aoWJeTGJZ44lVgJzMdcYFsHkdaM7v21Yu/nlND6ljDTuc7
         qOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722462748; x=1723067548;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bLWibALzAw9cOAsZfWHvpv4+9qQ3h7y9+x1xBNBFWbs=;
        b=uwhmGgG6rSF3ntwwDDEJOywA9+RqB6dc1QmlXeJbw+G3HDrebPyW5IQGVkVyrr/Adb
         9MJwxpRKKks1yE9fRHymx5zM0v6Gl4TbGl6om2ck5HgY0TGDcWjkMYEGBRifPm9JIUgr
         ppSgiwFUdKDgZHIUSIifp44tAIpNzXl7HbuPovThLzZB8ravTR7CBvtasQwya/WbMcPZ
         2Gy/7wz2tXAV6ey+biyK0sALre8QJ4neTmmSq4BcOSC17c3LtNBR/AZJ98A+gTmfmdU4
         Ls3/yOxufqvAgkOBJAAkByr/Pc0+Y9H5LmjMfvi3BfAfZfIbU1ca4qP3XrSo0QUffEh9
         o96Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJp8LM2v0c6/1eFiV0+ZjvtbmGI9Gl6rT25D6fb6v1U5PJvLFVzN3lLOguiFLYDckPbQuE9xChzwjfqHCewyiO8m8v
X-Gm-Message-State: AOJu0YzCBI1sfXSkEilYIeqUK0Lq1yGyb2RfLzTJFNpZ6o29mrvDwe0/
	Jt9mGUaYYMfQWwOUFAOw9ZPXFDhLUONhD7GOlZU6j7Kl7n7AcUvGKiucRA==
X-Google-Smtp-Source: AGHT+IFwC3hXwp6F7llPRw0cc+bOUD41xvwsMbmCT2/EOpDkyQM+479IC7g+YFvxiWNdWMcwqlxqKg==
X-Received: by 2002:a05:600c:4750:b0:426:5c81:2538 with SMTP id 5b1f17b1804b1-428a9bdb92bmr7492905e9.14.1722462748055;
        Wed, 31 Jul 2024 14:52:28 -0700 (PDT)
Received: from gmail.com (160.red-88-14-42.dynamicip.rima-tde.net. [88.14.42.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bab9f7esm33741165e9.21.2024.07.31.14.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 14:52:27 -0700 (PDT)
Message-ID: <82f4bef1-57d9-4427-8316-5e63b573931d@gmail.com>
Date: Wed, 31 Jul 2024 23:52:26 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/23] builtin/submodule--helper: fix various trivial
 memory leaks
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1721995576.git.ps@pks.im>
 <5220c91bda7bc766368c2925499e5d244a03697b.1721995576.git.ps@pks.im>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <5220c91bda7bc766368c2925499e5d244a03697b.1721995576.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Jul 26, 2024 at 02:15:09PM +0200, Patrick Steinhardt wrote:

> There are multiple trivial memory leaks in the submodule helper. Fix
> those.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

Hi Patrick,

While working on another series, I fixed some leaks.  But, I haven't
sent any patches.

The series this message belongs to fixes all the leaks that my unsent
series addresses.  So, I won't bother sending my patches.

However, I think we can do better for the second leak solved in this
patch.  I leave my patch at the end of this message in case you want
to take a look.

In any case, thanks for working on this.  I have the habit of having
"SANITIZE=leak" in my config.mak, so this series will make me have
fewer distractions :)

> ---
>  builtin/submodule--helper.c | 13 ++++++++++---
>  t/t7400-submodule-basic.sh  |  1 +
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f1218a1995..5ae06c3e0b 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2269,6 +2269,7 @@ static int is_tip_reachable(const char *path, const struct object_id *oid)
>  	struct child_process cp = CHILD_PROCESS_INIT;
>  	struct strbuf rev = STRBUF_INIT;
>  	char *hex = oid_to_hex(oid);
> +	int reachable;
>  
>  	cp.git_cmd = 1;
>  	cp.dir = path;
> @@ -2278,9 +2279,12 @@ static int is_tip_reachable(const char *path, const struct object_id *oid)
>  	prepare_submodule_repo_env(&cp.env);
>  
>  	if (capture_command(&cp, &rev, GIT_MAX_HEXSZ + 1) || rev.len)
> -		return 0;
> +		reachable = 0;
> +	else
> +		reachable = 1;
>  
> -	return 1;
> +	strbuf_release(&rev);
> +	return reachable;
>  }
>  
>  static int fetch_in_submodule(const char *module_path, int depth, int quiet,
> @@ -3135,6 +3139,7 @@ static void append_fetch_remotes(struct strbuf *msg, const char *git_dir_path)
>  static int add_submodule(const struct add_data *add_data)
>  {
>  	char *submod_gitdir_path;
> +	char *depth_to_free = NULL;
>  	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
>  	struct string_list reference = STRING_LIST_INIT_NODUP;
>  	int ret = -1;
> @@ -3200,7 +3205,7 @@ static int add_submodule(const struct add_data *add_data)
>  		}
>  		clone_data.dissociate = add_data->dissociate;
>  		if (add_data->depth >= 0)
> -			clone_data.depth = xstrfmt("%d", add_data->depth);
> +			clone_data.depth = depth_to_free = xstrfmt("%d", add_data->depth);
>  
>  		if (clone_submodule(&clone_data, &reference))
>  			goto cleanup;
> @@ -3223,7 +3228,9 @@ static int add_submodule(const struct add_data *add_data)
>  			die(_("unable to checkout submodule '%s'"), add_data->sm_path);
>  	}
>  	ret = 0;
> +
>  cleanup:
> +	free(depth_to_free);
>  	string_list_clear(&reference, 1);
>  	return ret;
>  }
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 981488885f..098d8833b6 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -12,6 +12,7 @@ subcommands of git submodule.
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
> +TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  
>  test_expect_success 'setup - enable local submodules' '
> -- 
> 2.46.0.rc1.dirty
> 

----- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] submodule--helper: depth clone parameter

The `clone` subcommand has an OPT_STRING parameter: `--depth`, that
eventually is used when invoking `git-clone`.

As `git-clone` only support positive integer values for `--depth`
since 5594bcad21 (clone,fetch: catch non positive `--depth` option
value, 2013-12-05), seems safe to change the `--depth` parameter to
OPT_INTEGER in `module_clone`.

Doing so we avoid a leak in `add_submodule`.

Do it.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/submodule--helper.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f1218a1995..e7d52f38d9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1530,7 +1530,7 @@ struct module_clone_data {
 	const char *path;
 	const char *name;
 	const char *url;
-	const char *depth;
+	int depth;
 	struct list_objects_filter_options *filter_options;
 	unsigned int quiet: 1;
 	unsigned int progress: 1;
@@ -1729,8 +1729,8 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 			strvec_push(&cp.args, "--quiet");
 		if (clone_data->progress)
 			strvec_push(&cp.args, "--progress");
-		if (clone_data->depth && *(clone_data->depth))
-			strvec_pushl(&cp.args, "--depth", clone_data->depth, NULL);
+		if (clone_data->depth > 0)
+			strvec_pushf(&cp.args, "--depth=%d", clone_data->depth);
 		if (reference->nr) {
 			struct string_list_item *item;
 
@@ -1851,8 +1851,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 			   N_("reference repository")),
 		OPT_BOOL(0, "dissociate", &dissociate,
 			   N_("use --reference only while cloning")),
-		OPT_STRING(0, "depth", &clone_data.depth,
-			   N_("string"),
+		OPT_INTEGER(0, "depth", &clone_data.depth,
 			   N_("depth for shallow clones")),
 		OPT__QUIET(&quiet, "suppress output for cloning a submodule"),
 		OPT_BOOL(0, "progress", &progress,
@@ -3199,8 +3198,7 @@ static int add_submodule(const struct add_data *add_data)
 			string_list_append(&reference, p)->util = p;
 		}
 		clone_data.dissociate = add_data->dissociate;
-		if (add_data->depth >= 0)
-			clone_data.depth = xstrfmt("%d", add_data->depth);
+		clone_data.depth = add_data->depth;
 
 		if (clone_submodule(&clone_data, &reference))
 			goto cleanup;
-- 
2.45.1
