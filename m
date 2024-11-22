Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8CC13D8B1
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732291104; cv=none; b=KktR00pGmhALgutHx2yGy5dG2JOG6cMrjztI+qGgq+GMoCzIgM+OekBYDwJhBV8fA7SymVlCmVbVHNgHTeiCecLLJkdT7aklMvhTMiHK0dHrtrOAvoSMpFCEGAxfcPXMRwXkqBHc7DkHGACTSQbjZm7MKUxHt+3p/chZd0QfsyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732291104; c=relaxed/simple;
	bh=AZOpnLyuytuKHt/JSCxIEU1izh7v0u+6SeeBwVQfl1o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OPYdWAhFSilfaBVLi0GpVx2D6JZYaR5ce1OMKp0EZeD5m3G+x3iE9ztE+w8HY4XFumh/jS68IOw+of8XzaX2SkmKsqIX3jXqlEUMwwWtxJW51V5SvmQpODQAaKz158KZ4xwzCAE4E86VFrP+f5Aakjgr8JIZZTJqRalJ8secRTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvYm4/iD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvYm4/iD"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315abed18aso19939905e9.2
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 07:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732291101; x=1732895901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JLfXFRTS+26hKprVpKKUEstw3JcP8s2cxxyt8Gfx7Y0=;
        b=IvYm4/iDaHq3vY93XOmpT3X7/hAdrLkXyysIgWqxM4kb2ffrDA986VQsDWQsgsT4kL
         FLiom/yXnQ9AEicEOrmOJXdGPwjXFw3oJomwhVk6wucAi7fYmpiygIILX5OVmXaDrnFP
         mtPrpyjbOB/oB7dYa/PZNhPuuk6WBEcr7Bq+ZMobVa2mnuSy38BG/0maHMRuZ/ZckA25
         3oQSp/+sVjIx0EhyyWO+6Tb0D1Eg41au0U2x9EfQkgWYq2VP5LU8ARcH+Ulfelu8AhTW
         2Xi9D7PsU/bgSTwBUStKv0vqAfybGCANi4rBv6D86Q1YfpSz/wyP/znlmbdAl6Dz1W9J
         rjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732291101; x=1732895901;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLfXFRTS+26hKprVpKKUEstw3JcP8s2cxxyt8Gfx7Y0=;
        b=mpjxlisoDQCA+aSpMcccYvqaSheXU1grtBcHvxVN5DtdgLjasqPRomkD8MMit0gf7y
         LHMB3QCv8hXFTUrEJT19je+3NpSmGSEY7x1mO3jDYW+A4tmzF6eHjS833ugtf1iQIY5s
         tOdB0fwn0YywFw3ewRvNzRdPAGxw4pa3SRjUrnPf9zr0hGxo40YVgsk+DC3EXJs3LtSs
         OajD7ing1PvPVOUeya6sbCQEgL41hmxgfsWm4umkid7+n1Pgm1knOHBLNCy7Mklb7uRV
         7Qo90Jj66j6UInV6MYZe+XL5skR9eBG8EH4xp3w415LEGMjRHi3rB6ODOKs5s2r3NwaE
         j1Sg==
X-Forwarded-Encrypted: i=1; AJvYcCU5k6IbZ8WKTOC6hlZD8+U9RhC5OfgLiT19PQ6N3VxrOABx0WO3GqyskKhQdkWfTc0Gnsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxRCYkTq1u9gdnKz5r+Pg+vGrI2MbnfYHEFSOPNUjPq9w1MSqZ
	cZG/wLhHlglOVUpURDVlclm/5NIW9Xixa0uM2TgliUn76hY16feZ
X-Gm-Gg: ASbGncsz9CLWP7R1ZgV8DZwj8vKFGWOmWFkaTDadf9PxilvdnnIRi6xbzMt/aPinLqi
	mM2IIHPPH+L3na34xVxVVIXCcIjMbnbm3QuV+AfXzsoVmIms3jatt3DzMvJMdKAJ53leuBQp0Zd
	S0CdoDk9NohaOQSUR0ZJ+wwQaE9ECMNLgx/6CGQ1qGVbDRU4VDgmUzo1EEH6RxMTzW2GKbwCYVi
	JaFxAOkowYCad0qtRR8hiKixeoNrkR7L0f0Kdf60e/7cLA1pSskioxtc0kUqTD4+EnVdHd6/Abu
	sEeBnk5Fth+yJEgFvoHkssI4mQ==
X-Google-Smtp-Source: AGHT+IGOsIKCYpzLzdd8xFIRz/QW7SMJwzz2bxqg5Kd40Ni1a3t17R80Xm7uSbnOMVstd1XxTORi6Q==
X-Received: by 2002:a05:600c:3b94:b0:431:51c0:c90f with SMTP id 5b1f17b1804b1-433ce4c1e59mr27922995e9.21.1732291101061;
        Fri, 22 Nov 2024 07:58:21 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a8:b801:610:d596:f87c:e591? ([2a0a:ef40:6a8:b801:610:d596:f87c:e591])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde98b4dsm31909475e9.43.2024.11.22.07.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 07:58:20 -0800 (PST)
Message-ID: <50187d7d-2a96-4df2-baaa-ea27c9bd5dcf@gmail.com>
Date: Fri, 22 Nov 2024 15:58:20 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 8/8] worktree: refactor
 `repair_worktree_after_gitdir_move()`
Reply-To: phillip.wood@dunelm.org.uk
To: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
 <20241031-wt_relative_options-v4-8-07a3dc0f02a3@pm.me>
Content-Language: en-US
In-Reply-To: <20241031-wt_relative_options-v4-8-07a3dc0f02a3@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Caleb

On 01/11/2024 04:39, Caleb White wrote:
> This refactors `repair_worktree_after_gitdir_move()` to use the new
> `write_worktree_linking_files` function. It also preserves the
> relativity of the linking files; e.g., if an existing worktree used
> absolute paths then the repaired paths will be absolute (and visa-versa).

It would be helpful to give a brief explanation of what this function is 
used for as it seems to be called from setup.c rather than as part of 
"git worktree repair"

> This also adds a test case for reinitializing a repository that has
> relative worktrees.

I'm not sure exactly what this is doing - are we breaking something and 
then calling "git init" to repair it?

My understanding of what this function is trying to do is rather limited 
but as far as I can see the conversion looks OK though the strbuf 
changes are quite distracting.

> Signed-off-by: Caleb White <cdwhite3@pm.me>
> ---
>   t/t0001-init.sh | 22 ++++++++++++++++++----
>   worktree.c      | 29 ++++++++---------------------
>   2 files changed, 26 insertions(+), 25 deletions(-)
> 
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 0178aa62a41f1606f2382a4a10ab593ccf11e0e8..264951592a711f6879555b785905e799db6c5dd4 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -434,6 +434,12 @@ test_expect_success SYMLINKS 're-init to move gitdir symlink' '
>   sep_git_dir_worktree ()  {
>   	test_when_finished "rm -rf mainwt linkwt seprepo" &&
>   	git init mainwt &&
> +	if test "relative" = $2
> +	then
> +		git -C mainwt config worktree.useRelativePaths true

test_config is your friend here (it accepts -C <repo>)

Best Wishes

Phillip

> +	else
> +		git -C mainwt config worktree.useRelativePaths false
> +	fi
>   	test_commit -C mainwt gumby &&
>   	git -C mainwt worktree add --detach ../linkwt &&
>   	git -C "$1" init --separate-git-dir ../seprepo &&
> @@ -442,12 +448,20 @@ sep_git_dir_worktree ()  {
>   	test_cmp expect actual
>   }
>   
> -test_expect_success 're-init to move gitdir with linked worktrees' '
> -	sep_git_dir_worktree mainwt
> +test_expect_success 're-init to move gitdir with linked worktrees (absolute)' '
> +	sep_git_dir_worktree mainwt absolute
> +'
> +
> +test_expect_success 're-init to move gitdir within linked worktree (absolute)' '
> +	sep_git_dir_worktree linkwt absolute
> +'
> +
> +test_expect_success 're-init to move gitdir with linked worktrees (relative)' '
> +	sep_git_dir_worktree mainwt relative
>   '
>   
> -test_expect_success 're-init to move gitdir within linked worktree' '
> -	sep_git_dir_worktree linkwt
> +test_expect_success 're-init to move gitdir within linked worktree (relative)' '
> +	sep_git_dir_worktree linkwt relative
>   '
>   
>   test_expect_success MINGW '.git hidden' '
> diff --git a/worktree.c b/worktree.c
> index 2cb994ac462debf966ac51b5a4f33c30cfebd4ef..2c2e9fd8fdc22d4fe3705227d72b8dbd293038b2 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -653,45 +653,32 @@ void repair_worktrees(worktree_repair_fn fn, void *cb_data, int use_relative_pat
>   
>   void repair_worktree_after_gitdir_move(struct worktree *wt, const char *old_path)
>   {
> -	struct strbuf path = STRBUF_INIT;
> -	struct strbuf repo = STRBUF_INIT;
>   	struct strbuf gitdir = STRBUF_INIT;
>   	struct strbuf dotgit = STRBUF_INIT;
> -	struct strbuf olddotgit = STRBUF_INIT;
> -	struct strbuf tmp = STRBUF_INIT;
> +	int is_relative_path;
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
> +	is_relative_path = ! is_absolute_path(dotgit.buf);
> +	if (is_relative_path) {
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
> +	write_worktree_linking_files(dotgit, gitdir, is_relative_path);
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
> 

