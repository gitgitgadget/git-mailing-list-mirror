Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94B1DE2AD
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053848; cv=none; b=c/JzPV10OUiAvfHjTXmRiJdIVODUjCpDorDCIAX0lVmHicd+xIZFypZaGq8MptMFpI4UX2IyXWOVvV8DV6F5Ob0Ww7BnibfiWIlh/qQ7bOpzMnFBfZUzfipXzpHCEBOi6P6FjPFIH0YnhUSjQ4V7yj6GEJ4QVMYrRY8suTRvi5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053848; c=relaxed/simple;
	bh=RUj0RhF8zeN2irI9q2QpCSlR6808BTqB2UhUUQR2+QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mksnMoP55d1g1yzxAyQMbB6qRMpPOidHQaIFDtuK8JJqOC6a62rQpsmtvEtriOHImww5xfQw+kh976U4kgbuDkzcU+qgjqIY8bEx2f30yKL0zkMeNju6Y3CAWJEVN+1cNhkpPSMU7sdcs7jo38gOm501QIBsuWT7OmMTttiG/ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H+XgNQoP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hDgal0uV; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H+XgNQoP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hDgal0uV"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A6E5D2540096;
	Fri,  8 Nov 2024 03:17:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 08 Nov 2024 03:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731053845; x=1731140245; bh=P2ux+cnsgV
	bdMXdK+wJAemBl4I66uLePXjv6GKxEvVE=; b=H+XgNQoPqr9MAVt7rfNlPxQlLu
	Yj4vK2/jIOFrkvaLIyUopoLkvrFUjkwz+BipUWI08Nm7OX368eDNAlgeRfn7mb8v
	4m6XKwrTtjgCMSYeB7H3UFpNRzyCLF3KEN3Tb8TX3jmoogHafRdkw9i3SI3dxZ10
	bxTfrym9uAmd0QGSFdFU6Jp80Q8g+d9eDT3kvGPpyBb23vbai909cxe5LKfTZH5b
	3dsXgGD15gk6kwYswCVS+2tF4BpBKDzTN2Wm3zH8JBpTnDRpjUtn6RuFV+yG26UI
	5E39lw4Ph0jHb4nt6W9bLOYYTkjtF1kViybd87NyM4nOCLFZbCjKkiNxZ+Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731053845; x=1731140245; bh=P2ux+cnsgVbdMXdK+wJAemBl4I66uLePXjv
	6GKxEvVE=; b=hDgal0uVPfmVBr18SCTNR+oSgvaLhgHYxKaXqafxDDoZXv6ayLi
	v6CQdWRPBlzJ1MKZtBQKGoT4wNc/3MQwA6RqVPJEb+Q38rir2C4JIaiQ7mSClRRA
	+vidrIIz0Kt4etx9366935PIS3aNzJKJhruEFL9JP5xbYVtfawDa3kgZOqQDqM8F
	Ty4MhGfr76fpGqoMoO5fgc18rneH9ZkfXlX2/MxI9Pmqxh24rg4bxwd6PvXPq2EI
	5HoyCnCJ7q+cV9TCmBfoYfPTNLp4txVpjlnr4D4bMMVO2viWl48fixaQV53FOSNi
	Suto6BaKsyS3O6mByAp1pcURbNzYlbbO3Og==
X-ME-Sender: <xms:FcktZ2hgUEqKDsDhsxx0p_oE6WWhjBQdWkfPgp9ZSoQLe_eO_fECzQ>
    <xme:FcktZ3CYrDKy-Get7lRYlFUvAX_3ZzQi3FsedLJB-CiLvQRoZcw4GTY1DTikmdbGY
    mVJvjUVPIaTF-TTtg>
X-ME-Received: <xmr:FcktZ-HfEUPbheScASQgNi8VvqVlZDX1dRh-n2kflVxlJyygqteQbhuaMPJhU_8nmyg7Xpn7LO0zo_ldX9UblWOAMAZCpVu5l_iM6Ygk3nHcWXM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdehgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:FcktZ_TkD2QrsNVvIKARbZqMbuBZjteuv9XgWfvtTd_cxrGkU_64tA>
    <xmx:FcktZzx4q8dP1MdLOzF5et7qy713uCTfn_KaneXG4RCsOEnw4K9Jmw>
    <xmx:FcktZ961PnL6_LKb0G196eFhn_BYgSke8KroxBVdxCxbz8u4ptcKkw>
    <xmx:FcktZwx1XpsirXCIvSpBt4fwRHRxI8ysYZosEN49EfwQ9-BjU0D40g>
    <xmx:FcktZ1sZjWVRQnhZNDYDZMiRKS1XzfQswkCZLl7teyrtMGIFtOreTKKw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 03:17:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b2ac7532 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 08:16:56 +0000 (UTC)
Date: Fri, 8 Nov 2024 09:17:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 4/7] reftable/stack: stop using `fsync_component()`
 directly
Message-ID: <7782652b97545f95c83aef08786c70384e5cfa52.1731047193.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im>
 <cover.1731047193.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731047193.git.ps@pks.im>

We're executing `fsync_component()` directly in the reftable library so
that we can fsync data to disk depending on "core.fsync". But as we're
in the process of converting the reftable library to become standalone
we cannot use that function in the library anymore.

Refactor the code such that users of the library can inject a custom
fsync function via the write options. This allows us to get rid of the
dependency on "write-or-die.h".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c    |  7 ++++++
 reftable/reftable-writer.h |  6 +++++
 reftable/stack.c           | 49 +++++++++++++++++++++++++-------------
 3 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 7d86d920970..2e774176eda 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -24,6 +24,7 @@
 #include "../setup.h"
 #include "../strmap.h"
 #include "../trace2.h"
+#include "../write-or-die.h"
 #include "parse.h"
 #include "refs-internal.h"
 
@@ -273,6 +274,11 @@ static int reftable_be_config(const char *var, const char *value,
 	return 0;
 }
 
+static int reftable_be_fsync(int fd)
+{
+	return fsync_component(FSYNC_COMPONENT_REFERENCE, fd);
+}
+
 static struct ref_store *reftable_be_init(struct repository *repo,
 					  const char *gitdir,
 					  unsigned int store_flags)
@@ -304,6 +310,7 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	refs->write_options.disable_auto_compact =
 		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
 	refs->write_options.lock_timeout_ms = 100;
+	refs->write_options.fsync = reftable_be_fsync;
 
 	git_config(reftable_be_config, &refs->write_options);
 
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 211860d08a4..c85ef5a5bd1 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -62,6 +62,12 @@ struct reftable_write_options {
 	 * negative value will cause us to block indefinitely.
 	 */
 	long lock_timeout_ms;
+
+	/*
+	 * Optional callback used to fsync files to disk. Falls back to using
+	 * fsync(3P) when unset.
+	 */
+	int (*fsync)(int fd);
 };
 
 /* reftable_block_stats holds statistics for a single block type */
diff --git a/reftable/stack.c b/reftable/stack.c
index 9ae716ff375..c67bdd952ca 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -8,7 +8,6 @@ license that can be found in the LICENSE file or at
 
 #include "stack.h"
 
-#include "../write-or-die.h"
 #include "system.h"
 #include "constants.h"
 #include "merged.h"
@@ -43,17 +42,28 @@ static int stack_filename(struct reftable_buf *dest, struct reftable_stack *st,
 	return 0;
 }
 
-static ssize_t reftable_fd_write(void *arg, const void *data, size_t sz)
+static int stack_fsync(const struct reftable_write_options *opts, int fd)
 {
-	int *fdp = (int *)arg;
-	return write_in_full(*fdp, data, sz);
+	if (opts->fsync)
+		return opts->fsync(fd);
+	return fsync(fd);
 }
 
-static int reftable_fd_flush(void *arg)
+struct fd_writer {
+	const struct reftable_write_options *opts;
+	int fd;
+};
+
+static ssize_t fd_writer_write(void *arg, const void *data, size_t sz)
 {
-	int *fdp = (int *)arg;
+	struct fd_writer *writer = arg;
+	return write_in_full(writer->fd, data, sz);
+}
 
-	return fsync_component(FSYNC_COMPONENT_REFERENCE, *fdp);
+static int fd_writer_flush(void *arg)
+{
+	struct fd_writer *writer = arg;
+	return stack_fsync(writer->opts, writer->fd);
 }
 
 int reftable_new_stack(struct reftable_stack **dest, const char *dir,
@@ -765,7 +775,7 @@ int reftable_addition_commit(struct reftable_addition *add)
 		goto done;
 	}
 
-	err = fsync_component(FSYNC_COMPONENT_REFERENCE, lock_file_fd);
+	err = stack_fsync(&add->stack->opts, lock_file_fd);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
@@ -858,8 +868,10 @@ int reftable_addition_add(struct reftable_addition *add,
 	struct reftable_buf next_name = REFTABLE_BUF_INIT;
 	struct reftable_writer *wr = NULL;
 	struct tempfile *tab_file = NULL;
+	struct fd_writer writer = {
+		.opts = &add->stack->opts,
+	};
 	int err = 0;
-	int tab_fd;
 
 	reftable_buf_reset(&next_name);
 
@@ -887,10 +899,10 @@ int reftable_addition_add(struct reftable_addition *add,
 			goto done;
 		}
 	}
-	tab_fd = get_tempfile_fd(tab_file);
 
-	err = reftable_writer_new(&wr, reftable_fd_write, reftable_fd_flush,
-				  &tab_fd, &add->stack->opts);
+	writer.fd = get_tempfile_fd(tab_file);
+	err = reftable_writer_new(&wr, fd_writer_write, fd_writer_flush,
+				  &writer, &add->stack->opts);
 	if (err < 0)
 		goto done;
 
@@ -973,8 +985,11 @@ static int stack_compact_locked(struct reftable_stack *st,
 	struct reftable_buf next_name = REFTABLE_BUF_INIT;
 	struct reftable_buf tab_file_path = REFTABLE_BUF_INIT;
 	struct reftable_writer *wr = NULL;
+	struct fd_writer writer=  {
+		.opts = &st->opts,
+	};
 	struct tempfile *tab_file;
-	int tab_fd, err = 0;
+	int err = 0;
 
 	err = format_name(&next_name, reftable_reader_min_update_index(st->readers[first]),
 			  reftable_reader_max_update_index(st->readers[last]));
@@ -994,7 +1009,6 @@ static int stack_compact_locked(struct reftable_stack *st,
 		err = REFTABLE_IO_ERROR;
 		goto done;
 	}
-	tab_fd = get_tempfile_fd(tab_file);
 
 	if (st->opts.default_permissions &&
 	    chmod(get_tempfile_path(tab_file), st->opts.default_permissions) < 0) {
@@ -1002,8 +1016,9 @@ static int stack_compact_locked(struct reftable_stack *st,
 		goto done;
 	}
 
-	err = reftable_writer_new(&wr, reftable_fd_write, reftable_fd_flush,
-				  &tab_fd, &st->opts);
+	writer.fd = get_tempfile_fd(tab_file);
+	err = reftable_writer_new(&wr, fd_writer_write, fd_writer_flush,
+				  &writer, &st->opts);
 	if (err < 0)
 		goto done;
 
@@ -1460,7 +1475,7 @@ static int stack_compact_range(struct reftable_stack *st,
 		goto done;
 	}
 
-	err = fsync_component(FSYNC_COMPONENT_REFERENCE, get_lock_file_fd(&tables_list_lock));
+	err = stack_fsync(&st->opts, get_lock_file_fd(&tables_list_lock));
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		unlink(new_table_path.buf);
-- 
2.47.0.229.g8f8d6eee53.dirty

