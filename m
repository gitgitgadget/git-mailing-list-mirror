Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ED8C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 09:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKCJcY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 05:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKCJcX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 05:32:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715B6270B
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 02:32:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bs21so1739512wrb.4
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 02:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+RSbJniPdqj/6WRFKhJ/8zCk9hEO4WrDcmgLCC7VxqU=;
        b=UFnZEVY2n48gnO/slmVmBzjtL9wwe3nUtBK55EA2yjXoOEwd0/D8CF69nccNcsBMHU
         KwMAxeXo8xdXFVWbSuFGdghnnIvP9fxH6OJ3nzdMOP2Zxq6HMSme838XybTRy2kyW3O3
         BCmExUuwFI7JVTqAgoFr7U6lAHelXfdv3oB9oe1w4jjQxklIM58ZqcdoYnnVwe4QlfHU
         0ymiHTytl64Ddm0qApClTuoz9sk2QCfQfoGi1QDfrUtZfZC7OQEMMzv5nJRlhzt4H96i
         /W65BAwgedq3x6hEU+gOzcvRKTghTsdyLoVmEgoOdmzp4kqVZ2BXaZtmVW73gA7KtSlq
         TLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RSbJniPdqj/6WRFKhJ/8zCk9hEO4WrDcmgLCC7VxqU=;
        b=dNrfDeJpHWT8EnOeZ4IcwrYEv2pbg4jC8BZfuJLFiiC594+AFLt6FOjNWxp79nSURr
         spTfdSErjAYnqHtTMtdQdGt0FuJS9xr08qJxI9pQM0M3zHp9he62m6MoDrCGmNqA9ctZ
         M14KAIaoh/z33jUCX1MCTo40PDxN2fJvhaQ87pkDSdjl4JJL4a90q1b1+mt+V4F1vPtT
         3D47brAMPan+P5d2A6fn7Z9G0fBka/mvpRhJvp7HyfOtKj44UqBYl1pr4Ex/78ruzDl5
         1iXnUeJOjxmmKy6CFgdclxJf3mYVwcPspPLZf/J8b0I3Enc/kMQp6JauHP1RjxeSMKmb
         EcyQ==
X-Gm-Message-State: ACrzQf1UUJeU5O2RQlXFozcQv1a2Qpraq4PyMxf2QAxIggNgCUxy5nqg
        2T3MTGBJbr0OzttK/vF12zo=
X-Google-Smtp-Source: AMsMyM7qrc3Ss7uhnL4Q2bXxTl+TJHRWuiQq7hQ+L8YUVpjN1HAqMiNdNuiCMiIFcAkR8mplzvby0g==
X-Received: by 2002:a05:6000:2a7:b0:236:e8fe:5654 with SMTP id l7-20020a05600002a700b00236e8fe5654mr7469664wry.122.1667467940952;
        Thu, 03 Nov 2022 02:32:20 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c354200b003a5f3f5883dsm5080026wmq.17.2022.11.03.02.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 02:32:20 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <16a8a331-f012-7dae-de1e-f03da95ecb6e@dunelm.org.uk>
Date:   Thu, 3 Nov 2022 09:32:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: rebase -i --update-refs can lead to deletion of branches
Content-Language: en-US
To:     "herr.kaste" <herr.kaste@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CAFzd1+5F4zqQ1CNeY2xaaf0r__JmE4ECiBt5h5OdiJHbaE78VA@mail.gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAFzd1+5F4zqQ1CNeY2xaaf0r__JmE4ECiBt5h5OdiJHbaE78VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Caspar

On 20/10/2022 18:01, herr.kaste wrote:
> Hi,
> 
> I have the following:
> 
> While doing a
> 
> `$ git rebase --interactive  --update-refs X`
> 
> I *removed* the "update-ref" lines from the todo list.  The rebase runs
> as expected and prints e.g.
> 
> ```
> Successfully rebased and updated refs/heads/test.
> Updated the following refs with --update-refs:
> refs/heads/master
> refs/heads/permissive-interactive-rebase
> refs/heads/variable-annotations-meta-block
> ```
> 
> After that all refs have been removed/deleted.
> 
> ```
> $ git branch  --list
> * test
> ```
> 
> Now, I should just have not used `--update-refs` in the first place but anyway
> I decide late that I rather don't want to update "master" etc. and it should
> probably not delete the local refs.
> 
> Actually, I so love the new feature that I switched it *on* by default, and just
> wanted to overwrite the behavior in the todo editor.

Sorry for the slow reply, I'm afraid I still haven't found time to look 
at this. As far as I can remember deleting the "update-ref" lines should 
leave the ref unchanged. I've cc'd the author to see if they have any 
insight into what is going on

Best Wishes

Phillip


> Regards
> Caspar Duregger
