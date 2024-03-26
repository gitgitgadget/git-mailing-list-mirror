Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138D25475D
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453194; cv=none; b=FzwzpdPnohAKRWJqlKerpPOOjLT0xKymX7jJczypXqs2rqB5DoLJ1RBWa/vgpWrfF4JNOXiJ7ao50/cwghMqn/RZqxpRZXoTHJrvdFJ5GcmtbDdJ+XJx7pcKBbF/pi88WxFy22zeACNabTv6awUVWmiZ7KJhDUymrhNvk2BqIFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453194; c=relaxed/simple;
	bh=GMVah82dpfOUqDGKt2Q/MzEoUgyYqe5UK7meih8OYvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYL+X/2+LIsVhCVkNjku8FshXWM0ShrqRkyt0s4tHADpOVVt6Ocx3uAAwMAN3o7j5q+l7NlGZ9FfvoQHBNhgFUSw/C7uwVIP1Sm4AXA5do+9boZ12QNatABrjahw+3WKyB23XJqpuNSOJytWiJ7G9emi1QdHg3d1MfnisEOjMzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OK2e+/vr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IpnwuZ5R; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OK2e+/vr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IpnwuZ5R"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0579F1140151;
	Tue, 26 Mar 2024 07:39:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 26 Mar 2024 07:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711453190; x=1711539590; bh=PkNnfZH1Dk
	48UoPDwnqvsYels3G24/gEYwJWps4Xtao=; b=OK2e+/vr1gqnBvm0vURg4XoRkN
	enIIvoVSPmlA14YisFbyIQXXySD/dO8/6VtMjyq/dOwM6LaLN0Yrp9w+p15Yhpdh
	nCwPCD7266Z94NySw/5f1rxRpcaDZv4ifLiOX1Umacqk4ZYmj/MibpLYMZeV3Psa
	3FyNBr1/wJXnEtZa3Uo3lcQBGioMiCYfit9PtRnDHdpaGPnTYHV4KWuIQ2ksAH/E
	2/hdS1iASK7v0Q1eVjAThMt2Nn+D0SZQSYf3ta/po6C5D71UjZs79rGy+K9X+xAQ
	olFCwTwqlAgg8T6HhVGYdoQgk6XPiVXSWQsK+DHfWvR12ECJjuW5b1SurU2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711453190; x=1711539590; bh=PkNnfZH1Dk48UoPDwnqvsYels3G2
	4/gEYwJWps4Xtao=; b=IpnwuZ5R9n8CvmjQs/t9OogHsCQk56DcbIjNZy/AEawe
	4L1wPRoxs2qKLk698jBlFEVtzSNTXS5S40vd6A2/yKxnKY0J4yHJiwDu1fUteRIs
	MOp0qDSJK5PkmirbjKRnML9jAC8Bt9TrNF+Qsu0P5L5gKUhUy938wX6cSC2+dPl5
	nQYYEapW1ZN4GlCqAPau9es7jRRaiDUHqi/RfnCqDcIauwSxg6r7ah3LBph/6yP3
	goFVByBnYzcQcENr+hWXYJ3KAX3jmeRErRT6OQAvldhjcS21NJwc2Buv5yTAhutJ
	cQyZdrGjcYB/SXkg7wnNO/KNwZVrnqkDFRKYxxIi1Q==
X-ME-Sender: <xms:BrQCZq6FS8IdN78fFjXYZkgTPKbNSgMCn3Z_5sdZZUEiuQLKrK7MAQ>
    <xme:BrQCZj5boPwgCDh3qLwG-30xuTVjybvdyto0LIAURmxs9xrmqkqriJ_jBDCCJCJzt
    ds2d4xUWo67nv_TlQ>
X-ME-Received: <xmr:BrQCZpflyHqQmJOBp74V9F_Prp-vQ8qtb_s_vxcVF0-LOSpw2ekuTrmLChnv5QesWJw3krRR9CmS7rzYzBbakJaYsmAgyYbZd6u4S27KbGED>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:BrQCZnLX5qPMKyJKl-HjXsG3scmtx-ycKYKJeqCsk8k27gZ2oty8kA>
    <xmx:BrQCZuLrNeTZ27DLG-jpfhPWsnqQ6OAMG4Wlysxq6JIbHzthZX-YeQ>
    <xmx:BrQCZowXIY6qkzgxufZZpvYHCFGW8LTzaIxZKaZP7Lpz8FmXhl59cg>
    <xmx:BrQCZiJg7M7WoKKzycdJC55MDr2UtgR9QSlNwY_RlW4GzaHIwA88nQ>
    <xmx:BrQCZm-yfWoAIvL_6vgeAtdTc_EPT1X_qMgcJlQj2FHnbXfuqikdoA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 07:39:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c5963c77 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Mar 2024 11:39:36 +0000 (UTC)
Date: Tue, 26 Mar 2024 12:39:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Achu Luma <ach.lumap@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org,
	christian.couder@gmail.com, gitster@pobox.com
Subject: Re: [Outreachy][PATCH v2 2/2] Port helper/test-sha256.c and
 helper/test-sha1.c to unit-tests/t-hash.c
Message-ID: <ZgK0Ap8CokOqWT7v@tanuki>
References: <20240226143350.3596-1-ach.lumap@gmail.com>
 <20240229054004.3807-1-ach.lumap@gmail.com>
 <20240229054004.3807-2-ach.lumap@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zyPzfyiWBSC6ck4R"
Content-Disposition: inline
In-Reply-To: <20240229054004.3807-2-ach.lumap@gmail.com>


--zyPzfyiWBSC6ck4R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 06:40:03AM +0100, Achu Luma wrote:
> In the recent codebase update (8bf6fbd (Merge branch
> 'js/doc-unit-tests', 2023-12-09)), a new unit testing framework was
> merged, providing a standardized approach for testing C code. Prior to
> this update, some unit tests relied on the test helper mechanism,
> lacking a dedicated unit testing framework. It's more natural to perform
> these unit tests using the new unit test framework.
>=20
> This commit migrates the unit tests for hash functionality from the
> legacy approach using the test-tool command `test-tool sha1`and

Nit: s/sha1`and/sha1` and/.

> `test-tool sha256` in helper/test-sha256.c and helper/test-sha1.c to the
> new unit testing framework (t/unit-tests/test-lib.h). Porting
> t0013-sha1dc.sh is left for later.
>=20
> The migration involves refactoring the tests to utilize the testing
> macros provided by the framework (TEST() and check_*()).
>=20
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Achu Luma <ach.lumap@gmail.com>
> ---
>  The change between version 1 and version 2 is:
>  - Deleted t/helper/test-sha256.c
>=20
>  Here is a diff between v1 and v2:
>=20
>  -#include "test-tool.h"
>  -#include "hash-ll.h"
>  -
>  -int cmd__sha256(int ac, const char **av)
>  -{
>  -       return cmd_hash_impl(ac, av, GIT_HASH_SHA256);
>  -}
>=20
>  Makefile               |  2 +-
>  t/helper/test-sha256.c |  7 ----
>  t/helper/test-tool.c   |  1 -
>  t/helper/test-tool.h   |  1 -
>  t/t0015-hash.sh        | 56 -------------------------------
>  t/unit-tests/t-hash.c  | 75 ++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 76 insertions(+), 66 deletions(-)
>  delete mode 100644 t/helper/test-sha256.c
>  delete mode 100755 t/t0015-hash.sh
>  create mode 100644 t/unit-tests/t-hash.c
>=20
> diff --git a/Makefile b/Makefile
> index 4e255c81f2..c85f24f813 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -847,7 +847,6 @@ TEST_BUILTINS_OBJS +=3D test-run-command.o
>  TEST_BUILTINS_OBJS +=3D test-scrap-cache-tree.o
>  TEST_BUILTINS_OBJS +=3D test-serve-v2.o
>  TEST_BUILTINS_OBJS +=3D test-sha1.o
> -TEST_BUILTINS_OBJS +=3D test-sha256.o
>  TEST_BUILTINS_OBJS +=3D test-sigchain.o
>  TEST_BUILTINS_OBJS +=3D test-simple-ipc.o
>  TEST_BUILTINS_OBJS +=3D test-strcmp-offset.o
> @@ -1347,6 +1346,7 @@ UNIT_TEST_PROGRAMS +=3D t-mem-pool
>  UNIT_TEST_PROGRAMS +=3D t-strbuf
>  UNIT_TEST_PROGRAMS +=3D t-ctype
>  UNIT_TEST_PROGRAMS +=3D t-prio-queue
> +UNIT_TEST_PROGRAMS +=3D t-hash
>  UNIT_TEST_PROGS =3D $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRA=
MS))
>  UNIT_TEST_OBJS =3D $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAM=
S))
>  UNIT_TEST_OBJS +=3D $(UNIT_TEST_DIR)/test-lib.o
> diff --git a/t/helper/test-sha256.c b/t/helper/test-sha256.c
> deleted file mode 100644
> index 08cf149001..0000000000
> --- a/t/helper/test-sha256.c
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -#include "test-tool.h"
> -#include "hash-ll.h"
> -
> -int cmd__sha256(int ac, const char **av)
> -{
> -	return cmd_hash_impl(ac, av, GIT_HASH_SHA256);
> -}
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 482a1e58a4..7bfbb75c9b 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -73,7 +73,6 @@ static struct test_cmd cmds[] =3D {
>  	{ "serve-v2", cmd__serve_v2 },
>  	{ "sha1", cmd__sha1 },

I'm a bit surprised that the `cmd_sha1` subcommand still exists. I would
have expected it to be removed as part of this commit, as well, judging
by the commit message.

In any case I think it would be easier to review if the "sha1" and
"sha256" refactorings were split out into two separate patches.

Patrick

>  	{ "sha1-is-sha1dc", cmd__sha1_is_sha1dc },
> -	{ "sha256", cmd__sha256 },
>  	{ "sigchain", cmd__sigchain },
>  	{ "simple-ipc", cmd__simple_ipc },
>  	{ "strcmp-offset", cmd__strcmp_offset },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index b1be7cfcf5..8139c9664d 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -66,7 +66,6 @@ int cmd__serve_v2(int argc, const char **argv);
>  int cmd__sha1(int argc, const char **argv);
>  int cmd__sha1_is_sha1dc(int argc, const char **argv);
>  int cmd__oid_array(int argc, const char **argv);
> -int cmd__sha256(int argc, const char **argv);
>  int cmd__sigchain(int argc, const char **argv);
>  int cmd__simple_ipc(int argc, const char **argv);
>  int cmd__strcmp_offset(int argc, const char **argv);
> diff --git a/t/t0015-hash.sh b/t/t0015-hash.sh
> deleted file mode 100755
> index 0a087a1983..0000000000
> --- a/t/t0015-hash.sh
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -#!/bin/sh
> -
> -test_description=3D'test basic hash implementation'
> -
> -TEST_PASSES_SANITIZE_LEAK=3Dtrue
> -. ./test-lib.sh
> -
> -test_expect_success 'test basic SHA-1 hash values' '
> -	test-tool sha1 </dev/null >actual &&
> -	grep da39a3ee5e6b4b0d3255bfef95601890afd80709 actual &&
> -	printf "a" | test-tool sha1 >actual &&
> -	grep 86f7e437faa5a7fce15d1ddcb9eaeaea377667b8 actual &&
> -	printf "abc" | test-tool sha1 >actual &&
> -	grep a9993e364706816aba3e25717850c26c9cd0d89d actual &&
> -	printf "message digest" | test-tool sha1 >actual &&
> -	grep c12252ceda8be8994d5fa0290a47231c1d16aae3 actual &&
> -	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha1 >actual &&
> -	grep 32d10c7b8cf96570ca04ce37f2a19d84240d3a89 actual &&
> -	perl -e "$| =3D 1; print q{aaaaaaaaaa} for 1..100000;" |
> -		test-tool sha1 >actual &&
> -	grep 34aa973cd4c4daa4f61eeb2bdbad27316534016f actual &&
> -	printf "blob 0\0" | test-tool sha1 >actual &&
> -	grep e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 actual &&
> -	printf "blob 3\0abc" | test-tool sha1 >actual &&
> -	grep f2ba8f84ab5c1bce84a7b441cb1959cfc7093b7f actual &&
> -	printf "tree 0\0" | test-tool sha1 >actual &&
> -	grep 4b825dc642cb6eb9a060e54bf8d69288fbee4904 actual
> -'
> -
> -test_expect_success 'test basic SHA-256 hash values' '
> -	test-tool sha256 </dev/null >actual &&
> -	grep e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 a=
ctual &&
> -	printf "a" | test-tool sha256 >actual &&
> -	grep ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb a=
ctual &&
> -	printf "abc" | test-tool sha256 >actual &&
> -	grep ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad a=
ctual &&
> -	printf "message digest" | test-tool sha256 >actual &&
> -	grep f7846f55cf23e14eebeab5b4e1550cad5b509e3348fbc4efa3a1413d393cb650 a=
ctual &&
> -	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha256 >actual &&
> -	grep 71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73 a=
ctual &&
> -	# Try to exercise the chunking code by turning autoflush on.
> -	perl -e "$| =3D 1; print q{aaaaaaaaaa} for 1..100000;" |
> -		test-tool sha256 >actual &&
> -	grep cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0 a=
ctual &&
> -	perl -e "$| =3D 1; print q{abcdefghijklmnopqrstuvwxyz} for 1..100000;" |
> -		test-tool sha256 >actual &&
> -	grep e406ba321ca712ad35a698bf0af8d61fc4dc40eca6bdcea4697962724ccbde35 a=
ctual &&
> -	printf "blob 0\0" | test-tool sha256 >actual &&
> -	grep 473a0f4c3be8a93681a267e3b1e9a7dcda1185436fe141f7749120a303721813 a=
ctual &&
> -	printf "blob 3\0abc" | test-tool sha256 >actual &&
> -	grep c1cf6e465077930e88dc5136641d402f72a229ddd996f627d60e9639eaba35a6 a=
ctual &&
> -	printf "tree 0\0" | test-tool sha256 >actual &&
> -	grep 6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321 a=
ctual
> -'
> -
> -test_done
> diff --git a/t/unit-tests/t-hash.c b/t/unit-tests/t-hash.c
> new file mode 100644
> index 0000000000..b512e64bf1
> --- /dev/null
> +++ b/t/unit-tests/t-hash.c
> @@ -0,0 +1,75 @@
> +#include "test-lib.h"
> +#include "hash-ll.h"
> +#include "hex.h"
> +#include "strbuf.h"
> +
> +static void check_hash_data(const void *data, size_t data_length, const =
char *expected, int algo) {
> +	git_hash_ctx ctx;
> +	unsigned char hash[GIT_MAX_HEXSZ];
> +	const struct git_hash_algo *algop =3D &hash_algos[algo];
> +
> +	if (!check(!!data)) {
> +    		test_msg("Error: No data provided when expecting: %s", expected);
> +    		return;
> +	}
> +
> +	algop->init_fn(&ctx);
> +	algop->update_fn(&ctx, data, data_length);
> +	algop->final_fn(hash, &ctx);
> +
> +	check_str(hash_to_hex_algop(hash, algop), expected);
> +}
> +
> +/* Works with a NUL terminated string. Doesn't work if it should contain=
 a NUL character. */
> +#define TEST_SHA1_STR(data, expected) \
> +    	TEST(check_hash_data(data, strlen(data), expected, GIT_HASH_SHA1), \
> +        	"SHA1 (%s) works", #data)
> +
> +/* Only works with a literal string, useful when it contains a NUL chara=
cter. */
> +#define TEST_SHA1_LITERAL(literal, expected) \
> +    	TEST(check_hash_data(literal, (sizeof(literal) - 1), expected, GIT_=
HASH_SHA1), \
> +        	"SHA1 (%s) works", #literal)
> +
> +/* Works with a NUL terminated string. Doesn't work if it should contain=
 a NUL character. */
> +#define TEST_SHA256_STR(data, expected) \
> +    	TEST(check_hash_data(data, strlen(data), expected, GIT_HASH_SHA256)=
, \
> +        	"SHA256 (%s) works", #data)
> +
> +/* Only works with a literal string, useful when it contains a NUL chara=
cter. */
> +#define TEST_SHA256_LITERAL(literal, expected) \
> +    	TEST(check_hash_data(literal, (sizeof(literal) - 1), expected, GIT_=
HASH_SHA256), \
> +        	"SHA256 (%s) works", #literal)
> +
> +int cmd_main(int argc, const char **argv) {
> +	struct strbuf aaaaaaaaaa_100000 =3D STRBUF_INIT;
> +	struct strbuf alphabet_100000 =3D STRBUF_INIT;
> +
> +	strbuf_addstrings(&aaaaaaaaaa_100000, "aaaaaaaaaa", 100000);
> +	strbuf_addstrings(&alphabet_100000, "abcdefghijklmnopqrstuvwxyz", 10000=
0);
> +
> +	TEST_SHA1_STR("", "da39a3ee5e6b4b0d3255bfef95601890afd80709");
> +	TEST_SHA1_STR("a", "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8");
> +	TEST_SHA1_STR("abc", "a9993e364706816aba3e25717850c26c9cd0d89d");
> +	TEST_SHA1_STR("message digest", "c12252ceda8be8994d5fa0290a47231c1d16aa=
e3");
> +	TEST_SHA1_STR("abcdefghijklmnopqrstuvwxyz", "32d10c7b8cf96570ca04ce37f2=
a19d84240d3a89");
> +	TEST_SHA1_STR(aaaaaaaaaa_100000.buf, "34aa973cd4c4daa4f61eeb2bdbad27316=
534016f");
> +	TEST_SHA1_LITERAL("blob 0\0", "e69de29bb2d1d6434b8b29ae775ad8c2e48c5391=
");
> +	TEST_SHA1_LITERAL("blob 3\0abc", "f2ba8f84ab5c1bce84a7b441cb1959cfc7093=
b7f");
> +	TEST_SHA1_LITERAL("tree 0\0", "4b825dc642cb6eb9a060e54bf8d69288fbee4904=
");
> +
> +	TEST_SHA256_STR("", "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca4=
95991b7852b855");
> +	TEST_SHA256_STR("a", "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b=
9807785afee48bb");
> +	TEST_SHA256_STR("abc", "ba7816bf8f01cfea414140de5dae2223b00361a396177a9=
cb410ff61f20015ad");
> +	TEST_SHA256_STR("message digest", "f7846f55cf23e14eebeab5b4e1550cad5b50=
9e3348fbc4efa3a1413d393cb650");
> +	TEST_SHA256_STR("abcdefghijklmnopqrstuvwxyz", "71c480df93d6ae2f1efad144=
7c66c9525e316218cf51fc8d9ed832f2daf18b73");
> +	TEST_SHA256_STR(aaaaaaaaaa_100000.buf, "cdc76e5c9914fb9281a1c7e284d73e6=
7f1809a48a497200e046d39ccc7112cd0");
> +	TEST_SHA256_STR(alphabet_100000.buf, "e406ba321ca712ad35a698bf0af8d61fc=
4dc40eca6bdcea4697962724ccbde35");
> +	TEST_SHA256_LITERAL("blob 0\0", "473a0f4c3be8a93681a267e3b1e9a7dcda1185=
436fe141f7749120a303721813");
> +	TEST_SHA256_LITERAL("blob 3\0abc", "c1cf6e465077930e88dc5136641d402f72a=
229ddd996f627d60e9639eaba35a6");
> +	TEST_SHA256_LITERAL("tree 0\0", "6ef19b41225c5369f1c104d45d8d85efa9b057=
b53b14b4b9b939dd74decc5321");
> +
> +	strbuf_release(&aaaaaaaaaa_100000);
> +	strbuf_release(&alphabet_100000);
> +
> +	return test_done();
> +}
> --
> 2.43.0.windows.1
>=20
>=20

--zyPzfyiWBSC6ck4R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYCtAEACgkQVbJhu7ck
PpQ4cw/8D5C1U6y71IcN41hoJJYdHEwHaj5r6zZIUWnjb0oh/YomzUaCpIiMd09I
9hGpc37VZ/Z/6VwfGJXm44ovSj18IsS9bf5AatDqzwyOBLOUVNcAYtpXlfLMZcYS
M4AWXmyflIcRHwYFM/aHg67nXpzPbYRSZTrMFdBBXSb2ySN/3RN/ewvIJeqAos+K
sjiIFeigD8V7U29LUGarpbnf4BQE9YIGfTRV+4z+YN6bVGVrEV0R4wBrOMklbdnx
pNvfljhPMb+MA4UkETJl+KkLn2zx9OFp0akmxqWGvhrNxWUhXZgp0Tx8yAmjT1XR
lPi8zD3vNdKdJP+56Pyd63jQGc3kezm4aDJD/PogqSrQxdbPLIzWOQ1EwFD6vuig
+5iGTGq5tNQZm+amFwyf5F4cGnvKRNPUZoqX6NyEXoQp/Hv+IbSVossFGPkhyB0L
VUHDspNQ21KFZ7CDpcm9bgRZM3BmjpD6YYJBMk5vbXOACFmX5dNCG84RqWTOlxR4
fPHB3sBNnjiw+1TA2He/RoNvARuFdOFKP5snG+sc72A/PwpjgswFiivfeb0caZCf
1WN/p5OHehqPbE2lRXGEFJSmvl4fMxlBqYoFIxY07/f3NPt1WYWUwX09MGmL89qV
0PrhLnq1e51o9oM5hKQIqCEL9YDY7OdXWIthQcL+4sKtd2v6Pf4=
=sqlY
-----END PGP SIGNATURE-----

--zyPzfyiWBSC6ck4R--
