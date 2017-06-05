Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6288D1F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 18:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbdFES4O (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 14:56:14 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35704 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbdFES4N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 14:56:13 -0400
Received: by mail-pg0-f47.google.com with SMTP id 8so38856450pgc.2
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 11:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GDpyXRgAhcH+MTWFKxNVYqmCzie/LOEN+n2fT5lgiHc=;
        b=Envv6FXcWntkmvdH7zJd2+QmQDd9Poi30H2OE+ntDdF1DozSJNde4Ypyg/lSvhsleS
         m1Ly6rC0GAftnmtfrtRMtL+fDmZMPvJS+whPyG6iSUcjOJVRaSZhbKP3WLSD22hroHsj
         12/a8ZF8t9kim9KCVb9izkvdUbFE9dRnCkDgQ9OpBknRMSB4cgw5Y1TP1UsXY+T/p3ea
         7tVLI4IeMuyf06YoVnuN6urfplnGYcjDCWL1/OCqRTlcsyoVvDkz9ytZkSqF44b4R2Zg
         DFH9KC5xGBBt8iYYJHultaUQf9QMB7tTnnyOaug00bYqKJUyrY53+zdYn6D2lGRZqXOW
         Wq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GDpyXRgAhcH+MTWFKxNVYqmCzie/LOEN+n2fT5lgiHc=;
        b=J5PwZ7LjvD+Ceyqy3CZ9h2I9dbF9YPx1l/TdxSBr2nTQC3G966CAQS1PVcR1YCxlkC
         PLOOrqf3rmhaJUAEcrWL9hpH/8sf959iDlfSmXV4Ofu6p+5nIS+T0VCAtvyv9fg0uU2a
         l4TRkTXMOevMHsVbEE+BZI+YIxQNqrxxFWNaAprkWdvsHwDTlsa8jRhlHF0+XhH9WmYq
         Av3dLbVhaPd5ma+8V5M0aRlcAIi8AnPazqlD2PDs82Sb1J5z1qlOO3gSyt0STS4Y/uD+
         J2L0yGlbuhTiXDlfh1aKiS7VsX1cscyGhPuSxucLogmWtlcxZ5yA7tnpl1rJQtdPG1Xk
         1XZw==
X-Gm-Message-State: AODbwcCdYFBhMN+hx3pGsfYcW73vOkGJBZFiToTKE95XM+jfpwsdIhA3
        UG7FfNE+uveCBJNYqM+b5oCX92xvz5Em
X-Received: by 10.84.137.165 with SMTP id 34mr16644685pln.167.1496688972953;
 Mon, 05 Jun 2017 11:56:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 5 Jun 2017 11:56:12 -0700 (PDT)
In-Reply-To: <CAP8UFD3-=sDQ2PEExLq_A3v5d8w8PJ1aLgBNP725mGHzocuqqQ@mail.gmail.com>
References: <20170603221335.3038-1-avarab@gmail.com> <xmqqa85owq3b.fsf@gitster.mtv.corp.google.com>
 <CACBZZX5_AYOXZMrgVZuERzOdzntw0ec36bKS5mcKT510cC3Y2g@mail.gmail.com>
 <xmqqefuzurj5.fsf@gitster.mtv.corp.google.com> <CAP8UFD3-=sDQ2PEExLq_A3v5d8w8PJ1aLgBNP725mGHzocuqqQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Jun 2017 11:56:12 -0700
Message-ID: <CAGZ79kbXS83s1tizFm1y_uZZ9CYDa0zoHWH4U3HK=3-Bp5XbUg@mail.gmail.com>
Subject: Re: [PATCH] test-lib: add ability to cap the runtime of tests
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 4, 2017 at 10:48 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>> when the hidden feature is _not_ used, so that wider set of people
>> will be forced to see that some tests take inordinate amount of
>> time, and entice at least some of them to look into it.
>
> I wonder if splitting tests would make a good GSoC microproject for next year.

That is an interesting thought.

It scales pretty well IMHO.
(Have a good student that works quickly
-> we'll have very modular tests at the end,
have a student doing a-ok
-> at least parts are converted and upstreamed)

On the other hand it requires knowledge of a lot of things
(shell scripting, different operating systems come to mind..)

I like the idea.
