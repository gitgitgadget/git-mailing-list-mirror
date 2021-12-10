Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A2EC433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 13:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbhLJOBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 09:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238967AbhLJOBH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 09:01:07 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56281C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 05:57:32 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso9710592otr.2
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 05:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=G0Attc+H50WIytSB+HFLdXjYUp4PLFdqXNwxYGE45kU=;
        b=HOHBWXj2EDs1faYrDHRI14u/MeplqHnmDTDvY1UY+0RkM4JUV7iz/mKwrX3x2x43xM
         iUFYImLf+ZXmiZ0awtvFSySpWBjtFhCgBqHeiKojlM5+Dizv2Uc4jzWMJHiv3XhgPfrJ
         H1UTxzvUTmKqgP9OE/nv1a7Y0IvWhuA7H6QCe3TI79xxMLEChCeXDKatsieNAitOgCeI
         UOExlhfUlnR7VXTrn2/Hk+yPh0jRxCJY5nRCRlmtfiQ40JxoZiyTl+c7okXeMlFto7VL
         SV+BhOmO/KwuMicJsIMvM8+0HxcBSnmPbgnZKTumbjoW/RT87IFwgULfAPOhKyZousqT
         QGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G0Attc+H50WIytSB+HFLdXjYUp4PLFdqXNwxYGE45kU=;
        b=Bse97Nzxe9KE+OM8jMcszuZi2PKq5JEXYyxfeWJQBVb2O6WI+bvD0vF66loikJjWNT
         zsMZlcR4fmI4SwHB9VWuxBT/Rs7ddbT31sn0K9M+smqsUUZI4EZlmYrnJRquoWdOhczP
         hUhYR9bRy1MDCOwM16X/tVZmwAEQo7mxXDD5cVeh820bsgLKjHy89UEOcJ82AA33sXJ9
         grnzYff2eH08C6VGSeO1LsjeUrjQQg6evuSya5cZf/XYRsGnhbUKxs4ZRNa/hh+Tm5rn
         Xl2t0XZSjyjIJQEtrSXaUnSz1QIOgBMCiq91ZxXqgmi60bUBPmXIcLbXQ7jIet9IVGO6
         TfRg==
X-Gm-Message-State: AOAM5319Ra3ITfMMXyXvMzXc0h25FFOHUOWC0PhdN0w/udxtUjkdclT5
        GfrkqvmpNjH6CrIDzUBm1ZM=
X-Google-Smtp-Source: ABdhPJyH2yDoJlXUx9RU6CKcTx17XyfxZaVsy1VvjI4myH1Q+scwKiSlVCqJ+IhRw72ZZb+mMykEMQ==
X-Received: by 2002:a05:6830:1da:: with SMTP id r26mr11034360ota.73.1639144651518;
        Fri, 10 Dec 2021 05:57:31 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:38d4:1ef3:99bd:2950? ([2600:1700:e72:80a0:38d4:1ef3:99bd:2950])
        by smtp.gmail.com with ESMTPSA id t11sm533152otj.24.2021.12.10.05.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 05:57:31 -0800 (PST)
Message-ID: <745e79e3-521d-58bd-2ddf-1da4e0f6fe26@gmail.com>
Date:   Fri, 10 Dec 2021 08:57:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] ls-files: add --sparse option
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
 <e42c0feec94de0e4869cda1fc6b28bd7055774e3.1637077083.git.gitgitgadget@gmail.com>
 <211123.86h7c3wrg2.gmgdl@evledraar.gmail.com>
 <03a642fc-6310-1ea4-083e-9fe4530cf761@gmail.com>
 <CABPp-BGJJM757CoOPjP=XBK-cMMGJemaeruxXSN9TEGmk+NKvg@mail.gmail.com>
 <d1275b30-b9b0-a416-3300-9809d880eb55@gmail.com>
 <CABPp-BEyvkRdxJoJZcNF1VoQBcJajq1CVUrNTfHnHG433Q=cNQ@mail.gmail.com>
 <c8e22885-1759-d3d9-3944-2d70c70960e2@gmail.com>
 <211209.86v8zydjjl.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <211209.86v8zydjjl.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2021 7:50 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Dec 08 2021, Derrick Stolee wrote:
> 
>> On 12/8/2021 1:36 PM, Elijah Newren wrote:
>>> On Wed, Dec 8, 2021 at 10:23 AM Derrick Stolee <stolee@gmail.com> wrote:
>>>>
>>>> On 12/8/2021 12:04 PM, Elijah Newren wrote:
>>>>>
>>>>> This actually looks quite nice, though the magic '16' is kind of
>>>>> annoying.  Could we get rid of that -- perhaps using something to rip
>>>>> out the diff header, or using comm instead?
>>>>
>>>> What I really want is "remove the first two lines of this file"
>>>
>>> Is `tail -n +3` portable?  Looks like we have five uses of tail -n +N
>>> in the testsuite, so it should be okay to use.
>>
>> Ah, that's the magic incantation. Sounds good.
>>
>>>> but perhaps "tail -n $(wc -l expect)" would suffice to avoid a
>>>> magic number?
>>>
>>> That works too.
>>
>> If the "-n +X" syntax works, then I'll opt for that.
> 
> I think it should be per
> https://pubs.opengroup.org/onlinepubs/009695299/utilities/tail.html
> 
> But isn't that "diff -u" non-portable, per GIT_TEST_CMP. I.e. sometimes
> we'll fall back on "cmp" etc.

You're talking about this hunk, right?

if test -z "$GIT_TEST_CMP"
then
	if test -n "$GIT_TEST_CMP_USE_COPIED_CONTEXT"
	then
		GIT_TEST_CMP="$DIFF -c"
	else
		GIT_TEST_CMP="$DIFF -u"
	fi
fi

This only switches from "diff -u" to "diff -c" if the
GIT_TEST_CMP_USE_COPIED_CONTEXT variable is set, but it is not set
by default. Thus, we are using "diff -u" by default throughout.

Please let me know if I'm misreading this.

Thanks,
-Stolee
