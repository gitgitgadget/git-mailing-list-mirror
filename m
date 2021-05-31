Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579FBC4708F
	for <git@archiver.kernel.org>; Mon, 31 May 2021 07:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F4F60FE9
	for <git@archiver.kernel.org>; Mon, 31 May 2021 07:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhEaHzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 03:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhEaHyz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 03:54:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2125C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 00:53:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so1490705pjq.3
        for <git@vger.kernel.org>; Mon, 31 May 2021 00:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kQOhrnkOFLjtj05XWu1i43zS1QPJed8wLetR93Us8Yw=;
        b=gTrYloJnWxa1BFHJvX4n9LAT1I5sbsDoI+sdkQw4R/CG7f5h71pGQA274LA4QOy0mo
         zeLmC8GoHZdfMh5xDVBn4HJAAaE18ucZXGyiAqcPRyOHpzcskJVbWUD/Ewidmgu+GvaT
         RMBvFBKguI/H1LpO4IvhZw31h4DlFz5bNEcEzbF6Kmn9UEEo9uPampIbe3XzIbx+qZSR
         rTpXKYfp79GCGPAbhdcrMdeXVYlpQszA2GFlGGoow67FhZad26SE2ghXRYCA9JjZ37Iq
         gNc0WsELWG7tOHngJZbOGpLqb6bWU1wULrrtFZnDVgy9OVWGeFgCaYDhpuXmvnd6Ix64
         +YZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kQOhrnkOFLjtj05XWu1i43zS1QPJed8wLetR93Us8Yw=;
        b=fSGnQtfctK6xlsX2fcT4pgF4B1lHEcCO+iimuq7/8WBGrAAYZ4DLh5KQ8qWLUlg3YN
         8tTAcvOrjQU6MqotikkM02TMkBtw9gxQlVLBy4EYMYJEPD9NisQ+ctYs1fxFP/57ICyu
         wYzer9XUdhbOra7l9QZge9L8zNKlEG/nBpTTMfGWAyH/2JWHZAq4lzIoph/x7OhpeBhO
         9c9ofON/Vp+fz6cOZFt8gI86H6EnOaEYFXapsa9tXbhF5B7/Cgqf+AZwkIqsnmkWncQm
         qcMdwEr+U7IaSQ+9V1im0wN2iSN0prRT2STXVBn4JRWHxWJ/GtnRzHYiKOT5G0y0BDfS
         Gp8w==
X-Gm-Message-State: AOAM533qvDe5AG5t/E9JaKYf+gtYr510+VnI7oNstfBigKX28oe9HhEO
        9mSTWIVlL14znxTUPzU3xdakQjBhGdZEIg==
X-Google-Smtp-Source: ABdhPJxxphdPWj/505Rw8HF1A4FHgAomAOxB6gXMa4SHgZ8REIMVPSnMCuttskI+fPyP4/WnTiyDZg==
X-Received: by 2002:a17:902:9b8b:b029:ee:bb74:7d46 with SMTP id y11-20020a1709029b8bb02900eebb747d46mr19463386plp.65.1622447594215;
        Mon, 31 May 2021 00:53:14 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-67.three.co.id. [180.214.233.67])
        by smtp.gmail.com with ESMTPSA id c190sm1558898pfc.26.2021.05.31.00.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 00:53:13 -0700 (PDT)
Subject: Re: [BUG] gitk error - can't read "arcnos()": no such element in
 array
To:     Chris Packham <judge.packham@gmail.com>
Cc:     GIT <git@vger.kernel.org>
References: <CAFOYHZBAg7pkise8bir7Z3qApw9mJB8Z99p6z71-_T6=7rFV7w@mail.gmail.com>
 <CAFOYHZAfQivHvs5=hGt-A1CbtwW-iJSwC1iFk7FY3wnNcVNVrQ@mail.gmail.com>
 <aa18c448-9a74-0837-a2bb-008aab31f0e4@gmail.com>
 <CAFOYHZA4xbnWc1d1zK-fjoDHZntQj7weDZk1r=SOJxVtKD4aOA@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <d919f68e-42a9-bd74-c16e-8d2c185b6938@gmail.com>
Date:   Mon, 31 May 2021 14:53:11 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAFOYHZA4xbnWc1d1zK-fjoDHZntQj7weDZk1r=SOJxVtKD4aOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/05/21 14.38, Chris Packham wrote:
>> Is your problematic repo public? If so, we can test against that.
>>
> 
> Unfortunately not. It's actually an internal kernel tree which has a
> different root to upstream (hence using git replace to attach upstream).
> All of which make the history a bit funky.
> 
> I don't know if the problem will survive anonymisation but I can try.
> 

Did you mean vendor kernel tree based on Linux kernel? I think you can 
try reproducing the issue with either Linus' tree [1] (mainline only) or 
Greg's stable tree [2] (mainline + release branches and tags).

[1]: https://github.com/torvalds/linux
[2]: https://github.com/gregkh/linux

-- 
An old man doll... just what I always wanted! - Clara
