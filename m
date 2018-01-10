Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59D481F404
	for <e@80x24.org>; Wed, 10 Jan 2018 19:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeAJTOj (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 14:14:39 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41279 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbeAJTOe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 14:14:34 -0500
Received: by mail-qk0-f196.google.com with SMTP id a8so136203qkb.8
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 11:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zmC8VPPMXp1CAquJh+9y47+RanZ9KzFOr//L2x8VUjg=;
        b=XTUJiyBnbbT1TuGv9GroESxD8wrd1NKAoPpXU4lnN1M7sG9cABSdd/o7uFy57kA2eL
         Z2baIZwrF97SR9aB02ui+TbmMdvf+l8zHEvKb05jXswhq2AUOz48JiEBNbZyiEI9gXUe
         CJTV8kaiTdlRROoDmZkTZkciRbLXGyvx0m8LQkgaKbUqDxf1Y/6HKgIR705jbHXNsLbU
         u31aKc9AbWoL5wzAUWilXqxnSf1jy35M6ORvWk2oO8Nxa2ahAj583l+CGTBy3yCwqDnO
         LRfUPJjU/EndW6HUbv9xabeo39KQ6JCiBMwiMnXra9UduPW9plIlcupVgvCPA5pBTHjG
         o9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zmC8VPPMXp1CAquJh+9y47+RanZ9KzFOr//L2x8VUjg=;
        b=Z4ZI9AUvO1+hVGS4J2EizPRvU33r/ULnlfq9oXN3GErN+RaHhAoUOfc1hXZpuajf30
         Vp1nXiOpuiXrkCWM9B3LT72+AYL56vlKQCLm/Z9ilxIx4cSbMA7TZWvkhTs2op807cpe
         hLazel7YRFxUSNSyrErs1yWe06dlM2k8cpt7TjhbL2J/jNntBfpx7X3lrVYWVBl631Sx
         7g/QAn72SW+k48UIUkOTzjEerB7EsQLV+dfaEiN+22WnoSYFcxJ2u3PmpDdkBZ0NRzN7
         rehN4IQwA1bjN8uRVAGghtGR310ICKdEhq5fArFwxD2tpq+rJ/0E4KNYeg3xzehD+dTO
         8oOw==
X-Gm-Message-State: AKwxytfoiTPMYkXnNp0n6OlKV3v4MVjWt0lPWcXgbAgxgRsDknkA42QJ
        EUPsCdSbgr3FgNQ/qW7bKv6FO/y04I0YTv0oafqL3w==
X-Google-Smtp-Source: ACJfBotzYIMUJY0DcPsSirjXdcwnjziV0+ZRbG+RHMm9jaDon8g0G31fFr01xjHQpMm690xURUmTdl+yo7gNuBwKpY0=
X-Received: by 10.237.58.132 with SMTP id o4mr3169164qte.207.1515611673278;
 Wed, 10 Jan 2018 11:14:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 10 Jan 2018 11:14:32 -0800 (PST)
In-Reply-To: <20180110180945.GA53941@google.com>
References: <20180110104835.22905-1-pclouds@gmail.com> <20180110180945.GA53941@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 10 Jan 2018 11:14:32 -0800
Message-ID: <CAGZ79ka0mhPy776fRYtvnaqd5P1dwvuaeONozEWpaJVZxSneiA@mail.gmail.com>
Subject: Re: [PATCH] run-command.c: print env vars when GIT_TRACE is set
To:     Brandon Williams <bmwill@google.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 10, 2018 at 10:09 AM, Brandon Williams <bmwill@google.com> wrot=
e:
> On 01/10, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> Occasionally submodule code could execute new commands with GIT_DIR set
>> to some submodule. GIT_TRACE prints just the command line which makes it
>> hard to tell that it's not really executed on this repository.

Speaking of GIT_DIR, we may also want to print the dir that the command is
executed in as the GIT_DIR for submodules usually is only ".git" assuming t=
he
run-command struct set the .dir to the submodules worktree. I think I had a
patch for printing the cwd of a process on the list once upon a time, but
I am unable to find it again. Maybe we'd want to include the cwd of a spawn=
ed
process if it differs from the current process?

>>
>> Print env variables in this case. Note that the code deliberately ignore
>> variables unsetting because there are so many of them (to keep git
>> environment clean for the next process) and really hard to read.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  A minor thing that I ignored in this patch is quoting the environment
>>  variables. For me it's meh. Perhaps I should just dumb the env
>>  without quoting at all.
>
> A patch like this would have been very helpful to me on some previous
> occasions, so thanks for writing it up.

The patch I mentioned above (very similar though less powerful than this on=
e)
was carried by locally for some time, so I definitely see value in this pat=
ch.
Thanks for writing it!

>
>>
>>  run-command.c |  3 ++-
>>  trace.c       | 38 +++++++++++++++++++++++++++++++++++---
>>  trace.h       | 18 +++++++++++++++---
>>  3 files changed, 52 insertions(+), 7 deletions(-)
>>
>> diff --git a/run-command.c b/run-command.c
>> index 31fc5ea86e..235367087d 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -624,7 +624,8 @@ int start_command(struct child_process *cmd)
>>               cmd->err =3D fderr[0];
>>       }
>>
>> -     trace_argv_printf(cmd->argv, "trace: run_command:");
>> +     trace_env_argv_printf(cmd->env, cmd->argv, "trace: run_command:");
>> +
>>       fflush(NULL);
>>
>>  #ifndef GIT_WINDOWS_NATIVE
>> diff --git a/trace.c b/trace.c
>> index b7530b51a9..d8967b66e8 100644
>> --- a/trace.c
>> +++ b/trace.c
>> @@ -146,7 +146,26 @@ static void trace_vprintf_fl(const char *file, int =
line, struct trace_key *key,
>>       print_trace_line(key, &buf);
>>  }
>>
>> +static void concatenate_env(struct strbuf *dst, const char *const *env)
>> +{
>> +     int i;
>> +
>> +     /* Copy into destination buffer. */
>> +     strbuf_grow(dst, 255);
>> +     for (i =3D 0; env[i]; ++i) {
>> +             /*
>> +              * the main interesting is setting new vars
>> +              * e.g. GIT_DIR, ignore the unsetting to reduce noise.
>> +              */
>
> I think you're missing a word, maybe:
>   'The main interesting part is setting new vars'
>
>> +             if (!strchr(env[i], '=3D'))
>> +                     continue;
>> +             strbuf_addch(dst, ' ');
>> +             sq_quote_buf(dst, env[i]);
>> +     }
>
> At first when i read this I was under the impression that the whole
> environment was going to be printed out...but i now realize that this
> tracing  will only print out the delta's or the additions to the
> environment that the child will see.  Maybe this should be called out
> more clearly in the commit message?

It only adds newly set variables, I wonder why deletions are noisy?
I could not find an example of a removal of environment variables
specific to submodules that would be noisy.

Stefan
