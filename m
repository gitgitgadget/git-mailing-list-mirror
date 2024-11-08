Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C661D0F51
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053844; cv=none; b=Xlbxj+QQujrnBrGd1E0G079cbFn+RQS7VP5JPvlt7OVIsjJnPoX3ACrcnwhnk3qMVI64Qo+XW0EFd/yT8EuauUDGXhcV9Mow6NbwQVdMwMEEyYkyUi24g1UUg/bZMzfzbLgfB3ea3zM1GmIPBmCx3GwnkpqRS8nuJmILQ4w/veM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053844; c=relaxed/simple;
	bh=pLrpwOq8oHYKrJ4MbuJdfU8MoOUvKTybLBA9Lm2aDg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Za9JHJ8MVfiQpK06fP2bzcDS/QQIgvBNPJnVotfjupJyP/vscjEkrhCYAeG+mCG37KFkfA0L1dxXhhlLtz22XQ1/2Q+NgJ8sonXVIuT4Y6boQERRLiuh52A8Is94L7pUtaeUDUOKZavAt56LEd75BWsRzMoIY3ufrJA5vLmxM3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=2nsW95iC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D7LhfCN3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="2nsW95iC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D7LhfCN3"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E23D2540096;
	Fri,  8 Nov 2024 03:17:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 08 Nov 2024 03:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731053838; x=1731140238; bh=P8ax7UiyPo
	nY+qM4m+TWmJM2IfZ/lF0etv1douyFn+o=; b=2nsW95iCnc8zdP5wh1v33Yl+kx
	iKMaLXZAFjDUY36TKajP/I8gmIIcg1rkzsLwdQxuhpMZi2mMtkETulvo+9nswfby
	wK5UN5X5/5REVDl5UPWppiT+oWiywpXz3Q5UJwVbv2DBBD8A8zOpxkUgTvhaopFn
	cuWBksoTr42EKi5BeqyS+YXOiAVlhh+nZKhevcxuF7Kpq0t0bFdO4OXX4nX7oh2q
	bZZDaM6VgpgQqhk/9OEM+VCBIASmK9x3xuHRP2EvB3nuoUJYEeJxzafH7btUHVgm
	oJMwFsn5R2dZBagyCetdD7nFou1EOfZQTM8yi0Zuy/G7NujXYC0cAYgpzerQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731053838; x=1731140238; bh=P8ax7UiyPonY+qM4m+TWmJM2IfZ/lF0etv1
	douyFn+o=; b=D7LhfCN3Qm/plasTAnTCNHtNBkJusBOC5oNPGti+vf4EB8Pr5Gp
	5GxoPDCs/K21N/5XcsVdLynfxrEIFFlc90H+ijqU3uklyOiqfzj/hHMu0kkwQK9f
	0L4S45Gj0ShUACRXsI4EVVUXG+IxF/dZfXnR1Fy0ylHa1xHmsrMTOmPpwihVTPYB
	lL2IYvUVwKjhgJaTH9CF5shyZWS5mRAABnxbr5vRWTdhahkQJrZlNy9B2yTk5tKA
	P37csYuaxS/f1kw1EQDJ+UFDF7i+h5r10o4pAMS+X9j64idEtNQDyv42C6y4O7p5
	YI4tA/qywIn3+QtrdBNU+risUTlNHu43a6Q==
X-ME-Sender: <xms:DsktZyVSd8E6hAhhoGSHgXRrPHSVSaSf9B7qZvs6GDSHGJU3UlokZg>
    <xme:DsktZ-lTrasLniX_7DfYEkeiVW-7oTLjvpNbbDEWNtBGGi0Yz5ek-fpxTm1NeM2lU
    7vNjbYMB5cufXk_Ww>
X-ME-Received: <xmr:DsktZ2ZoXDIF1hbxuKhrfen7nvO0iPegiNBzGL2jnis5mjcdp989ge3NIHLzohFj_ZjAckgocCjL82mOOcgR2ct1QwjBd7Cb0UCjJDh7b6ihLWo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdehgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghp
    thhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DsktZ5WDD248pj5_WpR1WBICHACLhS2ponOAZ7w-PrP-jTPbaaNAlw>
    <xmx:DsktZ8mocozKRJyD1UXCLcey8kCIyiCGztWSJfuzgW1VHN-kg2_cVg>
    <xmx:DsktZ-cPqTi-2sYZVhUahqapFHKXnFJQ-yEuQ0u1XyFZIw27YHGX1Q>
    <xmx:DsktZ-Hg1nG45JUt-GVK8ZtRbXxiZ4cSsc21yQ29YhCsz46_qUB40A>
    <xmx:DsktZ9BK1bbE8iLNSPc0clQPkIURyetLsG9weFJVZi9GOEeaj_07ow6B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 03:17:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 397ed07e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 08:16:46 +0000 (UTC)
Date: Fri, 8 Nov 2024 09:17:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/7] reftable: stop using Git subsystems
Message-ID: <cover.1731047193.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729677003.git.ps@pks.im>

Hi,

this is the second version of my patch series that continues to detangle
the reftable library from the Git codebase.

Changes compared to v1:

  - Fix a commit message typo.

  - Document the values of the newly introduced reftable format IDs.

  - Include "reftable-basics.h" instead of "basics.h".

  - Adapt `stack_fsync()` to take write options as input instead of the
    whole stack.

Thanks!

Patrick

Patrick Steinhardt (7):
  reftable/system: move "dir.h" to its only user
  reftable: explicitly handle hash format IDs
  reftable/system: stop depending on "hash.h"
  reftable/stack: stop using `fsync_component()` directly
  reftable/system: provide thin wrapper for tempfile subsystem
  reftable/stack: drop only use of `get_locked_file_path()`
  reftable/system: provide thin wrapper for lockfile subsystem

 Makefile                            |   1 +
 refs/reftable-backend.c             |  19 +++-
 reftable/basics.c                   |  13 ++-
 reftable/basics.h                   |  10 +-
 reftable/merged.c                   |   4 +-
 reftable/merged.h                   |   3 +-
 reftable/reader.c                   |  14 ++-
 reftable/reader.h                   |   4 +-
 reftable/reftable-basics.h          |  13 +++
 reftable/reftable-merged.h          |   4 +-
 reftable/reftable-reader.h          |   2 +-
 reftable/reftable-record.h          |  12 +-
 reftable/reftable-writer.h          |   8 +-
 reftable/stack.c                    | 171 ++++++++++++++--------------
 reftable/system.c                   | 126 ++++++++++++++++++++
 reftable/system.h                   |  88 +++++++++++++-
 reftable/writer.c                   |  20 +++-
 t/helper/test-reftable.c            |   4 +-
 t/unit-tests/lib-reftable.c         |   5 +-
 t/unit-tests/lib-reftable.h         |   2 +-
 t/unit-tests/t-reftable-block.c     |  41 +++----
 t/unit-tests/t-reftable-merged.c    |  26 ++---
 t/unit-tests/t-reftable-pq.c        |   3 +-
 t/unit-tests/t-reftable-reader.c    |   4 +-
 t/unit-tests/t-reftable-readwrite.c |  41 +++----
 t/unit-tests/t-reftable-record.c    |  59 +++++-----
 t/unit-tests/t-reftable-stack.c     |  37 +++---
 27 files changed, 505 insertions(+), 229 deletions(-)
 create mode 100644 reftable/system.c

Range-diff against v1:
1:  036cc8f9d60 ! 1:  2b7d4e28529 reftable/system: move "dir.h" to its only user
    @@ Metadata
      ## Commit message ##
         reftable/system: move "dir.h" to its only user
     
    -    We still include "dir.h" in "reftable/system.h" evne though it is not
    +    We still include "dir.h" in "reftable/system.h" even though it is not
         used by anything but by a single unit test. Move it over into that unit
         test so that we don't accidentally use any functionality provided by it
         in the reftable codebase.
2:  c1bd8e2b3c4 ! 2:  38cfe85bf5b reftable: explicitly handle hash format IDs
    @@ reftable/basics.h: int common_prefix_size(struct reftable_buf *a, struct reftabl
      
     +/*
     + * Format IDs that identify the hash function used by a reftable. Note that
    -+ * these constants end up on disk and thus mustn't change.
    ++ * these constants end up on disk and thus mustn't change. The format IDs are
    ++ * "sha1" and "s256" in big endian, respectively.
     + */
     +#define REFTABLE_FORMAT_ID_SHA1   ((uint32_t) 0x73686131)
     +#define REFTABLE_FORMAT_ID_SHA256 ((uint32_t) 0x73323536)
3:  b595668a5cd ! 3:  745c1a070dd reftable/system: stop depending on "hash.h"
    @@ reftable/merged.h: license that can be found in the LICENSE file or at
      #define MERGED_H
      
      #include "system.h"
    -+#include "basics.h"
    ++#include "reftable-basics.h"
      
      struct reftable_merged_table {
      	struct reftable_reader **readers;
4:  86269fc4fca ! 4:  7782652b975 reftable/stack: stop using `fsync_component()` directly
    @@ reftable/stack.c: static int stack_filename(struct reftable_buf *dest, struct re
      }
      
     -static ssize_t reftable_fd_write(void *arg, const void *data, size_t sz)
    -+static int stack_fsync(struct reftable_stack *st, int fd)
    ++static int stack_fsync(const struct reftable_write_options *opts, int fd)
      {
     -	int *fdp = (int *)arg;
     -	return write_in_full(*fdp, data, sz);
    -+	if (st->opts.fsync)
    -+		return st->opts.fsync(fd);
    ++	if (opts->fsync)
    ++		return opts->fsync(fd);
     +	return fsync(fd);
      }
      
     -static int reftable_fd_flush(void *arg)
     +struct fd_writer {
    -+	struct reftable_stack *stack;
    ++	const struct reftable_write_options *opts;
     +	int fd;
     +};
     +
    @@ reftable/stack.c: static int stack_filename(struct reftable_buf *dest, struct re
     +static int fd_writer_flush(void *arg)
     +{
     +	struct fd_writer *writer = arg;
    -+	return stack_fsync(writer->stack, writer->fd);
    ++	return stack_fsync(writer->opts, writer->fd);
      }
      
      int reftable_new_stack(struct reftable_stack **dest, const char *dir,
    @@ reftable/stack.c: int reftable_addition_commit(struct reftable_addition *add)
      	}
      
     -	err = fsync_component(FSYNC_COMPONENT_REFERENCE, lock_file_fd);
    -+	err = stack_fsync(add->stack, lock_file_fd);
    ++	err = stack_fsync(&add->stack->opts, lock_file_fd);
      	if (err < 0) {
      		err = REFTABLE_IO_ERROR;
      		goto done;
    @@ reftable/stack.c: int reftable_addition_add(struct reftable_addition *add,
      	struct reftable_writer *wr = NULL;
      	struct tempfile *tab_file = NULL;
     +	struct fd_writer writer = {
    -+		.stack = add->stack,
    ++		.opts = &add->stack->opts,
     +	};
      	int err = 0;
     -	int tab_fd;
    @@ reftable/stack.c: static int stack_compact_locked(struct reftable_stack *st,
      	struct reftable_buf tab_file_path = REFTABLE_BUF_INIT;
      	struct reftable_writer *wr = NULL;
     +	struct fd_writer writer=  {
    -+		.stack = st,
    ++		.opts = &st->opts,
     +	};
      	struct tempfile *tab_file;
     -	int tab_fd, err = 0;
    @@ reftable/stack.c: static int stack_compact_range(struct reftable_stack *st,
      	}
      
     -	err = fsync_component(FSYNC_COMPONENT_REFERENCE, get_lock_file_fd(&tables_list_lock));
    -+	err = stack_fsync(st, get_lock_file_fd(&tables_list_lock));
    ++	err = stack_fsync(&st->opts, get_lock_file_fd(&tables_list_lock));
      	if (err < 0) {
      		err = REFTABLE_IO_ERROR;
      		unlink(new_table_path.buf);
5:  aca19955560 ! 5:  b15daefbc83 reftable/system: provide thin wrapper for tempfile subsystem
    @@ reftable/stack.c: int reftable_addition_add(struct reftable_addition *add,
     -	struct tempfile *tab_file = NULL;
     +	struct reftable_tmpfile tab_file = REFTABLE_TMPFILE_INIT;
      	struct fd_writer writer = {
    - 		.stack = add->stack,
    + 		.opts = &add->stack->opts,
      	};
     @@ reftable/stack.c: int reftable_addition_add(struct reftable_addition *add,
      	if (err < 0)
    @@ reftable/stack.c: uint64_t reftable_stack_next_update_index(struct reftable_stac
      	struct reftable_buf tab_file_path = REFTABLE_BUF_INIT;
     @@ reftable/stack.c: static int stack_compact_locked(struct reftable_stack *st,
      	struct fd_writer writer=  {
    - 		.stack = st,
    + 		.opts = &st->opts,
      	};
     -	struct tempfile *tab_file;
     +	struct reftable_tmpfile tab_file = REFTABLE_TMPFILE_INIT;
6:  74afe30974d = 6:  83949837a29 reftable/stack: drop only use of `get_locked_file_path()`
7:  71b213d6f8a ! 7:  80fe5bc5e10 reftable/system: provide thin wrapper for lockfile subsystem
    @@ reftable/stack.c: int reftable_addition_commit(struct reftable_addition *add)
      		goto done;
      	}
      
    --	err = stack_fsync(add->stack, lock_file_fd);
    -+	err = stack_fsync(add->stack, add->tables_list_lock.fd);
    +-	err = stack_fsync(&add->stack->opts, lock_file_fd);
    ++	err = stack_fsync(&add->stack->opts, add->tables_list_lock.fd);
      	if (err < 0) {
      		err = REFTABLE_IO_ERROR;
      		goto done;
    @@ reftable/stack.c: static int stack_compact_range(struct reftable_stack *st,
      		goto done;
      	}
      
    --	err = stack_fsync(st, get_lock_file_fd(&tables_list_lock));
    -+	err = stack_fsync(st, tables_list_lock.fd);
    +-	err = stack_fsync(&st->opts, get_lock_file_fd(&tables_list_lock));
    ++	err = stack_fsync(&st->opts, tables_list_lock.fd);
      	if (err < 0) {
      		err = REFTABLE_IO_ERROR;
      		unlink(new_table_path.buf);
-- 
2.47.0.229.g8f8d6eee53.dirty

