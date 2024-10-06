Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8549A184537
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728229027; cv=none; b=hZ/gq86XboleA30Fd3y8UTtvd4VTCbuXrdRtV/bV/rkDmm35cXZVs+ci13/oqbfI5RiUWezZ39kgwQE3ZGnzyWLe5RrZrn/0Mu4CJnII3LTf/9pk/8jHTVgOWeVjjicVWWOQi+nUK2orjZAe0FtNueRW8amwyGzDHptLizuDEOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728229027; c=relaxed/simple;
	bh=YB0Rrxy6IIxG7ZuXQNAskFqpbMeDQqZvS3K5de4ldl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJ0NDj48izzK95shpWq1FnDdQn0IglS8K15m0xyj7Nbv+VJ+MOEEpQtLdagyWW1z3LRzYrdicN/0+DxOrZJ7TwpVpEoaK+re84TJv3qDJcDwhQDOvHdq3vTBEQWVHBr8OIe2fLQ8C0arZdDX0sJZzkMLswbeq7QhbYQkvsJQHzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLoyOG0M; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLoyOG0M"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7e9f98f2147so564220a12.1
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 08:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728229025; x=1728833825; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w2WWOzn95kxthF0C0cjQd3ZRln6OfZG3O9S2/5l/9Y4=;
        b=eLoyOG0M4KW1dxmWni8zt/gfxkppXYOBz2fi6JP0OlvNWiyEohAmW9tg5G8Hx8rYyl
         gf0hWENcoULSGk4qvb2ShdBxuDYK857otEw1CnYj9Wj3ySdCBSm6+MlE6coGYYuPHIuf
         GWjP+hZiGuxDmumaZj63/qsbOTGg5+hNBQJq8p70tDuvGzmr4jSuamyypnU6G86sm5fy
         iwDfyDFhyL/ZL4dI8JvK9bMquK63hd+L8wlPyyh+zM01o4VkENNNvtfGjuL77ClriDUt
         XXeA6uMeeru7bcUKgB4j81imK1fWhVRQ5kT8z2SEs2+rI60WPA26wHmgDGTdtZbIPIXu
         qbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728229025; x=1728833825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2WWOzn95kxthF0C0cjQd3ZRln6OfZG3O9S2/5l/9Y4=;
        b=i/Gb+uX3EWO9JRYx8tyLJ+ZVlEeSCFto2+ikU6Q7HnoRC7Ru/aMzqo99qcOgQvTSy4
         JWPa7XoutjHzASQVBaaeTnJNA3WnnBk30tcHsNN8ieLBZAnqab7bcp/LebEfcUvhAYp+
         Aqc+9SHRw+Gr8MMeLg+MmtOUfbh82Z+g2v9MhFLV2J6ux4749lPyehwXbmUIlmAJVHsO
         C/kmtsoK4J3BI5SCL3OW9jc3wK3Zbtk5vSNDzNpTYgsqm4uNqPgUigEDzZPTpbPCspcW
         NxTJJxZ7MrEdmEsCeVraSUJcCKsxnF65xO4CrNVri7937jlidVv7KdkydF7DN5oG8Z7h
         ZYog==
X-Gm-Message-State: AOJu0YyEMCw7d1cSgdKPM20XSRdRWf2BmAtPwu6EoAv+EE73Hsv7GeaF
	K+z+lkVcUSEMJNRrazlSZwUhd5PtInksbUNZTiFFbYqC6kM2Xuh4HFoCyQ==
X-Google-Smtp-Source: AGHT+IEgTfoVvG1Qc/+6rIT0x9pCePk5TjV89Jmzlh+7TmDfpckAT1H6COUe9LDgKjqek352/F7/OQ==
X-Received: by 2002:a05:6a20:2d22:b0:1d2:bc91:d49 with SMTP id adf61e73a8af0-1d6dfabadffmr14072828637.31.1728229024710;
        Sun, 06 Oct 2024 08:37:04 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4a1c1sm2828329a12.81.2024.10.06.08.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 08:37:04 -0700 (PDT)
Date: Sun, 6 Oct 2024 23:37:10 +0800
From: shejialuo <shejialuo@gmail.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] worktree: link worktrees with relative paths
Message-ID: <ZwKuptTMf9ECd-kf@ArchLinux>
References: <20241006060017.171788-1-cdwhite3@pm.me>
 <20241006060017.171788-3-cdwhite3@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241006060017.171788-3-cdwhite3@pm.me>

On Sun, Oct 06, 2024 at 06:01:17AM +0000, Caleb White wrote:
> This modifies Git’s handling of worktree linking to use relative
> paths instead of absolute paths. Previously, when creating a worktree,
> Git would store the absolute paths to both the main repository and the
> linked worktrees. These hardcoded absolute paths cause breakages such
> as when the repository is moved to a different directory or during
> containerized development where the absolute differs between systems.
> 
> By switching to relative paths, we help ensure that worktree links are
> more resilient when the repository is moved. While links external to the
> repository may still break, Git still automatically handles many common
> scenarios, reducing the need for manual repair. This is particularly
> useful in containerized or portable development environments, where the
> absolute path to the repository can differ between systems. Developers
> no longer need to reinitialize or repair worktrees after relocating the
> repository, improving workflow efficiency and reducing breakages.
> 
> For self-contained repositories (such as using a bare repository with
> worktrees), where both the repository and its worktrees are located
> within the same directory structure, using relative paths guarantees all
> links remain functional regardless of where the directory is located.
> 

Eric has already commented on this commit message. I think this commit
has done a lot of things which make the review painful.

> Signed-off-by: Caleb White <cdwhite3@pm.me>
> ---
>  builtin/worktree.c           |  17 ++--
>  t/t2408-worktree-relative.sh |  39 +++++++++
>  worktree.c                   | 152 +++++++++++++++++++++++++----------
>  3 files changed, 159 insertions(+), 49 deletions(-)
>  create mode 100755 t/t2408-worktree-relative.sh
> 
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index fc31d07..99cee56 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -414,7 +414,8 @@ static int add_worktree(const char *path, const char *refname,
>  			const struct add_opts *opts)
>  {
>  	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
> -	struct strbuf sb = STRBUF_INIT, realpath = STRBUF_INIT;
> +	struct strbuf sb = STRBUF_INIT, sb_tmp = STRBUF_INIT;
> +	struct strbuf sb_path_realpath = STRBUF_INIT, sb_repo_realpath = STRBUF_INIT;
>  	const char *name;
>  	struct strvec child_env = STRVEC_INIT;
>  	unsigned int counter = 0;
> @@ -490,11 +491,11 @@ static int add_worktree(const char *path, const char *refname,
>  
>  	strbuf_reset(&sb);
>  	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
> -	strbuf_realpath(&realpath, sb_git.buf, 1);
> -	write_file(sb.buf, "%s", realpath.buf);
> -	strbuf_realpath(&realpath, repo_get_common_dir(the_repository), 1);
> -	write_file(sb_git.buf, "gitdir: %s/worktrees/%s",
> -		   realpath.buf, name);
> +	strbuf_realpath(&sb_path_realpath, path, 1);
> +	strbuf_realpath(&sb_repo_realpath, sb_repo.buf, 1);
> +	write_file(sb.buf, "%s/.git", relative_path(sb_path_realpath.buf, sb_repo_realpath.buf, &sb_tmp));
> +	strbuf_reset(&sb_tmp);

Do we need reset the "sb_tmp"? I guess we do not need, "relative_path"
does not care about "sb_tmp". It will always reset the value of the
"sb_tmp". So, we may delete this line.

[snip]

> diff --git a/worktree.c b/worktree.c
> index c6d2ede..fc14e9a 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -373,18 +379,30 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
>  void update_worktree_location(struct worktree *wt, const char *path_)
>  {
>  	struct strbuf path = STRBUF_INIT;
> +	struct strbuf repo = STRBUF_INIT;
> +	struct strbuf tmp = STRBUF_INIT;
> +	char *file = NULL;
>  
>  	if (is_main_worktree(wt))
>  		BUG("can't relocate main worktree");
>  
> +	strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
>  	strbuf_realpath(&path, path_, 1);
>  	if (fspathcmp(wt->path, path.buf)) {
> -		write_file(git_common_path("worktrees/%s/gitdir", wt->id),
> -			   "%s/.git", path.buf);
> +		file = xstrfmt("%s/gitdir", repo.buf);
> +		write_file(file, "%s/.git", relative_path(path.buf, repo.buf, &tmp));
> +		free(file);
> +		strbuf_reset(&tmp);
> +		file = xstrfmt("%s/.git", path.buf);

Still, we do not need to call "strbuf_reset" again for "tmp". But there
is another question here. Should we define the "file" just in this "if"
block and free "file" also in the block?

And I don't think it's a good idea to use "xstrfmt". Here, we need to
allocate two times and free two times. Why not just define a "struct
strbuf" and the use "strbuf_*" method here?

> +		write_file(file, "gitdir: %s", relative_path(repo.buf, path.buf, &tmp));
> +
>  		free(wt->path);
>  		wt->path = strbuf_detach(&path, NULL);
>  	}
> +	free(file);
>  	strbuf_release(&path);
> +	strbuf_release(&repo);
> +	strbuf_release(&tmp);
>  }
>  
> @@ -564,38 +582,52 @@ static void repair_gitfile(struct worktree *wt,
>  {
>  

[snip]

>  	strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
>  	strbuf_addf(&dotgit, "%s/.git", wt->path);
> -	backlink = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
> +	git_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));

Why here we need to use "xstrdup_or_null". The life cycle of the
"git_contents" variable is in the "repair_gitfile" function.

[snip]

I omit the review for the later code, there are too many codes to
review. And due to my limited knowledge about worktree, the overhead
will be too big for me.

Thanks,
Jialuo
