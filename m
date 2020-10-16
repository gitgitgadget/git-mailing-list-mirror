Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4352C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 13:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DE820848
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 13:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNTi9ZvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407391AbgJPNkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 09:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407330AbgJPNkV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 09:40:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C46C061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 06:40:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s9so2964676wro.8
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 06:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9b3oPIyf+FMMjtm6h2Yi85E10zpSlWoJqoge7jC57OE=;
        b=mNTi9ZvKnMz3d5D9JtyQTdS66W2TTOcU7chWOVOv2ZX7ANaSS/TDae3crMaZHGfwbB
         ftSS6ZE5khfPuean10PuseWVwQGqNwoTjFwKlXRPU0hKLC6vt5mLFkzgfp6o3QqAH+Ys
         bbIs2dSRg9kJa07hbrEBU+sgRi9iSJqWRs/uaa9nM9miQWDukStqbw7ywzIZKHQJITMR
         1eOej0aUGpEmQU1ea7jOqRiglV0vL00RvUwlq7OabZTTCrGPWfz0Sy+mns+LRWi4LahO
         RulWCDqcnNtljC4lf6e9wJdICjk9VRBRKeJ518Qp45Mq/RxH052F+hl7v8WY4s41fFa5
         H1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9b3oPIyf+FMMjtm6h2Yi85E10zpSlWoJqoge7jC57OE=;
        b=QrQiokQwco91SYSCzUmXr5m+/EMPJrLte71qtQZnvlQazhp3gZ9JcDc7N23ZPm7iIF
         VdE0eJuCd2MijyY8ALBG8XU8CAPf87iV+CEq/TzQhLnFi50C9ecwPkwtE0HOP80EORJE
         9QrKBSj4l65bMkHKx7xqLZgjRkTSTTcVETXOlrC9LLEHrM/rW+1K6x7M/EHeh4HUFT9K
         CtjeRCRM/VuYE+1ptFLakYplIY2GVemAUliPLJtI5igFBr004Ucs5cEJDldg18BUO6oI
         tdmHcsw2R3IYgFacfmU5z4UFCfN3RQRl//yhVFdqm3wTj/WlnLzGEUrxuIqZtErCy38v
         BkBg==
X-Gm-Message-State: AOAM531NgwdanweW3RHEAKcxVTW3aUY4dgomoYHii2Tps1P/G9J+EnRk
        Fnpd9t3quTHCHIx0mLWz1xA=
X-Google-Smtp-Source: ABdhPJyNKxy+7Npf1CVPY/bgQ1xcxXMxbr2F1/Lja2IsEiOVqKeFhyE0dDUXXa6xhhj5TR2MIOwszA==
X-Received: by 2002:adf:ecc1:: with SMTP id s1mr3882450wro.120.1602855601578;
        Fri, 16 Oct 2020 06:40:01 -0700 (PDT)
Received: from [192.168.1.201] (48.45.90.146.dyn.plus.net. [146.90.45.48])
        by smtp.googlemail.com with ESMTPSA id j7sm2795787wmc.7.2020.10.16.06.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 06:40:01 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] sequencer: fix gpg option passed to merge
 subcommand
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Samuel_=c4=8cavoj?= <samuel@cavoj.net>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20201012234901.1356948-1-samuel@cavoj.net>
 <d2491759-e761-647b-7e76-3515b8eeaf3f@gmail.com>
 <xmqqy2k9ixvz.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <31ce457b-e71c-0ca0-e5be-a9aebb9cf785@gmail.com>
Date:   Fri, 16 Oct 2020 14:40:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqy2k9ixvz.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

It seems to be that the config handling here is another example an 
interdependence between tests that makes life harder for contributors 
and reviewers.

On 13/10/2020 23:06, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>>    +test_expect_success 'rebase -r, GPG and merge strategies' '
>>> +	git reset --hard merged &&
>>> +	git rebase -fr --gpg-sign -s resolve --root &&
>>> +	git verify-commit HEAD
>>> +'
>>
>> Unfortunately I've just noticed that the test above runs
>>
>> 	git config commit.gpgsign true
>>
>> So this test would pass anyway if merge picks up that config
>> setting. The previous test needs to be changed to
>>
>> 	test_config commit.gpgsign true
>>
>> so that the config setting is cleared when that test finishes.
> 
> Thanks for a review, but I do not think that is a right way to go.
> 
> test_config has an inherent assumption that not having the config at
> all is somehow the "natural" state, and if that holds true, that
> would be OK.  But what is "natural" is subjective X-<.

What is "natural" is subjective but what is the default config is not. 
If test scripts set random config variables and assumes that they will 
be cleared in later tests if they don't want them it makes it very hard 
for contributors and reviewers to check that new tests are sound as they 
have to analyze each existing test in the script. In this example I 
believe the new test was contributed by dscho who is an experienced 
contributor with an interest in the test suite. However the test did not 
clear the relevant config variable - if an experienced contributor did 
not realize that the variable needed to be cleared how are new 
contributors supposed to figure it out? If each test starts with the 
default config it is much easier to reason about it.

> The way each test is run by calling test_rebase_gpg_sign repeatedly
> uses a different and more robust approach to ensure that previous
> test does not affect the current one.  Each invocation of test
> explicitly sets the configuration to the state the test wants to,
> cancelling what the previous test did.

It is only robust if contributors and reviewers realize that is what is 
expected. Reviewers that only read the patch without loading up the test 
file in their editor have no indication that the test should be clearing 
the config variable.

Best Wishes

Phillip

> To blend in better with existing tests and match their robustness
> expectations, the right fix is for this new test to explicitly use
> "git config --set" or "git config --unset" to make the variable into
> the desired state, regardless of what the previous tests did.
> 
> If the test quoted at the beginning of this message wants to make
> sure that --gpg-sign from the command line takes effect without
> commit.gpgsign set, it should unset the variable explicitly.
> Another combination worth testing is to ensure that --gpg-sign takes
> effect when commit.gpgsign is explicitly set to false (not "left
> unset").
> 
> Thanks.
> 
> 
> 

