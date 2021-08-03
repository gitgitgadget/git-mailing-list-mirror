Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B86C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 00:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 194B360F94
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 00:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhHCAoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 20:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhHCAoT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 20:44:19 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7914BC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 17:44:08 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id a19so33414qkg.2
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 17:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z5PvUhKeZm00/d8OwLHklpSgXWWIUXNg0WbNxT50TnA=;
        b=R8eU6R8l33eQl7+yA1/232dGdMdkBZBtRkcAPfrsWF2TFnRlgXp/QzplFkbRSXJDDU
         0cGpLipGivQk4yzS/W14BtKm0dcKu5LKI9uRNdovjXymSdYbLquDDxcc4kHkT5kvISjf
         mZO+mRBYX9qSWxr2ejIGnwwGBZcqxWU69dd+D8HD6CAFQfj2AYUyBYjQh9O3Ft1lBjD2
         60H/fDsFEGOsImBT3kIVjoeuVn5PWqlXcRLM47oq+BSyP8T0gitGg8vJZmrnIxgtaknV
         EIig7SEskOux8K73UBF0IQ+99+OMfyGCPb3MdDev8Edcmny299RMpfhC14b/kpzBQBXx
         d1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z5PvUhKeZm00/d8OwLHklpSgXWWIUXNg0WbNxT50TnA=;
        b=sCc4tPe42EX3hRpy/ReiVZEyyvHWIW5WiUk2zcrcwu+upSWNC+8bH24xllSoEQaX4t
         iEc5ize48Ak/4s+CeA4xzMcSW8bA+kkMAgQSA35Xf14an0sIzQ8uF8zh2UrsbSH69RI5
         Dl2hbTaBpZuprCYi08WFQIk222vxtlBEvFE/uOEs4BObtvPNxDL6PxefqfTRh0ZpVSP5
         15vFKkn0gbUgOWzfSxn71Q+tikZKo1FC13g6yWOSD27brre+gB+eaPuZqHozLzmdGLgh
         NTZzzjhdUvkktvrUZ/yWuO2Bcc0Zj2HRYzkECqp3zwW8UcPLNH18gQLO9Sz1XSEHlJuf
         JzWA==
X-Gm-Message-State: AOAM531PfiYKONfq+dyxLK6rEaVkrG2hJnyY7XtjvAVs7xOFseL1+rMW
        atqdaq4ATXezMpSHF2rEkrU=
X-Google-Smtp-Source: ABdhPJyFVMYvXbeM6FHMKzOZw9LicF3ScMflEJBA20uhOJWLNjxdtBWTHYBs+kwLvjJNK+KrTxvDnQ==
X-Received: by 2002:a37:c11:: with SMTP id 17mr18699583qkm.1.1627951447705;
        Mon, 02 Aug 2021 17:44:07 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id w18sm1568889qtk.6.2021.08.02.17.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 17:44:07 -0700 (PDT)
Date:   Mon, 2 Aug 2021 20:44:06 -0400
From:   Ben Boeckel <mathstuf@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 4/4] advice: remove static global variables for advice
 tracking
Message-ID: <YQiRVhofZktlBF22@erythro.dev.benboeckel.internal>
References: <20210731022504.1912702-1-mathstuf@gmail.com>
 <20210731022504.1912702-5-mathstuf@gmail.com>
 <nycvar.QRO.7.76.6.2108030007060.55@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2108030007060.55@tvgsbejvaqbjf.bet>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 03, 2021 at 00:09:25 +0200, Johannes Schindelin wrote:
> On Fri, 30 Jul 2021, Ben Boeckel wrote:
> > All of the preferences are now tracked as part of the `advice_setting`
> > array and all consumers of the global variables have been removed, so
> > the parallel tracking through `advice_config` is no longer necessary.
> 
> Maybe add "This concludes the move from the old advice API to the new one
> introduced via c4a09cc9ccb (Merge branch 'hw/advise-ng', 2020-03-25)"?
> 
> At least this reader would have found that helpful.

Agreed.

> And as I mentioned in the review of patch 3/4, the removal of the
> explicit assignment to the `advice_*` global variables should be moved
> here.

I addressed this in the 3/4 thread.

Thanks,

--Ben
