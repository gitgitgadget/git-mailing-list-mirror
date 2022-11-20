Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2151C433FE
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 01:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiKTBsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 20:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKTBs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 20:48:29 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7502227B3A
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 17:48:28 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 136so8252867pga.1
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 17:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N9pu4vStq8HeIp/BBPp8YIGlCweYzOoImUPMXOpLdw0=;
        b=m/gwtS2kmoj6fXHWMJysLfXDUE8TORJi0ZAcN9IG9+aqh3sKpNfwREzTI1iKWAUNxJ
         YbZywwoLZ+QN/vs2/nbWPp+1MgP3zNhC85HLCLih/M2uiKcHggWaA+kPHr80SOsB5+jP
         QZ6Lqek46ncDzlEnMPF3E8PbTizOFJ2EAxDVmhLBoXlI47TX8c2nGz0SrTrajxigOvao
         iJBrT4XA8oSQCXVlkv9jcbTiw7o2eB92QrmdnUKMzABWjZcKt4RScbRytrHynH5quFZ2
         mHuMh5fbfk3ZHZDg3fb8wyfc8i3EBvf32yKmT65HPpZQuZl6VDqsHlgSYs0hEZMkeXSp
         uEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N9pu4vStq8HeIp/BBPp8YIGlCweYzOoImUPMXOpLdw0=;
        b=MvW03wn7bhRyZsfk8h+2thGb0BouiubFLSD3H3L350Ayyno0gc/scnt1W8F/7dhu3l
         qWkJkLadg7WyNGXlouzj1FZTrFpbBVvOxUHOYkO6ZADXs9IM2zKhga97TGZF2ldah1FY
         BiGajphjmuUcGZwWqRXpEaa6YLf075R7z4zxP2EycPPrAzQAfg9XYsRZLll+WlSxHWzO
         rU76N0DSz3oJengRPs1lrjitUQ6/05JdF8qf93TrTctVNhdeE9dLGmksclb5yW07SYbc
         HoTIkdTxhqxFy/0alOO0zqfcrzwdDVbTrG2U1LFClzZ2wBghBrOPsTkTvCtBIkuw7y3M
         M5Jw==
X-Gm-Message-State: ANoB5pmZKpJDkpYEVaM1OL7dSPcKjZz5X5VlqEZSaiN7fYCw/af+oWk3
        LLkclyCIu56lUw0JDvMA2Wc=
X-Google-Smtp-Source: AA0mqf4UEEuosTrSfId1jc7ZfiXYXhQ646/bKbrjhSrF0I73nPGbvIUYgRS0kzixrj68qbo6pA7N6A==
X-Received: by 2002:a63:5920:0:b0:43f:88cc:473 with SMTP id n32-20020a635920000000b0043f88cc0473mr12743211pgb.491.1668908907947;
        Sat, 19 Nov 2022 17:48:27 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-87.three.co.id. [180.214.232.87])
        by smtp.gmail.com with ESMTPSA id u71-20020a62794a000000b00562019b961asm5738887pfc.188.2022.11.19.17.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Nov 2022 17:48:27 -0800 (PST)
Message-ID: <a3cfe081-1e68-edda-b797-e68356988046@gmail.com>
Date:   Sun, 20 Nov 2022 08:48:25 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] Makefile: suppress macOS deprecation warning
Content-Language: en-US
To:     Stefan Sundin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Stefan Sundin <git@stefansundin.com>
References: <pull.1422.git.1668888407433.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <pull.1422.git.1668888407433.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20/22 03:06, Stefan Sundin via GitGitGadget wrote:
> From: Stefan Sundin <git@stefansundin.com>
> 
> Compiling git on macOS 13 emits the following deprecation warning:
> 
>         CC compat/fsmonitor/fsm-listen-darwin.o
>     compat/fsmonitor/fsm-listen-darwin.c:495:2: warning: 'FSEventStreamScheduleWithRunLoop' is deprecated: first deprecated in macOS 13.0 - Use FSEventStreamSetDispatchQueue instead. [-Wdeprecated-declarations]
>             FSEventStreamScheduleWithRunLoop(data->stream, data->rl, kCFRunLoopDefaultMode);
>             ^
>     /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/CoreServices.framework/Frameworks/FSEvents.framework/Headers/FSEvents.h:1138:1: note: 'FSEventStreamScheduleWithRunLoop' has been explicitly marked deprecated here
>     FSEventStreamScheduleWithRunLoop(
>     ^
>     1 warning generated.
> 
> Setting a minimum macOS version will suppress this deprecation warning.
> Using a version lower than 10.13 will cause other warning messages to
> be emitted.
> 

Why don't instead follow the suggestion on the warning message
(FSEventStreamSetDispatchQueue) instead?

-- 
An old man doll... just what I always wanted! - Clara

