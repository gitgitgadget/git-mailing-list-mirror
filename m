Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980E7C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 18:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C786191B
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 18:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhFYSgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYSgv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 14:36:51 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A063CC061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 11:34:29 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s17so12385597oij.0
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 11:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=rQlW7MzezKPjmZotTjLMABnDtxO30byo38ndKAy+AIc=;
        b=diyFoj3A7O+dyMpDFjk5JVpEfriCigo0j4qW3e77VUo975un48p+ahcVfxU55IGj0I
         8vA0E9R7cKsqM9zxZ+9zXpUaYy9QOpv8PUiNhqVxjYLNdTHO8pOqcvL1ineKMEvGNMsS
         hTPX7+Y6BVOeTY44/haFo8uvy4OdFBbW1Vn5oMcUp6+mZ1PIr1SH3TuMyLTZFJU8EEWF
         c6jI/foj09qL5kYKP+PRPVVclmhRQFtUZ8448putYsrsGnvqZ43GKwejw+ZMlW1hfwTC
         4z+pDbGy6F1JfWi01pdI8TNuey8IMU6oB7EsLJmkqavrUaZj7z/TkvDBLMxm8sHOzKJL
         Z9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=rQlW7MzezKPjmZotTjLMABnDtxO30byo38ndKAy+AIc=;
        b=mcj7tX2l1AWyZ48AjjyrGeIulfgi7/Ew44dYwiecmiJyAXMTiju8fwW6wR/iNzLbON
         nJNKXY15dUZ7HdvrGq3auoekf585BVChAV98RQ2CDnHoVliJ3I0IX++5eudow7zY9eBi
         rGosTHeJk0uFusCN+m9y7Or2VU03ZCBmg/KOT0CMPNebZpWFTpvnjpsuEwzUTDZ+36A3
         um3zsOylKispmxIqmAx2VTJMnDDgze08qZTE8eq0WybM1WZCIbk18G+Cj0bib8rDEmge
         VhXxaZnrybDbkDe5A7M+pm9ylp5SPue6WXsIjx/PdPwS2IDYbwrLvY8LOofNujr1hfvC
         U/zw==
X-Gm-Message-State: AOAM5307ed9JUNoFRSwpq31IOk1LWTouKGDKcU7691utIv7frmu4iW30
        CZBCJmeJBd6nzrpe+MYcNa0=
X-Google-Smtp-Source: ABdhPJxzGtvLvvyUYKFVZg6/Uqz86NKtvvLVXd5cCR1b4p8QvKKqub+9ja8am0Qfirwj2BNOKqFzVw==
X-Received: by 2002:a05:6808:8f3:: with SMTP id d19mr9296804oic.158.1624646069029;
        Fri, 25 Jun 2021 11:34:29 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id o26sm1568295otk.77.2021.06.25.11.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 11:34:28 -0700 (PDT)
Date:   Fri, 25 Jun 2021 13:34:26 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60d621b2c36d3_cc8d208c6@natae.notmuch>
In-Reply-To: <patch-15.30-477eb2245c3-20210614T101920Z-avarab@gmail.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
 <patch-15.30-477eb2245c3-20210614T101920Z-avarab@gmail.com>
Subject: RE: [PATCH v2 15/30] run-command: remove old run_hook_{le,ve}() hook
 API
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> From: Emily Shaffer <emilyshaffer@google.com>
> =

> The new hook.h library has replaced all run-command.h hook-related
> functionality. So let's delete this dead code.

Ahhh, much less mental load of the reviewer ;)

-- =

Felipe Contreras=
