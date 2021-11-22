Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8046EC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 13:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhKVNOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 08:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhKVNOe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 08:14:34 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F94C061714
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 05:11:28 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id l25so60171461eda.11
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 05:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=g2ThIuX8/tk4HEiy2KIH/VqZ6ZA+z4NbeTqoJrGImuc=;
        b=dvcVfp6muhZB85nJSrAYhrnziUOP0LI7gdFjnUpUIkJVYm+A20MTtacEfjnmB8mGXd
         kHk+kHnz54n8jwJY8W41nF5bfsRTPFAMnjPJC/PGJKg3oHKlKgiznl8TY/wlbxQ1v8by
         oGduOWa5TlW4HDzKZhpq66mKz+WsmG7IH2mRTitvPn0sJdyCMeA6UTFURJOrMzHKCIcH
         T9EvjmTQTapQkSbe3sDy4R6ksyeUEguc/hTP2jeSvTmDTYou+ov4T+j3X5pzeCNEUi6i
         PmNR8rnJGh4abg/cfeXflOsjd6s32qvn4oee3XTGDlT8pGb3y/DdndAa2cFaJfCdk/1L
         dMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=g2ThIuX8/tk4HEiy2KIH/VqZ6ZA+z4NbeTqoJrGImuc=;
        b=KOyF46BnJr8qub/oHCiGOuvaS3aSnh1M2y7UccwG43CrPBDEkrh/k8OK98xc8wYDTw
         4uKkip7R+J4HsAPW8cNwsLMOhiLgkYUJpi2HEbwSIxYM6ylpLMWaPa7oaI6nNe21P/mk
         N2HLWFje26URpybkSSbQVusZ7PeKKINza/P03K/vofcIly5lPZv6e5RJ7jyOudX8DZd7
         VfsAUpsagZ92ec6olw5zj4Yqpb7O4hmcOxYZt8O806e6ziHEVq0DFaEIlXWOAFhXIIvm
         bB8zconH9VnEx1uk/poJarYBsmU1PusABWjSsjsUf1j/qDQMAxRLlY5lIDz2SVDHjPLT
         1j+w==
X-Gm-Message-State: AOAM530AYVDFY0BEM8soQ+3UAFptGyw9//48I3kl0eQD23O89yyem2Nd
        D01XIL/HPEAT9j70Hwgq2pA=
X-Google-Smtp-Source: ABdhPJzm5U+wOCx1loi/Q29sfOeSzkVEtbru5CYT4wLnXDQ6L5FUeWawQlnd4p3i9fOF6h92YOv19A==
X-Received: by 2002:a50:d4d1:: with SMTP id e17mr64886575edj.348.1637586686333;
        Mon, 22 Nov 2021 05:11:26 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i5sm3758736ejw.121.2021.11.22.05.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 05:11:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mp96S-0011nL-L3;
        Mon, 22 Nov 2021 14:11:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] git-compat-util: add a test balloon for C99 support
Date:   Mon, 22 Nov 2021 14:05:42 +0100
References: <20211114211622.1465981-1-sandals@crustytoothpaste.net>
 <20211114211622.1465981-2-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2111161129120.21127@tvgsbejvaqbjf.bet>
 <xmqqk0h7423v.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2111221242320.63@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <nycvar.QRO.7.76.6.2111221242320.63@tvgsbejvaqbjf.bet>
Message-ID: <211122.86pmqsz66b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Johannes Schindelin wrote:

> Hi Junio & brian,
>
> On Wed, 17 Nov 2021, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> >> Even MSVC, long a holdout against modern C, now supports both C11 and
>> >> C17 with an appropriate update.  Moreover, even if people are using an
>> >> older version of MSVC on these systems, they will generally need some
>> >> implementation of the standard Unix utilities for the testsuite, and GNU
>> >> coreutils, the most common option, has required C99 since 2009.
>> >> Therefore, we can safely assume that a suitable version of GCC or clang
>> >> is available to users even if their version of MSVC is not sufficiently
>> >> capable.
>> >
>> > I am all in favor of this patch!
>>
>> I like the direction, but ...
>>
>> >> diff --git a/Makefile b/Makefile
>> >> index 12be39ac49..22d9e67542 100644
>> >> --- a/Makefile
>> >> +++ b/Makefile
>> >> @@ -1204,7 +1204,7 @@ endif
>> >>  # Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
>> >>  # tweaked by config.* below as well as the command-line, both of
>> >>  # which'll override these defaults.
>> >> -CFLAGS = -g -O2 -Wall
>> >> +CFLAGS = -g -O2 -Wall -std=gnu99
>>
>> ... as has been already pointed out, this part probably should not
>> be there.  It is not our intention to require gcc/clang, or to
>> constrain newer systems to gnu99.
>
> Another data point in favor of dropping this: our FreeBSD CI build reports
> a compile error with this:
>
> 	[...]
> 	archive.c:337:35: error: '_Generic' is a C11 extension
> 	[-Werror,-Wc11-extensions]
> 			strbuf_addstr(&path_in_archive, basename(path));
> 							^
> 	/usr/include/libgen.h:61:21: note: expanded from macro 'basename'
> 	#define basename(x)     __generic(x, const char *, __old_basename, basename)(x)
> 				^
> 	/usr/include/sys/cdefs.h:329:2: note: expanded from macro '__generic'
> 		_Generic(expr, t: yes, default: no)
> 		^
> 	1 error generated.
>
> I verified in https://github.com/gitgitgadget/git/pull/1082 that this
> patch is indeed the cause of this compile error.

As noted in another reply I don't think this -std=* thing is worth it,
but this isn't so much a case of breakage with this patch in particular,
but revealing an existing issue of us implicitly requiring C11 on
FreeBSD.

Whether that's worth pursuing is another matter, but it's not some
inherent issue in this approach, but just a platform-specific nit we
could fix. Either by saying -std=c11 on that platform, or presumably
defining NO_LIBGEN_H if we wanted to proceed in lockstep with
C99-but-not-C11 everyhere.

