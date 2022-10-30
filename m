Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478C1C38A02
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 23:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJ3X26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 19:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJ3X25 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 19:28:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105CE6256
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 16:28:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id u24so6046718edd.13
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 16:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=canva.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHdLXPvHxfVQu3bg1TRI97sYM6wJRpZpTkeh1rSaIsY=;
        b=Q/Y3rUwFAOc62/F13/X1zOaQNTw1SttNzO1jSTr0CNUcKwoT05OvQTBdn7ZwOL2j3G
         obWAGtzBzMtxl7hGWS2VceMvXPhvCBKV55RuJFB3mNyc1Ss8ae6hVzH+rsKiexcHx988
         fViH3baUHnk8EUHrkZ4/AL5ka7x6cI/MbjQjtIVCt3tZ6ZZlJJiH5cM4rjCZCPWrtZRj
         LhfYrfxduD39qEy8FzCGnfFzl2SoZ6QhKLQp6ydgBvy0QHyB7m10nVJqwqk5GPz9kOMR
         cMfPaiC56wfXgBYUJVcTmyGMjy9AuSZRsWC5/Q5gE/3A+FO3OSnqnGjMd74Xobok9401
         9MWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHdLXPvHxfVQu3bg1TRI97sYM6wJRpZpTkeh1rSaIsY=;
        b=yfQ2rIQbs8uj6iwzzYlh069b/w3bJ+/H4umqIFN1V0Q8HSkQYdft2/waQkAZLcMDLl
         Iq0l4XqNUC+lMjcmynTd5pY+0XA0SXWMdbYXfOZSxMwJn5WFYARgf2t5OPQh5HhJYBSS
         N3NPRUeNsnqWsELDlubfThbnRFooy871ecmGa9Pjlb50bMixleI43Rfrxdk+OhN0YjQB
         mGUGGx7pqbPA2AayKsnB+H4ZpZraDHTdKH8Kkic4Jr5L+0NUfgdNYEDPma6ErZwJtgrt
         hP7q/aGbAk2aUnbNfwKRr6BZGXul+SulGvW85kmVtlUdEabpkyZQlBTvj6NOMkGb/y8s
         yGpQ==
X-Gm-Message-State: ACrzQf1SFzGxmW3kxLQ8arCXvrY8ndPE+yp+3+RG8csA2kN/lsn8oImA
        sJjPHFAILRvaEMuaTDQDLNuk+DqBAOovazPGws/+K82aFsMUrvkhCxbFFpQJkL/b7nrD2F6noZ+
        rUf1erDJjr1mryTLZfB39ldxc+Kicjcyrllrt/yfwX2aAlb2F79N7DbG0ICZBT0fY8t4n0xVrlX
        m3zRDzkGnx99kso30XNx3h2N+P7j5hSjsEnb6WIg==
X-Google-Smtp-Source: AMsMyM4TSjwpSVzOHjIFxGS99qfJ8Z60MYQyqzaKQ+V6aGOXPG+QZdBg+uMyGCzfg6WjlrTcZ/02rQcdqN1dH4xrVjk=
X-Received: by 2002:a05:6402:51c9:b0:45d:5efe:d1a3 with SMTP id
 r9-20020a05640251c900b0045d5efed1a3mr10921586edd.58.1667172534480; Sun, 30
 Oct 2022 16:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1368.git.git.1666742722502.gitgitgadget@gmail.com>
 <pull.1368.v2.git.git.1666917961644.gitgitgadget@gmail.com>
 <313a6619-273c-066e-c3da-a519b38c03af@github.com> <xmqqy1szj29n.fsf@gitster.g>
In-Reply-To: <xmqqy1szj29n.fsf@gitster.g>
From:   Anh Le <anh@canva.com>
Date:   Mon, 31 Oct 2022 10:28:18 +1100
Message-ID: <CAOZNrpH7DSF9m+M7r=Za--dVWDiHyL4hdAUWHfW=DDy10n5eeQ@mail.gmail.com>
Subject: Re: [PATCH v2] index: add trace2 region for clear skip worktree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Anh Le via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Timothy Jones <timothy@canva.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: canva,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you everyone, lots of things for me to take notes of. I'll send
in another patch.

Regards,
Anh

On Sat, Oct 29, 2022 at 4:17 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Derrick Stolee <derrickstolee@github.com> writes:
>
> > A few style things:
> >
> > 1. Use "if (path_counts[0])" to detect a non-zero value.
> > 2. Don't use { } around a single-line block.
> > 3. Your lines are quite long, due a lot from your long keys.
> >    Shorten the keys (maybe "sparse_path_count" and "restarted_count"
> >    is enough context) and consider using a line break in
> >    the middle of the parameters.
>
> All good suggestions.  Let me add another one.
>
>   4. Call an array you primarily access its individual elements in
>      singular.  That way, you can say path_count[0] (i.e. the count
>      for the zeroth round).  An array that exists mostly to be
>      passed around as a whole to represent a "set of things", on the
>      other hand, can be called in plural.
>
> Taking them all together, perhaps something like this is what you
> meant?
>
>  sparse-index.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git c/sparse-index.c w/sparse-index.c
> index dbf647949c..8c269dab80 100644
> --- c/sparse-index.c
> +++ w/sparse-index.c
> @@ -493,22 +493,25 @@ void clear_skip_worktree_from_present_files(struct =
index_state *istate)
>         int dir_found =3D 1;
>
>         int i;
> -       int path_counts[2] =3D {0, 0};
> +       int path_count[2] =3D {0, 0};
>         int restarted =3D 0;
>
>         if (!core_apply_sparse_checkout ||
>             sparse_expect_files_outside_of_patterns)
>                 return;
>
> -       trace2_region_enter("index", "clear_skip_worktree_from_present_fi=
les", istate->repo);
> +       trace2_region_enter("index", "clear_skip_worktree_from_present_fi=
les",
> +                           istate->repo);
>  restart:
>         for (i =3D 0; i < istate->cache_nr; i++) {
>                 struct cache_entry *ce =3D istate->cache[i];
>
>                 if (ce_skip_worktree(ce)) {
> -                       path_counts[restarted]++;
> +                       path_count[restarted]++;
>                         if (path_found(ce->name, &last_dirname, &dir_len,=
 &dir_found)) {
>                                 if (S_ISSPARSEDIR(ce->ce_mode)) {
> +                                       if (restarted)
> +                                               BUG("ensure-full-index di=
d not fully flatten?");
>                                         ensure_full_index(istate);
>                                         restarted =3D 1;
>                                         goto restart;
> @@ -518,13 +521,14 @@ void clear_skip_worktree_from_present_files(struct =
index_state *istate)
>                 }
>         }
>
> -       if (path_counts[0] > 0) {
> -               trace2_data_intmax("index", istate->repo, "clear_skip_wor=
ktree_from_present_files/path_count", path_counts[0]);
> -       }
> -       if (restarted) {
> -               trace2_data_intmax("index", istate->repo, "clear_skip_wor=
ktree_from_present_files/full_index/path_count", path_counts[1]);
> -       }
> -       trace2_region_leave("index", "clear_skip_worktree_from_present_fi=
les", istate->repo);
> +       if (path_count[0])
> +               trace2_data_intmax("index", istate->repo,
> +                                  "sparse_path_count", path_count[0]);
> +       if (restarted)
> +               trace2_data_intmax("index", istate->repo,
> +                                  "sparse_path_count_full", path_count[1=
]);
> +       trace2_region_leave("index", "clear_skip_worktree_from_present_fi=
les",
> +                           istate->repo);
>  }
>
>  /*
>

--=20
**
** <https://www.canva.com/>Empowering the world to=C2=A0design
We're hiring,=20
apply here <https://www.canva.com/careers/>!=C2=A0Check out the latest news=
 and=20
learnings from our team on the Canva Newsroom=20
<https://www.canva.com/newsroom/news/>.
 <https://twitter.com/canva>=20
<https://facebook.com/canva> <https://au.linkedin.com/company/canva>=20
<https://twitter.com/canva>=C2=A0 <https://facebook.com/canva>=C2=A0=20
<https://www.linkedin.com/company/canva>=C2=A0
 <https://instagram.com/canva>



