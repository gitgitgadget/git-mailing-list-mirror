Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE1AC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 21:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D6E613BF
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 21:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhFQVSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 17:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbhFQVSU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 17:18:20 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A732C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 14:16:11 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id t140so8121759oih.0
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 14:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=hrfe7bkJ4XIyoEFwRsjI8s+pmfroS+Qql19tpka8e5c=;
        b=Ig5MobRWZwKazNPoKr/UV7nSoOdHRmw8u3yG9dJpqGgqmK+wGXzNNqueyVKXMOydlH
         AjmAmoaKpablwy0nQRILWyCAHe1OTLW5yOwz8o0F1yzlAzelwTX/sV5HQ3oPibzS2QR+
         pEcU4NCisJs8rs7a6WszXPPA99TkZNY5aSEs844DNGgfzEIeJ/7JX9puS0qt4+u4ZhMm
         VBnWjdZUlseVskjQ7nC8dO0757fpqInW9I1G714H+qPR47JVtRlmKKPGr5W2LWE4E/S7
         W9LRG29b6K6SKieT54sBg5ZFxaNh4yttBqdZ6YmSRNZaHzG9iWSdr4E+Fkw2Wl9m2Ve/
         8TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=hrfe7bkJ4XIyoEFwRsjI8s+pmfroS+Qql19tpka8e5c=;
        b=K9VYPzIrKg8NOGHQFnuxANwGSuWLa5rE3GgBfJoRNz12JXAdTT1fViGc7ZRTMkt9U1
         foPFYCUY4PjlzqPGLVk0hmji7ETzG4u+d70TzDQvfGn/JxtZo5o/Pi/4MN4Utw3qTMJz
         dBvA5g/yJQ+07Kw/NJmbLQ4VFTLs6CLOrkzALuhtW+hefLEBWSz7l6U5Yqp0cu89FaP9
         LWVQbbz8c5IW4If6nQneekfuUObnOa9kc69VLgJxz9yYIU31lofsOLNxEErjCAmhxxBD
         yJFNSV1P1c2PYf0oDfyQicX2GRkPykykaFoMdMQrK53NMJjF0fBhOV8roIYcxwaymgEV
         qU4Q==
X-Gm-Message-State: AOAM531SLRCSsmXA58xEqEf71Mwo/I6YKC5ju5st1DstTt9YRpZorQL3
        78bSvYDZgnfLQioAhQpjU0o=
X-Google-Smtp-Source: ABdhPJwzAPclgOJhFl/44lS2AvgKrNwjbvJ+kQjul2oZJ8LhZl5rfw74v9Yw0aBOxN5ye73bun/+gQ==
X-Received: by 2002:aca:6041:: with SMTP id u62mr4750761oib.23.1623964570491;
        Thu, 17 Jun 2021 14:16:10 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 30sm1539652ott.78.2021.06.17.14.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:16:10 -0700 (PDT)
Date:   Thu, 17 Jun 2021 16:16:08 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60cbbb98c40b3_1299208ea@natae.notmuch>
In-Reply-To: <patch-1.4-7b8ac43339-20210617T105245Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210617T105245Z-avarab@gmail.com>
 <patch-1.4-7b8ac43339-20210617T105245Z-avarab@gmail.com>
Subject: RE: [PATCH v2 1/4] show-branch tests: rename the one "show-branch"
 test file
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> diff --git a/t/t3202-show-branch-octopus.sh b/t/t3202-show-branch.sh
> similarity index 95%
> rename from t/t3202-show-branch-octopus.sh
> rename to t/t3202-show-branch.sh
> index 5cb0126cfe..8cfbbf79c1 100755
> --- a/t/t3202-show-branch-octopus.sh
> +++ b/t/t3202-show-branch.sh

Makes sense.

-- =

Felipe Contreras=
