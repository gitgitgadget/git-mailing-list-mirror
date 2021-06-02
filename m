Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B38C47080
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 01:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA5D5613C0
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 01:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhFBBG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 21:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhFBBG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 21:06:27 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460B7C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 18:04:44 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id a21so1182358oiw.3
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 18:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=340MeySRt5AszVXZm2GAuCaagqlSt/IZMioH2D2UYqk=;
        b=LB4doGShjXS0asRJFNaqLxX5JkhEcU3h8lbPJN1csPIKzB0zOrkua5/OgeQJfju1Rl
         HdIcoW1ui7W5OCditCpI4bJDSO1hc1MMdDLAdDSCpX/2q6wuJ3grtPOn8Qp/ZN6P7771
         quFkJPRN+DEe/K1f4K/zjN2QTW1TqIhWfNTaSawvrigL9lXmQUjV9Jqm+69T1DsjRbQO
         3kTuivueV3+jML7JH3Mn8A+lOnKKJ7SqWXuTT+RXtdWDxakNlwIMTxLHklO03kcfiAMO
         SYJt9aa/JtF+n2M77QYr5MFxPtxLtTgwNzkDjDXbAzQMaDU+9gcCtGny1Z1pkA0sfbdC
         OwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=340MeySRt5AszVXZm2GAuCaagqlSt/IZMioH2D2UYqk=;
        b=E94382ifYTvvu2ZILBwuzzaOZ52buNaQtPPrroiPJHd9dZ9c/Sr6HaUI+t2HEYlUit
         0fGm1se9xli/eqtew0IydQGGIxQO0Bsfl8I3eC5Il3coc5ntGa8/N6gWKFmBSJFbw9a/
         ytylmVxOlMvtRezOI9gpQ2Uxul2fvaFWK3Dg7LeK9yK3gktd0WbnjNRjBMlqWNKXJ8Jb
         ER3fLnKEzkX40/eaBesKJkAHkviBZQJIJ47nZpSY0/ZMX0s5Jh6UvtIqYW8sjfJ2iW4h
         HGaBRi24DIQFVpEbf+StOOn02g7ojbzj3EX6ODXLbx38IiAAVWysmM2C/RTDUymOTNlE
         C4mA==
X-Gm-Message-State: AOAM533B+j3DwL2i8I59bkQpyaK3beJnyqe4j1Aui9SlL3j+7ASK5I5R
        9V1Mav1mHExH6g3ZIM5Oz+Q=
X-Google-Smtp-Source: ABdhPJyHz5omhLhFHjv8XSu7ZkI7SXK0CKAJVd2z/lSYFbQNOUwndfaiAuhr55ZfizFIWfX+eTRj+w==
X-Received: by 2002:a54:4714:: with SMTP id k20mr20083159oik.16.1622595883721;
        Tue, 01 Jun 2021 18:04:43 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 96sm651763otv.62.2021.06.01.18.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 18:04:43 -0700 (PDT)
Date:   Tue, 01 Jun 2021 20:04:41 -0500
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
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60b6d929e9d4a_4abd20874@natae.notmuch>
In-Reply-To: <patch-27.31-c39c608e5cc-20210528T110515Z-avarab@gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com>
 <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <patch-27.31-c39c608e5cc-20210528T110515Z-avarab@gmail.com>
Subject: RE: [PATCH 27/31] receive-pack: convert 'update' hook to hook.h
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

> By using hook.h to invoke the 'update' hook we closer to removing the
> hooks code in run-command.c.

We *are* closer? We _get_ closer?

-- =

Felipe Contreras=
