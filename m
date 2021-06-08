Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A226BC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 10:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810DC61285
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 10:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhFHK7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 06:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhFHK7m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 06:59:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC49C061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 03:57:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k25so26407782eja.9
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 03:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=hBrzaFgUV3HhSnUEpdSFyYjg0nzyz9GJCINFJC0jV34=;
        b=bnc/bUiiHcS4DZ9/bqj60kuPayCqqsdt1HdJytxYxnW1VNGqAhSX41k2cnUCJvTg2I
         efrMZmrqv8E1zF6wtHt3KAzsqCACMdY8eooKNxhQ9hcCFtEW4gdIy/ydivfOx9+PArKP
         8GHjKVrkeewsX/7cehYNbFO/cGYSct+i45SdS0I+usonz/Jf/1PgjCwID1ET+yVFUlwf
         rFj+W8kOPE19mCHECj/Fqkt8bWF9su8DQG4SF1FN6QwfKobZeKMxFUnmDygKd/QjTFA2
         5TzVVKQFkfQnW5IuVKBqNMNUsUYy3f4/QOK7prtqqpGDpmt+JsqhHlBFokWlR0RrlblI
         Ejmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=hBrzaFgUV3HhSnUEpdSFyYjg0nzyz9GJCINFJC0jV34=;
        b=gxbDdfcyCowESs0afuZt20bGJHjccEwKXY1IEQGIQWXLu1eoA3gymfS2RhEtxlEj1s
         wCFCAwXOZavr0qKvkjP2j490AhgpPR1MI4Ehnmtl0GPTrpJrICt+vMMZCxCXEvwmv/Bm
         /J0Nt890WKzlXDJpia9N9pXNlaa54/SazD/YXXBuawzxWsyjWgvpYQjpjAMS0iXth8qk
         5bvcZe56WIZCsqR3vYS458iIWSNa/M4tKgCbOwxBRXno2Qj30ouS2aqrflhe0RoIPM3m
         k47fNyglCf9QZjRS+0E70eNTxqH5nLjo1Icdg068TwypLF1abKzQuine4eBwPyz3Nlut
         WPVQ==
X-Gm-Message-State: AOAM530VFweVvo+hYiqK/niOLo2ytm0569m32frwcizOclVvbVcaHk5E
        +DO28RGUgNeiMrrOlDLdhZ0=
X-Google-Smtp-Source: ABdhPJwTigOfVIyWkFSO6k3+Vv1gktSoyTAvc2gmwGQCf3MqUc5OmMmWlUShXs8c6kbcFaqO7DfDjA==
X-Received: by 2002:a17:907:270c:: with SMTP id w12mr23230262ejk.175.1623149867917;
        Tue, 08 Jun 2021 03:57:47 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x4sm8706051edq.23.2021.06.08.03.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 03:57:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtins + test helpers: use return instead of exit()
 in cmd_*
Date:   Tue, 08 Jun 2021 12:53:52 +0200
References: <patch-1.1-61d7e6e079-20210607T111008Z-avarab@gmail.com>
 <YL8S9jDmrtdKr5N+@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YL8S9jDmrtdKr5N+@coredump.intra.peff.net>
Message-ID: <87zgw039p1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 08 2021, Jeff King wrote:

> On Mon, Jun 07, 2021 at 01:12:48PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Change various cmd_* functions to use "return" instead of exit() to
>> indicate an exit code. On Solaris with SunCC the compiler legitimately
>> complains about these, since we'll e.g. skip the cleanup (e.g. closing
>> fd's, erroring if we can't) in git.c's run_builtin() when we exit()
>> directly like this.
>
> Each of these cases looks like a simple and obvious conversion, and I
> certainly don't mind us doing it.
>
> But I do wonder what SunCC is complaining about exactly. Calling exit()
> means you don't have to worry about cleanup anymore. Does the compiler
> not have any notion of NORETURN or equivalent? If so, I'd expect many
> more complaints in general that we probably _won't_ want to silence,
> because it will be awkward to do so.

It does, but in this case there's no NORETURN and we declared the
command to return int, and it's not the "main" function.

I believe that's what trips it up, as noted in a v2 I just submitted
now:
https://lore.kernel.org/git/patch-1.1-f225b78e01-20210608T104454Z-avarab@gm=
ail.com/

It's not whining about every instance of "exit" in the codebase.

>> diff --git a/builtin/difftool.c b/builtin/difftool.c
>> index 89334b77fb..6a9242a803 100644
>> --- a/builtin/difftool.c
>> +++ b/builtin/difftool.c
>> @@ -675,7 +675,7 @@ static int run_file_diff(int prompt, const char *pre=
fix,
>>  		"GIT_PAGER=3D", "GIT_EXTERNAL_DIFF=3Dgit-difftool--helper", NULL,
>>  		NULL
>>  	};
>> -	int ret =3D 0, i;
>> +	int i;
>>=20=20
>>  	if (prompt > 0)
>>  		env[2] =3D "GIT_DIFFTOOL_PROMPT=3Dtrue";
>> @@ -686,8 +686,7 @@ static int run_file_diff(int prompt, const char *pre=
fix,
>>  	strvec_push(&args, "diff");
>>  	for (i =3D 0; i < argc; i++)
>>  		strvec_push(&args, argv[i]);
>> -	ret =3D run_command_v_opt_cd_env(args.v, RUN_GIT_CMD, prefix, env);
>> -	exit(ret);
>> +	return run_command_v_opt_cd_env(args.v, RUN_GIT_CMD, prefix, env);
>>  }
>
> This one I'm not surprised that a compiler would complain about. The
> function returns an int, but there are no return paths from the
> function (and hence the caller doing "return run_diff_files()" likewise
> could not ever return there. Which is not quite what you said it
> complained about above, hence my curiosity. :)

I sent a few miscellaneous fixes recently for 15-20 SunCC
warnings. Around 1/2 of these are legitimate issues like these, the rest
are bugs in SunCC or flaws in it flow analysis or other known bugs in
the compiler.
