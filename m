Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15130C6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 14:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjCMOUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 10:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjCMOUv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 10:20:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9A71AD
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 07:20:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id az3-20020a05600c600300b003ed2920d585so1154003wmb.2
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 07:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678717248;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1SLIP61h88wKjZvJ+ksSNfTmzoIYdjjrYGBkmQvjOPU=;
        b=S2Ql/OppWiswcUdZrBdz9om+FqNQCEKBU0cVtWVpP+vJRCVSS0MB6ddzfyvqUhRVlS
         rUrEnbqpuWIZslD2G7PCTpRjp3NRU0vBYMG3agr6rybvz3LonM+gkWuLrM6wZZ4QGf7P
         A6SXFh40idFJfg8erB+M24hBpbWkSGic0sCZT3eAzyzkoiGt3USd/g4YMNvmyP9h9kBI
         EJi3CIW3VrWOB7oo6BrKbYD8E8jqnyO5OvaH3e4wxJD8uYay9iefX2cqTSgR1uBlIcVZ
         1nSBKKTP60HF5heCVxd8J/0QufqYJkiUT4wpnCfzMgM+CdolUlwY8FmgaAdoMUcQKaaA
         jZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678717248;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SLIP61h88wKjZvJ+ksSNfTmzoIYdjjrYGBkmQvjOPU=;
        b=LzQAWWQYCwYmoDxbqFAjr5AkDZgPGsAEknpJvo/Kvv+SE+dAy/JhBWW83MUr+5Lfxd
         R/qmEObP7ohk8eR9iYFKd4mrRUTOPhm3RqegJ2mTeQpGf59A9cl8cz/rimx2gDlwPKru
         LH278vYXvgmKzcj8O3rkK661BESamTFiGgaiZQnLXlW7VMsw/CkiYy6W1Kd9BczqKSFi
         sTx4lx+MPRP6RYJZ+Vh2ulpyVXAjO1+dVtyEjeoOACJMIoxTsUuhplPwIZLHOAIexfQR
         306gb/zRDhdJ/yL4iGUE1mIBCkcpB2o4u87DBQKawBFjEhbhDGvPSX+tt2zRoFqsI0vW
         DNww==
X-Gm-Message-State: AO0yUKWLrg68mg0s3zcSCdo/FSoh3D6m0YO+NjBemQYk1MlQNXuOTJbP
        h6UwgoYaYWxpcnd1KGYnvJw=
X-Google-Smtp-Source: AK7set8VztqccF4UYo0YbXZacg5+8DggtKuzORW0cvHKZv9w3V+//kG8S7GrAWdqd1NaicbvO2L15Q==
X-Received: by 2002:a05:600c:458f:b0:3eb:4162:7344 with SMTP id r15-20020a05600c458f00b003eb41627344mr11521428wmo.22.1678717248471;
        Mon, 13 Mar 2023 07:20:48 -0700 (PDT)
Received: from [192.168.1.212] ([90.248.23.119])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c2cce00b003df7b40f99fsm10023896wmc.11.2023.03.13.07.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 07:20:48 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <f8dc5bd3-b325-1e11-6e2d-6d202271f9ff@dunelm.org.uk>
Date:   Mon, 13 Mar 2023 14:20:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 3/3] rebase: add a config option for --rebase-merges
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230225180325.796624-4-alexhenrie24@gmail.com>
 <1021e6d0-0cd0-d92c-4cb3-45dbf2f6626e@dunelm.org.uk>
 <CAMMLpeRfD+81fsEtvKFvVepPpwYm0_-AD=QHMwhoc+LtiXpavw@mail.gmail.com>
 <5551d67b-3021-8cfc-53b5-318f223ded6d@dunelm.org.uk>
 <CAMMLpeTUbG+b89acan-GXGS4H=J7aQupbK8zdxwNg__U_We2dw@mail.gmail.com>
In-Reply-To: <CAMMLpeTUbG+b89acan-GXGS4H=J7aQupbK8zdxwNg__U_We2dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 12/03/2023 20:57, Alex Henrie wrote:
> On Tue, Mar 7, 2023 at 9:23 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> 
>> On 04/03/2023 23:24, Alex Henrie wrote:
>>> On Thu, Mar 2, 2023 at 2:37 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>
>>>> On 25/02/2023 18:03, Alex Henrie wrote:
>>>
>>>>> +rebase.merges::
>>>>> +     Whether and how to set the `--rebase-merges` option by default. Can
>>>>> +     be `rebase-cousins`, `no-rebase-cousins`, or a boolean. Setting to
>>>>> +     true is equivalent to `--rebase-merges` without an argument, setting to
>>>>> +     `rebase-cousins` or `no-rebase-cousins` is equivalent to
>>>>> +     `--rebase-merges` with that value as its argument, and setting to false
>>>>> +     is equivalent to `--no-rebase-merges`. Passing `--rebase-merges` on the
>>>>> +     command line without an argument overrides a `rebase.merges=false`
>>>>> +     configuration but does not override other values of `rebase.merge`.
>>>>
>>>> I'm still not clear why the commandline doesn't override the config in
>>>> all cases as is our usual practice. After all if the user has set
>>>> rebase.merges then they don't need to pass --rebase-merges unless they
>>>> want to override the config.
>>>
>>> Given the current push to turn rebase-merges on by default, it seems
>>> likely that rebase-cousins will also be turned on by default at some
>>> point after that.
>>
>> It is good to try and future proof things but this seems rather
>> hypothetical. I don't really see how the choice of whether
>> --rebase-merges is turned on by default is related to the choice of
>> whether or not to rebase cousins by default. It is worth noting that the
>> default was changed to from rebase-cousins to no-rebase-cousins early in
>> the development of --rebase-merges[1] as it was felt to be less surprising.
> 
>> [1]
>> https://lore.kernel.org/git/nycvar.QRO.7.76.6.1801292251240.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz/
> 
> Thank you for sharing that link. Even though I got the tests right, I
> got confused and started thinking that rebase-cousins was a more
> thorough version of rebase-merges. In fact, they do opposite things:
> rebase-merges tries to preserve the graph and rebase-cousins
> intentionally restructures the graph. In my opinion using the word
> "rebase" in the names of both options was another unfortunate UI
> decision, but I understand the difference now.
> 
>>> There will be a warning about the default changing,
>>> and we'll want to let users suppress that warning by setting
>>> rebase.rebaseMerges=rebase-cousins. It would then be very confusing if
>>> a --rebase-merges from some old alias continued to mean
>>> --rebase-merges=no-rebase-cousins when the user expects it to start
>>> behaving as though the default has already changed.
>>
>> But aren't you breaking those aliases now when
>> rebase.rebaseMerges=rebase-cousins? That's what I'm objecting to. It
>> seems like we're breaking things now to avoid a hypothetical future
>> change breaking them which does not seem like the right trade off to me.
>>
>> It also does not fit with the way other optional arguments interact with
>> their associated config setting. For example "git branch/checkout/switch
>> --track" and branch.autoSetupMerge. If the optional argument to --track
>> is omitted it defaults to "direct" irrespective of the config.
 >
> What I really don't want is to paint ourselves into a corner.

Nor do I but we already seem to be in some kind of corner as what you're 
proposing breaks the status quo and the existing convention that command 
line options override config settings.

> You're
> right that it's unlikely that the default will ever change from
> no-rebase-cousins to rebase-cousins; I was mistaken. However, Glen
> thinks that in the future we might have some kind of
> rebase-evil-merges mode as well, and that that might become the
> default. If we don't let the rebase.rebaseMerges config value control
> the default behavior of --rebase-merges without an argument on the
> command line, we would have to introduce a separate config option for
> the transition, which would be ugly.

I'm optimistic that Elijah's work on rebasing evil merges will allow us 
to improve --rebase-merges. I expect that we'll enable it by default 
once it is merged. I do not think that we should add another argument 
for --rebase-merges to disable it though as that would be orthogonal to 
"rebase-cousins" and "no-rebase-cousins" which control what commits get 
rebased not how merges are rebased. If users want to disable the better 
rebasing of merges we'll need to add a --remerge option or something 
like that.

> More voices would be helpful here. Does anyone else have an opinion on
> how likely it is that the default rebase-merges mode will change in
> the future? Or on whether rebase.rebaseMerges should be allowed to
> affect --rebase-merges in order to facilitate such a change?

Getting other's views would indeed be helpful

Best Wishes

Phillip


>>>>> +test_expect_success '--rebase-merges overrides rebase.merges=false' '
>>>>> +     test_config rebase.merges false &&
>>>>> +     git checkout -b override-config-merges-false E &&
>>>>> +     before="$(git rev-parse --verify HEAD)" &&
>>>>> +     test_tick &&
>>>>> +     git rebase --rebase-merges C &&
>>>>> +     test_cmp_rev HEAD $before
>>>>
>>>> This test passes if the rebase does nothing, maybe pass --force and
>>>> check the graph?
>>>
>>> The rebase is supposed to do nothing here.
>>
>> It's not doing nothing though - it is rebasing the branch, it just
>> happens that everything fast-forwards so HEAD ends up unchanged. My
>> point is that this test should verify the branch has been rebased. Maybe
>> you could check the reflog message for HEAD@{0} is
>>
>>          rebase (finish): returning to refs/heads/override-config-merges-false
>>
>>> Checking that the commit
>>> hash is the same is just a quick way to check that the entire graph is
>>> the same. What more would be checked by checking the graph instead of
>>> the hash?
>>
>> By using --force and checking the graph you check that the rebase
>> actually happened.
> 
> I got the impression that people like that not checking the graph
> itself (or the reflog) makes the tests more concise, but I don't care
> much either way. For what it's worth, the way I did it matches the
> existing tests in the file. If you can find at least one other person
> who thinks that it ought to change for this patch series to be
> accepted, and no one else objects, I'll change it.
> 
>> Thanks for working on this
> 
> You're welcome; hopefully we can get the remaining details ironed out quickly.
> 
> -Alex
