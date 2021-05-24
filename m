Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D2AC04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 09:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C4616120A
	for <git@archiver.kernel.org>; Mon, 24 May 2021 09:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhEXJwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 05:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbhEXJwr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 05:52:47 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78718C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 02:51:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b17so31230222ede.0
        for <git@vger.kernel.org>; Mon, 24 May 2021 02:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ggEmsJUxOYLT8tD7nhqoxl0jEj++FrZZejhkbanuxUM=;
        b=hDchry7pAhhg9p11KIEj35kWhZZsg9lixv4I9smZyU5k9haeuMvcoiqr2Zz4scp3uI
         50myHs1Yy2UTMHsecfdJdtYT2aiQPcVCuAdnSutKVkfouAzesiuaMeQPFC2fK4xmxTkI
         41Fm+cv/8mm+jLLwOEKGPgMzVEOZYjeo2ob/8wcgg1bf8kU2EL+Ercgx5SmkBMqLIQ4p
         qYSb0fphnXrAwsDEph/F/WR/IwVigArJklrZDqGPJtZnKHwCTqMrtKgpQDp3nvzXIJz+
         J3jrJeRvTDFjk0DYuCaArQocM1aBX8SNOEDbrMRojXD7W8RlW2H9uU1vvgdPxyYOSMFR
         8jdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ggEmsJUxOYLT8tD7nhqoxl0jEj++FrZZejhkbanuxUM=;
        b=OjllaBS4odhOkBuSDp688hRI8v7gYwzVOlxCoX4o1GSTwSh/wXEDC1rULX70fql8a8
         Jqdf2jfn3d7gRCtqWV3Loq4/mb3daSRnf1nYPaECm4I9nCvptHqf9U8Z+foB8gqfwjNU
         l9IpW3E6fKJ71ymQV9JiHdckQFxeE6L9bZWo+H+J4DiNZMEEqEMd7cxS5jQz7wqOAIVi
         bti29eVerXkBfFM7pg6LTbZ7A+TEHW7Jew2Nrplz6ZYnoCwB2h7Bquy8Gf5UO7KPRMTY
         nBOBEARPQeozcE03clw+a1ezQUKHVGVbFZSJnOhRgvKbYZr9RgdMyziL8QAeMXT1lEHj
         ZvNw==
X-Gm-Message-State: AOAM533CLURvie29b1EAKQNYH6kwEVIca2Z8kxfDRDrYsyGj14I7Y+PE
        ISTtMEBwkzHfp9UunIuH42w=
X-Google-Smtp-Source: ABdhPJzHl+/HEr+ue2Rv6ir7igxfTrE2BR1YglrajXGGCNUZMD2y6VIZNGI56TGypJKUXkb+d06QZw==
X-Received: by 2002:a05:6402:3548:: with SMTP id f8mr24206913edd.251.1621849877970;
        Mon, 24 May 2021 02:51:17 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id k22sm7577115eja.33.2021.05.24.02.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 02:51:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 2/4] maintenance: introduce ENABLE/DISABLE for code
 clarity
Date:   Mon, 24 May 2021 11:47:16 +0200
References: <20210520221359.75615-1-lenaic@lhuard.fr>
 <20210524071538.46862-1-lenaic@lhuard.fr>
 <20210524071538.46862-3-lenaic@lhuard.fr>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210524071538.46862-3-lenaic@lhuard.fr>
Message-ID: <87tumso3xn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 24 2021, L=C3=A9na=C3=AFc Huard wrote:

> The first parameter of `XXX_update_schedule` and alike functions is a
> boolean specifying if the tasks should be scheduled or unscheduled.
>
> Using an `enum` with `ENABLE` and `DISABLE` values can make the code
> clearer.

I'm a fan of enums in general for N values, but I think for this sort of
boolean case it's stepping into the territory of just making things less
readable. There's nothing unreadable about 0/1 as an on/off.

> -static int launchctl_boot_plist(int enable, const char *filename, const =
char *cmd)
> +enum enable_or_disable {
> +	DISABLE,
> +	ENABLE
> +};

So here we have ENABLE/DISABLE...

> +static int launchctl_boot_plist(enum enable_or_disable enable,
> +				const char *filename, const char *cmd)
>  {
>  	int result;
>  	struct child_process child =3D CHILD_PROCESS_INIT;
>  	char *uid =3D launchctl_get_uid();
>=20=20
>  	strvec_split(&child.args, cmd);
> -	if (enable)
> -		strvec_push(&child.args, "bootstrap");
> -	else
> -		strvec_push(&child.args, "bootout");
> -	strvec_push(&child.args, uid);
> -	strvec_push(&child.args, filename);
> +	strvec_pushl(&child.args, enable =3D=3D ENABLE ? "bootstrap" : "bootout=
",
> +		     uid, filename, NULL);

..And here we just check ENABLE, and assume !ENABLE =3D=3D DISABLE...
[...]

>  {
> -	if (run_maintenance)
> +	switch (run_maintenance) {
> +	case ENABLE:
>  		return launchctl_add_plists(cmd);
> -	else
> +	case DISABLE:
>  		return launchctl_remove_plists(cmd);
> +	default:
> +		BUG("invalid enable_or_disable value");
> +	}
>  }

And here we use a switch, but also a "default". It's actually better if
you're going to use an enum like this to leave out the "default", the
compiler will catch non-enumerated values for us.

>=20=20
>  static char *schtasks_task_name(const char *frequency)
> @@ -1864,18 +1871,24 @@ static int schtasks_schedule_tasks(const char *cm=
d)
>  		schtasks_schedule_task(exec_path, SCHEDULE_WEEKLY, cmd);
>  }
>=20=20
> -static int schtasks_update_schedule(int run_maintenance, int fd, const c=
har *cmd)
> +static int schtasks_update_schedule(enum enable_or_disable run_maintenan=
ce,
> +				    int fd, const char *cmd)
>  {
> -	if (run_maintenance)
> +	switch (run_maintenance) {
> +	case ENABLE:
>  		return schtasks_schedule_tasks(cmd);
> -	else
> +	case DISABLE:
>  		return schtasks_remove_tasks(cmd);
> +	default:
> +		BUG("invalid enable_or_disable value");
> +	}
>  }

As an aside (I haven't read much/all the context) I wonder why we have
these wrapper functions, can't the caller just pass an "enable" flag?

>  #define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
>  #define END_LINE "# END GIT MAINTENANCE SCHEDULE"
>=20=20
> -static int crontab_update_schedule(int run_maintenance, int fd, const ch=
ar *cmd)
> +static int crontab_update_schedule(enum enable_or_disable run_maintenanc=
e,
> +				   int fd, const char *cmd)
>  {
>  	int result =3D 0;
>  	int in_old_region =3D 0;
> @@ -1925,7 +1938,7 @@ static int crontab_update_schedule(int run_maintena=
nce, int fd, const char *cmd)
>  			fprintf(cron_in, "%s\n", line.buf);
>  	}
>=20=20
> -	if (run_maintenance) {
> +	if (run_maintenance =3D=3D ENABLE) {
>  		struct strbuf line_format =3D STRBUF_INIT;
>  		const char *exec_path =3D git_exec_path();

Same !ENABLE =3D=3D DISABLE assumption?

