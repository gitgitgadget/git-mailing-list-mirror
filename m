Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443BAC433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 12:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E191610A0
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 12:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbhITMzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238835AbhITMzR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 08:55:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D0BC061760
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 05:53:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t8so29380923wrq.4
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 05:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d/RnuHK0eanravkcfg3gwnqe0o5uF7JN50eApguhpYQ=;
        b=CWJIqSJbFs9ssCzVcQaTHRKTj1hIkvxgIRI1Wyn2Nj41Bk77U2mzu/5Pa6GnrvVGoM
         EYs3SLSbNiMbCn2r6n2wEZI55wQP9nX3V21kODCqrmfWYAEXuL2ftYKAgzNN0FUv3o9w
         yoP5sPpi5AgstiTvzRqBDNbk4LdsohxUbeT3OmrQ+tlHfesMrMR5wXGmWWIgNgpq2Lbr
         mCYaiglUF7PofetazitnPgUkHuqpFrFb9LAn9vPRtzn6z9O/EfsIvlrOW5VCbVctX8hg
         ZyDvy6zLT44r9DwHHh/qh4/J7Pal3I8qDCMGIkxQFuiXqGgz6l2AC7OYwmz7Sk+6bc1O
         51EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d/RnuHK0eanravkcfg3gwnqe0o5uF7JN50eApguhpYQ=;
        b=PVRjWQgGlzJvsJIezBF7p2cDFHLyC06n+U6sE1tvcprhbB4PD/D1ZgE/sbt+p1Ve8h
         9BZkdSZcpyQyawDZ9+S5XG4zwEzONbUk7kPX6z0PjBu7VvYaxt45R0WtqD/chRd66CVI
         q4Ltsy4TBKmq8uVFxwa/U5ddYhGeIBLqkby64BmFg60Lq0XW4tKAU2FYRbYpGDZAS4eN
         e39ZQDlhq2gHUZJlBe7t1pc/4ZQMdFKe4mxqwXvWy/U6t1DelDQ3/S/WDVKRnP8WMfum
         jfiNhUNl/VA222x6FCQBnWywDiBlynRnUyhNxxlLdct457D7TwAK0tyX+MuHuCr722Hh
         +PlA==
X-Gm-Message-State: AOAM533FDkarzYGN1zsmXBsT69qynroHm0I91t6GlNWEy0tlLGqhUvFI
        m9MgegvsZNiyMvqriJIzKQ4=
X-Google-Smtp-Source: ABdhPJxsRJ8ApogJgVT+pC0Z9ikx41LHG+k+P20OlV4AVFv73C2uYyH7SOC+6JJAf43IyibP7glbHQ==
X-Received: by 2002:a1c:210a:: with SMTP id h10mr23499431wmh.165.1632142428935;
        Mon, 20 Sep 2021 05:53:48 -0700 (PDT)
Received: from [192.168.1.201] (178.2.7.51.dyn.plus.net. [51.7.2.178])
        by smtp.googlemail.com with ESMTPSA id c7sm15336956wmq.13.2021.09.20.05.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 05:53:48 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 3/6] commit-graph: turn on commit-graph by default
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        jnareb@gmail.com, pclouds@gmail.com, carenas@gmail.com,
        avarab@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.292.v3.git.gitgitgadget@gmail.com>
 <pull.292.v4.git.gitgitgadget@gmail.com>
 <651e2d526b2a3f6c63c64cfe1f049eef94d39c07.1565721461.git.gitgitgadget@gmail.com>
 <xmqq8rzsdqlq.fsf@gitster.g> <YUfjIjgk2IwcJNI8@camp.crustytoothpaste.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8841729f-9310-c393-caa9-4b209909ea5d@gmail.com>
Date:   Mon, 20 Sep 2021 13:53:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YUfjIjgk2IwcJNI8@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/09/2021 02:25, brian m. carlson wrote:
> On 2021-09-20 at 00:42:57, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> diff --git a/repo-settings.c b/repo-settings.c
>>> index 309577f6bc..d00b675687 100644
>>> --- a/repo-settings.c
>>> +++ b/repo-settings.c
>>> @@ -2,6 +2,8 @@
>>>   #include "config.h"
>>>   #include "repository.h"
>>>   
>>> +#define UPDATE_DEFAULT_BOOL(s,v) do { if (s == -1) { s = v; } } while(0)
>>> +
>>>   void prepare_repo_settings(struct repository *r)
>>>   {
>>>   	int value;
>>> @@ -16,6 +18,8 @@ void prepare_repo_settings(struct repository *r)
>>>   		r->settings.core_commit_graph = value;
>>>   	if (!repo_config_get_bool(r, "gc.writecommitgraph", &value))
>>>   		r->settings.gc_write_commit_graph = value;
>>> +	UPDATE_DEFAULT_BOOL(r->settings.core_commit_graph, 1);
>>> +	UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);
>>
>>
>> This is a "review comment" that is more than 2 years late X-<, but I
>> noticed that this is used to muck with a structure that was
>> initialized by filling it with \0377 bytes.
>>
>> +           /* Defaults */
>> +           memset(&r->settings, -1, sizeof(r->settings));
>>
>> but the structure is is full of "int" and "enum", so apparently this
>> works only on 2's complement architecture.
> 
> This statement is true, but are there systems capable of running Git
> which don't use two's complement?  Rust requires two's complement signed
> integers, and there's a proposal[0] to the C++ working group to only
> support two's complement because "[t]o the author’s knowledge no modern
> machine uses both C++ and a signed integer representation other than
> two’s complement".  That proposal goes on to note that none of MSVC,
> GCC, or LLVM support other options.

A similar proposal [1] is included in the draft of the next C standard 
[2]. As integer representation is implementation defined I believe this 
code has well defined behavior on 2's complement implementations. If an 
enum has no negative members then the compiler may choose an unsigned 
representation but even then the comparison to -1 is well defined. In 
this case I'm pretty sure the enums all have -1 as a member so are 
signed. Using memset() to initialize the struct eases future maintenance 
when members are added or removed and seems to me to be a sensible 
design choice.

Best Wishes

Phillip

[1] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2412.pdf
[2] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2596.pdf

> Personally I am not aware of any modern processor which provides signed
> integer types using other than two's complement.
> 
> [0] http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0907r4.html
> 

