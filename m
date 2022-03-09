Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2DFC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 20:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbiCIUP4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 15:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237977AbiCIUPy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 15:15:54 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0AD52E31
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 12:14:55 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y22so4353345eds.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 12:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xeOswvUT4KNzk9PlGCSmjk6ieaLTi3tVOf9gyzfapsY=;
        b=hkze9e8NhdNkHJq8YdyCsTm2e1s2hvDQeE7923BGerj8mFTz7wOksht4OTFKYV3J1B
         bZueV3hiLI6207TnYZW/DyVgZcjD8I05OyBkJb+2Kblk9doqNxj7bZ9u6krLJNEwTrS/
         ank/lKTn81I8B2/G8trgbYjyuQVjB9S13xjvaj6vYKVLr2W2lF0kgwHdkq5xU6vYIhUW
         Ne6eDgkIMceqKjYadNMXxHqlDfXWPEceOlcqV07EBvB0u0aSs1hnpzPz3ItMSwfofXPd
         dH4QfFZa0GmEyxqeiAotQ3T0WF1v6znsThRRBTPHrJLtJYgsS6rxgouXuNfH3HoKaTTh
         vOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xeOswvUT4KNzk9PlGCSmjk6ieaLTi3tVOf9gyzfapsY=;
        b=VXfZounSTELgL9rj8ARp+coWnkDOzN8mT08WlcKfRef4iVQ3IuePmkjw+06Hty+nPi
         Nau8USM+ZTpGeMvCrbfeTepvYg39FzZuUUxrhaVs1GMsQaoldrOyt11CgNXkpCrK4+j4
         9YLSjn3ESPD0LvwcHodUq6afRKjaXfEc0UU0Ehg3QOgTQHf1wGnAJrRq5xwSCigrWqky
         qad8scAk+0c8+B2WJpDmLZpwiHGPkf864lyTpW8s7KLlaiSsqXdTZrjF+9Qrs4aYwcTN
         hJAw+Zr0x+WisbytatGcDq24Q7N+JxRech3m920oYrvIh23IBB2rWfRLS4H9fcbmdQTp
         ODGg==
X-Gm-Message-State: AOAM5325I5B6MA2XMG0f9pQx1l9LmwsE12+XG8gfrOqmLazN3ohBQu25
        DoQcUiIRuBB+08iRIMgT5FM=
X-Google-Smtp-Source: ABdhPJzKHw+4sppwT6GunP/QKoKdWJdVneylX+oYat22Z2M2R407GVico7BQHNBrgiTqWUfSVlbskg==
X-Received: by 2002:aa7:cc82:0:b0:410:d2b0:1a07 with SMTP id p2-20020aa7cc82000000b00410d2b01a07mr1141133edt.359.1646856893653;
        Wed, 09 Mar 2022 12:14:53 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gb2-20020a170907960200b006dac65a914esm1090606ejc.125.2022.03.09.12.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 12:14:52 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nS2hw-000F3v-Fx;
        Wed, 09 Mar 2022 21:14:52 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Git List <git@vger.kernel.org>,
        Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] test-lib.sh: use awk instead of expr for a POSIX non
 integer check
Date:   Wed, 09 Mar 2022 21:07:38 +0100
References: <20220304133702.26706-1-gitter.spiros@gmail.com>
 <20220308113305.39395-1-carenas@gmail.com>
 <CAPig+cSNgQ7SEYk9M=L7z0G=hteTdupKS6sHJL8T7zEp=zkLEA@mail.gmail.com>
 <CAPig+cT3TNFBMesYvYoncawfBdLqKL971SoP_J7F9FgnL10Eqw@mail.gmail.com>
 <CAPig+cSUTaPRvALJyJ8AxNB4wMFLyaWBOa8f+_8K6quPbxTT5A@mail.gmail.com>
 <xmqqv8wnm30q.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqv8wnm30q.fsf@gitster.g>
Message-ID: <220309.86pmmulw77.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 09 2022, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Tue, Mar 8, 2022 at 6:58 PM Eric Sunshine <sunshine@sunshineco.com> w=
rote:
>>> On Tue, Mar 8, 2022 at 6:55 PM Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>>> > On Tue, Mar 8, 2022 at 6:44 PM Carlo Marcelo Arenas Bel=C3=B3n
>>> > <carenas@gmail.com> wrote:
>>> > > +               local _GLIBC_VERSION=3D$(getconf GNU_LIBC_VERSION 2=
>/dev/null)
>>> > > +               if echo "$_GLIBC_VERSION" | cut -d. -f1-2 |
>>> > > +                       awk '{ if ($2 - 2.34 < 0) exit 1 }'
>>> >
>>> > No need for `cut` since `awk` can accomplish the same by itself.
>>> >
>>> >     if echo "$_GLIBC_VERSION" | awk '/^glibc / { if ($2 - 2.34 < 0) e=
xit 1 }'
>>> >
>>> > should work, I would think.
>>>
>>> Nevermind, I forgot you want to better support "2.34.9000" matches.
>>> Though, awk should still be able to do so on its own, one would
>>> expect, but not too important.
>>
>> This seems to work, though it's getting a bit verbose:
>>
>>     awk '/^glibc / { split($2,v,"."); if (sprintf("%s.%s", v[1], v[2])
>> - 2.34 < 0) exit 1 }'
>
> If we are losing "cut" (which I think is a good thing to do), we
> probably can lose the pipe, too and refer to $_GLIBC_VERSION as an
> element in ARGV[] and make the command used as "if" condition to a
> single "awk" script?
>
> In general it is a good discipline to question a pipeline that
> preprocesses input fed to a script written in a language with full
> programming power like awk and perl (and to lessor extent, sed) to
> see if we can come up with a simpler solution without pipeline
> helping to solve what these languages are invented to solve, and I
> very much appreciate your exploration ;-)

I agree :) But the first language we've got here is C. Rather than
fiddle around with getconf, awk/sed etc. why not just the rather
trivial:
=09
	diff --git a/Makefile b/Makefile
	index 6f0b4b775fe..f566c9c5df2 100644
	--- a/Makefile
	+++ b/Makefile
	@@ -732,6 +732,7 @@ TEST_BUILTINS_OBJS +=3D test-parse-pathspec-file.o
	 TEST_BUILTINS_OBJS +=3D test-partial-clone.o
	 TEST_BUILTINS_OBJS +=3D test-path-utils.o
	 TEST_BUILTINS_OBJS +=3D test-pcre2-config.o
	+TEST_BUILTINS_OBJS +=3D test-glibc-config.o
	 TEST_BUILTINS_OBJS +=3D test-pkt-line.o
	 TEST_BUILTINS_OBJS +=3D test-prio-queue.o
	 TEST_BUILTINS_OBJS +=3D test-proc-receive.o
	diff --git a/t/helper/test-glibc-config.c b/t/helper/test-glibc-config.c
	new file mode 100644
	index 00000000000..3c3cc2a8ba5
	--- /dev/null
	+++ b/t/helper/test-glibc-config.c
	@@ -0,0 +1,12 @@
	+#include "test-tool.h"
	+#include "cache.h"
	+
	+int cmd__glibc_config(int argc, const char **argv)
	+{
	+#ifdef __GNU_LIBRARY__
	+	printf("%d\n%d\n", __GLIBC__, __GLIBC_MINOR__);
	+	return 0;
	+#else
	+	return 1;
	+#endif
	+}
	diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
	index e6ec69cf326..c01422f5cab 100644
	--- a/t/helper/test-tool.c
	+++ b/t/helper/test-tool.c
	@@ -35,6 +35,7 @@ static struct test_cmd cmds[] =3D {
	 	{ "genrandom", cmd__genrandom },
	 	{ "genzeros", cmd__genzeros },
	 	{ "getcwd", cmd__getcwd },
	+	{ "glibc-config", cmd__glibc_config },
	 	{ "hashmap", cmd__hashmap },
	 	{ "hash-speed", cmd__hash_speed },
	 	{ "index-version", cmd__index_version },
	diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
	index 20756eefdda..dc061bc7833 100644
	--- a/t/helper/test-tool.h
	+++ b/t/helper/test-tool.h
	@@ -26,6 +26,7 @@ int cmd__fast_rebase(int argc, const char **argv);
	 int cmd__genrandom(int argc, const char **argv);
	 int cmd__genzeros(int argc, const char **argv);
	 int cmd__getcwd(int argc, const char **argv);
	+int cmd__glibc_config(int argc, const char **argv);
	 int cmd__hashmap(int argc, const char **argv);
	 int cmd__hash_speed(int argc, const char **argv);
	 int cmd__index_version(int argc, const char **argv);

I mainly copied the pcre2-config template I added in 95ca1f987ed
(grep/pcre2: better support invalid UTF-8 haystacks, 2021-01-24), which
likewise would have been quite a bit more complex to do from non-C.
