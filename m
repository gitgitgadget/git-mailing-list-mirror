Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEA0C433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 15:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 856E560295
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 15:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhCOP2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 11:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhCOP2A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 11:28:00 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C82C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 08:28:00 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso5313230oti.11
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 08:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lv7x0ASFa8WL4whQjayieWOuQyfTinravIDey6CxqMI=;
        b=fJIvaaMgnTxM7x2H148RLgHNHqGk0RBT30giJ3J6dCiM1oIcAgrPBRBCyj8sf778c6
         dllEZrPhwyGZqCrAc5YDrmdeZztRWBsijMHZhlpKwKIqdU8CgeIfiS5tvLI4w4LDODy1
         8jaNCxR0TPasAa32ST6lXZiIBW8SU2HGHjdtRavfXpLvrcsmVvePXn2MbbBPz2iO0AcK
         htbvsgKn0NaK2QF1Xvx3e5/dEGEwblaHT2IAiSxHM6kJ6XCtdC5izS0UZQeNiUXyDqzy
         nXJ9WKJ0W744Ea39nO4lowXnGIufLDR0QJm7PSBp/VZ2JzcWH00pFzWPn2Bu1SUfHkVz
         CoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lv7x0ASFa8WL4whQjayieWOuQyfTinravIDey6CxqMI=;
        b=ILfHW47CEBc/KrS+d/t8Tty+rPd/dU797YaxJsZDXuR6qEwrJcRchR+P12OIxUzY0M
         SpfAuC0kIOUi2/E/gUgl91ut26PsmhzTPKZECFF8p/GafBJA2JhLpNsIWADxzzj0hpo3
         VEhbx9qDQqrYTMr0dUJnQBXbmx0jLyg4ZUn1xPh7/4Y4LCTUG6WRRGfjY5QGy7Ua0+yT
         M1OUz+cJy86DZt4tGJecWLsNMtVanl5jM2S+7v/Zg7xmlddUqYOA8lEJHGzqCaxRZfLT
         Uu+zYDKbGoWGbqbuSQWRBXQ5+pycpyDRQMazMDKamtP7r/jey+qN8o4njLh5AZsv9+uP
         spIA==
X-Gm-Message-State: AOAM530bf+hNzYfzevpSuXvF8USsgxXOYsGrZBJPLVj4MOuEE7y6knWj
        1z8g3hMvOFo8J7phmNTxZKshpVAmuIqDfdimtxY3Kiv2JYO7BA==
X-Google-Smtp-Source: ABdhPJyLi1dtFoZUR0ESEndrLBkkAMMJsD7Ut3U07iOcg2Ol2NfHQ3Ckfo8mlB15W0GqIwZ+ExldhSIYE8Y5e04Ypuk=
X-Received: by 2002:a9d:4d0e:: with SMTP id n14mr14423284otf.316.1615822079519;
 Mon, 15 Mar 2021 08:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.853.git.1615674128.gitgitgadget@gmail.com>
 <05850cb49823ea9c6d6c7cfd3b4adbbc1c47abc6.1615674128.git.gitgitgadget@gmail.com>
 <baca2700-0959-c4ca-6ba9-ceb5188f96f4@gmail.com>
In-Reply-To: <baca2700-0959-c4ca-6ba9-ceb5188f96f4@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 Mar 2021 08:27:48 -0700
Message-ID: <CABPp-BHLL_u_E-Ss=AYWUZM+_9hbC6D6WzRjxEUwmexTEgQ2zw@mail.gmail.com>
Subject: Re: [PATCH 3/8] merge-ort: record the reason that we want a rename
 for a directory
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 7:31 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/13/2021 5:22 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > When one side of history renames a directory, and the other side of
> > history added files to the old directory, directory rename detection is
> > used to warn about the location of the added files so the user can
> > move them to the old directory or keep them with the new one.
> >
> > This sets up three different types of directories:
> >   * directories that had new files added to them
> >   * directories underneath a directory that had new files added to them
> >   * directories where no new files were added to it or any leading path
> >
> > Save this information in dirs_removed; the next several commits will
> > make use of this information.
> ...
> > +/* dir_rename_relevance: the reason we want rename information for a dir */
> > +enum dir_rename_relevance {
> > +     NOT_RELEVANT = 0,
> > +     RELEVANT_FOR_ANCESTOR = 1,
> > +     RELEVANT_FOR_SELF = 2
> > +};
>
> Is this potentially a flag list? It's hard to tell because we don't
> have another item (3 or 4?).
>
> >               unsigned sides = (0x07 - dirmask)/2;
> > +             unsigned relevance = (renames->dir_rename_mask == 0x07) ?
> > +                                     RELEVANT_FOR_ANCESTOR : NOT_RELEVANT;
> > +             /*
> > +              * Record relevance of this directory.  However, note that
> > +              * when collect_merge_info_callback() recurses into this
> > +              * directory and calls collect_rename_info() on paths
> > +              * within that directory, if we find a path that was added
> > +              * to this directory on the other side of history, we will
> > +              * upgrade this value to RELEVANT_FOR_SELF; see below.
> > +              */
>
> This comment seems to imply that RELEVANT_FOR_SELF is "more important"
> than RELEVANT_FOR_ANCESTOR, so the value will just be changed (not a
> flag).

Yes.

> > +     /*
> > +      * Here's the block that potentially upgrades to RELEVANT_FOR_SELF.
> > +      * When we run across a file added to a directory.  In such a case,
> > +      * find the directory of the file and upgrade its relevance.
> > +      */
> > +     if (renames->dir_rename_mask == 0x07 &&
> > +         (filemask == 2 || filemask == 4)) {
> > +             /*
> > +              * Need directory rename for parent directory on other side
> > +              * of history from added file.  Thus
> > +              *    side = (~filemask & 0x06) >> 1
> > +              * or
> > +              *    side = 3 - (filemask/2).
> > +              */
> > +             unsigned side = 3 - (filemask >> 1);
> > +             strintmap_set(&renames->dirs_removed[side], dirname,
> > +                           RELEVANT_FOR_SELF);
>
> Yes, using "RELEVANT_FOR_SELF" here, not "relevance | RELEVANT_FOR_SELF".
> OK. This should make the later consumers simpler.

Yep, indeed.  Would it make it clearer earlier if I were to stop
assigning the explicit values in the enum?  Would adding a comment
when I introduce the enum be easier?  Or was it just "thinking out
loud"?
