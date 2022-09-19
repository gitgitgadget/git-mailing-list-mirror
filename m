Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB380ECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 17:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiISRy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiISRyq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 13:54:46 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E026564
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:54:43 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id c11so33713qtw.8
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/iWqMNpuOuFX3GfjBVPaHy5b5Ki3+ReabgC7rEsNwYg=;
        b=QmyhzDy+x9P4pRJOMwUH1cYBN82+jAPqK0dL7QudhmIlZbKjbImCZAqvROxVT7i5v5
         snPFALD6IYbitOuggkQAaYOtClTmStUWXebnMVtb6mgGm2xy5nhHBl4xPk7uYsU1Cez/
         OzCQ5bh5hf77spAIojrgIWJskvK04MuPEa8v1z85gsHK6K5Yw/tYcDCaI0h28MrtF0a3
         XAO6CWJ+GynOHEJ2kv3BhtxSD10PZLsn4UITGCi1lLwyb2kF3LUW5jDqXCEFxRxQVvAc
         RFZbeu3o7zH69alhLNqDdLWitT1bRkaqxGx0MlJ80GdgUt1EwTFCrKD4eqcXdi+pOW6W
         J7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/iWqMNpuOuFX3GfjBVPaHy5b5Ki3+ReabgC7rEsNwYg=;
        b=csrESYxe7smTDS+abacr4TSfyKS4YDV9RB0PpMQuog7nBupXPspBz9ic2yYSXkJHXB
         ren4x3awZMfVKBw1zHGFfVBqV4A/FV/DdBI506M27hipsGJJXLSp/L4PWu/T+f3JfatJ
         bgk2XWCqIi2pG6p/ZtIIfM56J7+o5jTlQQ+K8+umiVISR4xDQCgXAmSrwzgrTo+lruCG
         9kBYJMJOOcGJ8Qufxq48MtR/l8FRyOkpKXiAbiIcTeh/69RKGPq3/RYZZSgkohNWGSkt
         LPiJDT16XnYHJK0P26YyIY3ymJAogiciFcaMPrvskmE2C5eCsHvGD1+a/gWR8cVshlBU
         hFfw==
X-Gm-Message-State: ACrzQf2s6fkpjiJ8hQv3QwITAQ63cubYZjeDLyrfVPafaQo2QONHVtw4
        X2xq2V8DeRkQEUVQcYOEPzkL
X-Google-Smtp-Source: AMsMyM70ldZ952i+/ekkV+chzTtqaQDhIJIra78ZAYeFFp7PtNm2sl8/FcrmgT/OkVDRf9j1Ir6+Kg==
X-Received: by 2002:ac8:7f81:0:b0:35b:bbd9:9876 with SMTP id z1-20020ac87f81000000b0035bbbd99876mr16037829qtj.224.1663610082684;
        Mon, 19 Sep 2022 10:54:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:fd97:43ff:6c00:2cf8? ([2600:1700:e72:80a0:fd97:43ff:6c00:2cf8])
        by smtp.gmail.com with ESMTPSA id 66-20020a370345000000b006cbc00db595sm12738407qkd.23.2022.09.19.10.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 10:54:42 -0700 (PDT)
Message-ID: <a492902d-7227-3172-9f73-3ddea51cf2c5@github.com>
Date:   Mon, 19 Sep 2022 13:54:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/9] bundle-uri: use plain string in
 find_temp_filename()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
 <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
 <ee6c4b824c276364b77de0b85b54f428c236de00.1662734015.git.gitgitgadget@gmail.com>
 <xmqqczc4l9di.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqczc4l9di.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/9/2022 1:56 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> The find_temp_filename() method was created in 53a50892be2 (bundle-uri:
>> create basic file-copy logic, 2022-08-09) and uses odb_mkstemp() to
>> create a temporary filename. The odb_mkstemp() method uses a strbuf in
>> its interface, but we do not need to continue carrying a strbuf
>> throughout the bundle URI code.
> 
> What the patch does is not wrong per-se, but it is unfortunate that,
> even though we accepted a known-to-be-racy approach for expediency
> earlier, the first update to that is not to replace it with a
> non-racy and safe approach, but make it easier to use, encouraging
> use of the racy approach and give it an appearance of a clean code
> X-<.
 
Hopefully you would be encouraged by future efforts to replace this
temporary file name with something deterministic based on the URI so
we can restart downloads that were halted, even if the process needs
to restart. But for now, this change helps us to remove the strbuf
from the remote_bundle_info struct.

Thanks,
-Stolee
