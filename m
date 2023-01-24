Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F73C38142
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 10:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjAXK2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 05:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjAXK2D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 05:28:03 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1DF2ED4F
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 02:28:00 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id kt14so37758155ejc.3
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 02:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tDxlsXKZSW4hgtGZKyd5uMtuhPyH2D4LC8ISpVNkaIU=;
        b=DLKl4DpcfQnI9m2hjSumN+T+88dQt3KIloXrnsf7yzoimo856czzTKSE5262J6KbwL
         GykcJBQF0gZY64L2reLcvqz6b/zuOJuh17P3k1yDq9d905gCXZ6sZ3j7okSHBYH696Oi
         uTLrS9SwcGmxrbLjxJLxDE2Y4WMss3HbqrjEItVvSwuXkF/sZcCAw/aSzX/O2CMcnjWL
         7/fbjETkyrtUjXJ9CXrrojKPoXwT6k0XefAM4W4zMQ/3okFybwWBl/QjPJ4pA1Cg8CAZ
         VKOsBTvwqGMC6LwGUPY3OQWz825xWIJ/R+voriheJUxj+QqtK7mjPnZA0iN/5ypoZXRu
         bPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDxlsXKZSW4hgtGZKyd5uMtuhPyH2D4LC8ISpVNkaIU=;
        b=RvvMand01oY74W3tMtsYuqqMnWsoCq+E+14X4WbFFfcLafaokJ79TOJ5uPoJKCNP/K
         Jupo/gafHxDeE4tU4j6nkq0LUFv2A4mMc1/xek4p609ZDYa4AVNql0PfwcwtYPCU5Ipw
         Xn62QDQObOxsYve7mGasurHKQS+qMOz31X8K2R7Wawv6qlDi3nPKuf9hwxw2jLb+7f97
         cKIvsrlzHreoMz7fL8nqu5dNuL9aB5TK4mScnRuHm5wVV508A0Zs54lRgwZp0xbcwIn9
         8C9KkZMSd/QBllEe+OVVoJnT06rwUmzCSk5rCqnGIc0r6BHXElDYTksuMoKVmL4L0OTf
         hKPg==
X-Gm-Message-State: AFqh2kqXKM6U68Db1Zt6ziLrQdA9dv0FEZdl4wBVEqGo7Yk4QoZU1CY1
        LpdAMSdyrkNvavK8/wdj4nM=
X-Google-Smtp-Source: AMrXdXshE80smh2Fj5KUxnXZQTtvamV++L7xF5kDp9ewspRKBQt5XA5rTS0fhGbCNjpBOZuqiS6pDA==
X-Received: by 2002:a17:907:1042:b0:7c1:5863:f8c4 with SMTP id oy2-20020a170907104200b007c15863f8c4mr28141672ejb.21.1674556078584;
        Tue, 24 Jan 2023 02:27:58 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906069000b007bd0bb6423csm684674ejb.199.2023.01.24.02.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 02:27:58 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <83d27162-59d4-d8c0-fde3-f522630d024d@dunelm.org.uk>
Date:   Tue, 24 Jan 2023 10:27:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 5/9] rebase: add coverage of other incompatible options
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
 <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
 <5e4851e611ee18112bd71939ee900e02a8d590c5.1674367961.git.gitgitgadget@gmail.com>
 <759fb313-ce88-4eb7-96c0-4adeb75ca9f9@dunelm.org.uk>
 <CABPp-BE+wRgjmWknARQpNsdUFjNOz0ND9wgx_-_RTyK+EwJjXA@mail.gmail.com>
In-Reply-To: <CABPp-BE+wRgjmWknARQpNsdUFjNOz0ND9wgx_-_RTyK+EwJjXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 24/01/2023 02:36, Elijah Newren wrote:
> Hi Phillip,
> 
> On Mon, Jan 23, 2023 at 12:08 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Elijah
>>
>> On 22/01/2023 06:12, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>>
>>> The git-rebase manual noted several sets of incompatible options, but
>>> we were missing tests for a few of these.  Further, we were missing
>>> code checks for some of these, which could result in command line
>>> options being silently ignored.
>>>
>>> Also, note that adding a check for autosquash means that using
>>> --whitespace=fix together with the config setting rebase.autosquash=true
>>> will trigger an error.  A subsequent commit will improve the error
>>> message.
>>
>> Thanks for updating the commit message and for the new commits at the
>> end of the series.
>>
>>> Signed-off-by: Elijah Newren <newren@gmail.com>
>>> --- a/builtin/rebase.c
>>> +++ b/builtin/rebase.c
>>> @@ -1224,6 +1224,26 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>>                if (options.fork_point < 0)
>>>                        options.fork_point = 0;
>>>        }
>>> +     /*
>>> +      * The apply backend does not support --[no-]reapply-cherry-picks.
>>> +      * The behavior it implements by default is equivalent to
>>> +      * --no-reapply-cherry-picks (due to passing --cherry-picks to
>>> +      * format-patch), but --keep-base alters the upstream such that no
>>> +      * cherry-picks can be found (effectively making it act like
>>> +      * --reapply-cherry-picks).
>>> +      *
>>> +      * Now, if the user does specify --[no-]reapply-cherry-picks, but
>>> +      * does so in such a way that options.reapply_cherry_picks ==
>>> +      * keep_base, then the behavior they get will match what they
>>> +      * expect despite options.reapply_cherry_picks being ignored.  We
>>> +      * could just allow the flag in that case, but it seems better to
>>> +      * just alert the user that they've specified a flag that the
>>> +      * backend ignores.
>>> +      */
>>
>> I'm a bit confused by this. --keep-base works with either
>> --reapply-cherry-picks (which is the default if --keep-base is given) or
>> --no-reapply-cherry-picks. Just below this hunk we have
>>
>>          if (options.reapply_cherry_picks < 0)
>>                  options.reapply_cherry_picks = keep_base;
>>
>> So we only set options.reapply_cherry_picks to match keep_base if the
>> user did not specify -[-no]-reapply-cherry-picks on the commandline.
> 
> options.reapply_cherry_picks is totally ignored by the apply backend,
> regardless of whether it's set by the user or the setup code in
> builtin/rebase.c.  And if we have an option which is ignored, isn't it
> nicer to provide an error message to the user if they tried to set it?
> 
> Said another way, while users could start with these command lines:
> 
>      (Y) git rebase --whitespace=fix
>      (Z) git rebase --whitespace=fix --keep-base
> 
> and modify them to include flags that would be ignored, we could allow:
> 
>      (A) git rebase --whitespace=fix --no-reapply-cherry-picks
>      (B) git rebase --whitespace=fix --keep-base --reapply-cherry-picks
> 
> But we could not allow commands like
> 
>      (C) git rebase --whitespace=fix --reapply-cherry-picks
>      (D) git rebase --whitespace=fix --keep-base --no-reapply-cherry-picks

(C) is already an error
(D) is currently allowed and I think works as expected (--keep-base only 
implies --reapply-cherry-picks, the user is free to override that with 
--no-reapply-cherry-picks) so I don't see why we'd want to make it an error.

> For all four cases (A)-(D), the apply backend will ignore whatever
> --[no-]reapply-cherry-picks flag is provided.

For (D) the flag is respected, (C) errors out, the other cases 
correspond to the default so it's like saying

	git rebase --merge --no-reapply-cherry-picks

ignores the flag. Arguably it is confusing that the apply backend only 
supports -[-no]-reapply-cherry-picks if --keep-base is given but I'm not 
sure that is a good reason to reject a combination that currently works 
as expected.

Best Wishes

Phillip

> For (A) and (B), the > behavior the apply backend provides happens to match what the user
> is requesting, while for (C) and (D) the behavior does not match.
> So we should at least reject (C) and (D).  But, although we could
> technically allow (A) and (B), what advantage would it provide?  I
> think the results of allowing those two commands would be:
> 
>      1) Confusion by end users -- why should (C) & (D) throw errors if
>         (A) and (B) are accepted?  That's not an easy rule to understand.
> 
>      2) More confusion by end users -- the documentation for years has
>         stated that --reapply-cherry-picks is incompatible with the apply
>         backend, suggesting users would be surprised if at least (B) and
>         probably (A) didn't throw error messages.
> 
>      3) Confusing documentation -- If we don't want to throw errors for
>         (A) and (B), how do we modify the "INCOMPATIBLE OPTIONS" section
>         of Documentation/git-rebase.txt to explain the relevant details
>         of when these flags are (or are not) incompatible with the apply
>         backend?   I think it'd end up with a very verbose explanation
>         that likely confuses more than it helps.
> 
>      4) Excessively complicated code -- The previous attempts to
>         implement this got it wrong.  Prior to ce5238a690 ("rebase
>         --keep-base: imply --reapply-cherry-picks", 2022-10-17), the code
>         would error out on (B) and (C).  After that commit, it would only
>         error out on (C).  Both solutions are incorrect since they miss
>         (D), and I think the code just becomes hard to hard to follow in
>         order to only error out on both (C) and (D) without (A) and (B).
> 
> (#2 and #3 might just be a repeat of the same issue, documentation,
> but it seemed easier to write separately.)
> 
> I think it's simpler for the code, for the documentation, and for end
> users to just error out on all of (A), (B), (C), and (D).
>   --[no-]reapply-cherry-picks is not supported by the apply backend.
> 
> But, given this lengthy email, perhaps I should split out the handling
> of --[no-]reapply-cherry-picks into its own commit and copy some or
> all of the description above into the commit message?
