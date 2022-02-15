Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880C7C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 20:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244116AbiBOUiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 15:38:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiBOUiV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 15:38:21 -0500
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43712D76EC
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 12:38:11 -0800 (PST)
Received: by mail-pf1-f177.google.com with SMTP id c4so234099pfl.7
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 12:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWXXLm1wWGVZlV21uBTFI1a37ttYie4Lcb7sFEHJoVA=;
        b=0RImLOsKtHIIyGpWTw6xqMI8z1OGJ0XZcXtgucXG0U3W/G1hrJE/msGoKYWtBK7tf9
         7jwzpQygDyrm5+MxYEC/+flRU6UKSVqHuKlU9TNukH/de66QB252vUnP2+bQ4KyYrdL1
         gA0WFhCUJXQhZaG4gYBq2CGV+DQOTAuw15REjE3mBc4oiKVAnTsgkjQd2OyARWuxgg/q
         IP6ovn2i/spuweeTthp6IYfN/rgzypvtVj4cejllYxxwanxOr7cxWawZjAQITdmGfEYf
         Jr9101AXhMwRdYyHRLmlo/Qr2DWsZGSs8Bo2/I83s0r3nGQCaoJAx4zljWpQBRKQXM8W
         vkAw==
X-Gm-Message-State: AOAM530VhnECrFwmhCroE3aKzpabyN53BRdonW7xh2IhhNVZI7Yhr1yM
        wJKAcYmr0LFQwcUbAWz4XhUXT0cx+/s+1dLHoZM=
X-Google-Smtp-Source: ABdhPJznkZssonZpeuiMYaKL1g5kLIwvbrofOwG59OVyjmmTnrXtMEd9H88jKGonpJRiEeFoCxJTCwAuwyxXtqhuYhg=
X-Received: by 2002:a63:2f82:: with SMTP id v124mr535969pgv.139.1644957490344;
 Tue, 15 Feb 2022 12:38:10 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
 <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com> <0260ff6cac0c76c6d66187d77defef1edd4c6fb5.1644269583.git.gitgitgadget@gmail.com>
 <xmqqo83hatm1.fsf@gitster.g> <11bf1541-c46a-fcf5-f8d4-0d144b942d59@gmail.com>
In-Reply-To: <11bf1541-c46a-fcf5-f8d4-0d144b942d59@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 15 Feb 2022 15:37:59 -0500
Message-ID: <CAPig+cSY7E_XQC1gHzDJxoDGGmgWDmNz9Ys=CwbhLkCt+DQf-A@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] Documentation: add extensions.worktreeConfig details
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 8, 2022 at 9:34 PM Derrick Stolee <stolee@gmail.com> wrote:
> On 2/8/2022 5:20 PM, Junio C Hamano wrote:
> > "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >> +extensions.worktreeConfig::
> >> +    If enabled, then worktrees will load config settings from the
> >> +    `$GIT_DIR/config.worktree` file in addition to the
> >> +    `$GIT_COMMON_DIR/config` file. Note that `$GIT_COMMON_DIR` and
> >> +    `$GIT_DIR` are the same for the main working tree, while other
> >> +    working trees have `$GIT_DIR` equal to
> >> +    `$GIT_COMMON_DIR/worktrees/<id>/`. The settings in the
> >
> > The mixed use of "worktree" and "working tree" in this paragraph
> > might confuse readers into thinking that the paragraph is being
> > careful to make distinction between the two.  All references to
> > "working tree" in the above paragraph should actually be "worktree",
> > I would think.
>
> I generally agree. This was changed in the most-recent re-roll
> based on a request by Eric [1]. I'm happy to take whichever
> version the two of you settle on.
>
> [1] https://lore.kernel.org/git/CAPig+cS-3CxxyPGcy_vkeN_WYTRo1b-ZhJNdPy8ARZSNKkF1Xg@mail.gmail.com/

"request" is perhaps too strong a word considering that I led in with:

    A few minor comments, which can be addressed later or not
    at all, and likely are not worth holding up the series...

I mentioned "worktree vs. working tree" only to point out the
terminology inconsistency being introduced by the new patch; the same
sort of inconsistency which had bothered Michael Haggerty enough to do
something about it in bc483285b7 (Documentation/git-worktree:
consistently use term "linked working tree", 2015-07-20).

I, personally, prefer the term "worktree" for both convenience and
because it better encapsulates the overall "thing" which is
manipulated by the git-worktree command unlike the term "working tree"
which, as Junio points out, has (perhaps) a more narrow meaning. As
such, I would not be opposed to a patch series which changes "working
tree" to "worktree" in documentation where appropriate, but that's
outside the scope of this series.
