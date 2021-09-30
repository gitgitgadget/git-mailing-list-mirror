Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C846C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 23:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF7761A08
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 23:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345610AbhI3XZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 19:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhI3XZH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 19:25:07 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FEBC06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 16:23:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s17so27409885edd.8
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 16:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=cacP9MVDNxDqECaQtsfEiBYXoy37wz/FBM+zOtIkWqM=;
        b=LPoU7GpqYevhabQ3dSd7uKt+ZbD+UNfpGiqylbUJC8Ec0VkykpfxlkznClH4XwRVTz
         DuWUmUx7J1O7SE7uiNGCGZAwrDDjc47UPZAC3AxlHxZ0zAn3pYlPMF8T9t+UyPcjroOG
         YUoWRl4vV+e3NFi6C7RKtMQfktYXjnl5g8LEYHgk2ETqrdJTbYBUe3rYxPA8kGHamsrR
         keVCpwcUg5c3ABm5LhOaY8nLlB7WvQ3jE1O6WraAPeIu9zCIlk3O6BYM3xaT4jPjKUUa
         MlChWAZ8S8Dl+Ji9lwJkZ7jj4fvVb9hh0ObUOrKBg3UoHoO2blS1wEmk7149t1nZbMmB
         JRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=cacP9MVDNxDqECaQtsfEiBYXoy37wz/FBM+zOtIkWqM=;
        b=7UFT9nptR7cUgnDbM87+zqFSyjAri1/pPcgc/0zIs1NKgQ+Ke6GJf3cXTzku8exWuH
         /5M+kLEUFrnnP5BJfznngTbDdYuhEOSP5Pjt5/S6JY26qGyQuoCJK4EtOgeGIgBqQJ2j
         jOsBAEhVi2srZbXpQns2ZKG+pjqkEToHyn+1GQ/WON48jGiRjhrIe7yi3dKTitFTm5iJ
         261NFXkqnRnPHx9cb8trm9UUXRQKZPmXfc7za36SR+QCLoyZnuyWIqfodE8TkOTu1toV
         5ofFkEwIP5FHLCjjYm7eyuznAg0FcEyFqcsfuq328DYAxSzI6kzR7Vv6j8/J6/RmBLsS
         YD+w==
X-Gm-Message-State: AOAM5315GGEV9ZIQydb+6m58CecgErkOtGmDMlpHDatzuBZysYKlQyge
        +TOt6DxsbjL0ltw2S0nclARhJEibI9RE4w==
X-Google-Smtp-Source: ABdhPJwSNipZEas3h2awyxEbh6A4ytqSYD8VyqNft2ICW/1sqQf5SfT63KgG4NmVJkP5BmrG/lkIrw==
X-Received: by 2002:a17:906:401:: with SMTP id d1mr2469959eja.242.1633044202264;
        Thu, 30 Sep 2021 16:23:22 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e22sm2371291edu.35.2021.09.30.16.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 16:23:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Brian Bartels <bartels.desmond@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Should help.autocorrect be on by default?
Date:   Fri, 01 Oct 2021 01:16:40 +0200
References: <CAEWW4VdL0N9DmJ7jwGY0WNN6SR75v-RR2HU-uFn7qDkod8o7Sg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CAEWW4VdL0N9DmJ7jwGY0WNN6SR75v-RR2HU-uFn7qDkod8o7Sg@mail.gmail.com>
Message-ID: <875yuhtzpz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 30 2021, Brian Bartels wrote:

> This would save developers precious inner loop time. I looked at the
> code and it already handles cases where the environment isn't
> interactive. So this should be a pretty minor configuration change.
>
> Let me know what you think,
> Brian

I haven't looked myself, but it's very informative to browse the list
archives at https://lore.kernel.org/git/ (search for help.autocorrect)
to see if this has been brought up before, whether there were any
arguments for/against, or if it was just an arbitrary (or careful due to
a new feature) default at the time.

That and trying your hand at flipping the default via a patch, running
the tests, seeing if any fail & fixing them is also a good way to both
get the ball rolling, and to discover any past opinions about what
should/shouldn't be the default added as code/tests at the time.
