Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3C5C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 17:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F32613F3
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 17:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhGPRHZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 13:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGPRHY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 13:07:24 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C8EC06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 10:04:29 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w127so11596089oig.12
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 10:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=IUj63Vkd4QuFmDAeIZ7/7p9HHXdKwohA5eJ5HBSxVPg=;
        b=QjuCJA5EGTy+DIyjtTGrlcF4pFf4wmqyFHCVvlvZvIcs+6w2sRVzHzHIt4TNr2dt2o
         Jd1DYrAIFUEU5kSSc/qBOizSmTxvT0lEL/8OzEqtam92eIO9WJAM9CAQ0imgzVgLeBPI
         OEJmu+n3LiCxsOgpE5WDR/2GUZMFudLZhzLR6JETwW7XAJCL9UuFxvTMIYAAre0wefbY
         L/hpaJkSMP3jXGgODlVPm+bCtPfokxKgX2g5FPMDyqmMFEGRHP0pk4nqe9f+yUp0mkR/
         pIVFBThBDOoIzoNc4eIKQZELEu0GdqAA7zIGjGRvZkeqIXIDQsbyOwBEgcoueWP8iJ7D
         dozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=IUj63Vkd4QuFmDAeIZ7/7p9HHXdKwohA5eJ5HBSxVPg=;
        b=bX7PSfnO13hffTh4noZbbdR1old8hFXdYO/yZ6hJSjpqJQOut6e16FHtMlhHRozjiU
         3shnt61qpUcmMkgCYAxd5KXCVtoroQnS++q3+dh/J1COfh834jvW1oBxrgF0lsXWjiz7
         fpFbMXzbm4XwbH4u0bkG5VKyg/+svK1ltntwXennDivjy+5HRar4IRE494pocWxTGaxP
         t4C2R/7NOdrrR/PH6G7bjk6bW+hFZeyf/8DS/QYy+pfCnNfWGSVheAbBGpCU2RjtbPAQ
         dDoGPSTrLokAPkzYvutK3PX4W9BjmYb0MFwKrAqc8fY8ClwkPYfwV/6rtF8gXdeA9DdY
         Z3JA==
X-Gm-Message-State: AOAM530tEVk0iCDJCwkpIezc4iEOGWcjgRKDh6NpwhjNiCRlPkz6AyVX
        rHEXs59AMDuHLRCyY3NQfCw=
X-Google-Smtp-Source: ABdhPJy06pyq/fj+wk9QQCk1VgepuanE2BruSZGl+0CJfflTNmPz8rAUXchCj+GZa7vmSGRsI6+NhQ==
X-Received: by 2002:aca:e107:: with SMTP id y7mr13184643oig.11.1626455069028;
        Fri, 16 Jul 2021 10:04:29 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id o129sm2161027oif.21.2021.07.16.10.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 10:04:28 -0700 (PDT)
Date:   Fri, 16 Jul 2021 12:04:22 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Message-ID: <60f1bc162a797_ade92086e@natae.notmuch>
In-Reply-To: <nycvar.QRO.7.76.6.2107161732150.59@tvgsbejvaqbjf.bet>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <5db2c0390a657d5790cf24404201505c4ec3a829.1625150864.git.gitgitgadget@gmail.com>
 <877di9d5uz.fsf@evledraar.gmail.com>
 <533d47fc-ea37-1e6a-b6f4-ac4fdd24555e@jeffhostetler.com>
 <87v95e2j71.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107161732150.59@tvgsbejvaqbjf.bet>
Subject: Re: [PATCH v3 02/34] fsmonitor--daemon: man page
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> On Tue, 13 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> > [snip =C3=86var's suggestion to populate the manual page incrementall=
y,
> > interspersed with the commits that finalize implementing the respecti=
ve
> > functionality]
> >
> > I suggested this because I think it's much easier to read patches tha=
t
> > are larger because they incrementally update docs or tests along with=

> > code, than smaller ones that are e.g. "add docs" followed by
> > incrementally modifying the code.
> =

> My experience is the exact opposite of yours: shorter patches are easie=
r
> to read.

It depends.

> > That's because you can consider those atomically.
> =

> No, in a patch series you cannot consider any patch completely atomical=
ly.
> Just like you don't consider any paragraph in any well-written book out=
 of
> context.

But you do not put every sentence in a paragraph.

Sometimes a paragraph can contain a single sentence, or a single word
even. But other times to properly read what is being tried to say you
need a pretty big paragraph.

> This all sounds like we're truly falling into the trap of ignoring the
> rule that the perfect is the enemy of the good.

Have you established that this is good enough?

-- =

Felipe Contreras=
