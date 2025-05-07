Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA55721FF51
	for <git@vger.kernel.org>; Wed,  7 May 2025 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602512; cv=none; b=bscJpoMW867HUANIO+KkObZpD0vP7Q3CCFU3VuSDRzqQAuzyD+/cW4Irh2uNo7j5OBZi5HgYNYjjbmMktCnr+xReHztEFn8IngYAvySePzphALWxjUlJCIvmquMVH5XRIYcR9bE0X1GcRGaa+bE49dSMUWOy3+1aACNUMvYvczI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602512; c=relaxed/simple;
	bh=Tluoq7uWiDz3QbUdlT3grE7ADjZ9DJpODcZhaUz1I5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nwzzQe1/omwS4f0tTkR6WuZGn8ARCKaDiToPBomWAdq4m9WO2LFjNBwIrb48YpzZTG4OpYgui+8KsFW2Y8xbP0o8ZCSLxruTOqrNxl/gsiKkYYqcz/s+NZ6ZFqfIPM4oK0br/q/RPKUrDbsNfCBY8rfkBErsRQUOWWrE4a45N2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rRWBlH5n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=br6LwF/9; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rRWBlH5n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="br6LwF/9"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id A68811140100;
	Wed,  7 May 2025 03:21:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 07 May 2025 03:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746602509;
	 x=1746688909; bh=b3W25dh3xkHm81BUg6uiPYbzfUPzUpy1RmmG083Fs38=; b=
	rRWBlH5nCqMChfLfo8kM/dh8duvKCGCO5/S5i56h9NE6w63fDIMTgHG0n6CIfrem
	0mL7mLSFNgX8l/1tslWMMjU3Ti5TYqwHKbR4T2FM3D9LqFaX3QK8bw1I769vvHVp
	yHArlxe1R8EWOgbXWyY/6rQb6TCEsJ/XrguEd9LPoSHZVR2UvQSQaqChSUZW3vdQ
	SkR7qoXLCSIbM7Z5bZAt4srnwpjn2bVoKEb8+UatxqPOEicKZlzIatg4lq+KKa8e
	qS+G4j0Svrwr42QgIqQr6/HuRda9TQjoBtAUYLkSroODlM/IRYwF2f8yl6Ae4zGT
	q1LiOWXS4hYa6V/P2xpMmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746602509; x=
	1746688909; bh=b3W25dh3xkHm81BUg6uiPYbzfUPzUpy1RmmG083Fs38=; b=b
	r6LwF/9JRKE6iphle4/bnbpRrptisMa1TVkQJUu2+8yyta9+zM1F6qpXYRjEpFol
	WB0tFKvd5jHuJqIpvRTA5L6LAo0RVDOZuR9AplXK1WSKXCmnwXzFBAAMm0h2YRzo
	JoJZBHAjChLP1jC9jclLX46OE56mAnFdKABKOgzwUYbKNJR9GOQhnPHVUNzJhZMl
	sKoXcV12VErUkwBLukZAgp+AhUcQgl40u0LFy0Yvdjh1tWG8J6N428GxP4O3L3CX
	H8ElckNyoSeK4Euj3u7kZReW6GaF6zg2lMxZREW8pKp1U+hXpcfeTYOMTJXQ73Rk
	6S71v11wc68UXDsPFL4nA==
X-ME-Sender: <xms:DQobaOq7ILQvQCZinziYFrlYKoIKyrM0PBnC4XIyEoaEtbeA1C-Plg>
    <xme:DQobaMpacorKegODCyBSoJM5dqygGdVnVbPQwRkIPCOzDk7amzMeyuJDNAU9NwCS1
    izUZgPeLxlFcC7BYQ>
X-ME-Received: <xmr:DQobaDN82oWOgf20dHBABN_iEm_Rrd60qcvc_L2AZDXE8M5M3ZCVTxEGAVqmK5O4ox-TCmB4UC60X-t_rVsKS_Q3DokcyycGCRvfdO6aYpWn2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeivdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilh
    ihrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhn
    vggtohdrtghomh
X-ME-Proxy: <xmx:DQobaN4fhEdQDldFziKsze2RMLqFYCfnOLkHGf413wK9Q_XPFpvJhw>
    <xmx:DQobaN7JzkjatPCWZmEew-TiSkf0NY_zbLVDfHQqlQarQXivoNtMng>
    <xmx:DQobaNgD-OYelupU6MreqOPmG42pmNEpG36K8r9ppcPpnZNOcFUY4w>
    <xmx:DQobaH5Ey3gtIXUCguJxPkGmkcGyuHkofLqDDaEFAclgrinrEZSckw>
    <xmx:DQobaNvSPlLN4PKa-M9gyNCik8_15IQ0TAJWX467n1g-55lDUL3QFATu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 03:21:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 82e97f77 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 07:21:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 07 May 2025 09:21:39 +0200
Subject: [PATCH v5 3/6] builtin/gc: move pruning of worktrees into a
 separate function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-pks-maintenance-missing-tasks-v5-3-aa5fdfb82891@pks.im>
References: <20250507-pks-maintenance-missing-tasks-v5-0-aa5fdfb82891@pks.im>
In-Reply-To: <20250507-pks-maintenance-missing-tasks-v5-0-aa5fdfb82891@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

In a subsequent commit we will introduce a new "worktree-prune" task for
git-maintenance(1). To prepare for this, refactor the code that spawns
`git worktree prune` into a separate function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index ada36e210f0..005ecc3f192 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -334,6 +334,18 @@ static int maintenance_task_reflog_expire(struct maintenance_run_opts *opts UNUS
 	return run_command(&cmd);
 }
 
+static int maintenance_task_worktree_prune(struct maintenance_run_opts *opts UNUSED,
+					   struct gc_config *cfg)
+{
+	struct child_process prune_worktrees_cmd = CHILD_PROCESS_INIT;
+
+	prune_worktrees_cmd.git_cmd = 1;
+	strvec_pushl(&prune_worktrees_cmd.args, "worktree", "prune", "--expire", NULL);
+	strvec_push(&prune_worktrees_cmd.args, cfg->prune_worktrees_expire);
+
+	return run_command(&prune_worktrees_cmd);
+}
+
 static int too_many_loose_objects(struct gc_config *cfg)
 {
 	/*
@@ -903,16 +915,9 @@ int cmd_gc(int argc,
 		}
 	}
 
-	if (cfg.prune_worktrees_expire) {
-		struct child_process prune_worktrees_cmd = CHILD_PROCESS_INIT;
-
-		prune_worktrees_cmd.git_cmd = 1;
-		strvec_pushl(&prune_worktrees_cmd.args, "worktree", "prune", "--expire", NULL);
-		strvec_push(&prune_worktrees_cmd.args, cfg.prune_worktrees_expire);
-
-		if (run_command(&prune_worktrees_cmd))
-			die(FAILED_RUN, prune_worktrees_cmd.args.v[0]);
-	}
+	if (cfg.prune_worktrees_expire &&
+	    maintenance_task_worktree_prune(&opts, &cfg))
+		die(FAILED_RUN, "worktree");
 
 	rerere_cmd.git_cmd = 1;
 	strvec_pushl(&rerere_cmd.args, "rerere", "gc", NULL);

-- 
2.49.0.1045.g170613ef41.dirty

