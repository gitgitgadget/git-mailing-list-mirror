Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACD4C433E6
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 21:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 767402222B
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 21:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394787AbhARVh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 16:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394775AbhARVhO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 16:37:14 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD18C061574
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 13:36:34 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id s2so19136382oij.2
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 13:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B/qJQG29Wp6Jgr2IIGlvHdvraIqypiywOQZXqcpkCEY=;
        b=etxnm35XilvvQVgJV2OfjNe1ypIScoAa6nqV9iTJnWDbVm3XGokVMyKwt7KG6Ka2ol
         W4lKTEbEJel4m8FucaIQxOoFZHw2vqWlRrzGkOqfIhzno/BHiUPQcolX4TLnikqAQff/
         uWC2ON92ckNQpKn5N5hm0hsX9F69SLKoUjJs8XjcqeAqy5ppAoCv9t6xKVQo9pJILgk4
         GU+sYLjgR8/KTvtQTdXJE4zH/mccup0gwXGOL1AfTr0hgKQu7I6kU1Mv1Bpf3uFl+ji4
         OnhkBiDx3gVpKeS2hkp7LeMjHgG6rClSLId/xgkXdvCRym7nzBoe4o58Uk7MQTgb+ajh
         ihgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/qJQG29Wp6Jgr2IIGlvHdvraIqypiywOQZXqcpkCEY=;
        b=Bn68QR+UNibGY80zgYxfjHDecgF1EPS7Ep8VxNbqICmT956sArBjMSXNRN44nQPsYV
         18yX0mRlchiZNA3R8oFHG+wA01DpANhhPKqY2n0Hus/nSlWLW0iEDngnRY3HdgstpS1B
         bIp3Tg4VOo8IQ9DI3wSEJVrh/ZezXKP4rBm19hdKvxXE4zaRqkiLU6qZUIAp4TAsjEpH
         jqqxU4rnGLw/dtOX/la0bIDz5LMSVGgALwwX3X1AZjpHpSKrCoK/eyY03J32et5/ZOp/
         2O/LpEZ9tY6NQ874UsxXEZ2uFUNWj1k4Eq9z2mo6UsUiK0JnoL0yQo+s2eu/h6GB9f98
         K4fw==
X-Gm-Message-State: AOAM530olkp5YGYVkWiJx0UBqG9SNPdWWkurH2zTBMLCG5UN4utR9uCL
        wQyEGO44SLcWkxV6s3WB7ye5hdYWKA1KHQFNu2M=
X-Google-Smtp-Source: ABdhPJzJdxRmAXefzfMmXUfKEMDrZqAuPrQFISApA5lv12Tif6aLCfbTPuAcmF8CAS2xJb2xteooP62wvm8L4KXB9Vs=
X-Received: by 2002:aca:cf03:: with SMTP id f3mr778253oig.39.1611005793695;
 Mon, 18 Jan 2021 13:36:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
 <pull.835.v2.git.1610055365.gitgitgadget@gmail.com> <f6efa4350d621cd955965e13329f15f4d1b91bb4.1610055365.git.gitgitgadget@gmail.com>
 <YAX3BdzYLyudD325@nand.local>
In-Reply-To: <YAX3BdzYLyudD325@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 18 Jan 2021 13:36:22 -0800
Message-ID: <CABPp-BEO0q_2R6ncZgx-Z=DKJXsPgui921HTU=_=jnhoYbgwtg@mail.gmail.com>
Subject: Re: [PATCH v2 08/17] merge-ort: implement handle_directory_level_conflicts()
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 18, 2021 at 1:00 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Thu, Jan 07, 2021 at 09:35:56PM +0000, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > This is modelled on the version of handle_directory_level_conflicts()
> > from merge-recursive.c, but is massively simplified due to the following
> > factors:
> >   * strmap API provides simplifications over using direct hashamp

Whoops, should be "hashmap"

> >   * we have a dirs_removed field in struct rename_info that we have an
> >     easy way to populate from collect_merge_info(); this was already
> >     used in compute_rename_counts() and thus we do not need to check
> >     for condition #2.
> >   * The removal of condition #2 by handling it earlier in the code also
> >     obviates the need to check for condition #3 -- if both sides renamed
> >     a directory, meaning that the directory no longer exists on either
> >     side, then neither side could have added any new files to that
> >     directory, and thus there are no files whose locations we need to
> >     move due to such a directory rename.
> >
> > In fact, the same logic that makes condition #3 irrelevant means
> > condition #1 is also irrelevant so we could drop this function.
> > However, it is cheap to check if both sides rename the same directory,
> > and doing so can save future computation.  So, simply remove any
> > directories that both sides renamed from the list of directory renames.
>
> Beautiful.
>
> >  static void handle_directory_level_conflicts(struct merge_options *opt)
> >  {
> > -     die("Not yet implemented!");
> > +     struct hashmap_iter iter;
> > +     struct strmap_entry *entry;
> > +     struct string_list duplicated = STRING_LIST_INIT_NODUP;
> > +     struct strmap *side1_dir_renames = &opt->priv->renames.dir_renames[1];
> > +     struct strmap *side2_dir_renames = &opt->priv->renames.dir_renames[2];
>
> Obviously saying "1" or "MERGE_SIDE1" are two ways of saying the same
> thing, but perhaps the latter is more easily grep-able? Dunno.
>
> > +     int i;
> > +
> > +     strmap_for_each_entry(side1_dir_renames, &iter, entry) {
> > +             if (strmap_contains(side2_dir_renames, entry->key))
> > +                     string_list_append(&duplicated, entry->key);
> > +     }
> > +
> > +     for (i=0; i<duplicated.nr; ++i) {
>
> One small nit: this spacing and prefixed ++ reads a little oddly to me.
> Perhaps:
>
>   for (i = 0; i < duplicated.nr; i++) {
>
> ?

Sure, will fix.

>
> > +             strmap_remove(side1_dir_renames, duplicated.items[i].string, 0);
> > +             strmap_remove(side2_dir_renames, duplicated.items[i].string, 0);
> > +     }
> > +     string_list_clear(&duplicated, 0);
>
> And this looks like a faithful implementation of what you described
> above. Thanks.
>
> Thanks,
> Taylor
