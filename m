Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB033D3498
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 21:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787176400; cv=none; b=GL+emgXonfEDQZY5dzBycfIozh06PLPD712rfNK6mkhcxBmPiH66IC8Dy95KyZwN5Bo4S9eQ3QJsGocmhNyKlW6ztRGFBOBJ8Yxx6GHcazdBF84yIdBYYlKLXPAssozqZmU5iIiZ/7cxEUgIj0PDP7IPCpGP/b6R+k5rbV8PtnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787176400; c=relaxed/simple;
	bh=6esPZhfhBJ/pPmhtRbHwkxmsO/ueCzCM5ah5wC47u4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLOLC4QlZsJVdDRCFoEuKmRv+T+10NdqceWEhCqalYhzSLOphXl8cNo76DQALBSNBpdZT2a+FvLQO5Rd6nj6Ix4K6Msr1LqLbpezfUukqiHw+H4rJm6n9vT+KhA9nL298S7d5o+zEKBT82fEtfe+dzbrv0m3Jmkbt0TNdWOKdv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPbwPdMP; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPbwPdMP"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7f3ece23165so1281313a34.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 14:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787176397; x=1787781197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xWUDkIUnTdPELypxsRrdem7faCnjLouHaKzyxQxPqaE=;
        b=YPbwPdMPMGixNwcMYHIsOXj8cdRNvM+pwJxLlNKvUmkmq3KIqYmzszRw6uceisjgYQ
         4JNidj9Tavu9EcWhTIbR5R4bCXGKCZDqGdS1VczY5p4vseK3B3RDxSZjqbgNh1SehWad
         nemNfhGv9jXxmM4na96enVilm2ip4N+dwwu7I9VvMJxA+7okyHDG+HD0QQuuI7bqz0hY
         P3fTAXAcfg54F5/stoSfYt3Ms+wSVld27kbrGDuBTYiO7aeS3ZwZgDptHGiqEUyqXiPJ
         wPDjPlPJQxQwKxHyd/g+yoX+1IxhXLMnyQ/iYboBVb2k5Z0cz0heNYrdBk78l6FKti9g
         Y3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787176397; x=1787781197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xWUDkIUnTdPELypxsRrdem7faCnjLouHaKzyxQxPqaE=;
        b=HWZR62JadZ5ZO746swU3SmrlGpJJEB5IwWvET099fQH9zXx6mSJphn5Wcs6J2j73OE
         euKRhayV7CVup4zpPbg/XmELOgxHzSKdQCRb8zdemSSNDcj7Ha5FNQkjK1sXlpji7OqD
         Y1ScCBhtJORHAgNBAG0NIdw8J9dzxchTzTTOR8ItSvJUD/BFYlLz0D0C39Nm/wMoFZdz
         avCWs4bp6DV/3yQkurjMfSJ/2yiJtTqD1PqWtGonOXHndK9JIODk4ltRVrEoUmZ50oX6
         m882NnmyOmCx27IGby+15U/gH5b4g3jutWOF6Srif9cTyhEwWepdBq13llaNv4hStAlJ
         Cnaw==
X-Gm-Message-State: AOJu0YxwCZ+8J4VQ5BZgk9IJo6CqyGvkuMC52YHJhr79mTD/HMZmOl5T
	PsKQUrmmMHtptE5v8VmxMzHfwAoQRWYo5Djh+DBbHgmVNEDPOye744GewlHtWA==
X-Gm-Gg: AR+sD11JNbFUOTTSrFvm4g5aXxywLHxKj25bjjTiZOBOaIwvHkUcerXey4P0A4s4SDL
	9qH1ANgp2jyU9LU73mRUGtnStsEqlgNLarLfylXy7mLYr2+3o4USwB6fW7ff5ZTMhzlGRCRh5TW
	77jqqGXBwuWZEen+9TmrDkjRhR7aqmJ4Hfunb4ykqxfJi1031eV/rjsUoz8igoD3P4m+RvQ+SA+
	Bw8E+EP0d7HOi2Jb6PbDaNUijhDNNiJyWfzyYYREavyjzi4Z1iwZhGFYs8o2c3/s68/LNP0WBSW
	Rkr9E36v4Y9vTIy1Y+eKqUjqI3upO8TtJj4aWpcTLb7YVETEWXQ3XC4EqWrUJZEMdLMMOTeecNI
	zhRppLHxynjKMjJW1bBWlgPdVnogEiS9ObqduTUCi8BBdJdJhDOqmlqBTW5c7GB4ekr8SjRlRQt
	CUJZnDYvuduZTK6r4/7DavYXEPjmBxMKr+yCHA+02bCQGJMuxOa0JjUqvUwL2DMFhpSMTh
X-Received: by 2002:a05:6830:498f:b0:7ea:b8c:4198 with SMTP id 46e09a7af769-7f43f9d07c0mr9393272a34.8.1787176397594;
        Wed, 19 Aug 2026 14:53:17 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f43fe7029dsm2718026a34.2.2026.08.19.14.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:53:17 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 5/9] builtin/receive-pack: lift global state out of unpack()
Date: Wed, 19 Aug 2026 16:53:07 -0500
Message-ID: <20260819215311.3880274-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260819215311.3880274-1-jltobler@gmail.com>
References: <20260811175415.2044235-1-jltobler@gmail.com>
 <20260819215311.3880274-1-jltobler@gmail.com>
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
index 971dc3f52e..f062b93b8d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2330,18 +2330,24 @@ static unsigned int get_unpack_limit(struct repository *repo)
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
@@ -2350,9 +2356,9 @@ static const char *unpack(struct odb_transaction *transaction,
 		return hdr_err;
 	}
 
-	if (shallow_file) {
+	if (opts->shallow_file) {
 		strvec_push(&child.args, "--shallow-file");
-		strvec_push(&child.args, shallow_file);
+		strvec_push(&child.args, opts->shallow_file);
 	}
 
 	odb_transaction_env(transaction, &child.env);
@@ -2360,14 +2366,14 @@ static const char *unpack(struct odb_transaction *transaction,
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
@@ -2388,18 +2394,18 @@ static const char *unpack(struct odb_transaction *transaction,
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
@@ -2431,11 +2437,23 @@ static const char *unpack(struct odb_transaction *transaction,
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
@@ -2444,7 +2462,8 @@ static const char *unpack_with_sideband(struct odb_transaction *transaction,
 	if (start_async(&muxer))
 		return NULL;
 
-	ret = unpack(transaction, shallow_file, muxer.in);
+	opts.err_fd = muxer.in;
+	ret = unpack(transaction, &opts);
 
 	finish_async(&muxer);
 	return ret;
-- 
2.55.0.424.g13c7afec21

