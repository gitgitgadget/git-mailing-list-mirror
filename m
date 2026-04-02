Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6AA38838A
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115095; cv=none; b=DF0GtU8BrEBkoxrBJuV8tMkc2Urg2s2+5jWzSEwbVPVrMCqXNReTDBetIMP38mN2kYozOD08896eeFHyqwEq9+8z7RY7I31EYbEcX0aTF+IQmu/6J3nOUZLicvUh86kF8H/sJhaQHGbWCmn8ZKucmkDQoJReDIX7kw8GWmrvAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115095; c=relaxed/simple;
	bh=vnPmleBUeeeXBnv9A3TqI8VqkAn+9X7uotp8Tpmoyos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HwqsnGpjNyZm9AyMBuOkhA7S0vpgoaBgEP0K5SU/4yAkO5XXtm66+Q5HiTDyzl0gl1lDSVdRPb52gV/yEm3ff5E5xWGv3XW1P1rUxPe65LmjZM4ePs3W2TculL7Fp5tF5kXgT8xEwvDsEZ2et4pVSpffE+FFv9pDt4wHcIMsSXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zqc//XEx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dnThK5oc; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zqc//XEx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dnThK5oc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 3F5C11D00045;
	Thu,  2 Apr 2026 03:31:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 02 Apr 2026 03:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775115093;
	 x=1775201493; bh=T+g3oRof3UB//Y6xOJqVGZ2/bAJFCZS9zAdHs9pPdgs=; b=
	zqc//XExZY+GaP75oaN0WDadyY5A5p3XYq5rMnN90L784/dO1GLH3/ejRYmEmN4A
	h3BYZhCFAxAOk2mYwIUDe+BAkrKW9TxaPSaZ949aDHNkKCYfWoI0vtoJCedtKy+Q
	aEtqT9tievcZchqrRVKwVFIBIu6bSacCAKNYWlf1PwIX45gaffkubaGHAQJumVDh
	unFoD9eVLf3Q2bF2w81KtjRN18u16Sdk/YJ31XnFK7C5lD5kAz2EHlGFkfWPPtAj
	NEIdqryI0PjhRJ5BW4YPXClP23PGrFE+tsN71a9Dy+gTjyFEZskmgindbGkKybd7
	UEN11S4wX26Uxe2+FgHTNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775115093; x=
	1775201493; bh=T+g3oRof3UB//Y6xOJqVGZ2/bAJFCZS9zAdHs9pPdgs=; b=d
	nThK5oce/AE4U35nuDWxc0zAseCVPc8qoI8taElUiEqL2Mp9oOkg5dGsQEBy3OJR
	xXOvsNH6aMnBRTcX4J/mM5Os1hc52saM0PMHa5unj0pUIlPQzLRuGLfW65rZGAor
	WoEIO8ZWQCRRIhKR46u5WTPefEiR5o4+hWkZ0KZRxbS/v0CHLixrJFa8CJ7t58O8
	R/HMDCOvMtcWfBUVyTD3XYDlYtiyhSVCsdNuCBUrdwWT/ad3Yw8dY1X66sPS57mM
	hwQHci28Hw0mce7X4WpzBAf3I55Mic/Br+eXWsmdMV2g6xa+oC3GDJ8C8RnS0BFC
	VlGiKEAj6pbIlylAl+kjg==
X-ME-Sender: <xms:VRvOadZeWHCiTnrKRq_zsvxUk1raMQlVwpQ8mK2kxpgtGNuymOfgZg>
    <xme:VRvOabZlS5_b0-reqiLOEUXLgG5sViLx2fdcMWSk9LC94ATTQP9QTf8j3A_CxKLM8
    7XsLjL1iXRc5ZKdFJWZgIy4yXiHMFqT1bZo5xJnfCpv9KSqmF7mT64>
X-ME-Received: <xmr:VRvOaU_gLZb2Lvm8z908pOWLlTfyrYlDJJJvVKR43ClkJaRlA1eb7uklt_HkJ7WwQs71ODLBST8qGX--rzKcgMcPj9-OLFKOoKEEJ-bBtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehgeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohht
    hhhprghsthgvrdhnvghtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VRvOaaiJA03bs79pc0Am9kGzQzgQjRgbDcwsx-4LiUPDWjHwnL_-NQ>
    <xmx:VRvOaUfCTzwYD8M-8g4xrARY_qS72bLFXIDyY8Iy3kVzNSbKBVIyMQ>
    <xmx:VRvOaRrQi1CNS5heI5Vedcwjg9ZC6Ydp5Lt-5zJH5zvAxdpY0WG23g>
    <xmx:VRvOaZAKYtRe9AW9Jo6hbZqy-5EPpY4W62d6RN5yuf1SVxu6KI-ndQ>
    <xmx:VRvOaUuz3Wrf_6d-Ge-j4iTCOGhw0CXd8E2C3e5udHXpfnRibsgWzWpa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 03:31:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 99b5ed57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Apr 2026 07:31:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Apr 2026 09:31:15 +0200
Subject: [PATCH v2 2/5] reftable/stack: provide fsync(3p) via system header
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-pks-reftable-portability-fixes-v2-2-bc110cee0ae0@pks.im>
References: <20260402-pks-reftable-portability-fixes-v2-0-bc110cee0ae0@pks.im>
In-Reply-To: <20260402-pks-reftable-portability-fixes-v2-0-bc110cee0ae0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: b4 0.15.1

Users of the reftable library are expected to provide their own function
callback in cases they want to sync(3p) data to disk via the reftable
write options. But if no such function was provided we end up calling
fsync(3p) directly, which may not even be available on some systems.

While dropping the explicit call to fsync(3p) would work, it would lead
to an unsafe default behaviour where a project may have forgotten to set
up the callback function, and that could lead to potential data loss. So
this is not a great solution.

Instead, drop the callback function and make it mandatory for the
project to define fsync(3p). In the case of Git, we can then easily
inject our custom implementation via the "reftable-system.h" header so
that we continue to use `fsync_component()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c    |  6 ------
 reftable/reftable-system.h |  3 +++
 reftable/reftable-writer.h |  6 ------
 reftable/stack.c           | 13 +++----------
 reftable/system.c          |  6 ++++++
 5 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index b124404663..daea30a5b4 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -366,11 +366,6 @@ static int reftable_be_config(const char *var, const char *value,
 	return 0;
 }
 
-static int reftable_be_fsync(int fd)
-{
-	return fsync_component(FSYNC_COMPONENT_REFERENCE, fd);
-}
-
 static struct ref_store *reftable_be_init(struct repository *repo,
 					  const char *payload,
 					  const char *gitdir,
@@ -408,7 +403,6 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	refs->write_options.disable_auto_compact =
 		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
 	refs->write_options.lock_timeout_ms = 100;
-	refs->write_options.fsync = reftable_be_fsync;
 
 	repo_config(the_repository, reftable_be_config, &refs->write_options);
 
diff --git a/reftable/reftable-system.h b/reftable/reftable-system.h
index 4a18a6a790..76f3e33e90 100644
--- a/reftable/reftable-system.h
+++ b/reftable/reftable-system.h
@@ -12,4 +12,7 @@
 #include "compat/posix.h"
 #include "compat/zlib-compat.h"
 
+int reftable_fsync(int fd);
+#define fsync(fd) reftable_fsync(fd)
+
 #endif
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 065dd93dc6..a66db415c8 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -61,12 +61,6 @@ struct reftable_write_options {
 	 */
 	long lock_timeout_ms;
 
-	/*
-	 * Optional callback used to fsync files to disk. Falls back to using
-	 * fsync(3P) when unset.
-	 */
-	int (*fsync)(int fd);
-
 	/*
 	 * Callback function to execute whenever the stack is being reloaded.
 	 * This can be used e.g. to discard cached information that relies on
diff --git a/reftable/stack.c b/reftable/stack.c
index 1c9f21dfe1..fa87b46c37 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -29,13 +29,6 @@ static int stack_filename(struct reftable_buf *dest, struct reftable_stack *st,
 	return 0;
 }
 
-static int stack_fsync(const struct reftable_write_options *opts, int fd)
-{
-	if (opts->fsync)
-		return opts->fsync(fd);
-	return fsync(fd);
-}
-
 static ssize_t reftable_write_data(int fd, const void *data, size_t size)
 {
 	size_t total_written = 0;
@@ -69,7 +62,7 @@ static ssize_t fd_writer_write(void *arg, const void *data, size_t sz)
 static int fd_writer_flush(void *arg)
 {
 	struct fd_writer *writer = arg;
-	return stack_fsync(writer->opts, writer->fd);
+	return fsync(writer->fd);
 }
 
 static int fd_read_lines(int fd, char ***namesp)
@@ -812,7 +805,7 @@ int reftable_addition_commit(struct reftable_addition *add)
 		goto done;
 	}
 
-	err = stack_fsync(&add->stack->opts, add->tables_list_lock.fd);
+	err = fsync(add->tables_list_lock.fd);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
@@ -1480,7 +1473,7 @@ static int stack_compact_range(struct reftable_stack *st,
 		goto done;
 	}
 
-	err = stack_fsync(&st->opts, tables_list_lock.fd);
+	err = fsync(tables_list_lock.fd);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		unlink(new_table_path.buf);
diff --git a/reftable/system.c b/reftable/system.c
index 725a25844e..4d7e366b55 100644
--- a/reftable/system.c
+++ b/reftable/system.c
@@ -5,6 +5,7 @@
 #include "reftable-error.h"
 #include "../lockfile.h"
 #include "../tempfile.h"
+#include "../write-or-die.h"
 
 uint32_t reftable_rand(void)
 {
@@ -131,3 +132,8 @@ int flock_commit(struct reftable_flock *l)
 
 	return 0;
 }
+
+int reftable_fsync(int fd)
+{
+	return fsync_component(FSYNC_COMPONENT_REFERENCE, fd);
+}

-- 
2.53.0.1323.g189a785ab5.dirty

