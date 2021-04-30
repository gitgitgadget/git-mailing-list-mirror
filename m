Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EEEC433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 04:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E073C61008
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 04:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhD3EMw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 00:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhD3EMv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 00:12:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFF1C06174A
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 21:12:04 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z6-20020a17090a1706b0290155e8a752d8so1018819pjd.4
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 21:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fST1YsB5IBQnadWnsk5xQQxRGKI5wSGm8R4ggDnEGBQ=;
        b=uY+LwZ3znDhpfGGq+m64Eo7Np1Q+0OV0R+RaPvSrmZIuRdZBDtIzTHm/gM21GJAAB6
         GrkFoFMVSsyeJzj7tXmy9LKixenoXORTX+gNFmuinmzz/vO6YE0uLRlHjuc3EHhbANAz
         Ux4kSQqwdlTjZPfCqWqOKfWc5Z8mG/CyB51BseTqWf2vZ/cdl/7yu/cecd3fLa2vYhXn
         zsdS5eXGNblIHkzA1qWmVK2ONe2WDwx/uyFdfVrllkjcf8i8y6satnqHWm0NXgc34JZB
         faK0vwAbfinwANCAyoBwrVBsqT4w0bnbBI5dURLzf41b4dAlVjL5lacqvF4WZIoeYbDR
         NrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fST1YsB5IBQnadWnsk5xQQxRGKI5wSGm8R4ggDnEGBQ=;
        b=GPGGIfzVRVTOZdwNUTGnfVoJGcNoURfHdK20ZMkJlhT9ri9+EooW0Sac+VIavXcq5l
         doT/i6E31IvGN7BOJo9i657VTk9Dl0KPKJ8Sjv7D/9AWNcuwZsdUpnW2w8yWCfg8iizb
         oXcEtfeP6ETgrYaqbglzJ3z/5SatouTNSb1Yf9oG9pkpoezL7ZbCeUGCI0RTAWaYGwLQ
         AW9mRpEBDRZVnYBxY9YwV04bPcxH3w7EzlFNr+2IT8nF3SD35+jXzilpGLRf8wDxwx18
         pplTSNtFk14exKPP2UnhppxhSUUCwKjm+Mlusp+hpKO1ha5tNns8ehgd3ytzJZNn+Cjp
         9Rvw==
X-Gm-Message-State: AOAM5339njpOGWmaMH571UbaoaxeiCm2+JJA/N/rckN2ZFbaQgOG4rH/
        3nyKzj9ERoanOY3N91NS2jUIxAq8ptua4w==
X-Google-Smtp-Source: ABdhPJyOk+bz7P9u7PwznuCQhYCbccQ/oXIaYdCNnFGNGmNsoGUY9/r2gn4I/HokbP429DZ+N96zMA==
X-Received: by 2002:a17:902:9b97:b029:eb:7a1b:5b88 with SMTP id y23-20020a1709029b97b02900eb7a1b5b88mr3120191plp.77.1619755923014;
        Thu, 29 Apr 2021 21:12:03 -0700 (PDT)
Received: from [110.32.98.18] (c-73-158-43-156.hsd1.ca.comcast.net. [73.158.43.156])
        by smtp.gmail.com with ESMTPSA id t10sm6688992pju.18.2021.04.29.21.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 21:12:02 -0700 (PDT)
From:   Count of San Francisco <countofsanfrancisco@gmail.com>
Subject: Re: git diff word diff bug??
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>
References: <215a2703-7a16-5ebd-41b5-de0830a1cf63@gmail.com>
 <3787BA48-785B-4375-95A0-715D97D0C523@gmail.com>
 <87o8e14b6a.fsf@evledraar.gmail.com>
Message-ID: <5f62472c-aa49-a587-131b-67b359978a3a@gmail.com>
Date:   Thu, 29 Apr 2021 21:12:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <87o8e14b6a.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

It would be nice to get the ability I was expecting as a new feature or 
as the default behavior. If I get to have a preference, I would prefer 
this be the new default behavior. Even as Atharva explained, when the 
addition is encountered you know it is the termination but this is 
really confusing and can lead to too many corner cases for a script to 
handle. It's just not a very natural understanding. For example, take 
the content of file1.txt and simply delete "river." (with the period).

You will now have this word diff:

The fox jumped over the
   [-wall.-]
[-Blah1e32-]
[-q432423-]
[-qe23234-]
[- 233-]
[-253-]
[-345235-]

[-53243-]
[-afsfffas-]{+He made it over.+}

The script would be confused and think that the "wall" from "[-wall-]" 
occurred on a new line in the original text (i.e. file0.txt). Forget 
about the script for a moment, a human reader would be confused by 
looking at a diff and if they were in a code review process, they may be 
confused by which line the original "wall" belonged to.

Also, adding an additional new line as suggested by Ævar sometimes work 
and sometimes does not as I experiment that idea with other diffs. I 
found that if you add an additional "fake" and non-empty new line, the 
word-diff gets what I wanted. For example, if I add "xxx fake new line" 
for every new line, the word diff produces something more intuitive and 
"natural" to understand what really changed.

So, can we get this new behavior added/supported?

Thanks,

Scott


On 4/26/21 2:45 AM, Ævar Arnfjörð Bjarmason wrote:
> On Sun, Apr 25 2021, Atharva Raykar wrote:
>
>> On 20-Apr-2021, at 22:08, Count of San Francisco<countofsanfrancisco@gmail.com>  wrote:
>>> Hi All,
>>>
>>> Here is my "git bugreport":
>>>
>>> Thank you for filling out a Git bug report!
>>> Please answer the following questions to help us understand your issue.
>>>
>>> What did you do before the bug happened? (Steps to reproduce your issue)
>>>    git diff --word-diff=porcelain file0.txt file1.txt
>>>      or
>>>    git diff --word-diff file0.txt file1.txt
>>>
>>> What did you expect to happen? (Expected behavior)
>>>
>>>    I expected the diff for porcelain or default word-diff to be clear on which lines got removed and which changes belong to which line. I explain more in details below.
>>>
>>> What happened instead? (Actual behavior)
>>>
>>>    The diff was not clear.
>>>
>>> What's different between what you expected and what actually happened?
>>>
>>>    The diff made it looked like all the removed text were on one line and a later change in a line look like it was meant for a different line. When in fact, the later changes were for the same line (i.e. the first line). More details below.
>>>
>>> Anything else you want to add:
>>>
>>> Here are the details to reproduce and more details on how I interpreted the diff. If I am writing a script to highlight changes or to do extra processing for my specific use case, my script would get confused as to what really changed.
>>>
>>> file0.txt content:
>>> *** Begin Content *** --> this line is not in the actual file but just a marker here for clarity.
>>> The fox jumped over the wall.
>>> Blah1e32
>>> q432423
>>> qe23234
>>>   233
>>> 253
>>> 345235
>>>
>>> 53243
>>> afsfffas
>>> *** End Content ****
>>>
>>> file1.txt content:
>>> *** Begin Content ***
>>> The fox jumped over the river.
>>>    He made it over.
>>> *** End Content ****
>>>
>>> git diff --word-diff file0.txt file1.txt produced this:
>>> diff --git a/file0.txt b/file1.txt
>>> index c8756ba..3413f10 100644
>>> --- a/file0.txt
>>> +++ b/file1.txt
>>> @@ -1,11 +1,2 @@
>>> The fox jumped over the [-wall.-]
>>> [-Blah1e32-]
>>> [-q432423-]
>>> [-qe23234-]
>>> [- 233-]
>>> [-253-]
>>> [-345235-]
>>>
>>> [-53243-]
>>> [-afsfffas-]{+river.+}
>>> {+  He made it over.+}
>> >From my experience, git diff prefers to bundle up a series of
>> deletions or additions into a group if they all have the same
>> word delimiter. The way I would interpret this diff is the steps
>> needed to be taken when moving left to right in file0 to get to
>> the state of file1, while minimising the number of times file1
>> has to be consulted to know what needs to be done next.
>>
>> Here it would be:
>> "Delete all the words from 'wall' upto 'afsfffas', and then add
>> 'river.' and ' He made it over'".
>>
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
>> I do not think this is a bug, because it does not really
>> deviate from any specified behaviour. But I do see the source
>> of confusion.
>>
>> I hope I could explain that well enough.
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
> In this case using --word-diff-regex='[^\n]' will produce:
>
>      The fox jumped over the [-wall-]{+river+}.
>
> But the rest of the output isn't ideal, exercise for the user and all
> that.
>
> The bug is arguably that we should be doing this by default, i.e. we
> split up our output into "\n" internally, and arguably confuse that with
> what the user wanted from their input.
>
> But see bf82940dbf1 (color-words: enable REG_NEWLINE to help user,
> 2009-01-17) which is probably the source of the "bug" here (if any) for
> a trade-off related to that.
>
