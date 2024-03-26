Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFE159B6F
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453573; cv=none; b=q6K4q7e5hlNMoRKTxlqm/8+fDja878Nl8fSgIlj0ccXo2+Vm0xE2isJn2rQBSk2rz4nRDGWyz9QjmpeiCHnpD3+HbzRNRds9ZOh5seTiyFiF/uaWhMO/D0YxBljLDR+jYdTxG5NitrAtC7gkYMs+VQ9HeH1vZdv0j07LgfETqUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453573; c=relaxed/simple;
	bh=i2zizsh/B6COsGWI95w3qjo8KanFT14XTKEczB5ZUl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCZlI+a5q6ELUB7DJQuCVdKTpZx01nSW2iIwKQ2WOItZbpS6MCCwnHjukNj06rLNcgdEwBAohMY/RrUxbpMKZAThnNFPlIExZ4Dv3isfYW/ClDzSW3B2gSknLKlkqNkV994XeU53y3HyRmnk1LWPZwdRR0O0osXEeIUP5tcVDVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FS/OwuAJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CQQcFOTL; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FS/OwuAJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CQQcFOTL"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 514531140151;
	Tue, 26 Mar 2024 07:46:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 26 Mar 2024 07:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711453569; x=1711539969; bh=v+ksBufn0G
	dP6Mz28LifjBb/P0T1j8aaMNDcNE83Cn8=; b=FS/OwuAJ6KoqSuWBtE9A22nr0W
	tkRVVvNAZDbP4OBtJ6rvv/g0ae67KzwiYQP2nyjpf0EqEUpfIRyuUB0fAK5SGQzf
	jtxZthbIoVzLdFT7MGR+YvfkC1I/B7g39CpsedsK51uevbcE1dN46BxbwNHRvbq7
	mu8MKBFL0NpOTaOVikNhezax3oooOfbveyx9L2+UmMd1RSbuNmGWq6gs7dK7nykd
	Ko+6J9vJ8p5iO20XG17oA8HARqmG4/QSeE1NoOzxLmv9/oLuDtdMeES48dW07lRX
	2INcZIikcVJwh8yXlKFL996j/SlduKp9kKFa1hp7SoUoN2LYyGiiPv5ALHRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711453569; x=1711539969; bh=v+ksBufn0GdP6Mz28LifjBb/P0T1
	j8aaMNDcNE83Cn8=; b=CQQcFOTL2ApBrzF4TSVcKsewL6YuOGG6046gPrE7skJe
	rZJGKUvcfq8XVcfWEAZmsSTxdmUDnvYvWAKDYEevIL6E329gZAkr11cPaF4BV+ur
	6A4zA9Ot6B5slovJxz/H43I62UmiuM4W7DN7rGlupMcIokpKE0O8f1imsDf+x1ZF
	CneDaywQcDtsga1lbcXwd6txDMEUTXwVIGaUkmaxRMKF/AZxxsh3D8wPpP0IZoUw
	rqTlENpEqf4x2r8ByUA7ltxmEBsESDJcyOjTAJdAo3tnZv2OCPTSc7TrltThTwKL
	+ytAMoZ/Pw85duPeopVXDWLrrpJamv95MMjtPblsrg==
X-ME-Sender: <xms:gbUCZsGLMkssedrAiIYrOvt6alQUok7f6rXJa2WtR4mAkjO6vYFPFw>
    <xme:gbUCZlUD9-lEmuox9AXs3Rg7XIKNA_jNALV3Fik9eT7U68sS8amvNC08hgcBp2Z9E
    VwRbZ4M_f9EJyOQew>
X-ME-Received: <xmr:gbUCZmIh50r4BPQdMd5USnRQZV_B2zymxIb28vuqt8ngF10aFLFWVYxjvoyTMXd1PNn43eiql8_2nnXyPhDU3mruFXwwv8PdLHJ6s5BMMw3->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:gbUCZuGuopOq0nbO8q7XysfZfxCtCy2dbbEEUvZShpKCzrR6gBMN9A>
    <xmx:gbUCZiVgEpezNri2XaoGuRQkJbQV9dVxEnp96mupEX7UViQkvLsyqQ>
    <xmx:gbUCZhPKNg7Bp5IzZV6GSg9bDukqf3hN6kWTd82Lf9vWEOOfyIfUOA>
    <xmx:gbUCZp2tAn1WAyd9GKIm58BjIYEq0YocLUtE5iaScFCgGVwfF0sHSw>
    <xmx:gbUCZke6CePOd3zDd6P3F2ZalGdq6Cl2WP1LgU65gMClkculUx63rQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 07:46:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a7fabbc3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Mar 2024 11:45:54 +0000 (UTC)
Date: Tue, 26 Mar 2024 12:46:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Achu Luma <ach.lumap@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [Outreachy][PATCH] Port helper/test-strcmp-offset.c to
 unit-tests/t-strcmp-offset.c
Message-ID: <ZgK1fLIlfssCRiS0@tanuki>
References: <20240310144819.4379-1-ach.lumap@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JLz+87sI1z0B1Aqq"
Content-Disposition: inline
In-Reply-To: <20240310144819.4379-1-ach.lumap@gmail.com>


--JLz+87sI1z0B1Aqq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 03:48:19PM +0100, Achu Luma wrote:
> In the recent codebase update (8bf6fbd (Merge branch
> 'js/doc-unit-tests', 2023-12-09)), a new unit testing framework was
> merged, providing a standardized approach for testing C code. Prior to
> this update, some unit tests relied on the test helper mechanism,
> lacking a dedicated unit testing framework. It's more natural to perform
> these unit tests using the new unit test framework.
>=20
> Let's migrate the unit tests for strcmp-offset functionality from the
> legacy approach using the test-tool command `test-tool strcmp-offset` in
> helper/test-strcmp-offset.c to the new unit testing framework
> (t/unit-tests/test-lib.h).
>=20
> The migration involves refactoring the tests to utilize the testing
> macros provided by the framework (TEST() and check_*()).
>=20
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Achu Luma <ach.lumap@gmail.com>
> ---
>  Makefile                       |  2 +-
>  t/helper/test-strcmp-offset.c  | 23 -----------------------
>  t/helper/test-tool.c           |  1 -
>  t/helper/test-tool.h           |  1 -
>  t/t0065-strcmp-offset.sh       | 22 ----------------------
>  t/unit-tests/t-strcmp-offset.c | 31 +++++++++++++++++++++++++++++++
>  6 files changed, 32 insertions(+), 48 deletions(-)
>  delete mode 100644 t/helper/test-strcmp-offset.c
>  delete mode 100755 t/t0065-strcmp-offset.sh
>  create mode 100644 t/unit-tests/t-strcmp-offset.c
>=20
> diff --git a/Makefile b/Makefile
> index 4e255c81f2..b8d7019ad7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -850,7 +850,6 @@ TEST_BUILTINS_OBJS +=3D test-sha1.o
>  TEST_BUILTINS_OBJS +=3D test-sha256.o
>  TEST_BUILTINS_OBJS +=3D test-sigchain.o
>  TEST_BUILTINS_OBJS +=3D test-simple-ipc.o
> -TEST_BUILTINS_OBJS +=3D test-strcmp-offset.o
>  TEST_BUILTINS_OBJS +=3D test-string-list.o
>  TEST_BUILTINS_OBJS +=3D test-submodule-config.o
>  TEST_BUILTINS_OBJS +=3D test-submodule-nested-repo-config.o
> @@ -1347,6 +1346,7 @@ UNIT_TEST_PROGRAMS +=3D t-mem-pool
>  UNIT_TEST_PROGRAMS +=3D t-strbuf
>  UNIT_TEST_PROGRAMS +=3D t-ctype
>  UNIT_TEST_PROGRAMS +=3D t-prio-queue
> +UNIT_TEST_PROGRAMS +=3D t-strcmp-offset
>  UNIT_TEST_PROGS =3D $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRA=
MS))
>  UNIT_TEST_OBJS =3D $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAM=
S))
>  UNIT_TEST_OBJS +=3D $(UNIT_TEST_DIR)/test-lib.o
> diff --git a/t/helper/test-strcmp-offset.c b/t/helper/test-strcmp-offset.c
> deleted file mode 100644
> index d8473cf2fc..0000000000
> --- a/t/helper/test-strcmp-offset.c
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -#include "test-tool.h"
> -#include "read-cache-ll.h"
> -
> -int cmd__strcmp_offset(int argc UNUSED, const char **argv)
> -{
> -	int result;
> -	size_t offset;
> -
> -	if (!argv[1] || !argv[2])
> -		die("usage: %s <string1> <string2>", argv[0]);
> -
> -	result =3D strcmp_offset(argv[1], argv[2], &offset);
> -
> -	/*
> -	 * Because different CRTs behave differently, only rely on signs
> -	 * of the result values.
> -	 */
> -	result =3D (result < 0 ? -1 :
> -			  result > 0 ? 1 :
> -			  0);
> -	printf("%d %"PRIuMAX"\n", result, (uintmax_t)offset);
> -	return 0;
> -}
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 482a1e58a4..3d56de82fd 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -76,7 +76,6 @@ static struct test_cmd cmds[] =3D {
>  	{ "sha256", cmd__sha256 },
>  	{ "sigchain", cmd__sigchain },
>  	{ "simple-ipc", cmd__simple_ipc },
> -	{ "strcmp-offset", cmd__strcmp_offset },
>  	{ "string-list", cmd__string_list },
>  	{ "submodule", cmd__submodule },
>  	{ "submodule-config", cmd__submodule_config },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index b1be7cfcf5..8d76a8c1e1 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -69,7 +69,6 @@ int cmd__oid_array(int argc, const char **argv);
>  int cmd__sha256(int argc, const char **argv);
>  int cmd__sigchain(int argc, const char **argv);
>  int cmd__simple_ipc(int argc, const char **argv);
> -int cmd__strcmp_offset(int argc, const char **argv);
>  int cmd__string_list(int argc, const char **argv);
>  int cmd__submodule(int argc, const char **argv);
>  int cmd__submodule_config(int argc, const char **argv);
> diff --git a/t/t0065-strcmp-offset.sh b/t/t0065-strcmp-offset.sh
> deleted file mode 100755
> index 94e34c83ed..0000000000
> --- a/t/t0065-strcmp-offset.sh
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -#!/bin/sh
> -
> -test_description=3D'Test strcmp_offset functionality'
> -
> -TEST_PASSES_SANITIZE_LEAK=3Dtrue
> -. ./test-lib.sh
> -
> -while read s1 s2 expect
> -do
> -	test_expect_success "strcmp_offset($s1, $s2)" '
> -		echo "$expect" >expect &&
> -		test-tool strcmp-offset "$s1" "$s2" >actual &&
> -		test_cmp expect actual
> -	'
> -done <<-EOF
> -abc abc 0 3
> -abc def -1 0
> -abc abz -1 2
> -abc abcdef -1 3
> -EOF
> -
> -test_done
> diff --git a/t/unit-tests/t-strcmp-offset.c b/t/unit-tests/t-strcmp-offse=
t.c
> new file mode 100644
> index 0000000000..176d2ed04a
> --- /dev/null
> +++ b/t/unit-tests/t-strcmp-offset.c
> @@ -0,0 +1,31 @@
> +#include "test-lib.h"
> +#include "read-cache-ll.h"
> +
> +static void check_strcmp_offset(const char *string1, const char *string2=
, int expect_result,  uintmax_t expect_offset)

Tiny nit: there's two spaces in front of `uintmax_t expect_offset`.

> +{
> +	int result;
> +	size_t offset;
> +
> +	result =3D strcmp_offset(string1, string2, &offset);
> +
> +	/* Because different CRTs behave differently, only rely on signs of the=
 result values. */
> +	result =3D (result < 0 ? -1 :
> +			  result > 0 ? 1 :
> +			  0);

I was wondering a bit why we munge the result like this and don't
compare that it's an exact match. But this isn't much of an isuse in my
opinion given that this is just a straight port of the old code.

Other than that this patch looks good to me, thanks!

Patrick

> +	check_int(result, =3D=3D, expect_result);
> +	check_uint((uintmax_t)offset, =3D=3D, expect_offset);
> +}
> +
> +#define TEST_STRCMP_OFFSET(string1, string2, expect_result, expect_offse=
t) \
> +		TEST(check_strcmp_offset(string1, string2, expect_result, expect_offse=
t), \
> +			"strcmp_offset(%s, %s) works", #string1, #string2)
> +
> +int cmd_main(int argc, const char **argv) {
> +	TEST_STRCMP_OFFSET("abc", "abc", 0, 3);
> +	TEST_STRCMP_OFFSET("abc", "def", -1, 0);
> +	TEST_STRCMP_OFFSET("abc", "abz", -1, 2);
> +	TEST_STRCMP_OFFSET("abc", "abcdef", -1, 3);
> +
> +	return test_done();
> +}
> --
> 2.43.0.windows.1
>=20
>=20

--JLz+87sI1z0B1Aqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYCtXsACgkQVbJhu7ck
PpR7FQ/7B/A4C9z3A6zctBhezFV6NztrwOy3s81YG8SbYQuyDIBiaFDaqF2L6lkV
kzKRCtn+lNlMAzjc/cveKRtuT7dXP95FoiCC2peusRhvzEiCk1etHZKouQikEozT
3Jac9mGiHzLD8w0WgL2kDMoR3L+YzVjcbPYjFG8cSy2eEHsYo1t6v0QXQe1/vzZU
5UUAc8ferN+I9Tl4GeKevdUoakyynXiFr7cEUWc2yM3NKxr7/UOBkNg1ih7za/8a
UZTJaOHt/VDF67IpWd3gZKTK+n9MyzfT5PoGmBVl5ywoxEOY33CVvMULHIu33pNN
ChwNd9cCu9tEL8hoxg+dXG6th3qYBdP7JNneH4YfPLeblJqVtkpw3HM03NbiGbu5
JVBdNMys9wgssl2qw/KjT0ociH1STKsMVaMQm8HWsoPn+6Cscel0si7wWYaDl2RN
z8hUxigJQ3NEdM+M9BPUAqQFybosQhNYHUnhdzISgu0+ftlc3vk9din+heXOh5mh
eyrQ8CBp7SRblhxAawiqiWFOjtAx0DGtTcco1T2ygiKDjW3j0qjb3/mKkb9YV04B
v2d22tUozS7zkjjOioIDUFQOPIzVlA3IaM10c+L9y9US6L7Xopi4fyCUD79O2h5P
rGFuiZXR3luTLXdyk0j0Yrx4S7EPiToFz3Yu1v7HO7877NK3dbU=
=sWm0
-----END PGP SIGNATURE-----

--JLz+87sI1z0B1Aqq--
