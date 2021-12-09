Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A0BC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 10:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhLIKnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 05:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhLIKnH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 05:43:07 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A740C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 02:39:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q3so8895634wru.5
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 02:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WvrmyVB0jd4XX3t9k45pxXUdASPYSaeIIQMBeMyV37o=;
        b=G20TUzBfiKEJZNSOYm8feBz7zag/Hy2VOd7dYjqDSR3RyjwIDf9TAPIH5rnW4X7yRE
         2p7+L7Ogucd+0x306QOVh5SqtNcMuixW9XXjBx2/CE6oEcB3647DTAV/3s34QD6HYdXs
         weQj+fBbhiIsr6yUFloJ6y6c/kLdzqgfyh20ilFB+E30QTOGOVrxYz7HvYzGsBGi+PLu
         pvPHzAi+EGtEg4C6u/V3romWUQRrRO0hx1l8mgwjgW/IzbELGuO7UmkqhM3rsQ2SKuN0
         6I2QZ19u6djh72IyOyiyN2F5oTMR3LDxFhiJcR5mzCBTOGSWRxnLrq1ExckcMnB6Ln3H
         2CFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WvrmyVB0jd4XX3t9k45pxXUdASPYSaeIIQMBeMyV37o=;
        b=KrzsUEIa77UalsHkaF/6qMnksiS3S6L6syAD5fTk3qjeK5stUspQQAIXtD+XLxGJHs
         SzVZWkx5RG9z5OJsJ/HHl6JPeXRzljbB6zt0fggU5tiY1buH2SgFbsAfuv+AQ5w486YQ
         Jb1HWwwqlWBWFi+V1+Wzkt1dzw3znCrcW7gwP3DsExUyUR1m+TFLEJRe26RwxvbdR3Ja
         ivqPEkzAgK6Fs+nmq+yGMPbiuyFleXqD1ZejI6qXBH+2JquXu8XWwg2bQT4ymcFGV6Xk
         4UwU975G9WhYrinTrJyl9ea2/TDysKYNPumVE60Usgu7CgunC9u9lzuuP0LjARtv2DhP
         Q6/w==
X-Gm-Message-State: AOAM531BoABCXshYlmiI76byqCz5iSIBjVUi9LY/93Auf81Kjh/Wlwdq
        QJVqrZAfSHI0v5G5yzOANgc=
X-Google-Smtp-Source: ABdhPJzrkFyqk4MyLHy4IgpnnceiNaHZmr76Ai2cYGNkFPfPcI+eRmDWI+mzsWCt5LdALFlBojPewQ==
X-Received: by 2002:adf:f151:: with SMTP id y17mr5517505wro.153.1639046372971;
        Thu, 09 Dec 2021 02:39:32 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id f15sm6534944wmg.30.2021.12.09.02.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 02:39:32 -0800 (PST)
Message-ID: <4dc6e1ee-bbbb-247b-f9e7-4f8dd37c57ed@gmail.com>
Date:   Thu, 9 Dec 2021 10:39:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Dec 2021, #01; Fri, 3)
Content-Language: en-GB-large
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqh7bpqhf0.fsf@gitster.g>
 <e1aadd47-533c-fd8b-4fae-f64a53c81ec9@gmail.com>
 <nycvar.QRO.7.76.6.2112081340420.90@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <nycvar.QRO.7.76.6.2112081340420.90@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 08/12/2021 12:42, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Mon, 6 Dec 2021, Phillip Wood wrote:
> 
>> On 04/12/2021 01:37, Junio C Hamano wrote:
>>
>>> * pw/diff-color-moved-fix (2021-10-27) 15 commits
>>>    - diff --color-moved: intern strings
>>>    - diff: use designated initializers for emitted_diff_symbol
>>>    - diff --color-moved-ws=allow-indentation-change: improve hash lookups
>>>    - diff --color-moved: stop clearing potential moved blocks
>>>    - diff --color-moved: shrink potential moved blocks as we go
>>>    - diff --color-moved: unify moved block growth functions
>>>    - diff --color-moved: call comparison function directly
>>>    - diff --color-moved-ws=allow-indentation-change: simplify and optimize
>>>    - diff: simplify allow-indentation-change delta calculation
>>>    - diff --color-moved: avoid false short line matches and bad zerba
>>>    coloring
>>>    - diff --color-moved=zebra: fix alternate coloring
>>>    - diff --color-moved: rewind when discarding pmb
>>>    - diff --color-moved: factor out function
>>>    - diff --color-moved: clear all flags on blocks that are too short
>>>    - diff --color-moved: add perf tests
>>>
>>>    Long-overdue correctness and performance update to "diff
>>>    --color-moved" feature.
>>>
>>>    Need to pick up the reroll before merging to 'next'.
>>>    cf. <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
>>
>> Dscho spotted a typo which I was going to correct with a re-roll but I've been
>> holding off in case he has time to read the rest of the series.
> 
> I would have loved to give this a much more in-depth review, but the days
> have become short on the North hemisphere, haven't they.

I know, it felt like it never got light here yesterday.

> In any case, the patch series looks good to me (personally, I do not care
> so much about typos as long as they aren't indicator of sloppiness, which
> in this case they aren't, I find your patches really well done).

I've just posted v5 with the typo fixed, thanks for your comments.

Phillip
