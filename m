Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE6FC3815B
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 15:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C811E20768
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 15:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzSEEapu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437171AbgDNPKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437193AbgDNPKh (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 11:10:37 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FF9C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 08:10:37 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id q17so10091291qtp.4
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WqmvQZwHQ/gM/HzRkPqhxlo2TmG/jjsMabkBBZsQUEA=;
        b=DzSEEapuxKPFUArGvuOPo2zcCva8qWkVkPK/mzUY7JqGN7eLf44mrweaq/fnEgQl2i
         lUs2ANxRDpg/iwsZp59Dh1G/VA+SYdASmA2dVwRdljhu2gBZBINZybg+Ipq8j8RXEkar
         lX/4NgoWJjmT+2/q/mp8B/BgVWXZ/ojiwe6m8EIZ3190o2sI7VS5hlcN+IN7XheS9HmC
         El1irGJsPjweY+ECr+YqTtOPnxdXDKnDUfKZbFhw7sfjyGNdhThoPDd/xWQYIsK8pM42
         FTb/LpaQJjsGxLIH2kMF4+dTJ0QrTGUl3Y2H8BWSjYDkEyWrPsftGBW6/S0dJFDxxsrU
         ElAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WqmvQZwHQ/gM/HzRkPqhxlo2TmG/jjsMabkBBZsQUEA=;
        b=iM69jD9R9OdJGgW6YSbvpqsSPBd8gRr6HxhinT8lReWkOpWlLoZfgxek3Jla3LY/OD
         aogOOxWWcux8EUoWitX77Lapkm7Iz85ikop65VxY65g7kKtg2y1Mp2h/TfEe48A5tDXG
         5LAcAxJiG6CJmfYnSKiq6GEZmOFhj4SPnZ3rtz9xzbx5FLvUUghPDu2tmcErCMnGkAyZ
         RvLRKWtpN13ija0RrijMZgh3yfSTh+OIlLw9X6PwjjJAehQ7SE2S5Gb7eh8Xr18KrJrJ
         TSm+LDxX+nGbUWlSnEctqolm/M99xLLOedjs/DPff6cd/TpTYKV1uK/GlP/dsZJYWAVp
         SfIw==
X-Gm-Message-State: AGi0PuZdCH05Im4pW5tfFIAXv8PRVJs4Okmul8iI7EHn3d/y3bko5RoR
        q0oKL/qLyoGtUPrCviQAwIg=
X-Google-Smtp-Source: APiQypLzXEBYzcaJjbgq/cjMOmpxy/XM2fBMprllhr/DMWCIzDqZ5FHEdP/+xzE61wgV+MB59h/u2A==
X-Received: by 2002:ac8:1ad1:: with SMTP id h17mr16894501qtk.9.1586877036072;
        Tue, 14 Apr 2020 08:10:36 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id v27sm1822756qtb.35.2020.04.14.08.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 08:10:35 -0700 (PDT)
Subject: Re: [PATCH] log: add log.excludeDecoration config option
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sluongng@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.610.git.1586791720114.gitgitgadget@gmail.com>
 <20200413154945.GA59601@syl.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0b9e3156-1101-0f19-91eb-36af541519aa@gmail.com>
Date:   Tue, 14 Apr 2020 11:10:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <20200413154945.GA59601@syl.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/13/2020 11:49 AM, Taylor Blau wrote:
> Hi Stolee,
> 
> On Mon, Apr 13, 2020 at 03:28:39PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> In 'git log', the --decorate-refs-exclude option appends a pattern
>> to a string_list. This list is used to prevent showing some refs
>> in the decoration output, or even by --simplify-by-decoration.
>>
>> Users may want to use their refs space to store utility refs that
>> should not appear in the decoration output. For example, Scalar [1]
>> runs a background fetch but places the "new" refs inside the
>> refs/scalar/hidden/<remote>/* refspace instead of refs/<remote>/*
>> to avoid updating remote refs when the user is not looking. However,
>> these "hidden" refs appear during regular 'git log' queries.
>>
>> A similar idea to use "hidden" refs is under consideration for core
>> Git [2].
>>
>> Add the 'log.excludeDecoration' config option so users can exclude
>> some refs from decorations by default instead of needing to use
>> --decorate-refs-exclude manually. The config value is multi-valued
>> much like the command-line option.
>>
>> There are several tests in t4202-log.sh that test the
>> --decorate-refs-(include|exclude) options, so these are extended.
>> Since the expected output is already stored as a file, simply add
>> new calls that replace a "--decorate-refs-exclude" option with an
>> in-line config setting.
>>
>> [1] https://github.com/microsoft/scalar
>> [2] https://lore.kernel.org/git/77b1da5d3063a2404cd750adfe3bb8be9b6c497d.1585946894.git.gitgitgadget@gmail.com/
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>     log: add log.excludeDecoration config option
>>
>>     This was something hinted at in the "fetch" step of the background
>>     maintenance RFC. Should be a relatively minor addition to our config
>>     options.
>>
>>     We definitely want this feature for microsoft/git (we would set
>>     log.excludeDecoration=refs/scalar/* in all Scalar repos), but we will
>>     wait for feedback from the community.
>>
>>     Thanks, -Stolee
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-610%2Fderrickstolee%2Flog-exclude-decoration-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-610/derrickstolee/log-exclude-decoration-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/610
>>
>>  Documentation/config/log.txt |  5 +++++
>>  builtin/log.c                | 14 ++++++++++++++
>>  t/t4202-log.sh               | 22 ++++++++++++++++++++++
>>  3 files changed, 41 insertions(+)
>>
>> diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
>> index e9e1e397f3f..1a158324f79 100644
>> --- a/Documentation/config/log.txt
>> +++ b/Documentation/config/log.txt
>> @@ -18,6 +18,11 @@ log.decorate::
>>  	names are shown. This is the same as the `--decorate` option
>>  	of the `git log`.
>>
>> +log.excludeDecoration::
>> +	Exclude the specified patterns from the log decorations. This multi-
>> +	valued config option is the same as the `--decorate-refs-exclude`
>> +	option of `git log`.
>> +
> 
> Thanks for this documentation update. Do you think that it would be
> worth updating the entry for '--decorate-refs-exclude', too? I figure
> that it would be good, since scripters who look at 'git log's man page
> before 'git config's would have a trail to follow in case they want a
> persistent '--decorate-refs-exclude' option.

That seems like a good way to help users.

>>  log.follow::
>>  	If `true`, `git log` will act as if the `--follow` option was used when
>>  	a single <path> is given.  This has the same limitations as `--follow`,
>> diff --git a/builtin/log.c b/builtin/log.c
>> index 83a4a6188e2..d7d1d5b7143 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -236,7 +236,21 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>>  	}
>>
>>  	if (decoration_style) {
>> +		const struct string_list *config_exclude =
>> +			repo_config_get_value_multi(the_repository,
>> +						    "log.excludeDecoration");
>> +
>> +		if (config_exclude) {
>> +			struct string_list_item *item;
>> +			for (item = config_exclude->items;
>> +			     item && item < config_exclude->items + config_exclude->nr;
>> +			     item++)
> 
> Any reason not to use the 'for_each_string_list_item' macro in
> 'string-list.h' for this?

The reason is I forgot about it.

Thanks,
-Stolee
