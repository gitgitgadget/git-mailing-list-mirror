Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8357AC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 23:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349320AbiBCXjt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 18:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiBCXjs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 18:39:48 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF14EC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 15:39:48 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id s6so3581583plg.12
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 15:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4t37gZ18l1yCiZXZ4iZzji55muCrQJvSOPwSRqqOOBo=;
        b=S59ykCMjitFJ4UI07L3S1wfIt+4b/1Yy3vhOrIkN2Gya39kdWOfXMEArLIH3x5DqLc
         zXFhu2bE0t7UqJTX8LElhFZ8bPnWnozRRfJSvN3NhE1ZV9IcI0CJrmSOYzLRyl9n2mfx
         XgeyGOVhgUG2z7vkcPew6OG4lFF8JgwlmDZB+0P1w+2ZsaITBVePdDrD6yXRRB+0+wpf
         pq/HQXmzTdcYo8Zo33blYL7mFvv9feIHZ1rI3+Hknriq9s6tD0XDbQQfLH0/em9gvmTD
         gULY04hzNH/3JjqjKL1CCy0Z92ZzJ4H1dxcKk25BnG0kdqTJpA4XYMd5lN7ifIFE9o+H
         0OGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=4t37gZ18l1yCiZXZ4iZzji55muCrQJvSOPwSRqqOOBo=;
        b=6E4UKhI5T1BgfZUliZkJ+IoWF9nAZvFYaR4wVPBMydDdBAt3N5oL8wY3QJlF1HlZ/o
         KWncMZAmI5cfnqGefx5z+m+MT4RDKZ+HzowrdIWCoPhIRlfdXxwpoPQnROtdXI9DnDf2
         SqOAHxL0N3foo9IXoI05Ucsd4xeE+FlEPWJqri1ZgyfhiPZm0Q+uyV45CNlFO/bsfng7
         HhNqd4jKmJ2lSTa33m6aYhgd7is+XUC6nyBYutWPsNX5lo86wlBl+05cJsbOn8m/KM9m
         YHk8yMb8mlhaE9NkNapyYx4VEpBbYmkkvZrBfRNk6jqKlZeJ4RiYHQ1PvCbS8sNxZrlZ
         2D7A==
X-Gm-Message-State: AOAM531ZwO9bhdcWTfDh5CNSDW4k2jPLTheP+D7Uw7BxXAxzgdFQ9ZnM
        z40h0JUkw8nt/CNk2X3kxUIwQCFLN88=
X-Google-Smtp-Source: ABdhPJzbJWKb6Yncwsk1jOwGBBALkPmTeHWGU/lOXQ0bN5HzDO2ddiB5e28Tdz94Eg1qZ2hz0JR9Ow==
X-Received: by 2002:a17:90b:4c44:: with SMTP id np4mr90181pjb.81.1643931588246;
        Thu, 03 Feb 2022 15:39:48 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id u37sm120490pga.2.2022.02.03.15.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 15:39:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v9 0/9] progress: test fixes / cleanup
References: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>
        <cover-v9-0.9-00000000000-20220203T213350Z-avarab@gmail.com>
Date:   Thu, 03 Feb 2022 15:39:47 -0800
In-Reply-To: <cover-v9-0.9-00000000000-20220203T213350Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 3 Feb
 2022 22:40:10
        +0100")
Message-ID: <xmqqtudfplj0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> But most significantly as René pointed out stop_progress() and
> stop_progress_msg() should really be unified. This series does that,
> which fixes a long-standing bug with the trace2 region not being ended
> if the stop_progress_msg() variant was called.

;-)

Yes, it is very pleasing to see it fixed.

Will take a look and queue but after finishing the week's "What's
cooking" report.

Thanks.
