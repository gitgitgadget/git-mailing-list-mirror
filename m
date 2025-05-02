Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD41723958D
	for <git@vger.kernel.org>; Fri,  2 May 2025 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179882; cv=none; b=N+keqL/f/WtDvh8++ON+EfI+4hcDvDiJPM0woEYCTXzjgKTxtp9bad1a15TNyPGxSmcsWH/GmWokE+OopkLyI06fbsGgcGVGP9x2Lp4mAcEef5DbwezjT71wW6sf9HxyOFJ4U/N63wnw1OXzaTUgHSqoli/e9DJhlCA6R0OYfsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179882; c=relaxed/simple;
	bh=omt2oAKvfbwGwxnK9NlgnuPCcoOjzVnWAuu/wm9uzrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYT8H/AZAhEgT15G8mfqnFK2t9y/6yuz7lHLWpbHyFxGUnfN9sFzInAYWrmBDy90F4a1adEwgTzKozW0JpoTyt/B2gxcVC3YULWznpzzbOkJx98fns4gWvHEbX+xWF64qYk76rBGv7oKUxtOMwRTfMrWLcOeTGzZ5aLJuV2U1wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rhN8OQd7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UIR6BeHJ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rhN8OQd7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UIR6BeHJ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id DAB8D1380FEE;
	Fri,  2 May 2025 05:57:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 02 May 2025 05:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746179879; x=1746266279; bh=g+qFFoPF37
	KjHH0QXBwYtKkwK7ias5+yA0Yn1Qd6xmA=; b=rhN8OQd7mp5b+p9VMo2JZSsFOm
	l6l+tIVL2mzAJ29ldP6Wr2OaAT9umAyyUOv2sHohXXQU6kH5+KldPJGGWgYvweze
	BY5J2+TmrzBBCLOFdVLTD8WkSkyUblXf3cEZKj0G/zbo/bRuzCSLq1heqzjCA3mR
	rB0zhE8mOC++npFnpMYLglgEU5zEXGUK+Tvx/8JeH8QqwgNx7mOOzr5eYNkB7aCc
	LBtjQOo7Gs3+nQzfHmWl0yWJqq9929aa+SOjpNRp1MxQH0rEB/Pav8PwrLXGYLRz
	uzLso7LLq863VL/uOv40GyIs4nTSHqML2jsiK7dKKwmTkv1L9TWOyOxg6OjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746179879; x=1746266279; bh=g+qFFoPF37KjHH0QXBwYtKkwK7ias5+yA0Y
	n1Qd6xmA=; b=UIR6BeHJOo1qXgBKNH7gmAuEKyHYicpEKKza1bCY8YlRm5NH1vV
	o1MeYVxqqbZ7BdE28jijyGlXnt9LQfW4ivI9ueviuJ+qkf/CRrIH2+E8qtjv5saF
	jgkcCEPlTYOYsVjpTGxM4wO8cQE9od1QsyHiZpy8wQ9I02P7QeYHMDQCOYzmRCt9
	PulaYrT0+9BKfcWyIvvoA8fY3dMjHoCxneW3ykqcuL5t9mXrskJJQDldSsYaJzH5
	kOtsajSXgOXqKw1FL4Xu0Jc0OAaJ4dCC5Sfii3ZA/VLA3Z26iyrlFedX6wR7ZD+D
	rqCzn75R9Iv5wFuMOp6CLJXwO89DLXxlDow==
X-ME-Sender: <xms:J5cUaNAwMtA5nTMypCozQysZA0vw7d9LX-0hJpsWTUeHP5LQyELLTw>
    <xme:J5cUaLjE72Tst6jZUdxjjVff6D3U8vi1GCOSYC6SwOzxFeFOq9AKqYEhA1glYdyIs
    KHFFmSj_1fznjBWGQ>
X-ME-Received: <xmr:J5cUaIlq1EUoQkj49_6rUXw5I2dCzaLhVb6dxuW9Rb4UemMnmEmA4hsh_1I6Hi0dj3navfRV3q-JRe4EF5K2n02RNHGNnTV_5WcCXu1bbVc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdp
    rhgtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:J5cUaHzeV9w_x5eK9P-8bGvnlUxtiFufQOuTNjh7xtVEE7f-8RDzqA>
    <xmx:J5cUaCTn4KENUfhxXkCeoVZesmwU88b8YGtWMWR7j4Maj0-YRX5iZQ>
    <xmx:J5cUaKZeg8rPAjMeBTgtYG4z9PEAgBgpFULHiwPG-0lvits3FaKG8w>
    <xmx:J5cUaDQCnuhMSgDAs5bZsbtVmik78O5uNAga0RuZtbwxsH6ZaalUdA>
    <xmx:J5cUaHUfq2BO8dUdkZnC0_RVs3zhzv-E1BXtWQCQS-uNAD9cIIlBGgrV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 05:57:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dff69b3d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 09:57:58 +0000 (UTC)
Date: Fri, 2 May 2025 11:57:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 10/10] t/unit-tests: adapt lib-reftable{c,h} helper
 functions to clar
Message-ID: <aBSXJcT8REHWrsrx@pks.im>
References: <20250429175302.23724-1-kuforiji98@gmail.com>
 <20250429175302.23724-11-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429175302.23724-11-kuforiji98@gmail.com>

On Tue, Apr 29, 2025 at 06:53:02PM +0100, Seyi Kuforiji wrote:
> Helper functions defined in `t/unit-tests/lib-reftable.{c,h}` are
> required for the reftable-related test files to run efficeintly. In the
> current implementation these functions are designed to conform with our
> homegrown unit-testing structure. So in other to convert the reftable
> test files, there is need for a clar specific implementation of these
> helper functions.
> 
> type cast `for (size_t i = 0; i < (size_t)stats->ref_stats.blocks; i++)`
> Adapt functions in lib-reftable.{c,h} to use clar. These functions
> conform with the clar testing framework and become available for all
> reftable-related test files implemented using the clar testing
> framework, which requires them. This change migrates the helper
> functions back into `lib-reftable.{c,h}`.
> 
> Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> ---
>  Makefile                    |  4 +-
>  t/meson.build               |  4 +-
>  t/unit-tests/lib-reftable.c | 26 +++++------
>  t/unit-tests/lib-reftable.h |  6 +--
>  t/unit-tests/unit-test.c    | 93 -------------------------------------
>  t/unit-tests/unit-test.h    | 16 -------
>  6 files changed, 20 insertions(+), 129 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 0b42893611..7e646e16ee 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1379,12 +1379,12 @@ CLAR_TEST_SUITES += u-urlmatch-normalization
>  CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
>  CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
>  CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
> -CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
>  CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
> +CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
> +CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
>  
>  UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
>  UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
> -UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
>  

`UNIT_TEST_PROGS` only contains the "unit-test" binary now, right? Does
this mean that we can simplify build rules in our Makefile now?

> diff --git a/t/meson.build b/t/meson.build
> index 8fa00fc9ef..7c305a90b5 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -26,8 +26,9 @@ clar_test_suites = [
>  
>  clar_sources = [
>    'unit-tests/clar/clar.c',
> +  'unit-tests/lib-oid.c',
> +  'unit-tests/lib-reftable.c',
>    'unit-tests/unit-test.c',
> -  'unit-tests/lib-oid.c'
>  ]
>  
>  clar_decls_h = custom_target(
> @@ -69,7 +70,6 @@ foreach unit_test_program : unit_test_programs
>    unit_test = executable(unit_test_name,
>      sources: [
>        'unit-tests/test-lib.c',
> -      'unit-tests/lib-reftable.c',
>        unit_test_program,
>      ],
>      dependencies: [libgit_commonmain],

Can't we remove this completely? `unit_test_programs` is empty now, so
this loop is a no-op now.

> diff --git a/t/unit-tests/lib-reftable.h b/t/unit-tests/lib-reftable.h
> index e4c360fa7e..2958db5dc0 100644
> --- a/t/unit-tests/lib-reftable.h
> +++ b/t/unit-tests/lib-reftable.h
> @@ -6,12 +6,12 @@
>  
>  struct reftable_buf;
>  
> -void t_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id);
> +void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id);
>  
> -struct reftable_writer *t_reftable_strbuf_writer(struct reftable_buf *buf,
> +struct reftable_writer *cl_reftable_strbuf_writer(struct reftable_buf *buf,
>  						 struct reftable_write_options *opts);
>  
> -void t_reftable_write_to_buf(struct reftable_buf *buf,
> +void cl_reftable_write_to_buf(struct reftable_buf *buf,
>  			     struct reftable_ref_record *refs,
>  			     size_t nrecords,
>  			     struct reftable_log_record *logs,

It is quite weird that we declare the replacement functions in
"unit-test.h" in the first commit only to remove them at a later point.
It would make way more sense if we introduced the functions in
"t/unit/lib-reftable.{c,h}" right from the start and then only remove
the unused functions in the last step.

Patrick
