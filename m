Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6023D8915
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939735; cv=none; b=iEGonCwF0QOAwQyf9bMmTfkJEjHcvTD5FJV8PQmtd0UEmvMBqRPFNRcEZw79T20Su0i0c11KYdJeS0uwVXujlnp4YwyD+Mbk3/mykYvy5r3/LR/nqUf5SaQKHuSuqeave4J77dfXGKqt3pGy37u3IqS+tYkwvPO8ojhThwqUbZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939735; c=relaxed/simple;
	bh=sPd2L6tHgdPtdA50Vic2LCvJswp9c2x3zTO2oFJ3i6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWsgrnrXHxrN8k91m7iQ8nLMlONKCPOPtlkDXzAHnuYywmVLQB3pL4pWei8nWTuOYHTWRc2+XsstkVBQ6YC4HyFLveaWgstwJnk7UdwFkBWqwyF7KOG5qIxtfj0K8pDMiL2aJYOkLEsIM90zONlMcmKoVtNG9Ppg0r0FvNXm9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r9QGi5fE; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9QGi5fE"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-48657fc84a3so4052779b6e.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 10:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780939732; x=1781544532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fTI3zym0KmkfFwJzeUvHvR+rM90BCGf/VGtDiCSR4sc=;
        b=r9QGi5fE4/JIYPdfIlNVYTMFZjbagL94CH6gANI6+6/06c4Z66c24qaP5LdW+AioB7
         hUEYdG0bEnlOC3LgxTHNl4NFmukpU9Mf5qKINSd0rQF6KFcW/jTpkTctzerNAhrscqpB
         wKl+OZiiQhcZ6Mr0tzHq+D/g7GowUzDw9oUU7q0EOkgAyYDrfNHIb+nBSk/dj01P4GwZ
         MlKqfNuEKQQ7rTJInZ5e2b3f46EYbFMMGHroXim1pdUmcf9uIRT7SbiBK7xhQZT7HA1O
         SAbm70FR/zcv7zJWwg0DUxJvibBFvMU/Cp3vn1IbEuYekUoYB075f5peZVakMgavGvk2
         16pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780939732; x=1781544532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTI3zym0KmkfFwJzeUvHvR+rM90BCGf/VGtDiCSR4sc=;
        b=qrgxdetBLLS0L1fgxBAIJsQQF3MZj0rjeZpaJLGHQUXklkyVvigJRnsuWuf1QHPNp2
         EaE9gqtF27beRjGMVfziu4qfeSPoHrxM/E6mKc1a1twyFZ113Soy98EgwQm6QgNVLivs
         0OFd8yN2RUgDXY/eGJseJ8YaKJDTxqZ/g0T5XTnu7N0WwdWKQLtkFNxR0byg8h6QxUjQ
         0lEnX2pNYYzDzCknNxj/tkwteKjWoQR0JaLKSVzWltJVz7FvrVUA2NOWNEBjdsnfmtvy
         WrNcKQ6F4tEV+pKEJtu5k3I+ehKKyIGsnk/xoufPNVJllwy71AqZ4+YqrbKVI+Hk6f3b
         zcgQ==
X-Gm-Message-State: AOJu0YxE6pkPtthw6ZR9f2OgRbQyEUopkSSbbsNn0XSrcHg6t4XEW+FW
	L6NchvTOJ+H49UzLb+5PQ7IWd8qtuE9IfTaA3BsZApSvz06ehekLJT75
X-Gm-Gg: Acq92OEZ47nv/g7zmMJBsGExyUKuVFG3q0rETtyvbvQtmu5TY60qspclMWKR6JuzKfc
	dsk074Q2zfz/TzI0yb5nBftriVocBl4pQcDmjFHEQIPYLFoL+hBgO3TLyN8YM9aIXEKv6FIln8A
	mT+OJ1vrEFD4HSbg0/qAouH/Q8ToWsTdq3aHr4a5JQe2+8OmejbSw1oEOaKPP8H8jWXRtSVIfwP
	i4cNFGj1FesvLCBy4sESTKn5NqdZkytWrpJZQFW7t2/6M2SfjxezgGiN00Tv1lKdY24HhUJNWUa
	B13C3rXyUyT7cgns4AHoI/4mR3xEmW9I7+G2i0c+BQZLih+ywY7Lj81I2RIcPRDS+51j8UrJqM4
	TNFKGnSI1KEG4pROq/jXi3vrCAIz6GsdFafjgNp8SxPwvjNDUSYKbzJNSMLIBWKeMy789sCKkXb
	XhHhlIncdMcUtgnAP5g8mjaGNjLCI=
X-Received: by 2002:a05:6808:2223:b0:485:403d:9b8d with SMTP id 5614622812f47-4868ddc4157mr9983259b6e.11.1780939732485;
        Mon, 08 Jun 2026 10:28:52 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b6ec694sm13935681b6e.5.2026.06.08.10.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 10:28:52 -0700 (PDT)
Date: Mon, 8 Jun 2026 12:28:49 -0500
From: Justin Tobler <jltobler@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, a3205153416@gmail.com, gitster@pobox.com, 
	kumarayushjha123@gmail.com, lucasseikioshiro@gmail.com, phillip.wood@dunelm.org.uk, 
	sandals@crustytoothpaste.net
Subject: Re: [GSoC PATCH v2 1/4] path: introduce format_path() for
 centralized path formatting
Message-ID: <aib2DuP7uS3YF5VD@denethor>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-2-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605163012.181089-2-jayatheerthkulkarni2005@gmail.com>

On 26/06/05 10:00PM, K Jayatheerth wrote:
> The path-formatting logic inside `builtin/rev-parse.c` handles absolute,
> canonical, and relative formatting rules based on user-supplied options.
> However, this logic is tightly coupled to `rev-parse` and writes directly
> to stdout.
> 
> To allow other builtins (such as the upcoming `git repo` path keys) to
> re-use this logic, extract the core path-formatting algorithm into a centralized
> helper function, `format_path()`, in `path.c`.

Makes sense.

> Expose a single, streamlined `path_format` enum in `path.h` to let callers
> explicitly declare their formatting strategy (UNMODIFIED, RELATIVE,
> RELATIVE_IF_SHARED, or CANONICAL). This decouples the core algorithm from
> the localized fallback mechanics specific to `rev-parse`.

Ok, so rev-parse has its own logic to select the formatting strategy
used when printing paths that either relies on what the user provides or
a designated fallback format that is specific to the type of path. Since
that is specific to rev-parse, it makes to factor it out of the generic
helper function here.

> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> Mentored-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  path.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  path.h | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
> 
> diff --git a/path.c b/path.c
> index d7e17bf174..2fcd24c5eb 100644
> --- a/path.c
> +++ b/path.c
> @@ -1579,6 +1579,64 @@ char *xdg_cache_home(const char *filename)
>  	return NULL;
>  }
>  
> +void format_path(struct strbuf *buf, const char *path,
> +		 const char *prefix, enum path_format format)
> +{
> +	if (format == PATH_FORMAT_UNMODIFIED) {
> +		strbuf_addstr(buf, path);
> +		return;
> +	}
> +
> +	if (format == PATH_FORMAT_RELATIVE) {

nit: we could just continue the "else if" chain here instead of
restarting it.

> +		struct strbuf relative_buf = STRBUF_INIT;
> +		struct strbuf real_path = STRBUF_INIT;
> +		struct strbuf real_prefix = STRBUF_INIT;
> +		char *cwd = NULL;
> +
> +		/*
> +		 * We don't ever produce a relative path if prefix is NULL,
> +		 * so set the prefix to the current directory so that we can
> +		 * produce a relative path whenever possible.
> +		 */
> +		if (!prefix)
> +			prefix = cwd = xgetcwd();
> +
> +		if (!is_absolute_path(path)) {
> +			strbuf_realpath_forgiving(&real_path, path, 1);
> +			path = real_path.buf;
> +		}
> +		if (!is_absolute_path(prefix)) {
> +			strbuf_realpath_forgiving(&real_prefix, prefix, 1);
> +			prefix = real_prefix.buf;
> +		}
> +
> +		strbuf_addstr(buf, relative_path(path, prefix, &relative_buf));
> +
> +		strbuf_release(&relative_buf);
> +		strbuf_release(&real_path);
> +		strbuf_release(&real_prefix);
> +		free(cwd);
> +	} else if (format == PATH_FORMAT_RELATIVE_IF_SHARED) {
> +		struct strbuf relative_buf = STRBUF_INIT;
> +
> +		/*
> +		 * If we're using RELATIVE_IF_SHARED mode, then we want an
> +		 * absolute path unless the two share a common prefix, so don't
> +		 * default the prefix to the current working directory. Doing so
> +		 * would cause a relative path to always be produced if possible.
> +		 */
> +		strbuf_addstr(buf, relative_path(path, prefix, &relative_buf));
> +		strbuf_release(&relative_buf);
> +	} else if (format == PATH_FORMAT_CANONICAL) {
> +		struct strbuf canonical_buf = STRBUF_INIT;
> +
> +		strbuf_realpath_forgiving(&canonical_buf, path, 1);
> +		strbuf_addbuf(buf, &canonical_buf);

Do we need `canonical_buf` here? Can we just add the path to `buf`
directly?

> +
> +		strbuf_release(&canonical_buf);
> +	}
> +}
> +
>  REPO_GIT_PATH_FUNC(squash_msg, "SQUASH_MSG")
>  REPO_GIT_PATH_FUNC(merge_msg, "MERGE_MSG")
>  REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
> diff --git a/path.h b/path.h
> index 0434ba5e07..a78e0fc141 100644
> --- a/path.h
> +++ b/path.h
> @@ -262,6 +262,36 @@ enum scld_error safe_create_leading_directories_no_share(char *path);
>  int safe_create_file_with_leading_directories(struct repository *repo,
>  					      const char *path);
>  
> +/**
> + * The formatting strategy to apply when writing a path into a buffer.
> + */
> +enum path_format {
> +	/* Output the path exactly as-is without any modifications. */
> +	PATH_FORMAT_UNMODIFIED,
> +
> +	/* Output a path relative to the provided directory prefix. */
> +	PATH_FORMAT_RELATIVE,
> +
> +	/* Output a relative path only if the path shares a root with the prefix. */
> +	PATH_FORMAT_RELATIVE_IF_SHARED,
> +
> +	/* Output a fully resolved, absolute canonical path. */
> +	PATH_FORMAT_CANONICAL
> +};
> +
> +/**
> + * Format a path according to the specified formatting strategy and append
> + * the result to the given strbuf.
> + *
> + * `buf`    : The string buffer to append the formatted path to.
> + * `path`   : The path string that needs to be formatted.
> + * `prefix` : The directory prefix to calculate relative offsets against.
> + * Pass NULL to default to the current working directory where applicable.
> + * `format` : The formatting behavior rule to execute.
> + */
> +void format_path(struct strbuf *buf, const char *path,
> +		 const char *prefix, enum path_format format);
> +

Ok so in this patch we are just adding the new path formatting
interface and will integrate it in the next one. Overall the direction
of this patch looks good to me.

-Justin
