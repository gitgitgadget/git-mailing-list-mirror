Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE58C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 06:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C02CA61245
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 06:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhFQGKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 02:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhFQGKD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 02:10:03 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0A2C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 23:07:55 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id s19so1858690ioc.3
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 23:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2ykgIPtPKYoN8DbauAGLJvUbTbKPGBUq7IsvynXaEIA=;
        b=EbbmjpBDaG2UtFI/l+gzXHraD7O03/vOjXE2yrzI857wNpWBn2WBJ3H9cv73+tKERy
         MDL6+bubXGK0Q2uDRzBGDx/9PDM5h2MM59qPehhEcybuzWt0H0vtW6W9Bbrgv3mhuytT
         1Gubc3nSKPrJxJ2Meg4IESOtcQZwL9V+U5LQmQdZkwCs8Rvqp7tPwBNS63KJ6Ql0wIFw
         JvXz+W9VF8IABFAd/gclyyp4HLcXSvAr+13gIArDINXhP/BPvn1Q2huqr4eyajzKAGb1
         QXuiacUYc0/7xE3i1mtMMbSO+RjXk4+YZRFysD6KHmJeRJK03ZcEYMrLCB0QLK91Pbg6
         uOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2ykgIPtPKYoN8DbauAGLJvUbTbKPGBUq7IsvynXaEIA=;
        b=pmjUNVsFaJ2SUsRnkCN9m0v5rsQaJ3INiJju/MdlQl0VGHnCPRGrP8sLWrFImTTsko
         6qEwUq84MUuwIjXva9d6Oi2hndamWND/T59aKZ1LrbehEC2KMMpo/tWIcOjCaIlFQiMf
         9jveOt5vbU5OepmEOKf7svSqFbJICEVGVd94VVUs579vO1TJIhf7gLWOqGtvPOSqcb9V
         TS3hKOBoEb+mDiUk6uO5I7Ms1GJ/IQ8qlp1Kc6MjdBsLFBLsbRbTAQgwUqFdk1Si0H+S
         /bF5m3lUdoNi2iZpAYHa4XLkS8XhVyPWxgFLlPq7PMZYuJ9Nc24QFidzphBy5jQOc62e
         k2DQ==
X-Gm-Message-State: AOAM533VCvife5Yz+rZdkwMPcAP5KOCWEG9iIhdG+4PC1EWpZErc8nWC
        YCIFPRjCwDRI9HovNyrwLlmOY5z/nDd50GW4O8A=
X-Google-Smtp-Source: ABdhPJwaVZQLyqqlhTWUWVYMn/faHBAPVRWMwHKCfEtMyu4hcWZeJVCEe1QMK7/DQT0a63K+TFv61y+Q/xsWlrqs+T0=
X-Received: by 2002:a5d:8b03:: with SMTP id k3mr2411774ion.203.1623910068665;
 Wed, 16 Jun 2021 23:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
 <pull.980.v2.git.1623763746.gitgitgadget@gmail.com> <xmqq5yyeqncn.fsf@gitster.g>
In-Reply-To: <xmqq5yyeqncn.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 17 Jun 2021 14:07:37 +0800
Message-ID: <CAOLTT8R8CBF6XSO0gx2P_UaSCf1ansXS1Y+Y7Kuft6AKmxTQLA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] [GSOC][RFC] cat-file: reuse ref-filter logic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8816=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:29=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This patch series make cat-file reuse ref-filter logic, which based on
> > 5a5b5f78 ([GSOC] ref-filter: add %(rest) atom)
>
> Hmph, does anybody have 5a5b5f78?
>
> The way to deal with this and avoid resending the same patches
> (assuming that this is not a 9-patch series, but only 5 of them are
> new) is to rebase your topic on 723bc66d (ref-filter: add %(rest)
> atom, 2021-06-09), which will allow you to discard the 4 earlier
> patches, and force push, with base set to 723bc66d, I think, but I
> am not a GGG user, so there may need an extra step or two on top of
> that.

Oh, 5a5b5f78 is in gitgitgadget.git and 723bc66d in git.git, their commit
messages are different. Later I will rebase my new patch to zh/xxx.

Thanks.
--
ZheNing Hu
