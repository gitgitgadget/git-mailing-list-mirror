Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048701B2EF7
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875522; cv=none; b=JtBzYXE+W5N6WrTJqmzNUilCvRMQRXdJZxvhXzGvZ72zmDjm66g9c0mjHVKV5n462OG5uihmp5Ez5DFQRhdqWxijOrZsGn4SHTa5zfkV5SpCp6kGre1SSvxQVStJ51QiZQYholjm8wh2DUqFck1GKdTQzS9fIdEWaqOgvuAlGhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875522; c=relaxed/simple;
	bh=wY/KsDiymHS24mNF5rSyg8u4YvMxmvWSvNizSzVHRHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMU4FCKnCoZ/fDukmbjbdKCI7eNf2zoHwMtnOmbHacWvWzmSkKMTNAcDkhXbQRS7VVOOg/X8IYkoqmgGRYtUHvr1MF5/oSMU9xltOpEj0nBltwC1SK+kwnWkpIW8m7lOfezuv+1BQNCxmi65d7Y6CmZjh5mvXC7HpW6ctRHfvx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QU9fOs6n; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QU9fOs6n"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d82b0ebd51so334765a12.2
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 02:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725875520; x=1726480320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efTp6zm0JAW2L8ZLNiolCUefx/xXcOwrc6hFasHiCrs=;
        b=QU9fOs6nndK5Sd9XbuSpQ1fJihYMCKibvRI3CgtxuO3BVgwsHbqZxpU+UUGUp2rVaD
         SVwAPgPPRju2mt6HbQfF9ccS2AFQs/PVPvvunGTf3Sj3zHxj599IBRybvkXhCiTW4ZN0
         mfYHKYyCzy1LN99ZJf6vT2YBNmJ4rVvwwTTUF3Iye26clCPOIc3zPI8j/nJ37dX2pOdt
         loYAPEY09k93SxRCwNg6VXeg30KEqq1MzzW3RZmecoixm+IvbNMumRCLx8C7As+cXhCq
         vToEK0/PkvY384ijL9Zxj6oKq48CbHoyl/+kJNwctJBi2cbPbh4ppwdoNKIYs5BYzYfq
         WilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725875520; x=1726480320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efTp6zm0JAW2L8ZLNiolCUefx/xXcOwrc6hFasHiCrs=;
        b=aoJzta3ezPdtFXT0VYpAdZwKpKfbX1sWUTpRS3tmVKRZcPiPfgSp6pC3CMyCBkHbIN
         lYcoCCD8TDS4TdJ0BXmrcgWvw016zPQyWPW5L/2huyk5Ccr1lVNfeWgJ8HljDYOvHz3l
         li/3aKfN15OfcApLq/oxgqYxAYmTEE1KmBYsELPxx2/jbjsyCtOYCypIu2oGO5ZIMCwT
         vRD68DKOwUeTYohvXnJlVm23w+L65VvcbCzgPhWkZKfTRBdNNsC6iq9hTj+xkRNYSBAU
         OJOlOyx/d9O+uObQSDi+kui5QG8j0C59gZ2jTAs5/qm5Y8Zyh9yfciYkDdNVgOT5s0QO
         3TWg==
X-Gm-Message-State: AOJu0YyqQOXfDwCxeRNr5M9Fkr5uoeybbTp4JyYOOBdRJORoJ85fUTdq
	KWWfjHWIbOWZtGqpVDqRyGxLIjmrhiIxMaMHOIUhWMYP4nYyF4R7gDig7vJihwo2XMFQ529gbc/
	rKAugs+vbjEUB/0oPJr0CTWtfbjc=
X-Google-Smtp-Source: AGHT+IEmHBdti4jeB7zEfd5X17YZsORoVNoMIzPtArotsiWb4jk6aEtb5F6x5IEOemuzIkb7I12c9W56IHocjDc5Ezo=
X-Received: by 2002:a17:90a:fa8e:b0:2d8:ad96:6ef4 with SMTP id
 98e67ed59e1d1-2dad50fcd71mr8693407a91.28.1725875519982; Mon, 09 Sep 2024
 02:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1782.git.1725875232922.gitgitgadget@gmail.com>
In-Reply-To: <pull.1782.git.1725875232922.gitgitgadget@gmail.com>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Mon, 9 Sep 2024 15:21:23 +0530
Message-ID: <CAG=Um+3u8F-bt4MJwQCZhVs6sQbr5T+GvPG4thGriOkMoKhNoQ@mail.gmail.com>
Subject: Re: [PATCH] remote: introduce config to set prefetch refs
To: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt [ ]" <ps@pks.im>, 
	"Junio C Hamano [ ]" <gitster@pobox.com>, "Derrick Stolee [ ]" <stolee@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 3:17=E2=80=AFPM Shubham Kanodia via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Shubham Kanodia <shubham.kanodia10@gmail.com>
>
> This commit introduces a new configuration option,
> remote.<name>.prefetchref, which allows users to specify specific
> ref patterns to be prefetched during a git fetch --prefetch
> operation.
>
> The new option accepts a space-separated list of ref patterns.
> When the --prefetch option is used with git fetch, only the refs
> matching these patterns will be prefetched, instead of the
> default behavior of prefetching all fetchable refs.
>
> Example usage in .git/config:
> [remote "origin"]
>     prefetchref =3D "refs/heads/main refs/heads/feature/*"
>
> This change allows users to optimize their prefetch operations, potential=
ly
> reducing network traffic and improving performance for large repositories
> with many refs.
>
> Signed-off-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
> ---
>     remote: introduce config to set prefetch refs
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1782%2F=
pastelsky%2Fsk%2Fremote-prefetchref-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1782/paste=
lsky/sk/remote-prefetchref-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1782
>
>  Documentation/config/remote.txt |  6 +++
>  builtin/fetch.c                 | 29 +++++++++++++-
>  remote.c                        |  8 ++++
>  remote.h                        |  3 ++
>  t/t7900-maintenance.sh          | 70 +++++++++++++++++++++++++++++++++
>  5 files changed, 115 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/remote.txt b/Documentation/config/remot=
e.txt
> index 8efc53e836d..b25d76dd3b1 100644
> --- a/Documentation/config/remote.txt
> +++ b/Documentation/config/remote.txt
> @@ -33,6 +33,12 @@ remote.<name>.fetch::
>         The default set of "refspec" for linkgit:git-fetch[1]. See
>         linkgit:git-fetch[1].
>
> +remote.<name>.prefetchref::
> +    Specify the refs to be prefetched when fetching from this remote.
> +    The value is a space-separated list of ref patterns (e.g., "refs/hea=
ds/master refs/heads/develop*").
> +    These patterns are used as the source part of the refspecs for prefe=
tching.
> +    This can be used to optimize fetch operations by specifying exactly =
which refs should be prefetched.
> +
>  remote.<name>.push::
>         The default set of "refspec" for linkgit:git-push[1]. See
>         linkgit:git-push[1].
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b2b5aee5bf2..6e584fa2ebb 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -434,6 +434,30 @@ static void find_non_local_tags(const struct ref *re=
fs,
>         oidset_clear(&fetch_oids);
>  }
>
> +static void apply_prefetch_refspec(struct remote *remote, struct refspec=
 *rs)
> +{
> +       if (remote->prefetch_refs.nr > 0) {
> +               int i;
> +               for (i =3D 0; i < remote->prefetch_refs.nr; i++) {
> +                       const char *src =3D remote->prefetch_refs.items[i=
].string;
> +                       struct strbuf dst =3D STRBUF_INIT;
> +
> +                       strbuf_addf(&dst, "refs/prefetch/%s/", remote->na=
me);
> +                       if (starts_with(src, "refs/heads/")) {
> +                               strbuf_addstr(&dst, src + 11);
> +                       } else if (starts_with(src, "refs/")) {
> +                               strbuf_addstr(&dst, src + 5);
> +                       } else {
> +                               strbuf_addstr(&dst, src);
> +                       }
> +
> +                       refspec_appendf(rs, "%s:%s", src, dst.buf);
> +                       strbuf_release(&dst);
> +               }
> +       }
> +}
> +
> +
>  static void filter_prefetch_refspec(struct refspec *rs)
>  {
>         int i;
> @@ -502,8 +526,11 @@ static struct ref *get_ref_map(struct remote *remote=
,
>         int existing_refs_populated =3D 0;
>
>         filter_prefetch_refspec(rs);
> -       if (remote)
> +       if (remote) {
>                 filter_prefetch_refspec(&remote->fetch);
> +               if (prefetch)
> +                       apply_prefetch_refspec(remote, rs);
> +       }
>
>         if (rs->nr) {
>                 struct refspec *fetch_refspec;
> diff --git a/remote.c b/remote.c
> index 8f3dee13186..b46d62b2c47 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -141,6 +141,7 @@ static struct remote *make_remote(struct remote_state=
 *remote_state,
>         ret->prune =3D -1;  /* unspecified */
>         ret->prune_tags =3D -1;  /* unspecified */
>         ret->name =3D xstrndup(name, len);
> +       string_list_init_dup(&ret->prefetch_refs);
>         refspec_init(&ret->push, REFSPEC_PUSH);
>         refspec_init(&ret->fetch, REFSPEC_FETCH);
>
> @@ -166,6 +167,7 @@ static void remote_clear(struct remote *remote)
>         free((char *)remote->uploadpack);
>         FREE_AND_NULL(remote->http_proxy);
>         FREE_AND_NULL(remote->http_proxy_authmethod);
> +       string_list_clear(&remote->prefetch_refs, 0);
>  }
>
>  static void add_merge(struct branch *branch, const char *name)
> @@ -456,6 +458,12 @@ static int handle_config(const char *key, const char=
 *value,
>                 remote->prune =3D git_config_bool(key, value);
>         else if (!strcmp(subkey, "prunetags"))
>                 remote->prune_tags =3D git_config_bool(key, value);
> +       else if (!strcmp(subkey, "prefetchref")) {
> +               if (!value)
> +                       return config_error_nonbool(key);
> +               string_list_split(&remote->prefetch_refs, value, ' ', -1)=
;
> +               return 0;
> +       }
>         else if (!strcmp(subkey, "url")) {
>                 if (!value)
>                         return config_error_nonbool(key);
> diff --git a/remote.h b/remote.h
> index b901b56746d..c18e68e0d8d 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -5,6 +5,7 @@
>  #include "hashmap.h"
>  #include "refspec.h"
>  #include "strvec.h"
> +#include "string-list.h"
>
>  struct option;
>  struct transport_ls_refs_options;
> @@ -77,6 +78,8 @@ struct remote {
>
>         struct refspec fetch;
>
> +       struct string_list prefetch_refs;
> +
>         /*
>          * The setting for whether to fetch tags (as a separate rule from=
 the
>          * configured refspecs);
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index abae7a97546..2ad5b922d83 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -245,6 +245,76 @@ test_expect_success 'prefetch multiple remotes' '
>         test_subcommand git fetch remote2 $fetchargs <skip-remote1.txt
>  '
>
> +test_expect_success 'prefetch only acts on remote.<name>.prefetchref ref=
s if present' '
> +       test_create_repo prefetch-test-mixed-patterns &&
> +       (
> +               cd prefetch-test-mixed-patterns &&
> +               test_commit initial &&
> +               git clone . clone1 &&
> +               git clone . clone2 &&
> +
> +               git remote add remote1 "file://$(pwd)/clone1" &&
> +               git remote add remote2 "file://$(pwd)/clone2" &&
> +
> +               # Set single prefetchref pattern for remote1 and multiple=
 for remote2
> +               git config remote.remote1.prefetchref "refs/heads/foo" &&
> +               git config remote.remote2.prefetchref "refs/heads/feature=
/* refs/heads/topic" &&
> +
> +               # Create branches in clone1 and push
> +               (
> +                       cd clone1 &&
> +                       git checkout -b foo &&
> +                       test_commit foo-commit &&
> +                       git checkout -b feature/a &&
> +                       test_commit feature-a-commit &&
> +                       git checkout -b other &&
> +                       test_commit other-commit &&
> +                       git push origin foo feature/a other
> +               ) &&
> +
> +               # Create branches in clone2 and push
> +               (
> +                       cd clone2 &&
> +                       git checkout -b topic &&
> +                       test_commit master-commit &&
> +                       git checkout -b feature/x &&
> +                       test_commit feature-x-commit &&
> +                       git checkout -b feature/y &&
> +                       test_commit feature-y-commit &&
> +                       git checkout -b dev &&
> +                       test_commit dev-commit &&
> +                       git push origin topic feature/x feature/y dev
> +               ) &&
> +
> +               # Run maintenance prefetch task
> +               GIT_TRACE2_EVENT=3D"$(pwd)/prefetch.txt" git maintenance =
run --task=3Dprefetch 2>/dev/null &&
> +
> +               # Check that only specified refs were prefetched
> +               fetchargs=3D"--prefetch --prune --no-tags --no-write-fetc=
h-head --recurse-submodules=3Dno --quiet" &&
> +               test_subcommand git fetch remote1 $fetchargs <prefetch.tx=
t &&
> +               test_subcommand git fetch remote2 $fetchargs <prefetch.tx=
t &&
> +               ls -R .git/refs/prefetch &&
> +
> +               # Verify that only specified refs are in the prefetch ref=
s for remote1
> +                git rev-parse refs/prefetch/remotes/remote1/foo &&
> +               test_must_fail git rev-parse refs/prefetch/remotes/remote=
1/feature/a &&
> +               test_must_fail git rev-parse refs/prefetch/remotes/remote=
1/other &&
> +
> +                               # Verify that only specified refs are in =
the prefetch refs for remote2
> +               git rev-parse refs/prefetch/remotes/remote2/feature/x &&
> +               git rev-parse refs/prefetch/remotes/remote2/feature/y &&
> +               git rev-parse refs/prefetch/remotes/remote2/topic &&
> +               test_must_fail git rev-parse refs/prefetch/remotes/remote=
2/dev &&
> +
> +               # Fetch all refs and compare
> +               git fetch --all &&
> +               test_cmp_rev refs/remotes/remote1/foo refs/prefetch/remot=
es/remote1/foo &&
> +               test_cmp_rev refs/remotes/remote2/feature/x refs/prefetch=
/remotes/remote2/feature/x &&
> +               test_cmp_rev refs/remotes/remote2/feature/y refs/prefetch=
/remotes/remote2/feature/y &&
> +               test_cmp_rev refs/remotes/remote2/topic refs/prefetch/rem=
otes/remote2/topic
> +       )
> +'
> +
>  test_expect_success 'loose-objects task' '
>         # Repack everything so we know the state of the object dir
>         git repack -adk &&
>
> base-commit: 2e7b89e038c0c888acf61f1b4ee5a43d4dd5e94c
> --
> gitgitgadget

This is a continuation of my work, as we deemed that adding a
`remote.<remote-name>.prefetch` was unnecessary given that
there were already ways to stop fetching refs from a given remote
using `skipFetchAll`.

Looking at getting early feedback on the direction & implementation
here since this isn't as straightforward as my last contribution.
I would appreciate any thoughts! The config's name is tentatively
`prefetchref,` but I'm open to suggestions.
