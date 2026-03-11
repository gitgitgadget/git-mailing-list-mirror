Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC6286D73
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773262146; cv=none; b=teGnkfbEKVFYFsIMQHAFID9qA2SkFdwNPugaQK0L7+aWALMnK1bRRpyzTGszLPunaw6m7sUGg6spdJkDgOEz+JcBZLbEqp5xQHcGSl0xe/drfjt6nsnUrpSuU6j960tryEsIE3h2vwZdzoNwI3543eRCSCi7A/+4x1cg6uzZ7WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773262146; c=relaxed/simple;
	bh=b8Ja91TSwqdua0Osrw8/tEcx5AAXX/0HUl8R0qsbdso=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SZ/a034TKIUp59gBQDqgVbFq5hPu9Oixvcnv8SWLQpMNRymQC153NLBuWhjWpCAQxdULJQaGewUTzuZr+I2FS7EltlMSxMXo8s1IPH/66RZ+jmC5hoim7m3os3DO9tjxuErQI/XMQ7ezHbSEa0G5nhnKHkVHJ6fvyHuMf9O2zCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bZ1hkwBj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CuUq9mCM; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bZ1hkwBj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CuUq9mCM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 69EBF1D00190;
	Wed, 11 Mar 2026 16:49:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 11 Mar 2026 16:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773262143; x=1773348543; bh=hoIxjf9DcZ
	Wk6nfg3DVPYxf4bguROqjulFFGPEMTlU4=; b=bZ1hkwBjg+boeGPk0KwOlxHP0s
	5ERlzbsxj/07kldcb87gleDlQBv1aPjcPrenKX05EdWjIKhq7sieHjOonC6r1exw
	mmivjj0uYlQ9o8JyFx40cx4WsIDp8PLnIlEkzVYPSHzhtra6hdGFxbjwSszPnr/d
	eqKOLug3/64PQOJrAeUqHOfaVwvPhDRG6O7BAIXH3ZsHKwlTeBti55/2UvBiApvv
	ysun1nP44Yp8JK7OOhQspOWzuu+wyVy8gUUc7vQDtPAhGkvsf+eiqiSg9NL/x92h
	bW+pJB91jX180T2GxbHxVV5R6jplglmOsieEtUNb7N4ACs92A3JjVuTD2CmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773262143; x=1773348543; bh=hoIxjf9DcZWk6nfg3DVPYxf4bguROqjulFF
	GPEMTlU4=; b=CuUq9mCMVP1hOPihZ6v99gBWvkWDeWqvok1emmhwxtfNCKKIE7e
	bH6iQsNEM2+PgP+CFjlHT+TcEbie+2zVl/3LPtmCSEai6UaODm4STnUzI5e0Lfn0
	ixsyrv8GUMG6gAYOd6ajKViyZhXdlonjyQOhI31Dz/5bDVhTdIU+fTuGR+9952JO
	5Ph5UTpnK+jqi8asVphM/XhR4zgG0tvqEcmtMP4HAzBUOR/dN9p+Gv9Yo5aVa7Hg
	PPGUG/VpQH+oyJijOPGq0DBRFJRZTBzIoSHMWBVgUHH0qEMDQgkmqSlJVFwnqE+x
	LqYrg5GbQRFtK8FY+oGd55eKG2Cd4iUuxLA==
X-ME-Sender: <xms:P9WxaSNfWY2E2RT6p5TNNVJCdC5VpLfQOUhJ6vxGm1zsF__L3i1s9w>
    <xme:P9WxaYbrnDqLDyyRb0DmNodMlNQSq72iG7jCsZme2qODQ1VpSQTMSDdFdn-Y1GrmF
    dV9M0pjG8IZAlcnUsPmWLA2p6RO_31QogDc8nnCr9KHDunRCr1voQ>
X-ME-Received: <xmr:P9WxaWq0cHi2w2boz6FypjnruvDFLkPrf--N_EvAnm-FVgBwaDj-lZeopzow-GlJ7Kk7UoiSrmqtVvtbWfOxSnmloQBNSan7rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprggslhho
    ohhsrggsrghtvghrrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:P9WxacaQlrAqCNLEd3SGartLgnfN2tDt1ScbJF0tzXPqMLdCYBo7_g>
    <xmx:P9WxaeQDFwv9J8cl1gvzr8eFxfOc0KBMXQMf6VuypFgIzTMa0JRurw>
    <xmx:P9WxaT4BDb8MEhU4UFw-nr6iqH_6n6Cg31KyKysdaKleMz6s5SOwSw>
    <xmx:P9WxaTxFol6V32A0uBnTyeh6iIyN63P-Ayx5_L8gqCQeGTxxfp3RxQ>
    <xmx:P9WxaUb5iy4ofOhiwfJEwp5BVqTiTvWH3ufoBwQUou3JXXAZVQL7f_Hs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 16:49:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH v2] test-lib: print escape sequence names
In-Reply-To: <20260311031442.11942-1-pabloosabaterr@gmail.com> (Pablo
	Sabater's message of "Wed, 11 Mar 2026 04:14:42 +0100")
References: <20260310183513.1077875-1-pabloosabaterr@gmail.com>
	<20260311031442.11942-1-pabloosabaterr@gmail.com>
Date: Wed, 11 Mar 2026 13:49:01 -0700
Message-ID: <xmqqms0em6rm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> When printing expected/actual characters in failed checks, use
> their names (\a, \b, \n, ...) instead of their octal representation,
> making it easier to read.
>
> Add tests to test-example-tap.c
> Update t0080-unit-test-output.sh to match the desired output
>
> Teach 'print_one_char()' the equivalent name
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
> Changes from v1:
> reverted unrelated test change '\'' to '\\'' in t0080
>
>  t/helper/test-example-tap.c |  4 +++
>  t/t0080-unit-test-output.sh | 52 +++++++++++++++++++++++--------------
>  t/unit-tests/test-lib.c     | 19 ++++++++++++--
>  3 files changed, 53 insertions(+), 22 deletions(-)

Looking good.  Will queue.  Thanks.


>
> diff --git a/t/helper/test-example-tap.c b/t/helper/test-example-tap.c
> index 229d495ecf..998a1f0b42 100644
> --- a/t/helper/test-example-tap.c
> +++ b/t/helper/test-example-tap.c
> @@ -63,6 +63,8 @@ static void t_messages(void)
>  	check_str("NULL", NULL);
>  	check_char('a', ==, '\n');
>  	check_char('\\', ==, '\'');
> +	check_char('\a', ==, '\v');
> +	check_char('\x00', ==, '\x01');
>  }
>  
>  static void t_empty(void)
> @@ -123,6 +125,8 @@ int cmd__example_tap(int argc UNUSED, const char **argv UNUSED)
>  		check_str("NULL", NULL);
>  		check_char('a', ==, '\n');
>  		check_char('\\', ==, '\'');
> +		check_char('\a', ==, '\v');
> +		check_char('\x00', ==, '\x01');
>  	}
>  	if_test ("if_test test with no checks")
>  		; /* nothing */
> diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
> index 3db10f095c..66838a00b2 100755
> --- a/t/t0080-unit-test-output.sh
> +++ b/t/t0080-unit-test-output.sh
> @@ -6,10 +6,10 @@ test_description='Test the output of the unit test framework'
>  
>  test_expect_success 'TAP output from unit tests' - <<\EOT
>  	cat >expect <<-EOF &&
> -	# BUG: check outside of test at t/helper/test-example-tap.c:75
> +	# BUG: check outside of test at t/helper/test-example-tap.c:77
>  	ok 1 - passing test
>  	ok 2 - passing test and assertion return 1
> -	# check "1 == 2" failed at t/helper/test-example-tap.c:79
> +	# check "1 == 2" failed at t/helper/test-example-tap.c:81
>  	#    left: 1
>  	#   right: 2
>  	not ok 3 - failing test
> @@ -34,53 +34,65 @@ test_expect_success 'TAP output from unit tests' - <<\EOT
>  	not ok 15 - failing check after TEST_TODO()
>  	ok 16 - failing check after TEST_TODO() returns 0
>  	# check "!strcmp("\thello\\\\", "there\"\n")" failed at t/helper/test-example-tap.c:62
> -	#    left: "\011hello\\\\"
> -	#   right: "there\"\012"
> +	#    left: "\thello\\\\"
> +	#   right: "there\"\n"
>  	# check "!strcmp("NULL", NULL)" failed at t/helper/test-example-tap.c:63
>  	#    left: "NULL"
>  	#   right: NULL
>  	# check "'a' == '\n'" failed at t/helper/test-example-tap.c:64
>  	#    left: 'a'
> -	#   right: '\012'
> +	#   right: '\n'
>  	# check "'\\\\' == '\\''" failed at t/helper/test-example-tap.c:65
>  	#    left: '\\\\'
>  	#   right: '\\''
> +	# check "'\a' == '\v'" failed at t/helper/test-example-tap.c:66
> +	#    left: '\a'
> +	#   right: '\v'
> +	# check "'\x00' == '\x01'" failed at t/helper/test-example-tap.c:67
> +	#    left: '\000'
> +	#   right: '\001'
>  	not ok 17 - messages from failing string and char comparison
> -	# BUG: test has no checks at t/helper/test-example-tap.c:94
> +	# BUG: test has no checks at t/helper/test-example-tap.c:96
>  	not ok 18 - test with no checks
>  	ok 19 - test with no checks returns 0
>  	ok 20 - if_test passing test
> -	# check "1 == 2" failed at t/helper/test-example-tap.c:100
> +	# check "1 == 2" failed at t/helper/test-example-tap.c:102
>  	#    left: 1
>  	#   right: 2
>  	not ok 21 - if_test failing test
>  	not ok 22 - if_test passing TEST_TODO() # TODO
> -	# todo check 'check(1)' succeeded at t/helper/test-example-tap.c:104
> +	# todo check 'check(1)' succeeded at t/helper/test-example-tap.c:106
>  	not ok 23 - if_test failing TEST_TODO()
> -	# check "0" failed at t/helper/test-example-tap.c:106
> +	# check "0" failed at t/helper/test-example-tap.c:108
>  	# skipping test - missing prerequisite
> -	# skipping check '1' at t/helper/test-example-tap.c:108
> +	# skipping check '1' at t/helper/test-example-tap.c:110
>  	ok 24 - if_test test_skip() # SKIP
>  	# skipping test - missing prerequisite
>  	ok 25 - if_test test_skip() inside TEST_TODO() # SKIP
> -	# check "0" failed at t/helper/test-example-tap.c:113
> +	# check "0" failed at t/helper/test-example-tap.c:115
>  	not ok 26 - if_test TEST_TODO() after failing check
> -	# check "0" failed at t/helper/test-example-tap.c:119
> +	# check "0" failed at t/helper/test-example-tap.c:121
>  	not ok 27 - if_test failing check after TEST_TODO()
> -	# check "!strcmp("\thello\\\\", "there\"\n")" failed at t/helper/test-example-tap.c:122
> -	#    left: "\011hello\\\\"
> -	#   right: "there\"\012"
> -	# check "!strcmp("NULL", NULL)" failed at t/helper/test-example-tap.c:123
> +	# check "!strcmp("\thello\\\\", "there\"\n")" failed at t/helper/test-example-tap.c:124
> +	#    left: "\thello\\\\"
> +	#   right: "there\"\n"
> +	# check "!strcmp("NULL", NULL)" failed at t/helper/test-example-tap.c:125
>  	#    left: "NULL"
>  	#   right: NULL
> -	# check "'a' == '\n'" failed at t/helper/test-example-tap.c:124
> +	# check "'a' == '\n'" failed at t/helper/test-example-tap.c:126
>  	#    left: 'a'
> -	#   right: '\012'
> -	# check "'\\\\' == '\\''" failed at t/helper/test-example-tap.c:125
> +	#   right: '\n'
> +	# check "'\\\\' == '\\''" failed at t/helper/test-example-tap.c:127
>  	#    left: '\\\\'
>  	#   right: '\\''
> +	# check "'\a' == '\v'" failed at t/helper/test-example-tap.c:128
> +	#    left: '\a'
> +	#   right: '\v'
> +	# check "'\x00' == '\x01'" failed at t/helper/test-example-tap.c:129
> +	#    left: '\000'
> +	#   right: '\001'
>  	not ok 28 - if_test messages from failing string and char comparison
> -	# BUG: test has no checks at t/helper/test-example-tap.c:127
> +	# BUG: test has no checks at t/helper/test-example-tap.c:131
>  	not ok 29 - if_test test with no checks
>  	1..29
>  	EOF
> diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
> index 87e1f5c201..72ee20a06f 100644
> --- a/t/unit-tests/test-lib.c
> +++ b/t/unit-tests/test-lib.c
> @@ -396,8 +396,23 @@ int check_uint_loc(const char *loc, const char *check, int ok,
>  static void print_one_char(char ch, char quote)
>  {
>  	if ((unsigned char)ch < 0x20u || ch == 0x7f) {
> -		/* TODO: improve handling of \a, \b, \f ... */
> -		printf("\\%03o", (unsigned char)ch);
> +		char esc;
> +		switch (ch) {
> +		case '\a': esc = 'a'; break;
> +		case '\b': esc = 'b'; break;
> +		case '\t': esc = 't'; break;
> +		case '\n': esc = 'n'; break;
> +		case '\v': esc = 'v'; break;
> +		case '\f': esc = 'f'; break;
> +		case '\r': esc = 'r'; break;
> +		default: esc = 0; break;
> +		}
> +		if (esc) {
> +			putc('\\', stdout);
> +			putc(esc, stdout);
> +		} else {
> +			printf("\\%03o", (unsigned char)ch);
> +		}
>  	} else {
>  		if (ch == '\\' || ch == quote)
>  			putc('\\', stdout);
