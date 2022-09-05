Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D74ECAAD3
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 13:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238297AbiIENvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 09:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbiIENvI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 09:51:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218A858B69
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 06:51:03 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k9so11514877wri.0
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Mi7DGozDB/BCfbl4lfk6Zz/ebRa8IDPcV4h+vZxNX8Y=;
        b=otXQfuJk7B5OzD4JFCafxzNWv17lzHGggOMp4gBdh2Gfztxtw3CHJOcucgvtM2l9zb
         GciXJv1Qa7ZbsLQsdd9OhIcmP2njgrdwSVYYtYKnL3jjxuuhKfR9QiW1dWcoOGIdkkYv
         WxrrOCQUec3hkAaYxEp7uZnEvKiOa4n+M1TxTcGkZlDIMHKSpIM7YRT0Nhot0+lpX0/t
         PGn7dx5eb/dyduYZxcLAdRiOFpzy2YBN6hLJMpR3DUSzSE1w4PgnAI78V5QpDMg+neXk
         q4Tf1gAfIgCNbC+j6uEoMXs5A1XLsCgH5l9M0uUKW/u4+DbLCSTlXODyJBe0tkrhAO8p
         kpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Mi7DGozDB/BCfbl4lfk6Zz/ebRa8IDPcV4h+vZxNX8Y=;
        b=zzvrE1QKpcTTCudhHulXjpdF632jNeL//SXutPMA5GSoQbqtrfWPhu0VIJgTDuCifG
         axtpA7P3kKbgDeiLLbOdw4Z21CMDp0d8TL7Vro9WcoBZ2mpikPuVnzgnt3/OCOcQLT71
         vR7ohZrNPtQ/x3vhqSqeuACHvplP7UamGSjqNPibMIwhN5ae4pJyZ1gIXD0XKsoUV9Ac
         8FIK7wwCzmuMvltgDDiG8g4KHvDERQHMLUpVf6m4YQet6GSiVAfcP7ZWcL5JuBfSdLeD
         pfskJaxCmQ9/ZjBpmMP/agCkjCDODGsZ7eopQwaw4UmX1fli8V/5Vr8icL8+vhcKwuiC
         SU+g==
X-Gm-Message-State: ACgBeo2ChNlugpC4w2SqfMHt1tMRXUU9QJ+RPRG+nE7qXDOjsp0DH7DF
        CK0rDS4aTe1ImYt603B6JlE=
X-Google-Smtp-Source: AA6agR5P83bLCtUMEdCBhCkZDlwttOgc47ac1IsTEqJfO9rD+3qBONsVZN4VfwtYbtnsD4h+cO4jJQ==
X-Received: by 2002:a5d:62cc:0:b0:228:afe3:9fce with SMTP id o12-20020a5d62cc000000b00228afe39fcemr1799629wrv.618.1662385861850;
        Mon, 05 Sep 2022 06:51:01 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d5012000000b00226dedf1ab7sm3764283wrt.76.2022.09.05.06.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 06:51:01 -0700 (PDT)
Message-ID: <0a997c9d-d601-637b-9389-9dfd300083cd@gmail.com>
Date:   Mon, 5 Sep 2022 14:51:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 5/5] rebase --keep-base: imply --no-fork-point
Reply-To: phillip.wood@dunelm.org.uk
To:     Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20220824221851.1684475-1-jonathantanmy@google.com>
Content-Language: en-US
In-Reply-To: <20220824221851.1684475-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan

On 24/08/2022 23:18, Jonathan Tan wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> @@ -1240,6 +1240,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>   			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--onto");
>>   		if (options.root)
>>   			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--root");
>> +		/*
>> +		 * --keep-base ignores config.forkPoint as it is confusing if
>> +		 * the branch base changes when using this option.
>> +		 */
>> +		if (options.fork_point < 0)
>> +			options.fork_point = 0;
> 
> Hmm..doesn't forkPoint decide the set of commits to be rebased, not the
> point at which the new commits are created? If yes, that doesn't seem to
> have much to do with --keep-base.

I think it depends a bit on how you look at it. You're right that 
--fork-point restricts the set of commits that are rebased, but it also 
effectively changes the branch base as it removes commits from the branch.

Best Wishes

Phillip
