Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1E361F462
	for <e@80x24.org>; Fri, 26 Jul 2019 23:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfGZXjR (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 19:39:17 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45180 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfGZXjR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 19:39:17 -0400
Received: by mail-vs1-f67.google.com with SMTP id h28so37183170vsl.12
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 16:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sY656UtviHOO2NhwM2BZNrvWDgRlV+wlP4u7s5sitWM=;
        b=uo0yxod1Xfl8kCTSvmxGVg1y8szliGLhWVLN63A8B/reVUrf6U6D7m7VZPmVSksoQd
         Dqy/QyZNZAjjRRGqF2JLPjwSBH+41bKy0NQ7koStXB3PAU47SXjQucV2q70mjwB2x781
         pDZ2SgCWLaFd4jBcPVuz9hWBahAKURPGmcU5fSvkifddym7ABe9TecD//nvvjfCkWt/V
         TbuZ/tO//6/ngOEDkEu4AZ0sBH4F3lgIcopHmS1TjhpzP2jQ5v/mpM5u7i+pzU7eZFR7
         d932mT0N2w2xx0S1PWpPY3DmKFUSMOVqV425+pQLacioR1+ZQVMHn5wd49ZkI4CQhUvj
         HiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sY656UtviHOO2NhwM2BZNrvWDgRlV+wlP4u7s5sitWM=;
        b=Qv9rKGjMt/SAyKKIxKi84JnFg6irGURVK2+UAHj9yhjivslti4dBZOUli3RWM5fycT
         7qwLbt96ecCkDagZO97uXQc1FgUdP7CSIFxfnx7soonrEyKy6TI1xvlk/TiZlHgwabpf
         Roeik7vcIRU9DVMaQHpWHMdsnBO0bRxjRpcl4dWTwDxg0wpSxpO7s+r1/nGtRANXrh5u
         NYL0jQgkTDr/nwAEZ7swBh3sMOBaV1dVSO9HDmkb3tn7p+qe2anhV/yWmii5h5oXpIQE
         xmjJabI0lqU0AecfDc+OO3Xz1n3J+yBlTn6huYcLsl8Ob+UcX9rm/dUWEX2qpixrFkVZ
         Yrjw==
X-Gm-Message-State: APjAAAUFt7SgebHb3ez8Qeu7dLid+3EHBOIYXwfcVyfuawg/RFcCywLO
        O7bxe20PR+Hvj8HW7Xxxy6kdlBw9ZGyITCoZZPIUwQ==
X-Google-Smtp-Source: APXvYqxTpuJ7MfeJ388OimBX9T/ct6ypox7+lTBxLyA+WxvuHQMRRVzoWfJ2uHW4Lr7aTDP93jQTAsL42hdqCSzkgbY=
X-Received: by 2002:a67:300f:: with SMTP id w15mr57451331vsw.116.1564184356758;
 Fri, 26 Jul 2019 16:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190725174611.14802-1-newren@gmail.com> <20190726155258.28561-1-newren@gmail.com>
 <20190726155258.28561-8-newren@gmail.com> <xmqqy30kmu8r.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy30kmu8r.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Jul 2019 16:39:05 -0700
Message-ID: <CABPp-BExLuH9mz6sgjTbKXg44zmT3PcRsy+A8s-9PAQuxDuXfw@mail.gmail.com>
Subject: Re: [PATCH v2 07/20] Use write_index_as_tree() in lieu of write_tree_from_memory()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 26, 2019 at 1:11 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > diff --git a/cache-tree.c b/cache-tree.c
> > index 706ffcf188..99144b1704 100644
> > --- a/cache-tree.c
> > +++ b/cache-tree.c
> > @@ -613,14 +613,19 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
> >       int entries, was_valid;
> >       struct lock_file lock_file = LOCK_INIT;
> >       int ret = 0;
> > +     int access_disk = !(flags & WRITE_TREE_FROM_MEMORY);
>
> Shouldn't we go one step futher and make the bulk of in-core index
> processing into a new helper function, while making
> write_index_as_tree() a thin-wrapper around it, i.e.
>
>         write_index_as_tree()
>         {
>                 lock the index for update;
>                 read the on-disk index;
>                 call that new helper function to write a tree;
>                 update the on-disk index;
>         }
>
> and reuse the helper from
> merge-recursive.c::write_tree_from_memory() while keeping the call
> to the latter in merge_trees_internal()?  Wouldn't that approach
> let you do this without adding an extra flag bit?

I thought about that briefly yesterday, but the fact that the
write_locked_index() call only happens if !cache_tree_fully_valid()
meant refactoring slightly more to get the helper to also return that
boolean value, and since I was a little unsure of myself with
cache-tree stuff in general I wanted to propose what looked like the
minimally invasive changes first (by which I mean smallest patch).
I'll take a closer look at this path.

> Also, there used to be a check to ensure that the in-core index fed
> to write_tree_from_memory() is fully merged and otherwise dump the
> unmerged entries with BUG().  Can we simply lose it?  I know you
> return with "error building trees" from merge_trees_internal() but
> it does not BUG().

I thought about that yesterday and decided, "Nah, it's a developer
only debug message used during development.  I've _never_ seen anyone
report those messages, and I only saw them when I was making bad
changes during development when I first started a decade ago."  Then
Emily posts a report today showing that exact BUG message being hit
with git-2.22.0, and how she wouldn't have been able to get all that
extra information in her analysis without that bit of information
being reported.

So, yeah, I need to put something from those BUG() messages back in;
they clearly helped with that issue, and might help again in the
future.
