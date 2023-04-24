Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60332C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 15:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjDXPT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 11:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjDXPTu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 11:19:50 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FDB2D53
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 08:19:49 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b95c3b869dcso15193580276.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 08:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682349589; x=1684941589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EKahkNOuBM+uhOCHizQXRNmPLWVaMaOYJnQT2jfxTv0=;
        b=djwnci3GjmirPItoxes6Vptjje1AxqDd/SsQeFk2Sl7bycnwk+7gWj5JFj+L0Wh5jq
         Zq3AVxKspYQ73wR9kO0pvMeB6v1I6y/WVsSNzb8YLLUXMGq1xgBj1TJwDM507a4QnBW/
         PKXQSRwLF9Or9rDEuQnRUk8AV9T9Gjwy6oBelJ3vtggG2SURKALyxIZO+Q5Sk/5itJ0o
         sQHdrAFS9H9c0zMSv5wMeJfDFEG9AbYBLlRnnTf++NL7dArU9u+L4nmMGEuMk8bpeQ29
         SzpEYyROOKgySDL8KYtDfKWj1FlgUYbSGUR/oekLPMsdbHUUpTyZgxlNvRs4CZ1F33wQ
         Wc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682349589; x=1684941589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EKahkNOuBM+uhOCHizQXRNmPLWVaMaOYJnQT2jfxTv0=;
        b=A1TVgUcATsJOvRoBGrjGGgLpZOZN0sCCCTld0OnuydeCKudUuKmekARqlGlyW/4vxT
         O4gZRQwV/aoAZs5+FmCJz574g/te5aEszX+xFiLj69ZFBiljIthzCvEHKs40il2vjjWA
         h+8vuQFGzfg8EdtJB0tlICZkIoO7qeisiFlYmjheR2Tlp85pOqWLNIEk2N45JZKZ7KIH
         l6u4Y20mzNWlkcgL/g4f7GU85QehuOwEcGbuEwJjqPWRGvn3JKY0PZoFMkG7pvzyG6u+
         y+oxyTFXibP1aPdvYluMdCw77nErwyBsGclAX2nwatA8V8PybHHhQf1aTWgyVL+W2zsS
         t3qQ==
X-Gm-Message-State: AAQBX9cA9rzfukik6798lzOXSzwh4sh2+LrsdO4dxrC1pfB1HfxtVZbP
        /kjuZIz4aCgdNCykwOl3M3ut
X-Google-Smtp-Source: AKy350a+K/PGGWAfLGQZy0SrTXyV4ARA6wWrgCzsTkc/Nw6eAOwEvlp6YyhR9/uSB6hKW4BAKwe57A==
X-Received: by 2002:a81:bcd:0:b0:54f:b573:bff5 with SMTP id 196-20020a810bcd000000b0054fb573bff5mr8439382ywl.22.1682349589048;
        Mon, 24 Apr 2023 08:19:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:4c:5bca:4632:1d72? ([2600:1700:e72:80a0:4c:5bca:4632:1d72])
        by smtp.gmail.com with ESMTPSA id i66-20020a0df845000000b0054601bc6ce2sm3003999ywf.118.2023.04.24.08.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 08:19:48 -0700 (PDT)
Message-ID: <1393c57f-9f3f-18da-8f02-badfdc62f02d@github.com>
Date:   Mon, 24 Apr 2023 11:19:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 00/22] Header cleanups (more splitting of cache.h and
 simplifying a few other deps)
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/22/2023 4:17 PM, Elijah Newren via GitGitGadget wrote:
> Changes since v1:
> 
>  * dropped the 3rd patch (it was pulled into the series this one depends
>    upon to fix an issue in it)
>  * redid the old patch 14 (new patch 13); moved the parts of hash.h not
>    depending on repository.h into hash-ll.h so that other headers and files
>    could depend upon just that part. (Are people happy with the hash-ll.h
>    name or have alternate suggestions?)

Thank you for this change. I looked at patch 13 and was pleased to see
several uses of hash-ll.h (more than I expected). I'm also happy with the
name.

v2 LGTM.

Thanks,
-Stolee
