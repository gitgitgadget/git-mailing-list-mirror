Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02755C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 15:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiBVPlr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 10:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiBVPlq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 10:41:46 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC062163055
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 07:41:20 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s14so20523379edw.0
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 07:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KTdD4i4fMsW17UGGijKNj3P9orBFCT7ErBZSp9p+slw=;
        b=aJXmoumlg6Nu4x4d6/ShvDrrg9xWcr3hEFoONwKJhwDMc4LjNdUsbMHTuJpNUsREca
         ekswHYARp/5rgCmZtwVynB4VWUDXWxApwzevKBKYodeLrcDNByBMqF9it8Ookq2PqXUm
         M7G+ScKNscnjwf3LuJG1oCyWtS6WdRxTGkZmH9/WRPnibBwtOZOHOpMk1AAr0kMoxqQ6
         2oL4Eo7nZVpgni+oZMVoFyTeGPFwYdTzWwzttqSMPlPendwkMZ6vgAx+6UCxk5ckU+/B
         VkGrvHExIT1CM4nKdWct1fpSl4xPyrFPN8RyObnt0QZH1VzQKzI7AkRdi00Zq02srLp2
         KRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KTdD4i4fMsW17UGGijKNj3P9orBFCT7ErBZSp9p+slw=;
        b=Ej5rxm24hVFs9lXfB77cCuZaXU+DqRVFSOKJjY3mYO0SVPDnofP4j/DpkmEtWSyjUL
         2iLWZn1/xO8+o3OQ3Z/2GnZhZ2L2Hcj0SPCUwR71qhr4I0DCABPBQhSVItUjz+ypESIU
         QPz+PqOuAGaCbOVcn6+YHOK0d1YBw5l04fgDJ7vH5+Jn+dxz1aXj2x7K2RmB3CLD0wdN
         HIju6F2nDnRNiJ8bI7nylFisHDKQPw1BrBqMAABDXFDYWar9tTTo8JEyYB15BoLAZbHy
         p3EO6zffzq4IomvYNEGt18IScnayjBvmic3DFIjGrHaomFgMos6Tw6q+3BOBc4wG5Giv
         QyMQ==
X-Gm-Message-State: AOAM531sirgnQwDMwdhpoUJUkA7MrYfzrXjlMd7BX1s8jrTHdVPvWdbU
        KtxsevJehuwXvWKSwMZWb8Y=
X-Google-Smtp-Source: ABdhPJxWJXePoPvnr/b0kInj6v8IxuFl++mQ+MsxxVdoYWqjX2KjwpfCgyflgBiyxJIsI/7qiDnEHg==
X-Received: by 2002:aa7:c0d0:0:b0:410:d576:8808 with SMTP id j16-20020aa7c0d0000000b00410d5768808mr27258710edp.340.1645544479201;
        Tue, 22 Feb 2022 07:41:19 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m11sm10540395edc.110.2022.02.22.07.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 07:41:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMXHy-006BPg-5u;
        Tue, 22 Feb 2022 16:41:18 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 2/2] rebase: `preserve` is also a pull option, tell
 dying users
Date:   Tue, 22 Feb 2022 16:34:56 +0100
References: <pull.1155.git.1645526016.gitgitgadget@gmail.com>
 <eb5871db95b12500cc0a6b8b0e3a82ed9e8fcfbd.1645526016.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <eb5871db95b12500cc0a6b8b0e3a82ed9e8fcfbd.1645526016.git.gitgitgadget@gmail.com>
Message-ID: <220222.868ru27vtt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 22 2022, Philip Oakley via GitGitGadget wrote:

> From: Philip Oakley <philipoakley@iee.email>
>
> The `--preserve-merges` option was removed by v2.35.0. However
> users may not be aware that it is also a Pull option, and it is
> still offered by major IDE vendors such as Visual Studio.
>
> Extend the `--preserve-merges` die message to direct users to
> this option and it's locations.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/rebase.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 07221d0ae41..97f704bb297 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1205,7 +1205,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			     builtin_rebase_usage, 0);
>  
>  	if (preserve_merges_selected)
> -		die(_("--preserve-merges was replaced by --rebase-merges"));
> +		die(_("--preserve-merges was replaced by --rebase-merges\n"
> +			"Also, check your `pull` configuration settings\n"
> +			"`git config --show-scope --show-origin --get-regexp 'pull.*'`\n"
> +			"which may also invoke this option."));

I may be missing some subtlety, but how is the user ever going to need
to check their config?

After 52f1e82178e (pull: remove support for `--rebase=preserve`,
2021-09-07) we:

    $ git -c pull.rebase=preserve pull
    error: rebase.c:29: preserve: 'preserve' superseded by 'merges'
    fatal: builtin/pull.c:45: Invalid value for pull.rebase: preserve

I.e. we'd error before this, and the "preserve_merges_selected" variable
being checked here is not affected by config, i.e. we only ever got to
this "via config" route if "pull" et al was invoking us.

But now that command dies.

If there is still a codepath where we call "rebase --preserve-merges" on
the basis of config that I've missed, shouldn't this die() be happening
there?
