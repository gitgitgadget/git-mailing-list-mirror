Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588E11514CB
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910947; cv=none; b=Hoz8D0yjvjUth5dDb5kT2935HCm7/j7kwbjRFCMn1CYHco9BY0DeHZxTLo9P3cVHObulypoKCXe4n8hDGb7TEWdI1UDcHo+WFbiZUvAlUGyZZCFq2gPStW0LVd05UVNCHYPDVeKwbMDpGIJPO1arJqIQbvRDrHuDgnMvcRqAKsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910947; c=relaxed/simple;
	bh=A5KxsFFYwUFWxR2D8LZ9P+yjfCcJm8Q3YaxBGUBe50Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5TXSTUo4lC2oP9p9JBK/X/YI1NlZTscKzdUr+zuOymHcmEqmc0aEeHhlI7Yi6w3r5E0yf+RHBWSVq/kuBRNNBM9r8rULPJ8a3REj4/4BBGgnOpGmlc8r//qXgaqbaMd64C8ycBW/QUxa4t6DItvXt0dJBJSuPbQSc5juaRejE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oSqWbPoR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fo+7O2yR; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oSqWbPoR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fo+7O2yR"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 305941380225;
	Mon, 14 Oct 2024 09:02:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 14 Oct 2024 09:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728910944; x=1728997344; bh=r0cuxEPRkt
	69p5wTWPKCnDzwb1IK3PGPRIVHdSqfaGU=; b=oSqWbPoRH2Diw6/xkpJ/RTCAw7
	GximwyhJbjioofnPK1EG2Q/fB+g06TgcAxbvw2SZ6sTjMYp9jvCmrtMmr5Hnob3n
	BdhSNA0+YCJNT7QivZtIDC8BZPbkVHDvuGgM2A3N54xTAeKhvpYaGaw5wP88q13n
	SU5svsyLYHJzVkN1n+oaIhJnaCkEgfpUYt7WrAygqvvwQwdbrrBFBboXWpX0h1lT
	0A6tuTGDRO/SMp+ej8F2q9bqpU/30Z4m51pn2hzQ6V/t7SPAR86ttYaccMzlqQkP
	yPuZ211SAySjwaPnam44USxpsDBgYSdoWXKM2ie6Fkmc2DYKmKFtQOKY0xIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728910944; x=1728997344; bh=r0cuxEPRkt69p5wTWPKCnDzwb1IK
	3PGPRIVHdSqfaGU=; b=fo+7O2yRwRtu4tXwVMXq5EosCE2600gh9pBSpYLN+vdd
	k5cy8D5WKDzaIuhKY4QNECKFTnWl/L4sRiKu7JazJuiSNu8pzvpJutMI7EA2ffb8
	5GQ0nE1KXPid1y1NnqJSp3YW9bZMBVaC+MKZna8Hp82rJMCjAlh877TuvIiWJmE+
	anX4CEvp3TmYR4jHHK/xKsnzxENgpuRRCzQgebEr4y/zGN66MnzJ3ymgnVciOvYF
	QES10O06d0ZTg/Qyw2qysEXC2VzWPWScDmaxPYGUOnaNu0frfC5cFuedSdeK1KE7
	4Kkb+SK2cc5WcaQssMadXR6plY0ZpRuoJI2CNKiBtg==
X-ME-Sender: <xms:XxYNZ0RFroPDV1QnF32HiqsyJv1J147pODFn3lUkWm3Sz6K_EDyThA>
    <xme:XxYNZxyyFL6e7HU80QkzTHsik8fx0NTtJzUrUpQNg_lfhynzb7aTg_MGJYwcyyBk_
    UQfRQ7EHLbc8yNbVg>
X-ME-Received: <xmr:XxYNZx1WBfiFrilf-Ld4s97xiEWne1PAs_8aUsfyYw59VTdu0oZs1sp_dHR1z7SVrf3a9_mWdSdyHLh1iij8meuD_t2jznqZIrnoOUWYxlqZOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:XxYNZ4AkQzO5KBHHnROYOb32nSRcqvJNAFshWw6_7cyYb46hw2NWSg>
    <xmx:XxYNZ9hOpQgXWB6qs6J5xH5Ctm1uYs7GyjJoGbqTmVXSBvPF3tQ95A>
    <xmx:XxYNZ0o-P7MKiko2r2To0cRBjSx7tSCOzgYgIbzkLR4uzVdUGOVsgA>
    <xmx:XxYNZwiTuS7QV-ZJ17rp-FCjPzx8btrOeiyCTEzIv1O29T5U4YbzUQ>
    <xmx:YBYNZytjMT9GVAEd9nwUxDpdUgOqM_EipRTKJPkw97YnrOI92GTdy-7S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 09:02:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ca18704e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 13:01:05 +0000 (UTC)
Date: Mon, 14 Oct 2024 15:02:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 00/10] reftable: stop using `struct strbuf`
Message-ID: <cover.1728910726.git.ps@pks.im>
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

this is the second part of my patch series that stop using `struct
strbuf` in the reftable library. This is done such that the reftable
library becomes standalone again and so that we can use the pluggable
allocators part of the library.

Changes compared to v1:

  - Point out a while-at-it refactoring when getting rid of
    `strbuf_addf()`.

  - Fix grammar issue in another commit message.

  - Use REFTABLE_OUT_OF_MEMORY_ERROR error codes on allocation failure.

  - Add documentation for `struct reftable_buf` functions.

  - Clarify that the conversion to use the new interface is not wholly
    mechanical via sed(1).

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
 reftable/basics.h                   |  59 +++++++-
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
 24 files changed, 726 insertions(+), 452 deletions(-)

Range-diff against v1:
 1:  7408482c152 =  1:  7408482c152 reftable: stop using `strbuf_addbuf()`
 2:  abc28d7664f !  2:  6a7333b275e reftable: stop using `strbuf_addf()`
    @@ Commit message
         `strbuf`. Get rid of the seldomly-used `strbuf_addf()` function such
         that we have to reimplement one less function.
     
    +    While at it, remove a useless call to `strbuf_reset()` in
    +    `t_reftable_stack_auto_compaction_with_locked_tables()`. We don't write
    +    to the buffer before this and initialize it with `STRBUF_INIT`, so there
    +    is no need to reset anything.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## reftable/stack.c ##
 3:  24e31619b93 !  3:  0ddc8c0c896 reftable/basics: provide new `reftable_buf` interface
    @@ Commit message
     
           - The `strbuf` interfaces do not handle memory allocation failures and
             instead causes us to die. This is okay in the context of Git, but is
    -        not context of the reftable library, which is supposed to be usable
    -        by third-party applications.
    +        not in the context of the reftable library, which is supposed to be
    +        usable by third-party applications.
     
           - The `strbuf` interface is quite deeply tied into Git, which makes it
             hard to use the reftable library as a standalone library. Any
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## reftable/basics.c ##
    +@@ reftable/basics.c: license that can be found in the LICENSE file or at
    + #define REFTABLE_ALLOW_BANNED_ALLOCATORS
    + #include "basics.h"
    + #include "reftable-basics.h"
    ++#include "reftable-error.h"
    + 
    + static void *(*reftable_malloc_ptr)(size_t sz);
    + static void *(*reftable_realloc_ptr)(void *, size_t);
     @@ reftable/basics.c: void reftable_set_alloc(void *(*malloc)(size_t),
      	reftable_free_ptr = free;
      }
    @@ reftable/basics.c: void reftable_set_alloc(void *(*malloc)(size_t),
     +		char *reallocated = buf->buf;
     +		REFTABLE_ALLOC_GROW(reallocated, newlen + 1, buf->alloc);
     +		if (!reallocated)
    -+			return -1;
    ++			return REFTABLE_OUT_OF_MEMORY_ERROR;
     +		buf->buf = reallocated;
     +	}
     +
    @@ reftable/basics.h: license that can be found in the LICENSE file or at
     +};
     +#define REFTABLE_BUF_INIT { 0 }
     +
    ++/*
    ++ * Initialize the buffer such that it is ready for use. This is equivalent to
    ++ * using REFTABLE_BUF_INIT for stack-allocated variables.
    ++ */
     +void reftable_buf_init(struct reftable_buf *buf);
    ++
    ++/*
    ++ * Release memory associated with the buffer. The buffer is reinitialized such
    ++ * that it can be reused for subsequent operations.
    ++ */
     +void reftable_buf_release(struct reftable_buf *buf);
    ++
    ++/*
    ++ * Reset the buffer such that it is effectively empty, without releasing the
    ++ * memory that this structure holds on to. This is equivalent to calling
    ++ * `reftable_buf_setlen(buf, 0)`.
    ++ */
     +void reftable_buf_reset(struct reftable_buf *buf);
    ++
    ++/*
    ++ * Trim the buffer to a shorter length by updating the `len` member and writing
    ++ * a NUL byte to `buf[len]`. Returns 0 on success, -1 when `len` points outside
    ++ * of the array.
    ++ */
     +int reftable_buf_setlen(struct reftable_buf *buf, size_t len);
    ++
    ++/*
    ++ * Lexicographically compare the two buffers. Returns 0 when both buffers have
    ++ * the same contents, -1 when `a` is lexicographically smaller than `b`, and 1
    ++ * otherwise.
    ++ */
     +int reftable_buf_cmp(const struct reftable_buf *a, const struct reftable_buf *b);
    ++
    ++/*
    ++ * Add the given bytes to the buffer. Returns 0 on success,
    ++ * REFTABLE_OUT_OF_MEMORY_ERROR on allocation failure.
    ++ */
     +int reftable_buf_add(struct reftable_buf *buf, const void *data, size_t len);
    ++
    ++/* Equivalent to `reftable_buf_add(buf, s, strlen(s))`. */
     +int reftable_buf_addstr(struct reftable_buf *buf, const char *s);
    ++
    ++/*
    ++ * Detach the buffer from the structure such that the underlying memory is now
    ++ * owned by the caller. The buffer is reinitialized such that it can be reused
    ++ * for subsequent operations.
    ++ */
     +char *reftable_buf_detach(struct reftable_buf *buf);
     +
      /* Bigendian en/decoding of integers */
 4:  e2ac27dbca0 !  4:  e1ff1af1f30 reftable: convert from `strbuf` to `reftable_buf`
    @@ Commit message
         reftable: convert from `strbuf` to `reftable_buf`
     
         Convert the reftable library to use the `reftable_buf` interface instead
    -    of the `strbuf` interface. This is a mechanical change via sed(1) and
    -    does not yet handle allocation failures. These will be addressed in
    -    subsequent commits.
    +    of the `strbuf` interface. This is mostly a mechanical change via sed(1)
    +    with some manual fixes where functions for `strbuf` and `reftable_buf`
    +    differ. The converted code does not yet handle allocation failures. This
    +    will be handled in subsequent commits.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 5:  da432d7a384 =  5:  fe8c9ace463 reftable/blocksource: adapt interface name
 6:  797e435ed2e =  6:  8c98745233a t/unit-tests: check for `reftable_buf` allocation errors
 7:  66ee431db46 =  7:  1f08163009b reftable/stack: adapt `format_name()` to handle allocation failures
 8:  f5ae5ec27d6 =  8:  5798d76d7a4 reftable/record: adapt `reftable_record_key()` to handle allocation failures
 9:  d66d9e50e06 =  9:  a9582d51dd1 reftable/stack: adapt `stack_filename()` to handle allocation failures
10:  8406948ae74 = 10:  90819c90f38 reftable: handle trivial `reftable_buf` errors
-- 
2.47.0.dirty

