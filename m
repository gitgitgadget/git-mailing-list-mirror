Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226C9184D
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 04:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140830; cv=none; b=P6Ko6Sw0pKWzkitsIXolxgCDpPuL+xnEK8KFUvtu9K85v41d8+RMCUaDIjH9jVU41K6hAY6V6fc4f+c2WNeegsRShU1367qnvQ2TTRm0cgu/HVFmfCEiUSTqSmJElGds+Ox0vuFkfcyrQpgj2O97di0Tybd0D8+HbB9N3vY5QwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140830; c=relaxed/simple;
	bh=Ujcyk+1TflnsT2eGvwA9nrSHrlAzVfryE3iEGGbGGmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkhpQlGE9yx7IRRxZ+pIaQpCj1OJzKNBFtpd8R+Zy0no1x8FGQIo+2kNYYQs5+snLDHmywLDJaRh+4TjfAgKtMSfDyZHwpzFKd6mDLFu0XyAJ9nomI0JKUub34Gw2F6pQ8P1vmYVEvJ0DiaQZMl5Ug1NDlxsJ2im8TBD9iCje1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EJiwOznm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YKZ9n4AL; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EJiwOznm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YKZ9n4AL"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2929D11400A6;
	Thu, 17 Oct 2024 00:53:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 17 Oct 2024 00:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729140827; x=1729227227; bh=+GVnEx94FB
	JDsCX8Tat8zJtNuAj6a8p7V1gLaKBSwV8=; b=EJiwOznm8BPlDsjkl1fhnVzeSg
	GQM2soQJ+86kQd1YzbsLh5ERqgIpf4jPH+ydMVcNd7sy32346YARoW5waFfQqngf
	HJtP0DqoP1nLLMRM5ppNWV9WwXresKaysdlxgCHiSn0UO5r4lhNZ9LUx5GUe/1Zy
	SxGh6jq9ok/bb1rjYAnKmpwi4pooJ6uxUjt4vuZiMNlt/xrDA4/lXCA+GX0PEXaZ
	rqeZcTuySIHorn+AXQLNmd0cokwRccRJ8+z8wUmNdqfy9lJBXqCr0HLsek4Ta4rX
	vXZClnPhaC90uPWD+nAZ/WJ0NTAkzqAXm43o3qeAQpCqJA/0HdsYyyPsYhLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729140827; x=1729227227; bh=+GVnEx94FBJDsCX8Tat8zJtNuAj6
	a8p7V1gLaKBSwV8=; b=YKZ9n4AL/fJsOj4yZGuwEb4DJpt/2IkSjvrShb5sggI6
	y6Y+CpTViDv6AHQEAILyPIZ2bb1AlOoA0UprBqXwProLDc/P1uHbj3M39G5FnrmS
	ejbvpfjIdWy1uueq6fneA5Scaft7imMorRTff7/DLuIOi5e20VtaEEVlpQVawPeU
	T9wcOdxDkauFe/5I0F4QsmkhJMiwXQxe5sWIlFI3654SfnnlC9klIRGS+10Ddw2t
	ZWLXeDOTLW9sSE9ZSWHH95uMcs95rIvzffnMG9AqxHRiVe25ZIO5gN0T/eaCkF2V
	iLey292kay31DquNkJhXYj7AxKk2aPLu8ckFJcgIWw==
X-ME-Sender: <xms:WpgQZwq1MMEsjj6z8wmT2vTtWTNR3-CLn4YzHQ4FZgPZB7aCwY54zA>
    <xme:WpgQZ2otkt0T3EYUHW8RjikUi40Xc8odyt66JLaBbIV-9CYCcNIUMPM41okSKSP3E
    yaa7tVIa06rU_BMhA>
X-ME-Received: <xmr:WpgQZ1PqIm257kRCed8Um06Xb2Kqy9BJYHKv5kLSA1P9z1XDXo4HNkHlyfBq6ZyZfTeQAyFmC78ddG3KU0rvyusY2gYWhb1l5zEXC55fZjDfdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehtddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthho
    pehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:WpgQZ37DyxlPJqwe7NJXHetz19oVDYgMbgacnG9l_f2L5pThKoZMRg>
    <xmx:WpgQZ_400cWDHuITMhG-CFWCG7herba25dxZgt7WRMpcTyB54k48Yg>
    <xmx:WpgQZ3hgvs7fZ94rBjmg6SGkzQJNmjHemtI7cvQlusxnRlJRw-iEAg>
    <xmx:WpgQZ550-IKzMcXE2ghyw3_20bwGuKp2T3VCCV-O85bj9aZpn4WZ1Q>
    <xmx:W5gQZ1Q8_ssgISIpKR4Jxpdlk9_exYmdfQ4DXWpB9KAXiSJKFDyqezNr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 00:53:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eaacea0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 04:52:25 +0000 (UTC)
Date: Thu, 17 Oct 2024 06:53:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, shejialuo <shejialuo@gmail.com>
Subject: [PATCH v3 00/10] reftable: stop using `struct strbuf`
Message-ID: <cover.1729140565.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728629612.git.ps@pks.im>

Hi,

this is the third version of my patch series that removes use of `struct
strbuf` in the reftable library. The intent of this is to convert the
reftable library back into a standalone library that can be used in the
context of libgit2.

Changes compared to v2:

  - Provide more context around why we get rid of `stbuf_addf()`.

  - Fix a commit message type.

  - Provide better docs for `reftable_buf_add()`.

Thanks!

Patrick

Patrick Steinhardt (10):
  reftable: stop using `strbuf_addbuf()`
  reftable: stop using `strbuf_addf()`
  reftable/basics: provide new `reftable_buf` interface
  reftable: convert from `strbuf` to `reftable_buf`
  reftable/blocksource: adapt interface name
  t/unit-tests: check for `reftable_buf` allocation errors
  reftable/stack: adapt `format_name()` to handle allocation failures
  reftable/record: adapt `reftable_record_key()` to handle allocation
    failures
  reftable/stack: adapt `stack_filename()` to handle allocation failures
  reftable: handle trivial `reftable_buf` errors

 reftable/basics.c                   |  76 +++++++++-
 reftable/basics.h                   |  61 +++++++-
 reftable/block.c                    |  61 +++++---
 reftable/block.h                    |  14 +-
 reftable/blocksource.c              |  30 ++--
 reftable/blocksource.h              |   5 +-
 reftable/iter.c                     |   9 +-
 reftable/iter.h                     |   8 +-
 reftable/reader.c                   |  27 ++--
 reftable/record.c                   | 114 ++++++++------
 reftable/record.h                   |  21 +--
 reftable/stack.c                    | 221 ++++++++++++++++++----------
 reftable/system.h                   |   1 -
 reftable/writer.c                   | 102 ++++++++-----
 reftable/writer.h                   |   2 +-
 t/unit-tests/lib-reftable.c         |   4 +-
 t/unit-tests/lib-reftable.h         |   7 +-
 t/unit-tests/t-reftable-basics.c    |  16 +-
 t/unit-tests/t-reftable-block.c     |  53 +++----
 t/unit-tests/t-reftable-merged.c    |  32 ++--
 t/unit-tests/t-reftable-reader.c    |  12 +-
 t/unit-tests/t-reftable-readwrite.c | 134 +++++++++--------
 t/unit-tests/t-reftable-record.c    |  74 +++++-----
 t/unit-tests/t-reftable-stack.c     |  96 ++++++------
 24 files changed, 728 insertions(+), 452 deletions(-)

Range-diff against v2:
 1:  7408482c152 =  1:  7408482c152 reftable: stop using `strbuf_addbuf()`
 2:  6a7333b275e !  2:  634fd3c35f5 reftable: stop using `strbuf_addf()`
    @@ Commit message
         reftable: stop using `strbuf_addf()`
     
         We're about to introduce our own `reftable_buf` type to replace
    -    `strbuf`. Get rid of the seldomly-used `strbuf_addf()` function such
    -    that we have to reimplement one less function.
    +    `strbuf`. One function we'll have to convert is `strbuf_addf()`, which
    +    is used in a handful of places. This function uses `snprintf()`
    +    internally, which makes porting it a bit more involved:
    +
    +      - It is not available on all platforms.
    +
    +      - Some platforms like Windows have broken implementations.
    +
    +    So by using `snprintf()` we'd also push the burden on downstream users
    +    of the reftable library to make available a properly working version of
    +    it.
    +
    +    Most callsites of `strbuf_addf()` are trivial to convert to not using
    +    it. We do end up using `snprintf()` in our unit tests, but that isn't
    +    much of a problem for downstream users of the reftable library.
     
         While at it, remove a useless call to `strbuf_reset()` in
         `t_reftable_stack_auto_compaction_with_locked_tables()`. We don't write
 3:  0ddc8c0c896 !  3:  53c5f667f28 reftable/basics: provide new `reftable_buf` interface
    @@ Commit message
             to make things work, which is not all that sensible.
     
           - The `strbuf` interface does not use the pluggable allocators that
    -        can be set up via `refatble_set_alloc()`.
    +        can be set up via `reftable_set_alloc()`.
     
         So we have good reasons to use our own type, and the implementation is
         rather trivial. Implement our own type. Conversion of the reftable
 4:  e1ff1af1f30 !  4:  7c7ccc5d966 reftable: convert from `strbuf` to `reftable_buf`
    @@ reftable/basics.c: int names_equal(const char **a, const char **b)
      	for (; p < a->len && p < b->len; p++) {
     
      ## reftable/basics.h ##
    +@@ reftable/basics.h: int reftable_buf_setlen(struct reftable_buf *buf, size_t len);
    + int reftable_buf_cmp(const struct reftable_buf *a, const struct reftable_buf *b);
    + 
    + /*
    +- * Add the given bytes to the buffer. Returns 0 on success,
    ++ * Append `len` bytes from `data` to the buffer. This function works with
    ++ * arbitrary byte sequences, including ones that contain embedded NUL
    ++ * characters. As such, we use `void *` as input type. Returns 0 on success,
    +  * REFTABLE_OUT_OF_MEMORY_ERROR on allocation failure.
    +  */
    + int reftable_buf_add(struct reftable_buf *buf, const void *data, size_t len);
     @@ reftable/basics.h: char *reftable_strdup(const char *str);
      #endif
      
 5:  fe8c9ace463 =  5:  f9632860933 reftable/blocksource: adapt interface name
 6:  8c98745233a =  6:  d850a2fe7d0 t/unit-tests: check for `reftable_buf` allocation errors
 7:  1f08163009b =  7:  8f8e2ca3962 reftable/stack: adapt `format_name()` to handle allocation failures
 8:  5798d76d7a4 =  8:  268e4cd6fc6 reftable/record: adapt `reftable_record_key()` to handle allocation failures
 9:  a9582d51dd1 =  9:  245a428842a reftable/stack: adapt `stack_filename()` to handle allocation failures
10:  90819c90f38 = 10:  4b51ea4b628 reftable: handle trivial `reftable_buf` errors
-- 
2.47.0.72.gef8ce8f3d4.dirty

