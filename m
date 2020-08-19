Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DBEC433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 10:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3003207BB
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 10:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifh3r/0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHSKAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHSKAB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 06:00:01 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EB6C061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 03:00:01 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g8so1463039wmk.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 03:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+l8VkmVcx2/hDmTEAQKQii88Z8MukpbxEHHCGU+vlCo=;
        b=ifh3r/0rK54GJZqR4LwJr7TiWyiE8L/sPh3dEOJLR6rrXrIjpLrq0dbxo1eizU+9Kg
         dPG+B+VJWbLbLWoQoZHpYaLahgJdRVSohxh5hf9svmnzGd4+Sbl21E8u1KTaOW8o6E7s
         GIrIZ0U5U+TCkFstLQMCTmxoDuGfR10T++8NiZFAN1v/nqxKO2jRUy3VmczpjNQkKGf9
         7REaOZ0XQyS6dmPNiXIkAjSWAQAKt8DVgTsSMTLTILS5JZzbg/sVXQ7wmEp//ViUbKMp
         RaCkYa3b2tZA/yDgATWoswqogMsBlrolE+PZvmTnKbD0/bi+4pDjh2vOUAF6kJ0RoWzU
         mu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+l8VkmVcx2/hDmTEAQKQii88Z8MukpbxEHHCGU+vlCo=;
        b=IbkdOinjhim0x651O6NO6Dxdq043PuTC0+UP4Hvvj/guMszCM1ul147R08lEiBM9r8
         uvZSqIUgViMwb2EhHgmvmzV/X9pLwPNPM2djC3zJ3SoYQWW9dw4s3n2luMlqQF+PJ2P1
         PxBqofGZfmRjpeW4M0s1mhu8IArrGwMUnDOqVPUKJQxTD/Sj85WS0NmXMZWt/6Q+aj0+
         uatC5C2yHdRmUrek8dk37UjNFN9Rq45/fAyk6MI77vpe9oPqlvwfng5+HQvDKRO4xpiA
         hXOwi5E4QEYhteLezjGI48XSjfbIep7arck56XMHBXymRbbpQo0e6dPHTeBOwjGaielY
         GhWQ==
X-Gm-Message-State: AOAM532zq2x/tw90hjZiJyFuL9m5Kty7LhtX6TgOn5WDq64aNsAFn7fu
        oBZ+fhM+fQUns3qJQaTUM8Q=
X-Google-Smtp-Source: ABdhPJwkujmJ7nNVLuW/N3cTbMIAXT//DbHstpNyzBzjcNqrux/cIbnVM8ZVfCBd5ma/+G2RBCx3jA==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr4284642wml.126.1597831199634;
        Wed, 19 Aug 2020 02:59:59 -0700 (PDT)
Received: from [192.168.1.201] (192.252.189.80.dyn.plus.net. [80.189.252.192])
        by smtp.googlemail.com with ESMTPSA id k10sm40486286wrm.74.2020.08.19.02.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 02:59:59 -0700 (PDT)
Subject: Re: [PATCH 0/2] add p in C tweaks
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.702.git.1597670589.gitgitgadget@gmail.com>
 <xmqqmu2ryc0l.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <744e464f-6378-ef68-01c1-3b8bf63c54a4@gmail.com>
Date:   Wed, 19 Aug 2020 10:59:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqmu2ryc0l.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/08/2020 20:44, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> A code cleanup and small bug fix for the C version of add -p
>>
>> dscho has pointed out that the bug fix in the second patch gets lost in the
>> other changes and suggested adding the last member of the enum (which fixes
>> the bug with handling 'e') as a separate patch. I'm unsure as it feels odd
>> to split up the introduction of the flags - I'd be interested to hear what
>> others think.
> 
> Essentially, the original was doing:
> 
>     - In early part of patch_update_file(), decide what option to show
>       in s->buf using "if (undecided_previous >= 0)" etc. boolean
>       expression that is tailored for each command;
> 
>     - In later part of patch_update_file(), after getting an answer
>       to the end user, try to use the same boolean expression that
>       is tailored for each command to see if the given command is
>       acceptable.
> 
> and the bug was that each pair of boolean expressions that are
> supposed to be identical were duplicated in two places, and one pair
> was not identical by mistake.
> 
> Your [2/2] fixes it by turning the above to
> 
>     - In early part of patch_update_file(), decide what option to show
>       in s->buf using "if (undecided_previous >= 0)" etc. boolean
>       expression that is tailored for each command, *AND* record the
>       fact that the command is allowed in the permitted bitmask.
> 
>     - In later part of patch_update_file(), after getting an answer
>       to the end user, consult the permitted bitmask computed
>       earlier to see if the given command is acceptable.
> 
> Since there no longer is duplicated boolean expressions that are
> supposed to be the same but different by a bug, once this conversion
> is made, it is impossible to have the bug.  For that reason, I do
> not think the suggested split makes much sense.
> 
> A much saner split, if we have to split this step into two, would be
> to first fix the bug keeping the code structure of the original,
> i.e. the later part guards the 'e' command with
> 
> 	if (hunk_index + 1 == file_diff->mode_change)
> 
> but the earlier part also required !file_diff->deleted, i.e. the
> condition should have been
> 
> 	if (hunk_index + 1 > file_diff->mode_change && !file_diff->deleted)
> 
> So without introducing enum and permitted bitmask, you can fix the
> bug in place, replacing the incorrect boolean condition in the later
> part that guards the 'e' command with a corrected one.  That would
> be a minimum fix that can become your new [2/2], whose theme is "to
> fix the bug with minumum change".
> 
> On top of that, you can convert the function again to reach the
> final shape that writes each boolean condition only once and records
> the permitted commands in the bitmask.  That can be your new [3/2],
> whose these is "to make it impossible to introduce the bug previous
> step fixed".

Thanks that makes much more sense to me

Best Wishes

Phillip

>> Phillip Wood (2):
>>   add -p: use ALLOC_GROW_BY instead of ALLOW_GROW
>>   add -p: fix checking of user input
>>
>>  add-patch.c | 67 +++++++++++++++++++++++++++++++++--------------------
>>  1 file changed, 42 insertions(+), 25 deletions(-)
>>
>>
>> base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-702%2Fphillipwood%2Fwip%2Fadd-p-fixes-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-702/phillipwood/wip/add-p-fixes-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/702

