Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 258571F461
	for <e@80x24.org>; Tue, 20 Aug 2019 08:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfHTI4b (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 04:56:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55410 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbfHTI4a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 04:56:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id f72so1884596wmf.5
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 01:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3wVhXy7XtEF8LY2AIikgXjb4lWQ9tSHWPYL9T0Y86Yw=;
        b=eeHH1zux5L2KKVCnyXFZF2TWM3uN/UObZFo0sMmS9oJgh6gEUjh44Im7Buo/I7sY5k
         HiKPVQWoKwkR7PMhTLd6OotZRCJHGPjkYuMQTgJGV+h4ueTTQwB6eAUomRzklQaMvoid
         0hYWRTcfHD4wkABaO2PcnurGYRMdt38JgtBm2yW7MsInoefXlOYcwDxpx7fYgcEXw4YI
         jbwkPPHyRNpTmzeIxUGpNDDy6uo7d71GdpQclzJvWck7edakwKQWx+J2jbFWPJUpgdBY
         Q34g5MZvPnvn/6UkYZgoccSCOzk55736THUKRgRCvWhSuNO9mMxmZHDnjbTBpS4WGjTT
         VK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3wVhXy7XtEF8LY2AIikgXjb4lWQ9tSHWPYL9T0Y86Yw=;
        b=dIdQgG6fjMk94XmE/uXliMK+q6VrTE88PiockdlMuqjhCMrKmxXGzhO3zGz9vGnoYP
         8hRl/+zhE41OVMtSVzLc8HgWTnz5t/E8gbbODUz9amfETw3GNIH3k8tAYVO7eLLwgaUP
         tx9mJiC1u/gMcs6gDd5omJ75HJpTEk0q8LiRzmkQtKiGSRcr/127iWGLYIWZEvMGYn/5
         oMCWHXNVhWyelqbKkpyYQakMPYkKaVBtcnEND8/yDmCqP0muXxBggZ8IeJZVcJ9iWu5r
         hiUS4AMVgFEuqJ9pg5I38Ji1ZntHRtTdgWrWnfXrh9tRB2EOJrdP4pqdweRFebTzKhzB
         wJQA==
X-Gm-Message-State: APjAAAURd1WQDGQbX+Y/QBnmB4G7YL9N6H5f4tKaS3qAKHmOh9CFqCaE
        iNGxCw48LixmsYhwOXHFDpA=
X-Google-Smtp-Source: APXvYqxWZUT+F6A1ja2SLmjYXA/ICnUO0VC618PG5T74Vbt/ZaExMahPlBfYHfEomHwyMnS+s8suow==
X-Received: by 2002:a1c:494:: with SMTP id 142mr23894760wme.12.1566291388424;
        Tue, 20 Aug 2019 01:56:28 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-12-34.as13285.net. [92.22.12.34])
        by smtp.gmail.com with ESMTPSA id z8sm17706745wru.13.2019.08.20.01.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 01:56:27 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] apply: reload .gitattributes after patching it
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190818184403.861907-1-sandals@crustytoothpaste.net>
 <20190818184403.861907-3-sandals@crustytoothpaste.net>
 <9b940950-666a-0c4c-58c0-1e61ac9e654c@gmail.com>
 <2c33a668-4c7d-2114-41b1-8907c4384a15@gmail.com>
 <20190820030544.GI365197@genre.crustytoothpaste.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <facdfb93-bbf5-cca7-7970-b68efed7cfd3@gmail.com>
Date:   Tue, 20 Aug 2019 09:56:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820030544.GI365197@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/08/2019 04:05, brian m. carlson wrote:
> On 2019-08-19 at 09:55:27, Phillip Wood wrote:
>> On 19/08/2019 10:41, Phillip Wood wrote:
>>> [...]
>>>> diff --git a/convert.c b/convert.c
>>>> index 94ff837649..030e9b81b9 100644
>>>> --- a/convert.c
>>>> +++ b/convert.c
>>>> @@ -1293,10 +1293,11 @@ struct conv_attrs {
>>>>        const char *working_tree_encoding; /* Supported encoding or
>>>> default encoding if NULL */
>>>>    };
>>>> +static struct attr_check *check;
>>>
>>> I was concerned about the impact adding a file global if we ever want to
>>> multi-thread this for submodules, but looking through the file there are
>>> a couple of others already so this isn't creating a new problem.
>>
>> Doh, I've just realized it was static already - ignore that.
> 
> And I just realized that I didn't read the entire thread before
> responding.  Sorry about that.
> 
>> One thing did occur to me though - does this patch reset attributes like the
>> merge marker length (they're less critical though if there is a conflict
>> after an attribute change it would be nice to have the correct length) or
>> just the ones for filtering files?
> 
> It resets "crlf", "ident", "filter", "eol", "text", and
> "working-tree-encoding".  Things it doesn't reset include "whitespace",
> "export-ignore", "export-subst", "merge", and "conflict-marker-size".
> Of these, I think only the latter two are relevant.
> 
> I'll update that in v5.

Thanks, one other thought I had was that this is really a bug in 'am' 
rather than 'rebase'. There has been some talk of switching the default 
rabase backend to the sequencer so maybe it would be better to test 'am' 
rather than 'rebase' to ensure we still check 'am' is working properly 
after any switch in the rebase backend. (perhaps we should be testing 
rebase and rebase --interactive separately as well to prevent any future 
regressions I'm not sure)

Best Wishes

Phillip

