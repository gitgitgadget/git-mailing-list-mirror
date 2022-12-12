Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797B7C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 14:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiLLOKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 09:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiLLOKP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 09:10:15 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2167AC38
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 06:10:14 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id g7so8999441qts.1
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 06:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m04tHu8sj3vfe3Kg5uaI+/yh2yeE9b3JtxTLWKD/Abk=;
        b=A+8oWFTS6h4xzd4JiAKf5RxIkThJdgkZuOrBcmEvwa+Tvk4NVWcw0Gz/r8qozss2Fn
         gsdmCgQTYbYhVBlq+3rIojZLJh8EW3qi2IPYWdOoIlKNU0WhM3mn4b3lqnwtJFIs7GXS
         wc6AhMW/FB3fcvkiShQCv2q2m/TMgySVi11YXk3hNcOHXmgGYkQLnh7OqpDkiZb+FyyT
         7gDr2WAhctVZYT/+Hg1qBizAf9iNFuS9gZh0iBpEeMDHdfGOvwuBQMF80B0P3zZq0HYZ
         E9XMIDse+It2httkfvL77BNAHM1cLiXLeqfL8zNzE2Utkvt6nYbaC5++mhgluPS8qqq3
         eGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m04tHu8sj3vfe3Kg5uaI+/yh2yeE9b3JtxTLWKD/Abk=;
        b=X4EPl0whfYs+Dl7Lzo1LHuMFaw8H2gH3lz7zh4Ycqgvr+xMb/FmydUaVtJo53ogiHJ
         EcxYYnNEDZd6ILpXYhHKcxEh+xSwTSjBODs4fkS7F6yxNBFR1eUTiDY7XJA39twDPeMM
         EkAC4ty1WEDY3MVbaeT7eApHuvQW9gH0yqCxHtz3oxk6FKWm5A+yshCY5KwsM5QtbprQ
         twJcRk+hF0liOLqgsLcNSKz1duR7ZdpEUNROVztfY9mZ0xoGkmzNnovRg/aNUJszJZcE
         nRA2+sN+SxfmRRvrDp639f1u6OlKMMGkrAY1qp9Xz38RIrDsEXIUqWwE/YP8iRgsnFOQ
         sxkw==
X-Gm-Message-State: ANoB5pknOiBGXJjtpDZvYu7KJf7935Xv4ZeaJl8Y6B24gZnMlfZHhWi7
        XMehxrdrXBd7qJl3gg+FDDLY
X-Google-Smtp-Source: AA0mqf5qDGf3CogPu9fJ3MzJJp22fb1al1V8yBKhYAQTB+pkJxm13VAKsZ6pT0qJx5Hn+LtpAV3GxQ==
X-Received: by 2002:a05:622a:5a87:b0:3a6:8f41:a5bd with SMTP id fz7-20020a05622a5a8700b003a68f41a5bdmr21722029qtb.62.1670854214015;
        Mon, 12 Dec 2022 06:10:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:84c8:9ef9:1297:e16e? ([2600:1700:e72:80a0:84c8:9ef9:1297:e16e])
        by smtp.gmail.com with ESMTPSA id c12-20020ac8518c000000b003a69c77eb1asm5783765qtn.34.2022.12.12.06.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 06:10:13 -0800 (PST)
Message-ID: <95b8bca3-51fc-7cbc-aa06-5de8b01e7021@github.com>
Date:   Mon, 12 Dec 2022 09:10:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/4] test-lib-functions: add helper for trailing hash
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        newren@gmail.com
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
 <a20bf8de8645c19a02838d70a7c2c3b00378a50d.1670433958.git.gitgitgadget@gmail.com>
 <221207.86zgby97bk.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <221207.86zgby97bk.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/7/2022 5:27 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Dec 07 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>> [...]
>> +# Given a filename, extract its trailing hash as a hex string
>> +test_trailing_hash () {
>> +	local file="$1" &&
>> +	tail -c $(test_oid rawsz) "$file" | \
>> +		test-tool hexdump | \
> 
> You don't need the "\"'s here.

Thanks.
 
>> +		sed "s/ //g"
>> +}
> 
> At the end of this series we have one test file using this
> test_trailing_hash, can't we just add it to t1600-index.sh?

I imagine that it would be helpful to access the trailing hash
for testing other file formats in the future. It certainly
could have helped the incremental commit-graph work, so we
could check that the filenames do match the trailing hashes.

Thanks,
-Stolee
