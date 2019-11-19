Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACFC41F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 21:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfKSVr3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 16:47:29 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:45474 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfKSVr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 16:47:29 -0500
Received: by mail-pj1-f67.google.com with SMTP id m71so3202004pjb.12
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 13:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Si5IXlQEvl28ZMOzWoQC7fI8UynO9XKuma3O9ioB98=;
        b=Cn5vsfsJ7Gg757z8U7anUi2lrKePkY4CjJDmeKfuNm96ZuMdO71Ya0kupduG8wFXrV
         uX6gUvyKd42dfU6s1brhv7e2cfst5kyiI0MlrQfpSlCz5iudv7FvCiuhFFL0v4GDtPjm
         QQ8VP4ktQYlMR64OpYuvLnPHXZR0t3XvxclUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Si5IXlQEvl28ZMOzWoQC7fI8UynO9XKuma3O9ioB98=;
        b=GcMWtaSo52pnSyedRsUdTYbqJLlZwZ7zlaNnopxlF5Zu5zZf77oqE0EAg4F2yBL8wy
         Bx8hsM4e/Jr3cRAgUT1+NGM8zWu1XkKP7RYjPP8IZRhKqlfrk+PQEHv4Novl76P6TmM2
         zfUQ+EBcJfq+sBeFqFR5NCHUcaca7tpxfcqW0BsbIFYzNRvwg7WrItrmVJ8hBovJci6P
         FWneG0AvCsp526QlFuSqB1oY1xx6rYLzpspv2WJLfxVn+R3ifrd2gypo+rxkZR+iI/SZ
         4bf4ijxGuEZkAYccCUE1wHlUw7I/1CN3G3UQOZGM2YSpTD/ZYp/TTjlAc+Yw/SZpPVij
         NHIg==
X-Gm-Message-State: APjAAAV5m6SKxb2gRRUm+ViaLKxGEv8xg18WLjdcZqwpC9POoPJwg6NP
        L/GiwlZ7jwwrsm5mn9Uzt6d1itSipxY=
X-Google-Smtp-Source: APXvYqybB7rSY0VhZ8ylS//3r8BX+tXmyUxL/ni1C+EnGDAnO4NfOLSovcOeUC4iVNg7YmHn6a22Pg==
X-Received: by 2002:a17:90a:2942:: with SMTP id x2mr9259681pjf.119.1574200048225;
        Tue, 19 Nov 2019 13:47:28 -0800 (PST)
Received: from erikchen-macbookpro.roam.corp.google.com ([2620:0:1000:2104:407f:1cf7:d833:4184])
        by smtp.gmail.com with ESMTPSA id 186sm26712503pfe.141.2019.11.19.13.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 13:47:27 -0800 (PST)
Subject: Re: [PATCH v3 1/1] fetch: add trace2 instrumentation
To:     Junio C Hamano <gitster@pobox.com>,
        Erik Chen via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.451.v2.git.1573066300.gitgitgadget@gmail.com>
 <pull.451.v3.git.1573069152.gitgitgadget@gmail.com>
 <364c526a5d674e3f137578b24143678256601d08.1573069152.git.gitgitgadget@gmail.com>
 <xmqq5zjws12y.fsf@gitster-ct.c.googlers.com>
From:   Erik Chen <erikchen@chromium.org>
Message-ID: <383762c9-06eb-707c-c0d8-c8ec8757133e@chromium.org>
Date:   Tue, 19 Nov 2019 13:47:26 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <xmqq5zjws12y.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Importing response from 
https://github.com/gitgitgadget/git/pull/451#issuecomment-555044068

> 
>          /*
>           * We write our multi-line comments like this, with the
>           * slash-asterisk at the beginning and the asterisk-slash
>           * at the end on its own line.  Learn such local conventions
>           * from the existing surrounding code and imitate, which
>           * would reduce stylistic errors.
>           */
> 
> Will fix-up while queuing (no need to reroll only to fix this).

Sorry about that. I was copying from line 682, which looks like it was 
also using the wrong style. I've fixed that line as well.

> So this introduces a single region around the entire function body
> of mark_complete_and_common_ref(), within which only one subpart is
> also enclosed in a nested region.  Is that because the parts inside
> the outer region before and after the inner region are known to
> consume negligible time?  IOW I would understand
Good point. I used this structure because I observed locally that the 
middle block was slow, but was concerned that the initial/ending block 
might be slow as well. I've gone ahead and adding tracing regions for 
each block.

