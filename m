Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B879CA0FE6
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 13:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349764AbjIANd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 09:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjIANd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 09:33:58 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA714E7E
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 06:33:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401bbfc05fcso20204455e9.3
        for <git@vger.kernel.org>; Fri, 01 Sep 2023 06:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693575234; x=1694180034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yPrzn0PlP6ezZN9D48s3kwxs8g5xm2ouF2ieOkEWq14=;
        b=doCRa+6uHroD8gzdkYXgS96ExgbdrfMEn2kxSa8apgKXhpAiAj+dlEvXqOXRm3gtrX
         woOqqGCCLG1hXCM6r9/gwq1ZEaGMxYFqgv6jYfrLPRRnCzyuFbeLFRi5OWUM5jRhW5T0
         uYX/+xl5HdTxTWEvafV5VwBl4Vfp3zlCEk3aRUQAaQLDmtUShaghBzqNiCg0EMgYgF/9
         UOGDPF5KrZwAX33hkc6gaVubRfTfky86Hx5OBP6tA/6KRdHcifg9zp+rRvwVZgLTeaH6
         1tcDjwN9l3DgHNF7SyMCEFrFk97TNBBrD41tqnOPMfTzc1ySmMxD2VOa5dnalm0HbGmP
         jdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693575234; x=1694180034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPrzn0PlP6ezZN9D48s3kwxs8g5xm2ouF2ieOkEWq14=;
        b=fTf1hzm4foE/sXiKpPSdmdZEErEWWRBA6zl6QlpH7RN6P0cIuPAY/siHZRGhjDwMI4
         PvB1E/OcYP3X3s4XvFsqNWb5mHiR5UI1f5V4G+IBG1/ezambN5iRq+HnQxlPCK7CJEG+
         1ERUcDJFUPyoicQX+3PAj6X7jFYGCXLcQoe9Yf08TZ7mM5wGzXI8UYu7lniut+VlTNTr
         2pyFCL+sYfbf+4wLPpqTfNgb1zvyD1AxD8bipZ5W8EioVT+QJP/CZv8jTWt16Qr0wcOH
         4n9if6I21wMZUmgq51jv85ybFib90Cs3hQekKZXOzQC5cIsYOTU5l+2+Pi4/RVAb1/fn
         z8Qw==
X-Gm-Message-State: AOJu0YxIYRzVnzIf4edh8Mo6hl2428QIUoahsV4Ie9QrgQ3c1BEnNJev
        lNqbR3f5muDXpr0o1xxZsmc=
X-Google-Smtp-Source: AGHT+IHbK4Lfj+ouRxz+mj6U0JZ1ZKmujS/ljjKllkd69dkAltykaiMng+TqH/0aChm8zb5s8o4TeQ==
X-Received: by 2002:a7b:c411:0:b0:3fe:f45:772d with SMTP id k17-20020a7bc411000000b003fe0f45772dmr1858765wmi.28.1693575233793;
        Fri, 01 Sep 2023 06:33:53 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id p9-20020a1c7409000000b003fee53feab5sm4960739wmc.10.2023.09.01.06.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 06:33:53 -0700 (PDT)
Message-ID: <4ee8802b-0b54-4ed3-8ead-61e7d7628bce@gmail.com>
Date:   Fri, 1 Sep 2023 14:33:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] builtin/rebase.c: Emit warning when rebasing without
 a forkpoint
To:     Junio C Hamano <gitster@pobox.com>,
        Wesley Schwengle <wesleys@opperschaap.net>
Cc:     git@vger.kernel.org
References: <20230819203528.562156-1-wesleys@opperschaap.net>
 <20230819203528.562156-2-wesleys@opperschaap.net>
 <xmqqbkenszfa.fsf@gitster.g> <xmqq1qfiubg5.fsf@gitster.g>
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq1qfiubg5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/08/2023 22:52, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> I am not commenting on the tests, as the above code probably needs
>> to be corrected first so that folks who want to squelch the message
>> and want the "forkpoint behaviour by default when rebuilding on the
>> usual upstream" behaviour can do so by setting the variable to true.
>>
>> And that obviously need to be tested, too.
> 
> Another worrysome thing about rebase.forkpoint is that it will be
> inevitable for folks to start complaining that it does not work the
> way other configuration variables do.  Setting the variable to
> 'true' is not the same as passing '--fork-point=true' from the
> command line.

It does seem strange, it looks like the variable was really added as a 
way to turn off the current default. If we do change the default to 
--no-fork-point when no upstream is given on the commandline then I 
think we should consider allowing "auto" for rebase.forkpoint with the 
some meaning as "true" and recommend that instead.

Best Wishes

Phillip

> I actually think it would be a lot larger behaviour change with a
> huge potential to be received as a regression if we start making the
> variable to mean the same thing as passing '--fork-point=true'.
> People may like the current "if you are rebuilding your branch on
> its usual upstream, pay attention to the rebase and rewind of the
> upstream itself, but if you are giving an explicit upstream from the
> command line, the tool does not second guess you with the fork-point
> heuristics" behaviour and prefer to set it to true.  We would be
> breaking them big time if suddenly the rebase.forkpoint=true they
> set previously starts triggering the fork-point heuristics when they
> run "git rebase upstream".  So that needs to be kept in mind when/if
> we fix the "setting the variable, even to 'true', will squelch the
> warning".
> 

