Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF87AC4320E
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 22:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9942E60FF2
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 22:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhH0W2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 18:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhH0W2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 18:28:24 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D86C0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 15:27:35 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id bi4so7743673oib.9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 15:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v5CKS2YKp+aHA9WOj63NHLsVsU1qERD0pyQj8rReN/Y=;
        b=d4I1yViC7fkCt7BewJQXoLQKv92Pp2nXnE+kGLKnJhqmu/AXLYagoSUnpA3YJkfKkI
         1v05UXRSkjaeGl7kVpFvtuT5S77lWjxp/h+VvKL14hRAm4S2xLsOvlGLLuisPVp6GcUc
         RkCb4B53OSdUNWhrTWyhbRWzxNWT0ddxX8miuTgYCdbe8uBDn1aelyMV1TXSI1xLTSQb
         ngS1N9759f24vTh6FQ1x4rWqHAHzWh84Q8bSfg/f4zkoGr6TmIDhKoAFUZVP5Cf9iHyM
         7PaMaAbXOof/tPg2mBp1jkb9Hf+iZsy2gcZt/T8EcypXIWzmvFIGuYUCGof6D9H7O2Ub
         MtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5CKS2YKp+aHA9WOj63NHLsVsU1qERD0pyQj8rReN/Y=;
        b=cLbYGMpM5/AU65NdUFf6r9pbnIWZEMW0eX4MU7TodPhFlrFDKCklhDLvnvr92VDSiH
         6FukYO0TqzGr2QyEL4cnDuQymEcgy2WCmG/2sgXe6f9FI7wLsdyJ2N7hrm2ugzgXGBWn
         IMb8ysoQG+oAF6jh4V/X+BIsb0IF4jJloiXwgZXcvYXbmjE2tB4PCycluh+35Usf9KE3
         CgZu/c3F0FDROEkSlBGNjEbm40Yr1fmlr86BZMCeOPLPyiAlRFZPEuY9WmgVIdE9xUUR
         pGmd9BJnOmqLFPjglY8QR3d3o9Cg+Hirv+LAX7Cd2CCNYoruw2q1NNXn4JLhuxy225gy
         FRbA==
X-Gm-Message-State: AOAM533HRmLoD+PhzACtLssODPGf7diVtGqq6K/DxBbLQypc9SoDIG/s
        0tQuHEuU05MGdtTpgHSHN7wsSk15zyjkGExtwSc=
X-Google-Smtp-Source: ABdhPJx6pZApsP3ZQgVgl7gMqAAfubuclfZlij5AsatH0BZeW4AAlCW0OCwTWA8o/imP894gcR8HzruThN2b84juGCw=
X-Received: by 2002:aca:bfc6:: with SMTP id p189mr16293695oif.167.1630103254135;
 Fri, 27 Aug 2021 15:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
 <9f50f11d394e46ffbe348a579792c2b683096452.1629220124.git.gitgitgadget@gmail.com>
 <CABPp-BFu29JHkoBERcVnV_NooSaVDrFEiR-NQRu-ehTC4iRHiQ@mail.gmail.com> <d77ae8ce-977a-82d9-f28c-f57271fbf923@gmail.com>
In-Reply-To: <d77ae8ce-977a-82d9-f28c-f57271fbf923@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Aug 2021 15:27:23 -0700
Message-ID: <CABPp-BHR5Zf23yVXJ9NTbo05Ck+kpZ7tH3qBEvnPjV42PzyOcg@mail.gmail.com>
Subject: Re: [PATCH 2/6] diff: ignore sparse paths in diffstat
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 11:30 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/20/2021 5:32 PM, Elijah Newren wrote:
> > On Tue, Aug 17, 2021 at 10:08 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Derrick Stolee <dstolee@microsoft.com>
> >>
> >> The diff_populate_filespec() method is used to describe the diff after a
> >> merge operation is complete, especially when a conflict appears. In
> >> order to avoid expanding a sparse index, the reuse_worktree_file() needs
> >> to be adapted to ignore files that are outside of the sparse-checkout
> >> cone. The file names and OIDs used for this check come from the merged
> >> tree in the case of the ORT strategy, not the index, hence the ability
> >> to look into these paths without having already expanded the index.
> >
> > I'm confused; I thought the diffstat was only shown if the merge was
> > successful, in which case there would be no conflicts appearing.
>
> That's my mistake. I'll edit the message accordingly.
>
> > Also, I'm not that familiar with the general diff machinery (just the
> > rename detection parts), but...if the diffstat only shows when the
> > merge is successful, wouldn't we be comparing two REVS (ORIG_HEAD to
> > HEAD)?  Why would we make use of the working tree at all in such a
> > case?  And, wouldn't using the working tree be dangerous...what if
> > there was a merge performed with a dirty working tree?
> >
> > On a bit of a tangent, I know diffcore-rename.c calls into
> > diff_populate_filespec() as well, and I have some code doing merges in
> > a bare repository (where there obviously is no index).  It seemed to
> > be working, but given this commit message, now I'm wondering if I've
> > missed something fundamental either in that implementation or there's
> > something amiss in this patch.  Or both.  Maybe I need to dig into
> > diff_populate_filespec() more, but it seems you already have.  Any
> > pointers to orient me on why your changes are right here (and, if you
> > know, why diffcore-rename.c should or shouldn't be using
> > diff_populate_filespec() in a bare repo)?
>
> I think the cases you are thinking about are covered by this
> condition before the one I'm inserting:
>
>         /* We want to avoid the working directory if our caller
>          * doesn't need the data in a normal file, this system
>          * is rather slow with its stat/open/mmap/close syscalls,
>          * and the object is contained in a pack file.  The pack
>          * is probably already open and will be faster to obtain
>          * the data through than the working directory.  Loose
>          * objects however would tend to be slower as they need
>          * to be individually opened and inflated.
>          */
>         if (!FAST_WORKING_DIRECTORY && !want_file && has_object_pack(oid))
>                 return 0;
>
> or after:
>
>         /*
>          * Similarly, if we'd have to convert the file contents anyway, that
>          * makes the optimization not worthwhile.
>          */
>         if (!want_file && would_convert_to_git(istate, name))
>                 return 0;
>
> (This makes me think that I should move my new condition further down
> so these two can be linked by context.)
>
> Sounds like this is just an optimization, so it is fine to opt out of it
> if we think the optimization isn't necessary. Outside of the sparse-checkout
> cone qualifies.

Ah, this is very helpful.  Thanks for digging up these details.
