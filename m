Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBD8320A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 17:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeLJRXv (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 12:23:51 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45493 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeLJRXv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 12:23:51 -0500
Received: by mail-vk1-f196.google.com with SMTP id n126so2691649vke.12
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 09:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A39hBDW1TX9i4Vl8/r5QlvABP6yENUBYi8vdNwuDkGg=;
        b=PeWyWygxOBktnXez46oma2hFULEU51liSuGvidtFK1z1yB0XJ87gBm3Ny1LkG5SWtz
         pKcbE8yAQlR3d7KzcGBRCMt+9VIk7bc4WF1TcuXe4D7zDTR1dvydBQpKoEho+3kiossQ
         xgRiH0yjU4DXYcydZPHNeRtaAiXRoktOTz8I9oPRU0U+UrJkQ52HhTWoX69umJrZZi1t
         rrzUAZyP4UKrwHxWoT3BEY8+Xph9iqE/SaWOqIY8pBdNIe92qXbz9XFgiHaD6rabj3eR
         2+Ut12wchLmpchPZfO6MTEYJyM4HACPZmtvEjWC4/9RMo844GPqtUXZViGpKbZYcdmtD
         6Vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A39hBDW1TX9i4Vl8/r5QlvABP6yENUBYi8vdNwuDkGg=;
        b=otyiPAUnCrtxv4uHzGWu97Oc/wOkOFsZ2gjCCzNKdCLVMdVILnZJFydm0VQy3UV0MN
         Q9c1HI9M4zoEK6lFrOtv0mY0bLaw2H42g2l9jm62ZYAt6Yv+c1UygaOfy0xs6T4V3qKF
         kqffOApMHWBsfwrdyNDwLcqhB/YSJKpi2jxshuyBmtkqOX6ruhNM0PQJjJhU0iqRucRv
         U9HlZUxud2ruKb67B2A/33GX7CqKcw7cPFVS+bWWHu4V4LSL5ab/xv+NRqGrJ9/sYazU
         /oLrAXW4fd5f0KsDO+llg/SiBzH5IvAaEeBiVYeKmtQfzNa/NoC5E+3dGYTPvXUIHBVT
         tTdw==
X-Gm-Message-State: AA+aEWb1M1HUocLagtbEVy9FX1eQAc0qN+3N3hRGWkK9PNJefjAoCEVv
        HBPSLZXQYPOw7gWvk/j0KuNXNTfW9BBFJyCrJKk=
X-Google-Smtp-Source: AFSGD/VhPEA+GAzAghU5QPRvFBIYacIj1CfkEUGEt6oa2uHNOQMLYTRRmYdVSDEDNuYhcQPoUBefLznmh6GFrHN0Nw8=
X-Received: by 2002:a1f:97d1:: with SMTP id z200mr5521863vkd.15.1544462629552;
 Mon, 10 Dec 2018 09:23:49 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-3-t.gummerer@gmail.com>
 <CACsJy8AGerhjnT0O6vT264tND78N5cbgFREzYtdmriXERu0Jtw@mail.gmail.com>
In-Reply-To: <CACsJy8AGerhjnT0O6vT264tND78N5cbgFREzYtdmriXERu0Jtw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Dec 2018 09:23:38 -0800
Message-ID: <CABPp-BE15jfe76q3hqSxnifv8MNB1e6_GDT=5=ZmTE__XuTmLw@mail.gmail.com>
Subject: Re: [PATCH 2/8] entry: factor out unlink_entry function
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 7:50 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Sun, Dec 9, 2018 at 9:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > Factor out the 'unlink_entry()' function from unpack-trees.c to
> > entry.c.  It will be used in other places as well in subsequent
> > steps.
> >
> > As it's no longer a static function, also move the documentation to
> > the header file to make it more discoverable.

I also started using unlink_entry() in another place in a local patch
series that I haven't submitted yet (and which I need to get back to
at some point).  So this will help me too.  :-)

> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  cache.h        |  5 +++++
> >  entry.c        | 15 +++++++++++++++
> >  unpack-trees.c | 19 -------------------
> >  3 files changed, 20 insertions(+), 19 deletions(-)
> >
> > diff --git a/cache.h b/cache.h
> > index ca36b44ee0..c1c953e810 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -1542,6 +1542,11 @@ struct checkout {
> >  extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
> >  extern void enable_delayed_checkout(struct checkout *state);
> >  extern int finish_delayed_checkout(struct checkout *state);
> > +/*
> > + * Unlink the last component and schedule the leading directories for
> > + * removal, such that empty directories get removed.
> > + */
> > +extern void unlink_entry(const struct cache_entry *ce);
>
> I'm torn. We try to remove 'extern' but I can see you may want to add
> it here to be consistent with others. And removing extern even from
> functions from entry.c only would cause some conflicts.
>
> I wonder if we should move the 'removal' variable in symlinks to
> 'struct checkout' to reduce another global variable. But I guess
> that's the problem for another day. It's not the focus of this series.

"move the 'removal' variable in symlinks"?  I'm having a really hard
time parsing that phrase and the sentence it's embedded in.  Could you
reword for me Duy?
