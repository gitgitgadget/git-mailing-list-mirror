Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D99C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 18:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347157AbiEZSYU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 14:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237702AbiEZSYT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 14:24:19 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77D365426
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:24:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id p26so2781649eds.5
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=MrIrZ5B9Ht0ESnQ+a7HVA+5SWFlrVU8pRKpYKtXqEQg=;
        b=VMyGM/cvReVTyVVqQ8fVWlCixLVPWwsU7Sx2P+hY9mXb9h1nF5OKQ6ucg0EN8/F8gI
         70+5SrY+ElnZAyLXeIIAwA13APTS7LLj5redRzxftNbJwhnB5T2N+EqmRGydu+069MQm
         FMoC/7FmXckNUpR0toVPI6s3wPm95S2C4teTO8ke2Z9aeQVsWmnVwzb85Nr2h8xpP71l
         lE9JiMstSqoshsipLVC+MPvDGHj82GFmse8IjIrWXsmoqFlyrwBwrX/dRHlr6Y67TjVk
         lyyDenEK2/Uf7dNyBCK6U+gR3t3+SUWdT4WK2JuSwy60+SNrZfIGjpLc31HTe0bCTHrp
         fyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=MrIrZ5B9Ht0ESnQ+a7HVA+5SWFlrVU8pRKpYKtXqEQg=;
        b=naP4Y/l2NI1y/QDFgcvK5L+AYvJwJ6R3Ds5kY8rc/QpnKFSX5RkDEQXdU3YFzZISr3
         OrQeVkgUYJlb92HMEVWA25KXUOSuV7SlRi4MEaVNjYfGc0dvR9rorya5givMYxNXvYP/
         +mZVZ1BHCk6WuJBQKcCi40u3GzRHUeTNMgUt4ZOhgFugp6XfvHWKSad4yc0eomqf21ZY
         rmumd6sPWj5ucJUG0bcj/teEaB/ZROdbAqYpLvI9beZ+QoYr05Xi6D5HO3SNcbKm8g5W
         vLKgYv+Qiaj5tpT3ZOpq+tzs1h3KnMim1otJj6fO9OlnbIgty5yf18Cjq8gv4gj/HNIG
         eeyw==
X-Gm-Message-State: AOAM531/1W+Izu1zzvtP4+fcLB8z30r2nATg39bvyRnvwxXC7bic/Mau
        ekLbY+7htxPDicc5lZg+SwnKF9zGfi+sVQ==
X-Google-Smtp-Source: ABdhPJywonDJr6Fmnu236+WSsb8zgMdtUrTMeGOAErOW9dljM8zNXZLixZGonHZzzjhi1c2IVq9sog==
X-Received: by 2002:aa7:d2cb:0:b0:42b:c9f8:a236 with SMTP id k11-20020aa7d2cb000000b0042bc9f8a236mr9583759edr.347.1653589456139;
        Thu, 26 May 2022 11:24:16 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id cd26-20020a170906b35a00b006fee526ed72sm715890ejb.217.2022.05.26.11.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:24:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuI9e-000Eni-Mr;
        Thu, 26 May 2022 20:24:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 8/8] hook API: fix v2.36.0 regression: hooks should
 be connected to a TTY
Date:   Thu, 26 May 2022 20:23:23 +0200
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
 <patch-v2-8.8-238155fcb9d-20220518T195858Z-avarab@gmail.com>
 <Yo+3gmtbaARan23V@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Yo+3gmtbaARan23V@google.com>
Message-ID: <220526.86h75c5f01.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Emily Shaffer wrote:

> On Wed, May 18, 2022 at 10:05:24PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> Fix a regression reported[1] in f443246b9f2 (commit: convert
>> {pre-commit,prepare-commit-msg} hook to hook.h, 2021-12-22): Due to
>> using the run_process_parallel() API in the earlier 96e7225b310 (hook:
>> add 'run' subcommand, 2021-12-22) we'd capture the hook's stderr and
>> stdout, and thus lose the connection to the TTY in the case of
>> e.g. the "pre-commit" hook.
>>=20
>> As a preceding commit notes GNU parallel's similar --ungroup option
>> also has it emit output faster. While we're unlikely to have hooks
>> that emit truly massive amounts of output (or where the performance
>> thereof matters) it's still informative to measure the overhead. In a
>> similar "seq" test we're now ~30% faster:
>>=20
>> 	$ cat .git/hooks/seq-hook; git hyperfine -L rev origin/master,HEAD~0 -s=
 'make CFLAGS=3D-O3' './git hook run seq-hook'
>> 	#!/bin/sh
>>=20
>> 	seq 100000000
>> 	Benchmark 1: ./git hook run seq-hook' in 'origin/master
>> 	  Time (mean =C2=B1 =CF=83):     787.1 ms =C2=B1  13.6 ms    [User: 701=
.6 ms, System: 534.4 ms]
>> 	  Range (min =E2=80=A6 max):   773.2 ms =E2=80=A6 806.3 ms    10 runs
>>=20
>> 	Benchmark 2: ./git hook run seq-hook' in 'HEAD~0
>> 	  Time (mean =C2=B1 =CF=83):     603.4 ms =C2=B1   1.6 ms    [User: 573=
.1 ms, System: 30.3 ms]
>> 	  Range (min =E2=80=A6 max):   601.0 ms =E2=80=A6 606.2 ms    10 runs
>>=20
>> 	Summary
>> 	  './git hook run seq-hook' in 'HEAD~0' ran
>> 	    1.30 =C2=B1 0.02 times faster than './git hook run seq-hook' in 'or=
igin/master'
>>=20
>> In the preceding commit we removed the "stdout_to_stderr=3D1" assignment
>> as being redundant. This change brings it back as with ".ungroup=3D1"
>> the run_process_parallel() function doesn't provide them for us
>> implicitly.
>>=20
>> As an aside omitting the stdout_to_stderr=3D1 here would have all tests
>> pass, except those that test "git hook run" itself in
>> t1800-hook.sh. But our tests passing is the result of another test
>> blind spot, as was the case with the regression being fixed here. The
>> "stdout_to_stderr=3D1" for hooks is long-standing behavior, see
>> e.g. 1d9e8b56fe3 (Split back out update_hook handling in receive-pack,
>> 2007-03-10) and other follow-up commits (running "git log" with
>> "--reverse -p -Gstdout_to_stderr" is a good start).
>>=20
>> 1. https://lore.kernel.org/git/CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR=
8rAeqUCCZw@mail.gmail.com/
>>=20
>> Reported-by: Anthony Sottile <asottile@umich.edu>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  hook.c          |  5 +++++
>>  t/t1800-hook.sh | 37 +++++++++++++++++++++++++++++++++++++
>>  2 files changed, 42 insertions(+)
>>=20
>> diff --git a/hook.c b/hook.c
>> index dc498ef5c39..5f31b60384a 100644
>> --- a/hook.c
>> +++ b/hook.c
>> @@ -54,6 +54,7 @@ static int pick_next_hook(struct child_process *cp,
>>  		return 0;
>>=20=20
>>  	strvec_pushv(&cp->env_array, hook_cb->options->env.v);
>> +	cp->stdout_to_stderr =3D 1; /* because of .ungroup =3D 1 */
>>  	cp->trace2_hook_name =3D hook_cb->hook_name;
>>  	cp->dir =3D hook_cb->options->dir;
>>=20=20
>> @@ -126,6 +127,7 @@ int run_hooks_opt(const char *hook_name, struct run_=
hooks_opt *options)
>>  		.tr2_label =3D hook_name,
>>=20=20
>>  		.jobs =3D jobs,
>> +		.ungroup =3D jobs =3D=3D 1,
>
> I mentioned it on patch 5, but I actually do not see a reason why we
> shouldn't do this logic in run_processes_parallel instead of just for
> the hooks. If someone can mention a reason we want to buffer child
> processes we're running in series I'm all ears, of course.
>
>>=20=20
>>  		.get_next_task =3D pick_next_hook,
>>  		.start_failure =3D notify_start_failure,
>> @@ -136,6 +138,9 @@ int run_hooks_opt(const char *hook_name, struct run_=
hooks_opt *options)
>>  	if (!options)
>>  		BUG("a struct run_hooks_opt must be provided to run_hooks");
>>=20=20
>> +	if (jobs !=3D 1 || !run_opts.ungroup)
>> +		BUG("TODO: think about & document order & interleaving of parallel ho=
ok output");
>
> Doesn't this mean we're actually disallowing parallel hooks entirely? I
> don't think that's necessary or desired. I guess right now when the
> config isn't used, there's not really a way to provide parallel hooks,
> but I also think this will cause unnecessary conflicts for Google who is
> carrying config hooks downstream. I know that's not such a great reason.
> But it seems weird to be explicitly using the parallel processing
> framework, but then say, "oh, but we actually don't want to run in
> parallel, that's a BUG()".

I can just drop this paranoia. I figured it was prudent to leave this
landmine in place so we'd definitely remember to re-visit this aspect of
it, but I think there's 0% that we'll forget. So I'll make it less
paranoid.
