Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60CD61FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 23:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbdBMXfa (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 18:35:30 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:34187 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbdBMXf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 18:35:29 -0500
Received: by mail-it0-f51.google.com with SMTP id k200so12057396itb.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 15:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IWHjxCqRHdwRv2RcbC80RVTJFGywhp3VqD89B0ohC9Q=;
        b=KbVDpH/CHjfwooY1JyLw0Fy36rxNRVQa/nBEXzGKuK5ZYKJmul9zJ/dsKUlZ17YSid
         w+IQSc1b8vP+CuPriwMAt/VPvU7eml4iQAAZZlHbDbMsW37HvcE6VRDEdSNomSfHNG4q
         ODVvpNvtAwCiKgSLaeYTiyiQMw6rkZBdzrMprMq30TwCCG2kWgFr0OZnqPkHq2V+mmJa
         6BjTcJ0/5wFF+fRaU4vTS27Wi6Qgf4p84Lfu3vCOTGP/jqtK6rPRTBdogM+lCpBUdzy7
         xovIHiZqsl5Ror5xSMRmdthC/ABB2k2WVmof0v4wfj6pkzsbOTRE4oGr/9/wF1rk8vTS
         96qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IWHjxCqRHdwRv2RcbC80RVTJFGywhp3VqD89B0ohC9Q=;
        b=lXtwj6m8PDHI+QyJeB+hwiElV0SLdzAthlo1Pv0w5DFeroTDXP1zgv1dfKO7qz7wn9
         QXHSUZUoGnuvpc1DAAg4aA5bWUpdavUGmPNuQ+v/Oes2JLkIdCCazQeL4z63jwhqyaEJ
         7sOqF4dcEyoz8+q7crv3l2Dmi58ZoOZQ6ISaOcbcYhz/1XUkKtYGJY5xHcj62hO96v60
         GJuBPM7N69ZJmxCiit4YYAmrG+4ycGCyCGtuPtc7isn9hC/DVsdsTNepZIgPjdSFeCm0
         qbsS+yobYajc6P5AqXfAH7VjMzTlf3mVBdNMbfUqcOscLCNgB3H3sMP9pW6YjZ514cOD
         dvdg==
X-Gm-Message-State: AMke39msFh+cqSulvIrRb2S2QV+KeVyR+nFF88mkpnV2aT9l1IZ1+yC7hqIKukNXGdXTbXy0kbEu+BCpvU0PQMh5
X-Received: by 10.107.3.160 with SMTP id e32mr23681441ioi.52.1487028928318;
 Mon, 13 Feb 2017 15:35:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Mon, 13 Feb 2017 15:35:27 -0800 (PST)
In-Reply-To: <20170213152011.12050-10-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com> <20170213152011.12050-10-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Feb 2017 15:35:27 -0800
Message-ID: <CAGZ79kannQDWWYN5rHr6q-6=o1_ajeEjLn8Wzsc4RjqkfYOYwg@mail.gmail.com>
Subject: Re: [PATCH 09/11] refs: move submodule code out of files-backend.c
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 7:20 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> files-backend is now initialized with a $GIT_DIR. Converting a submodule
> path to where real submodule gitdir is located is done in get_ref_store()=
.
>
> The new code in init_submodule_ref_store() is basically a copy of
> strbuf_git_path_submodule().
>
> This gives a slight performance improvement for submodules since we
> don't convert submodule path to gitdir at every backend call like
> before. We pay that once at ref-store creation.
>
> More cleanup in files_downcast() follows shortly. It's separate to keep
> noises from this patch.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  refs.c               | 48 +++++++++++++++++++++++++++++++++++++++++-----=
--
>  refs/files-backend.c | 25 +++++++------------------
>  refs/refs-internal.h |  6 +++---
>  3 files changed, 51 insertions(+), 28 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 8ef7a52ba..9ac194945 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -9,6 +9,7 @@
>  #include "refs/refs-internal.h"
>  #include "object.h"
>  #include "tag.h"
> +#include "submodule-config.h"
>
>  /*
>   * List of all available backends
> @@ -1410,7 +1411,7 @@ static void register_ref_store(struct ref_store *re=
fs, const char *submodule)
>   * Create, record, and return a ref_store instance for the specified
>   * submodule (or the main repository if submodule is NULL).
>   */
> -static struct ref_store *ref_store_init(const char *submodule)
> +static struct ref_store *ref_store_init(const char *submodule, const cha=
r *gitdir)
>  {
>         const char *be_name =3D "files";
>         struct ref_storage_be *be =3D find_ref_storage_backend(be_name);
> @@ -1419,7 +1420,7 @@ static struct ref_store *ref_store_init(const char =
*submodule)
>         if (!be)
>                 die("BUG: reference backend %s is unknown", be_name);
>
> -       refs =3D be->init(submodule);
> +       refs =3D be->init(gitdir);
>         register_ref_store(refs, submodule);
>         return refs;
>  }
> @@ -1445,15 +1446,48 @@ static struct ref_store *lookup_ref_store(const c=
har *submodule)
>         return entry ? entry->refs : NULL;
>  }
>
> -static struct ref_store *init_submodule_ref_store(const char *submodule)
> +static struct ref_store *init_submodule_ref_store(const char *path)
>  {
>         struct strbuf submodule_sb =3D STRBUF_INIT;
> +       struct strbuf git_submodule_common_dir =3D STRBUF_INIT;
> +       struct strbuf git_submodule_dir =3D STRBUF_INIT;
> +       struct strbuf buf =3D STRBUF_INIT;
> +       const char *git_dir;
> +       const struct submodule *sub;
>         struct ref_store *refs =3D NULL;
>
> -       strbuf_addstr(&submodule_sb, submodule);
> -       if (is_nonbare_repository_dir(&submodule_sb))
> -               refs =3D ref_store_init(submodule);
> +       strbuf_addstr(&submodule_sb, path);
> +       if (!is_nonbare_repository_dir(&submodule_sb))
> +               goto done;
> +
> +       strbuf_addstr(&buf, path);
> +       strbuf_complete(&buf, '/');
> +       strbuf_addstr(&buf, ".git");
> +
> +       git_dir =3D read_gitfile(buf.buf);

if buf.buf is a (git) directory as opposed to a git file,
we error out in read_gitfile. Did you mean to use
read_gitfile_gently here or rather even resolve_gitdir_gently ?

> +       if (git_dir) {

when not using the _gently version git_dir is always
non NULL here (or we're dead)?

> +               strbuf_reset(&buf);
> +               strbuf_addstr(&buf, git_dir);
> +       }
> +       if (!is_git_directory(buf.buf)) {
> +               gitmodules_config();
> +               sub =3D submodule_from_path(null_sha1, path);
> +               if (!sub)
> +                       goto done;
> +               strbuf_reset(&buf);
> +               strbuf_git_path(&buf, "%s/%s", "modules", sub->name);

You can inline "modules" into the format string?

> +       }
> +       strbuf_addch(&buf, '/');
> +       strbuf_addbuf(&git_submodule_dir, &buf);
> +
> +       refs =3D ref_store_init(path, git_submodule_dir.buf);

strbuf_detach (git_submodule_dir) here, such that we keep
the string alive despite the release of the strbuf below?

so essentially this function
* takes a submodule path
* checks if there is a repo at the given path in the working tree
* resolves the gitfile if any
* if the gitfile could not resolve to a valid repo just make up the
  location to be $GIT_DIR/modules/<name>

sounds confusing to me. I need to reread it later.

>
> -       if (submodule) {
> -               refs->submodule =3D xstrdup_or_null(submodule);
> +       if (gitdir) {
> +               strbuf_addstr(&refs->gitdir, gitdir);
> +               get_common_dir_noenv(&refs->gitcommondir, gitdir);

Oh I see. we loose the _or_null here, so my remark on the previous patch
might be just unneeded work.

>         } else {
>                 strbuf_addstr(&refs->gitdir, get_git_dir());
>                 strbuf_addstr(&refs->gitcommondir, get_git_common_dir());
> @@ -1034,8 +1025,6 @@ static struct ref_store *files_ref_store_create(con=
st char *submodule)
>  static void files_assert_main_repository(struct files_ref_store *refs,
>                                          const char *caller)
>  {
> -       if (refs->submodule)
> -               die("BUG: %s called for a submodule", caller);
>  }

In a followup we'd get rid of files_assert_main_repository
presumably?

Thanks,
Stefan
