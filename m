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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC71C433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C3822262
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgL3Tqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 14:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgL3Tqa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 14:46:30 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3735DC061573
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:45:50 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id j21so3903608oou.11
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wr5A08arAONKR3l+yJzL+o9L1puOP35ITS0+xp8jYVg=;
        b=evxnJE0MGo1Esv/N4CMDyXDU74leiH6ojTfvCr3Cz8+8w1iBxH3h56AdiZ6qJf+G4G
         ulwo+IGdD7DPmYZ2siA1+2YrNbB8z5xOELJsrf26PAsDDCWRuPFEOmsyvUzygA8jwdD1
         JOf/93m42xQ3AYDX0c8ygktUw/Eq+S2a++F3xE1efQWBPTYgfm+IWhjnu7fcrC0tpPs2
         cgfiQ6KR33lsN6KL8686AP4fPPH0VAx8OL//aeJQEZqGDPv20cznjYz4MOuI3PbS9DyM
         YSiM7EH7JFRQCXwhtgzfHG0mIM7MjfXpKzDADZME97nV0cgRf0i7NUHoYmi7ryzaxA9M
         qB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wr5A08arAONKR3l+yJzL+o9L1puOP35ITS0+xp8jYVg=;
        b=kJNV0nmbRutSXfn+sCFmt23In5NyUmwzG24p/vcSBKLOldK93ELah5acTLT6BuRInV
         vo18oG50Bu8I8NBGdBwB+RaHAVhZT43aoli8Ophdfd0T0m6K+PyQffsGqesDQQabHM0p
         tnZpqlhfbMjv7Ui7tApqAAN8KFjEhrcFpJ2anDK34IAzPwPNMCVOpL6wIaJxcf69jkbR
         h5mkyLTTkzmNZb5J3vDTjBkefuwBt3ZR8ykZt90UwZJ7A5NZWxCvBh/h3c1M5sxW+Nyh
         B/zwhAI13EwyGvaMa4167JMwBtRlHzNod3DDUZH90d8sv73jhJRYugVa1EZBueHgFvfJ
         xnJg==
X-Gm-Message-State: AOAM533TlQDFguDNKAetK5zkaZ+yQ8ctHNZRjAjSyO5D9jzg8a4EzEpf
        FwOEkjOd7Cxpg0ZPrfqFK7s37I0GQK/lumnnb2VDQpTX
X-Google-Smtp-Source: ABdhPJyr1KItTocj6ldOnerTUl6tWhf9Srtyu8b3rnxsO4hsB4TeD21R/zGFvUCuviMIoQWhhud6mPylP3KhEERDZzU=
X-Received: by 2002:a4a:ea5a:: with SMTP id j26mr27238501ooe.45.1609357549590;
 Wed, 30 Dec 2020 11:45:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.829.git.1609356413.gitgitgadget@gmail.com> <6923e6211aaa9e1e144db747c971c6fe35fb4d41.1609356413.git.gitgitgadget@gmail.com>
In-Reply-To: <6923e6211aaa9e1e144db747c971c6fe35fb4d41.1609356413.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 30 Dec 2020 11:45:38 -0800
Message-ID: <CABPp-BGrTcr2q10ppuEML3N1imV_PMm8zzB5SGTQPFWtyUUzEA@mail.gmail.com>
Subject: Re: [PATCH 2/8] unpack-trees: add trace2 regions
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 30, 2020 at 11:26 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The unpack_trees() method is quite complicated and its performance can
> change dramatically depending on how it is used. We already have some
> performance tracing regions, but they have not been updated to the
> trace2 API. Do so now.

Somewhat of a curious side comment: Any idea at what scale the perf
issues show up?  Or are you still digging into that?

> We already have trace2 regions in unpack_trees.c:clear_ce_flags(), which
> uses a linear scan through the index without recursing into trees.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  unpack-trees.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 02f484604ac..7dbd006ac56 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1579,6 +1579,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>                 die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
>
>         trace_performance_enter();
> +       trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
> +
>         if (!core_apply_sparse_checkout || !o->update)
>                 o->skip_sparse_checkout = 1;
>         if (!o->skip_sparse_checkout && !o->pl) {
> @@ -1652,7 +1654,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>                 }
>
>                 trace_performance_enter();
> +               trace2_region_enter("unpack_trees", "traverse_trees", the_repository);
>                 ret = traverse_trees(o->src_index, len, t, &info);
> +               trace2_region_leave("unpack_trees", "traverse_trees", the_repository);
>                 trace_performance_leave("traverse_trees");
>                 if (ret < 0)
>                         goto return_failed;
> @@ -1740,6 +1744,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  done:
>         if (free_pattern_list)
>                 clear_pattern_list(&pl);
> +       trace2_region_leave("unpack_trees", "unpack_trees", the_repository);
>         trace_performance_leave("unpack_trees");
>         return ret;
>
> --
> gitgitgadget

Seems simple and straightforward, and I like having more trace2
measurements since I used it so much in merge-ort.
