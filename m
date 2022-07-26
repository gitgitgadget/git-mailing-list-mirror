Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6110BC00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 20:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbiGZUAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 16:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiGZUAA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 16:00:00 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87E3357F4
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 12:59:59 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id ot17-20020a17090b3b5100b001f2c064b8b0so1062337pjb.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 12:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=dTcIL326g04SyAz0RthJfiFR95U9fV+whW/JZSykHdI=;
        b=s5+5xNQmh3/khSgcEhrNAdSt5efRoK7bVxNKuPn2b5is84hlITAONmad9+1XkHq8+N
         f+mlBSgG5kLc0I3UpymPI8zoL48ceKRD9F5rAIhKxobuDOMsf1dgr+zlEyosehl7y6R3
         w5HTgfKopmzXXeu65oTkXLI3NGZLOlZDZzRjuSY3/UK0P4uqtoedfdkrvnquBT7IQgsN
         joY4Pr/pNWMqZLe0wdWrlXhBtcGrhP7TJJtwJn3Tk+8kUK+Fm1WhvSjLKqs/dcU+gLdu
         gR7ImtSlLoWKwH4F30IBE3qKvtjWC/hp2Y8OOEPjPATKZNI5lnzwAzLjhSCGZI+4YXLq
         jBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=dTcIL326g04SyAz0RthJfiFR95U9fV+whW/JZSykHdI=;
        b=A8dWO/+gmYR/xpmSOuqpxYQvDO8X0MMQ4vuUoUoNtYuNfF0eJyOpVyryRnr4JWfKgS
         +iNhUAWNEWIDRsStaKFoTQ082SGfDdWT+//aTuw3sdGd0KwGL7eg7D1wvz0uy/rWfAYn
         qSNHL+9drD9/WaIpqs5ZKFWVG82yOjYHqy3QjwhZcvqO8rVjLyqEAmqoxSrj4HR580Ks
         f5PDtqjiwAs5kDTkO+VLBiGnkFgoiVlnnpDDYPt+6b4ZpOkQ8YVM/rofrdag9EIe2SgH
         iYcLqMTrcboRNNgDwu5CMNOfm7H9N2Bv0Ad5C/iG5PnnyNu7rACa7/vH2yhdsHhANATN
         iXeQ==
X-Gm-Message-State: AJIora9/syHRdM777X52ex6lIbEfh5+BvbMJAAzFf8sBq9VYhuKqc0C0
        9J0EN3UepEm1Eq9E+1sd6bp8/O6HwqGDiQ==
X-Google-Smtp-Source: AGRyM1sk3cat/X3+WzljJIPZ7qvnDXKXei3AxaHzv0VosjGuL+itqs8KwWKJtTYYPePiDgz12pXaKaOxISOyUg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:8c7:b0:528:1aa1:5283 with SMTP
 id s7-20020a056a0008c700b005281aa15283mr18945803pfu.81.1658865599292; Tue, 26
 Jul 2022 12:59:59 -0700 (PDT)
Date:   Tue, 26 Jul 2022 12:59:57 -0700
In-Reply-To: <220726.864jz3n0uf.gmgdl@evledraar.gmail.com>
Message-Id: <kl6lfsinskzm.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1299.git.git.1658855372189.gitgitgadget@gmail.com> <220726.864jz3n0uf.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH] config.c: NULL check when reading protected config
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Jul 26 2022, Glen Choo via GitGitGadget wrote:
>
>> From: Glen Choo <chooglen@google.com>
>>
>> In read_protected_config(), check whether each file name is NULL before
>> attempting to read it. This mirrors do_git_config_sequence() (which
>> read_protected_config() is modelled after).
>>
>> Without these NULL checks,
>>
>>  make SANITIZE=3Daddress test T=3Dt0410*.sh
>>
>> fails because xdg_config is NULL, causing us to call fopen(NULL).
>
> FWIW a lot more than that fails, that's just the test I focused on for
> the bug report, the others ones (I didn't check out all of them) all
> variants of that.
>
> See https://github.com/avar/git/runs/7519070124?check_suite_focus=3Dtrue
> for the current failing run with that "[2]" patch you quoted. We fail a
> total of 14 test files (and many more tests within those files).

Ah thanks, I'll amend the message accordingly.

>> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Signed-off-by: Glen Choo <chooglen@google.com>
>> ---
>>     config.c: NULL check when reading protected config
>>    =20
>>     This fixes the SANITIZE=3Daddress failure on master, That was introd=
uced
>>     by gc/bare-repo-discovery. Thanks again to =C3=86var for the origina=
l report
>>     [1] and for proposing a way to catch this in CI [2].
>>    =20
>>     [1]
>>     https://lore.kernel.org/git/220725.861qu9oxl4.gmgdl@evledraar.gmail.=
com
>>     [2]
>>     https://lore.kernel.org/git/patch-1.1-e48b6853dd5-20220726T110716Z-a=
varab@gmail.com
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-12=
99%2Fchooglen%2Fconfig%2Ffix-sanitize-address-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1299/=
chooglen/config/fix-sanitize-address-v1
>> Pull-Request: https://github.com/git/git/pull/1299
>>
>>  config.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/config.c b/config.c
>> index 015bec360f5..b0ba7f439a4 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -2645,9 +2645,12 @@ static void read_protected_config(void)
>>  	system_config =3D git_system_config();
>>  	git_global_config(&user_config, &xdg_config);
>> =20
>> -	git_configset_add_file(&protected_config, system_config);
>> -	git_configset_add_file(&protected_config, xdg_config);
>> -	git_configset_add_file(&protected_config, user_config);
>> +	if (system_config)
>> +		git_configset_add_file(&protected_config, system_config);
>> +	if (xdg_config)
>> +		git_configset_add_file(&protected_config, xdg_config);
>> +	if (user_config)
>> +		git_configset_add_file(&protected_config, user_config);
>>  	git_configset_add_parameters(&protected_config);
>> =20
>>  	free(system_config);
>>
>> base-commit: 6a475b71f8c4ce708d69fdc9317aefbde3769e25
>
> Re your claim in
> https://lore.kernel.org/git/kl6lzggwsyh1.fsf@chooglen-macbookpro.roam.cor=
p.google.com/
> I tried testing this, and came up with the below.
>
> I wonder if we should work in here for general paranoia, but I'm not too
> familiar with the this part of the config reading, maybe we're confident
> enough that these are invariants within the process.
>
> This will BUG() out if these variables change within the process, which
> would mean that our caching assumptions are no longer true, which would
> cause you to return the wrong data here.
>
> Of course you'd have segfaulted or similar before, but this should
> demonstrate that not only are these sometimes NULL, but that they stay
> that way.

Interesting, this is worth proposing, but I suspect that the
conversation will be long enough for this to be its own thread. Surely
someone must have given some thought to this, especially for long-lived
processes (git-daemon?).

There's also the general question of config cache freshness, e.g. what
if another git process writes to a shared config file? (We don't worry
about the single process case because the process will invalidate its
own cache).

Perhaps we should also worry about that (probably more common) case in
addition to this one? At any rate, that seems like a bigger topic than
this fix here.

>
> diff --git a/config.c b/config.c
> index 015bec360f5..cdd665c1cc8 100644
> --- a/config.c
> +++ b/config.c
> @@ -2102,6 +2102,30 @@ int git_config_system(void)
>  	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
>  }
> =20
> +static char *last_system_config;
> +static char *last_xdg_config;
> +static char *last_user_config;
> +
> +static void sanity_check_config_1(const char *name, char **last,
> +				  const char *now)
> +{
> +	if (*last && now && strcmp(*last, now))
> +		BUG("%s_config: had '%s', now '%s'", name, *last, now);
> +	else if (*last && !now)
> +		BUG("%s_config: had '%s', now NULL", name, *last);
> +	free(*last);
> +	*last =3D xstrdup_or_null(now);
> +}
> +
> +static void sanity_check_config(const char *system_config,
> +				const char *xdg_config,
> +				const char *user_config)
> +{
> +	sanity_check_config_1("system", &last_system_config, system_config);
> +	sanity_check_config_1("xdg", &last_xdg_config, xdg_config);
> +	sanity_check_config_1("user", &last_user_config, user_config);
> +}
> +
>  static int do_git_config_sequence(const struct config_options *opts,
>  				  config_fn_t fn, void *data)
>  {
> @@ -2134,6 +2158,8 @@ static int do_git_config_sequence(const struct conf=
ig_options *opts,
>  	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
>  		ret +=3D git_config_from_file(fn, user_config, data);
> =20
> +	sanity_check_config(system_config, xdg_config, user_config);
> +
>  	current_parsing_scope =3D CONFIG_SCOPE_LOCAL;
>  	if (!opts->ignore_repo && repo_config &&
>  	    !access_or_die(repo_config, R_OK, 0))
> @@ -2645,6 +2671,8 @@ static void read_protected_config(void)
>  	system_config =3D git_system_config();
>  	git_global_config(&user_config, &xdg_config);
> =20
> +	sanity_check_config(system_config, xdg_config, user_config);
> +
>  	git_configset_add_file(&protected_config, system_config);
>  	git_configset_add_file(&protected_config, xdg_config);
>  	git_configset_add_file(&protected_config, user_config);
