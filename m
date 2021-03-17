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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF3EC433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A1B64F07
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhCQRu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 13:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhCQRuf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 13:50:35 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB10C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 10:50:34 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so2615443otr.4
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 10:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CGJphFExgGXcMZj1nJMxbymp/4NK0gCjk9XsBXW0+ko=;
        b=oemUsAgtijIxyzmoT1Q/el5gF8vxPAb2QMHxgbGoDKeAchX8tSOkb6G38yHaum5aNw
         vl8uauMu1YZbP5Tv3D5a1TBZeSDcaWwVpFwQIHEyPN8lVGnHgo9/cAT6keyAysVg10bo
         pxXDhxtw0/7me/xD1auxTEkI6KVKtSAXLSQGrqNOxXrLDg3XSo9EJy2E/tu6Xo1o19pD
         4kdZV0+vaUX9roC28/l26CZhWLk2oRROTj6SQEa9lls3R7p3GBFd4V8xaoitNeY2xV45
         0nc/9yUzws1J+Qdd87UejANzSXmaNWY7oXj9qxjrd0LeTBsnNmfbeZ//1MrFsMnBqM7d
         KAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGJphFExgGXcMZj1nJMxbymp/4NK0gCjk9XsBXW0+ko=;
        b=kZf1gKFJRJ+pCqX85qCSEzCNmtHBHLG3DPgjDZIi4DzhMGPoLHHlsFgB4ccmJQJCcw
         HsjbMr+PdRc4J/qDRG+7c+6Ql3lX+BiXQtjG/CvXA64l2iK840YBeBiGmkSl025+GLS5
         NchbqHjVXRdYRoXrcl0ZGdXwGZyv0sulrLM47cNsWUuDZdePH8Owh8HfuJmnULeHlC+O
         kfTuRkbgKYPL3iR/NrX0WuyHqe+UKv7AGpOYocSIDe7itLXzbrB7crhu5jvbXgHP1EpC
         bqKW7+J955jH9MA0ko4Ux0f0tiUaJAdEuSB6SdQchrMCEy81g7Dxhwh7/JE/Wa2mS88H
         PWBw==
X-Gm-Message-State: AOAM531vfB1tLGEEfIszXXsSvRggTVsmqXiN+9y4KsmiQjPaWwTTNL9z
        m2Sew/pAhG4aIW0n4HWrZv6Hyak4DtrlLUZoa3c=
X-Google-Smtp-Source: ABdhPJzjcu0uB2vOfImOeBSfja/zssBiV/XFJFN1JMg+nzEymQEOBlObD2q1UCFcswMBiK/FlyCaFgkmbIy745fh/mU=
X-Received: by 2002:a9d:4d0e:: with SMTP id n14mr4154707otf.316.1616003433788;
 Wed, 17 Mar 2021 10:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.906.git.1615929435.gitgitgadget@gmail.com> <bfa0164cc3c167e383cdb5405526202432ae624e.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <bfa0164cc3c167e383cdb5405526202432ae624e.1615929436.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Mar 2021 10:50:22 -0700
Message-ID: <CABPp-BF=-2qD9YodpnhYP49EnKEV=MOFDMUnB-agd-d69jVeQA@mail.gmail.com>
Subject: Re: [PATCH 06/27] checkout-index: ensure full index
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 16, 2021 at 2:17 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Before we iterate over all cache entries, ensure that the index is not
> sparse. This loop in checkout_all() might be safe to iterate over a
> sparse index, but let's put this protection here until it can be
> carefully tested.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/checkout-index.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
> index 023e49e271c2..ba31a036f193 100644
> --- a/builtin/checkout-index.c
> +++ b/builtin/checkout-index.c
> @@ -119,6 +119,7 @@ static void checkout_all(const char *prefix, int prefix_length)
>         int i, errs = 0;
>         struct cache_entry *last_ce = NULL;
>
> +       ensure_full_index(&the_index);
>         for (i = 0; i < active_nr ; i++) {
>                 struct cache_entry *ce = active_cache[i];
>                 if (ce_stage(ce) != checkout_stage

With the caveat in the commit message, this change looks okay, but
checkout-index may be buggy regardless of the presence of
ensure_full_index().  If ensure_full_index() really is needed here
because it needs to operate on all SKIP_WORKTREE paths and not just
leading directories, that's because it's writing all those
SKIP_WORKTREE entries to the working tree.  When it writes them to the
working tree, is it clearing the SKIP_WORKTREE bit?  If not, we're in
a bit of a pickle...

Might be nice to add a
/* TODO: audit if this is needed; if it is, we may have other bugs... */
or something like that.  But then again, perhaps you're considering
all uses of ensure_full_index() to be need-to-be-reaudited codepaths?
If so, and we determine we really do need one and want to keep it
indefinitely, will we mark those with a comment about why it's
considered correct?

I just want a way to know what still needs to be audited and what
doesn't without doing a lot of history spelunking...
