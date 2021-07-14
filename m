Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1B3C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 18:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1895C613C5
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 18:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbhGNSpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 14:45:30 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:63964 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239999AbhGNSpa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 14:45:30 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 1D646F9D;
        Wed, 14 Jul 2021 20:42:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1626288154; x=1628102555; bh=E0KQRJ49Z4ylADNRdo8
        gKk6w3pQqpGDDq+7kVoL6mOc=; b=h5F+lw1t9Xn0iZLZsyEFmeATF5QV20ztFGM
        xi5sT6P2ACFsZK9uXr5zZoJp96HqC4sUEAgi8XtzNuF9qQVeGGB28Ox36wO1NLA0
        kaq25d5iJbRPCmyGaNaY2BbVuGJvlodZNg7qNUl4Yg1EjBs1gpgIiulYeDLwkfl+
        P7nmzlV4VNbYVSby1dNajmXfLHK4vuQV/lo907JOobjOfbTilxi5UvaabDC3mUV2
        LI/pFQdlX6C00/A1aVp7deGgc5SwuIS9ip6u19KSVkf3e4z/MfgPTyYZugK6XSdd
        C/KpIcT8m5Hkb1ugv2XG1bgR4GrkKqpX82uWn78ZAnmIdFSpnsrwIDsfciR0a8rt
        jTupEhka2mIzZR/iyj+nzR8HNEyv6NzThd2WMwbY2GHDUct2azbg2GzUIemBrt1h
        iD9U9K7damWOjZsSL9T8hsIaorVd+qJzy9wnBBOubQcxZS3Gzr01G1YNMWYdeeUN
        DnS9enDJZKQp12grhvNQQEpOpc0aqpNcmorNL5FSnu3j1/PtCW3TOplh/OqY5F2R
        xL0pwzY+ywwnNxL6FBQ+Foou28rBdEBsiPO6JPtldG8SBVnUMEFOFOrzONPXW+yi
        6S/BsTZJzNMhm9IX0CZh26qhDZJH3pZ0k4Y5d/1h3OM9lsA08Y2QUjteRrD1kT5/
        reLviHBg=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VOYK6bYbJzOY; Wed, 14 Jul 2021 20:42:34 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 6BBBAE7F;
        Wed, 14 Jul 2021 20:42:34 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 16F5C3367;
        Wed, 14 Jul 2021 20:42:29 +0200 (CEST)
Subject: Re: [PATCH v2 1/4] tests: add a test mode for SANITIZE=leak, run it
 in CI
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <patch-1.4-0795436a24-20210714T172251Z-avarab@gmail.com>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <eebb4f74-b5e3-6c11-3b84-fcee1b876992@ahunt.org>
Date:   Wed, 14 Jul 2021 20:42:27 +0200
MIME-Version: 1.0
In-Reply-To: <patch-1.4-0795436a24-20210714T172251Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/07/2021 19:23, Ævar Arnfjörð Bjarmason wrote:
> While git can be compiled with SANITIZE=leak there has been no
> corresponding GIT_TEST_* mode for it, i.e. memory leaks have been
> fixed as one-offs without structured regression testing.
> 
> This change add such a mode, we now have new
> linux-{clang,gcc}-sanitize-leak CI targets, these targets run the same
> tests as linux-{clang,gcc}, except that almost all of them are
> skipped.
> 
> There is a whitelist of some tests that are OK in test-lib.sh, and
> individual tests can be opted-in by setting
> GIT_TEST_SANITIZE_LEAK=true before sourcing test-lib.sh. Within those
> individual test can be skipped with the "!SANITIZE_LEAK"
> prerequisite. See the updated t/README for more details.
> 
> I'm using the GIT_TEST_SANITIZE_LEAK=true and !SANITIZE_LEAK pattern
> in a couple of tests whose memory leaks I'll fix in subsequent
> commits.
> 
> I'm not being aggressive about opting in tests, it's not all tests
> that currently pass under SANITIZE=leak, just a small number of
> known-good tests. We can add more later as we fix leaks and grow more
> confident in this test mode.
> 
> See the recent discussion at [1] about the lack of this sort of test
> mode, and 0e5bba53af (add UNLEAK annotation for reducing leak false
> positives, 2017-09-08) for the initial addition of SANITIZE=leak.
> 
> See also 09595ab381 (Merge branch 'jk/leak-checkers', 2017-09-19),
> 7782066f67 (Merge branch 'jk/apache-lsan', 2019-05-19) and the recent
> 936e58851a (Merge branch 'ah/plugleaks', 2021-05-07) for some of the
> past history of "one-off" SANITIZE=leak (and more) fixes.
> 
> When calling maybe_skip_all_sanitize_leak matching against
> "$TEST_NAME" instead of "$this_test" as other "match_pattern_list()"
> users do is intentional. I'd like to match things like "t13*config*"
> in subsequent commits. This part of the API isn't public, so we can
> freely change it in the future.
> 
> 1. https://lore.kernel.org/git/87czsv2idy.fsf@evledraar.gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   .github/workflows/main.yml |  6 ++++
>   Makefile                   |  5 ++++
>   ci/install-dependencies.sh |  4 +--
>   ci/lib.sh                  | 18 ++++++++----
>   ci/run-build-and-tests.sh  |  4 +--
>   t/README                   | 16 ++++++++++
>   t/t5701-git-serve.sh       |  2 +-
>   t/test-lib.sh              | 60 ++++++++++++++++++++++++++++++++++++++
>   8 files changed, 105 insertions(+), 10 deletions(-)
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 73856bafc9..752fe187f9 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -297,6 +297,12 @@ jobs:
>             - jobname: linux-gcc-default
>               cc: gcc
>               pool: ubuntu-latest
> +          - jobname: linux-clang-sanitize-leak
> +            cc: clang
> +            pool: ubuntu-latest
> +          - jobname: linux-gcc-sanitize-leak
> +            cc: gcc
> +            pool: ubuntu-latest

Is there any advantage to running leak checking with both gcc and clang? 
My understanding is that you end up using the same sanitiser 
implementation under the hood - I can't remember if using a different 
compiler actually helps find different leaks though.

My other question is: if we are adding a new job - should it really be 
just a leak checking job? Leak checking is just a subset of ASAN 
(Address Sanitizer). And as discussed at [1] it's possible to run ASAN 
and UBSAN (Undefined Behaviour Sanitizer) in the same build. I feel like 
it's much more useful to first add a combined ASAN+UBSAN job, followed 
by enabling leak-checking as part of ASAN in those jobs for known 
leak-free tests - as opposed to only adding leak checking. We currently 
disable Leak checking for ASAN here [2], but that could be made 
conditional on the test ID (i.e. check an allowlist to enable leak 
checking for some tests)?

I think it's worth focusing on ASAN+UBSAN first because they tend to 
find more impactful issues (e.g. buffer overflows, and other real bugs) 
- whereas leaks... are ugly, but leaks in git don't actually have much 
user impact?

[1] 
https://lore.kernel.org/git/YMI%2Fg1sHxJgb8%2FYD@coredump.intra.peff.net/

[2] https://git.kernel.org/pub/scm/git/git.git/tree/t/test-lib.sh#n44

>       env:
>         CC: ${{matrix.vector.cc}}
>         jobname: ${{matrix.vector.jobname}}
> diff --git a/Makefile b/Makefile
> index 502e0c9a81..d4cad5136f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1216,6 +1216,9 @@ PTHREAD_CFLAGS =
>   SPARSE_FLAGS ?=
>   SP_EXTRA_FLAGS = -Wno-universal-initializer
>   
> +# For informing GIT-BUILD-OPTIONS of the SANITIZE=leak target
> +SANITIZE_LEAK =
> +
>   # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
>   # usually result in less CPU usage at the cost of higher peak memory.
>   # Setting it to 0 will feed all files in a single spatch invocation.
> @@ -1260,6 +1263,7 @@ BASIC_CFLAGS += -DSHA1DC_FORCE_ALIGNED_ACCESS
>   endif
>   ifneq ($(filter leak,$(SANITIZERS)),)
>   BASIC_CFLAGS += -DSUPPRESS_ANNOTATED_LEAKS
> +SANITIZE_LEAK = YesCompiledWithIt >   endif
>   ifneq ($(filter address,$(SANITIZERS)),)
>   NO_REGEX = NeededForASAN
> @@ -2793,6 +2797,7 @@ GIT-BUILD-OPTIONS: FORCE
>   	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
>   	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
>   	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
> +	@echo SANITIZE_LEAK=\''$(subst ','\'',$(subst ','\'',$(SANITIZE_LEAK)))'\' >>$@+
>   	@echo X=\'$(X)\' >>$@+
>   ifdef TEST_OUTPUT_DIRECTORY
>   	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 67852d0d37..8ac72d7246 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -12,13 +12,13 @@ UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
>    libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
>   
>   case "$jobname" in
> -linux-clang|linux-gcc)
> +linux-clang|linux-gcc|linux-clang-sanitize-leak|linux-gcc-sanitize-leak)

How about `linux-clang*|linux-gcc*)` here and below?

>   	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
>   	sudo apt-get -q update
>   	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
>   		$UBUNTU_COMMON_PKGS
>   	case "$jobname" in
> -	linux-gcc)
> +	linux-gcc|linux-gcc-sanitize-leak)
>   		sudo apt-get -q -y install gcc-8
>   		;;
>   	esac
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 476c3f369f..bb02b5abf4 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -183,14 +183,16 @@ export GIT_TEST_CLONE_2GB=true
>   export SKIP_DASHED_BUILT_INS=YesPlease
>   
>   case "$jobname" in
> -linux-clang|linux-gcc)
> -	if [ "$jobname" = linux-gcc ]
> -	then
> +linux-clang|linux-gcc|linux-clang-sanitize-leak|linux-gcc-sanitize-leak)
> +	case "$jobname" in
> +	linux-gcc|linux-gcc-sanitize-leak)
>   		export CC=gcc-8
>   		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
> -	else
> +		;;
> +	*)
>   		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python2"
> -	fi
> +		;;
> +	esac
>   
>   	export GIT_TEST_HTTPD=true
>   
> @@ -233,4 +235,10 @@ linux-musl)
>   	;;
>   esac
>   
> +case "$jobname" in
> +linux-clang-sanitize-leak|linux-gcc-sanitize-leak)
> +	export SANITIZE=leak
> +	;;
> +esac
> +

Have you considered doing this in the yaml job configuration instead? 
It's possible to set env-vars in yaml, although it will require some 
careful tweaking - here's an example where I'm setting different values 
for SANITIZE depending on job (you'd probably just have to set it to 
empty for the non leak-checking jobs):

https://github.com/ahunt/git/blob/master/.github/workflows/ahunt-sync-next2.yml#L51-L69

That does make the yaml more complex, but I think it's worth it to 
reduce the amount of special-casing elsewhere (and is also worth it if 
we ever add other sanitisers)?

>   MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 3ce81ffee9..5fe047b5c6 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -12,7 +12,7 @@ esac
>   
>   make
>   case "$jobname" in
> -linux-gcc)
> +linux-gcc|linux-gcc-sanitize-leak)
>   	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   	make test
>   	export GIT_TEST_SPLIT_INDEX=yes
> @@ -29,7 +29,7 @@ linux-gcc)
>   	export GIT_TEST_CHECKOUT_WORKERS=2
>   	make test
>   	;;
> -linux-clang)
> +linux-clang|linux-clang-sanitize-leak)
>   	export GIT_TEST_DEFAULT_HASH=sha1
>   	make test
>   	export GIT_TEST_DEFAULT_HASH=sha256
> diff --git a/t/README b/t/README
> index 1a2072b2c8..303d0be817 100644
> --- a/t/README
> +++ b/t/README
> @@ -448,6 +448,22 @@ GIT_TEST_CHECKOUT_WORKERS=<n> overrides the 'checkout.workers' setting
>   to <n> and 'checkout.thresholdForParallelism' to 0, forcing the
>   execution of the parallel-checkout code.
>   
> +GIT_TEST_SANITIZE_LEAK=<boolean> will force the tests to run when git
> +is compiled with SANITIZE=leak (we pick it up via
> +../GIT-BUILD-OPTIONS).
> +
> +By default all tests are skipped when compiled with SANITIZE=leak, and
> +individual test scripts opt themselves in to leak testing by setting
> +GIT_TEST_SANITIZE_LEAK=true before sourcing test-lib.sh. Within those
> +tests use the SANITIZE_LEAK prerequisite to skip individiual tests
> +(i.e. test_expect_success !SANITIZE_LEAK [...]).
> +
> +So the GIT_TEST_SANITIZE_LEAK setting is different in behavior from
> +both other GIT_TEST_*=[true|false] settings, but more useful given how
> +SANITIZE=leak works & the state of the test suite. Manually setting
> +GIT_TEST_SANITIZE_LEAK=true is only useful during development when
> +finding and fixing memory leaks.
> +
>   Naming Tests
>   ------------
>   
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> index 930721f053..d58efb0aa9 100755
> --- a/t/t5701-git-serve.sh
> +++ b/t/t5701-git-serve.sh
> @@ -243,7 +243,7 @@ test_expect_success 'unexpected lines are not allowed in fetch request' '
>   
>   # Test the basics of object-info
>   #
> -test_expect_success 'basics of object-info' '
> +test_expect_success !SANITIZE_LEAK 'basics of object-info' '
>   	test-tool pkt-line pack >in <<-EOF &&
>   	command=object-info
>   	object-format=$(test_oid algo)
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 7036f83b33..9201510e16 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1353,6 +1353,40 @@ then
>   	exit 1
>   fi
>   
> +# SANITIZE=leak test mode
> +sanitize_leak_true=
> +add_sanitize_leak_true () {
> +	sanitize_leak_true="$sanitize_leak_true$1 "
> +}
> +
> +sanitize_leak_false=
> +add_sanitize_leak_false () {
> +	sanitize_leak_false="$sanitize_leak_false$1 "
> +}
> +
> +sanitize_leak_opt_in_msg="opt-in with GIT_TEST_SANITIZE_LEAK=true"
> +maybe_skip_all_sanitize_leak () {
> +	# Whitelist patterns
> +	add_sanitize_leak_true 't000*'
> +	add_sanitize_leak_true 't001*'
> +	add_sanitize_leak_true 't006*'
> +
> +	# Blacklist patterns (overrides whitelist)
> +	add_sanitize_leak_false 't000[469]*'
> +	add_sanitize_leak_false 't001[2459]*'
> +	add_sanitize_leak_false 't006[0248]*'
> +
> +	if match_pattern_list "$1" "$sanitize_leak_false"
> +	then
> +		skip_all="test $this_test on SANITIZE=leak blacklist, $sanitize_leak_opt_in_msg"
> +		test_done
> +	elif match_pattern_list "$1" "$sanitize_leak_true"
> +	then
> +		return 0
> +	fi
> +	return 1
> +}
> +
>   # Are we running this test at all?
>   remove_trash=
>   this_test=${0##*/}
> @@ -1364,6 +1398,31 @@ then
>   	test_done
>   fi
>   
> +# Aggressively skip non-whitelisted tests when compiled with
> +# SANITIZE=leak
> +if test -n "$SANITIZE_LEAK"
> +then
> +	if test -z "$GIT_TEST_SANITIZE_LEAK" &&
> +		maybe_skip_all_sanitize_leak "$TEST_NAME"
> +	then
> +		say_color info >&3 "test $this_test on SANITIZE=leak whitelist"
> +		GIT_TEST_SANITIZE_LEAK=true
> +	fi
> +
> +	# We need to see it in "git env--helper" (via
> +	# test_bool_env)
> +	export GIT_TEST_SANITIZE_LEAK
> +
> +	if ! test_bool_env GIT_TEST_SANITIZE_LEAK false
> +	then
> +		skip_all="skip all tests in $this_test under SANITIZE=leak, $sanitize_leak_opt_in_msg"
> +		test_done
> +	fi
> +elif test_bool_env GIT_TEST_SANITIZE_LEAK false
> +then
> +	error "GIT_TEST_SANITIZE_LEAK=true has no effect except when compiled with SANITIZE=leak"
> +fi
> +
>   # Last-minute variable setup
>   HOME="$TRASH_DIRECTORY"
>   GNUPGHOME="$HOME/gnupg-home-not-used"
> @@ -1516,6 +1575,7 @@ test -z "$NO_PYTHON" && test_set_prereq PYTHON
>   test -n "$USE_LIBPCRE2" && test_set_prereq PCRE
>   test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
>   test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
> +test -n "$SANITIZE_LEAK" && test_set_prereq SANITIZE_LEAK
>   
>   if test -z "$GIT_TEST_CHECK_CACHE_TREE"
>   then
> 
