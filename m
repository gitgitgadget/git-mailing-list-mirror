Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FF1C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 15:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiCAPKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 10:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbiCAPKU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 10:10:20 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FC965431
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 07:09:38 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so22818734oot.11
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 07:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5AxrAEizIh5Yyzzr4En+3UdrcRTkOiJC2hfG/NRo9yA=;
        b=Nvelk7CQ2B9WEOo2PXgtFTxiLC6CWQCMVWVHNFIoGqxy5L8/Xue/RUknrWnzIx3QX7
         mjIvPBLJTzmnoZZ27sQPMxcXGPoJyHmDaDg4Kh0M3UgwmZbzFBm1IU2BzvZtPPsHblgn
         OgfpKMaeyNxHRGd/fXjXl9LHuXcoatl6H8i1OrJ5GHxuQ86y0zeVG6jl0V/3RgXdBpbt
         k2Y7b0B8Tzvimky9m0H+NiGhxsQA6Sz3Zg4iurOSla2Zj/zbAlyLiAAq2C+xMTsvKWWL
         wHgc98Hu31DEl18Ih9V/bQuCcL9Ogp+18g8TSLcKhmyTJKdRY5wMNsfwhdLZeg7r+Ofp
         Aeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5AxrAEizIh5Yyzzr4En+3UdrcRTkOiJC2hfG/NRo9yA=;
        b=k9qEKbCcphVMwW7qiLSgu+Xjve9mr+0XPc51ESA+AhgPPKiRsyHiw+x1fttkH3vr8Z
         mshkOvJDJPKngzejd7mBUVfpeFObiE7DzzSKj7X+K3WTcpNLVH7YC9R58c7WwLznsgUt
         N0YaEhd2vFJAOOXkKrP9W+TwFxE6ss1ZvBrPej/6Mz5UWSNOcDtbFQK98gVeRA7KeI5y
         +Oux3reR96E32tnmEqZYHrbTqcCWH0MAGBocy1UOjeJsERGHTJRqb4qnej61EJ9zR1nz
         2x0xBOI9KuvVA3+WKgyRfjs5275jjw1HmOMF3ggMuSQo8fgJHoMJXZGqQViCAU9Se5gI
         EyfA==
X-Gm-Message-State: AOAM530M64yhrtY5TFw24l+yvKFGF/zvFUv+Wx9KIqP3jJYLoN7ayLpM
        tyHwNipZt8MghrSL1ieBSka1ZUyqnERD
X-Google-Smtp-Source: ABdhPJydqDU9trTSzGF2lQlLXcpGYuq+SC+E3cu1TKLfFjKlyIsuM9Os8lFt1NiyMbJBPkBOFV5kFQ==
X-Received: by 2002:a05:6870:516:b0:d7:16dc:cc7e with SMTP id j22-20020a056870051600b000d716dccc7emr6982491oao.167.1646147377714;
        Tue, 01 Mar 2022 07:09:37 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id b7-20020a056870918700b000d16208b7c4sm6019642oaf.15.2022.03.01.07.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 07:09:37 -0800 (PST)
Message-ID: <6b00c67b-01c9-bf22-a8e6-904f47fa7acf@github.com>
Date:   Tue, 1 Mar 2022 10:09:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] name-rev: use generation numbers if available
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
References: <20220228215025.325904-1-jacob.e.keller@intel.com>
 <20220228215025.325904-3-jacob.e.keller@intel.com>
 <xmqqpmn6wg98.fsf@gitster.g>
 <CA+P7+xoECs-rXb4vpRrw40Q-oRvfu97kMig9zu0rEE6KagAyiw@mail.gmail.com>
 <xmqqfso2t9cu.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqfso2t9cu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2022 2:33 AM, Junio C Hamano wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
> 
>> On Mon, Feb 28, 2022 at 6:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Jacob Keller <jacob.e.keller@intel.com> writes:
>>>
>>>> +test_expect_success 'name-rev without commitGraph does not handle non-monotonic timestamps' '
>>>> +     test_config -C non-monotonic core.commitGraph false &&
>>>> +     (
>>>> +             cd non-monotonic &&
>>>> +
>>>> +             rm -rf .git/info/commit-graph* &&
>>>> +
>>>> +             echo "main~3 undefined" >expect &&
>>>> +             git name-rev --tags main~3 >actual &&
>>>> +
>>>> +             test_cmp expect actual
>>>> +     )
>>>> +'
>>>
>>> I doubt it is wise to "test" that a program does _not_ produce a
>>> correct output, or even worse, it produces a particular wrong
>>> output.  This test, for example, casts in stone that any future
>>> optimization that does not depend on the commit-graph is forever
>>> prohibited.
>>>
>>> Just dropping the test would be fine, I would think.
>>
>> Stolee mentioned it. We could also convert it to a
>> "test_expect_failure" with the expected output too... But that makes
>> it look like something we'll fix
> 
> Neither sounds like a good idea anyway.  What we care most is with
> commit graph, the algorithm will not be fooled by skewed timestamps.

I'm fine with losing this test.

I perhaps lean too hard on "tests should document current behavior"
so we know when we are changing behavior, and the commit can justify
that change. For this one, we are really documenting that we have
an optimization that doesn't walk all commits based on the date of
the target commit. If we dropped that optimization accidentally,
then we have no test so far that verifies that we don't walk the
entire commit history with these name-rev queries.

If there is value in documenting that optimization, then a
comment before the test could describe that the output is not
desirable, but it's due to an optimization that we want to keep in
place.

Thanks,
-Stolee
