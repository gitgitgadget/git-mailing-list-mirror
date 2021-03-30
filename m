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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDDAC433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 12:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D5B561994
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 12:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhC3MC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 08:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhC3MCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 08:02:25 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9313DC061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 05:02:25 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id q12so7952030qvc.8
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 05:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z3dyUgULJ8KAUhh7+pW+WEdu4XHIu3Ylkzt0gCz4IjU=;
        b=BbcfSSIbItQ8Q0vguJR1mPqQdbkG4pkFU8++igRPmO9DAYiJNeDd6t4ZK/SfOg0/qf
         hADLqbeggDumz/CsHInJKm/F9lfE3m/x7I2eDE6zZVGgMahM8Id/AEL6op7sf4idyR4q
         4dDhrxnvwQpnNuVTSwyDj366msmCUhAn+DHEjc8Ggm4ljb37ikERl8HRzL8fJ2an/urt
         Sz2/8knDpP50/Ktcw+CYaRhPLZG3G1A3rPFjIgQ0FeW9Yt66+PSkDQj9K1HxvHIySJsM
         ZnfqvEqtuKyGtEHpm5CYA7NIeAgBLXzUHW1KSP+hG9vTOVv9msoEAqBvhLrRfpR6MsEV
         47EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z3dyUgULJ8KAUhh7+pW+WEdu4XHIu3Ylkzt0gCz4IjU=;
        b=Ou5Um8P6MD6E302TQnUaFPTUpvV4QwUxkPNEodxEsUfTZf19XJFlum++u422eONcXT
         Ki2+G1P8TEQ6u8LGZwUQeT3bYY64i0+pgjI5++yernO7pIJP47YGh8dzfGmBfLiUh+xu
         8WCix/XTnApEjmOPu199KWUXVlTEsW84bAT2R2ihQqZUTpCq39hRQ5hSKmT3uVP0LGiX
         5wuLFzyzdzgXFFmVcRaeQ7mcTocYr5R1kYizppmUZQwXsT8THuVn3gRlDw3U1O3ftB91
         WTK5QU7XzGXqg6IeQhy2q28Tpwt79VKdFxMDe45Bmcp9LHtqh+Y/gaxt/ZVl3Aala687
         O5Ew==
X-Gm-Message-State: AOAM531CpeF7Tf8qN2/tQg8WYiM5o7NLLUheBd6wvKXOHQtpXxpJwYie
        M91jbW8DtXfPkpQmSwZEy0mJfcZDPe5NOQ==
X-Google-Smtp-Source: ABdhPJykO5MwHT4idqWj+B++nB4R2bTaWv+xt9TUDfDGeF4hqaiSWFZNAcnz/Y9Qq1nj7kSC7pgaUg==
X-Received: by 2002:a05:6214:1624:: with SMTP id e4mr30017681qvw.58.1617105744287;
        Tue, 30 Mar 2021 05:02:24 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:51d7:1436:793b:b3c9? ([2600:1700:e72:80a0:51d7:1436:793b:b3c9])
        by smtp.gmail.com with ESMTPSA id i6sm15324764qkf.96.2021.03.30.05.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 05:02:23 -0700 (PDT)
Subject: Re: [PATCH] maintenance: specify explicit stdin for crontab
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Kevin Daudt <me@ikke.info>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20210329210928.561586-1-me@ikke.info>
 <CAN0heSrSNJhy33Wi9Yq8kfnkJEyvQoadyj8joLqHtV+SYPs1sw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <25ea6f26-c829-f63f-77a1-11a28bbe7fc0@gmail.com>
Date:   Tue, 30 Mar 2021 08:02:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSrSNJhy33Wi9Yq8kfnkJEyvQoadyj8joLqHtV+SYPs1sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/30/2021 1:41 AM, Martin Ågren wrote:
> On Mon, 29 Mar 2021 at 23:23, Kevin Daudt <me@ikke.info> wrote:
>>
>> There are multiple crontab implementations that require stdin for
>> editing a crontab to be explicitly specified as '-'.

Thank you for reporting this, especially with a patch!

However, I'm not sure about this adding of '-' being something that
crontab ignores so commonly. My Ubuntu machine reports this:

$ crontab -e -
crontab: usage error: no arguments permitted after this option
usage:  crontab [-u user] file
        crontab [ -u user ] [ -i ] { -e | -l | -r }
                (default operation is replace, per 1003.2)
        -e      (edit user's crontab)
        -l      (list user's crontab)
        -r      (delete user's crontab)
        -i      (prompt before deleting user's crontab)

Is there a way we could attempt writing over stdin, notice the
failure, then retry with the '-' option?

> 
> [...]
> 
>> --- a/t/helper/test-crontab.c
>> +++ b/t/helper/test-crontab.c
>> @@ -17,7 +17,7 @@ int cmd__crontab(int argc, const char **argv)
>>                 if (!from)
>>                         return 0;
>>                 to = stdout;
>> -       } else if (argc == 2) {
>> +       } else if ((argc == 3 && !strcmp(argv[2], "-")) || argc == 2) {
>>                 from = stdin;
>>                 to = fopen(argv[1], "w");
> 
> Would it make sense to make this
> 
>   } else if (argc == 3 && !strcmp(argv[2], "-")) {
> 
> in order to make this test-tool as picky as possible and to only accept
> the kind of usage we want to (well, need to) use? The tests as they
> stand would still pass, which I think argues for us not really needing
> that "argc == 2".
> 
> This would be followed by
> 
>   } else
>           return error("unknown arguments");
> 
> which wouldn't be super helpful if you forgot the "-", but helpful
> enough for an internal test-tool, I guess.
>
> Speaking of usage and hints, there's "Usage: ..." in a comment at the
> top of this file. It should probably be updated either way.

I agree with Martin's review here, too.

Thanks,
-Stolee
