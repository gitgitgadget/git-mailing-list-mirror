Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071B1C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 10:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3C924686
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 10:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRsj+w8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfLRKza (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 05:55:30 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41244 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfLRKz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 05:55:29 -0500
Received: by mail-yb1-f195.google.com with SMTP id b145so552460yba.8
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 02:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gvp/ujNXK6EyresOku+TfIIb9V4hWxGnsO23pfTnMgY=;
        b=pRsj+w8DsHF65M4jz5gxfNpeiwSOKZKbhQeWgm8tzGIuNuZ3c3uQFHMI9NXQr3MuNR
         zDjM6hzGx0ZEI6+wYfYSTg1Rphm7m84k+9Qn0XlWgJUVGn5O8VN5gjF3mtIusV4B4HSl
         PlXHAJN0pPrPDk2GsuASD/GyjMXJidU971hhkvRkIMdLG8gjZ0b6JqklRXysOV9B6gpX
         0ypggaEEQcgL8lxImBHVPxXQ3sr4hmxXSeLUIJ5sVG6rI2SBPckXBk2xnNE4hPAmVdoT
         QnW1WCCsEbod5umZDiNFlEjXXDXYjXs3Js0JBtNPwBfBZOXbqaQwOfUQTREEhr/ZsA3I
         tCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gvp/ujNXK6EyresOku+TfIIb9V4hWxGnsO23pfTnMgY=;
        b=ZO6WKrU04o7iqS7TjHfe1xNPzs5yKpDZlkqmiKjBiZl8A6//Jd/a/UorAi135q4zwt
         72wrWgDT0FO+tGzI9KkAZ4f1YPCpYQaMttHG9MzFKBB61DBGkjY3UnjZjqesA1NuOUFh
         D5DG0DgzGLA7bvB9AMVIyx+tzh9w+yFW072GeuFq2kmWjhyuyrps9a8tCL6NK5XIMwjB
         Y0xgbhBdIIBc1vn+qMmnhG3bSjIEzi2KEPMmNxEoShmLzK3b5Mi1rJPb4vu2VBklPUNo
         cWqM9H1B7wCdbSIb+oJU4MphTAi2548UivWu8NNFG4g6m7qJQI6imyLYjZACgnutc+py
         5XJw==
X-Gm-Message-State: APjAAAUFmL/8VKxtAR/Gnt9m8P6o/MpU/wqZnYr7wVPn0KY7aWYSaSf2
        8FFJyr0yqTP9XevILEbt9jk=
X-Google-Smtp-Source: APXvYqxJvhz4OTXC7T70gaeRb/OXUGj/UiRWnaJBOdu+wewVaQPkQKbpWFThZ01WwK92ZCTYwDSnXg==
X-Received: by 2002:a25:df84:: with SMTP id w126mr1286840ybg.387.1576666528746;
        Wed, 18 Dec 2019 02:55:28 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id n3sm773899ywd.35.2019.12.18.02.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 02:55:28 -0800 (PST)
Subject: Re: [PATCH 2/2] Documentation/git-log: mention that line-log regex
 must match in starting revision
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>
References: <pull.494.git.1576559263.gitgitgadget@gmail.com>
 <4ea4eeae0c1e23221012855168bf6640be93fd4f.1576559263.git.gitgitgadget@gmail.com>
 <1d033204-80fd-25f8-3a80-0cb641953139@gmail.com>
 <xmqq5zieizrb.fsf@gitster-ct.c.googlers.com>
 <147443E8-EA04-45D2-B3BC-D879A5FFECDC@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d8e753ec-2835-331f-99de-35a4a5369b48@gmail.com>
Date:   Wed, 18 Dec 2019 05:55:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <147443E8-EA04-45D2-B3BC-D879A5FFECDC@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/17/2019 10:28 PM, Philippe Blain wrote:
> 
>> Le 17 déc. 2019 à 13:16, Junio C Hamano <gitster@pobox.com> a écrit :
>> Even when you specify <start> or <end> as a line number, they must
>> exist in the starting revision or it would be a fatal error.  If we
>> are clarifying with this patch for completeness, I think we should
>> also mention it together.  
...
>     git log -L 300,2000000085:Documentation/git-log.txt 
> errors out:
>     fatal: file Documentation/git-log.txt has only 239 lines

This case seems important enough to include what it means to "match".

Specifically, the range must match at least one line in the file.

> But 
>     git log -L 300,-2000000085:Documentation/git-log.txt
> does not error out and shows the history for the whole file. Also,
>     git log -L 1,-2000000085:Documentation/git-log.txt
> does not error out and gives the history for the first line.

Negative numbers in the ranges are a bit strange to include, and the
large magnitude you include here seems unnecessary for the test.
However, it appears that we do store signed values in the line-log
machinery:

/* A range [start,end].  Lines are numbered starting at 0, and the
 * ranges include start but exclude end. */
struct range {
	long start, end;
};

Perhaps these should be replaced with an unsigned value instead,
just to be clear that negative values do not make sense in this
context?

Or rather, do we want to enforce start < end if they are to be
valuable? We apparently do assert() this in
range_set_check_invariants() for all that does.

The current behavior of showing only the first line
is a strange byproduct of allowing these odd ranges, but we may
want to keep it for consistency. That would imply we allow
start <= end, and auto-correct these negative values to have
end = start. (This does not fix the 300,-1 case, but that
is strange enough to be considered a bug, right?)

Thanks,
-Stolee

