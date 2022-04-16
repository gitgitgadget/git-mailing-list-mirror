Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A798C433EF
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 05:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiDPFid (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 01:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiDPFi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 01:38:29 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39878FC8A4
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 22:35:58 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 79so1760864iou.7
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 22:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QeWd0aQDFCriSSRPYHT+sz9hm7J5TVL6gqYnTOoOlPc=;
        b=U/3XxnBvvkLGV0aD1rE9PjOb21p9D7BYwCC6e6gVir3iA/9+cuTLwDdPcsySaFG32R
         9nu+TAFsomGhsOG0cgo9qj6ogGs/Jj960w4YU3eTl4Zlm3mYpM9/WBfarg/AY5I95pOp
         8kMgNY0v7icci8IVft58R5U38CFnEnQRlmEjXRe0kLBb7MrG9UkZ8IOXeyJZl8V6U8ok
         x9PrzoHevUpdj/XQcSMoxxuObzBXWB4oAYpwleWd5FLLzIFoB2BZ5KdamP8Qbm8nclz9
         YuPalmi8MlGaBHKsQKwfp5A3kS9+iO3QunYVw2g12zLaRpwYT/sQLh/+i+TVEYI2VJMN
         oBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QeWd0aQDFCriSSRPYHT+sz9hm7J5TVL6gqYnTOoOlPc=;
        b=0Mfn9KVQpAQ181ygw+NCWqI99g2SPiZuett0NkrZA6rmo77PYTTrGeAVeTMfNL5nRu
         OFxKMkyAYycfIa4bZNuhys/JDvfOG4p3C9fTDlXS2J7Qs8nXuVtr4OMPABQVVhO+Rnda
         rOFy2ZKMmKyOmi3TdSP9HeMuwyI2TxTTVvVViiNqma5tt3mFW/Tyv/VnUMqHodjJrY5L
         cNWHNRzyZV2nvZp0HAtM5eLsPsodfdwKxtjwu2SiQrbjkRnjfHgu5ybF07/j6UT4hyFI
         0GApzrcsBi+0slUHzT2gYVbUEwQSgTKt2sn++2E/d8wLsYPMa94n2K7vH54FivlyxFJK
         e4kA==
X-Gm-Message-State: AOAM5314byUbpfTwZF0ToziJAiHwEaT8gxt0egtlRV3TY+8kyiS3W/+C
        n63PJ25woiZ8uCLmsQX6654J5lc/FlFBHxw/gYChdBFKh9F9bQ==
X-Google-Smtp-Source: ABdhPJxpnIDNYmWqAT64sNks0aa0COZrEClE7SaEwULDXZgD5DfDEXo319HedQlsDLbM+mtNrVH9c7TKpPoDZ0a+XOw=
X-Received: by 2002:a05:6638:3589:b0:326:4caf:7b64 with SMTP id
 v9-20020a056638358900b003264caf7b64mr1126329jal.160.1650087357557; Fri, 15
 Apr 2022 22:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220413164336.101390-1-eantoranz@gmail.com> <xmqq4k2wap8g.fsf@gitster.g>
 <CAOc6etYvOhqQn3icWj3Ny1m+J_60h7aiqW-gvm=dQyDLgG=6NA@mail.gmail.com> <xmqqbkx2ccj4.fsf@gitster.g>
In-Reply-To: <xmqqbkx2ccj4.fsf@gitster.g>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sat, 16 Apr 2022 07:35:46 +0200
Message-ID: <CAOc6etYwMtfytbw6iRfnJnsexJhe7UydVu0OFUbWP0byS9i=MQ@mail.gmail.com>
Subject: Re: [RFC] introducing git replay
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2022 at 10:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>
> It would be wonderful if a single command like replay can be used to
> say "In the old history master..seen I have bunch of merges.  master
> used to be M but now it is at N.  Rebuild M..S on top of N _but_
> with a bit of twist.  Some of the topics in M...S may have been
> merged to 'master' between M..N and the replayed history on top of N
> does not want to have a merge from such 'already graduated' topics.
> Many topics are updated, either by adding a new commit on top or
> completely rewritten, and we want an updated tip of these topic
> branches, not the old tip that I merged when I created M..S chain,
> when replaying the history on top of N."
>
> That kind of operation is quite different from what "rebase" does,
> and deserves to be under a different name.
>

Let me work a little bit on your workflow to see what I can do. Tip:
It will probably come out in the shape of a script. We can talk about
what to do with it later.

> Compared to that, "replay exactly the same set of commits in the
> same shape on top of a different commit whose tree happens to be the
> same as the original", is a mere special case of "rebase" that is
> not all that interesting.  It may be a worthwhile thing to do to
> teach "rebase" capable of doing so reliably and more efficiently,
> but that still falls into "improving rebase" category, not meriting
> a separate command.
>
>

I agree that it might not require a full separate command. I'll see if
I am able to get it into rebase.

Thanks for the feedback.
