Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F92C43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 23:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184F620714
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 23:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="e021ez+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgCYXP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:15:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44397 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbgCYXP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 19:15:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so4411150lji.11
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 16:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iWqpBGYkRzW7EOjSXlWEXJe/T+ANchr80iXR8IUBL18=;
        b=e021ez+icXBsE3kdV6hBwOnpSZXFHcwiZ+WNcGJ4BYq8moGWB01WmzuZqbus73j5aX
         0f/ZrrZJbnw1BDTODxG1dJo/8SlsVMtJqPWxQlZXdJVyhqvxdlWLxZ/jyeJ9XDRogSXz
         Rgwj51QIOCR/ZLY87oejp5aQJhl2BJU2Xbiatqgo0uxnlwUSRxDs1N9s1lQ/6fBVSXOg
         442u32NkFf+UwQeBhTlIw1CXBsfYWEvBNva4nJpmc4dUPNgY3YYegSUuA1i7RXul1EGS
         Lo09uvF+XZ6KOvjd/hxaE0Fr2qFJtOlMd9K8bcHpr2wP4UJ8N6rpe+kHkk5lyu74BGlW
         nuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iWqpBGYkRzW7EOjSXlWEXJe/T+ANchr80iXR8IUBL18=;
        b=LpTsYymIG7uDvSfy/Jf2bN/ki5C/a4hYokc9YEvVoDsUb4rd+JnhSde5HKwJcL7UQz
         DrKGdASQkpSHnjl8mKqmwA+6INDahmVIYfkeVLifTW2j7g8UpfWPmRJ0Llr06Te0DTTV
         205aGtW48G7F3ugXL8lKAb52Ey4nPq+spyJoD9HDtaookNv2MvvrbchrYvczVIbTBnwg
         5IQpESmPEGs8DVuRRbVWM/VBbcpmhUCdW87llmu6AVoaMFzrLFw7UkLwgD9wFTtxQRbQ
         5GPoZlaRx6opFjH00TlTHUU4tDxLepG9yTLTJVdnqiMDBiVBHkI74EniLbnuMevTGnXG
         DOqA==
X-Gm-Message-State: ANhLgQ2+L5QyVf0+HBdrwAJTamEBEX8bxJKclTmjRPsj3LmIJJxC8fhL
        mPzRTihPtaWTF4LH+WiU8jmchsczaV53HuXAhZiNesvjP/I=
X-Google-Smtp-Source: APiQypJKkPu9z22O2eGjzfYNNB2l5Vf+f/5jvK2xpcufPkEelBmk+3gxQ1GPxNheuxqWTltlTKXbwwJ3sqLuP+GMOgY=
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr3407441ljp.116.1585178154370;
 Wed, 25 Mar 2020 16:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585027716.git.matheus.bernardino@usp.br>
 <a76242ecfa69cf29995bd859305dc2ab1bc1a221.1585027716.git.matheus.bernardino@usp.br>
 <CABPp-BEbNCYk0pCuEDQ_ViB2=varJPBsVODxNvJs0EVRyBqjBg@mail.gmail.com>
In-Reply-To: <CABPp-BEbNCYk0pCuEDQ_ViB2=varJPBsVODxNvJs0EVRyBqjBg@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 25 Mar 2020 20:15:42 -0300
Message-ID: <CAHd-oW6ANf_iNmYkgXt4jo1seB-AEx1TSH384v+oh1bicG8RDA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] grep: add option to ignore sparsity patterns
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 24, 2020 at 4:55 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Mar 23, 2020 at 11:13 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
>
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> >
> > Note: I still have to make --ignore-sparsity be able to work together
> > with --untracked. Unfortunatelly, this won't be as simple because the
> > codeflow taken by --untracked goes to grep_directory() which just
> > iterates the working tree, without looking the index entries. So I will
> > have to either: make --untracked use grep_cache(), and grep the
> > untracked files later; or try matching the working tree paths against
> > the sparsity patterns, without looking for the skip_worktree bit in
> > the index (as I mentioned in the previous patch's comments). Any
> > preferences regarding these two approaches? (or other suggestions?)
>
> Hmm.  So, 'tracked' in git is the idea that we are keeping information
> about specific files.  'sparse-checkout' is the idea that we have a
> subset of those that we can work with without materializing all the
> other tracked files; it's clearly a subset of the realm of 'tracked'.
> 'untracked' is about getting everything outside the set of 'tracked'
> files, which to me means it is clearly outside the set of sparsity
> paths too (and thus you could take --untracked as implying
> --ignore-sparsity, though whether you do might not matter in practice
> because of the items I'll discuss next). Of course, I am also
> assuming `--untracked` is incompatible with --cached or specifying
> revisions or trees (based on it's definiton of "In addition to
> searching in the tracked files in the *working tree*, search also in
> untracked files." -- emphasis added.)

Hm, I see the point now, but I'm still a little confused: The "in the
working tree" section of the definition would exclude non checked out
files, right? However, git-grep's description says "Look for specified
patterns in the tracked files *in the work tree*", and it still
searches non checked out files (loading them from the cache, even when
--cache is not given). I know that's exactly what we are trying to
change with this patchset, but we will still give the
--ignore-sparsity option to allow the old behavior when needed (unless
we prohibit using --ignore-sparsity without --cached or $REV). I guess
my doubt is whether the problem is in the implementation of the
working tree grep, which considers non checked out files, or in the
docs, which say "tracked files *in the work tree*".

I tend to go with the latter, since using `git grep --ignore-sparsity`
in a sparse checked out working tree, to grep not present files as
well, kind of makes sense to me. And if the problem is indeed in the
docs, then I think we should also allow --ignore-sparsity when
grepping with --untracked, since it's an analogous case.

> If the incompatibility of
> --untracked and --cached/REVSIONS/TREES is not enforced, we may want
> to look into erroring out if they are given together.  Once we do, we
> don't have to worry about grep_cache() at all in the case of
> --untracked and shouldn't.  Files with the skip_worktree bit won't
> exist in the working directory, and thus won't be searched (this is
> what makes --untracked imply --ignore-sparsity not really matter).
>
> In short: With --untracked you are grepping ALL (non-ignored) files in
> the working directory -- either because they are both tracked and in
> the sparsity paths (anything tracked that isn't in the sparsity paths
> has the skip_worktree bit and thus isn't present), or because it is an
> untracked file.  [And this may be what grep_directory() already does.]
>
> Does that make sense?

It does, and thanks for a very detailed explanation. But as I
mentioned before, I'm a little uncertain about --untracked implying
--ignore-spasity. The commit that added --untracked (0a93fb8) says:

"grep --untracked" would find the specified patterns from files in
untracked files in addition to its usual behaviour of finding them in
the tracked files

So, in my mind, it feels like --untracked wasn't meant to limit the
search to "all non-ignored files in the working directory", but to add
untracked files to the search (which could also contain tracked but
non checked out files). Wouldn't the "all non-ignored files in the
working directory" case be the use of --no-index?

> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index 52ec72a036..17eae3edd6 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
...
> >
> > @@ -487,7 +492,7 @@ static int grep_cache(struct grep_opt *opt,
> >         for (nr = 0; nr < repo->index->cache_nr; nr++) {
> >                 const struct cache_entry *ce = repo->index->cache[nr];
> >
> > -               if (ce_skip_worktree(ce))
> > +               if (!ignore_sparsity && ce_skip_worktree(ce))
>
> Oh boy on the double negatives...maybe we want to rename this flag somehow?

Yeah, I also thought about that, but couldn't come up with a better
name myself... My alternatives were all too verbose.

...
> I'm super excited to see work in this area.  I hope I'm not
> discouraging you by attempting to provide what I think is the bigger
> picture I'd like us to work towards.

Not at all! :) Thanks a lot for the bigger picture and other
explanations. They help me understand the long-term goals and make
better decisions now.
