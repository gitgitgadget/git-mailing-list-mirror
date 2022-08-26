Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5D3ECAAD4
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 23:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345436AbiHZXPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 19:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiHZXPp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 19:15:45 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE14D51C7
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 16:15:43 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id a4so2379534qto.10
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 16:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=LCDAaxgpU2mu0gGI8EH2qbPCiCxwgWMRpRBfDV40T5I=;
        b=VdnP3gsznv/9fedEEvClfwPOfD2YJrnhb05AOWzjq8tLl/n69QUxHti1/JmwqXX6Aa
         19+p3xmF/WrdqdVwJdklzECtVhqjnVjvOaCtiNiadTzAi0wMriuXUUxjXjlg1p52Z+nx
         BMrc+yEAFF7izb8r/0dRhmxHD9h1TJKHWTvsNaP7fEzaYMYxlLYR8X7NjuWJxeBqAIN6
         efVnKqalPvhA5uvTNbYoQk1/dl4b5TLoP2kOY4aAFgqufMYro/mpXbOjl6IPQFvs6wUS
         Xv+9NJkiuI2871aSQ0vvdod9V5NJPa6PtN5F2JAXdFIZul0SVqvJRTxbl0m94L/sf42v
         sp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=LCDAaxgpU2mu0gGI8EH2qbPCiCxwgWMRpRBfDV40T5I=;
        b=vatUrPIDRpZqei1J7cVhddL1HnMP1Rrd3yH4oyAn+lvJwp0xayzbUkXjhXUTIp4fWa
         J1SsuKMS4D4mT4lNuzdLecdonnJepmSnHe5X/1QTM+4ddLaub0kTjY8edRO/mFAHE/jv
         2KkfVcvp0Lqk3OFP5eBOCjmDjzDmbKfbWC+UkyL3ZBPQmpI6c1xKs7rFJ2DPZZKU+i0J
         cAVwz9r1Vq/clP+q1zlP/EcrDQHr8CEeByOgwVLQgJH9WCJHPE4dWTrchsVuG45Vbc2B
         2ME+KPyzRekfJ/wXQVi5hgZKZDCymCUlTSPdcEBNk0T3mtzlTQ79ukvgVYW3RkaMlm2D
         gW1Q==
X-Gm-Message-State: ACgBeo1bYcNY2wlBzzr1KLd8OrPshm5jHG91w+pO+VXrA38fG9cfSA6l
        92y2aTu9Dumxijt/+Cza8/5FWVxIkIA=
X-Google-Smtp-Source: AA6agR5V1L/n4w/qePQz5zU1OnPfzJT8nKYETPfasqF/+G0fxzEz+H5YVkJGg2/f17GPA1FLwpLKFQ==
X-Received: by 2002:a05:622a:178e:b0:344:56a8:25da with SMTP id s14-20020a05622a178e00b0034456a825damr1619967qtk.375.1661555741976;
        Fri, 26 Aug 2022 16:15:41 -0700 (PDT)
Received: from [192.168.1.128] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id r6-20020a05620a298600b006b98315c6fbsm874267qkp.1.2022.08.26.16.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 16:15:41 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] built-in add -p: support diff-so-fancy better
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
 <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
 <241d3760-5b7a-fb3e-00dc-bf54bda92c82@gmail.com>
 <818s0453-677s-sos7-24r2-qq66o4r81r4q@tzk.qr>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <a9a6c73c-65d5-795e-6830-a543c2513941@gmail.com>
Date:   Fri, 26 Aug 2022 19:15:40 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <818s0453-677s-sos7-24r2-qq66o4r81r4q@tzk.qr>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Le 2022-08-26 à 07:43, Johannes Schindelin a écrit :
> Hi Philippe,
> 
> On Wed, 24 Aug 2022, Philippe Blain wrote:
> 
>> Le 2022-08-24 à 17:21, Johannes Schindelin via GitGitGadget a écrit :
>>> Philippe Blain reported in
>>> https://lore.kernel.org/git/ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com
>>> that there is a problem when running the built-in version of git add -p with
>>> diff-so-fancy [https://github.com/so-fancy/diff-so-fancy] as diff colorizer.
>>> The symptom is this:
>>>
>>>     error: could not parse colored hunk header '?[36m?[1m?[38;5;13m@ file:1 @?[1m?[0m'
>>>
>>>
>>> This patch series addresses that and should fix
>>> https://github.com/so-fancy/diff-so-fancy/issues/437
>>>
>>> Changes since v1:
>>>
>>>  * Added a commit to ignore dirty submodules just like the Perl version
>>>    does.
>>>
>>> Johannes Schindelin (4):
>>>   t3701: redefine what is "bogus" output of a diff filter
>>>   add -p: gracefully ignore unparseable hunk headers in colored diffs
>>>   add -p: handle `diff-so-fancy`'s hunk headers better
>>>   add -p: ignore dirty submodules
>>>
>>>  add-patch.c                | 24 ++++++++++++++----------
>>>  t/t3701-add-interactive.sh | 24 +++++++++++++++++++++++-
>>>  2 files changed, 37 insertions(+), 11 deletions(-)
>>>
>>>
>>> base-commit: 795ea8776befc95ea2becd8020c7a284677b4161
>>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1336%2Fdscho%2Fdiff-so-fancy-v2
>>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1336/dscho/diff-so-fancy-v2
>>> Pull-Request: https://github.com/gitgitgadget/git/pull/1336
>>>
>>> Range-diff vs v1:
>>>
>>>  1:  74ab50eeb1c = 1:  74ab50eeb1c t3701: redefine what is "bogus" output of a diff filter
>>>  2:  b07f85a0359 = 2:  b07f85a0359 add -p: gracefully ignore unparseable hunk headers in colored diffs
>>>  3:  9dac9f74d2e = 3:  9dac9f74d2e add -p: handle `diff-so-fancy`'s hunk headers better
>>>  -:  ----------- > 4:  540ce27c38a add -p: ignore dirty submodules
>>>
>>
>> Thanks, 4/4 fixes the mismatched output bug. Just after I sent my last email,
>> I asked myself "but why does 'git add -p' presents dirty submodule to the user,
>> as they can't be staged?" :)
>>
>> A small question about 2/4, any reason why you did not use a "Reported-by:"
>> trailer ? Not that I care that much, but I think using such a trailer is more
>> standard, and makes for easier statistics as it's more parseable :)
> 
> Good suggestion.
> 
> How about adding your review? I'll then add a "Reviewed-by:" trailer, too
> ;-)

I won't have time to look at the code changes themselves, and I've never looked 
at the builtin add -p code (nor the original Perl one!) so it would take some time.

Cheers,
Philippe.
