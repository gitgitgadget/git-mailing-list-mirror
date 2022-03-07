Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7144C43217
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241916AbiCGMXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242070AbiCGMWz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:22:55 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9F080216
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:22:01 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id d10so31470840eje.10
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xRa3CoZ8OgLjGTuj8ePYx9ZpuPFTgQf54LLHAuPY5m4=;
        b=Blqhl0eClwZ+YXt2GXkwO/qXsP678D7+MqkCmGLMFc2zOhHS0zbi/xKV8oLzMIVfuY
         zWlVjMBVVk7XbRzCNbfzirxhFQ4vV16H/I1N9sdUv8Cv26f5VRiTDOTWh+aVc1ovElLy
         nYIyQCi09sb+VlMCmwUzgmAKtS2eZt0C5aG1R9jwN7+KYRgg0yxFtbXtokY2zEWWc76g
         mbN9/yGXYE92I4+y8QcBC1RjX4zegiamm+p3DTuFbcn6gwy+wES4tlWaYYe2J7hUfaSD
         zpGOUpq2SIYCqSyyyUY4iy4t3rSD2OYWB+8rXcW49cEZdPTs43A9zePIcRNkMnkjsE87
         l1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xRa3CoZ8OgLjGTuj8ePYx9ZpuPFTgQf54LLHAuPY5m4=;
        b=bTfGtIiq6bDk75vS7qT4LI4q6Ki3tItTWfEZbX8U1HIuy9o1gONAL6XOV/HiHoRYlR
         ZI7S+lqIxWPV1eVuuEb6wBA3bnm22iBnc9MRT9OLDxKZ+j4XhpM6Grf4sn329BOblJfo
         xN02txt+DUIpKkuDR0gxaTiNTAGV3mbyQFk3qQvM7YNbOIAhmSkerHiGZK9+mi3jNVqy
         rId2SBzVHznyd48H5GJmlCLlJH0FnT00e4EXd3bM8rBFj+cyORAPo7w7WAwxY/IRSb63
         4Ld93/KYPoaVIY907AHW5g6J3c9oWAhQuXpMV59EI69NSSW5B1BHjGoTF8QLzkMm3GLf
         1Ipw==
X-Gm-Message-State: AOAM532ChFUhTikAgjtvrmmWpM081AEken3NxI/ISHjzdRkMsy1krmAs
        5ZWXgo2PHo3R54txdL8iGHUvMEO7HXot6Q==
X-Google-Smtp-Source: ABdhPJzWcOgyyVqxyWj1tlBxAUSWb/taVA7UqjLnngXf/hg2m/Kan60Yhpft8xpak2nJslnl6tvu7w==
X-Received: by 2002:a17:906:c18c:b0:6d5:8518:e567 with SMTP id g12-20020a170906c18c00b006d58518e567mr8464484ejz.37.1646655719474;
        Mon, 07 Mar 2022 04:21:59 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m24-20020a170906161800b006d420027b63sm4714545ejd.18.2022.03.07.04.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:21:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRCNB-001Tsf-SP;
        Mon, 07 Mar 2022 13:21:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] cat-file: skip expanding default format
Date:   Mon, 07 Mar 2022 13:15:48 +0100
References: <pull.1221.git.git.1646429845306.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1221.git.git.1646429845306.gitgitgadget@gmail.com>
Message-ID: <220307.865yoq0x7e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 04 2022, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
>
> When format is passed into --batch, --batch-check, --batch-command,
> the format gets expanded. When nothing is passed in, the default format
> is set and the expand_format() gets called.
>
> We can save on these cycles by hardcoding how to print the
> information when nothing is passed as the format, or when the default
> format is passed. There is no need for the fully expanded format with
> the default. Since batch_object_write() happens on every object provided
> in batch mode, we get a nice performance improvement.
>
> git rev-list --all > /tmp/all-obj.txt
>
> git cat-file --batch-check </tmp/all-obj.txt
>
> with HEAD^:
>
> Time (mean =C2=B1 =CF=83): 57.6 ms =C2=B1 1.7 ms [User: 51.5 ms, System: =
6.2 ms]
> Range (min =E2=80=A6 max): 54.6 ms =E2=80=A6 64.7 ms 50 runs
>
> with HEAD:
>
> Time (mean =C2=B1 =CF=83): 49.8 ms =C2=B1 1.7 ms [User: 42.6 ms, System: =
7.3 ms]
> Range (min =E2=80=A6 max): 46.9 ms =E2=80=A6 55.9 ms 56 runs
>
> If nothing is provided as a format argument, or if the default format is
> passed, skip expanding of the format and print the object info with a
> default format.
>
> Based-on-patch-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>

Nit: I think it's probably better to just add a Signed-off-by here for
me instead to indicate that it's originally based on my crappy WIP code
(but most of what you've got here is thoroughly yours & better).

> Signed-off-by: John Cai <johncai86@gmail.com>
> [...]
> +static void print_default_format(char *buf, int len, struct expand_data =
*data)
> +{
> +	snprintf(buf, len, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oid),
> +		 data->info.type_name->buf,
> +		 (uintmax_t)*data->info.sizep);
> +
> +}
> +
>  /*
>   * If "pack" is non-NULL, then "offset" is the byte offset within the pa=
ck from
>   * which the object may be accessed (though note that we may also rely on
> @@ -363,6 +372,12 @@ static void batch_object_write(const char *obj_name,
>  			       struct packed_git *pack,
>  			       off_t offset)
>  {
> +	const char *fmt;
> +
> +	struct strbuf type_name =3D STRBUF_INIT;
> +	if (!opt->format)
> +		data->info.type_name =3D &type_name;
> +
>  	if (!data->skip_object_info) {
>  		int ret;
>=20=20
> @@ -377,12 +392,21 @@ static void batch_object_write(const char *obj_name,
>  			printf("%s missing\n",
>  			       obj_name ? obj_name : oid_to_hex(&data->oid));
>  			fflush(stdout);
> -			return;
> +			goto cleanup;
>  		}
>  	}
>=20=20
> +	if (!opt->format && !opt->print_contents) {
> +		char buf[1024];
> +
> +		print_default_format(buf, 1024, data);
> +		batch_write(opt, buf, strlen(buf));

Just a nit (Junio comment on most of the rest), for something that's an
optimization patch we shouldn't ever need to do strlen() here, since we
just called snprintf(), let's just use its return value instead.

I also think that in this case you'll want xsnprintf(), and if not this
code is buggy & needs to check the return value (but let's just use x*()
...).

FWIW snprintf() relly should be in a mostly-banned.h, but we only have
the blanket banned.h, and there's a few legitimate uses of it :)

(And yes, this is all probably commentary on my own bugs in some WIP
code, but at this point I honestly can't remember & didn't look it up)

Thanks for hacking on this & carrying it forward!
