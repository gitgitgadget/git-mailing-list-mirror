Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65152C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiFHA1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387827AbiFGWu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 18:50:58 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC8C2B4B3F
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 12:41:17 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id d7so10075483iof.10
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 12:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yf/KuHSdIqGIIELQI2NwOC9dZmp/n4vOBv7MaP3aMOk=;
        b=SD4nCBN9xBaHWHT6ueh+5h86sSlRy228ZaMKw/2ihoTpJ6BOKBa0jv8h6H/h1rv04R
         nc585R8UJnReEX7T4Ww+LU/ALuHMRE5whCvBjZlHugKqJG/B8ARTBeBmEMUQeWi6Gnl0
         c3Qp9LOql/SsBxFY6UmPn0ulYtC6Qiw7+bjVfvFYQmTcR9vHqdp9W582PeCrXKGza0Hq
         WsZmTvXVOLqJ7A/dUdzouT9P0mxlBsRsVm3bcuWT3yUDpTuVI9ExRiuEVoBPNIIvEcDL
         7IrT+RGJOXuLYQ+wrmYMcl9pYoWGj3ovnPnsL4nS38v85OxXTfJjBThgvspePDo6IFBg
         0gDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yf/KuHSdIqGIIELQI2NwOC9dZmp/n4vOBv7MaP3aMOk=;
        b=48nogi8Q0oVKGLIxBpSSikvV9hUkiFjkXlvw9DFI7SW507M1RvL7JFlXjy01hGydL1
         19nPw2FO3phfPlRR157cVAIt9t7NlzHhMPI/4Kka5ff3ubHenBuBxr4/SZd/rtOLw5xY
         r0eDGuGHNht+Nj7XNq2D2X+cpc+3PUE/pVNSeoscgpvP5xGodB22aRpF9/Z5LOlt1Yr1
         ApqT+WJSFVvAfcxCP5IMgF2iANW4K6yx6mHVzU6e/7ssFuLps1gde4tdimbntPTyVUws
         XV2zMbm3I1QZojcmvfHlLl9Fo8GhAmT0hK8Lgpxe0n0cU4Y6VfHYhfOapIj6ax1y+WAp
         gRCw==
X-Gm-Message-State: AOAM530ExfTfXc0MwRqFyj1WCqFylVwR13aNWdqc9p1z7n0q+zbAdrHm
        TuMpRs1jp7h7+5F30qZMhx4bTXsRVm9Z
X-Google-Smtp-Source: ABdhPJyyV+f0kyJa8MgNTKKt3b0aMHoGl2lrMaW4RVLR8LQnwUSNluC36PyO+qusaf39yOL0eBfj7g==
X-Received: by 2002:a05:6602:2e10:b0:669:670d:6a4 with SMTP id o16-20020a0566022e1000b00669670d06a4mr4344500iow.104.1654630876471;
        Tue, 07 Jun 2022 12:41:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:84ee:28a2:f31c:8892? ([2600:1700:e72:80a0:84ee:28a2:f31c:8892])
        by smtp.gmail.com with ESMTPSA id i3-20020a02a0c3000000b00330c5581c03sm7028408jah.1.2022.06.07.12.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 12:41:16 -0700 (PDT)
Message-ID: <73a973fa-cb44-b92e-e8c0-b68e14b4bd34@github.com>
Date:   Tue, 7 Jun 2022 15:41:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/2] builtin/show-ref.c: support `--count` for limiting
 output
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
References: <cover.1654552560.git.me@ttaylorr.com>
 <xmqqo7z54d7g.fsf@gitster.g> <Yp6GRccc5UElNrZb@nand.local>
 <xmqqk09t4cun.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqk09t4cun.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/6/2022 7:00 PM, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
>> If you're strongly opposed to having `show-ref` match `for-each-ref`'s
>> `--count` option, I won't be too sad. But I'm not in a huge rush to
>> replace this series with `git --pipe-to-head-N=<n>` either, FWIW.
> 
> Heh, to me "git --pipe-to-head-N=<n>" smells equally absurd, too ;-)

I wonder if we could teach Git to skip an extra process if we see

	git -c "core.pager=head -n=<N>" ...

?

Thanks,
-Stolee
