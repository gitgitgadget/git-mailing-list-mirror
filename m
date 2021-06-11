Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEF1C48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB6F613D0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFKReS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhFKReR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 13:34:17 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC86C061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 10:32:19 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id x196so6550602oif.10
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 10:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=MGp3Z6QUMIAEAXC6lWaILQD7bFXfXbtI8cGCpIyD0FQ=;
        b=dj7M8ibWQ7wyZWqjE9wzZueJ3SkoVqvannfet9zXEjY6K9E41LHNTKU+qUHWBmrguP
         l1vmeSY82tiLycUf96A1ZfvSBnO5EC/pgK/GMqNGc+rMy87q0hWqyNZTNF27wKLMxS0t
         RIFV7HLDsGu+BQLtTIjw8/i+/KqZhzS4T4JJXquZ/xUag8YZKuNQvUtSphTZOAzgNYlH
         5wBk9F71GUbeKS+xlnMVodxkeRniPrf6L8Ac6WZrU+2YtMbPuSw+eyullnUQqYhxe3mB
         iDHMjaCVsBxFX9ZDxxl3/XXAhMku4QIUovY2FNNLOJg+Yhf/RkNLPo49Llj3lOTGVAAd
         ZgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=MGp3Z6QUMIAEAXC6lWaILQD7bFXfXbtI8cGCpIyD0FQ=;
        b=ROlCIuRO9DvDmL49GUBZo+SCep22yTmxqPKy3sxm89VNQmckYD2HB2agMtFwKMqymv
         fqkFD1SvXOOE3eTo8vtbZSVBR9LEFd6+l5aH+HrHdqM8ITQPqADGaRyzYPBDaIvZInpy
         eKr000Zn6wX121LQqR5oSDFNEUb8yDBiELMBdF2FYSecOcft2x8j1CF/r0sqFmh/LUGM
         2sEW+Xq9BkIudymWxOPoX/r/SPiPK3H9Vjcl7ALsgnTBOrBep1PMq2ra0PYFHXoYMGAo
         hYIl34t1v6iombaPt6egw/4rERYlxXen3fpwihqVc1N8aZrKvS82hkgMLreUMM4Y25xG
         WNBw==
X-Gm-Message-State: AOAM5324VIsmo7aQZNBDLD6Jn8PvVwjPrr5dvpwivdEn/nzwg0YmZm4+
        147UfHCuyiWqlgaIM7/6XRU=
X-Google-Smtp-Source: ABdhPJz+hNHf+Vhj9TAyeXkTpku6qQT9H6dc+c5UJrq5r7X80CEI10dEdSE6dDiRh3nhh6hEXH4b6Q==
X-Received: by 2002:aca:af90:: with SMTP id y138mr3263673oie.92.1623432738887;
        Fri, 11 Jun 2021 10:32:18 -0700 (PDT)
Received: from localhost ([187.188.155.231])
        by smtp.gmail.com with ESMTPSA id c13sm1448021otr.23.2021.06.11.10.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 10:32:18 -0700 (PDT)
Date:   Fri, 11 Jun 2021 12:32:12 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, David Aguilar <davvid@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <60c39e1c52c04_8d0f208b2@natae.notmuch>
In-Reply-To: <CABPp-BH0aRiSUw03nSK6jHRNQ+zcpUzr6WjeJ5GpdUCqCKxbag@mail.gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
 <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
 <xmqqh7i5ci3t.fsf@gitster.g>
 <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org>
 <xmqqy2bg3nqw.fsf@gitster.g>
 <07ef3a3b-4812-4fa1-c60c-b9085a268bc3@kdbg.org>
 <60c3724de35b4_3ad920839@natae.notmuch>
 <CABPp-BH0aRiSUw03nSK6jHRNQ+zcpUzr6WjeJ5GpdUCqCKxbag@mail.gmail.com>
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Fri, Jun 11, 2021 at 7:25 AM Felipe Contreras <felipe.contreras@gmail.com>
> wrote:

> > Personally I have never experienced what you posted, so maybe there's
> > something else happening behind the scenes.
> >
> > Maybe merge-ort changed something.
> 
> merge-ort made no changes relative to content merges or choice of merge
> bases.  (In fact, merge ort doesn't even handle content merges; that's the
> xdiff layer.)  Even if merge-ort had made changes in this area, merge-ort
> is not the default and I didn't see the necessary config tweaks in your
> list of config options.  (I would have recommended against people using
> merge ort until 7bec8e7fa6 ("Merge branch 'en/ort-readiness'", 2021-04-16),
> which only made it into a release last week with 2.32.  I probably won't be
> recommending it as the default at least until the optimization work is
> merged and it's hard to predict how many more months that will take.)

Indeed, I tested on v2.25 and found the same output.

I thought of merge-ort because 1) I've never seen such kind of output
before, and 2) grepping the code I thought I saw merge-ort being the
default of something, but now I seem to be unable to find where.

> It's more likely that the codebases you work with just don't have
> criss-cross merges.

Yes, that's it.

I don't see why people in these kinds of codebases would like diff3
doing that by default.

Cheers.

-- 
Felipe Contreras
