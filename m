Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4533563F6
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 19:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786302077; cv=none; b=GMuEpuU3LSaSuZUpvhht/WOsnC9l8slJjE4pkYn5vY9ThFj459Yu7QUO2DJfXMBb/5eoOBBp7XTReztnSReovXIEQzY2Gh2b/J5rsJy91wPvSqOCR13JJ0hOlNARx7wZkoMNWH3MFQLA/t+pzSyOaKob4CG9fTG+parW74iXXmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786302077; c=relaxed/simple;
	bh=bqEsL4KMO9Ren7+OiJLPuNN99SqkDd+nVIsv7vQ1XNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNjD/FfWOvYaggqjTQnkZFw2QnGND3dalcl5cLNSZK+ol7wIvEkYaMKgw15SlKGTGemdvne4Yo4NTBjrs/+8X7fIXlAwdoR2AwaTvJxFmCmHwqUdOCoA29rS+CPVw3Mhcxms+4uMbb4QKCd5noElJjrB+V62t369TyvJ1kZICAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPVLTVp5; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPVLTVp5"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4b1be215736so499627b6e.1
        for <git@vger.kernel.org>; Sun, 09 Aug 2026 12:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786302074; x=1786906874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nrxguwbD+fjsE931sALof4A2wbjQKOpyE96jDh28AcQ=;
        b=iPVLTVp5i5xX39Dm9Qdqnclh4IXoiaEKauqAY33jH2eI8EUsiozGtcV5LcXytuy950
         2/NTptMtgA1h4e8qY5HNhGeOALa7oJ1tl2Z38LJvf9jXq/y1t/dngQYZKQ3Fxdodkg2h
         qZlrTW8vRC9UjQqUUIkTz4xKr8VYGCtyoQm7jdFw8rk+/UvK9k6HtGRofc7xTyLDbKPN
         QxlypFEtiiS+MeSRuI4ToVrvQcQA8hy6pb9Gp8KkaFZ3R9NPYupvPY8IBCpo+NON1yqe
         w0kJqIRSyNtVxkhFw4qK+lzaZ03Ox5+xNRQSE33XCevhfjYb/m8FwVNqRNro7BqgZaFL
         i7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786302074; x=1786906874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nrxguwbD+fjsE931sALof4A2wbjQKOpyE96jDh28AcQ=;
        b=JkuFQJeEAvt7N7/KRDF3x00cdYTjMlVRl+AMR7RMbJqvfu8opJ8AfgHxC/h9VBbEU/
         ejD1HE2uXGk0D5jJdpb5dLmBjuKm0vyVzSbCiphA/O6tVH+oztByCS/Rex3VcKT0yNoQ
         zfIq9LI9a44umwQOoGLnf6kyDuGQEhLgFOqcFYLwtjaPn8IPS8+3in85nHoLnYOkgU4i
         BrK5NtQQn+MLhjP5Q2pKXooA+qV06px/KJtkPqsssZCudO74GvUo9SFEV4AruwIUnvWv
         IWIXmN4fs8Nkmuf+i9ahXMu3w41OYBFGKd5rJCAjftK0M565XdhSyPK0uMYtOY81GcPq
         P6Iw==
X-Gm-Message-State: AOJu0Yzl7j0zR2VS7GquCx86tdZEImmpJMKVLSqwZQK/geNhVswAG4L7
	XJS0RpyEpdj5y8464+Gf4LnU6t43D/W3N8ckpkggCkG0jUrGH5SGRXmwXj+TFg==
X-Gm-Gg: AR+sD12j8yuaPUfC8hXVC9sh28G5HCT1eRwwgYXRUVNc3NvjoxT4VnfG9lAmXq000Rf
	so404JdFAT0Nt3v+xocI2f/mbND9tcpfqR3UiNLh9nL/ihSK7XhyRkl700KEkXsCAkq4KrQxKvj
	tq5l9dD647c3mJFrUO0g9v4oWtrx/wSRfGcbRaj7aJgyPJxqk6iu3QCj6BeJGnBmvCAqUXf5Rvi
	6Us6O0gcTJrpUOFZYuYfBfUMNh6/scXVuEIPjdcEvmdTAbYvsxUBfbRLsPjoex0dPcD0/GhozPP
	fhAg66EZSvRlnKSnaAoSpm0+rgjd7yKdFs+pfOawleZ49zsa2KXIeRdWCGNkCUwxki8MjLrwnRy
	CO8PXl7s+8cTiK7h/RCapWpvPw4GXTTsAq96nJMK6yGyW+DIEd7AtbvTnylMMFoIfCLk7UwJ7pV
	Mfxcv6Xr4JtJBJc7+4YnyKZllooUjiYsXHkv/pVuo5ebMbdvj3gKEki7KQ4M+aj0uULF81
X-Received: by 2002:a05:6808:1646:b0:496:559d:5474 with SMTP id 5614622812f47-4afadfb0140mr18908948b6e.8.1786302074571;
        Sun, 09 Aug 2026 12:01:14 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1af5e7b77sm4872188b6e.10.2026.08.09.12.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 12:01:13 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 4/7] builtin/receive-pack: lift global state out of unpack()
Date: Sun,  9 Aug 2026 14:01:03 -0500
Message-ID: <20260809190106.1565882-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260809190106.1565882-1-jltobler@gmail.com>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260809190106.1565882-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In git-receive-pack(1), writing the packfile to the transaction is
handled via `unpack()` which relies on global variables to decide how to
invoke the underlying git-index-pack(1) or git-unpack-objects(1) child
processes. In a subsequent commit, the `unpack()` logic is moved behind
a generic ODB transaction interface to handle writing packfiles and thus
can no longer rely on these globals.

Lift the global state out of `unpack()` by instead storing this state in
a `struct unpack_opts` that gets passed to the function explicitly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c | 63 +++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 22 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 5264d70467..21dab851ad 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2344,18 +2344,24 @@ static int get_unpack_limit(struct repository *repo)
 	return limit;
 }
 
+struct unpack_opts {
+	const char *fsck_msg_types;
+	const char *shallow_file;
+	off_t max_input_size;
+	int fsck_objects;
+	int reject_thin;
+	int err_fd;
+	int quiet;
+};
+
 static const char *unpack(struct odb_transaction *transaction,
-			  const char *shallow_file, int err_fd)
+			  const struct unpack_opts *opts)
 {
 	struct pack_header hdr;
 	const char *hdr_err;
 	int status;
 	struct child_process child = CHILD_PROCESS_INIT;
-	int fsck_objects = (receive_fsck_objects >= 0
-			    ? receive_fsck_objects
-			    : transfer_fsck_objects >= 0
-			    ? transfer_fsck_objects
-			    : 0);
+	int err_fd = opts->err_fd;
 
 	hdr_err = parse_pack_header(&hdr);
 	if (hdr_err) {
@@ -2364,9 +2370,9 @@ static const char *unpack(struct odb_transaction *transaction,
 		return hdr_err;
 	}
 
-	if (shallow_file) {
+	if (opts->shallow_file) {
 		strvec_push(&child.args, "--shallow-file");
-		strvec_push(&child.args, shallow_file);
+		strvec_push(&child.args, opts->shallow_file);
 	}
 
 	odb_transaction_env(transaction, &child.env);
@@ -2374,14 +2380,14 @@ static const char *unpack(struct odb_transaction *transaction,
 	if (ntohl(hdr.hdr_entries) < get_unpack_limit(the_repository)) {
 		strvec_push(&child.args, "unpack-objects");
 		push_header_arg(&child.args, &hdr);
-		if (quiet)
+		if (opts->quiet)
 			strvec_push(&child.args, "-q");
-		if (fsck_objects)
+		if (opts->fsck_objects)
 			strvec_pushf(&child.args, "--strict%s",
-				     fsck_msg_types.buf);
-		if (max_input_size)
+				     opts->fsck_msg_types);
+		if (opts->max_input_size)
 			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
-				     (uintmax_t)max_input_size);
+				     (uintmax_t)opts->max_input_size);
 		child.no_stdout = 1;
 		child.err = err_fd;
 		child.git_cmd = 1;
@@ -2402,18 +2408,18 @@ static const char *unpack(struct odb_transaction *transaction,
 			     (uintmax_t)getpid(),
 			     hostname);
 
-		if (!quiet && err_fd)
+		if (!opts->quiet && err_fd)
 			strvec_push(&child.args, "--show-resolving-progress");
-		if (use_sideband)
+		if (err_fd)
 			strvec_push(&child.args, "--report-end-of-input");
-		if (fsck_objects)
+		if (opts->fsck_objects)
 			strvec_pushf(&child.args, "--strict%s",
-				     fsck_msg_types.buf);
-		if (!reject_thin)
+				     opts->fsck_msg_types);
+		if (!opts->reject_thin)
 			strvec_push(&child.args, "--fix-thin");
-		if (max_input_size)
+		if (opts->max_input_size)
 			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
-				     (uintmax_t)max_input_size);
+				     (uintmax_t)opts->max_input_size);
 		child.out = -1;
 		child.err = err_fd;
 		child.git_cmd = 1;
@@ -2439,11 +2445,23 @@ static const char *unpack(struct odb_transaction *transaction,
 static const char *unpack_with_sideband(struct odb_transaction *transaction,
 					const char *shallow_file)
 {
+	struct unpack_opts opts = {
+		.fsck_objects = (receive_fsck_objects >= 0
+				 ? receive_fsck_objects
+				 : transfer_fsck_objects >= 0
+				 ? transfer_fsck_objects
+				 : 0),
+		.fsck_msg_types = fsck_msg_types.buf,
+		.max_input_size = max_input_size,
+		.shallow_file = shallow_file,
+		.reject_thin = reject_thin,
+		.quiet = quiet,
+	};
 	struct async muxer;
 	const char *ret;
 
 	if (!use_sideband)
-		return unpack(transaction, shallow_file, 0);
+		return unpack(transaction, &opts);
 
 	use_keepalive = KEEPALIVE_AFTER_NUL;
 	memset(&muxer, 0, sizeof(muxer));
@@ -2452,7 +2470,8 @@ static const char *unpack_with_sideband(struct odb_transaction *transaction,
 	if (start_async(&muxer))
 		return NULL;
 
-	ret = unpack(transaction, shallow_file, muxer.in);
+	opts.err_fd = muxer.in;
+	ret = unpack(transaction, &opts);
 
 	finish_async(&muxer);
 	return ret;
-- 
2.55.0.424.g13c7afec21

