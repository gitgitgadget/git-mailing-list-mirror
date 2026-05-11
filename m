Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA063E5EFF
	for <git@vger.kernel.org>; Mon, 11 May 2026 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502610; cv=none; b=SFUrz9tXAwZQdLm6PtHIljBcmL60+GTu1yGGD5WOc4ZoEVUMQp22Vs5AGUV1DQT31vrEPDh5VSNlB7pofsCgcrKgIbREvvuDmv3uUheWcrJQYey+K7Zz+mDXjR1RQnrs62Uc621njTPZSVVVyPVF7YUzk2IIGn9fLB0nORN5ZCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502610; c=relaxed/simple;
	bh=TnSnYOfGsj4ubU5YVw+rgfD49kv/4ws6M6r6FBr674w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XhYvvbFhqFHl4wlcSbgQYEEMl8CbrX+0+gDeuamtA3EDoPjZ+lKtKfYkDvngo7ZIplxpEZkvhvSCVRRJAhfU9XnIn9Hhbdic5sLW4tyN6FkasfOGH9bjkIbUoLEVxm4gZ3NH90VL1sDncXmq4Kc8ZpYY5dKupfk0IGwP2ZMp9Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H1gg+pxv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vmV6W6KU; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H1gg+pxv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vmV6W6KU"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id E64241D0011B;
	Mon, 11 May 2026 08:30:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 11 May 2026 08:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778502607;
	 x=1778589007; bh=Ht/RAe/txQBp2+jbYEIDGdaR/1JF/bAaGzZNB6ftog4=; b=
	H1gg+pxvkdHpibg4ePFg3z4BOwB62q4Hk0YPBbG2f/0E2PUevkiVq9g+N8RuhwC6
	8OfO1hqng/ZQsE0gi8Pl1zDXVTmIcNMkafrKgpULBaDJqiKftGALUk0YKy/FQvFx
	bi4iYeMRwV6EPVw2I1yPOMlt2scC3U6sou+mIOyK0f4UuSzJZWE+BAB774qCmUjR
	/2kxrJIdTFJalMs9BIGVO1U9lRdEYlKpfEhvJADDPjr3/HIRb1uhHNc3X7iCYCCN
	CB0wdw8dQCkssbzR7CMbs1O2YdDq3A5hReWPkDIVkaauMEiimpBrmD5E9nTvQVdp
	dSYCkAaPMHftdrQxqaa6xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778502607; x=
	1778589007; bh=Ht/RAe/txQBp2+jbYEIDGdaR/1JF/bAaGzZNB6ftog4=; b=v
	mV6W6KUdN9qon1hse+7mrsBUiLilqR6oHYA03ekBnlCU+KEwAAcLVYojeIOpXm6r
	eumkkYchHVRKzbv+Kj8O7xCPxkzujfbn+VgLWs9QPBPMW7Wj+28d8GbmUvWCggIV
	zqYdQEsvZN++shthjAdgPYFjF+yxAHfn2EfZ/tTFrAvCWGYysaml+R1RDnWBpSa3
	afJSf/xUmpnMUSNA9TKbHzqqN454VKrxVUJUkH/E/tZrYzr86i+mfm/rUFEMB0Eh
	S8KKfxk0XL6keJCVEhk8mpaLMcC6j1NPb/5Fga+6Vs2PqPgv4WEMbClxjuOSDf/j
	WsoADO4pi6bBQJ5RQ9USQ==
X-ME-Sender: <xms:z8sBalCPNBlicmMiUAjAhYagAEy3Jz3hUdukL-8O8iKIdXOXls8TJQ>
    <xme:z8sBanMmVGlDr9qDvd18TNzdXbXeZecU1UyH9PhTm2DJnwT9-o4QyvPLNcxR6OlEq
    HhMMi21suxeeRk2w2nlWfUirfZD1zLw3NVMI2QP0qqrBljvUXFUJA>
X-ME-Received: <xmr:z8sBaqYLJ-gQEenxqp7k6YE8yMU1WibBKSh5W2_i43ZMW8yx4tHxZdxYqyrLOXsR2Uiayxj3Op_5fBtkhUBSb7-dO7WLZ7Opvl5DzfSS0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihhkrggthhhusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrtghtihhonhhmhihsthhiqhhuvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomh
X-ME-Proxy: <xmx:z8sBamuJDILfnUapacx0YvOYDb7HScqHaFDkklbKCpdnzCZzr4I7Zw>
    <xmx:z8sBasNz5oFlowjI3RoZmfotkcuxzbvHbpdfUhXsJQPhUrUyc2Kdpg>
    <xmx:z8sBat6aFLxODXTd3kBkyQ-lgDaXuBUpMqM9O92B7lrEJ7rL3gopUg>
    <xmx:z8sBaiTbme7Pl2OtI2cjQ6WAizxtrTiDHes4q03N9jpd_QilFCuATQ>
    <xmx:z8sBarf6LiUSW6haswOwt8DPk-Yg3_AmKGSQB50L03Dt0QUYZ9NcXEIO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 08:30:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 00f28584 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 May 2026 12:30:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 May 2026 14:29:55 +0200
Subject: [PATCH 1/2] builtin/maintenance: fix locking with "--detach"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-pks-maintenance-fix-lock-with-detach-v1-1-ccd7d62c9a40@pks.im>
References: <20260511-pks-maintenance-fix-lock-with-detach-v1-0-ccd7d62c9a40@pks.im>
In-Reply-To: <20260511-pks-maintenance-fix-lock-with-detach-v1-0-ccd7d62c9a40@pks.im>
To: git@vger.kernel.org
Cc: Jean-Christophe Manciot <actionmystique@gmail.com>, 
 Mikael Magnusson <mikachu@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>
X-Mailer: b4 0.15.2

When running git-maintenance(1), we create a lockfile that is supposed
to keep other maintenance processes from running at the same time. This
lockfile is broken though in case the "--detach" flag is passed: the
lockfile is created by the parent process and will be cleaned up either
manually or on exit. But when detaching, the parent will exit before all
of the background maintenance tasks have been ran, and consequently the
lock only covers a smaller part of the whole maintenance process.

Fix this bug by introducing two new functions:

  - `daemonize_without_exit()` is the same as `daemonize()`, but doesn't
    call exit(3p) for the parent process.

  - `lock_file_reassign_owner()` reassigns the owner of its owned
    tempfiles so that they don't get unlinked anymore when the previous
    owner exits.

Together this allows us to reassign ownership of the lockfile after we
have daemonized so that the lockfile is now owned by the child process.

Reported-by: Jean-Christophe Manciot <actionmystique@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Taylor Blau <me@ttaylorr.com>
Helped-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c           | 26 ++++++++++++++++++++--
 lockfile.c             |  9 ++++++++
 lockfile.h             | 10 +++++++++
 setup.c                | 31 +++++++++++++++++++--------
 setup.h                |  1 +
 t/t7900-maintenance.sh | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 124 insertions(+), 11 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 3a71e314c9..09cb92ac97 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1810,10 +1810,32 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 				   TASK_PHASE_FOREGROUND))
 			result = 1;
 
-	/* Failure to daemonize is ok, we'll continue in foreground. */
 	if (opts->detach > 0) {
+		pid_t child_pid;
+
 		trace2_region_enter("maintenance", "detach", the_repository);
-		daemonize();
+
+		child_pid = daemonize_without_exit();
+		if (!child_pid) {
+			/*
+			 * We're in the child process, so we take ownership of
+			 * the lockfile.
+			 */
+			lock_file_reassign_owner(&lk, getpid());
+		} else if (child_pid > 0) {
+			/*
+			 * We're in the parent process, so we assign ownership
+			 * of the lockfile to the child and then exit immediately.
+			 */
+			lock_file_reassign_owner(&lk, child_pid);
+			exit(0);
+		} else {
+			/*
+			 * Failure to daemonize is ok, we'll continue in
+			 * foreground.
+			 */
+		}
+
 		trace2_region_leave("maintenance", "detach", the_repository);
 	}
 
diff --git a/lockfile.c b/lockfile.c
index 7add2f136a..96aab3c885 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -356,3 +356,12 @@ int rollback_lock_file(struct lock_file *lk)
 	delete_tempfile(&lk->pid_tempfile);
 	return delete_tempfile(&lk->tempfile);
 }
+
+void lock_file_reassign_owner(struct lock_file *lk, pid_t owner)
+{
+	if (!is_lock_file_locked(lk))
+		BUG("cannot reassign ownership of unlocked lockfile");
+	lk->tempfile->owner = owner;
+	if (lk->pid_tempfile)
+		lk->pid_tempfile->owner = owner;
+}
diff --git a/lockfile.h b/lockfile.h
index e7233f28de..0b10b624fa 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -341,4 +341,14 @@ static inline int commit_lock_file_to(struct lock_file *lk, const char *path)
  */
 int rollback_lock_file(struct lock_file *lk);
 
+/*
+ * Reassign ownership of the lockfile to a different process.
+ *
+ * This is intended for use after `fork(2)`-ing. The parent transfers ownership
+ * to the daemonized child so that its atexit handler does not unlink the lock
+ * that should outlive it, and the child claims the inherited tempfiles so that
+ * they are cleaned up when the daemon exits.
+ */
+void lock_file_reassign_owner(struct lock_file *lk, pid_t owner);
+
 #endif /* LOCKFILE_H */
diff --git a/setup.c b/setup.c
index 7ec4427368..34deb6e985 100644
--- a/setup.c
+++ b/setup.c
@@ -2156,20 +2156,18 @@ void sanitize_stdfds(void)
 		close(fd);
 }
 
-int daemonize(void)
+pid_t daemonize_without_exit(void)
 {
 #ifdef NO_POSIX_GOODIES
 	errno = ENOSYS;
 	return -1;
 #else
-	switch (fork()) {
-		case 0:
-			break;
-		case -1:
-			die_errno(_("fork failed"));
-		default:
-			exit(0);
-	}
+	pid_t pid = fork();
+	if (pid < 0)
+		return -1;
+	if (pid > 0)
+		return pid;
+
 	if (setsid() == -1)
 		die_errno(_("setsid failed"));
 	close(0);
@@ -2180,6 +2178,21 @@ int daemonize(void)
 #endif
 }
 
+int daemonize(void)
+{
+#ifdef NO_POSIX_GOODIES
+	errno = ENOSYS;
+	return -1;
+#else
+	pid_t pid = daemonize_without_exit();
+	if (pid < 0)
+		die_errno(_("fork failed"));
+	if (pid > 0)
+		exit(0);
+	return 0;
+#endif
+}
+
 struct template_dir_cb_data {
 	char *path;
 	int initialized;
diff --git a/setup.h b/setup.h
index 80bc6e5f07..396af8d808 100644
--- a/setup.h
+++ b/setup.h
@@ -150,6 +150,7 @@ int path_inside_repo(const char *prefix, const char *path);
 
 void sanitize_stdfds(void);
 int daemonize(void);
+pid_t daemonize_without_exit(void);
 
 /*
  * GIT_REPO_VERSION is the version we write by default. The
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

-- 
2.54.0.545.g6539524ca2.dirty

