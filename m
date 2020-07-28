Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D658C433DF
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 22:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD46207FC
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 22:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7a85Xra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbgG1WoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbgG1WoM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 18:44:12 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AA2C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 15:44:12 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 1so6416026vsl.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 15:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jjamBvhk/euj+MiRmaGyseSKatnxtrOZn+NpIkmNZbA=;
        b=k7a85XraOtDaPP5kwiIm21xLG/Cmr/19m8Cd9XRqqTRV169l/Jnr/TdUu2Yk76p0uF
         +8kwfCipm8pfBpbFj2g5at40ilS5LRQdY1v6dMBg7JbvZ7Xd1pZsO9gzFrpi/r9WK8ey
         ZA4cUswsyq/i16ajbYDEL6tLkjgz1vVHjkowvA1Avnj8cNlC8a33gxiA0EGa4VdM0D0t
         TV87dmbYas1M+gzP4kt7N4T8UqAYH9rPn5YpL5wSJCDJvrpFPYOhXlQMOmYDZdQaO4Er
         tXSOt9Wh149ZwckvYyMkjT3+t7DnrtVNp/fcZvlHu853/eZ8rhf7jTsamPNRUlqZuvEn
         Jtxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjamBvhk/euj+MiRmaGyseSKatnxtrOZn+NpIkmNZbA=;
        b=b9193q0YNk9c0F7tW6syjA3IV5/SuJ3iI18hBUlEC4C73Yr748VAxua6US3ywdXjGy
         OsxUdgC8lBbd59lG7IS+vctqpMeyBvbw/h8Pbf80EBWU7Nwmarcrx+uNpg+mnnEuD9lx
         xevYyNvrx5UlsCeEBdjvJ55F4yBd5iD7N3WJzXZnKtsMrtfp0Q0Mh8TE6BZB2LkuWpRB
         W4pPeW/v+Y/GV+cljs1cAKNerQudB1YfQ67SnyrX+Qgkn//6MGgDsbinRA56/JUexRdz
         6P9oVCqA11+1Sk+HdzPFX9Slve29/EF7G2uXYJWE18YzhPhCmlt/XoPgV0UcbrZ7sPIP
         Z6og==
X-Gm-Message-State: AOAM5324T4WvRd9+C20XYDWyIqI4qRD9TuH9JSDizdcwm0Qea80nh79t
        yApAz/HqZyjd2kjOmTcbjOo5pZWZg9XSK51Kz8dY7Hus
X-Google-Smtp-Source: ABdhPJxbjHXqfYWWP1opEyHO50liWrhXTIz//7G94DcuAL1Xx48zwNwP6uOme8OafhqI6ruz5Shwygd1DzUrKjAWQKo=
X-Received: by 2002:a67:1702:: with SMTP id 2mr22552711vsx.153.1595976251424;
 Tue, 28 Jul 2020 15:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200728202124.GA1021264@coredump.intra.peff.net> <20200728202631.GH1021513@coredump.intra.peff.net>
In-Reply-To: <20200728202631.GH1021513@coredump.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 28 Jul 2020 15:43:59 -0700
Message-ID: <CA+P7+xq08K3MNn7jLoVS8Sqnj79yOSqnXeXU6uob=SKJYKmBxg@mail.gmail.com>
Subject: Re: [PATCH 08/11] strvec: fix indentation in renamed calls
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 1:29 PM Jeff King <peff@peff.net> wrote:
> Let's fix these up to align the arguments with the opening paren. I did
> this manually by sifting through the results of:
>
>   git jump grep 'strvec_.*,$'
>

I haven't seen this before. Some sort of alias that lets you open each
grep spot in an editor?
