Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023CFC433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 15:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiJDPOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 11:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJDPN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 11:13:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A65F5C97A
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 08:13:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u10so21696879wrq.2
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date;
        bh=EWLlClUm745Ep3hhURx71/CQcS8Vw3HBumS1DvAxuJU=;
        b=HIEutTDEQVZVr3I6rktBcycaNCEPqyPj7l5udvV/fgYzNFewTM/d73l/YE0yPQ8bPN
         hdwwHJK12pP0J3+ts2cL2A+GU9YsFoPkV//ZD7VDXB5jP9Pr12C3jS07Sd5SOi9X2XC0
         QnWg5B0M2tsdx2YqFNm9vW9JN+nJYtpLSRH6kkS/2VcVsDKuYg6pX12CwAOESUv3Xjri
         OWNG3jQQ172ZrcxCfpux50WdcMGFTTyynFhHGw2ztu7MrQyf5m5TjcVHNgJa5dIJ1T9/
         El7ogqS6BIDvwJK4PKHozRAVJs/JRcwJL7OqRyMfJ4v0SWW9MCZe+L7QBqFTHcDnxNFo
         qODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date;
        bh=EWLlClUm745Ep3hhURx71/CQcS8Vw3HBumS1DvAxuJU=;
        b=Vii7Fq4b0XeYvz/HtcRg6Hsyqo1DwNY7ZFFZral5lnzoL0LXcVthpcozfI1JPVYtcE
         LVMOVlUQMbUyNTdlMUReC/umcRq+FyWT+cMnLXoaGCTyw+7/BKl60noHeio0GX2JcnEf
         Wt5+KEWxlWHLqxvRMoJcEH9HH8Hi3W8oqchAIqZ7YWGggMlHMdvfz6rqM/4ND8jGpHxT
         a7es9xToFWwIPBJI+nEd6r48JBrku+qlhRK2HiNA2Oj7lbpEzlmZ1m6xNQehTQjfN2IV
         qzusVXUEGCJLm1xNpyGP9iPR9XjrMM4fepzGP9MxqbmqlChbBhSthdPFwZukmJF5S+nH
         IorA==
X-Gm-Message-State: ACrzQf1kZxuJN8XmZqA39CMt6G1rwtWd+9IucvZQSJxICmy0hckaubjk
        Ppmv4UNGDHLy1eYYIjPGQRw=
X-Google-Smtp-Source: AMsMyM4f884DeDsyANl8J6nyPwGNYxEVY3s9msibAX/bHxGMXBXbzmA/yQKg/wLiYoPZCR4JE/evcw==
X-Received: by 2002:a5d:668a:0:b0:22e:470:174e with SMTP id l10-20020a5d668a000000b0022e0470174emr12196649wru.131.1664896436089;
        Tue, 04 Oct 2022 08:13:56 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003b47b80cec3sm21450965wmq.42.2022.10.04.08.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 08:13:55 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <25ec850e-8677-8011-912e-315efb93db4f@dunelm.org.uk>
Date:   Tue, 4 Oct 2022 16:13:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Using git-update-index to add existing tree objects at other
 paths
Content-Language: en-US
To:     Sean Allred <allred.sean@gmail.com>, git <git@vger.kernel.org>
References: <87o7ur1wi9.fsf@gmail.com>
In-Reply-To: <87o7ur1wi9.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sean

On 04/10/2022 14:44, Sean Allred wrote:
> Hi all,
> [...]
>> USING --INDEX-INFO
>> ------------------
>>
>> `--index-info` is a more powerful mechanism that lets you feed
>> multiple entry definitions from the standard input, and designed
>> specifically for scripts.  It can take inputs of three formats:
>>
>>      . mode SP type SP sha1          TAB path
>> +
>> This format is to stuff `git ls-tree` output into the index.
> 
> but the following does not work:
> 
>      $ cat | git update-index --index-info
>      040000 tree TREEID1	PATH1
> 
> (using the appropriate delimiters, of course). This command succeeds,
> but checking git-status (and confirming with other tools like `git
> ls-files -s`) reveal that this invocation did not have the desired
> effect:
> 
>> (mode) (oid) (stage)	(path)
>> (...)
>> 100755 (oid1) 0       PATH1FILENAME
>> 100755 (oid2) 0       PATH1FILENAME
>> 100755 (oid3) 0       PATH1FILENAME
> 
> with `PATH1` simply prepended to each file in TREEID1. In contrast, the
> desired state is
> 
>> 100755 (oid1) 0       PATH1/FILENAME
>> 100755 (oid2) 0       PATH1/FILENAME
>> 100755 (oid3) 0       PATH1/FILENAME
> 
> I also tried appending a / at the end of PATH1 (this isn't ls-tree
> output, but it's 'reasonable'), but git-update-index simply ignores the
> line with the message
> 
>> Ignoring path PATH1/
> 
> Is there a better, recommended way to do this? Given the language in
> git-update-index.txt, is this a bug / functionality gap in update-index?
> The documentation reads as if I could
>
>      $ git ls-tree <args> | git update-index --index-info

I agree update-index sounds like the right tool for what you want to do 
and this sounds like a bug but I'm not that familiar with update-index. 
As a workaround you could try

	git ls-tree -r arg | sed s:	:	new/prefix/: | git update-index --index-info

Best Wishes

Phillip
