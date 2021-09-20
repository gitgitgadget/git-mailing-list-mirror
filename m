Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789E3C28CAD
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B91961242
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348264AbhIUCXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238899AbhIUB6M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:58:12 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B59FC11179C
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 11:00:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d21so32091274wra.12
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e2yawZyoiDlcQUiB+suHeTdJw9DLnlMH5ZPNHn+Hm0k=;
        b=OG3OuR2vJ6jfbj0ShiT1lwWTVtDxvvd+02ASEWbT1QkJTvGSJPiKE+T98dI5ZUdQM2
         p7MEYNJaq5CZDQwvZoYgO0j36oRtIOcUsIWtqYrc79JhHaoL1S7vTI69Rm+iD+NPMrTU
         q1tV+39RYXSmVyMbFNmYEI3TiZ4fZl6maJij/JwfCPHDem2jPFbzUPR2Z6/YyBozx9FZ
         MUEvlw4/b23HeytNHdRtAluDySk3EkeJ2TWxvyINiw4vtrHL9I7Egie3TwvpYtxJp2Lf
         k/6EC+Cc6z2d5S/ZwqVBlUkBLZlaLjAvN3buY1PEztZK4/YWkmWryw9tMwhtxXqb1Jel
         Wyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=e2yawZyoiDlcQUiB+suHeTdJw9DLnlMH5ZPNHn+Hm0k=;
        b=m/fhgj642OWQzS9zFR08rRCkJDDIIagcoOPCoaz4424SM9bpGvGcv7apH7Av7kppDW
         J/G7L0GKseuhpwBR54kXPrVxx/p5FHGfoeb+mr/eZsDsPgPLP0stGjueR/n7AxHKnw0j
         rBVdnwzl7gP79lF6Q2eqkWGJl478u4bZAGqTY5FGy2c1kslPl3oqc1j2QhyrVfk0/MXM
         bPFS2bwaEczL2PpI4IMXffi+s7RzN+fMRmA0wNq8CKma5Bc9S4Ip9fzOLgNr17QJfp05
         cBtTVx+b6cLUye1agHQIhP/DmwCBbR0YDy5zJkkzhjR0cZz/XuZT39xQWhWCsVTm3tKB
         OJxA==
X-Gm-Message-State: AOAM530r1UYERjWZY6rqk6EiAgqQY2i+T9uBu+fpN53xno/QxaAvvKsm
        Lg0ltBsc6riI866o3PZS1TjqH/02ueo=
X-Google-Smtp-Source: ABdhPJwnJFRANPIajEUq6ZyMTeXM1Sq5BvPeHbw3uS2mRHygR8e3wult8L1jxqlq2jHiJ35lF/SHig==
X-Received: by 2002:a5d:64e6:: with SMTP id g6mr14537277wri.151.1632160828177;
        Mon, 20 Sep 2021 11:00:28 -0700 (PDT)
Received: from [192.168.1.201] (178.2.7.51.dyn.plus.net. [51.7.2.178])
        by smtp.googlemail.com with ESMTPSA id r9sm9002053wru.2.2021.09.20.11.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 11:00:27 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 3/6] commit-graph: turn on commit-graph by default
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        jnareb@gmail.com, pclouds@gmail.com, carenas@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.292.v3.git.gitgitgadget@gmail.com>
 <pull.292.v4.git.gitgitgadget@gmail.com>
 <651e2d526b2a3f6c63c64cfe1f049eef94d39c07.1565721461.git.gitgitgadget@gmail.com>
 <xmqq8rzsdqlq.fsf@gitster.g> <YUfjIjgk2IwcJNI8@camp.crustytoothpaste.net>
 <8841729f-9310-c393-caa9-4b209909ea5d@gmail.com>
 <8735pzbbtk.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <25817fb9-ec3e-4c26-0dff-a353463867e4@gmail.com>
Date:   Mon, 20 Sep 2021 19:00:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <8735pzbbtk.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/09/2021 14:30, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Sep 20 2021, Phillip Wood wrote:
> 
>> On 20/09/2021 02:25, brian m. carlson wrote:
>>> On 2021-09-20 at 00:42:57, Junio C Hamano wrote:
>>>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>>
>>>>> diff --git a/repo-settings.c b/repo-settings.c
>>>>> index 309577f6bc..d00b675687 100644
>>>>> --- a/repo-settings.c
>>>>> +++ b/repo-settings.c
>>>>> @@ -2,6 +2,8 @@
>>>>>    #include "config.h"
>>>>>    #include "repository.h"
>>>>>    +#define UPDATE_DEFAULT_BOOL(s,v) do { if (s == -1) { s = v; } }
>>>>> while(0)
>>>>> +
>>>>>    void prepare_repo_settings(struct repository *r)
>>>>>    {
>>>>>    	int value;
>>>>> @@ -16,6 +18,8 @@ void prepare_repo_settings(struct repository *r)
>>>>>    		r->settings.core_commit_graph = value;
>>>>>    	if (!repo_config_get_bool(r, "gc.writecommitgraph", &value))
>>>>>    		r->settings.gc_write_commit_graph = value;
>>>>> +	UPDATE_DEFAULT_BOOL(r->settings.core_commit_graph, 1);
>>>>> +	UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);
>>>>
>>>>
>>>> This is a "review comment" that is more than 2 years late X-<, but I
>>>> noticed that this is used to muck with a structure that was
>>>> initialized by filling it with \0377 bytes.
>>>>
>>>> +           /* Defaults */
>>>> +           memset(&r->settings, -1, sizeof(r->settings));
>>>>
>>>> but the structure is is full of "int" and "enum", so apparently this
>>>> works only on 2's complement architecture.
>>> This statement is true, but are there systems capable of running Git
>>> which don't use two's complement?  Rust requires two's complement signed
>>> integers, and there's a proposal[0] to the C++ working group to only
>>> support two's complement because "[t]o the author’s knowledge no modern
>>> machine uses both C++ and a signed integer representation other than
>>> two’s complement".  That proposal goes on to note that none of MSVC,
>>> GCC, or LLVM support other options.
>>
>> A similar proposal [1] is included in the draft of the next C standard
>> [2]. As integer representation is implementation defined I believe
>> this code has well defined behavior on 2's complement
>> implementations. If an enum has no negative members then the compiler
>> may choose an unsigned representation but even then the comparison to
>> -1 is well defined.
> 
> That's informative, thanks.
> 
>> In this case I'm pretty sure the enums all have -1
>> as a member so are signed. Using memset() to initialize the struct
>> eases future maintenance when members are added or removed and seems
>> to me to be a sensible design choice.
> 
> It's really not sensible at all in this particular case, as I think my
> [1] which gets rid of the pattern convincingly argues.

I meant that it was a sensible way to initialize all the struct members 
to -1, I did not mean to comment either way on whether such an 
initialization was sensible. If we can just store the default and then 
update from the user's config that sounds sensible.

Best Wishes

Phillip

> I.e. the only reason it had a memset() of -1 after we'd already memset
> it to 0 was because the function was tripping over itself and setting
> defaults in the wrong order for no good reason.
> 
> I.e. it was doing things like (pseudocode);
> 
>      memset(&data, -1, ...)
>      if_config_is_true_set("x.y", data.x_y);
>      if (data.x_y == -1)
>          data.x_y = x_y_default();
> 
> When we can instead just do:
> 
>      data.x_y = x_y_default();
>      set_if_cfg_key_exists("x.y", &data.x_y);
> 
> Which is how we e.g. handle options parsing, we have hardcoded defaults,
> then read defaults from config, then set options, in that order.
> 
> We don't set options, then check if each value is still -1, if so read
> config etc. Just read them in priority order, doing it any other way is
> just make-work for something that's the equivalent of a simple
> short-circuit || operation.
> 
> Anyway, there are other cases where we need to read something and
> distinguish e.g. false/true from "unset", and there a -1,0,1 tri-state
> serves us well.
> 
> But even in those cases what repo-settings.c was doing of memsetting the
> entire struct to -1 (2's compliment aside) just makes for needlessly
> hard to read code.
> 
> If we've got some members that need -1 defaults we should instead have
> that in an *_INIT macro or equivalent. The pre-[1] repo-settings.c also
> has code like this pseudocode:
> 
>      data.a_b = -1; /* default for a bi-state, not tri-state variable */
>      set_if_cfg_key_exists("a.b", &data.a_b);
>      if (data.a_b == -1)
>          data.a_b = 1; /* on by default */
> 
> Which, urm, you can just do as:
> 
>      data.a_b = 1; /* on by default */
>      set_if_cfg_key_exists("a.b", &data.a_b);
> 
> I.e. the setup for things that never wanted or cared about being set to
> -1 was complicated by them needing to un-set themselves from a -1
> default they never wanted.
> 
> Thus the anti-pattern, yes set defaults for some members to -1, but not
> the entire struct. The only value we should memset a whole bag-of-stuff
> config struct to is 0, as that's the only sensible default & plays well
> with other C semantics.
> 
> 1. https://lore.kernel.org/git/patch-v3-4.5-28286a61162-20210919T084703Z-avarab@gmail.com/
> 
>>
>> Best Wishes
>>
>> Phillip
>>
>> [1] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2412.pdf
>> [2] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2596.pdf
>>
>>> Personally I am not aware of any modern processor which provides signed
>>> integer types using other than two's complement.
>>> [0]
>>> http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0907r4.html
>>>
> 

