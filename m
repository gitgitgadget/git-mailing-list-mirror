Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8D2C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 10:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BEC9610C8
	for <git@archiver.kernel.org>; Mon, 24 May 2021 10:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhEXKEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 06:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbhEXKEc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 06:04:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8086C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 03:03:03 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g7so19067620edm.4
        for <git@vger.kernel.org>; Mon, 24 May 2021 03:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=oQgFKjWhr3YJrwKv44uXNJ1xvEX2FkqqVrMhjWHBpCQ=;
        b=BhYj49NUlh+GknqkoFz2s5PryPRULjJ4uPlKdNwScZyzk/omRloKq0qVp0qK1yr4G8
         iA+/Px+eCeIKxGquzI0jW8L4SvTB/3ABJgQLgvB2AxlZJUWbsnU0Y9jvWHw5SyzHoKWF
         kZdOFBNkY5rtZc4bqLruACxczeHvdHagIS4VB9FWxFgxSFtqGMFNdASINoylLZRLlznR
         EaS3R3VX3RRTMeZb6tXQa8LXrszyqo6sy3Ltx6cVQk60buZ+vN9ygFov1lqgTPhwn/qL
         JnZNMfpdTIEvXhdKL9RJUM4KiN3zDJf+oWYDrrcuMaxwM0/L6Ju4sPsocSBgYqwFYTcT
         QZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=oQgFKjWhr3YJrwKv44uXNJ1xvEX2FkqqVrMhjWHBpCQ=;
        b=dquxx3r9oyxZpQJpXUxflXfYmryR6gKfWL5QwgpBsU5wiR4xYikwjBUN9lPMCOZHUS
         Z0qqUtTciPHilzpjACuhKBsSHAm/5wDH0hvqoO4Gw33sY8VNbKh2TYOnQtxnaw0Pd10d
         y7hquRTBYD4QaG6C5P2eE/LXxnt8YsqXY+aBdUyOuifomLp70YT42eEz8kOPr2mSj1qo
         Czr/KW+jlfEklc6mqbHVOIABlg5x7N9yCExjs1Haghfr2lcfL71Kcp9bpqfEeWBjcjEW
         JD+pjjhDVOTiZ+yLMPfyhkHCZjovTGnDDqjp0OU6UMgXX3ned4lzYo5V2uxpWKYHn7Zx
         25FA==
X-Gm-Message-State: AOAM530n2MWbRKINUJ0IRYKc7Ign/DZOD4AQtGXK685luz556tRUzgFk
        lsFumD6yRQPW1BZe0lpaqMs=
X-Google-Smtp-Source: ABdhPJzM8IL4Zkey+LSDt90QqO+30DMQLbvxYyaii9wI+WwGrOko8W2AqfkeIqz1xJLaNKQ8cF9V+A==
X-Received: by 2002:a05:6402:5216:: with SMTP id s22mr14011785edd.232.1621850582238;
        Mon, 24 May 2021 03:03:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id k13sm7639609ejr.1.2021.05.24.03.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 03:03:01 -0700 (PDT)
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
Subject: Re: [PATCH v4 4/4] maintenance: add support for systemd timers on
 Linux
Date:   Mon, 24 May 2021 11:55:09 +0200
References: <20210520221359.75615-1-lenaic@lhuard.fr>
 <20210524071538.46862-1-lenaic@lhuard.fr>
 <20210524071538.46862-5-lenaic@lhuard.fr>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210524071538.46862-5-lenaic@lhuard.fr>
Message-ID: <87r1hwo3e3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 24 2021, L=C3=A9na=C3=AFc Huard wrote:

If we're going to use ifdefs then...=20

> +static int is_systemd_timer_available(void)
> +{
> +	const char *cmd =3D "systemctl";
> +	int is_available;
> +	static int cached_result =3D -1;
> +#ifdef __linux__
> +	struct child_process child =3D CHILD_PROCESS_INIT;
> +#endif
> +
> +	if (cached_result !=3D -1)
> +		return cached_result;
> +
> +	if (get_schedule_cmd(&cmd, &is_available))
> +		return is_available;
> +
> +#ifdef __linux__
> +	strvec_split(&child.args, cmd);
> +	strvec_pushl(&child.args, "--user", "list-timers", NULL);
> +	child.no_stdin =3D 1;
> +	child.no_stdout =3D 1;
> +	child.no_stderr =3D 1;
> +	child.silent_exec_failure =3D 1;
> +
> +	if (start_command(&child)) {
> +		cached_result =3D 0;
> +		return cached_result;
> +	}
> +	if (finish_command(&child)) {
> +		cached_result =3D 0;
> +		return cached_result;
> +	}
> +	cached_result =3D 1;
> +	return cached_result;
> +#else
> +	return 0;
> +#endif
> +}

This sort of function would, I think, be clearer if we just had two
different functions in an ifdef/else, e.g. here cached_result" is
checked under !__linux__, but is never set in that case.

But aside from that, why we do we need all this is_available caching,
isn't this all called as a one-off? If it's not, it seems much better to
push that cache one level up the callstack. Have whatevere's keeping
track of the struct cache is_available itself, or cache it in another
(or the same, then tristate) field in the same struct.

> [...]
> +test_expect_success 'start and stop Linux/systemd maintenance' '
> +	write_script print-args <<-\EOF &&
> +	printf "%s\n" "$*" >>args
> +	EOF
> +
> +	XDG_CONFIG_HOME=3D"$PWD" &&
> +	export XDG_CONFIG_HOME &&
> +	rm -f args &&

If you're going to care about cleanup here, and personally I wouldn't,
just call that "args" by the name "expect" instead (as is convention)
and clobber it every time...

Anyway, a better way to do the cleanup is:

    test_when_finished "rm args" &&
    echo this is the first time you write the file >args
    [the rest of the test code]

Then you don't need to re-rm it.
