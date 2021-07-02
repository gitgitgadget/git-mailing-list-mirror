Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B188C07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 22:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D7861405
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 22:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhGBWfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 18:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhGBWfd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 18:35:33 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A287CC061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 15:33:00 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t80so13092637oie.8
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 15:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=L1CXQEVZZhus4WmzXkvBj9HDuo/nBBLiIzDVKG4jifM=;
        b=r/USx4kuxTtlAVoqD61zNGd/X5AiVZ/2+67gxSfkcX/1/4c52xkDGAEWfEfqvb4mH7
         3mM55+eJ3gieIuF25vetRGEDJJpdtqd2oiwnnoq7H77Zf7KOUmbnenBuzzjkA3EsP4a4
         VAeP35nfWIRNfEK1U0eHz2nbz+QvgSVDB5VOFr+RRXHTESAuTIY9IMvcg53desACyNWU
         CGuyV9L2rwJuVrqgg0tepyU/qTw7H+60Jw+u8apnEeW4ToXOOhAAKu6lMGy9yTBjacKR
         6DscFhXq+1fH6yo5NKp4Cla/+fgeS/RCBBoxAUN3SxtOX75aWAb8tkA+ZiMPMAtnMK81
         2MIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=L1CXQEVZZhus4WmzXkvBj9HDuo/nBBLiIzDVKG4jifM=;
        b=GpNlulWZQQuUxjaziCOALF1Qwr78xzg7g53LqsYpJVvNgZ1/U/ssub2VuHQKJdjWgo
         00f0qXrWBVM8aeD3iCREdUPzbnszAkuo4hgwrytIBnXemJbtfflHK/N0idhqWwJDfKlL
         eX9NehxkHA0PxSdCEEiEwpJck6uN2vhtc0awqXSQ7gtoqP4/2Bv7TSREFNY8fMO+ptQ5
         tCpOsLAHqLpIew/C2szcqrhn9fiyOj53b7642ZVSsPtA3Mw4xjmXAcshX7r7U6Id7/x4
         KbnGMC7aMzAMUGApES2+2GtGKVN6nIQavY43OexTg4mLCMxLXbGXZJNEc5vkn25FBL0G
         SOjA==
X-Gm-Message-State: AOAM532638CSFG3J6sLmFD6rpv1SLZil1sJh/WnAeSp8eCGkOXZOUr3s
        WsOgCYLFGALHcidkV+/D3ys=
X-Google-Smtp-Source: ABdhPJwHTwhx6FoBweKmCzbQnxGhPOzO6VrCtSEhZXg0Yjdcf0MCiDswopf3OX8gkPrX3ua3xWlRLQ==
X-Received: by 2002:aca:ad52:: with SMTP id w79mr1430684oie.86.1625265180122;
        Fri, 02 Jul 2021 15:33:00 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id l5sm827604otj.79.2021.07.02.15.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 15:32:59 -0700 (PDT)
Date:   Fri, 02 Jul 2021 17:32:58 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'martin' <test2@mfriebe.de>,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>
Cc:     'Felipe Contreras' <felipe.contreras@gmail.com>,
        'Andreas Schwab' <schwab@linux-m68k.org>, git@vger.kernel.org,
        'Junio C Hamano' <gitster@pobox.com>
Message-ID: <60df941a7c43e_28bb20837@natae.notmuch>
In-Reply-To: <03cf01d76f8e$0d8cf620$28a6e260$@nexbridge.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <871r8hauvi.fsf@igel.home>
 <60dee7d4e27bf_2964b20817@natae.notmuch>
 <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de>
 <60def07e686c7_7442083a@natae.notmuch>
 <3e82a574-fdcc-08b8-8fb5-1ff15f8ae564@mfriebe.de>
 <03a401d76f45$e1c6fce0$a554f6a0$@nexbridge.com>
 <874kdcal1k.fsf@evledraar.gmail.com>
 <03ac01d76f4c$ad23a130$076ae390$@nexbridge.com>
 <8f847f31-5c5d-0236-997c-bd07040f7ea7@mfriebe.de>
 <03cf01d76f8e$0d8cf620$28a6e260$@nexbridge.com>
Subject: RE: [PATCH 5/5] config: add default aliases
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:
> If an alias overwrites/overrides a git command, I would expect NIST to
> have a proverbial cow and a CVE will be raised, probably by me.

Once again; that cannot happen.

-- 
Felipe Contreras
