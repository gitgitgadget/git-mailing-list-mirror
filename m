Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DF3C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 18:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567FD60EBB
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 18:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbhI0SDl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 14:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbhI0SDk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 14:03:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BD4C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 11:02:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r23so28075862wra.6
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 11:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D+TtMZZ87zs773SmQajI6/XSySlCUDMKFdw2hgYH5wY=;
        b=hsg+vZr8SF9jMQ6EZ7e7WDysTcw8xBwXKLrUITRPhiTajebihTG6NcNiwkG+V8gBhF
         NTW5YCEtsLiHpPRYCpAbBQi/tNlULQ75485+dRfs9EHBPNV1tnwN6FphiLplIvb8ugiE
         GtEuuLKjPWBzSKlvwIBMCFDAKa76GZRvzUgOyMgXdAiunaQfTSxpQYkPngyoWnX15sao
         6irR+hwc8HtBBBbmUIzTkwRcZTb4GWu2vO2ch0nrgMxqpxiHrqzsYBF4H/etMuPJRQPs
         yMsGo2VtcnqzeWiaxJU98n6igCn5k2qowCJwc7sHWzmlnJCEqFB491IDaTSUVr9782tq
         hTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=D+TtMZZ87zs773SmQajI6/XSySlCUDMKFdw2hgYH5wY=;
        b=0hYXKALO210mYB9SjZQk+7Bni75A5XKntDTAXYJJL/IoO/xWbsXCIzTzrK6CPzcZrO
         0hIYzTfmQXlKnFnJkBTVxQu53M7BUB17MxC5aeamkunxGDNTevSMGme9OE1Im+kzdQ75
         rdvzc60bHnXfsHcl/LyV/FaLObQ4gTKrWDFjBZQIqtPlw/ejvIor1PsTdIMYkbUxUXRg
         YQ3saLpKRLDpW6uUpTxAHDcocis3zdBXwWkwzeS7InmPgOXl4HxlDAeds0QYeyPICTm2
         iE46WkyXN4zdlTs/Cw5UW9oQ07Ds7ZM2XSvmqVIRYvS+4gjpnhbeMZ/4C9Rbi5qfCBNq
         l1nQ==
X-Gm-Message-State: AOAM531ax42VimgxFOUZhysAjFc1BLvdvn8n11euaC8NoER5+YMBzjZW
        x/C+uwI+K7vaUy1XA0Pf2hM=
X-Google-Smtp-Source: ABdhPJxXchO9qgLPzibBaajkEFBbWGUWGbGj1aoXpEkt1X3b2IYp885WK3rAy0GaoRNNK69crMsASA==
X-Received: by 2002:adf:f4ca:: with SMTP id h10mr1390655wrp.159.1632765721120;
        Mon, 27 Sep 2021 11:02:01 -0700 (PDT)
Received: from [192.168.1.201] (178.2.7.51.dyn.plus.net. [51.7.2.178])
        by smtp.googlemail.com with ESMTPSA id d24sm192991wmb.35.2021.09.27.11.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 11:02:00 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/8] Makefile: generate a hook-list.h, prep for
 config-based-hooks
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
 <8d2ccf02-09ad-3876-9c9f-2dd79f9221bc@gmail.com>
 <87pmsu1eao.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6e7d5945-d64f-9511-9668-b453c20c086c@gmail.com>
Date:   Mon, 27 Sep 2021 19:01:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87pmsu1eao.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/09/2021 11:38, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Sep 27 2021, Phillip Wood wrote:
> 
>> On 26/09/2021 20:03, Ævar Arnfjörð Bjarmason wrote:
>>> This series is an incremental restart of the now-ejected
>>> es/config-based-hooks and ab/config-based-hooks-base topics. See [1]
>>> for a summary of the plan and progression.
>>> In v2 the "sed" invocation that generates the new hook-list.h has
>>> been
>>> changed to be portable under POSIX. See the thread starting at
>>> https://lore.kernel.org/git/92471ff9-7573-c3e4-e9fd-63a5cbf5738f@gmail.com/;
>>> The portability issue is AFAICT theoretical in that any "sed"
>>> command
>>> I've tried accepts the old version (I tried the large list of OS's
>>> listed in [2]), but better safe than sorry.
>>> Other changes:
>>>    * I noticed that the run-command.h inclusion in transport.c become
>>>      redundant, I removed that and validated the other ones that have
>>>      the new hook.h, they all still need run-command.h.
>>>    * A whitespace change in v1 in a change to the Makefile makes the
>>>      diff for 8/8 easier to read.
>>> 1. http://lore.kernel.org/git/cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com
>>> 2. https://lore.kernel.org/git/87fstt3gzd.fsf@evledraar.gmail.com/
>>> [...]
>>> 8:  80aae4d5c13 ! 8:  7420267ce09 hook-list.h: add a generated list of hooks, like config-list.h
>>>       @@ Makefile: XDIFF_LIB = xdiff/lib.a
>>>         generated-hdrs: $(GENERATED_H)
>>>               @@ Makefile: git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS)
>>> $(GITLIBS)
>>>       + 		$(filter %.o,$^) $(LIBS)
>>>                help.sp help.s help.o: command-list.h
>>>       ++hook.sp hook.s hook.o: hook-list.h
>>>               -builtin/help.sp builtin/help.s builtin/help.o:
>>> config-list.h GIT-PREFIX
>>>       -+hook.sp hook.s hook.o: hook-list.h
>>>       -+
>>>        +builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook-list.h GIT-PREFIX
>>
>> This is billed as a whitespace change above but this line has actually
>> changed since the last version - was that intentional?
> 
> I think you're mistaken here,

Yes you're right, looking more closely it is a context line in the range 
diff that has changed, sorry.

> it is a whitespace-only change to the
> end-state, but the diff and range-diff are confusing. If I diff the two
> Makefiles I end up with when applying v1 and v2 I get:
> 
> @@ -2217,7 +2210,6 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
>   		$(filter %.o,$^) $(LIBS)
>   
>   help.sp help.s help.o: command-list.h
> -
>   hook.sp hook.s hook.o: hook-list.h
>   
>   builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook-list.h GIT-PREFIX
> 
> I.e. only the line between the old command-list.h and new hook-list.h
> line is gone.
> 
> But the diff for v1 is D/A/A/A and for v2 A/D/A (D = Deletion, A =
> Addition).
> 
> I.e. it's one of those times when "git diff" produces a valid diff, and
> one that's actually smaller than couldu have been produced with a
> v2-like diff given the change in v1.
> 
> As an aside I've sometimes wished we had a --diff-algorithm=maximal or
> something, i.e. there's a lot of cases where by just adding one line to
> the diff you can produce a bigger but IMO less confusing one.

Yes especially when it splits the diff just to keep an empty line or 
closing brace as context even though the line itself is not really 
interesting. Python's diff-lib has an option to ignore "junk" when 
determining which lines are unchanged, I keep meaning to see how it 
affects the diff but have never got round to it (the library uses a 
different slower algorithm for calculating the diff as well).

Best Wishes

Phillip

> 
> In any case, the end state looks better & the diff for v2 is more
> intuitive to look at.
> 
>>>         builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
>>>         	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
>>>       @@ generate-hooklist.sh (new)
>>>        +static const char *hook_name_list[] = {
>>>        +EOF
>>>        +
>>>       -+sed -n -e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}; x' \
>>>       ++sed -n \
>>>       ++	-e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}' \
>>>       ++	-e 'x' \
>>>        +	<Documentation/githooks.txt |
>>>        +	LC_ALL=C sort
>>>        +
>>
>> The sed change looks good
> 
> Thanks for confirming.
> 

