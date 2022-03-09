Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEEAC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 19:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbiCITbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbiCITba (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 14:31:30 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694C55AA6C
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 11:30:30 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id l24-20020a4a8558000000b00320d5a1f938so4114896ooh.8
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 11:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=oiee2nOpWq0RkTMgof5un6g9plvUp5CPhCpthLLaAOM=;
        b=eER40w0S9wb4ra3+0g65rpsWlrLODZyAwv9c0nGy/f2B7857lFd9ud9dNGvmKkP7kP
         oRqhicxz79y8QQtUmp2q4ThGyu8LP8+NOwdN1VSH5AMjU6Mcgom26HqFW7C6lSYb912U
         QyStLBf1Aj7Hq3xiRp4EvBj5yO4znc3VetzzxI6GBwWs8NYK3piX6lv+Lq7gT7h3cufx
         vtVFmunwmFw/qsixKKP8wExvkaxJOu3bOcH8QafLpWKNg2leAe3roI5/5uRBtwFPMb0z
         51uObK9Qvfp02wUxrD3w8dup7DcSRuWn70jo/liAeRDbIKSWXQCj6Z0klMA9meiwZsGd
         xkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=oiee2nOpWq0RkTMgof5un6g9plvUp5CPhCpthLLaAOM=;
        b=CnzbyDikTT6LMc9DuITc24z42jzd6GsR3UDqvIyJvtAVxlv1c0UA/oUzuL5J3Ltmub
         7jW3/uac2AtKBvR4GGgF8OcbX6P+NCjuDujlj30bKfJs1Dl5PBrpJ8BlBzpXiQiiw/Qr
         EbygwpfcpWkDwyEeCn3wECDlwG6LeKJwT9zjfpjmdVzeUBRQ9ON3ldkaAlnTgGvt1h7d
         UsELUfrKPwRPym2kBwGIlXQ1ZsuGgiTswrDYsEoddy8/h6fTSmE/jxzaOYhNsVy6frAM
         beltwqBKNKVIDndgm876w3nynM3LvMNH4MR3IxdHbFojYsMXHgJu2+IUYa/wHCzappKF
         hLbw==
X-Gm-Message-State: AOAM531AAEFbtlYNKmADpc6c8vct/q1QoiwZedrZ6ke2abc18FN/q4Ic
        L/0r9EkbooOlfMKex3NtYVMS
X-Google-Smtp-Source: ABdhPJzybNDyr5aUtTnotMukl1oPePDfTpnyqMed68OKNOd7flILYOry+M1UJFLuOYxgOsnr9jCkgA==
X-Received: by 2002:a05:6870:508:b0:ce:c0c9:5f1 with SMTP id j8-20020a056870050800b000cec0c905f1mr6331537oao.67.1646854229352;
        Wed, 09 Mar 2022 11:30:29 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id j10-20020a4ad2ca000000b0031c515672d0sm1394129oos.23.2022.03.09.11.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 11:30:28 -0800 (PST)
Message-ID: <94242ef8-2e68-1b77-a108-2ed3604741fa@github.com>
Date:   Wed, 9 Mar 2022 14:30:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 00/24] revision.[ch]: add and use release_revisions()
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <77c8ef4b-5dce-401b-e703-cfa32e18c853@github.com>
In-Reply-To: <77c8ef4b-5dce-401b-e703-cfa32e18c853@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2022 9:34 AM, Derrick Stolee wrote:
> On 3/9/2022 8:16 AM, Ævar Arnfjörð Bjarmason wrote:
>> == For Junio ==
>>
>> This has a trivially resolved conflict with Derrick Stolee's
>> aaf251cdc5c (revision: put object filter into struct rev_info,
>> 2022-03-08) currently in "seen" in builtin/rev-list.c.
>>
>> The resolution is to just keep the "goto cleanup" in place of "return
>> 0" in the conflicting lines, but to otherwise keep Derrick's version.
>>
>> It will pass with/without SANITIZE=leak when applied to both "master"
>> and "seen". I omitted one test change (described in a relevant commit
>> message) due to the latter not being true (no fault of "seen", just a
>> new leaking command being added to a test).
> 
> Since ds/partial-bundles will soon be updated in v4 to change the
> pointer added to struct rev_info, it is even more likely that there
> will be more important things to do with regards to clearing the
> memory of rev_infos based on that change. It might be better to wait
> for that update (coming soon) and then rebase directly on top.

I took a look at the series as it stands now and have a few nits
here and there. Generally, things are pretty standard in this kind
of series you've been working diligently on for a while.

The only thing I can recommend is to check that your leak-check
statements are still true when reaching the end of the series, now
that the filter member exists. Likely the tests that you are marking
as leak-free do nothing with object filters, so they will still be
true. Just something to keep in mind and maybe add a patch that
recursively frees the contents of 'revs->filter' at the end.

Thanks,
-Stolee
