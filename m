Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5127D3F4
	for <git@vger.kernel.org>; Mon, 13 May 2024 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629700; cv=none; b=SFjFy59/7Kb3XmX9g+lnYyz1GEpYCwABefdcqBCpSmZLe5JAD2f37+IQHDBUuSNDW0V1JB8htBLQ8v4c6hxSGhRKoJ1Qi0R3B76cJhLk1XhOopSXiWpO5NgG4/lyLfyhQpTDUhOQAcRu1iGxq8myg47uj3lCxI8XER7CIHGztTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629700; c=relaxed/simple;
	bh=IUQlzc22kQXYYzdG6Ht0BJUR3Ea0YVja6Lf+xJhmRxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJAg+Zuyu8Z6n21P6rpwFBiWiGEJyXaDj9hE1VirMHPQkQNfcr0fJZn2cZ/+RHwUF0aGVXsjlbGAK4J2IAKruNFjsrPsdmKK1+wHUuXtceESYcPanGP0E2ExHhHic60ysPMVsfWwHXYcoW7JCmtXv+wEbDdpjsQvDe2LswNiU0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c+pLWXnN; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c+pLWXnN"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5a1054cf61so1279867366b.1
        for <git@vger.kernel.org>; Mon, 13 May 2024 12:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715629697; x=1716234497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+msAoHSUJ1/zg0KV2I3Bd5c0Arr78aKERu6jNWG72Rs=;
        b=c+pLWXnNN0JAaI+wsSwSct9rgX0vRwjin5uXxeWXhf2relvoGzEgRfImZ1CAgY9KAW
         pUbWZSttnbZNT7lpRfsen4fdbIpan7zYf5FQQ/7aAVmjRCU2jW1aEk8lS4LPHXu8YQk2
         uNyMGnS68cLgcP46wDwEpNhZrR9WhqET6v2Y4S1XjPh4D4GGbdZHcbKKaYRtMZjEwoAm
         0HxRZ1R5boJNLu4025KWkp0iQQcR+J4juq74vhhsYeHXIzqckvuZgZQVWjCLDwdbUQ0x
         ZPYDpBu+Ty6rIFnv7533BIYtfG2oXr7ZtsW0DLDXX53WkTWuvWnVjmQCFyRia1Aa4ONb
         SruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629697; x=1716234497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+msAoHSUJ1/zg0KV2I3Bd5c0Arr78aKERu6jNWG72Rs=;
        b=rS/9wcl1UH9/dYRpo6PtxrRiCw6qm0FhD/DGGUcrPHIJv1G60/IWzGqV3cwKYaVEeI
         j80rghM/NitoBl73w/7JmfdLTVWyxtMXohQsauHe5vAUWCbf3YeDUfqn1L3P42hyJS/J
         EClLHFVMMe5i9ea32HDI9eRJAgkDsFMd78+YXR9dti0kg5hknH6wFGnJTZFZHTapa9LC
         pAR/9CpXaiipr2gHhgdUxlqinOBK3pgg6HViMJH1Ho1ICHTK2F+WbpBDdE/I3E/c3Eu8
         1hJLQ0lrZsrxwDCrgMf28bAhOuQyw7DjhQ0d5i4jNcVcxNKcGTO9MNlcF/ZhdsqzwTCm
         DcAA==
X-Gm-Message-State: AOJu0YyZyol/DgDy42Pzr5UcAkRhdBgFb8Pk5ZKnZNweKHZraDHq9A4G
	5J9Gfh+dBsRwVddzit8XTvHueG4OV42hLuMDJnqwgvtO00tI96PLivtUE6QXiG3bV/wlIABszgH
	tCQmoHenzAPocPFfrsPffcHz0gBpnSpg8CY2YeMVxgWbwaGGHgg==
X-Google-Smtp-Source: AGHT+IF+jppmjGRm1vFARvdJ2a3rgyjTFD+zo8BC44FDNn0NcrQ8qCK5FGJcIeHJcrkBMRP2KQ8fA1GLdOXLGS3OJ2c=
X-Received: by 2002:a17:907:747:b0:a59:a3ef:21f5 with SMTP id
 a640c23a62f3a-a5a2d65ed16mr1379746366b.57.1715629696778; Mon, 13 May 2024
 12:48:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715582857.git.ps@pks.im> <20240513192112.866021-1-gitster@pobox.com>
 <20240513192112.866021-2-gitster@pobox.com>
In-Reply-To: <20240513192112.866021-2-gitster@pobox.com>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 13 May 2024 12:48:05 -0700
Message-ID: <CAO_smVhxCGUD2D5m9eDj+CBmteauBuGG=6RgjADnuXgBeB5O8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] setup: add an escape hatch for "no more default
 hash algorithm" change
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 12:21=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Partially revert c8aed5e8 (repository: stop setting SHA1 as the
> default object hash, 2024-05-07), to keep end-user systems still
> broken when we have gap in our test coverage but yet give them an
> escape hatch to set the GIT_TEST_DEFAULT_HASH_IS_SHA1=3D1 environment
> variable to revert to the previous behaviour.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  repository.c  | 24 ++++++++++++++++++++++++

Nice idea, this concept LG.

>  t/test-lib.sh |  4 ++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/repository.c b/repository.c
> index 15c10015b0..6f67966e35 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -26,6 +26,30 @@ void initialize_repository(struct repository *repo)
>         repo->parsed_objects =3D parsed_object_pool_new();
>         ALLOC_ARRAY(repo->index, 1);
>         index_state_init(repo->index, repo);
> +
> +       /*
> +        * Unfortunately, we need to keep this hack around for the time b=
eing:

Nit: the comment says we need to keep it around, but it's actually
defaulted to off. We may want to add clarification of the current
status to the comment (or replace the entire comment with a comment
describing that we added a hack to the hack, and that it should be
removed "soon").

> +        *
> +        *   - Not setting up the hash algorithm for `the_repository` lea=
ds to
> +        *     crashes because `the_hash_algo` is a macro that expands to
> +        *     `the_repository->hash_algo`. So if Git commands try to acc=
ess
> +        *     `the_hash_algo` without a Git directory we crash.
> +        *
> +        *   - Setting up the hash algorithm to be SHA1 by default breaks=
 other
> +        *     commands when running with SHA256.
> +        *
> +        * This is another point in case why having global state is a bad=
 idea.
> +        * Eventually, we should remove this hack and stop setting the ha=
sh
> +        * algorithm in this function altogether. Instead, it should only=
 ever
> +        * be set via our repository setup procedures. But that requires =
more
> +        * work.
> +        *
> +        * As we discover the code paths that need fixing, we may remove =
this
> +        * code completely, but we are not there yet.
> +        */
> +       if (repo =3D=3D the_repository &&
> +           git_env_bool("GIT_TEST_DEFAULT_HASH_IS_SHA1", 0))
> +               repo_set_hash_algo(repo, GIT_HASH_SHA1);
>  }
>
>  static void expand_base_dir(char **out, const char *in,
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 79d3e0e7d9..36d311fb4a 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -542,6 +542,10 @@ export EDITOR
>
>  GIT_DEFAULT_HASH=3D"${GIT_TEST_DEFAULT_HASH:-sha1}"
>  export GIT_DEFAULT_HASH
> +
> +GIT_TEST_DEFAULT_HASH_IS_SHA1=3D0

This is the default as being established in this commit, correct?
Should we add a comment saying this is the default and describe why we
have it here anyway?

> +export GIT_TEST_DEFAULT_HASH_IS_SHA1
> +
>  GIT_DEFAULT_REF_FORMAT=3D"${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
>  export GIT_DEFAULT_REF_FORMAT
>  GIT_TEST_MERGE_ALGORITHM=3D"${GIT_TEST_MERGE_ALGORITHM:-ort}"
> --
> 2.45.0-145-g3e4a232f6e
>
>
