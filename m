Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B39C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 11:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiGRLsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 07:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbiGRLsv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 07:48:51 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B458D5A
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 04:48:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id mf4so20726573ejc.3
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 04:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=rHLIoxRMqMjzgcReJd71m5tJp3bTuPRBTu4gXfC39fo=;
        b=NMSu3u/rcCqfdsX/sIWb30uqs1NIhkcMa/fJeO4WgerXZOJ75BPU4Km2IvBYCjtSqF
         +aSPSvTRdWcnuTlyS7jNJ9+xyBHaJ2tEmL3yKcBZwEcgjZ+91f7NwAcO5XCDbzrLu8cX
         L9/maJcYKKkMqFO++2aXS/wdZx2Df2otWqcFi7t4qKAhyKmRFS7xtqkzhT4x3C5nmv7d
         khfDk/iv/isILT567auMqW0sDV9cg954lXY3WIPyKCEIApS9eonYF3+2PGU8pL5IEfmK
         Dkk7ax8h8jmrdsICoEmO+IDFihnywpVjhPIqTMZCR+irzo0sX3RtunTzA5qQY/AD8mT4
         tJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=rHLIoxRMqMjzgcReJd71m5tJp3bTuPRBTu4gXfC39fo=;
        b=LjEb+wqlxOSdupRjRuS0qJLGK/0Zcky9AKGpEY0rKeQ1U4Ft1IVTcxa+hqVwPVa+wt
         hz1j+0EHHJKh4QT/2lTHuv39Shvl0i2h2odDUq1etNKytq5uSwqVL67Df1TcbesL3A46
         SJ3zkjKIpuJbfyH3lrmwGSI6eAXpR4UZodFne82rjNhuv828h1v1/ATctHB5h1Tri4TW
         CFjUMKil+TIiEhfvnt816cPW3NsKc9sXKIu53t/Y3kFX1ArcfOypNoCwtLevUv2Um4af
         wnFHh2ytLkTsoKu6BZxKZEPfJufYY/9ti2R4aau0PEfpOBTUs87jkIz3S6rmih+AEZi3
         NpKg==
X-Gm-Message-State: AJIora8fw4cXJzk+62v9qAKyD2yr+pVahb5GKeO13C2foKwgdFZ2OMHE
        ctcsF7rrgfcFd3w6NQU2qdPx9VOCttSNCUnXAtL2J2xL7ZrC/g==
X-Google-Smtp-Source: AGRyM1vTQ+nkQQgwqKrSoO1bCZZZfi+KjJIrelHUM+ZJqz572fFYBh4n/XqehLM55QAu6UlsJuOLDaSHzLbCMQjAT2I=
X-Received: by 2002:a17:907:724f:b0:72f:4445:3c10 with SMTP id
 ds15-20020a170907724f00b0072f44453c10mr1226328ejc.529.1658144926818; Mon, 18
 Jul 2022 04:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
In-Reply-To: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Mon, 18 Jul 2022 17:18:35 +0530
Message-ID: <CAPOJW5wVYcmTA6kpf=kGEofziq1RLCg2haCMrye=EXaPLzb7Tw@mail.gmail.com>
Subject: Re: Can I use CRoaring library in Git?
To:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just got to know that CRoaring doesn't support Big Endian systems (till now) -

https://groups.google.com/g/roaring-bitmaps/c/CzLmIRnYlps

What do you think about this?
