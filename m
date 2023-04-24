Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38C3C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 18:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjDXSU5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 14:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjDXSU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 14:20:56 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F93A123
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 11:20:56 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a920d484bdso40014795ad.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 11:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682360455; x=1684952455;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEJNQ5zgpdOS6Cd40OVOTpgpdkEIagxeE1SszXh2RHo=;
        b=grd7uvoTlcnVJeULRi15pmrssMR7jlOW5W+96WqVEyF987/PoV1P+SDIO7qPv5+cE+
         KUPE8sz8NbarX4/kHsFshNZw6e4rbKCzVZHvCWAwu/S9gmjexSPKG4e+ojE/TFw21X7k
         kWIcSNDTIHE/XwlcCEU19xgfPj/HBOf+vlVbiZsXU4P9c2E+K1x1jekmU4hT1UUbYsUs
         wQ7S6ai9FRUokNc5MzOk3a58QuzguwgtU1951cYYmsS2BW5NxAqURDkAP2ir5uiFdn3W
         jUfQ2lXqF/WvYYe39qFxPtYPjemtmGrIIAMGdzQLjTP6phPYb+huVOaM2IDT5Zrg3q2L
         +8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682360455; x=1684952455;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yEJNQ5zgpdOS6Cd40OVOTpgpdkEIagxeE1SszXh2RHo=;
        b=AqSRuGu78FtD+bu/cePnRjgr6YMu57fYlV7K4bstPBNRgZIEddZ+WIYKwEGnmVcZeh
         yWoUjMEvOAXyYPAiz2IvWhAMtrEAP5rkbjD5mP08tx8g7wQCb4VhrcmUWeMLEEG7+7V2
         hI7ISooFzB1pB3k2luEBmW5Hgciu0K8X93LHsY6tXtUnWeV0yuA2LoBtGvLVe/ZR0em5
         4hHKkVCpFqbXxKAEOZL6C18x0teqevuzhTWSp3t/7DIsZSoQj7NdPPcj534rdB/AbQ64
         rD6kt6QBJWWAIHLPTJKhX8l1ljRv1zWR6wzX84N48cnl/etr8pUKHGVaxlpofd2JimIZ
         5vrQ==
X-Gm-Message-State: AAQBX9c24UUl28nmlHNYuNW2+fdOtbTEnN97dBM1XLdhgkyyCVVAHCVz
        d3nkJRy7D+DEr93OxGgKo2zCEt8KmOU=
X-Google-Smtp-Source: AKy350YM3M8l6EgeLbF0uNtnlwldmu+GOSDUvlqvtYWqDRsXcKVz5tb5mxgeyhqWrJt7EcvefVf6iA==
X-Received: by 2002:a17:903:30c3:b0:1a6:f1f3:e475 with SMTP id s3-20020a17090330c300b001a6f1f3e475mr12060542plc.55.1682360455463;
        Mon, 24 Apr 2023 11:20:55 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902740a00b001a076025715sm6875359pll.117.2023.04.24.11.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 11:20:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: en/header-split-cache-h-part-2
References: <xmqqwn26w5cd.fsf@gitster.g>
        <CABPp-BHTYha8g1t5VPCkuMtgCopwx==iBGMOCxnyWpZbYMNtAQ@mail.gmail.com>
Date:   Mon, 24 Apr 2023 11:20:54 -0700
In-Reply-To: <CABPp-BHTYha8g1t5VPCkuMtgCopwx==iBGMOCxnyWpZbYMNtAQ@mail.gmail.com>
        (Elijah Newren's message of "Sat, 22 Apr 2023 08:00:00 -0700")
Message-ID: <xmqqpm7tdtvd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>>  Will merge to 'next'?
>>  source: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
>
> Not yet; please mark as expecting a re-roll.  I need to fix up the
> hash.h/repository.h patch

Thanks.
