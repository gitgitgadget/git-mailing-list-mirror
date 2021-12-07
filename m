Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7363C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbhLGSQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhLGSQi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:16:38 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5839CC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 10:13:07 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y13so60207155edd.13
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 10:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dmgYaRzsC5FLtHAqKbuB3/pW9TQC41mKSB4UKZM6UoI=;
        b=WKfgxf8XrJFPzHPN+wX3F9LGg+t6KxiosI+ehc5vN2soeT9xOBtMopOiG/N641ywJ/
         Xyht1fH3mSTZg3Jh5dAvc6yCshA1ockurLhtAf1vQunS/GcuCxE4WLImH7cESAZrMpP/
         rhVeJwX3/8SyW2RgN7yDdrAx4XVmLX/pcWUEgvsFVCg/h2aqT0sa0MyKWXB8jAiTG+hZ
         Iid1RHhSugYfqWLtvVqgS2cgKHjTddCouI48UZvvPYtf9kJVmAUieOd02qNcTp078w6D
         ObC597b07hogH/beE/S75eRNutC3AUeJaNfMTXT4b9SfvtsEQNZYtjkOMnTAD2zpuwqM
         s5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dmgYaRzsC5FLtHAqKbuB3/pW9TQC41mKSB4UKZM6UoI=;
        b=5adIVnj6KNH7GoczL8rE7of+VRMTHwqiP4scstGlQCsIy/kja40ZnzlMWXh5vYCjXD
         K9qdN8NCoztM9bHBwHUgamuPFqClkUtoYrog8XDbnFLi1/NfA7h8MGhBwmwWRct9K6EH
         XUf0bJBsKnB0Njx39Xqb/A51vSMcbR7rLuw7yeFu5rJFQa16/ZLJMy2bkLChebTzWolH
         LnMsqtjRfbxR4AjomBLGksbwNVYo55zl4Md8+jbnxL9SkMN7Km6cazAkIl2kOCjOk8eS
         1IJVpahFuE3VMknKdRQIdqc6pL7gwup93LvXktewYGsquY9fqI5ykT9H6s8RgaYqzNWm
         8Mwg==
X-Gm-Message-State: AOAM531ZrdcozHRClAWehoYlh6QrPxKxWJEWZ/GuU4krolVINiOpHlYg
        i/15et2/inJxvAE3wA+0hSmuhSXlCCgGoA==
X-Google-Smtp-Source: ABdhPJzyhuGrYpCzImTeu9uiWuosXDC0PoV/bsofUqjzbHLQcNKIu3fqi0HYX7hRWdBM0Xnjn+Xzog==
X-Received: by 2002:a17:906:c9d2:: with SMTP id hk18mr1052311ejb.523.1638900785850;
        Tue, 07 Dec 2021 10:13:05 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y19sm342347edq.2.2021.12.07.10.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:13:05 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muexc-001FEI-WE;
        Tue, 07 Dec 2021 19:13:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH 05/10] i18n: tag.c factorize i18n strings
Date:   Tue, 07 Dec 2021 19:10:10 +0100
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
 <b67f0e492e0d9a32f0be9ae085ea3d31135567d5.1638514910.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <b67f0e492e0d9a32f0be9ae085ea3d31135567d5.1638514910.git.gitgitgadget@gmail.com>
Message-ID: <211207.8635n4nv0v.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 03 2021, Jean-No=C3=ABl Avila via GitGitGadget wrote:

> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  builtin/tag.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 41941d5129f..6415d6c81a2 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -543,13 +543,13 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
>  		goto cleanup;
>  	}
>  	if (filter.lines !=3D -1)
> -		die(_("-n option is only allowed in list mode"));
> +		die(_("%s option is only allowed in list mode"), "-n");
>  	if (filter.with_commit)
> -		die(_("--contains option is only allowed in list mode"));
> +		die(_("%s option is only allowed in list mode"), "--contains");
>  	if (filter.no_commit)
> -		die(_("--no-contains option is only allowed in list mode"));
> +		die(_("%s option is only allowed in list mode"), "--no-contains");
>  	if (filter.points_at.nr)
> -		die(_("--points-at option is only allowed in list mode"));
> +		die(_("%s option is only allowed in list mode"), "--points-at");
>  	if (filter.reachable_from || filter.unreachable_from)
>  		die(_("--merged and --no-merged options are only allowed in list mode"=
));
>  	if (cmdmode =3D=3D 'd') {

Since for all of these we're asking translators to re-do some work
(albeit with translation memory) this could use a bit of grammar
improvement. E.g.:

    _("the '%s' option is only allowed in list mode'")

I.e. "blah option is only" without a "the" is a bit odd.

But also for this & various other boilerplate in this series, I think it
would be much better as say:

    const char *only_in_list =3D NULL;
    if (...)
        only_in_list =3D "-n";
    else if (...)
        only_in_list =3D "--contains";
    [...]
    if (only_in_list)
        die(__("the '%s' option [...]"), only_in_list);

I.e. we're buying ourselves the chance to easily get a rid of a lot of
this repetition, but aren't using it. I think a series like this should
probably resist some big refactorings, but things like that would be
pretty easy & make the code more readable.
