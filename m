Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F0AC43460
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 02:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE3B461450
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 02:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbhDVCZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 22:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhDVCZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 22:25:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E7BC06138B
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 19:24:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h36so15589559lfv.7
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 19:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bjFcwHiAQyHh+YnpvDT8RRIOibEDJwvlr7oLmOw0dmU=;
        b=IkxbAFNaA4EUfPhNExWhlYn9PWvM/lwyPfd9AzfHdFMbbyLNlWCz/TcgE3G4lgByb2
         4n+dbnZMpnncc8onoGS632vri3HJSouGVxllAhUAPjyI/wNj6W7iph0h0yGFruYONBMY
         R370MLAjwnzTfWW3oTh6kp7bytv3VxXh2rbtNBsyHvroeJEzSPSCdll5W4iOTKNWY7hK
         JGhUKCXVrGH6O41rgruPCCWpVpc8b2XFSGg1awTFIaX3ee7rfXd0hnaOj3AIhQ16y89a
         o+KqyJ0kwSMYMTcOKQYui6O8TzS8w3qbc9WNViMrTeo9pbOUSMU9e61Ik5UtqnFBU5I/
         /lXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bjFcwHiAQyHh+YnpvDT8RRIOibEDJwvlr7oLmOw0dmU=;
        b=dDiTdcKIVcGz7QfUKSeNOAVCJ3xVN3c+5C4atI2mGIwZ8r+YUfX/onXt6cCzLzjiJo
         IQCRN7y47Z/iLvjfJM6Nt+204Oa562NYaOk5DTACL0iZR8V/HE8NfXyyPsCdPM2KZj0a
         00euZAX3ESsVuq3jlDbKvzDKo5imTqIGWgwwDdWUiJ1XqkA8aRADV9zHEediB177TDCr
         BQM7RvE1ouMYjrJLDjcvPGczlWvDsRF3omxvOmWgvvjVStRz//5E/c4mwGS4/ZUj9E4w
         XNp7KEXoLSat6rwnM3iq5sXgulf7KWWLAUucwn4m64QVqKtl+c6ei0h+eKbtIFFmcvmZ
         e9sQ==
X-Gm-Message-State: AOAM530P2yHW8CtmDGzxl8dyh8+0MRTFaRLTUOPPeFZD6xDrXIvXGAA+
        dO4VoRb6SVeJhVBaKGGTHA8u/DkPpgP5+tATKV65ZA==
X-Google-Smtp-Source: ABdhPJwnA6xPclF6haR879OHsTKTr4Ruc+F6KchZPAFKl2slf23FVo3nC2N1ydUctGc8mkeZtZzP1+FPofyXJwRbSBk=
X-Received: by 2002:ac2:5f64:: with SMTP id c4mr804973lfc.538.1619058278965;
 Wed, 21 Apr 2021 19:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <0a3892d2ec9e4acd4cba1c1d0390acc60dc6e50f.1618322497.git.gitgitgadget@gmail.com>
 <CABPp-BHcdhO_kEdqR23sDdGAgoSu2R-HBWv-RmzQvJ0ysWtzxg@mail.gmail.com>
 <a777331a-aff6-766f-30da-eef052ad83ee@gmail.com> <CABPp-BEdXOrDecGZBxmwdMvLBse80s3J+O34Bwz5dRRvFPgnUA@mail.gmail.com>
In-Reply-To: <CABPp-BEdXOrDecGZBxmwdMvLBse80s3J+O34Bwz5dRRvFPgnUA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 21 Apr 2021 23:24:27 -0300
Message-ID: <CAHd-oW4Ei3p9rG5z2DRJMVx2dc5B7LeimnoRvBOsStM42v+9HQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] unpack-trees: make sparse aware
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 1:11 PM Elijah Newren <newren@gmail.com> wrote:
>
> // Adding Matheus to cc due to the ignore_skip_worktree bit, given his
> experience and expertise with the checkout and unpack-trees code.
>
> On Wed, Apr 21, 2021 at 6:41 AM Derrick Stolee <stolee@gmail.com> wrote:
> >
> > On 4/20/2021 7:00 PM, Elijah Newren wrote:
> > > On Tue, Apr 13, 2021 at 7:01 AM Derrick Stolee via GitGitGadget
> > > <gitgitgadget@gmail.com> wrote:
> > >>
> > >> diff --git a/read-cache.c b/read-cache.c
> > >> index 29ffa9ac5db9..6308234b4838 100644
> > >> --- a/read-cache.c
> > >> +++ b/read-cache.c
> > >> @@ -1594,6 +1594,9 @@ int refresh_index(struct index_state *istate, unsigned int flags,
> > >>                 if (ignore_skip_worktree && ce_skip_worktree(ce))
> > >>                         continue;
> > >>
> > >> +               if (istate->sparse_index && S_ISSPARSEDIR(ce->ce_mode))
> > >> +                       continue;
> > >> +
> > >
> > > I'm a bit confused about what could trigger ce_skip_worktree(ce) &&
> > > !ignore_skip_worktree and why it'd be desirable to refresh
> > > skip-worktree entries.

The skip-worktree entries are not really refreshed in refresh_index(),
even when !ignore_skip_worktree (which is the default case; i.e.
without the REFRESH_IGNORE_SKIP_WORKTREE flag).

This flag (which is currently only used by `git add --refresh`s code
at `builtin/add.c:refresh()`), just makes refresh_index() skip the
following operations on skip-worktree entries: pathspec matching,
marking the matches on `seen`, checking/warning if unmerged, and
marking the entry as up-to-date (i.e. with the in-memory CE_UPTODATE
bit).

I added this flag in mt/add-rm-in-sparse-checkout and changed
`builtin/add.c:refresh()` to use it mainly because we needed a `seen`
array with only matches from non-skip-worktree entries so that we
could later decide when to emit the warning. (In fact, the original
implementation of the flag only controlled whether sparse matches
would be marked on `seen` or not [1])

[1]: https://lore.kernel.org/git/d65b214dd1d83a2e8710a9bbf98477c1929f0d5e.1614138107.git.matheus.bernardino@usp.br/

Perhaps we could alternatively make refresh_index() skip the
previously mentioned operations on all skip-worktrees entries
*unconditionally*. I.e. having, early in the loop:

if (ce_skip_worktree(ce))
        continue;

But I'm not familiar enough with CE_UPTODATE and how it's used in
different parts of the code base, so I didn't want to risk introducing
any bugs at refresh_index() callers that might want/expect the
function to set the CE_UPTODATE bit on the skip-worktree entries. The
case of `git add --refresh` was much narrower and easier to analyze,
and that's what we were interested in for the warning. That's why I
only changed the behavior there :)

> > > However, this is tangential to your patch and
> > > has apparently been around since 2009 (in particular, from 56cac48c35
> > > ("ie_match_stat(): do not ignore skip-worktree bit with
> > > CE_MATCH_IGNORE_VALID", 2009-12-14)).

Note that the `CE_MATCH_IGNORE_SKIP_WORKTREE` added in this patch does
control if refresh_cache_ent() will refresh skip-worktree entries, but
refresh_index() allways calls this function *without* this flag.
