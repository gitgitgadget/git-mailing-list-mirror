Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7884BC6FD1F
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjCSGE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCSGEz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:04:55 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B069B144B3
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:04:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id t14so9016258ljd.5
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679205892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxFEYuZ0wFnfmM2WGU4qRjHxGlQVTT6zhS1syyS+4X0=;
        b=IsGIcAW10rU/YM3XRVAXusYSFVROMTx2p1PCSpQC+cM2ZIamdbA7enXfW6GN13OIZA
         OsNmnQalWJZ7WmqABI8Uld1XYkSPYEw+jCCUiMHFocDZmUf2V4A943ugz41gw+33rtOo
         SeIYM0LsipKX0OsnBrULcOl50OjfJrKmfQ16/UNCcTDsm/LMUXZOL9gwAdqdgZLn2k/B
         QmjG+f5LP/wypvNnX1lJx+CZ5r6uYO+Lm9pKlg82Jd5dcjuPjObak7u+/HrlWGKxwNKa
         alfbtVyEvr4b4G2T+AivZNFaUgmeItcnsFlpQ1AZZ9Orp+lVghEs8VIP7+x5iMU3a8H1
         r7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679205892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxFEYuZ0wFnfmM2WGU4qRjHxGlQVTT6zhS1syyS+4X0=;
        b=RBNLDG73s2iiLE791d9RgMzTvhtQFw+dMeOd/cBEeimXywqGafx5W1BlKAENkjXRJs
         kIj3CwvWRKLFhpdVYle8ZBKpN5oQt8TYPZZ+fdCPCQzMIY+ddEVMLwkmsSSqLNK24I1+
         HgpR79zXeneF4YqhzMszQX+ftvjD7YHGAOlGQ336HRNbcrvA/gXFWh6i84Sn9ezf2uhI
         yCvBVJoOr+YXJEgb+8ae1XelmB2IZrve9K+rFJem4+/qPrIzaj93vzbwqnbpRCd8C4+5
         BOgoTxrzdVYr0yE+Xgh1260yNVy+8LZo1HBsaiya6U6syAi4J0AxIeLb0ZGL/Uj3ud5J
         YBJg==
X-Gm-Message-State: AO0yUKUs0grbUJcRW2yoZuAOV3PfA/NHveLCyz+lvxd0J+dblveKfaX7
        QITF71Pnw4rcHHjCZEKyK/dRIlMiGJeMF5+kYJYeHWPVqqg=
X-Google-Smtp-Source: AK7set999m2INz+VsUEit/PfbUQadfcrC/cmV0M625bQazX2MnHbEQraHH+z+mGvjQBsAwFpk8J8N3/f4snWrTHKowU=
X-Received: by 2002:a2e:b4a3:0:b0:295:93eb:e796 with SMTP id
 q3-20020a2eb4a3000000b0029593ebe796mr4658286ljm.1.1679205891952; Sat, 18 Mar
 2023 23:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <patch-04.17-4b62e9a35a9-20230317T152724Z-avarab@gmail.com>
In-Reply-To: <patch-04.17-4b62e9a35a9-20230317T152724Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 18 Mar 2023 23:04:39 -0700
Message-ID: <CABPp-BHNQuK=uaaxO65nMxegSK=cQ20ni_L+RPHs1bkYagetZQ@mail.gmail.com>
Subject: Re: [PATCH 04/17] cocci: add missing "the_repository" macros to "pending"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2023 at 8:57=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
<avarab@gmail.com> wrote:
>
> In the case of diff.h, rerere.h and revision.h the macros were added
> in [1], [2] and [3] when "the_repository.pending.cocci" didn't
> exist. None of the subsequently added migration rules covered
> them. Let's add those missing rules.
>
> In the case of macros in "cache.h", "commit.h", "packfile.h",
> "promisor-remote.h" and "refs.h" those aren't guarded by
> "NO_THE_REPOSITORY_COMPATIBILITY_MACROS", but they're also macros that
> add "the_repository" as the first argument, so we should migrate away
> from them.

Yaay, nice to see work on migrating away from the_repository again.  :-)

> 1. 2abf3503854 (revision.c: remove implicit dependency on the_index,
>    2018-09-21)
> 2. e6757652350 (diff.c: remove implicit dependency on the_index,
>    2018-09-21)
> 3. 35843b1123e (rerere.c: remove implicit dependency on the_index,
>    2018-09-21)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  .../coccinelle/the_repository.pending.cocci   | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/co=
ccinelle/the_repository.pending.cocci
> index 84b79dce480..8b3f2580e6b 100644
> --- a/contrib/coccinelle/the_repository.pending.cocci
> +++ b/contrib/coccinelle/the_repository.pending.cocci
> @@ -5,7 +5,44 @@
>  @@
>  @@
>  (
> +// cache.h
> +- get_oid
> ++ repo_get_oid
> +|
> +- get_oid_commit
> ++ repo_get_oid_commit
> +|
> +- get_oid_committish
> ++ repo_get_oid_committish
> +|
> +- get_oid_tree
> ++ repo_get_oid_tree
> +|
> +- get_oid_treeish
> ++ repo_get_oid_treeish
> +|
> +- get_oid_blob
> ++ repo_get_oid_blob
> +|
> +- get_oid_mb
> ++ repo_get_oid_mb
> +|
> +- find_unique_abbrev
> ++ repo_find_unique_abbrev
> +|
> +- find_unique_abbrev_r
> ++ repo_find_unique_abbrev_r
> +|
> +- for_each_abbrev
> ++ repo_for_each_abbrev
> +|
> +- interpret_branch_name
> ++ repo_interpret_branch_name
> +|
> +- peel_to_type
> ++ repo_peel_to_type
>  // commit-reach.h
> +|
>  - get_merge_bases
>  + repo_get_merge_bases
>  |
> @@ -36,6 +73,13 @@
>  |
>  - logmsg_reencode
>  + repo_logmsg_reencode
> +|
> +- get_commit_tree
> ++ repo_get_commit_tree
> +// diff.h
> +|
> +- diff_setup
> ++ repo_diff_setup
>  // object-store.h
>  |
>  - read_object_file
> @@ -50,6 +94,32 @@
>  |
>  - format_commit_message
>  + repo_format_commit_message
> +// packfile.h
> +|
> +- approximate_object_count
> ++ repo_approximate_object_count
> +// promisor-remote.h
> +|
> +- promisor_remote_reinit
> ++ repo_promisor_remote_reinit
> +|
> +- promisor_remote_find
> ++ repo_promisor_remote_find
> +|
> +- has_promisor_remote
> ++ repo_has_promisor_remote
> +// refs.h
> +|
> +- dwim_ref
> ++ repo_dwim_ref
> +// rerere.h
> +|
> +- rerere
> ++ repo_rerere
> +// revision.h
> +|
> +- init_revisions
> ++ repo_init_revisions
>  )
>    (
>  + the_repository,
> --
> 2.40.0.rc1.1034.g5867a1b10c5

Makes sense.
