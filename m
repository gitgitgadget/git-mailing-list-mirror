Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A689DC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 01:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6342073D
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 01:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0dRuvf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfLKBVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 20:21:21 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34825 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfLKBVV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 20:21:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id j6so22067774lja.2
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 17:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5yWgVnHsluKXh8VDxrkX6Mql5s/+aZ0ZHAH9x6SmosY=;
        b=j0dRuvf+RVNTDaJLYnvvynZmZmNilmarGhzC08XAShvrUNRx5Nji4JHmwURdNsTOwC
         lOvAvxcAv2CUBrTOqABOhPvY0sp/Xx6lHncobaifRuCsq1toyfiQ/uBA5vCvYayXJjzM
         c7eqZL3FQ/NAcTmPzFrfzb4ccnXAbgB7WMIPk2CUDoB4VWUAMmqc43FRYlMbp1E/GQzW
         PSUTSEqfrMEL40eNKJyAmma1mphEbDHb6aJTAYfG6mKQKWZfb9ChCPybMO0t3jZ/FlmL
         XSxDVvNn/h7uP+kV2+JGpzA29pauEtOGpx2OuSh4KmvMrCzmHfmpS/9doetYhp3E8AAa
         P0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5yWgVnHsluKXh8VDxrkX6Mql5s/+aZ0ZHAH9x6SmosY=;
        b=HNej3p7vobn2dwifqk6lnbSMFPrUriOKDuGvBCTcaRwqXyUjuo4rmGVD4l97dFsYSL
         iErsCtdz0gpi0e3vDW6GocAFk0M3KyMG1wn725zZtUN5mIgKbPEcaFOwZ0z9gr0Yw5Ac
         Rm7DQVrHMd7uSMUM0sdNYP867zStIT+l5G0iSrQXkh+pyAgLOlFETzT1s5+v5CB+ppFo
         6AQFCZ7YzcmwiomU5ncavQb5iwAh+3dJ3veYWbzgqpFb1A+YDyY7F6pSgGNGZ9zkkYvz
         x1+MtHsCWICcbxM94lPFZlyMJD7PfXk7/nnzKq9TMGNLiVz8P9CRTgoNc0OZtQ+Q5xTU
         o0ow==
X-Gm-Message-State: APjAAAUKqrRVAUGflfwFi1lPcX1NOFkJHk3M0ddTfuARze+36UmLniuH
        zSL6iTs680Ddj3GUGH+PRgYk1Ebq55JAe502U3w=
X-Google-Smtp-Source: APXvYqzLnvQeVBl/Ve4oyq3esJ2rWAth5JYTEHrQ72d8RQW7amMZS2qGsJgZz6ByrzDBVoXE0BqngQMbCnG89O9M52s=
X-Received: by 2002:a05:651c:204f:: with SMTP id t15mr173539ljo.240.1576027278082;
 Tue, 10 Dec 2019 17:21:18 -0800 (PST)
MIME-Version: 1.0
References: <20191205235704.31385-1-alext9@gmail.com> <20191209145312.3251-1-alext9@gmail.com>
 <20191209145312.3251-2-alext9@gmail.com> <xmqq36dtwcvw.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36dtwcvw.fsf@gitster-ct.c.googlers.com>
From:   Alex Torok <alext9@gmail.com>
Date:   Tue, 10 Dec 2019 20:21:06 -0500
Message-ID: <CANmPhj26C2ow-4kZZ5f5USPVE7aN_F7Y81sJK_6iWxBUwc0cmw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] rebase: fix --fork-point with short refname
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 9, 2019 at 1:51 PM Junio C Hamano <gitster@pobox.com> wrote:
> and there are other calls to die(_("...")) in the caller everywhere,
> so I'd say you are over-engineering a simple bugfix.
>
> Wouldn't it be sufficient for this fix to be more like this?

This is essentially what I had done in the v2 version of my patch
with the only "big" difference being pulling out the dwim_ref() switching
and dying logic into a dwim_ref_or_die() function.

Let me know if you want me to adjust my patch at all (my v2 patch is
missing a call to free()...).

If the patch that you replied here with is sufficient for how you would fix
it, I'm fine with you just using that.

> -- >8 --
>
> Subject: rebase: --fork-point regression fix
>
> "git rebase --fork-point master" used to work OK, as it internally
> called "git merge-base --fork-point" that knew how to handle short
> refname and dwim it to the full refname before calling the
> underlying get_fork_point() function.
>
> This is no longer true after the command was rewritten in C, as its
> internall call made directly to get_fork_point() does not dwim a
> short ref.
>
> Move the "dwim the refname argument to the full refname" logic that
> is used in "git merge-base" to the underlying get_fork_point()
> function, so that the other caller of the function in the
> implementation of "git rebase" behaves the same way to fix this
> regression.
>
> ---
>  builtin/merge-base.c         | 12 +-----------
>  commit.c                     | 15 +++++++++++++--
>  t/t3431-rebase-fork-point.sh | 20 ++++++++++++++++++++
>  3 files changed, 34 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/merge-base.c b/builtin/merge-base.c
> index e3f8da13b6..6719ac198d 100644
> --- a/builtin/merge-base.c
> +++ b/builtin/merge-base.c
> @@ -114,26 +114,16 @@ static int handle_is_ancestor(int argc, const char **argv)
>  static int handle_fork_point(int argc, const char **argv)
>  {
>         struct object_id oid;
> -       char *refname;
>         struct commit *derived, *fork_point;
>         const char *commitname;
>
> -       switch (dwim_ref(argv[0], strlen(argv[0]), &oid, &refname)) {
> -       case 0:
> -               die("No such ref: '%s'", argv[0]);
> -       case 1:
> -               break; /* good */
> -       default:
> -               die("Ambiguous refname: '%s'", argv[0]);
> -       }
> -
>         commitname = (argc == 2) ? argv[1] : "HEAD";
>         if (get_oid(commitname, &oid))
>                 die("Not a valid object name: '%s'", commitname);
>
>         derived = lookup_commit_reference(the_repository, &oid);
>
> -       fork_point = get_fork_point(refname, derived);
> +       fork_point = get_fork_point(argv[0], derived);
>
>         if (!fork_point)
>                 return 1;
> diff --git a/commit.c b/commit.c
> index 40890ae7ce..016f14fe95 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -903,12 +903,22 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
>         struct commit_list *bases;
>         int i;
>         struct commit *ret = NULL;
> +       char *full_refname;
> +
> +       switch (dwim_ref(refname, strlen(refname), &oid, &full_refname)) {
> +       case 0:
> +               die("No such ref: '%s'", refname);
> +       case 1:
> +               break; /* good */
> +       default:
> +               die("Ambiguous refname: '%s'", refname);
> +       }
>
>         memset(&revs, 0, sizeof(revs));
>         revs.initial = 1;
> -       for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
> +       for_each_reflog_ent(full_refname, collect_one_reflog_ent, &revs);
>
> -       if (!revs.nr && !get_oid(refname, &oid))
> +       if (!revs.nr)
>                 add_one_commit(&oid, &revs);
>
>         for (i = 0; i < revs.nr; i++)
> @@ -934,6 +944,7 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
>
>  cleanup_return:
>         free_commit_list(bases);
> +       free(full_refname);
>         return ret;
>  }
>
> diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
> index 78851b9a2a..5b09aecd13 100755
> --- a/t/t3431-rebase-fork-point.sh
> +++ b/t/t3431-rebase-fork-point.sh
> @@ -47,11 +47,31 @@ test_rebase 'G F B A' --keep-base
>  test_rebase 'G F C E D B A' --no-fork-point
>  test_rebase 'G F C D B A' --no-fork-point --onto D
>  test_rebase 'G F C B A' --no-fork-point --keep-base
> +
>  test_rebase 'G F E D B A' --fork-point refs/heads/master
> +test_rebase 'G F E D B A' --fork-point master
> +
>  test_rebase 'G F D B A' --fork-point --onto D refs/heads/master
> +test_rebase 'G F D B A' --fork-point --onto D master
> +
>  test_rebase 'G F B A' --fork-point --keep-base refs/heads/master
> +test_rebase 'G F B A' --fork-point --keep-base master
> +
>  test_rebase 'G F C E D B A' refs/heads/master
> +test_rebase 'G F C E D B A' master
> +
>  test_rebase 'G F C D B A' --onto D refs/heads/master
> +test_rebase 'G F C D B A' --onto D master
> +
>  test_rebase 'G F C B A' --keep-base refs/heads/master
> +test_rebase 'G F C B A' --keep-base master
> +
> +test_expect_success "git rebase --fork-point with ambigous refname" "
> +       git checkout master &&
> +       git checkout -b one &&
> +       git checkout side &&
> +       git tag one &&
> +       test_must_fail git rebase --fork-point --onto D one
> +"
>
>  test_done
