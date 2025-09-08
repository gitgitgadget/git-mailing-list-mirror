Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8912E7F25
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341441; cv=none; b=oRhZIqroi80jWtjLPDR4gBpO2gWJhdoXpc671UgcLY1c2y3LsyCMVyu+TWcgviV4VhghtMEw2lwtd/+vZaSab5Vjv7C7nU5auXBlC/IDNP2dcWFa8Bxh5g82O78YBeMu06u8qz9olqtC3HNFOK06tT6J+KmMgSyYianmYjD0MFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341441; c=relaxed/simple;
	bh=yW7ln5pjmicFUjjF0BfMn3YQsvqligBi8mC0afwCwdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvTGUUMATW/vfWM5SzRkOl47P5P9JSVtImlj85TeNg4BSQwzNLaA93K109RwJpRqh4JIghazNemh/l4gBGUVG1hTzSraRHGKbWNZ3hmY7C8YKKnqNUNO3BYrtpaMSISb1VUOHSTIzz+Q0KUASsy56Leznf/KpFXEl0FjTHy1Qio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fv5kLMfC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv5kLMfC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso36675115e9.0
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 07:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757341437; x=1757946237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QkppIgIZtyq7hDoaMb2bju2QhO1wkcBxv3xm+aHMD78=;
        b=fv5kLMfCemD1ojNbrFjiRAJ8AMrMs5IJU163uYYrMcL47sshxeHH3AEfavwGTKPVGq
         0WMvsF2rNlSpO9g9VdhztyXxLAm8T4aL3NFlRguIInd/Ft4q4XJzf67l8u3t+QqzsoEe
         HNKOXQ4wraE/gZYjKNKzCDen/0aKAqrmtrjBhFqx/EvuF/28JPaGQ5CuWNI9w5qv+1zR
         GFjfqsnqXq0pBBeg8koi2J3K/DmLFdzK2B23OF3Z8nnI1cjvuEsnKkQZOFEFeR6BXcsk
         Hholh8vY2PGe1DdgPEP/MagSbMgvZxNVQVO89WOdGc+oO6BvwpWVIOn8SOVnOF92dMh+
         Nypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757341437; x=1757946237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QkppIgIZtyq7hDoaMb2bju2QhO1wkcBxv3xm+aHMD78=;
        b=ddKWW8htq70LR5FBfDB5P2RacqCPsepHjrd/jWS3lCEPv4XGmztIvfuA1rygg9QoyK
         P5nMQnec4nUR3UyQQcR+VKYPRw9WWOcOJV5fZaVZrLPtN94cdTYNjqAxOghhOUpx4SgI
         wjL4k7OJ9fe9FAh+a1aNtJv0pNfrIv0y0DC8M3T+N0jvyCgxQ3wy9KAzB6CFul/QsWqx
         BZQQ8IhJo3o976WRY3QT0VyXJYxiYAO5J1xLdbdyOkQXi8qx1VszFhmhOKS5Pm0UlgaM
         ktaQUv58WJRYCboLjm2MoGMCPfVnLy0VTfC+7h7uE2G6EWNoh+LvJLdv4Z1leGPvMkNR
         7OIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtFSLmCSGdynPT+wdgbR5bIaxqbnq8aHwyKhYoxrWbcs4FXdux6sjZwCv8XtKUMUXGMyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1/+IivaIJBDmY7L138msXItjt67f+mKakjJmWsbN8j7BotF7Y
	z7pewwQayLeWBxxoqAkhnuBszU7LhFY7PTghTUYHBQMP2DfSxnyIx6eMEPIWJSJ2
X-Gm-Gg: ASbGnctiVmonwQAXYAHqH9qcqUFnS17ewsCDB1K98Hjf+6PcM8rhndUUsq0q96xwW2d
	haDDFNKlU4yvQEYj/lstUpXoLgNOaLAXjk1YUK4ovyIQZ7WPGuYoWb3nYnsSHJDAs/HfXl5tDlp
	B72fIyNkxK6n9vuFVCyFmQ3N1M1xoY3/7P2UN/QUq+iKI6grzd5AxIU58YjwKmmRFL88ejF9467
	c6puEesr3HOxZ/npCp6mZBh4LdX0AnoaNvRs+mAo7kNB++SNqnWKvIrBgLA7hp85hmVM73RiRLQ
	wLuOVBvevVUS4/R7ZmGaQ/ufJTKmKim1/XncJOgC+JhNzohMZME+ywmKHNEOIxYm1TjbWt3yz1h
	1hSsr2osozQSBXSYJxcDIU8HeaqLpbQVYEyiB0JxTBvqsLqc2P7h/DlBKg8BHk+ur/HZV9Nv+1N
	uT70yB
X-Google-Smtp-Source: AGHT+IHXdx6+vfIku0VPK0bYj0vIKr7df/nJyo8OVej9FuouA5ow6SDcLLIQ7LRV/diwhxORFh4Kpg==
X-Received: by 2002:a05:600c:3b1d:b0:45b:8ac2:9761 with SMTP id 5b1f17b1804b1-45dde20e5c0mr75310815e9.13.1757341437163;
        Mon, 08 Sep 2025 07:23:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda202112sm147345535e9.5.2025.09.08.07.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 07:23:56 -0700 (PDT)
Message-ID: <ee61c97a-63a5-4c81-8859-09b896bdcf42@gmail.com>
Date: Mon, 8 Sep 2025 15:23:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/9] submodule: add gitdir path config override
To: Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
 Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>,
 Jonathan Nieder <jrnieder@gmail.com>, Stefan Beller <sbeller@google.com>,
 Patrick Steinhardt <ps@pks.im>, Brandon Williams <bmwill@google.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250816213642.3517822-4-adrian.ratiu@collabora.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250816213642.3517822-4-adrian.ratiu@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adrian

On 16/08/2025 22:36, Adrian Ratiu wrote:
> This adds an ability to override gitdir paths via config files
> (not .gitmodules), such that any encoding scheme can be changed
> and JGit & co don't need to exactly match the default encoding.

Reading the old email thread you linked to in the cover letter, my 
understanding is that this was suggested as an alternative to changing 
the gitdir for submodules from "modules" to "submodules". Do the later 
patches set this key when encoding the gitdir so that JGit can find the 
gitdir by reading the config?

Thanks

Phillip

> A new test and a helper are added. The helper will be used by
> further tests exercising gitdir paths & encodings.
> 
> Based-on-patch-by: Brandon Williams <bmwill@google.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>   builtin/submodule--helper.c           | 17 +++++++++++++++++
>   submodule.c                           | 11 +++++++++++
>   t/lib-verify-submodule-gitdir-path.sh | 15 +++++++++++++++
>   t/t7400-submodule-basic.sh            | 15 +++++++++++++++
>   4 files changed, 58 insertions(+)
>   create mode 100644 t/lib-verify-submodule-gitdir-path.sh
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 7243429c6f..30e40d6c79 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1214,6 +1214,22 @@ static int module_summary(int argc, const char **argv, const char *prefix,
>   	return ret;
>   }
>   
> +static int module_gitdir(int argc, const char **argv, const char *prefix UNUSED,
> +			 struct repository *repo UNUSED)
> +{
> +	struct strbuf gitdir = STRBUF_INIT;
> +
> +	if (argc != 2)
> +		usage(_("git submodule--helper gitdir <name>"));
> +
> +	submodule_name_to_gitdir(&gitdir, the_repository, argv[1]);
> +
> +	printf("%s\n", gitdir.buf);
> +
> +	strbuf_release(&gitdir);
> +	return 0;
> +}
> +
>   struct sync_cb {
>   	const char *prefix;
>   	const char *super_prefix;
> @@ -3597,6 +3613,7 @@ int cmd_submodule__helper(int argc,
>   		NULL
>   	};
>   	struct option options[] = {
> +		OPT_SUBCOMMAND("gitdir", &fn, module_gitdir),
>   		OPT_SUBCOMMAND("clone", &fn, module_clone),
>   		OPT_SUBCOMMAND("add", &fn, module_add),
>   		OPT_SUBCOMMAND("update", &fn, module_update),
> diff --git a/submodule.c b/submodule.c
> index dbf2244e60..bf78636195 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2611,6 +2611,17 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
>   	 * administrators can explicitly set. Nothing has been decided,
>   	 * so for now, just append the name at the end of the path.
>   	 */
> +	char *gitdir_path, *key;
> +
> +	/* Allow config override. */
> +	key = xstrfmt("submodule.%s.gitdirpath", submodule_name);
> +	if (!repo_config_get_string(r, key, &gitdir_path)) {
> +		strbuf_addstr(buf, gitdir_path);
> +		free(key);
> +		free(gitdir_path);
> +		return;
> +	}
> +	free(key);
>   
>   	/* Legacy behavior: allow existing paths under modules/<name>. */
>   	repo_git_path_append(r, buf, "modules/");
> diff --git a/t/lib-verify-submodule-gitdir-path.sh b/t/lib-verify-submodule-gitdir-path.sh
> new file mode 100644
> index 0000000000..fb5cb8eea4
> --- /dev/null
> +++ b/t/lib-verify-submodule-gitdir-path.sh
> @@ -0,0 +1,15 @@
> +# Helper to verify if repo $1 contains a submodule named $2 with gitdir in path $3
> +
> +verify_submodule_gitdir_path() {
> +	repo="$1" &&
> +	name="$2" &&
> +	path="$3" &&
> +	(
> +		cd "$repo" &&
> +		cat >expect <<-EOF &&
> +			$(git rev-parse --git-common-dir)/$path
> +		EOF
> +		git submodule--helper gitdir "$name" >actual &&
> +		test_cmp expect actual
> +	)
> +}
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 178c386212..f4d4fb8397 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -13,6 +13,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
>   . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-verify-submodule-gitdir-path.sh
>   
>   test_expect_success 'setup - enable local submodules' '
>   	git config --global protocol.file.allow always
> @@ -1505,4 +1506,18 @@ test_expect_success 'submodule add fails when name is reused' '
>   	)
>   '
>   
> +test_expect_success 'submodule helper gitdir config overrides' '
> +	verify_submodule_gitdir_path test-submodule child submodules/child &&
> +	(
> +		cd test-submodule &&
> +		git config submodule.child.gitdirpath ".git/submodules/custom-child"
> +	) &&
> +	verify_submodule_gitdir_path test-submodule child submodules/custom-child &&
> +	(
> +		cd test-submodule &&
> +		git config --unset submodule.child.gitdirpath
> +	) &&
> +	verify_submodule_gitdir_path test-submodule child submodules/child
> +'
> +
>   test_done

