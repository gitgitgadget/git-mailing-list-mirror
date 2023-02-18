Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC87C05027
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 03:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjBRDRc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 22:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBRDRa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 22:17:30 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493C050ACC
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 19:17:29 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id z10so2778356ljq.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 19:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5sABvGsBdQGKvmiTOJBw2rRrul6QeiBolsjm722ODj0=;
        b=Nlv5+BbH5ffhSdWrX0TAnb/HpBKJis65X96b3GRnl0noANlRxbHaIF2rlJ2az/YxKG
         g9Vxda8Yd3gSMHJZuTP50e6P4SuziiIOQpFndNwlnv4Jx1kjI8l+ZyOowb9ty4iXqZU4
         Mf7vO3ApV3gubBjUHpDGGmnU+4X2ueFP77uti3DL5gLX6sSqWwhid+NRm6oNV6unnZgc
         GQBliVtE2bX05kSR6OpPkI/14Gt7dGh95OmmocvNeiSX8dqArDXJG9rhsGtPGr0KFsR1
         g/P89RK0JavayYHyNXDCnoSyAN19bMOHg/N6uG8JJKIZ7srSfJAP8N2AmvlAnLs5t3Fs
         DThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sABvGsBdQGKvmiTOJBw2rRrul6QeiBolsjm722ODj0=;
        b=iInyyhibyoUB19A4xBf9CNhEcUY+x42zP7j/HktacyhPwU0NaobTiAW1/oyLoTWT0Q
         j65vzDqaZDuwGR2EC9D4DO76RiegaotABvaleGgGVlO1D+d+/CtWj9LUdvyPkOKMBVSm
         HXkMaFCDLAf1a/W4M0LnStGOH2DRruoA4uyn72O2ILzYxvgOmlyg/2pcpSspRz+VKxCQ
         +i9VMWvE6nCJrduejVaoYK5oQEriMJ/DSAJCvOZz9zhjZ6JDCq0+ea+o0Ug4dmkcLXgF
         cpUYqelP83Gl0gfN8e86liwshjpBnQ8a8QdtyfcxuCgmHzX56IQHTLPPBkAJrEZPOk5G
         ai+A==
X-Gm-Message-State: AO0yUKWA988qWQbYtaHFMS9WJuOS38zW1kkHK8bvRyzc3HmZtfH+Y+vI
        Mg+JcbtT/dTV4lAH87PEK6UslDlWO63dRxY8hE5QLoFsfMg=
X-Google-Smtp-Source: AK7set9AGefDtgLCFaYlg6PiaaOVekCuqvRvnhxDF1A9EGfPwYNm0RayECzzpjL2LBcFtOqxr0cwvcqcur/6gRaBKWg=
X-Received: by 2002:a2e:b5ca:0:b0:292:f86f:4315 with SMTP id
 g10-20020a2eb5ca000000b00292f86f4315mr928426ljn.6.1676690247488; Fri, 17 Feb
 2023 19:17:27 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com> <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
In-Reply-To: <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 17 Feb 2023 19:17:00 -0800
Message-ID: <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 8:02 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> On Thu, Feb 16, 2023 at 5:31 AM Tao Klerks <tao@klerks.biz> wrote:
> >
> > If there's an appetite for it, I would love to contribute to a
> > multi-year adventure to change git's behavior, little by little, until
> > the behavior of "rebase=merges" is the default, and the old behavior
> > becomes a different option like
> > "rebase=copy-merged-commits-to-flatten"
>
> I know you had a lot to say in your last email, but I'd like to focus
> on this point. I would be OK with the proposed patch if it were part
> of a larger effort to make --rebase-merges the default behavior of
> `git rebase`. That seems like an achievable goal, and I don't think it
> would take multiple years, maybe one year at the most. The process
> would look something like this:
>
> 1. Add a --no-rebase-merges option to `git rebase`.
>
> 2. Add a rebase.merges config option.
>
> 3. Add a warning to `git rebase` that appears if rebase.merges is
> unset and neither --rebase-merges nor --no-rebase-merges is given. The
> warning would advise the user that the default behavior of `git
> rebase` will change in a future release and suggest setting
> rebase.merges=no-rebase-cousins to get the new behavior now.
>
> 4. Change the `git pull` advice to recommend --rebase=merges and
> pull.rebase=merges.
>
> 5. Wait a couple of releases.
>
> 6. Change the default behavior of `git rebase` to `git rebase
> --rebase-merges` and the default behavior of `git pull --rebase` to
> `git pull --rebase=merges`. At the same time, remove the warning from
> `git rebase`. The old `git pull` behavior would still be available as
> `git pull --rebase=true`.
>
> 7. Change the `git pull` advice to recommend the short and simple
> --rebase option again (leaving the recommendation of
> pull.rebase=merges for the config option).
>
> Does that sound reasonable? I think I could lend a hand with steps 1-3.

One concern I have is that "--rebase-merges" itself has negative user
surprises in store.  In particular, "--rebase-merges", despite its
name, does not rebase merges.  It uses the existing author & commit
message info, but otherwise just discards the existing merge and
creates a new one.  Any information it contained about fixing
conflicts, or making adjustments to make the two branches work
together, is summarily and silently discarded.

My personal opinion would be adding such a capability should be step
2.5 in your list, though I suspect that would make Tao unhappy (it's a
non-trivial amount of work, unlike the other steps in your list).
