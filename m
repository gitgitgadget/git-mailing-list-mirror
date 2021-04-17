Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEF8C433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 00:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1858F611AB
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 00:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbhDQACX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 20:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDQACX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 20:02:23 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B34DC061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 17:01:57 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i10so11416896lfe.11
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 17:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=R08bg8rzPNTixVWWSSd+j9zdVafbfsSa5b8Zl/gLPqs=;
        b=oOVP64t8P94EHSPpLq/XaFouH23p7H5HaSTPZjs5l7NEgSvypSS/Ck2v4083mE4grF
         etNR65eT2yWUInUDlMgFz05E91mWvvdzPWpU+49yYjpoqZhnkcee989Bh6Dm3zmHiVFO
         r9rQuxKgYKYpYTHdwqR52IvQ1w1yK51gf2YeikTpNvsE5EWAtkrnHoQOA6UXMSO/yRwX
         L2MnUT/fEPqKI9YHB/PHpcKWkwkBTFIUDbWblZ5nMOpb7Xi56pF6Ifr8OpZE1sgOk6YB
         cpNJ1sHdCLvrWZaF7+/FW4aCQaabmzsMXlS92l9Zwax9sIjAWp1yv1lA1Zl0IkAPkfCS
         SjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=R08bg8rzPNTixVWWSSd+j9zdVafbfsSa5b8Zl/gLPqs=;
        b=jXRzLHiAyjv2s7uhRieJRo8WepagI8ogrHO4F0V6M9dfpJagy1AE8GaWZhUcAoY4O+
         hVNC/TMKynzXdyvpTXLDXzquvQEiJN4nZyxws6oXe0bUxmnn/+gCHMEAnCZIG3xFGWoZ
         gn+gRQEqTipJ4GqxvcsZKFKfP/UK3q1ourx+EvyAfjI+FcRfDmqIS/Bx4Y6X8cPmo16t
         zBDqU95wE2K8l65CJcwVgnVajBEK7zaNMDmZppyMyAfYpSBIWvBZ4TgkhoZP75OCKYlD
         vhBV5luII0thKL4t83eFH2VPvLptVhHSFM52+RFrjTJ7t3/MjlinCOY7e+fpvgpSWYLi
         aeJQ==
X-Gm-Message-State: AOAM533l0S15Veq+TXXyysynIqD9vssvh/mGV3IHa8MTVWolY/KI8Wl5
        Z13N4LxbQ+O00cJvN1Ie3Ye6Q7J5axtH+WggH1Xc8t9Agjc=
X-Google-Smtp-Source: ABdhPJzOcixbGtquGwuzT4NtgnnbER3uErcGoC0eRUZBWHHWbj8W9PtHm8gy4lglZr3azUKwoE9GHvAI23aIRWb0y4s=
X-Received: by 2002:a05:6512:22c4:: with SMTP id g4mr4537469lfu.501.1618617716084;
 Fri, 16 Apr 2021 17:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210416182121.3c824c87@pc.home.lkiesow.io> <YHobypuPjLTdjHIJ@camp.crustytoothpaste.net>
In-Reply-To: <YHobypuPjLTdjHIJ@camp.crustytoothpaste.net>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Fri, 16 Apr 2021 17:01:45 -0700
Message-ID: <CAPx1GvetNRBovJMF8tkk9obuSHjC=w9JqryrSTeA0rVF35Q5+A@mail.gmail.com>
Subject: Re: Bug report: gitk unable to handle Unicode properly
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lars Kiesow <lkiesow@uos.de>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 16, 2021 at 4:21 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On 2021-04-16 at 16:21:21, Lars Kiesow wrote:
> > - Launch gitk
> >     - Crash (see below)

> I don't see a crash.

I think this is a Tk/X11 interaction bug.

See, e.g., https://bugs.python.org/issue42225 (which has the same symptoms).

I'm no tcl/tk expert, but I vaguely remember other similar bug
reports.  They all turned out to need a tk-side fix.

Chris
