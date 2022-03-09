Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5443BC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 14:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiCIORf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 09:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiCIORe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 09:17:34 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F120A7743
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 06:16:35 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id g6-20020a9d6486000000b005acf9a0b644so1802983otl.12
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 06:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9aS0dRykOf28UAGlAZee+wP961yqPiSx+j+q06Ko92I=;
        b=Keiowj+SZjNZFiuel8pWVxZkj/VftG/cjJypgjRYjGSw0+WivYAUwsIkBYkFZCBu49
         tgR7uyg3Z5sTNx4dhtCGI5lG5Q0v4Fx0Ui/ep2EDGO6fY8BxF0Zn/Ju0ISHRK+tACmmR
         GRpx6oAVvdQTT4PDso/VQtgls8bh9wlPhdjIF6/WdTUla5daSvckTPiT0rqc05wjrZbk
         WNemHzAm9F1bxGG6nzt+IY5Te7kCxc54gTvrxcCxqsP0i2ed5Zn4fJT/aBeyvKstxf7E
         hkzChPy5dHUvLdu70hCGmSpPZSMsXqC9E3IuHcfp5jtAXkGlsKgLT9wRin6k3Kk/IMxV
         ONTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9aS0dRykOf28UAGlAZee+wP961yqPiSx+j+q06Ko92I=;
        b=yjbe+Ft3l7Y3cPoJ5G7+48VILybCAw+0lGXHzYPbkejIMQWiHbRu92+AJ5oyIkWZgt
         jXU7oxxXN6M6lMLx+xznPH0Fu2ljba4f7eMaYgBjFMbVEC0jbA0h4tjytYyqJV/n0WqG
         pDAIAd+qh1mZoj6G2RRrv6z66FbtspOty2gdjT/MVfFKRhE//jrCz+y1p2gpDEgYky35
         ljimcmjUgmgyaWcBdr/G0dyKyvBE7HUpAo48Y+Atv7h5gxaVh1HgYJNC3Au4jKx9GSp+
         PFBKYuEXdsk0d4C6ywKr4W038+0jjAfcswlrZdk197PAlrjV5aboN7LovMgXr6GcutRv
         cp8Q==
X-Gm-Message-State: AOAM531ciXDWq4rDXK0w2pVlvqMPk5JYcwGy0D8xOwzrT+7muXBtlx2W
        hQTQ2waHAsBc8uQGbSZPvVrl
X-Google-Smtp-Source: ABdhPJxj0msmsE/bJZ5GtVe08aSiXpBJe8oeAqWsh9t50zlgaANSpEHcfyQm8PBnVJu1/qiOjPViDA==
X-Received: by 2002:a9d:70cf:0:b0:5af:9dda:ec44 with SMTP id w15-20020a9d70cf000000b005af9ddaec44mr10513688otj.23.1646835394670;
        Wed, 09 Mar 2022 06:16:34 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id n6-20020a056870970600b000d8a7483548sm944083oaq.43.2022.03.09.06.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 06:16:34 -0800 (PST)
Message-ID: <28939126-328c-467d-7423-a186a9285d50@github.com>
Date:   Wed, 9 Mar 2022 09:16:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 07/12] list-objects: handle NULL function pointers
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?=c3=86var_Arnfj=c3=b6r=c3=b0_Bjarmason_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org, stolee@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
 <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
 <782182a26e37eb8e84aef7d8cc67cf276b2abb54.1646750359.git.gitgitgadget@gmail.com>
 <xmqq8rtknyni.fsf@gitster.g> <220309.86k0d3mee3.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220309.86k0d3mee3.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2022 8:40 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Mar 08 2022, Junio C Hamano wrote:
> 
>> "Ævar Arnfjörð Bjarmason via GitGitGadget"  <gitgitgadget@gmail.com>
>> writes:
>>
>>> Replace all callers of the show_commit and show_object function pointers
>>> in list-objects.c to be local methods show_commit() and show_object()
>>
>> "to be local methods" -> "to call helper functions"
>>
>>> which check that the given contex has non-NULL functions before passing
>>
>> "contex" -> "context"
>>
>>> the necessary data. One extra benefit is that it reduces duplication
>>> due to passing ctx->show_data to every caller.
>>
>>> -		ctx->show_object(obj, path->buf, ctx->show_data);
>>> +		show_object(ctx, obj, path->buf);
>>
>> I guess this is the "reduced duplication" refers to.  The helper
>> does make it easier to follow and reason about: "show the given
>> object at the path in this context" is what it asks.
>>
>>> diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
>>> index b13e8a52a93..6522401617d 100755
>>> --- a/t/t6020-bundle-misc.sh
>>> +++ b/t/t6020-bundle-misc.sh
>>> @@ -475,4 +475,16 @@ test_expect_success 'clone from bundle' '
>>>  	test_cmp expect actual
>>>  '
>>>  
>>> +test_expect_success 'unfiltered bundle with --objects' '
>>> +	git bundle create all-objects.bdl \
>>> +		--all --objects &&
>>> +	git bundle create all.bdl \
>>> +		--all &&
>>> +
>>> +	# Compare the headers of these files.
>>> +	head -11 all.bdl >expect &&
>>> +	head -11 all-objects.bdl >actual &&
>>
>> "head -n 11" but more importantly, why eleven and not ten or twelve?
>> Is that a number this code can automatically learn from the given
>> .bdl file?
> 
> I suspect what's wanted here is "print all stuff before the "\n\n"
> header/PACK delimiter, which is better done with "sed" like this:
> 
> 	sed -n -e '/^$/q' -e 'p'

Thanks for this tip. That is indeed the intention.

-Stolee
