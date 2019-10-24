Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C6821F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 10:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393266AbfJXKSM (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 06:18:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38818 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392678AbfJXKSL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 06:18:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so2012772wmi.3
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 03:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EqZXOVW3eGBnyA36588XhA4eOmszagB3AWaLKL76ycw=;
        b=EYlsyT7PiU3tchDCsYG0DTkIWnjganUIw8DGfWe6Vfjyg0ozaY+TpWAMznksappyIm
         2gfHVXntnP59q9FW5izSg6ZiAfkCbD/JiO5yehhwztvlRFRIr28BF63f4p/u7nYN0+ot
         APyVgvtZ2sKEQ3weLsf7kztqn5hPYCqR9v9R4YPrXR7iRKFHD681LSr3Spu972ruhw+c
         4gjGnm0vVYO5nI7ZVT6HsJlqNPKV5bFYIcnrLJud6dgv+Lq1kVQPYlAotGimBFc0/dJu
         bW2CEx5mbhS2h+LW/MDHnU8Lls5Sq/fU7OcCgVM/8G1lGkl6+ODFG1Cltl/4BT5NWweP
         sOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EqZXOVW3eGBnyA36588XhA4eOmszagB3AWaLKL76ycw=;
        b=U0mBkvGHfRJ7qCTZFqJd0g0Io2bHveOBWdZ5YyswOM6fnih/Zw+72KXsZFfuR1DOkF
         gNv2jj9itbMFFIglP9ll1lpQ9ulrlbhcZMjHelZcFom2OSQWc0UTb+zyl9CaV4BCBUAj
         23ttRNlHjOW3cBarIwueOew8lLKJ6RIUAALEndXOmMAM3DE4B2zq+VVVqGlLOaM7nzDZ
         YViKjtQU2mX0LbhujnGSW5cyaKm3u8eoTeWDtvbtNKx5eiBn11yrjb5WWynDqVMx3z3W
         +En66k7jh2CM2cdRTf40Nea2gOtv8oZ2z00NDMBm7VJSWmMyTnFMWpd3k/gOzw+VwCzF
         RmhQ==
X-Gm-Message-State: APjAAAXzgbZw1xFAfJXcigB6LO3jvWDVN3Y6dzvdVIUVH9DHvhgxka1T
        +2elExs6WVrItoCrh0YddF0=
X-Google-Smtp-Source: APXvYqzOAMxA5PgBLibUCM7a2q/SfuQT5HlVnPbcTZupqwQadmrQMuNeEGEUPiOVKXBKPfC+pAZ9yw==
X-Received: by 2002:a1c:ed04:: with SMTP id l4mr4374692wmh.116.1571912284309;
        Thu, 24 Oct 2019 03:18:04 -0700 (PDT)
Received: from [192.168.2.201] (host-92-22-20-250.as13285.net. [92.22.20.250])
        by smtp.googlemail.com with ESMTPSA id a13sm26437818wrf.73.2019.10.24.03.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 03:18:03 -0700 (PDT)
Subject: Re: [PATCH v5 13/17] read-tree: show progress by default
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        szeder.dev@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <a229e1ee0cb96c5f8c2c5d430641c386bc082a2d.1571666187.git.gitgitgadget@gmail.com>
 <3de0f590-c75c-2470-232f-73a07876df88@gmail.com>
 <857e23df-c447-7297-df74-3546424386d9@gmail.com>
 <xmqqimogi0kq.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <09df07f8-9a1f-9e00-31e8-63cbebd38397@gmail.com>
Date:   Thu, 24 Oct 2019 11:18:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqimogi0kq.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/10/2019 04:48, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>> I'm slightly wary of changing the output of plumbing commands
>>> like this. If a script wants progress output it can already get
>>> it by passing --verbose. With this change a script that does not
>>> want that output now has to pass --no-verbose.
>>
>> If a script is calling this, then won't stderr not be a terminal window, and
>> isatty(2) return 0?
> 
> Unless the script tries to capture the error output and react
> differently depending on the error message from the plumbing (which
> is not localized), iow most of the time, standard error stream is
> left unredirected and likely to be connected to the terminal if the
> script is driven from a terminal command line.
> 
>> Or, if the script is run with stderr passing through to
>> a terminal, then the user would see progress while running the script, which
>> seems like a side-effect but not one that will cause a broken script.
> 
> It will show unwanted output to the end users, no?  That is the
> complaint about having to pass --no-verbose, if I understand
> correctly, if the script does not want to show the progress output.

Yes that was my objection.

Best Wishes

Phillip


