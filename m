Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3C8C54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 21:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiIHVGq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 17:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiIHVGo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 17:06:44 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C44F6BBB
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 14:06:44 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-127f5411b9cso16413203fac.4
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 14:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=6rD4kEfrANTm6QACEHHV+Fz+Wr2evVsqSmWCVlHCd5I=;
        b=Oezdy24OL26mTo+dMwdsX1gOIITWb+YMwhAp3+UAp8Up02CGqFFvfYVBeXF4rYHPxQ
         /4q7zomGtKPj6Ey5a44grE+0TnXk2+kNRv+t1HCWRBII0KyDn8j6TFLeoT7IIXwys9sX
         ucX3SkBSJKYlWZqpXbP/o3nldVJ+dxZqvCdNYhbFhDcRSLNd5SfvZ48NeWcmISJLpg9O
         d+z2G2J0Wxp5hYtUVYCFgpUnKiPM4aUoPppj2Q0UD8bkWZ5TF/X6iOxTW/RgJXU0vEr8
         BgsvN/L5Yp7i0L2euRbT+SxDPRduNart6YOjzKDWleJws/Yt3R6y5w7B4OXulrSMNbBH
         OZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6rD4kEfrANTm6QACEHHV+Fz+Wr2evVsqSmWCVlHCd5I=;
        b=xg2Kms64P9UqmKRP0je+jfBBI70lYJVUvRuR+xa2GlX1RZj5iexy8ruSenxU8KNSUV
         ag6cZDMT3uZy2v2XfVWwfg7+fao6rudUmr9qoXv3DjGwLxP4G0CJDmSyYpFiUo90AW8g
         9GZtrTgfPHhNT6v+uH54tCCLoLLj7EYPNY88zyagxWunsonhhXuOBNe9hV/uw+eu8fAu
         ZLtfe+9m77n7XoDFnU2GmPEV9BwiB4g3Z9OkAm5d+B7eEjc4dfR+Wq++x3Nu+/OLmCN4
         FbepS0DkkEjDAlh5O+zRclh+gWCX7dBgxCwhtQOemlKR5aqTOT11nKgexW0Wxk/B0MMJ
         y+Zg==
X-Gm-Message-State: ACgBeo3o3l/dBXAXZeiZSMpryUHWUKGLJJY9euc6gQejW4jw/8Zq9p94
        7NS13voUyKw6eVX57XMbr+HhRfa2iYM=
X-Google-Smtp-Source: AA6agR559zZQ6sz2mhI2rF/DJbbaLxflpHvmKchgZHI3JT0gaKDhOALNImKrHBBSz5/ziLLvp0GR+A==
X-Received: by 2002:a05:6870:2482:b0:101:52cf:d099 with SMTP id s2-20020a056870248200b0010152cfd099mr3198496oaq.44.1662671203410;
        Thu, 08 Sep 2022 14:06:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:5a60:7720:22:ee9f:44ce:2cf1? ([2600:1700:5a60:7720:22:ee9f:44ce:2cf1])
        by smtp.gmail.com with ESMTPSA id m1-20020a05680806c100b00344cc0c4606sm7984033oih.58.2022.09.08.14.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 14:06:43 -0700 (PDT)
Message-ID: <f7f54032-df51-87f1-dc14-02632ec37cb7@gmail.com>
Date:   Thu, 8 Sep 2022 14:06:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 3/3] builtin/grep.c: walking tree instead of expanding
 index with --sparse
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Cc:     vdye@github.com, git@vger.kernel.org
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-4-shaoxuan.yuan02@gmail.com>
 <xmqqczc5rblr.fsf@gitster.g>
 <093827ae-41ef-5f7c-7829-647536ce1305@github.com>
 <xmqqo7vpoaan.fsf@gitster.g>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <xmqqo7vpoaan.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/8/2022 1:56 PM, Junio C Hamano wrote:
>> Shaoxuan's comment is attempting to list the reasons why submodules
>> do not currently work with sparse-index,
> 
> "do not currently work" in a sense that it produces wrong result, or
> it just expands in-core index unnecessarily before applying pathspec
> to produce the right result in an inefficient way?

It's the latter situation. It expands the index inefficiently though,
the results are correct. The other problem is that, there is no sparse
directories in an expanded index, thus we cannot test how does the
grep_tree() approach (introduced in the third patch) work within submodules.
