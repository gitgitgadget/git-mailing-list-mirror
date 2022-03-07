Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B678C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 11:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbiCGL0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241968AbiCGL0D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 06:26:03 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435484EA1C
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 02:58:52 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id h13so7139358ede.5
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 02:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=EfZYKkTte0a/q0uuewMKWZFdaP5BDKOVKPEDSsLlhMo=;
        b=ieJgmOvXNa0quFyjGaHR7KCdrjpkifbHwKDZz/D4ES+aO2xGT1lhuSJZJa59AGCv+o
         D71nkg3e+d1P5Ri81+J8rCLwHYEHVOxd5nc3g5/i4saw3Z8JGJg7mc+6dUFfF9vHHQXy
         q+53muwOgV7f9ttURQ1yTgGtprPOxFh5S8niD6WlUd+yYMKd97hI7THjw3/KHa3Lb0Pr
         SoLVg3wtqeOvgl365jAiDxMReol9gtosqx5Oq5rnM9IRIctHjZvFIE5KEJGV7Ezdkyjd
         y3kWPKN9hEvJqUMeerKGFD+Y30Xp9krYqCY6WVPqrJcZWXOaoz9nlhUYupGFiaB8hcME
         VwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=EfZYKkTte0a/q0uuewMKWZFdaP5BDKOVKPEDSsLlhMo=;
        b=pI4N0ojm2pzEzJlE5USf2Ih/dewzOqrD+tDI67xJl4vZZIBHTO98BWLHTDfa6bSxe2
         OqDXFYdJgMI7Mx/T2te7mkQxk1MhBTHagfPDFEWfinFd5FLY14zUCEsIE7oMcPKpSjM9
         O0A1XV8MEn5SllVFHPo9OcTYEWStMKgO9I7CDcByBBmA39XwnOADM5qf3ghJhb1ovPdF
         NVjFfoyIwBBU05JOpO/B7GAjvKZDvFLt//EF3c2AaGIIClpVdqA1AtEJYYw2gxruB81u
         j7Kb/tEjE2eShwLbYiMbTyZXq65tNPiSmqtA1KJwuRAf1LLR5Vk5EvkbEh0oXx5JEDqE
         CRDg==
X-Gm-Message-State: AOAM531d8D4UOhYqNazeWdECOd8sFulaYFxq0p0GDVRuGdLS10f8wlVx
        rmys7cU315Gw6nWFJiB85IUnG09Kf/g=
X-Google-Smtp-Source: ABdhPJw4rWQIc+jbar8HbnfqxJeSr5b1kvwXFx3qYkAHwXSFe8xSwNF8lvFGKjvqwuCcvkhv8K1B4A==
X-Received: by 2002:aa7:c4cf:0:b0:416:e28:45b9 with SMTP id p15-20020aa7c4cf000000b004160e2845b9mr10589906edr.319.1646650730441;
        Mon, 07 Mar 2022 02:58:50 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e12-20020a056402190c00b0041615cd434csm3861545edz.60.2022.03.07.02.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 02:58:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRB4j-001Qi3-8n;
        Mon, 07 Mar 2022 11:58:49 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 20/30] t/helper/fsmonitor-client: create IPC client
 to talk to FSMonitor Daemon
Date:   Mon, 07 Mar 2022 11:53:27 +0100
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <2b563c240eb1b592e95e89400aa5d57df1bf29b8.1646160212.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <2b563c240eb1b592e95e89400aa5d57df1bf29b8.1646160212.git.gitgitgadget@gmail.com>
Message-ID: <220307.868rtm2fme.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> [...]
> +/*
> + * test-fsmonitor-client.c: client code to send commands/requests to
> + * a `git fsmonitor--daemon` daemon.
> + */
> +
> +#include "test-tool.h"
> +#include "cache.h"
> +#include "parse-options.h"
> +#include "fsmonitor-ipc.h"
> +
> +#ifndef HAVE_FSMONITOR_DAEMON_BACKEND
> +int cmd__fsmonitor_client(int argc, const char **argv)
> +{
> +	die("fsmonitor--daemon not available on this platform");

UX strings added in the series should be marked for translation with
_(), but in this case this is correct as this is a test helper, so only
git developers will see it. We shouldn't waste translator time on it.

> +		die("unable to read index file");

...ditto

> +		die(_("could not query fsmonitor--daemon"));


...but this one is marked for translation, but shouldn't be.

There are other such cases in this series, found by e.g. diffing
origin/master.. and grepping for '"', not noting all of those in review,
I trust you can eyeball them & see what's missing ... :)

> +	if (argc == 2 && !strcmp(argv[1], "-h"))
> +		usage_with_options(fsmonitor_client_usage, options);

I don't think you need this special handling for -h...

> +
> +	subcmd = argv[1];
> +	argv--;
> +	argc++;
> +
> +	argc = parse_options(argc, argv, NULL, options, fsmonitor_client_usage, 0);

...because this will do it for you.
