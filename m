Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A460C4727D
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 14:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3FC20848
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 14:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBR5NI9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbgI2OET (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 10:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbgI2OET (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 10:04:19 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B97C061755
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 07:04:18 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k8so4659053pfk.2
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 07:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=F+Iod/JUbEzoeUXh7rnt6/F+LNHXN/4kiiLHpwjyzHE=;
        b=rBR5NI9CDi9U0ZIdKwnd7Fj7/+S8DyTpBy7f0HuyaVra5jDtVUh0PVKLozBM7yFVW7
         5QeSH+NEkVz6B6c+nC3nVLRjj3cItMlfTqueulTJ2hrwiCsZOs0qEX1/bOIRb9X4nhTS
         bMilk61J2dImNU56pJcCIkK4H9BXDvmMNRYeF5zvvR55Pm60en6B5zgJXtZi1s8tCB/W
         pd+dTJgeOREWJGKg4sWGmck8QrrrpkTLHHE8kHZR70ztGAxOoTCJ7wbpTv3wm8Fp0L5F
         x7wn1Bq7o5ctdq9yBOT3Mqk2z7yknQx/zf6HVo1GljtrxoOGL7PTw7CvX/Q9F3VwXK1c
         5aXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=F+Iod/JUbEzoeUXh7rnt6/F+LNHXN/4kiiLHpwjyzHE=;
        b=ujFXRCxTaqm2lPHm3MwcGqmS1PF0doRcS155NMLpX7iwTwmvodIamKVn0DxjWNkQh2
         YP51+eL7CQ/KNZXR4nImfY0yhEL5b3YYqcT3WUY13rN2IWZMDNTFtjqbPm8ME4M+bgW0
         IbIlqs1jEioA2OkHNd79pIiwnSbD0dpzfvHnCK/9R9iNdZs9INHTFkq7OSLDKLfOHtDz
         qWEoKhj77onAEYutACzsf49VRJMhEzUZEGsF32ILqRf5L6eRwMXSJNumtDIpSPiTgUkY
         IkK9U506iir2E+Y3TatwRYim5S2zydrwsiNYNwW2BitYm+EFVl7Yf//9aYlejNCWV/dB
         jPBg==
X-Gm-Message-State: AOAM530I55s4JVzMQpv+gfMpSRjWwthu+QN1/2vylrkdV+ZG1qdUPDCr
        GW1vr+GZXvw21wsGb9lVvafYx67e+KA=
X-Google-Smtp-Source: ABdhPJxzJZ6/5qYv6VVW8jGPRnA6lgiwj9wNX+hW7pqyz6e9Id4uhDvQ7ygUVAY5VwFgQutZMZTPQw==
X-Received: by 2002:a63:ce47:: with SMTP id r7mr3330766pgi.360.1601388257790;
        Tue, 29 Sep 2020 07:04:17 -0700 (PDT)
Received: from localhost ([2402:800:63a8:845a:d928:cf31:b27:22d1])
        by smtp.gmail.com with ESMTPSA id g206sm5577358pfb.178.2020.09.29.07.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 07:04:16 -0700 (PDT)
Date:   Tue, 29 Sep 2020 21:04:13 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 02/10] cmake: do find Git for Windows' shell interpreter
Message-ID: <20200929140400.GE20935@danh.dev>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
 <05b4b69fee2b8c32769dd72dea182cfb72a14876.1601044118.git.gitgitgadget@gmail.com>
 <CAKiG+9V=BGX4k_dM-5JzYmko0cZfYXuSxEk5-UuHZpAqaWoU_A@mail.gmail.com>
 <nycvar.QRO.7.76.6.2009260821260.50@tvgsbejvaqbjf.bet>
 <20200927022543.GD20935@danh.dev>
 <nycvar.QRO.7.76.6.2009281553520.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2009281553520.50@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-09-28 15:56:13+0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi Danh,
> 
> On Sun, 27 Sep 2020, Đoàn Trần Công Danh wrote:
> 
> > On 2020-09-26 22:32:25+0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > > > I personally don't install my dev tools(except Visual Studio) to
> > > > Program Files(because of the _space_), it messes up the Makefiles.
> > >
> > > Sure, and that's your prerogative. There's unfortunately no good way to
> > > support your use case.
> > >
> > > Luckily, the vast majority of Git for Windows' users do not change the
> > > default location, and this patch is for them. (And "them" in this case
> > > includes me, personally ;-))
> >
> > This doesn't fit into my view of Git for Windows' users
> > For some users that have the Administrator right, it's the default
> > location if they grant the Administrator right for the installer.
> >
> > For those poor souls that works for enterprise companies, and thoses
> > that not feel comfortable give Administrator right to _another_
> > installer, the installer will install into (hopeful, I type it right):
> >
> > 	%USERPROFILE%/AppData/Local/Programs/Git
> 
> Those poor souls that work for enterprise companies often have Git for
> Windows installed by default. And of course, that default would be in
> `C:\Program Files\Git`.

Yes, that's correct, but that Git is usually very old, and I'm not
sure about its layout. Obviously, you know better in this regard :-p

> 
> > I think it's better to offer SH_EXE as an OPTION, let user specify it
> > as will. And we'll search in PATH if it's not specified, fallback to
> > 2 default value if not found.
> 
> That's exactly as it is right now. You can specify `SH_EXE` (but only if
> running CMake manually, not via Visual Studio). If you don't, it searches
> `PATH`, and with my patch it then falls back to trying to find `sh.exe` in
> Git for Windows' default location.
> 
> So I think we're in agreement here?

Yes, seems good.

-- 
Danh
