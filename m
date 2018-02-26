Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 243D71F404
	for <e@80x24.org>; Mon, 26 Feb 2018 18:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeBZS5Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 13:57:25 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38890 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbeBZS5W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 13:57:22 -0500
Received: by mail-qk0-f193.google.com with SMTP id s198so20339055qke.5
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 10:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=dbCHDZpSruuVcHzkiYPFVkX5Tr9+tyvcDoIoUMDWSTU=;
        b=f10gSmBpZVz/h0L0Lbf5rlzo/o+Qq3QyFGiBX2e357xGxFJnlN53+8HVIP5tFmtMHt
         1p9GYgnqClSiZqRiU+EpF08Ipq+KRRPePrn02Ri/s/j/9hAthHlWQ18xjIGgPH9s039J
         sp4bzcOvSZyscr7+1bf4gV1h7x90yy3W9JOIMlPN2/F0pYKeKj3JvHlHAw+NQvvqmnvQ
         bW5ne4pq8BH7OSZSYtNGsPd1+OszrZfEk1ofi0FQ5nB2QXiGsNAMV0JKyWDVQKaHBwDN
         8LJHVGfW8joEUqJ1+UM2F0g7o3aczKYUGr01+Nw7wYBtVh9LnL8RVLjUUBMxp6L+HUPO
         5P3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=dbCHDZpSruuVcHzkiYPFVkX5Tr9+tyvcDoIoUMDWSTU=;
        b=o7wjMR59dCiUPxT88n9XUoWkaTP1FdqfCShf7JFK8VEZ5HsjkrSXPz02TYeiRhUL7o
         OMXzm5Or+fH0YkiatvSYOVnc7s6TuBvublbBNof3mlBoLA0tnfIkmMqzlhNA5lwP/xcW
         ne33cnmtMAEvNfR5uBpiFguaU+aLM3CjVJW13daKF6BlD1wKX7BMOFLKjbJhx7rohVJw
         +tdlxgV2ePbCoiFlvKtwytMM/vQeotRWaG6OIAtrGbYDNUUJRUdp79xm4aOe2wsKScW8
         Qr8uy6nbzCNkueLgzpv6xALVaxRvDTrr4vvF+iFRdHBrOmj9PtIIwHjc9nd2mnpoQm0H
         uSxA==
X-Gm-Message-State: APf1xPC81RHBk6DYf8Jd9ImBppHIsMqT3ox0z+Ggeq9YGDbTZ9+wYP4b
        v/+6/1OjeoH4VudCOfP3Su3/w0qlXrFkzvwU0zk=
X-Google-Smtp-Source: AG47ELt7sXKyShE585K9b1zgHNi7Da3g34WVetwJ7Nr49RovrZtKNMTNGJAmkj19J6hYWM/T6dXhgH91Oju1/VTo9lE=
X-Received: by 10.55.134.133 with SMTP id i127mr18653937qkd.275.1519671441852;
 Mon, 26 Feb 2018 10:57:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Mon, 26 Feb 2018 10:57:21 -0800 (PST)
In-Reply-To: <20180226103030.26900-2-pclouds@gmail.com>
References: <20180214180814.GA139458@google.com> <20180226103030.26900-1-pclouds@gmail.com>
 <20180226103030.26900-2-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 26 Feb 2018 13:57:21 -0500
X-Google-Sender-Auth: 12XfmZJS8ZUKCiLsMiwnlpyVf_E
Message-ID: <CAPig+cRkEzN-dHh9R0cX5gOhsJ7X5evAMfpWuCnVp_QN3uz8ng@mail.gmail.com>
Subject: Re: [PATCH 1/4] repository.c: move env-related setup code back to environment.c
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 5:30 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> It does not make sense that generic repository code contains handling
> of environment variables, which are specific for the main repository
> only. Refactor repo_set_gitdir() function to take $GIT_DIR and
> optionally _all_ other customizable paths. These optional paths can be
> NULL and will be calculated according to the default directory layout.
>
> Note that some dead functions are left behind to reduce diff
> noise. They will be deleted in the next patch.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/environment.c b/environment.c
> @@ -148,10 +148,17 @@ static char *expand_namespace(const char *raw_names=
pace)
> -void setup_git_env(void)
> +void setup_git_env(const char *git_dir)
>  {
>         const char *shallow_file;
>         const char *replace_ref_base;
> +       struct set_gitdir_args args =3D { NULL };
> +
> +       args.shared_root =3D getenv(GIT_COMMON_DIR_ENVIRONMENT);
> +       args.object_dir =3D getenv(DB_ENVIRONMENT);
> +       args.graft_file =3D getenv(GRAFT_ENVIRONMENT);
> +       args.index_file =3D getenv(INDEX_ENVIRONMENT);

According to POSIX[1], the result of getenv() may be invalidated by
another call to getenv() (or setenv() or unsetenv() or putenv()).

[1]: http://pubs.opengroup.org/onlinepubs/9699919799/functions/getenv.html

> +       repo_set_gitdir(the_repository, git_dir, &args);
> diff --git a/repository.c b/repository.c
> @@ -61,15 +61,50 @@ static void repo_setup_env(struct repository *repo)
> +void repo_set_gitdir(struct repository *repo,
> +                    const char *root,
> +                    const struct set_gitdir_args *o)
> +{
> +       const char *gitfile =3D read_gitfile(root);
> +       char *old_gitdir =3D repo->gitdir;
> +
> +       repo->gitdir =3D xstrdup(gitfile ? gitfile : root);
>         free(old_gitdir);

Can:

    char *old_gitdir =3D repo->gitdir;
    repo->gitdir =3D xstrdup(...);
    free(old_gitdir);

be simplified to:

    free(repo->gitdir);
    repo->gitdir =3D xstrdup(...);

?

> +       repo_set_commondir(repo, o->shared_root);

The repo_set_gitdir() prototype (below) makes it seem as if the last
argument ('o', in this case) is optional, presumably by passing in
NULL, however, this code does not appear to be prepared to deal with
NULL.

> +       expand_base_dir(&repo->objects.objectdir, o->object_dir,
> +                       repo->commondir, "objects");
> +       expand_base_dir(&repo->graft_file, o->graft_file,
> +                       repo->commondir, "info/grafts");
> +       expand_base_dir(&repo->index_file, o->index_file,
> +                       repo->gitdir, "index");
>  }
> diff --git a/repository.h b/repository.h
> @@ -89,7 +89,16 @@ struct repository {
> +struct set_gitdir_args {
> +       [...]
> +};
> +
> +extern void repo_set_gitdir(struct repository *repo,
> +                           const char *root,
> +                           const struct set_gitdir_args *optional);
