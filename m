Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB89E20248
	for <e@80x24.org>; Mon, 25 Mar 2019 16:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfCYQHm (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 12:07:42 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45864 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCYQHm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 12:07:42 -0400
Received: by mail-ua1-f65.google.com with SMTP id c13so1762473uao.12
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V2xCGdwGN1CCoqUFUvJCXL17B83tKttqG4sAtntFonU=;
        b=bzP2pVdjTehKtTCoNqTJKlJO++3pTtBrCXXPiA3llRuDku4DMllAhatAkOkJIVTuWT
         CmdMwVTgXUhSEubKHPPSH8Rdn2KOfrmCfHSxiVwCvGWXnBfXNYT/mQEpLgH0Lp3Np1Qw
         +QkZcGx23K11O+HkyBua/zOcbnY3IB0l2Agp1Ixly+vfsz7tcet2E4ACF3Rzp+PLmm9N
         WRcPxYo4sHTRoDCkWOD4LTW4+XGKhBfbWNAZQwIfsiYafoX458MqgID/AYoi8LTmjcqm
         qD6js12Ws60y6EHjIvtb2P/EoyEg6VOcSoEc/KhzMk4mCZdjtTlPlIP36lFB1Yq75Dmh
         DMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V2xCGdwGN1CCoqUFUvJCXL17B83tKttqG4sAtntFonU=;
        b=lT+T7I48O9IJDId1icWQwE2pnxQu+XaLh5lWs+ju0phpMGGq/9IELARyzjIdROYJB3
         5jVenlmWqNP+xY+SYvjd78INkA8+dGRtJM+Q4T6LXO5jSiR/a4Qycnj94y2P7gO5Fao4
         06pBlwoa47aL/5sJuA3HzoL5telm3y0jbLrPvD0lzBCliJgMDNXWphA2iRcmUm+ta3jn
         iTXXoHXs/TBudoVYMHtwXPL83wh9mA6bAQIZwBmV7R79r6Dsm57loamT87lQIh7vOdqu
         /fA6qnEcnUQ2eGYknWrh43BMc2Yi//D/4/YP85tpjCyvEJm61VXys/ELs4FZiYmEnY3N
         D/sA==
X-Gm-Message-State: APjAAAXJhteiwxJEYMvk6XQiqIvevlxfIvfhfxoUW2QpX4uYVi0wGG9d
        OddWk6s9GirRd7LXcF3hn0oDNE8LDt1Y9zeGuCEzvg==
X-Google-Smtp-Source: APXvYqxoNcnVPw/Qrxunvcx7rnfmYI0ecIhWSSpiBFlLhek+F/e2R1w0F0ijXlxn4x4toV4/AV/mfk2bqwM5yl4RVgE=
X-Received: by 2002:a9f:24ee:: with SMTP id 101mr7778603uar.87.1553530060566;
 Mon, 25 Mar 2019 09:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190322093138.13765-1-pclouds@gmail.com> <20190322093138.13765-5-pclouds@gmail.com>
In-Reply-To: <20190322093138.13765-5-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 25 Mar 2019 09:07:28 -0700
Message-ID: <CABPp-BGcfEuMCcRvALWHO26frj3GRO_Wo620YgXwgriLSMggJA@mail.gmail.com>
Subject: Re: [PATCH 4/4] checkout: prevent losing staged changes with --merge
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 22, 2019 at 2:32 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> When --merge is specified, we may need to do a real merge (instead of
> three-way tree unpacking), the steps are best seen in git-checkout.sh
> version before it's removed:
>
>     # Match the index to the working tree, and do a three-way.
>     git diff-files --name-only | git update-index --remove --stdin &&
>     work=3D`git write-tree` &&
>     git read-tree $v --reset -u $new || exit
>
>     git merge-recursive $old -- $new $work
>
>     # Do not register the cleanly merged paths in the index yet.
>     # this is not a real merge before committing, but just carrying
>     # the working tree changes along.
>     unmerged=3D`git ls-files -u`
>     git read-tree $v --reset $new
>     case "$unmerged" in
>     '')     ;;
>     *)
>             (
>                     z40=3D0000000000000000000000000000000000000000
>                     echo "$unmerged" |
>                     sed -e 's/^[0-7]* [0-9a-f]* /'"0 $z40 /"
>                     echo "$unmerged"
>             ) | git update-index --index-info
>             ;;
>     esac
>
> Notice the last 'read-tree --reset' step. We restore worktree back to
> 'new' tree after worktree's messed up by merge-recursive. If there are
> staged changes before this whole command sequence is executed, they
> are lost because they are unlikely part of the 'new' tree to be
> restored.
>
> There is no easy way to fix this. Elijah may have something up his
> sleeves [1], but until then, check if there are staged changes and
> refuse to run and lose them. The user would need to do "git reset" to
> continue in this case.
>
> A note about the test update. 'checkout -m' in that test will fail
> because a deletion is staged. This 'checkout -m' was previously needed
> to verify quietness behavior of unpack-trees. But a different check
> has been put in place in the last patch. We can safely drop
> 'checkout -m' now.
>
> [1] CABPp-BFoL_U=3DbzON4SEMaQSKU2TKwnOgNqjt5MUaOejTKGUJxw@mail.gmail.com
>
> Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  builtin/checkout.c | 11 ++++++++++-
>  t/t7201-co.sh      | 10 +---------
>  2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 22fb6c0cae..7cd01f62be 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -725,7 +725,10 @@ static int merge_working_tree(const struct checkout_=
opts *opts,
>                          */
>                         struct tree *result;
>                         struct tree *work;
> +                       struct tree *old_tree;
>                         struct merge_options o;
> +                       struct strbuf sb =3D STRBUF_INIT;
> +
>                         if (!opts->merge)
>                                 return 1;
>
> @@ -735,6 +738,12 @@ static int merge_working_tree(const struct checkout_=
opts *opts,
>                          */
>                         if (!old_branch_info->commit)
>                                 return 1;
> +                       old_tree =3D get_commit_tree(old_branch_info->com=
mit);
> +
> +                       if (repo_index_has_changes(the_repository, old_tr=
ee, &sb))
> +                               die(_("cannot continue with staged change=
s in "
> +                                     "the following files:\n%s"), sb.buf=
);
> +                       strbuf_release(&sb);
>
>                         /* Do more real merge */
>
> @@ -772,7 +781,7 @@ static int merge_working_tree(const struct checkout_o=
pts *opts,
>                         ret =3D merge_trees(&o,
>                                           get_commit_tree(new_branch_info=
->commit),
>                                           work,
> -                                         get_commit_tree(old_branch_info=
->commit),
> +                                         old_tree,
>                                           &result);
>                         if (ret < 0)
>                                 exit(128);
> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index f165582019..5990299fc9 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -224,15 +224,7 @@ test_expect_success 'switch to another branch while =
carrying a deletion' '
>         test_i18ngrep overwritten errs &&
>
>         test_must_fail git read-tree --quiet -m -u HEAD simple 2>errs &&
> -       test_must_be_empty errs &&
> -
> -       git checkout --merge simple 2>errs &&
> -       test_i18ngrep ! overwritten errs &&
> -       git ls-files -u &&
> -       test_must_fail git cat-file -t :0:two &&
> -       test "$(git cat-file -t :1:two)" =3D blob &&
> -       test "$(git cat-file -t :2:two)" =3D blob &&
> -       test_must_fail git cat-file -t :3:two
> +       test_must_be_empty errs
>  '

Ah, I see you avoid the other bug in checkout by just removing its
usage.  Seems fair enough; I can add a separate test to demonstrate
that bug when I get some time to work on it.  Hopefully I'll find a
quick fix too.
