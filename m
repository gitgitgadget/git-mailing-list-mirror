Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6452C433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 15:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiK3Pih (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 10:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiK3Pic (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 10:38:32 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA982982A
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 07:38:31 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w15so14507210wrl.9
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 07:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wByZyunCH1N5dK8li2pS0yM6EgPGVbYOqutmCTXbXOQ=;
        b=JINCYVzsrcyJlgiysr3fKIMacj0dIoNO9K5S5LhdqTg4jGIEmWt1is2fQUJMKwe5ha
         Wc+WmThMaQeQzacqqW1Mazl1ax48ThiMOgzjg++rIfSgkz/LEdSnfiraZSa8YTugsS7I
         2XRJN0+xOotlyEoWqZHkUisJ1sjvKlstuZrkUfdpFq1d15Mq/o1bjl9L7+EoTPwf16Tg
         yZx+lvOsHRX5DAY0V6I9ZrvsQ452MmKEI7SsM3KBR+IQAhUdYXdqcNYswHBjjTFU0vVa
         3fzVd6cgAHb5BAvz5dNgZBL3ojSZvR43JDxgoZrBJzWVwQqBxtH5UJ+x2Ns0WlL2tfb6
         tsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wByZyunCH1N5dK8li2pS0yM6EgPGVbYOqutmCTXbXOQ=;
        b=iMuJpAUosm9/4jhx01mjxd/JqLJVH3P8BA+D+g7pRDp1sRjvgVUZ1dJpwZiU4eJeXj
         JtyssQpTHljDVscbx/tYgB76OUA92yqkk/4U6WhEghMii7cyfAeRzZaccAFytlirr/9t
         2hAVHySPxHrQ2KIq+Vh4aOyX9S44AIoIPCtpP/51e0hsEvFWoH5IHyJXRF/AUmj1fbny
         74PgjjFKU57Q3FnDUT2hibSK/x4yK36Hy6kD99PfKj62iRgFEuVe2/MJt2w3UqBRCkZ1
         Ufg1mHZ3qi1K+H2mlq+LYBj8DrAW+GKPFksYmRdZ0MUzmzgRG0dBZrtCpkclZ15btxmE
         78EQ==
X-Gm-Message-State: ANoB5pnHN1WaKLUlVoKC8VoxvaSJ6mmho/DmqSqMAODjh3R0YlfHEXN4
        f5DQKFuVne9CXl0KI5MhMJQ=
X-Google-Smtp-Source: AA0mqf4rnGbvaNyCX9wiUcN/CEtjnpbLzMrF4rFhwBOElUK7KhmcQHlOwzy94JrzhY0zpvg8yfvlPw==
X-Received: by 2002:a5d:51ce:0:b0:236:78cd:f3e7 with SMTP id n14-20020a5d51ce000000b0023678cdf3e7mr36639869wrv.140.1669822710180;
        Wed, 30 Nov 2022 07:38:30 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b003cf54b77bfesm6579863wmq.28.2022.11.30.07.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 07:38:29 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <0e3ab2bb-68ed-8e77-ac0b-afeb5ca88def@dunelm.org.uk>
Date:   Wed, 30 Nov 2022 15:38:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2 file
 format
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        John Cai <johncai86@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
 <CAFQ2z_MZd150kQNTcxaDRVvALpZcCUbRj_81pt-VBY8DRaoRNw@mail.gmail.com>
 <f1c45bd5-692e-85db-90c3-c516003f47e5@github.com>
In-Reply-To: <f1c45bd5-692e-85db-90c3-c516003f47e5@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 30/11/2022 15:16, Derrick Stolee wrote:
> On 11/28/2022 1:56 PM, Han-Wen Nienhuys wrote:
>> * Worktrees and the main repository have a separate view of the ref
>> namespace. This is not explicit in the ref backend API, and there is a
>> technical limitation that the packed-refs file cannot be in a
>> worktree. This means that worktrees will always continue to use
>> loose-ref storage if you only extend the packed-refs backend.
> 
> If I'm understanding it correctly [1], only the special refs (like HEAD or
> REBASE_HEAD) are worktree-specific, and all refs under "refs/*" are
> repository-scoped. I don't actually think of those special refs as "loose"
> refs and thus they should still work under the "only packed-refs" value
> for extensions.refFormat. I should definitely cover this in the
> documentation, though. Also, [1] probably needs updating because it calls
> HEAD a pseudo ref even though it explicitly is not [2].
>
 > [1] https://git-scm.com/docs/git-worktree#_refs
 > [2] 
https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-aiddefpseudorefapseudoref

Unfortunately I think it is a little messier than that (see 
refs.c:is_per_worktree_ref()). refs/bisect/*, refs/rewritten/* and 
refs/worktree/* are all worktree specific.

Best Wishes

Phillip
