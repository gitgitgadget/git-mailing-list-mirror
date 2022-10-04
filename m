Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9789C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 14:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJDOKf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 10:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJDOKd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 10:10:33 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B5D5755D
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 07:10:30 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id t4so8944597wmj.5
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 07:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date;
        bh=YlK5u2+PdTwn9Qk7BZnps612P1CrvlJrrLOT5SZrDQs=;
        b=Q0iN4HLe2jIilhW5QW0X6p8m4cCuyhlGmVk4n1P4RdWIVUHlxExl2ivQFIAyiYJrJY
         RxIgakFV7UHSSZbbHNfuSkLT1HmcrLnZ1ef2NFTog2weqHV1inc74i4NN1e9rD/KX9kR
         nAmVAhP4q/hucyJdeXdNSk8Vm+TmIHgmJ08JuFSjDT2aVlOwvH6TpjuoJIjY2JF0DWBq
         4vpZaAW4W8Fik4KOSb+/DfUZQWeXHAm00lhdnt3eAfI57yZysHNZOavu1dYU0U0LMYo+
         LHS8vsnHSM+KU6tZQe9SBkZnJxVD/Er3WqUPFHSCCotEmzUihuqme3X2JxnWpNo9SYC3
         gKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date;
        bh=YlK5u2+PdTwn9Qk7BZnps612P1CrvlJrrLOT5SZrDQs=;
        b=MslwwEbsEDs1Z8wOPAHhXrUMb3hFbqeOibupIQWZ388dfdtD2g2JO1U1w+j9Gi3bXo
         ev/dk20EQ1qFe0i0fIp005y3+9uQzgkuzJptIG6GErlShl7lSwY5BGtOFUP4NayfWVoI
         490KApz+wHYREu+/OY0fVpZIt3XKhdXXKif0egUyYGOZR54V+PUFhNXoAdpOwTbvF3qt
         zefIH3apZTuMppHthOpig2pQdoteHl5fAURqcbs/T3kWRLgLRQ9KwWnbjll572MDayNl
         SNTAPXHiBDBUTEdsigywnAtC43SSkEq28BrG0UDluya+6ZIurGpOS6KrvjSMHZV99SeO
         E33Q==
X-Gm-Message-State: ACrzQf0oFUQddPsxMKKMv4m1FFZBXoocsTOF2KmCeAeuMBmRcx6DVJ5m
        DJuRahR/VXDFo3zphgTcwjkaOl/hwiw=
X-Google-Smtp-Source: AMsMyM6Q/XgB6ytVQjfSRVMStkNilLkz+I/5/TUd1YHIx4ieBSNEi8b+gOZagwF0+ESo7fAKrGpKAQ==
X-Received: by 2002:a05:600c:4f8d:b0:3b4:9f2f:4311 with SMTP id n13-20020a05600c4f8d00b003b49f2f4311mr10041645wmq.17.1664892629068;
        Tue, 04 Oct 2022 07:10:29 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id t23-20020a05600c2f9700b003b483000583sm14716198wmn.48.2022.10.04.07.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 07:10:28 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <003a4462-dd98-9ffb-6bd8-771dd18693e8@dunelm.org.uk>
Date:   Tue, 4 Oct 2022 15:10:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 04/10] evolve: add support for parsing metacommits
Content-Language: en-US
To:     Chris P <christophe.poucet@gmail.com>
Cc:     Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christophe Poucet <poucet@google.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <2e9a4a9bd819785404e8a5343385f4fb2bc06109.1663959325.git.gitgitgadget@gmail.com>
 <e7278794-428d-4aff-e91b-d2e6527f142d@gmail.com>
 <CAN84kKmsFiGm2W+74aBbe=fXjDeK05ujCxNF+wTHGEjEkQwjDw@mail.gmail.com>
In-Reply-To: <CAN84kKmsFiGm2W+74aBbe=fXjDeK05ujCxNF+wTHGEjEkQwjDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris

On 04/10/2022 12:21, Chris P wrote:
>>> This patch adds the get_metacommit_content method, which can classify
>>> commits as either metacommits or normal commits, determine whether they
>>> are abandoned, and extract the content commit's object id from the
>>> metacommit.
>>> diff --git a/Makefile b/Makefile
>>> index cac3452edb9..b2bcc00c289 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -999,6 +999,7 @@ LIB_OBJS += merge-ort.o
>>>    LIB_OBJS += merge-ort-wrappers.o
>>>    LIB_OBJS += merge-recursive.o
>>>    LIB_OBJS += merge.o
>>> +LIB_OBJS += metacommit-parser.o
>>
>> There seems to be a problem with the indent here
> 
> I'm not sure I follow, there's not indentation on that line?

For some reason LIB_OBJS on that line does not line up with the lines 
either side of it in my mailer, but looking at the patch on 
lore.kernel.org it seems fine so I think the problem was at my end.

>>> diff --git a/metacommit-parser.c b/metacommit-parser.c
>>> new file mode 100644
>>> index 00000000000..70c1428bfc6
>>> --- /dev/null
>>> +++ b/metacommit-parser.c
>>> @@ -0,0 +1,110 @@
>>> +#include "cache.h"
>>> +#include "metacommit-parser.h"
>>> +#include "commit.h"
>>> +
>>> +/*
>>> + * Search the commit buffer for a line starting with the given key. Unlike
>>> + * find_commit_header, this also searches the commit message body.
>>> + */
>>
>> There is no explanation in the code or commit message as to why this
>> function is needed. The documentation added in the first commit says
>> that "parent-type" header is a commit header. I think the answer is that
>> this series does not implement that header but uses the commit message
>> instead. That's perfectly fine for a proof of concept but it is
>> precisely the sort of detail that should be described it the commit
>> message and probably flagged up in the cover letter.
> 
> I admit I thought I thought this was part of the header because it
> shows up before
> the blank line before the commit title.

If I create a meta-commit and then run "git cat-file commit" on it I see

tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
parent fd7e455287603d5bb2e3623dc442b592411cbfe9
parent d79ce1670bdcb76e6d1da2ae095e890ccb326ae9
author A U Thor <author@example.com> 1112912113 -0700
committer C O Mitter <committer@example.com> 1112912113 -0700

parent-type c r

i.e. the parent-type comes after the blank line that separates the 
headers from the message

> How do I make this a commit header?

I've left some comments on the patch that creates the meta-commits. 
Since I wrote the above Junio has commented[1] that he prefers the 
commit message approach to adding a new header so I'd leave the creation 
as it is for now and change find_key() just to look at the commit 
message. (I do prefer the idea of a new header as it provides an 
unambiguous way to distinguish meta-commits from normal commits but lets 
see how using the commit message pans out)

[1] https://lore.kernel.org/git/xmqqsfkbqjgz.fsf@gitster.g/

>>> +static const char *find_key(const char *msg, const char *key, size_t *out_len)
>>> +{
>>> +     int key_len = strlen(key);
>>> +     const char *line = msg;
>>> +
>>> +     while (line) {
>>> +             const char *eol = strchrnul(line, '\n');
>>> +
>>> +             if (eol - line > key_len && !memcmp(line, key, key_len) &&
>>> +                 line[key_len] == ' ') {
>>> +                     *out_len = eol - line - key_len - 1;
>>> +                     return line + key_len + 1;
>>> +             }
>>> +             line = *eol ? eol + 1 : NULL;
>>> +     }
>>> +     return NULL;
>>> +}
>>> +
>>> +static struct commit *get_commit_by_index(struct commit_list *to_search, int index)
>>> +{
>>> +     while (to_search && index) {
>>> +             to_search = to_search->next;
>>> +             index--;
>>> +     }
>>> +
>>> +     if (!to_search)
>>> +             return NULL;
>>> +
>>> +     return to_search->item;
>>> +}
>>
>> This function is a useful utility for struct commit_list and should live
>> in commit.c. It could be used to simplify object-name.c:get_parent() for
>> example.
> 
> Done.  I'll defer cleaning up get_parent to a potentially later change to avoid
> muddying up this change too much.

Sure, get_parent() was meant as an example of why the function is useful 
outside of this work, while you're very welcome to clean it up please 
don't feel that you are obliged to.

>> I'll try and take at look at the next couple of patches later in the week.
> 
> Thank you for all the reviews!

You're welcome, I'm excited to see evolve getting some attention again.

Phillip


> -- simply chris
