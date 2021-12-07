Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82826C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhLGSMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240438AbhLGSMM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:12:12 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF4EC061748
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 10:08:41 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id g14so59700739edb.8
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 10:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=lAPjIunw7YfH5bemZw7KLdnPdcT8URfAF/xUksRKV6k=;
        b=dGnXnB4bS6UDimlNkKwabPeOWUFSyOZZzV6J9oKUYWATU4175/u5s2lB1aJrJIWid8
         WriMuSNJBYGVmUQhfK5SVn73gU3fqbaAF1dh/6l7ePVAwKSDzieR+Pm6p+ghvkSvGV8b
         O4ZC9U0YF2KecmO+VyEhuL/Z5V9n2Ymug0TrLv5x4YAuxvz5iZGvqyZ8V6/VTqKn/m9V
         /aD3a1RY8uY9vKlGIE+hDp/Lj8qhLPGPEJLSLaNzOnIkzHPAwJs2xeNa9F6h7G73JuHk
         FRyNjUVFUTzOdRQzYLPzGaQctfp0Zzra0fJ2NiTiEtJ8yvb+z/EDGoSwQ7ay9F0aHqoR
         leZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=lAPjIunw7YfH5bemZw7KLdnPdcT8URfAF/xUksRKV6k=;
        b=YzPAyGe2GEFoacSuZ1cdmRrZo7+rC1BQ8ZqXW61waFWv6sma2FnIpXqxtriIsGZDiJ
         zzcxiUNWBV4/pELbGExcrcJ3gxfTpbzvc089GBYDx4jv5p80LgWenab1lHYrrBlkrG5m
         BwGfB/1kWSZdopAUa2IYqN97/Mq8tYks+VDpo05HoqJYryrl0HUrl4c0VMBZ/MJ/i7hs
         cwRh5KrN9a+AVHOf1BqRclwmCCJ34P8AKez8RSZnZEFfRtr40qdTsJL7qQkqBZbVPjh5
         U2wHcTGLQgMebihfQud0t+25j/ZxYvcE7jZinhW0us9ZPrMKMuwzvBAyofgtLw0mmnP0
         VDEQ==
X-Gm-Message-State: AOAM530hFUCie/I8mtAZuptNGWL6Hwn7Axr+/zUZIwvBSbm84gbznyHn
        GiQd1bLtwYYnEVk1YdgwtIo9zv8H1Q/8lQ==
X-Google-Smtp-Source: ABdhPJwUDaynoN4hM+8w4CQGOSFTANaPTRE6ffQ3CMCELxKoKQsdgGZjRrrunPIz60UJUCWM/dVGkg==
X-Received: by 2002:a05:6402:148:: with SMTP id s8mr11525580edu.221.1638900518132;
        Tue, 07 Dec 2021 10:08:38 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cs15sm142325ejc.31.2021.12.07.10.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:08:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muetJ-001F6R-8o;
        Tue, 07 Dec 2021 19:08:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH 01/10] i18n: refactor "foo and bar are mutually exclusive"
Date:   Tue, 07 Dec 2021 19:07:41 +0100
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
 <476eb77aff6fbea926eaec55c9b4febb74282ab4.1638514910.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <476eb77aff6fbea926eaec55c9b4febb74282ab4.1638514910.git.gitgitgadget@gmail.com>
Message-ID: <211207.86bl1snv8a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 03 2021, Jean-No=C3=ABl Avila via GitGitGadget wrote:

> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> Use static strings for constant parts of the sentences.
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  builtin/checkout.c          | 2 +-
>  builtin/diff-tree.c         | 2 +-
>  builtin/fetch.c             | 2 +-
>  builtin/init-db.c           | 2 +-
>  builtin/log.c               | 4 ++--
>  builtin/submodule--helper.c | 4 ++--
>  builtin/worktree.c          | 2 +-
>  range-diff.c                | 2 +-
>  8 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index cbf73b8c9f6..4bd8a57f190 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1621,7 +1621,7 @@ static int checkout_main(int argc, const char **arg=
v, const char *prefix,
>  				cb_option, toupper(cb_option));
>=20=20
>  	if (opts->overlay_mode =3D=3D 1 && opts->patch_mode)
> -		die(_("-p and --overlay are mutually exclusive"));
> +		die(_("%s and %s are mutually exclusive"), "-p", "--overlay");

It's good to do all of these, but I think we should really quote the
'%s' while at it. It also helps translators, who without that won't know
(without jumping to the source) if %s and %s are "walking" and "chewing
gum" or something like a CLI option that's quoted :)
