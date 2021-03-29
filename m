Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E65C433E0
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 17:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C62861968
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 17:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhC2RQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 13:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhC2RQA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 13:16:00 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC578C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 10:15:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u5so20653701ejn.8
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 10:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V15TJZnb4exuNr4u/Yiu9woSm+JlRJ/eKe3sfmJSOe0=;
        b=HaYPk3/pBk7H4NH/ZuoOjvW0EyNggBaFonTSxaT/YK6hhzqiupyc5fMRB6wJolTFn6
         3O5kW+Y+eASh7eYts1uQoecA9x8NNLlP9cgmxcvCZHUhLMPIg1DI1h3dDWng46ZVXum5
         i2JQUZ4KVN5A45gFN8HQn4mkQopRV2R6+O0FcZpayxfhlmAE+KG7cexDVclXstPE4N0A
         AKAu5/QBhcuw7Ei8/jN1IxuVf7pMT6dofzi3PQ8FygZo7/V5ZFlqNz0KfZJ2tW+t8sYl
         WcE6VKasbclWc5WTJPBKDzUVRpREUO6G/Q/zu1613HcZKGLtRsKdzeIvnQ0gP9LDfrcO
         TRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V15TJZnb4exuNr4u/Yiu9woSm+JlRJ/eKe3sfmJSOe0=;
        b=WKzpe8k/l1Pi2U2bFOUJzBDV994JKFbHTaGpWq8HCVKDAOYIKSGS7JkgQ7V4k0RGzF
         SHX7oNFzgF7WNzmGKM9aS3tumMw1c6egwkRLeUl8NoAoeG4hPlH6tytlMeT/HeyzbEWH
         ZtKP8mxPe5Wvd1xHDiRD9nZCEbpUILxTVS2lCeLrt3ZLPyP9UAH/59P+x7lrwvw87Cln
         uxixx4pu4qASHeBaagH0tW8F+5V13M/Qo5PVq1f3NrMNcCgDWvgxY6mUc5znZs8xGjny
         uJcNYmJnwUQOg5TvMe0KatHbOf3IwMlz7++HJhazMdSwBZ6NYAW81HU2lgUJ/YQO2VU1
         Ezww==
X-Gm-Message-State: AOAM533V/qV7Ic3JTl92TaJL53ePQCD5JNxJLxh2mHT5zJ1NRlXtpXEq
        mA5j0OtDJg/fK81ZK0mwLxJZjZ8PKow=
X-Google-Smtp-Source: ABdhPJwtyFYpLLPrAzvWrmzIesGQFiCjwyRoeeFgrBP0ZdVtjst0MXsBwm2OfDj71jizozb9QTd65g==
X-Received: by 2002:a17:906:8308:: with SMTP id j8mr28661197ejx.339.1617038157923;
        Mon, 29 Mar 2021 10:15:57 -0700 (PDT)
Received: from [192.168.1.201] (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.googlemail.com with ESMTPSA id cf4sm9384075edb.19.2021.03.29.10.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 10:15:57 -0700 (PDT)
Subject: Re: [PATCH 3/3] rebase: don't override --no-reschedule-failed-exec
 with config
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <873d1fda948855510b07f9cb75d374c03d60a94e.1544468695.git.gitgitgadget@gmail.com>
 <cover.1616411973.git.avarab@gmail.com>
 <e00300d58d4de4a6b440446a0054d34ad5a092f3.1616411973.git.avarab@gmail.com>
 <fc7e3d13-8761-6d79-0fc9-734d6942a8e6@gmail.com>
 <87lfa6lz16.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a5ce93ea-1e1d-a8e5-7d0e-059dd0c63fd4@gmail.com>
Date:   Mon, 29 Mar 2021 18:15:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <87lfa6lz16.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/03/2021 17:12, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Mar 29 2021, Phillip Wood wrote:
> 
>> Hi Ævar
>>
>> On 22/03/2021 11:48, Ævar Arnfjörð Bjarmason wrote:
>>> Fix a bug in how --no-reschedule-failed-exec interacts with
>>> rebase.rescheduleFailedExec=true being set in the config. Before this
>>> change the --no-reschedule-failed-exec config option would be
>>> overridden by the config.
>>> This bug happened because of the particulars of how "rebase" works
>>> v.s. most other git commands when it comes to parsing options and
>>> config:
>>> When we read the config and parse the CLI options we correctly
>>> prefer
>>> the --no-reschedule-failed-exec option over
>>> rebase.rescheduleFailedExec=true in the config. So far so good.
>>> However the --reschedule-failed-exec option doesn't take effect when
>>> the rebase starts (we'd just create a
>>> ".git/rebase-merge/reschedule-failed-exec" file if it was true). It
>>> only takes effect when the exec command fails, and the user wants to
>>> run "rebase --continue".
>>
>> The exec command is rescheduled in the todo file as soon as it fails,
>> we do not wait for the user to run 'rebase --continue' to reschedule
>> it. However if it still fails after restarting or a later exec fails
>> we have the problem you describe.
> 
> Right, as noted in [1] I grokked those internals eventually, but the
> commit message is written from the viewpoint of a hypothetical user...

So user will find that the first failed exec is not rescheduled but 
subsequent ones are which looks like the setting only takes effect after 
the run 'git rebase --continue'  - fair enough.

> B.t.w. if you've had a chance to read [1] over it would be interesting
> to get some thoughts on that rambling. So far I only managed to upset
> Johannes :)

I'll try and have a proper look at it tomorrow, I did have a glance the 
other day - I'm not that keen on the way the prompt behaves either

> 1. http://lore.kernel.org/git/cover.1616411973.git.avarab@gmail.com

>>> At that point we'll have forgotten that we asked for
>>> --no-reschedule-failed-exec at the start, and will happily re-read the
>>> config.
>>> We'll then see that rebase.rescheduleFailedExec=true is set. At that
>>> point we have no record of having set --no-reschedule-failed-exec
>>> earlier. So the config will effectively override the user having
>>> explicitly disabled the option on the command-line.
>>> Even more confusingly: Since rebase accepts different options based
>>> on
>>> its state there wasn't even a way to get around this with "rebase
>>> --continue --no-reschedule-failed-exec" (but you could of course set
>>> the config with "rebase -c ...").
>>> I think the least bad way out of this is to declare that for such
>>> options and config whatever we decide at the beginning of the rebase
>>> goes. So we'll now always create either a "reschedule-failed-exec" or
>>> a "no-reschedule-failed-exec file at the start, not just the former if
>>> we decided we wanted the feature.
>>
>> Thanks for working on this and for the detailed commit message. I'm
>> not entirely convinced we want yet another state file in
>> .git/rebase-merge. We could we start writing the setting to the file
>> rather than having different files for whether the option is on or
>> off. If we use the contents of the file it could be -1 for 'use
>> config', 0 'off', 1 'on'. The downside is that starting 'rebase
>> --no-reschedule-failed-exec' with a new version of git and then
>>   continuing with an old version would do the wrong thing.
> 
> Yes I suppose, but it seems much simpler indeed to just represent this
> sort of tri-state as a ENOENT/no-FOO/FOO neither exists + file pair with
> how the current code is set up, 

I can see that, I'm not a great fan of the current setup though - we're 
not using shell scripting anymore so there's no need to add a new file 
for each piece of state (though we need to keep the old ones for 
backwards compatibility). Having said that I don't object to the current 
approach if it's easier and preserves backwards compatibility. If you 
feel like adding support for ENOENT="use config" that would be great so 
that 'git -c ... rebase --continue' continues to work.

Best Wishes

Phillip

> especially because (as you note) we'd
> need to phase-in any writing of the content across multiple versions or
> something, least in-progress rebases across versions subtly behave
> weirdly.
> 
> Well, in this case it's not such a big deal, but I'd rather not
> establish the pattern for something that *does* matter.
>> Best Wishes
>>
>> Phillip
>>
>>> With this new worldview you can no longer change the setting once a
>>> rebase has started except by manually removing the state files
>>> discussed above. I think making it work like that is the the least
>>> confusing thing we can do.
>>> In the future we might want to learn to change the setting in the
>>> middle by combining "--edit-todo" with
>>> "--[no-]reschedule-failed-exec", we currently don't support combining
>>> those options, or any other way to change the state in the middle of
>>> the rebase short of manually editing the files in
>>> ".git/rebase-merge/*".
>>> The bug being fixed here originally came about because of a
>>> combination of the behavior of the code added in d421afa0c66 (rebase:
>>> introduce --reschedule-failed-exec, 2018-12-10) and the addition of
>>> the config variable in 969de3ff0e0 (rebase: add a config option to
>>> default to --reschedule-failed-exec, 2018-12-10).
>>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>> ---
>>>    Documentation/git-rebase.txt |  8 ++++++++
>>>    sequencer.c                  |  5 +++++
>>>    t/t3418-rebase-continue.sh   | 25 +++++++++++++++++++++++++
>>>    3 files changed, 38 insertions(+)
>>> diff --git a/Documentation/git-rebase.txt
>>> b/Documentation/git-rebase.txt
>>> index a0487b5cc58..b48e6225769 100644
>>> --- a/Documentation/git-rebase.txt
>>> +++ b/Documentation/git-rebase.txt
>>> @@ -622,6 +622,14 @@ See also INCOMPATIBLE OPTIONS below.
>>>    --no-reschedule-failed-exec::
>>>    	Automatically reschedule `exec` commands that failed. This only makes
>>>    	sense in interactive mode (or when an `--exec` option was provided).
>>> ++
>>> +Even though this option applies once a rebase is started, it's set for
>>> +the whole rebase at the start based on either the
>>> +`rebase.rescheduleFailedExec` configuration (see linkgit:git-config[1]
>>> +or "CONFIGURATION" below) or whether this option is
>>> +provided. Otherwise an explicit `--no-reschedule-failed-exec` at the
>>> +start would be overridden by the presence of
>>> +`rebase.rescheduleFailedExec=true` configuration.
>>>      INCOMPATIBLE OPTIONS
>>>    --------------------
>>> diff --git a/sequencer.c b/sequencer.c
>>> index 848204d3dc3..59735fdff62 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -164,6 +164,7 @@ static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
>>>    static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
>>>    static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
>>>    static GIT_PATH_FUNC(rebase_path_reschedule_failed_exec, "rebase-merge/reschedule-failed-exec")
>>> +static GIT_PATH_FUNC(rebase_path_no_reschedule_failed_exec, "rebase-merge/no-reschedule-failed-exec")
>>>    static GIT_PATH_FUNC(rebase_path_drop_redundant_commits, "rebase-merge/drop_redundant_commits")
>>>    static GIT_PATH_FUNC(rebase_path_keep_redundant_commits, "rebase-merge/keep_redundant_commits")
>>>    @@ -2672,6 +2673,8 @@ static int read_populate_opts(struct
>>> replay_opts *opts)
>>>      		if (file_exists(rebase_path_reschedule_failed_exec()))
>>>    			opts->reschedule_failed_exec = 1;
>>> +		else if (file_exists(rebase_path_no_reschedule_failed_exec()))
>>> +			opts->reschedule_failed_exec = 0;
>>>      		if (file_exists(rebase_path_drop_redundant_commits()))
>>>    			opts->drop_redundant_commits = 1;
>>> @@ -2772,6 +2775,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
>>>    		write_file(rebase_path_ignore_date(), "%s", "");
>>>    	if (opts->reschedule_failed_exec)
>>>    		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
>>> +	else
>>> +		write_file(rebase_path_no_reschedule_failed_exec(), "%s", "");
>>>      	return 0;
>>>    }
>>> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
>>> index ea14ef496cb..9553d969646 100755
>>> --- a/t/t3418-rebase-continue.sh
>>> +++ b/t/t3418-rebase-continue.sh
>>> @@ -291,4 +291,29 @@ test_expect_success 'rebase.rescheduleFailedExec only affects `rebase -i`' '
>>>    	git rebase HEAD^
>>>    '
>>>    +test_expect_success 'rebase.rescheduleFailedExec=true &
>>> --no-reschedule-failed-exec' '
>>> +	test_when_finished "git rebase --abort" &&
>>> +	test_when_finished "test_unconfig rebase.rescheduleFailedExec" &&
>>> +	test_config rebase.rescheduleFailedExec true &&
>>> +	test_must_fail git rebase -x false --no-reschedule-failed-exec HEAD~2 &&
>>> +	test_must_fail git rebase --continue 2>err &&
>>> +	! grep "has been rescheduled" err
>>> +'
>>> +
>>> +test_expect_success 'new rebase.rescheduleFailedExec=true setting in an ongoing rebase is ignored' '
>>> +	test_when_finished "git rebase --abort" &&
>>> +	test_must_fail git rebase -x false HEAD~2 &&
>>> +	test_when_finished "test_unconfig rebase.rescheduleFailedExec" &&
>>> +	test_config rebase.rescheduleFailedExec true &&
>>> +	test_must_fail git rebase --continue 2>err &&
>>> +	! grep "has been rescheduled" err
>>> +'
>>> +
>>> +test_expect_success 'there is no --no-reschedule-failed-exec in an ongoing rebase' '
>>> +	test_when_finished "git rebase --abort" &&
>>> +	test_must_fail git rebase -x false HEAD~2 &&
>>> +	test_expect_code 129 git rebase --continue --no-reschedule-failed-exec &&
>>> +	test_expect_code 129 git rebase --edit-todo --no-reschedule-failed-exec
>>> +'
>>> +
>>>    test_done
>>>
> 

