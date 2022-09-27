Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076AFC07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 16:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiI0QwW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 12:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiI0QvL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 12:51:11 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB7198C9E
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 09:50:40 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id l4so5408094ilq.3
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=nzEZU4Bp0H+Q49mHeLQbYrTYc37j135eCY3Q3wjr2fY=;
        b=d4Nowu/QL00nwAfCgWFAmZJyOcZgfpg+00oWxA7gzVgpHbOjd6wJHEwcTfE7kDMpGr
         n3F6sgg5GJAlZ1F6nQdIzUS/GJluOm3gGE9zAsEbCztgyeSPOXhm/AwtnzkSeBt6/4c2
         aa2IDXRxrweoYOqEICO98RVJ/r69IEORQ2FJXPAF1djgrB6PISZ0PxIgfTUTldMbGTVg
         t6uMCJJKZQjyDpFpmI5j3eVujkb9XZSTW0J/OOK/JEn8p0cApS910z7dx6sOYi6DyjIL
         51ot1bWnKVAiHAQQv/A8E+8p4vkHuH7yHu4J3ohHqYuxO/2dJ0zQmPv2eQyYR5V/uMjv
         NLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nzEZU4Bp0H+Q49mHeLQbYrTYc37j135eCY3Q3wjr2fY=;
        b=Txcz1PijTWZq8NG6eO9jxzRQC7XOpYWyDrnrEBnszD7WghRdbPTl9BOMdzO3wcx8Hl
         ymajbZDkWn9XFUkapCLsBW4ysbfRbvCoGHyh6Db2IZKCilRs95GQ4H9MWz6lsA4lNV0C
         1I0ySnikR31Ce2BYx6Ojf4m/QJAb5LanIoWIEPHrCk4Y9opgstbhXwinN/0caTtEMVjO
         W2A+JUFGBeR/PtkY/q8L/MouPokhosQ5NsfL7H3VOv1RXqggOnJoSRUI8bAO976VG6zn
         b5Bh/AeteaN3r1+44NfV6Zcn4pNNULkHaph1bv/hvKZrkRpXlJEQxiV8NIV8fnh+Do5m
         LQkQ==
X-Gm-Message-State: ACrzQf35XSVfLjwNp25Imsm3D6aAUSyTXlK7aH12XSJb7hwDpf7gSnJD
        mdrD/K2RmvzRSgcXI1ZnTD7lzNbccHs7
X-Google-Smtp-Source: AMsMyM4tLvulGpGdHCZYmouRSZ8yJJMfzngbnTj+PDRPmRMRQwP5mZHeTWpxCBxtvkdu4RxLwN1ZWw==
X-Received: by 2002:a05:6e02:148a:b0:2f6:f277:18e2 with SMTP id n10-20020a056e02148a00b002f6f27718e2mr10730781ilk.56.1664297439499;
        Tue, 27 Sep 2022 09:50:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:6d75:31c0:4041:5d27? ([2600:1700:e72:80a0:6d75:31c0:4041:5d27])
        by smtp.gmail.com with ESMTPSA id t12-20020a02b18c000000b00346e7ca2463sm753955jah.135.2022.09.27.09.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 09:50:39 -0700 (PDT)
Message-ID: <b85d8a43-6640-aa9c-3103-0c3d43c2a479@github.com>
Date:   Tue, 27 Sep 2022 12:50:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 4/5] config: return an empty list, not NULL
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
 <396343ce7dd17f86bbbc66197c6f0b4012caf445.1664287711.git.gitgitgadget@gmail.com>
 <220927.86sfkcyebf.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220927.86sfkcyebf.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/27/2022 12:21 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Sep 27 2022, Derrick Stolee via GitGitGadget wrote:

>>  /**
>>   * Finds and returns the value list, sorted in order of increasing priority
>>   * for the configuration variable `key`. When the configuration variable
>> - * `key` is not found, returns NULL. The caller should not free or modify
>> - * the returned pointer, as it is owned by the cache.
>> + * `key` is not found, returns an empty list. The caller should not free or
>> + * modify the returned pointer, as it is owned by the cache.
>>   */
>>  const struct string_list *git_config_get_value_multi(const char *key);
> 
> Aside from the "DWIM API" aspect of this (which I don't mind) I think
> this is really taking the low-level function in the wrong direction, and
> that we should just add a new simple wrapper instead.
> 
> I.e. both the pre-image API docs & this series gloss over the fact that
> we'd not just return NULL here if the config wasn't there, but also if
> git_config_parse_key() failed.
> 
> So it seems to me that a better direction would be starting with
> something like the WIP below (which doesn't compile the whole code, I
> stopped at config.[ch] and pack-bitmap.c). I.e. the same "int" return
> and "dest" pattern that most other things in the config API have.

Do you have an example where a caller would benefit from this
distinction? Without such an example, I don't think it is worth
creating such a huge change for purity's sake alone.

I'm pretty happy that the diff for this series is an overall
reduction in code, while also not being too large in the interim:

 12 files changed, 39 insertions(+), 57 deletions(-)

If all callers that use the *_multi() methods would only use the
wrapper, then what is the point of doing the low-level manipulations?

Thanks,
-Stolee
