Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBF4224B01
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021748; cv=none; b=t4tfk+870PT3i/KHrxQSrd8L7sLSk+ZYNm+Nldfiet8uFdRJcf3iMPJyYHeeFZUXS+z1beAThSwO/TMel75bNECKTW1WZZv95mFXWfKkQF7Is167WhdFwEaamuqBSCZE7RLv2X+0q916X9Cn/+9kLlK8gxbmF7cfbsRIQuhNKKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021748; c=relaxed/simple;
	bh=vbKLNM8WKXQBJoXfXLyhG1leCUukAxnf4LIDLw8ExAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zl3Z9AVDkdxJDU94FdFRXWzN0pv5OQnq5ptd5PpiqDZqITzZYiB8ZIAbz3cjQudemJDDQIJhfhjljbNPChvb3uFcFLRlFi0GqSGgddC0FR1aX9CUyyA+D2zwndQWLBY0tdb8cD/OAA9s04owrOMqD/zqOACRoxa4wVQTCYoBAdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X9ri7uxT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w1uldbda; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X9ri7uxT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w1uldbda"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DF2697A0096;
	Wed, 21 Jan 2026 13:55:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 21 Jan 2026 13:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769021744; x=1769108144; bh=/GqtwvLjXu
	bn4gU+1vg5FOb2dd2E275TKcGNuVPnMbo=; b=X9ri7uxT8Ul/EedA9C4BaBtimF
	3qI4ZJoaJ14noXesDld4MjTI4G9GPHD8/s+xIozqG10C5Pk2Cv9VIjddRvSCwUWR
	FHO3MppBWDkQ+qh8I/vB814uPNuxxiQkmaclxv0LN3rgUUt5UayhvBBLbdBK+lbW
	kgLb5EZxqI45/zRvPbXV7Cnct8JRp/n4I15woQ5NW1ZzQv4pqZRAPNwqfKaJTCYf
	uBiFeS296YojNA00ObRY8Rw1CLMmd53kpiADrLqjFyydV8UnO1RqfLHvOg25cBuR
	UPvuZF6HOMQ6fUe+4EiwPZlv1whs6ggkLElLLtz+mLg6uzzyXBdbMRY2Sotg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769021744; x=1769108144; bh=/GqtwvLjXubn4gU+1vg5FOb2dd2E275TKcG
	NuVPnMbo=; b=w1uldbdajDGKGeFy4OH5t+n4cp7Oa6mbqLKGBJ4cn3GpfrdLK6M
	XdI6BwbGUkJ9li3DbbUE/d0/tobo4h1KcSZF347c3VqnLC5xuY93sY34C2fk5qYt
	DzZoCTDy5NYagHbMMixjHNQ8u5jJXN/a996yhsju6r5mVykMLg0NtDAnrzem+nR8
	wyls34znPez6rCteAPY/G2bZXc98MTkL2EiPtD/5NXW49nvce8JOaaZRBkT4QAx7
	iSWcvh+JJBRK+8XUzAaPWoI+5MwWZhLO2B6khd5HKtNxRuby5hXFp+RBQbMqmrJZ
	hvK6vobfWHre8R1o+/EgGueOx9DRPx/ZYFg==
X-ME-Sender: <xms:MCFxaRpUaTe7Lhisy2JsRfd41q3WLbZzA4vcgbgcIwCmaN7txr8Aig>
    <xme:MCFxaTXt2tYZg4ijdW71ubuIlp9FZ2XlKQ6jlX6pK022NYKR2UItLmJxZAn8v1-HE
    MzpFMohPiyykTS9xz9dq2uDEg6E5AheFCFcEdQGsOEqtm8aAWfeBg>
X-ME-Received: <xmr:MCFxaZ0jqTHPsEIg-naFm8BadsMhBgbEOK5yQAijbTKkBvJDpURYidgiCyg_owT3ytfkJtEjKrj5Zt06JNv1H8Wg8No80DLlxOvHU9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffdtveevueeigfetheeufeehveejhffgvdffheffvddugfevveefgeeuleel
    veetnecuffhomhgrihhnpegtohhmmhhithdrtgifpdhgtgdrtgifpdhlohgtkhhfihhlvg
    drtgifnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
    dprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthho
    pehtsghovghgihesfigvsgdruggvpdhrtghpthhtohepphgruhhlohdrtggrshgrrhgvth
    htohesshhhohhpihhfhidrtghomhdprhgtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:MCFxaYt7DQ2z5aqnJQChLh4Jm2FBoZ6gt78kSkJ1ml0PaUuA-slV9Q>
    <xmx:MCFxaRVPxRDJXTW3QBernd5CtV977xzlXIOU9kdRB7nwRLHZKQsPMQ>
    <xmx:MCFxaQylNla6XGkNCjngkP_K_bFbyqwGHy7IUQ-6vM25g_uCrEb7MA>
    <xmx:MCFxaQF5zhkjbfXoOtPA-iYniDs6hyHT1qp2S4M8tR1jZRw0WX2smQ>
    <xmx:MCFxaWBj1Q5eaCKXAalrWb-Nm5_imRAmIJ7SIqhx4hX0rT8VsGRJtmvl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 13:55:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Paulo Casaretto via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Torsten
 =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,  "Paulo Casaretto (Shopify)"
 <paulo.casaretto@shopify.com>,  Patrick Steinhardt <ps@pks.im>,  Paulo
 Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH v5] lockfile: add PID file for debugging stale locks
In-Reply-To: <20260121163924.GA576236@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 21 Jan 2026 11:39:24 -0500")
References: <pull.2011.v4.git.1767804355831.gitgitgadget@gmail.com>
	<pull.2011.v5.git.1768933954845.gitgitgadget@gmail.com>
	<20260121071344.GA570838@coredump.intra.peff.net>
	<CAPig+cSE7Y-MLu1PTdo2kUq_MztMQgm0eYby03cX2K5YAJLwsg@mail.gmail.com>
	<20260121163924.GA576236@coredump.intra.peff.net>
Date: Wed, 21 Jan 2026 10:55:42 -0800
Message-ID: <xmqqcy32u769.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> The second half is still valid, I think, but at that point it is the
> only path that uses the close() in the out-path, so we might as well
> drop the out-path one.

True.  A fix-up may look like this.  I've got rid of the assignments
to "fd" that are not used.

The changes to first two files simply revert unnecessary changes.

 builtin/commit.c | 3 ++-
 builtin/gc.c     | 6 ++++--
 lockfile.c       | 6 +-----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git c/builtin/commit.c w/builtin/commit.c
index 4378256fa5..0243f17d53 100644
--- c/builtin/commit.c
+++ w/builtin/commit.c
@@ -539,7 +539,8 @@ static const char *prepare_index(const char **argv, const char *prefix,
 
 	path = repo_git_path(the_repository, "next-index-%"PRIuMAX,
 			     (uintmax_t) getpid());
-	hold_lock_file_for_update(&false_lock, path, LOCK_DIE_ON_ERROR);
+	hold_lock_file_for_update(&false_lock, path,
+				  LOCK_DIE_ON_ERROR);
 
 	create_base_index(current_head);
 	add_remove_files(&partial);
diff --git c/builtin/gc.c w/builtin/gc.c
index 1dcc8dd550..92c6e7b954 100644
--- c/builtin/gc.c
+++ w/builtin/gc.c
@@ -748,7 +748,8 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 		xsnprintf(my_host, sizeof(my_host), "unknown");
 
 	pidfile_path = repo_git_path(the_repository, "gc.pid");
-	fd = hold_lock_file_for_update(&lock, pidfile_path, LOCK_DIE_ON_ERROR);
+	fd = hold_lock_file_for_update(&lock, pidfile_path,
+				       LOCK_DIE_ON_ERROR);
 	if (!force) {
 		static char locking_host[HOST_NAME_MAX + 1];
 		static char *scan_fmt;
@@ -1015,7 +1016,8 @@ int cmd_gc(int argc,
 
 	if (daemonized) {
 		char *path = repo_git_path(the_repository, "gc.log");
-		hold_lock_file_for_update(&log_lock, path, LOCK_DIE_ON_ERROR);
+		hold_lock_file_for_update(&log_lock, path,
+					  LOCK_DIE_ON_ERROR);
 		dup2(get_lock_file_fd(&log_lock), 2);
 		atexit(process_log_file_at_exit);
 		free(path);
diff --git c/lockfile.c w/lockfile.c
index 6d03c60d50..13e2ad1307 100644
--- c/lockfile.c
+++ w/lockfile.c
@@ -110,7 +110,7 @@ static struct tempfile *create_lock_pid_file(const char *pid_path, int mode)
 {
 	struct strbuf content = STRBUF_INIT;
 	struct tempfile *pid_tempfile = NULL;
-	int fd = -1;
+	int fd;
 
 	if (!lockfile_pid_enabled)
 		goto out;
@@ -123,18 +123,14 @@ static struct tempfile *create_lock_pid_file(const char *pid_path, int mode)
 	if (write_in_full(fd, content.buf, content.len) < 0) {
 		warning_errno(_("could not write lock pid file '%s'"), pid_path);
 		close(fd);
-		fd = -1;
 		unlink(pid_path);
 		goto out;
 	}
 
 	close(fd);
-	fd = -1;
 	pid_tempfile = register_tempfile(pid_path);
 
 out:
-	if (fd >= 0)
-		close(fd);
 	strbuf_release(&content);
 	return pid_tempfile;
 }
