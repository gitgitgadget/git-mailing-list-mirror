Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDAF221D9A
	for <git@vger.kernel.org>; Wed,  7 May 2025 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602513; cv=none; b=sjslpedHIXHk343W/zbo5QDBLYaCLr56Qgw8Zc7ABSsM72NqlzucYk5qfx9Gg1rPVQyuFvF8f1qbQ+M1TdABR/tiUjuqONjsK2XSphvKyphxxhE0t/Vfv00Yd7TsvQkJUVslBMUfkXGwRRjsu550ZWm2S0TPlPx0tpJ/8cs8tlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602513; c=relaxed/simple;
	bh=L1HKiTxCKrU/G4Q+2MCKkEussVL4OJX3PV+S+v2Erg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dm9Htn2UDODj63+X82bmmWCPNC245T7qwbwLSx0782EZ1j7mJR3pv2t+vSkTAbHkH+Djz1ap1ubO8BS4N5s5kicQyUQJtzlBBTvnQuvKG8vvG+Z1/E79i2l0vS8iZ2pmGo46okubRZUV2lHCfPzgDgdjai5Vmc/imoN+qf+U+dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XQBO81er; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CahCJC3l; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XQBO81er";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CahCJC3l"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 42F991140128;
	Wed,  7 May 2025 03:21:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 07 May 2025 03:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746602511;
	 x=1746688911; bh=yFPpKIZ83CiAApDK+LdKdBsqrrAgjrJ/3ryL0wd+o+w=; b=
	XQBO81erM3ORhffkm/5yEvFQg9rM1X1r30GQ2wJcNXXfea7Cnka+wnATmEelVg0R
	uBIwKGMr6qd682/OyFzXuPZjb8RAkD1cR+d3xQXy7ja2EZj/oWcPKDE0Q9wfqzNr
	8i50imUqNsS1QlxysNj5otsurSBYtBU/86ltbuNI/N7RwnHm7h5gEl8mrjBQT8gl
	mJKpwKWadzfEca4nijuilh74N6wIYmTkDk3ZNTi3xEmX9pPsWWS4ck7FK8sekeb+
	ICflW+9S+eKw7MD8D2gTfs9fGjMIjzE7LMrBfOTLGpCHjN/N750JlxzAgR58NaCs
	Xpmhobno0abF4iSdVkqINg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746602511; x=
	1746688911; bh=yFPpKIZ83CiAApDK+LdKdBsqrrAgjrJ/3ryL0wd+o+w=; b=C
	ahCJC3lYOWk3PKXdoKuLlEMVISgB0ysW37VArKvTbC/Hx6Ekb5dME7bigl1y3P6B
	OSOe1MG9wg1Y2pWDuZiDampCZXaTELr2GJXVsxPtIhQFKqb2ZwJmXs7WGpjGDP2M
	o9RluBsqwR6ZDDnDZwN5hFzfUzAZ9KyP2xaRS58gns+Y5EVLbeCvGwhAC9dJlMD5
	MQNf85U/Ip+iEyKFz6AetREmI7urOFOUczGVvZmxeOVrGapau/x6qZryYqtXPOPX
	4zEtSa3+j0tNcLFkZ6iR+I9x1j3SF4CmpwMfSNKnQE2VZf2j8Smjelkvve/Byipb
	uPnAgCIeX0Fd+hJR+c7Uw==
X-ME-Sender: <xms:DwobaC34-HORv3qqnz3Rqdg1nhCOMD8dBdavDj3iSoRI6_LxtDvVNg>
    <xme:DwobaFE1bCcwc4EB_zGgP9dRjqijXYtrGQBaJgv6fzERxaZJAL12jdY2Y9SP8A6Qd
    2FquX3jtk61KMlvnw>
X-ME-Received: <xmr:DwobaK7RBV2ywLIwGw53TqSlyxQBkvxJHb7ptHYBV_nguQT9V35v_D4yeUmZVNohaUjiZfeEehXmlwHMaGLls9dHeaYqgd4zKLwQDouy_nvZWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeivdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhish
    gtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehsthholhgvvgesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:DwobaD0HKEsWD5H8VU8dOmiV9mz3YvWuFusUKHlrCPEUVY5jVVgJZw>
    <xmx:DwobaFGnC8W8eW1W4dOzHG1u95qdMi1cy0pCAQKFKK7XKuPQoBS-rw>
    <xmx:DwobaM-f21uEL3OnMaXjgLQXcWa5NAIbH4TStmSLFBQGwvvqS1ri2g>
    <xmx:DwobaKmWiLU7S_5KB2Cye2MLccYuaPh0WQkhQqGuVWjIIfA9is7FIg>
    <xmx:DwobaJoJaHpahV6FEeRfc2-VUW-1nNVfbOnme1gYH3T1w0z7t6meU_uK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 03:21:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5315629 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 07:21:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 07 May 2025 09:21:41 +0200
Subject: [PATCH v5 5/6] builtin/gc: move rerere garbage collection into
 separate function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-pks-maintenance-missing-tasks-v5-5-aa5fdfb82891@pks.im>
References: <20250507-pks-maintenance-missing-tasks-v5-0-aa5fdfb82891@pks.im>
In-Reply-To: <20250507-pks-maintenance-missing-tasks-v5-0-aa5fdfb82891@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

In a subsequent commit we are going to introduce a new "rerere-gc" task
for git-maintenance(1). To prepare for this, refactor the code that
spawns `git rerere gc` into a separate function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e85e313d78f..0ae3071ec71 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -385,6 +385,15 @@ static int worktree_prune_condition(struct gc_config *cfg)
 	return should_prune;
 }
 
+static int maintenance_task_rerere_gc(struct maintenance_run_opts *opts UNUSED,
+				      struct gc_config *cfg UNUSED)
+{
+	struct child_process rerere_cmd = CHILD_PROCESS_INIT;
+	rerere_cmd.git_cmd = 1;
+	strvec_pushl(&rerere_cmd.args, "rerere", "gc", NULL);
+	return run_command(&rerere_cmd);
+}
+
 static int too_many_loose_objects(struct gc_config *cfg)
 {
 	/*
@@ -781,7 +790,6 @@ int cmd_gc(int argc,
 	int daemonized = 0;
 	int keep_largest_pack = -1;
 	timestamp_t dummy;
-	struct child_process rerere_cmd = CHILD_PROCESS_INIT;
 	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
 	struct gc_config cfg = GC_CONFIG_INIT;
 	const char *prune_expire_sentinel = "sentinel";
@@ -958,10 +966,8 @@ int cmd_gc(int argc,
 	    maintenance_task_worktree_prune(&opts, &cfg))
 		die(FAILED_RUN, "worktree");
 
-	rerere_cmd.git_cmd = 1;
-	strvec_pushl(&rerere_cmd.args, "rerere", "gc", NULL);
-	if (run_command(&rerere_cmd))
-		die(FAILED_RUN, rerere_cmd.args.v[0]);
+	if (maintenance_task_rerere_gc(&opts, &cfg))
+		die(FAILED_RUN, "rerere");
 
 	report_garbage = report_pack_garbage;
 	reprepare_packed_git(the_repository);

-- 
2.49.0.1045.g170613ef41.dirty

