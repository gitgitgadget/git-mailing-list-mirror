Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A34C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 09:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD532224A
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 09:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc6Zwz8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbgJOJYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 05:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgJOJYD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 05:24:03 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18B1C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 02:24:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id b127so2758034wmb.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 02:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w9+BvIebESP/hjbm34fduYvR8QiTnzyckd+SO3niGFE=;
        b=Sc6Zwz8OqFtHDOtHcZRZYCMoAjiJ7hfjPdasprsllAG4nwq1v/Yor3mOjZ59lbxFfT
         IvwiQCc8l+iwqtKI+4uAjm6X+StLBfgz+zwIjIteyVtS0IjMmK071qehiLIZW+31aWBE
         SdM+4pRLtwxLC1ypgsbnzdtnLrw6OjWSfavdFrzGvdBHC9FiRSyTw8PY3FgK5Hhq8sOq
         TMdQThCTxwoQyxjk2wG74zejhnqksc0PdjZGSJUG/W/t78mUfjJxzBMNtq4nyvpykMEc
         2TPL/RRmn6MxujFuoZAqVq3R3qK8ayToIAqz4eAQgdw9Y99UFqohYwfxIhB1ngbc/IXA
         kt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=w9+BvIebESP/hjbm34fduYvR8QiTnzyckd+SO3niGFE=;
        b=nbsTmZM8Cux2bK3uiDAWSv5z1xpgUZeYNLRgLYf9DdfknlHOUTyRWGKZORnE5baw2l
         0hamNi++9TF9wo2K7tKr2xEgN2JtunLrsa8ga5vgBUBg+Wgdsw3+gtPUlSnvQs9rJ6Zu
         geWIUGjMQRP/JQguswK744/IBFsh/zUKQLqKgdpwdXLdWK/uh0Dzt1G1FRpzrEaHbN+W
         7RorJK8DIXtz9i8NZsnoWDYOBMhz7BozHAZlSG0FKuzWVikxTXWnTJ97ftPLd9p9UxH8
         x276LnR9f9zBsXPdcl/aOefjsUI1pcWaZA/cH4K5iZaP8+e5RRQ63NOga9rkmr7afWln
         O2ww==
X-Gm-Message-State: AOAM533HtqnCzhGKguN0JAtT6tIq/llug1P0MoGiQlLXKw4oRRCTSPOf
        MhQLOurElYLzSuy9FINY10ebNW6HFfU=
X-Google-Smtp-Source: ABdhPJwcNm7I+Xzp+Z5N0GRY2POwZHiqoSDrCUnKAHtsEIcvc+CXuzIZyKB1cElICYZC37UEkCfDAQ==
X-Received: by 2002:a1c:6788:: with SMTP id b130mr3213053wmc.91.1602753840864;
        Thu, 15 Oct 2020 02:24:00 -0700 (PDT)
Received: from [192.168.1.240] (48.45.90.146.dyn.plus.net. [146.90.45.48])
        by smtp.gmail.com with ESMTPSA id u15sm3525185wrm.77.2020.10.15.02.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 02:24:00 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy] Introduction
To:     Sangeeta NB <sangunb09@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        phillip.wood@dunelm.org.uk, kaartic.sivaraam@gmail.com
Cc:     git@vger.kernel.org
References: <CAHjREB4gsyOrdnhp0_9rs0wv5q5H47-3RcB3fm5NY+L=3SYnMA@mail.gmail.com>
 <22e3d737-8621-9f20-307e-fc4c2a47ec0c@gmail.com>
 <CAHjREB59HjZAs98wMPtMANcHUaXGou7CYg9vAacc3m4uz1yUug@mail.gmail.com>
 <7d691f37-b8b7-510d-ba46-51a4a7587226@gmail.com>
 <CAHjREB6j6BqZ49wX5uqEOiysTAm8Oo7N=EFpcoovWKkBghBjxQ@mail.gmail.com>
 <xmqq362jsahk.fsf@gitster.c.googlers.com>
 <CAHjREB4Qw78xS-T=LA80yVf_u3=Hbpxg5tqBnP1QK44FRkBFOQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3c0bf417-b3d5-b615-c605-49a5d8be4e06@gmail.com>
Date:   Thu, 15 Oct 2020 10:23:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHjREB4Qw78xS-T=LA80yVf_u3=Hbpxg5tqBnP1QK44FRkBFOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sangeeta

On 14/10/2020 16:52, Sangeeta NB wrote:
> Hey everyone,
> 
> I created a PR at gitgitgadget here[1] but it is failing at three
> tests of git rm[2].  I looked at the behavior of git status at some
> other places( by pausing  'git diff HEAD with dirty
> submodule(untracked)' in t/t4027-diff-submodule.sh and looking at `git
> status` behavior)  but it was working perfectly fine(was giving what
> output was expected). But here[2] I couldn't understand why is it
> failing. Can someone please have a look at the PR and give me some
> pointers? I know I am asking way out of too much but I tried a lot on
> what could have been missing but couldn't find anything.

I've spent some time looking at it and I cannot understand what is going 
on :-( I think it may possibly be something to do with that test looking 
at a nested submodule and the options not being properly propagated down 
to that submodule - it might be worth looking at the diff code that 
handles submodules.

I've got a fixup which I'll post after this which gets rid of the global 
flag and instead uses a flag in struct diff_options. I had a quick look 
through the test changes and I thinking it would be worth considering if 
some of them should instead be changed to pass --ignore-submodules=none 
rather than changing the expected result.

Best Wishes

Phillip

> 
> [1] https://github.com/gitgitgadget/git/pull/751
> [2] https://github.com/git/git/blob/master/t/t3600-rm.sh#L691
> 
> Regards,
> Sangeeta
> 
> On Mon, Oct 12, 2020 at 9:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Sangeeta NB <sangunb09@gmail.com> writes:
>>
>>> A fix for making this as the default behaviour can be:
>>>
>>> --- a/diff.c
>>> +++ b/diff.c
>>> @@ -422,6 +422,7 @@ int git_diff_ui_config(const char *var, const char
>>> *value, void *cb)
>>>          if (git_color_config(var, value, cb) < 0)
>>>                  return -1;
>>>
>>> +       handle_ignore_submodules_arg(&default_diff_options, "untracked");
>>>          return git_diff_basic_config(var, value, cb);
>>
>> This function is called for each and every element of configuration
>> item in your ~/.gitconfig and .git/config; by definition, the
>> default behaviour is what is used when the user did not specify
>> anything so what is usually done is to do that kind of defaulting
>> before the code calls git_config() with a callback function like
>> this.
>>
>> And more importantly, the users may have
>>
>>      [diff] ignoresubmodules=<value>
>>
>> in their configuration file.  After calling handle_ignore_submodules_arg()
>> with the value the user desires, the above code will overwrite it with
>> a hardcoded default---at that point that is no longer "the default"
>> to be used when the user didn't specify.
>>
>> I am wondering if the init_diff_ui_defaults() function is the right
>> location to add the above call.
>>
>>>   }
>>>
>>> But this would also involve a lot of changes in the way tests are
>>> written as 12 out of 19 tests in t4027-diff-submodule.sh failed after
>>> adding this patch.
>>
>> If the tests expect that the -dirty suffix is added at the end of
>> "Subproject commit 2f256705..." when the submodule directory has a
>> untracked file, it is expected that such tests need to be updated
>> to the new world order you are introducing, which is "just like 'git
>> describe --dirty' does not consider having an untracked file does not
>> make otherwise clean checkout a dirty one, 'git diff' should not
>> show that a submodule is dirty in its output if its working tree has
>> an untracked file but is otherwise clean".
>>
>>
>>
>> What follows is a note for more experienced developers, but I notice
>> that over the years, we seems to have done a shoddy job adjusting
>> the implementation in diff.c file in the hope of adding support to
>> work in multiple repositories; most file-scope static globals like
>> default_diff_options and diff_detect_rename_default are still only
>> read while in the main repository, yet repo_diff_setup() pretends as
>> if an invocation of the diff machinery in a different repository can
>> use settings that are repository specific.  Again, this is not
>> something you need to be worried about.
