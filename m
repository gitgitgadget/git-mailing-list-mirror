Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97538C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 10:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347221AbiFOKrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 06:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245468AbiFOKrP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 06:47:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A75151E56
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:47:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eo8so7295104edb.0
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=rqLn5pC7YqwLPuVdUKNuj0xuX0LI+wdw6kOwMh1PylA=;
        b=P+7UuCYbKde/TsCZ1HgrBQeXV2d8ZTtNM3OPA9DoEap5uqDKGDOqM4BUwgufoX2jox
         nx8l1nshlrfTmOUZGoxrPyFMyRyq0fB89srvJq3Bya5YP5Ix97DfUxQJ8/UF+AQD/klE
         w1tEh7fdu9u7+vQOW3L8etKzUywiMyUlMawTeZehnmmLVAonkPj/amYPEqubVwm5aWtw
         lduL0kaPifC8kMJvRJNt6oAmEBgGaP+cvTfM1VtvkRTKrTY6IqcHlUl97mDYweo0rEsl
         uPrtDosDlhlEX/v9ThyCg4Cvwdjr3dR9JffnLBCmoWY2RaA2+NtT6vbFTMtfUPTMgRry
         m+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=rqLn5pC7YqwLPuVdUKNuj0xuX0LI+wdw6kOwMh1PylA=;
        b=umtkV7cbYbvPJgUFo7RmzDBXVxh8nt9zSU4wA5c8lVaX1vk7CRN8c68zctzFc21/ST
         iz04ELUaWYOqsWxEGtJ2NiRSqFb/NN0SM1it48PW/VOJMEGcgE9V+0oc54OrYqr2xH4C
         QS9JdXn+fS80k+4PFIDfzkMcMzu4beyeaio8i3MtMK7ep3o/fFK9o4HSklB5GgyAwOqw
         q/qDBqw+MdllQwDAZIyGe1yEtmZXxoMAuS5nnDQX3FaFmJv5zXJ4rDSH0uZQ4nBhgRS/
         LVNIxAkkjMP0XodzeA0V34KPhti0zzvAqLUHQyadBHETImOoDSHan7d5xl2cKmIqM9G6
         Gkag==
X-Gm-Message-State: AJIora+D93fw80chZgvRgd1tcyZ48zqpric+OaVxJfrMAzs97trx2tPM
        dlI8R4LViM3vBO9TX9j0bX4=
X-Google-Smtp-Source: ABdhPJxfx2e8RkvJ0Xa5YE+1Mu2Mjoqr4SS2eskJqD//vDuLG1NoemIqR8UN18Hf95WRzkHdpPkQ3w==
X-Received: by 2002:a05:6402:190b:b0:431:3231:fce6 with SMTP id e11-20020a056402190b00b004313231fce6mr11829968edz.127.1655290032914;
        Wed, 15 Jun 2022 03:47:12 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id wi23-20020a170906fd5700b006f3ef214e3bsm6071572ejb.161.2022.06.15.03.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:47:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o1QYJ-000o1v-IA;
        Wed, 15 Jun 2022 12:47:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     rsbecker@nexbridge.com
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Test Failure t5516.113 RE: [ANNOUNCE] Git v2.37.0-rc0
Date:   Wed, 15 Jun 2022 12:46:21 +0200
References: <01e801d880a0$2c5e4d50$851ae7f0$@nexbridge.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <01e801d880a0$2c5e4d50$851ae7f0$@nexbridge.com>
Message-ID: <220615.86ilp2xky8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 15 2022, rsbecker@nexbridge.com wrote:

> On June 13, 2022 9:46 PM, Junio C Hamano wrote:
>>An early preview release Git v2.37.0-rc0 is now available for testing at the usual
>>places.  It is comprised of 339 non-merge commits since v2.36.0, contributed by 59
>>people, 18 of which are new faces [*].  There are a few topics that we may want to
>>merge before the final release, which will be in -rc1 that is planned to be tagged at
>>around the end of the week.
>
> This one keeps showing up occasionally. I am not sure why, but I am
> not certain bash likes ! grep. This only happens on our NonStop x86
> build, which is a more recent platform than the ia64, where the
> construct succeeds. Have we not moved away from that?
>
> not ok 113 - fetch warns or fails when using username:password
> #	
> #		message="URL 'https://username:<redacted>@localhost/' uses plaintext credentials" &&
> #		test_must_fail git -c fetch.credentialsInUrl=allow fetch https://username:password@localhost 2>err &&
> #		! grep "$message" err &&
> #	
> #		test_must_fail git -c fetch.credentialsInUrl=warn fetch https://username:password@localhost 2>err &&
> #		grep "warning: $message" err >warnings &&
> #		test_line_count = 3 warnings &&
> #	
> #		test_must_fail git -c fetch.credentialsInUrl=die fetch https://username:password@localhost 2>err &&
> #		grep "fatal: $message" err >warnings &&
> #		test_line_count = 1 warnings &&
> #	
> #		test_must_fail git -c fetch.credentialsInUrl=die fetch https://username:@localhost 2>err &&
> #		grep "fatal: $message" err >warnings &&
> #		test_line_count = 1 warnings
> #	

I've submitted
https://lore.kernel.org/git/cover-0.1-00000000000-20220615T103609Z-avarab@gmail.com
to fix this (but spotted this thread just afterwards, I fixed the bug
yesterday).

This happens on all platforms, you just happen to have NO_CURL=Y only in
your nonstop build.
