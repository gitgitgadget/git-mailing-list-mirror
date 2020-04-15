Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EE8C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 10:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D93CD20768
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 10:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFM8ulOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896199AbgDOKIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2896152AbgDOKIY (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 06:08:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AB2C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 03:08:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i10so18395526wrv.10
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 03:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kzBdo55HjfD+jATlBmyrNDsV6wXPj1qsq3cieSrxRsg=;
        b=CFM8ulOsZ1Q6cgYQ894leIdcm5g52Ko2WkmrQNdJ/dadkFULi4pTozhWF6t5mTA7Kh
         uNB2SWKL6E4sgbuC9UM+Oz8CBgtnNZhSf6KBFmzQKTOu2JOhsw9ckefozcnb4nQfENCf
         4s52baG1ZIp8waXJPKf3C3YIsgS1hiaqVRNne1K+eaqm6G7Q3+jOgHhqPWAi841vaS3r
         mXZGAYU1NGE/VK1zgezX03yjqj+uhncrWts/SGPIoC3v8uTNIYmIK1T4P8Icvj/ceFSF
         lchgUVSQQSqDa1RSAjAwQdts/jsGr8pyC93QygLob4+sp2YKwRIVPhS4it/5I/nwVHx1
         EsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kzBdo55HjfD+jATlBmyrNDsV6wXPj1qsq3cieSrxRsg=;
        b=Zz+3uDmYytkq7rWmA51W7AeBQJzyoW+PhtU7uoMYs/A/BAVnr0KzxpWYQ+Ds5FZOwL
         rYmKzIx7vHrSKrR6PG9y6Wn170ApMhlHYaElzmPi3At8uEPRnT1v9q2OdFyGjsjgShFo
         QKwtq+7Cd5A/2L5jFVaOlvPO6SRGxXBGTO2WSMm9lOXABXCR3K9rbYeN3dfgN2wtZcVt
         B+g+5aS6KR1UN9/d+PMd/ra7zGiRAuNjR+MXSB7CYwFEFPJ6cK2EB6mpxm+84hDkTra8
         +ueWARDpC/hocxCVI+hj64bHp6snmJaGP2K3fzu8LYC2vEKrDu1BoKdMAKoF7zgNwoYH
         dZzQ==
X-Gm-Message-State: AGi0PuYE/qQZonunl1vPwqxOJxtKGEIpjv7JM8NDdgjM2NWzXPVFEHFZ
        nIyZ1NAoZUWI6MmJxpr5pEU=
X-Google-Smtp-Source: APiQypLrMlQ0YBkMIBDpBDQmfy2P8BiQ5Cwh5GadR/f7YZ2pFCtrF+x1P3+wbJK8DRjHbxBlrM7zKQ==
X-Received: by 2002:adf:e403:: with SMTP id g3mr27778067wrm.121.1586945302439;
        Wed, 15 Apr 2020 03:08:22 -0700 (PDT)
Received: from [192.168.1.201] (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.googlemail.com with ESMTPSA id y10sm18065313wma.5.2020.04.15.03.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 03:08:21 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/2] configuration-based hook management
To:     Josh Steadmon <steadmon@google.com>, phillip.wood@dunelm.org.uk,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>, Jeff King <peff@peff.net>
References: <20191210023335.49987-1-emilyshaffer@google.com>
 <20200414005457.3505-1-emilyshaffer@google.com>
 <efad3927-1d8f-5545-48e9-9a58c2308273@gmail.com>
 <20200414200347.GD12694@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ec6efbd4-4821-eefe-b16f-ab1ed8bc2058@gmail.com>
Date:   Wed, 15 Apr 2020 11:08:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414200347.GD12694@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/04/2020 21:03, Josh Steadmon wrote:
> On 2020.04.14 16:15, Phillip Wood wrote:
>> Hi Emily
>>
>> Thanks for working on this, having a way to manage multiple commands per
>> hook without using an external framework would be really useful
>>
>> On 14/04/2020 01:54, Emily Shaffer wrote:
>>> Not much to look at compared to the original RFC I sent some months ago.
>>> This implements Peff's suggestion of using the "hookcmd" section as a
>>> layer of indirection.
>>
>> I'm not really clear what the advantage of this indirection is. It seems
>> unlikely to me that different hooks will share exactly the same command line
>> or other options. In the 'git secrets' example earlier in this thread each
>> hook needs to use a different command line. In general a command cannot tell
>> which hook it is being invoked as without a flag of some kind. (In some
>> cases it can use the number of arguments if that is different for each hook
>> that it handles but that is not true in general)
>>
>> Without the redirection one could have
>>   hook.pre-commit.linter.command = my-command
>>   hook.pre-commit.check-whitespace.command = 'git diff --check --cached'
>>
>> and other keys can be added for ordering etc. e.g.
>>   hook.pre-commit.linter.before = check-whitespace
>>
>> With the indirection one needs to set
>>   hook.pre-commit.command = linter
>>   hook.pre-commit.check-whitespace = 'git diff --check --cached'
>>   hookcmd.linter.command = my-command
>>   hookcmd.linter.pre-commit-before = check-whitespace
>>
>> which involves setting an extra key and checking it each time the hook is
>> invoked without any benefit that I can see. I suspect which one seems more
>> logical depends on how one thinks of setting hooks - I tend to think "I want
>> to set a pre-commit hook" not "I want to set a git-secrets hook". If you've
>> got an example where this indirection is helpful or necessary that would be
>> really useful to see.
>>
>> Best Wishes
>>
>> Phillip
> 
> Indexing repo content (see [1] for a detailed discussion) is one use
> case where you have a single command that runs identically from
> post-commit, post-merge, and post-checkout.

Thanks for sharing that, it is a useful reference point

> Also, I suspect that many users don't have a firm enough grasp on the
> various git hooks options to know ahead of time which ones they want to
> set to accomplish a given task (without diving into the docs first). 

I agree with this, especially as setting up a hook is probably an
infrequent task for most people

> I'm
> not trying to say that your workflow is incorrect, but my gut feeling is
> that most Git users would work in the opposite direction. Every time I
> have needed to automate something, I generally had a rough script in
> place first, and then looked up which hook(s) would be appropriate
> triggers for the script.

As you say once they have a script they still have to look up which
hooks they want to hook it up to, the indirection does not avoid that,
it just means they have to lookup how to set up a hookcmd as well as
which hooks they want to use.

Best Wishes

Phillip

> [1]: https://tbaggery.com/2011/08/08/effortless-ctags-with-git.html
> 

