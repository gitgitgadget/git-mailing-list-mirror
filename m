Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5D9C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 17:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C4B61430
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 17:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244697AbhDURis (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 13:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbhDURis (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 13:38:48 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA41C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 10:38:14 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso25588039otm.4
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 10:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XSBHZlcOGyT2HuDBBQT+/C1q1cxDqP1Je43cLlL/8rg=;
        b=MwexRAzz79lXbPFg+rxmt+Lfd1obB9lr6jCZam3qS97cdQ+chVud25ePkhWxjge2hM
         Ph7mwj5Qjx105efklJIWU7wak73eoT4FNtHeStFjC4euQOG4ISHV7yofAxd+vb0Kd+i5
         H8YZ6bP6+jH+1iH3SlsdivutbGS8FuRPsoTL4CQBCzhDoz/z99RJIQc2dnthW4t1xI+H
         ntGG2VjQH/lbKzr4R39znE27+Kcz1RR0eqseCra4Lf2C+PRMdggiZvHAGiQ02QISdd4/
         K9T2iSVGcd/J3L7yJDmzBdePcK7m4iVR/PxxzxNf+0w34WHuz0bDfCEpD4ZsAbeYWwxY
         QM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XSBHZlcOGyT2HuDBBQT+/C1q1cxDqP1Je43cLlL/8rg=;
        b=Qxm8S+iA5IcIyaI94WSo5fqvvHwRfpKE8AjYgPXXCSH7IPeAnWNarsX86gj0sL8KKB
         4T0V97lf5NDyYxyWdBt6RDJUM/I6fqNf42S/txgyfKUXmqy3FvnhrcjGqBhdkLveEZqN
         KtyryNhgm6C9/8qRES7n8Z1G0++MlCJF5dysHarwCOlML7pYZnIfZ8Td8OeY5uzUf7ZA
         Qa+rxsFZYPuaP5gQ1wEu/IX8QFU4Vxxp1QT2o7wXWqlLIlyINFu8+cz+vfwtvbKsfMns
         FheBOLEMSX/Hq7T/2/k+oo2MEsa22Tv1XceGo//0fZUWKRisQbvdfDJ6N7mqOXOmsTtY
         2SsQ==
X-Gm-Message-State: AOAM532T3C7eIKsfhFFr8UM1b6wTZc79rLBfJgO0tcLMBKrRhrVkjKjh
        p9ddOIdK7w4no+KKFrUoPI72bOiIALU0n1a782I=
X-Google-Smtp-Source: ABdhPJym4svd8hiioHKMmht2Dp4MqSUZMotO9sWdjQtM3OuB29JWw3whNtl+jCQ3pNzT6eGf6uiWaCOmj8HQyJ/J08s=
X-Received: by 2002:a05:6830:906:: with SMTP id v6mr24256845ott.345.1619026694261;
 Wed, 21 Apr 2021 10:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
 <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com> <8db27892c598a3976c0742e23563f1d360b8dee1.1607677728.git.gitgitgadget@gmail.com>
 <87fszj3jni.fsf@evledraar.gmail.com>
In-Reply-To: <87fszj3jni.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Apr 2021 10:38:03 -0700
Message-ID: <CABPp-BHoCron-aNvjwwDkoAcvi_5X5uoZdO639eGg9XnoJUqdQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] t4058: explore duplicate tree entry handling in a
 bit more detail
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 5:29 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Dec 11 2020, Elijah Newren via GitGitGadget wrote:
>
> > While creating the last commit, I found a number of other cases where
> > git would segfault when faced with trees that have duplicate entries.
> > None of these segfaults are in the diffcore-rename code (they all occur
> > in cache-tree and unpack-trees).  Further, to my knowledge, no one has
> > ever been adversely affected by these bugs, and given that it has been
> > 15 years and folks have fixed a few other issues with historical
> > duplicate entries (as noted in the last commit), I am not sure we will
> > ever run into anyone having problems with these.  So I am not sure thes=
e
> > are worth fixing, but it doesn't hurt to at least document these
> > failures in the same test file that is concerned with duplicate tree
> > entries.
> > [...]
> > +test_expect_failure 'fast-forward from duplicate entries to non-duplic=
ate' '
> > +     git merge update
> > +'
> > +
> >  test_done
>
> Per https://lore.kernel.org/git/87lf9b3mth.fsf@evledraar.gmail.com/
> isn't the noise of having a segfault from "git" worth fixing in itself
> though? I.e. something like this, so we at least se why it fails:
>
> diff --git a/t/t4058-diff-duplicates.sh b/t/t4058-diff-duplicates.sh
> index 54614b814db..ed91d9f7fe9 100755
> --- a/t/t4058-diff-duplicates.sh
> +++ b/t/t4058-diff-duplicates.sh
> @@ -182,8 +182,10 @@ test_expect_success 'switch to base branch and force=
 status to be clean' '
>         test_must_be_empty actual
>  '
>
> -test_expect_failure 'fast-forward from duplicate entries to non-duplicat=
e' '
> -       git merge update
> +test_expect_success 'fast-forward from duplicate entries to non-duplicat=
e' '
> +       ! git merge update 2>err &&
> +       grep "^BUG: " err &&
> +       grep -F "should have entry at o->src_index->cache[1]" err
>  '
>
>  test_done
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 8a1afbc1e49..230cb073fe1 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -789,8 +789,11 @@ static int traverse_by_cache_tree(int pos, int nr_en=
tries, int nr_names,
>          */
>         for (i =3D 0; i < nr_entries; i++) {
>                 int new_ce_len, len, rc;
> +               int j =3D pos + i;
>
> -               src[0] =3D o->src_index->cache[pos + i];
> +               src[0] =3D o->src_index->cache[j];
> +               if (!src[0])
> +                       BUG("should have entry at o->src_index->cache[%d]=
", j);
>
>                 len =3D ce_namelen(src[0]);
>                 new_ce_len =3D cache_entry_size(len);
>

Seems reasonable to me.  Are you planning to add a commit message and
turn it into a proper patch?  If so, I'll give my Thumbs-up-by or
whatever we need.  :-)
