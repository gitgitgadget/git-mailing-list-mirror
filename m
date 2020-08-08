Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1EDC433DF
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 14:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C437120748
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 14:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFOdGJOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgHHOVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 10:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgHHOVm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 10:21:42 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F39C061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 07:21:41 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id a1so2147734vsp.4
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 07:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iqsJsJmAGpPFrfQxuRGPao0Glf/PT5qijTPdRzg3Uic=;
        b=VFOdGJOd0qfCKCDilDS0bBVqPcyh4PhyVjgbp1A74HhM7H+jiZKJPAt9T/J6/d0ZC0
         6xRNTdN5J3uSIkZ/A4VYCi4dzE3MUwgN7ciOZeTDcsZDeSNQ1ZsGKCo4Ys10SbWe7awr
         FNF9iGiM9fa5yKCCeC2Ku1sN0/FlJXnK1wPPjTmBi0xgoXxEiIrGc0mXmYd9JgEukHlr
         VLkqPCg8um5nIr9kPIW1MKnWa6UlTGhLNleInMOK5HLxNwvcugVBstzBpZKgZ4JGR6iO
         O1HbNC3FASItoKS//brqcE2/icOgo9RR70++0AL5Ny9/U1tin9usgV953Ye2uu93YvlK
         5q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iqsJsJmAGpPFrfQxuRGPao0Glf/PT5qijTPdRzg3Uic=;
        b=ouV7VYag8zaumEB1iY0nvz+Lg4i8/zD8yX76HkJjK3TwVepb9IXH0yRvKs+g+9HaHL
         /yn04swyQhIpZCpq3gItq7iuWljZv4UKrBUxStUt594ZeSEwzCJndumzuOcqbsdevQq4
         V/r/D1jUSbromo/lV9Wvk7BBZ8Kl1NvfsCq9OEcWo4OB5WJGNTg40mGbVcwp+noWdbUE
         yyL6GwxXwbGwNmhUpT+6KpZh3nba/f0fgRKkVtLzIlXqR/IAvKdV4I/pBx4/1fJjAbUw
         veF5zIJpVu9OGpTTfHVQM4DGoWcOzT9CFABJY6Nw5Mft3HvtUcoKCCPb/K0vVbq5/G8S
         y8tA==
X-Gm-Message-State: AOAM531wugd+g7S3dlKLGhbeDNsX4XoFY9XPFhVa3084mT0gvJUui6Nf
        dkWIVLJeWtx8WRZVeLOHcvmgUww5575+UQBrkXXsssC0yAY=
X-Google-Smtp-Source: ABdhPJy+faXUPuUIRRPD2ir6lZFAHgpmLqAt8xtIi2ST/rvuYKjGih9L++yLNzmCPkE5M9fghktjEd9cYSIr3wSfAQw=
X-Received: by 2002:a67:bb06:: with SMTP id m6mr14959651vsn.54.1596896501163;
 Sat, 08 Aug 2020 07:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAN0heSoVs+ApvanSOGZJeOvy5DNEMrMAZ41BKUkchmfVE2kTjg@mail.gmail.com>
 <C4RJZM9BYO1C.21M5GRE871JIN@ziyou.local>
In-Reply-To: <C4RJZM9BYO1C.21M5GRE871JIN@ziyou.local>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 8 Aug 2020 16:21:28 +0200
Message-ID: <CAN0heSpY5w5n71C24bNSfJr3tThbVQgHxKS4Wb4PvEECCYHu-A@mail.gmail.com>
Subject: Re: [PATCH 1/1] diff-lib: use worktree mode in diffs from i-t-a entries
To:     "Raymond E. Pasco" <ray@ameretat.dev>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 8 Aug 2020 at 13:24, Raymond E. Pasco <ray@ameretat.dev> wrote:
>
> On Sat Aug 8, 2020 at 4:48 AM EDT, Martin =C3=85gren wrote:
> > Describing the current state of affairs and using imperative mode, it
> > could be something like:
> >
> > When creating "new file" diffs against i-t-a index entries, diff-lib
> > erroneously uses the mode of the cache entry rather than the mode of
> > the file in the worktree. Change run_diff_files() to correctly use the
> > mode of the worktree file in this case.
>
> I see both styles around in the tree (past for the state of the world
> before this patch, present for the state of the world as of this patch,
> vs. present for the state of the world just before and just after
> applying this patch). Neither is unreadable to me so I just want to do
> whatever's the standard around here.

Yeah, there are all kinds of log messages in the history.
SubmittingPatches (search for "imperative") recommends this way of
writing.

> (I'm not convinced, as a matter of grammar, that the
> commit-message-present verb form is really in the imperative mood; I
> think the freeform nature of English grammar obscures that it's the
> present active infinitive, analogous to, say, the fact that a French
> software program with an "open file" button will say "ouvrir" and not
> "ouvrez".)

When you put it that way, I'm also not sure. :-)

> The whole set of i-t-a diffing behaviors needs a test suite (unless I've
> grepped very poorly), which will come in another patchset. t4140 in this
> thread's main patchset assumes they work.

I did grep a little when I wrote my previous reply and I didn't find
anything either.

I guess you could add a very small testcase here and then base that
future series on top of this commit. Or in lieu of a test, maybe this
could be used:

  Tested-by: Martin =C3=85gren <martin.agren@gmail.com>

Martin
