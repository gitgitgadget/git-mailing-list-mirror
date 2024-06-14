Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F0849638
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391057; cv=none; b=oh1xA2MzoD/nykGeAmrVV13igdzzU28pqbvVuGc5RxMe1GCMNZGjzcZUieEuV+fX5vzYv9StIx8Ny1GUnp4qVZ3aNn5fhrjRVQzEkajGKt7/OGq+gUH25pky90ChAaWj868NezSKXIOAqgunF9QSz+pWJI4eynN/WTTYgE7bkFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391057; c=relaxed/simple;
	bh=XrhZi3A8Gr0qeG+JWtwB3DXAF3neQdzAAM//pQY1k5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyUiiWkUZDB6aWdqfymxrK29LafTecKyG3kg0h79zEhmGqqv8Pdjxp3MOYqX9i064pkjjUUzCk6XwqdubS0L3lniDLvH1SzUZ6MXDqj272LG4UrrM3TiERtWYwx5lD3w2C+mUeQuGJ4Q46ef4eo4d7Z8xrUgNlIEJzKOgURS/uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYBZ44Va; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYBZ44Va"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7eb01106015so110220939f.1
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 11:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391055; x=1718995855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iN4H+VssjtdYQNFkETNVaz2/MwbujMTilkHbaMgX1pM=;
        b=cYBZ44VaPuR9Qnyg6eRqvgq7o825nbAJzWnXpIx8KrRJ1bps8wQptPCD2C4NxNqvX2
         MA7/NhExYa5EBlexcZDYGK0Py6iACAslMzgA/vaGMiqtcsIFUcanpdB87Th/kaQ6aOGw
         ixCLozvxSUrVFM0jH5//RU3FeDjVt1pF6ktVAamoT7uHaHMTI1kgtdaOGncyuXQ5GppM
         jn0TvQYXzayX6NPiiCiiNUeb+tTbXFEvCLf2Vps3STcln46Y9q2cwCTQ1g6LcBN63/zU
         WFsaQBBVSj5x5vYieVGJOEEIRO44GQD0PexNeJ8Ule+He1tUQ9B7y/An8tJX401L70vR
         u5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391055; x=1718995855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iN4H+VssjtdYQNFkETNVaz2/MwbujMTilkHbaMgX1pM=;
        b=t8uJ6lVyOeIY+kL9yCRh2+/DcRp2bldY406Xhji0u9u2fzb6KeHPJ1RU4e3lD3J+N7
         nCC7keWRzRDAc0vXe5L8uLx3dQN4kkptB/iU3EqrfgVFljlCHKmBqF2uZW4cRYYKp7ZS
         Cj/7AJkK9nFiiFodyh/dxw6xFgfqs6csy7si4spA52KYM1jBejQ0yqtjBBASCIuBDmG6
         0hUHUpJFPCl4iMWCYtaADH/YvRTLamAJ/G8vglUUOgVI66/SdWBsQkkwJee4v0pqe2u8
         RhtfMmBpel0TuPOePQsn61OTi6/Cm3a8j/dY1BoyZKNaR6P0tHSPK/ZkF/2NS4P7Q84t
         vSIQ==
X-Gm-Message-State: AOJu0Yxni9mPfR4dvy9DolUs2V0OJtzY53CmLKpAD3LTST6BGWfGmEzw
	EdZBVoV1XpRL4KzB+bGMdyNG55wZtv3CgGRXXZWXS2nBQ/iviqyi1PWZJ19vvL1jHx4qvBUL5n4
	l0tJDFfMjlFuBF/Ev1bvocoRI9+0=
X-Google-Smtp-Source: AGHT+IFhoexaSaslY1zqXZ+bBpRTCgT1Vts8inOn0Z4JueKxL98Q7cV480Rm+1tDi95UsoDG64D891Q1MqUIiiJR564=
X-Received: by 2002:a05:6602:6b85:b0:7eb:ae17:c234 with SMTP id
 ca18e2360f4ac-7ebeb4d4f64mr360852439f.11.1718391055020; Fri, 14 Jun 2024
 11:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608183901.2084546-1-gitster@pobox.com>
In-Reply-To: <20240608183901.2084546-1-gitster@pobox.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 14 Jun 2024 18:50:43 +0000
Message-ID: <CABPp-BEnhJt_5mJ2rY3FFU-4_v41zt2NHOkf_Xp8DYxUsGgYPQ@mail.gmail.com>
Subject: Re: [PATCH] worktree_git_path(): move the declaration to path.h
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 6:39=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> The definition of this function is in path.c but its declaration is
> in worktree.h, which is something unexpected.  The function is
> explained as "Similar to git_path()"; declaring it next to where
> git_path() is declared would make more sense.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  path.h     | 9 +++++++++
>  revision.c | 1 +
>  worktree.h | 8 --------
>  3 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/path.h b/path.h
> index c3bc8617bd..a6f0b70692 100644
> --- a/path.h
> +++ b/path.h
> @@ -4,6 +4,7 @@
>  struct repository;
>  struct strbuf;
>  struct string_list;
> +struct worktree;
>
>  /*
>   * The result to all functions which return statically allocated memory =
may be
> @@ -81,6 +82,14 @@ void strbuf_repo_git_path(struct strbuf *sb,
>  const char *git_path(const char *fmt, ...)
>         __attribute__((format (printf, 1, 2)));
>
> +/*
> + * Similar to git_path() but can produce paths for a specified
> + * worktree instead of current one
> + */
> +const char *worktree_git_path(const struct worktree *wt,
> +                             const char *fmt, ...)
> +       __attribute__((format (printf, 2, 3)));
> +
>  /*
>   * Return a path into the main repository's (the_repository) git directo=
ry.
>   */
> diff --git a/revision.c b/revision.c
> index 7ddf0f151a..09024cf4aa 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -29,6 +29,7 @@
>  #include "bisect.h"
>  #include "packfile.h"
>  #include "worktree.h"
> +#include "path.h"
>  #include "read-cache.h"
>  #include "setup.h"
>  #include "sparse-index.h"
> diff --git a/worktree.h b/worktree.h
> index 7cc6d90e66..11279d0c8f 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -177,14 +177,6 @@ int other_head_refs(each_ref_fn fn, void *cb_data);
>  int is_worktree_being_rebased(const struct worktree *wt, const char *tar=
get);
>  int is_worktree_being_bisected(const struct worktree *wt, const char *ta=
rget);
>
> -/*
> - * Similar to git_path() but can produce paths for a specified
> - * worktree instead of current one
> - */
> -const char *worktree_git_path(const struct worktree *wt,
> -                             const char *fmt, ...)
> -       __attribute__((format (printf, 2, 3)));
> -
>  /*
>   * Return a refname suitable for access from the current ref store.
>   */
> --
> 2.45.2-445-g1b76f06508

Simple and straightforward, and the rationale makes sense to me.
