Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19DBC433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 17:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiJNRyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 13:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJNRyn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 13:54:43 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6246C12D2F
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 10:54:41 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id o13so2899600ilc.7
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 10:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cqi3sr8+olGXy+3mj18HhZkh66RqmvTij+obGlw0LSs=;
        b=ZQH/iXwklgBCiePNNrDzrH8gdG46CmQVmOaMCjsS9W4iTfXjhYj3pTUyjdoVQzu3Yk
         AKT462ZesUiULPmIqN/IWBknaedGf9gG30ldzuhtTr8qOluo5wn7aZO/zU2tR/WRsvFD
         gjEGLktLpspvn1av68L2JRJb1Zd19X/Z5aNb0W2cf9nt4RqjndxxxztLARbnSXwHFrWt
         A2G5wmck3MlczqI627dqppNa2hw/xEKIys1oS1qAXdssAYN6x5QXbJ8azjdp7gSNwBg+
         mzjdLGueCDr3kp5usN7nQaoPHmuZEIEVCVf5o3zYiHTiiPfyIvI1DBfsymPfdJijQdQ6
         lpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqi3sr8+olGXy+3mj18HhZkh66RqmvTij+obGlw0LSs=;
        b=s7h3N5Brkm7F21bbWthSjWSrM5ASd6iJETVT96U/UKSaedfG2uDuC5iW42sLMHZRMZ
         nMbwqlTtjWNC+LPvUdw1cCrK2E4LPKQC7jo/w05Tjr0xJTGTAW/zoWB5PksvfxOy7k8+
         TfBgmobjQVmS/8H3aBzJWKY45o3eExL8VnjSTGIgTrHbodZ1xOGTwoIvPu0Z5X2qZqVj
         psfJYU3l0UAvF1g3p6/X16hCits01XW7e+tjuas83nSHlHai15JtPxOiyLNW8U8Ro50F
         31DT/2ZIFZdynmRw6wjuGSIWpIJnzabvwV9F2KKHeCd5RwqVkvixlIIv7fCb725A8M8l
         h2Rg==
X-Gm-Message-State: ACrzQf1cgWf1Rg/wsGAYjDmBRcI6Y2aGLOMJyOabonoTam4+sv/osva1
        tGYQ854QTt6ZjKAWNGNL7/Zj
X-Google-Smtp-Source: AMsMyM7PwpyLqCYSb2wwRfzdcpErtOrZHMbuL3r+s15YjM9XDiycPQerE87BvqmpiENDrnWxfuUGVA==
X-Received: by 2002:a92:cccc:0:b0:2fc:cc40:6a7 with SMTP id u12-20020a92cccc000000b002fccc4006a7mr3096192ilq.68.1665770080716;
        Fri, 14 Oct 2022 10:54:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8c47:21b5:c860:3399? ([2600:1700:e72:80a0:8c47:21b5:c860:3399])
        by smtp.gmail.com with ESMTPSA id e6-20020a056602044600b006bc0f8e18d4sm1157066iov.34.2022.10.14.10.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 10:54:40 -0700 (PDT)
Message-ID: <cc0a6adb-d894-77b3-2a65-9042237c07b5@github.com>
Date:   Fri, 14 Oct 2022 13:54:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3] [OUTREACHY] t1002: modernize outdated conditional
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        nsengaw4c via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, nsengaw4c <nsengiyumvawilberforce@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
References: <pull.1362.v2.git.git.1665733647421.gitgitgadget@gmail.com>
 <pull.1362.v3.git.git.1665734502591.gitgitgadget@gmail.com>
 <xmqqv8om9yaz.fsf@gitster.g>
 <f064ce46-8ed0-a9c1-8df5-5c258677d95f@github.com>
 <CAPig+cT=bJ7BP9CDh5-oYYF376vVxsh7E0UAE_QN0wfAgR3AAg@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAPig+cT=bJ7BP9CDh5-oYYF376vVxsh7E0UAE_QN0wfAgR3AAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/14/2022 12:58 PM, Eric Sunshine wrote:
> On Fri, Oct 14, 2022 at 12:35 PM Derrick Stolee
> <derrickstolee@github.com> wrote:
>> On 10/14/2022 12:15 PM, Junio C Hamano wrote:
>>> "nsengaw4c via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>> Cc: Christian Couder  <christian.couder@gmail.com>
>>>> Cc: Hariom Verma <hariom18599@gmail.com>
>>>
>>> What are these C: lines for?  I do not think the message I am
>>> responding to is Cc'ed to them.  There may be a special incantation
>>> to tell GitGitGadget to Cc to certain folks, but adding Cc: to the
>>> log message trailer like this does not seem to be it---at least it
>>> appears that it did not work that way.
>>
>> GitGitGadget will read the "cc:" lines from the end of the pull request
>> description, not the commit messages. I'm pretty sure they will be
>> ignored if there are other lines after them.
> 
> For Wilberforce's edification for future submissions, presumably the
> reason that the CC: in the pull-request's description didn't work is
> because the CC: line wasn't the last line in the description? Does
> there need to be a blank line before the CC: line? Is it okay to list
> multiple people on the same CC: line as done in this case, or is that
> also a problem?

Looking at the PR (https://github.com/git/git/pull/1362) it seems
there was no "cc:" lines in the PR description (until GitGitGadget
added them due to our replies).

Nsengiyumva: you'll want to be careful to edit your pull request
description on GitHub before running the "/submit" chatop. Your
current description has a paste of your commit message followed by
the contributing template. The pull request description becomes
your cover letter (in the case of multiple patches) or a commentary
section after the commit message (in this case of a single patch).

The description is a good place to say things like "I started
working on this because of a mailing list thread..." or "I'm not
sure if I've tested everything enough".

The "cc:" lines should _not_ be in the commit message at all, which
is what's visible in the patch.

Thanks,
-Stolee
