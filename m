Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A652C15B7
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368126; cv=none; b=qAu+9OmJmSDwoPOwtKEmjfSQgKfZm6dJOlU5TZhOdTdP/9ggIXvVettCQv76lcfKFvrCl6Cr+kUuFzE2gXE5PiXKvqBeQVhL4sDC8YzD1zedrtdU0SkyS0fLSH+e78U7dkTiJFmsw2w4vNvBaK/dypHZrk0vqM7c7bvXHUY3g1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368126; c=relaxed/simple;
	bh=iuT3OZ87kOJrs8ZoR+FDM2KZAz4/YlauHEf0V/exnpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbGmDsKQG2ZO2w17HbM+ZqkYIul1eQCJlEBWbM9nls5OgK4Maqvai091HxwSZtBc5a0ELCOwQFlHuS3WIHgFlOy8bOdMicvjeQxsAXbrb23YxpNaA5GIKRanYw0Muan+Dt85wKZuzziwQpujKyTpILAnI0QM4Mj52RdYwtx0U6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vttQm0oZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lPpZBAeY; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vttQm0oZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lPpZBAeY"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2AEDD7A01F0;
	Thu, 24 Jul 2025 10:42:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 24 Jul 2025 10:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753368123; x=1753454523; bh=b8liHMyGqO
	9Xo3/qhl3pSRMBd73aktU7M3MFSnHtYnc=; b=vttQm0oZLWvUAO09efH6nzj5th
	SD1khNGa9uzfEx3VS1l1bW86V73XmmJu8i80pcJkI/nrincZg0GyByWE+pYIo8hm
	fYHs7Af8TYuz2hiaEAiM+J4RzOynpOzIc6aLD3cJiNRlsJs/wcmb0EatJffJRAH7
	geSSAjegNin6GcXEqBoY0otIyjxdpPMOWYAFuwQl294Ro6hPanyqn5vzLduAcCUa
	rGem3nJTtrvn4rm/vZe9YKVBIGcBNDN5efs2Mp6LKZPhLl8EXDbXCUyXiXO786UB
	b4mC4rrgqh00MM3y4MgKM4JYt8WwOVSnbfMmFV80ogtbzwAPwn2BFoGUSGcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753368123; x=1753454523; bh=b8liHMyGqO9Xo3/qhl3pSRMBd73aktU7M3M
	FSnHtYnc=; b=lPpZBAeY2+68tFNEzv/CKgOomIvzUQc/P3cDvmg0myM3j9ETf6W
	5Hs2V47Ovk9tee4XJiFYknuG0X9XpVDSknPrexKDm0jpSZT5VJyKxFL/qUEtsPzl
	XM00mJZWnxN5GBdrg1kS5SzO7oTidCjAaKVyuEADd6rtjsb/YLPuZyZ71E3imHg0
	Hdmx5SqbaDv7AWLdYY9SWSTGZh/KQGy5KKZhUJfEUaOXlw+YgAHBxdf88NxX6mUs
	njq6pVRa7jWhW4r5dpzj9MO4mDeiqOv1bSoueN78fZolvs7wv/RKRkCHl7T5pPWj
	/oRNysjkAZ9vPYfa48saFF45qEFR8wPu4YA==
X-ME-Sender: <xms:OkaCaK-YATvMVM8vc99gingmY5oK27Wcm3Im0egtxEkEjZXuf4vSbA>
    <xme:OkaCaBm4kHxQR8H9bduG6nHs_edLNJKJFX_EhlzBwH8m2igj_iDYHvdt84QpSGy-L
    OEPQsAkDo09LfDJmg>
X-ME-Received: <xmr:OkaCaM9Zon7027b872jtwLsNWvlXClt__hXY3drbcxJt-78M-FfCc-x80DY-NhX03TX_gJX6eDQfOzMjCXynB9z_meVUvFpb5KUekO9eQp8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdektdelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomhdprhgtphhtth
    hopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:OkaCaPlAd4J2A6njHnlGw8eWcXrG2HvsfWBS1xuDi15qGitk7M3BtA>
    <xmx:OkaCaJ0g4eeqPAdDyleR9oeay40y81ylXxmNvCLToXZqa7mTo9HDQw>
    <xmx:OkaCaKr-zaKellUiWWcnPPzs_DpmvUpkYw48WKe1szwm-bVntbD7rA>
    <xmx:OkaCaGc4Wm6iL-bNCdsFEYZIwsKlkKNvm8mqQu-EVej03lirxXl4Rg>
    <xmx:O0aCaEMWqB1xJmSMSxk_lknxHdKI6t7z7SYdUfqLoGsGI5JQjHn20EGU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 10:42:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ede0dd19 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Jul 2025 14:41:59 +0000 (UTC)
Date: Thu, 24 Jul 2025 16:41:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kufoiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 00/10] t/unit-tests: convert unit-tests to use clar
Message-ID: <aIJGNGxhkz9CESFu@pks.im>
References: <20250605140644.239199-1-kuforiji98@gmail.com>
 <20250724142837.67149-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724142837.67149-1-kuforiji98@gmail.com>

On Thu, Jul 24, 2025 at 03:28:27PM +0100, Seyi Kufoiji wrote:
> Range-diff against v4:
>  -:  ---------- >  1:  4a04557ae3 t/unit-tests: implement clar specific reftable test helper functions
>  -:  ---------- >  2:  2c576ddd11 t/unit-tests: convert reftable basics test to use clar test framework
>  -:  ---------- >  3:  04d54fef89 t/unit-tests: convert reftable block test to use clar
>  -:  ---------- >  4:  06eba27f8e t/unit-tests: convert reftable merged test to use clar
>  -:  ---------- >  5:  eaa8b8d636 t/unit-tests: convert reftable pq test to use clar

Something here went wrong. :) But the remainder of the range-diff looks
exactly like I'd expect it to:

  - The Meson change gets moved to the correct commit.

  - The missing newline got fixed up.

Thanks!

Patrick

>  1:  7c159bd2fe !  6:  cf8b0471fd t/unit-tests: convert reftable table test to use clar
>     @@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
>       UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
>       UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
>       UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
>     -@@ Makefile: $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
>     - 	$(OBJCOPY) --localize-hidden $^ $@
>     - 
>     - contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
>     --	$(AR) $(ARFLAGS) $@ $^
>     -+	$(AR) $(ARFLAGS) $@ $^
>     - \ No newline at end of file
>      
>       ## t/meson.build ##
>      @@ t/meson.build: clar_test_suites = [
>  2:  3ae3b2cf9c =  7:  cbe70c5c23 t/unit-tests: convert reftable readwrite test to use clar
>  3:  d4303eb913 !  8:  38e2198eac t/unit-tests: convert reftable record test to use clar
>     @@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
>       UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
>      
>       ## t/meson.build ##
>     +@@ t/meson.build: clar_test_suites = [
>     +   'unit-tests/u-reftable-merged.c',
>     +   'unit-tests/u-reftable-pq.c',
>     +   'unit-tests/u-reftable-readwrite.c',
>     ++  'unit-tests/u-reftable-record.c',
>     +   'unit-tests/u-reftable-table.c',
>     +   'unit-tests/u-reftable-tree.c',
>     +   'unit-tests/u-strbuf.c',
>      @@ t/meson.build: clar_unit_tests = executable('unit-tests',
>       test('unit-tests', clar_unit_tests)
>       
>  4:  df582f6e2c !  9:  8de9dbbd3b t/unit-tests: convert reftable stack test to use clar
>     @@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
>      
>       ## t/meson.build ##
>      @@ t/meson.build: clar_test_suites = [
>     -   'unit-tests/u-reftable-merged.c',
>         'unit-tests/u-reftable-pq.c',
>         'unit-tests/u-reftable-readwrite.c',
>     -+  'unit-tests/u-reftable-record.c',
>     +   'unit-tests/u-reftable-record.c',
>      +  'unit-tests/u-reftable-stack.c',
>         'unit-tests/u-reftable-table.c',
>         'unit-tests/u-reftable-tree.c',
>  5:  9340e7ce88 ! 10:  a69c3370ee t/unit-tests: finalize migration of reftable-related tests
>     @@ Makefile: CLAR_TEST_SUITES += u-urlmatch-normalization
>       
>       # xdiff and reftable libs may in turn depend on what is in libgit.a
>       GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
>     -@@ Makefile: $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
>     - 	$(OBJCOPY) --localize-hidden $^ $@
>     - 
>     - contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
>     --	$(AR) $(ARFLAGS) $@ $^
>     - \ No newline at end of file
>     -+	$(AR) $(ARFLAGS) $@ $^
>      
>       ## t/Makefile ##
>      @@ t/Makefile: check-meson:
> -- 
> 2.43.0
> 
