Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9419E7E3
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677369; cv=none; b=nmGle5iSY+G5iVFWatWYcd7+36TWlFYZl0n8+/Ia2LAIQw9xkU8yMtwHO4ehjE9dfeCjk7WLuC6EpHRCsIhaRG8lj96wAc5qeymGt8khIsMifewknuI/t5F1vwLnOufp6ZSherhVH1euE/ZUu0GvbHoBl9aFAYdS/AEi5E8uFCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677369; c=relaxed/simple;
	bh=fu5NoIPIPSXAfioPkZCk1Mz04xfn4nI3gIu4iAGKyIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxjA3nGgI3WnuTXq3skvI/XVUVCeEog8a2u9yztD9zH6EBxLawsxIFL35OS+SZaYpYCtIkTBs3JO/rw3spyYwz67IQYPuhnOGGc0AkCv2o93pyLj0Bq0RK05pcAdNtFvP+qqtltYF2ByFCYalC7k9aMTZ3BsygmUDmU/y6HiSBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SxH8MRHp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eLIHCCzh; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SxH8MRHp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eLIHCCzh"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 405F71380766;
	Wed, 23 Oct 2024 05:56:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 23 Oct 2024 05:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729677367; x=1729763767; bh=n5He5K/neD
	DsWGh/mPAxpx59IbuLAH2yQS5dVFXZoic=; b=SxH8MRHpeM6mRDORSd+3IttrzS
	dTQGLmK8slpHVPpvG9fj7add1AEb5mF+23cncfkla6Ocx8w4QFJdM1q10fSTBimF
	AUUmVvxAZbsm2m0YtjluN7KeeetfBdSGJ92S2is9PV2Z1PQIJoJ90cJAngJm3k1x
	+GDiAoxjFkczC18MoqXyuVNywAWfCay0oVYfp2VbARp03uQ1M1Vv73j14IJxB3Zz
	9N2WaZmqVy+PN9DS/5V0rUMgOnBzasLXUpoQYOdbJkIL6OAc+csaBN6UTvLte9l4
	F0Oj5pUORuDbuKmuPU8QDOu71tWUK64yMNgLlkprBhHJ6Nkjjp0boLUIufhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729677367; x=1729763767; bh=n5He5K/neDDsWGh/mPAxpx59IbuL
	AH2yQS5dVFXZoic=; b=eLIHCCzhok7oJ6wmtn5rLPFVS1BhFP7v3rm7cPSTamNz
	Gk0tgvRKlqzSJ+wYZbeXFje6cANfQdLOq01/x7RHPwHlsYq5cAhiiPhR9MJjMKJW
	gx4LOaJqIoueXovPbCw7lqOjSV/rXdVzTDYLpPux8JulGGdZNV6YVj6VTsw02obL
	BbQvYoL5meub27Y05vPKTtP4/mOXHS76sFVw0ls1A58A2P5wgz/dwMGXSjrlhD6i
	u7gSmQSXvhXANjOhi6B/8wCk0WNyDqicbADoq0kgJAVTFobogVJDpC7GsHKXTAK/
	PcrrAoi0UgKdbc/H2er9u/z04Nr9DGf5SoFi7uY6WQ==
X-ME-Sender: <xms:N8gYZxFuuLBwfGvAanw3_Byj4CvHWnlQfcJNpQb8rzJyw_HGK2HPXg>
    <xme:N8gYZ2U_DG8vpzK1Ou2jNuTx9HVU73wSYaIsyAUHo8xNPl0K_ZISuJoawdyRcj1Sc
    PWdYk2XYEP62iXg_Q>
X-ME-Received: <xmr:N8gYZzIUqEewh6L9VNFoFTP20e6swIos4OcQUtJ0_yrIDFixa0uJu0-eKuum2Sktb8uvQb_JtovyJcFadhWc22CFOrh4fHq0yu7OzdrrNfnE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:N8gYZ3HxsMM3In-X4QbdhJLBOD-a0Bi0VKC4yBtqbHiWSMQGBRFqTQ>
    <xmx:N8gYZ3UXshk5_uZ59h3Tq1cJVA0pyX4zCkIxJmwzYu5VQzVLjDFA0g>
    <xmx:N8gYZyO3qYj0PVR5u36b83I7wwfdMNGg91bqn3RGtTvZV4K4Mv4uDQ>
    <xmx:N8gYZ239rUsowcdJj2VhYAkvGK4WF0lpy-AX6vjXxInZwJrWMHWaCQ>
    <xmx:N8gYZ0i-Org5eZu1EnYRhfNE7Dxc-PRucFul15SMda-7GcsGTnlSKoSe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 05:56:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3840ee5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 09:54:35 +0000 (UTC)
Date: Wed, 23 Oct 2024 11:56:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 4/7] reftable/stack: stop using `fsync_component()` directly
Message-ID: <86269fc4fcad9a97709aa0d080c4c077a85ca667.1729677003.git.ps@pks.im>
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
index 9ae716ff375..df4f3237007 100644
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
+static int stack_fsync(struct reftable_stack *st, int fd)
 {
-	int *fdp = (int *)arg;
-	return write_in_full(*fdp, data, sz);
+	if (st->opts.fsync)
+		return st->opts.fsync(fd);
+	return fsync(fd);
 }
 
-static int reftable_fd_flush(void *arg)
+struct fd_writer {
+	struct reftable_stack *stack;
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
+	return stack_fsync(writer->stack, writer->fd);
 }
 
 int reftable_new_stack(struct reftable_stack **dest, const char *dir,
@@ -765,7 +775,7 @@ int reftable_addition_commit(struct reftable_addition *add)
 		goto done;
 	}
 
-	err = fsync_component(FSYNC_COMPONENT_REFERENCE, lock_file_fd);
+	err = stack_fsync(add->stack, lock_file_fd);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
@@ -858,8 +868,10 @@ int reftable_addition_add(struct reftable_addition *add,
 	struct reftable_buf next_name = REFTABLE_BUF_INIT;
 	struct reftable_writer *wr = NULL;
 	struct tempfile *tab_file = NULL;
+	struct fd_writer writer = {
+		.stack = add->stack,
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
+		.stack = st,
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
+	err = stack_fsync(st, get_lock_file_fd(&tables_list_lock));
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		unlink(new_table_path.buf);
-- 
2.47.0.118.gfd3785337b.dirty

