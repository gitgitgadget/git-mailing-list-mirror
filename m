Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D19C433EF
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 17:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243851AbiCTRCl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 13:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiCTRCh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 13:02:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E114D4A906
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 10:01:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w25so15460800edi.11
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 10:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jZX4hRqmtDdeJAMpzwzUNhpEalpjQbF3cfjbAH3qvrk=;
        b=Hg/AKfLpB1Fv07mC3pAYS7XasOfBBjELdczMjuZpgPbYiLqGmDGAAcLbwSs59kqWSc
         r+9DMKt31q7KH6t8wPukB1daXWQogv3GqMmugyPsf84KIz6MnKgxY2+bhaJdXsNohoTb
         w7t1HptTpXPnte9m2Xn3lDu93OqPftWtHhmBOlwV70OuV69r8qvY5xndQlkyftUx6BSs
         tve0sWCMvjj1p9S3J4utYhRdfP0CBzWu5rtiNCTw+U/nMKTrTkgh7tpRGTjvQfkfp5aM
         dxSd1DsgjD2HdtwqPMigtftBu95x4Vup9NW1UAFxtVO2PU/oX3g1D9hHpTvD4EPVMz2+
         Dagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jZX4hRqmtDdeJAMpzwzUNhpEalpjQbF3cfjbAH3qvrk=;
        b=EFpkQ8Dvi9qyr3db4nsTWpGBGHEuuA1AhXCnrzKTw9ct+Eku3quIKyl53bXRN+gp02
         i6PJnXTkeCJC8GdIjCsPreKrflOm22dh9KdVZoyfaye3qOvwtfMeZllzCR+udM/GS5TR
         VXMx7QRdswHZhNajZxay2fodnPP9diLUHT1qc7oQBTKe1hyfPZmLBH1dLs+kOOCzSNNg
         W21zDcYg9G99Ivwi/9L0mG2voYz7RoKOPbTY7dBMoyiaJz03pxyUd7sfj2o6gZV+QZ14
         I/Sa0r5UF3WLPDUSRRxf+HADx3se8Hjz0L21rmk9cBdcqpD/JC4SBaKm6rXwsaXWYEzS
         R3xg==
X-Gm-Message-State: AOAM530tyuH/a/Gh99VXd5uXxB1R2NnBL6LXQhtH4x5PbH6MggDnl3YD
        UspW+b5ZyezUfiBxZvx5NsdbfNEcJCqgjLoTmUjzIA==
X-Google-Smtp-Source: ABdhPJxre7yi9wNm73XiRMIUcDntako69xpBLYWBL485bIV8rcsVlXuKLLmUqjqR5myt+tI2p8uek4DXliPl6X0CFQs=
X-Received: by 2002:a05:6402:2750:b0:416:29dd:1d17 with SMTP id
 z16-20020a056402275000b0041629dd1d17mr19313800edd.387.1647795672266; Sun, 20
 Mar 2022 10:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1161.v2.git.1645815142.gitgitgadget@gmail.com>
 <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com> <0b5d47895120539d6a72a91398f33a0e33df7cd5.1646032466.git.gitgitgadget@gmail.com>
 <220228.86k0df5key.gmgdl@evledraar.gmail.com> <CAPMMpoi9gQscSQ5Xn1xTb6WaCXu+qR67DJh9nCbqN0jp7-b_5A@mail.gmail.com>
In-Reply-To: <CAPMMpoi9gQscSQ5Xn1xTb6WaCXu+qR67DJh9nCbqN0jp7-b_5A@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sun, 20 Mar 2022 18:00:57 +0100
Message-ID: <CAPMMpohKRq0N8MGcWmUfMxVLTXrMD-+ADBDp_W6xwOXjUxdkhA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] merge: new autosetupmerge option 'simple' for
 matching branches
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 2, 2022 at 10:35 AM Tao Klerks <tao@klerks.biz> wrote:
>
> On Mon, Feb 28, 2022 at 11:56 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> >
> >
> > This function is the only user of find_tracked_branch(). For e.g. "git
> > checkout we emit";
> >
> >     fatal: builtin/checkout.c:1246: 'foo' matched multiple (4) remote t=
racking branches
> >
> > Perhaps we can do something similar here
>
> I'm not sure what you're pointing to specifically - the fact that the
> checkout message provides a count? If so I guess I understand/agree,
> find_tracked_branch() could be enhanced to keep counting rather than
> exiting at the first sign of trouble, to support such a
> slightly-more-explicit message here.
>
> I'm not convinced that this situation is common enough to warrant
> change: mapping multiple remotes to the same remote-tracking path
> seems like a strange setup - is this something we recommend or
> document anywhere? maybe to have 2 "remotes" that correspond to the
> same server over different protocols appear as one set of tracking
> branches?
>
> On the other hand I am of course happy to make things better if we
> think this will do that!

Having finally understood the logic in play here, I now see that
find_tracked_branch() does not "exit at the first sign of trouble" as
I thought, so there isn't much change required to produce a marginally
richer error message here, but I've decided to work on this proposed
enhancement in a separate patch. The more I look at this, the less
confident I am about exactly the right thing to do - and I'd rather
not hold up the (in my opinion) net-good branch.autosetupmerge=3Dsimple
work.

The specific concern I have is about changing the "fatal: Not
tracking: ambiguous information for ref refs/remotes/origin/master"
message. Having understood when it can occur, I've realized it is
probably quite common - I at least have certainly seen it a few times,
as the situation it describes is what happens if you copy/paste a
"remote" section in your git config file, to create a new remote with
the same setup as an existing one, without remembering to adjust the
refspec for the new remote name.

> > even with some advise()
> > emit information about what other branches conflicted.
>
> I believe the conflict is not about different "branches" exactly, but
> about *refspecs* that map to the tracking branch.
>
> If I understand correctly this change would entail creating a new
> advice type (and documenting it), and figuring out what the advice
> should look like - something like "find and disambiguate your fetch
> refspecs to enable auto tracking setup! If you want to keep your
> ambiguous refspecs, set auto tracking setup to false!" - but nicer :)

In addition to the mechanics of creating a new advice type, I
eventually realized that the right message would list the *remotes*
that have refspecs mapping to the same tracking ref - which would mean
newly tracking those in the per-remote find_tracked_branch() looping.

I initially thought this situation was too rare to warrant this kind
of change, but now, understanding how I myself have reached this
situation a few times *and it took me a while to understand what I did
wrong* (at least the first time), I think it's worthwhile work in and
of itself.

Expect a new separate patchset sometime.
