Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7589C433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 23:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJVXTf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 19:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJVXT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 19:19:29 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C038D
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 16:19:23 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id A68E3320055E;
        Sat, 22 Oct 2022 19:19:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 22 Oct 2022 19:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcclimon.org; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666480762; x=1666567162; bh=QwVTISREqa
        z61KxZo1k5u9mKwPwTS/RJsf1pdYCrD/s=; b=upMbikT1KFHTXC7WKTRBtmsq2n
        gdvWgvWSDZfcq9y09URDpKSevsX3iagbfbqU3jIYNcG12jCwNjls9oTxgebryq34
        7zIUnpfWC4S73x/kgTX4SQ8E2zCcbGeL8hcbSDf/xfWLfs5B6ILRSfNvP3iZqAGD
        JLPFNOV7Kivemh/FSQcWEeEbuVgR0XfFqPXI+wtGXlXnkqoe0pm2HuURj9RSdFLr
        ZK9IM/WPOX0RH2LaiJEjwFdPKWbfMEqNhCCCQfs2mHRTUWrc9bu4h60fCwpwWzMs
        F/FMB9ffM4VjfEW483CJhF0o5KZGqpEHBobeX3GE3mgG0hasFnXXzFmjhoyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666480762; x=1666567162; bh=QwVTISREqaz61KxZo1k5u9mKwPwT
        S/RJsf1pdYCrD/s=; b=MSHpBWgMwtVPsbNHoy48+GxpCBqni9UIFhrs2Z7Dl0OA
        BDh6nPwGT2SjW4jIcg6xi7JNHuPQ0t7q7D9jsRs4djKkwlLBJfyAtY4gsguKtaW0
        +IafGVXAGKRvlLqwuna4h3LX7MLuyYo5suYBmrHi9enWgysyXHiQ2hnjGtIcJdOj
        Chk/KFnOcfdXp2VOZaCfqV4KBVfQrUBpRyZHlsoHN0vlvfz8aCmzWXKYp0WDBnMl
        R3pxx2L/o5vgwbJgK8DjMlyVJh5+k5stTSj268/Hhz/I5mM2MVsLyupcd/mLD31F
        olIHLStpWa4VErlkauvVeyFZkNrf01/kba32+CvLZA==
X-ME-Sender: <xms:enpUY76HQ938GRN9tfPh4l12fyptSHqCeBdmX5h5D7FRB3H-6kZ9xw>
    <xme:enpUYw6c0xBsm-41MPOAPCVnJgzklGNpShqwMejeFe5_e2hZP766e0WLfIqjP2f_b
    CrlzbPcrPO9hd2n270>
X-ME-Received: <xmr:enpUYydelkDG8LBWcr276MYKWdkDhEAkrmAU7VrIq_ZwwyMNAhevN8XtikLT4Ou9M8JRBH44j6gP4HYUjOGOORTly8PJaiMjqPU1xvmBBvCy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtuddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefoihgthhgrvghlucfotgevlhhimhhonhcuoehmihgthhgr
    vghlsehmtggtlhhimhhonhdrohhrgheqnecuggftrfgrthhtvghrnhepueelledtheejfe
    eiuedtvdehgeetvefghfekfffguefgkeetiedukeekheefledtnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhitghhrggvlhesmhgttghlih
    hmohhnrdhorhhg
X-ME-Proxy: <xmx:enpUY8KMdHu_OqkHf0fnfysfHIn2GUUBLEQjkjiD5cFIFqaCnHuvRw>
    <xmx:enpUY_L-MYIGik-qg_HvZEcWrXLhnzPLAUkmWW0twfKK51JOOre8gA>
    <xmx:enpUY1yVVb4icQ8uV2E8VrciGe-D_pWt0omtT_mWVQS26VyDlw6udQ>
    <xmx:enpUY1iu0z4mDcVEqv_mfOt3llQdImo16yH2vukHevEo8gSx4eKKcw>
Feedback-ID: i9dc944d1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Oct 2022 19:19:21 -0400 (EDT)
Date:   Sat, 22 Oct 2022 19:19:21 -0400
From:   Michael McClimon <michael@mcclimon.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] setup: allow Git.pm to do unsafe repo checking
Message-ID: <Y1R6ecMO+6X8tFlF@newk>
References: <20221016212236.12453-1-michael@mcclimon.org>
 <20221022011931.43992-1-michael@mcclimon.org>
 <20221022011931.43992-3-michael@mcclimon.org>
 <Y1Rdtog/XQV0YLj0@coredump.intra.peff.net>
 <Y1Rp+7R7e+LFa5k6@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1Rp+7R7e+LFa5k6@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I prepared it on top of your fix in the mm/git-pm-try-catch-syntax-fix
> branch. That's not strictly necessary, since my patch deletes the line
> you fixed. :) But I think it's nicer to use your fix as the starting
> point, since it means the test runs but produces the wrong behavior,
> rather than barfing with a syntax error.

My vanity thanks you for this, even if it's not strictly necessary. As a
professional programmer with roughly no C chops and a long-time admirer of the
Git project, all I _really_ wanted to do was to fix a thing that was in my
wheelhouse so that I could say I have a commit in the history. (This isn't a
good reason on its own, of course, but I'm happy it was useful even if the
line is immediately deleted!)

> We can fix this by just relying on rev-parse to tell us when we're not
> in a repository, which fixes the vulnerability. Furthermore, we'll ask
> its --is-bare-repository function to tell us if we're bare or not, and
> rely on that.

Your suggested patch seems fine to me, and indeed I think if we were writing
it today we'd just rely on rev-parse to do the heavy lifting. It looks like
the code in question -- and indeed, the syntax error in question --  blames to
d5c7721d (Git.pm: Add support for subdirectories inside of working copies,
2006-06-23), at which point rev-parse did not appear to have any special
handling for bare repositories.

-- 
Michael McClimon
michael@mcclimon.org
