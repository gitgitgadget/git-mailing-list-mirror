Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2F91BD9C1
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738323842; cv=none; b=dOXKI1UzPTv3GOlF7Lc52v9yclv3jm0mfCaUF73ywtYybhVuel2YMUw70VNDadhxcds0K2Tcgi8KRfvl6SADd4P6gxIuTzweIBv2haaI05huFVYJM6Z33kx3SshoiXMX0+BPi2m8WEh51vFeyqT/Yg/qHjRpP0j0HfcqZtiOpl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738323842; c=relaxed/simple;
	bh=GhPx5qeNdF3104myqlXLRGOCFsMvqvoBqJBlnKCE/Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4zq2GdRpyD7MW5xScwlMuvEVfKWQ3JPH3OeEjBCKEJVnKe5YUsP0lcGxoTzqABv+DdH25nrvOdHVAE5rwmfcxKJzHIjJKAPcHLYzp4chafZXiZF1HUB/FOIhp5aezcycPn/RYb6jGBc7hO2NSIzjz1biPuk5ficWNssxt3iTYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZLwxSnar; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EEtLM30R; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZLwxSnar";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EEtLM30R"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5EAE31140106;
	Fri, 31 Jan 2025 06:43:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 31 Jan 2025 06:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738323839; x=1738410239; bh=YmThaACQJ2
	MoeOvfUNUGbmNEJF2fsS4aSGCXA6V8hlY=; b=ZLwxSnariFzGAXp+LcfGsAxAKS
	yCWErXSoETNPqXwON7zqQiWemNyws0WyyhssV9U/PW/Y5wXixVgj/Q4uDoz3C6kd
	DNc3UkDwZ1Ce07HCGwYp9Y4ucebBZq6YV+DjsTZskMvEijlIiI41cQKnXA5vge0F
	gCKdzAfZIDCkVYAH16b8VoA31BJWpC2ePG44FZvTjunuvjynprPkF51QcSdEDjOO
	WD70LdK0JwHbaFnbPnIeckgWw1WVe3mDsZleQa97Hl+M47tICXNAeKFggv8ZPQOD
	9rtEPe40RWpfF6bNat3Z0kAzZsU8YQSMTzI7SGicGt/Zza20xayI4iNQ8pUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738323839; x=1738410239; bh=YmThaACQJ2MoeOvfUNUGbmNEJF2fsS4aSGC
	XA6V8hlY=; b=EEtLM30ROjJo5tJRiKVeQk1NdU7ExH3XSiKDCnu6dVroz78kni2
	843V8eSCPA8vGwp8abE0IjYmac8yl5oDwNnfcJ78bflHg9WTOSr0AKDbjFrIvggV
	rW9jrkB1DTwUWF1LACIa02y2c1RBX1xZVBRac42b3DagDncakUr60DGs2HTJ0v4Y
	IEmK85XE1vnaJY4CwXdJvb4cfx0zGQmyEqLNlV2jKfjhkpY3z87lJgmmXFDcXNxp
	MkxAL5tDpFzNUtlCnp1RB1PvDiJN4sMOi2XE3IsT2S+4rFqfivAmo0LyzZTIaVr2
	ZBXBKJLfTc0w6C39itGPRO7t/qGpXYoL0fg==
X-ME-Sender: <xms:f7ecZxKq05PRBBctulGLhBd9BvH_Gx82Xvb_rF4A8dKkew7bdN4DMA>
    <xme:f7ecZ9KxechyOdxwif3vcmMMJ7y7uH7vUiAmazsSnoUgPG6TbpO6DWCRIWY98kyMo
    ahXcz_vNForjdbGGA>
X-ME-Received: <xmr:f7ecZ5u6i7Kj80H9TCmQMYBlYsflKos_5P8TanatzvvUOXG2-_pGxyEZKiEuQSqjJLtDy2dAOh8fpke9o1ZH9rpD7_mH53BQYu2-uWC_u3vFag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:f7ecZyYi7UQlsF1qie7FSdmu72kNYE0ou7oDq0V5_dWcrGMVg6wvqg>
    <xmx:f7ecZ4Zy8RDYl67GhvVriMZxUAO1dFBkHsjaCFgqIH8_oVSPNNNG2Q>
    <xmx:f7ecZ2DDIGxJ9MuoLyr2m3mTeYUY_H-EX0nPz8UwcWjDCnEv0J0qZw>
    <xmx:f7ecZ2YBmUh9JdfiHp1JlvTtNnZ-_OOwtBiIwiZ01YeYnxIMU7HoEg>
    <xmx:f7ecZwE1GgxeYsniEeZIBZMzXxL5yixtpkHWajm-NdRV1_IAsw6fxiMK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 06:43:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ab889526 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 11:43:57 +0000 (UTC)
Date: Fri, 31 Jan 2025 12:43:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/4] t/unit-tests: adapt example decorate test to clar
 framework
Message-ID: <Z5y3fI7o6ZXaSoas@pks.im>
References: <20250130091334.39922-1-kuforiji98@gmail.com>
 <20250130091334.39922-3-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130091334.39922-3-kuforiji98@gmail.com>

On Thu, Jan 30, 2025 at 10:13:32AM +0100, Seyi Kuforiji wrote:
> Adapts example decorate test script to clar framework by using clar
> assertions where necessary. Test functions are created as standalone to
> test different test cases.

Again, I don't think that the second sentence doesn't add much
information to the commit message and can probably just be dropped. It
would be more interesting to talk about any design decisions that
weren't immediately obvious, as these may also make the reviewer wonder.

One thing that would be worth to explain here are the `initialize()` and
`cleanup()` functions. Readers not familiar with the clar framework may
not know that those get picked up by the framework automatically and
that they are executed before and after every single test.

> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> ---
>  Makefile                          |  2 +-
>  t/meson.build                     |  2 +-
>  t/unit-tests/t-example-decorate.c | 74 ------------------------------
>  t/unit-tests/u-example-decorate.c | 76 +++++++++++++++++++++++++++++++
>  4 files changed, 78 insertions(+), 76 deletions(-)
>  delete mode 100644 t/unit-tests/t-example-decorate.c
>  create mode 100644 t/unit-tests/u-example-decorate.c
> 
> diff --git a/Makefile b/Makefile
> index 2d9dad119a..732d765f1c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1338,6 +1338,7 @@ THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
>  THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
>  
>  CLAR_TEST_SUITES += u-ctype
> +CLAR_TEST_SUITES += u-example-decorate
>  CLAR_TEST_SUITES += u-hash
>  CLAR_TEST_SUITES += u-hashmap
>  CLAR_TEST_SUITES += u-mem-pool
> @@ -1349,7 +1350,6 @@ CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
>  CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
>  CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
>  
> -UNIT_TEST_PROGRAMS += t-example-decorate
>  UNIT_TEST_PROGRAMS += t-oid-array
>  UNIT_TEST_PROGRAMS += t-oidmap
>  UNIT_TEST_PROGRAMS += t-oidtree
> diff --git a/t/meson.build b/t/meson.build
> index af597f9804..c7e08eca6f 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -1,5 +1,6 @@
>  clar_test_suites = [
>    'unit-tests/u-ctype.c',
> +  'unit-tests/u-example-decorate.c',
>    'unit-tests/u-hash.c',
>    'unit-tests/u-hashmap.c',
>    'unit-tests/u-mem-pool.c',
> @@ -45,7 +46,6 @@ clar_unit_tests = executable('unit-tests',
>  test('unit-tests', clar_unit_tests)
>  
>  unit_test_programs = [
> -  'unit-tests/t-example-decorate.c',
>    'unit-tests/t-oid-array.c',
>    'unit-tests/t-oidmap.c',
>    'unit-tests/t-oidtree.c',
> diff --git a/t/unit-tests/t-example-decorate.c b/t/unit-tests/t-example-decorate.c
> deleted file mode 100644
> index bfc776e223..0000000000
> --- a/t/unit-tests/t-example-decorate.c
> +++ /dev/null
> @@ -1,74 +0,0 @@
> -#define USE_THE_REPOSITORY_VARIABLE
> -
> -#include "test-lib.h"
> -#include "object.h"
> -#include "decorate.h"
> -#include "repository.h"
> -
> -struct test_vars {
> -	struct object *one, *two, *three;
> -	struct decoration n;
> -	int decoration_a, decoration_b;
> -};
> -
> -static void t_add(struct test_vars *vars)
> -{
> -	void *ret = add_decoration(&vars->n, vars->one, &vars->decoration_a);
> -
> -	check(ret == NULL);
> -	ret = add_decoration(&vars->n, vars->two, NULL);
> -	check(ret == NULL);
> -}
> -
> -static void t_readd(struct test_vars *vars)
> -{
> -	void *ret = add_decoration(&vars->n, vars->one, NULL);
> -
> -	check(ret == &vars->decoration_a);
> -	ret = add_decoration(&vars->n, vars->two, &vars->decoration_b);
> -	check(ret == NULL);
> -}
> -
> -static void t_lookup(struct test_vars *vars)
> -{
> -	void *ret = lookup_decoration(&vars->n, vars->one);
> -
> -	check(ret == NULL);
> -	ret = lookup_decoration(&vars->n, vars->two);
> -	check(ret == &vars->decoration_b);
> -	ret = lookup_decoration(&vars->n, vars->three);
> -	check(ret == NULL);
> -}
> -
> -static void t_loop(struct test_vars *vars)
> -{
> -	int objects_noticed = 0;
> -
> -	for (size_t i = 0; i < vars->n.size; i++) {
> -		if (vars->n.entries[i].base)
> -			objects_noticed++;
> -	}
> -	check_int(objects_noticed, ==, 2);
> -}
> -
> -int cmd_main(int argc UNUSED, const char **argv UNUSED)
> -{
> -	struct object_id one_oid = { { 1 } }, two_oid = { { 2 } }, three_oid = { { 3 } };
> -	struct test_vars vars = { 0 };
> -
> -	vars.one = lookup_unknown_object(the_repository, &one_oid);
> -	vars.two = lookup_unknown_object(the_repository, &two_oid);
> -	vars.three = lookup_unknown_object(the_repository, &three_oid);
> -
> -	TEST(t_add(&vars),
> -	     "Add 2 objects, one with a non-NULL decoration and one with a NULL decoration.");
> -	TEST(t_readd(&vars),
> -	     "When re-adding an already existing object, the old decoration is returned.");
> -	TEST(t_lookup(&vars),
> -	     "Lookup returns the added declarations, or NULL if the object was never added.");
> -	TEST(t_loop(&vars), "The user can also loop through all entries.");
> -
> -	clear_decoration(&vars.n, NULL);
> -
> -	return test_done();
> -}
> diff --git a/t/unit-tests/u-example-decorate.c b/t/unit-tests/u-example-decorate.c
> new file mode 100644
> index 0000000000..3a457d41fc
> --- /dev/null
> +++ b/t/unit-tests/u-example-decorate.c
> @@ -0,0 +1,76 @@
> +#define USE_THE_REPOSITORY_VARIABLE
> +
> +#include "unit-test.h"
> +#include "object.h"
> +#include "decorate.h"
> +#include "repository.h"
> +
> +struct test_vars {
> +	struct object *one, *two, *three;
> +	struct decoration n;
> +	int decoration_a, decoration_b;
> +};
> +
> +static struct test_vars vars;
> +
> +void test_example_decorate__add(void)
> +{
> +	void *ret = add_decoration(&vars.n, vars.one, &vars.decoration_a);
> +	cl_assert(ret == NULL);
> +	ret = add_decoration(&vars.n, vars.two, NULL);
> +	cl_assert(ret == NULL);
> +}

We could avoid the separate variable here, e.g. like this:

void test_example_decorate__add(void)
{
	cl_assert_equal_p(add_decoration(&vars.n, vars.one, &vars.decoration_a), NULL);
	cl_assert_equal_p(add_decoration(&vars.n, vars.two, NULL), NULL);
}

The same is true for some of the other test, too.

The test itself could be a bit more thorough in verifying what has been
done, but that is not a new issue that your conversion introduces as the
old testcase was somewhat light on that, too. So this is nothing that I
think you need to change.

> +void test_example_decorate__readd(void)
> +{
> +	void *ret;
> +
> +	cl_assert(add_decoration(&vars.n, vars.one, &vars.decoration_a) == NULL);
> +	cl_assert(add_decoration(&vars.n, vars.two, NULL) == NULL);

Okay. This wasn't present before because tests were actually dependent
on the data that previous tests wrote. Now that we decouple the tests
from one another we have to make sure to recreate the expected setup.
Which I think is a good thing, as it makes tests fully self-contained
and the setup easier to understand.

I guess this is another thing that you should be explaining in the
commit message, as it is not obvious at all.

> +	ret = add_decoration(&vars.n, vars.one, NULL);
> +	cl_assert(ret == &vars.decoration_a);
> +	ret = add_decoration(&vars.n, vars.two, &vars.decoration_b);
> +	cl_assert(ret == NULL);
> +}
> +
> +void test_example_decorate__lookup(void)
> +{
> +	void *ret;
> +
> +	add_decoration(&vars.n, vars.two, &vars.decoration_b);
> +	add_decoration(&vars.n, vars.one, NULL);
> +
> +	ret = lookup_decoration(&vars.n, vars.two);
> +	cl_assert(ret == &vars.decoration_b);
> +	ret = lookup_decoration(&vars.n, vars.one);
> +	cl_assert(ret == NULL);
> +}
> +
> +void test_example_decorate__loop(void)
> +{
> +	int objects_noticed = 0;
> +
> +	add_decoration(&vars.n, vars.one, &vars.decoration_a);
> +	add_decoration(&vars.n, vars.two, &vars.decoration_b);
> +
> +	for (size_t i = 0; i < vars.n.size; i++) {
> +		if (vars.n.entries[i].base)
> +			objects_noticed++;
> +	}

Nit: we can get rid of the curly braces here.

> +	cl_assert_equal_i(objects_noticed, 2);
> +}
> +
> +void test_example_decorate__initialize(void)
> +{
> +	struct object_id one_oid = { { 1 } }, two_oid = { { 2 } }, three_oid = { { 3 } };
> +
> +	vars.one = lookup_unknown_object(the_repository, &one_oid);
> +	vars.two = lookup_unknown_object(the_repository, &two_oid);
> +	vars.three = lookup_unknown_object(the_repository, &three_oid);
> +}
> +
> +void test_example_decorate__cleanup(void)
> +{
> +	clear_decoration(&vars.n, NULL);
> +}

Let's move both `initialize()` and `cleanup()` to the top so that it
becomes easy to see that all tests use this commen setup.

Patrick
