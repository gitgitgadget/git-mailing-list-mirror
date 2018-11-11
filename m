Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEC181F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 08:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbeKKSIW (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 13:08:22 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:41033 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbeKKSIW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 13:08:22 -0500
Received: by mail-vk1-f194.google.com with SMTP id t127so1329534vke.8
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 00:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xFVtz+gXn+tVZ1WIzu63FsuMpc1/oFQSXnZC+QWnqRE=;
        b=DmsGriwMSQefmJ8Ob72zNEl3XhQGoZoOCKtA0ErOZlQuXe5WFSMN3jVey5D/HS7LL+
         agz9ukKnkZreQ0NiuaTuuoOyb6YsLiSMJKLqsnND3DfAGpujXsgTV84BbXi14BZVQXQ9
         jLgniqihZK67sIMEgLvqVLGLwcTdcYRzs95Nn7rjq+IkjIslHn3+rgrRiTA3XD+7xvYP
         I7zIylE2mRKserQgVInRyQDAkDyK3o1PvU2lPf3bZiaL3Wvcj5sXwYoJtLgS/NWykL5F
         hvl8BMaGfoHn54gFO4dY1qyJelq+/WfRem873+LfGRtULOWcgZ1mL0p7/I/RrDvkj8mv
         oVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xFVtz+gXn+tVZ1WIzu63FsuMpc1/oFQSXnZC+QWnqRE=;
        b=Rj9wSCG4EOSrA27virfgDFuhMZrfy9Ud6suR+4Kihblca9yXsnfxO9XFr/0w0GSzS1
         wdY8PpVXL9Uc1sdHYKO5BYO+vaK1yt/7bc4CYy2c8QvNppXFsKEI59sGWrxuR2H8CDdu
         yT3PkC73ixK6m8r6AmMs8EvP7bhlV6WAM2fZiTKTeRiqKEyV6r50pEW0YRN/5KWFc4BE
         HNLsHSIhnTA/8KIW8vUPHopfPii0xZBwmn/be8tDPAXEppVkBXkhwTMJKJHN1fg6XDgM
         I+4/LG3Yck7l4HBrbqvB8dlQA/9er25cKkoEuQKIimv/KbmBnbEWQTcAkSpadPeesXF5
         vDjw==
X-Gm-Message-State: AGRZ1gJzZxS/3UDmQWZx1e3N01HNkRU167oRUi6vD4yFmrHt0rnbeYCK
        xwCNQ+4oT/iWjpzjzo7gtr5bsr4FhlR+BN5WaVQ=
X-Google-Smtp-Source: AJdET5eThZPDFbKUjWV20Vl/hHf1VNPFlZ1VkhFHQg3QNf5YAbPUXcGCg918hzP4TkBHV1w5AYvZiXUfjVacmpcbFng=
X-Received: by 2002:a1f:a451:: with SMTP id n78mr6533865vke.37.1541924427648;
 Sun, 11 Nov 2018 00:20:27 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com> <20181111062312.16342-8-newren@gmail.com>
 <20181111070240.GG30850@sigill.intra.peff.net>
In-Reply-To: <20181111070240.GG30850@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Sun, 11 Nov 2018 00:20:16 -0800
Message-ID: <CABPp-BGQNsZYKYuaBcY7Umr=u0qzF5gXWFT3yGjLdzAz2ZGs+w@mail.gmail.com>
Subject: Re: [PATCH 07/10] fast-export: ensure we export requested refs
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 10, 2018 at 11:02 PM Jeff King <peff@peff.net> wrote:
>
> On Sat, Nov 10, 2018 at 10:23:09PM -0800, Elijah Newren wrote:
>
> > If file paths are specified to fast-export and a ref points to a commit
> > that does not touch any of the relevant paths, then that ref would
> > sometimes fail to be exported.  (This depends on whether any ancestors
> > of the commit which do touch the relevant paths would be exported with
> > that same ref name or a different ref name.)  To avoid this problem,
> > put *all* specified refs into extra_refs to start, and then as we export
> > each commit, remove the refname used in the 'commit $REFNAME' directive
> > from extra_refs.  Then, in handle_tags_and_duplicates() we know which
> > refs actually do need a manual reset directive in order to be included.
> >
> > This means that we do need some special handling for excluded refs; e.g.
> > if someone runs
> >    git fast-export ^master master
> > then they've asked for master to be exported, but they have also asked
> > for the commit which master points to and all of its history to be
> > excluded.  That logically means ref deletion.  Previously, such refs
> > were just silently omitted from being exported despite having been
> > explicitly requested for export.
>
> Hmm. Reading this it makes sense to me, but I remember from discussion
> long ago that there were a lot of funny corner cases around "which refs
> to include" and possibly even some ambiguous cases. Maybe that is all
> sorted these days, with --refspec.

Oh yeah, there definitely were some funny corner cases around "which
refs to include" (though I don't think --refspec affects this, either
before or after my patch.)  Before this commit, fast-export would
often emit unnecessary reset directives at the end, AND fail to export
some other refs that had been explicitly requested for export.  It had
some simple logic to attempt to cover the cases, but it was just
wrong.  As far as I can tell, this patch fixes all of those.

...well, almost all.  We still fail on tags of tags of commits (or
higher level nestings), but that's a multi-pronged issue that feels
like a different beast. (We rewrite tags of tags of commits to just be
tags of commits, even without any special request from the user
somewhat contrary to otherwise requiring --signed-tags and
--tag-of-filtered-object options.  As far as I can tell, this isn't
documented for fast-export but I saw somewhere in the filter-branch
docs where it said it does this kind of thing on purpose.  However, to
make it even weirder, if the user requests
--tag-of-filtered-object=rewrite instead of the default of "abort"
then we actually abort on tags-of-tags-of-commits instead of
rewriting.  I don't think it was intentional, but
tags-of-tags-of-commits inverts the meaning of the
--tag-of-filtered-object={rewrite vs. abort} flag -- it's very weird).
I put more time into attempting to fix the nested tags issue than I
feel like it was worth.  git.git is the only repo I know of that seems
to have such tags, so I just gave up on them for now.

> > ---
> > NOTE: I was hoping the strmap API proposal would materialize, but I either
> > missed it or it hasn't shown up.  The usage of string_list in this patch
> > would be better replaced by what Peff suggested.
>
> You didn't miss it. Junio did some manual conversions using hashmap,
> which weren't too bad.  It's not entirely clear to me how often we'd be
> able to use strmap instead of a full-on hashmap, so I haven't really
> pursued it.
>
> It looks like you generate the list here via append, and then sort at
> the end. That's at least not quadratic. I think the string_list_remove()
> is, though.

I think it would have been useful in multiple places in
merge-recursive.c, in addition to here.  Maybe that just means I need
to add strmap to my list of things to do.
