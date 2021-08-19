Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71749C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 18:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42246610A3
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 18:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhHSSZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 14:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbhHSSZF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 14:25:05 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4990C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 11:24:28 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u10so9696703oiw.4
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 11:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4/5yhduZza4yZq7uUWcf90hcT2/A6aNvI7qcDSTJoPc=;
        b=MSIOG8A2Rv/loJvvjnZ56dlXY5uMllYKBR4AVo9ZxLVCL3ts514epW26X8Wii69u3v
         9O6oybfwF1Ay62VkbBK2LHhHfOvmomKJUF6L22nURudJEgcyfoTUqoRICc3LBrNP2z1b
         HHRjDjngFP6Q72WjR0sePMAPweYcOkvp3+2KlyxH12y9DZEIrCSPLoSGK/qrpTB6n8wo
         nCFzR4TYrLnRiwglp1ZJU7WyvoUezbViogaYvVMOeoMToLqU4CKDefHMPsinU1NC1cUk
         q2vjTzSz20KBL/IBdt4rT8Yf9dVu5Ysnv0m//H8yz+WMqVSHYYmrSs+2v3bt+xZCSbL9
         CPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4/5yhduZza4yZq7uUWcf90hcT2/A6aNvI7qcDSTJoPc=;
        b=sSGMoY+f1ftQb8I6hp2xa3nxO63g56Yii2G4c5XYjodXifgm+4hHs5qkGRInknaEeY
         qzn3wZiCvIUj25NjHVO0T4KD4daB0ycyXtCxaSWNS8ruk5qOBba2pquORS1UZ62m54zr
         fLqD761amk6w6JEjwHv5Xp/xYRqmytoe3p6guNSYlHg3vIw83k+ZJrqMxgSQv1dwa4LC
         IE/9q+XHU3ME99I3zQNKBLvFi0/bcohZMgFrtJJhPV3y7igRiP2dyp4O2/YzMeJPki1l
         Kt7xRQkb3RgCFuQAXPR4QK7GDr10lAzhTcvGGFZmYoFqiBRv8wkPo8xdq8e4vsyh2JPR
         X8Hw==
X-Gm-Message-State: AOAM5320Lp+wF6xYm05UhSp+V53egXfb2pyRSK2LY7PHeJLX0GypwdKv
        ODVvnMgk4ublUvfVjfX3H2WOKJ3UwhqDtlykSfc=
X-Google-Smtp-Source: ABdhPJy5MUOsV/p1KJ6tA9afbRUJ6uDAhCLeADYIrMP5Wjh6S+SanjuVRc6MqzD4umyT9t1Ln8QsoiJhTWPnVJoa0bY=
X-Received: by 2002:a05:6808:2084:: with SMTP id s4mr45994oiw.31.1629397468212;
 Thu, 19 Aug 2021 11:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
 <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com> <371985352680a767dfacb5477aa77e92e04008ee.1628625013.git.gitgitgadget@gmail.com>
In-Reply-To: <371985352680a767dfacb5477aa77e92e04008ee.1628625013.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 19 Aug 2021 11:24:17 -0700
Message-ID: <CABPp-BFYHZUtiBy1B1NqvKD-S7cT-L138H0rF4-6J_sEpPXYAQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] sparse-index: silently return when cache tree fails
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 12:50 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> If cache_tree_update() returns a non-zero value, then it could not
> create the cache tree. This is likely due to a path having a merge
> conflict. Since we are already returning early, let's return silently to
> avoid making it seem like we failed to write the index at all.
>
> If we remove our dependence on the cache tree within
> convert_to_sparse(), then we could still recover from this scenario and
> have a sparse index.
>
> When constructing the cache-tree extension in convert_to_sparse(), it is
> possible that we construct a tree object that is new to the object
> database. Without the WRITE_TREE_MISSING_OK flag, this results in an
> error that halts our conversion to a sparse index. Add this flag to
> remove this limitation.

Would this only happen when the user has staged but uncommitted
changes outside the sparsity paths, and tries to sparsify while in
that state?  (Notably, this is a much different condition than the
above mentioned merge conflict case that would case
cache_tree_update() to just fail.)

I think it might be nicer to split this commit in two, just to make it
easier to understand for future readers.  This seems like two logical
changes and trying to understand them and why would I think be easier
if the two were split.  I'd be tempted to put the
WRITE_TREE_MISSING_OK first.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  sparse-index.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/sparse-index.c b/sparse-index.c
> index bc5900eae35..b6e90417556 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -179,10 +179,15 @@ int convert_to_sparse(struct index_state *istate)
>
>         /* Clear and recompute the cache-tree */
>         cache_tree_free(&istate->cache_tree);
> -       if (cache_tree_update(istate, 0)) {
> -               warning(_("unable to update cache-tree, staying full"));
> -               return -1;
> -       }
> +       /*
> +        * Silently return if there is a problem with the cache tree update,
> +        * which might just be due to a conflict state in some entry.
> +        *
> +        * This might create new tree objects, so be sure to use
> +        * WRITE_TREE_MISSING_OK.
> +        */
> +       if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
> +               return 0;
>
>         remove_fsmonitor(istate);
>
> --
> gitgitgadget

These feel like cases where it would be nice to have a testcase
demonstrating the change in behavior.  Perhaps just splitting the
commit would be enough, but it took a bit of time to try to understand
what would change and why, despite the simple changes.
