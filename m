Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52DFC4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 08:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CDB66108E
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 08:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFWINu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 04:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFWINt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 04:13:49 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28ADC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 01:11:31 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id x17-20020a05683000d1b029045fb1889a9eso675724oto.5
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 01:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3dHfWBwefv4F+CVfw3lfq5GsgD/ktTvcXvT5ioFXzw=;
        b=SlNgSGbNnEmexMUw/9Uot3JRYZLMTOhDK05qfKPvYhsjmMEbMvOU9EJKe21e64Arg4
         ic/FLg1TZggHEkgrtiTNjRuGSxY1p7rnwgQsBkBMaTxes5M56xVmq0o1AA5UyBRlyUVv
         Ih0uSFDCWnIvoKtPQfmcjcinPtBj3DJTSog+a0EvE2oLgitPNLlp9ethfYbMFq6NIhQv
         aFMlvmub7phqIMbEiSDv0NVpQ0so43LeFE51qDQnVf8wA2LhVadv7Pxb3ELB1YrhRm5E
         lIFf2Pz3p+mz702pDDk4WjDXwdnGoYZ5NQCG2CmqSluccsTWxT/3MvLvNvyfqRaE5/Ao
         twhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3dHfWBwefv4F+CVfw3lfq5GsgD/ktTvcXvT5ioFXzw=;
        b=pYt//quvj54O5/IBMLy0BShOIDCg8gwsXPGqex2T50NpPAvngsXaJvY4Eb44L5/VA/
         ElZyK0nTVC8ulABazYlhS/iV4dP5exL7EP1NRY6McpRpYwIAEUFSDhW4sQnEfpMeDliY
         +PM5uftvoglrJhLb7GFjtM5gc7HpMocaPulexCKVjcp1wpkd2JefyIL3BstMQ7dt8caU
         iQBxqdCBX14wNvvQ6mynXV594D86gX0S4yAbaSEgw+/haKFzLUKFo034aFE/SsPgrhRq
         0SyZr9Lwm3dYNa6GufjajNjpzmEm4pYTtQYDQKsXEg2iJpm56s0EFdhOBxDJIT5mgjQo
         e1Gw==
X-Gm-Message-State: AOAM530FEF5/9UPPUAzG46HUaHubOI08u+ZemTh671YYmECsBBak1tCV
        UOr7F+/nwgaIPIvipJsbgIbvpDtN3t7FniHuyvc=
X-Google-Smtp-Source: ABdhPJzv8FoIGOtxYfPUMibOfAQhwS3m7IYPQKg0tMai4zVLhobjvLC5Ml28NDeYUMe1ZBV+rQdpvpcRvrX2xDqpRsQ=
X-Received: by 2002:a9d:1a8:: with SMTP id e37mr6679118ote.316.1624435891105;
 Wed, 23 Jun 2021 01:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.969.v2.git.1623796907.gitgitgadget@gmail.com>
 <pull.969.v3.git.1624349082.gitgitgadget@gmail.com> <3a397e04-88a1-1205-a465-75dc2fd7e93d@gmail.com>
 <CABPp-BH9vy3otHvAxR2T6JmVKtH2+EKj-A7NxGsuoqnZA_Bykg@mail.gmail.com> <8f1edc60-f754-541b-1d66-7f5ec49eff55@gmail.com>
In-Reply-To: <8f1edc60-f754-541b-1d66-7f5ec49eff55@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 23 Jun 2021 01:11:19 -0700
Message-ID: <CABPp-BEuHbFbTWXKhW0MYkcW9ScJfUungwL6y9g=W=bZ=cmCbg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Optimization batch 13: partial clone optimizations
 for merge-ort
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 7:14 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/22/2021 2:45 PM, Elijah Newren wrote:
> > On Tue, Jun 22, 2021 at 9:10 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> I want to focus on this item:
>
> >> 2. I watched for the partial clone logic to kick in and download blobs.
> >>    Some of these were inevitable: we need the blobs to resolve edit/edit
> >>    conflicts. Most cases none were downloaded at all, so this series is
> >>    working as advertised. There _was_ a case where the inexact rename
> >>    detection requested a large list of files (~2900 in three batches) but
> >>    _then_ said "inexact rename detection was skipped due to too many
> >>    files". This is a case that would be nice to resolve in this series. I
> >>    will try to find exactly where in the code this is being triggered and
> >>    report back.
> >
> > This suggests perhaps that EITHER there was a real modify/delete
> > conflict (because you have to do full rename detection to rule out
> > that the modify/delete was part of some rename), OR that there was a
> > renamed file modified on both sides that did not keep its original
> > basename (because that combination is needed to bypass the various
> > optimizations and make it fall back to full inexact rename detection).
> > Further, in either case, there were enough adds/deletes that full
> > inexact detection is still a bit expensive.  It'd be interesting to
> > know which case it was.  What happens if you set merge.renameLimit to
> > something higher (the default is surprisingly small)?
>
> The behavior I'd like to see is that the partial clone logic is not
> run if we are going to download more than merge.renameLimit files.
> Whatever is getting these missing blobs is earlier than the limit
> check, but it should be after instead.
>
> It's particularly problematic that Git does all the work to get the
> blobs, but then gives up and doesn't even use them for rename
> detection.

I agree with what should happen, but I'm surprised it's not already
happening.  The give up check comes from too_many_rename_candidates(),
which is called before dpf_options.missing_object_cb is even set to
inexact_prefetch.  So I'm not sure how the fetching comes first.  Is
there a microsoft specific patch that changes the order somehow?  Is
there something I'm mis-reading in the code?

> I'm happy that we download necessary blobs when there are a few
> dozen files that need inexact renames. When it gets into the
> thousands, then we jump into a different category of user experience.
>
> Having a stop-gap of rename detection limits is an important way to
> avoid huge amounts of file downloads in these huge repo cases. Users
> can always opt into a larger limit if they really do want that rename
> detection to work at such a large scale, but we still need protections
> for the vast majority of cases where a user isn't willing to pay the
> cost of downloading these blobs.

Sure, that's fair.

But I'm still curious what the particular shape is for the data in
question.  What does the error say merge.renameLimit would be need to
set to?  If it's set higher, do some of the files resolve nicely (i.e.
they really were renames modified on both sides with a different
basename), or are they modify/delete conflicts and we're paying the
cost of rename detection to verify they were deleted and we really do
have a conflict?  I'm curious if there's more to learn and more
optimization potential, basically.  Your repository is bigger, so
there may be more to learn from it than from the testcases I've tried
so far.  :-)
