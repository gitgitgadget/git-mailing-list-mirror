Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02042C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 13:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244490AbiCWNu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 09:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244484AbiCWNuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 09:50:25 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A075B377E4
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 06:48:56 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id j83so1668272oih.6
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 06:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZkUXpO18nOi+lG6QN3nYhOHoG/16SQ4Q2WUgYQkafSI=;
        b=KzQephY62Fd+5hirmaV4bJtRfHAEyDYeRmAtQRLkmAQlRvnZlfa7u2CvqMwNHLcpPs
         8X3doBnHlmpXAosjDH19ZeSu/kPinP6aChnCWn1KSh8dpv8XXUzV4J4WyiDH+G+SVg9S
         6KtBycYAWVusJfDjoUQ6M3Bnetg+zf4FABbm82YH6JuKVM1a8HFVgiMucj4yDepXkj3l
         Fpodrhhnr/YvhZMdyGH/8sy2Iv5M3xstnjA2jYe/Y2v56FHjAs5aLmlby1NegYXjNMVl
         emLTG5FNnrgjvjosGA0ftnqc6xDO528BpvLelx85IYrvsRDhLaitI3zx3WsegaPtTJ3Y
         8SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZkUXpO18nOi+lG6QN3nYhOHoG/16SQ4Q2WUgYQkafSI=;
        b=c/ZEPXvW4dmbLIBy0Syxg3NcgBZL4ox3DYx/gVW7i38V3dCQjbkJbOV+RNQmerXV3A
         pIU+1p8ExgGDuP7ck8h8/JgZz3ZLbOCXmgitpOV+i4yU2VImGTKvR7XEUmxHnsPKWw0f
         /yW9bpmO6U3dCGqwVVva67ObxbDiLRXtMwepa8PeROFzlktb2RW3YFVQBLPuJ1p2qOoo
         8SqhvRYRFU2vQIMtF2CTaL4YncRqA8jwoWN94QXiYGXLZA0AAqgDEXvr6TUt8+2v7lBl
         WtHduvOmHz9uAoo+aOQTrB4VgtNWaqeKaN0gNImRKOAWvu8hn4BpyQ22wza+V0DU8oGf
         /NYA==
X-Gm-Message-State: AOAM531TfC8fbXdw0353DAkG/B6/PE3GXhpK1eIV7BMweVuh5naCU7TH
        kK+a3g7TSE0WYWjVWx9XO5AWbbO/6N6Q
X-Google-Smtp-Source: ABdhPJxnhn7xsyMPy52xHqzG7NsgEWOARwRRqFIViu4z0hfzIE+PNWvB+uIz0jkbi19kXhKBvI0sXQ==
X-Received: by 2002:aca:1c0f:0:b0:2ed:22b4:9205 with SMTP id c15-20020aca1c0f000000b002ed22b49205mr21450oic.118.1648043335994;
        Wed, 23 Mar 2022 06:48:55 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id k22-20020a056870959600b000d277c48d18sm9653150oao.3.2022.03.23.06.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 06:48:55 -0700 (PDT)
Message-ID: <0b827ba1-5870-dfc0-8fdb-455e2f23a048@github.com>
Date:   Wed, 23 Mar 2022 09:48:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [-SPAM-] [PATCH 3/5] pack-objects: parse --filter directly into
 revs.filter
Content-Language: en-US
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com
References: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
 <97de926904988b89b5663bd4c59c011a1723a8f5.1647970119.git.gitgitgadget@gmail.com>
 <b5685cca-2fb9-dabf-fe4e-4a718817820b@ramsayjones.plus.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <b5685cca-2fb9-dabf-fe4e-4a718817820b@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/22/2022 3:37 PM, Ramsay Jones wrote:> On 22/03/2022 17:28, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> The previous change moved the 'revs' variable into cmd_pack_objects()
>> and now we can remote the global filter_options in favor of revs.filter.
> 
> s/remote/remove/

Thanks (you and Ævar both).
-Stolee
