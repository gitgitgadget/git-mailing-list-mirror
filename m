Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C5826CE1C
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752607252; cv=none; b=n99J9AyrMMNAWRQaK8s9gbwgqRUBrsQWsfBsLXpsH4MpL4bVUu/hjA+g6Q13I4yN5T8oU7gAoXPpz4K+Q/7CQiKNin/XrrCmBnrVNnOpZNDOXLNgBTltBNRv0e4cgQuNhQEVPtzt241w10PvzshI+o4Z67DEgYVXuRAbD/72FSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752607252; c=relaxed/simple;
	bh=PWviarzZFuYp3o/yw6TafUd9r5gIUUfNs9PlVfSZ7Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfFwPKTBShYgJCnrO6BA+cShMF3ybtpumviqoeeI9XeMRkJJGGIq7RCBRh4HKa8gjssxuQ8G8WQOXDQsWvzu3VOEh3rG4EDE1yD/pcym7eSCr9BzqIIeubxu3ZKe/f1gPHQUQz7d0RPAjGnNqhAARNW5yEdH/oxEmqBTj20nOxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCMMD1ei; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCMMD1ei"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2f78ef10832so3571618fac.3
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752607250; x=1753212050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gTg3hCsUo/mEjGZYYpEtkhEKYvuBXXzFVA6nn16U5Lw=;
        b=kCMMD1ei4qF7mBPi9MxQf1gft4KXalDgJbAwz4m8PV7sszvW8kQ+EmltCN5eYeyVlA
         t99t0AxfaTwbKhKkE39x41FuT1z5s+AGAaKKNOXdV2WxWrB/GeiWI3IkbbP668ZaLS7K
         l0fD74ReRLuVODmmWRyBFhQ9wV7pplJhYJf1KVumxTtmgUs/xs0pU6bYZ+u8cOHhmt0j
         aGi6I/RP5dQ/sh0IQ+OO+zsW8FcliTH5JrmU4Jg9DsuERNjsAZts39FYN8PZbgVZ2eBy
         bNO7mIjs0+vw6Z9pY/bmlv7pA2kBUh82t5XVUg4hE+rN3q4dJh9uMNcHUVSd9q66Mm7h
         /64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752607250; x=1753212050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTg3hCsUo/mEjGZYYpEtkhEKYvuBXXzFVA6nn16U5Lw=;
        b=V1c18fPRQaGqioHEBMUSA3T3C5A8gaXW8PNMgdbewFr/9jRmGb3ntRKpzStCw1ymu8
         slkbGfBtLOjZ6Jp4PFoKrwvcDyuQQ+ykHtsev79FBZohy1miuKkwlxwDrutVBG8Ubg8N
         z8/TQjzhVeVcSYpCpNZ34zO6rjZ6PCVF3DPLeWkc7vZmYEXdEvC/mk5j9OP+dnT33myd
         zPtVpwjCn9VdKBrWHIIE4HCChGtf/pFnMq6vKFYH4kAfSFNy/KQQsUA3ezfQk2pYzMBI
         DBAJu5FrSSh9IbLGIVs775TtA8rvFSiVRBHNztWRk/4p+6LPh8tNRJF67h2p4u8qV8kt
         p4Pg==
X-Gm-Message-State: AOJu0Yzw9EmIm3EAh4vq7fHWf4vSBWCw3OGyS7JtNpxJXI6Wm2byxZi4
	PrJ/uhjg+ev3delo1gYf6nzvOtMxWZPF3oztti6pMOXw0fowhEIy6QdeONpfmw==
X-Gm-Gg: ASbGncsRRKu/tPqtASHwXWmoOIBXw5ioKr4KUj/PwnAOW6lCxyaEqOO095pWymSPZq0
	TeQuqL4Iyq8H0J4LTIahyN82kiGeWUFzupz5UHxC+g/1II7vLFumzOoC+YM6gWvFNT/4cGPXZ8m
	p0FILcVAGqBmLal8qyfatHYe3+JX8aBGT209yylhmEMo0yBz5lCmLAOISnVmW/mbpNiE6l1sF3m
	losEM5oVLFxEKmIW+WFwxWxhVDzqMxB4YPe9lqjKYTiUgResGuVhQ2a5co30eEuSCqtIvc07m2Q
	FU0yys7JzgRwZCJgjxd7nBgRBvBn5WG5hhh/RwxlL1miuguQeRrih5KRLmkPa0noqrZtr9vPhVu
	ipJJTHBvVvsaTYbA=
X-Google-Smtp-Source: AGHT+IHUwG0+kZfO/jsBayg3VBvpEOqOPMfMLGQNgZ806B/093m3EohZ4gXNVZ5UE3uLeTeoZWs5IQ==
X-Received: by 2002:a05:6871:e3:b0:2ff:94a7:d275 with SMTP id 586e51a60fabf-2ffaf4df055mr595957fac.18.1752607249946;
        Tue, 15 Jul 2025 12:20:49 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2ff11686ad2sm2779072fac.28.2025.07.15.12.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 12:20:49 -0700 (PDT)
Date: Tue, 15 Jul 2025 14:15:07 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com, 
	ben.knoble@gmail.com, gitster@pobox.com, phillip.wood@dunelm.org.uk
Subject: Re: [GSoC RFC PATCH v4 2/4] repo: add the field references.format
Message-ID: <mgdervgp34m6ipfbodsfn7cztcl7gdeggzemfgivzvuyk7qtba@wdijebkuioxg>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714235231.10137-3-lucasseikioshiro@gmail.com>

On 25/07/14 08:52PM, Lucas Seiki Oshiro wrote:
> This commit is part of the series that introduce the new subcommand

s/introduce/introduces/

> git-repo-info.
> 
> The flag `--show-ref-format` from git-rev-parse is used for retrieving
> the reference format (i.e. `files` or `reftable`). This way, it is
> used for querying repository metadata, fitting in the purpose of
> git-repo-info.
> 
> Then, add a new field `references.format` to the repo-info subcommand
> containing that information.
> 
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  Documentation/git-repo.adoc |  4 ++
>  builtin/repo.c              | 92 +++++++++++++++++++++++++++++++++++--
>  t/meson.build               |  1 +
>  t/t1900-repo.sh             | 47 +++++++++++++++++++
>  4 files changed, 140 insertions(+), 4 deletions(-)
>  create mode 100755 t/t1900-repo.sh
> 
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 6f8fe3f6ea..b7af6f45a4 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -45,6 +45,10 @@ INFO KEYS
>  The set of data that `git repo` can return is grouped into the following
>  categories:
>  
> +`references`::
> +Reference-related data:
> +* `format`: the reference storage format, either `files` or `reftable`.
> +
>  SEE ALSO
>  --------
>  linkgit:git-rev-parse[1]
> diff --git a/builtin/repo.c b/builtin/repo.c
> index a1787a3cc5..dcda0d6d61 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -1,11 +1,95 @@
>  #include "builtin.h"
>  #include "parse-options.h"
> +#include "strbuf.h"
> +#include "refs.h"
>  
> -static int repo_info(int argc UNUSED,
> -		     const char **argv UNUSED,
> +typedef void add_field_fn(struct strbuf *buf, struct repository *repo);
> +
> +struct field {
> +	const char *key;
> +	add_field_fn *add_field_callback;
> +};
> +
> +static void add_string(struct strbuf *buf,
> +		       const char *key, const char *value)
> +{
> +	strbuf_addf(buf, "%s\n%s%c", key, value, '\0');
> +}

Any reason we add each key/value pair to a buffer instead of just
printing it?

Also, as mentioned in a comment for the previous patch, maybe we should
support printing two output modes. For the default output, maybe a
simple `<key>=<value>\n` where the any value containing special
characters is quoted via `quote_c_style()`.

A null-terminated output, such as the one proposed in this patch, could
be enabled via a `-z` flag similar to how its done in other commands.

-Justin
