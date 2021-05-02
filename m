Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B648C433ED
	for <git@archiver.kernel.org>; Sun,  2 May 2021 18:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6BA61352
	for <git@archiver.kernel.org>; Sun,  2 May 2021 18:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhEBSA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 14:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhEBSA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 14:00:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFB7C06174A
        for <git@vger.kernel.org>; Sun,  2 May 2021 11:00:03 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g65so2017760wmg.2
        for <git@vger.kernel.org>; Sun, 02 May 2021 11:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:reply-to:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UsVJLuvc7AWbA/JNeh/R/8BUJpFHCuU/QrOv2YNBQxs=;
        b=plhm9b9hwLsbL/FtuCs9U66SqvgoFNZ3ByRZyCtgwRkywYm9IRC60nIDFd8+Hqr1w6
         gWLrMhj5U54Oazn3Bg/KWuersFv7G7dheiUbjwpEl2WKLcZ3D/nqBJBAsvIk8nlOVt6c
         chZXtuWQybvqVyuU6kMKbc8RXGebMPSDiUUCLprHgSkWFqSBqQSqekUu+zSnuJKcGAqq
         Tg7Xd9ZBW05ev6SPmKVvzy4yqQ4dZBfhk3wSAbIkABqyKeZ7hC9uWSouwjo5wGAisv2q
         b8OZqeNADT79/MmhEaPCKdH8j1iguEiOGPhBCAIbU3W7+/djfC9CJL2bEh9eWVDHB7rQ
         oXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:reply-to:to:cc:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UsVJLuvc7AWbA/JNeh/R/8BUJpFHCuU/QrOv2YNBQxs=;
        b=B7Y3xUke96AlHttQwLbSuvr7m2LZVvYCkHfnQFBWeiEhgSHCLpzUOGqgdzqg/GtdcS
         AgNH0s3xE/9b7F8Upjxl+PCKBwT+cqBmku0DBEsozqE9+Ktilam/TryHHs4cwSfeDT78
         9XchVQbss8Q4uwvz/CDl50R2tHemkE3/GYiKo1jVfAC429sVaBd4GhWD0pJR6alDZIle
         7oZRpL1VO15gkGIMiyckwlhreqG0jaybdLw2Gd8duN76wVLrSapUY2KS8hgRvDsan2EI
         wvzaqYUzWjrYYyrLHJ0xLXhZMSHyv646jEkOzsdFbvZf4ZAJvnP/65eH7bqLQ+SY4UuS
         zrQw==
X-Gm-Message-State: AOAM53099QgzSQvhqk46pl72Zi0aFYjV+qne08sU2wXLRGqZqRpz5inS
        8qaSmgqukjrc5CZ8x6jx0NlgztJVaus=
X-Google-Smtp-Source: ABdhPJwboBmCzadBOzYS9zKMSxnrE2kyH8MImcwthapoquNqRTbN2yXbz/l3YE6okuMlUyL9z+EA+Q==
X-Received: by 2002:a1c:3587:: with SMTP id c129mr16941838wma.80.1619978401926;
        Sun, 02 May 2021 11:00:01 -0700 (PDT)
Received: from [192.168.1.201] (61.22.198.146.dyn.plus.net. [146.198.22.61])
        by smtp.googlemail.com with ESMTPSA id b6sm17959087wmj.2.2021.05.02.11.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 May 2021 11:00:01 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: git diff word diff bug??
Reply-To: phillip.wood@dunelm.org.uk
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>
Cc:     Count of San Francisco <countofsanfrancisco@gmail.com>,
        git <git@vger.kernel.org>
References: <215a2703-7a16-5ebd-41b5-de0830a1cf63@gmail.com>
 <3787BA48-785B-4375-95A0-715D97D0C523@gmail.com>
 <87o8e14b6a.fsf@evledraar.gmail.com>
Message-ID: <c8e51afa-ec67-fd8a-09e5-2111020a5c55@gmail.com>
Date:   Sun, 2 May 2021 19:00:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <87o8e14b6a.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/04/2021 10:45, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, Apr 25 2021, Atharva Raykar wrote:
> 
>> On 20-Apr-2021, at 22:08, Count of San Francisco <countofsanfrancisco@gmail.com> wrote:
>>>[...]
>>> The diff above does not make it clear that the "{+river+}" is really to be appended (or related) to the first line.
>>> I expected the first diff line to look like this:
>>> The fox jumped over the [-wall.-]{+river+} and the rest of the lines are delete lines.
>>>
>>> git diff --word-diff=porcelain file0.txt file1.txt produced this:
>>> diff --git a/file0.txt b/file1.txt
>>> index c8756ba..3413f10 100644
>>> --- a/file0.txt
>>> +++ b/file1.txt
>>> @@ -1,11 +1,2 @@
>>>   The fox jumped over the
>>> -wall.
>>> ~
>>> -Blah1e32
>>> ~
>>> -q432423
>>> ~
>>> -qe23234
>>> ~
>>> - 233
>>> ~
>>> -253
>>> ~
>>> -345235
>>> ~
>>> ~
>>> -53243
>>> ~
>>> -afsfffas
>>> +river.
>>> ~
>>> +  He made it over.
>>> ~
>>>
>>> This is more non-discernable. The git diff --help documentation says
>>> that "Newlines in the input are represented by a tilde ~ on a line
>>> of its own". So a script would see the '~' character and interpret
>>> that as a new line. The script would have mistaken the "+river" for
>>> a different line. The git diff --help documentation does not explain
>>> what to do in this scenario.
>>>
>>> I expected this:
>>>   The fox jumped over the
>>> -wall.
>>> +river.
>>> ~
>>
>> This is also consistent with the behaviour I mentioned above.
>> A script would need to interpret this as:
>> delete "wall"        (this starts the streak of deletions)
>> go to next line
>> delete "Blah1e32"
>> ...
>>
>> and as soon as it sees a '+', that is, an addition, it knows
>> the series of deletions are done with, so it will add "river"
>> to the last line that was common to both, that is,
>> "the fox jumped over the".
>>
>>> Is this a bug? If not, how do I make the distinction that the {+river+} (in the first case) and the +river (in the 2nd case) is really for the first line?
>>
>> I do not think this is a bug, because it does not really
>> deviate from any specified behaviour. But I do see the source
>> of confusion.
>>
>> I hope I could explain that well enough.
> 
> I do think it's somewhere between a "bug" and a "missing feature"
> though.
> 
> The core issue here is that in diff.c we "fake up" the whole word-diff
> mode by essentially taking both sides, splitting them on whitespace, and
> then diffing that. So for A/B like:
> 
>      A: foo bar
>         baz
>      B: foo baz
>         boo
> 
> We diff:
> 
>      A: foo\nbar\nbaz
>      B: foo\nbaz\nboo
> 
> If you insert an extra newline into that stream you'll get different
> results, which is closer to what the Count is expecting here.
> 
> In this case using --word-diff-regex='[^\n]' will produce: >
>      The fox jumped over the [-wall-]{+river+}.
> 
> But the rest of the output isn't ideal, exercise for the user and all
> that.

Yes it's a complete mess as we're matching a character at a time rather 
than words, the only reason it works for the first line is that there 
happens to be some context at the end of the line.

> The bug is arguably that we should be doing this by default, i.e. we
> split up our output into "\n" internally, and arguably confuse that with
> what the user wanted from their input.
> 
> But see bf82940dbf1 (color-words: enable REG_NEWLINE to help user,
> 2009-01-17) which is probably the source of the "bug" here (if any) for
> a trade-off related to that.

Reverting that commit has no effect on the output, looking at 
find_word_boundaries() it has always terminated the match at a newline 
so I'm not sure what the commit message for bf82940dbf1 means when it 
says "Of course newlines can still be matched explicitly.".

To me the problem is not with how the word diff is calculated but how it 
is presented. At the moment it just prints all the deletions followed by 
all the insertions. I think that if following some context it just 
printed the deletions and insertions up to the end of that line and then 
dumped the rest of the deletions and insertions following the line break 
that would give a more readable result. It would need to do something 
similar for deletions and insertions at the beginning of a line that are 
followed by some context before the end of the line.

In general I find it useful that --word-diff ignores the line structure 
of the input, this enables it to show changes to the words in re-flowed 
text without the clutter one sees in a line-by-line diff from moving the 
line breaks. I think the changes above would probably be compatible with 
that.

Best Wishes

Phillip

