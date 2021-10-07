Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C11C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 17:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08D19610EA
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 17:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243170AbhJGRNE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 13:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241593AbhJGRND (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 13:13:03 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FACDC061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 10:11:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r18so25742185edv.12
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=SbFJBOzWJXfPXhBwrl5S+HY3ES3Ol01/gVbAXRmLCwk=;
        b=B/aaaUU5Mjhq5NwqQLfBpjhDRgdVZY2Q2saKLfrLACW+czBTL40YCyzo7xTP9uDg0l
         eZDV7Ya7DxHOeP5E0J1SiW03ZGBGpYoaWPwMwkIR66ZoOPpvr5/77o5fogPFmroMoOvp
         aaDxBf3LiuWqV8gqEJZIa+xLFu2oEnzniK6r/4/5yfGhflYb9p/NaWFenxZSJHaTEsPo
         yAezthxFmkdKihEt66O2CtQayZc+eOqu3Kr7wryJvzQ760KhxzlV5CiFFSEgyv2j6Lre
         tnYQsHcLQ1RbHyetuvPre3dPy+z90HoiExYBeSuU7zcJ4LeFJYzdQLwhSoEmJIpUUgZz
         ImZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=SbFJBOzWJXfPXhBwrl5S+HY3ES3Ol01/gVbAXRmLCwk=;
        b=Y4EYZ1Za/2N3Hirn835J6tMx4ZpIB8PrkUBr+9mYW4K4d1pk0aDe+fXqA5TuV3y33q
         kgXfHkXYKbEUo5fIyl5JEEq6TitnkklLog1QXfPn9rZNSGx+GTgM83beWHS4NjvLZemp
         6zwFL/2wzdSdWd5UXteUJQF4Mup6kIulsP9k1/8Zct2qhygI+4vL8eVh5PTSLHDVqkN1
         3V1FrM17qjf45m35O0N5p6rFUaA3koWl3ftBpnYD1CB/BJ/hwaxpYgEng/9FTWhLS0AY
         GakA4mXig6BYxfP2nB6zaVsSJ3+rIvRkdC7pbA6UIUMpNM+eruPk+2thVy+Z8N4P8xew
         QAEw==
X-Gm-Message-State: AOAM532O+0k337G+dB/VQLXZg1u+N5GO5640ApJCxIhYO0J+NJCWqXBW
        gxzpQpJqDwYGNWckqrdL1D/MgkJyWzyHog==
X-Google-Smtp-Source: ABdhPJwTGyYPjh0qXJjMMqLfIqx67s1AY/2BAhHrnvnJAjyJqPMHaKgFNRYBh5D6DU9Vn11fhYYXdw==
X-Received: by 2002:a17:906:9b46:: with SMTP id ep6mr3356278ejc.226.1633626667447;
        Thu, 07 Oct 2021 10:11:07 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id nd36sm4927ejc.17.2021.10.07.10.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 10:11:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 3/5] fsmonitor: config settings are repository-specific
Date:   Thu, 07 Oct 2021 18:59:07 +0200
References: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
 <pull.1041.v2.git.1633614772.gitgitgadget@gmail.com>
 <7d5a353e74d2f2a1ed3f9275425bb564265323d6.1633614772.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <7d5a353e74d2f2a1ed3f9275425bb564265323d6.1633614772.git.gitgitgadget@gmail.com>
Message-ID: <877deohiad.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 07 2021, Jeff Hostetler via GitGitGadget wrote:

Good to see this move forward!

This bit:

> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -20,6 +20,8 @@ void prepare_repo_settings(struct repository *r)
>  	if (r->settings.initialized++)
>  		return;
>  
> +	r->settings.fsmonitor = NULL; /* lazy loaded */
> +
>  	/* Defaults */
>  	r->settings.index_version = -1;
>  	r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
> diff --git a/repository.h b/repository.h

Is carried forward from v1, but with 3050b6dfc75 (repo-settings.c:
simplify the setup, 2021-09-21) isn't needed. It's init'd to 0/NULL
already, but was -1 before.

So this hunk can go, and its presence makes for confusing reading
without that history, is it set before somehow? No, just working around
older code that's no longer there.

But also: For untracked_cache_setting and fetch_negotiation_setting
we've got an embedded enum in the struct, but this...

> index a057653981c..89a1873ade7 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -4,6 +4,7 @@
>  #include "path.h"
>  
>  struct config_set;
> +struct fsmonitor_settings;
>  struct git_hash_algo;
>  struct index_state;
>  struct lock_file;
> @@ -34,6 +35,8 @@ struct repo_settings {
>  	int command_requires_full_index;
>  	int sparse_index;
>  
> +	struct fsmonitor_settings *fsmonitor; /* lazy loaded */
> +
>  	int index_version;
>  	enum untracked_cache_setting core_untracked_cache;
>  

Is a pointer to a struct that has an "enum fsmonitor_mode mode", and the
code in fsmonitor-settings.c seems to be repeating the patterns we had
in repo-settings.c pre-3050b6dfc75, e.g. checking whether a bool config
variable exists *and* is true, v.s. checking if it exists (presumably an
explicit false wants to override something).

I haven't looked carefully, but between that & the "char *hook_path"
being something that'll need to be made to use Emily's hook config
series sooner than later, can't we read/setup the initial config in
"repo_cfg_bool"?

The relevant commit message just says:

    Move FSMonitor config settings to a new `struct fsmonitor_settings`
    structure.  Add a lazily-loaded pointer to `struct repo_settings`.
    Create `fsm_settings__get_*()` getters to lazily look up fsmonitor-
    related config settings.[...]

Which I think can be paraphrased as "Add scaffolding to repo-settings.c
but do config loading differently than everything there (lazily),
because...", except the "because" is missing :)


