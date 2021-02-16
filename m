Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DF7C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 15:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57E464E09
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 15:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhBPPop (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 10:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBPPoo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 10:44:44 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2147C061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 07:44:03 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id z190so3849995qka.9
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 07:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t8B/oNYaXbQFt7gAZPUCQL7t8S+a8lTF3wmOzUoHfsQ=;
        b=RDMB7L5mrcNm8oIGyJ2oFqkrq/yzhNk6WA6rPEPtNAuBuS3UiE3kq6d9Ey87dj14Pq
         AUF6AaxyLaXsECvf/TFx5D7arwO/1LQ81HCC32YgvKJZ/JvFJtK4iCoiV4e0StyXwrKz
         kAfWm4em08SbtGP4QWOqFyOydkP+/ndH7Eqp31VTRsWSX3GalumCG/5/2Sq496x6zlK7
         eGr2t3j1Q1pXOhE5q8o3R24t+a3OCTUkAw+lZYF5IEj4bVKcb9k8RZSiD9Af4nYDifkl
         yiAtHhZEsWTbshgn2gCxkQNAkeQLLUc3Dc0epdfew5BUcl8f6d6vyOQkhZdSphWHMH/u
         fPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t8B/oNYaXbQFt7gAZPUCQL7t8S+a8lTF3wmOzUoHfsQ=;
        b=gRA6okEXITTOJYl8yEUvj61qP6xsuxy0DITPbE5EUhkmeCuqqGVVuLzB9hnmhS667N
         uujoKpeVSrZqCLnACH0htj5JaSdqrO1fGW2jYQcoJlPvYEtsQChk4GsrnCdMqaJ8JjEV
         UVUYF70nrh6uJ60kPorOqXHMpSze1s66HfQIm18ZVQrc1oG7iNI/KkWyJ9piNBPw6qjk
         Scl/zmKOcDqWpytmGqjAZV/+odWBYXIKWfTxft16Z2GP0vdFKuZccC/pKOdcm7ZUzhWZ
         FB7mSA6MpeyeNfkfY/ybMVxlsGHeXkyPj49nFEebVGACb0xo/RBti5E1LJsb4Ov3cd/8
         6fJw==
X-Gm-Message-State: AOAM530oFsMKHCRYvu7glXgnoXwqZ78hnm3854H6c7SHOSH53ktwBMAa
        h88joC7Vm3+C6GKnuDta+9kuRA==
X-Google-Smtp-Source: ABdhPJx41fK4r/j9bRJoOmDIHot2KoNCjriOdQqTaQAZuHVVhR7yfDS5Sw9HtBj1ePqr0Q2gAHWnVg==
X-Received: by 2002:a37:48d1:: with SMTP id v200mr20690216qka.159.1613490243263;
        Tue, 16 Feb 2021 07:44:03 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:c1ff:146e:b5:8cba])
        by smtp.gmail.com with ESMTPSA id l137sm14834967qke.6.2021.02.16.07.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 07:44:02 -0800 (PST)
Date:   Tue, 16 Feb 2021 10:44:00 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Blake Burkhart <bburky@bburky.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] add open_nofollow() helper
Message-ID: <YCvoQBhmCeeR9Cup@nand.local>
References: <YCvaJg8o882IqNnx@coredump.intra.peff.net>
 <YCvaRpQs99TBaCrQ@coredump.intra.peff.net>
 <YCvcoPnDAEWNcv+h@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCvcoPnDAEWNcv+h@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 09:54:24AM -0500, Jeff King wrote:
> This is all on Linux, of course. Perhaps other systems with slower
> syscalls may be more impacted.

I timed it on macOS, which (as you know) I don't use for daily
development, but it's a useful testbed from time to time.

On your branch, 'git check-attr -a' took 193.4ms with O_NOFOLLOW, and
245.3ms without. After touching every .gitattributes file, those numbers
shot up to 340.9ms and 346.6ms, respectively.

(All numbers on linux.git, of course).

There isn't an apples-to-apples comparison between my numbers and yours
(since my laptop is much slower than yours), but the relative numbers
are quite clear that only doing a single syscall is worth it in the
non-pathological case.

Thanks,
Taylor
