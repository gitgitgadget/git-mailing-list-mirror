Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DB6C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 18:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0886461040
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 18:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhHISkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 14:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbhHISk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 14:40:29 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4789FC0613D3
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 11:40:09 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id bi32so1081982oib.2
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 11:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+50qCcw6yUuFxjx90MpGwul3LLf95P+CWuryhyDK6Ls=;
        b=pTC08/kDbgX5R6Bgyi8wLzu7RmMUnS+hGeysB+81VbAMf+Rq6R+FQpPl4wyFbNEbNQ
         H5SoTT+oYBJLzr1gjKHEY6gp29RT/ZcZwGipqe6OB7LlVo+ovrsPvk6pCNxirNlbyeY1
         slTweLhdrzt2bWMsfkMqeuiIHDSV5nf7x1k8JFjNZMpu6L2IxH8r4CZ1o8h/zP90/jwm
         Dg7899c7c9HkYKmHn194XZ/K4q6ZeBolDADm1GDVpPjC4cjf+L+i6Tc8LqjZcWYUj+X9
         dly/bmDXxD8tt3xK/TomwyfEFhP940qm9bZSkludy/p1azmbT7nhq6AjiCnoYhVBQnAB
         4K6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+50qCcw6yUuFxjx90MpGwul3LLf95P+CWuryhyDK6Ls=;
        b=mjqk1vkkZ0qsBl2/ZqB42dvQyxP66dxGGUkrJCI6vLoN6K/ujiXNuEUjdGaOdU0MHw
         ZYg/fJZoMfx18FtI7C82zEps803RlwwffdHZjoDDbJKNr85+r+vUu+0aV5HoURH5bplt
         NA4SUEWxxHTyJouK/pYAmjyhJR0UxM0q81dmhjcLdeLp9vHS5eJRr5ZGB1fv9bO9DPFO
         gv4EeKMQEnLrjEqAYfpn+2NrERXf7ej/RmjUMgI055T+X3zvrIoCawOC+Mt2hK9MVa8V
         at06DAfG8dBih1r5Z21JuaqgA95jjYvzYBM8e6JLGGobsOjSNjY3t6wnHWEyYTPQ16tL
         U8jA==
X-Gm-Message-State: AOAM530E6LjlbtV3wOyURF0Socohaojvy5R5TGRSwqsiHP8jB7+Bxx4G
        /weySvcUqRfx5Oh+/BmhMl6Y59mHhX/YRFsUb1Y=
X-Google-Smtp-Source: ABdhPJx20Ga7cuZiPt2tcqz7IZf+B/7jT+NcYubEQsNJrF5t50UK59HWcfGU8MJlnhahdW7DyxaGRGGSmqnxPJDm7Yw=
X-Received: by 2002:aca:902:: with SMTP id 2mr395524oij.167.1628534408716;
 Mon, 09 Aug 2021 11:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqzgtuf6r0.fsf@gitster.g> <CABPp-BFOusrK6E6n91XSXcKP8kin-8RX8L_HXdKRjS790HkwHQ@mail.gmail.com>
 <xmqqlf5afsgs.fsf@gitster.g>
In-Reply-To: <xmqqlf5afsgs.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 9 Aug 2021 11:39:57 -0700
Message-ID: <CABPp-BHen70xN8fHZr_s61ix17qLq2iw3SFjP-GJmmEuMMF6rw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2021, #03; Fri, 6)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 9, 2021 at 10:17 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Fri, Aug 6, 2021 at 6:26 PM Junio C Hamano <gitster@pobox.com> wrote=
:
> >
> >> * jt/push-negotiation-fixes (2021-07-15) 3 commits
> >>  - fetch: die on invalid --negotiation-tip hash
> >>  - send-pack: fix push nego. when remote has refs
> >>  - send-pack: fix push.negotiate with remote helper
> >>
> >>  Bugfix for common ancestor negotiation recently introduced in "git
> >>  push" codepath.
> >>
> >>  Needs review.
> >
> > I decided to take a look.
[...]
>
> I am mostly worried about the lack of response to comments on [2/3],
> especially to Peff's "Wouldn't this also be a problem for
> multi-round fetch?".

Oh, I read Peff's comments[1] to mean that he thought Jonathan's
patches behaved no worse than the existing code in the face of
simultaneously running gc's, and thus that =C3=86var's concerns shouldn't
hold up Jonathan's patches.  But, it's totally possible I
misunderstood his intent -- as I mentioned, I'm not at all familiar
with this area of the code.  Maybe Peff or Jonathan can clarify.

[1] Handy link:
https://lore.kernel.org/git/YQA4bzFxdOHSQva7@coredump.intra.peff.net/
