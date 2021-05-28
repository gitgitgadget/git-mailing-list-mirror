Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B85C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B9961378
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhE1Mtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbhE1Mtr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:49:47 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E34FC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:48:11 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n8so1578288plf.7
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YpTFXUgbwGokFEB8Nq3kVWEnbrOG30+w43Rx6vRbItg=;
        b=eElliwX53Fx0eg7ihGzunFojq9c8QpgfLr+JQQE0KO70YOIMMoYkOefD4aNGldrBAt
         D12SAjNYGbCfp5hLrqtCeZpHXxKTShTil6jJjq+77DgOYNlQc9FauDFO6++amhTYIPT+
         w+YZfYa4/LOn7FlKuxJlYOnEtW855rFIwcgUDCbNWIDuvL8UiIqYEdDed31h/QvdAvCq
         WEqgMVkdxqbQgPnLuVGMfJ9hpbwbsYCLx6Du4j4SHMhQy2I+Yd1bFHcEQ1194SKJSmTs
         jQwAOHYo+63O+hQj5QhcVCc5Uvj/nciZG9C3li3/DwcMfvW1XbBm8jwYABKd8uUCkd0O
         AdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YpTFXUgbwGokFEB8Nq3kVWEnbrOG30+w43Rx6vRbItg=;
        b=K+8B0Xec8ghfPrJk2bb/OSK6GoOjBXr/Ufmf0pg8Tk+Obh+Uey1T/0v865Bq/a4KJn
         mMypNGN2Zn7Nb0g9oUd5NoGGLENJjqdFcSQ8FN6aS12lRPhH74GDy6Vu029uSKGDozw8
         ayjSwGuuJRTCUo5Nug5SzXjlZc0SgkA4oPLQZt9DW1zbA5+oHQNmnD1oO26Lq/xGRdva
         eE4dIaFYX+iID4Obgm5+7FMgikti+W7mk+ufUj+bUUgtTgmH0ToyX9QinJNOrNjwA5Cs
         NWzT+o3H4heZ6Mz3bbStVI0CyQxSmWPDpSs/Y1Fhc0zZtRrDqg0RXfxfcc2Hb4EE2wqn
         RugQ==
X-Gm-Message-State: AOAM533VuCst4ABNQSp/NZ6hb3V7ZZEJ4sZxCQ6pWMY8factDOFkokmF
        Z0vgb5L+3hOpMpvRE9xptvQ=
X-Google-Smtp-Source: ABdhPJzOGh7uc00abrY7xI6p6oEUj0IEDyiRYVo8V3V9XA2wgmAUQBWE3g9ky5jnbF/K2LMVGwxE0Q==
X-Received: by 2002:a17:902:6501:b029:ef:8518:a25a with SMTP id b1-20020a1709026501b02900ef8518a25amr8010133plk.64.1622206090943;
        Fri, 28 May 2021 05:48:10 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-74.three.co.id. [180.214.232.74])
        by smtp.gmail.com with ESMTPSA id e7sm4666760pfl.171.2021.05.28.05.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 05:48:10 -0700 (PDT)
Subject: Re: [PATCH 30/31] hooks: fix a TOCTOU in "did we run a hook?"
 heuristic
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com>
 <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <patch-30.31-d93bdc0c294-20210528T110515Z-avarab@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <b5c0a071-a073-7153-a623-75642a79942e@gmail.com>
Date:   Fri, 28 May 2021 19:48:06 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <patch-30.31-d93bdc0c294-20210528T110515Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/05/21 19.11, Ævar Arnfjörð Bjarmason wrote:
> Let's also change this for the push-to-checkout hook. Now instead of
> checking if the hook exists and either doing a push to checkout or a
> push to deploy we'll always attempt a push to checkout. If the hook
> doesn't exist we'll fall back on push to deploy. The same behavior as
> before, without the TOCTOU race. See 0855331941b (receive-pack:
> support push-to-checkout hook, 2014-12-01) for the introduction of the
> previous behavior.

What is TOCTOU? I never hear this term before.

-- 
An old man doll... just what I always wanted! - Clara
