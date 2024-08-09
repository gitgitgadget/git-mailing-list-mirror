Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE825624
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230191; cv=none; b=fS5QqMQUmv7Cs5wnbTyakTDofvp+LSmmFA85tT9WyLmsQqYOhEOgdZfKraCn1JIUudR4VJ/03LrwhXq/K97SlGI+ubGOflowV0gwVqh4ozB6PFdIuSWZn9r+Q8NTZfBMaAaQ116tabhdaMkbU4I3zdRzchALwUV+F1Eal5lCYEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230191; c=relaxed/simple;
	bh=bOWK6Uwpbfp/mxwah2j1c6Xcg83r6mwA9F2aBjSKPGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQfbCksaKgFQPld5r1/khEiYHhPUt1DjA5+TJkchhzRXDZA8ZwGtJBXWs7vrLpm1xpwQnjB0MrUCDrcwj3xwkDbuq0H/pgWXgxKSE6UuljP/1/VLVNBFeSP7yAApikKoqXTwQ+RuaK4scZ/1ny2PG+z1KhoCX6z5vT0bNYlsTCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgTteXHR; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgTteXHR"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-70944dc8dc6so1159968a34.3
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 12:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723230189; x=1723834989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s56/wY/dg2baKCZtVl/WN7goowuNknMavXHBXmTVDTs=;
        b=lgTteXHRB1qE7wp3JZl0qzg4Vdx0xjQvA/tn/Y49KEzQczVo8WgLRngveLvkfxuTgB
         zrIvq7QIElW2Y0FN/KdybgJSFkk+DbFTdJ5eaYKttPWApgRcowjdAgoI3KPtfKMrJB8F
         SB5WXaZRZwEuSYm9TzxjAL3SHtG61KCVOC0bVuMxvnz5okX1G9OJ59KoZI5UdCf8XrX4
         qxI2O3u5j/WKEbk48V2ruHVP5xT4B3LHc/bn7msoq8Hny0mjmfzRyJzXYFzN+WxEtazo
         bsWZT7hfa6kna68gGy+KIeb0TXOWJjouCT07zHElOamGqpm8+BA6fiWo9mLz2bEifimq
         bKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723230189; x=1723834989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s56/wY/dg2baKCZtVl/WN7goowuNknMavXHBXmTVDTs=;
        b=QeovzSihzM5Gc2GNJuDBZvgLf+zICbGqRdJU/TvUWHbJBULFWsroAG1uUF6dxGiEy3
         KW9BMZOCGxRQibd7XWSBNcrMJ1ES7UgRwtCk8S0h7ZfJ8D8+O417Ya8/Rr5f1Uy2IWPj
         4g8M4E3J2s5QX5VV8gktRxloPOl/+k+2+pJbvVHjJcXalBNDj/P/YrwlYHRDxTu2uZdM
         8G20Xp3qHR9TLdDAViW438Wv6eyAKIsDa+bfz/x4ME9d6khV+MzDEQ44o7CQ9mXAZ8dt
         5vmAC9UHMBfwp5p/LknZ0OC/EXXbQir1FNNrg2bPMa7u4ERPsuDl2W/d/Kq0YVH7fRyC
         2O3g==
X-Gm-Message-State: AOJu0Yx74ccxgGqO4KF1iHhYNZJguwiHT2QTSM6vvFGOnk1LxyPtTzz+
	E/N2tIXbEj2MfNruQMwCtbGbQPqoj38mbjePwwuVJxWnsHjvsojGoTiOLw==
X-Google-Smtp-Source: AGHT+IFFYRXoPMFdgDlRwMVZA+OPxJn2NTPbSP7IXxdS2f6g/WEmslgHaHyJtjiBvJaa7JOm3ulqLQ==
X-Received: by 2002:a05:6830:6187:b0:709:3c0a:ff00 with SMTP id 46e09a7af769-70b74878392mr3349476a34.24.1723230188890;
        Fri, 09 Aug 2024 12:03:08 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70c7b82a334sm88235a34.44.2024.08.09.12.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 12:03:08 -0700 (PDT)
Date: Fri, 9 Aug 2024 14:02:21 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/20] path: stop relying on `the_repository` in
 `worktree_git_path()`
Message-ID: <cqc4xlbrusu5edfsh2snvekkd2qfwjxu3x33pzizp22rsuidbw@pz4e3fsqfhgv>
References: <cover.1723013714.git.ps@pks.im>
 <67405dcd0a121aee971f854dc35ba89bd4f808c4.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67405dcd0a121aee971f854dc35ba89bd4f808c4.1723013714.git.ps@pks.im>

On 24/08/07 08:57AM, Patrick Steinhardt wrote:
> When not provided a worktree, then `worktree_git_path()` will fall back
> to returning a path relative to the main repository. In this case, we
> implicitly rely on `the_repository` to derive the path. Remove this
> dependency by passing a `struct repository` as parameter.

Are there many situations where `worktree_git_path()` would expect to
not be provided a worktree? I wonder whether this implicit behavior is
really necessary to begin with.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip] 
> -const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
> +const char *worktree_git_path(struct repository *r,
> +			      const struct worktree *wt, const char *fmt, ...)
>  {
>  	struct strbuf *pathname = get_pathname();
>  	va_list args;
> +
> +	if (wt && wt->repo != r)
> +		BUG("worktree not connected to expected repository");

So if we receive a worktree, we expect that it should always match the
main repostiory. Makes sense.

> +
>  	va_start(args, fmt);
> -	repo_git_pathv(the_repository, wt, pathname, fmt, args);
> +	repo_git_pathv(r, wt, pathname, fmt, args);
>  	va_end(args);
>  	return pathname->buf;
>  }
> diff --git a/path.h b/path.h
> index 3d21b9cd16..6228ca03d7 100644
> --- a/path.h
> +++ b/path.h
> @@ -97,9 +97,10 @@ const char *git_path(const char *fmt, ...)
>   * Similar to git_path() but can produce paths for a specified
>   * worktree instead of current one
>   */

Now that the previously implicit behavior is more explicit, it might be
update the comment to explain that the provided repository is used as a
fallback.

> -const char *worktree_git_path(const struct worktree *wt,
> +const char *worktree_git_path(struct repository *r,
> +			      const struct worktree *wt,
>  			      const char *fmt, ...)
> -	__attribute__((format (printf, 2, 3)));
> +	__attribute__((format (printf, 3, 4)));

Overall, I quite like how this series is bubbling up `the_repository`
usages from the bottom up. :)
