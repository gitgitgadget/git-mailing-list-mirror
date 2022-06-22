Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D90C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 11:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355695AbiFVLZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 07:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbiFVLZI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 07:25:08 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7408B856
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 04:25:07 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id q4so12521834qvq.8
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 04:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8FaFrnVYdTU4CI2bpUAQ4A8xoCVtCqYnD48Ddt6mXCc=;
        b=VKh7ZcLpUf8XvnKrCZ4xWQPBD/XjPEtHkjvfFUv1JkqGzsEEJ5qhoGPrannuptTzTv
         xmk+xGAn/CAyU9B6PL/R4yligOCKg76NwNXSscbvnIGGsJBX5iw6mZjv+lqnwQuFyOeZ
         vXIi2HibbJtMBYzLLoxke5Iv7XR/j5ZtpcuJiqUFlBJEC0y6gqg7+P8dbPnsdfRYR5fH
         ot6oJCMqFFubewbhCu80L4ggzb8Y4OeHRuThG9GIjbMVlji9/f6IDh6Eqq4nml1by3Ye
         e5c5i7v7meoM1t6lvJIqBFLYnIkAEaVIm/zYSZ8p7QwmiI6Fax1Ryr2MFuoOzebU9bIC
         7R1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8FaFrnVYdTU4CI2bpUAQ4A8xoCVtCqYnD48Ddt6mXCc=;
        b=6jzZO3bK3QnUIf5AzgCquklYzRkwVKZw7lZELZvLrscTmIy+Jjg7fL7kxn2aWsd2lV
         +XJWLOaW4jP62MUrUDWLIq64DsKT6RRzFCR2/B3R/x0UlZueAaotR9VWW7pY1bEqfrHN
         276RIobVmiCSzzfmymDtnmAP3XN1cHaH44Ln0GmHRLYBP4XKF9mIW1QG+FlJBQJ6dF1K
         6uUDsReJJXcjAYIRHmFcCfyejHpWc9hSzL+EY+A6jGqkupi3CaOGQv0/AhwvvwxmHLFk
         gCmqUpJZeKWO3UKOnmA5k+4qr1qHNqaGMV8XU1YjcoERglkOvrWZSxHMpSku0yNoc+3u
         MTiQ==
X-Gm-Message-State: AJIora8w5eflaWrInQWh8DgSzImDNZCzblY9Sg5RGlGPBNfQO7rVUxH/
        KB8u2pkFbr8PsXlPgDwdK/8C
X-Google-Smtp-Source: AGRyM1ub+eZMis9tJXNAPlmBsx9zJY4X7VoeKfXu4yaLhCDIj1DSu3t9O7dAZ45PeSQqHFUxInnbDw==
X-Received: by 2002:a05:6214:410c:b0:470:46e6:bbbf with SMTP id kc12-20020a056214410c00b0047046e6bbbfmr10135456qvb.42.1655897106897;
        Wed, 22 Jun 2022 04:25:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9029:68d7:275:ef4? ([2600:1700:e72:80a0:9029:68d7:275:ef4])
        by smtp.gmail.com with ESMTPSA id q13-20020a37f70d000000b006a91da2fc8dsm15728714qkj.0.2022.06.22.04.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 04:25:06 -0700 (PDT)
Message-ID: <69256646-13b0-5619-3161-8d8e319fad50@github.com>
Date:   Wed, 22 Jun 2022 07:25:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 10/10] fetch tests: fix needless and buggy re-quoting
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
References: <xmqqa6a5g0m3.fsf@gitster.g>
 <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
 <patch-10.10-54129b94a77-20220621T222854Z-avarab@gmail.com>
 <xmqqsfnx6xbh.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqsfnx6xbh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/22/22 2:12 AM, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> This makes it a lot clearer, with no perl, no sed, no eval.  It does
> become louder, but should be easier to follow in general ...
> 
>>  test_configured_prune_type --mode link true  unset true  unset pruned pruned \
>> -	"\"$remote_url\"" \
>> +	REMOTE_URL \
>>  	"refs/tags/*:refs/tags/*" "+refs/heads/*:refs/remotes/origin/*"
> 
> ... except for a magic like this one.
> 
> We may remember the REMOTE_URL -> $remote_url trick used here this
> week, but I am not sure if we find it sensible in 3 months.
> 
> But overall I think this makes it simpler.  I am not 100% sold on
> the necessity of lengthy earlier steps, though.

When I saw that this was a series with 10 patches (without reading
anything else) I expected that you had created a test-lib.sh helper
that allowed replacing a word in a string with another string, and
then the remaining patches were fixing the other tests that have
similar breaks when using "@" in the path.

(Heck, I'd even take a "test-tool replace-word <string> <word>
<replacement>" implementation to avoid all of these issues we have
due to using scripting languages that rely on special characters
to define the match and replacement operation.)

It seems like this isn't the last time we are going to have a
problem with string replacement like this, and having a well-defined
helper would go far.

The rest of the changes to the test script seem more complicated
than necessary for what _should_ be a simple problem.

Thanks,
-Stolee
