Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05DEC433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 20:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiJFUcI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 16:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJFUcF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 16:32:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB5BBEAEA
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 13:32:01 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id qw20so6484648ejc.8
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 13:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oegIOAaKiSfQhII5y3xJK6XSZFVaHJvPcDzeQVgsc/k=;
        b=poUUJAH7EjqabR7+KEYAj07ZNKNrTpnVDvj2t64yYtSlwBJ4sjajeXo4ETsWKi5KNC
         mEzSBacxZCU8MW5oviswJeBUV0V9rhRlkPJA2mB9A9iWhxMA84vHb3z+yexuQX7CWTTW
         vXwyHBmiNiVUK/Bmb4U9MmI5DrCLPwWhv52LgLWKi+sd5mR3Rq0xkJYUwkL8rRyBZXMs
         KzMci/pIR1dlIpKLo+aMN35ZBF43VkOUBG4RsZ/ehrq5BCvpdCNh9lpEMgNZ4kBa26zf
         gT2RGe2AsSt5c9+KyZvcPMU5knwiJjTwZjKJ3uAAh2p0dmEuoh8mqEvbbzen/+fma7Ql
         PKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oegIOAaKiSfQhII5y3xJK6XSZFVaHJvPcDzeQVgsc/k=;
        b=dn8lXvC0Qk9RmrCkK4IOh7/4oRJV8L8fRAhbV1614gZx1lzlfKXQrEr6oTfE9vjRNb
         SKc3uCWEgJ8aUUNHV7w8hKzibN0vXafS7/pXNC0WVu1a6TpIppEwDAWNLplyIbD1BN9y
         qEH1PyzUvleUCryDtOQU4EVabXHEN5PibvhzyrV3bIcnmGFye1fdTaQFoq935GUVkfCJ
         +1UBsNnjy6UDK/g6ad5ElJJHu8IgeFS8FriHTO6DBICqkvPQ8Y3/3eIWs4PmcG+cVoLa
         QXKZAam7ISU8vMYW3IbAuqTtUDvtsV2e19DhVWXylqTKQg13D4yYBZLkKr6XI/zxfAwR
         Ih5Q==
X-Gm-Message-State: ACrzQf3o3XsIhtYXCiuXBeivJXyVvZ6E/u+BUmPoMzfFnYkrek229n53
        2Xi3Haq9E5yl0PPiucCu6IQ=
X-Google-Smtp-Source: AMsMyM4YgYC33yiVbI09TLSD6azJTzqb6cA1vJXJpkC5KC2IwV8THGEaof0s1hI6Zczre0VeCKEBYA==
X-Received: by 2002:a17:907:78a:b0:782:2223:a7cd with SMTP id xd10-20020a170907078a00b007822223a7cdmr1378535ejb.532.1665088319596;
        Thu, 06 Oct 2022 13:31:59 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id cy3-20020a0564021c8300b00458cc5f802asm103133edb.73.2022.10.06.13.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:31:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ogXXB-00340O-2f;
        Thu, 06 Oct 2022 22:31:57 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/3] [RFC] test_todo: allow [!] grep as the command
Date:   Thu, 06 Oct 2022 22:26:03 +0200
References: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
 <645fa2990f79bdb7ee00ff3fd34122676469a783.1665068476.git.gitgitgadget@gmail.com>
 <221006.864jwhrldr.gmgdl@evledraar.gmail.com>
 <c3f4a79c-2dc6-fbf4-fc61-591ebf417682@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <c3f4a79c-2dc6-fbf4-fc61-591ebf417682@dunelm.org.uk>
Message-ID: <221006.86r0zkr8w2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 06 2022, Phillip Wood wrote:

> On 06/10/2022 16:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Oct 06 2022, Phillip Wood via GitGitGadget wrote:
>>=20
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> Many failing tests use grep, this commit converts a sample to use
>>> test_todo(). As POSIX specifies that a return code greater than one
>>> indicates an error rather than a failing match we take care not the
>>> hide that.
>> Ah, so on the one hand this gives me second thoughts about my stance
>> in[1], i.e. if we just allowed any command we wouldn't be forced to add
>> these sorts of special-cases.
>> Although, we could also allow any command, and just add smartness
>> for
>> ones we know about, e.g. "grep".
>> But I do find doing this to be weirdly inconsistent, i.e. caring
>> about
>> the difference between these two:
>> 	$ grep blah README.md; echo $?
>> 	1
>> 	$ grep blah README.mdx; echo $?
>> 	grep: README.mdx: No such file or directory
>> 	2
>
> The intent was to catch bad options, not missing files (i.e. we don't
> want test_todo to hide a failure from "grep --invalid-option"). We
> could check the file exists and skip running grep if it does not
> (hopefully the test wont be grepping multiple files in a single
> command)

It returns the same exit code for missing files and bad options, so I
don't think this plan will work.

I.e. I (in my initial series) wanted to have something where we declared
what the behavior was right now, *and* what it should be.

But some of our tests are wishy-washing "I wish this worked", so:

	test_todo git some-new-cmd && # should write "unicorn" to a new foo.txt
	test_todo grep unicorn foo.txt

Won't do what you expect?

>> Is basically why I took the approach I did in my [2], i.e. to force us
>> to positively assert *what* the bad behavior should be.
>
> That is what made the end result so hard to use though
>
> 	test_todo \
> 		--want "test_must_fail git" \
> 		--reset "git reset --hard" \
> 		--expect git \
> 		-- \
> 		rm d/f &&
>
> is not exactly readable.

Yes, indeed:) Anyway, my just-sent
https://lore.kernel.org/git/221006.86v8owr986.gmgdl@evledraar.gmail.com/
goes into that.

I think a "test_todo" should either be a "strictly declare stuff", or a
"YOLO this" where we just detect segfaults.

But per the above having it be some mix of the two is just confusing,
i.e. to extend the example above:

	test_todo git some-new-cmd &&
	test_todo test_path_exists foo.txt &&
	test_todo grep unicorn foo.txt

Won't "work", because the "test_path_exists" isn't strict, but your
"grep" is.

So I think whatever "test_todo" does it should be picking one or the
other.
