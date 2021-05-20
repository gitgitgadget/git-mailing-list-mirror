Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9030CC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 03:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6724E611BD
	for <git@archiver.kernel.org>; Thu, 20 May 2021 03:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhETDtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 23:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhETDtu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 23:49:50 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E37DC061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 20:48:29 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id j75so15117738oih.10
        for <git@vger.kernel.org>; Wed, 19 May 2021 20:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=vY29jMqJ1gx2HUeWfboMlMNob+CKslE1fnSbMsAGz9Y=;
        b=R+x9Ew8jRuHlCe+0Itvjytlqdn9GPy15/5S3/AUEENS8Q5lZ9H8QzFNxaYc/NZ1/gN
         Ag8wiMnqyvposvA0Jstl1hbVswAjhtoB+chEygGTbSu99TfDz97Hqrlj9wOjT1j3tZQQ
         o52k7A+B57Fht/sUKHLWCES6Z58X/JkfYVQKiCf+in+kg9BoAdm7Rn56OoSYIpGO8NH/
         5fbmMY9tkWc2jerPKoW3MvgdxPJKuLp1NMx1jDSJSLycftNHvYU0RxQTASJaEzp+8nBs
         BKz4KYzyE4srGKBy1eB7DbpuXhjesnP5RF0pw6zEMI8saAAt9cd3do3ggrMbBYH046/F
         +FRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=vY29jMqJ1gx2HUeWfboMlMNob+CKslE1fnSbMsAGz9Y=;
        b=QVtd1d7FAEnl29IgW/fWlSoa/tkouDXrPFsFBllV7bOEkzrw5IELbYXHoc4NtUmVk1
         Vbut+H51XdPK9k6DnUCWhjidpKnav0UyVZaNXIlilsaTX/CjSiddmI1B/1ShUvgBbKPN
         r0HBg+kXOs8eYwOw1zduNeU1yfQUrOx/DyauB1QHuie68qqzk1be2+g3wC2yQ3vvizA8
         GslY46iaOmJNbPr28YRjtEzlHnrx/pS+hLXB3aIIIiKM6S6efUNqAQieJpNDgWxe+rTl
         2Km7vHOQIsbfCr2HTDc3ZC9BfIfhqvGibjBN+gj1A2w73u3gi8dOffonfoulQuoHVEcP
         EvRA==
X-Gm-Message-State: AOAM531y/oCHwv4C3tklt294BxHMwBfCt5s45Q0rKxD3Au5L5gWNyty6
        tT51rE3Cn4ctN1l/yN2ln9Q7DB3xkm3m9Q==
X-Google-Smtp-Source: ABdhPJxyYhqUGReHS3/1bwR0mG+FEY+DN49XRCoHy7crOJDdIHO9iQ95S1Dm2ylaFmb/XRd0TJTbyw==
X-Received: by 2002:aca:b856:: with SMTP id i83mr1843924oif.157.1621482508403;
        Wed, 19 May 2021 20:48:28 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id t39sm299463ooi.42.2021.05.19.20.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 20:48:28 -0700 (PDT)
Date:   Wed, 19 May 2021 22:48:26 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Message-ID: <60a5dc0ab8e2c_2044120877@natae.notmuch>
In-Reply-To: <xmqqpmxmulqt.fsf@gitster.g>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
 <87im3fqci9.fsf@evledraar.gmail.com>
 <YKXBdQ36MYz2YG8s@camp.crustytoothpaste.net>
 <xmqq35uiw3bm.fsf@gitster.g>
 <60a5d20a4e134_1f37320860@natae.notmuch>
 <xmqqpmxmulqt.fsf@gitster.g>
Subject: Re: [PATCH] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > How is enabling a configuration already present in `man` out of scope,
> > but running an *ENTIRELY* different program--such as konqueror or
> > woman--to view man pages is not?
> >
> >   git help --man git
> >
> > Doesn't even necessarily run man *already*.
> 
> As an end-user, I do not expect Git to run konqueror or woman with
> its own tweaks when it does so.  And I do not see a reason why "man"
> should be any different.

You skipped the first question: 

Do you also expect that `git diff a b` runs something similar to
`diff a b`?

-- 
Felipe Contreras
