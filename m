Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91C3191F6C
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213563; cv=none; b=lUsP51Vzr5MRU6+eS1PpSwizKNmUsgVriptEhhxcmJCl9Q9e1UsggoySjcI+3SMLAjxl+RyS/HRkVMm4+7tp+djDBYjbFpueYfiwVqSfZ2m+lwdcmVSenL3zFsRXzd3W5e2UdF3StHmnGxUfFMeS83yLYrJcJ0DjWYXR1ob4Mi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213563; c=relaxed/simple;
	bh=F3WjY9oed/HvSXxUE79wQUC48BbXra1eWdBMFkSaYOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5Mf95FO3yAOmZsM/K8K8lDX//Vet54scJpFNcpqGf+LzbSt+G8eX3p8YKCJV8/zGKDC9+VDyeV6cnzW+AS2sfmIiFEwqqjzTkiWMRsDxycLjp6QRCRghr6U1q9mYkK17/XqN/+PuLEEFKv0hUsy1reZXZrzDh/zfp0sARJ7Ndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhtIODtx; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhtIODtx"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f7606199so6001762e87.0
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730213558; x=1730818358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7Qm2r3k+IxfQgh3Bf8qUwYqrlW/MtomGxZoyueZwvYc=;
        b=IhtIODtxyc6RIi0+OM/XvNgmEvid9ydKA88AUaXYnQkWk0wLT/AoxISbWMZ268SDdz
         UovCsJZ8MpX1CTI7jnPdxeXt5pGS+VJsYJR8anxpNwWqRZVlafcsDzhsQK+oS+AOWraU
         07LTq2jwky0ocLR4FB3ftxo38KSS5ltiRdbGvb9Lq4/vHubVtHCHXj6hDSCHzAVfIne+
         BsEEp7hPtzRl054ycWJxGqHlOECppRPd1yv3xgdV6iJP1kdJdSo7Szi8aBzXhbuL2v4S
         Z/prc3AsiREnzqVfhgKML3lkqg8MEEsGw8MJ4ALDkUBpzZBmpnJPAenLR60sXUBDxn37
         bYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730213558; x=1730818358;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Qm2r3k+IxfQgh3Bf8qUwYqrlW/MtomGxZoyueZwvYc=;
        b=WsNh557r7Dp2D/DUiI3V76LUpOhxIGMwpvRET3/7jml+NV+7tqW36Wgg9tN0WXTFxF
         XhV7YhNP7da5lp+75/slTBM9huRFyI61U4zbmGyXfz2KYap5s1I2MDU1PGi77RPXao0D
         /mes0MR2jFfMSIKI9yRGCEgxzO4uIchH/rXe+AlPmWZ31QXUloJQ19XDb6Qru9aTtI+F
         wf6oe0o3PyT3eKMscDcAPntxV+ASQJRwqo/Ty8hZsiG/m0ovdol4Y0LWRkcgNkk5ZU+m
         Uw1R0bydXzE4pTbFGk2QpgHKtVPN/5EWpSYrfIYcx23kOrCYTVmfdXO9SEP067Il38VY
         fE0w==
X-Forwarded-Encrypted: i=1; AJvYcCXKIisHZDzx1r9jnQSlAgIDXzxortrAvPWHIk4L7z+hMnH/m1eCq1nOnQFHB9/KTfjGzUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzme+5g+ItlgufF29IYE0/z1ukRMZz8UdNNsFwG5LlTxvns3SN9
	bIQLR+PNnW9J7a2SUyZcuBYODe52BdV/c1QIXnUzG3Gok0a36dGWyIxyOA==
X-Google-Smtp-Source: AGHT+IE5B6meiYRxEB1XHTyzS/YCaCSdlIdno/tzv6m5BZfrMVk8CcAggZUPhbetZ98wLMLk10v9Vw==
X-Received: by 2002:a05:6512:3ba0:b0:539:edc9:e81b with SMTP id 2adb3069b0e04-53b348daaabmr5270818e87.28.1730213557596;
        Tue, 29 Oct 2024 07:52:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43193594fffsm145707955e9.13.2024.10.29.07.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 07:52:37 -0700 (PDT)
Message-ID: <4a316a5f-9360-4f24-843f-bcbb5b3378c4@gmail.com>
Date: Tue, 29 Oct 2024 14:52:36 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/5] worktree: add `write_worktree_linking_files`
 function
To: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me>
 <20241028-wt_relative_options-v2-2-33a5021bd7bb@pm.me>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20241028-wt_relative_options-v2-2-33a5021bd7bb@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Caleb

On 28/10/2024 19:09, Caleb White wrote:
> A new helper function, `write_worktree_linking_files()`, centralizes
> the logic for computing and writing either relative or absolute
> paths, based on the provided configuration. This function accepts
> `strbuf` pointers to both the worktree’s `.git` link and the
> repository’s `gitdir`, and then writes the appropriate path to each.

That sounds like a useful change. I think it would be better to pass an 
extra parameter "use_relative_paths" rather than relying on a global 
varibale in worktree.c. Thank you for adding some documentaion for the 
new function.

> This also teachs `git worktree repair` to fix the linking files if
> there is an absolute/relative paths but the links are correct. E.g.,
> `git worktree repair` can be used to convert a valid worktree between
> absolute and relative paths.

This might be better as a separate step so that reviewers can 
concentrate on the correctness of write_werktree_linking_files() when 
reviewing this patch.

Best Wishes

Phillip

> Signed-off-by: Caleb White <cdwhite3@pm.me>
> ---
>   builtin/worktree.c |  11 +----
>   worktree.c         | 118 +++++++++++++++++++++++++++--------------------------
>   worktree.h         |  12 ++++++
>   3 files changed, 74 insertions(+), 67 deletions(-)
> 
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index c1130be5890c905c0b648782a834eb8dfcd79ba5..bb06830d6fe82aa97833c6e87f034115dfaa23bd 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -417,8 +417,7 @@ static int add_worktree(const char *path, const char *refname,
>   			const struct add_opts *opts)
>   {
>   	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
> -	struct strbuf sb = STRBUF_INIT, sb_tmp = STRBUF_INIT;
> -	struct strbuf sb_path_realpath = STRBUF_INIT, sb_repo_realpath = STRBUF_INIT;
> +	struct strbuf sb = STRBUF_INIT;
>   	const char *name;
>   	struct strvec child_env = STRVEC_INIT;
>   	unsigned int counter = 0;
> @@ -494,10 +493,7 @@ static int add_worktree(const char *path, const char *refname,
>   
>   	strbuf_reset(&sb);
>   	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
> -	strbuf_realpath(&sb_path_realpath, path, 1);
> -	strbuf_realpath(&sb_repo_realpath, sb_repo.buf, 1);
> -	write_file(sb.buf, "%s/.git", relative_path(sb_path_realpath.buf, sb_repo_realpath.buf, &sb_tmp));
> -	write_file(sb_git.buf, "gitdir: %s", relative_path(sb_repo_realpath.buf, sb_path_realpath.buf, &sb_tmp));
> +	write_worktree_linking_files(sb_git, sb);
>   	strbuf_reset(&sb);
>   	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
>   	write_file(sb.buf, "../..");
> @@ -581,12 +577,9 @@ static int add_worktree(const char *path, const char *refname,
>   
>   	strvec_clear(&child_env);
>   	strbuf_release(&sb);
> -	strbuf_release(&sb_tmp);
>   	strbuf_release(&symref);
>   	strbuf_release(&sb_repo);
> -	strbuf_release(&sb_repo_realpath);
>   	strbuf_release(&sb_git);
> -	strbuf_release(&sb_path_realpath);
>   	strbuf_release(&sb_name);
>   	free_worktree(wt);
>   	return ret;
> diff --git a/worktree.c b/worktree.c
> index de5c5e53a5f2a758ddf470b5d6a9ad6c66247181..f4cee73d7a1edecafdff30b6d5e2d9dd1365b93e 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -381,29 +381,24 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
>   void update_worktree_location(struct worktree *wt, const char *path_)
>   {
>   	struct strbuf path = STRBUF_INIT;
> -	struct strbuf repo = STRBUF_INIT;
> -	struct strbuf file = STRBUF_INIT;
> -	struct strbuf tmp = STRBUF_INIT;
> +	struct strbuf dotgit = STRBUF_INIT;
> +	struct strbuf gitdir = STRBUF_INIT;
>   
>   	if (is_main_worktree(wt))
>   		BUG("can't relocate main worktree");
>   
> -	strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
> +	strbuf_realpath(&gitdir, git_common_path("worktrees/%s/gitdir", wt->id), 1);
>   	strbuf_realpath(&path, path_, 1);
> +	strbuf_addf(&dotgit, "%s/.git", path.buf);
>   	if (fspathcmp(wt->path, path.buf)) {
> -		strbuf_addf(&file, "%s/gitdir", repo.buf);
> -		write_file(file.buf, "%s/.git", relative_path(path.buf, repo.buf, &tmp));
> -		strbuf_reset(&file);
> -		strbuf_addf(&file, "%s/.git", path.buf);
> -		write_file(file.buf, "gitdir: %s", relative_path(repo.buf, path.buf, &tmp));
> +		write_worktree_linking_files(dotgit, gitdir);
>   
>   		free(wt->path);
>   		wt->path = strbuf_detach(&path, NULL);
>   	}
>   	strbuf_release(&path);
> -	strbuf_release(&repo);
> -	strbuf_release(&file);
> -	strbuf_release(&tmp);
> +	strbuf_release(&dotgit);
> +	strbuf_release(&gitdir);
>   }
>   
>   int is_worktree_being_rebased(const struct worktree *wt,
> @@ -582,9 +577,9 @@ static void repair_gitfile(struct worktree *wt,
>   			   worktree_repair_fn fn, void *cb_data)
>   {
>   	struct strbuf dotgit = STRBUF_INIT;
> +	struct strbuf gitdir = STRBUF_INIT;
>   	struct strbuf repo = STRBUF_INIT;
>   	struct strbuf backlink = STRBUF_INIT;
> -	struct strbuf tmp = STRBUF_INIT;
>   	char *dotgit_contents = NULL;
>   	const char *repair = NULL;
>   	int err;
> @@ -600,6 +595,7 @@ static void repair_gitfile(struct worktree *wt,
>   
>   	strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
>   	strbuf_addf(&dotgit, "%s/.git", wt->path);
> +	strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
>   	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
>   
>   	if (dotgit_contents) {
> @@ -617,18 +613,20 @@ static void repair_gitfile(struct worktree *wt,
>   		repair = _(".git file broken");
>   	else if (fspathcmp(backlink.buf, repo.buf))
>   		repair = _(".git file incorrect");
> +	else if (use_relative_paths == is_absolute_path(dotgit_contents))
> +		repair = _(".git file absolute/relative path mismatch");
>   
>   	if (repair) {
>   		fn(0, wt->path, repair, cb_data);
> -		write_file(dotgit.buf, "gitdir: %s", relative_path(repo.buf, wt->path, &tmp));
> +		write_worktree_linking_files(dotgit, gitdir);
>   	}
>   
>   done:
>   	free(dotgit_contents);
>   	strbuf_release(&repo);
>   	strbuf_release(&dotgit);
> +	strbuf_release(&gitdir);
>   	strbuf_release(&backlink);
> -	strbuf_release(&tmp);
>   }
>   
>   static void repair_noop(int iserr UNUSED,
> @@ -653,45 +651,30 @@ void repair_worktrees(worktree_repair_fn fn, void *cb_data)
>   
>   void repair_worktree_after_gitdir_move(struct worktree *wt, const char *old_path)
>   {
> -	struct strbuf path = STRBUF_INIT;
> -	struct strbuf repo = STRBUF_INIT;
>   	struct strbuf gitdir = STRBUF_INIT;
>   	struct strbuf dotgit = STRBUF_INIT;
> -	struct strbuf olddotgit = STRBUF_INIT;
> -	struct strbuf tmp = STRBUF_INIT;
>   
>   	if (is_main_worktree(wt))
>   		goto done;
>   
> -	strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
> -	strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
> +	strbuf_realpath(&gitdir, git_common_path("worktrees/%s/gitdir", wt->id), 1);
>   
> -	if (strbuf_read_file(&olddotgit, gitdir.buf, 0) < 0)
> +	if (strbuf_read_file(&dotgit, gitdir.buf, 0) < 0)
>   		goto done;
>   
> -	strbuf_rtrim(&olddotgit);
> -	if (is_absolute_path(olddotgit.buf)) {
> -		strbuf_addbuf(&dotgit, &olddotgit);
> -	} else {
> -		strbuf_addf(&dotgit, "%s/worktrees/%s/%s", old_path, wt->id, olddotgit.buf);
> +	strbuf_rtrim(&dotgit);
> +	if (!is_absolute_path(dotgit.buf)) {
> +		strbuf_insertf(&dotgit, 0, "%s/worktrees/%s/", old_path, wt->id);
>   		strbuf_realpath_forgiving(&dotgit, dotgit.buf, 0);
>   	}
>   
>   	if (!file_exists(dotgit.buf))
>   		goto done;
>   
> -	strbuf_addbuf(&path, &dotgit);
> -	strbuf_strip_suffix(&path, "/.git");
> -
> -	write_file(dotgit.buf, "gitdir: %s", relative_path(repo.buf, path.buf, &tmp));
> -	write_file(gitdir.buf, "%s", relative_path(dotgit.buf, repo.buf, &tmp));
> +	write_worktree_linking_files(dotgit, gitdir);
>   done:
> -	strbuf_release(&path);
> -	strbuf_release(&repo);
>   	strbuf_release(&gitdir);
>   	strbuf_release(&dotgit);
> -	strbuf_release(&olddotgit);
> -	strbuf_release(&tmp);
>   }
>   
>   void repair_worktrees_after_gitdir_move(const char *old_path)
> @@ -766,13 +749,10 @@ void repair_worktree_at_path(const char *path,
>   			     worktree_repair_fn fn, void *cb_data)
>   {
>   	struct strbuf dotgit = STRBUF_INIT;
> -	struct strbuf realdotgit = STRBUF_INIT;
>   	struct strbuf backlink = STRBUF_INIT;
>   	struct strbuf inferred_backlink = STRBUF_INIT;
>   	struct strbuf gitdir = STRBUF_INIT;
>   	struct strbuf olddotgit = STRBUF_INIT;
> -	struct strbuf realolddotgit = STRBUF_INIT;
> -	struct strbuf tmp = STRBUF_INIT;
>   	char *dotgit_contents = NULL;
>   	const char *repair = NULL;
>   	int err;
> @@ -784,25 +764,25 @@ void repair_worktree_at_path(const char *path,
>   		goto done;
>   
>   	strbuf_addf(&dotgit, "%s/.git", path);
> -	if (!strbuf_realpath(&realdotgit, dotgit.buf, 0)) {
> +	if (!strbuf_realpath(&dotgit, dotgit.buf, 0)) {
>   		fn(1, path, _("not a valid path"), cb_data);
>   		goto done;
>   	}
>   
> -	infer_backlink(realdotgit.buf, &inferred_backlink);
> +	infer_backlink(dotgit.buf, &inferred_backlink);
>   	strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0);
> -	dotgit_contents = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));
> +	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
>   	if (dotgit_contents) {
>   		if (is_absolute_path(dotgit_contents)) {
>   			strbuf_addstr(&backlink, dotgit_contents);
>   		} else {
> -			strbuf_addbuf(&backlink, &realdotgit);
> +			strbuf_addbuf(&backlink, &dotgit);
>   			strbuf_strip_suffix(&backlink, ".git");
>   			strbuf_addstr(&backlink, dotgit_contents);
>   			strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
>   		}
>   	} else if (err == READ_GITFILE_ERR_NOT_A_FILE) {
> -		fn(1, realdotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
> +		fn(1, dotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
>   		goto done;
>   	} else if (err == READ_GITFILE_ERR_NOT_A_REPO) {
>   		if (inferred_backlink.len) {
> @@ -815,11 +795,11 @@ void repair_worktree_at_path(const char *path,
>   			 */
>   			strbuf_swap(&backlink, &inferred_backlink);
>   		} else {
> -			fn(1, realdotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
> +			fn(1, dotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
>   			goto done;
>   		}
>   	} else {
> -		fn(1, realdotgit.buf, _("unable to locate repository; .git file broken"), cb_data);
> +		fn(1, dotgit.buf, _("unable to locate repository; .git file broken"), cb_data);
>   		goto done;
>   	}
>   
> @@ -841,39 +821,35 @@ void repair_worktree_at_path(const char *path,
>   	 * in the "copy" repository. In this case, point the "copy" worktree's
>   	 * .git file at the "copy" repository.
>   	 */
> -	if (inferred_backlink.len && fspathcmp(backlink.buf, inferred_backlink.buf)) {
> +	if (inferred_backlink.len && fspathcmp(backlink.buf, inferred_backlink.buf))
>   		strbuf_swap(&backlink, &inferred_backlink);
> -	}
>   
>   	strbuf_addf(&gitdir, "%s/gitdir", backlink.buf);
>   	if (strbuf_read_file(&olddotgit, gitdir.buf, 0) < 0)
>   		repair = _("gitdir unreadable");
> +	else if (use_relative_paths == is_absolute_path(olddotgit.buf))
> +		repair = _("gitdir absolute/relative path mismatch");
>   	else {
>   		strbuf_rtrim(&olddotgit);
> -		if (is_absolute_path(olddotgit.buf)) {
> -			strbuf_addbuf(&realolddotgit, &olddotgit);
> -		} else {
> -			strbuf_addf(&realolddotgit, "%s/%s", backlink.buf, olddotgit.buf);
> -			strbuf_realpath_forgiving(&realolddotgit, realolddotgit.buf, 0);
> +		if (!is_absolute_path(olddotgit.buf)) {
> +			strbuf_insertf(&olddotgit, 0, "%s/", backlink.buf);
> +			strbuf_realpath_forgiving(&olddotgit, olddotgit.buf, 0);
>   		}
> -		if (fspathcmp(realolddotgit.buf, realdotgit.buf))
> +		if (fspathcmp(olddotgit.buf, dotgit.buf))
>   			repair = _("gitdir incorrect");
>   	}
>   
>   	if (repair) {
>   		fn(0, gitdir.buf, repair, cb_data);
> -		write_file(gitdir.buf, "%s", relative_path(realdotgit.buf, backlink.buf, &tmp));
> +		write_worktree_linking_files(dotgit, gitdir);
>   	}
>   done:
>   	free(dotgit_contents);
>   	strbuf_release(&olddotgit);
> -	strbuf_release(&realolddotgit);
>   	strbuf_release(&backlink);
>   	strbuf_release(&inferred_backlink);
>   	strbuf_release(&gitdir);
> -	strbuf_release(&realdotgit);
>   	strbuf_release(&dotgit);
> -	strbuf_release(&tmp);
>   }
>   
>   int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath, timestamp_t expire)
> @@ -1034,3 +1010,29 @@ int init_worktree_config(struct repository *r)
>   	free(main_worktree_file);
>   	return res;
>   }
> +
> +void write_worktree_linking_files(struct strbuf dotgit, struct strbuf gitdir)
> +{
> +	struct strbuf path = STRBUF_INIT;
> +	struct strbuf repo = STRBUF_INIT;
> +	struct strbuf tmp = STRBUF_INIT;
> +
> +	strbuf_addbuf(&path, &dotgit);
> +	strbuf_strip_suffix(&path, "/.git");
> +	strbuf_realpath(&path, path.buf, 1);
> +	strbuf_addbuf(&repo, &gitdir);
> +	strbuf_strip_suffix(&repo, "/gitdir");
> +	strbuf_realpath(&repo, repo.buf, 1);
> +
> +	if (use_relative_paths) {
> +		write_file(gitdir.buf, "%s/.git", relative_path(path.buf, repo.buf, &tmp));
> +		write_file(dotgit.buf, "gitdir: %s", relative_path(repo.buf, path.buf, &tmp));
> +	} else {
> +		write_file(gitdir.buf, "%s/.git", path.buf);
> +		write_file(dotgit.buf, "gitdir: %s", repo.buf);
> +	}
> +
> +	strbuf_release(&path);
> +	strbuf_release(&repo);
> +	strbuf_release(&tmp);
> +}
> diff --git a/worktree.h b/worktree.h
> index 37e65d508ed23d3e7a29850bb938285072a3aaa6..5929089891c97318a8f5329f7938264c717050d5 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -217,4 +217,16 @@ void strbuf_worktree_ref(const struct worktree *wt,
>    */
>   int init_worktree_config(struct repository *r);
>   
> +/**
> + * Write the .git file and gitdir file that links the worktree to the repository.
> + *
> + * The `dotgit` parameter is the path to the worktree's .git file, and `gitdir`
> + * is the path to the repository's `gitdir` file.
> + *
> + * Example
> + *  dotgit: "/path/to/foo/.git"
> + *  gitdir: "/path/to/repo/worktrees/foo/gitdir"
> + */
> +void write_worktree_linking_files(struct strbuf dotgit, struct strbuf gitdir);
> +
>   #endif
> 

