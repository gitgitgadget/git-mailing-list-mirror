Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28125C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 03:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiKUDRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 22:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiKUDRE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 22:17:04 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42791317FE
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 19:17:04 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y4so9425473plb.2
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 19:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfQCjmHUoI/WHid/Mq5sIulaeaEe3g+J1Gs5UnI4bYU=;
        b=Os0Yb02sybMa21ykGg2hDtxypxfUKM2JAq5yA18zZiijrmVQ0SGU60LHEwNG/jUBLS
         hnlFcxqBFC9xgT0Y4DJT8dZIgPMBSx0IA36MPmG+eOrFA3Nd9uyU9Mfge6tWJmLiwImC
         O7fGVwzoDnxyyHhD6o9J8/jVvVxt1T2pKcagU7+yJEjlR092UvTrck8cn+yVuVOkKUb1
         u5FkhyTdanDibO71lhpSAaFAvJrsWbcotLJfo/boHU9HiPgrCCrzDArE8f1pWYCxDcE2
         ig9LcdUjDINukrsbdCTznql41/ocSRISfnMBOKLsNbvW+1wauVBgS1efvIYXBshVVIG+
         LMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JfQCjmHUoI/WHid/Mq5sIulaeaEe3g+J1Gs5UnI4bYU=;
        b=IkmRCOtgsqTA9CJC789iDZBQMUUozmcnCvooIeFmon7kP9e543RGbUHAVRwocY0SxI
         DF+L893OLjzshfIb2RzgGZnXuGyA/YoCfrsH/h3FuobgqoUqu1dOHbv9lGs3+Ol22Ur8
         cWNI1N3Rup2FPcpsPHWD4AotgUw3nGleLy8j0HUtDOLnrnJDSjVdex3+nY6M1zV4MPBU
         n3YgxUNrYeB9H8oziQ/n+FgtiZxwdgXka17GaEYy02tCyP8H6f2JI60jVKC6/4LBfpf1
         Gs8t0CjoMt9hT7189gamIUOiNvP2ZUOjXTHwWVqpwxPQGInD7zqAv+owROGZPlDflK2P
         iFjg==
X-Gm-Message-State: ANoB5pnWMGDPF4nRpgpnRpxFWLAoUt1gqG7H4l83weRJPaINquMhsC68
        VuMuDuS4HTZPPW6YliTy3ic=
X-Google-Smtp-Source: AA0mqf4NkQe7JpLH4I4nFz4ErjvMCcMZeQir5KLvF+/YAhVnLXVxJgd8ODQAp0lJmRBHFjd+JmEiJQ==
X-Received: by 2002:a17:903:291:b0:186:994b:5b55 with SMTP id j17-20020a170903029100b00186994b5b55mr10191670plr.100.1669000623609;
        Sun, 20 Nov 2022 19:17:03 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id r10-20020aa7988a000000b00553d573222fsm6114910pfl.199.2022.11.20.19.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 19:17:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
        <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
        <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com>
        <221114.86tu31lnwr.gmgdl@evledraar.gmail.com>
        <pss2rp96-qr48-21p4-36on-ns04nnp0944q@tzk.qr>
        <221114.86pmdplbs5.gmgdl@evledraar.gmail.com>
        <xmqqr0xzkfz8.fsf@gitster.g> <Y3hF1vOQ8waqpvXo@nand.local>
        <221119.86wn7rdugi.gmgdl@evledraar.gmail.com>
Date:   Mon, 21 Nov 2022 12:17:02 +0900
In-Reply-To: <221119.86wn7rdugi.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 19 Nov 2022 12:54:31 +0100")
Message-ID: <xmqqtu2txahd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Junio's pointing out that a test that would do:
>
> 	! diff a b
>
> Is pretty stupid, why would you want to show a diff of differences, if
> you're expecting it to be different? Just use:
>
> 	! cmp a b
>
> Or something. That's correct. So I think probably those "! test_cmp"
> uses would be good candidates for some clean-up to make the test suite
> pretty.

Yes.

Besides, "the outcome must be different from this other file" is a
very sloppy thing to say in a test.  It rarely is OK for our output
to be merely different from one "wrong" output.  Tests should
specify in what way the output must be different from the "wrong"
example, at least.
