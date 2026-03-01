Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A38919EED3
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772361231; cv=none; b=LzDMwAfOPdJDs0io8XH8+MZByqhvwwgsw0DTF2swFklsQ2cYQ4yMJzWVur71kSH4rRyY16Qlm6c2wyQYBySSQ77J/R4oTrPE0jkMs5kQofdK8dRKloHSq+amTb/xdq8KVmlKpf8wVFY6gmUeKufAa8gmCMjjqiHrLOOQ0wCB8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772361231; c=relaxed/simple;
	bh=qceXE21irU1ZUOIBPYH66sbnmdw3/ibQNX36DGp7+Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ni4gAdW8EQJ+d9cQYZVT3e6eFneRRCQuS5zZulb/9VugppdTSmNgiy8yVMpuRNc/EmmFBJEqu99GdfjMNY7j2ZMFtqro5cx89rU6vBge39DOY/wsUUmkUyAm8BgnxcJGbzZOyHRVNsHlwmujiTCnm9w1uDWsuC/JwUAkKSruugQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOcp0VQs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOcp0VQs"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4807068eacbso28438425e9.2
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 02:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772361228; x=1772966028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lymB84kfzX0wNWlVbxUGUUjAa/WUhL8jGkzPd7KxP1g=;
        b=KOcp0VQsBgT8ud5S+cZy19fIDdV0jJTLemAzIkO66YGzF65ccg1k8cZDdVcD6+smTN
         1zgYKRjmh9g1X/vJEu+14XT1I5/H++HNAZchTt7/jsIlKNUgoXyyv03+xZUbrhFse56T
         2azlfrCK/tpop9uLc7IeEVT1eMS/flt3SerE4JcpjGjNleiz99NKNcxXVNRzJWh8vQfo
         +V4YjU6z7ifMciMeKuRYvrZvQ939rR6+LL53oVQC/lS2WG4M2RpdVvAxTAU/bt8Z3P5D
         39SqOKhMkBMrxxcmEwrLfQ+/fXrzEGwsNN6bQpuzH/ceD5QOIV5sYRS3RGJGCYeUzxxo
         uDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772361228; x=1772966028;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lymB84kfzX0wNWlVbxUGUUjAa/WUhL8jGkzPd7KxP1g=;
        b=NKwi+CrLe46YmUC3dToGWT6pI3iI/+hI44CtR4CpeGX5nnMzaMdBEyH9zNrlWQ+WHX
         Mk0QhwznYAxmklBReeLjny12PkAQ5Ifiljtm1p0bllacKjlzh4zoIfcPdIi+g3JLyxGp
         KdUibueJJ/BLKSagUc8iD6jnkYituoA+LAIlv1aJSxgSS4kHIjc4q82nfsfX7x/l7h+r
         mUAEPHGKS9xu327VczFxIbsJtcug/EQlpyIwjhYrA4ipUrTIrtDdZBJadPtw/Xx4WeMF
         iW35fVqYWdJFv0GphInxr5t+oyhiBz4EdqrMlldtM+ECeDOjfu8Zr+z+Ey+EDNF109Uu
         f/8w==
X-Forwarded-Encrypted: i=1; AJvYcCUv5QVue3HvSpMC1Bhx1nr/eBiwRnuYPUNOvaujL5U3V2wiyIFBI9kMyItIGwSKxWGIiDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA4OMsK9prTUb8aYaJpGWHNUHbym3JnZ02N99gz8IknpkBKEgF
	k44qIa+l9uCuCaDNd6voXeXYZWrdcjdR0Vq68P21PLp9FLS2gEt54rWw
X-Gm-Gg: ATEYQzzGk+X4fnoGSIX+4OA8mkp8drzK1CbPuRlXLdM0VV2jTGoOQkUKNZGXmrqFdiM
	YFXdcJyhcGOAsWB3jMtWmHw+osti8/Z+m8/SAjFLlZWLJWmhh3QE0ZFEUMXTujdgGU8VLceBZWO
	VOoK3hLuricJv1uRmxO2EX+8hY7h69lpzJcn4uRnsQitJkNhl0WpsENrw3q5qcylfGIG17S0oVV
	GdLH7vXRvH5glNRXn+yiTR4wTBRPmz7I1aiHhfLJ7/sZrh037m52lguu2VSkTWaBaIJlnJCBtj3
	QUqffbvcHl0fERA6EiOXxSmY7P0J+Fu8k2thk7OX1TAuzyyuA1IBltHDp8ucAINzxn1zeX36Q7Y
	uen3Fl5IRNouKwVtL27Tv2KCIPRiO/N+a/hB2Afekl9W5lnOxtAXnU5hOkj8Cnu2+zw4wdMdHa7
	BAdF95OHyQJxTOy0mtCQrVC701QaH8TjOTD1HdQjmb9x4rU7cdPgstDP0+aPjP1ezNDSfrBc8GU
	fMYfw==
X-Received: by 2002:a05:600c:4592:b0:47a:7fdd:2906 with SMTP id 5b1f17b1804b1-483c9bad6femr149400965e9.12.1772361228207;
        Sun, 01 Mar 2026 02:33:48 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcbf016sm165810965e9.5.2026.03.01.02.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 02:33:47 -0800 (PST)
Message-ID: <40a256b0-81fc-435b-b4b4-7ae1144d3672@gmail.com>
Date: Sun, 1 Mar 2026 10:33:46 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 11/11] repo: refine path keys for repo info
To: Eslam reda ragheb via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: eslam reda <eslam.reda.div@gmail.com>
References: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
 <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
 <8af17ad83115882ed174434e566523cf0bc376d9.1772220640.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <8af17ad83115882ed174434e566523cf0bc376d9.1772220640.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Eslam

On 27/02/2026 19:30, Eslam reda ragheb via GitGitGadget wrote:
> From: Eslam reda ragheb <eslam.reda.div@gmail.com>
> 
> Rename path.git-prefix to path.prefix, add path.work-tree as an alias
> for path.toplevel, and drop reflog/ref-file-oriented path keys.
> 
> This narrows the path surface to keys that are less tied to direct
> file access while keeping tests and documentation in sync.
> 
> Also normalize prefix handling in repo_info context so path.prefix has
> a stable empty-string behavior.

When you change a patch series based on a reviewer's feedback, you 
should use "git rebase -i" to edit or fixup the existing commits rather 
than adding new changes on top. That keeps the history cleaner as we 
don't need to know "I implemented it like this and than changed it to 
that". It also makes the patch series easier to review as reviewers 
don't waste their time commenting on changes in one patch that are then 
deleted in a later patch.

Thanks

Phillip

> Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
> ---
>   Documentation/git-repo.adoc | 14 ++++-------
>   builtin/repo.c              | 45 ++++++++--------------------------
>   t/t1900-repo.sh             | 48 +++++++++++++++++--------------------
>   3 files changed, 36 insertions(+), 71 deletions(-)
> 
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index b575977a4b..3d34c6edca 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -114,7 +114,7 @@ Here's a list of the available keys and the values that they return:
>   `path.git-dir`::
>   	The path to the git directory.
>   
> -`path.git-prefix`::
> +`path.prefix`::
>   	The path of the current working directory relative to the top-level
>   	directory.
>   
> @@ -127,18 +127,9 @@ Here's a list of the available keys and the values that they return:
>   `path.index-file`::
>   	The path to the index file.
>   
> -`path.logs-directory`::
> -	The path to the `logs` directory.
> -
>   `path.objects-directory`::
>   	The path to the objects directory.
>   
> -`path.packed-refs-file`::
> -	The path to the `packed-refs` file.
> -
> -`path.refs-directory`::
> -	The path to the `refs` directory.
> -
>   `path.shallow-file`::
>   	The path to the `shallow` file.
>   
> @@ -150,6 +141,9 @@ Here's a list of the available keys and the values that they return:
>   	The path to the top-level working tree directory, or an empty string
>   	for bare repositories.
>   
> +`path.work-tree`::
> +	Alias for `path.toplevel`.
> +
>   `references.format`::
>   	The reference storage format. The valid values are:
>   +
> diff --git a/builtin/repo.c b/builtin/repo.c
> index ecd9d3aee5..9fbd13a358 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -109,10 +109,9 @@ static int get_path_git_dir(struct repo_info *info, struct strbuf *buf)
>   	return 0;
>   }
>   
> -static int get_path_git_prefix(struct repo_info *info, struct strbuf *buf)
> +static int get_path_prefix(struct repo_info *info, struct strbuf *buf)
>   {
> -	if (info->prefix)
> -		strbuf_addstr(buf, info->prefix);
> +	strbuf_addstr(buf, info->prefix);
>   	return 0;
>   }
>   
> @@ -137,39 +136,12 @@ static int get_path_index_file(struct repo_info *info, struct strbuf *buf)
>   	return 0;
>   }
>   
> -static int get_path_logs_directory(struct repo_info *info, struct strbuf *buf)
> -{
> -	struct strbuf path = STRBUF_INIT;
> -
> -	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "logs"));
> -	strbuf_release(&path);
> -	return 0;
> -}
> -
>   static int get_path_objects_directory(struct repo_info *info, struct strbuf *buf)
>   {
>   	repo_info_add_path(info, buf, repo_get_object_directory(info->repo));
>   	return 0;
>   }
>   
> -static int get_path_packed_refs_file(struct repo_info *info, struct strbuf *buf)
> -{
> -	struct strbuf path = STRBUF_INIT;
> -
> -	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "packed-refs"));
> -	strbuf_release(&path);
> -	return 0;
> -}
> -
> -static int get_path_refs_directory(struct repo_info *info, struct strbuf *buf)
> -{
> -	struct strbuf path = STRBUF_INIT;
> -
> -	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "refs"));
> -	strbuf_release(&path);
> -	return 0;
> -}
> -
>   static int get_path_shallow_file(struct repo_info *info, struct strbuf *buf)
>   {
>   	struct strbuf path = STRBUF_INIT;
> @@ -201,6 +173,11 @@ static int get_path_toplevel(struct repo_info *info, struct strbuf *buf)
>   	return 0;
>   }
>   
> +static int get_path_work_tree(struct repo_info *info, struct strbuf *buf)
> +{
> +	return get_path_toplevel(info, buf);
> +}
> +
>   static int get_references_format(struct repo_info *info, struct strbuf *buf)
>   {
>   	struct repository *repo = info->repo;
> @@ -217,17 +194,15 @@ static const struct field repo_info_fields[] = {
>   	{ "path.common-dir", get_path_common_dir },
>   	{ "path.config-file", get_path_config_file },
>   	{ "path.git-dir", get_path_git_dir },
> -	{ "path.git-prefix", get_path_git_prefix },
>   	{ "path.grafts-file", get_path_grafts_file },
>   	{ "path.hooks-directory", get_path_hooks_directory },
>   	{ "path.index-file", get_path_index_file },
> -	{ "path.logs-directory", get_path_logs_directory },
>   	{ "path.objects-directory", get_path_objects_directory },
> -	{ "path.packed-refs-file", get_path_packed_refs_file },
> -	{ "path.refs-directory", get_path_refs_directory },
> +	{ "path.prefix", get_path_prefix },
>   	{ "path.shallow-file", get_path_shallow_file },
>   	{ "path.superproject-working-tree", get_path_superproject_working_tree },
>   	{ "path.toplevel", get_path_toplevel },
> +	{ "path.work-tree", get_path_work_tree },
>   	{ "references.format", get_references_format },
>   };
>   
> @@ -378,7 +353,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
>   	enum output_format format = FORMAT_KEYVALUE;
>   	struct repo_info info = {
>   		.repo = repo,
> -		.prefix = prefix,
> +		.prefix = prefix ? prefix : "",
>   		.path_format = PATH_FORMAT_ABSOLUTE,
>   	};
>   	int all_keys = 0;
> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> index dcacf84cc3..2351b772b2 100755
> --- a/t/t1900-repo.sh
> +++ b/t/t1900-repo.sh
> @@ -13,17 +13,15 @@ REPO_INFO_KEYS='
>   	path.common-dir
>   	path.config-file
>   	path.git-dir
> -	path.git-prefix
>   	path.grafts-file
>   	path.hooks-directory
>   	path.index-file
> -	path.logs-directory
>   	path.objects-directory
> -	path.packed-refs-file
> -	path.refs-directory
> +	path.prefix
>   	path.shallow-file
>   	path.superproject-working-tree
>   	path.toplevel
> +	path.work-tree
>   	references.format
>   '
>   
> @@ -31,17 +29,15 @@ REPO_INFO_PATH_KEYS='
>   	path.common-dir
>   	path.config-file
>   	path.git-dir
> -	path.git-prefix
>   	path.grafts-file
>   	path.hooks-directory
>   	path.index-file
> -	path.logs-directory
>   	path.objects-directory
> -	path.packed-refs-file
> -	path.refs-directory
> +	path.prefix
>   	path.shallow-file
>   	path.superproject-working-tree
>   	path.toplevel
> +	path.work-tree
>   '
>   
>   # Test whether a key-value pair is correctly returned
> @@ -172,12 +168,12 @@ test_expect_success 'path.toplevel is empty in bare repository' '
>   	test_cmp expect actual
>   '
>   
> -test_expect_success 'path.git-prefix matches rev-parse --show-prefix' '
> +test_expect_success 'path.prefix matches rev-parse --show-prefix' '
>   	git init path-prefix &&
>   	mkdir -p path-prefix/a/b &&
>   	expected_value=$(git -C path-prefix/a/b rev-parse --show-prefix) &&
> -	echo "path.git-prefix=$expected_value" >expect &&
> -	git -C path-prefix/a/b repo info path.git-prefix >actual &&
> +	echo "path.prefix=$expected_value" >expect &&
> +	git -C path-prefix/a/b repo info path.prefix >actual &&
>   	test_cmp expect actual
>   '
>   
> @@ -209,27 +205,27 @@ test_expect_success 'git-path style keys match rev-parse --git-path' '
>   	git -C path-git-path repo info path.config-file >actual &&
>   	test_cmp expect actual &&
>   
> -	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path logs) &&
> -	echo "path.logs-directory=$expected_value" >expect &&
> -	git -C path-git-path repo info path.logs-directory >actual &&
> -	test_cmp expect actual &&
> -
> -	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path packed-refs) &&
> -	echo "path.packed-refs-file=$expected_value" >expect &&
> -	git -C path-git-path repo info path.packed-refs-file >actual &&
> -	test_cmp expect actual &&
> -
> -	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path refs) &&
> -	echo "path.refs-directory=$expected_value" >expect &&
> -	git -C path-git-path repo info path.refs-directory >actual &&
> -	test_cmp expect actual &&
> -
>   	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path shallow) &&
>   	echo "path.shallow-file=$expected_value" >expect &&
>   	git -C path-git-path repo info path.shallow-file >actual &&
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'path.work-tree matches path.toplevel' '
> +	git init path-work-tree &&
> +	expected_value=$(git -C path-work-tree rev-parse --show-toplevel) &&
> +	echo "path.work-tree=$expected_value" >expect &&
> +	git -C path-work-tree repo info path.work-tree >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'path.work-tree is empty in bare repository' '
> +	git init --bare bare-path-work-tree &&
> +	echo "path.work-tree=" >expect &&
> +	git -C bare-path-work-tree repo info path.work-tree >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'path.superproject-working-tree is empty when not a submodule' '
>   	git init path-superproject &&
>   	echo "path.superproject-working-tree=" >expect &&

