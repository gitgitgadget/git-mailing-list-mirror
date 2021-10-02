Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C577C433EF
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 09:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86EA61AFD
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 09:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhJBJKg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 05:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbhJBJKd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 05:10:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B59FC061570
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 02:08:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id p13so15388325edw.0
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 02:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=CEupdcnHzp+AlFIrVDi6TpbeNDKTEUgKwHzswCayYOU=;
        b=X9TAOZoVuXM0bcNDMTr6wWF3Hkkx4hQksIRFQTZNeOJccITr5lTV2kRs7txdWP1O/p
         nxv2mj5ERl1Kyvh9JDd0+t7u2NizgnkvtT+hYSTuJ2lrHuH19FX9uiNH9WZZ1X1I8IAd
         1VdSiDtyDnb/TM9Eepl1zuughn1PeqffUQRT1J5xWGsduV1w9L1QXxSQJYpPRu0L4e8l
         ng2GBBLzkKl04ul1iOPiSLk5ygXbriLNOHaGyAx2ek4pR6H5g++CiM56RTdM1nshdla8
         cb9gEt45bGaIMPmSmPQZOurJmzfhQNDESs8NoQ+M4ctcaIvkROat2ahayo4BV04PoyNH
         cDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=CEupdcnHzp+AlFIrVDi6TpbeNDKTEUgKwHzswCayYOU=;
        b=KtEgZ7NYLWfBCVJIziHMjFJIZhSyWEfDcFWVIG0bPFBx48zi/rvhdLGvAqpDzLMaRU
         f34mGShpgttJTcfX6M4MbGUNTsHPv9iC5yCc5+rI+su3iS9Ht7Ew7TSPIXIMbPr+QFKE
         xZYxlzBgL1OwfhLOuW4Sp9mgzWN3orkCIeT6U/LmQjakxWplDy7QZ0Hs+WTdm6gGVd0j
         IQYZb7qQ+Ynvgis3jvVxnnnrMwhlZ+FoptPq2NKX3J92Kq9jiFHLv9DIDCvjtEzaQZvI
         aFbkaP4e1Dc8W/By+sUJPwyBI9fgxOaPRF5HxCXe2Q5x3ES1WNDSGy40SzQ6BUa9Zi+1
         BhrA==
X-Gm-Message-State: AOAM530dM4Ginz3vtw5bYgU7HtjEpKUR5hKSAoy7vlLVgqoa4fwZcftQ
        on+fobEsKCVP1LfheWwzQtgDNXrf9+3K/w==
X-Google-Smtp-Source: ABdhPJymxiSQvtB8CQe/VO7z+B2A775q1/SVcEn6f9AHFpj09/tKchfq5s/Yp5P3QMIXBzu0jByReg==
X-Received: by 2002:a50:da48:: with SMTP id a8mr2718718edk.155.1633165725975;
        Sat, 02 Oct 2021 02:08:45 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ox9sm996029ejb.66.2021.10.02.02.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 02:08:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] test-mergesort: use strbuf_getline()
Date:   Sat, 02 Oct 2021 11:08:19 +0200
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
 <928cb42c-c45b-c90a-c71b-2f6669e03251@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <928cb42c-c45b-c90a-c71b-2f6669e03251@web.de>
Message-ID: <87fstjpzdu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 01 2021, Ren=C3=A9 Scharfe wrote:

>  	while (lines) {
> -		printf("%s", lines->text);
> +		puts(lines->text);
>  		lines =3D lines->next;

Aside: I wonder if we should have a coccicheck for that (not as part of
this series), but maybe it would generate too much noise.
