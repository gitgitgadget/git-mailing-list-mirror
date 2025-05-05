Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECEE1DDA14
	for <git@vger.kernel.org>; Mon,  5 May 2025 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435114; cv=none; b=KPcGnVvtu8ILoTqYio3M+T7g2uAywZf07DTd/g/MaxenFEzLRtAHmhYwjyESJnDYNl1yII3OvHMRLsGKlPdvC3A0R41n60W8b5ZpjL1kEFBBHjYqoKZwY9OOI6sxX76ZxASRKpvqL+e407NHC90lpgHBZ2Nv/MdlpjKAmh/uRt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435114; c=relaxed/simple;
	bh=PDh664u0KiANV65MIPjfYrNErJaXiHjWjSWHaDa8Nuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eO1Wtimoh3TqUanH6o5LefXdUjk97XHiaXASbxyWjsBWEOpedDIGm4y59MrM29enDANWN6ZxsmK1NzydRVPOJRNqBjdMRXw2xXdQBJzSPGfXH5kqdN/YF7Z1HUh5wxWLeRgzbwwebAJY4q2capPVlW4r3tn/KUcsYWqmr2XHH4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k9ys1pfL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ng53BMJp; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k9ys1pfL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ng53BMJp"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D75425400C4;
	Mon,  5 May 2025 04:51:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 05 May 2025 04:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746435111;
	 x=1746521511; bh=mg4yEuJRUykYeG0GyzLl31cRTFVwK87DKf1CFZfSFSg=; b=
	k9ys1pfLIwnaoOqYQ5kMgutV+yH/Jqkki4Hh+dhFiXyplQMJsFAVTvaXXIY0in+5
	6fdEFOS0LlUqKPJiVkX/CTpB32eDXIMzViWI7bfjUkp15BVSKkE6dg54Ci8kfBcB
	7TXEijmPDHI57M6rvX12Pfqo1Ch5QFFzf3Gj7dmH8CmNhaHXTu3tXVsM0RoZXHuV
	f3J9JTubeEA0/C4+F2DsQP6huAF1wnRSs306Vmz3k3MQnaN+wG9pgKgT71EJRvtn
	qa9azS8snuBawpdvdOGKcDw7B4nAspm5iq2XyIcnuZp5zCUHopGxvxt0+D8+M/Kq
	2ty2WAvaoGN/YyzzBeisOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746435111; x=
	1746521511; bh=mg4yEuJRUykYeG0GyzLl31cRTFVwK87DKf1CFZfSFSg=; b=n
	g53BMJpoK6vU4eyIhoOAExbhiqgnPyyAnYIotn9Ew3B4WK8Y3gJPtwXwG3uqJx0t
	ge0C0ONuSFoMKBbOXI9P1WySBSrV25P+yX4XBwXXqxZqTaCD9Q6ztft/FCWmRA+X
	RPX0vfzCPA66q1ILAyGPH1WPhjlI1CR+1p3pj316XqoAXQzlgCozgPX4YGIeJlYZ
	3cwI3zuj97YMpmwC/N1IIqi6K8Ym3M0PstBwLztMpbNE093lLNRSX/wDtn81COrO
	PO9GEMdSy5d3OTRFWByxd0knvJGv0sBe7v3GJ3QDn+lMIk2ePxppQc/zVQLd36uU
	LeygjdvJ80K2un6NbodOA==
X-ME-Sender: <xms:J3wYaN68151GmCTQeu-txD8yAEt_1KKj7XePU1dcBMxITbg5JSxV-A>
    <xme:J3wYaK76KPFm31J2J1rUm5xSL0flrUTPrfZV8ssgpXvXHf-9kUMStZhTugdYva0GU
    UWEEY0vI9wsUUastA>
X-ME-Received: <xmr:J3wYaEdoc3OocSu3Y4stw6yJCRXszhH_G7XNOLG77CTDmdx-_hgLjmXrZx1dAzE6Jbzo3tQJ3mxy_M0zb4MuHIay0lbFHzU3esn88i6GtD1AeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:J3wYaGKcKtD-iHNwIGM253D8jMUJzJsnC3PuSxSVyUEnFk9gLiKt9A>
    <xmx:J3wYaBJmQE3RYKa8bJVNlinRQeX90MPoE-9u0igrm5wkoqmEYaB4RQ>
    <xmx:J3wYaPw9nvWgBKWZz-1bsylPjYCCoDjtnr4m1xr1N2Dp0vJWJVPY5g>
    <xmx:J3wYaNJd_t6vzLEpa_1o8Wt27xI7rFqGXrZzTLUKlbmk4EfjwGACpw>
    <xmx:J3wYaOlLidrB60hjGkmvAJUbbq2X6IdhoCBiGaUYF5vDM53CNM3othx7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 04:51:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id efc9e12e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 08:51:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 05 May 2025 10:51:42 +0200
Subject: [PATCH v4 2/7] builtin/gc: remove global variables where it
 trivial to do
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pks-maintenance-missing-tasks-v4-2-141f4df906a1@pks.im>
References: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
In-Reply-To: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We use a couple of global variables to assemble command line arguments
for subprocesses we execute in git-gc(1). All of these variables except
the one for git-repack(1) are only used in a single place though, so
they don't really add anything but confusion.

Remove those variables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index a73ec22fb18..ada36e210f0 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -53,15 +53,9 @@ static const char * const builtin_gc_usage[] = {
 };
 
 static timestamp_t gc_log_expire_time;
-
 static struct strvec repack = STRVEC_INIT;
-static struct strvec prune = STRVEC_INIT;
-static struct strvec prune_worktrees = STRVEC_INIT;
-static struct strvec rerere = STRVEC_INIT;
-
 static struct tempfile *pidfile;
 static struct lock_file log_lock;
-
 static struct string_list pack_garbage = STRING_LIST_INIT_DUP;
 
 static void clean_pack_garbage(void)
@@ -769,9 +763,6 @@ int cmd_gc(int argc,
 					 builtin_gc_usage, builtin_gc_options);
 
 	strvec_pushl(&repack, "repack", "-d", "-l", NULL);
-	strvec_pushl(&prune, "prune", "--expire", NULL);
-	strvec_pushl(&prune_worktrees, "worktree", "prune", "--expire", NULL);
-	strvec_pushl(&rerere, "rerere", "gc", NULL);
 
 	gc_config(&cfg);
 
@@ -897,34 +888,36 @@ int cmd_gc(int argc,
 		if (cfg.prune_expire) {
 			struct child_process prune_cmd = CHILD_PROCESS_INIT;
 
+			strvec_pushl(&prune_cmd.args, "prune", "--expire", NULL);
 			/* run `git prune` even if using cruft packs */
-			strvec_push(&prune, cfg.prune_expire);
+			strvec_push(&prune_cmd.args, cfg.prune_expire);
 			if (quiet)
-				strvec_push(&prune, "--no-progress");
+				strvec_push(&prune_cmd.args, "--no-progress");
 			if (repo_has_promisor_remote(the_repository))
-				strvec_push(&prune,
+				strvec_push(&prune_cmd.args,
 					    "--exclude-promisor-objects");
 			prune_cmd.git_cmd = 1;
-			strvec_pushv(&prune_cmd.args, prune.v);
+
 			if (run_command(&prune_cmd))
-				die(FAILED_RUN, prune.v[0]);
+				die(FAILED_RUN, prune_cmd.args.v[0]);
 		}
 	}
 
 	if (cfg.prune_worktrees_expire) {
 		struct child_process prune_worktrees_cmd = CHILD_PROCESS_INIT;
 
-		strvec_push(&prune_worktrees, cfg.prune_worktrees_expire);
 		prune_worktrees_cmd.git_cmd = 1;
-		strvec_pushv(&prune_worktrees_cmd.args, prune_worktrees.v);
+		strvec_pushl(&prune_worktrees_cmd.args, "worktree", "prune", "--expire", NULL);
+		strvec_push(&prune_worktrees_cmd.args, cfg.prune_worktrees_expire);
+
 		if (run_command(&prune_worktrees_cmd))
-			die(FAILED_RUN, prune_worktrees.v[0]);
+			die(FAILED_RUN, prune_worktrees_cmd.args.v[0]);
 	}
 
 	rerere_cmd.git_cmd = 1;
-	strvec_pushv(&rerere_cmd.args, rerere.v);
+	strvec_pushl(&rerere_cmd.args, "rerere", "gc", NULL);
 	if (run_command(&rerere_cmd))
-		die(FAILED_RUN, rerere.v[0]);
+		die(FAILED_RUN, rerere_cmd.args.v[0]);
 
 	report_garbage = report_pack_garbage;
 	reprepare_packed_git(the_repository);

-- 
2.49.0.987.g0cc8ee98dc.dirty

