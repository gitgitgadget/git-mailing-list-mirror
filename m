Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A21DC433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 15:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbhL1PN2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 10:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbhL1PN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 10:13:26 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5B5C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:13:25 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id t204so24508663oie.7
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2kjWHpSOt5zoE/VYJccMaffHb35jXB9icjdzbzPEnf4=;
        b=q3KE79AubqHoURxEJJvg0xBHgb8yejiQEE/0GhRFArF3qMbgj+xdJgbEaBZWCvK/JR
         Ht/S+EN5Sk7EG03/x+OI6k1+qEPd+w9hXWbdJ8JMDFeRK7b+DweiwjCj0Ny8mnWVQ5CL
         OFh2LXclhyKDEwxKK1wvF8bp8yEUDiuJg1Frlwsfgp14bClQkos6EgUmnpaVnEYQQEH0
         q9Pd7dG73i+wBLe3unTWQmvNGy97BhYS+MT3hzdisa+lzoGDsmNn9oww6myWC52Ub+RU
         /Gpkg4AgvGvCklJI0Z3hVsS3xEz1AbSIDB99a5S5H9dn1YMXnDhrzs6krs0uwQ/CC3bO
         oIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2kjWHpSOt5zoE/VYJccMaffHb35jXB9icjdzbzPEnf4=;
        b=2ehc92kQ5wh7JOwH5K2dZPwzOuue+hApbLgtwDO5C6IbD3/yI5IN8BCm93aUVwk3Og
         xqQNTl9/SkbcKDC6XDf2mXt9dIVigsw0AD6s2kx0nD1Oh8vleRjE+GTKYcTsGOC64xlU
         r0md8BzyO7Aj/ecBoq7L7WUwMLYnCoLMQMMtdVGT3icrwAt4Yr9sBbGyceIB4yX3k5B7
         5stSF4eqmow2gsZJmhWriuNnhzpOS1EMdTwBljhEukTq78C8vznXB9Bs+i8WvNfld1AM
         xPY3ACliqkvekxP/SjzhIWebBhvhVI1oRbz6KZ+z7xKzx5PN/MJQJuTDwwPG7NOFMcCz
         1Szw==
X-Gm-Message-State: AOAM5331KxZ0ik3mPtepEiBoUpJejRn0WssONhDTIcQMFVPv423Xddxg
        b+7u401bcZT19PAA4lJGyRY=
X-Google-Smtp-Source: ABdhPJwsXO/h/I/4vs+mdVcj4PWC5fi/mfrM35QwWp18YmWpBdkveFh9+KC2isBV52BlCoLo7QeuEA==
X-Received: by 2002:a05:6808:3c6:: with SMTP id o6mr17120181oie.145.1640704404914;
        Tue, 28 Dec 2021 07:13:24 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:a8af:d265:ced5:e098? ([2600:1700:e72:80a0:a8af:d265:ced5:e098])
        by smtp.gmail.com with ESMTPSA id 186sm3909308oig.28.2021.12.28.07.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 07:13:24 -0800 (PST)
Message-ID: <aa73d9bb-1d34-4991-a242-991251ec02be@gmail.com>
Date:   Tue, 28 Dec 2021 10:13:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 3/5] worktree: add upgrade_to_worktree_config()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        allred.sean@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <ed8e2a7b19d236642b3b8d3a49d017d29753db56.1640114048.git.gitgitgadget@gmail.com>
 <xmqq4k71mc75.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq4k71mc75.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/22/2021 12:38 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +int upgrade_to_worktree_config(struct repository *r)
> 
> Not a suggestion to rename the function, but does it mean "we have
> been using a single configuration for all worktrees attached to the
> repository, but we are switching to use per-worktree configuration
> file"?  I am wondering if the phrase "worktree_config" is clear
> enough for our future developers.
> 
>> +{
>> +	int res;
>> +	int bare = 0;
>> +	struct config_set cs = { 0 };
>> +	char *base_config_file = xstrfmt("%s/config", r->commondir);
>> +	char *base_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
>> +
>> +	git_configset_init(&cs);
>> +	git_configset_add_file(&cs, base_config_file);
>> +
>> +	/*
>> +	 * If the base repository is bare, then we need to move core.bare=true
>> +	 * out of the base config file and into the base repository's
>> +	 * config.worktree file.
>> +	 */
>> +	if (!git_configset_get_bool(&cs, "core.bare", &bare) && bare) {
>> +		if ((res = git_config_set_in_file_gently(base_worktree_file,
>> +							"core.bare", "true"))) {
>> +			error(_("unable to set core.bare=true in '%s'"), base_worktree_file);
>> +			goto cleanup;
>> +		}
> 
> Hmph, I would have expected to see
> 
> 		if (git_config_set_in_file_gently(...)) {
> 			res = error(_("..."));
>                         goto cleanup;
> 		}
> 
> instead (obviously with "res" initialized to "0" to assume all will
> be well at the beginning).

Deep down in the git_config_set_... stack, it returns helpful error
codes that I thought would be good to communicate upwards. cmd_config()
uses these error codes, too, but that's a more obvious place where the
user is expecting the error code to be related to the config operation.
 
If this communication is not helpful, then I will use the pattern you
suggest. I will assume this is the case unless told otherwise.

> More importantly, are we prepared to see the repository 'r' that
> already uses per-worktree config layout and refrain from causing any
> damage to it, or are we all perfect developers that any caller that
> calls this on repository 'r' that does not need to be upgraded is a
> BUG()?

I don't think we should add burden to the callers to check that the
repo is not using worktree config. Thinking back to your rename idea
this could be "ensure_using_worktree_config()" to make it clear that
we will use the worktree config after the method, whether or not we
were using it beforehand.

I think this current implementation is non-damaging if someone calls
it after already using worktree config. The change being that a user
can go and add core.bare=false to the common config file and break all
worktrees again, and the current implementation will help heal that.
It's probably better to let the user have that ability to mess things
up and not try to fix something so broken.

Thanks,
-Stolee
