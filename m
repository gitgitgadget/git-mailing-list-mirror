Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA21C4320E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 12:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A7D1610CD
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 12:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344593AbhIBMlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 08:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344579AbhIBMlG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 08:41:06 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812BDC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 05:40:08 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id g9so2177676ioq.11
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0fbJcgutmhxg9PMtmURopmUULOE1nwAE4ZHGXJn6uXI=;
        b=GP0DVdAWJTPNnx6wVTg0h3qNTmNPLvq7PrWuAs8JCXrbporZbWRVKfV68l3Sb3VpfO
         mPqGmMmAo8NizA4AB6i+4Pep5T/t8580bqOV+dnTgirfDCIpX68Wse90b38HdeEUoEpK
         ffiQT85MiT7J9UcohrNZ9JCvpe9x12QJCIviTnU2pjHkOG3smwewEl5CAUy4YE/g1ran
         wWetsTi4NSUNoBp+UrfJH3x7Sb0CywbGr02ZkxEjd5GGuGbZQecR7PAjTAbkKiFn7mDv
         +vRhulsKjBYIxhXFEUt7jK8cAWtcbemcsElNDe0zjWrJ2c/B1uw8l7C/R5zzFCJxUELd
         yPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0fbJcgutmhxg9PMtmURopmUULOE1nwAE4ZHGXJn6uXI=;
        b=k3YFxI8N6MS7KWlJXWhFH7HjeyCKFbFnRqDBOmAF4fNIYAIh+nLmT1YuOqmdQaBGd8
         5UPfe2AYbp6W7KWgY+ybUcUukmJSYCIS9XnMBUsMAgnvIm6BjAsrwsqJEEXNN/RFSUgf
         RrqgAqfu9spaMmrI+x+qSRcAA2235MvbKwUP9mv0wtyy2YPDD1WynjTIA5Jf19WqHJ6Q
         P0ZrOAXJtmHbwUzBWhfi3hb2ekbQXcEwfHsS6UAu5qdWktui212VdLZW1MXfNoNr5Zg1
         wdhCMlFjgi0nOCIaDb8ttp2kn277iA4WgVjJj47l2159+Lz4zSIMBOZUwXh1rRaShEaA
         JCPg==
X-Gm-Message-State: AOAM533kFpR8veLM6hS/+CBzQh2MF6640cqMW472GbgW6X7VIlWNMwjV
        qB9VAOEdTCy9RNkm+WMNV8aJknjozCdOr1cRqjGTlQhhlwX3sTiig1k=
X-Google-Smtp-Source: ABdhPJzEwgjt8M9DaUzTEO4WKtERnH7O/eaoKmhfgmsFfwaClBlFyiwWK4kQ4BKHbBlfG/g3ih/Tl/4pl85S6RAx4Xc=
X-Received: by 2002:a05:6638:4104:: with SMTP id ay4mr2596890jab.10.1630586407969;
 Thu, 02 Sep 2021 05:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629805395.git.dyroneteng@gmail.com> <011e5eaea3f48eeacac1614f769e8fd809e0c093.1629805396.git.dyroneteng@gmail.com>
In-Reply-To: <011e5eaea3f48eeacac1614f769e8fd809e0c093.1629805396.git.dyroneteng@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 2 Sep 2021 20:39:56 +0800
Message-ID: <CAOLTT8Qm2wGMU0RuX+OrzZt78zSmzxHNoh0NYUFuVKJSAZJ1Ng@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] commit.h: add wrapped tags in commit struct
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8810:24=E5=86=99=E9=81=93=EF=BC=9A
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  commit.h   | 5 +++++
>  revision.c | 8 ++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/commit.h b/commit.h
> index df42eb434f..1e99e9ae8a 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -38,6 +38,11 @@ struct commit {
>          */
>         struct tree *maybe_tree;
>         unsigned int index;
> +       /*
> +       * wrapped tags or NULL.  If the commit is peeled from tag(s),
> +       * then save the wraps, otherwise will be NULL.
> +       */
> +       struct object_list *wraps;
>  };
>
>  extern int save_commit_buffer;
> diff --git a/revision.c b/revision.c
> index 65e0926d25..aecf493f46 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -416,14 +416,17 @@ static struct commit *handle_commit(struct rev_info=
 *revs,
>         const char *path =3D entry->path;
>         unsigned int mode =3D entry->mode;
>         unsigned long flags =3D object->flags;
> -
> +       struct object_list *wraps =3D NULL;
>         /*
>          * Tag object? Look what it points to..
>          */
>         while (object->type =3D=3D OBJ_TAG) {
>                 struct tag *tag =3D (struct tag *) object;
> -               if (revs->tag_objects && !(flags & UNINTERESTING))
> +               if (revs->tag_objects && !(flags & UNINTERESTING)) {
> +                       object_list_insert(object, &wraps);
>                         add_pending_object(revs, object, tag->tag);
> +               }
> +
>                 object =3D parse_object(revs->repo, get_tagged_oid(tag));
>                 if (!object) {
>                         if (revs->ignore_missing_links || (flags & UNINTE=
RESTING))
> @@ -449,6 +452,7 @@ static struct commit *handle_commit(struct rev_info *=
revs,
>          */
>         if (object->type =3D=3D OBJ_COMMIT) {
>                 struct commit *commit =3D (struct commit *)object;
> +               commit->wraps =3D wraps;
>
>                 if (repo_parse_commit(revs->repo, commit) < 0)
>                         die("unable to parse commit %s", name);
> --
> 2.31.1.456.gec51e24953
>

/*
 * The size of this struct matters in full repo walk operations like
 * 'git clone' or 'git gc'. Consider using commit-slab to attach data
 * to a commit instead of adding new fields here.
 */
struct commit {
        struct object object;
        timestamp_t date;
        struct commit_list *parents;

        /*
         * If the commit is loaded from the commit-graph file, then this
         * member may be NULL. Only access it through repo_get_commit_tree(=
)
         * or get_commit_tree_oid().
         */
        struct tree *maybe_tree;
        unsigned int index;
};

According to the instructions above, I wonder if you should use "commit_sla=
b" to
store part of the data related to the commit object instead of
modifying the member
of struct commit itself?

See:
https://github.com/git/git/blob/master/commit-slab.h
https://github.com/git/git/blob/master/commit-slab-impl.h
https://github.com/git/git/blob/master/commit-slab-decl.h
https://lore.kernel.org/git/CAOLTT8Q8BEKCVwPDypW1w66P9_xP7QC0T-CnLqamqAL4ha=
GzwA@mail.gmail.com/

Thanks.
--
ZheNing Hu
