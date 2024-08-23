Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC75A1885AE
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422353; cv=none; b=axTFUPcHJ5KJ5YsqL/5C3yWIChbQKC7uN6JAhfeldCtMfaqIA9Ei6RNP+IgsXQxSlGKf0otycX0FZiHr3w7mKm9qL6sLtAihP3/VGECvjW+lUxpk1ub5aC1DvVGA5Hf+T9EZ44AFM9DClhiF+3HsW2c5bAmG97Q+kiZtpiIreW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422353; c=relaxed/simple;
	bh=kReqhdC9fHrtuBJN28npWYo1I8e4oyxmsCOfpdFvDp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j52lhqFuBv/HPXmA71KEYgHucw4Q4pWP/B7rGVe0Tdi4tAH7nJxmI47qHuhe0S5ZjzToxcXKC15uBVmYvw10ImY+LuzPS5t7tlQ1X3eJn/uWoi5kLJ9qALsCgBw5if5l6uDZVI6q+U7ARb8STG5eovhbq4V/HAQyAICysZHTAQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cMgCjpZ8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YSwrNWru; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cMgCjpZ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YSwrNWru"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C05321151A09;
	Fri, 23 Aug 2024 10:12:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 23 Aug 2024 10:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724422350; x=1724508750; bh=EKONnRFhMq
	cqKItwUAI8RaGd2C21qBphzm8aqArBcoo=; b=cMgCjpZ8bn4wD7ICITnB+MwQDV
	C4QgFHPr+X4QBuJLrjgEzHYE45SId5b5iyhe4CpCxHaWuJHQxysRvOTUfVUsi/Qh
	vEGnsoUwcmOJ3tCov1pZ+forUJ/18SIP2OfYiY+Oh7nb0x3PhrO9WeVJJ6PbdtZX
	Mbm7K3UQhLuT2s969pceX5SXoM/JX+9ryaoRzHUJ+DNw2+Gf+E35F394G3aTOBjC
	egJM2DCQTRjnMZ/AqX33MY/8ckRMoUqmGBeHa/WR7SjpQ/h3OtxQZwomdj+T6XIe
	+GcpefqjCMwgGAqBRV7RDHcmJYfNm/XRNRkWs+hIvAAqyHb4v0XlOj0F1aJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724422350; x=1724508750; bh=EKONnRFhMqcqKItwUAI8RaGd2C21
	qBphzm8aqArBcoo=; b=YSwrNWrur8p6XMSmuYXmAZ1ZosgFgv2Me+ShiSeltoGT
	gi//xz53yDA5mJqJfMnZmIujY7CMqW0jhlFM5my8t1JtJbFtIg4T1Fgo9f64ut5c
	4PJvvmI6pgW9hg53RKABwnWGm8jhfLrhx8o3HmMk8wKV7J9RTWOhio/tOiU55fid
	qiPhRn5TVB+KVks76250pTliLF/MV09YcfDQNZh4zgVs9YKjbfQW/b/xZHN+9A+w
	fKTqvjewsATINXJZRzjgHKPfga0PtiuRN0Yt2Z1K5up4/4tCae18y9/dHqFXzWtv
	FRGAnLdLeyp8lPeNigc6HHsAgqdC4yTHe5qsPLBgrA==
X-ME-Sender: <xms:zpjIZj66Fi7YpjN1HLxnvGIy_4mK1IvdOprac_6fMOKOonK5BUofKg>
    <xme:zpjIZo4cH8gebD_ujcuzcZBX0kuUTRCZIQhA-g2td9rIn-hmh0Z0jvFoo37SZR6E-
    6kcSjEmD1Bz7aL3dw>
X-ME-Received: <xmr:zpjIZqcUL5e-ZPzzJ-Bsomit6NNPc4too84z3h2yNWf4y1_6BgbKBIXOyiMNPsjmWwa3mhF2hnkGLlysUyb7xYg_LqZdDhXUzCRQyvhHXTYdqYBDbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvvddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvght
X-ME-Proxy: <xmx:zpjIZkJBccyWNZtqVc7nz-_BPFk9Yr5olN9wG4UsZH8FywYLDMENFA>
    <xmx:zpjIZnLZ9W3RPLIpkW-Fd6669dSRaPQqq9bajLUOHWlU6bg5Hxb13g>
    <xmx:zpjIZtydCIW9HWQx8C4KZJMZsQNQ7SCPwxBiUDpFXdh0yZkmIJ1-Jg>
    <xmx:zpjIZjJw7CN641wmJa_i2I3dRpcjcgNGsTqXZA7aQNi59dvpYFBs9w>
    <xmx:zpjIZkETVRXe_dTHuz0HeL8DR4rfzstpoTZVkxFjGdZ6nEQiEj1RFouL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Aug 2024 10:12:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 56c06576 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Aug 2024 14:11:51 +0000 (UTC)
Date: Fri, 23 Aug 2024 16:12:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, karthik nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/10] reftable: fix reload with active iterators
Message-ID: <cover.1724420744.git.ps@pks.im>
References: <cover.1724080006.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724080006.git.ps@pks.im>

Hi,

this is the second version of my patch series that fixes issues in the
reftable libary caused by having concurrent readers and writers.

Changes compared to v1:

  - Remove a spurious change that renamed `init_reader()` to
    `reader_init()`. That function went away in the subsequent commit
    anyway.

  - Fix a typo in a commit message.

  - Fix some assertions in one of the added tests.

Thanks!

Patrick

Patrick Steinhardt (10):
  reftable/blocksource: drop malloc block source
  reftable/stack: inline `stack_compact_range_stats()`
  reftable/reader: rename `reftable_new_reader()`
  reftable/reader: inline `init_reader()`
  reftable/reader: inline `reader_close()`
  reftable/stack: fix broken refnames in `write_n_ref_tables()`
  reftable/reader: introduce refcounting
  reftable/reader: keep readers alive during iteration
  reftable/stack: reorder swapping in the reloaded stack contents
  reftable/stack: fix segfault when reload with reused readers fails

 reftable/block_test.c            |   3 +-
 reftable/blocksource.c           |  20 -----
 reftable/blocksource.h           |   2 -
 reftable/reader.c                | 149 ++++++++++++++++---------------
 reftable/reader.h                |   5 +-
 reftable/readwrite_test.c        |  85 +++++++++---------
 reftable/reftable-reader.h       |  19 ++--
 reftable/stack.c                 |  90 +++++++++++--------
 reftable/stack_test.c            | 116 +++++++++++++++++++++++-
 t/helper/test-reftable.c         |   4 +-
 t/unit-tests/t-reftable-merged.c |  10 +--
 11 files changed, 312 insertions(+), 191 deletions(-)

Range-diff against v1:
 1:  fee3d3523eb =  1:  fee3d3523eb reftable/blocksource: drop malloc block source
 2:  3c0cf2bf46f =  2:  3c0cf2bf46f reftable/stack: inline `stack_compact_range_stats()`
 3:  e658b372f04 !  3:  b4cf97bf758 reftable/reader: rename `reftable_new_reader()`
    @@ reftable/reader.c: int reftable_reader_print_blocks(const char *tablename)
      		goto done;
      
     
    - ## reftable/reader.h ##
    -@@ reftable/reader.h: struct reftable_reader {
    - 	struct reftable_reader_offsets log_offsets;
    - };
    - 
    --int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
    -+int reader_init(struct reftable_reader *r, struct reftable_block_source *source,
    - 		const char *name);
    - void reader_close(struct reftable_reader *r);
    - const char *reader_name(struct reftable_reader *r);
    -
      ## reftable/readwrite_test.c ##
     @@ reftable/readwrite_test.c: static void test_write_empty_table(void)
      
 4:  f628b7dafb9 !  4:  3b667097501 reftable/reader: inline `init_reader()`
    @@ reftable/reader.h: struct reftable_reader {
      	struct reftable_reader_offsets log_offsets;
      };
      
    --int reader_init(struct reftable_reader *r, struct reftable_block_source *source,
    +-int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
     -		const char *name);
      void reader_close(struct reftable_reader *r);
      const char *reader_name(struct reftable_reader *r);
 5:  4a9fe150427 =  5:  b129d8a8687 reftable/reader: inline `reader_close()`
 6:  4965402e7bf =  6:  e3b28709b5f reftable/stack: fix broken refnames in `write_n_ref_tables()`
 7:  fc0ed68d467 =  7:  6535d1ca9de reftable/reader: introduce refcounting
 8:  02682056288 !  8:  8d08c3bc515 reftable/reader: keep readers alive during iteration
    @@ Metadata
      ## Commit message ##
         reftable/reader: keep readers alive during iteration
     
    -    The lifetime of a table iterator may surive the lifetime of a reader
    +    The lifetime of a table iterator may survive the lifetime of a reader
         when the stack gets reloaded. Keep the reader from being released by
         increasing its refcount while the iterator is still being used.
     
    @@ reftable/stack_test.c: static void test_reftable_stack_compaction_concurrent_cle
     +	EXPECT(st2->merged->readers_len == 2);
     +	err = reftable_stack_compact_all(st2, NULL);
     +	EXPECT_ERR(err);
    ++	EXPECT(st2->merged->readers_len == 1);
     +
     +	/*
     +	 * Verify that we can continue to use the old iterator even after we
    @@ reftable/stack_test.c: static void test_reftable_stack_compaction_concurrent_cle
     +	 */
     +	err = reftable_stack_reload(st1);
     +	EXPECT_ERR(err);
    -+	EXPECT(st2->merged->readers_len == 1);
    ++	EXPECT(st1->merged->readers_len == 1);
     +	err = reftable_iterator_next_ref(&it, &rec);
     +	EXPECT_ERR(err);
     +	EXPECT(!strcmp(rec.refname, "refs/heads/branch-0000"));
 9:  d98316fbf4c =  9:  5aee91de25e reftable/stack: reorder swapping in the reloaded stack contents
10:  b777818ea99 = 10:  4a8d45cc9b4 reftable/stack: fix segfault when reload with reused readers fails
-- 
2.46.0.164.g477ce5ccd6.dirty

