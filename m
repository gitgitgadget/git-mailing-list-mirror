Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84E8C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91099610A6
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244087AbhIMPmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240645AbhIMPmN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:42:13 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DB2C0253FB
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:02:42 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id t2-20020a4ae9a2000000b0028c7144f106so3486677ood.6
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tei0F7vm/fRw7f5F8OEWHm9FbQSuDmLr3nkgoIlWwh4=;
        b=l7rPCfYx4RiXAfSoNw8pxvy/IiQG9W5D60ncqHMLApesCIuQG/5OhhSh8+ttYijCBS
         ZPllw3Zs4gE0IbuNyZsCUccorKOMGzbIiA+FN3bWwvFK0MGneaw8PmUOpyb6qrOQqKDu
         JNeoN0jq/NL8v0dA10DsbTxBU/1j0fr9LiHiW4q5x5g9tquDmShHWgIhrpprrXstuYnn
         I1fl1k2OTRdbGrhKtZU1xRbi4LzESoYochkVSz3qTxbopNJLdZ1g7ZPT8gdAGiHSHN2X
         NQpqXxNwv84SLsK7X0sEseA3BTZFas0/15/wgkjXQvblMNlwlRYuO4pP9HKmLzn+qfFO
         0TbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tei0F7vm/fRw7f5F8OEWHm9FbQSuDmLr3nkgoIlWwh4=;
        b=kqigw1iAHm+oPT3ov2ISdnai61jYJ/nE0dnDXGpmTP0kZGPmtwzBck5AchDrjgAbh+
         /5FkYXxz5iSz17Msy8Bl/mEJ5uHvB0CcvcJ2S9dujTd4Khik3AEJTltUJwbivAhEbkIS
         892bY9dj0f+Fcg61AVx4Ww8QP5gyD4h4Fu49/iuIpEclznDAO7q+epGnkhVoxCuoFBYv
         iEl1DgOXfFbvnPAoPCWxpjNcywsem1IZv8YTeTZG+Q1FRBit9zqnhzT9PfjzvXPVU/hW
         uCrHcXj0b9l3QreCBuTUJOFqfJXlXsMDJcElpoJAEGiJBzKOdYirhjNrBITnLEr0PHLw
         krXA==
X-Gm-Message-State: AOAM533Tfl6sC2XxVwshorF74Ae/xcpgeurClRdq0ufV2vZItSZWQkmC
        U+D9wHzUzeRR9qjf6gPG640=
X-Google-Smtp-Source: ABdhPJz4ZBeTMMb6QYyVtqvo+qM/A8uYgwToKtndggF69PyFZoUsPXMhUXH2BL32gc4B1bLMPgbVLw==
X-Received: by 2002:a4a:3b0e:: with SMTP id s14mr9649520oos.40.1631545361627;
        Mon, 13 Sep 2021 08:02:41 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:68b4:7b14:58ba:fff4? ([2600:1700:e72:80a0:68b4:7b14:58ba:fff4])
        by smtp.gmail.com with ESMTPSA id x42sm1908091ott.14.2021.09.13.08.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 08:02:41 -0700 (PDT)
Subject: Re: [PATCH v2 02/14] t1092: behavior for adding sparse files
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        matheus.bernardino@usp.br, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
 <61c23dc59a6e062e073ba3bea135c370a78415aa.1631453010.git.gitgitgadget@gmail.com>
 <87lf415tge.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0c691195-cb06-aa91-639f-cc1added81b6@gmail.com>
Date:   Mon, 13 Sep 2021 11:02:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87lf415tge.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/12/2021 6:17 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, Sep 12 2021, Derrick Stolee via GitGitGadget wrote:
> 
>> +# NEEDSWORK: This documents current behavior, but is not a desirable
>> +# behavior (untracked files are handled differently than tracked).
> 
> I wonder if a test_expect_failure test would be better for the thing
> that is the desired behavior, but maybe we don't know what the CLI UI
> for that would look like yet.

The problem with test_expect_failure is that you don't know which
line of the test is the problem. That's probably all fine and good
when we completely understand the situation we want to solve but
don't have a good approach to fixing it, but here I want to document
a change in behavior.

Using test_expect_success allows me to demonstrate "it works this
way now" and then "this is how behavior changes".

>> +test_expect_success 'add outside sparse cone' '
>> +	init_repos &&
>> +
>> +	run_on_sparse mkdir folder1 &&
>> +	run_on_sparse ../edit-contents folder1/a &&
>> +	run_on_sparse ../edit-contents folder1/newfile &&
>> +	test_sparse_match test_must_fail git add folder1/a &&
>> +	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
> 
> Just "grep" is preferred over "test_i18ngrep" now, the GETTEXT_POISON
> went away.

Right. Force of habit.

Thanks,
-Stolee
