Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6E0C433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 10:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbiK3K2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 05:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiK3K2X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 05:28:23 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E7F3D93C
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 02:28:20 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h11so19058290wrw.13
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 02:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gwAZ9VF9g0hg/B4MxGIQP2Gi/LCesS9hzLCTGiWjQuw=;
        b=UsMawIBqCSE9tdEDctFvL7DgAOJuXx91HRJIJUmhjRUXdnD3UmhDwrcN7BJhU3dOcX
         /4u5aj6428OCBZDYKH7dXwQujw9mPq9h3VqZqUI81WLzG2pzmmpLN+ye4H67Ek4LVgxx
         sfv/FjXO+Qa3EXLmD9aI7Frxlvzs5NJk4iU55CX9If2gWJuareiKxInE3lGJxA828vtb
         ZLwaHl5rK/a0Ktq06wLIr8MRkjQ/bC5pyAlWcr/mWRFTOlvqMyvBzRHHY2DAIaDj/V3u
         f/6l1rrzfRjUZa1ZWeHEXfQlNAo9aRzyWN0M5drI30bJsAKC/MyuXU24fUGBIGXpbZqE
         Lzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwAZ9VF9g0hg/B4MxGIQP2Gi/LCesS9hzLCTGiWjQuw=;
        b=DxMeQUSYmITFeVsuhX2O1v/S9Ni3p3F50fKddlRAgsQzb5I9QH0Dc2l3V62dzWW7Vn
         h22sQT5WOscUFQPWs5yOH5oiIJf0u59j2viJ11/myzBQXMJkytCwry0p9EU1dc4gpLBA
         PIiYGtMmAXxUuFLE7B0s+eEerhNnYIxye7LAATuN6whl7ebnduAhPuTXQoSliWNLkzHv
         yoGck8E9/1GHKpYd9Mk41FTCgdf6ptlQ5g3pX14Ukd5FnBLn98D0+sAtFDGm437YJCOn
         509djp4AjGsFeGHPQGPkcDEk06Vpn3b1eD7zlLZDbsit6aGqQ6yLWlnB+k8w2IQudGLH
         3A5Q==
X-Gm-Message-State: ANoB5pkE8GHcjsV5CBM1W2urHT1OSCFlDcQQ/Bw1BdjvYi+xjCaSIuLa
        E0V40I7lWGwHbKah695B98k=
X-Google-Smtp-Source: AA0mqf7uSqL6COtzoaYHX+j8pWSieqxdvzx/7hY4ypAWUj6ErBvijK3PYllLZ3wcZbfkUF3piiC7dQ==
X-Received: by 2002:adf:f789:0:b0:242:129b:9cb9 with SMTP id q9-20020adff789000000b00242129b9cb9mr5074159wrp.373.1669804099007;
        Wed, 30 Nov 2022 02:28:19 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c424800b003c5571c27a1sm1696896wmm.32.2022.11.30.02.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 02:28:18 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <5f6f0181-c251-0a98-a39f-a910b93f8c1a@dunelm.org.uk>
Date:   Wed, 30 Nov 2022 10:28:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/5] run-command: add duplicate_output_fn to
 run_processes_parallel_opts
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        emilyshaffer@google.com, phillip.wood123@gmail.com,
        myriamanis@google.com
References: <https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/>
 <20221108184200.2813458-2-calvinwan@google.com>
 <kl6lo7spqqzg.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221130.86lensiwy0.gmgdl@evledraar.gmail.com>
In-Reply-To: <221130.86lensiwy0.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/11/2022 09:53, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Nov 29 2022, Glen Choo wrote:
> 
>> Calvin Wan <calvinwan@google.com> writes:
>> So this might be more idiomatically written as:
>>
>>          int n = strbuf_read_once(&pp->children[i].err,
>>          			 pp->children[i].process.err, 0);
>>   +      if (opts->duplicate_output) {
>>   +          struct strbuf buf = STRBUF_INIT;
>>   +          strbuf_addbuf(&buf, &pp->children[i].err);
>>   +        	opts->duplicate_output(&buf, &pp->children[i].err,
>>   +        		  opts->data,
>>   +        		  pp->children[i].data);
>>   +          strbuf_release(&buf);
>>   +      }
>>
>> which also has the nice benefit of not touching the strbuf_read_once()
>> line.
> 
> We should also use "size_t n" there, not "int n", which is what it
> returns.

It returns an ssize_t not size_t, lower down we test `n < 0` so we 
certainly should not be using an unsigned type.

Best Wishes

Phillip
