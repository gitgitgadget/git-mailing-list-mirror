Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAA7C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 00:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C2E260E97
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 00:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhIOA2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 20:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhIOA22 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 20:28:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E61C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 17:27:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ho42so2216920ejc.9
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 17:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=xN1v2Qm5fB1ef856wIl5twIYigip3CirNKTi+d06Y74=;
        b=n9o5LL5A1MmhdQjHjn6v29LsENk78eYoUHCYTb2sJhGQvJAygpqhTYm4Oz4mJanbdO
         RTM/x3fRZp2zXk1fBVNWcPDnPkVZIPz1OdXPbvqnoqP8/7AYu2h5yKBDhuXh4mzUgK1R
         PCq0Qr1SVeHEmP2LlqL1qu8+0Pbb2n0gXeIDz4NpMF9HIGLrcBRwGKRzIcAZKZOuX7ux
         9ClkB9bTFETu3j7dM0LDeDwQW1dTupDDsReNa+Qf/tkX+gF1+OFqY5Ksul5jSqFUbpFU
         bWZekfAsEkul8sZxr6APwANtWMf+32Cf5Yn7HO+p92GT9EQPRTlepac7Kg/oDxPc90Qn
         0kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=xN1v2Qm5fB1ef856wIl5twIYigip3CirNKTi+d06Y74=;
        b=ZYwZEjeO+vECncBXCC3ddP1gUgjXCl6uNrIWDSUTKROqV2HI2hnHInMnaFb+Ts9TYI
         fZsEhXAVjovMWL/yit9beR++bIkFWznXbbYKIlj77aNBBXCtDI4CdqALUKNeOuZNiDjT
         atu8LRruhF9E0DTK1Qr3TRpe6uB6Qa3OgVL5Yg9LaGDcrdCZ/MKzo8UsqMM/l/RxWQv5
         /7s/Gbj6dUrgc/vwAzzLnbRmHhcWZGECfDAHmkHxrfDxSBwNlmwRMNsDZNm/Ua64cO5w
         2Blz8JwyRL4/aacSurox0SA01j0d1Jjs6VzWAfkUvOMTEMzISVwTLDCAOJBInjooax36
         63hw==
X-Gm-Message-State: AOAM533s5BfbhGrQzLNvifEalrsCsJmneb6hkQIQa3VbmouUoNIzUXzz
        XmxSX5fXlKd9Q8FN7OKcy3BMFljEGmc=
X-Google-Smtp-Source: ABdhPJyogohxj9ecYeKgFINtoxeoMrQV7FqqTdUNfOwCZdVykRdHIX+EESpsuulwThfpDL8L6qTMdg==
X-Received: by 2002:a17:906:700f:: with SMTP id n15mr21859575ejj.319.1631665628294;
        Tue, 14 Sep 2021 17:27:08 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o23sm6215796eds.75.2021.09.14.17.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 17:27:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/9] reducing memory allocations for v2 servers
Date:   Wed, 15 Sep 2021 02:25:49 +0200
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
Message-ID: <871r5qof8k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 14 2021, Jeff King wrote:

> While looking at [1], I noticed that v2 servers will read a few bits of
> client input into strvecs. Even though we expect these to be small-ish,
> there's nothing preventing a client from sending us a bunch of junk and
> wasting memory.

[...]

>
> [1] https://lore.kernel.org/git/YT54CNYgtGcqexwq@coredump.intra.peff.net/

When I first read this I expected it to be a link to
https://lore.kernel.org/git/YPCsDLoiiAG%2FC%2Fft@coredump.intra.peff.net/;
i.e. that the object-info leak discussion back in July had encouraged
you to work on this ... :)
