Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6369C433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 17:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346630AbiEaRnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 13:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238878AbiEaRnX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 13:43:23 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DE92A253
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:43:22 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id c14-20020a17090a1d0e00b001e328238e7eso1711884pjd.4
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/0hbb2nQ8qLOSX43QfBq0AO60VqrSoR4REXu4GQwUqw=;
        b=LUsm3w4I10jZ03x0DexY7sn6TkZ2Z6pSXXHoaqgiJIxrxk1iC6m6lGPRGY3vKiBv51
         2+KajwWxMxxpf4pAlEPiy9T8cZtoXQsDNbT343X/QHN/RHjI7xIgq1eUKLPIiqXLl4M+
         I+/057mmH0RFUQzRd3IRJslXljk7KWZjh3QXT2CxnW5A/I0Oo7GMZg8v5dghU9uGKeAE
         aHCH607Z1Ou1eYZyWx6DlX82Hipq/eGO6/3Ntod6faCXOZpa6yBX7nWVcJ/oZQf5vxH2
         LKe11dOk2/4g8ayVFYSPqyvVdGNTAfSpGknOoVk/8La770cptO8XJTEkBe20dsReXqWw
         w7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/0hbb2nQ8qLOSX43QfBq0AO60VqrSoR4REXu4GQwUqw=;
        b=LRpB1OhoS/SHBxat1N3qem56PL7H7z0XFI08pnsH1CQV4vMH+RsQS3ChkL2m/q6r0P
         9AzQp0y/cjHQRV6GesZWMFFBcwKTziYWndWzq3uU3igM3YEIWDkWNeiosxjgjkxkGdtm
         i6BUVIGsTWX6HLW0GbNqRdxgU95QYmA4IxS2lfsJHhxMZVVAF8TWk+k82AevUR70MwEC
         q1GAc268w6r7/P97ku2K003EfyxQTmdmmln6erJwps01PmjPbd8pJYdULs/JB2a8wxf3
         96NzdCD9WrVSBu9zIIBL5BMRRczfvE2Y8ZsyV9NZVVe4/TNQMrJxqwxXvV+JcNaBmL0s
         fzLA==
X-Gm-Message-State: AOAM5330Fazx7CK+ipRGjCAt5iZZuWIDlHdYmIMyrRXiNE786aFOj5Ew
        hqjTqceawdXQIJXADw99brjYh/oH3n0rYg==
X-Google-Smtp-Source: ABdhPJwQ+IOqJ3v1OyJoVc0v3YdcvvRq45ekBJo/e4LGz4w7xi4JpSlLmtfViOzMhjTj/nMExqSS9po5h4+0mw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:2348:b0:163:fc70:a4cd with SMTP
 id c8-20020a170903234800b00163fc70a4cdmr6191709plh.89.1654019001365; Tue, 31
 May 2022 10:43:21 -0700 (PDT)
Date:   Tue, 31 May 2022 10:43:15 -0700
In-Reply-To: <xmqqbkvi1owx.fsf@gitster.g>
Message-Id: <kl6lv8tlegy4.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
 <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com> <7499a2809615d42eaf3649e1c33f38d099d27c1a.1653685761.git.gitgitgadget@gmail.com>
 <xmqqbkvi1owx.fsf@gitster.g>
Subject: Re: [PATCH v3 2/5] config: read protected config with `git_protected_config()`
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Protected config is read using `read_very_early_config()`, which has
>> several downsides:
>>
>> - Every call to `read_very_early_config()` parses global and
>>   system-level config files anew, but this can be optimized by just
>>   parsing them once [1].
>> - Protected variables should respect "-c" because we can reasonably
>>   assume that it comes from the user. But, `read_very_early_config()`
>>   can't use "-c" because it is called so early that it does not have
>>   access to command line arguments.
>
> Now we are talking about protected "variable".  Is that a synonym
> for "config", or are there some distinctions between them?

Sorry, that's an old term I was toying with (this somehow snuck through
my proofreading). I just meant "variable that is only read from
protected config", aka a "protected config only variable".

A goal in this version was to introduce as little jargon as possible, so
- "protected config" refers to the set of config sources, and
- "protected config only" refers to config variables/settings that are
  only read from protected config.

>> - Protected config is stored in `the_repository` so that we don't need
>>   to statically allocate it. But this might be confusing since protected
>>   config ignores repository config by definition.
>
> Yes, it indeed is.  Is it because we were over-eager when we
> introduced the "struct repository *repo" parameter to many functions
> and the configuration system wants you to have some repository, even
> when you know you are not reading from any repository?  

Ah no, I was just trying to avoid yet-another global variable (since
IIRC we want to move towards a more lib-like Git), and the_repository
was a convenient global variable to (ab)use.

> I am wondering if it is a cleaner solution *not* to hang the
> protected config as a configset in the_repository, but keep the
> configset as a separate global variable, perhaps static to config.c
> and is meant to be only accessed via git_protected_config() and the
> like.

I think your suggestion to use a global variable is better, as much as I
want to avoid another global variable. Protected config would affect any
repositories that we work with in-core, so using a global sounds ok.

environment.c might be a better place since we already make a concerted
effort to put global config variables there instead of config.c.

As an aside, I wonder how we could get rid of all of the globals in
environment.c in the long term. Maybe we would have yet-another all
encompassing global, the_environment, and then figure out which
variables belong to the repository and which belong to the environment.

>> @@ -295,6 +295,11 @@ void repo_clear(struct repository *repo)
>>  		FREE_AND_NULL(repo->remote_state);
>>  	}
>>  
>> +	if (repo->protected_config) {
>> +		git_configset_clear(repo->protected_config);
>> +		FREE_AND_NULL(repo->protected_config);
>> +	}
>> +
>
> This becomes necessary only because each repository instance has
> protected_config, even though we need only one instance, no matter
> how many repositories we are accessing in this single invocation of
> Git, no?

Yes.

> How should "git config -l" interact with "protected config" and
> "protected variables", by the way?  Should a user be able to tell
> which ones are coming from protected scope?  Should we gain, next to
> --global, --system, etc., --protected option to list only the
> protected config/variable?

I'll have to think about this some more. My initial thoughts are that we
should do this if we formalize 'protected' as a scope-like concept, but
I don't see the lack of "--protected" as a significant hindrance to
users because they can use "--global" and "--system" (albeit in two
invocations instead of one).

> This is another thing that I find iffy on terminology.  Should a
> random variable, like user.name, be a "protected config", if it is
> found in $HOME/.gitconfig?  If it comes from there, surely we can
> trust its value, but unlike things like safe.directory, there is no
> code that wants to enforce that we pay attention only to user.name
> that came from trusted scopes.  Should such a variable be called
> "protected variable"?

Ah.. I think it would be best to pretend that the "Protected variable"
typo never happened. That term was destined to be confusing and
meaningless.

Instead, we can use "protected config" to refer to the config and
"protected config only" to refer to variables. Since "protected config"
is defined as (global + system + CLI) config, then yes, we would say
that it is "protected config". But since we do not enforce that
"user.name" _must_ come from only protected config, it is not "protected
config only".
