Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731C5C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 13:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiBVNsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiBVNsE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 08:48:04 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A608D6AF
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 05:47:38 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id x3so42006074qvd.8
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 05:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j0KCTvKm/myfYu8PnwtZvIAsxPfZZZNaeQu3O49O1h8=;
        b=Hi0WnoiaU4DynWqrAES09U/rycg2DSLK9xnIlAffkZfwzZsVnN5XTyCLlqImx7Hj77
         ed85Fi7Wcfdlln7xWsrLFO/4r6eb2wrQFEY8768YRTTYTlNqEJ4uSaXNDaYzSxmRQscK
         QDvUExaNuaND+EW9qIpv7XUfpB7UrAf9nbdVA5oUtHZrv7XhEEEvPPadfD9WnYks572X
         TWNT1tN2yQplKkfc+ZQScn34BtjXsLF7lGzPZP4gdTSv1sUYb2JJBtfRvuTBs9PyCfLz
         ebttYb5A+Qo98O4xfN+TRHSI+wR8atdyS2hERfcCY1KUcn7UDEw5lgko2pwgldAUS1jj
         JB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j0KCTvKm/myfYu8PnwtZvIAsxPfZZZNaeQu3O49O1h8=;
        b=Bf68yRWMXS/961I+UnghTDM6cDvme0N1VOeYbfRlUMLIZk5ZJmVD72fUFWsk5R4f4q
         TnndB3X9hPLQht+TjUp68cq8ZtJ58Pg43zE1pe+NPiz89LqZT1FOKlmARHb7RYHcsgir
         RrTfqIMw4Acf8NFqremuKKsEhtNjDN/IZMIqxD4El819mzTFX+H7EQhs++nLNjl3wn8p
         kO/GAwG6OR9fq57VRlBAJgpOgrSp4M5WgzjeYUlZ7GHaYfj7ZBevSKQ1koEwyhyQfKha
         J4pC3lSZvAPCTJHiZ1qy7OeYOw2tg40KvSi34ZaKrU5FmHk0HGL3Riu+O+/WuROHH3Ud
         eVYg==
X-Gm-Message-State: AOAM531ACRkWesp1NYh3PiNM5CmZ6V3TVrYR+mAPcrA9gjICE0sGT5sU
        0NWfYcyXZIstaECWXyI+MYGe+8o9BBRV
X-Google-Smtp-Source: ABdhPJxke+EawZWhmkwbmf4qP29fSdvo2EhEIdT9FwI573BIgTJ3jIjcm2k0YvHktOp/+C+hUSy+Wg==
X-Received: by 2002:ac8:708e:0:b0:2de:23e3:62d7 with SMTP id y14-20020ac8708e000000b002de23e362d7mr8849644qto.35.1645537657510;
        Tue, 22 Feb 2022 05:47:37 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id j15sm26824838qkp.88.2022.02.22.05.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 05:47:37 -0800 (PST)
Message-ID: <d33e3253-dc2f-18a7-04b7-2c8a44405f6b@github.com>
Date:   Tue, 22 Feb 2022 08:47:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] Provide config option to expect files outside sparse
 patterns
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1153.git.1645333542011.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202212100080.4418@tvgsbejvaqbjf.bet>
 <CABPp-BH_fJYWSySh_-Pk5w2j7U2q4CAXi_mEextmmd4YBXOiGg@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BH_fJYWSySh_-Pk5w2j7U2q4CAXi_mEextmmd4YBXOiGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/21/2022 9:23 PM, Elijah Newren wrote:
> On Mon, Feb 21, 2022 at 12:34 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>
>> Hi Elijah,
>>
>> In addition to Stolee's feedback...
>>
>> On Sun, 20 Feb 2022, Elijah Newren via GitGitGadget wrote:
>>
>>> diff --git a/config.c b/config.c
>>> index 2bffa8d4a01..68e877a1d80 100644
>>> --- a/config.c
>>> +++ b/config.c
>>> @@ -1520,6 +1520,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
>>>               return 0;
>>>       }
>>>
>>> +     if (!strcmp(var, "core.expectfilesoutsidesparsepatterns")) {
>>> +             core_expect_files_outside_sparse_patterns = git_config_bool(var, value);
>>> +             return 0;
>>> +     }
>>
>> The `core` section is already quite crowded (for which I am partially
>> responsible, of course).
>>
>> Maybe it would be a good idea to introduce the `sparse` section, using
>> `sparse.allowFilesMatchingPatterns` or `sparse.applyPatternsToWorktree =
>> false`?
> 
> That's a fair point.  At one point Stolee wanted to change from
> core.sparse* to sparse.* -- but by that point we already had users and
> would have had to deal with a bit of a migration story (and wondering
> what to do if people had both old and new config variables set
> inconsistently).
> 
> I'm not sure if it's optimal to try to keep the sparse settings
> together (thus put new ones under core), or try to avoid filling core.
> I guess if we moved towards sparse.* now, it might be an easier
> migration story if we only have two options to move.  And besides,
> we're already split between multiple sections with
> extensions.worktreeConfig, core.sparseCheckout{,Cone}, and
> index.sparse already...so maybe adding one more section would be par
> for the course.  ;-)
> 
> So, I'm leaning towards sparse.expectFilesOutsideOfPatterns, but I'd
> like to hear Stolee's thoughts too.

This has been an interesting discussion.

I think that the existence of core.sparseCheckout[Cone] isn't a good
reason to keep adding to the core.* namespace. Creating a sparse.*
namespace is a good idea. I doubt this will be the last time we want
a config option for some behavior custom to sparse-checkouts (or
virtual environments).

I agree that migrating core.sparseCheckout[Cone] to the sparse.*
namespace would need to be done carefully. In particular, we would
probably need to _always_ understand the core.* versions, but start
to prefer the sparse.* versions if there is a conflict. This work
could be delayed indefinitely, or could be offered as a project for
a new contributor (if we experienced contributors could agree on a
clear path to make this transition).

Thanks,
-Stolee
