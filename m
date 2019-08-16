Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB0E31F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 19:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfHPT0T (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 15:26:19 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:43378 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfHPT0T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 15:26:19 -0400
Received: by mail-vs1-f53.google.com with SMTP id s5so4382318vsi.10
        for <git@vger.kernel.org>; Fri, 16 Aug 2019 12:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EL46JBReJnaXFr25YCgMGW4NOiY5Ao2wO4gWVxMyCy0=;
        b=PqWGPBLVZgGTrfUjzHzlObwhGf9L8sQqxRVdFR6ZHFx5wcxrc5Vf96TA094ue+8Hz4
         xKMCJ3jrYUgp1Xl4e6CVaLWl5aFNWzOrApb2npNmRlunk8sEIVvW9y0iTyWbVJo4pi2a
         r5t52j7WOeiZun2Ln+KcabDcg3s0Pq4SLyTXdNEfDq3KjJlUBS9GEEaQsvBYm7GM0yRV
         DOaC95c3bLwv4zztsGix3pXfKENuqX6A2ggltnWWdhwyTMn11/YaSYgxVJvHd8ysU/4e
         pN+rrDvZUPfyGg5We17bokUKi0Tq2+SskUD5PzJlGprrXodAx6RrQgFSi7T/HsuHqjt0
         DM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EL46JBReJnaXFr25YCgMGW4NOiY5Ao2wO4gWVxMyCy0=;
        b=dQTv/wo3a8lBJ0mnGHhvuPkDaHJul/Zy9kjxH6cn/z7DqsGkcBMzO0u5XwF1G/3f3M
         oIc2RMGDGUPcnjv/mLKjONrvxA8xiyrJgN8CcOSoHEJG/QyrbUFnfBzWG0ZEF5I5MSqs
         OWMX2Xee7kk8HyOTo1b/nWibfl/zkMY9KKAqoVD0HUrZOB5LFjyLzb2lSmzdZ3BHgzv9
         EbIkE3pxjIuCElMmZ70Zyo7tojc6WIEJRDfbeD98nT0O4crsKzS7mVzi+2QbJra/eq7u
         Rp0rW+pHo6slL1GlJMl3/iWIRqv209azCs6qg9QtS9aSehQ3ULyiTbG2CzqtC1ahtABH
         LhcA==
X-Gm-Message-State: APjAAAVDntBowvpvIWNJgfFA12ntQ2JRC89666nQE7vAaDPiY1pdEdhD
        j+ATEFunNJtQPt9N2Y1+WoDddCabUmftYQm/3I4=
X-Google-Smtp-Source: APXvYqwDtCuGUJa6nKez8I0UChEASM/xOgTnJ5dqUM66ZSKvQ/E3vWx2T7BJQzdEM04NxfcOhZJWEVqv3HExg3+GkpI=
X-Received: by 2002:a67:fd13:: with SMTP id f19mr7193257vsr.53.1565983578169;
 Fri, 16 Aug 2019 12:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190815220303.17209-1-newren@gmail.com> <xmqqh86h12au.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh86h12au.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 16 Aug 2019 12:26:06 -0700
Message-ID: <CABPp-BF_PdzOvsgUQUtQRgiQe1qQ_O9Pn2rbpwJ095e7VA2xKA@mail.gmail.com>
Subject: Re: BUG?: xdl_merge surprisingly does not recognize content conflict
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 16, 2019 at 9:51 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Now, a manual merge of these files gives no conflicts, which surprises me:
> >
> >   $ git merge-file ours base theirs; echo $?
> >   0
>
> Indeed that is surprising.
>
> > -- 8< --
> > Subject: checkout: remove duplicate code
> >
> > Both commit a7256debd4b6 ("checkout.txt: note about losing staged
> > changes with --merge", 2019-03-19) from nd/checkout-m-doc-update and
> > commit 6eff409e8a76 ("checkout: prevent losing staged changes with
> > --merge", 2019-03-22) from nd/checkout-m were included in git.git
> > despite the fact that the latter was meant to be v2 of the former.
> > The merge of these two topics resulted in a redundant chunk of code;
> > remove it.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
>
> The latter half that you remove cannot be reached, because the first
> half would have already died after checking the same condition, so
> we were doing the same repo-index-has-changes check twice when there
> is no change; in other words, we were lucky that this accidental dup
> did not cause any real damange.

Yes, but I am wondering if there are other cases we just don't know
about yet and for which we did not get lucky.

I dug a little further and found that even the first version of `git
merge-file` that Dscho added to git in 2006 also exhibited the same
behavior.  Since he was basically making a minimal replacement for RCS
merge, I tried out /usr/bin/merge from the rcs package and found it
has the same behavior.  I then downloaded the oldest tarball on the
GNU ftp site I could find for rcs (5.7 from June 1995) and found that
its' merge command had the same behavior.

I'm not sure if that alarms me (not only have all versions of git
potentially been mis-merging things, but all versions of rcs, cvs, and
probably any other version control system out there in current use),
or comforts me ("hey, it's been around for at least 24 years so it
must only mis-merge things in both rare and innocuous ways or else
someone would have noticed it decades ago")

I'm leaning towards "It can't be that bad; I'll look at it again later
if someone else who knows xdiff better hasn't already solved it"
