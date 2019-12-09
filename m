Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53E0C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 17:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8918F2077B
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 17:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOerTPLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfLIRod (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:44:33 -0500
Received: from mail-yw1-f42.google.com ([209.85.161.42]:36779 "EHLO
        mail-yw1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfLIRod (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 12:44:33 -0500
Received: by mail-yw1-f42.google.com with SMTP id u133so6124602ywb.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 09:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fu4GwWFiegLB3kXzAryK7dJxj7LOs64rFW2CQhsD8gI=;
        b=jOerTPLjqGK3If+RLdAM/vWRgSeDxpetUGe7DQM1EqDg7jen//alnUAJ+658pD7U+V
         NSyUvxTw3nooO9wUHhLtMiUnwlsObYvZAfB19yE8UkBLKWinqN5yd7TCAcoyj5mLM9Xn
         CkxCTwrdDJr8/mnyf1Ht+OCq98b6Uwb9zxN9+ihDzPUuXFufGwSQnWFdhGrSU33HEsSy
         EFH/M03MzmIAaD7yNB//7/Jmqv/DVFRTUYVKXmXI6D1MYoCrQHwStX4TeCXkNQsT5LrZ
         it2tTsr/ZT1NIryBAG+1XthMEUTzphOlA+0cXWgPgKVcA26mhrOc8rVQlFOxISQBGKO0
         AdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fu4GwWFiegLB3kXzAryK7dJxj7LOs64rFW2CQhsD8gI=;
        b=RY6CYBu46nibmArbY5di9rREEnHVp2Wc2rKqUHhRfcTV7pDkAoZ7HBL1y4R/0Tm3YG
         0Ck2+jzTKotGQm6DoFO9sAKiGlWZEOSdCJxPVyvP3/hBLuVXYzAklC+uTtRgkTJueULV
         EtlhVp7ldl1JU23PooY86wj5aUa8LowGGqVJ1pnxLotTAV3SusdM7/k2QfUspGXYq1Ra
         ZaeS5b4T/X5WDNw8eftigKL4Z8Wo8MLzWTrQR7cqkY5lAFZy9VbUV8OkqYeMl2uOj9rZ
         6B4KHvRWCvvJJKI5fOY+ZolDyj82LEJtZWayhsX+DkOB+hfvzzGmesc/TG0/0s0ftA/J
         nG3w==
X-Gm-Message-State: APjAAAVNIrJamZOC+A2ngJOci8nkhU/uSdN5FiKCsVM09f0208xEwWeP
        QbTKN5lbBi/wZxHQBeRgYQw=
X-Google-Smtp-Source: APXvYqycsJ33l5M5mQdFpbJ0G5tbCh2Hyq7pBOe/rHarAslOf1t6amTpfnMFpveCRCRnl6P+d8yB6w==
X-Received: by 2002:a81:19d7:: with SMTP id 206mr9207405ywz.153.1575913472097;
        Mon, 09 Dec 2019 09:44:32 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id z23sm257253ywa.24.2019.12.09.09.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 09:44:31 -0800 (PST)
Subject: Re: Git Test Coverage Report (Mon. Dec 9)
To:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <903fcdea-6f08-caf5-77a4-2e82b8585edf@gmail.com>
 <e47b77b4-7b7a-3d59-9e24-934528c5e297@web.de>
 <CAPig+cTrAsn64S0Qm7PdJVFhsquVA3+ugwngLpo1S4yUjMcrGA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <58a3e2c4-4c5a-e276-f74e-128438f2ab40@gmail.com>
Date:   Mon, 9 Dec 2019 12:44:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTrAsn64S0Qm7PdJVFhsquVA3+ugwngLpo1S4yUjMcrGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2019 12:19 PM, Eric Sunshine wrote:
> On Mon, Dec 9, 2019 at 12:11 PM René Scharfe <l.s.r@web.de> wrote:
>> Am 09.12.19 um 16:36 schrieb Derrick Stolee:
>>> René Scharfe  0bb313a5 xdiff: unignore changes in function context
>>> xdiff/xemit.c
>>> 0bb313a5 223)        xchp->i1 + xchp->chg1 <= s1 &&
>>> 0bb313a5 224)        xchp->i2 + xchp->chg2 <= s2)
>>> 0bb313a5 225) xchp = xchp->next;
>>
>> Hmm, line 223 *is* exercised by t4015.85.
> 
> This, along with Dscho's[1] review of an earlier coverage report,
> makes one wonder if there is some off-by-one error in the reporting
> logic, such that it is reporting the wrong lines as not covered.

This is definitely possible. I'll see if I can locate the bug in
my report-generation code.

However, line 222 is here [1]

	while (xchp != xch &&

So if this is always false, then the rest of the while condition
will not be tested, nor will the body (line 225: xchp = xchp->next;).

If it's just an off-by-one error in either direction, then line 224
still is definitely not covered (which would imply that 225 is not
covered, either).
 
> Footnotes:
> 
> [1]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.1911262116100.31080@tvgsbejvaqbjf.bet/
> which, among other seeming anomalies pointed out by Dscho, showed a
> closing brace '}' not covered by a test:
> 
>     > Johannes Schindelin 867bc1d2 rebase-merges: ...
>     > sequencer.c
>     > 867bc1d2 4539) }
> 
>     Not sure why this closing parenthesis isn't covered :-D

That closing paren is the end of a for loop [2] that has an if (*) break; inside.
The closing paren _could_ be uncovered if the "break;" is hit every time.

So, these seem like reasonable lines to report as uncovered. However, I'll
continue to look for a problem in my code as I would hate to cause readers
to stress over an actually-covered line.

Thanks,
-Stolee

[1] https://github.com/git/git/blob/e0522318ac56aeb88f14e72ba2db25912e9972de/xdiff/xemit.c#L223
[2] https://github.com/git/git/blob/083378cc35c4dbcc607e4cdd24a5fca440163d17/sequencer.c#L4539
