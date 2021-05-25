Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306CCC2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 11:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F03610A0
	for <git@archiver.kernel.org>; Tue, 25 May 2021 11:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhEYLPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 07:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhEYLPM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 07:15:12 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392BCC061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 04:13:41 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id z3so29897397oib.5
        for <git@vger.kernel.org>; Tue, 25 May 2021 04:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=92qHqEkGXy6XJSy2eqYslljpcOzjWXFRqlI1akCwbQo=;
        b=O2e/TWeN87C7mdR4vQ3QO5pHAlQqCj/p5pgecbzfKLfEBHzkZ672eB9cVBy56cFLUS
         kEkdYxGO0aF5sarVcqxeqfc466m2fyEHFu+QkDh7p2aNWsryqvKl/hZfom6L+l6oZbZX
         tex6A7poTbN6NCE7Xqy14z+/m9qSr7F1X0lFLoFbYdR62WYSHpySvpxWIaOPZJBKSPxP
         n0KYFb0KvdvstBUEp+UjK1JLBKHlKWNFx+kIzKiJWocfwlYw1HsOn6RMoWwGxoZAanhV
         +3uy7TPVl+sLkGV5x3NuXq9gdcNZVeoExdvA/wJ2OX9nfgvT+A2HhCDxIONAezkRjAOr
         rRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=92qHqEkGXy6XJSy2eqYslljpcOzjWXFRqlI1akCwbQo=;
        b=PumV8BYt0GL5bfNeHeVs9uiXL8TL4A+rX/WIuKY+jJCRm9q55TMzj+lUuKnHR11Nzw
         JQW3uujCfPk9AAXk0ikYuepJJA5w8ha6MOPoEfblfmeoYzCIbrDrN5x0d8bamdJ1szIL
         TZJH6YoledHl9M0RKQQYQ61iCksz0Sqw1Vx6UjmCHHOyZ452JOsRpCdGa401tIfqj/r8
         LTTZR9p0lNSNQm+IAgxhvsVQx/j3N+2uKRjQYMgs4MqE5dHDsTbIj6YPZHHLAVo+rrGU
         4B3s12nfxw5Ilxgec/VJ/BO2YBx5sG0QqhJ/jHZt//UXj2DH2nZWI1KiNmDmH/RFC2IU
         Q7IA==
X-Gm-Message-State: AOAM533vG/UXYSzPkuCmevkQT1MMMpF7HF+oaY71CEANCTT0kwELZ1JD
        tEriJj/jV2Qoo8Lw7PHMz60=
X-Google-Smtp-Source: ABdhPJzXa+5SmoXgB28sCfrpMXPZDwCS+hZK1NnFfbiV2zKx2rSeRZm/yqVA3tPYqfkUA9ghXJeuYQ==
X-Received: by 2002:a05:6808:128a:: with SMTP id a10mr2462632oiw.161.1621941220669;
        Tue, 25 May 2021 04:13:40 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id s17sm3411398oog.31.2021.05.25.04.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 04:13:40 -0700 (PDT)
Date:   Tue, 25 May 2021 06:13:39 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>
Message-ID: <60acdbe31e9e8_2257a20838@natae.notmuch>
In-Reply-To: <nycvar.QRO.7.76.6.2105250327550.57@tvgsbejvaqbjf.bet>
References: <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210520221359.75615-1-lenaic@lhuard.fr>
 <20210520221359.75615-5-lenaic@lhuard.fr>
 <715d8115-641b-5c06-d514-36911eb169ef@gmail.com>
 <44d937a0-e876-e185-f409-a4fd61eae580@gmail.com>
 <nycvar.QRO.7.76.6.2105220856320.57@tvgsbejvaqbjf.bet>
 <60aaa09aebce4_454920811@natae.notmuch>
 <YKrk4dEjEm6+48ji@camp.crustytoothpaste.net>
 <87wnrooa17.fsf@evledraar.gmail.com>
 <xmqqim38jfja.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2105250327550.57@tvgsbejvaqbjf.bet>
Subject: Re: [PATCH v3 4/4] maintenance: optionally use systemd timers on
 Linux
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:

> Where an email thread was going on about inviting us to join, using no
> male pronouns, or putting them last.

This is totally and completely missing the point. Nobody objected to
using a female pronoun, nor using she/he.

I for one would have no problem using a female pronoun, and in fact I
often do [1].

This has absolutely nothing to do the issue at hand.

> I know I wouldn't. Yet that's exactly the atmosphere we're fostering
> here.

Except this is disconnected from reality.

 1. I know female colleagues who don't want to be treated more
    delicately than their male counterparts. And they certainly don't
    want unsolicited help, especially regarding hypothetical feelings
    they might have towards the use of a pronoun.

 2. On the other hand I do know people that lurk the mailing list and
    are afraid of expressing their opinions because of fear of reprisals
    in this PC-culture climate.

If anybody needs consideration I would side with the real, rather than
hypothetical, people.

[1] https://lore.kernel.org/git/60a66b11d6ffd_2448320885@natae.notmuch/

-- 
Felipe Contreras
