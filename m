Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75090C433E6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 15:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403B064E06
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 15:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBAPFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 10:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhBAPEA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 10:04:00 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668AAC0613D6
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 07:03:58 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id df22so3267365edb.1
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 07:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=K5uLPkJhW+7w/BlYDWYVfaEqboJvRewdwKXIyx9lnc4=;
        b=h8O2/RfL8vZDKzJLnT8DatgpCeGDzcduKnwyeaKyw1Icf/By4USbbmpx/cHsTg0UV5
         Fmi7VS6TkITT2tYZxP9vh/ofjyK2je68cfNIbn1HAR3vRaS6kNDUhHFEyUxvNZuVrhnb
         ugzRDGLswDuJTcIgYApHNwCrGCH2cU8K8nI9MB1vvcyLmXRezXwe6pqIszKuzkai16MG
         DDqeTfbLOUOyQjLeOjA3LHm4naSMWsO1x9wPAgu2rg8nWnh1+kinIqK2+NnAlrbquQJr
         Rv4wBUoX52P3jbUqyVMAyAX/v52e+4hagKxGLHOywPhPC8XIY7ss53MaB9XJ6pusy2XC
         VodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=K5uLPkJhW+7w/BlYDWYVfaEqboJvRewdwKXIyx9lnc4=;
        b=Y4Zdh13TRwuSg/Tcpgivb3hF1MaisUQEQO9tMlRqIzolhAF7B44aOe8hWP4/cWGzn4
         5cT6+YwycS0eV25hF9eXLOMB4JKwK1s+DRr/ahe4Y2NmmetgnTwUnS694swdfRh36s2a
         HNOY2crwHuUaZDcLDl9zMJ6EFz0X2TBGOMZT37T9HEit42aWFtgdKxtjObCxGsjAeQYh
         aa2hj6zY9VFRt3wA0UIyu0zWZMnSK6iCB0vnQrVL7Jw1bduGQFNIbXAcmYvTTs4nxM+l
         jubQS1ye/kUEwBWOZh8phLIblJJj2BoYzG2nemQXBfzEUCaQbgyP6djKuPf6nz/c/n9g
         cM2w==
X-Gm-Message-State: AOAM531ACzfZQ9QI7jzjNu/v1MPhtUBdoKThvLFlw3vm8359VLIDtmkV
        bxH70BO1US6zKj6+1EnP0EI=
X-Google-Smtp-Source: ABdhPJwlUqwf8Y7oBSre/EcmNxjAXT26mSnWtpgYxYhSS5kfi1AsqnrdfZMo8f3q165OmWUxcCpsnA==
X-Received: by 2002:aa7:c485:: with SMTP id m5mr19118575edq.320.1612191837090;
        Mon, 01 Feb 2021 07:03:57 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id f13sm8105188ejf.42.2021.02.01.07.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 07:03:56 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Vincent Lefevre <vincent@vinc17.net>
Subject: Re: [PATCH] pager: exit without error on SIGPIPE
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <bc88492979fee215d5be06ccbc246ae0171a9ced.1611910122.git.liu.denton@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <bc88492979fee215d5be06ccbc246ae0171a9ced.1611910122.git.liu.denton@gmail.com>
Date:   Mon, 01 Feb 2021 16:03:55 +0100
Message-ID: <87czxjomn8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 30 2021, Denton Liu wrote:

> [...]

The thread at large has enough about whether this approach even makes
sense. I won't repeat that here. Just small notes on the patch itself:

> diff --git a/Makefile b/Makefile
> index 4edfda3e00..38a1a20f31 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -719,6 +719,7 @@ TEST_BUILTINS_OBJS += test-mktemp.o
>  TEST_BUILTINS_OBJS += test-oid-array.o
>  TEST_BUILTINS_OBJS += test-oidmap.o
>  TEST_BUILTINS_OBJS += test-online-cpus.o
> +TEST_BUILTINS_OBJS += test-pager.o
>  TEST_BUILTINS_OBJS += test-parse-options.o
>  TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
>  TEST_BUILTINS_OBJS += test-path-utils.o
> diff --git a/pager.c b/pager.c
> index ee435de675..5922d99dc8 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -34,6 +34,8 @@ static void wait_for_pager_atexit(void)
>  static void wait_for_pager_signal(int signo)
>  {
>  	wait_for_pager(1);
> +	if (signo == SIGPIPE)
> +		exit(0);

As shown in
https://lore.kernel.org/git/20210201144921.8664-1-avarab@gmail.com/ this
leaves us without guard rails where the pager dies/segfaults or
whatever.

That's an existing bug, but by not carrying the SIGPIPE forward it
changes from "most of the time we'd exit with SIGPIPE anyway" to "we'll
never notice".

> [...]
> +test_expect_success TTY 'SIGPIPE from pager returns success' '
> +	test_terminal env PAGER=true test-tool pager
> +'
> +
>  test_done

As noted in
https://lore.kernel.org/git/20210201144921.8664-1-avarab@gmail.com/ I
think this whole "test-tool pager" isn't needed. We can just use git
itself with some trickery.
