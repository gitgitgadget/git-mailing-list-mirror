Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F579C433DF
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 22:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D36207FC
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 22:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jkqps9bW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgG1WpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbgG1WpU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 18:45:20 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C65FC061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 15:45:20 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id m18so4955575vkk.7
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVk6fV38CUc5qawTlbo80bBXF0XgXcZymLlwMKzfpgc=;
        b=Jkqps9bWC6FoP941cLq8PQOdAaCaceh1GH1GQ4POFGMw7Sy98t+5NCg67B4rj0KRzD
         RFSrM/v7tGyBShkKdNL5LYebdXP1mOj1ym5QgX/s8aa9NJlYn+EbyU/yBUczYVgryD+Y
         HoiGqQEWV7cnAmaOV+6Mt4yfFSP6PeYvPKqIgItLXq1bioCjDbNw+rbVvRLvg2dOA3m4
         3UaRpqm2VwSF1CNuMZjsgynJmyUgiuR3MOYiurmTVkDs9fMJMIcYPVxYib86bVGYEWmM
         nuzVia+0KGtjZyFXfR372JbWcq3CDgfhI2Mp6cO36XK2sa4T6icBgJyn2uiOLGPw6soQ
         5u0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVk6fV38CUc5qawTlbo80bBXF0XgXcZymLlwMKzfpgc=;
        b=SV1wzy0fbwxIPLifprmVM1TGpnofpEvlN7eldusMxw6UoLWbuk45puGpCfIQq7FR3v
         GurqAFoLhiIvTeytOP/CGsjRgxgND2248k7UngjcE8hJfQJOiN7aCZHpedM796YPnjLc
         jFnx+CXzXsCXRMPcf+vxszeI+Xg4sUMFdPvdWS7pNx1yHp5O2lM1355yJxE3KYRZXCsH
         onaoRYsrFcebk+iOYeegYfkMmnQ7AH5kKNvhwmzwXMUar6/iASSR+N4ysWuIw+udG1I+
         Ketdyn1d66hNn6A3U4jHPzP5eV9GJIVHQ6rIQHzBxMXwDF7vneHIPgtXlNvgtK2wj8jD
         sUEw==
X-Gm-Message-State: AOAM532WE+MD4sbTKyrlP9kURv/aiv46bfQGn2H9iThXZLmZqJ1be7o4
        AF1eRSnsoPdD1inrA02/lgMmn0yJKcYT5Ibpe2bvpjPI
X-Google-Smtp-Source: ABdhPJxDfjHXf0f3pTeMxEjpoEH2cx0WKDWs8nUNaSEDflyOBaZ8cnqsJpmRo2Gojf1Z81a8TvtrLOxcOeCmUgYaMz0=
X-Received: by 2002:a1f:cf01:: with SMTP id f1mr15130901vkg.21.1595976319720;
 Tue, 28 Jul 2020 15:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200728202124.GA1021264@coredump.intra.peff.net>
In-Reply-To: <20200728202124.GA1021264@coredump.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 28 Jul 2020 15:45:08 -0700
Message-ID: <CA+P7+xqrV7yvQ2XihDnjuuT5Ro0_qvb4WS6tNH2GGn5DQzoLNw@mail.gmail.com>
Subject: Re: [PATCH 0/11] renaming argv_array
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 1:25 PM Jeff King <peff@peff.net> wrote:
>
> The argv_array data type has turned out to be useful in our code base,
> but the name isn't very good. From patch 2 of this series:
>
>   The name "argv-array" isn't very good, because it describes what the
>   data type can be used for (program argument arrays), not what it
>   actually is (a dynamically-growing string array that maintains a
>   NULL-terminator invariant). This leads to people being hesitant to use
>   it for other cases where it would actually be a good fit. The existing
>   name is also clunky to use. It's overly long, and the name often leads
>   to saying things like "argv.argv" (i.e., the field names overlap with
>   variable names, since they're describing the use, not the type). Let's
>   give it a more neutral name.
>
> This has bugged me for a while, so I decided to finally fix it. It
> wasn't _too_ painful, though I'm sure there will be a little fallout
> with topics in flight.
>
> I tried to split out the mechanical bits into their own patches to make
> reviewing easier. Patches 5-7 really could be a single patch, but
> they're too big for the mailing list. I'm OK to leave them separate, or
> they could be squashed together.
>
> We could stop at patch 9 for now and allow topics in flight to catch up
> before removing the compat layers. But the struct field renaming has to
> happen as a single step, so it will be a pain whenever we do it. If
> we're going to go this route, I'd just as soon do it all now and deal
> with other topics as they get merged.
>
>   [01/11]: argv-array: use size_t for count and alloc
>   [02/11]: argv-array: rename to strvec
>   [03/11]: strvec: rename files from argv-array to strvec
>   [04/11]: quote: rename sq_dequote_to_argv_array to mention strvec
>   [05/11]: strvec: convert builtin/ callers away from argv_array name
>   [06/11]: strvec: convert more callers away from argv_array name
>   [07/11]: strvec: convert remaining callers away from argv_array name
>   [08/11]: strvec: fix indentation in renamed calls
>   [09/11]: strvec: update documention to avoid argv_array
>   [10/11]: strvec: drop argv_array compatibility layer
>   [11/11]: strvec: rename struct fields
>

I like this. It definitely helps to name the API after what it does.

One thing I thought I would see but I guess we simply don't have one
is a technical doc that details the strvec. I guess we just never had
one for argv_array? Probably worth adding one at some point.

Thanks,
Jake
