Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA98EC47082
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 00:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C16226128E
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 00:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhFIAKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 20:10:32 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:43790 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhFIAKb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 20:10:31 -0400
Received: by mail-oi1-f178.google.com with SMTP id x196so22986538oif.10
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 17:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0LpE/sslZdycH96tIdcdxmybx6Kt3+8qRYFhxOrhCwk=;
        b=UCkIyPa+r3mRQHAJg1Bsc/1T+EjPRD2cCLVWR1VRuZaJJmYgUaLnC3VOdUrzXUHLtS
         YGPYa+3SAIfp5BDn1sU5LZZjPdANn2T+nv86NExerTbq387TG2PFYWn+1jrkPng9ejQU
         cish/e/3hGIiO9JaD1U7TFTb/vaXqz6OZLg2cl5Pb0AOCZCXqiVbiPJXWGhhpC6y/sWE
         kEpzdn7Yhfq3nmNCpC930G4aVNAJl0bdPU1bpuuPaujkdDC+qEb12XMmWjmK0Mo3Lm5c
         AXd8Id+obnvXSK5qAAXgn5P011Zjs6cHVoOZbeuOivoBaGr4z3mt8eH/FU2igdijIm9h
         tlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0LpE/sslZdycH96tIdcdxmybx6Kt3+8qRYFhxOrhCwk=;
        b=SvhkI47oyv2uVcz2UKorgBax4rV0cu8Va+aYzviASDfLSNru6lzkQQ8STsAStrixKo
         ypIcF9vulLNe6XuG9tD0J89eTQx5H15KMxfsbSXTe2VZJfevp/kdWqK1ewVRXN3fnO1g
         SrAhittkjUoTTaLgVsLKuY+RNZ4dkk7vXMBRVgS4jNSQTiH4K67WAWvQAWK9k0IS1dle
         XycU37nOGu3XH1OFQ7Qto6/PtgLl2yVusxwc3N+9L+sjUBGpiYic8AaujryVEFvvFY9l
         6QjZz/rSED1g8C5l64Df7t23oMSdZRZ3yPZTFAJ3hqx6bc990kE2yZgE6eDC1YykP9CP
         FXyA==
X-Gm-Message-State: AOAM533msAR5TgGAM3HPZaX1/I7dqgxeaSLTEa/0ShsNf/2+CDVGtiex
        eGrbqUK6TnGr7fg2BvoFWRJHtUXRumKij9mAXC8=
X-Google-Smtp-Source: ABdhPJxdLLVulYk8aNTYl/OvCCcDQlxXmxosDt7YaKnjTeSa8ljXK7YoDBBdXTVrouUZZMAc93M2yS4KhTPNUwGz1hM=
X-Received: by 2002:a05:6808:13d5:: with SMTP id d21mr4699631oiw.31.1623197241799;
 Tue, 08 Jun 2021 17:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com>
 <cover.1623111879.git.jonathantanmy@google.com> <CABPp-BGL3L5uReVHtSUsNJ7fYgBV_Us5ZYv7e9FPHT2DuY-dyg@mail.gmail.com>
 <xmqq4ke7ordl.fsf@gitster.g>
In-Reply-To: <xmqq4ke7ordl.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Jun 2021 17:07:10 -0700
Message-ID: <CABPp-BF97Ej+WrgSrumz9DZpeg_wgKVhvPatiHn4GvSyraymag@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] First steps towards partial clone submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 8, 2021 at 4:42 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Mon, Jun 7, 2021 at 5:26 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> >>
> >> Thanks everyone for your reviews. I believe I've addressed all review
> >> comments, including the one from Elijah about the test failing with
> >> sha256 (which turns out to be because I didn't add a call to
> >> setup_git_directory(), which the other test helpers do).
> >
> > Thanks for fixing those up.  I spotted some minor nits/questions, but
> > nothing big.
> >
> > Looks like Junio did spot some bigger items...which raises a question
> > for me.  I have a series ...
>
> Do you mean, by "bigger items", that we may want to turn it around
> to have repo extension data to the in-core repository structure?

Yes.

> > (https://lore.kernel.org/git/pull.969.git.1622856485.gitgitgadget@gmail.com/)
> > that also touches partial clones.  Our series are semantically
> > independent, but we both add a repository parameter to
> > fetch_objects().  So we both make the same change, but you also make
> > additional nearby changes, resulting in two trivial conflicts.  ...
>
> I can sort of see how the above plan would work if we are not going
> to fix the "keep only the partialclone related extension thing,
> instead of solving the larger structural problem that the current
> arrangement ignores that repository extensions are per repository".
> But wouldn't that leave us with two series with technical debt?
> Also, if Jonathan's series fixes the "bigger item", would the above
> "proceed more or less independently or rebase one on top of the
> other" plan work well without making the same fix in yours?

My series is completely independent of the partialclone extension stuff.

My series merely adds the recording of a single statistic (number of
fetched objects) to the partial clone stuff; everything else is higher
level diffcore-rename and merge-ort stuff.

> I guess a better first step would be to stop, think and decide what
> to do with the "bigger" thing---if only to dismiss it with a firm
> declaration that we would never do such a fix and move extension
> data piecemeal to relevant subsystems, so that we'd reduce conflicts
> in the future, as I am reasonably sure that the "bigger item" will
> be tempting to fix even after the two series lands, and doing so at
> that time would be twice larger surgery.

I don't understand how you think the partialclone extension stuff is
relevant to my series at all.  My changes to promisor-remote.c are
just a couple lines, and if he expands or rearranges his work, the
amount of conflicts can't really get any bigger because there's only a
few lines on my side for it to conflict with.
