Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E94FC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 15:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FEA061159
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 15:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhFGP2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 11:28:09 -0400
Received: from mout.web.de ([212.227.15.3]:45235 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230398AbhFGP2I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 11:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1623079566;
        bh=FAQ0AgqQ0uJ3LYMOslvHXfzj8vZRBvYYE54+UiztglE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Krts+/5qTK3trMr2ilOSVpe1J4UFF+jYRJ772Z7KeNY8LZ1IzFk5W+Dz8W5sWfIPo
         lH4v+cCgQQ6xF9lWX0TK7W1zK2buQ0o1r3qyxy6MlQ5cYd3LiaAWf5AjF0UvYyfdfi
         NK8hh3EDFU0qO1/E6gRUw1G0vaW8LS5SajNDv3Ck=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MfqSa-1m2Qm21WzM-00N6w1; Mon, 07 Jun 2021 17:26:06 +0200
Subject: Re: [PATCH] t0001: fix broken not-quite getcwd(3) test in bed67874e2
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Coppa <dcoppa@openbsd.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <cde6c1a5-3dfc-9710-bab9-b847a5dd960b@web.de>
 <patch-1.1-c70791bbd3-20210601T003743Z-avarab@gmail.com>
 <b650bef5-d739-d98d-e9f1-fa292b6ce982@web.de>
 <871r9d6hhy.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <57c2f4dc-06b9-b330-a01c-d2ae0e86df7c@web.de>
Date:   Mon, 7 Jun 2021 17:26:05 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <871r9d6hhy.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a6L5rcCt/pwHTz8WtxDFx9p1uFQgLgTum1pL5pN0uhivBEllix9
 zNdCMiJumL9CXzzsAwIrpmEsDg10hRI7xoBrxbxpfJHjc7nblBDwYXe24VO+23xxe9d5Oom
 vTFv8CGZlKhH/unZvswdOHpZAOcBPIPvDaHb2GfCZNxqhhTsgkBBUJov9OFuIurjGPgu65+
 zida+MLgO58Q+LUpQss9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IaV2cYAegeQ=:WnNue+ZmS/pS9rs3Sv00Ar
 xYm9OtcZbgr+QHXQXBZob1tglUjhu3IzLOwofqeKx1SExtKwvY7zoID+cBfrQBiiYcXgaSyyt
 VhQvJcQ+GnOYYG4Ax4VU+cQrRVWDDipWNWm7/c+VCpSQy8wbJD6tcHAjsqZbfUfdX8ArT0aH7
 bcDlAeUPrpPxFzu7srsqFBpBDQcN5yiKyxanc5CzE0JhiXPp4FuFGZCi9tTBujVA+Qf3//K/a
 8kBK+7qtSIauAXYXmcL56kbUwahdVrjFbDG+qygZTTCgqzhJA8QQTukPRQIqsScnttvJBXHSo
 oTUup55f46Nd5/vqBL96ySxob7GAJuspK0nc24paiNdp5dEs7tWWMG/LHSVOnEkMBnMFutXnZ
 YIfLD9mTOvLhvOA+p7P5OnMEzyX0Joo/PzfyWzKj5lV8vaZM0t1ZqRshMcUPIVaIIosYHHpAM
 m9O877WAsbyqudmWi7HFy+rK2WiZmy5WcaGxvq5/kKZdkIlYtCNu0GDfk29Ex86kYo6GCkRvR
 7xJGeWBrL+zVPrIuW29bxetGO+8FcNDxB+URTtCxPNB/qBVMKYIvOwYVbFn6gdnhsNzZ6wY0Y
 pRK2CcFlEB0/TRFp4weWd1fpEfsz9x7iJ9jX6Qrowc1CrKl0/Ph0zAeVNlzh+Gw8xu3R0G8wi
 bTmdmEsFV+lJ0Cdzvt33Cu6Mcs7Tfpfq9/SSYUpOMkec3DXpqURCcxqDwATCcYWb9lDD0NjAP
 LLGK05nYMjh24gtyhmuYtgr8AsnqSRwLmjapyS5DbvDmhIvjksOnOveFAw8+5IEiJKwS81BMh
 UBuoDggLz0TD318cIj+uZ/kzRjW/Kwo/Bs1XlIWMx5UYpTmXEilQDf24l18e9D4M95I4yWWQd
 jvJS0oPrBfOWBz/nm0oC5oq756svDKai31M5qK60gpNHU2wYGetkwn2ovYH/4gtzFdXVN9qVX
 /hpM3XvkiQlwVVgwXUxNPjYHrA23mxdsuOqisZLNNJI0hlkDcKAlNvQ4bSQuTIoHeHSLPZA5Z
 1uwEV3i4BcCbtr6WnNqG2dhXLhyWuBKBE8sP5PSB67Cauzq1avExejRXIBZLtsmmDKEh9rsNI
 oX/gmNelQbD3z8g45OBTGUNO7BKL+ND2QPY
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.06.21 um 13:24 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Tue, Jun 01 2021, Ren=C3=A9 Scharfe wrote:
>
>> Am 01.06.21 um 02:38 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>> With a54e938e5b (strbuf: support long paths w/o read rights in
>>> strbuf_getcwd() on FreeBSD, 2017-03-26) we had t0001 break on systems
>>> like OpenBSD and AIX whose getcwd(3) has standard (but not like glibc
>>> et al) behavior.
>>>
>>> This was partially fixed in bed67874e2 (t0001: skip test with
>>> restrictive permissions if getpwd(3) respects them, 2017-08-07).
>>>
>>> The problem with that fix is that while its analysis of the problem is
>>> correct, it doesn't actually call getcwd(3), instead it invokes "pwd
>>> -P". There is no guarantee that "pwd -P" is actually going to call
>>> getcwd(3), as opposed to e.g. being a shell built-in.
>>>
>>> On AIX under both bash and ksh this test breaks because "pwd -P" will
>>> happily display the current working directory, but getcwd(3) called by
>>> the "git init" we're testing here will fail to get it.
>>>
>>> I checked whether clobbering the $PWD environment variable would
>>> affect it, and it didn't. Presumably these shells keep track of their
>>> working directory internally.
>>>
>>> Let's change the test to a new "test-tool getcwd".
>>
>> Makes sense.
>>
>> If /bin/pwd can figure out the path to the current working directory
>> without read permissions to parent directories then it might be possibl=
e
>> to teach strbuf_getcwd() the same trick, though.  How does it do it?
>>
>> Perhaps it falls back to $PWD; POSIX says the behavior of pwd is
>> unspecified if that variable would be changed, so a compliant
>> implementation would be allowed to do that.  I think that way is not
>> interesting for strbuf_getcwd(), though, because if we trust that
>> variable then we can read it directly instead.  It gets stale if any
>> parent directory is renamed.  E.g. the following commands would print a
>> string ending in "stale":
>>
>> 	mkdir stale
>> 	cd stale
>> 	mv ../stale ../fresh
>> 	chmod 111 ../fresh
>> 	/bin/pwd -P
>
> Yes, AIX prints "stale" here, but e.g. my Linux box prints "fresh".

OK, thanks for checking.  I find it weird: Why would they add a command
that basically prints $PWD when callers can easily access this variable
directly?  Anyway, it is what it is.

>> Perhaps it asks the kernel, like getcwd() does on FreeBSD.  It would
>> be a bit weird to expose this functionality in a command line tool, but
>> not in the library function, so this is unlikely.  You seem to say that
>> /bin/pwd is a shell builtin on your system, which is also weird, though=
.
>> The commands above would print a string ending in "fresh" with the
>> syscall method.
>>
>> An evil way would be to temporarily add read permission to all parent
>> directories.  It would also print a string ending in "fresh".  You'd
>> probably see chmod calls when running /bin/pwd using truss in that
>> case, and it would fail if chmod is not allowed.
>>
>> That's all I can think of.
>>
>> If strbuf_getcwd() were to learn any of these tricks, then so would
>> "test-tool getcwd", via its xgetcwd() call.  At that point we'd better
>> rename GETCWD_IGNORES_PERMS to XGETCWD_IGNORES_PERMS.
>>
>> But I guess we need none of that because we never got a request from
>> an AIX user to support a /home directory without read permissions,
>> right?
>
> I don't really see the point of trying that hard. Yes, we could make
> some forward progress if we bent over backwards and got the current
> working directory, but what would we be left with? A git repository the
> user can't "ls" inside of.

The reason would be support for execute-only (e.g. 0711) /home, which
some systems have for privacy reasons.

> So any number of other thing after that now-working xgetcwd() call would
> fail, we couldn't list any files in the working tree or .git directory.

Users own their /home/directory in that scenario and have full
permissions in their repositories.  They cannot verify the name of their
/home/directory using readdir(), though.

> Why not just fix the bug in there being disconnect between pwd and
> getcwd() here and move on?

If you mean the false assumption that /bin/pwd uses getcwd(): I still
think that your patch makes sense, as I wrote in my first reply,
implying that I agree it should be applied.

>
>>>
>>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>>> ---
>>>
>>> Not an issue new in v2.32.0, but an easy enough fix, so I thought I'd
>>> send it now anyway in case we'd like these various AIX fixes in one
>>> batch...
>>>
>>>  Makefile               |  1 +
>>>  t/helper/test-getcwd.c | 26 ++++++++++++++++++++++++++
>>>  t/helper/test-tool.c   |  1 +
>>>  t/helper/test-tool.h   |  1 +
>>>  t/t0001-init.sh        |  5 ++++-
>>>  5 files changed, 33 insertions(+), 1 deletion(-)
>>>  create mode 100644 t/helper/test-getcwd.c
>>>
>>> diff --git a/Makefile b/Makefile
>>> index c3565fc0f8..8c000ba48b 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -711,6 +711,7 @@ TEST_BUILTINS_OBJS +=3D test-example-decorate.o
>>>  TEST_BUILTINS_OBJS +=3D test-fast-rebase.o
>>>  TEST_BUILTINS_OBJS +=3D test-genrandom.o
>>>  TEST_BUILTINS_OBJS +=3D test-genzeros.o
>>> +TEST_BUILTINS_OBJS +=3D test-getcwd.o
>>>  TEST_BUILTINS_OBJS +=3D test-hash-speed.o
>>>  TEST_BUILTINS_OBJS +=3D test-hash.o
>>>  TEST_BUILTINS_OBJS +=3D test-hashmap.o
>>> diff --git a/t/helper/test-getcwd.c b/t/helper/test-getcwd.c
>>> new file mode 100644
>>> index 0000000000..d680038a78
>>> --- /dev/null
>>> +++ b/t/helper/test-getcwd.c
>>> @@ -0,0 +1,26 @@
>>> +#include "test-tool.h"
>>> +#include "git-compat-util.h"
>>> +#include "parse-options.h"
>>> +
>>> +static const char *getcwd_usage[] =3D {
>>> +	"test-tool getcwd",
>>> +	NULL
>>> +};
>>> +
>>> +int cmd__getcwd(int argc, const char **argv)
>>> +{
>>> +	struct option options[] =3D {
>>> +		OPT_END()
>>> +	};
>>> +	char *cwd;
>>> +
>>> +	argc =3D parse_options(argc, argv, "test-tools", options, getcwd_usa=
ge, 0);
>>> +	if (argc > 0)
>>> +		usage_with_options(getcwd_usage, options);
>>> +
>>> +	cwd =3D xgetcwd();
>>> +	puts(cwd);
>>> +	free(cwd);
>>> +
>>> +	return 0;
>>> +}
>>> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
>>> index c5bd0c6d4c..3c13cb19b5 100644
>>> --- a/t/helper/test-tool.c
>>> +++ b/t/helper/test-tool.c
>>> @@ -33,6 +33,7 @@ static struct test_cmd cmds[] =3D {
>>>  	{ "fast-rebase", cmd__fast_rebase },
>>>  	{ "genrandom", cmd__genrandom },
>>>  	{ "genzeros", cmd__genzeros },
>>> +	{ "getcwd", cmd__getcwd },
>>>  	{ "hashmap", cmd__hashmap },
>>>  	{ "hash-speed", cmd__hash_speed },
>>>  	{ "index-version", cmd__index_version },
>>> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
>>> index e8069a3b22..e691a4d9e9 100644
>>> --- a/t/helper/test-tool.h
>>> +++ b/t/helper/test-tool.h
>>> @@ -23,6 +23,7 @@ int cmd__example_decorate(int argc, const char **arg=
v);
>>>  int cmd__fast_rebase(int argc, const char **argv);
>>>  int cmd__genrandom(int argc, const char **argv);
>>>  int cmd__genzeros(int argc, const char **argv);
>>> +int cmd__getcwd(int argc, const char **argv);
>>>  int cmd__hashmap(int argc, const char **argv);
>>>  int cmd__hash_speed(int argc, const char **argv);
>>>  int cmd__index_version(int argc, const char **argv);
>>> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
>>> index acd662e403..df544bb321 100755
>>> --- a/t/t0001-init.sh
>>> +++ b/t/t0001-init.sh
>>> @@ -356,7 +356,10 @@ test_lazy_prereq GETCWD_IGNORES_PERMS '
>>>  	chmod 100 $base ||
>>>  	BUG "cannot prepare $base"
>>>
>>> -	(cd $base/dir && /bin/pwd -P)
>>> +	(
>>> +		cd $base/dir &&
>>> +		test-tool getcwd
>>> +	)
>>>  	status=3D$?
>>>
>>>  	chmod 700 $base &&
>>>
>
