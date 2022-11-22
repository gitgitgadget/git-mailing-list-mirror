Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5587C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 14:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbiKVOUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 09:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbiKVOUO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 09:20:14 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF9867F7A
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 06:20:13 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bs21so24951337wrb.4
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 06:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y+rysV3XAFTQ8a+rG4/5wEdNI7yNPA1X2LEVynccBVw=;
        b=fZjVO3RXeIsAYYcRZPcAGILxxGMdrBT+QMfkNSg6b0XlvyC4KoI0wNYXE0EKs5KNTJ
         kArlr5DN6KqDAf9lE0CcFepFdRAH/CsdLjGubGpmkF+20wUl+WLBwFK3l2OIC+85bnOr
         4GhBOFHhC6fHamPw+lyj13DCEqKp44+RX751/ThbPYtiW7mBEVpUp4oDFimQuF44cnto
         46Mh/2FJ/3t+Nw3VtC1n2nPaBcWAT3B7WPILLLsCModSm3p0NFQkp2gShSBCYMMtDWfN
         oXg3hlElDsIfxR36+j4UTR0deG+7U3cbXIQf+VRc7z6HmoRJkzHCO7NnyNFkPn8ZTnDS
         9xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+rysV3XAFTQ8a+rG4/5wEdNI7yNPA1X2LEVynccBVw=;
        b=RyjlFtO4i+MmhHSETsRE91LXkgB9oXt4lH3VPtLarebDjrg4IZu3RfJyq697CG9+2U
         NqqO8FItOm1Sp0fVc6qCK+JX486g4Zzix5Ry+foJOXDZ0ds5OAbpGD97FKOqcBPfwneD
         31FIHRFmBFwk697Bb18Pg8NJToh3UUTeaYUyjXypeNP2uNzqeKpmIYUa06WuhZ2tZl8r
         joYOtSQlY1R6s+AB6oDzLBN3B7RlByDVNCb/hWZOrG6I0JKcbnvRlpTunoOEl9vls9Sk
         t8h3PgWZ68u0/8eJoL7+0UiFcX/lxZUqTim8ZJUENdDjSmRER/01mqSVkAlxroVrFE5+
         bG4g==
X-Gm-Message-State: ANoB5pnKc1SrceC+p3w0a3V/QFQwXy/1ccz4jvoEglX5bza7T4L2PqAB
        8j8h0yzQPbWrmyzZrkzPoaQsEnCNy3E=
X-Google-Smtp-Source: AA0mqf5D7qyLUTZs1PmH1icHnXWqMJW8jc1SirGNF3ZWDmOnspZ2dF9l/TdnQbQH8lZoLyyvLNBoYw==
X-Received: by 2002:a5d:42d0:0:b0:241:d8e2:868d with SMTP id t16-20020a5d42d0000000b00241d8e2868dmr5687441wrr.671.1669126811957;
        Tue, 22 Nov 2022 06:20:11 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d668d000000b00236488f62d6sm14199824wru.79.2022.11.22.06.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 06:20:11 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <db3baf6d-02b8-f562-70dd-13d16149e9be@dunelm.org.uk>
Date:   Tue, 22 Nov 2022 14:20:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] range-diff: support reading mbox files
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1420.git.1668536405563.gitgitgadget@gmail.com>
 <pull.1420.v2.git.1668899471058.gitgitgadget@gmail.com>
 <8d40f170-650f-800a-02d7-d279186d5883@dunelm.org.uk>
 <rr7sp534-43o9-7n1o-5700-369n5rprq75p@tzk.qr>
In-Reply-To: <rr7sp534-43o9-7n1o-5700-369n5rprq75p@tzk.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 22/11/2022 07:40, Johannes Schindelin wrote:
> [...]
>> I'm a bit confused by this sed command, I've annotated it with my probably
>> flawed understanding.
>>
>>>        ++	sed -e "/^From: .*/{
>>>        ++		h
>>
>> This stores the From: header in the hold space
> 
> 👍
> 
>>>        ++		s/.*/From: Bugs Bunny <bugs@bun.ny>/
>>
>> This changes the From: header in the pattern space
> 
> 👍
> 
>>>        ++		:1
>>>        ++		N
>>>        ++		/[ -z]$/b1
>>
>> We loop until we find a line that does not end with a space, letter or number
>> adding the lines to the hold space
> 
> I would have _loved_ to match on an empty line, i.e. `/[^\n]$/b1`. But
> that construct is not understood by the `sed` on macOS.

I don't think it matters much but can't you match an empty line with 
/^$/ ? Then you can loop on non-empty lines with /^$/!b1

> I even went so far as to search for the source code of a BSD `sed` (and I
> found it, and modified the code so that it builds on Linux, see
> https://github.com/dscho/sed-bsd) to try a couple of things, but could not
> make it work with any variation of `\n`. Therefore, I settled on expecting
> all the lines in the commit header to end in printable ASCII characters
> between the space and the `z`.
> 
>>>        ++		G
>>
>> This appends the hold space to the pattern space, then the pattern space is
>> printed.
> 
> 👍
> 
>> Doesn't this mean we end up with two From: headers? Is the in-body From:
>> line already present?
> 
> There is no in-body `From:` header because the patch author matches the
> `GIT_AUTHOR_IDENT` that is in effect while running the `format-patch`
> command.
> 
> Let me show you what this `sed` call deals with. In the local test run, it
> modified an `mbox` starting with this:

Thanks for taking the trouble to show the mbox files, I didn't have time 
to run the tests my self yesterday. The processed mbox file looks good.

> 	From 4d39cb329d3ef4c8e69b43859c2e11adb83f8613 Mon Sep 17 00:00:00 2001
> 	From: Thomas Rast <trast@inf.ethz.ch>
> 	Date: Mon, 22 Jul 2013 11:23:44 +0200
> 	Subject: [PATCH 1/3] s/4/A/ + add other-file
> 
> 	---
> 	  file       | 2 +-
> 	  other-file | 0
> 	  [...]
> 
> to a modified `mbox` that starts with this:
> 
> 	From 4d39cb329d3ef4c8e69b43859c2e11adb83f8613 Mon Sep 17 00:00:00 2001
> 	From: Bugs Bunny <bugs@bun.ny>
> 	Date: Mon, 22 Jul 2013 11:23:44 +0200
> 	Subject: [PATCH 1/3] s/4/A/ + add other-file
> 
> 	From: Thomas Rast <trast@inf.ethz.ch>
> 	---
> 	  file       | 2 +-
> 	  other-file | 0
> 	  [...]
> 
>>
>>>        ++	}" <mbox >mbox.from &&
>>>        ++	git range-diff mode-only-change..topic mbox:./mbox.from
>>>        >actual.from &&
>>>        ++	test_cmp expect actual.from &&
>>>        ++
>>>        ++	append_cr <mbox >mbox.cr &&
>>>        ++	test_must_fail git range-diff \
>>>        ++		mode-only-change..topic mbox:./mbox.cr 2>err &&
>>>        ++	grep CR/LF err &&
>>
>> Thanks for adding that
> 
> Thank you for the suggestion to add it!
> 
> And thank you again for modeling how to perform actionable, helpful and
> productive code reviews,

Thanks for your kind words, I glad you found my comments helpful

Best Wishes

Phillip
