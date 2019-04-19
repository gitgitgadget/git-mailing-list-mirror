Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DB5720248
	for <e@80x24.org>; Fri, 19 Apr 2019 01:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfDSBdg (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 21:33:36 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39958 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfDSBdg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 21:33:36 -0400
Received: by mail-it1-f196.google.com with SMTP id k64so6226423itb.5
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 18:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hu5LpjvKoT4N58ixqfVTlvNm6dBOzQ3qNLjJyBCD7u8=;
        b=tO5cPMMWUK/cXxCACnQyIEG1g56H+Dg1OYdaqX0BI9J/8qJg6GFEUevpZbOXs5Pdxv
         QsVXwM3AdZyd7fKa6STpxw1CGYJ9fFAE93SUAwWQCfoAlgJvd11JBovDipHttsw974ok
         HzTf/eK24cfH7Lbu/zAi1Rp3nfo1xRNXrfo6iZy+xvoEoxljI5GaCvjdbj84WjT9Dec8
         MEoTy2T1gJmyII5KufmDhP29EbiLR/Fi0RTK1uwVi6jLqZi7T1dkC9XiqfWszOsU9I96
         cyOQhiQ4s5B9QMcuImh6er1klzNFn+8qeCJq0p8Bs0Scgl/MBP438RC7E/ucgtVGADk1
         uPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hu5LpjvKoT4N58ixqfVTlvNm6dBOzQ3qNLjJyBCD7u8=;
        b=VkwwXa8x4j7fg+nS7kCafbd0yXihgtE1DRZt04qOZ3J/cZdXVbFDy8S0FnLxpiuC0d
         L7MXK4BMWedWz26b1Q1UZ9evTXFOibp06F5zRZreJ60Ez1r3rz/sOLGiwkcGGrmAuscS
         UQLS6aXdMZyeBa7PHzp40qgfjsbQds8QyhbLImn3dEgcz0aFFi+mcxLWksrJ1t9Un2yN
         wmIujsZ23gyupVwudy3V5GVJAMB7r3ddZgyWI3GLpHtQX0+TWrejrAEl6ILrEeVBbcEB
         UTZ+tCiOJvwL9/cOh/a4Fvh2Yn4BelzEdYRYKVla4tYordCH1IgnEyfWNCQjxS9Ondgi
         v9cA==
X-Gm-Message-State: APjAAAVr0EUyQmDrSZSXwc4mBO//nOWb25ekhk5Z+OjKVna46SirlVqX
        //q/sfseDY1IKH4f4BFWNGpN10pPtqjoE2O1L2z6CCAm
X-Google-Smtp-Source: APXvYqwJV/Nys2lnhJGClghSkeKqooqyNYDHcEeNK5Pw/Hx+3NAwgPDqCEEZxhOyc2SfAUhhex3aFD1yZCMI7GY/OiM=
X-Received: by 2002:a24:4d8a:: with SMTP id l132mr968265itb.70.1555637615913;
 Thu, 18 Apr 2019 18:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <CACsJy8BygpTQg5=8+2KkFCpaJBEkKx+ocVZoa0yRBAQvnkXVSw@mail.gmail.com>
 <20190418183000.78138-1-jonathantanmy@google.com> <20190418184205.GA12260@sigill.intra.peff.net>
In-Reply-To: <20190418184205.GA12260@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 19 Apr 2019 08:33:09 +0700
Message-ID: <CACsJy8C9TDK8OT89FxVAobMtdHMNMih+hevnCetMpo2M9bSsDw@mail.gmail.com>
Subject: Re: [PATCH] worktree: update is_bare heuristics
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Mike Rappazzo <rappazzo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 19, 2019 at 1:42 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, Apr 18, 2019 at 11:30:00AM -0700, Jonathan Tan wrote:
>
> > > >         strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
> > > > -       is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
> > > > -       if (is_bare)
> > > > +       if (!strbuf_strip_suffix(&worktree_path, "/.git"))
> > > >                 strbuf_strip_suffix(&worktree_path, "/.");
> > >
> > > We can just call these two calls unconditionally, right? No harm done
> > > if we don't strip.
> >
> > We can, and no harm done. But this if/then pattern is also repeated in
> > other parts of the file (e.g. get_linked_worktree()) so I'll leave it in
> > for consistency. (Also, for what it's worth, it's slightly faster if
> > only one strip is done.)
>
> I also think your version expresses the intent more clearly. We expect
> to see one or the other, but not "foo/./.git". And so (just as the code
> prior to your patch) we would not convert that to "foo".
>
> I am not sure of exactly what the "/." is trying to accomplish, so maybe
> that double-strip _would_ be desirable, but if so it is definitely
> worthy of its own commit explaining why that is so.
>
> Interestingly, the case in get_linked_worktree() makes a lot more sense
> because it has added "." as an absolute path itself, and is just
> cleaning up the results of its strbuf_add_absolute_path()[1]. Which
> makes me wonder if the "/." stripping in get_main_worktree() is actually
> cargo-culted and simply unnecessary.

Yeah. It's added the same time get_linked_worktree() adds absolute
paths and trims "/." in 5193490442 (worktree: add a function to get
worktree details - 2015-10-08). Maybe it's because he wasn't sure if
get_git_common_dir() could return ".", which makes it exactly the same
as get_linked_worktree(). It's probably very unlikely that
git_git_common_dir() could return ".", but I can't be sure either.
-- 
Duy
