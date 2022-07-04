Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D05C433EF
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 17:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiGDR6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 13:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiGDR6A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 13:58:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF80C646B
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 10:57:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lw20so17926136ejb.4
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZDtXciaInKnHGCK2aTOYtR38Wz6bocqonCwRz+nf/A8=;
        b=B6w9twzpaamTRVwLjvTiY7y0eKpf2S7zPGg3AL24yUVdHLWpbc6Ks/sZ/8eGmCH3GY
         Xz0JjhxDjHuu/PijsOBVbKmYkZZBJD5OJ8Yt7BWFJlYueZ8C30hvC3sPHshTLGp2Nlu1
         pqQPt0ph22ne/gd10ETpV3PDC36GObKecODKefRELa6GZsODtNSnEDAf3v2lBRrrExqv
         NTFw+ZQI9IqQD0pRzZ1xEwKDPmPwNoUVJ2NWiDbP7bLLrJ246LCC2MepfxXT6AAnuAbC
         S9fJFr5OeQIezL2shl+kRE+grlabElvsm8PPv73lQMbAn+k/f628O67fB95vVkxpgQ+C
         kfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZDtXciaInKnHGCK2aTOYtR38Wz6bocqonCwRz+nf/A8=;
        b=2zDKMhkUO51Mb+0AQ8smyTdQJbeiCp9R7LbhHl02kftCKHbWbDteNFE8hinge1sYzK
         K/6MIqDE7jIdk6Eor1drjrMnaDHu4ocO2MUwN2FR1thxN3sA59m6L4bPWIE1Ydt5ulcb
         q6AUX1LB8oabM5F+l618QgrCJd47bgHTEHJdJojiCqAOUJ2vz1fxAL6fn1luIot3e+4F
         jsb3jwEIho0dIm9hKRzCnpL+a3YIjn5MKo+EIX0QRCoxmLnCLSIELQfVEkpPMP6zDIkd
         U2ZFOPTgBuQXwl4hxSatNq5mR1TgeSEg1xn7NEGdMB2HHKJR0/tk+X4LmSBoUBGQ+L4h
         i3sw==
X-Gm-Message-State: AJIora+eYUpsBd5994iyhOilQZthkIJVdAKsWYOMPI4Bk2EktocdGkek
        8DFK3NST8do33qXkwA5lnJKD1IicddFoQSSZao0=
X-Google-Smtp-Source: AGRyM1uQBJP2bQhqM81S4D6wHP8UYGekDStZxYDbv53QAXI5fT6HoEWtY70i3ZIgHnkNkCg/rL4Zi4yVmakdwG2C0ZA=
X-Received: by 2002:a17:907:d18:b0:726:3172:2266 with SMTP id
 gn24-20020a1709070d1800b0072631722266mr29814568ejc.476.1656957478395; Mon, 04
 Jul 2022 10:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com> <918b398d6a2264a99acadd319f780c796bbafc18.1656422759.git.gitgitgadget@gmail.com>
 <CABPp-BFqLP51q9RkJr=16+Aqq7R=tYqL5mZGUq-dvfn8LL2AMQ@mail.gmail.com> <7dd69bb1-8bc7-3ae9-6265-bdba660b4c4a@github.com>
In-Reply-To: <7dd69bb1-8bc7-3ae9-6265-bdba660b4c4a@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Jul 2022 10:57:47 -0700
Message-ID: <CABPp-BHOSHYLEpH_222X_Pv_hZeDwy10zLejrVgwgf6W-pFVyw@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] rebase: add --update-refs option
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 4, 2022 at 5:56 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 7/1/22 3:20 PM, Elijah Newren wrote:
> >> +/*
> >> + * For each 'pick' command, find out if the commit has a decoration in
> > Is this really limited to picks?  If someone uses --autosquash and has
> > a fixup or squash in the list, wouldn't this apply as well, or does
> > all of this apply before the transformations to fixup/squash?  Also,
> > what if the user is doing --rebase-merges and there's a merge commit
> > with a branch pointing at the merge.   Would that be included?
> >
> >> + * refs/heads/. If so, then add a 'label for-update-refs/' command.
> >> + */
>
> This is limited to picks (for now) mostly for the reason that the
> fixup! and squash! commits are probably getting reordered, even if
> they exist at the tip of some refs.
>
> The workflow I am optimizing for is to create fixup! and squash!
> commits at the tip of a long multi-topic series, and then those
> get reordered into the list. In that case, the only ref that is
> pointing at one of those commits is also the HEAD branch, so that
> is not updated using this mechanism.
>
> This is a case where I'm very interested in alternatives here, and
> maybe I should clearly mark this option as experimental so we can
> work out cases like this based on use.

So my question was that if I had the following `git log --oneline
origin/main..` output:

    555555 (HEAD -> branch2) fixup! second commit
    444444 fourth commit
    333333 third commit
    222222 (branch1) second commit
    111111 first commit

and I run `git rebase -i --autosquash --update-refs origin/main`, what
would I get?  Is branch1 updated to the rebase of 222222, or does it
include the amending from squashing 555555 into the rebased 222222?
Does branch2 get "left behind" because it wasn't a pick commit at the
tip of history, leading us to not update branch2 at all?  Or does it
get correctly pointed at the rebased version of 444444?

Actually, I checked out ds/rebase-update-ref just now to try it, and
it seems like it does the right thing:

    pick 111111 first commit
    pick 222222 second commit
    fixup 555555 fixup! second commit
    update-ref refs/heads/branch1

    pick 333333 third commit
    pick 444444 fourth commit
    # Ref refs/heads/branch2 checked out at '...'

The last line was very disorienting to me at first and made me think
we had a bug, but the update-refs stuff is built on top of the normal
rebase mechanism and branch2 will be updated by that logic rather than
by the special update-refs handling.  If I add another branch with a
few commits on top of branch2, then branch2 is indeed updated and
after the pick of 444444 (and the additional branch, say branch3,
would be updated by the normal rebase logic instead of by the
update-refs handling).  So it all works correctly, but users might get
worried or confused along the way wondering whether it will function
correctly.

Another part that users might find disorienting is that at the end,
the rebase reports:
    Successfully rebased and updated refs/heads/branch2.
which is correct but totally ignores the fact that it *also* rebased
and updated other branches.
