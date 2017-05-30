Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5A382027C
	for <e@80x24.org>; Tue, 30 May 2017 21:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbdE3VyB (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 17:54:01 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36576 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbdE3Vx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 17:53:58 -0400
Received: by mail-pf0-f169.google.com with SMTP id m17so83693131pfg.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 14:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NanwFfK7y+SvM39fkU6yQr109yz0knoqn/lrHo5xpnU=;
        b=H7jjIP58IJxBUuVS7crMviq5qErPaPQ1m6gXT61GnJjamOBhX5gMwGeIz+zy2AqTuI
         VbHGEkUyHLO9qxYqaeszIlMzRz1sOrZZhRmjGiDJtXyyXCMeWw/cTaYgrUpSMGqSsqpz
         tiP3GSV/6otlw6OMcwdqdRq83G5jyU4h30cxRu5rK6YZBkp7IMQzoBzHeNWHIR9sOzgy
         2MIG37ulI/hQYukp3sZuMbxpbZJEdF+38Va++dj+vHf8LqX0yIIszhDjqCMw6pD0QHQo
         dNZiAQHtQ4Vf0Z2MnKfAYQN4hCVhORSnk9RvhhiA9zj0dGahF6LhTrOaHlkRACrLlawb
         D42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NanwFfK7y+SvM39fkU6yQr109yz0knoqn/lrHo5xpnU=;
        b=MPvd4EPaN/L1tMrghAJlh8+9++ySSCelQI6zeo3SVHEPhS5lSh/0tb9u5GB6bQ9qD3
         UUeWIr+iQh58SIXh0CRTiD+KoryxxfYY4WB4WhbsCxhO0ZZwVj3mPIbmoErgDkYb/IuW
         lvM/3hWjB8gcOMhmWGIbXolrnuCycrNQWWs17guMOqlehcjDHrh731juIhszMUREcJm7
         ESyIcnxFh3+Hn4dLZBIUxuOjXbLsZyYEyONSuWe13RHq7+2DAhZkIegCpYQ1FQOIIu5V
         y3XRanEeEuEKJJb3F5KEynVDjOTALvnXAuKWpZSWnmv35uZLkGe1aUfTkMJ2QL5naUAZ
         mKvQ==
X-Gm-Message-State: AODbwcAXq90KlwDQ5gxUTAxcGbe/jnMwXnmKngny0Jp6WXuzaoUwYlP5
        faE2sVCIvC3WqaDe//xTFC65758Wv56l
X-Received: by 10.98.236.150 with SMTP id e22mr26033477pfm.48.1496181227663;
 Tue, 30 May 2017 14:53:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 30 May 2017 14:53:47 -0700 (PDT)
In-Reply-To: <24ebb17b-4324-c6ef-7e3a-5576cda3b595@ramsayjones.plus.com>
References: <20170521125814.26255-2-pc44800@gmail.com> <20170526151713.10974-1-pc44800@gmail.com>
 <01e8c552-fd3a-ee05-1ff1-3b3ea0f7feeb@ramsayjones.plus.com>
 <CAGZ79kYbi5QxWAsxdfPkuWEyMt9Qg753sm0vExsKaWyksDVw+Q@mail.gmail.com> <24ebb17b-4324-c6ef-7e3a-5576cda3b595@ramsayjones.plus.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 May 2017 14:53:47 -0700
Message-ID: <CAGZ79kYc9wx23N9quxhuYAf2H1Rm3tGNg_0Ydz0KO4qPH-Kz5w@mail.gmail.com>
Subject: Re: [GSoC][PATCH v5 1/3] submodule: fix buggy $path and $sm_path
 variable's value
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 26, 2017 at 6:10 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 26/05/17 18:07, Stefan Beller wrote:
>> On Fri, May 26, 2017 at 9:31 AM, Ramsay Jones
>> <ramsay@ramsayjones.plus.com> wrote:
>>> Hmm, I'm not sure which documentation you are referring to,
>>
>> Quite likely our fine manual pages. ;)
>>
>>        foreach [--recursive] <command>
>>            Evaluates an arbitrary shell command in each checked out submodule.
>>            The command has access to the variables $name, $path, $sha1 and
>>            $toplevel: $name is the name of the relevant submodule section in
>>            .gitmodules, $path is the name of the submodule directory relative
>>            to the superproject, $sha1 is the commit as recorded in the
>>            superproject, and $toplevel is the absolute path to the top-level
>>            of the superproject. Any submodules defined in the superproject but
>>            not checked out are ignored by this command. Unless given --quiet,
>>            foreach prints the name of each submodule before evaluating the
>>            command. If --recursive is given, submodules are traversed
>>            recursively (i.e. the given shell command is evaluated in nested
>>            submodules as well). A non-zero return from the command in any
>>            submodule causes the processing to terminate. This can be
>>            overridden by adding || : to the end of the command.
>
> I suspected as much, but I was wondering specifically if $sm_path
> had been documented anywhere. I didn't think so, but ...
>
>> As $path is documented and $sm_path is not, we should care about
>> $path first to be correct and either fix the documentation or the implementation
>> such that we have a consistent world view. :)
>
> Sure, but what is that world view? :-D
>
> I suspect that commit 091a6eb0fe did not intend (should not have)
> used $sm_path in that test. If we were to 'fix' that test, would
> it still work?
>
> Back in 2012, the submodule list was generated by filtering the
> output of 'git ls-files --error-unmatch --stage --'; but I don't
> recall if (at that time) git-ls-files required being at the top
> of the working tree, or if it would execute fine in a sub-directory.
> So, it's possible that the documentation of $path was wrong all along.
> ;-)
>
> At that time, by definition, $path == $sm_path. However, you know this
> stuff much better than me (I don't use git-submodule), so ...

Don't take that stance. Sometimes I shoot quickly from the hip without
considering consequences (Figuratively).

In a foreach command I can see value both in the 'displaypath'
(what sm_path would become here) and the 'submodule path'
from the superproject. The naming of 'sm_path' hints at that it ought
to be the 'submodule path'.

>>
>>     $path (as documented) is the name of the submodule directory
>>     relative to the direct superproject (so in nested submodules you
>>     go up only one level).
>>
>> $sm_path on the other hand is not documented at all and yields
>> non-sense results in corner cases.
>
> Hmm, at what point did '$sm_path yields non-sense results' start
> being the case? (perhaps the corner cases need to be fixed first).

Well the corner case is described in the patchs notes.
So that patch would fix it to be consistent with the new world view
(that I have in mind) as I do not know about the 2012 ideas how submodules
ought to behave correctly.

>> With this patch it becomes less non-sensey and could be documented as:
>>
>>     $sm_path is the relative path from the current working directory
>>     to the submodule (ignoring relations to the superproject or nesting
>>     of submodules).
>
> OK.
>
>>                      This documentation also fits into the narrative of
>>     the test in t7407.
>
> Hmm, does it?

After rereading that test, I would think so?

Thanks for keeping discussing this.

So maybe we want to
* keep path=sm_path
* fix the documentation via s/$path/$sm_path/g in that section quoted above.
* Introduce a new variable sm_display_path that contains what this patch
  proposes sm_path to be.
* fix the test in t7407 by checking both sm_path (fixed) as well
  as sm_display_path (what is currently recorded in sm_path)
---
In the next patch:
* Additionally in the rewrite in C, we would do an

    #ifndef WINDOWS /* need to lookup the exact macro */
        argv_array_push(env_vars, "path=%s", sm_path);
    #endif

such that Windows users are forced to migrate to sm_path
as path/Path is case sensitive there. sm_path being documented
value, so it should work fine?

Thanks,
Stefan
