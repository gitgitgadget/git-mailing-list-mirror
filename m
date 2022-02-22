Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AF0C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 02:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbiBVCiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 21:38:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbiBVCiE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 21:38:04 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EFD25C6A
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 18:37:39 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s1so213834edd.13
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 18:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PsnYBzex8hu3hZzMRM6gaiAhdyK9wxwlhtqJuqqjrgY=;
        b=QVoDSKlgIueF5gP1dBwt0lZNrkmVC9fNYT3FaiQ/zmQeFGq9mwQGlsYJxr/mVhzWcE
         eUhdZYr1ASa5YJZKbDKzrgF83THKxnjPUs2N1qPrNoJNnpV+jmNhxXyrRjltKT01dake
         dbPjqk4KzI5wsduBPXa6to8olBAuRcy3uG3BC3RMxc7Xph657oSgL19phsDMYze/g0dR
         Gj8alg6jgENeTrPBfgu9HfyvJtxY1bf0Cty6mJHuXl1Vb3CvBbw59WWH2AI2VpZD5TuF
         JYE86FiZwSTmn6pzltfTmmBlLo+T1GdyJgFvW2ZL9bQrxZI6VExX8Ub6vVUT2xU30hSv
         962g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PsnYBzex8hu3hZzMRM6gaiAhdyK9wxwlhtqJuqqjrgY=;
        b=3OrQytzoQEOWb4AGKpHHwysbJzc+mzxpP8tjevAdiIQRILfJ4Q6ALGAkizZwh8evDf
         g0CAK23NqVapde6Um4MwKFp77WaO88z4w/YaMp4420MNu8QPDWknBf6DyEkmt/bGIHib
         9RHKc9IcQJroMoBzOmu9/jpUw8GHGW83r7ntS2Vj3QijU1hDkWLJOTY+xAbpg4qE1DOF
         IBNl1xCsq+Jg9etXbvzvkiVUnqoeGJ0y2c+Apt/q1NzSRWuOKBWT/3P7xkRaUyBAPkyq
         aB/7fqoBoVGlHV3OqgKFeWZb0jdSAqUYglmpQqh8pdfDKxbqQs5N345gc1ok/kvg/ZN7
         MdQQ==
X-Gm-Message-State: AOAM532XPOhsM7wWNwoXUqmIHEEh8zNmH1VIYKqe1hpeOu06wocfKsXG
        6Nay6yJ1sDF/m4w9nonjPOuHe+aliovM6rfiNha6cCPrNiM=
X-Google-Smtp-Source: ABdhPJwpdfzuY94zWgaZmxWi1oa56R99Y4HGmGiCun3rTL/52OdJ1QMwa/4golthxED+vCCPG/8BfJ0zZo6Azfe4tcA=
X-Received: by 2002:a05:6402:845:b0:412:ad14:863e with SMTP id
 b5-20020a056402084500b00412ad14863emr23300000edz.380.1645497458014; Mon, 21
 Feb 2022 18:37:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com> <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643787281.git.gitgitgadget@gmail.com>
 <xmqqy22tx8t1.fsf@gitster.g> <CABPp-BGpD6g5QH3=4X_dCuSX0Bs0utHn5hyuU4_UiwNhU0h8sg@mail.gmail.com>
 <xmqqh79hvsgn.fsf@gitster.g> <CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com>
 <20220203104241.yvfragan6ucecfjl@gmail.com> <CABPp-BH_TiJaDpn2+VVjCb83NEFjL9teSk06+YiZyFGiTu8Lpg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202210956430.26495@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2202210956430.26495@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Feb 2022 18:37:26 -0800
Message-ID: <CABPp-BFK_7eFtJ5C-fqLCvpacOj-AEmy=+6jteYWcY0X4BRKgg@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] merge-tree: implement real merges
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Altmanninger <aclopte@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 1:06 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> On Thu, 3 Feb 2022, Elijah Newren wrote:

[...]
> > I agree.  I've got a lot of thoughts on it, and some work in progress
> > towards it (https://github.com/newren/git/tree/replay -- _very_ hacky,
> > not even close to alpha quality, lots of fixup commits, todo comments,
> > random brain dump files added to the tree, based on a previous round
> > of this patch series, not updated for weeks, etc., etc.)
>
> Just chiming in that I find that very exciting. But it's a tangent, and
> slightly distracting from the topic at hand, so I would like to ask to
> focus back on server-side merges.

+1 for refocusing.

> > We'll certainly have discussions on what that should look like.  But a
> > plumbing-ish replacement for merge was much simpler, and made sense to
> > do first.  I would prefer to concentrate on getting that hammered down
> > first.  Then I'll start discussions on a plumbing-ish
> > rebase/cherry-pick.  And if that doesn't fulfill all the needs that
> > folks think they want out of merge-tree, then we can add a
> > merge_incore_nonrecursive()-based mode to merge-tree.  It's all
> > coming, but having fought transliterations-of-scripts in
> > merge-recursive.c, sequencer.c, stash.c, rebase.c, etc. for years I
> > really, really don't want any more of that.  Let's end that insanity.
>
> Being the driving force behind many a "built-in-ification" of scripted
> commands, I wholeheartedly agree. You can still see the fall-out of
> designing commands in a scripted fashion, without any way to represent
> data structures other than strings. I wish we had come up with a better
> design to prototype commands than to write shell scripts. But I have to
> admit that even I do not have any better idea than to work on a proper API
> for libgit.a (which has historically invariably seen push-back from
> Junio).
>
> While I agree that this discussion is a valuable one, right now I would
> like to focus on getting the server-side merges done, and once that has
> happened, move on to the replay/sequencer/API discussion (which will
> probably be a big one, not so much for technical reasons but more for all
> too human ones).

I'm just guessing, but I suspect your prediction for the future
replay/sequencer/rebase/API discussion will be spot on.  :-)
