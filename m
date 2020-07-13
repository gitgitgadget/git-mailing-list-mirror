Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A68C433E0
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 10:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2766A207F9
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 10:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGsTV3WP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgGMKCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgGMKCe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 06:02:34 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E8DC061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 03:02:34 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so12695489wmh.4
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 03:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hNBAzGuekAvMw7oWZ4ySpAXGUoUjLW/AxSfxk4fx16U=;
        b=sGsTV3WPpUlyhVxKmTCaWzEli1BLKYPV6TGxvxYe6/DGt3I+S0V+FWLAETqYIDsNvT
         U6aq8DHkIaf6ZgqNYrozTdqwjxF7vZ2YvvqLVRcAk3ZV0PIfwni7w44TAZxr8W00k9fy
         NPq9a2VCrN7h1/WsMqyJtXjMtPxdFFqNfA4+1wGqOGgwIDZM9qjdFJ2lYr+GguqLFFAv
         nvJb5LCeLZdDxKoD8UTIpJY6wh3ChnTBLAcnssFCAuLnZKnBu/GSaX8b9hsVPBXugfTK
         rcVRK2cCrppFEK2997f1nLO0YVb3TDa/vXBYbTT/YGlcWB4OzPxQhD+z9w481dmWkGoh
         0FGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hNBAzGuekAvMw7oWZ4ySpAXGUoUjLW/AxSfxk4fx16U=;
        b=r0Agriu+qgvMvBD+Omy0M1l9egMZ3ah03ZA59eBpqR9emdvSWaHtnub6PJjL5GQcQd
         6fXu0cAzpZ0BE+Wfk2ibPTlvz1pUsy6fvzHbJdximrWz19z+zdfaW/jOzu1VUu5nJ1iY
         wBtPZzt6PqlxmXZWdIhbiPI+25dqPRnGuFsFgYJAuzmZU+5aXgwlFe+YG2IjQTXtr0Y0
         IA/HKPBAU1AEZK/1eDSrAYrIzG+VRWQpw/gW0tjExmXDMh9s2Efj4ympkcTCJwGE7Z0I
         GcFCROpo1baDPS5iq2ZFwgtsYFjDyCbGMPDG+4L0y2jSn4gpTJsBczawOtJJB/f1Rrta
         5e0A==
X-Gm-Message-State: AOAM532xi5J6GWxUHgBJTfGI1BfhY3BH/SF0QWJ73SCHXCCSuovNTlNU
        zw2e0BaZIf+PwXL0NK8gucV9QLyy
X-Google-Smtp-Source: ABdhPJwTLVvVl2Ql6n3FyYSmuBtzE27Glang2LJEY6by1d8YbgfneLzA6W9BSRDJKO97ydkfGnZ76A==
X-Received: by 2002:a05:600c:2118:: with SMTP id u24mr19197882wml.133.1594634552545;
        Mon, 13 Jul 2020 03:02:32 -0700 (PDT)
Received: from [192.168.1.201] (130.20.198.146.dyn.plus.net. [146.198.20.130])
        by smtp.googlemail.com with ESMTPSA id l1sm23462863wrb.12.2020.07.13.03.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 03:02:31 -0700 (PDT)
Subject: Re: [PATCH v5 1/5] rebase -i: add --ignore-whitespace flag
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200626095528.117524-1-phillip.wood123@gmail.com>
 <20200626095528.117524-2-phillip.wood123@gmail.com>
 <20200626133714.GB12504@danh.dev>
 <78c32f2d-3af6-1514-51a3-1110531cbb88@gmail.com>
 <20200629141453.GB20303@danh.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e4a440e5-fc10-f22c-bca2-b5cb077f49a6@gmail.com>
Date:   Mon, 13 Jul 2020 11:02:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200629141453.GB20303@danh.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh

On 29/06/2020 15:14, Đoàn Trần Công Danh wrote:
> Hi Phillip,
> 
> On 2020-06-26 15:43:00+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>> +	if (options.type == REBASE_APPLY) {
>>>> +		if (ignore_whitespace)
>>>> +			argv_array_push (&options.git_am_opts,
>>>> +					 "--ignore-whitespace");
>>>> +	} else if (ignore_whitespace) {
>>>> +			string_list_append (&strategy_options,
>>>> +					    "ignore-space-change");
>>>> +	}
>>>> +
>>>
>>> Hm, I've just noticed this by now.
>>> Would it's better if we rewrite it as:
>>>
>>> 	if (ignore_whitespace) {
>>> 		if (options.type == REBASE_APPLY)
>>> 			argv_array_push(&options.git_am_opts,
>>> 					"--ignore-whitespace");
>>> 		else
>>> 			string_list_append(&strategy_options,
>>> 					   "ignore-space-change");
>>> 	}
>>>
>>> Ah, the incoming patches will add more conditions into the:
>>>
>>> 	if (options.type == REBASE_APPLY)
>>>
>>> I'm still not convinced, though.
>>
>> I wanted to keep the subsequent patches as simple as possible. Having to
>> rewrite the if statement in the next patch just clutters it up and makes the
>> real changes introduced by that patch less obvious
> 
> I think the code suggested by Junio may be cleaner ;)

Yes, I'll reroll with Junio's suggestion

> I may write as:
> 
> 	if (ignore_whitespace) {
> 		if (options.type == REBASE_APPLY)
> 			argv_array_push(...)
> 		else
> 			string_list_append(...)
> 	}
> 
> 	if (other_condition)
> 		do_something_else(...)
> 
> I don't know if it's cleaner or not.

It leads to a lot of repetition of ' && options.type == REBASE_APPLY' as
all the other conditions apart from --ignore-whitespace only need
handling for the apply backend here.

> I haven't tried applied it into real code.
> 
>>> Anyway, IIRC, --ignore-whitespace and --ignore-space-change has the
>>> same meaning, I think it's better to use the same option for both
>>> legs, no?
>>>
>>> I can understand the decision to use --ignore-whitespace as keeping
>>> the pass-through behavior of old code, but I think future maintenance
>>> is more important than that.
>>
>> I'm not sure how it affects future maintenance. The two different options
>> are for two different commands so I'm not sure it is worth the effort
> 
> I vaguely remember I was thinking about same option text in both leg
> would make the code easier for reasoning. And we can unify the
> recommendation for both backend. We will never strip
> --ignore-whitespace from git-apply, but it would be easier to always
> answer: "--ignore-space-change should be used to ignore space" when
> someone asks about it.
> 
> Typing this now makes me wonder if we should teach --ignore-space-change to
> git-rebase?

Possibly but not as part of this series which is about improving the
merge backend rather than adding new options to rebase itself

Best Wishes

Phillip

> 
> Thanks,
> 
> -- Danh
> 
>>
>> Best Wishes
>>
>> Phillip
>>
>>> I've tried changing ignore-whitespace to ignore-space-change and run
>>> make test
>>>
>>> It looks good to me (aka nothing failed _in my machine_),
>>> 4/5 and 5/5 is not applied, though.
>>>
>>>>   	if (strategy_options.nr) {
>>>>   		int i;
>>>> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
>>>> index 50e7960702..55ca46786d 100755
>>>> --- a/t/t3422-rebase-incompatible-options.sh
>>>> +++ b/t/t3422-rebase-incompatible-options.sh
>>>> @@ -61,7 +61,6 @@ test_rebase_am_only () {
>>>>   }
>>>>   test_rebase_am_only --whitespace=fix
>>>> -test_rebase_am_only --ignore-whitespace
>>>>   test_rebase_am_only --committer-date-is-author-date
>>>>   test_rebase_am_only -C4
>>>> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
>>>> new file mode 100755
>>>> index 0000000000..4f8a6e51c9
>>>> --- /dev/null
>>>> +++ b/t/t3436-rebase-more-options.sh
>>>> @@ -0,0 +1,60 @@
>>>> +#!/bin/sh
>>>> +#
>>>> +# Copyright (c) 2019 Rohit Ashiwal
>>>> +#
>>>> +
>>>> +test_description='tests to ensure compatibility between am and interactive backends'
>>>> +
>>>> +. ./test-lib.sh
>>>> +
>>>> +. "$TEST_DIRECTORY"/lib-rebase.sh
>>>> +
>>>> +# This is a special case in which both am and interactive backends
>>>> +# provide the same output. It was done intentionally because
>>>> +# both the backends fall short of optimal behaviour.
>>>> +test_expect_success 'setup' '
>>>> +	git checkout -b topic &&
>>>> +	test_write_lines "line 1" "	line 2" "line 3" >file &&
>>>> +	git add file &&
>>>> +	git commit -m "add file" &&
>>>> +
>>>> +	test_write_lines "line 1" "new line 2" "line 3" >file &&
>>>> +	git commit -am "update file" &&
>>>> +	git tag side &&
>>>> +
>>>> +	git checkout --orphan master &&
>>>> +	test_write_lines "line 1" "        line 2" "line 3" >file &&
>>>> +	git commit -am "add file" &&
>>>> +	git tag main
>>>> +'
>>>> +
>>>> +test_expect_success '--ignore-whitespace works with apply backend' '
>>>> +	test_must_fail git rebase --apply main side &&
>>>> +	git rebase --abort &&
>>>> +	git rebase --apply --ignore-whitespace main side &&
>>>> +	git diff --exit-code side
>>>> +'
>>>> +
>>>> +test_expect_success '--ignore-whitespace works with merge backend' '
>>>> +	test_must_fail git rebase --merge main side &&
>>>> +	git rebase --abort &&
>>>> +	git rebase --merge --ignore-whitespace main side &&
>>>> +	git diff --exit-code side
>>>> +'
>>>> +
>>>> +test_expect_success '--ignore-whitespace is remembered when continuing' '
>>>> +	(
>>>> +		set_fake_editor &&
>>>> +		FAKE_LINES="break 1" git rebase -i --ignore-whitespace \
>>>> +			main side &&
>>>> +		git rebase --continue
>>>> +	) &&
>>>> +	git diff --exit-code side
>>>> +'
>>>> +
>>>> +# This must be the last test in this file
>>>> +test_expect_success '$EDITOR and friends are unchanged' '
>>>> +	test_editor_unchanged
>>>> +'
>>>> +
>>>> +test_done
>>>> -- 
>>>> 2.27.0
>>>>
>>>
> 

