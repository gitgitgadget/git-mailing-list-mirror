Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACE2C54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 16:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbiI0Qrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 12:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiI0QrX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 12:47:23 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834269E68C
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 09:46:10 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e205so8223495iof.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 09:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zkwPKYgg0fiYecTbnccNvBczo02i2s/ZxyQ4n8ihc2Q=;
        b=UDNhf11Etj2r+qCYrZHId/n/DE77W9wkMwqqdqFBxWk9qKltEQ7YN8UyJQqIrr/dX7
         u8SRQS4vYvXIVvOBt1voP/53VLn6IEOusRPj3uNXYGEebpQje5hDwwa32ULdcjHuM2lG
         Rgq9Kvxivprc7087byUF3eipPTT6bIPyrSVc+P3Klb8q9abxDJmoiE0P5mG9cTu56YFH
         Rt/PFYP8IyyYgG0IqWXYKZWTutF240yvOepGloN4xmK7XI569x7sXa8ebgFyIu3Tp26t
         Z1MC2oAR5BcVq2CIVhU/Qi2Eqo2EIRN3fPxTUokWByG+tb/u7OezfTrKkG1JSvHx01Af
         KOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zkwPKYgg0fiYecTbnccNvBczo02i2s/ZxyQ4n8ihc2Q=;
        b=18a7Uq59Gaq8NF2G3RihnAr80w9CdXG8UQ0PSeE/AAH0X2TmgtAUmxLY3KXCUPaZYF
         LCAEyPlcvIidQ5Ki8Zxlq+dzuFYRADdrJpEc7fKAlcFYR05GAssz0WG6K4S3AwsquLoW
         BXdkzmXCCp4Vu7020FPUtEMSJiA4waJihorREaxFzjPjKJlpfpFaiwcaSDSag2/dh2nU
         8FzjKQPtcIdFGZTCe8EyHxX44hgwTVFnEbX2NP/Xm19pmV0nvllWSbEijZswj1mDKCzn
         ZQS6Q0Vz8kh17O4Mp5XCQv1SEs+oBX79dxdCJ1+6KhvzypPS/QWfKfUgeENnIbcjJqIm
         wLhw==
X-Gm-Message-State: ACrzQf3FLuBlDh/Ft6zLMXRyyopIT1BCUzslgM/S8ugGSAceyTV/0Nf1
        mzoHnUFEsWvL1pvLbyfjwJTOw3R38mpX
X-Google-Smtp-Source: AMsMyM61kPqfM7TFk6WSe49IuQ+gxRYCAFWk4Q8t1JZ6sBmrG8tDkPbXCx+VdStrqGrr20RAU5Hmuw==
X-Received: by 2002:a02:ccca:0:b0:35a:d680:7a0f with SMTP id k10-20020a02ccca000000b0035ad6807a0fmr15736165jaq.110.1664297169135;
        Tue, 27 Sep 2022 09:46:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:6d75:31c0:4041:5d27? ([2600:1700:e72:80a0:6d75:31c0:4041:5d27])
        by smtp.gmail.com with ESMTPSA id q11-20020a056e02078b00b002f611806ae9sm773318ils.60.2022.09.27.09.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 09:46:08 -0700 (PDT)
Message-ID: <4d0cf1a7-0902-af0e-93b0-ad6727bf6c2c@github.com>
Date:   Tue, 27 Sep 2022 12:46:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 3/5] config: add BUG() statement instead of possible
 segfault
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
 <f277a7a429db8f54fa06dd1965d62ec491e6d84b.1664287711.git.gitgitgadget@gmail.com>
 <220927.86wn9oyejm.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220927.86wn9oyejm.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/27/2022 12:17 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Sep 27 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> The git_die_config() method calls git_config_get_value_multi() but
>> immediately navigates to its first value without checking if the result
>> is NULL or empty. Callers should only call git_die_config() if there is
>> at least one value for the given 'key', but such a mistaken use might
>> slip through. It would be better to show a BUG() statement than a
>> possible segfault.
 
> AFAIKT the intent of the current code on "master" is that this will only
> get called if the likes of git_configset_get_string() returns < 0, not
> if it returns > 0.
> 
> So isn't the combination of your 1/5 and this 3/5 now conflating these
> two conditions? See e.g. repo_config_get_string_tmp() and when it would
> call git_die_config().
> 
> I.e. isn't the whole point of git_die_config() to print an error message
> about a configuration *value* that we've parsed out of the config?
> 
> If e.g. the key itself is bad we'll get a -1, but in this case it seems
> we would have a BUG(), but it's not that we "expected a non-empty list
> of values", but that the state of the world changed between our previous
> configset invocation, no?

If git_die_config() was static to config.c, then I would agree with you
that its use is controlled enough to avoid that possibility. However, it
is available in config.h and its doc comment does not say anything about
"make sure 'key' properly parses at least one value".

The point is defense-in-depth to prevent a segfault if someone adds an
incorrect caller. It looks too easy to add an erroneous caller.

Thanks,
-Stolee
