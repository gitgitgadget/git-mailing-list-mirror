Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9817FC433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 22:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbiBUW6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 17:58:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbiBUW6T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 17:58:19 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AEFE23
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 14:57:55 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id lw4so36949846ejb.12
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 14:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=MO2gPPRiiFE7QpjAcTKgklrnsUVaxLRNCJgaSMg4z6M=;
        b=ByRhi+vt2Ex9tqHmofafKQgvM7/NwKJ5UsZDUCzyyPfhseXfTMhwkSDEMFz0S5zbBX
         beFgJ+ANfDSl7m0kYeaYrzevrZIgMEJ0lVDqyZ1+b81Uq2HLoVDWIsskH+tJ4eXvLMBT
         dygbuP1ZTcks/3QDmzsyZVQJppayZ+iMblsp+wsx36+QK1FRvL0mFtRI1V1oMrUbKnOw
         mzNQ2IxXdneKKqtNSmuzahMd9udWAuejDuZ/lP+thVoKOYD7OceTUaC7FtulPo8f6LSB
         Py/38ZXveJJ8ka347KXTZzh0kqT/c+jTNtf0NvTL7sudrtHEDM/zNbPgTA3fpFHUh8sX
         4bZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=MO2gPPRiiFE7QpjAcTKgklrnsUVaxLRNCJgaSMg4z6M=;
        b=KihM7qd9iUcSfQ0x1MDVs0SbmuPQzndpJz22F66jUjA38ADXkTjyc+hT5APNQcbobu
         G+q9PubWSfGqeY9NKlDmR8uGT2fuup42D9Ta9ICMX5PB5bWkaItxcqahOb2RYndGIQTz
         LXWw7uS216fa2jhTv5IBDym/IkoOc0eZLD/AfaJNpnvfjhh+8TGwT7ZqZETVWWPqiWiV
         i0P3Op5NhliYPOJFYmLDvajFbGGqv9KcOfupTDYCJZgXKLFueA9rtPpSm1DpDBDZjOsV
         wbd4iZ6YJGfqxKVXq+7h8jNaz6XYDEXS+ATM52UY9DFCOdnmSnT/NYpKOOl/2/8Iu7Rv
         82nA==
X-Gm-Message-State: AOAM531vKI1dq4Q86qwvUBM0FX6L8k9+5riTCJEy502ngSydMqcFwb9s
        lXjn0yfTjCTWGvDlo+0eFAg=
X-Google-Smtp-Source: ABdhPJymZ+KFEmcqnpW3FB79PaWLmiPmNVq7he5jZDOWMvTdicL9unrFY70FzytNN+LNAoZyux+9Qg==
X-Received: by 2002:a17:906:b887:b0:6ce:36cb:1e18 with SMTP id hb7-20020a170906b88700b006ce36cb1e18mr17476578ejb.95.1645484274187;
        Mon, 21 Feb 2022 14:57:54 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j23sm5559772eja.204.2022.02.21.14.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 14:57:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMHcu-005qSl-Cb;
        Mon, 21 Feb 2022 23:57:52 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, jabolopes@google.com,
        Jeff Hostetler <jeffhostetler@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] Provide config option to expect files outside sparse
 patterns
Date:   Mon, 21 Feb 2022 23:53:08 +0100
References: <pull.1153.git.1645333542011.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202212100080.4418@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2202212100080.4418@tvgsbejvaqbjf.bet>
Message-ID: <220221.86a6ejakun.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 21 2022, Johannes Schindelin wrote:

> Hi Elijah,
>
> In addition to Stolee's feedback...
>
> On Sun, 20 Feb 2022, Elijah Newren via GitGitGadget wrote:
>
>> diff --git a/config.c b/config.c
>> index 2bffa8d4a01..68e877a1d80 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -1520,6 +1520,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
>>  		return 0;
>>  	}
>>
>> +	if (!strcmp(var, "core.expectfilesoutsidesparsepatterns")) {
>> +		core_expect_files_outside_sparse_patterns = git_config_bool(var, value);
>> +		return 0;
>> +	}
>
> The `core` section is already quite crowded (for which I am partially
> responsible, of course).
>
> Maybe it would be a good idea to introduce the `sparse` section, using
> `sparse.allowFilesMatchingPatterns` or `sparse.applyPatternsToWorktree =
> false`?

There's a large list of exceptions to this, but generally we have core.*
for cross-command configuration, and <cmd>.* for command-specific
configuration.

Excetions include http.*, mailmap.*, pack.* (arguably), trace2.*.

In this case though we have 2x /^core\.sparse[A-Z].*/ variables in
git-config(1) already.

So perhaps we could name it like that, then at least you'd find all of
these in the same place when looking through that documentation,
although a name starting with "core.sparse" might not be otherwise
ideal.

There's also no law that says we can't have a three-level variable as
core.sparse.*, perhaps that would be the start of a good trend, and it
would sort adjacent to core.sparse[A-Z].* ...
