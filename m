Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6B918FDAB
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575541; cv=none; b=m7UvsXLCZi563Zvd1yFlIhIJoYhIJwM0L1dmFAj59HZvH9IiuX9OdWAXeRgQP7g2F6awzhQYPbZoUZkAp6HsUNAqfUZXE58WEcozcpUBS9LOXvWVMe4RiCyLx15oAsVMAp7G8V5NFOA2Fxj1/DOZRsZ+xXOvsRuocyR0n7KgPLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575541; c=relaxed/simple;
	bh=VjOaQYQSxyk8gzzlyLhQHm8VCveD1F+zKqu2Yi+fOZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKoqS43RsDx3V4d/odMsRrRXVdKGN40DVXis4VGGfMA3BaHl6mjowJ5XcrHIkEtQaH4ramHiB6HttQf8nx8vSpAehVyxZAwYEizRzCNbeZQYhX7oVivTK4kvdFf6qtfAZWHk3kzOrQn1n3z+mjIZ+fdAWpJfBouG8+pyZy87PEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZT6uXDs; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZT6uXDs"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71df1fe11c1so922999b3a.2
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 08:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728575539; x=1729180339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2FtgeFdQW5tiBNyn3fJrCz31SX0lJKlv3G55bd5iL98=;
        b=MZT6uXDsmV2jpz6SyZ0o+Vs5dQ3kB0zR//sc0aFulDu9BEi2bPKFs9jX/NFSx8v2ZB
         VREqha1vNCkdbJslsymJmXP/irrkIGDwOEpdctuIhP95LmPyDWV1C7hv0ogUi5KYB4LV
         wbVzoiBj4B672Cw0umjHkdIx4YRTG5bnd1fybAf3wnS5FNNTDpNdwwVsYTW4oTO3Kkbz
         GY8/wTT4rvu0Zz+EI21L/caOeNxJJjS0CC2rxy/di65V3OatRzj3gU9pykji4zmGbG7A
         eza0clsBMbzJksrX0FkY416r42D/3OuwsnUBBuwYfLdC6I0QZgPHPbrsfyfNKYyDK8F0
         tEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728575539; x=1729180339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FtgeFdQW5tiBNyn3fJrCz31SX0lJKlv3G55bd5iL98=;
        b=YADB14nQC2wpulNejxybn/SmGSe+qYBFGDHpiVvqV8lq6vCbVyuwi5IAfHdk2y5KQT
         fb8MP0Oxo4nUrDsIiYUwXSXHuYd4PqqdayGqYqrRLFPo+haLxhrfjz6Lgfa+QvfJwIf5
         gditvaSBkHunr1z4EWBrhbG36zIokp6LXBgowcSzEPwgG+yQc4rlDIWuYsubikEbFvfO
         m1slG2b1Zk2KLFgDLIglbN+jzjpBf16bAkJDV/lyK1eLyBZZbQ4kHy5F21mFbrmZkeeX
         jcTEvW5Uodda7wZzcewlQPrQUhfwd2n4e8jHc/dTNz2w81Lxm+zPrGgCfTbrXIXTnZ4L
         uZqg==
X-Gm-Message-State: AOJu0YyGlTK8ElSohZ8z7mfha05blH4H382UUh3HVkDqjyw85mWqkOZw
	qY2J7ryKTcefuLu+nHJPxViZHNV0w6OG/cIMwhSX9jp8LEpDtwIZ+OaT7Q==
X-Google-Smtp-Source: AGHT+IH/6OsWi+Di+ydC1jXLScdeSz4s3AfwJ7S3pvf3nuYlUV3R3n8JbBZqiKjeyEfXZlOjLeeUsQ==
X-Received: by 2002:a05:6a00:1404:b0:71d:f2e3:a88c with SMTP id d2e1a72fcca58-71e36179820mr100106b3a.1.1728575539065;
        Thu, 10 Oct 2024 08:52:19 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9f6982sm1175316b3a.77.2024.10.10.08.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:52:18 -0700 (PDT)
Date: Thu, 10 Oct 2024 23:52:29 +0800
From: shejialuo <shejialuo@gmail.com>
To: cdwhite3@pm.me
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] worktree: refactor infer_backlink() to use *strbuf
Message-ID: <Zwf4PT-vaLX35ELL@ArchLinux>
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me>
 <20241007-wt_relative_paths-v3-1-622cf18c45eb@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-wt_relative_paths-v3-1-622cf18c45eb@pm.me>

On Mon, Oct 07, 2024 at 10:12:30PM -0500, Caleb White via B4 Relay wrote:
> From: Caleb White <cdwhite3@pm.me>
> 
> This lays the groundwork for the next patch, which needs the backlink
> returned from infer_backlink() as a `strbuf`. It seemed inefficient to
> convert from `strbuf` to `char*` and back to `strbuf` again.
> 

I think here we should first talk about the current behavior of the
`infer_backlink`:

    `infer_backlink` initializes a "strbuf" for the inferred backlink
    and returns the result with type "char *" by detaching the "strbuf"

And then you should tell your intention like the following (The reader
like me does not know what is the intention of the next patch, you should
__explicitly__ mention this).

    Because we decide to link worktrees with relative paths, we need to
    convert the returned inferred backlink "char *" to "strbuf".
    However, it is a bad idea to convert from `strbuf` to `char*` and
    back to `strbuf` again. Instead, we should just let the
    `infer_backlink` to accept the "struct strbuf *" parameter to
    improve efficiency.

> This refactors infer_backlink() to return an integer result and use a
> pre-allocated `strbuf` for the inferred backlink path, replacing the
> previous `char*` return type and improving efficiency.
> 

I think you should also talk about that you make the
`repair_worktree_at_path` function to align with above refactor.

> Signed-off-by: Caleb White <cdwhite3@pm.me>
> ---
>  worktree.c | 48 ++++++++++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/worktree.c b/worktree.c
> index ec95ea2986107b3bc12d38b0825d7c6e87402bc6..0cba0d6e6e9ad02ace04a0301104a04a07cbef65 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -642,10 +642,9 @@ static int is_main_worktree_path(const char *path)
>   * be able to infer the gitdir by manually reading /path/to/worktree/.git,
>   * extracting the <id>, and checking if <repo>/worktrees/<id> exists.
>   */
> -static char *infer_backlink(const char *gitfile)
> +static int infer_backlink(const char *gitfile, struct strbuf *inferred)
>  {
>  	struct strbuf actual = STRBUF_INIT;
> -	struct strbuf inferred = STRBUF_INIT;
>  	const char *id;
>  
>  	if (strbuf_read_file(&actual, gitfile, 0) < 0)
> @@ -658,17 +657,18 @@ static char *infer_backlink(const char *gitfile)
>  	id++; /* advance past '/' to point at <id> */
>  	if (!*id)
>  		goto error;
> -	strbuf_git_common_path(&inferred, the_repository, "worktrees/%s", id);
> -	if (!is_directory(inferred.buf))
> +	strbuf_reset(inferred);

Question here: should we use `strbuf_reset` here? I want to know the
reason why you design this. Is the caller's responsibility to clear the
"inferred" when calling this function?

> +	strbuf_git_common_path(inferred, the_repository, "worktrees/%s", id);
> +	if (!is_directory(inferred->buf))
>  		goto error;
>  
>  	strbuf_release(&actual);
> -	return strbuf_detach(&inferred, NULL);
> +	return 1;
>  
>  error:
>  	strbuf_release(&actual);
> -	strbuf_release(&inferred);
> -	return NULL;
> +	strbuf_reset(inferred); /* clear invalid path */
> +	return 0;
>  }

Design question, when calling `infer_backlink` successfully, we will
return 1, if not, we will return 0. But in the later code, we use the
"inferred.buf.len" to indicate whether we could get the inferred
backlink successfully.

We have two signals to indicate the success. I think it's a bad idea to
use "inferred.buf.len". Let me give you an example here:

    struct strbuf inferred_backlink = STRBUF_INIT;
    inferred_backlink = infer_backlink(realdotgit.buf);

    // What if I wrongly use the following statements?
    strbuf_addstr(&inferred_backlink, "foo");

    if (inferred_backlink.buf.len) {

    }

If you insist using "inferred_backlink.buf.len" as the result, this
function should return `void`. And you should add some comments for this
function.

>  
>  /*
> @@ -680,10 +680,11 @@ void repair_worktree_at_path(const char *path,
>  {
>  	struct strbuf dotgit = STRBUF_INIT;
>  	struct strbuf realdotgit = STRBUF_INIT;
> +	struct strbuf backlink = STRBUF_INIT;
> +	struct strbuf inferred_backlink = STRBUF_INIT;
>  	struct strbuf gitdir = STRBUF_INIT;
>  	struct strbuf olddotgit = STRBUF_INIT;
> -	char *backlink = NULL;
> -	char *inferred_backlink = NULL;
> +	char *dotgit_contents = NULL;
>  	const char *repair = NULL;
>  	int err;
>  
> @@ -699,23 +700,23 @@ void repair_worktree_at_path(const char *path,
>  		goto done;
>  	}
>  
> -	inferred_backlink = infer_backlink(realdotgit.buf);
> -	backlink = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));
> -	if (err == READ_GITFILE_ERR_NOT_A_FILE) {
> +	infer_backlink(realdotgit.buf, &inferred_backlink);
> +	dotgit_contents = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));
> +	if (dotgit_contents) {
> +		strbuf_addstr(&backlink, dotgit_contents);
> +	} else if (err == READ_GITFILE_ERR_NOT_A_FILE) {
>  		fn(1, realdotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
>  		goto done;
>  	} else if (err == READ_GITFILE_ERR_NOT_A_REPO) {
> -		if (inferred_backlink) {
> +		if (inferred_backlink.len) {
>  			/*
>  			 * Worktree's .git file does not point at a repository
>  			 * but we found a .git/worktrees/<id> in this
>  			 * repository with the same <id> as recorded in the
>  			 * worktree's .git file so make the worktree point at
> -			 * the discovered .git/worktrees/<id>. (Note: backlink
> -			 * is already NULL, so no need to free it first.)
> +			 * the discovered .git/worktrees/<id>.
>  			 */
> -			backlink = inferred_backlink;
> -			inferred_backlink = NULL;
> +			strbuf_swap(&backlink, &inferred_backlink);
>  		} else {
>  			fn(1, realdotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
>  			goto done;
> @@ -743,13 +744,11 @@ void repair_worktree_at_path(const char *path,
>  	 * in the "copy" repository. In this case, point the "copy" worktree's
>  	 * .git file at the "copy" repository.
>  	 */
> -	if (inferred_backlink && fspathcmp(backlink, inferred_backlink)) {
> -		free(backlink);
> -		backlink = inferred_backlink;
> -		inferred_backlink = NULL;
> +	if (inferred_backlink.len && fspathcmp(backlink.buf, inferred_backlink.buf)) {
> +		strbuf_swap(&backlink, &inferred_backlink);
>  	}

For single line statement after "if", we should not use `{`.

>  
> -	strbuf_addf(&gitdir, "%s/gitdir", backlink);
> +	strbuf_addf(&gitdir, "%s/gitdir", backlink.buf);
>  	if (strbuf_read_file(&olddotgit, gitdir.buf, 0) < 0)
>  		repair = _("gitdir unreadable");
>  	else {
> @@ -763,9 +762,10 @@ void repair_worktree_at_path(const char *path,
>  		write_file(gitdir.buf, "%s", realdotgit.buf);
>  	}
>  done:
> -	free(backlink);
> -	free(inferred_backlink);
> +	free(dotgit_contents);
>  	strbuf_release(&olddotgit);
> +	strbuf_release(&backlink);
> +	strbuf_release(&inferred_backlink);
>  	strbuf_release(&gitdir);
>  	strbuf_release(&realdotgit);
>  	strbuf_release(&dotgit);
> 
> -- 
> 2.46.2
> 
> 

Sorry, I could not review other patches today (I need to go sleep).

Thanks,
Jialuo
