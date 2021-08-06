Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C967C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 09:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D2061050
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 09:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243952AbhHFJGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 05:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhHFJGb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 05:06:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256F0C061798
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 02:06:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id go31so14057818ejc.6
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 02:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=su2SmysAyMfFwsky4bjmgh8ew0RsAoF9GkRyx98/Nks=;
        b=WXcUl7cdedUcW9bYYzdzYg7MlRHkuHNyRjpOTeTRmjfatWNig3mh6uzqF0Hqwqw2/G
         JVkrGHlw+k+ZCoZJYEBhWKSOtzcyNEyhp+ZrwgbTs10uqUjBm/bOx9TU9tYyxeX22FoL
         XL8Lju8I2z3aVqgBfQR1LFjrbOAeyO68efTQdApbTBX4n18hiOyjhawzWRMg4e+sGgE/
         N4livvOs67QOIROlgdHpucmtmtmJ2jtSvJisXKJJCUfUNaniNhMWf1HkubFWsKw4ZuFA
         Lt/ztzexhYxkjlH2jPhK8gqzoBztvDr5RIWg4cc/rkBacpJgbX2OXNyevVJvl1LvQS40
         LLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=su2SmysAyMfFwsky4bjmgh8ew0RsAoF9GkRyx98/Nks=;
        b=PTVw+K7cJz9vwonNEEiv2T9dX03BaA5g4UNFJTDtqRsjG/Nc2ncwb5vhGQtXMQHLXG
         3j8ZymUjlLTBsRo8D2d3G6/MlFB52opKNj2XDn9BmrCcvyoHphpsC/VfdgKCVpayhG0e
         n/FAOgwe0H5VDANpv6b92EANqUYqqoGhGL2Ny0Vjeb5ybSxTaUL17DR0b2eoFGtOvwSt
         twz0fHbihsXD/BbP8p7vuY1et9GK3lt8umQ7Kh/7TVsZDazTHq6koFN0/VGMhaBRNldo
         GhsnEvtd+jA5Q+rqheppMzGBLdjAdyUCU+GwS4qHrT5F6j663y/is2ctyYCSbHz/7RxQ
         dSTg==
X-Gm-Message-State: AOAM531RE6mq9iMAhwyZnbhPHC011T50nlm1GFb2aSfixZeCBP7Jv0gA
        6FfDsTpVeorz+cBwQTvLlDjpGs0qeUjFSZAtTkQ=
X-Google-Smtp-Source: ABdhPJxLA/EnaigYpiTAuPfFtOHvKL9Otu5Xxv2TiY5Fq9wa6JwyJK6r8y19Fm+fTDbvMdtNpdbCnAZEyP0BoR0uWyU=
X-Received: by 2002:a17:906:511:: with SMTP id j17mr8880953eja.283.1628240774751;
 Fri, 06 Aug 2021 02:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210805071917.29500-1-raykar.ath@gmail.com> <20210805071917.29500-3-raykar.ath@gmail.com>
 <YQyIJpq/r0O7zhb1@danh.dev>
In-Reply-To: <YQyIJpq/r0O7zhb1@danh.dev>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 6 Aug 2021 11:06:03 +0200
Message-ID: <CAP8UFD0hnkO+LMo2OTAiqPoi20V25806-zL97DA5qPz+3tgKnA@mail.gmail.com>
Subject: Re: [GSoC] [PATCH 2/8] submodule--helper: remove repeated code in sync_submodule()
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Atharva Raykar <raykar.ath@gmail.com>, git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 6, 2021 at 2:54 AM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <=
congdanhqx@gmail.com> wrote:

> While previous patch is definitely a refactoring, this patch add small
> overhead to the system, the new code will query (then free())
> git_config_get_string() and/or xgetcwd() one more time in the second
> compute_submodule_clone_url()
>
> I think the abstraction overhead is not that big, though.

Yeah, Junio made basically the same comment. So it would be nice if
the commit message could mention we are adding a very small overhead
in exchange for code simplification (10 lines removed).
