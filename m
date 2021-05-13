Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52ABDC433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 11:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2152C61073
	for <git@archiver.kernel.org>; Thu, 13 May 2021 11:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhEMLHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 07:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbhEMLGx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 07:06:53 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E19EC061761
        for <git@vger.kernel.org>; Thu, 13 May 2021 04:05:41 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id e19so3151714pfv.3
        for <git@vger.kernel.org>; Thu, 13 May 2021 04:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xUQbLNTPUoovdggcG65cIZVLZDPCxZFldHTp/N+6zD8=;
        b=r/ZzzaummSfa53Mh0I7AzGFZA4JeMwiIOqNlhZDkEvkh/mi2A2mY9EHozNCuqgi0rG
         xOmxqP5jlLAs/WIXRTaYLBOVEkKCMcCLglAWRmINmNs+gdiJU3hXpm9iIpusxaUvXpgC
         PPk/faK1BBAapja9I5S/I2FYWb5SaiMV1shHwW5Z/ADRJ9XCnNpIH+ZMFr42ZCGdR0Pd
         RrYNYUswVUSwhYhtkYkjQDK1sk16rp1TSZoI01QJMZJm6+AIA7WwNfKe+BAD7EOzy5b5
         wu+9km3TOIT0A4JEBeAlyvZHqvlorWG6GnGN9dO0eFHsNfRi8LT3u2v2OhqnnsHvRJ0T
         USvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xUQbLNTPUoovdggcG65cIZVLZDPCxZFldHTp/N+6zD8=;
        b=MMgB4nJlx3qzNlKnd1GAyKgGNWuxyE3gGfsS6FzV90W5VPcCnAUMZ/Q0JpXjI+vJKa
         eXlqY6GtBdWEoUIH2fD5xNUNezPQGrz5m94jH8RpjMlPbeEHHzr0D5pa6s8KA2Ofs9Bx
         NBK1n5Krwq5kzlBGPVZ1xjrUEV8kguBzMAwkaLo/ZaZj7ZqCnnZgRqhFXFyVAMYWaJt3
         rjKoVC5BMTPw1+s9nCMSMUBJM0eWCg05Ua+SBi/1x04CmAwN20HjZ2lBw3kiHcdjNcqo
         pP5stQgBfdzZnAb8Yf7qLjYU9Ya6gXwP5nkAnN1EG0tYisok8TaOw31X3b8jvG+oj+vo
         Bo4g==
X-Gm-Message-State: AOAM530JM520a+eBsoN8yfap3BozjKqXKPWJHB6LlhfsodSWhHiZ8wyk
        Jc0yxg1OOdfzBLjKE+jT+zMPzBqA0GKlI2SIEy9A1dyb
X-Google-Smtp-Source: ABdhPJwovdSJcfFWabgAbM16NuusyVx8eSul8Z1fVeeyN9lpRj/LInttJf9xlBbp3Q3VGajdSbWxPu3oMI8Aw0hN6o4=
X-Received: by 2002:aa7:8ac3:0:b029:28e:df57:991b with SMTP id
 b3-20020aa78ac30000b029028edf57991bmr39890597pfd.38.1620903941206; Thu, 13
 May 2021 04:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <YJzGcZpZ+E9R0gYd@coredump.intra.peff.net>
In-Reply-To: <YJzGcZpZ+E9R0gYd@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 13 May 2021 13:05:28 +0200
Message-ID: <CAN0heSp3mXQeqeC_Zd==bBoJCCWe-NzJsomuUf6MTxy7+WZ1wA@mail.gmail.com>
Subject: Re: [PATCH] t: avoid sed-based chain-linting in some expensive cases
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 13 May 2021 at 08:29, Jeff King <peff@peff.net> wrote:
> This patch introduces a mechanism for controlling when those extra
> lint checks are run, at two levels:
>
>   - a user can ask to disable or to force-enable the checks by setting
>     GIT_TEST_CHAIN_LINT_HARDER
>
>   - if the user hasn't specified a preference, individual scripts can
>     disable the checks by setting GIT_TEST_CHAIN_LINT_HARDER_DEFAULT;
>     scripts which don't set that get the current behavior of enabling
>     them.

> +# Disable expensive chain-lint tests; all of the tests in this script
> +# are variants of a few trivial test-tool invocations, and there are a lot of
> +# them.
> +GIT_TEST_CHAIN_LINT_HARDER_DEFAULT=0

Devil's advocate: Who do we expect to turn GIT_TEST_CHAIN_LINT_HARDER
on, and when?  If no one ever does it then we might as well drop the
"default" thing and just go "we won't bother linting these particular
tests, ever". But as long as "someone" does it "sometimes", it's not
like it's a very complex mechanism to carry around.

I seem to have 140 tests that haven't changed on disk since I did this
particular clone in 2017. 235 haven't changed this calendar year. Maybe
we could skip linting those tests that haven't been modified for several
weeks on the basis that they can't reasonably have newly-introduced
syntax mistakes. I guess it gets tricky where the t????-*.sh file
doesn't change in a long time, but it sources tests from other places,
such as a lib-foo.sh helper. We'd have to be a bit more clever there.
That's all just thinking out loud, and definitely not something that
should hold up your patch.


Martin
