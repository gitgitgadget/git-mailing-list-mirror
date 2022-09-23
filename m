Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F808C04A95
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 18:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiIWSLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiIWSLa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 14:11:30 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886E0EE669
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:11:29 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y141so568667iof.5
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=5M1+2ILsQmenRVs2a6tJvQdQRWEHmTbQdfFONHNu+xY=;
        b=MUoY3vQckpyY0SnoMQjVFWY3jzygHmAI38Hu5q11yvjZqJFVuiFWlXcGzPyMjBK2GR
         9jcHqMeYmqStNExnVyuSHc5PbZVFGKQtUOry6AqePcbox39BIN5bpZsfWad5WMTos6rl
         i9WGwaXM2erfh5xL+ru3bKhFB3irv1Il9CLH0T4gPu3K+nTf6W1FyVrpC0qOlx7ZGJz/
         RigkXDcMMZZDMMC1oDhNXagKJRP2t96x6bPuGnOlAN6RaJVivvJqzree7TecY+Orh9jZ
         eWj8eQRUJl6cQFaabzxpCIZKkLzfb80ZxSra7zFSs1FxuJtCIiCeTo7cC4UEJIIpvbXR
         iRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5M1+2ILsQmenRVs2a6tJvQdQRWEHmTbQdfFONHNu+xY=;
        b=k+Q7jn/t3n4SyNHogAX9V9JAbqwFFk44tChabYHgK47dpo8Lc5AP9YtCpSVz6N1G+f
         KU9HBDGyZwlFIkiLfaz8plv5HlNo2VwjHKk4KcJh35pZh0Q70WlrwyMXSwi5hdwNMk4O
         pdt4NMVwTrsgmEPojO0taw6dIZxu00V6E2jp+CdewIiXeDAaAgz4NsmeoECInPJJ48in
         REeTAcC+EMYvNI8ceUfVOfr+0IMvyN93CqWP3b1oXqiou2OEWteNuT8Ap8rFB7RqlrSF
         iKtIZjqtBYs8oiF5XzhTQNTzU8p0kFMeGdwSgkMOsx+3TGdaMmRq8GrqVl7zsn3CQFFH
         zfuA==
X-Gm-Message-State: ACrzQf2Dg0Kkw4VeCKUj3pqYWlUCKmsRk4qoYeFhJ34klHnhS4OdYIyX
        EkxREKPSw+KgUkl4if60DL7s
X-Google-Smtp-Source: AMsMyM7ToRYNAW06XxCDDC+gwBEoRnuirQPULRg91ygkVPTMnwCz1d/ecCosy86ef0lQrdrXXg4Dxw==
X-Received: by 2002:a05:6638:35a1:b0:35a:6967:acbe with SMTP id v33-20020a05663835a100b0035a6967acbemr5484582jal.37.1663956688883;
        Fri, 23 Sep 2022 11:11:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f43f:f355:a5bb:115a? ([2600:1700:e72:80a0:f43f:f355:a5bb:115a])
        by smtp.gmail.com with ESMTPSA id bm4-20020a05663842c400b0034294118e1bsm3641614jab.126.2022.09.23.11.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 11:11:27 -0700 (PDT)
Message-ID: <a86af661-cf58-a4e5-0214-a67d3a794d7e@github.com>
Date:   Fri, 23 Sep 2022 14:11:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: Question relate to collaboration on git monorepo
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
References: <CAOLTT8SHo66kGbvWr=+LQ9UVd1NHgqGGEYK2qq6==QgRCgLZqQ@mail.gmail.com>
 <CAJoAoZnm8jE9rT+rrze-zP7KZNW=oCZjcrFWqjDssW3LzxrKPg@mail.gmail.com>
 <CAOLTT8TwdwfHCCv+x51++Aanf3tipMegfZiTKFbQtfh7b_EY0A@mail.gmail.com>
 <CABPp-BEBB1oqdVcXrWwMAdtb0TwHZvr-6KDa210j5ncw54Di_g@mail.gmail.com>
 <1c2f6cfe-a6db-c06e-5313-f5b31be42c8d@github.com>
 <xmqqzgeqw0sy.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqzgeqw0sy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/23/2022 11:46 AM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:

>> This is an interesting find! I wonder how many people are hitting this
>> in the wild. Perhaps merge.stat should be added to the optional, but
>> recommended config options in scalar.c.
> 
> Hmph.  It somehow sounds like throwing the baby out with the
> bathwater, doesn't it.
> 
> You are only interested in a few directories in the project.  You
> pull from somebody else (or the central repository), and end up
> getting updates to both inside and outside the areas of your
> interest.
> 
> As a project gets larger and better modularized, does it become more
> likely that such an update will happen more often?
> 
> I am very tempted to suggest that the diffstat after a merge in such
> a project should use the sparse cone(s) as pathspec.  Disabling the
> "what happened in this merge" report altogether is a way too blunt
> instrument, isn't it?

You're right that having a sparse-checkout-scoped diffstat is likely
to be interesting in the long term. It does require updating its
format to describe "some paths outside the sparse-checkout changed,
but we won't give you the full diffstat there".

Using something like the config to disable it in the short term
would certainly hide the pain point, but you're right that we shouldn't
stop there.

Thanks,
-Stolee
