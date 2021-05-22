Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256A9C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 21:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86056109F
	for <git@archiver.kernel.org>; Sat, 22 May 2021 21:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhEVVyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 17:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbhEVVys (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 17:54:48 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D15C061574
        for <git@vger.kernel.org>; Sat, 22 May 2021 14:53:23 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id b25so23414589oic.0
        for <git@vger.kernel.org>; Sat, 22 May 2021 14:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=cMxWOn3nKrna6vkNRGeTlbxQ+5sC/dBf3YFN3bokVgE=;
        b=hiALxi/KqMxp2CUraNG5KiY0B2UX8VOJCSRcSG10Toy575FOlQTXTlL9BHkNe8yJyR
         K1kc6B6DLF/WAUPd+Q4fML+MqtQ411+re1QTnocQJj7iyx2o/ohb7jNn0Ln4ySBy0R1r
         bVBv9xY8IBxsa89Zc0K9YZbG1Zk/Zggmkubwfs/rCkWXoL/INFNZ4TiDeyuV7/ctYDIF
         J8G6p0HjUWZ/n5oLFC3IL8LzXi2dF44aHh2ABF9gGiPwlFLv+dG2JOYTF7sDujKx1Tne
         CqZD5xW0Nhlz8RmA7tRI6jwE7BnFBWGonta+MTMY5d9b1Z6Hr7WN8tfB9iXWeD4SdCcU
         LUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=cMxWOn3nKrna6vkNRGeTlbxQ+5sC/dBf3YFN3bokVgE=;
        b=Kc43UtYSEw2Iup3zKB6jJimysbkQdaE1J+KLGKrlRErmYohCHknyfSlzpN1VV9ndkp
         EmBrwdw0KFBEGkvWKq38PR2Nf7gXURGg/Brpv/N4ubotv1F7tXgOXCAPqLHv48IKHKHN
         KaFIEjpPI4bHGB7g/e6q5ouapZBSA0BCuZFTlh6tYq79YvVadA1nwZDHzJBsGFgfWV1d
         kB4LhHmjCcCrazQOTA3XXUYZYPUMI5qmEapj39uvYj/840YXA7YmFjwpcQgc8GJGsXAl
         4B/oIIIaqdJxvI0+/2qXwdvIxt4PfRtFnCEdxzMDYV6E+rG/ZOPGRReg2XDbTPPXKnEa
         luJw==
X-Gm-Message-State: AOAM5317yLeB71Ivi4E2NIyk9AESQ1zq5qtjOgCx4nI1BV1/NMKXW09U
        wlMjPy4410cscBMtoaBDox0=
X-Google-Smtp-Source: ABdhPJywpYRpBBZsDs325EcdTfXSmsPdeSNrTdrV7iedkLHqEORFdfjb28y8aqGAODitLsU5PG/Sog==
X-Received: by 2002:a05:6808:3b9:: with SMTP id n25mr6350370oie.54.1621720402935;
        Sat, 22 May 2021 14:53:22 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 19sm1840973oiy.11.2021.05.22.14.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 14:53:22 -0700 (PDT)
Date:   Sat, 22 May 2021 16:53:21 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Message-ID: <60a97d51b9a7_8572320883@natae.notmuch>
In-Reply-To: <3C6468D1-3E14-4600-BC8E-86CCCB84E74C@zytor.com>
References: <YKWggLGDhTOY+lcy@google.com>
 <60a5afeeb13b4_1d8f2208a5@natae.notmuch>
 <CAMMLpeScunGg5WM4N90vG+yN3tOATqhsL2iRLsJ43ksNyTx_wQ@mail.gmail.com>
 <dc14c50d-c626-19f8-e615-52ca3c9051dc@zytor.com>
 <xmqqfsyfqhkq.fsf@gitster.g>
 <60a976221c390_857e920812@natae.notmuch>
 <3C6468D1-3E14-4600-BC8E-86CCCB84E74C@zytor.com>
Subject: Re: RFC: error codes on exit
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

H. Peter Anvin wrote:
> No, please use the standardized numbers when they apply.

I wasn't talking about the numbers, but the names.

Do you see something wrong with USAGE = EX__USAGE?

-- 
Felipe Contreras
