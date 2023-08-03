Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01D1C04A6A
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 13:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbjHCNJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 09:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjHCNIs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 09:08:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990504C34
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 06:07:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so881166f8f.1
        for <git@vger.kernel.org>; Thu, 03 Aug 2023 06:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691067965; x=1691672765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z7xyt8h1UpABawXQseTfYnoFuiwQktRRFbw0PBJiPTs=;
        b=RCHHFz1cp2iDmKcSfpMr1NHL+0Rlu7pPaPdNWf5japmPEPbQydpQLmylQvh/D5lB2q
         +ZMBvhympkXkQ0mhk2SPHMAWBA2xzwQFvV1V9NwVUTN3VwSo2pSlWWF0PzBTa/RFGIdX
         L4fOg4GgbPWVpu/pysrW8iaXUKZfRq/DBSEXnKElEBQNTyR+7j8vBcVLpleeRd5s8K4V
         mbj9PQhlkBdI3CEfsG2HfLnems0MA1LFwLeLAolk3T/UhIeSDcF6BbK2cBZLMcsB/7HS
         lz9DXAwfrmVMdHuI5uIIpqoQXnN8WDW6lCsQsdEB1390MchQH82IX+FbTieDilqcBIMR
         oUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691067965; x=1691672765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7xyt8h1UpABawXQseTfYnoFuiwQktRRFbw0PBJiPTs=;
        b=K/g5gXhivrK2rWEJa/PKW+7E3drE4uLc2MUw44Dr2nXLQQe7vmEG5LilUs1mf7lktF
         oT2UhZASV+7/4ODagkyR/u9V0PTskUw89x4tv2W6j1JE1cGEG6T+SJXLGEwbMZOWkz2x
         eJtID03eOBvX1qf56qwtBTMEOVGgzpIw+Ij2KEyU+YaL1WjWhDV4cV//lw/WBjGG5ECz
         cmg4bWx1H+qzXE8maGRTasvgXy7m5KRoaIVK3hBFPPZs7WMTOE05ToBUqX+QHy1BoLo4
         n5sy8DuXvn1+1O95U0rfrTGsEIyocors9WEe5MQzideM4v9GqITbIAMC2IuajIfeJgMm
         98nw==
X-Gm-Message-State: ABy/qLYf82k2SrBEiATaXYJgmHpuA80iuePV0uvBbV+UlvO8fyPrT4q6
        n6i53K/fOgI375hXL5kCWpA=
X-Google-Smtp-Source: APBJJlHfrMYFGu5BZiTaKS514N0FcDNpatTIgDymUR27+WNmKe3aPaENqjOxjd/HCSlwiDlJH5DMmg==
X-Received: by 2002:adf:fec4:0:b0:314:1aed:8f5f with SMTP id q4-20020adffec4000000b003141aed8f5fmr7434362wrs.34.1691067964618;
        Thu, 03 Aug 2023 06:06:04 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id s6-20020a1cf206000000b003fbb1a9586esm4260344wmc.15.2023.08.03.06.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 06:06:04 -0700 (PDT)
Message-ID: <ee2d639d-32b7-6c61-f01f-9f06b295fd99@gmail.com>
Date:   Thu, 3 Aug 2023 14:06:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/7] rebase -i: impove handling of failed commands
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
 <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
 <xmqq8rat6qou.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq8rat6qou.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/08/2023 23:10, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>    sequencer: factor out part of pick_commits()
>>    rebase: fix rewritten list for failed pick
>>    rebase --continue: refuse to commit after failed command
>>    rebase -i: fix adding failed command to the todo list
> 
> I'd really prefer to see the latter half of the series reviewed
> (both for the design and its implementation) by those who have more
> stake in the sequencer code than myself.

That would certainly be nice.

> I just noticed that we have a question on the last step left
> unanswered since the very initial iteration.
> 
> cf. https://lore.kernel.org/git/f05deb00-1bcd-9e05-739f-6a30d6d8cf3b@gmx.de/

Thanks, I'd forgotten about that.

Best Wishes

Phillip

