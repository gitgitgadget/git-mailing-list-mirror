Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287CCC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbhLGSNW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240438AbhLGSNS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:13:18 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99AAC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 10:09:47 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id t5so60371088edd.0
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 10:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gyRN22ykeUZ/z/cPA9un82ciqVc8HTCWsKNJQKQYsDs=;
        b=dWO3vZLU3UgkmX+y3jgF4ZyngHERe9cwGg31iGZbkB8PsGT8+iLuXJNuGwZPFfmnOj
         MqDbDMyAPKXBWst4oKjVjQxHjVuWdocoX8nkyA5wwio+yNlH3OrdphqGavZf5eIki9hu
         6bZgmW898zH2XvHZZUEd2mMlLKsfQIs17GkORdT1wzcGsj0tWd4hZKdGj0vNDJN522lW
         xmcnV2SqX0cWFBU2KujeejckH5eSEYumO7NJ9ZudCKRsDJGbnVFrI/IarGy0k4Jxfg82
         CO9SB91FaHi76I6XePeTM90ouN541V9blIfEEivjcZbuFu2UQQKpQSq1zx2NmHb58ptz
         4BiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gyRN22ykeUZ/z/cPA9un82ciqVc8HTCWsKNJQKQYsDs=;
        b=rjFcN6leGENmhXeFrPxqJIPgUXcL9vC0Ey4IHvphh6BkYnkRe3jl4nJwAM8NMo7RAz
         7EORxodoZ0ouXlG++EuIvqJEub9GTha9Wlj0Vc5gOTD2sHhm/qZulo+KP3lpgzTs100W
         Vqc9sTWh0y0Ze4yXXcqC9IH3Apvj8fRbSosWwW8C3++WyjqmyVR8hE51zi1+3RxR1YBn
         GKgzNtFUIm1bmyDYZjJST80tSN+qI4e6bE6A0ncyhcEm0nRThWdOS2qToF4MP4TkIysR
         ju7t+RiZECwH3fPausM7D2yDIzWJgR6L/vMyiEMg0FC91TnPxs37gcJTVBOQ96Cwh2LC
         UCvQ==
X-Gm-Message-State: AOAM533Vzlzhg1YwRdGTpGGMhZVO+hX6YFuvynWTnzBQtoQ7AZSZ4/05
        /cG/PUYcj6XwZQkWt59Of0M=
X-Google-Smtp-Source: ABdhPJzjEVjk38Ay6haK0/qYUK08MTL204FBzFrj/FCjPsIW1oP2pPJmKfib0baPxYdyg3Lk9nYVDA==
X-Received: by 2002:a05:6402:4413:: with SMTP id y19mr11549643eda.26.1638900586230;
        Tue, 07 Dec 2021 10:09:46 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id jg32sm201179ejc.43.2021.12.07.10.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:09:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mueuP-001F8Z-B0;
        Tue, 07 Dec 2021 19:09:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH 04/10] i18n: standardize "cannot open" and "cannot read"
Date:   Tue, 07 Dec 2021 19:09:11 +0100
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
 <d408cecc85fad1177676c1cb404c0dd0b0a8fbb6.1638514910.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <d408cecc85fad1177676c1cb404c0dd0b0a8fbb6.1638514910.git.gitgitgadget@gmail.com>
Message-ID: <211207.867dcgnv6e.gmgdl@evledraar.gmail.com>
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
>  archive.c       | 4 ++--
>  builtin/fetch.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/archive.c b/archive.c
> index 10376be7161..f1208beacff 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -185,7 +185,7 @@ static int write_archive_entry(const struct object_id=
 *oid, const char *base,
>=20=20
>  	buffer =3D object_file_to_archive(args, path.buf, oid, mode, &type, &si=
ze);
>  	if (!buffer)
> -		return error(_("cannot read %s"), oid_to_hex(oid));
> +		return error(_("cannot read '%s'"), oid_to_hex(oid));

Re my just-sent comment, i.e. quote things like that, but between this
and the first patch there's a bunch that don't use quotes that could use
them...
