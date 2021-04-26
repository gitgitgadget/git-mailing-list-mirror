Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B75C43460
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 10:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C0F61168
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 10:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhDZKCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 06:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbhDZKCE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 06:02:04 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8520C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 03:01:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l4so83496849ejc.10
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 03:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=aQ3Y/bSE1Xl88+esbgOugRov2dy9ADuAjsYJ4OsJKGA=;
        b=n6o7rsOyxr/1lyGQqlexGauKKZNnpc9NcIZsTiJ80MpmepXWmyZQUK3qKR1aBLXvuK
         rQoL2fk6VQYuHw7wz8/VWyq6rSl47H6kAr8BlK6lG90gWyqkNBMCVbuDHzMf6uumffWz
         02BV2sfPbfWlEhMGNv7UGTs8uO3sTpIwz9wRtOYIn4vEg19ZBqzMRwk+S+m7hgSbGE/e
         MoW0MIXlveWTFeCnmYsjcDLicsCWz9gLKqrGjredWnUjpuTBPIr17//ssjJy3Q4G+44w
         jnkPp0GDyHwfJiMcMdGEs9lT0WCKlPfwQdjJ//snWEb+K+C9uzrhh82ZtDiZaSqo0TCH
         GIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=aQ3Y/bSE1Xl88+esbgOugRov2dy9ADuAjsYJ4OsJKGA=;
        b=AHV6PV+9/oFyamCmjXA5aEx0ltS2Ujjy/HV1dJWsFdnrNVxRC3FBWXq0+FgeWCTxSM
         kJ6AFV5/h0p8uEFofsNrCSjhRD/YIkZSY6d1ow2/MFTrWMzs3VEj03SZOqi8DSJJ5ryg
         HSOnHqqwnPEsUpSWBjiwAhQReDQXQ2ANeBzk+82fCo/r/T/JDWuko2njCRYostoLf8L5
         iK4mAiVlscGpRIrnwgI7rSHvAy0i5Ef0ZPJbM7xXeNPHF9bHEhdqzLTm8wqr7Vjt0HlX
         WAwm2qckSZkAH9BhjI7MCYMP250YsGamz40ilYoBJKOEev7Gvojp4uQrG4g5HN4CbfwI
         SBiw==
X-Gm-Message-State: AOAM530aOKFw49TWQ7yiy4d1yklESCobsZ7aV4CoadHY8atK9oaJ2pIk
        HtmdUDPAVZzC8Wybsg5hNk0=
X-Google-Smtp-Source: ABdhPJxiu39B26IjahZrwCyN5oPJQ28XsHhOdSHalwkknQbuncYxGOMAtovwtd6ExhR2SuKrSQUJkg==
X-Received: by 2002:a17:906:7714:: with SMTP id q20mr18080419ejm.167.1619431278401;
        Mon, 26 Apr 2021 03:01:18 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id f13sm11293713ejb.33.2021.04.26.03.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 03:01:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Count of San Francisco <countofsanfrancisco@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: git diff word diff bug??
Date:   Mon, 26 Apr 2021 11:45:11 +0200
References: <215a2703-7a16-5ebd-41b5-de0830a1cf63@gmail.com>
 <3787BA48-785B-4375-95A0-715D97D0C523@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <3787BA48-785B-4375-95A0-715D97D0C523@gmail.com>
Message-ID: <87o8e14b6a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 25 2021, Atharva Raykar wrote:

> On 20-Apr-2021, at 22:08, Count of San Francisco <countofsanfrancisco@gmail.com> wrote:
>> 
>> Hi All,
>> 
>> Here is my "git bugreport":
>> 
>> Thank you for filling out a Git bug report!
>> Please answer the following questions to help us understand your issue.
>> 
>> What did you do before the bug happened? (Steps to reproduce your issue)
>>   git diff --word-diff=porcelain file0.txt file1.txt
>>     or
>>   git diff --word-diff file0.txt file1.txt
>> 
>> What did you expect to happen? (Expected behavior)
>> 
>>   I expected the diff for porcelain or default word-diff to be clear on which lines got removed and which changes belong to which line. I explain more in details below.
>> 
>> What happened instead? (Actual behavior)
>> 
>>   The diff was not clear.
>> 
>> What's different between what you expected and what actually happened?
>> 
>>   The diff made it looked like all the removed text were on one line and a later change in a line look like it was meant for a different line. When in fact, the later changes were for the same line (i.e. the first line). More details below.
>> 
>> Anything else you want to add:
>> 
>> Here are the details to reproduce and more details on how I interpreted the diff. If I am writing a script to highlight changes or to do extra processing for my specific use case, my script would get confused as to what really changed.
>> 
>> file0.txt content:
>> *** Begin Content *** --> this line is not in the actual file but just a marker here for clarity.
>> The fox jumped over the wall.
>> Blah1e32
>> q432423
>> qe23234
>>  233
>> 253
>> 345235
>> 
>> 53243
>> afsfffas
>> *** End Content ****
>> 
>> file1.txt content:
>> *** Begin Content ***
>> The fox jumped over the river.
>>   He made it over.
>> *** End Content ****
>> 
>> git diff --word-diff file0.txt file1.txt produced this:
>> diff --git a/file0.txt b/file1.txt
>> index c8756ba..3413f10 100644
>> --- a/file0.txt
>> +++ b/file1.txt
>> @@ -1,11 +1,2 @@
>> The fox jumped over the [-wall.-]
>> [-Blah1e32-]
>> [-q432423-]
>> [-qe23234-]
>> [- 233-]
>> [-253-]
>> [-345235-]
>> 
>> [-53243-]
>> [-afsfffas-]{+river.+}
>> {+  He made it over.+}
>
> From my experience, git diff prefers to bundle up a series of
> deletions or additions into a group if they all have the same
> word delimiter. The way I would interpret this diff is the steps
> needed to be taken when moving left to right in file0 to get to
> the state of file1, while minimising the number of times file1
> has to be consulted to know what needs to be done next.
>
> Here it would be:
> "Delete all the words from 'wall' upto 'afsfffas', and then add
> 'river.' and ' He made it over'".
>
>> The diff above does not make it clear that the "{+river+}" is really to be appended (or related) to the first line.
>> I expected the first diff line to look like this:
>> The fox jumped over the [-wall.-]{+river+} and the rest of the lines are delete lines.
>> 
>> git diff --word-diff=porcelain file0.txt file1.txt produced this:
>> diff --git a/file0.txt b/file1.txt
>> index c8756ba..3413f10 100644
>> --- a/file0.txt
>> +++ b/file1.txt
>> @@ -1,11 +1,2 @@
>>  The fox jumped over the
>> -wall.
>> ~
>> -Blah1e32
>> ~
>> -q432423
>> ~
>> -qe23234
>> ~
>> - 233
>> ~
>> -253
>> ~
>> -345235
>> ~
>> ~
>> -53243
>> ~
>> -afsfffas
>> +river.
>> ~
>> +  He made it over.
>> ~
>> 
>> This is more non-discernable. The git diff --help documentation says
>> that "Newlines in the input are represented by a tilde ~ on a line
>> of its own". So a script would see the '~' character and interpret
>> that as a new line. The script would have mistaken the "+river" for
>> a different line. The git diff --help documentation does not explain
>> what to do in this scenario.
>> 
>> I expected this:
>>  The fox jumped over the
>> -wall.
>> +river.
>> ~
>
> This is also consistent with the behaviour I mentioned above.
> A script would need to interpret this as:
> delete "wall"        (this starts the streak of deletions)
> go to next line
> delete "Blah1e32"
> ...
>
> and as soon as it sees a '+', that is, an addition, it knows
> the series of deletions are done with, so it will add "river"
> to the last line that was common to both, that is,
> "the fox jumped over the".
>
>> Is this a bug? If not, how do I make the distinction that the {+river+} (in the first case) and the +river (in the 2nd case) is really for the first line?
>
> I do not think this is a bug, because it does not really
> deviate from any specified behaviour. But I do see the source
> of confusion.
>
> I hope I could explain that well enough.

I do think it's somewhere between a "bug" and a "missing feature"
though.

The core issue here is that in diff.c we "fake up" the whole word-diff
mode by essentially taking both sides, splitting them on whitespace, and
then diffing that. So for A/B like:

    A: foo bar
       baz
    B: foo baz
       boo

We diff:

    A: foo\nbar\nbaz
    B: foo\nbaz\nboo

If you insert an extra newline into that stream you'll get different
results, which is closer to what the Count is expecting here.

In this case using --word-diff-regex='[^\n]' will produce:

    The fox jumped over the [-wall-]{+river+}.

But the rest of the output isn't ideal, exercise for the user and all
that.

The bug is arguably that we should be doing this by default, i.e. we
split up our output into "\n" internally, and arguably confuse that with
what the user wanted from their input.

But see bf82940dbf1 (color-words: enable REG_NEWLINE to help user,
2009-01-17) which is probably the source of the "bug" here (if any) for
a trade-off related to that.

