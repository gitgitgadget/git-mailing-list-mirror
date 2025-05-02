Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A8C1EBFFF
	for <git@vger.kernel.org>; Fri,  2 May 2025 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179866; cv=none; b=Y5ZCMnQ7+YOF4KsP1nmgif7XaV46t8JDOmSt2bBPNVe1UK1zikED7jYkzEtxPBB9GUn4sbev3+9pVxhiASL2MlzYQ0nnuUw0xrm1g+1SFDbsMulPdrAafmmK/YqTmFFD50dP7BhmBWkOuzL/ZYzT+E7smR185+Tt+T2FBNfyv1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179866; c=relaxed/simple;
	bh=2jOd2Ok6UyS+X6JHKYcy1FkuITXxVaXTAdlISggqzl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uj0ohK/Fzcmqn3/JHQfVYpFwGVF5YQU8vCC0SA+cX27nC3NU6COKKpX+EdS8kYpBhhMRBxHHRNg1dth7iIqwus0Rt/ViBMlcyn0P/HWdvZGJsaCyWHb1Qcev33tazi+7QimryOQfNB733vqGIXj66IGRdBDiI9rE0jyw9X43ESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YY6SZjTe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QF8+Ld+r; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YY6SZjTe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QF8+Ld+r"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id D7C7E1380FF1;
	Fri,  2 May 2025 05:57:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 02 May 2025 05:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746179862; x=1746266262; bh=EVsHb9w0YC
	OryybaVxyIf8CbGAHeDX/1xoIzz7j9ZR8=; b=YY6SZjTe1TbdmwpNYi816z+Npp
	qyfYPASqP/py3t3gI9PtZ7MTqcuP/aT8kJsbo+zwHjk4O4x8PBjCsVj5Krw9iW1P
	XIjCGY4R3YHaX/fDDUJOFzXkqzEqbMoMJT7ht0e/gULU/wzjCzaY4pOfQz+YA9cn
	m+qNNSJuduMPRvrCdD01c2p9IISEm0XSvNYODrj4L/JJGar+8RShxBZCG3rRZ2ii
	hUCTLfmb+8WWZurEVKTwZLq/m3HP1YjrJbaEGT0kCPEIGUP1MQEDxwiGv4+zXnp3
	kX4nvpu2HMpkcgG5IfVZrDoVZs65wJL7PYYLemiPwv61eEcpAB9QYdxMLRZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746179862; x=1746266262; bh=EVsHb9w0YCOryybaVxyIf8CbGAHeDX/1xoI
	zz7j9ZR8=; b=QF8+Ld+rhDK+3RrK9aoNYsIBdjc9PP885oEpC1f+PzUlZn0KIH0
	i0qWX7rbJKOBj53CGoZazpxpt5M1y91SNsjbnN4tXn2VESswxpZ30ToGRzxmPy2Z
	5JcE4VvV2C3voXjZLkjjiyKpCWu6JnQbY7ma22YCbaUOL2lO71NuVkjJyRSfMMns
	shcKWqubucQWyxswZwlo4n8NAWNAp6X5ksriWG+Itup2SkngakPGh7CCu47cmSO2
	KiqteAw5AA3l/uhb0uzqTJJi0rjZRJCFkrLToBAWaW26y8R37pDJT1Cf+7DBdGEr
	B9wSPlgA8noKHUmyDhA5z4EG/GKiqZU1y3A==
X-ME-Sender: <xms:FpcUaHjc7V5vb8WqBuQ7VQQZpNbf0h0i9V8qV7EPI9Hyv4z5Chd2rw>
    <xme:FpcUaEDL8LXF_rfmfo15ByxcGbS2od--0cTXdDWx0BWYiXACj_moja-t5Ji_t1TYC
    5xWdK1znJSwTztWLw>
X-ME-Received: <xmr:FpcUaHFigqTVQdsuXvWy2dIKQhDhxsynxMrbxSPHi4mTjaCWXYvzkV_Vj7cStsXPwvE6zIH9WkQdixwAjYK9U0AKLZI-5plZ7bQY8wX75tc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepueeiueduhfevhfekiefgkefggeeljedtffetheeh
    tefhhfdvledukeekfffhffdvnecuffhomhgrihhnpehgohhoghhlvgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hkuhhfohhrihhjihelkeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FpcUaETcBDMhApdgMuSbtFHuY5UoouWxGKfR9A4muae5kF7Eicdq6Q>
    <xmx:FpcUaEyl6llS2uNJ6i-nyW3tGKhokIGpuuYix4aCsYIUYVCGf0VORA>
    <xmx:FpcUaK5FYeS4hcvaNe4iX5sli1MKuPjs7BeSxQdlRJgwXSmGdtbMAQ>
    <xmx:FpcUaJyQCjXiJ8uJUCDz8bkLJ31hPj-_Gk5G_0zXVr4yKmOfF9UWxg>
    <xmx:FpcUaP0op23H6fPEooEtRsNgdI16ZeH-_J8HoJwiIuOQhX9_H-BgMWxJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 05:57:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc5d61fc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 09:57:41 +0000 (UTC)
Date: Fri, 2 May 2025 11:57:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 02/10] t/unit-tests: convert reftable basics test to
 use clar test framework
Message-ID: <aBSXFNKU5JK1DgCv@pks.im>
References: <20250429175302.23724-1-kuforiji98@gmail.com>
 <20250429175302.23724-3-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429175302.23724-3-kuforiji98@gmail.com>

On Tue, Apr 29, 2025 at 06:52:54PM +0100, Seyi Kuforiji wrote:
> Adapt reftable basics test file to clar by using clar assertions
> where necessary.Break up test edge case to improve modularity and
> clarity.
> 
> Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> ---
>  Makefile                         |   2 +-
>  t/meson.build                    |   2 +-
>  t/unit-tests/t-reftable-basics.c | 219 -------------------------------
>  t/unit-tests/u-reftable-basics.c | 195 +++++++++++++++++++++++++++
>  4 files changed, 197 insertions(+), 221 deletions(-)
>  delete mode 100644 t/unit-tests/t-reftable-basics.c
>  create mode 100644 t/unit-tests/u-reftable-basics.c
> 
> diff --git a/Makefile b/Makefile
> index 13f9062a05..7b12bb078c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1362,6 +1362,7 @@ CLAR_TEST_SUITES += u-oid-array
>  CLAR_TEST_SUITES += u-oidmap
>  CLAR_TEST_SUITES += u-oidtree
>  CLAR_TEST_SUITES += u-prio-queue
> +CLAR_TEST_SUITES += u-reftable-basics
>  CLAR_TEST_SUITES += u-reftable-tree
>  CLAR_TEST_SUITES += u-strbuf
>  CLAR_TEST_SUITES += u-strcmp-offset
> @@ -1374,7 +1375,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
>  CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
>  CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
>  
> -UNIT_TEST_PROGRAMS += t-reftable-basics
>  UNIT_TEST_PROGRAMS += t-reftable-block
>  UNIT_TEST_PROGRAMS += t-reftable-merged
>  UNIT_TEST_PROGRAMS += t-reftable-pq
> diff --git a/t/meson.build b/t/meson.build
> index bfb744e886..8a42b595d9 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -8,6 +8,7 @@ clar_test_suites = [
>    'unit-tests/u-oidmap.c',
>    'unit-tests/u-oidtree.c',
>    'unit-tests/u-prio-queue.c',
> +  'unit-tests/u-reftable-basics.c',
>    'unit-tests/u-reftable-tree.c',
>    'unit-tests/u-strbuf.c',
>    'unit-tests/u-strcmp-offset.c',
> @@ -54,7 +55,6 @@ clar_unit_tests = executable('unit-tests',
>  test('unit-tests', clar_unit_tests)
>  
>  unit_test_programs = [
> -  'unit-tests/t-reftable-basics.c',
>    'unit-tests/t-reftable-block.c',
>    'unit-tests/t-reftable-merged.c',
>    'unit-tests/t-reftable-pq.c',
> diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-basics.c
> deleted file mode 100644
> index c9e751e49e..0000000000
> --- a/t/unit-tests/t-reftable-basics.c
> +++ /dev/null
> @@ -1,219 +0,0 @@
> -/*
> -Copyright 2020 Google LLC
> -
> -Use of this source code is governed by a BSD-style
> -license that can be found in the LICENSE file or at
> -https://developers.google.com/open-source/licenses/bsd
> -*/
> -
> -#include "test-lib.h"
> -#include "reftable/basics.h"
> -
> -struct integer_needle_lesseq_args {
> -	int needle;
> -	int *haystack;
> -};
> -
> -static int integer_needle_lesseq(size_t i, void *_args)
> -{
> -	struct integer_needle_lesseq_args *args = _args;
> -	return args->needle <= args->haystack[i];
> -}
> -
> -static void *realloc_stub(void *p UNUSED, size_t size UNUSED)
> -{
> -	return NULL;
> -}
> -
> -int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
> -{
> -	if_test ("binary search with binsearch works") {
> -		int haystack[] = { 2, 4, 6, 8, 10 };
> -		struct {
> -			int needle;
> -			size_t expected_idx;
> -		} testcases[] = {
> -			{-9000, 0},
> -			{-1, 0},
> -			{0, 0},
> -			{2, 0},
> -			{3, 1},
> -			{4, 1},
> -			{7, 3},
> -			{9, 4},
> -			{10, 4},
> -			{11, 5},
> -			{9000, 5},
> -		};
> -
> -		for (size_t i = 0; i < ARRAY_SIZE(testcases); i++) {
> -			struct integer_needle_lesseq_args args = {
> -				.haystack = haystack,
> -				.needle = testcases[i].needle,
> -			};
> -			size_t idx;
> -
> -			idx = binsearch(ARRAY_SIZE(haystack),
> -					&integer_needle_lesseq, &args);
> -			check_int(idx, ==, testcases[i].expected_idx);
> -		}
> -	}
> -
> -	if_test ("names_length returns size of a NULL-terminated string array") {
> -		const char *a[] = { "a", "b", NULL };
> -		check_int(names_length(a), ==, 2);
> -	}
> -
> -	if_test ("names_equal compares NULL-terminated string arrays") {
> -		const char *a[] = { "a", "b", "c", NULL };
> -		const char *b[] = { "a", "b", "d", NULL };
> -		const char *c[] = { "a", "b", NULL };
> -
> -		check(names_equal(a, a));
> -		check(!names_equal(a, b));
> -		check(!names_equal(a, c));
> -	}
> -
> -	if_test ("parse_names works for basic input") {
> -		char in1[] = "line\n";
> -		char in2[] = "a\nb\nc";
> -		char **out = parse_names(in1, strlen(in1));
> -		check(out != NULL);
> -		check_str(out[0], "line");
> -		check(!out[1]);
> -		free_names(out);
> -
> -		out = parse_names(in2, strlen(in2));
> -		check(out != NULL);
> -		check_str(out[0], "a");
> -		check_str(out[1], "b");
> -		check_str(out[2], "c");
> -		check(!out[3]);
> -		free_names(out);
> -	}
> -
> -	if_test ("parse_names drops empty string") {
> -		char in[] = "a\n\nb\n";
> -		char **out = parse_names(in, strlen(in));
> -		check(out != NULL);
> -		check_str(out[0], "a");
> -		/* simply '\n' should be dropped as empty string */
> -		check_str(out[1], "b");
> -		check(!out[2]);
> -		free_names(out);
> -	}
> -
> -	if_test ("common_prefix_size works") {
> -		struct reftable_buf a = REFTABLE_BUF_INIT;
> -		struct reftable_buf b = REFTABLE_BUF_INIT;
> -		struct {
> -			const char *a, *b;
> -			int want;
> -		} cases[] = {
> -			{"abcdef", "abc", 3},
> -			{ "abc", "ab", 2 },
> -			{ "", "abc", 0 },
> -			{ "abc", "abd", 2 },
> -			{ "abc", "pqr", 0 },
> -		};
> -
> -		for (size_t i = 0; i < ARRAY_SIZE(cases); i++) {
> -			check(!reftable_buf_addstr(&a, cases[i].a));
> -			check(!reftable_buf_addstr(&b, cases[i].b));
> -			check_uint(common_prefix_size(&a, &b), ==, cases[i].want);
> -			reftable_buf_reset(&a);
> -			reftable_buf_reset(&b);
> -		}
> -		reftable_buf_release(&a);
> -		reftable_buf_release(&b);
> -	}
> -
> -	if_test ("reftable_put_be64 and reftable_get_be64 work") {
> -		uint64_t in = 0x1122334455667788;
> -		uint8_t dest[8];
> -		uint64_t out;
> -		reftable_put_be64(dest, in);
> -		out = reftable_get_be64(dest);
> -		check_int(in, ==, out);
> -	}
> -
> -	if_test ("reftable_put_be32 and reftable_get_be32 work") {
> -		uint32_t in = 0x11223344;
> -		uint8_t dest[4];
> -		uint32_t out;
> -		reftable_put_be32(dest, in);
> -		out = reftable_get_be32(dest);
> -		check_int(in, ==, out);
> -	}
> -
> -	if_test ("reftable_put_be24 and reftable_get_be24 work") {
> -		uint32_t in = 0x112233;
> -		uint8_t dest[3];
> -		uint32_t out;
> -		reftable_put_be24(dest, in);
> -		out = reftable_get_be24(dest);
> -		check_int(in, ==, out);
> -	}
> -
> -	if_test ("put_be16 and get_be16 work") {
> -		uint32_t in = 0xfef1;
> -		uint8_t dest[3];
> -		uint32_t out;
> -		reftable_put_be16(dest, in);
> -		out = reftable_get_be16(dest);
> -		check_int(in, ==, out);
> -	}
> -
> -	if_test ("REFTABLE_ALLOC_GROW works") {
> -		int *arr = NULL, *old_arr;
> -		size_t alloc = 0, old_alloc;
> -
> -		check(!REFTABLE_ALLOC_GROW(arr, 1, alloc));
> -		check(arr != NULL);
> -		check_uint(alloc, >=, 1);
> -		arr[0] = 42;
> -
> -		old_alloc = alloc;
> -		old_arr = arr;
> -		reftable_set_alloc(NULL, realloc_stub, NULL);
> -		check(REFTABLE_ALLOC_GROW(arr, old_alloc + 1, alloc));
> -		check(arr == old_arr);
> -		check_uint(alloc, ==, old_alloc);
> -
> -		old_alloc = alloc;
> -		reftable_set_alloc(NULL, NULL, NULL);
> -		check(!REFTABLE_ALLOC_GROW(arr, old_alloc + 1, alloc));
> -		check(arr != NULL);
> -		check_uint(alloc, >, old_alloc);
> -		arr[alloc - 1] = 42;
> -
> -		reftable_free(arr);
> -	}
> -
> -	if_test ("REFTABLE_ALLOC_GROW_OR_NULL works") {
> -		int *arr = NULL;
> -		size_t alloc = 0, old_alloc;
> -
> -		REFTABLE_ALLOC_GROW_OR_NULL(arr, 1, alloc);
> -		check(arr != NULL);
> -		check_uint(alloc, >=, 1);
> -		arr[0] = 42;
> -
> -		old_alloc = alloc;
> -		REFTABLE_ALLOC_GROW_OR_NULL(arr, old_alloc + 1, alloc);
> -		check(arr != NULL);
> -		check_uint(alloc, >, old_alloc);
> -		arr[alloc - 1] = 42;
> -
> -		old_alloc = alloc;
> -		reftable_set_alloc(NULL, realloc_stub, NULL);
> -		REFTABLE_ALLOC_GROW_OR_NULL(arr, old_alloc + 1, alloc);
> -		check(arr == NULL);
> -		check_uint(alloc, ==, 0);
> -		reftable_set_alloc(NULL, NULL, NULL);
> -
> -		reftable_free(arr);
> -	}
> -
> -	return test_done();
> -}
> diff --git a/t/unit-tests/u-reftable-basics.c b/t/unit-tests/u-reftable-basics.c
> new file mode 100644
> index 0000000000..63dd568faf
> --- /dev/null
> +++ b/t/unit-tests/u-reftable-basics.c
> @@ -0,0 +1,195 @@
> +/*
> +Copyright 2020 Google LLC
> +
> +Use of this source code is governed by a BSD-style
> +license that can be found in the LICENSE file or at
> +https://developers.google.com/open-source/licenses/bsd
> +*/
> +
> +#include "unit-test.h"
> +#include "reftable/basics.h"
> +
> +struct integer_needle_lesseq_args {
> +	int needle;
> +	int *haystack;
> +};
> +
> +static int integer_needle_lesseq(size_t i, void *_args)
> +{
> +	struct integer_needle_lesseq_args *args = _args;
> +	return args->needle <= args->haystack[i];
> +}
> +
> +static void *realloc_stub(void *p UNUSED, size_t size UNUSED)
> +{
> +	return NULL;
> +}
> +
> +void test_reftable_basics__binsearch(void)
> +{
> +	int haystack[] = { 2, 4, 6, 8, 10 };
> +	struct {
> +		int needle;
> +		size_t expected_idx;
> +	} testcases[] = {
> +		{-9000, 0},
> +		{-1, 0},
> +		{0, 0},
> +		{2, 0},
> +		{3, 1},
> +		{4, 1},
> +		{7, 3},
> +		{9, 4},
> +		{10, 4},
> +		{11, 5},
> +		{9000, 5},
> +	};
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(testcases); i++) {
> +		struct integer_needle_lesseq_args args = {
> +			.haystack = haystack,
> +			.needle = testcases[i].needle,
> +		};
> +		size_t idx;
> +
> +		idx = binsearch(ARRAY_SIZE(haystack),
> +				&integer_needle_lesseq, &args);
> +		cl_assert_equal_i(idx, testcases[i].expected_idx);
> +	}
> +

Nit: empty newline can be removed.

> +}
> +
> +void test_reftable_basics__names_length(void)
> +{
> +	const char *a[] = { "a", "b", NULL };
> +	cl_assert_equal_i(names_length(a), 2);
> +}
> +
> +void test_reftable_basics__names_equal(void)
> +{
> +	const char *a[] = { "a", "b", "c", NULL };
> +	const char *b[] = { "a", "b", "d", NULL };
> +	const char *c[] = { "a", "b", NULL };
> +
> +	cl_assert(names_equal(a, a));
> +	cl_assert(!names_equal(a, b));
> +	cl_assert(!names_equal(a, c));
> +}
> +
> +void test_reftable_basics__parse_names(void)
> +{
> +	char in1[] = "line\n";
> +	char in2[] = "a\nb\nc";
> +	char **out = parse_names(in1, strlen(in1));
> +	cl_assert(out != NULL);
> +	cl_assert_equal_s(out[0], "line");
> +	cl_assert(!out[1]);
> +	free_names(out);
> +
> +	out = parse_names(in2, strlen(in2));
> +	cl_assert(out != NULL);
> +	cl_assert_equal_s(out[0], "a");
> +	cl_assert_equal_s(out[1], "b");
> +	cl_assert_equal_s(out[2], "c");
> +	cl_assert(!out[3]);
> +	free_names(out);
> +}
> +

I think you missed converting "parse_names drops empty string".

> +void test_reftable_basics__common_prefix_size(void)
> +{
> +	struct reftable_buf a = REFTABLE_BUF_INIT;
> +	struct reftable_buf b = REFTABLE_BUF_INIT;
> +	struct {
> +		const char *a, *b;
> +		int want;
> +	} cases[] = {
> +		{"abcdef", "abc", 3},
> +		{ "abc", "ab", 2 },
> +		{ "", "abc", 0 },
> +		{ "abc", "abd", 2 },
> +		{ "abc", "pqr", 0 },
> +	};
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(cases); i++) {
> +		reftable_buf_reset(&a);
> +		reftable_buf_reset(&b);
> +		cl_assert_equal_i(reftable_buf_addstr(&a, cases[i].a), 0);
> +		cl_assert_equal_i(reftable_buf_addstr(&b, cases[i].b), 0);
> +		cl_assert_equal_i(common_prefix_size(&a, &b), cases[i].want);

Why did you change the order of `reftable_buf_reset()` calls? The
reordered logic achieves the same result, but I'd recommend to keep
things as-is so that reviewers aren't puzzled by this arbitrary change.

> +	}
> +	reftable_buf_release(&a);
> +	reftable_buf_release(&b);
> +}

I miss tests for `put_be64` and `put_be32`.

> +void test_reftable_basics__put_get_be24(void)
> +{
> +	uint32_t in = 0x112233;
> +	uint8_t dest[3];
> +	uint32_t out;
> +	reftable_put_be24(dest, in);
> +	out = reftable_get_be24(dest);
> +	cl_assert_equal_i(in, out);
> +}
> +
> +void test_reftable_basics__put_get_be16(void)
> +{
> +	uint32_t in = 0xfef1;
> +	uint8_t dest[3];
> +	uint32_t out;
> +	reftable_put_be16(dest, in);
> +	out = reftable_get_be16(dest);
> +	cl_assert_equal_i(in, out);
> +}
> +
> +void test_reftable_basics__grow_alloc(void)

Let's rename this to `__alloc_grow()` to match the name of the function.

> +{
> +	int *arr = NULL, *old_arr;
> +	size_t alloc = 0, old_alloc;
> +
> +	cl_assert_equal_i(REFTABLE_ALLOC_GROW(arr, 1, alloc), 0);
> +	cl_assert(arr != NULL);
> +	cl_assert(alloc >= 1);
> +	arr[0] = 42;
> +
> +	old_alloc = alloc;
> +	old_arr = arr;
> +	reftable_set_alloc(NULL, realloc_stub, NULL);
> +	cl_assert(REFTABLE_ALLOC_GROW(arr, old_alloc + 1, alloc));
> +	cl_assert(arr == old_arr);
> +	cl_assert_equal_i(alloc, old_alloc);
> +
> +	old_alloc = alloc;
> +	reftable_set_alloc(NULL, NULL, NULL);
> +	cl_assert_equal_i(REFTABLE_ALLOC_GROW(arr, old_alloc + 1, alloc), 0);
> +	cl_assert(arr != NULL);
> +	cl_assert(alloc > old_alloc);
> +	arr[alloc - 1] = 42;
> +
> +	reftable_free(arr);
> +}
> +
> +void test_reftable_basics__grow_alloc_or_null(void)

Same here, let's rename to `alloc_grow_or_null`.

> +{
> +	int *arr = NULL;
> +	size_t alloc = 0, old_alloc;
> +
> +	REFTABLE_ALLOC_GROW_OR_NULL(arr, 1, alloc);
> +	cl_assert(arr != NULL);
> +	cl_assert(alloc >= 1);
> +	arr[0] = 42;
> +
> +	old_alloc = alloc;
> +	REFTABLE_ALLOC_GROW_OR_NULL(arr, old_alloc + 1, alloc);
> +	cl_assert(arr != NULL);
> +	cl_assert(alloc > old_alloc);
> +	arr[alloc - 1] = 42;
> +
> +	old_alloc = alloc;
> +	reftable_set_alloc(NULL, realloc_stub, NULL);
> +	REFTABLE_ALLOC_GROW_OR_NULL(arr, old_alloc + 1, alloc);
> +	cl_assert(arr == NULL);
> +	cl_assert_equal_i(alloc, 0);
> +	reftable_set_alloc(NULL, NULL, NULL);
> +
> +	reftable_free(arr);
> +}

Other than that this looks well-done to me, thanks!

Patrick
