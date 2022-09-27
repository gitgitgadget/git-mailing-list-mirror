Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E0DC6FA83
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 13:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiI0Nz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 09:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiI0Nzy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 09:55:54 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EE7B2D81
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 06:55:52 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r134so7771602iod.8
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 06:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=mKOK9XziAoTKHq5SPBTojsSr75SYZeDRp2r9wKG9J1U=;
        b=KD7OxdgJ2kZ42Hccx5yzNIdlYzkU9zUT8upFTMDSNaiIB6Yb9UNDysoQg2BGwpq2lv
         5VPcPKmGr8tnarvTzEVdPw6j8klNaOCs4pTxCXgJm1Zgpi3yZsX2dLteDZAsftNVuBBN
         lRzv9YtJ09ORffC6TiFP2uu1Oyg717C1h1NR/2rvvALDWq/2Aj1MNDcrrd9TAbzEjbgI
         Fp8Ktirz3enLKJ4olP+dVahLopi2ZaKraANODcy572zGIo+TsG4iLCCEg6cmA4u4Tucg
         Mb58ZitVoWMAHmQcit12b94WorcJW/Aniwj3jV0gqPuKQe7dUnAnZsoiqUlZsH2rKn3d
         /vYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mKOK9XziAoTKHq5SPBTojsSr75SYZeDRp2r9wKG9J1U=;
        b=faRtNUjdNlXcuRNkr396L7tBvHQn7qHDDIm9q7K/KH5nQleMawg+wa35g0IJMkz9wy
         nuhBr3jQ9R3P9vx2UI9ri1Vq+5oKuaTW/KVE60cGB7MLshdnV9y0fCde53a8ZuI9wYd7
         CzpTXZDv2wqBlUgUkfPXSa3wJHITaWLXECFYecvmbMdzpxsRhsAIG+XLacPjEK3gvY0z
         2JQx8KlO8mTrHr4eMSNmqGQQOnUqSNnf8666FwTi78JhO3gLCat9gwdaGGNhcM+V2rjV
         aABhRzJ6PC0DyCJiV2xszLjX4ku7PAHKA/22VTopYAYsKrLlEx39mewP954ezQGfUZY+
         Nz7w==
X-Gm-Message-State: ACrzQf3GMA6hN9zDxh6EwL2bZ2vXXoiBY3KraIxuCDBvUVTalJ2LypFa
        M9QHh2BcB+UAQChjO1oCcxtsP20HKpDM
X-Google-Smtp-Source: AMsMyM7lx/RM2k68NNZSF3DFgeXZvgRRzqNym/SmL+Q/B7bJ+RS7Fh4Bph5izAKiRj136juuhhnm4Q==
X-Received: by 2002:a05:6638:3828:b0:35a:415e:fb8f with SMTP id i40-20020a056638382800b0035a415efb8fmr15013665jav.71.1664286952293;
        Tue, 27 Sep 2022 06:55:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:6d75:31c0:4041:5d27? ([2600:1700:e72:80a0:6d75:31c0:4041:5d27])
        by smtp.gmail.com with ESMTPSA id e14-20020a02860e000000b00349ba0d1137sm652115jai.24.2022.09.27.06.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 06:55:51 -0700 (PDT)
Message-ID: <30b43cee-e7fb-067f-8a84-ff1fef5444db@github.com>
Date:   Tue, 27 Sep 2022 09:55:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 1/3] maintenance: add 'unregister --force'
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
 <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
 <8a8bffaec89e55da0c5bcac2f04331e0d4e69790.1664218087.git.gitgitgadget@gmail.com>
 <xmqqa66lby1w.fsf@gitster.g>
 <b1e6f118-046c-42f8-01a8-2543e792685a@github.com>
 <63aa68fb-c215-a79f-e3c6-1c1a489220e2@github.com>
 <220927.86a66lylk5.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220927.86a66lylk5.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/27/2022 9:36 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Sep 27 2022, Derrick Stolee wrote:
>> Of course, there is a reason why we don't check for NULL here,
>> and it's because -Werror=address complains when we use a non-pointer
>> value in the macro:
>>
>> string-list.h:146:28: error: the address of ‘friendly_ref_names’ will always evaluate as ‘true’ [-Werror=address]
>>   146 |         for (item = (list) ? (list)->items : NULL;      \
>>       |
>>
>> I tried searching for a way to suppress this error in a particular
>> case like this (perhaps using something like an attribute?), but I
>> couldn't find anything.
> 
> We discussed this exact issue just a few months ago, see:
> https://lore.kernel.org/git/220614.86czfcytlz.gmgdl@evledraar.gmail.com/

Thanks for finding this thread. I knew it was vaguely familiar.
 
> In general I don't think we should be teaching
> for_each_string_list_item() to handle NULL.
> 
> Instead most callers that need to deal with a "NULL" list should
> probably just use a list that's never NULL. See:
> https://lore.kernel.org/git/220616.86bkuswuh5.gmgdl@evledraar.gmail.com/
> 
> In this case however it seems perfectly reasonable to return a valid
> pointer or NULL, and the function documents as much:
> 	
> 	/**
> 	 * Finds and returns the value list, sorted in order of increasing priority
> 	 * for the configuration variable `key`. When the configuration variable
> 	 * `key` is not found, returns NULL. The caller should not free or modify
> 	 * the returned pointer, as it is owned by the cache.
> 	 */
> 	const struct string_list *git_config_get_value_multi(const char *key);

It documents that it will never return an empty list, and instead will
return NULL. There are several places that check that condition explicitly.
Converting them is not terribly hard, though, and I'll send an RFC soon
that performs that conversion.

> This also gives the reader & compiler more information to e.g. eliminate
> dead code. You're calling maintpath() unconditionally, but if you have
> no config & the user provided --force we'll never end up using it, so we
> can avoid allocating it in the first place.

While you're correct that we could avoid that allocation, it makes the
code look terrible and hard to reason about, so I won't make that change.

Thanks,
-Stolee
  
