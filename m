Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128D9C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 08:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E474E610A2
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 08:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhHBIyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 04:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbhHBIyY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 04:54:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217FAC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 01:54:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b7so23460156edu.3
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 01:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=0alurNjt8q7w4JnlhzmQForPgNxe8R2UPkG747zupes=;
        b=ZY+NJklAPYcWPpUHrVJkaKRMXZNGwJSoGcjbLWZZwc7iAGmIboa+Uw57dBpPXatVMF
         Tz9mFBkwVBnOuOhHrbSYUwxV1GlZFHOTv8AJaUQ7vRpqO4zhFQh8zET58zfaO/tuNmyR
         8nZx6ycksJeDrR8HTSDvFYIb46acvPMPlJsAVKluQ8WVNYNf1Id7E1c3pTQF4idOJ7s9
         b61d2NG4FH0kquPkKJhdqkjYErcKMc2IZ0gsxcKn/V5FYBnFXl53LJtXic+NKibc5b9e
         LEUoozgN8GlaMt3JnSHUW9lAx1l6zKGl5NKJOgTCvvYg+EwJWxgER4FEZT5QI4WVUr/Q
         1Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=0alurNjt8q7w4JnlhzmQForPgNxe8R2UPkG747zupes=;
        b=qf0kNNQ/DsdY+fyvMon2chYK7+/r0VmNi+OZmKameL7OqjjIN62A3w5dnm37Wua1Bx
         pOmbL253MyjcAbdptELibxQb2RnUC1/m4PrCUYXD041BSFC9TXPX9KzmYIvi/uozuK3D
         JfgZziX+sTCgLNXWgAOnb876DqYTz44fruHB4Gv0T7+VZFWrcGgVVGX+4oB+sawp752t
         RjZ7hAzMp3fgz2tJos9Pg6SlQpTUqEaQNweXgd/3TFjkL4sZTmERlbf6a+xWvibSBvz9
         tN2sZxV/TMhjbzG6pjM387i2eFR7H6dYLczNu0ypww5aseNHfitFZ1FOOJXF20yxfwCW
         jw2Q==
X-Gm-Message-State: AOAM530x2sYNKg0T09al3PNPYMEkrzF//Lx96Stsr1KA5uxlkZIxIJCL
        7V14GRizsioaRb7FxCVNVGE=
X-Google-Smtp-Source: ABdhPJyfqkawHojP9hzeivDmiadRCMFaTZLf7a1oSkZA3dBIQ3Vo8n0fyfVY8isliI1s+rviEolgiw==
X-Received: by 2002:a05:6402:1396:: with SMTP id b22mr18072938edv.380.1627894452608;
        Mon, 02 Aug 2021 01:54:12 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id i6sm4203239ejr.68.2021.08.02.01.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 01:54:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: Remove constraint on --bare and --origin
Date:   Mon, 02 Aug 2021 10:53:04 +0200
References: <20210801082546.18543-1-oystwa@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210801082546.18543-1-oystwa@gmail.com>
Message-ID: <8735rsqlal.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Aug 01 2021, =C3=98ystein Walle wrote:

> This test has been present since long before clone was ported to C. Now
> there is no need for it, and since df61c88979 (clone: also configure url
> for bare clones, 2010-03-29) it's especially useful to allow both
> options.
>
> Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
> ---
>
> A question on this constraint popped up on #git the other day. I
> investigated a bit and found no particular reason for its existence. All
> tests still pass (except the one removed here) and the behavior is as
> expected. I realize it might have gone under the radar for 11 years but
> it's still worth the noise to remove it, in my opinion.
>
> I wanted to include a bit on the reasoning for the original check in the
> commit message but I couldn't find it.=20

Aside from working in Junio's reply as a summary of the original
justification in the commit message for a v2...

> -test_expect_success 'disallows --bare with --origin' '
> -
> -	test_must_fail git clone -o foo --bare parent clone-bare-o 2>err &&
> -	test_debug "cat err" &&
> -	test_i18ngrep -e "--bare and --origin foo options are incompatible" err
> -
> -'
> -

This just removes the only test, if it's "especially useful" to allow
both options let's replace this with a test that shows and tests for
those use-cases.
