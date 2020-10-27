Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95BDC4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 02:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7275D207F7
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 02:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409072AbgJ0Cdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 22:33:31 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:41365 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394953AbgJ0Cda (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 22:33:30 -0400
Received: by mail-ej1-f68.google.com with SMTP id s15so12723580ejf.8
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 19:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8n+UJS83/oSOYxq7OPd8FMB20jLrY1EZtMyoNABTlI=;
        b=q+oP6hmoCEkQXS3drrwpiDV/IXdLkZ1PqTSx02tTIocqcIP6qGOBEq2JPbaWYF2JB5
         TuzmDOYkhZbIAYwC6qhNJ6Yn3e+EebIJ/0ZzyEkXhe2HcYfwHBZko41eM6/qct+xR7yA
         u6kTw8CkYVghkJvuTSIyr/s3QuRvm0szOi//87aITdXIJp5IWJ39XLWGZE4yXrsPfQ2G
         qUATbChgDw+3N17fTZC/aOy5kjiMfDyrMdglEb9mfMy2DUXShPV+1ZJcv8M2rCNvAuzM
         hnOIgdlIuDdc+EnkpKxdl1wH1SU+jBckxrnH65ucbSVeyIN4KbsIrUWuLfFBDhfHwJDI
         vthA==
X-Gm-Message-State: AOAM533WgzS2399mWnqKgD8bjGMWOFw8+nMh+3ARsLYT3e0EoM37F0Ua
        QqJVxMtA+tXaLFyPNgFZV/3A/EYhSLm8ci5mPRU=
X-Google-Smtp-Source: ABdhPJy8sxLz6RJyvvFNFrGuPWFy3dlJyAZRkYX618sZCzmpWFxHfDIB2d6NLNK0plpCbaXY/632o9022nQ+b5T9VU0=
X-Received: by 2002:a17:906:f24b:: with SMTP id gy11mr238314ejb.371.1603766008752;
 Mon, 26 Oct 2020 19:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.895.v2.git.git.1603731448.gitgitgadget@gmail.com>
 <pull.895.v3.git.git.1603764490.gitgitgadget@gmail.com> <3357ea415e3437966f15bf73fbbeb21cda3df592.1603764490.git.gitgitgadget@gmail.com>
In-Reply-To: <3357ea415e3437966f15bf73fbbeb21cda3df592.1603764490.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 26 Oct 2020 22:33:16 -0400
Message-ID: <CAPig+cTkxP=aaCi8YrxbSYptkgwSYG_sd+P6FiXmtA6xuXxGSw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] merge-ort: barebones API of new merge strategy
 with empty implementation
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 26, 2020 at 10:08 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> + * "Ostensibly Recursive's Twin" merge strategy, or "ort" for short.  Meant
> + * as a drop-in replacement for the "recursive" merge strategy, allowing one
> + * to replace
> + *
> + *   git merge [-s recursive]
> + *
> + * with
> + *
> + *   git merge -s ort
> + *
> + * Note: git's parser allows the space between '-s' and its argument to be
> + * missing.  (Should I have backronymed "ham", "alsa", "kip", "nap, "alvo",
> + * "cale", "peedy", or "ins" instead of "ort"?)

You forgot:

    git merge -s newren

the "NEW Recursive ENgine" merge strategy. I won't bore you with some
other backronyms I came up with[1].

FOOTNOTES

[1] Such as "Extended LInear Jump AHead", "UNabashedly Smart High
INtelligence Eccentricity" and "UNsurprisingly SHallow and
INsignificant Exception". Oh wait, don't read this if you don't want
to be bored.
