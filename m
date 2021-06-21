Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67921C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4484760C3E
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhFUQBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 12:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhFUQBr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 12:01:47 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5AEC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:59:32 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id s17so11629260oij.11
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=dznv7Lfbt4LiRAILrU1zkRKjZi2FTKFu49gX/U2qyvM=;
        b=DaR9JulQ6TCb/61it3XzpBwxhx34ojHkde3FbXwrE7Djld9OGD1RDYF9GVU8W4dgwx
         OwWtgQsnOU9sOU7u65+nXdMtf4QyY/n3644E7nCUiz/6vQYLWAb3gamWrefRu+iZWvhH
         8Inm7RvlWdKmAC95Wf9OoBb4sLPCEWzVYWgauxufbdOlmW6QEfDHNu31wgks0Qlj1Nsh
         2zHx39NlkyEsqAae+JEcump5pWfBEDCNYbRZwFid/tzsaQmqfNakMgdyzY45BH+h5BMI
         nvcBsuuYcfgQAYJE48eNF7UCdQf/ZJXO87iCe8aodvGVKcBiow7pbfkrou6OSFPGvXBp
         Ghrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=dznv7Lfbt4LiRAILrU1zkRKjZi2FTKFu49gX/U2qyvM=;
        b=KcTldGJ/OL1ydgTMwu67uCFKXftLErRJb4O08q0hd8hvYJb62zg+KeU2gCppgZrAsf
         3kKZbRcXRuloLks54do6mKFkyqhJsL+2kMbMHQg5syQRJbXU6NpRt/rH+4CJix4KyTwK
         4ohFAds+HiT4QtLqYEplqJVmfPlbNrl6Hopa0tUR9uWcoe9w7TVtAahaQuTAEVIkzFlA
         ARe6MIpkqDPI1ErH9f8bjfLwQAFbcZymsGT7lVdMHhizvjJUFOdxa00o2G6PjoiNH7Ku
         wb9Rkc857C6wIBN4ahI90coQSF33lOkiKeJ4XaYuqMna7nxjuM6ZqRduu/UVFuVkpLDR
         +tqg==
X-Gm-Message-State: AOAM5315Nc1T+3tkTKt1pNw28D5g6uhMx08+WAefHHoImoPlJgt99g9v
        tz7ty/mtt86PbLOZwMgQnlo=
X-Google-Smtp-Source: ABdhPJwWn/px4B5Gc8LxBgFq3nol9oZ4w3YL/9gZ99J3Y3rbEC/L1qMVEWd+Lk0dl+XsKtnHM753lQ==
X-Received: by 2002:a54:4503:: with SMTP id l3mr16044155oil.156.1624291171613;
        Mon, 21 Jun 2021 08:59:31 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id q26sm3732351ood.7.2021.06.21.08.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 08:59:31 -0700 (PDT)
Date:   Mon, 21 Jun 2021 10:59:24 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60d0b75c80635_105b452089b@natae.notmuch>
In-Reply-To: <patch-1.1-a950ef49e28-20210621T083254Z-avarab@gmail.com>
References: <xmqq4ke8pig9.fsf@gitster.g>
 <patch-1.1-a950ef49e28-20210621T083254Z-avarab@gmail.com>
Subject: RE: [PATCH v7] help: colorize man pages if man.color=true under
 less(1)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> From: Felipe Contreras <felipe.contreras@gmail.com>
> =

> We already colorize tools traditionally not colorized by default, like
> diff and grep. Let's do the same for man, but only if `color.man` is
> explicitly set to "true".
> =

> Unlike other `color.*` output this colorization is not enabled by
> `color.ui` being true, the user needs to explicitly set the
> `color.man` variable to `true.
> =

> When it was proposed to treat `color.man` like any other `color.*`
> variable some thought that git opting in coloring for an external
> program such as man(1) was a step too far[1], even if the user invoked
> it via the "git help <topic>" wrapper.
> =

> So let's make this explicitly opt-in for now. As noted in the
> documentation we're leaving ourselves an out to turn this on by
> default in the future, or e.g. putting it under the
> feature.experimental umbrella. We probably won't, but let's not
> promise users that `color.man` will forever be a special-case.
> =

> As for what this actually does the effect of having this enabled is
> that a documentation blurb like (some parts elided with "[...]"):
> =

> 	NAME
> 	----
> 	git-config - Get and set [...]
> =

> 	SYNOPSIS
> 	--------
> 	[...]
> 	'git config' [<file-option>] [...]
> 	[...]
> 	The `--type=3D<type>` option instructs 'git config' to ensure [...]
> =

> Will have "NAME" and "SECTION" shown as BOLD RED instead of BOLD, "git
> config" and other '-quoted parts in BLUE UNDERLINE instead of
> UNDERLINE, and `--type=3D<type>` and other `-quoted parts in RED BOLD
> instead of BOLD. The "Standout" setting is then used for the user's
> own search bar (invoked with "/") and prompt. See [2] for more
> examples
> =

> Normally check_auto_color() would check the value of `color.pager`, but=

> in this particular case it's not git the one executing the pager, but
> man. Therefore we need to check pager_use_color ourselves.
> =

> We do not need to support `color.man` being set to `always`; The `git
> help` command is always run for a tty (it would be very strange for a
> user to do `git help $page > output`, but in fact, that works anyway,
> we don't even need to check if stdout is a tty, but just to be
> consistent we do). So it's simply a boolean in our case.
> =

> So, in order for this change to have any effect:
> =

>  1. color.man=3Dtrue must be set in the config
>  2. The user must use less
>  3. Not have the same LESS_TERMCAP variables set (we call setenv(3) wit=
h overwrite=3D0)
>  4. Have color.ui enabled
>  5. Not have color.pager disabled
>  6. Not have git with stdout directed to a file
> =

> 1. https://lore.kernel.org/git/87tun1qp91.fsf@evledraar.gmail.com/
> 2. https://unix.stackexchange.com/questions/119/colors-in-man-pages/147=

> =

> Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>=

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>

Looks good to me.

-- =

Felipe Contreras=
