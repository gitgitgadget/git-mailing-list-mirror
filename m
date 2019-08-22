Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A33B1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 16:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbfHVQvt (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 12:51:49 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45904 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730719AbfHVQvt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 12:51:49 -0400
Received: by mail-qk1-f196.google.com with SMTP id m2so5723348qki.12
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 09:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EDHi/vJwJWrPsyHEOt8yTQ0gXin4Z3as7pO7SRKNLBo=;
        b=Xxvd8WDVJaU3ptkcpSG03RhDG/XDMicJULu5fnH2arszdUKLbBYjrJFhsJHmEnB+i5
         xOcn96g4Omsmw/taySPGj4Pu7C3/jSKNv2hmVBp2cUkP4ndbmQKjbvwJozFc6LhBG/To
         bYRnlhsdq3NkCBdhUMegX8faJHWY2Ct4v9CPE7LyBPYoP09sMV8d29WEe5kjneyP4Soa
         jkY69d5lVpagjB9L6sPQOtU2CGuCVHwJTOOi/i6ScF6WD6Du87+Ot7dja2mz+RWDCklm
         qq40Ts2tVRG5/J9J+CX0GR5StsF162i7+MBu4XWRzpVqxgftBe6KyRmT79f5IBnvpmdO
         SEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EDHi/vJwJWrPsyHEOt8yTQ0gXin4Z3as7pO7SRKNLBo=;
        b=B8m865kuBNkc4KgeuzYi7t5NMaChyvNCw7VSjmnWL+zrBDTwdCOOndMXqIcy9pT+Cv
         ZmqwclN0r+EyQBebLbT1qmEzFh+GEGuRfETZmJksYtFf3jkGjRd8GI0e2eUmv1drcxDi
         22TFh9puU5O9BzgOddRn3GgReJFjvmRC752tsC00ho/4z8P2uq2XgbelCUvc2birWcsh
         A12xpz4jloIolAjxKXz0e+rXggSLQKm2muzeQix3XyAIxbO6h1YCfB1NFeGoheKmL0A+
         MhC1m7gZJ9VNarFjHYMGbQyAnmauxgtK5CFMc5VALwrEUB/GHUeVCIq2GA05v6kED3i0
         3Naw==
X-Gm-Message-State: APjAAAXLv7c1q6Yli8G5QGgX8F2kqC6P599Q6m64WIk+64jDRwOY5aZ8
        +00qxTEHYRS68bwZCnqmDDw=
X-Google-Smtp-Source: APXvYqz3i3E/7nVo4nDXagTuHBV+HaCrMxmyfxB8TEDvKyfq2Joous70hx0IpxAH0rSkNfg9lIRv3Q==
X-Received: by 2002:a05:620a:6c3:: with SMTP id 3mr25945151qky.379.1566492708392;
        Thu, 22 Aug 2019 09:51:48 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7dcd:416c:c779:cf77? ([2001:4898:a800:1012:2f01:416c:c779:cf77])
        by smtp.gmail.com with ESMTPSA id q42sm45775qtc.52.2019.08.22.09.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 09:51:47 -0700 (PDT)
Subject: Re: [PATCH 2/2] line-log: avoid unnecessary full tree diffs
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>
References: <20190821110424.18184-1-szeder.dev@gmail.com>
 <20190821110424.18184-3-szeder.dev@gmail.com>
 <e52e867b-af17-d239-11b5-e0c6353acc2f@gmail.com>
 <20190821173515.GY20404@szeder.dev> <20190822084158.GC20404@szeder.dev>
 <xmqq7e75qjdj.fsf@gitster-ct.c.googlers.com>
 <20190822162656.GE20404@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <09b86c6c-234e-f6e9-c0c7-a810b8214bcf@gmail.com>
Date:   Thu, 22 Aug 2019 12:51:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190822162656.GE20404@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/22/2019 12:26 PM, SZEDER Gábor wrote:
> On Thu, Aug 22, 2019 at 09:01:44AM -0700, Junio C Hamano wrote:
>> SZEDER Gábor <szeder.dev@gmail.com> writes:
>>
>>> Well, that fruit hung much lower than I though, just look at the size
>>> of the WIP patch below.  I just hope that there are no unexpected
>>> surprises, but FWIW it produces the exact same output for all files up
>>> to 't/t5515' in v2.23.0 as the previous patch.
>>>
>>> Can't wait to see how it fares with that evil Windows path :)
>>>
>>>   --- >8 ---
>>>
>>> Subject: [PATCH 3/2] WIP line-log: stop diff-ing after first TREESAME merge parent
>>
>> A quick question.  That we need "stop diffing after first treesame"
>> patch in the first place means we have always been attempting to
>> follow all the parents of a merge?
> 
> To follow, no.
> 
> But there are two subsequent loops: the first loop computed the diffs
> between the merge and each of its parents, while the second processed
> those diffs, and returned as soon as it found a treesame parent,
> without following the others.
> 
> This patch unified those two loops so it computes the diff with the
> first parent, and then processes that diff right away, and returns if
> treesame, thereby avoding diffing the remaining parents.

The change you've proposed could be made a bit better in the following
way: first look for a treesame parent by computing the diffs without
rename detection. Re-enable rename detection only if no treesame parent
is found.

That would be sure to avoid the rename detection even if the merge has
a treesame second parent.

Thanks,
-Stolee

