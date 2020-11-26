Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE809C63777
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 11:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805722173E
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 11:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCkE3RZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388945AbgKZLVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbgKZLVt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 06:21:49 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F98EC0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 03:21:49 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id v11so850115qtq.12
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 03:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kalKIP9CMUNAEp2+5Qy+nJ9wsVTzs7RH3Pr6wrQGbhQ=;
        b=uCkE3RZDvz87eQY7wXOR8+Amc4e+6Qo4beqVgMeZLeOeY+dkIEGEPUum2ZdavwGPKm
         HiW8ue6+GkV6ZYdIGjyXeWR5LlQKHXndtV80Ehkx4Ce5hyOQLDXxAjJTNYwMGjh563Gj
         1PahVmXuR0jAMbU8JHuma1i8Kmdk08puNq0m6iKxieATKlvXLG88yAAnZsjKJZE0tBwR
         4kkwmf46DlC2u7XXb8Ckr8vj07pZBTdd+c1TkwuCvtX3VYUVguyGUv1Lu8zlg4LeKUoc
         wXlMZra1MsNxQdwUMJSAgYQGpUGD/kO9Agxc/mhH72hFs/gNBgmFO5SFQJEUGRRKSkSJ
         BWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kalKIP9CMUNAEp2+5Qy+nJ9wsVTzs7RH3Pr6wrQGbhQ=;
        b=k1mkr18BpPKbJ33YReS2A0PY4yXS7spt5HBgLWS4GZt59NidwTYmkiuXESZuOixBbv
         5A6lKcaRhZoEqbwh4Yrw47IDJDTWWDJYRmhto8XIwFQ/Jt/SyX5fUFqeSy2MyPk/4cdI
         xOv9xz9SQsWFRXsaBAeBATk7SdWKgNy0VRAaZ5kVGaOMpukqRawHNovStYfHu0HmTHOx
         a1zlsQ1BT2UpthzV8JYW5qwMcYY0oymByy3NFmLpK6DAQvxoHFkj5cJ5RrrcdxeZ+VUk
         RS1c8Didzdvf2yAE88KntlaMqmJ4YimFqUHdDrqiK9Tp85b4zaDqKV8zfid4zrdRlH/E
         k0Lg==
X-Gm-Message-State: AOAM531ZZ0/D573ChlxqlV3bxi/KUuAuQtt+0BI3OVNBQct6CC86OH1L
        32TR80CG1cM379V2Yh2elhw=
X-Google-Smtp-Source: ABdhPJzHDV7bMVcfQJYCeHDS7Ppxd7BJ6gaIHG9Gu9fY1cFLpjO2b03ob60cNSSfUqB3SPZg4s2AmA==
X-Received: by 2002:aed:38c8:: with SMTP id k66mr2442882qte.385.1606389708119;
        Thu, 26 Nov 2020 03:21:48 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id a7sm2272355qth.41.2020.11.26.03.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 03:21:47 -0800 (PST)
Subject: Re: [PATCH 1/1] maintenance: fix a SEGFAULT when no repository
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
 <20201124164405.29327-2-rafaeloliveira.cs@gmail.com>
 <1bfd84da-5b74-be10-fc2c-dee80111ee2d@gmail.com>
 <20201126082255.yyxx2kpskj3td5og@contrib-buster.localdomain>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <54fa678c-7150-8c48-50e5-b33923a69249@gmail.com>
Date:   Thu, 26 Nov 2020 06:21:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201126082255.yyxx2kpskj3td5og@contrib-buster.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/26/2020 3:22 AM, Rafael Silva wrote:
> On Tue, Nov 24, 2020 at 12:22:40PM -0500, Derrick Stolee wrote:
>> If the above code change fixes your test (below), then that would
>> probably be a safer change.
> 
> I agree, switching the maintenance command option to use RUN_SETUP
> seems like a nicer approach here. Given the all current operations
> requires the command to be executed inside the a git repository this
> will make the command consistent across the subcommand. 
> 
> Also, it seems this provides an opportunity to cleanup the
> register and unregister subcommands that currently implement the
> check to ensure the commands are running from a git repository.
> 
>>
>> The reason to use RUN_SETUP_GENTLY was probably due to some thought
>> of modifying the background maintenance schedule without being in a
>> Git repository. However, we currently run the [un]register logic
>> inside of the stop|start subcommands, so a GIT_DIR is required there,
>> too.
>>
> 
> Indeed. Aside from this reason, another concern that I have is that
> switching the validation to all subcommands (on this case by switching
> the maintenance command option) will change a bit the behaviour of register
> subcommand. Currently, the behaviour of "register" subcommand is to return
> with 0 without any messages when running outside of repository and switching
> will make the command fail instead.

Excellent point. It would be good to cover this case with a test, to
demonstrate that as _intended_ behavior. It makes sense to fail instead
of "succeed" when doing nothing.

> Nevertheless, I am inclined to go with your suggestion given that it seems
> better approach to support the automatically and make the behaviour
> consistent for all subcommands given that changing the behaviour of
> "git maintenance register" command will (hopefully) be okay.

Yes. I would say that changing that behavior aligns it with what it
should be doing. The best news is that the 'register' subcommand does
not exist in a released version of Git, so no one depends on the
current behavior.

Thanks,
-Stolee

