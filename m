Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2910FC433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 17:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385135AbiBHR5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 12:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385129AbiBHR5p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 12:57:45 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8A6C033246
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 09:56:59 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id n9-20020a17090a73c900b001b5cafefa27so2776990pjk.2
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 09:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MAyv0p07aAqBsLkP8Eu1c3kTRS4ARMBVjM3CtBbBwOM=;
        b=f4Fy8isJPzchodLKubWYO/4Caoi7s+Bij/XqDskebUicvq0wAeqNQ2ZcfaxZklrR75
         3SlXPcEPGM0h2ZcqRmnh/T9CMTA9ALLi8T5qI84FNtWBeoBAoTLq9hE6cXjLsWSQbp8V
         mepzBZE0llv3q0jTkHBDk/xQWZZwUJgWOojwlbbFRRKO+8oldPryhe+2DYf/xpIca0oT
         JdiZY/U4eYFI1S5rD7gdLoAcxim/edtjW+y/1FE/wZM2FJJTsc0F+k5AhAwh0gC5ShcG
         2Crj1RjUQToigobpCS/09NPJdSJmZHA2/dAsvw7IZziF7+Fbu1wivJ3QF4Hnya5pJTie
         3PvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MAyv0p07aAqBsLkP8Eu1c3kTRS4ARMBVjM3CtBbBwOM=;
        b=CpUZBRB7qoPDlOYrkfRQTwDR+hV1jo3H1S/6gGCQDwxxdO4y8hiK6Pmgsd8psPlVYT
         DKd9xv0jYJMdISeibDBhUuPMn9VjELa/hU/RJo3g5yelKjoRXfd3Nh0KYqTojnAyKFxN
         IrrjzFae9cVWdTC3x72J6xBuRPaMqboiDLEXYdXSAbbWPpVkT1ZA7kKtMV6qxziifqGH
         rWtWarvkAAeQFjaVV2+xGgrz1jOQ3hohos3Bra06ig1RHwEorDE/xnbuLsRkuCktg2ON
         Cc2Rk9b9g52Sv+DWgoL47TQf11KQ89IAAowa5SQrxVHmukpedj4hFBFrMENXFrftfpA3
         HjRw==
X-Gm-Message-State: AOAM532LMh6hCh5hhjCoZFmaMQzYuO8ButlAuNFZsywSc4wKnO61L25g
        l146TTbVCXL6dHEV27Hk5kzkik3lEmNqRm97Zxlm
X-Google-Smtp-Source: ABdhPJwDk/ODNeeM+G7VW+obBjHr6Xg/PZM9Qx8L3+h6FThrGC1kQ8HK7Hb6P3fl3txXHh99w4RRXfen7ZZWyiXAuR0m
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:16c1:: with SMTP id
 l1mr5583023pfc.52.1644343018972; Tue, 08 Feb 2022 09:56:58 -0800 (PST)
Date:   Tue,  8 Feb 2022 09:56:51 -0800
In-Reply-To: <83ab0f7d-96d5-8730-edd7-693f10b09002@gmail.com>
Message-Id: <20220208175651.155629-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <83ab0f7d-96d5-8730-edd7-693f10b09002@gmail.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: Re: [PATCH v2 2/2] cat-file: add --batch-command mode
From:   Jonathan Tan <jonathantanmy@google.com>
To:     phillip.wood123@gmail.com
Cc:     git@vger.kernel.org, johncai86@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:
> Jonathan is there any overlap between what this series is trying to do 
> and your proposal for a batch command[1]? For example would extending 
> this series to get blob sizes be useful to you?
> 
> Best Wishes
> 
> Phillip
> 
> [1] 
> https://lore.kernel.org/git/20220207190320.2960362-1-jonathantanmy@google.com/

There is overlap, yes. I'm not sure of the best way to resolve it,
though. John mentions a substantial reduction ("roughly half") of Git
processes [1], and if they foresee needing to access things other than
object info and contents, it might be better to start with something
more extensible, like my proposal for a specific batch command. (If not,
they will encounter another increase in the number of processes.) If
they think that they can make do with this patch for the time being, I
think that's fine too: once this is merged (which will be earlier than
any extensible batch command, for sure), they (and anyone else who needs
batched object info and contents without the overhead of initializing
all the data structures in Git) can make use of this improvement.

As for getting blob sizes, I think that --batch-check can already give
it to us. If that is the case, the series is fine as-is (at least in
that aspect).

[1] https://lore.kernel.org/git/1b63164ad4d9ec6b5fa6f733b6095b2779298b36.1644251611.git.gitgitgadget@gmail.com/
