Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CCDC433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 10:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC3F222282
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 10:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF5q7yvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393063AbgJTKQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 06:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387440AbgJTKQc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 06:16:32 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637D1C061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 03:16:32 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m22so1256857ots.4
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 03:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8l9X4hc6JK+62gf4x9BjONwO+Yv99dIpfvGrCt3T/c=;
        b=EF5q7yvmOOQ9pU9dAPtRBQPd9Y6o7PlsJKta/WErvcMs93ynOL7CDYtdMoRjU0uTZg
         ga/4TnCTBVl03SXquQPldZFkVWOc6ryH9rDC1wpewY1kqoS/2N96HnumUYgtzYx2TYGl
         YeJpLWl3XgyXzfJeRtzHV3wENSBDrqe6D3qLY2zYaWKdUypdGOwxmZywCP2S3QneQl8l
         UHSoAfENs4U0hH290UP8XH91xU7BlQL+cRoeYLtbw5pf8kXZVji0GYZ7pUitacA+bVwK
         mJ32BmUf5kS2gDhIlGYq3eoR+MhmlCpxHVPbIv3QZJ2RXzJkvImoaba++4CUhF2Zt0qp
         kNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8l9X4hc6JK+62gf4x9BjONwO+Yv99dIpfvGrCt3T/c=;
        b=Q04JnruEkjhc1oZfqoTw+qVvJwV+8UTu6VcxBn5dnkNpWyS/9bOyEwohp/n+aPbHdC
         DPUeb7pZoabdwJ7rYocvY3BVkDfx1YKFHmjoZ+CD7My6motQ/5o9PjMcWBLnKwvpWjan
         5MLag/bQ/Q7teUlfRQAGegszHGidG1cJ+28Q3qC37gtR+1iEjGcxa/AhwyyOvD+biTmY
         L5MbTi9poWxv4BvIh/HFDsQY6tNB0xP6vPx8gJt/1McROUp05M43iNwpbiz4crUXE6Zm
         b4gwg0eOsOOIatb4w0dVoWMdN4Bu0WBjvJAiiYL79wh0jsVMuelZI2NHlyqmfyw0XtdO
         +l9w==
X-Gm-Message-State: AOAM531JrqkbndgwwtpelF4s1JqpZfJFi8YxHCMbnLGxPFtH+jjbbukQ
        S3fBZczxkEJJOmOKNEc57Vn63pV89l93LL5D4YQ=
X-Google-Smtp-Source: ABdhPJxFAYA0CXfXdjHv8bQpKWNs1R3MBqkzhPoWs+xfubYSyeXpdJhq67FhKaBNpSzK+HG7GURSMwAUVGdkCZ0b2lc=
X-Received: by 2002:a9d:2c4:: with SMTP id 62mr1323520otl.102.1603188991679;
 Tue, 20 Oct 2020 03:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
 <pull.756.v3.git.1603147657.gitgitgadget@gmail.com> <28c1e488bf644786af071e66b73450baa47ccc44.1603147657.git.gitgitgadget@gmail.com>
 <20201020023857.GC54484@nand.local> <xmqqlfg1d22n.fsf@gitster.c.googlers.com> <20201020031509.GA56322@nand.local>
In-Reply-To: <20201020031509.GA56322@nand.local>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Tue, 20 Oct 2020 11:16:20 +0100
Message-ID: <CAN8Z4-V05AXvxBktMim=m8v3CyL5_HmcuicAb8jY+UuqkWL4Tw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] perf lint: check test-lint-shell-syntax in perf tests
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > test_seq is fine, but I do not think tac is portable (only saved by
> > the fact that not many people, especially on exotic platforms, run
> > perf scripts).
>
> Serves me right for reading while I'm tired! I glazed right over 'tac'.
> If you need a truly unrelated file, you could write random data into it
> (there are some examples in t/test-lib-functions.sh), but I'd just write
> 'test_seq 1001'.

Seems like there might be some value to adding `tac` to the perl script
check-non-portable-shell.pl - though I'm not sure what we'd use as an
alternative. I'll leave this here for now for someone else to handle in
a follow up patch series
