Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB749C433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 14:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380124AbiD3OSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 10:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382790AbiD3OSl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 10:18:41 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985BD140D9
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 07:15:19 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-deb9295679so10697966fac.6
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xwLotVDdPN5HA5U8GdQCzTsoof9jJPCvNkZisycFsmU=;
        b=MGK5gRVGunZPNgX7fZKNuxY+nSKWekifwdTcRprNyKKS+3wJe+Jm0HIzfvNi8weHnX
         ZtcNUQPwqtg6IH4UxJUVyyCk7jTJXKmthKTU1zNJ1Ye9VRKljT16gDfCipwdZ/ThIni2
         V5ZAKQ1gAR+ltBUsrrEv5tJ7tJaApLh8kGCvjsP6125/ch1W07tmHsQQI1KRJ6PfXpUi
         B4lkMT4wwFqGK5TSy6cF4ahNK2UPC3ivWZkI4cx5PfULF3q3l3vWaEffpFrp6mGnGfT0
         8LO73BisNXQDIdbmFkt5g+UW6ckp+MjAFA1uOgGfC5G8nklp0tNRn2Owt98I4xyaqDFW
         nNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xwLotVDdPN5HA5U8GdQCzTsoof9jJPCvNkZisycFsmU=;
        b=0s7AK5b+3/O/wHQejNTrosceEm1rrVnUvkfkuncg+vFHgVouOR6/Jye5UbmIOawbtO
         hD/8GU+iLQL7pkXadiMDJ3jEKLo7jZGZVCKs3XCVyTJprsTS3WHIzH/5Tlx6SYsb+Mlv
         z7Pb63nd/oAQCVYI1mfHlkDDb5npNs0z4yMpRNs2Q8zOTjB3c0ikkykP8TcmKA3E7dUT
         Y9isv6pXjj3V9AmVJFI5uqB29qDsrJCDHx9Cx0FPuSFFGIIDuaA9cdq+RGU+zZQitcnk
         BdyD10m/jAK7NmiaFOStcRAyP+ULuJRjfj1kEsrQ24mrLBIDNPz5sKsdIGMEtWNLurWL
         RWSg==
X-Gm-Message-State: AOAM5313jzvsGEbD82lBMmrpalLTxiIxQpQ1ln6/fCBUtwUnoSqe+VFp
        VS/STxDxXae4+cFJBDPR0Ano30BYjvw=
X-Google-Smtp-Source: ABdhPJzB08Md1zaOA3anDwA/i3d+tw0VxbmUyMRIWDQCfrOLMqXiDI0PkZo1OgMHH5PcN6pG2hZBHQ==
X-Received: by 2002:a05:6870:d68e:b0:e2:af08:6cc3 with SMTP id z14-20020a056870d68e00b000e2af086cc3mr3453481oap.189.1651328118174;
        Sat, 30 Apr 2022 07:15:18 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id k3-20020a9d7dc3000000b0060603221261sm928364otn.49.2022.04.30.07.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 07:15:17 -0700 (PDT)
Date:   Sat, 30 Apr 2022 07:15:16 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Documentation: explain how safe.directory works
 when running under sudo
Message-ID: <20220430141516.u5yeznmmbxwaki44@carlos-mbp.lan>
References: <20220428033544.68188-1-carenas@gmail.com>
 <20220428105852.94449-1-carenas@gmail.com>
 <20220428105852.94449-3-carenas@gmail.com>
 <YmzUirQlDR1942rH@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YmzUirQlDR1942rH@debian.me>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 30, 2022 at 01:17:46PM +0700, Bagas Sanjaya wrote:
> On Thu, Apr 28, 2022 at 03:58:51AM -0700, Carlo Marcelo Arenas Belón wrote:
> > In a previous patch, the behavior of git was changed so it will be able
> > to find the "effective uid" that is required when git was invoked with
> > sudo to root, for example the internal calls made to git when calling
> > the following in git's own repository:
> > 
> >   $ sudo make install
> >
> 
> That is building Git, right?

Technically, installing it.  The full report is more informative of what the
specific impact is, which I obviously forgot to link to:

  https://lore.kernel.org/git/20220412180510.GA2173@szeder.dev/

Another example of it (which started this whole regression fix) is available
in:

  https://lore.kernel.org/git/4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de/

Carlo
