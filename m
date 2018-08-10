Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB0051F404
	for <e@80x24.org>; Fri, 10 Aug 2018 16:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbeHJTKE (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:10:04 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42232 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbeHJTKD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:10:03 -0400
Received: by mail-io0-f196.google.com with SMTP id n18-v6so8149323ioa.9
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YPow6CaCpz36v+VaQT3D5YOufvLaKninPoFk0lvCElk=;
        b=M0YlttaWPS5FMosU8KavShzXZ232X1wgCHgIn4V6mmLX/L3VPt9JiDTNsEnCsWodah
         PGDOD7Y+Mpxk/dQzMszzTXjjOjdb6bWEJByo++/wxWf0CHVDqWYJsP6dBoL2Y0wXdzW0
         YYEs67jKWpewxQu4hEv6Tjl1Lq4djNz12CYnf87hY9fcT4Ex6nCR1eOmeRibkl4l9zY8
         KHI+GQzJUE1FUqOpNNktZo3i7/IhzjoEhipOiA7TA3yVlvQ7P2y7pF0dlFBucG5YuEvz
         apCBiKRID3vTgAO+81Y9y9iJ9SsuGddY3OpQBBHaoTkhjcXyocXu8C7NIirdXWddiyeD
         xnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YPow6CaCpz36v+VaQT3D5YOufvLaKninPoFk0lvCElk=;
        b=BE30pM2R27tKpzvhoxVkIPIJ9hENXwz1xz0EAfJTNCUo1c3MNKurYd6U4nB7XZHDad
         mjpfP95tsT+xJvSQyWFa7UXYHNMJgng+KNojTS4z+8a9S5P5f1OyY2W2WXw6aRs13ac2
         2pyV3Rjqp+LQc84K8FIbJzitUOwXG15k4SDIVvRnxuPpAz3/L9FuHwiiH5IAXgaYl0Ul
         w5pZxTAWExZYKBoipgHCLbU/58xv9YR2zPdJI+gzoZEOT2csgNL6qz6mJXRR92MY8lfL
         IRAJaka0TUi9t2DIZ2l9O5rzRqwRVSjlDY/yE4s9VEgJhLO0LCKqcDt3Oa9vuixPjthY
         MMaQ==
X-Gm-Message-State: AOUpUlG1qQ/MjmkjxjcGPiP2XtWaO2bp1SRklmajiqM3/TRsJgJ8iY0y
        bYPTfEpCdPlqua1vM4/IAJRso0Uihq5TQdlcIGI=
X-Google-Smtp-Source: AA+uWPzHRIG2u5KVU7N/4o2jIXIEPC0OOGMLjT52+nZicQ27lECD0/pocrEEfpI8NhF/4zLlKtttWsRZW6M9BY9TSfI=
X-Received: by 2002:a6b:8f4b:: with SMTP id r72-v6mr6002673iod.118.1533919167585;
 Fri, 10 Aug 2018 09:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180727154241.GA21288@duynguyen.home> <20180729103306.16403-1-pclouds@gmail.com>
 <20180729103306.16403-5-pclouds@gmail.com> <CABPp-BGF+GZjm-DiveLjFOESKwPz2F0Y7X4_kXyem2xFo2odUw@mail.gmail.com>
In-Reply-To: <CABPp-BGF+GZjm-DiveLjFOESKwPz2F0Y7X4_kXyem2xFo2odUw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 10 Aug 2018 18:39:01 +0200
Message-ID: <CACsJy8DF5XLf-RF3SwTpRynYALJUPO_VTK=fpx1oabwB80ZpPw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] unpack-trees: cheaper index update when walking by cache-tree
To:     Elijah Newren <newren@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 8, 2018 at 8:46 PM Elijah Newren <newren@gmail.com> wrote:
> > @@ -701,6 +702,24 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
> >         if (!o->merge)
> >                 BUG("We need cache-tree to do this optimization");
> >
> > +       /*
> > +        * Try to keep add_index_entry() as fast as possible since
> > +        * we're going to do a lot of them.
> > +        *
> > +        * Skipping verify_path() should totally be safe because these
> > +        * paths are from the source index, which must have been
> > +        * verified.
> > +        *
> > +        * Skipping D/F and cache-tree validation checks is trickier
> > +        * because it assumes what n-merge code would do when all
> > +        * trees and the index are the same. We probably could just
> > +        * optimize those code instead (e.g. we don't invalidate that
> > +        * many cache-tree, but the searching for them is very
> > +        * expensive).
> > +        */
> > +       o->extra_add_index_flags = ADD_CACHE_SKIP_DFCHECK;
> > +       o->extra_add_index_flags |= ADD_CACHE_SKIP_VERIFY_PATH;
> > +
>
> In sum of this whole patch, you notice that the Nway_merge functions
> are still a bit of a bottleneck, but you know you have a special case
> where you want them to put an entry in the index that matches what is
> already there, so you try to set some extra flags to short-circuit
> part of their logic and get to what you know is the correct result.
>
> This seems a little scary to me.  I think it's probably safe as long
> as o->fn is one of {oneway_merge, twoway_merge, threeway_merge,
> bind_merge} (the cases you have in mind and which the current code
> uses), but the caller isn't limited to those.  Right now in
> diff-lib.c, there's a caller that has their own function, oneway_diff.
> More could be added in the future.
>
> If we're going to go this route, I think we should first check that
> o->fn is one of those known safe functions.  And if we're going that
> route, the comments I bring up on patch 2 about possibly avoiding
> call_unpack_fn() altogether might even obviate this patch while
> speeding things up more.

Yes I do need to check o->fn. I might have to think more about
avoiding call_unpack_fn(). Even if we avoid it though, we still go
through add_index_entry() and suffer the same checks every time unless
we do somethine like this (but then of course it's safer because
you're doing it in a specific x-way merge, not generic code like
this).

> > @@ -1561,6 +1581,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
> >                 if (!ret) {
> >                         if (!o->result.cache_tree)
> >                                 o->result.cache_tree = cache_tree();
> > +                       /*
> > +                        * TODO: Walk o.src_index->cache_tree, quickly check
> > +                        * if o->result.cache has the exact same content for
> > +                        * any valid cache-tree in o.src_index, then we can
> > +                        * just copy the cache-tree over instead of hashing a
> > +                        * new tree object.
> > +                        */
>
> Interesting.  I really don't know how cache_tree works...but if we
> avoided calling call_unpack_fn, and thus left the original index entry
> in place instead of replacing it with an equal one, would that as a
> side effect speed up the cache_tree_valid/cache_tree_update calls for
> us?  Or is there still work here?

Naah. Notice that we don't care at all about the source's cache-tree
when we update o->result one (and we never ever do anything about
o->result's cache-tree during the merge). Whether you invalidate or
not, o->result's cache-tree is always empty and you still have to
recreate all cache-tree in o->result. You essentially play full cost
of "git write-tree" here if I'm not mistaken.
-- 
Duy
