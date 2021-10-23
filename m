Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CCEC433F5
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 03:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BAD26101C
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 03:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhJWEAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 00:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhJWEAf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 00:00:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDEEC061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 20:58:16 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gn3so4270594pjb.0
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 20:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=MqNJ3LShFjmPTcXNRm5Ot5uvuGf8U0Ump5bulS7RLQI=;
        b=hBXG4+RKO6JoMYUHLkrW0rAZ6yxwzDIGkrBG9DVVwGGOUJLzYpjMIS7V5Iv4uvuBSa
         l56B1vfHcJdCPDlgvIz0Hs7TM/zZLGq51YWdC2eSmu5nr1IgM6Vj3bwErSRnkPjPHnQs
         nMdUPD0mkqZxc4mpfM7Q1EZhH1LVzgSi3OlZFbVgimJu9GQpTNIz0YY+e9rInjakLIex
         i5FmtYBVonIjOYpHf7SyLTLxk+TV3gJ29DvS2bL7xAfCZU5i1h3/nP4gmqovF6Sl61TN
         13ak1zZ9WMssBVkYBgN0sl3B96QmA3xFEZ1mmpV4pdt/OL07RfYXwz0R270SiqVDXHz/
         g/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MqNJ3LShFjmPTcXNRm5Ot5uvuGf8U0Ump5bulS7RLQI=;
        b=qvInN8SMEIJ89kr1k94yr1kryzvK41uyvjXMJRtsENq5kScsMoOhzXYhdVBxa5RCdc
         FPDimBi+PGH+K0qiTFy5jWY5nMB1EpFtRvDvfxuNbJmBhw29N+f3GdpMAVC3xxTFaVlM
         nq+ywm7cKiKIoHYb7BNu9derl9dDOkVJ01ZuNWe5TAV5ar8ir2NzYkW2oul0PjRuoBxm
         qabTgJPCaQAl+ekRSZAE9P4dTYc+vcBZZJgkmKibg922ITRpWGtuEVNj0tLE9peaPU2m
         3FpFNcJtun4tIgxwcMo4EmLS5cZYxEuFj7NckCYNt0tSKj5vIRau3+nVmDJXDhsgQERs
         OFmQ==
X-Gm-Message-State: AOAM533Nvx6booeoJ9qpLUC3JQ52tc62TEGV+7MXoeHbwViZX64bPpxy
        IJlmuR/YY198zEH9eD+3lQc=
X-Google-Smtp-Source: ABdhPJyzoa5ZAtLLPWSPfM5JjisEFYdt3EbX+HXT1P2YX8qDxrDH5WAThqkxdBRV0oGrgETJXvTAHQ==
X-Received: by 2002:a17:90a:9291:: with SMTP id n17mr4373472pjo.243.1634961496005;
        Fri, 22 Oct 2021 20:58:16 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-89.three.co.id. [180.214.232.89])
        by smtp.gmail.com with ESMTPSA id f84sm10853995pfa.25.2021.10.22.20.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 20:58:15 -0700 (PDT)
Message-ID: <b802e803-520d-49f5-a845-8e3c94f1c0ee@gmail.com>
Date:   Sat, 23 Oct 2021 10:58:11 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Error in 'git clone' via SSH in v2.33.0 (related to commit
 ae1a7ee)
Content-Language: en-US
To:     Philipp Eib <philipp.w.eib@gmail.com>, git@vger.kernel.org
References: <CAN2Gq0de1tpiLNcQqoZmgAu=kuOXxEmAtziWM7OJtGPGhLneYQ@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAN2Gq0de1tpiLNcQqoZmgAu=kuOXxEmAtziWM7OJtGPGhLneYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/10/21 21.26, Philipp Eib wrote:
> Hi,
> 
> Using git-for-windows, I noticed that an SSH git clone of an internal
> repo broke for me in git v2.33.0
> The exact error is:
> 
> fetch-pack: unexpected disconnect while reading sideband packet/s
> fatal: early EOF
> fatal: fetch-pack: invalid index-pack
> 
> Cloning via HTTPS continued to work.
> It was also repository-specific as cloning other repositories from the
> same (Gitlab) instance via SSH was working fine.
> 
> Together with the maintainer we traced the problem back to git commit
> ae1a7ee (https://github.com/git/git/commit/ae1a7eefffe60425e6bf6a2065e042ae051cfb6c).
> Reverting this commit and rebuilding fixed the issue within git-for-windows.
> (You can read the full conversation here:
> https://github.com/git-for-windows/git/issues/3444)
> 
> Unfortunately I cannot give a reproducible example as the internal
> repository cannot be shared.
> I have also not tested on linux.
> 
> Regards,
> Philipp
> 

I've tried to reproduce this issue on Ubuntu 20.04, using the same Git 
version. I cloned from a Git server hosted on my own computer under LXD, 
and the operation worked as expected.

Try adding GIT_TRACE_PACKET=true when attempting to clone the 
problematic repo.

-- 
An old man doll... just what I always wanted! - Clara
