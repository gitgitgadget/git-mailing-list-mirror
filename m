Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822EBC4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 15:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiLHPGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 10:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiLHPGj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 10:06:39 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C085B8DBC5
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 07:06:38 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h10so1954026wrx.3
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 07:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uA5E0p1W1wa4CZtEDzBejOqWbWOUe6AyZslzqQJhts0=;
        b=prgACmoheGwqyprqU+LVxeRu+W0Ng0eVqKU24q/JW/68z75xuKUJCSFdS5+hJdcZLK
         LdHkJ0TGAp9Ou7fvngI+8sOggSeD9dlwofOVVC9SDr9apP4YHuLwPh/xcgG2iL43RuQQ
         KZMR2wypCBU8E/sP/NsquJ+99KjFhSPK/I6jHuXO/Dwl6koQlUznSelJJ2Q6xN0e3CcW
         CMQ3LPgJTYO7BeqjvMK77KNQP5FezVqlMcnoUxJLeQccTuUfMT/wGS3R5BwLndWiKUAm
         rDhNROVO20CNAVRO7SQYMBol+LElBxD2igM6DPAYXQjuDPeyzucLcmtCDgOg4m0emPha
         nQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uA5E0p1W1wa4CZtEDzBejOqWbWOUe6AyZslzqQJhts0=;
        b=wg6fvFpaFGjV4AwSgAwFuYBq6WQc0xKC1WUqUKdfSqJy1YNvn5+U0KgnHuEbXePsmE
         eqO6JMr7MMVhjhCKdE2cjTcfbgTPYZQmRwm7n2FsXx4IvXc+1lsFRbODuuoTEFy0INkQ
         rCztj4a0F33uxt7+zyYvdo8J2B6hpvAsXPxUsKDi/EUXFLoARicKwJq1Z3IBLtVtnFMV
         sDKKdYy908NGKtTY2h5XnWNhZ9qyQMmmCJEJ23Q4zpO6FwW11DwCZ8hQkwi/e0JzyqLt
         hFo+mFV5qmZ0YnuapcsGUf1P8EGYj3vyscIgNy3XQ0ZqHe7W1Ix4c8lubP7+lgHJJmHi
         sf3A==
X-Gm-Message-State: ANoB5pkfLPVdVuo3jNzgsB5nrcAahi9n5jhtsEZ2ICVpgoVLxwwyvoCB
        vY1CDoz/onUMrwFjdtMNJvs=
X-Google-Smtp-Source: AA0mqf5odS4lXPCJfdhDnOgh+XQaWomcC86PwOveXkoaE4pb8SQblAusw4lSpUU4+nRSCkPJvO3z2g==
X-Received: by 2002:adf:df0c:0:b0:242:1dba:a62a with SMTP id y12-20020adfdf0c000000b002421dbaa62amr1549346wrl.35.1670511997162;
        Thu, 08 Dec 2022 07:06:37 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id p18-20020adfce12000000b00242271fd2besm22155897wrn.89.2022.12.08.07.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 07:06:36 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <1b5fc712-9659-1bd6-493c-197b003d21d6@dunelm.org.uk>
Date:   Thu, 8 Dec 2022 15:06:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/3] [RFC] tests: add test_todo() to mark known breakages
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
References: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
 <472d05111a38276192e30f454f42aa39df51d604.1665068476.git.gitgitgadget@gmail.com>
 <07d963f0-45f2-ed8e-ea08-bcea14386a4d@github.com>
In-Reply-To: <07d963f0-45f2-ed8e-ea08-bcea14386a4d@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria

On 06/12/2022 22:37, Victoria Dye wrote:
> Phillip Wood via GitGitGadget wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
 >>
>> Failing commands are reported by the test harness in the same way as
>> test_expect_failure() so there is no change in output when migrating
>> from test_expect_failure() to test_todo(). If a command marked with
>> test_todo() succeeds then the test will fail. This is designed to make
>> it easier to see when a command starts succeeding in our CI compared
>> to using test_expect_failure() where it is easy to fix a failing test
>> case and not realize it.
>>
>> test_todo() is built upon test_expect_failure() but accepts commands
>> starting with test_* in addition to git. As our test_* assertions use
>> BUG() to signal usage errors any such error will not be hidden by
>> test_todo().
> 
> Should this be so restrictive? I think 'test_todo' would need to handle any
> arbitrary command (mostly because of custom functions like
> 'ensure_not_expanded' in 't1092') to be an easy-to-use drop-in replacement
> for 'test_expect_failure'.
> 
> I see there's some related discussion in another subthread [1], but I don't
> necessarily think removing restrictions (i.e. that the tested command must
> be 'git', 'test_*', etc.) on 'test_todo' requires doing the same for
> 'test_must_fail' et al. to be internally consistent. On one hand,
> 'test_todo' could be interpreted as an assertion (like 'test_must_fail'),
> where we only want to assert on our code - hence the restrictions. From that
> perspective, it would make sense to ease restrictions uniformly on all of
> our assertion helpers.
> 
> On the other hand, I'm interpreting 'test_todo' as
> 'test_expect_failure_on_line_N' - more of a "post-test result interpreter"
> than an assertion helper. So because 'test_expect_failure' doesn't require
> the failing line to come from a particular command, I don't think
> 'test_todo' needs to either. That leaves assertion helpers like
> 'test_must_fail' out of the scope of this change, avoiding any hairiness of
> allowing them to assert on arbitrary code.
> 
> What do you think?

I don't think we need to remove the restrictions on 'test_must_fail', 
they seem to be there for a good reason and I'm not aware of anyone 
complaining about being inconvenienced by them. I think of 'test_todo' 
and 'test_must_fail' as being distinct, 'test_todo' only reuses the 
implementation of 'test_must_fail' for convenience rather than any other 
deep reason.

I added the restrictions to 'test_todo' to try and stop it being misused 
but I'm happy to relax them if needed. I'm keen that test_todo is able 
to distinguish between an expected failure and a failure due to the 
wrapped command being misused e.g. 'test_todo grep --invalid-option' 
should report an error. Restricting the commands makes it easier to 
guarantee that but we can always just add checks for other commands as 
we use them. In a way the existing restrictions are kind of pointless 
because test authors can always name their helper functions test_... to 
get round them.

I think you've convinced be to remove the restrictions on what can be 
wrapped by 'test_todo' when I re-roll.

Thanks for your thoughtful comments

Phillip

> [1] https://lore.kernel.org/git/221006.86mta8r860.gmgdl@evledraar.gmail.com/
> 
>>
>> This commit coverts a few tests to show the intended use of
>> test_todo().  A limitation of test_todo() as it is currently
>> implemented is that it cannot be used in a subshell.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
