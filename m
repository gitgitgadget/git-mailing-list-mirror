Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D59C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 12:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhLHMeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhLHMeA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 07:34:00 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52449C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 04:30:28 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o20so7779652eds.10
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 04:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=+QxpXpcQZ2qqliuvQQSjpWKnXGzlNe1d1i8tGBFWWSY=;
        b=krZew3Oz34B2sMLhrwFShRdB7+pAUV85r1grFYqjPiL0DQKxOj5t7bx7fHCCA94D8f
         iSWHou7GH6OMOyZR3NEBKkcwy/RhxcQlptM06yzKPj4jE+GfXpvZoOllU5RIKDAGXP+8
         GySo0KbxqFKZL6ImpC7wBg5KWRxmehuHwaEDXR3jqqnvZnicYmrwpuup0JBSneNQkbD6
         OOeahH78lq3iH7XVWxwodLnnZLKoGtHssXx0gHC5NXCrejM0JEQzg5X1+5Te4d3AkAmK
         mWeggjRyn9FBZc0difJKoWFGv8CTquWRWgI7tYgi7nUq56/XVpA1xKeKfUHX5JEq0mRa
         ZUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=+QxpXpcQZ2qqliuvQQSjpWKnXGzlNe1d1i8tGBFWWSY=;
        b=zouK2ax04uFBr299EIRZA4XwgS9q5nE92nQGZOrzf6ACOd6FRDwBkYlNCVCLQjaFM4
         PJFmTJKwVhU0OpSgk/vZAZJ3wpNcbOyH0xUt21Ifu8y9gqZYt08IpQGs1uXuH1UB0ieD
         wz78cdCXTfb/aLh8W9JcVtjZUpG2qVgpocStuK3BITpy868NvYFskawlqiIphwzNdUyX
         PnRsIMIG0D0S6/Lu5TT8ttYCpKa8F8fsNwsLiLmuU9DnW8ZEYlSdFEhqkvtQ/OG69XeG
         rO7OQs6pDiucHICYSPFAHiYHFhJIMJZ8qPbVRyK0H9B3N+X+rGJZtaYl//NUTjEr8f1f
         2AbA==
X-Gm-Message-State: AOAM533mrn9UH1TmUQSbGuTsRyd0pQe59Xt9cXEpFgYhvdnSLp3mVwhV
        rc5Ze0JFNzWTRWL7JOVIkOo=
X-Google-Smtp-Source: ABdhPJxZ6y9PZ/eLnR2ArjQsy2QKd0dTcCsx/sAtwV7y+gFpii4+LF9cPyb+JSG1goL81wcGpdpFZw==
X-Received: by 2002:aa7:d052:: with SMTP id n18mr19315094edo.104.1638966626852;
        Wed, 08 Dec 2021 04:30:26 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sh33sm1578953ejc.56.2021.12.08.04.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 04:30:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muw5Z-001PkZ-VF;
        Wed, 08 Dec 2021 13:30:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Removing -Wdeclaration-after-statement (was: [PATCH] revision: use
 C99 declaration of variable in for() loop)
Date:   Wed, 08 Dec 2021 13:17:16 +0100
References: <20211113122833.174330-1-gotlouemail@gmail.com>
 <20211113130508.zziheannky6dcilj@gmail.com>
 <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com>
 <xmqq7ddbme7q.fsf@gitster.g> <211114.868rxqu7hr.gmgdl@evledraar.gmail.com>
 <xmqqilwulims.fsf@gitster.g> <xmqqpmr2j5lq.fsf_-_@gitster.g>
 <61518213-9ce8-00d2-efd9-7f2091c574c4@gmail.com>
 <xmqq1r3eym7f.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqq1r3eym7f.fsf@gitster.g>
Message-ID: <211208.86wnkfl1ni.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 17 2021, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> I like the idea of using a specific test balloon for the features that
>> we want to use but wont this one break the build for anyone doing
>> 'make DEVELOPER=1' because -Wdeclaration-after-statement will error
>> out.
>
> I think you are missing '?' at the end of the sentence, but the
> answer is "no, at least not for me".
>
>     # pardon my "make" wrapper; it is to pass DEVELOPER=1 etc. to
>     # the underlying "make" command.
>     $ Meta/Make V=1 revision.o
>     cc -o revision.o -c -MF ./.depend/revision.o.d -MQ revision.o -MMD -MP  -Werror -Wall -pedantic -Wpedantic -Wdeclaration-after-statement -Wformat-security -Wold-style-definition -Woverflow -Wpointer-arith -Wstrict-prototypes -Wunused -Wvla -fno-common -Wextra -Wmissing-prototypes -Wno-empty-body -Wno-missing-field-initializers -Wno-sign-compare -Wno-unused-parameter  -g -O2 -Wall -I. -DHAVE_SYSINFO -DGIT_HOST_CPU="\"x86_64\"" -DUSE_LIBPCRE2 -DHAVE_ALLOCA_H  -DUSE_CURL_FOR_IMAP_SEND -DSUPPORTS_SIMPLE_IPC -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\"" -DSHA256_BLK  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_SYNC_FILE_RANGE -DHAVE_GETDELIM '-DPROCFS_EXECUTABLE_PATH="/proc/self/exe"' -DFREAD_READS_DIRECTORIES -DNO_STRLCPY -DSHELL_PATH='"/bin/sh"' -DPAGER_ENV='"LESS=FRX LV=-c"'  revision.c
>     $ cc --version
>     cc (Debian 10.3.0-11) 10.3.0
>     Copyright (C) 2020 Free Software Foundation, Inc.
>     This is free software; see the source for copying conditions.  There is NO
>     warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
>
> It would be quite sad if we had to allow decl-after-stmt, only to
> allow
>
> 	stmt;
> 	for (type var = init; ...; ...) {
> 		...;
> 	}
>
> because it should merely be a short-hand for
>
> 	stmt;
> 	{
> 	    type var;
> 	    for (var = init; ...; ...) {
> 		...;
> 	    }
> 	}
>
> that does not need to allow decl-after-stmt.

Why would that be sad? The intent of -Wdeclaration-after-statement is to
catch C90 compatibility issues. Maybe we don't want to enable everything
C99-related in this area at once, but why shouldn't we be removing
-Wdeclaration-after-statement once we have a hard C99 dependency?

I usually prefer declaring variables up-front just as a metter of style,
and it usually encourages you to split up functions that are
unnecessarily long.

But I think being able to do it in some situations also helps
readability. E.g. I'm re-rolling my cat-file usage topic now and spotted
this nice candidate (which we'd error on now with CC=gcc and
DEVELOPER=1):
	
	diff --git a/builtin/cat-file.c b/builtin/cat-file.c
	index f5437c2d045..a43df23a7cd 100644
	--- a/builtin/cat-file.c
	+++ b/builtin/cat-file.c
	@@ -644,8 +644,6 @@ static int batch_option_callback(const struct option *opt,
	 int cmd_cat_file(int argc, const char **argv, const char *prefix)
	 {
	 	int opt = 0;
	-	int opt_cw = 0;
	-	int opt_epts = 0;
	 	const char *exp_type = NULL, *obj_name = NULL;
	 	struct batch_options batch = {0};
	 	int unknown_type = 0;
	@@ -708,8 +706,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
	 	batch.buffer_output = -1;
	 
	 	argc = parse_options(argc, argv, prefix, options, usage, 0);
	-	opt_cw = (opt == 'c' || opt == 'w');
	-	opt_epts = (opt == 'e' || opt == 'p' || opt == 't' || opt == 's');
	+	const int opt_cw = (opt == 'c' || opt == 'w');
	+	const opt_epts = (opt == 'e' || opt == 'p' || opt == 't' || opt == 's');
	 
	 	/* --batch-all-objects? */
	 	if (opt == 'b')

I.e. in this case I'm declaring a variable merely as a short-hand for
accessing "opt", and due to the need for parse_options() we can't really
declare it in a way that's resonable before any statement in the
function.

By having -Wdeclaration-after-statement we're forced to make it
non-const, and having it "const" helps readability, you know as soon as
you see it that it won't be modified.

That particular example is certainly open to bikeshedding, but I think
the general point that it's not categorically bad holds, and therefore
if we don't need it for compiler compatibility it's probably a good idea
to allow it.
