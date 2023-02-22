Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBB0C6379F
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 10:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjBVKQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 05:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBVKQM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 05:16:12 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7F534C29
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 02:16:08 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j3so3342793wms.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 02:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LNPQ2G95drX0BLyuXgG0m37j7ZIFH7TO1PyfBI43zFk=;
        b=qsjHU8dJzu9UP7ftId1UTY25aK/r/oK09qKK8FU72NwVVlvnVDV2DMzdZIJevYl48U
         Vx9MOXadigHqUTaQIUpsIcZqUmmvOAsCEO3T6PYxNY1TxMhitFrg/dQnpNnIHPPuuLhW
         dNsfdoC7RgaYpYaQLKlJyKNOTYMtTdMcw8r4y7KUjQl+K5s8CcQq/hIFsf2l/hPcfXqn
         wKZ7nfSRvRjPYhN8LEnXJOEBTCdA0OpzoSvebmzcvarc73H2dURkSjxpHbnXkwab9Rki
         pGBfK54wgC2A+FqAw8WnkNM3PlqvMMlF4Z4MlbjpFqJvCZy/7ecehOgpPHKLTCFsnJeY
         1Nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNPQ2G95drX0BLyuXgG0m37j7ZIFH7TO1PyfBI43zFk=;
        b=A8SVEdj4aiRFNKY9llSGaa2r3IJ4rSTiirnsPefgBjblJ+LD0QsWpJX6wl2L99/gEE
         PZ1U+7ZGaGN7g7+7C1aAYCHcEyZh/qr2UO4jp9cnXKP8fquTWaYtEGqwV/nlnpguPR0g
         xmF9WDPJt4YEzcMys0uL2Sr/qtVC9G50zgTrAJp7JRpRXcNx5qjQdnvoqEU3Dcg09MPx
         vpXq6ahUhHLiF5ul3iH2NJ2KwYaixUEV2r/UU40IadSdtEvptq9zwJtXLPtM4UCjCjX5
         1xtry8Zp7QzIlrdFzh7/uywpKE8fRqk7xGlfHJUN0qkrIguOMXt30aW06oNkGiDkrky4
         eQQg==
X-Gm-Message-State: AO0yUKUkV9OZ/mySPVUq9j0PqNDk9oat5STH3j3aGiBVb5bq8L4Gb0XQ
        M/81vKxztW0EHYgfdUmsEibjGx/73dA=
X-Google-Smtp-Source: AK7set/zlpmF2x+CZujsD2hPExZU7YcV9ThO5dEl+/3FpWUnD7N2Pfp4dqOscc/ISED1x373W0i2dA==
X-Received: by 2002:a05:600c:3b91:b0:3df:f3df:29b0 with SMTP id n17-20020a05600c3b9100b003dff3df29b0mr6135055wms.14.1677060967054;
        Wed, 22 Feb 2023 02:16:07 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id s10-20020a05600c45ca00b003e8dcc67bdesm1988977wmo.30.2023.02.22.02.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 02:16:06 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <36090abb-72a0-f9b7-5a41-ddd8ccde92bd@dunelm.org.uk>
Date:   Wed, 22 Feb 2023 10:16:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/4] rebase: add tests for --no-rebase-merges
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de
References: <20230221055805.210951-1-alexhenrie24@gmail.com>
 <20230221055805.210951-2-alexhenrie24@gmail.com>
 <24be0c50-9dfa-e9d9-9d78-1b993832884b@dunelm.org.uk>
 <CAMMLpeSMO38acvnxK2QX18CdoaEiUojwLsV+AQZYOTe5h4Nq=Q@mail.gmail.com>
In-Reply-To: <CAMMLpeSMO38acvnxK2QX18CdoaEiUojwLsV+AQZYOTe5h4Nq=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 22/02/2023 01:37, Alex Henrie wrote:
> On Tue, Feb 21, 2023 at 4:00 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 21/02/2023 05:58, Alex Henrie wrote:
>>> +test_expect_success 'do not rebase merges unless asked to' '
>>> +     git checkout -b rebase-merges-default E &&
>>> +     before="$(git rev-parse --verify HEAD)" &&
>>> +     test_tick &&
>>> +     git rebase --rebase-merges C &&
>>
>> I don't quite follow what this part of the test is for
> 
> The test is modeled after the existing test "do not rebase cousins
> unless asked for". First, it verifies that --rebase-merges rebases the
> merges, which in this case results in no changes to the branch. Then,
> it verifies that `git rebase` without arguments flattens the history.

I think "do not rebase cousins unless asked for" is a bit different 
because it is checking the default for --rebase-merges which seems 
reasonable. I cannot see the point of checking that --rebase-merges 
works in this test as we have a whole file of tests that already do that.

Best Wishes

Phillip


>>> +test_expect_success '--no-rebase-merges countermands --rebase-merges' '
>>> +     git checkout -b no-rebase-merges E &&
>>> +     git rebase --rebase-merges --no-rebase-merges C &&
>>> +     test_cmp_graph C.. <<-\EOF
>>> +     * B
>>> +     * D
>>> +     o C
>>> +     EOF
>>> +'
>>
>> This test looks good. I think we could probably have just this second
>> test
> 
> I like having a test for the default behavior. Nevertheless, I am
> happy to remove that test as requested. Does anyone else have an
> opinion?
> 
>> and squash this into the previous patch - improving the
>> documentation and test coverage for --no-rebase-merges would make a nice
>> self-contained commit.
> 
> Sure, squashing the first two patches is no problem.
> 
> Thanks for the feedback,
> 
> -Alex
