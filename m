Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE75FC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 14:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbiHVOsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 10:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbiHVOsE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 10:48:04 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B2D33A2F
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 07:48:02 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id i7so7978868qka.13
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 07:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=PHcjJgeMa1QXDEYK7qkVC8ZcZ6R1bwBTgSTctnM9BLs=;
        b=2MF+h7y2VlIrq2mITQVCaZUU7zNRwmFaj8k+vLxKC+LvKlEFhA2HVoObgXyaKfY1GN
         TyRGXqaWR2h5+ynTSkp8Sxgwt2jNoMIGS4s8jdGU9rrDoY+l4UYsrbgNKHNcYvlZY4oA
         BYOUaM3/OtyNGDhGPguZM7R5rxzZdAI9wZYdpxKFMx8iJjKOR44MO+vE7B3LIGBOMPOn
         rk61l3zpDpRFl84xQFfTVM0CMy8IsiWY1dagQCoCMIRnx/ggyQI2RBEYHIt+SZ7x4eee
         Ef+rxbrwer+IEeIA7WjnwVkfB3gRBQjURtHgv04RkY1+zm90kefHixbjyZeXhzKMgq8D
         zQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=PHcjJgeMa1QXDEYK7qkVC8ZcZ6R1bwBTgSTctnM9BLs=;
        b=IRIwxXQNLBJDObukcMnR1oIaNwnEm4gOPPPMYMN4p9gf6+4CgyALmupgB44VWvOmoW
         bfy/bxK6BWRwGt0ZBwCWUxIQASC06o8d26OSnulDMTSuYzTdGsYCrIfw8hsVqt3modib
         1By4p40U/yPknYt6R/ornZNDj31TJyswbr0lrQU2Xn0UeQEnqEqdRXwL5xLym9vSg/2A
         aOi94WcHlENQ4lJWktjSsA3Fy/ijOJUWcd7oGLlX8DK3dlvADNrywB99MUIVIJWuYZVz
         /iEc2fvmyhyd0cOWI4WaiwLW2Cs5CHhJlIfDRbUcXNXLvWr+BRsj0vyy61/Krs9uyC4H
         BxnA==
X-Gm-Message-State: ACgBeo0+2wdrJQXwBSvV7sKJauT0jzzVAMZNYyZUtmXdBWfILyHdtI/6
        r6nlPI2dgfu2kg9qek9AUyfcPA==
X-Google-Smtp-Source: AA6agR5eIikBnJR7yBIqGr+YJnJ83gEHYk6t7V/+ati5sZDD/GW0Se414euHSeWN97qhLrdJlTAF9A==
X-Received: by 2002:a05:620a:1650:b0:6bb:29b7:198c with SMTP id c16-20020a05620a165000b006bb29b7198cmr12709861qko.552.1661179681797;
        Mon, 22 Aug 2022 07:48:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h15-20020a05620a244f00b006bb9381aee4sm10835589qkn.30.2022.08.22.07.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 07:48:01 -0700 (PDT)
Date:   Mon, 22 Aug 2022 10:48:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v6 0/6] [GSoC] bitmap: integrate a lookup table extension
 to the bitmap format
Message-ID: <YwOXIE8K0GJRLuDT@nand.local>
References: <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
 <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com>
 <xmqqlerkj5f9.fsf@gitster.g>
 <80852679-rsso-rp45-q328-99n36q0639sq@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80852679-rsso-rp45-q328-99n36q0639sq@tzk.qr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2022 at 04:42:49PM +0200, Johannes Schindelin wrote:
> Taylor contributed <cover.1660944574.git.me@ttaylorr.com> to address the
> bug. While he seems grateful for my help, I am honestly puzzled because I
> lack too much knowledge about the code to have been of assistance in any
> meaningful way.

I was grateful ;-). Your contributions were quite helpful, especially
making the bug more easily reproducible (doubly so since that test
*could* have failed on master since its introduction, but didn't).

Pinning down some of the effects of the bug and documenting those were
helpful, too.

> My participation in this thread should not be mistaken for a review: I am
> woefully unfamiliar with the bitmap design (let alone code) and would
> therefore not _dare_ to offer anything that I would claim is a code
> review.

Reviewing Abhradeep's patches are on my list of things to get to,
hopefully today. I had hoped to get to it last week after getting back
from vacation, but was stymied by the aforementioned bug.

Thanks,
Taylor
