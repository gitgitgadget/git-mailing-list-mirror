Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E79C433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 02:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C1D223BF
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 02:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="QSWMGKCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390766AbgJTCnd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 22:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390701AbgJTCnc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 22:43:32 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8C1C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 19:43:32 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id p15so798286ioh.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 19:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Je9eCEsJSjiE7xEvWwZyMhw9A8BCf1uhYpheAkDcEj4=;
        b=QSWMGKCiLW0ZEZC1seiG5pbCbBbfOOgeDhjJVWk4oqqbwbd6A/2wGbj1gfKZcmEahW
         naf9ykuxuoQpUohpYawbY+qy68nEuE0/XFAork8RSeGG3wx/mgSL6yrfk9V12AYBW1Ek
         mWI2qbw15+a7VXBEkupKa5FoI3BRxTx/J28d9nDk5XxSCKQSnl0gahIZtmsm59lDtdAO
         kKYIiK2F7HLWpNSCFhwV/lV05Cyl0vkEVS5VdwThAKoTDhVql9wveVhjICQjzK5Osm6I
         sLmCaaAKFX2yXM6XBHsHKAoSzmkMEIEhqG+9qo12qvrwrzk8uYh2OE/ZhCWF/jpFBZG3
         rVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Je9eCEsJSjiE7xEvWwZyMhw9A8BCf1uhYpheAkDcEj4=;
        b=I9r6qVtlK83/Zpkn2JCrnN7zMcx9ALM7+sVnQSGYdQno3rrliB+XYcDKIqbSm99o0q
         dsdEbctKBFkt8Y/yWCKkiItY9RG7jBZwVKqrdTDMeOcz72Kg2/wl1YYtYnJ/x1JDK/zM
         7Hj7C/3tUL+rsXIPzpAHAMDERH2L4PJjmB5IRYBCP+GJvy7OwFvZMGGjVrIirC4PDUg1
         Q73aGUuoIoGNyR9gdR5aYNTrRnnvP4pxaxumCXYl8SbyLvxnGPNunZK4CDjUSr4lwDnX
         76YVl9Yni1ESsv/68HGTn0xe7U8WdiBzL/6V2UZCu0xUwnlZyMywZqMT/PqGLqehx7ZS
         DRYQ==
X-Gm-Message-State: AOAM533T2ChSWLSTBznAsqR3FE8zBLFqeDrKAqrkuBIT8c7vCS+9jDla
        RbJu6vPHv2OeIlppZPSn+3DEmCdmgXc2pfZ3
X-Google-Smtp-Source: ABdhPJy0xZyP0FkqmZuGYa0WARYd6fiQIXLt2ihwSruH4ZOvnrgRt1Y4+h6mhFDtSRF9vwnxZi8WAg==
X-Received: by 2002:a6b:e714:: with SMTP id b20mr590663ioh.109.1603161812177;
        Mon, 19 Oct 2020 19:43:32 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:943f:d0f4:e8b9:b8f9])
        by smtp.gmail.com with ESMTPSA id n28sm628741ila.52.2020.10.19.19.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 19:43:31 -0700 (PDT)
Date:   Mon, 19 Oct 2020 22:43:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 6/7] p7519-fsmonitor: refactor to avoid code
 duplication
Message-ID: <20201020024329.GE54484@nand.local>
References: <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
 <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
 <b38f2984f93488d6582eff4865d6d5293491ce60.1603147657.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b38f2984f93488d6582eff4865d6d5293491ce60.1603147657.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 19, 2020 at 10:47:36PM +0000, Nipunn Koorapati via GitGitGadget wrote:
> From: Nipunn Koorapati <nipunn@dropbox.com>
>
> Much of the benchmark code is redundant. This is
> easier to understand and edit.
>
> Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>

Much easier to read, thank you for taking the time to simplify the code.

I know that this is maybe more review than you were hoping for, but I
think it's been worth it and the series is in an even better state than
when you started.

  Acked-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
