Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,WEIRD_PORT shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4200201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 18:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751154AbdB1Stv (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 13:49:51 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34719 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbdB1Stq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 13:49:46 -0500
Received: by mail-pg0-f54.google.com with SMTP id p5so8806215pga.1
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 10:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=+tsmqxppvA44rxpFu4btG320l5YRQbiUmECRTQaGPe8=;
        b=EJcasv/14gdC0TXXm5QMflCPpD9XCpsGJQpRkM/EEmMGTwL2lws0EzKOcSpy9Qe+I+
         Eja3AWf7t19tRkDuXSZEDAWQgMHzccUHAAmmgfGwykfL32f3jd8QW2dpPR5OgWcWrOwg
         //w7I06SgJOrk5FS9nlOa4ASkjyYCMwUIxkrDf2Bxjy9mdlpJI0oQbgf5VdOWfq1mKhQ
         SrjihVke7VJeTlV/mEJyvL7lDfacZgWRZr/uaodNaPs0AX3Osr2ASjkBUWyzKGhoNSJh
         QaKecOcK69Om9YFQsDtfhvIIBpx5+Wvomik4u0NkVZ6JuPjbv4MpH44eeH56+731vIGj
         jeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=+tsmqxppvA44rxpFu4btG320l5YRQbiUmECRTQaGPe8=;
        b=DndYDXVt7mJDfaYi/8/culzvSQK0OIlpXNvswNn798YXhIUDB3w5F18/0QRU4orHj2
         BKZgH5074XrH3cZtQ0Qczc3Jmf86YAEP11YYPaS6OO/NngdJsYpDehjZHp0SQmx0GGxD
         xQsK3wGDw9wbLDzLXviKHWjRzr7AMLZhpRO0hO1APEnMiFwrdOoTMWGhDvPJ+/QldstY
         dBd1Fr3CGV8kI03t/lw1kG5lnrfyqXCzt0lM4i9bDYAlYdCoafc+qm10+Hno9HIPdbzG
         odvcUwlpioPxLD3/WKSoOzsaeukZ1DsX1T7zrexw8JhXa5ph5AyShzU5QB/6DGcuZL3G
         u9Dw==
X-Gm-Message-State: AMke39moljmRifqgAqnd92nWiGx6Ak1haGEyhYAeT03AlBOAdw3fbajeXDO8gueEjCc02JUU
X-Received: by 10.98.10.69 with SMTP id s66mr4131156pfi.146.1488307734356;
        Tue, 28 Feb 2017 10:48:54 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:d5df:502e:cc15:2daf])
        by smtp.gmail.com with ESMTPSA id i70sm5668716pfi.67.2017.02.28.10.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Feb 2017 10:48:53 -0800 (PST)
Subject: Re: [PATCH] http: attempt updating base URL only if no error
To:     Jeff King <peff@peff.net>
References: <20170228025311.6347-1-jonathantanmy@google.com>
 <20170228132814.wp3cq4ilp7syinqy@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <6127c0a7-800d-fcf3-c6e2-17533347f07e@google.com>
Date:   Tue, 28 Feb 2017 10:48:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170228132814.wp3cq4ilp7syinqy@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/28/2017 05:28 AM, Jeff King wrote:
> Right, your patch makes sense. A real HTTP error should take precedence
> over the url-update trickery.
>
> Acked-by: Jeff King <peff@peff.net>

Thanks!

> Running your included test, we get:
>
>   fatal: unable to access 'http://127.0.0.1:5550/redir-to/502/': The
>   requested URL returned error: 502
>
> but the error really happened in the intermediate step. I wonder if we
> should show the effective_url in that case, as it's more likely to
> pinpoint the problem. OTOH, we do not mention the intermediate redirect
> at all, so they might be confused about where that URL came from. If you
> really want to debug HTTP confusion, you should use GIT_TRACE_CURL.

Yeah, if we mention the effective_url, I think that there would need to 
be a lot more explaining to be done (e.g. why does my URL have 
"info/refs?service=git-upload-pack" tacked on at the end). It might be 
better to just recommend GIT_TRACE_CURL.
