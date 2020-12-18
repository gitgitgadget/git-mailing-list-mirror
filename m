Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D41C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 22:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D4A323B98
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 22:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgLRWNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 17:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgLRWNi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 17:13:38 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A45C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 14:12:58 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id d20so3411974otl.3
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 14:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WQRPFz7U6ZEOYe8Ny30kmaBzf+3UcpVzzJtCtkdFRCQ=;
        b=t9JUUzOzsRzbEVvJH52JFvqVFNW9bxeCMI7n6J3I8bL5WOwYHqnQmfdPPg0qiZ9ADc
         9KDh6qi5SmWqKezQvSf52UfZkHDKzKWWOUx5ZFPw4oAahBLlHFDuVA+ifZM8Uii/vFOI
         z37OJkDaQNgxHsR8W3FS9+Yqot2wntFAgKJwX32BwnJJi353SZS8B0pXMoYnoiDQBUmD
         H0OFyFIdXmHRQkUw4f0Td56p/Ibd18m1EkEeKJ9UIb1p+qMLYSSjIGsB006kqATjjzPl
         Yg6kXe1z7PLrIclaWQixGtLNu3D7HH4nFcfqp2/0ZtVWmq/RB0SeLRhwI0AyOd5j6IdC
         dF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WQRPFz7U6ZEOYe8Ny30kmaBzf+3UcpVzzJtCtkdFRCQ=;
        b=n4imz0GT47TDcprIr3xxg2rRTemCk2hrvVSsWLss5d9VojsSJFnAsNl/Lwct/zA9w7
         4tECYWuW9DksNVlSMuSEi3YztK/guzrcFPrh8lIT9ac78/Kj4icWa09gnnGFowkPJnP2
         4BVGkTnodxI2EOteHlgB5bjdgfb1Y9RUul4yMQ9IO3p4qWj7diXxsNFd1baAMsjqLyOY
         I/TKxLvu1DwoVyYjtk2DoYdt6oosh52wCxNDcrQo6sVDqI7/tTvZDfC04eMKAXwW+yMN
         YyRSNUJikCNVxPe60IjTGZFXft2pR2a7LqrwaI3KiljOxDwq2pd/IcwYPBRjGmQJf02t
         +JWw==
X-Gm-Message-State: AOAM5325K0ONRMvCckosI69dbAuMABHLE4PrJzNbL9DLK+ifD6lj3N7H
        iX6Yft99k7X9iephiI0gDNfjNGEuGMpgzw+Nqn8=
X-Google-Smtp-Source: ABdhPJx49WGUAb2R2BK3KpBTV3lZXY2GfbSEoRTuZ/VlVyhsWOgIiXNeXY9aPixTN432mDQTqzFe4XKbU4dT1L1BaO0=
X-Received: by 2002:a05:6830:1610:: with SMTP id g16mr4383634otr.345.1608329577979;
 Fri, 18 Dec 2020 14:12:57 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201216184929.3924-1-sorganov@gmail.com>
 <20201216184929.3924-25-sorganov@gmail.com> <CABPp-BHh4VSTQ=VOzik5H34OcJaQ63wSgPgrZqJ5-_XvBSow+g@mail.gmail.com>
 <875z4zciwd.fsf@osv.gnss.ru> <CABPp-BGg9oBkG3ZaWztKMnQE4sREOK_L3so5fer5hbiAKxMaHg@mail.gmail.com>
 <87tusi7pq4.fsf@osv.gnss.ru>
In-Reply-To: <87tusi7pq4.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 18 Dec 2020 14:12:46 -0800
Message-ID: <CABPp-BG-Nv=pzwTO3J0OK20gFVV67_qFL+m-cL7d9xrMvTjH-Q@mail.gmail.com>
Subject: Re: [PATCH v2 24/33] diff-merges: handle imply -p on -c/--cc logic
 for log.c
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 18, 2020 at 1:45 PM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Fri, Dec 18, 2020 at 6:01 AM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> Elijah Newren <newren@gmail.com> writes:
> >>
> >> > On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
> >> >>
> >> >> Move logic that handles implying -p on -c/--cc from
> >> >> log_setup_revisions_tweak() to diff_merges_setup_revs(), where it
> >> >> belongs.
> >> >
> >> > A very minor point, but I'd probably drop the "where it belongs";
> >> > while I think the new place makes sense for it, it reads to me like
> >> > you're either relying on a consensus to move it or implying there was
> >> > a mistake to not put it here previously, neither of which makes sense.
> >>
> >> Well, it was meant to be an excuse for not moving it there earlier in
> >> the patch series indeed. I just overlooked this piece of code that
> >> logically belongs to the diff-merges module. I think you need to
> >> consider the state of the sources right before this patch to see the
> >> point of phrasing it like this.
> >>
> >> That said, I'm fine removing this either.
> >
> > If it should have been moved there earlier, then you should amend the
> > relevant previous commit instead of making a new one.  rebase -i is
> > your friend and should be used, especially with long patch series.
> > :-)
>
> This is to be a separate commit anyway. I can move the commit itself
> more closer to the beginning, but I don't see how it'd make things
> any better.
>
> By "earlier" above I mostly meant that I should have noticed and moved
> it in the first issue or the patch series.

Even if keeping the commit as-is, moving it earlier would have one benefit...

> >
> >> > Much more importantly, this patch doesn't do what you said in
> >> > discussions on the previous round.  It'd be helpful if the commit
> >> > message called out that you are just moving the logic for now and that
> >> > a subsequent patch will tweak the logic to only trigger this for
> >> > -c/--cc and not for --diff-merges=.* flags.
> >>
> >> I believe this patch is useful by itself, even without any future
> >> improvements (that we actually discussed), if any, so I don't see the
> >> point in describing what this patch doesn't do.
> >>
> >> OTOH, the commit message seems to be clear enough to expect this patch
> >> to be pure refactoring, without any functional changes, no?
> >
> > I'm just pointing out that reading the patch triggers a "wait, you
> > said you wanted to enable diffs for merges without diffs for regular
> > commits" reaction and makes reviewers start diving into the code to
> > check if they missed where that happened.  Sometimes they'll even
> > respond to the commit asking about it...and then read a later patch
> > and find the answer.  Perhaps I'm more attuned to this, because I've
> > done this to reviewers a number of times and they have asked me to add
> > a note in the earlier commit message to make it easier for other
> > reviewers to follow and read the series.  You don't need to describe
> > in full detail the subsequent changes that will come, just highlight
> > that they are coming to give reviewers an aid.  For example, this
> > could be as simple as:
> >
> > """
> > Move logic that handles implying -p on -c/--cc from
> > log_setup_revisions_tweak() to diff_merges_setup_revs().  A
> > subsequent commit will tweak this logic further.
> > """
>
> I think I see what you mean, but I still don't like this, sorry, as:
>
> First, this commit doesn't tweak the logic at all, so "further" doesn't
> sound right.

Good point, I should have left off "further".

> Second, the purpose of this move is not to have subsequent commits that
> will tweak this logic further in any particular way. One of the aims of
> this commit is rather to make it more simple to have /any/ further
> tweaks to the logic.
>
> Third, if the "tweak" you mention is not accepted, I'd need not to only
> get rid of the tweaking commit, but not to forget to edit the
> description of this one, that is basically unrelated?

...so, one advantage of moving this commit earlier in the series is
that if it appears before the introduction of --diff-merges, then it
doesn't trigger the "What?  I thought we weren't making the
diff-merges flags trigger patches for non-merge commits" reaction, and
thus makes it clearer that the patch is just pure refactoring.

> >
> > (Note that 'git log --grep=subsequent' in git.git will find you
> > several examples of where people have done this kind of thing.)
>
> Yeah, I agree it's useful when commits are tightly coupled and thus the
> purpose of single commit is unclear. I just don't think this one is such
> a case.

I think where it appears in the series makes its purpose unclear.
