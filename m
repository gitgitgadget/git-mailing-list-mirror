Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7125C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 11:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B76CF61074
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 11:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349310AbhIHLlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 07:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbhIHLln (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 07:41:43 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC89C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 04:40:36 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x5so1479164qtq.13
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 04:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eeJmXRO3dUM4JApE3eOD/rkDf23nfqBJHwCCPYz1aM0=;
        b=I59qmI4S9uZq4cjEceOQ3CPxjpIVPO1mVAh7lIiXrGTBK98F6FAOunoXPAst9/E6C5
         VDfsZv+hMCNpiDhALgLpYZ5bpKAZr/U6a1ocpoIQhv/qnkOMQ6rL65sN3QnWCDWXF2zP
         hn24a4ENiTV+TsA02yP8gJs/ZjiQEG6EIaM4L1u2qkD3+hesfSU5tfM76Mg8BmiWS1Tm
         yX/tgDhFhycsa1gHmM+x1VTazs5ncViPfQ3HuJ8XLJePMMjWLmH5boX7SMVd79VDimZ3
         nMF0dXMhaAjg2hDEbY/V6i2aoOZTjlmry0dUljPVvhNWNSoavGb84Z4jKzKIFl/4QEb+
         sQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eeJmXRO3dUM4JApE3eOD/rkDf23nfqBJHwCCPYz1aM0=;
        b=GnlhWOe+kaIqx8BRGXpHFn3JLh5xcs2S410g6x8VMU+falAqkDBO7Ok8vY5EuLEg9U
         OCVCeNm9FEb/Z3fYb4qoElh65M5QQCvo5xQhVMe62beRjmXKtf7Ra9IWx8fuMRAo6t8F
         zDuP4aopph9e4gVg0XA2j4DAvtmD2Kh2aIeOTPUZg8srJnS+jQN+raB/5EigXJz7O/Km
         4bKiZbfsaghhau9ZE0YXWBvXBB6EFsaJ1SYXS2jcGRSEMCoFpr4DQYKdHrNLccQ+bEnf
         xsQWd/f46N0enJY4I88InEkWL2QAVJsaVQ99/2/Liu+4zNdICx0s2djEwQeu+1xYY0GH
         AROA==
X-Gm-Message-State: AOAM532aUZgQiTSSd0sw10GKNbAh1QoXgXd9gPUd6Oq/CV4o16WJNQy4
        o468GJ/ddKADMFO6/vEary0=
X-Google-Smtp-Source: ABdhPJwdGSTxla2o9H3eHXsqWhIdWqpdJp8b7MHZonPljCV0D2pOyuS/UWcbJr5lNKjudlfM5U7NsQ==
X-Received: by 2002:ac8:53d8:: with SMTP id c24mr3251066qtq.280.1631101235049;
        Wed, 08 Sep 2021 04:40:35 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79fe:8f64:ef46:a881? ([2600:1700:e72:80a0:79fe:8f64:ef46:a881])
        by smtp.gmail.com with ESMTPSA id f29sm1308946qtv.34.2021.09.08.04.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 04:40:18 -0700 (PDT)
Subject: Re: [PATCH v5 0/9] Sparse index: delete ignored files outside sparse
 cone
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, matheus.bernardino@usp.br,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
 <pull.1009.v5.git.1631065353.gitgitgadget@gmail.com>
 <xmqqwnnr7icz.fsf@gitster.g> <xmqqczpj7dyk.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4a0125d2-67d9-b533-4f8b-618c3de3b411@gmail.com>
Date:   Wed, 8 Sep 2021 07:39:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqczpj7dyk.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/8/2021 2:56 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> Updates in V5
>>> =============
>>>
>>>  * Updated the locality of a cache_entry pointer.
>>>
>>>  * Rephrased a comment.
>>>
>>>  * Removed the patch adding a config option.
>>>
>>>  * I tried, but failed, to create a scenario where the call to
>>>    cache_tree_update() causes a test to fail. I still think this is valuable
>>>    as defensive programming for the reasons mentioned in the patch, which is
>>>    why I didn't remove them here.
>>
>> OK.  
>>
>> The 'sg/test-split-index-fix' topic that has been queued in 'seen'
>> textually depended on the earlier iteration of this topic, so I'll
>> discard it while replacing this topic.
> 
> I rebased the dependent topic myself, but I would not be surprised
> if I weren't careful enough and introduced a new bug.  Please double
> check when a new 'seen' is pushed out in several hours.

Did you have any conflicts? I don't think this version changed any
of the textual dependencies. Anyway, the test suite passes with
GIT_TEST_SPARSE_INDEX=1 on my machine at 'seen' (except for an issue
with t7900-maintenance.sh that is unrelated).

Thanks,
-Stolee
