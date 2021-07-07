Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5CAC07E96
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 01:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9102B61CB6
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 01:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhGGB4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 21:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGGB4j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 21:56:39 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC56C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 18:53:59 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id s17so1673568oij.0
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 18:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=K8od09VLST9Bi72OYuVRPYdmsqckrewjiAN0pEdENEM=;
        b=NEr7vHQpdjyuaBdOEp/qw04lXAnFN2LH3cFYWPTYtvigcLiN7x182Zr8km96OqHmRD
         HQJcTLmVu3Cqnzk7MSnqRc5palPlIpq+Fy9dqAVnUQTpsXpVSCfWtJY7t2+hzl98PfNX
         9ZpvWDYoaZOA6toJj5uY3WG+S+O1qXbtl7x1M1Nj0RX7Yg2IJYYsE+CWQ3lnyygJ8zrQ
         Kb8FomyXaup82QWoHu+9anUHj+3aRnHsBPhta96DSU1ouxKjaIF89NNoC+3fG+gTr+em
         EhMDJqqWEnrhShN+BAF+0u0RYhEeBk5TOV0v7MS5/dDfeq3IchpcLX+FiwP8g47O/CDz
         lnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=K8od09VLST9Bi72OYuVRPYdmsqckrewjiAN0pEdENEM=;
        b=q0QQaJmCsS49DDQ0SReslRAmn3BYUPubhhOfFq8KSMZ0a+fxQMybV9bWHEcaQ1W+bh
         wiDToAXrN0C/nVLnt8vm7hnbIVBcpm8NDGyPYQmh8uMl9p0R/zu4KPBvoRatiwwpdk6B
         YSkhla1F5uYpXpHPvmQp4HK/L1joufok+qmD095BM05UDtX8P56WXOb5mNgsbdfNmR6d
         alGCvvEQCMippUXxqCS7fMDNtcTVY77vcDzBHTOV/fKm56UTv+PqiWVlkh0OJ2hZYUKg
         uD7V2Qf7p9l4qjdl5buOSGtSvvhu/qhfpjDGkgml7CFmIZZWFO7lAAUOUxhgIbKrhuFf
         FQ/w==
X-Gm-Message-State: AOAM531+uccepmkMBmS0PMUFgTHxYY0kcdh67tCFpjJXaGAODLtW3vu7
        WXQFJoR00RZ59p6U1BHpHg0=
X-Google-Smtp-Source: ABdhPJwZ+4Sc/EWAlxEMCJ8D0toFPF7xcGIRVoT8m4zZZEtMepbIKJLJwXaO5QNusC78j0DRt/tz1g==
X-Received: by 2002:aca:b486:: with SMTP id d128mr3028600oif.99.1625622838830;
        Tue, 06 Jul 2021 18:53:58 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id f12sm3318677ooh.38.2021.07.06.18.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 18:53:58 -0700 (PDT)
Date:   Tue, 06 Jul 2021 20:53:57 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        David Turner <David.Turner@twosigma.com>
Message-ID: <60e509353500e_2fc0f5208ef@natae.notmuch>
In-Reply-To: <nycvar.QRO.7.76.6.2107052259340.8230@tvgsbejvaqbjf.bet>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <87fswyc4dz.fsf@evledraar.gmail.com>
 <e1442a04-7c68-0a7a-6e95-304854adff39@jeffhostetler.com>
 <87czs1d6uy.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107052259340.8230@tvgsbejvaqbjf.bet>
Subject: Re: [PATCH v3 00/34] Builtin FSMonitor Feature
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:

> In Git, it is our tradition to develop incrementally, for better or
> worse.

We develop incrementally, but the first version of a big feature has to
have as many eyes on it as possible in order to track potential issues
in the future.

It is very common to look back at an API and say "oh, if only wad
thought of that back then". Therefore we should do our best to think
about it now.

We want to avoid future aw-shucks.

> Jeff's effort
> brought us to a point where we already have Windows and macOS support,
> i.e. support for the most prevalent development platforms (see e.g.
> https://insights.stackoverflow.com/survey/2020#technology-developers-primary-operating-systems).
> We already established multiple obstacles for Linux support, therefore
> demanding Linux support to be included Right Now would increase the patch
> series even further, making it even less reviewable, being even less
> incremental, hold up the current known-to-work-well state, force Jeff to
> work on something he probably cannot work on right now, and therefore
> delaying the entire effort even further.

This is a red herring.

You don't need to send the Linux support as part of the patch series,
you can simply provide a branch for the people that want to give it a
try.

Even if it's not ready for wide use, even if it needs a specific version
of Linux, even if it's a proof of concept, you can provide it.

The real reason it's not provided is laziness (this is not an attack,
laziness is good trait in a programmer, although not always).

Cheers.

-- 
Felipe Contreras
