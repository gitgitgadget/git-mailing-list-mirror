Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11199C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 10:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25D261279
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 10:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbhDIKAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 06:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbhDIJ6x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 05:58:53 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D51BC0613D8
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 02:58:36 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y2so2496284plg.5
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 02:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rEQ4XmN3XY0yUpirSe1qEs++9Sw1oYtBP0vzwEhZE34=;
        b=ESloUYyUzlDaaCT5ngf+bQ8FeP2q5Sd8nwxCSTQ2/eocstsoIfkZnA13DpSmOkaiWT
         5Wbb1pcC1Wde7ekV1ChSKLld73sKERDcsDiu5rpGlpSYx+iPcFQIVJouP2CZ9D8ZAPf4
         47OSfU0BEEgwDl5X0lr2gA54VByZ6RU+DOHMhZCwZVSEIvfiFz7IwHpnAwUI7//GehRP
         TZ+5dPLLHIDkGX3mqNPSfaaXIabRZXsuntBY/51edTJqKaDVEsJXfrtfyhoIcIjQjCFm
         Yb1AysWbHKNIffCjqWhh096+yf3E0NEsgkY7FbKpNwJfPrXnWmHn6Mw+LAEH5S6xbB9v
         PVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rEQ4XmN3XY0yUpirSe1qEs++9Sw1oYtBP0vzwEhZE34=;
        b=UKQEGhfOb5XHF7/BRyuiKZeD3PbMuDEbSF0/40yi6iC+r7cO0iVLo/JL4W6GdcXwfy
         vF6S0H4BRAVnVt7J0od0g08XJfrpBk9Uv6tMdWheBf2WtPh8c5OgeSIj8iZ0OquYWf6w
         184a8cD0ZoL1lUq145KQcc8JJCKHzVjZdtHuyC1rFwXPUpow7mMCjTwv8Qk3kfPBAcxZ
         GQmi8nErHqNx9/WLJn6RQEUfGdPzEEx04qGBPSmcK0x6xkII/m30e54ssvCBw8OcxXui
         /Z6DfkABNWkQcjWTXW6mIg6hMaQakc2RvUQEiRH/ohS46ZDHmPmDnxJN0eRFRRaETGZi
         Nc3g==
X-Gm-Message-State: AOAM5307q5l74QTr+5exK29vQ3KSjMX8KodGiNcq//XwGunYLCnJ/56E
        +cdD/5YDbV2kUja08hjJJOnkgRiTN4hTNw==
X-Google-Smtp-Source: ABdhPJzcd8TzgULWYIWN06GfKrfGqqXAizK1uxuJ8RlAueqyeEPFtEnaOuJGqUnTGWj8mvOFgZ6Gag==
X-Received: by 2002:a17:902:d645:b029:e8:ec90:d097 with SMTP id y5-20020a170902d645b02900e8ec90d097mr12163797plh.47.1617962315607;
        Fri, 09 Apr 2021 02:58:35 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-9.three.co.id. [180.214.232.9])
        by smtp.gmail.com with ESMTPSA id w6sm1911393pjl.49.2021.04.09.02.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 02:58:35 -0700 (PDT)
Subject: Re: There should have be git gc --repack-arguments
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <b35a68a1-e693-5502-7a28-a1dd8222d3a0@gmail.com>
 <YG4J7vtTRVpGGLoo@coredump.intra.peff.net> <xmqq8s5tzv4f.fsf@gitster.g>
 <YG4mImcQyTC1/S8X@coredump.intra.peff.net> <xmqqa6q9yc8c.fsf@gitster.g>
 <YG4ws7PiKKKjPUff@coredump.intra.peff.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <1edb799b-5e17-264d-e525-5355c52af36a@gmail.com>
Date:   Fri, 9 Apr 2021 16:58:32 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YG4ws7PiKKKjPUff@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/04/21 05.22, Jeff King wrote:
> If you are sneaker-netting, you are probably better off to just split
> the pack at byte boundaries with an external tool anyway, for two
> reasons:
> 
>    - our max-pack-size is just a guideline. It only splits at object
>      boundaries so if you have an object bigger than the max, we'll
>      exceed it.
> 
>    - dedicated splitting tools often have useful extra features, like
>      k-of-n error correction.
> 
What external tools are for splitting packs? Can splitted packs
by such tools still be usable by Git?

-- 
An old man doll... just what I always wanted! - Clara
