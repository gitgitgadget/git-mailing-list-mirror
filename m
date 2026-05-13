Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DCA33B6EA
	for <git@vger.kernel.org>; Wed, 13 May 2026 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778657484; cv=none; b=J7qwECHvKmRY3Q6G67fZxec0IjeygYz9szsgX7xvER2gF7x2eskSAi/R+fOaykz/wrkoIsEQTOSRjEp/ddpMiQs4bjbGlHAjqYeZRWd27jKcXB7H7yuAbfZlLQuV82EsO8iejLCg1qwK0GtHJh3wjObIg1s0YvvzhHbzKDGDT3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778657484; c=relaxed/simple;
	bh=FJ3gpzSSIDISyRd5y1Y/uBzB29TpfBKb6I/0UHNbvcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ofNgXPVCqkJeqen+9fV6qROqgC/liXUVAwWzFU1teMJsEY1WYsDixfZGqcDHD8HgnluDCGDOhLIG+0MHryx132j5q5lQG430H75sohxGipRL8O2Z/BuI9P9fn2L3Vt/SHahT6/Kw8KkJZ8ZgvqgRh60RuEiz+yK810SrtSNlQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WQOnP2o/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aX8PegOr; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WQOnP2o/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aX8PegOr"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 3B97B1D000CF;
	Wed, 13 May 2026 03:31:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 13 May 2026 03:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778657482;
	 x=1778743882; bh=PckpkPdWoEOiSLPhhBjnNYhfkZla8UuPxu8HSYgfvHk=; b=
	WQOnP2o/fnKqdvrMKMj1n/o8HdIJFXii1fYGj6H4nHH359a7KZmxFxXi4E3OFlpX
	yDl0OWXVV6p1RRU4n4b95tai5SqqXnpw00A6WiuEaeKXgAay3rh6B4vpajqq+gLn
	Imymv2AO6Ziegho4ehHVPKwnixY0vOx9Y1CiF7MumGn24Q0i1aEyF8d8Zf9/tcKc
	sGl2IlC/nqPaxfhmUDm45vKuAjXlWcMfVr40LxaG4N/5s7ELmG0vsAwAUn7fjYzq
	P1YryxHzWcWTOpzDRA1LmINhSvMIQmQqYsv9UPBZy4aZL2Ub9JtdI1EEsUt7qMa6
	KvvQxtteVqB2AJmxL9wV2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778657482; x=
	1778743882; bh=PckpkPdWoEOiSLPhhBjnNYhfkZla8UuPxu8HSYgfvHk=; b=a
	X8PegOrfOwPJR5OhpZCeAcDimPjdcw1z2tGZrSQiA1cFQkwJpGyetbe+QmmO3WIt
	xsQ380B23BHLUHmtH8/bOpqIv1dnmpHzFNUyAnLTIMiaF7o9YqP9qjb3lMitfE0Z
	G0KBFoKm9u+5gYiY4/DO6WrC+vpvbRRbCEbRJzJpYr+Vs+wMz8TVNnTxJVS6G6yg
	R43u1FNSbRyEBYmsoHXDe/6sEWsaUEFp4pofZYIootH2sEYdX4+NGSWMNeuLLAzu
	uTNkwkimPBm4CllAkJYKD1mkCrMTXfQ6wZ3n4vNOhNKa04MfrLTTlzGmuPxDqKEy
	rHK9R2YFMdlcYz0YBbzjw==
X-ME-Sender: <xms:ySgEanBnCzRpDTE--cmjW7HFWely6JgZGQydBYXzxRePVyYv5WzoFA>
    <xme:ySgEavyu1-HVqDDk2gLD8PxFsSyM6cZivR92js47s8jk-P86CMTYj5W34f8wzb2tP
    W8-VLV6UfhTNj2UnM9OdL4N1lV7ftK5XXKGD2jKtQA301Pf2C69ww>
X-ME-Received: <xmr:ySgEak3Fn7PI0tRQ9vge1h3A6v9UfFmrNnqZ4mjb-vqsYHr6VFvM1NZnEsc-v70rmPYdBgNwjf7i1cXd0e32UxEBL49EDchGIygYUnRSNdI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhhikhgrtghhuhesgh
    hmrghilhdrtghomhdprhgtphhtthhopegrtghtihhonhhmhihsthhiqhhuvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ySgEavyd9T2Jntf1L4TivANllikurFjy5gXpGVccF5Arelb_hHotrg>
    <xmx:ySgEarGAiYGLSSuU7JuZnXrewSvS2v_EDwrrhLp4wpIYQ712lINe2w>
    <xmx:ySgEaiYxpCQqi5yiUtJ68KfTYiGy7f4r5i9IISZpRXoohRu5uGJvEg>
    <xmx:ySgEatBs89QBKgWTEIpjUcv60nSTq6_kzO3cjRt0TSfS6hera0rxLQ>
    <xmx:yigEapYfCxifvb0bD9Ayi1Tj5TChGH2IrGag7bHFMnBWXi-cJ3pmRE5r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 03:31:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2db00774 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 May 2026 07:31:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 13 May 2026 09:31:13 +0200
Subject: [PATCH v3 1/2] builtin/maintenance: fix locking with "--detach"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-pks-maintenance-fix-lock-with-detach-v3-1-f27a1ac82891@pks.im>
References: <20260513-pks-maintenance-fix-lock-with-detach-v3-0-f27a1ac82891@pks.im>
In-Reply-To: <20260513-pks-maintenance-fix-lock-with-detach-v3-0-f27a1ac82891@pks.im>
To: git@vger.kernel.org
Cc: Jean-Christophe Manciot <actionmystique@gmail.com>, 
 Mikael Magnusson <mikachu@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When running git-maintenance(1), we create a lockfile that is supposed
to keep other maintenance processes from running at the same time. This
lockfile is broken though in case the "--detach" flag is passed: the
lockfile is created by the parent process and will be cleaned up either
manually or on exit. But when detaching, the parent will exit before all
of the background maintenance tasks have been run, and consequently the
lock only covers a smaller part of the whole maintenance process.

Fix this bug by reassigning all tempfiles from the parent process to the
child process when daemonizing so that it becomes the responsibility of
the child to clean them up.

Note that this is a broader fix, as we now always reassign tempfiles
when daemonizing. This is a natural consequence of the semantics of
`daemonize()` though, as it essentially promises to continue running the
current process in the background. It is thus sensible to have that
function perform the whole dance of assigning resources to the child
process, including tempfiles.

There's only a single other caller in "daemon.c", but that process
doesn't create any tempfiles before the call to `daemonize()` and is
thus not impacted by this change.

Reported-by: Jean-Christophe Manciot <actionmystique@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Derrick Stolee <stolee@gmail.com>
Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c                | 16 +++++++++++++-
 setup.h                | 15 +++++++++++++
 t/t7900-maintenance.sh | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tempfile.c             | 12 +++++++++++
 tempfile.h             | 11 ++++++++++
 5 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 7ec4427368..14445a71a4 100644
--- a/setup.c
+++ b/setup.c
@@ -2162,12 +2162,26 @@ int daemonize(void)
 	errno = ENOSYS;
 	return -1;
 #else
-	switch (fork()) {
+	pid_t parent_pid = getpid();
+	pid_t child_pid = fork();
+
+	switch (child_pid) {
 		case 0:
+			/*
+			 * We're in the child process, so we take ownership of
+			 * all tempfiles.
+			 */
+			reassign_tempfile_ownership(parent_pid, getpid());
 			break;
 		case -1:
 			die_errno(_("fork failed"));
 		default:
+			/*
+			 * We're in the parent process, so we drop ownership of
+			 * all tempfiles to prevent us from removing them upon
+			 * exit.
+			 */
+			reassign_tempfile_ownership(parent_pid, child_pid);
 			exit(0);
 	}
 	if (setsid() == -1)
diff --git a/setup.h b/setup.h
index 80bc6e5f07..b5bc5f280c 100644
--- a/setup.h
+++ b/setup.h
@@ -149,6 +149,21 @@ void verify_non_filename(const char *prefix, const char *name);
 int path_inside_repo(const char *prefix, const char *path);
 
 void sanitize_stdfds(void);
+
+/*
+ * Daemonize the current process by forking and then exiting the parent
+ * process. Returns 0 when successful, in which case the parent process will
+ * have exited and it's the child process that continues to run the code.
+ * Otherwise, a negative error code is returned and the parent process will
+ * continue execution.
+ *
+ * Note that this function will also perform the following changes:
+ *
+ *   - Standard file descriptors in the child process are closed.
+ *   - The child process is made a session leader via setsid(3p).
+ *   - All tempfiles owned by the parent process are reassigned to the
+ *     daemonized child process.
+ */
 int daemonize(void);
 
 /*
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 4700beacc1..df0bbc1669 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -1438,6 +1438,64 @@ test_expect_success '--no-detach causes maintenance to not run in background' '
 	)
 '
 
+test_expect_success PIPE '--detach holds maintenance lock until daemonized child exits' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		git config maintenance.auto false &&
+		git config core.lockfilepid true &&
+
+		git remote add origin /does/not/exist &&
+		git config set remote.origin.uploadpack "cat fifo-uploadpack" &&
+
+		mkfifo fifo-uploadpack fifo-maint &&
+
+		# Open the maintenance FIFO, as otherwise spawning
+		# git-maintenance(1) would block. Note that we need to open it
+		# as read-write, as otherwise we would block here already.
+		exec 9<>fifo-maint &&
+
+		{ git maintenance run --task=prefetch --detach 7>&9 & } &&
+		parent="$!" &&
+
+		# Reap the parent process so that the exec call below will not
+		# get SIGCHLD.
+		wait "$parent" &&
+
+		# Open the git-upload-pack(1) FIFO for writing, which will
+		# block until the upload-pack script opens it for reading. Once
+		# exec returns, we know that the daemonized child is alive and
+		# pinned.
+		exec 8>fifo-uploadpack &&
+
+		test_path_is_file .git/objects/maintenance.lock &&
+		test_path_is_file .git/objects/"maintenance~pid.lock" &&
+
+		# Verify that the maintenance.lock still exists, and
+		# that it was created by the parent process, not the
+		# child.
+		echo "pid $parent" >expect &&
+		test_cmp expect .git/objects/"maintenance~pid.lock" &&
+
+		# Reopen the maintenance FIFO as read-only so that
+		# git-maintenance(1) is the only writer. This will cause it to
+		# close the FIFO once the process exits.
+		exec 9<&- &&
+		exec 9<fifo-maint &&
+
+		# Close the FIFO used by git-upload-pack(1) to unblock it and
+		# then wait until the maintenance FIFO is closed by
+		# git-maintenance(1), indicating that it has exited.
+		exec 8>&- &&
+		cat <&9 &&
+
+		test_path_is_missing .git/objects/maintenance.lock &&
+		test_path_is_missing .git/objects/"maintenance~pid.lock"
+	)
+'
+
 test_expect_success '--detach causes maintenance to run in background' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
diff --git a/tempfile.c b/tempfile.c
index 82dfa3d82f..f0fdf58279 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -373,3 +373,15 @@ int delete_tempfile(struct tempfile **tempfile_p)
 
 	return err ? -1 : 0;
 }
+
+void reassign_tempfile_ownership(pid_t from, pid_t to)
+{
+	volatile struct volatile_list_head *pos;
+
+	list_for_each(pos, &tempfile_list) {
+		struct tempfile *p = list_entry(pos, struct tempfile, list);
+
+		if (is_tempfile_active(p) && p->owner == from)
+			p->owner = to;
+	}
+}
diff --git a/tempfile.h b/tempfile.h
index 2d2ae5b657..2227a095fd 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -282,4 +282,15 @@ int delete_tempfile(struct tempfile **tempfile_p);
  */
 int rename_tempfile(struct tempfile **tempfile_p, const char *path);
 
+/*
+ * Reassign ownership of all active tempfiles whose `owner` field matches
+ * `from` to `to`.
+ *
+ * This is intended for use by `daemonize()`; after `fork(2)`-ing, the parent
+ * transfers ownership to the daemonized child so that its atexit handler does
+ * not unlink tempfiles that should outlive it, and the child claims the
+ * inherited tempfiles so that they are cleaned up when the daemon exits.
+ */
+void reassign_tempfile_ownership(pid_t from, pid_t to);
+
 #endif /* TEMPFILE_H */

-- 
2.54.0.709.gd731d7959a.dirty

