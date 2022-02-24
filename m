Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68013C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 02:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiBXCWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 21:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiBXCWm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 21:22:42 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9C9151C49
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 18:22:12 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qk11so1342634ejb.2
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 18:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FoBRDfPq+6gWgl+l/YnwvWcA6Nn/zK423UYZUYH+9qo=;
        b=nTi/qYp/HC2QdCbX5AMXANeMnKXqSRyuQz+E8x3Ki6g+thMMNKUd81tDFukv8O3kjf
         xg1okaZiKZsht7e4s1jcCtl+/+NvaLE39tOxkq0+BmDzuXSww9+iRdMzvkAqeoJY0xqt
         u0xxRY4BdlgxElKMgcGnj5ZTRDGcoWw97Y9f46q3jiwVO2ZFewM4PHFX++qQp9HmarrQ
         DuiocMOQc12w2WNyykLHxTh7CXi25HkPEK92VJKsTr76n4KcNDeCtPqp2fgDqtJL+on2
         POXz6i/4p3UpZzr5a6NwYN4RXmdnb24y63FiHeLFi0b7g7Fttllr/dLUM35sWiMmkifn
         DaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FoBRDfPq+6gWgl+l/YnwvWcA6Nn/zK423UYZUYH+9qo=;
        b=O6kWSerTEEJI1jNS2BrYcAdaZBOzoF3d8HZX704m2uCDkwbUh7qSdSGwOycN99hdvE
         sZKyODMU1NLzMnHJ1OfQMqe7DbXCjggQcsbsxmGXmHG5orzYfWlTbhRZkhG8c60IQomj
         MQ7y+E55MWc2JL/J9SsbddAq778BIE6DddFAa85o5TnTqIthWS+orK5SK6mZnPuKFOK0
         Nsk1fMUJwmn8l6ahryrbu+TM0R9wg1FsS0MBywa+0NXAxQrLdby3laDefz9UacQb+XQb
         NL2ScBSpdknSBd/lc+h3HbIj9Rr216A3xKtljEFMDDZUTg5Y2W0C5+dFReWILEbN1cYA
         MYVQ==
X-Gm-Message-State: AOAM533my07xWR/x82a4V2eXIiZXgGzQbAEe4hFg5lGbuIzKOf+RJtxd
        IpNfVygjP5Grn/tBaqKqEY/o1MB/rhBZ4hoDVTo=
X-Google-Smtp-Source: ABdhPJxkGA6qcvsUcXeg+tf6vGTXWrfhHxSsZoQASlFTU4aLXJnCcNsu2fM+ONdjI0QJnpQN1+UugcpHkZjsfUeCo/c=
X-Received: by 2002:a17:906:2f94:b0:6cf:e4f7:13a with SMTP id
 w20-20020a1709062f9400b006cfe4f7013amr441915eji.269.1645669331382; Wed, 23
 Feb 2022 18:22:11 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com> <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643787281.git.gitgitgadget@gmail.com>
 <xmqqy22tx8t1.fsf@gitster.g> <CABPp-BGpD6g5QH3=4X_dCuSX0Bs0utHn5hyuU4_UiwNhU0h8sg@mail.gmail.com>
 <xmqqh79hvsgn.fsf@gitster.g> <CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com>
 <xmqqee3wt5g3.fsf@gitster.g> <CABPp-BE+DaBkis0r7pqs-kaChCvFhCEsyDg=gs3=QjWOPERaXQ@mail.gmail.com>
 <xmqqczjduz2h.fsf@gitster.g>
In-Reply-To: <xmqqczjduz2h.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 23 Feb 2022 18:22:00 -0800
Message-ID: <CABPp-BEsYTz35XpXy_j09J9-ke4UoCTED4z3L1sq0vYHuvuKPQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] merge-tree: implement real merges
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 23, 2022 at 12:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > The objection you are arguing against is not my position.  In fact,
> > I'm not even objecting to having a single-step cherry-pick, I'm
> > objecting to providing it _now_, which I thought would have been clear
> > from the portion of my email you snipped ("...I'm happy to add [a
> > single step cherry-pick primitive] along with the tool I submit
> > later...").
>
> The entry point into the in-core merge machinery of ort already
> knows how to accept externally defined merge-base(s) to bypass the
> "caller didn't give us the merge base, so let's figure them out by
> using the two heads being merged" logic, so it just felt backwards
> *not* to have a vanilla three-way merge that can take three trees
> and be used for merge, cherry-pick or revert as the single primitive
> in the very beginning before we talk about multi-step operations.

"The entry point"?

There are two entry points: merge_incore_recursive(), and
merge_incore_nonrecursive().  The former is analogous to
merge-recursive's merge_recursive(), and the latter is analogous to
merge_trees().

"git merge" always uses merge_incore_recursive()/merge_recursive().
The other big merge-y operations (cherry-pick, rebase, revert), always
use merge_incore_nonrecursive()/merge_trees().

(Technically, merge-recursive has a third entry point used by am &
stash, but let's ignore it for a moment.)

> So, I guess I am still not getting where the "I'm happy to _add_"
> part comes from.  If we start with a primitive (internally callable
> from C) "here are three trees O A B, do the three-way merge", then
> there is nothing to "add" at all to expose a single-step
> cherry-pick.  In fact, to the users of merge-tree, the result does
> not have to have any fixed meaning.  If they pass common ancestors
> as the merge bases as Os and the current HEAD and the other branch
> as A and B, they get a merge.  If they pass the commit to be picked
> as B, current HEAD as A and B's parent as O, they get a cherry-pick.
>
> Perhaps starting from "You are allowed to give me two commits A B,
> and I do not let you specify the commit O to use as a common
> 'ancestor'" is the root cause of making this thing feel backwards.
> I agree with the goal of having an all-incore machinery that can do
> a merge.  I just do not see the reason why you have to build it in a
> way that cannot be reused for other two directions of merge-y
> operations.

So, am I correct to understand that what bugs you is actually
merge-recursive's and merge-ort's API?  That you don't want these two
types of merges to have different entry points, and that there should
in fact only be one?

That might be an interesting line of investigation to try to modify
the API to achieve that, but that feels like a bigger task that is
somewhat tangential to this series.

Without such a thing, handling both merging-of-divergent-branches and
three-way-merge-with-specified-merge-base would be separate codepaths
that call different functions.  I implemented one of those two
codepaths, and if we want the other then it needs to be added.  That's
where the "add" part comes from, in my view.


Does that help, or am I still missing what you're saying?
