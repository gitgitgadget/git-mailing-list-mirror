Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F497C433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 20:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhL0UQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 15:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhL0UQz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 15:16:55 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8792AC06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 12:16:55 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x15so65772608edv.1
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 12:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GofR3iGKQCRWTxlROHPDvRYXQeRxZutFAraA3BDSULQ=;
        b=YNiTJ6y1gn5HzwUvEwqBO/abhYYu//xZRHMTQcI+P54o3O7pg6ojm6FhsEvuOxhqHh
         G+mTvZgNux83maEszIsgmRN1Co2X2DbqzZ1R+zk2fugs2K8jk9nZ+MRObSDwULHsg2AL
         APUC1Xou0TPOHsySbm8Q6bvkxRvzd/3MvG0mi6HTW3gPGNeTD9MeUJDfcZ7dtQBI/T9+
         vlJP95f0048juRrObtwkTy4tXhvD6B8L82JPX2P2GHXWYQZf/fh/lyTl1ICLtunToqQk
         gJ/hjcXzeaU6Y46lKnmfpm9E0coV3D/TwmxGbU3uPVBXJBAyTLV5dNLq4SDPxxJHaMEc
         1ZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GofR3iGKQCRWTxlROHPDvRYXQeRxZutFAraA3BDSULQ=;
        b=BiXfKgQ1W40/jiiG7/1dPd0fKPiEE6GyDd5iXyHjycCAsU9+mlLkCSV0ABS4r3W3rV
         AAUqbApvZvc6vLJUgVZks8MQqTAKNZYD+s5pNe6HI9zNgqmyk5RO37MkqGUuD5yxAsCi
         kM0LqfwV++n547duyG5yL3F58zoiVdLUuoH/IVP3tLCiD1ew/P21uGGd2Xrx28DHmGR7
         DpmTxZ6/Zv/Yb/zksRXNXbF++jLzEeLE94YNOGr/7THkRbhOfY6rFDQnYgsC/00SRqeI
         uigVCyUKa/Mr0Km1RMPkxo+jGtPSWr5M+P83YgjOCFzKf8UCyZeXGbs3TWtoXokYzhWb
         x7gA==
X-Gm-Message-State: AOAM531S1IxDcsxa7UM4TrRi8SruqeCIFKnbzyZIbCOu1TgJBJAoaxy3
        EQcFRCbVa1ls14I13h2hkPHmqk22gEuWPzBuV4A=
X-Google-Smtp-Source: ABdhPJxSq3BPFJS/Sd/llv68Z16vzRD1wDKw/bXUwmfi1JyhhTGcDuVsNUjE+5kg+tqbekkAAUqKgaZWLxiw8nCfKLM=
X-Received: by 2002:a17:907:9808:: with SMTP id ji8mr15483251ejc.476.1640636213949;
 Mon, 27 Dec 2021 12:16:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com> <CABPp-BG7nwsdEYrnfqhAbWU4ndJHcqGf6RS_6DzJittuNVLvoA@mail.gmail.com>
 <CAPig+cRDDGU=9BB6kd1tMJR8DmWKSSJwpTD8JeszrY685Fc3-Q@mail.gmail.com> <CAPig+cQjYiARBwSZTsswk442TvDC2UiyOx5wNdRwF6C7i8ENxA@mail.gmail.com>
In-Reply-To: <CAPig+cQjYiARBwSZTsswk442TvDC2UiyOx5wNdRwF6C7i8ENxA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Dec 2021 12:16:42 -0800
Message-ID: <CABPp-BHMr32MuisNzt-R3O4=HPY63HQT0=ykrbtiASyS1K_JjQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Sparse checkout: fix bug with worktree of bare repo
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 26, 2021 at 11:34 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Dec 27, 2021 at 2:15 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Wed, Dec 22, 2021 at 5:54 PM Elijah Newren <newren@gmail.com> wrote:
> > > I think that "git
> > > worktree add" should check if either core.bare is false or
> > > core.worktree is set, and if so then set extensions.worktreeConfig and
> > > migrate the relevant config.
> >
> > Similar to my response to Sean in [1] and to Stolee in [2], while this
> > may help the situation for worktrees created _after_
> > `extensions.worktreeConfig` is enabled, it does _not_ help existing
> > worktrees at all. For this reason, in my opinion, `git worktree add`
> > is simply not the correct place to be addressing this problem, and
> > it's why I suggested a separate command for enabling the feature and
> > doing all the necessary bookkeeping. It's also why I suggested[2] that
> > in the long run, we may want per-worktree config to be the default
> > (and only) behavior rather than the current (legacy) behavior of all
> > config being shared between worktrees.
>
> Thinking upon it further, I take back what I said about it not helping
> existing worktrees.
>
> Your proposal is _almost_ the same as my suggestion of eventually
> making per-worktree config the default. The difference is that you're
> only making it the default if `core.bare=true` or `core.worktree` is
> set.

Indeed.  :-)

> But do we need that distinction? If people are comfortable with
> that, then are they comfortable with simply flipping the switch and
> making per-worktree config the default today regardless of `core.bare`
> and `core.worktree`?

This is tempting, at least if we leave core.repositoryFormatVersion as
0 (see 11664196ac ("Revert "check_repository_format_gently(): refuse
extensions for old repositories"", 2020-07-15)) when core.bare is
false and core.worktree was unset.  However, for that case:

* This is a case where operating on the primary worktree was not
previously problematic for older git versions or third party tools.
* Interestingly, git <= 2.6.2 can continue to operate on the primary
worktree (because it didn't know to error out on unknown extensions)
* git >= 2.19.0 could continue to operate on the primary worktree
(because it understands the extension)
* git versions between that range would suddenly break, erroring out
on the unknown extension (though those versions would start working
again if we migrated core.bare and core.worktree but just didn't set
extensions.worktreeConfig).

> I'm not sure that I'm comfortable with it due to the potential of
> breaking older versions of git which don't understand
> `extensions.worktreeConfig`, as well as breaking third-party tools,
> but maybe other people feel differently?

The distinction I made was particularly written with third party tools
and older versions of git in mind, to allow them to continue to safely
operate when possible.  But let's flesh it out a little:

* core.bare = false AND core.worktree is unset (i.e. a typical
non-bare clone), AND we try to add a worktree: we have _years_ of
in-the-wild usage showing that old git versions and third party tools
operate fine without migrating the config.  Leave it in place and do
not set extensions.worktreeConfig and do not upgrade
core.repositoryFormatVersion.

* (core.bare = true OR core.worktree is set) AND we try to add a
worktree: all third party tools and all git versions (old and new) are
broken anyway.  Flip the switch (upgrade core.repositoryFormatVersion
to 1, set extensions.worktreeConfig=true, and migrate
core.bare/core.worktree for main repo and newly created worktree),
which at least allows new git versions and new tools to work
correctly, and will hopefully cause old tools to error out since this
is a configuration they won't handle correctly.


Further:
  * Toggling extensions.worktreeConfig=true for the first time is
rather trivial for users to try; for years they have been able to do
so without making _any_ other changes and expect things to continue to
work (assuming new enough git versions and third-party tools).  They
have likely disseminated this information to other users.  I certainly
did.  If we are going to expect more of anyone toggling this option,
we need lots of documentation and perhaps code changes to help shore
up the path.  I'd rather just allow folks to continue to do such
toggling.
  * Toggling either core.bare or core.worktree in an existing clone
requires significant additional manual work to make things consistent.
Because it requires a lot more knowledge and work, I think the burden
should be on these users to know about the ramifications with existing
worktrees.  (I've never heard of a user other than myself attempt to
toggle these; I'm sure there are some, it just seems quite rare.)
