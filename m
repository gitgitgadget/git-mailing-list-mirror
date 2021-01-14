Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49ABC433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 10:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66E623A40
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 10:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbhANKaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 05:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbhANKaV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 05:30:21 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89151C061574
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 02:29:34 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id y187so4207322wmd.3
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 02:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1jnI0huHAWt6FLU0nwX4c9tUJbDrhaNTI9nxS3JeQyw=;
        b=siJi7hWNG35EouQSOLxFaX8plTffOm+xUdpphk57ZoldG4n8+S6ORerYCHHJjKwdMy
         j38h0rIa0LeE9dE0xSEqY3ccGK9cIhRhubwwgIH4kHQC9t3m2FrX/BjqleD7NZeQM51z
         h695yGB9YwS8NsL0d16tKtPiocfE7W2JjvbgRwrd2GxnJdxk4hHavUDJo1mzMx3sPEX0
         I5vRpHLoxNbK9qBxoKWjvDA48ITm/ARHLkqyaUCB5mpmZ+HoK/Jn3iHHZsrE9iL3aXD/
         ueeKaDhQChFGb70uMcnNS9K6lhINTop9FmIRUOTeO1iW99AzLBkEBsSosrhHY3PQhtn7
         NKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1jnI0huHAWt6FLU0nwX4c9tUJbDrhaNTI9nxS3JeQyw=;
        b=JIg5o8Gqgz9G3f8mxvsOFALR+hF/sIfkykUx3G2ddzoLfR+NuaBqQKuLRwKcQzwnQg
         hyOBopaubK/xFTFEjRqj4V5P0gdAb0pzq5zDUb5T1sNq0rKBJ26HehYPOlMFG7qu5fDd
         EDDMNtnYjeYxjAZz/wYt/F21wIAeK90oXrs6eRJENgLoD1zP/IsKVZtGy3HVhtM21lUf
         xKs9VsmH7kEA5tyyx4YylMktOwKUFPuwAU/AqQhuL1MwJJcj1QYhoFGA3RDyU6lfOjd7
         KPO4q/1cbYyG4MNjyph8475mCBkzNXpUBmx3N+TDXRgHUXFFx1+Iq37geUQ4o35J2eJH
         LvLQ==
X-Gm-Message-State: AOAM532+H0EjBJ+w79syzpT9Gn3Ugw1d/KT7wCxUzcYNnEby8VIWkbQJ
        ftGPmGGw9hsgyvlQoGozd0s=
X-Google-Smtp-Source: ABdhPJyH0AMxA3TRusko2Q8DaOR7ttCYu/M6PRZroD0V9vSfcKXu6ahvvpwD95Ki4PWlY6CAhGC1EA==
X-Received: by 2002:a1c:3286:: with SMTP id y128mr3269231wmy.104.1610620173232;
        Thu, 14 Jan 2021 02:29:33 -0800 (PST)
Received: from [192.168.1.201] (112.16.7.51.dyn.plus.net. [51.7.16.112])
        by smtp.googlemail.com with ESMTPSA id u6sm9960250wrm.90.2021.01.14.02.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 02:29:32 -0800 (PST)
Subject: Re: [RFC PATCH 3/9] rebase -i: comment out squash!/fixup! subjects
 from squash message
To:     Charvi Mendiratta <charvi077@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes.Schindelin@gmx.de
References: <20210108092345.2178-1-charvi077@gmail.com>
 <20210108092345.2178-4-charvi077@gmail.com> <X/9DdGnYo7RQz5CE@nand.local>
 <CAPSFM5fuT0QAK9wJ_HuH3t=qThPx7Opwy0GrYieVntJ8A4ARMA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <abc9334d-a9ec-a041-aa04-16cb4f01372a@gmail.com>
Date:   Thu, 14 Jan 2021 10:29:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAPSFM5fuT0QAK9wJ_HuH3t=qThPx7Opwy0GrYieVntJ8A4ARMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Charvi and Taylor

On 14/01/2021 08:27, Charvi Mendiratta wrote:
> On Thu, 14 Jan 2021 at 00:31, Taylor Blau <me@ttaylorr.com> wrote:
>>
>> On Fri, Jan 08, 2021 at 02:53:41PM +0530, Charvi Mendiratta wrote:
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> When squashing commit messages the squash!/fixup! subjects are not of
>>> interest so comment them out to stop them becoming part of the final
>>> message.
>>>
>>> This change breaks a bunch of --autosquash tests which rely on the
>>> "squash! <subject>" line appearing in the final commit message. This is
>>> addressed by adding a second line to the commit message of the "squash!
>>> ..." commits and testing for that.
>>>
>>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
>>> ---
>>>   sequencer.c                  | 25 ++++++++++++++++++++++++-
>>>   t/t3415-rebase-autosquash.sh | 27 +++++++++++++--------------
>>>   t/t3900-i18n-commit.sh       |  4 ----
>>>   3 files changed, 37 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/sequencer.c b/sequencer.c
>>> index 5062976d10..b050a9a212 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -1718,15 +1718,38 @@ static int is_pick_or_similar(enum todo_command command)
>>>        }
>>>   }
>>>
>>> +static size_t subject_length(const char *body)
>>> +{
>>> +     size_t i, len = 0;
>>> +     char c;
>>> +     int blank_line = 1;
>>> +     for (i = 0, c = body[i]; c; c = body[++i]) {
>>> +             if (c == '\n') {
>>> +                     if (blank_line)
>>> +                             return len;
>>> +                     len = i + 1;
>>> +                     blank_line = 1;
>>> +             } else if (!isspace(c)) {
>>> +                     blank_line = 0;
>>> +             }
>>> +     }
>>> +     return blank_line ? len : i;
>>> +}
>>> +
>>
>> OK, so this gets the length of the subject in "body", which is defined
>> as the run of characters before a newline and then a space character.

The length of the subject is the run of characters before a line 
containing only whitespace, "hello\n there" would return 13 "hello\n 
\nthere" would return 5. Looking again at my code there must be a way of 
writing that function that is easier to follow.

>> So
>> "foo bar\n\nbaz" would return 7, but "foo bar\nbaz" would return 11.
>>
>> Makes sense. (Apologies for stating the obvious here, I just had to read
>> this function to myself a couple of times to make sure that I understood
>> what it was doing.)
>>
> 
> Earlier while testing patch, I also went through in the same way and
> now got confirmed as you described here.
> 
>>>   static void append_squash_message(struct strbuf *buf, const char *body,
>>>                                  struct replay_opts *opts)
>>>   {
>>> +     size_t commented_len = 0;
>>> +
>>>        unlink(rebase_path_fixup_msg());
>>> +     if (starts_with(body, "squash!") || starts_with(body, "fixup!"))
>>> +             commented_len = subject_length(body);
>>>        strbuf_addf(buf, "\n%c ", comment_line_char);
>>>        strbuf_addf(buf, _("This is the commit message #%d:"),
>>>                    ++opts->current_fixup_count + 1);
>>>        strbuf_addstr(buf, "\n\n");
>>> -     strbuf_addstr(buf, body);
>>> +     strbuf_add_commented_lines(buf, body, commented_len);
>>> +     strbuf_addstr(buf, body + commented_len);
>>
>> Very nice; the subject gets commented when it starts with "squash!" or
>> "fixup!", but the body remains uncommented. Makes sense to me.
>>
> 
> I agree and Thanks to Phillip, for the patch.
> 
>>> @@ -224,7 +223,7 @@ test_expect_success 'auto squash that matches longer sha1' '
>>>        git cat-file blob HEAD^:file1 >actual &&
>>>        test_cmp expect actual &&
>>>        git cat-file commit HEAD^ >commit &&
>>> -     grep squash commit >actual &&
>>> +     grep "extra para" commit >actual &&
>>>        test_line_count = 1 actual
>>>   '
>>
>> Worth checking that "squash" doesn't appear in an uncommented part of
>> actual? Or better yet, checking that "# squash ..." _does_ appear.
>>
>> I.e., that we would leave this as:
>>
>>      -   grep squash commit >actual &&
>>      +   grep "^# squash" commit >actual &&
>>      +   grep "extra para" commit >actual &&

This test is checking the message that gets committed, not the contents 
of the file passed to the editor. I like the idea of checking that the 
squash! line is indeed commented out, but we'd need to test it with

grep -v squash

Looking at the changes to the tests in this commit it highlights the 
fact that I don't think we ever check exactly what the user sees in 
their editor. We do add such a test for the new `fixup -C` functionality 
in a later patch but perhaps we should improve the test coverage of the 
squash message presented to the user before then.

Best Wishes

Phillip

>>> @@ -342,8 +341,8 @@ test_expect_success C_LOCALE_OUTPUT 'autosquash with custom inst format' '
>>>        git cat-file blob HEAD^:file1 >actual &&
>>>        test_cmp expect actual &&
>>>        git cat-file commit HEAD^ >commit &&
>>> -     grep squash commit >actual &&
>>> -     test_line_count = 2 actual
>>> +     grep first commit >actual &&
>>> +     test_line_count = 3 actual
>>>   '
>>
>> Ditto.
> 
> Okay, I will add it .
> 
> Thanks and Regards,
> Charvi
> 
>>
>> Thanks,
>> Taylor

