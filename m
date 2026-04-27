Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3988D3B38AE
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286542; cv=none; b=kwxX7h19c99OU0najOvjYKyoJjvmjPaegyB/IdwPBfOLDGqklOMTY9NEh6XVjT5E02ORquGTPsbPhnqqncPs5gs7fh++buo2K2Ql0ctXMAdWEYGb00FSbNoqKUjJdxYMDF9Xs6rsbA27vZlemiPQp5Pd9exPMalY7brabMDW7NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286542; c=relaxed/simple;
	bh=r2v28c3wl5d/L0J6UZ8nz+gZ7ctBgxdu59dnQQzsXi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XR4l0NExIhqVIivNIGo9m58Y8NvSG5MAgMoWQgf7Q29sIfH9e+bkG+dGccs1cK9NHWlbLLSiyAshZZzFkbybp7WPGH+nTEuWIuql6SukNmfghIHOXbTFYTfhXMTMvvAxUezeVLK1KDRUcHiCaAvijvpCwjtITJOnk+yKKXxA3WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p95lPrBu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p95lPrBu"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43fde5b81a1so7560566f8f.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 03:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777286538; x=1777891338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZf+eENodM7qckAD5PMHwVmXeXl1XY0tQNsT3S/5/eE=;
        b=p95lPrBuIN1ZhdY5gh4/umxw/QnIvaVA5CY+7MUNpuHCQFb3SxhzDcOpzNOmReLrO1
         XS2dX/GKScgWujWomJV/X9ASCShErnHAbUVs/ZJbogN75CO6A9IpocBoeAw2EubW7Xjd
         gFqqkZ5WA+IQ633GeZYS0UI7Fk2pgjRx7WkP4o9Q0eQFbZsfNuuuEC7fYpdxWWGZV1Y/
         uiAqwwkCDBzS/+gfxghb3riFFAorRQ/YR/r4MzKIX8984bMgbN780xRWLvoTCDRn9DQZ
         JAM/hTIv7UHSy7zGlB6Wp5LoBhxmJm2O/uZvkTOFkxf+4+GrZFQGIkYgJF3IoZpIaFhu
         il/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286538; x=1777891338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pZf+eENodM7qckAD5PMHwVmXeXl1XY0tQNsT3S/5/eE=;
        b=dUCeiF+m1jDvo5Mgn2flgVe9D0+iKrW44Z7zZxPtMWQjLRXHImRLQvqFuVFqY7Acy9
         fByMYThfAM6L4NYC9FcnDg3mdZWTSIgb36jUd6xhYU0nQNBsNG8FKwcBTWciX530egp+
         8nVuHzCHULrj5Pclk2Bqk6y8WNvsEFlhWB9wI0Zo2NGwuOD7nkPTlrRKYCFzK37uYH0M
         CZMkXfmvBcWcO9K7syXGO0fVGB+fipqksARNcCkxnM19ULrb5DV0lRoxauHALcwLWDS3
         UK4nJsgcLR1XJ0mi8Sfl07bjKqgxhFPYGBvg9wid5TD+0PiDvN6JCaoKvRXIRV/X+EjN
         8kWw==
X-Gm-Message-State: AOJu0YzkKO3j5A5v6BP/vbriNgVlK+YJnsXoDsKuHbAcvIVS0lVRzweR
	hV+qk/f2CE4GioYBIc+ykHlIp6MwfjZkx0PcC7DsMu0JQmapyuJL0TGXpjSzrw==
X-Gm-Gg: AeBDieufGtzxRTS5jsF2MX93RtPDeBDqjM6dokhUNXBKOkvBW9NKBsg0XikX53XQRrs
	r+7iaSQHeaCCKU2Sy0660R/k5bHz1B4EOb+8Jk3Ok7kuMjBC6mnN/sycTnvlfV8bxo/XlHEyhRN
	93FVXbGfexOn4yxVWBQ4e47XymZMvzUMXI6cDsXJbsTQsZmxUugLopHY1rlvHOhtUYJAcUoDL9u
	JqbyYE/PyyF++htXaIYynl4/FpTZ24g7th+FNRiW5mBwsRYf62b2G+MOpmUQHxBvZfpuFtFUcR5
	eshIwUvmSZhgRQSL1pl2b1SyCXcuzVb95c1yDgU1vRDRv7plV65N5uTjfu6HvRNDhHIbBsTI3AI
	iXWGemzh4L7nz8Dx6ENXh2vTJzclIhYQf/YLPlg/D5VtajC6OgsSgT2jS61VRjlWcCVZfZLEjjP
	IX6Nk28/TTYbBBUvuceORj+ddYSnf4tpN/sZEGwez+
X-Received: by 2002:a05:6000:1a8e:b0:43f:de5a:eb63 with SMTP id ffacd0b85a97d-43fe3dc0dc4mr62740811f8f.11.1777286537687;
        Mon, 27 Apr 2026 03:42:17 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:5b56:7e7f:83e5:ed3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a7b4sm74231698f8f.22.2026.04.27.03.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:42:17 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 27 Apr 2026 12:42:07 +0200
Subject: [PATCH v3 6/9] update-ref: handle rejections while adding updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-refs-move-to-generic-layer-v3-6-e4638dfb7897@gmail.com>
References: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
In-Reply-To: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, toon@iotcl.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10218;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=r2v28c3wl5d/L0J6UZ8nz+gZ7ctBgxdu59dnQQzsXi4=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnvPYDpNZGMHeBpD67n4wEeI0m5asJNY+p+P
 9ZHIcvHlGjgtIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp7z2AAAoJED7VnySO
 Rox/yRwL/jTHmFeBDG2IX1o6bVuzFwvPG31ViF1VhswGi6xmtYBNqo16q2iFeBA9pdbj5C1dnpk
 HraBD92ufi8xRAJ/LJ9u+YOkFZ5wbhs+ccjaCimkd29zm374ER4ttGeRRcX+gwy7DXRHVwD7pkb
 CZUhPsVaww6UPQyRrsBMsDGfs4Vlz+U/W8rXg2xgFdX8XmST27D878SiJLtQMPduqIg5+GKiv+L
 Kd2LaUBtZ9vSBCrkf8VFn4XYWp9l7HS8HhHXY/NJ2ju/t463JH1nFhH+G18QwjPwW0YIA6om6BC
 75KjwcgAu5gnupW1a5uzyMrjA180EfzVcuEjtwNyOd/2Zy6SlaJtl/Hzs2GpgwAo1ookux+rLeR
 gHrMnkbjmS9cCTLENFFUiC1HGxVmIVdWw/rHDuzAN74zsUJcS68rKi9tDzO4+4bait6KmxRRRWc
 o8asdPyeiaW1h8PUBViPHtjIAeqSU5QT8bAJ51zMU4Ch1DcWdot4WbvvufBADmy838c7tzXbIA6
 w4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When using git-update-ref(1) with the '--batch-updates' flag, updates
rejected by the reference backend are displayed to the user while other
updates are applied. This only applies during the commit phase of the
transaction.

In the following commits, we'll also extend `ref_transaction_update()`
to reject updates before a transaction is prepared/committed. In
preparation, modify the code in update-ref to also handle non-generic
rejections from `ref_transaction_update()`. This involves propagating
information to each of the commands on whether updates are allowed to be
rejected, and also checking for rejections and only dying for generic
failures.

Errors encountered during updates will be shown to the user immediately
unlike other errors encountered only when the transaction is
prepared/committed. As the verification of object IDs and peeled tag
objects will move into `ref_transaction_update()` in the following
commit, this means that those errors will be shown to the user before
other errors, this changes the order of errors, but the functionality
remains the same.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/update-ref.c | 106 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 77 insertions(+), 29 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 5259cc7226..348b7fec94 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -25,6 +25,15 @@ static unsigned int default_flags;
 static unsigned create_reflog_flag;
 static const char *msg;
 
+struct command_options {
+	/*
+	 * Individual updates are allowed to fail without causing
+	 * update-ref to exit. This is set when using the
+	 * '--batch-updates' flag.
+	 */
+	bool allow_update_failures;
+};
+
 /*
  * Parse one whitespace- or NUL-terminated, possibly C-quoted argument
  * and append the result to arg.  Return a pointer to the terminator.
@@ -268,11 +277,13 @@ static void print_rejected_refs(const char *refname,
  */
 
 static void parse_cmd_update(struct ref_transaction *transaction,
-			     const char *next, const char *end)
+			     const char *next, const char *end,
+			     struct command_options *opts)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
 	struct object_id new_oid, old_oid;
+	enum ref_transaction_error tx_err;
 	int have_old;
 
 	refname = parse_refname(&next);
@@ -289,22 +300,35 @@ static void parse_cmd_update(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
-	if (ref_transaction_update(transaction, refname,
-				   &new_oid, have_old ? &old_oid : NULL,
-				   NULL, NULL,
-				   update_flags | create_reflog_flag,
-				   msg, &err))
+	tx_err = ref_transaction_update(transaction, refname,
+					&new_oid, have_old ? &old_oid : NULL,
+					NULL, NULL,
+					update_flags | create_reflog_flag,
+					msg, &err);
+
+	/*
+	 * Generic errors are non-recoverable, so we cannot skip the update
+	 * or mark it as rejected.
+	 */
+	if (tx_err == REF_TRANSACTION_ERROR_GENERIC)
 		die("%s", err.buf);
 
+	if (tx_err && opts->allow_update_failures)
+		print_rejected_refs(refname, have_old ? &old_oid : NULL,
+				    &new_oid, NULL, NULL, tx_err, err.buf,
+				    NULL);
+
 	update_flags = default_flags;
 	free(refname);
 	strbuf_release(&err);
 }
 
 static void parse_cmd_symref_update(struct ref_transaction *transaction,
-				    const char *next, const char *end UNUSED)
+				    const char *next, const char *end UNUSED,
+				    struct command_options *opts)
 {
 	char *refname, *new_target, *old_arg;
+	enum ref_transaction_error tx_err;
 	char *old_target = NULL;
 	struct strbuf err = STRBUF_INIT;
 	struct object_id old_oid;
@@ -341,14 +365,25 @@ static void parse_cmd_symref_update(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("symref-update %s: extra input: %s", refname, next);
 
-	if (ref_transaction_update(transaction, refname, NULL,
-				   have_old_oid ? &old_oid : NULL,
-				   new_target,
-				   have_old_oid ? NULL : old_target,
-				   update_flags | create_reflog_flag,
-				   msg, &err))
+	tx_err = ref_transaction_update(transaction, refname, NULL,
+					have_old_oid ? &old_oid : NULL,
+					new_target,
+					have_old_oid ? NULL : old_target,
+					update_flags | create_reflog_flag,
+					msg, &err);
+
+	/*
+	 * Generic errors are non-recoverable, so we cannot skip the update
+	 * or mark it as rejected.
+	 */
+	if (tx_err == REF_TRANSACTION_ERROR_GENERIC)
 		die("%s", err.buf);
 
+	if (tx_err && opts->allow_update_failures)
+		print_rejected_refs(refname, have_old_oid ? &old_oid : NULL,
+				    NULL, have_old_oid ? NULL : old_target,
+				    new_target, tx_err, err.buf, NULL);
+
 	update_flags = default_flags;
 	free(refname);
 	free(old_arg);
@@ -358,7 +393,8 @@ static void parse_cmd_symref_update(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_create(struct ref_transaction *transaction,
-			     const char *next, const char *end)
+			     const char *next, const char *end,
+			     struct command_options *opts UNUSED)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
@@ -387,9 +423,9 @@ static void parse_cmd_create(struct ref_transaction *transaction,
 	strbuf_release(&err);
 }
 
-
 static void parse_cmd_symref_create(struct ref_transaction *transaction,
-				    const char *next, const char *end UNUSED)
+				    const char *next, const char *end UNUSED,
+				    struct command_options *opts UNUSED)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname, *new_target;
@@ -417,7 +453,8 @@ static void parse_cmd_symref_create(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_delete(struct ref_transaction *transaction,
-			     const char *next, const char *end)
+			     const char *next, const char *end,
+			     struct command_options *opts UNUSED)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
@@ -450,9 +487,9 @@ static void parse_cmd_delete(struct ref_transaction *transaction,
 	strbuf_release(&err);
 }
 
-
 static void parse_cmd_symref_delete(struct ref_transaction *transaction,
-				    const char *next, const char *end UNUSED)
+				    const char *next, const char *end UNUSED,
+				    struct command_options *opts UNUSED)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname, *old_target;
@@ -479,9 +516,9 @@ static void parse_cmd_symref_delete(struct ref_transaction *transaction,
 	strbuf_release(&err);
 }
 
-
 static void parse_cmd_verify(struct ref_transaction *transaction,
-			     const char *next, const char *end)
+			     const char *next, const char *end,
+			     struct command_options *opts UNUSED)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
@@ -508,7 +545,8 @@ static void parse_cmd_verify(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_symref_verify(struct ref_transaction *transaction,
-				    const char *next, const char *end UNUSED)
+				    const char *next, const char *end UNUSED,
+				    struct command_options *opts UNUSED)
 {
 	struct strbuf err = STRBUF_INIT;
 	struct object_id old_oid;
@@ -550,7 +588,8 @@ static void report_ok(const char *command)
 }
 
 static void parse_cmd_option(struct ref_transaction *transaction UNUSED,
-			     const char *next, const char *end UNUSED)
+			     const char *next, const char *end UNUSED,
+			     struct command_options *opts UNUSED)
 {
 	const char *rest;
 	if (skip_prefix(next, "no-deref", &rest) && *rest == line_termination)
@@ -560,7 +599,8 @@ static void parse_cmd_option(struct ref_transaction *transaction UNUSED,
 }
 
 static void parse_cmd_start(struct ref_transaction *transaction UNUSED,
-			    const char *next, const char *end UNUSED)
+			    const char *next, const char *end UNUSED,
+			    struct command_options *opts UNUSED)
 {
 	if (*next != line_termination)
 		die("start: extra input: %s", next);
@@ -568,7 +608,8 @@ static void parse_cmd_start(struct ref_transaction *transaction UNUSED,
 }
 
 static void parse_cmd_prepare(struct ref_transaction *transaction,
-			      const char *next, const char *end UNUSED)
+			      const char *next, const char *end UNUSED,
+			      struct command_options *opts UNUSED)
 {
 	struct strbuf error = STRBUF_INIT;
 	if (*next != line_termination)
@@ -579,7 +620,8 @@ static void parse_cmd_prepare(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_abort(struct ref_transaction *transaction,
-			    const char *next, const char *end UNUSED)
+			    const char *next, const char *end UNUSED,
+			    struct command_options *opts UNUSED)
 {
 	struct strbuf error = STRBUF_INIT;
 	if (*next != line_termination)
@@ -590,7 +632,8 @@ static void parse_cmd_abort(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_commit(struct ref_transaction *transaction,
-			     const char *next, const char *end UNUSED)
+			     const char *next, const char *end UNUSED,
+			     struct command_options *opts UNUSED)
 {
 	struct strbuf error = STRBUF_INIT;
 	if (*next != line_termination)
@@ -618,7 +661,8 @@ enum update_refs_state {
 
 static const struct parse_cmd {
 	const char *prefix;
-	void (*fn)(struct ref_transaction *, const char *, const char *);
+	void (*fn)(struct ref_transaction *, const char *, const char *,
+		   struct command_options *);
 	unsigned args;
 	enum update_refs_state state;
 } command[] = {
@@ -644,6 +688,10 @@ static void update_refs_stdin(unsigned int flags)
 	struct ref_transaction *transaction;
 	int i, j;
 
+	struct command_options opts = {
+		.allow_update_failures = flags & REF_TRANSACTION_ALLOW_FAILURE,
+	};
+
 	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
 						  flags, &err);
 	if (!transaction)
@@ -721,7 +769,7 @@ static void update_refs_stdin(unsigned int flags)
 		}
 
 		cmd->fn(transaction, input.buf + strlen(cmd->prefix) + !!cmd->args,
-			input.buf + input.len);
+			input.buf + input.len, &opts);
 	}
 
 	switch (state) {

-- 
2.53.GIT

