Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A821EC433F5
	for <git@archiver.kernel.org>; Tue, 17 May 2022 20:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbiEQUYm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 16:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343591AbiEQUYk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 16:24:40 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FC1527E1
        for <git@vger.kernel.org>; Tue, 17 May 2022 13:24:38 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id g5-20020a17090a4b0500b001df2807132fso1985371pjh.7
        for <git@vger.kernel.org>; Tue, 17 May 2022 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=B0GS6f3oeGqBHkOORxHP+IUiQUwSNicnmPhR2wecrbk=;
        b=bY6lLAwbl+EE3vo8qQE7kpKIckdOfM55eXvk4jbnuOMgTK3+hJUU0+xQdUB8KurCex
         leson73xuShbZOwjzMnWCjUt5vQl71evn6MuYn73BOlGkaLKyKpN7iyhSEq5ANrG9iOO
         7vAVSvAjkvT0oE0PqIP9fAB/tBdBCigDRxTrrw1KHzQJWgzYZTegA7H6vbar93dgFAzn
         xYWxY0Ge02SHxmnuuMMCvnVYnalBeccSwUrniMJGkGG6qGM20wIA7AMlmptElckbUSql
         +QW85mg3Futl0Xzy16NHWpdgzvdP58OApWRo3HU47oH5WwBOfd49TBk1XCFpCTXVcw2L
         NDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B0GS6f3oeGqBHkOORxHP+IUiQUwSNicnmPhR2wecrbk=;
        b=s2rJ07+q8TPJBw5MwnQNhJwLuFQYoQHu+h8t8zOEzpVQaK02Nq1iMlnP8sR5RDeVuH
         sTKAksKl3j6cYnn2U3g2AGdDcmgb9gS73jpCbuso9oVYK0AW74htvPeqss2uc635jadq
         G84KQUzKQuOElUEJwk68YJ/NAbI+Z5HalofYMyI5gQmqr9TuoAr2rBenBTOsnn2iIgkp
         avOYufUkkMduD0E0A+Kj75SaCEf5+7ICAYyEndz1R78Gp/lSkesZBBWnosSpgyR+rEpi
         uxbOMEp4WuKd7jLb6wGkrpjomsY9xg4jgSwdLWi9MYfOBhXjBEyvuvPVwi7IdZsSUEt+
         WSow==
X-Gm-Message-State: AOAM530/aRh7q8m0rcEjtx72acApWgBirapxuae3hXLxG67NXhkdQDs+
        L7PHXKzFjk163mRdxI5hkpAKILrjRpgYFw==
X-Google-Smtp-Source: ABdhPJwCKg5Izmczl0KLp05LlA2q7PbWT6XoFOz0IC38IbbhbhTg0l3LoAxcjiEl3/Ftaw7YawIqxlK+ibFLpw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1bce:b0:1dc:9a4e:bc66 with SMTP
 id oa14-20020a17090b1bce00b001dc9a4ebc66mr26514650pjb.70.1652819078139; Tue,
 17 May 2022 13:24:38 -0700 (PDT)
Date:   Tue, 17 May 2022 13:24:29 -0700
In-Reply-To: <e5139922-9b74-ebfa-756c-629918e0456b@github.com>
Message-Id: <kl6lilq3j4aq.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
 <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com> <22b10bf9da8ccf4ae4da634aadfdaff5ee7a3508.1652485058.git.gitgitgadget@gmail.com>
 <e5139922-9b74-ebfa-756c-629918e0456b@github.com>
Subject: Re: [PATCH v2 1/2] setup.c: make bare repo discovery optional
From:   Glen Choo <chooglen@google.com>
To:     Derrick Stolee <derrickstolee@github.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for being thorough, I find it really helpful.

For brevity, I won't reply to comments that I think are obviously good,
so you can assume I'll incorproate anything that isn't commented on.

Derrick Stolee <derrickstolee@github.com> writes:

> On 5/13/2022 7:37 PM, Glen Choo via GitGitGadget wrote:
>> From: Glen Choo <chooglen@google.com>
>> 
>> +This config setting is only respected when specified in a system or global
>> +config, not when it is specified in a repository config or via the command
>> +line option `-c discovery.bare=<value>`.
>
> We are sprinkling config options that have these same restrictions throughout
> the config documentation. It might be time to define a term like "protected
> config" at the top of git-config.txt and then refer to that from these other
> locations.

Agree, and I think defining the term will be useful in future on-list
discussions.

>> +static int check_bare_repo_allowed(void)
>> +{
>> +	if (discovery_bare_config == DISCOVERY_BARE_UNKNOWN) {
>> +		read_very_early_config(discovery_bare_cb, NULL);
>
> This will add the third place where we use read_very_early_config(),
> adding to the existing calls in tr2_sysenv_load() and
> ensure_valid_ownership(). If I understand it correctly, that means
> that every Git execution in a bare repository will now parse the
> system and global config three times.
>
> This doesn't count the check for uploadpack.packobjectshook in
> upload-pack.c that uses current_config_scope() to restrict its
> value to the system and global config.
>
> We are probably at the point where we need to instead create a
> configset that stores this "protected config" and allow us to
> lookup config keys directly from that configset instead of
> iterating through these config files repeatedly.

Looking at all of the read_very_early_config() calls,

- check_bare_repo_allowed() can use git_configset_get_string()
- ensure_valid_ownership() can use git_configset_get_value_multi()
- tr2_sysenv_load() reads every value with the "trace2." prefix. AFAICT
  configsets only support exact key lookups and I don't see an easy way
  teach configsets to support prefix lookups.

(I didn't look too closely at uploadpack.packobjectshook because I don't
know enough about config scopes to comment.)

So using a configset, we'll still need to read the config files at least
twice. That's better than thrice, but it doesn't cover the
tr2_sysenv_load() use case, and we'll run into this yet again if add
function that reads all config values with a given prefix.

An hacky alternative that covers all of these use cases would be to read
all protected config in a single pass, e.g.

  static struct protected_config {
         struct safe_directory_data safe_directory_data;
         const char *discovery_bare;
         struct string_list tr2_sysenv;
  };

  static int protected_config_cb()
  {
    /* Parse EVERYTHING that belongs in protected_config. */
  }

but protected_config_cb() would have to parse too many unrelated things
for my liking.

So I'll use the configset for the cases where the key is known, and
perhaps we'll punt on tr2_sysenv_load().

>> +	}
>> +	switch (discovery_bare_config) {
>> +	case DISCOVERY_BARE_NEVER:
>> +		return 0;
>> +	case DISCOVERY_BARE_ALWAYS:
>> +		return 1;
>> +	default:
>> +		BUG("invalid discovery_bare_config %d", discovery_bare_config);
>> +	}
>
> You return -1 in discovery_bare_cb when the key matches, but
> the value is not understood. Should we check the return value
> of read_very_early_config(), too?

This comment doesn't apply because unlike most other config reading
functions, read_very_early_config() and read_early_config() die when the
callback returns -1.

I'm not sure why this is the case though, and maybe you think there is
value in having a non-die()-ing variant, e.g.
read_very_early_config_gently()?

>>  };
>>  
>>  /*
>> @@ -1239,6 +1293,8 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>>  		}
>>  
>>  		if (is_git_directory(dir->buf)) {
>> +			if (!check_bare_repo_allowed())
>> +				return GIT_DIR_DISALLOWED_BARE;
>
> Won't this fail if someone runs a Git command inside of a .git/
> directory for a non-bare repository? I just want to be sure that
> we hit this error instead:
>
> 	fatal: this operation must be run in a work tree
>
> I see that this error is tested in t0008-ignores.sh, but that's
> with the default "always" value. It would be good to explicitly
> check that this is the right error when using the "never" config.

Yes, it will fail if run inside of a .git/ directory. "never" prevents
you from working from inside .git/ unless you set GIT_DIR.

IIRC, we don't show "fatal: this operation must be run in a work
tree" for every Git command, e.g. "git log" works just fine. It makes
sense to show this warning when the CWD supports 'some, but not all' Git
commands, but I don't think this is valuable if we forbid *all* Git
commands.

Instead of trying to make "never" accomodate this use case, perhaps what
we want is a "dotgit-only" option that allows a bare repository if it is
below a .git/ directory. Since we forbid .git in the index, this seems
somewhat safe, but I hadn't proposed this sooner because I don't know if
we need it yet, and I'm certain that there are less secure edge cases
that need to be thought through.
