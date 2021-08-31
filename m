Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7E4C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 08:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC67360FC0
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 08:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240236AbhHaIQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 04:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240072AbhHaIQM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 04:16:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210A4C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 01:15:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n5so26198235wro.12
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 01:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=mGiedHCDvMMGBqjF+e3lxh2exkO7Bh5yXLcEBHM6UuQ=;
        b=X3pQYVeR4t5Sd8nMbsEAeQik3w2q5xxuPW/aMJAx/J0EthxQ6dYJtdy9zffGubiI8w
         79ILtcOTphNVaNYOybC5hq9ybomplrithRHv71NLt6OcCQfRpMJVufZkmPhqS1cKxHyp
         3KqTaf6z49tSCAdHHwcof5DDWcsC2r49vNzrLQePCEkmj3UUQGOJ1O/Dowa5pqIKo1tu
         ijftCY7r/BhXEFUXyThYXueT0/ALRqzAXllOWjcwI01VOmmPl47M1qzCeIq9p4JQ9F9O
         DAb/PTy91t/xAi0rCtrkQjg+bi4paSMU0zvI0/omTFVZwPjn5A0hj8UsCQjOXwW6vAvB
         G5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=mGiedHCDvMMGBqjF+e3lxh2exkO7Bh5yXLcEBHM6UuQ=;
        b=riW/kQNpPb8lbE2NzE9L/TQd/xxINzmxhsVM6QTghilV8r96IjqIS5EdE+cdzhkc7c
         huDate/JziWRe07IJodnFTqa0qKwXdUXmrn4Qy/2zv6P5+VpQLC5wvQMJ2Jzy7Zn+X6M
         U2jcwLvhylneeOpoGd0VAf6gbk21y1wNh2bnPU8wdwVg+ZZwSjkbNw/c12B3raN5W3aJ
         J3oRysIBYJyn5nXyIxpPfTNCCW4SjPYYpU/z69B9HSafQuVuagEsCiN73xYdOEQtlrBB
         E7tML7GVKbb1WgcoEqig2K3kRNdIxhPOMBI4eXqhxyEjzv4YD0Aw4BWJWdMsEXMzrOqv
         rgkA==
X-Gm-Message-State: AOAM5335eQuiMWQC6zaaDz2E8hf49ecw5SGhCpDySM48pNUYRJMcPKzT
        abj2rMuHK7qx9Ac5JXwjQ3s=
X-Google-Smtp-Source: ABdhPJyRoBEuSDPRI0NeGQVJn2zHQX6OjWTMH1R6WzcLp4SQAgIQ9FKij4cSL4q2fsR4NUPZIOpo2g==
X-Received: by 2002:adf:e604:: with SMTP id p4mr30134185wrm.37.1630397715628;
        Tue, 31 Aug 2021 01:15:15 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t64sm1705454wma.48.2021.08.31.01.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 01:15:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 04/15] scalar: 'register' sets recommended config and
 starts maintenance
Date:   Tue, 31 Aug 2021 10:11:31 +0200
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
 <3786f4c597fffc13f638efd26875dcb257d54ab4.1630359290.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <3786f4c597fffc13f638efd26875dcb257d54ab4.1630359290.git.gitgitgadget@gmail.com>
Message-ID: <87fsuqxc6l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 30 2021, Derrick Stolee via GitGitGadget wrote:

> [...]
> +#ifndef WIN32
> +		{ "core.untrackedCache", "true" },
> +#else
> +		/*
> +		 * Unfortunately, Scalar's Functional Tests demonstrated
> +		 * that the untracked cache feature is unreliable on Windows
> +		 * (which is a bummer because that platform would benefit the
> +		 * most from it). For some reason, freshly created files seem
> +		 * not to update the directory's `lastModified` time
> +		 * immediately, but the untracked cache would need to rely on
> +		 * that.
> +		 *
> +		 * Therefore, with a sad heart, we disable this very useful
> +		 * feature on Windows.
> +		 */
> +		{ "core.untrackedCache", "false" },
> +#endif
> [...]

Ok, but why the need to set it to "false" explicitly? Does it need to be
so opinionated as to overwrite existing user-set config in these cases?

> +		{ "core.bare", "false" },

Shouldn't this be set by "git init" already?

> [...]
> +		{ "core.logAllRefUpdates", "true" },

An opinionated thing unrelated to performance?

> [...]
> +		{ "feature.manyFiles", "false" },
> +		{ "feature.experimental", "false" },

Ditto the question about the need to set this, these are false by
default, right?

> [...]
> +		if (git_config_get_string(config[i].key, &value)) {
> +			trace2_data_string("scalar", the_repository, config[i].key, "created");
> +			if (git_config_set_gently(config[i].key,
> +						  config[i].value) < 0)
> +				return error(_("could not configure %s=%s"),
> +					     config[i].key, config[i].value);
> +		} else {
> +			trace2_data_string("scalar", the_repository, config[i].key, "exists");
> +			free(value);
> +		}

The commit message doesn't discuss these trace2 additions, these in
particular seem like they might be useful, but better done as as some
more general trace2 intergration in config.c, i.e. if the functions
being called here did the same logging on config set/get.
