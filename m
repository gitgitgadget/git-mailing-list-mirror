Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F208EC433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F4660FC0
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhIOQnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhIOQnc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 12:43:32 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D87CC061767
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 09:42:13 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso4388871otp.1
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j2q/84xIg9Dx+goMIJaB0X9yw1dvJnAyLpf3oo/xEwM=;
        b=jJF7IMxGBg4b5UXuWDRDkJ7hc4r8lTHp4WxNVvs/T6ZFGg9RN57Fd6EmoBSB8ueEYx
         Qn0EV07a2Wg7CJXeltMgKvCT2NSJ2K2MFu9+6Walneyy21lfC3Yj4hufl5de0n7NcCcD
         W4GpUti75+sZbkVuOk8Z+8YwV8CJqNG2tSBaRRRUZXkGBtuHacv95X/a3KKxnxv+4fob
         fj7A8QyjKEyBmDwLu/i9rDAR4fnyvyR0fskNJF7ABlvYXUWm8jZpakQZohYam74amES6
         mRIQPI6sSc22aJa9YP/qoCGuggV8i315sg14ti/vUhtyiadLyBvr5zmixMO4G5Yc7bUo
         Wx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j2q/84xIg9Dx+goMIJaB0X9yw1dvJnAyLpf3oo/xEwM=;
        b=2QxB9/SOaEkaz6wZ3ngZmY522GHiw/kvaOlIxsxw3PjbzdruIhS1fvSf2LgQvWa939
         DRP+zlxw2VIzfuRJJxw25rkG0TCXWJLYfvua9jmsyZ6KhBfx2iTMleyzcODTWYab3BIL
         TuYhGMuay6E/EBdZoGzOjbX6tzMsLw//DHqAZ8zpSvO7Voi2pDBuMk8aA5Su2bSzj5oi
         mxIja6E2lDweFCmbfRK+e9nPTzaR2uaalCBPmAPf937zFi7HTBqnDqT6ss04jsUq0ixD
         uoje08GATk4bYAq/gBd93RTiDetZsmeJccGGs5xOiYwBXvMfUj9yz/MczojE0cqq5jFn
         gnYQ==
X-Gm-Message-State: AOAM533nX6L2G8DAJAmTK4Z8g9oI0XLYPipvl3gZeHtMtFohkc9EkO7e
        0qR7wZee3asUKRMtql/t8KM=
X-Google-Smtp-Source: ABdhPJw5PpQg+kWw/NZEcJvF3/gG0GSXc8QCpQ3avmmpMxd2nQ8uEZOamONyK4+fRLBK3KaJkebD4w==
X-Received: by 2002:a05:6830:20c2:: with SMTP id z2mr782075otq.285.1631724132323;
        Wed, 15 Sep 2021 09:42:12 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:8cdb:119:9f7e:3e24? ([2600:1700:e72:80a0:8cdb:119:9f7e:3e24])
        by smtp.gmail.com with ESMTPSA id q22sm136032oof.14.2021.09.15.09.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 09:42:11 -0700 (PDT)
Subject: Re: [PATCH v2 01/14] t3705: test that 'sparse_entry' is unstaged
To:     Matheus Tavares <matheus.bernardino@usp.br>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
 <8aefce6254c0bcbbbca909a62d033c74c90f980b.1631453010.git.gitgitgadget@gmail.com>
 <CAHd-oW59G6MF04aUA-XJewa=0VnqbHenb2khkeO7U9egW_6S4A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <96e63435-f8d6-73c7-15f9-f713fd742931@gmail.com>
Date:   Wed, 15 Sep 2021 12:42:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHd-oW59G6MF04aUA-XJewa=0VnqbHenb2khkeO7U9egW_6S4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/15/2021 12:32 PM, Matheus Tavares wrote:
> On Sun, Sep 12, 2021 at 10:23 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The tests in t3705-add-sparse-checkout.sh check to see how 'git add'
>> behaves with paths outside the sparse-checkout definition. These
>> currently check to see if a given warning is present but not that the
>> index is not updated with the sparse entries.
> 
> Hmm, I probably missed something, but don't we already check that with
> the `test_sparse_entry_unchanged` helper? The only test case that we
> don't call it is 'git add --refresh does not update sparse entries',
> but we explicitly compare the cached 'mtime' from before and after
> `git add` there.

test_sparse_entry_unchanged does a bit more by actually
requiring that we fully know the mode and OID of the object
in the index. 

Since some of the tests modify sparse_entry and then update
the index using the --sparse option (including a mode change
with --chmod=x), it seems more robust to avoid an exact
match from ls-files.

Thanks,
-Stolee
