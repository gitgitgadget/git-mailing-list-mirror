Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E20C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631666109E
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbhGOQCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239415AbhGOQCT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 12:02:19 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348E3C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:59:26 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id e1-20020a9d63c10000b02904b8b87ecc43so6683369otl.4
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6M/YIbrKMges8uOb6tpr2tDBgwdhtEtadarWrE+J/1Q=;
        b=csKmPCMtyErtW1iFLCyw9BjWr2WVdLRs8niIWGYL7pGHMULIjyXJtd8HWGoHSq5zCu
         ufb80iSm+ZDMcj3U6qdzaFua8oqbXWpwaER7Mqs+JCZbNRF/IP6ZFOPodtpDZv4a41t1
         s2mcQuz5SSblK7pV+XWzlcy8QQR7udV4QvFTH/B+c2BiVXOeJDlA/koNgTLrwT3QobfS
         XlVwKgDEvOlu/IJFxkKCt7UuE7w/xBrjrJrWShvKIVzt7Dcb2Ti9LMBYQXWbUVaEy4jP
         BD9+pIuk5YATOSKZd+UGelQg29uAXQC2cvcokMGIEffEh+UF7a+iUddpACjRJnEjRzHt
         MqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6M/YIbrKMges8uOb6tpr2tDBgwdhtEtadarWrE+J/1Q=;
        b=LrkoWBxJ8gj+W9pOuPvW9Rfu+YYorYA7Lb0a3uDxmOe2OxOUK7WXwbRhQvlPq4wgov
         iCD1cBv7zneWmjerxfdSq3q6ZrzYS4PVDvneWlx3Udkab558s0D0pc0cXw3sUVRqICz8
         eORaD0/JHe/kisvVqrAdzYLH/oedFsuLW2PrOhY6lcgWiRshQsngPxgNGGu3cK/D6CVt
         5BJHFWzk/Z2f/mMrV3D8OvGthgoyfb3YPGx0BI9gktdOTxJx1pomueaX50hn+qGcJnRk
         yTBP0INAJHtDi6r9LbBCumE0yt1j2PS2+lF41inM5oD1Yob6Nrt1ylDDC0QWbaSd3Lku
         BxKg==
X-Gm-Message-State: AOAM533O381ZObADyTiTBLlLPNCiMrO2X1OUoHOqaikL8knzfy4Uw1ME
        crMWRMRrhFImqwuHPAgGo2UqE95TDrXWTfdQgOo=
X-Google-Smtp-Source: ABdhPJz4OOte1QibZ6xL24zoOe/7eu6gpPWBE+I1hrV+IixfXokAXvp2TljCdm5rp88OX89gGIXtKeyNxcZpfOH4Qtw=
X-Received: by 2002:a05:6830:1d73:: with SMTP id l19mr4257525oti.316.1626364765627;
 Thu, 15 Jul 2021 08:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
 <pull.988.v2.git.1626204784.gitgitgadget@gmail.com> <7e28323b624ad2d8d12123783f00f5a8fbb248e8.1626204784.git.gitgitgadget@gmail.com>
 <4aa2f487-ad4b-b7fc-2ee0-b78c3703d955@gmail.com>
In-Reply-To: <4aa2f487-ad4b-b7fc-2ee0-b78c3703d955@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 15 Jul 2021 08:59:14 -0700
Message-ID: <CABPp-BGmNOGjSkJTGE7EFLv0oemzBA8kgSw_4EDjBjT+8V6oeA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] merge-ort: add a handle_deferred_entries() helper function
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 15, 2021 at 7:32 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 7/13/2021 3:33 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > In order to allow trivial directory resolution, we first need to be able
> > to gather more information to determine if the optimization is safe.  To
> > enable that, we need a way of deferring the recursion into the directory
> > until a later time.  Naturally, deferring the entry into a subtree means
> > that we need some function that will later recurse into the subdirectory
> > exactly the same way that collect_merge_info_callback() would have done.
> >
> > Add a helper function that does this.  For now this function is not used
> > but a subsequent commit will change that.  Future commits will also make
> > the function sometimes resolve directories instead of traversing inside.
> ...> +MAYBE_UNUSED
> > +static int handle_deferred_entries(struct merge_options *opt,
> > +                                struct traverse_info *info)
> > +{
> > +     struct rename_info *renames = &opt->priv->renames;
> > +     struct hashmap_iter iter;
> > +     struct strmap_entry *entry;
> > +     int side, ret = 0;
> > +
> > +     for (side = MERGE_SIDE1; side <= MERGE_SIDE2; side++) {
> > +             renames->trivial_merges_okay[side] = 0;
>
> We are unconditionally setting this to zero? I will await the
> use of the method to see how that affects things.

Unconditionally set to 0 because at this point in the series we don't
yet have the logic to handle it.  This line will be replaced later
once we add the necessary logic.

>
> > +             strintmap_for_each_entry(&renames->possible_trivial_merges[side],
> > +                                      &iter, entry) {
>
> The rest of this loop seems like standard logic for handling
> these tree walks.
>
> Thanks,
> -Stolee
