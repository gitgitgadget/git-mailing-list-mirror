Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161BFC433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 15:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD5C9610C7
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 15:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbhDKPfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 11:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbhDKPfG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 11:35:06 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF142C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 08:34:49 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id c15so8872014ilj.1
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zx/N8PvVk1/J3OqgsJ1oZHvWC02VUV717+6tfdxzMq8=;
        b=aPiyktCT4AMzTJ/bf3SL5egSoKQHRPKIGHpjqJ45YiamErJSSCgnJVH07OEMPyUkT0
         gl1SlIWsqqrIrSB/C5tgdhVFabze3AFy6njN7RkKSE0qnkfH8XYLI5E56hONfkg6KIci
         ewQLipdRDcY22SG4jBR5SVggeZlT40r/Lbwydn6sFI6hSmLZ4QRAFUedRaZAFXrTzHFH
         4fsyzOIZfc6HjTr9PfgWx1SWdgn9GkXyr8sHA10TuqfWehydanvHRmnrqiqcC8omMAR2
         IHldtwBUUQECdn2ccvnOWpAgmpyY+Hq4ww3WUiAZGR8ycU4eq/jkbIpwquHmJ9RtUA5l
         /+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zx/N8PvVk1/J3OqgsJ1oZHvWC02VUV717+6tfdxzMq8=;
        b=IPXNh5QFSzxGKLt+3J6f2FjUayYuniJv51sQuYd6GJ1f/19eh3K26HNFjFNOTgYm5C
         k1bvYlqzRn5M5NxzuIHGTTYc8NwXiMwjQeWQjDm30U5SqB+iC/X6xwFi2L9QptY1AmN/
         G4pWSfwCjHSorqK0pb3xwVKsxs+UOQGb1HDAtGCjbuEmES9yqiQI1DDBsxIVOrm5O1z5
         E/Ke0xVeYbqyJSVwaUE8iNZJRSz79pWmkub/+/xCmOUqBh4tyMdgRkr/fikWS1+7AUAN
         CUyu9Vvt0dlVTwN/W/hmaMOXYT/d37OXIWodhBOLT4AxkD22RU465AEh0+ffrwXbkjiT
         vkqQ==
X-Gm-Message-State: AOAM531XcOD5b6V3DCrpjofmhPJs/rDDsBpFGRZvkMPFPa4EtOdlJLWn
        uAQS6IFgsO3scUUoNqKzND+vNbcQ1d7c5djSOGA=
X-Google-Smtp-Source: ABdhPJzYeIjn/4Mof72v8oitQ6xjXGpXHIu+uA7Q3HSAv7L2nb31dt/iJQX5IF3UugMYOolvrEje0VE8rlw4No6UU1o=
X-Received: by 2002:a92:3644:: with SMTP id d4mr20284303ilf.53.1618155289299;
 Sun, 11 Apr 2021 08:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RfE4nn5NnjZh7xuF09-5=+K+_j_2kP0327HVdR4x_wAQ@mail.gmail.com>
 <CAOLTT8RTA0inxgxbd3qDToKYxwgXGKvJikXWsXg7oQ4asFj+HQ@mail.gmail.com>
In-Reply-To: <CAOLTT8RTA0inxgxbd3qDToKYxwgXGKvJikXWsXg7oQ4asFj+HQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 11 Apr 2021 23:34:35 +0800
Message-ID: <CAOLTT8SW0n=x3HBL=php0aC1nhP7eU-MHFLustC3H0opxGRV1w@mail.gmail.com>
Subject: Re: GSoC Git Proposal Draft - ZheNing Hu
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Peff,

> Why is Olga=E2=80=99s solution rejected?
> 1. Olga's solution is to let `git cat-file` use the `ref-filter` interfac=
e,
> the performance of `cat-file` appears to be degraded due "very eager to
> allocate lots of separate strings" in `ref-filter` and other reasons.

I am thinking today whether we can directly append some object information
directly to `&state->stack->output`, Instead of assigning to `v->s` firstly=
.

But in `cmp_ref_sorting()` we will use `get_ref_atom_value()`, It is possib=
le
to compare `v->s` of two different refs, I must goto fill object info in `v=
->s`.

So I think this is one of the reasons why `ref-filter` desires to
allocate a large
number of strings, right?

--
ZheNing Hu
