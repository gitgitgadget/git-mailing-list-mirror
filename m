Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FCBD20248
	for <e@80x24.org>; Mon, 18 Mar 2019 09:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfCRJZH (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 05:25:07 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51388 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfCRJZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 05:25:07 -0400
Received: by mail-it1-f193.google.com with SMTP id e24so19373564itl.1
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 02:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fP0/p+zlxpHwFe0Hvy0DjSUwCl7GUjbCXUwzbv84MZo=;
        b=ZrA+E7EP59Z009qO6PrlgDOQHuu66dYXsDdUG31oDNQqZC3u69plSmyD6q1grUn0Ew
         6R731qE7XM/gvtuPEyKEW3V+XNtM+JxQ0YigZhhAmDFZ72FLeCYobXhyih8EoBnoLTl5
         shb3wWHgpNNRbhoRfkKWCD+OGb2NNSlTnjb/oI5bSSJSAGxVTXJgdkCoc7dst8+Os9z0
         iXxmDDhFF/PgXUJhEndjMO7dI96FwhnD2AVtVd7kEnjNJdiF0I3v+azj35k74QB+4bCe
         9CQ75a9cY/C7C1LzCJK+VBAEVC+mJBe2jrAiue66wekYEioym4hVfln7lILO5UKin6rm
         Agkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fP0/p+zlxpHwFe0Hvy0DjSUwCl7GUjbCXUwzbv84MZo=;
        b=CmUFyTWNJB0vHbXRtBqduWNsaEiayTJHXV0IOfJ7pblHxz07r2mm73nR8Gza3HsYUi
         95hWkhDdDeVkwi9JwNC8sLHg5trEq69EhXEFpUE1R0LiqtEtkQsKTwp+SCCukNzanrd9
         ZndrdA17N2BbEpgiO9Fm/8YJczr+IIfjfIuJLAeniGrEVluv0VYVCyBYKV26emgWh7aB
         iRKmn7ZmA5sK9tpuoZJDJh63A+eqVnGuUD7gCye6smls4T5hE4PgVCEDRk8XAGQu6Qgd
         +p0pf6On5HXT6FpFlBI2z2Qz7Y1qRSHk7a4jYnUveYaR8TXp5oH5q+Wg2S2P3HM7aHxN
         SZIA==
X-Gm-Message-State: APjAAAWjsh1iVZbWQL0DNfCKvXsTs4ASBnQ+K74gcmtq/d2QOdm7aUWV
        WNo/sprvLKskadT/qvikBvRifrCwqHG8HcbOmqo=
X-Google-Smtp-Source: APXvYqyWYcZMy1WiiqeTlnnsIh3RQmkRY55pHWyco6gm5b2X8i3hnAWWISbXvNU/liKweCn96/1VDrRbSqrBBUTL/x0=
X-Received: by 2002:a24:7542:: with SMTP id y63mr9915466itc.70.1552901106896;
 Mon, 18 Mar 2019 02:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <20190317060023.3651-1-pclouds@gmail.com> <xmqqh8c06dgq.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh8c06dgq.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 18 Mar 2019 16:24:40 +0700
Message-ID: <CACsJy8CdS1oHt__SzgOxnoD=0h=iN51SWm3YjkOwYGkbzb4o9A@mail.gmail.com>
Subject: Re: [PATCH] unpack-trees: fix oneway_merge accidentally carry over
 stage index
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 10:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > One-way merge is supposed to take stat info from the index and
> > everything else from the given tree. This implies stage 0 because trees
> > can't have non-zero stages. The add_entry(.., old, ...) call however
> > will keep stage index from the index.
> >
> > This is normally not a problem if the entry from the index is
> > normal (stage #0). But if there is a conflict, we'll get stage #1 entry
> > as "old" and it gets recorded in the final index. Fix it by clearing
> > stage mask.
> >
> > This bug probably comes from b5b425074e (git-read-tree: make one-way
> > merge also honor the "update" flag, 2005-06-07). Before this commit, we
> > may create the final ("dst") index entry from the one in index, but we
> > do clear CE_STAGEMASK.
>
> Wow, good find.  That's an old one.

Credit goes to Phillip for such attention to detail. If I tested this,
I would have stopped after seeing conflict stages collapsed into one
and missed the stage index. In fact I was swearing "what the hell did
he complain about" when looking at his test script's result, until I
realized stage #1 was indeed wrong.

> >
> >  t/t2026-checkout-force.sh (new +x) | 26 ++++++++++++++++++++++++++
>
> This makes it cumbersome to have the same fix in the maintenance track
> as t2026 is already in use over there.  Do we need an entirely new test
> just to house this new single test?

I could not find any right file to put it in. I guess I could stick it
in t2023-checkout-m.sh

> > +test_expect_success 'force checking out a conflict' '
> > +     echo a >a &&
> > +     git add a &&
> > +     git commit -ama &&
> > +     A_OBJ=3D$(git rev-parse :a) &&
> > +     git branch topic &&
> > +     echo b >a &&
> > +     git commit -amb &&
> > +     B_OBJ=3D$(git rev-parse :a) &&
> > +     git checkout topic &&
> > +     echo c >a &&
> > +     C_OBJ=3D$(git hash-object a) &&
> > +     git checkout -m master &&
> > +     test_cmp_rev :1:a $A_OBJ &&
> > +     test_cmp_rev :2:a $B_OBJ &&
> > +     test_cmp_rev :3:a $C_OBJ &&
> > +     git checkout -f topic &&
> > +     test_cmp_rev :a $A_OBJ
>
> So in short, "checkout -f" should have given us an entry for path
> "a", taken from the tip of the 'topic' branch, at stage #0 while
> switching to that branch, but it didn't?  That would be a nice
> summary to have at the beginning of the log message before going
> into the implementation detail of how that happens.

OK. And the last line probably should be :0:a to make it clear we're
looking for stage #0.
--=20
Duy
