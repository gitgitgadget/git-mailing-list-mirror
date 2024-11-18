Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673DC1B6D0A
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944054; cv=none; b=QW4uidHsN1oiOJQZIryTXtkRBhfTv5b/5gGkDbbGcMmnTXrFnsX2RY87NA8rxGLqzwBVZcICuxIeyhx7Hgf8R5IfFluxhoviHl932nCB/GfOb2HbcF2mui1hWrCmo+Pcw68uuek7uGEBD8WOQ8/bE7ar/YLQ7Ut9SmO/hd/mrcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944054; c=relaxed/simple;
	bh=9XE2Au5AbUcXSqiGR7fuNx1kxJy6M93xzRSgUD/rCwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LH7NuWZX2paZd/7dju2MZXIW0ZbGZOGEo/JCRjps3JSjfx+7OJewl7b9PpDBXOahgCgA62YPPyZUZGRpkXxnmR8WR2/QgcJSz5sKHwlOnjhVcHl0kz1/TkTnDQH35moFqCEiCU8P4G3mgIQsOZD4SmTwdVYPAJ8/lZfG0cvyM4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=4OZ202bb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lAuVcEb8; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="4OZ202bb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lAuVcEb8"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 84B76114022C;
	Mon, 18 Nov 2024 10:34:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 18 Nov 2024 10:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731944051; x=1732030451; bh=ApxP+lZ2lO
	KFRtbWchhaxSoWLiKJPCPJs/CCInpTMxg=; b=4OZ202bbTeA8bBxQLdZov10cSi
	DPMV+NH4uGJ5120EXqohtxECIeTyh5Tx7rEL7sWdgRW7veqmQNskfbuA9bEbA9nY
	d6ZXtkagFHeYbcu9Uvq35TZIXL40lxc3eqXLZyr4vbdxk9lNfbEpQ6adqVs8mE2D
	r+U3YP0MD6jKIA2LjcGX0/2JU8WeWhHbzAwm1QM6q7KaSZIwo9ZnGKUu/b2XFYjE
	6izzQ/GUSqEUDMmvDQlR9Y3HVlRqrf68CX2xEosGG9iCi3xodV4N2KxUm4d6ih2h
	m0OKju7wO7YD4Vn6GezVoDGGFICtJACzPawf0aq3aWF8SZpJG3j7i8HFZ1Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731944051; x=1732030451; bh=ApxP+lZ2lOKFRtbWchhaxSoWLiKJPCPJs/C
	CInpTMxg=; b=lAuVcEb80qMuMdaxJ9dgTQOIjJU2cU6RQwwcS3AG7CXpa5/8Mmd
	7WNFqsl+YQGrMJbvDm6PzprhsEmB0TO+KCjKIT3OqwlzvyiQqAcY2HrZ5iA75tZ1
	eEHCGixqX504dKGXbIUXNOnWE8V0I+27peJRohTiRze1knvULxbLxu04WII96yg8
	0n3yyqIWpnB+aTfng/vgVaUaHja0fwvv32VRD6RmstpighN2twz9lWJjCvMFctTu
	tQWcc++7VZrlpQbpaoWfOTEbGtBTkrPEsgCXu5trZJJdJ8nKmIIbrPFaLA4mbPk8
	8+sc7Zf5dWONtUFhm8LztWpQF+pJSj5zIlw==
X-ME-Sender: <xms:c147ZxLxUHDQRaoHrs81vgA2BaAi96hS7PprWeEAeC6YZlxvOJBnuQ>
    <xme:c147Z9Lsmqu8v20VVWeSqkHy-7ZbZu92H_-suDSU7htgfBX71I6mXdViiyp2v2oxs
    _YqeRE8eLXuocqldA>
X-ME-Received: <xmr:c147Z5vZs6bsXYpZH-nDVsTGeTHG7MkvEi2c-oIvuYebT00A8o_xCPwZFTiobqUWm2lpJNLWxkWQrnn0TmZVzEm7A2pWs0hYvzoyplfnJcUuKqrC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhn
    shhhihhnvggtohdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:c147ZyZV3Nno9c15cXeJDAiavV3ZKkex5piCext9FzzmLrHJYBoCow>
    <xmx:c147Z4YpnGYj3iXn5heCU5gN_pS8S1rUEGteCOk-Uax_dXTZOzgfZw>
    <xmx:c147Z2CuOvpo8Dzh_F7Hgmi8V8IA0Mw6gN2Vd2Gzc-uhJTMGkEiDNg>
    <xmx:c147Z2YQxLZfHjf6d3RCM5S-D7CYp-Fm9lCEKJNF8AXqGzhrEL20qg>
    <xmx:c147Z9O-BM5rfhUH5bG_RkAXV5QHqtWEG_f-yTtUSVXetoUQboxWxoi0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 10:34:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8d2961b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 15:33:22 +0000 (UTC)
Date: Mon, 18 Nov 2024 16:34:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 4/7] reftable/stack: stop using `fsync_component()`
 directly
Message-ID: <7782652b97545f95c83aef08786c70384e5cfa52.1731943954.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im>
 <cover.1731943954.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731943954.git.ps@pks.im>

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
2.47.0.274.g962d0b743d.dirty

