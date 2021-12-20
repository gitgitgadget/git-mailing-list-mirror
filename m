Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68912C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 14:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238535AbhLTOyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 09:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbhLTOwU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 09:52:20 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4308BC08EAFC
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 06:47:00 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id l8so9928602qtk.6
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 06:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r0hDO+31DvT6qijZ5QadXF6lFfrhKbLP10Yc7a3RmNA=;
        b=aSdFnWpm30ZaqJMgXBgZXsOs5Zl224QIMDR52RYWxLp1ihuCUQQeFGmR2ZETM0upav
         RH0aX5SmhNBIUP4jC7Yz/p5z0ljScysZSUk9qMkmB8axNHQfaGjd1SrX0rlUSrG295sm
         k6Vzrv+t0w3JKYx6Zj79n/dEr4EacGhVRPXJIKWlLK8WoHNf6LzwluLZZAVwcBDcunSE
         6PMM3hyR6a9zCx/jlnBvE3S0yxstBJYGo30xnKQ/0KIA3xf4nE3VuXz/X2Lx0STOsFYE
         vIcyEHZGvQfrQTeSzfc/UzrN5TxzHOvfqRtUjUjlPIf5aVfrgqEfz+oesX93RPBM0JS2
         h7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r0hDO+31DvT6qijZ5QadXF6lFfrhKbLP10Yc7a3RmNA=;
        b=cMamu+1aHaHGNR8j4BchHWSxNntTzt8e/qXePkfgLeYt2Yg05bziWIzFUHzqTrMzZN
         tL8l5DzEddm1Th6GNfH56/whAiqRk4DPOEim6m+pp4rSCs0+osuYUqSPTVAepXlh28mK
         g7YGuJhvmdHH4Jh0dYd7rUCaBnh+wTSxa6ra6MxQ9HIFcOxj48KU0WP57TiVAvCFB61d
         lhVcx/ugXiFwCZH/ZsV1V6BZxSceYibm5RNf+gwcQkDwVlk9KOtFke26hLYZEMUOicfa
         GNmY7rXJgxdqTjR9u4C4ASwXjAwiFAy8T+Rofh2aZxrgLVl4pcEH9ZxVqRT5C4T2D5VQ
         Bs4w==
X-Gm-Message-State: AOAM5331cJXP2lqr+3yNpTroQQ3DDQ88G218lornmG6j6sw8ELap4Nw8
        4PBl2QQqtvlKbY1Z7SKcVvg=
X-Google-Smtp-Source: ABdhPJygjA11kOWtk/65jokEC9CVj0+vc1DWya4YYdBeMbrJqwIbeshf7BA4aHNDAhAitD5F5lbOrw==
X-Received: by 2002:ac8:7f8b:: with SMTP id z11mr7341109qtj.513.1640011619281;
        Mon, 20 Dec 2021 06:46:59 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1dd9:8fb3:37da:4055? ([2600:1700:e72:80a0:1dd9:8fb3:37da:4055])
        by smtp.gmail.com with ESMTPSA id w9sm11610671qko.71.2021.12.20.06.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 06:46:58 -0800 (PST)
Message-ID: <6f449f30-abb2-8b11-1669-abb03b73f7d0@gmail.com>
Date:   Mon, 20 Dec 2021 09:46:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] repack: make '--quiet' disable progress
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1098.git.1639758526.gitgitgadget@gmail.com>
 <3eff83d9ae14023f3527dfeb419cf8259f6d053d.1639758526.git.gitgitgadget@gmail.com>
 <YbzSfwQixuonrK/o@coredump.intra.peff.net>
 <7969c9e5-dd57-705c-b554-67681b9af62f@gmail.com>
 <YcCJ0bU1y4TnS3yp@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YcCJ0bU1y4TnS3yp@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/20/2021 8:49 AM, Jeff King wrote:
> On Mon, Dec 20, 2021 at 08:37:52AM -0500, Derrick Stolee wrote:
> 
>>> +test_expect_success TTY '--quiet disables progress' '
>>> +	test_terminal env GIT_PROGRESS_DELAY=0 \
>>> +		git -C midx repack -ad --quiet --write-midx 2>stderr &&
>>> +	test_must_be_empty stderr
>>> +'
>>> +
>>>  test_done
>>
>> Thanks. I added this test.
>>
>> When first running the test, it failed because I didn't have the
>> IO::Pty Perl module installed. I'm not sure why I don't fail with
>> other tests that use test_terminal. If someone knows more about
>> what is going on, then maybe we need to expand the TTY prereq?
> 
> Weird. I uninstalled IO::Pty, and get:
> 
>   checking prerequisite: TTY
>   
>   [...prereq code...]
> 
>   
>   + perl /home/peff/compile/git/t/test-terminal.perl sh -c test -t 1 && test -t 2
>   + command /usr/bin/perl /home/peff/compile/git/t/test-terminal.perl sh -c test -t 1 && test -t 2
>   Can't locate IO/Pty.pm in @INC (you may need to install the IO::Pty module) (@INC contains: [...etc...]
>   BEGIN failed--compilation aborted at /home/peff/compile/git/t/test-terminal.perl line 5.
>   prerequisite TTY not satisfied
>   ok 25 # skip --quiet disables progress (missing TTY)
> 
> What does running with "-x -i" say for the prereq?

Ok, I got this same error and misread it as an error. The prereq
is working just fine. Thanks for checking.

-Stolee
