Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223A0C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 00:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiI3AmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 20:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiI3AmI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 20:42:08 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A814122608
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 17:42:07 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id v128so2187943ioe.12
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 17:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=puvYYMMVT5/u/tEkYe/MFmOM/B6hFDmn5imGngZB1CQ=;
        b=Nlj7h4Y2cuBapMEGXCMslaa/eyV1KOKZwZdeNVdq5ewJdBCdhJKlz5SFUu0nPn7FQo
         3s8RiPykwhpltLM9Yuvw4Mmjc9m2I3Vdd6YR2R0ofiSMD35EESl4mHwsPwnr3DFHq463
         KAZ6n+Hge6h1rXZ3VRQs1JwZNWjSsUr4zWA7gItWAmaacNkvEeh5i5HrCUYedO/Di6+3
         QH6FLTYox3i6rmzOk2UGLSXGdDjPcHU1owesJzyQeXffCLz9uq7np+EhQ2PhdhPfN2sh
         qltzR8HxSstju8CbYHbr8F7b3OE6KHgIkzwnVYZ5uJUQVM+r1yVJPVbdb/DsZ7qqiwv0
         8a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=puvYYMMVT5/u/tEkYe/MFmOM/B6hFDmn5imGngZB1CQ=;
        b=aTmZ4sJWvmoADNCMazdR89cPJLwObl5EnTCbb5KM/kcGlU7/kuD5+6ZfonE311ExHe
         vIbbdU6W/FBGeQYVFXOKkv/zQPO3LruYRqzsijvsh4As4hpcjQjmbC7WRZmAe0JaVjzb
         WyeouXHUqHmckOp4JVpBpnWE0xUXgLeuO3k00qTQOKY4LJR92IxlwYceQu6srcdBk1CW
         tiM/2gfFjIESl08H7lBryB6w9GcDtJNYcP1vGxzi7Ipgbr6qSjnN1cyNFqikZ5DwvbXt
         NFHse9Sdx2VuS0xoMCTfUqDvB6oz5aMkVWzqc/EeqieIT/KobVWXUpomMsAfMZrEavcG
         0qFQ==
X-Gm-Message-State: ACrzQf3h1HK+aMfyMynaIMlLZPJtptpU+Zy5hNnha95xvoWkDjd5VZXr
        JDni9j9Ys3eiu4ZohabLO0sNuw==
X-Google-Smtp-Source: AMsMyM58f5ExXZzD9FoGq00Hukh4BjRrdRbptL77PBsfiek8IJtPJoI0qP4sY2mxb3qwpgi6YQWkOQ==
X-Received: by 2002:a6b:8e92:0:b0:6a4:4799:3c80 with SMTP id q140-20020a6b8e92000000b006a447993c80mr2647597iod.93.1664498526956;
        Thu, 29 Sep 2022 17:42:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t2-20020a056e02060200b002eae6cf8898sm440650ils.30.2022.09.29.17.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 17:42:06 -0700 (PDT)
Date:   Thu, 29 Sep 2022 20:42:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tim Hockin <thockin@google.com>,
        Bruno Brito <bruno@git-tower.com>, Jeff King <peff@peff.net>
Subject: Re: Draft of Git Rev News edition 91
Message-ID: <YzY7XWHyI8waS1vd@nand.local>
References: <CAP8UFD2pG7f5-9eywHE4ziz7OKLZ_A9AnNnQEQvdvOTYvsdP+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD2pG7f5-9eywHE4ziz7OKLZ_A9AnNnQEQvdvOTYvsdP+A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2022 at 05:51:58PM +0200, Christian Couder wrote:
> You can also reply to this email.

Your email reminded me to send the notes we all took during the
Contributor's Summit a couple of weeks ago. I did that today beginning
in this thread:

  https://lore.kernel.org/git/YzXvMRc6X60kjVeY@nand.local/

You may want to squash in a link to that in your article, since it
mentions the notes hopefully making their way to the list soon.

Thanks for preparing these, as always :-). This was a delightful read.

Thanks,
Taylor
