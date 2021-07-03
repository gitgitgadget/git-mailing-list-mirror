Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2380C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 11:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA4661876
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 11:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhGCLbV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 07:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhGCLbV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 07:31:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87907C061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 04:28:46 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i5so16933403eds.1
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 04:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qx3BM4bAGtHcmx0v96lPLan45TH1jhn8r6umvlnsUV0=;
        b=TrE7AYNUyvpEaOxmmqiyZPlSLvC+XpUwfuslQX11JR7jWWtpAw3uWRblAup/SAT9Ht
         ZmJc+qIFZ22kucBxR2rrc+EakUep9e29fD9231UW67KeISDMhCVVuRoKYn6TnGblTQlc
         KKYwJOMaiYd9BNMrJ8cddso8pzjB3Za50h2UnwTjn6va2+IPWD+DYAHeRqafjigCGvAG
         vu8yzbyXmBIdO5wIohfQHBINMU3BHKVX1Aw9bAQrbkGPiP47VsyGVfj+IxtUMEaeGzyQ
         krufMxcMFNjlqyXEs1uZRycroKnDxB0nKVtoFnLpneUamBhABkzsIWdl9kHCcrvjppLa
         Yt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qx3BM4bAGtHcmx0v96lPLan45TH1jhn8r6umvlnsUV0=;
        b=pUe3sBJkT8gCSf0wFCfLOZHIFc9eXxUJ7vLwxcO+3S5Slf9TYQ+0AXFlTyInHEnZdp
         2fTaSfTlyYQog9Surrq9TDHdqPjUOmsMBpTBCh46LQOWdLMTS3cYNo6XD5xEaJdj37ok
         gIfKHxkuU5mSABg4b4iIBNWMKnGzpI2sIg2blKXmqbY87Ep3a3Qv0fXr4v4MwnA0Zdpq
         p4+8neGY7hfRxNwX4ehsrPUMnw5uruUxAq9Cv2AseA4++C2CbfhQoIeXUt6Tj6E6bEIf
         q2uNu7jSLaDK1kiaXYREQVVY1MhPuXcAKkMqQPkGAIJweM0eGQQ8hj7EedmcUIIPi718
         k9sQ==
X-Gm-Message-State: AOAM532tsHY4brMaKZUCDJvbQo79enaQHzz332R028En0pmOGJEAHiwY
        B/SC6WjKRQ2+z8vAc52Swp0=
X-Google-Smtp-Source: ABdhPJzNgJVmYsv7pkzvMioQFgCyovUzgs4tTlScz3CDnDt/5fhkJYgLGo8PGoTzoinvogT3cWGIKA==
X-Received: by 2002:a05:6402:14d8:: with SMTP id f24mr4641947edx.195.1625311725083;
        Sat, 03 Jul 2021 04:28:45 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g8sm2474536edw.89.2021.07.03.04.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 04:28:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v4 0/3] bundle.c: remove "ref_list" in favor of
 string-list.c API
Date:   Sat, 03 Jul 2021 13:28:32 +0200
References: <cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210702T095450Z-avarab@gmail.com>
 <YOBBgfiaz59KdsWS@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YOBBgfiaz59KdsWS@coredump.intra.peff.net>
Message-ID: <87y2an8wlv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 03 2021, Jeff King wrote:

> On Fri, Jul 02, 2021 at 11:57:29AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> This re-roll of v3 changes the discussion in the 1/3 commit message,
>> it incorrectly referred to SANITIZE=3Dleak when I meant valgrind.
>>=20
>> I also changed the bundle_header_init() pattern to use the same
>> "memcpy() a blank" as in my parallel series to do that more generally.
>
> Thanks, this looks good to me.
>
> I'd probably word the discussion about die() a bit differently, but you've
> already seen my expositions on leak-checking, and it's all tangent here.
> So let's move forward with this, and we can let leak-checking
> philosophies iron themselves out as we fix more cases. :)

Thanks for the detailed review over multiple rounds.
