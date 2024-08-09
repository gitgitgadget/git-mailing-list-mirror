Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4D73C099
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723225051; cv=none; b=RojkuxbJ952n+qteY6VLQ6JYOCK2M++Hu4n1p3ITpil898RsPs7og6W+C6HlGOJirJZFh1LjZDUETKRz2ui5/avqxQ4xEiz+1tDCBu9tPJXgZ7wbY3EwwDc7HyvJukfJXbDzGcD10PI9SRn2siC9E4m7BqtIEZ6Ij9LOBBEdEi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723225051; c=relaxed/simple;
	bh=L29x/o51jhtagI4IcbSb8Ab2OHVFa2BQTCQ8E93RZzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/Rhn2gWqxcumK1NXdrxE9GpK+BDhWayp5WbvfsykgV57nLSXS6WfeV03pQbNI9zEtOX3gdHFwl6lVIHR7MSNK5lsP5/VsCMI673R4L01dqOnt2OgdaGacyZBr8J67i75yv1zjsMD6yCejbVNG6XrIqsZ7Wqd/W3O1zHmuABQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6yQm83v; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6yQm83v"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70938328a0aso1264245a34.1
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 10:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723225049; x=1723829849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7euUbl0IXeAJqodKqaaaAytCKuCiX2Q1k9mZlzbRcQY=;
        b=A6yQm83vJHDkUyUy77Dcf6P7b29NvtFpsQ6XoyKhgFV51/kYS5GIQO1rw6LPa2mDWV
         GxYDr17nXDuBGgYrMPE1V/KES7uS803GETPZqn2siGeu2tYcyJEvTSeGSU2E1ZCVFzIi
         9FuE4zkv5VigCgJ7cwHy2m2ryjXClDhyiI2oPZJEsyAKcpoPVnwhgz2AI9w7OxvRUKDN
         9kTKWhqBCNpxDWG8Ti8v07/5lSKZ7mhYNfZ5a0uqO0SZntlukeAukWbZqWhyp2hxArVB
         dbL7i1ZNBBPRoZYw1F/Vbdkv2gYlm6XqjwfV8uwJ0rm1Lw25VQqR2J+08IyOAArk0PEi
         xWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723225049; x=1723829849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7euUbl0IXeAJqodKqaaaAytCKuCiX2Q1k9mZlzbRcQY=;
        b=wW3PGbe8tpSkk+tPkxuZUdLK11950oxWzhaZzgo3dpE5NZgL7rL+jLshRYl8XQn227
         c0bqTbzxvDmOhLVgswuyqpVEwo/xukpMAvWfS3spOxzlTesWmvsrtSQxvI/JGMDNjBM7
         AcXpCgx7zCfYR43hMClRgY5z/+zPt11WT+jF7l22qUBOs775EBAOllCKYVAmcx6t/3xV
         XdIbnlkNIKtdkHupQtlTe4GdDeQFhy5CF0hS1FKIyrJyyVpxEw9sipRvZpynmfOBOpBv
         gsIjFG5bZe8ea0MkySqGzc8HYWbvJuXW61ZP8xOR51Ut0nDJBE4ora/jq8/sMHyOkLJv
         7frw==
X-Gm-Message-State: AOJu0Yy8bq45n0/TWiScG8+LjM/Hb4+lMsLRfHtQXM90EPCrLIbQ4N5U
	xVsswe9kJRtBvnEJoJ7NWeheoj+6ZihGeTIwfnMWM+FXE5gae6vV2tnKPA==
X-Google-Smtp-Source: AGHT+IGVWmN45RV999iWAjcdXL2d72P0sxtWqHJ3huiH4HS0GWDOCVQ/qdpP0N2qs99UnntkqfFLLQ==
X-Received: by 2002:a05:6830:310c:b0:709:61d:edad with SMTP id 46e09a7af769-70b746e3995mr2779428a34.8.1723225049326;
        Fri, 09 Aug 2024 10:37:29 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70c7b80e9c9sm35926a34.5.2024.08.09.10.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 10:37:29 -0700 (PDT)
Date: Fri, 9 Aug 2024 12:36:41 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/20] editor: do not rely on `the_repository` for
 interactive edits
Message-ID: <zvkqwebiqktmpsithuf5bf2ugwpwfzi5jc2wpk53ewz4nlns4r@kdbzz4hmuhjk>
References: <cover.1723013714.git.ps@pks.im>
 <c2556fff9e25aabab237c5902aff64f65b0a953f.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2556fff9e25aabab237c5902aff64f65b0a953f.1723013714.git.ps@pks.im>

On 24/08/07 08:56AM, Patrick Steinhardt wrote:
> We implicitly rely on `the_repository` when editing a file interactively
> because we call `git_path()`. Adapt the function to instead take a
> `sturct repository` as parameter so that we can remove this hidden

s/sturct/struct/
s/parameter/a parameter/

> dependency.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  add-patch.c |  3 ++-
>  editor.c    | 12 +++++++-----
>  editor.h    |  3 ++-
>  3 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/add-patch.c b/add-patch.c
> index 46f6bddfe5..4e3aa02ed8 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1140,7 +1140,8 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
>  				"removed, then the edit is\n"
>  				"aborted and the hunk is left unchanged.\n"));
>  
> -	if (strbuf_edit_interactively(&s->buf, "addp-hunk-edit.diff", NULL) < 0)
> +	if (strbuf_edit_interactively(&s->buf, "addp-hunk-edit.diff", NULL,
> +				      the_repository) < 0)
>  		return -1;
>  
>  	/* strip out commented lines */
> diff --git a/editor.c b/editor.c
> index d1ba2d7c34..6c461dd253 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -134,13 +134,15 @@ int launch_sequence_editor(const char *path, struct strbuf *buffer,
>  }
>  
>  int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
> -			      const char *const *env)
> +			      const char *const *env, struct repository *r)
>  {
> -	char *path2 = NULL;
> +	struct strbuf sb = STRBUF_INIT;
>  	int fd, res = 0;
>  
> -	if (!is_absolute_path(path))
> -		path = path2 = xstrdup(git_path("%s", path));
> +	if (!is_absolute_path(path)) {
> +		strbuf_repo_git_path(&sb, r, "%s", path);
> +		path = sb.buf;
> +	}

By switching from `git_path()` to `strbuf_repo_git_path()`,
`strbuf_edit_interactively()` no longer implicitly depends on
`the_repository`. This requires a `struct repository` be injected into
`strbuf_edit_interactively()`. The function signature is updated along
with the single call site. The small cleanup also looks good. Makes
sense to me.

Non-blocking: Instead of appending `struct repository` as the last
argument, it might be nicer to match `strbuf_repo_git_path()` and place
it as the second argument.

>  	fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
>  	if (fd < 0)
> @@ -157,6 +159,6 @@ int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
>  		unlink(path);
>  	}
>  
> -	free(path2);
> +	strbuf_release(&sb);
>  	return res;
>  }
> diff --git a/editor.h b/editor.h
> index 8016bb5e00..d4c4d216ac 100644
> --- a/editor.h
> +++ b/editor.h
> @@ -1,6 +1,7 @@
>  #ifndef EDITOR_H
>  #define EDITOR_H
>  
> +struct repository;
>  struct strbuf;
>  
>  const char *git_editor(void);
> @@ -29,6 +30,6 @@ int launch_sequence_editor(const char *path, struct strbuf *buffer,
>   * If `path` is relative, it refers to a file in the `.git` directory.
>   */
>  int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
> -			      const char *const *env);
> +			      const char *const *env, struct repository *r);
>  
>  #endif
> -- 
> 2.46.0.dirty
> 


