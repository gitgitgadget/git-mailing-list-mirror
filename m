Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26055C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 14:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbiG2Oyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 10:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiG2Oyw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 10:54:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EC56D9EE
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 07:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659106488;
        bh=ZdZmyy4RT5gIPzt6wpLCx0Wed8drpZD1gWqKIIa9gs4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YF82kHZ7j9hSFrtWcMIBricQvzNbY6XlU7HX+Rp1dFEfZFektvle6JKnRlTGvnVgy
         11yo8mD1lyCf6rM1jQy+UXgu16FIIwBO3VwLvOb60y8McXSQAhw6+kTa/0cLwrvCII
         qMLNIhqeO/1OTREzx43rckuL1w8974msquOkXrqc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.244.62] ([89.1.214.237]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Msq6C-1nSe7E1IAS-00tEyQ; Fri, 29
 Jul 2022 16:54:48 +0200
Date:   Fri, 29 Jul 2022 16:54:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] tests: replace mingw_test_cmp with a helper in C
In-Reply-To: <pull.1309.git.1659106382128.gitgitgadget@gmail.com>
Message-ID: <06n1s2n7-o827-0244-50s2-rrq50s42oqn5@tzk.qr>
References: <pull.1309.git.1659106382128.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xKXQpwBQM4IRoGGmmlbrlcwCAdaFUMUldyvDwdKWOtIcIrjcA8K
 D5ZR0MF6COqGaC3fgBhHR7+4ZAPpIAHqBazw4fy8/pmicD1LW4UTxPvMAzz1pAPYvc8TsMD
 th4NoIjLuWtIpLGMAZxBp2uX6vLR8K+V2C1umGzh+J5We9BJUG5BRELNTnAMAisOwyaGA97
 oJjhWIaL/nTDTGp4BvhHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5IkRAGNKVOk=:tTLQsG6sapzSadXVWvZhye
 bSNMUi5JcnWjtAxqQj7zCxdYmEE7fQxHMrw8VT+V4DDL8ow7TuVfqfSrBRSeP86uNz7U3FRX8
 vKTUdko7m3ehBK7hI8slvMBwiWsZ4d7G8uIlHgkaxrZX3J5RIN+gKcZdM8QyDcF7NentJH1eh
 1MLYvMd75vAEm3MsgeHi1XWNqyzU0WyUX6/bOTgi/O9BqCdJg0OycMtEPPW4GsW8XoARdVgDK
 t6i6pM1l6IitnXJUZ9P+zirTaDy2n4Q+ow1L9f4t/euVWskoZkKbitvAwKBzt6WV9mBcEYIpB
 6cdWqhJSYBlmrOJMoK/RcQ/mUOTif5vEZkYbcKc8hZZL8nCzlkEJC/G61YrFGvPG2Rs2sbBz/
 92RGnrC1euZFU57xJgh3KphAvVqdSr71sDkoseI3QnpQLLx7U0cPQxT1YIyfHTEqaeeJKElk2
 cRj95lKNQiM04RNqgpXi+Ru93grp65oLZoVefLGC9howQtDPgWuIa9N8SxItWeJY/STS3z5L7
 NuZcctO6IF0xsukdzOlSWABHzInV4wO7Rb1SV53Ufg0ozwXVjPSlmsnEF0IEYUseW66Kwh08U
 3seDZBM3zm77wmavBlwrEMjkSpivDzMFh9vcozYcd6hdvAtUcQPVYt2aSm0tf22TETEAtfXdf
 CFcwofqyclLx94bus+sjcRYtMuY/ZaV2lHaqPQey4fPYc6/BJtzXkN4p2Ks3p8eXJlbU1uucH
 f7vHvF679mjjdwE1/C75IwlmLg6ysSCBE+WoJW6Ie7V46QJicJvlpbtMPLe5L/LP25zE++LCh
 +gnMfKVbBBu3mtbek7D5PiQ6F7BusahRk7XCTq7g4NEfiZqxw0wB+edbEHyERJW5rwEkX4F8b
 R6lWhrDRvaOiv6dIcc7UduM48BIXSIGmm6CH4nabaHorZVISyKkp5WtkdURbEZMPQ5kp0eBzz
 CP3R7ENjLWESIo0KGnK6iU3PwyYAE7tcZo0HurBXTcgri0zIxRl/VJsur5gGr0oPpQg7UBnkd
 9Vtuhz64aJKme9g3fasGhVZDT4OhApuzV3mJWJWLN47NFwRrQrOxnWxp/pCUsQKf++BiX/Jo2
 BJnki6d9+n1x1QM6QAJg+cty/1J+HpttMy3CF8c3hhdtrKmJpYSnUGGUQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 29 Jul 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This helper is more performant than running the `mingw_test_cmp` code
> with with MSYS2's Bash. And a lot more readable.

Ooops... s/with with/with/

Ciao,
Dscho

>
> To accommodate t1050, which wants to compare files weighing in with 3MB
> (falling outside of t1050's malloc limit of 1.5MB), we simply lift the
> allocation limit by setting the environment variable GIT_ALLOC_LIMIT to
> zero when calling the helper.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     tests: replace mingw_test_cmp with a helper in C
>
>     On the heels of sending a patch to fix a performance regression due =
to a
>     mis-use of test_cmp
>     [https://lore.kernel.org/git/b9203ea247776332e4b6f519aa27d541207adc2=
f.1659097724.git.gitgitgadget@gmail.com/],
>     I was curious to see whether Git for Windows had the same issue. And=
 it
>     does not
>     [https://github.com/git-for-windows/git/runs/7556381815?check_suite_=
focus=3Dtrue#step:5:127]:
>     it passes t5351 in 22 seconds, even while using test_cmp to compare =
pack
>     files
>     [https://github.com/git-for-windows/git/blob/3922f62f0d5991e9fe0a081=
7ebf89a91339c7705/t/t5351-unpack-large-objects.sh#L90].
>
>     The answer is of course that a test helper written in C is much fast=
er
>     than writing the same in Bash, especially on Windows. This is especi=
ally
>     sad when said Bash code is only used on Windows. So I pulled out thi=
s
>     helper from the years-long effort to let Git for Windows use BusyBox=
'
>     ash to run the test suite. The result is this patch, which has been =
in
>     Git for Windows since June 2018.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1309%2=
Fdscho%2Fmingw-test-cmp-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1309/dsch=
o/mingw-test-cmp-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1309
>
>  Makefile                |  1 +
>  t/helper/test-cmp.c     | 73 +++++++++++++++++++++++++++++++++++++++++
>  t/helper/test-tool.c    |  1 +
>  t/helper/test-tool.h    |  1 +
>  t/test-lib-functions.sh | 68 +-------------------------------------
>  t/test-lib.sh           |  2 +-
>  6 files changed, 78 insertions(+), 68 deletions(-)
>  create mode 100644 t/helper/test-cmp.c
>
> diff --git a/Makefile b/Makefile
> index 1624471badc..45f108e43a1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -723,6 +723,7 @@ TEST_BUILTINS_OBJS +=3D test-advise.o
>  TEST_BUILTINS_OBJS +=3D test-bitmap.o
>  TEST_BUILTINS_OBJS +=3D test-bloom.o
>  TEST_BUILTINS_OBJS +=3D test-chmtime.o
> +TEST_BUILTINS_OBJS +=3D test-cmp.o
>  TEST_BUILTINS_OBJS +=3D test-config.o
>  TEST_BUILTINS_OBJS +=3D test-crontab.o
>  TEST_BUILTINS_OBJS +=3D test-csprng.o
> diff --git a/t/helper/test-cmp.c b/t/helper/test-cmp.c
> new file mode 100644
> index 00000000000..1c646a54bf6
> --- /dev/null
> +++ b/t/helper/test-cmp.c
> @@ -0,0 +1,73 @@
> +#include "test-tool.h"
> +#include "git-compat-util.h"
> +#include "strbuf.h"
> +#include "gettext.h"
> +#include "parse-options.h"
> +#include "run-command.h"
> +
> +#ifdef WIN32
> +#define NO_SUCH_DIR "\\\\.\\GLOBALROOT\\invalid"
> +#else
> +#define NO_SUCH_DIR "/dev/null"
> +#endif
> +
> +static int run_diff(const char *path1, const char *path2)
> +{
> +	const char *argv[] =3D {
> +		"diff", "--no-index", NULL, NULL, NULL
> +	};
> +	const char *env[] =3D {
> +		"GIT_PAGER=3Dcat",
> +		"GIT_DIR=3D" NO_SUCH_DIR,
> +		"HOME=3D" NO_SUCH_DIR,
> +		NULL
> +	};
> +
> +	argv[2] =3D path1;
> +	argv[3] =3D path2;
> +	return run_command_v_opt_cd_env(argv,
> +					RUN_COMMAND_NO_STDIN | RUN_GIT_CMD,
> +					NULL, env);
> +}
> +
> +int cmd__cmp(int argc, const char **argv)
> +{
> +	FILE *f0, *f1;
> +	struct strbuf b0 =3D STRBUF_INIT, b1 =3D STRBUF_INIT;
> +
> +	if (argc !=3D 3)
> +		die("Require exactly 2 arguments, got %d", argc);
> +
> +	if (!(f0 =3D !strcmp(argv[1], "-") ? stdin : fopen(argv[1], "r")))
> +		return error_errno("could not open '%s'", argv[1]);
> +	if (!(f1 =3D !strcmp(argv[2], "-") ? stdin : fopen(argv[2], "r"))) {
> +		fclose(f0);
> +		return error_errno("could not open '%s'", argv[2]);
> +	}
> +
> +	for (;;) {
> +		int r0 =3D strbuf_getline(&b0, f0);
> +		int r1 =3D strbuf_getline(&b1, f1);
> +
> +		if (r0 =3D=3D EOF) {
> +			fclose(f0);
> +			fclose(f1);
> +			strbuf_release(&b0);
> +			strbuf_release(&b1);
> +			if (r1 =3D=3D EOF)
> +				return 0;
> +cmp_failed:
> +			if (!run_diff(argv[1], argv[2]))
> +				die("Huh? 'diff --no-index %s %s' succeeded",
> +				    argv[1], argv[2]);
> +			return 1;
> +		}
> +		if (r1 =3D=3D EOF || strbuf_cmp(&b0, &b1)) {
> +			fclose(f0);
> +			fclose(f1);
> +			strbuf_release(&b0);
> +			strbuf_release(&b1);
> +			goto cmp_failed;
> +		}
> +	}
> +}
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 318fdbab0c3..3334de248a1 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -18,6 +18,7 @@ static struct test_cmd cmds[] =3D {
>  	{ "bitmap", cmd__bitmap },
>  	{ "bloom", cmd__bloom },
>  	{ "chmtime", cmd__chmtime },
> +	{ "cmp", cmd__cmp },
>  	{ "config", cmd__config },
>  	{ "crontab", cmd__crontab },
>  	{ "csprng", cmd__csprng },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index bb799271631..e1104898cc3 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -8,6 +8,7 @@ int cmd__advise_if_enabled(int argc, const char **argv);
>  int cmd__bitmap(int argc, const char **argv);
>  int cmd__bloom(int argc, const char **argv);
>  int cmd__chmtime(int argc, const char **argv);
> +int cmd__cmp(int argc, const char **argv);
>  int cmd__config(int argc, const char **argv);
>  int cmd__crontab(int argc, const char **argv);
>  int cmd__csprng(int argc, const char **argv);
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 8c44856eaec..28eddbc8e36 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1240,7 +1240,7 @@ test_expect_code () {
>
>  test_cmp () {
>  	test "$#" -ne 2 && BUG "2 param"
> -	eval "$GIT_TEST_CMP" '"$@"'
> +	GIT_ALLOC_LIMIT=3D0 eval "$GIT_TEST_CMP" '"$@"'
>  }
>
>  # Check that the given config key has the expected value.
> @@ -1541,72 +1541,6 @@ test_skip_or_die () {
>  	error "$2"
>  }
>
> -# The following mingw_* functions obey POSIX shell syntax, but are actu=
ally
> -# bash scripts, and are meant to be used only with bash on Windows.
> -
> -# A test_cmp function that treats LF and CRLF equal and avoids to fork
> -# diff when possible.
> -mingw_test_cmp () {
> -	# Read text into shell variables and compare them. If the results
> -	# are different, use regular diff to report the difference.
> -	local test_cmp_a=3D test_cmp_b=3D
> -
> -	# When text came from stdin (one argument is '-') we must feed it
> -	# to diff.
> -	local stdin_for_diff=3D
> -
> -	# Since it is difficult to detect the difference between an
> -	# empty input file and a failure to read the files, we go straight
> -	# to diff if one of the inputs is empty.
> -	if test -s "$1" && test -s "$2"
> -	then
> -		# regular case: both files non-empty
> -		mingw_read_file_strip_cr_ test_cmp_a <"$1"
> -		mingw_read_file_strip_cr_ test_cmp_b <"$2"
> -	elif test -s "$1" && test "$2" =3D -
> -	then
> -		# read 2nd file from stdin
> -		mingw_read_file_strip_cr_ test_cmp_a <"$1"
> -		mingw_read_file_strip_cr_ test_cmp_b
> -		stdin_for_diff=3D'<<<"$test_cmp_b"'
> -	elif test "$1" =3D - && test -s "$2"
> -	then
> -		# read 1st file from stdin
> -		mingw_read_file_strip_cr_ test_cmp_a
> -		mingw_read_file_strip_cr_ test_cmp_b <"$2"
> -		stdin_for_diff=3D'<<<"$test_cmp_a"'
> -	fi
> -	test -n "$test_cmp_a" &&
> -	test -n "$test_cmp_b" &&
> -	test "$test_cmp_a" =3D "$test_cmp_b" ||
> -	eval "diff -u \"\$@\" $stdin_for_diff"
> -}
> -
> -# $1 is the name of the shell variable to fill in
> -mingw_read_file_strip_cr_ () {
> -	# Read line-wise using LF as the line separator
> -	# and use IFS to strip CR.
> -	local line
> -	while :
> -	do
> -		if IFS=3D$'\r' read -r -d $'\n' line
> -		then
> -			# good
> -			line=3D$line$'\n'
> -		else
> -			# we get here at EOF, but also if the last line
> -			# was not terminated by LF; in the latter case,
> -			# some text was read
> -			if test -z "$line"
> -			then
> -				# EOF, really
> -				break
> -			fi
> -		fi
> -		eval "$1=3D\$$1\$line"
> -	done
> -}
> -
>  # Like "env FOO=3DBAR some-program", but run inside a subshell, which m=
eans
>  # it also works for shell functions (though those functions cannot impa=
ct
>  # the environment outside of the test_env invocation).
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 7726d1da88a..220c259e796 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1546,7 +1546,7 @@ case $uname_s in
>  	test_set_prereq SED_STRIPS_CR
>  	test_set_prereq GREP_STRIPS_CR
>  	test_set_prereq WINDOWS
> -	GIT_TEST_CMP=3Dmingw_test_cmp
> +	GIT_TEST_CMP=3D"test-tool cmp"
>  	;;
>  *CYGWIN*)
>  	test_set_prereq POSIXPERM
>
> base-commit: 23b219f8e3f2adfb0441e135f0a880e6124f766c
> --
> gitgitgadget
>
>
