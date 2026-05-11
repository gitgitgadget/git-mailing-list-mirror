Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F775331218
	for <git@vger.kernel.org>; Mon, 11 May 2026 06:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778481744; cv=none; b=iil19ECUxY343VKwrhxemRCNvbb+gMdMTfhifk+mnmenRs9fynk1lKPBkzNOqpvnH/TTdOLFBEMzBx1/DIQ717symMrDdVu8iMqS2jUH40P3ybCtRh0SHYBSDZ+g+4a9DHrHWBtpoQCh+IEpciA/F67k7fM7b/WQw1pUh4ENM+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778481744; c=relaxed/simple;
	bh=oePE+KJhR+tNarn7r1wgY8a9vX8XTBYFCxzjtqVF87o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uF73fxjUAwuQmMcNlhDR61DnlN8hYl9XgiznK5DgPjUPZ5wE6lfHef8IJi/H19FioLjFsBmSbdB9ZQPJ4wFAaTjev5I7ULjpp9sf7L31jbOdjnrISJdPwIwuiMT4XUVOiOMqYLLauPAytde/vCGFetfQlo8yMjYAIjkRmQkXt+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HPLPjn1Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JUS07psZ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HPLPjn1Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JUS07psZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4676BEC005A;
	Mon, 11 May 2026 02:42:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 11 May 2026 02:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778481742; x=1778568142; bh=jmHOksm9Km
	dyn/kgbexHhtuEb9XC3ObZmsm9Ro5bAqc=; b=HPLPjn1ZA3DKtlsGzL1ZepXr1s
	F+Ysv2TsRbD/9dFG2e4jXG8V4/GNA2Doen3F7cL9vaXXtpvCMSQhHBMnE+QU8ucs
	iUE9ISwlyPi9+RzIUMhPQeNN21NytCsRWlTpPhT/h8xFS8dmrEfAHX+22WNqY97p
	lYgwEMs8gvrcGdkOCKDE8VYuhsd+PLUriXJDRa6MniFRsu9zBwzmhcj/eigb6/p3
	EneXbQA0lTGeaikHlP1Hb7pB0LUvLAJmn2RSYNFoUfQoKBts6VkE4nVj0SKeHmPs
	pL9kBQ3V5guYuB80KRnG+bYoXcV8WPJItVwxr6to7QIjL1VYsSyjxXduoP7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778481742; x=1778568142; bh=jmHOksm9Kmdyn/kgbexHhtuEb9XC3ObZmsm
	9Ro5bAqc=; b=JUS07psZYc5ifhmaNaTpgRHCHZV/mNA6Q4O/8Mv6mz2syTVQYtA
	f9OHTl1Y42lZlPqWjt9791mw5AQTB5yzw3YUvSCCYyFCUQ0UDsXR67sdxiaG36iW
	NfGSdOIxOGEU4et7+QVBfIzp+HOYomxmvER93kyUwwJA/ZDOx70Q75dJbHNRAxM8
	7HBW8HXL6Vi+3FYn1vIqN2dtPnPHDJivk6EdvmxikJvUaES/ohXYLx9BQLAZd93g
	axFaI/jSq8GPBvYcvng6llmBdI8ji59an/KLPKOQ/dVxDwbol/e4+xP8KNk9zmVS
	N1uzyJASHzVxgLUNCyNtE7T4F78gnNcA4/A==
X-ME-Sender: <xms:TnoBasOo5anrPBpAs0c1gRaxCstYKF26ymWpUhYYdhh1SbQBKe32FQ>
    <xme:TnoBap3zWHWXbBVah7ztGaf13UVsBsK09NIkFsx6UPze2Ye76vZ2Dlh_NqsH7cc3i
    d3gLUusGCA12aB2WMxgKWr26wK5L2JAcdcb_Zkfqr4lsV0KIgUN0w>
X-ME-Received: <xmr:TnoBarlajT_mWhrafxA89CB6WWrF_RbQnu7TYY7XXIcmBcjpyazKEU5UGUZh_D0RWkkAanmCbVEs0n2gkgfj2VfOY45C9hlE5FEk0dce3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphht
    thhopegrtghtihhonhhmhihsthhiqhhuvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:TnoBagUB36QHGyD0mKKWiUcLbwCc_w6yj1Kkq0ItHl29XjUXzgDgXA>
    <xmx:TnoBahuqjwlbq-hYEZki08-WE81GHoseqhT2Kjkb72WFOnz2C-MGtA>
    <xmx:TnoBajYJ4GOpka3uqzGsMLUNlFJZC0Po6BLr5coQn50tAXvBW9PrzA>
    <xmx:TnoBagW4q3ZTNZCujvV-24fEpNS7ckFPnMy-fSoCbuifjJ3OV4XOCQ>
    <xmx:TnoBarVpXXLNC45wNUpJbfa0I1Y9UJPyWWVFWnsrX_-RF1EodAdAeDti>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 02:42:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2b4f742f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 May 2026 06:42:19 +0000 (UTC)
Date: Mon, 11 May 2026 08:42:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
	jean-christophe manciot <actionmystique@gmail.com>,
	git@vger.kernel.org
Subject: Re: unexpected auto-maintenance, was Re: git hogs the CPU, RAM and
 storage despite its config
Message-ID: <agF6Q-z1SuTL1xXs@pks.im>
References: <CAKcFC3arsYExb5dCMQspo4V9UFDadFaj8Q4PUsMWZJw_eYrMzA@mail.gmail.com>
 <20260508180341.GB737125@coredump.intra.peff.net>
 <20260509175249.GA2336928@coredump.intra.peff.net>
 <af+snTGFeoUUyfPU@nand.local>
 <9ddfd37d-7d71-4359-b9be-d993fbfd138c@gmail.com>
 <agDjyAXxkOIso8FU@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agDjyAXxkOIso8FU@nand.local>

On Sun, May 10, 2026 at 04:00:08PM -0400, Taylor Blau wrote:
> On Sun, May 10, 2026 at 12:08:14PM -0400, Derrick Stolee wrote:
> > > That's not too terrible to write, and I would feel OK about putting it
> > > in a 2.54.1 release soon-ish provided that others think it is reasonable.
> >
> > I'd rather revert the geometric maintenance default for a point
> > release and let something more complicated like this percolate
> > until the next release window.
> >
> > > Simply reverting 452b12c2e0 (builtin/maintenance: use "geometric"
> > > strategy by default, 2026-02-24) feels somewhat unsatisfying, since it
> > > is merely making the bug less likely rather than eliminating it
> > > entirely.
> >
> > It does limit the behavior to those who previously chose to opt-in to
> > this behavior, and likely that's a low number or else we'd have more
> > bug reports.
> 
> I agree with what you're saying. In an ideal world we would be able to
> apply a fix on top that would prevent this bug from occurring, but if
> that's not trivial to do then we shouldn't rush it in the 2.54.1 window.
> 
> I think that not having this bug whatsoever (as opposed to simply
> reverting 452b12c2e0) would be preferable, but as you note we haven't
> seen any bug reports in a pre-452b12c2e0 world, so perhaps the risk is
> low enough that we could merely revert 452b12c2e0.

I think having an actual fix for the locking logic in git-maintenance(1)
would be preferable though, as the issue isn't merely contained to Git
2.54. With that release we are of course much more likely to hit the
issue as the "geometric" strategy is the default now. But even before
this release it was possible to configure that strategy, and if the user
had opted in to it they might've hit the same bug.

> > For me to be convinced that this forward fix is the right direction,
> > I'd need to see a test that proves the detached process will clean up
> > the locks on a normal process end and an early exit.
> 
> Yeah, I agree. Testing this is a little tricky, but I played around
> with it for a while and came up with the following:
> 
> --- 8< ---
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 4700beacc18..77bfa537385 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -1460,6 +1460,56 @@ test_expect_success '--detach causes maintenance to run in background' '
>  	)
>  '
> 
> +test_expect_success PIPE '--detach holds maintenance lock until daemonized child exits' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		mkfifo fifo &&
> +
> +		git config maintenance.auto false &&
> +		git config core.lockfilepid true &&
> +
> +		git remote add origin /does/not/exist &&
> +		git config set remote.origin.uploadpack \
> +			"echo \$PPID >child && cat \"$(pwd)/fifo\"" &&
> +
> +		# Start a detached prefetch maintenance task. Note that
> +		# we are backgrounding git-maintenance here in order to
> +		# determine its PID to validate that the lockfile was
> +		# created by the parent.
> +		{ git maintenance run --task=prefetch --detach & } &&
> +		parent="$!" &&
> +
> +		# Open fifo for writing, which will block until the
> +		# upload-pack helper opens it for reading. Once exec
> +		# returns, we know that the daemonized child is alive
> +		# and pinned.
> +		exec 8>fifo &&
> +
> +		test_path_is_file .git/objects/maintenance.lock &&
> +		test_path_is_file .git/objects/maintenance~pid.lock &&
> +
> +		# Verify that the maintenance.lock still exists, and
> +		# that it was created by the parent process, not the
> +		# child.
> +		echo "pid $parent" >expect &&
> +		test_cmp expect .git/objects/maintenance~pid.lock &&
> +
> +		# Close the write end of the FIFO, causing our upload-pack
> +		# helper to quit. Wait until the grandparent (from the
> +		# perspective of our upload-pack helper, the daemonized
> +		# git-maintenance child)
> +		exec 8>&- &&
> +		gpid="$(ps -o ppid= -p $(cat child) | tr -d " ")" &&
> +		test -n $gpid && wait $gpid &&
> +
> +		test_path_is_missing .git/objects/maintenance.lock &&
> +		test_path_is_missing .git/objects/maintenance~pid.lock
> +	)
> +'
> +
>  test_expect_success 'repacking loose objects is quiet' '
>  	test_when_finished "rm -rf repo" &&
>  	git init repo &&
> --- >8 ---
> 
> I'm not sure how portable it is, though. I think that 'ps -o ppid=' is
> OK, since 'start_git_in_background()' uses it, but I'm not sure if $PPID
> is available on Windows.

Yeah, this test seems to work on my system, too. But it's another
Windows machine indeed. I'll start a CI pipeline to check whether it
works on Windows, as well.

In any case, I also agree with Stolee that it may have unintended
consequences to unconditionally reassign tempfiles to the child process
when daemonizing. It is okay for all current callers, but I'm not sure
whether future callers would expect this behaviour.

An alternative would be to explicitly reassign the lockfile's ownership
in git-maintenance(1). Something like the below patch.

Thanks!

Patrick

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
index 7ec4427368..d651e11d4b 100644
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
+		return error_errno(_("fork failed"));
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
+		die(NULL);
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
index 80bc6e5f07..10f8b377f2 100644
--- a/setup.h
+++ b/setup.h
@@ -150,6 +150,7 @@ int path_inside_repo(const char *prefix, const char *path);
 
 void sanitize_stdfds(void);
 int daemonize(void);
+int daemonize_without_exit(void);
 
 /*
  * GIT_REPO_VERSION is the version we write by default. The
