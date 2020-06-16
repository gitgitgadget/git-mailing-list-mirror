Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54099C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 07:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 231802078E
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 07:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahvHpXV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgFPHb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgFPHbz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 03:31:55 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46A2C05BD43
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 00:31:55 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id j32so14721427qte.10
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 00:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XabtVVZE7gMR4RbfHV7jX48+byb6bboKQgb98hJbFg8=;
        b=ahvHpXV2cvkA0VFeQxrbp2KE/8KwhGBLgVNV6q9wYr+KLEgeRmEwjqHdrGU5cXugef
         cp6zGHxB0dnuNXCr9Q7f81QN9ticbOfEIM17RVsAip6B7Lz459W9RZQUPhKpw3m8MJfo
         KF6nbg0I3g4iJdaZdnEcAinWV+bcH+q4nomEHPvyDlkPV2GQQ+grQCg0U9jpark5nnJq
         hT4R7myi/lqdYxL03HwOKCjlqXvSdrUxy49TYzyKXeuyZPAVZCqC8Z4dEXYXZmukIqFz
         zYVnH2T74iHvbys7tzrA6DgBI+2CHr6DXRLYPVndB/x6/QuPTDjK63WFPErrKI2Guhey
         e1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XabtVVZE7gMR4RbfHV7jX48+byb6bboKQgb98hJbFg8=;
        b=sQKYBJMSXJoFpwExcYcFwubsg3tUcQAqMEyo4IGKf6wqyof6+W5QCFySkkhg5+8E4F
         Pybf02thriR8hjLNXMWVM92oFUMildIXsaTV2V6KwVWuQ8Hh1LluqyAadycXqylgYOJp
         cjMb2VDV1lTRfg+ds4vvogVHmSGllW9Cn589V1NXWT38Awee/LmCdY7u/H2YOaKJ5tDT
         PMKtnt9E15c1/+EEPjZ8XlPRlD7/7ojRhoK1mmpwRMFneKPvWJ4vArFPznbicZ6gMr+L
         s5v2qRvjKO4uk3Z2Z9+8l8Vc5b6O0E+bahohAEA8tjoB6m6SEgaDHqpgKxpEAEEK1vlo
         DVsw==
X-Gm-Message-State: AOAM530G+duwD4Lhqq8jJvUxE0osctcl6azmgJsUaBlgZv+t58MUCe3G
        fkBPtAPGKhFBHaL0NMKk3ITjlGCnrwzZ/OnjYxw=
X-Google-Smtp-Source: ABdhPJwYKvR5uKofaFcUL7mVo0Wjso8TE6AM+0EssGmvgHyZC6qLujBQ6rVZluNfpw3UQICvKB9G5L8WlRmTuKu2SBw=
X-Received: by 2002:ac8:670c:: with SMTP id e12mr19643783qtp.223.1592292714923;
 Tue, 16 Jun 2020 00:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy2oqxyp3.fsf@gitster.c.googlers.com> <0dd6b6c2-4ea4-498d-4481-7f65988db293@gmail.com>
 <CAGA3LAeXzYokcpU8RnFdF7N5vC-geOdJSY5_Mjc-yssvbpjmgw@mail.gmail.com>
In-Reply-To: <CAGA3LAeXzYokcpU8RnFdF7N5vC-geOdJSY5_Mjc-yssvbpjmgw@mail.gmail.com>
From:   demerphq <demerphq@gmail.com>
Date:   Tue, 16 Jun 2020 09:31:43 +0200
Message-ID: <CANgJU+Vs-hzU-Fg+iWAn349_azb3k_6PCzyY+S2C_5ZUTv7o=A@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     Don Goodman-Wilson <don@goodman-wilson.com>
Cc:     =?UTF-8?Q?S=C3=A9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 14 Jun 2020 at 08:35, Don Goodman-Wilson <don@goodman-wilson.com> wrote:
> But to deny that explosive content on the basis that you don't
> personally feel it, that you've never experienced it? To claim that it
> is "meaningless", that some people are "perpetually offended"? That's
> willful ignorance on your part, a bad-faith effort to engage in
> serious intellectual conversation about what is good and right, and
> has no place in a discussion about creating an inclusive space for all
> developers, let alone trying to bring about a more just world.

Well said sir. I might quote that sometime.

Cheers,
Yves
