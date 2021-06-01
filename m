Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2C5C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 16:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 622B360FD8
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 16:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhFAQRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 12:17:36 -0400
Received: from mout.web.de ([212.227.15.4]:55795 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhFAQRg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 12:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1622564141;
        bh=WhmR3MoUm2E7icAXdgWb8itQHwfQNe/eL2jrT7sfA2s=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=h9VP/62mMkD546RhismIBhNeZbGmed1+9213zL/Ku+nsq9XRRNpsq/lGeETbFrDTi
         yPxfUf+liQ2sktOUBFznHU11F5iRL/0gydIvFT5MFoARytv4j7WbNwNV0R07ltSmqX
         HEBv64VO80u2C/iJFwUhsadFzJu6gJFC271bTlh4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MaajJ-1m86mC1Kvp-00K6bL; Tue, 01 Jun 2021 18:15:41 +0200
Subject: Re: [PATCH] t0001: fix broken not-quite getcwd(3) test in bed67874e2
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Coppa <dcoppa@openbsd.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <cde6c1a5-3dfc-9710-bab9-b847a5dd960b@web.de>
 <patch-1.1-c70791bbd3-20210601T003743Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b650bef5-d739-d98d-e9f1-fa292b6ce982@web.de>
Date:   Tue, 1 Jun 2021 18:15:39 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <patch-1.1-c70791bbd3-20210601T003743Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hzf5DGWN8P4zhYNy5O5rS3N+P2WDQhUW48//fDc8FJHR2Ykx+sN
 54dLb3Y5OVKSLwj0SG3PbIm0U1rc2ycdYa8tPMnTgL7U74lIRFYr1o3cVBGLQsRDvmxhTGK
 laBA23CMksyhv0MnvA9R2WYAbeqmpVcBybXlGYqoQ3czU+cIotfkEvGb4wq1XbgRkCwoTZa
 0jgmawrn9enmrsZO0SaOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bny1nZ3INKQ=:tkGRBlehBVB1e6r5MPWJtR
 8yL07Sn1pufvrA5DlEnPRKBeOI2Updyc6fAzbrGZ61SgYQXgp0HlOxl9QICa4dZqmgz5Z4xCc
 s9yW0YBJ8e4GqKompaCuXrfMLJ0lmUXipr8WF2Ytsljdg7ODo4WJ0JCgWAzZ2xhtpFI2VJdd+
 xrWZK+FxYxtbV/iaFG4b1BHVn11dOvKA7vsKVv6VzkWfKMkmhmDPtLPWqodnZ1AC8zbY8srUV
 elLpsGb1iSCWcUZH94xOzIs/OkE3+1nA5UNEft7SXeI/7AwST9UzrT4eQHeHnTRRu5YwVBfum
 HduXcSgr6bTddZ01sz18o4LY4qi4gepxbpNOPaHjJGROrcHjrG1PIO6p7uVykbn9Sa3lr46Q3
 zt7Ago+gQWCDD/a4ULrRTHMckEsqnn5sRoTP+ffO5057GbtSKc4BAEpFGftCXQDWHXbToTcBW
 fommaX0v5nhKbKZ7k6/aTSWpL5m2IWdJxIfzgz8cZ/amWGqX6pOTdJ2C36rpFKmjhCjENnwwU
 sBIRKAI970VMkb00JfjraGVDTasQJ26GqNg79DGFUN+xbpoG7iukK0/xke8YlVmOX78InN7Yq
 gGY5jbq2N9X7MTmzHJPJaq45QQ93jgLJ8EYB6dMQH6pyPSatWRP7bD0K2zs8guDgAdfn7OpMK
 X/jc6VlOA6fdRlC8ThrQolpKRytJmI1TyKHQLWQUl3EfxpXimLyJDnnXMrnotTsF/AQbmLP60
 AkILkTyCjvXX2ollGNKFHvx/8axrN3QCqYP0rMlb6kj+BZ+JkwPXjrX96Huj2uVhqTNnx2lah
 zhi7KsAAX7ERcm552sRxZqkqQ6JQZ19ZaAF3p5DtF+U7hxsWO5aSily8wLKNojvtcM24pEkW4
 I9H8z9lP9S4t77nSyar4oLysTBCVDr5o4EFLx2tW6Janz+7/+Fi6Hvm4ow/js8qlKpzHaEgEZ
 AJ+m1Iq8x3mo9ghRRq6L7fqgjvgFo8FZM28dUOuNic+xb8hCP4V1xgEJ5Y3PVSo26PNIxuZnn
 L7xdUVUi8QgA4oLkfMZ6kZD7tFjjiHA2pxK5mYTQNS0blHwMxMgerREeCvGI3l4giVVP9AAH4
 y7OS1Rtr4imX6taGZVdhmcAAydSNKHifGRH
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.06.21 um 02:38 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> With a54e938e5b (strbuf: support long paths w/o read rights in
> strbuf_getcwd() on FreeBSD, 2017-03-26) we had t0001 break on systems
> like OpenBSD and AIX whose getcwd(3) has standard (but not like glibc
> et al) behavior.
>
> This was partially fixed in bed67874e2 (t0001: skip test with
> restrictive permissions if getpwd(3) respects them, 2017-08-07).
>
> The problem with that fix is that while its analysis of the problem is
> correct, it doesn't actually call getcwd(3), instead it invokes "pwd
> -P". There is no guarantee that "pwd -P" is actually going to call
> getcwd(3), as opposed to e.g. being a shell built-in.
>
> On AIX under both bash and ksh this test breaks because "pwd -P" will
> happily display the current working directory, but getcwd(3) called by
> the "git init" we're testing here will fail to get it.
>
> I checked whether clobbering the $PWD environment variable would
> affect it, and it didn't. Presumably these shells keep track of their
> working directory internally.
>
> Let's change the test to a new "test-tool getcwd".

Makes sense.

If /bin/pwd can figure out the path to the current working directory
without read permissions to parent directories then it might be possible
to teach strbuf_getcwd() the same trick, though.  How does it do it?

Perhaps it falls back to $PWD; POSIX says the behavior of pwd is
unspecified if that variable would be changed, so a compliant
implementation would be allowed to do that.  I think that way is not
interesting for strbuf_getcwd(), though, because if we trust that
variable then we can read it directly instead.  It gets stale if any
parent directory is renamed.  E.g. the following commands would print a
string ending in "stale":

	mkdir stale
	cd stale
	mv ../stale ../fresh
	chmod 111 ../fresh
	/bin/pwd -P

Perhaps it asks the kernel, like getcwd() does on FreeBSD.  It would
be a bit weird to expose this functionality in a command line tool, but
not in the library function, so this is unlikely.  You seem to say that
/bin/pwd is a shell builtin on your system, which is also weird, though.
The commands above would print a string ending in "fresh" with the
syscall method.

An evil way would be to temporarily add read permission to all parent
directories.  It would also print a string ending in "fresh".  You'd
probably see chmod calls when running /bin/pwd using truss in that
case, and it would fail if chmod is not allowed.

That's all I can think of.

If strbuf_getcwd() were to learn any of these tricks, then so would
"test-tool getcwd", via its xgetcwd() call.  At that point we'd better
rename GETCWD_IGNORES_PERMS to XGETCWD_IGNORES_PERMS.

But I guess we need none of that because we never got a request from
an AIX user to support a /home directory without read permissions,
right?

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>
> Not an issue new in v2.32.0, but an easy enough fix, so I thought I'd
> send it now anyway in case we'd like these various AIX fixes in one
> batch...
>
>  Makefile               |  1 +
>  t/helper/test-getcwd.c | 26 ++++++++++++++++++++++++++
>  t/helper/test-tool.c   |  1 +
>  t/helper/test-tool.h   |  1 +
>  t/t0001-init.sh        |  5 ++++-
>  5 files changed, 33 insertions(+), 1 deletion(-)
>  create mode 100644 t/helper/test-getcwd.c
>
> diff --git a/Makefile b/Makefile
> index c3565fc0f8..8c000ba48b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -711,6 +711,7 @@ TEST_BUILTINS_OBJS +=3D test-example-decorate.o
>  TEST_BUILTINS_OBJS +=3D test-fast-rebase.o
>  TEST_BUILTINS_OBJS +=3D test-genrandom.o
>  TEST_BUILTINS_OBJS +=3D test-genzeros.o
> +TEST_BUILTINS_OBJS +=3D test-getcwd.o
>  TEST_BUILTINS_OBJS +=3D test-hash-speed.o
>  TEST_BUILTINS_OBJS +=3D test-hash.o
>  TEST_BUILTINS_OBJS +=3D test-hashmap.o
> diff --git a/t/helper/test-getcwd.c b/t/helper/test-getcwd.c
> new file mode 100644
> index 0000000000..d680038a78
> --- /dev/null
> +++ b/t/helper/test-getcwd.c
> @@ -0,0 +1,26 @@
> +#include "test-tool.h"
> +#include "git-compat-util.h"
> +#include "parse-options.h"
> +
> +static const char *getcwd_usage[] =3D {
> +	"test-tool getcwd",
> +	NULL
> +};
> +
> +int cmd__getcwd(int argc, const char **argv)
> +{
> +	struct option options[] =3D {
> +		OPT_END()
> +	};
> +	char *cwd;
> +
> +	argc =3D parse_options(argc, argv, "test-tools", options, getcwd_usage=
, 0);
> +	if (argc > 0)
> +		usage_with_options(getcwd_usage, options);
> +
> +	cwd =3D xgetcwd();
> +	puts(cwd);
> +	free(cwd);
> +
> +	return 0;
> +}
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index c5bd0c6d4c..3c13cb19b5 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -33,6 +33,7 @@ static struct test_cmd cmds[] =3D {
>  	{ "fast-rebase", cmd__fast_rebase },
>  	{ "genrandom", cmd__genrandom },
>  	{ "genzeros", cmd__genzeros },
> +	{ "getcwd", cmd__getcwd },
>  	{ "hashmap", cmd__hashmap },
>  	{ "hash-speed", cmd__hash_speed },
>  	{ "index-version", cmd__index_version },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index e8069a3b22..e691a4d9e9 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -23,6 +23,7 @@ int cmd__example_decorate(int argc, const char **argv)=
;
>  int cmd__fast_rebase(int argc, const char **argv);
>  int cmd__genrandom(int argc, const char **argv);
>  int cmd__genzeros(int argc, const char **argv);
> +int cmd__getcwd(int argc, const char **argv);
>  int cmd__hashmap(int argc, const char **argv);
>  int cmd__hash_speed(int argc, const char **argv);
>  int cmd__index_version(int argc, const char **argv);
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index acd662e403..df544bb321 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -356,7 +356,10 @@ test_lazy_prereq GETCWD_IGNORES_PERMS '
>  	chmod 100 $base ||
>  	BUG "cannot prepare $base"
>
> -	(cd $base/dir && /bin/pwd -P)
> +	(
> +		cd $base/dir &&
> +		test-tool getcwd
> +	)
>  	status=3D$?
>
>  	chmod 700 $base &&
>
