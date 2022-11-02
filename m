Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA67C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 17:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiKBRY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiKBRYz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 13:24:55 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03257C1A
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 10:24:55 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y6so12614967iof.9
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 10:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4fAyW8rksXE1Ikv3VQLW/j207LHdBQV+fqvrR3bH6kY=;
        b=1jcV4VCqhIbuQ5SR649FnlBHuW90WtU3lTpm316t+cSrSPzKSBZnW7jfI8NRBi09Hk
         MNTmU5r4sVCUiuBTumyLam+Dppil6qcfn2/RynTlyyQX2oYU4XNzLl8GW00+Hl3GAb+X
         J+sLyRfDB7Dr8YiQ7JxtCAVV/li/awZlwr7w17XBeBAPicPtoZR4kD4w5FrX+C38LRFJ
         PJg8u3lfkwNWP80JZRGJlv++8g6aSwDqOWLIUuSaFA4q4I+59/8lmPSO113FjneFsiIb
         RwQ7iilI2jpThLDISYR2Txp2j7yjb0abHzZyi0RjcOBKIkrOM0av+yxI41pEenQgeZSG
         SROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fAyW8rksXE1Ikv3VQLW/j207LHdBQV+fqvrR3bH6kY=;
        b=hYKGxCQpbBpmQEWhnOjF68ff+8ASLNMguFby+EgP95usXdBpeqphB0OQfXkxfmblHU
         oPngwy2AgFqJLr8wF2/Nf1jp6EfREhphe3ToJGl9GNNUoP9R8Ylb+QPwjZBCjyxQ839W
         OW0Xuw10jBZkc8/fmpjFnYz8FGE3ejzCQFFIB2dtRyxnZGPyxejrj3zegEF0ovQQlyKc
         Rw0pbaJXYtJ7s+AoyaSWzDYFzoVjv845e1Qbt6868NBT3A9sXHJw7JS4Bdgo05/70mxo
         CeYS5zgrF1pimKzcBAdeenawhyk+vT0ft/yoSyC8Lgzd0LtfTs4SHFeSfVc3ypPgbqgy
         x9VA==
X-Gm-Message-State: ACrzQf3oaNVU8g+BL1uZjsKV514UFMDad245eQb+zwxj5vanEkLQSOdC
        WLgxWcLMLH9D+bLzrXntbo4+Jg8YPwtPY2E7
X-Google-Smtp-Source: AMsMyM4Qj2gMAc2EbrryBFsfD5RpOfHBz/ptClkDjWzYxaWawDJDdyRj+tv/2WLvC/LzfNJHIQ/nJQ==
X-Received: by 2002:a6b:3103:0:b0:6ce:e628:dba9 with SMTP id j3-20020a6b3103000000b006cee628dba9mr13267747ioa.151.1667409894248;
        Wed, 02 Nov 2022 10:24:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x6-20020a0566380ca600b003495b85a3b9sm4977370jad.178.2022.11.02.10.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:24:53 -0700 (PDT)
Date:   Wed, 2 Nov 2022 13:24:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ab/misc-hook-submodule-run-command (was: What's cooking in
 git.git (Oct 2022, #09; Mon, 31))
Message-ID: <Y2Kn5MVQojz33cta@nand.local>
References: <Y19dnb2M+yObnftj@nand.local>
 <221101.86iljz5z7l.gmgdl@evledraar.gmail.com>
 <Y2BlK5uhCy77Ot4Z@nand.local>
 <221102.86h6zh2rxf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221102.86h6zh2rxf.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 06:13:51PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > Yeah, I agree. I was mistaken that GIT_TRACE truncated its output when
> > redirected to a file, but it appends. So, the series looks fine to me.
> >
> > I would still like to hear from Emily, but otherwise I don't have a
> > problem starting to merge this down.
>
> (Just looking at what I can & can't unblock)
>
> In case that's a "let's hear from the author" (understandable) then this
> is entirely my work, even if it's her in the "author" header.
>
> Her last version of tha commit was[1], but this entire test is from
> my[2] re-roll of that topic[3].

Fair enough, I didn't realize the original topic in [1] was so old.

Let's merge this down.

Thanks,
Taylor

> 1. https://lore.kernel.org/git/20210527000856.695702-8-emilyshaffer@google.com/
> 2. https://lore.kernel.org/git/patch-03.31-1ad4e69f7da-20210528T110515Z-avarab@gmail.com/
> 3. https://lore.kernel.org/git/cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com/
