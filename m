Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648C8356764
	for <git@vger.kernel.org>; Tue, 12 May 2026 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574645; cv=none; b=hxc6jSalupxbDtiNHQ9/dFJ4DaK1+d6jLqEfv0cc6CX5ZqPeMir76FMbbT/Xa0clsF+HkqjVD+o7gFnYgmZvEnQV4OHlippnzq6hcdPf+o6cbPFtTgXe+o/huYd74KOVux8hrN3sgtIaJsVJbRgdTS4LVO/ghl5sDLlItFTqqDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574645; c=relaxed/simple;
	bh=pfPztXRj+RQcZnl1E0HxHVTytWxLFxh0FU0DDuNfhYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LCUQmp/Bu1zxGDE6jqWxwhnAX8svZkgtnCqNEMIJjPAxUGz27eVMmk9EDk4L7bYKnycWqm3nrysoHDd3P/iaagCCnpGU3+V0eCnk5qxqnZj1w6TI3QxPKOhMUvyh1BqkHrPtPr7/hwHQrpNPiaLcCj9epOhCnn+qciF96uqqQqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CPFDKBBN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iHCg9/Hc; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CPFDKBBN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iHCg9/Hc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6EF77EC020E;
	Tue, 12 May 2026 04:30:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 12 May 2026 04:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778574641;
	 x=1778661041; bh=Jljj8/ZDYBg0AprbsAm0KizkeZKEmoT1Ws28FpdIwJo=; b=
	CPFDKBBN7uCS1ZKyZFk6J6DZ0+Bxs951WX/qQCRqfjsKZGx07ZNTkfeMnPMh6jEi
	fzl5Hk2a7xU16MSI607Br8BOj4WOu81emKowaEmbYwvHSYkDCWkLGG2s43O+Qt02
	zmG7p3fCqlAhgziXauCvpMG/yXmV2OrGgNiODd/QbNPwuFPRgRXJ43bA+4vrBhai
	grKEoV3hFE2Is6T4BfeD7tVY1Rmi2Akx4bEV4LTJeShqxgeT5HwryFERoCs+kcED
	OXvbngxzaMkXaSTWXOqR/Di6nkkQTQXo9IocZNKfoO3Yx54ULHN/9fk7aIw90ywE
	9mjjz+vWPtTHgMOPUXAmKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778574641; x=
	1778661041; bh=Jljj8/ZDYBg0AprbsAm0KizkeZKEmoT1Ws28FpdIwJo=; b=i
	HCg9/HctVxSEFQU1DJiQoN+qFFT0oCH8+Z4BGLmsWAWP+31HMzWTIRlo0nIZebYc
	sO5Ll/7VoZ6xAsfteym9r9z4fpedJpLfytIWDIPVEl33KJx9g9atHdJunPb2O7wr
	FXrYGj6xmxoNBGMb8MWFhAzUVwZNF7nPc6RC0XFogmwTo1ClMswj6SaJZYj9DV31
	3NhRBxHXemU02SsCqYfJwYBt8eASvMKutjV2oq55Af1OIukkO/iWzGIud42CDqkU
	zBPjgRO9JRX3of+p+5sMcKJgZrN4Ig+S+TM3iVlpBtlFW27TVt7bMyX7ruJ73gfc
	CJ2JSD94ZSsZol9NfKvPA==
X-ME-Sender: <xms:MeUCany6TWFPs6Y6olK2CgMMzBTU8AJkPF4EsVBwIdMbbpxcp9kh8w>
    <xme:MeUCahjTwbT-wCQuP_DWXZXs4FOmI6rON6xkkiyxK5RCmM2NEJbist9_-R6i6ijJN
    2AEyMWncAzglqfXZBaOETp-I_qcqxf9Xl-6iTlJLig9hPQAmOzv>
X-ME-Received: <xmr:MeUCajlNkm_odwrvBEg7hPhvd7ZT6o_et-5QRjpu2KC0G1itRn5MgHeM9OT43VijNT9md9ZKSWcfA80uic1DhlDvU-flCrH2-p5KWlBmRgk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddufeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggtthhioh
    hnmhihshhtihhquhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhikhgrtghhuhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:MeUCaniF5x_uy5XtN7FKFetVgwWSS96ntNB11UAGJk_uqE9FuVdXfA>
    <xmx:MeUCan140vm7-8JcsAL_ujAkpPS8RL4vCrY5I7hho8Ml9PZI7hchcg>
    <xmx:MeUCagL7ZkKjRvK54XDGZ-JGyEQGb6MZ4OOrSu2qkzfwUIdn2SvKLQ>
    <xmx:MeUCanwHD2EXwZQrcUS5Mv-osNYYmekByYl7-2qhtGEG3Mr-1J6OAQ>
    <xmx:MeUCaujtDKkPpf3UhhuyqN9KEz6bybnCwPh6FxovPp1BzciWVYUwN5fB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 04:30:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 83a5f253 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 May 2026 08:30:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 May 2026 10:30:30 +0200
Subject: [PATCH v2 1/2] builtin/maintenance: fix locking with "--detach"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-pks-maintenance-fix-lock-with-detach-v2-1-dc6f2d284b6d@pks.im>
References: <20260512-pks-maintenance-fix-lock-with-detach-v2-0-dc6f2d284b6d@pks.im>
In-Reply-To: <20260512-pks-maintenance-fix-lock-with-detach-v2-0-dc6f2d284b6d@pks.im>
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
 builtin/gc.c           | 27 +++++++++++++++++++++--
 lockfile.c             |  9 ++++++++
 lockfile.h             | 10 +++++++++
 setup.c                | 31 +++++++++++++++++++--------
 setup.h                |  1 +
 t/t7900-maintenance.sh | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 125 insertions(+), 11 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 3a71e314c9..d866c19b92 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1810,10 +1810,33 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
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
+			 * We're in the parent process, so we drop ownership of
+			 * the lockfile to prevent us from removing it upon
+			 * exit.
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

