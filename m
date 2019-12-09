Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A32C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 18:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F9E2077B
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 18:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j38nloeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfLISX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:23:27 -0500
Received: from mail-yw1-f47.google.com ([209.85.161.47]:46093 "EHLO
        mail-yw1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLISX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 13:23:26 -0500
Received: by mail-yw1-f47.google.com with SMTP id u139so6140688ywf.13
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 10:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gew+J60XGeZWMnmOKJoLDZJhRfWPPQ8kmybFuJX4U0U=;
        b=j38nloeTr/rwSzoaShRDnX69IuSrwM4l7eu/K/DulX1vjIZVu5KNPI/QJ0Kla63QLi
         RudMVdsc4AO2mrhlBfXpCd2E1ITMg94hxgHalitjntr+3qgJY64C2YOd134H73fkPpAj
         cyhgzQVbxXrkF9vIa+ns3cOKqOxIjI9K135ahybIUrBxMGdQ9eXOriRNvHHxNrvWqOUP
         Imz/kyXCsKF56Wrak0Ex8XR/TSzI4m0PR3EpbYiJaQiJqdDCV0mmCi6GA5Lp8OluMJNE
         PRyJJKeyH4YKYf31f2jcU4BaCC6zqrZ3OUF/Tbxzpw4Qtw10MhPnZHA/8+xaGA6dUZK8
         doSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gew+J60XGeZWMnmOKJoLDZJhRfWPPQ8kmybFuJX4U0U=;
        b=mn4J46McSH82jMkxcOHlsmdiBY5J67zDCJ1yX5uyysUS+trEsOxGb9ooV7yTHLv0BM
         tORSOiwgOjEH/TwSkOvH2aAJyb4IApNpcJHJv1dIUJquPOdzxERBDWrj9K3kg4tZ2ygR
         Do5W64gkpF5tbKonx2XvzpKLVll0W9oBh3F1DThvAAmKWTzoA2JbdFxNZ2ZQKoZFVerE
         MP8pV8euCEFFh92b3M2MnsMP1Rwn0WyvLHlse0qvhXUX5sl74+vaPYzUCvQBS20P6nTs
         cpOgwL4Wn6mMPbIuXcHkyGuS+6veTYJqNOZGVk5nU+8bsbrdV/zeQNXYL06L8gPILrN+
         48gw==
X-Gm-Message-State: APjAAAVWPmgfZoDr9WkQnOtEtJxy5St1Gf+8hh29NORzxffc0ezqfL6K
        PatpwRVOLOxZSDH20gu1l/Y=
X-Google-Smtp-Source: APXvYqxS98w8mR7lXoox1k9KJCczjYxH4KZ1UDx+n/6DjE2N2NqBzCBiswP8H0vJlzLC2oLnhIeDGg==
X-Received: by 2002:a0d:db49:: with SMTP id d70mr20906819ywe.370.1575915805197;
        Mon, 09 Dec 2019 10:23:25 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i127sm264122ywe.65.2019.12.09.10.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 10:23:24 -0800 (PST)
Subject: Re: Git Test Coverage Report (Mon. Dec 9)
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <903fcdea-6f08-caf5-77a4-2e82b8585edf@gmail.com>
 <e47b77b4-7b7a-3d59-9e24-934528c5e297@web.de>
 <CAPig+cTrAsn64S0Qm7PdJVFhsquVA3+ugwngLpo1S4yUjMcrGA@mail.gmail.com>
 <58a3e2c4-4c5a-e276-f74e-128438f2ab40@gmail.com>
 <a9c2c409-778c-48e2-e6d5-229eab45a707@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <676dc5c1-5823-ac83-878b-995f3793bfb8@gmail.com>
Date:   Mon, 9 Dec 2019 13:23:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <a9c2c409-778c-48e2-e6d5-229eab45a707@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2019 1:10 PM, René Scharfe wrote:
> Am 09.12.19 um 18:44 schrieb Derrick Stolee:
>> On 12/9/2019 12:19 PM, Eric Sunshine wrote:
>>> On Mon, Dec 9, 2019 at 12:11 PM René Scharfe <l.s.r@web.de> wrote:
>>>> Am 09.12.19 um 16:36 schrieb Derrick Stolee:
>>>>> René Scharfe  0bb313a5 xdiff: unignore changes in function context
>>>>> xdiff/xemit.c
>>>>> 0bb313a5 223)        xchp->i1 + xchp->chg1 <= s1 &&
>>>>> 0bb313a5 224)        xchp->i2 + xchp->chg2 <= s2)
>>>>> 0bb313a5 225) xchp = xchp->next;
>>>>
>>>> Hmm, line 223 *is* exercised by t4015.85.
>>>
>>> This, along with Dscho's[1] review of an earlier coverage report,
>>> makes one wonder if there is some off-by-one error in the reporting
>>> logic, such that it is reporting the wrong lines as not covered.
>>
>> This is definitely possible. I'll see if I can locate the bug in
>> my report-generation code.
>>
>> However, line 222 is here [1]
>>
>> 	while (xchp != xch &&
>>
>> So if this is always false, then the rest of the while condition
>> will not be tested, nor will the body (line 225: xchp = xchp->next;).
> 
> 0bb313a5 also added lines 228 and 229, which are not in the report, so
> xchp != xch must be true at least once (it is, in t4015.85).
> 
> 222)				while (xchp != xch &&
> 223)				       xchp->i1 + xchp->chg1 <= s1 &&
> 224)				       xchp->i2 + xchp->chg2 <= s2)
> 225)					xchp = xchp->next;
> 226)
> 227)				/* If so, show it after all. */
> 228)				if (xchp != xch) {
> 229)					xch = xchp;

Thanks for pointing out that context.

My guess is that gcov is marking the line as uncovered because the &&
operator is on that line. I'm testing [1] by breaking style conventions
and using the following:

				while (xchp != xch
				       && xchp->i1 + xchp->chg1 <= s1
				       && xchp->i2 + xchp->chg2 <= s2)
					xchp = xchp->next;

[1] https://dev.azure.com/git/git/_build/results?buildId=1453
