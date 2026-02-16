Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23172EE608
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 06:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771224361; cv=none; b=nvesbE0s8oEorlI6P4/aa5crJ0wuRXV2ZsG3zefXcAYfLLDekpCH2/SDU0k0JzU+kdAY9mxsYe+mh1+LVsL4p3djMssdn9wbHpPV9Bt4r36dUZArOpBAnpF6q5nEOd3B8yMq7orTlwYX3XkkXbRV4MiPqJ7HYkg3Y1syvFjbLgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771224361; c=relaxed/simple;
	bh=grIcNI3r7rmAm+8utH6q0xXuiEhKjPa9K/BIdYqDLJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t2RLg14q8AF4tQ9HXc6CaRwPcTGEc5ycbNgqCbOgegykrTxsTUJiINoVqlww5RmERM5lGjepfzyH6WUe5uvXXARaPX4kxZSAqvAKSd3tpp17mltY46FJIqMNYfG9QBfcUrZZzvFMs97euvPssEVHp83aU8Q+H0CGj5dOH2ILxzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YAMX0hJ5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GwdAAUAz; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YAMX0hJ5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GwdAAUAz"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 0DA221D0021B;
	Mon, 16 Feb 2026 01:45:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 16 Feb 2026 01:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771224358;
	 x=1771310758; bh=iTPa5/8DAiLAD2VDta6jL3HePiY6Lu2g7erMG4OdJ4w=; b=
	YAMX0hJ5TkHRnPuwBI0Ew3HO3+68F43BXV+/CBw3M0d9mfy/mz5FXfXqfraixtbx
	EwVKwdoJDK8BXBEBQRQZwb+p7S/LAT8ddKKh1dR/LUWNstrdivlKR3WFLIs3Iwxt
	xTjPahz/hoHj5dVHgZ/mmmR/kDlAuTZavluHhDlug752p20pu/8dEIQLs7wHiXuC
	ij3QPgq0MNIvw7ItLGf37MPzgjRRqtBXJjzW8+vaWqbpdbZmBcEpSK5Gpkn8iM/A
	qtdJz8ZVX92JRARikGz9iRYvz5sCZp0KjEB+xEwJpsXzB+YzgkbxVbrIruYfYgPA
	CiCh5domobuUYcj0gbvyXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771224358; x=
	1771310758; bh=iTPa5/8DAiLAD2VDta6jL3HePiY6Lu2g7erMG4OdJ4w=; b=G
	wdAAUAzSnbZUX47Tcq3XKbhP1/0xm/MFLEtJ6/73cYJ2SDQ2YARkZVP5/AJ39Jx0
	ZrgFhZv9qnD8obrkA+WF2t+b20seqb14MyK6P6SUJ/BMg2coLWq5mS8Ra2LuWLOc
	Dyvpjk7sOTUctY4Lb0/AY8655c/TTbMgJqk/NkCTeVi1icZu+lRIBvNdB1540pkF
	h86A/hFwIRq8Fp38WUQ40Z4/iDX6YAEFlSFphixN0A6jmQHFlsutwQeHsdUNZ/hD
	22GV5MlXH+8+8c5ZPWE+uaEnMWIWDz5UZVT0l5r33CkUBMNtsQWNODmCF56iU+zW
	GJXt69P/smIiUXZxNq4Ag==
X-ME-Sender: <xms:Jr2SaeERYHnYxqq5RkJ42jn5BARxuNdjxqIJtuzaAf0s6nnqN-08uA>
    <xme:Jr2SaWWDkvoK736A8w4epuqxRCrkc8H8RKUHr3usoJYz_4IIZ0C1d6YSkoDIYw1y8
    7hVwIJRr7J3WscNl5vwjcpTSAdKJRKOg4eBSe4P13Pwnb0rqXPF6g>
X-ME-Received: <xmr:Jr2SadK9dHfpIlmQWYJV3-DL8IgBL7vCYkEOXELZisV_--lTxgCYQvciMy5zj40vASOI75wtuQ9zudIgaMsn1_LdyIw60vjCaGYNrfT5Fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeiudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:Jr2SaW-M97HJFrEQYaZNGAuK5qr-tsKP4_jPJKwOTHYU1xTAHK1mpQ>
    <xmx:Jr2SaQK7J5RkCoxgoXclrC9LaT0BsdjMCJ-kSHstlLOw0RaPvzMADA>
    <xmx:Jr2Sabm5XDcnYDwYMusq4JBoe8lUp9KZ2fQ3sDXgwPfO7U8MbH3Y1w>
    <xmx:Jr2SaUNdzg24swlNGDz3Zo2D5Hb94QkHCAC2pUzCgDuqbXGHTbir3Q>
    <xmx:Jr2SaYqeLicTAeSqXZiY_y4MbM9AcsMfhqiMhmdkBXyR9QPY3wQu9qWf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 01:45:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0d0d7eb8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Feb 2026 06:45:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Feb 2026 07:45:45 +0100
Subject: [PATCH v3 2/5] builtin/history: check for merges before asking for
 user input
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-b4-pks-history-dry-run-v3-2-c4db58a651fc@pks.im>
References: <20260216-b4-pks-history-dry-run-v3-0-c4db58a651fc@pks.im>
In-Reply-To: <20260216-b4-pks-history-dry-run-v3-0-c4db58a651fc@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.3

The replay infrastructure is not yet capable of replaying merge commits.
Unfortunately, we only notice that we're about to replay merges after we
have already asked the user for input, so any commit message that the
user may have written will be discarded in that case.

Fix this by checking whether the revwalk contains merge commits before
we ask for user input.

Adapt one of the tests that is expected to fail because of this check
to use false(1) as editor. If the editor had been executed by Git, it
would fail with the error message "Aborting commit as launching the
editor failed."

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/history.c         | 39 +++++++++++++++++++++++++++++++++++++++
 t/t3451-history-reword.sh |  2 +-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/builtin/history.c b/builtin/history.c
index 1de51372ea..ff90e93d6e 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -177,6 +177,41 @@ static int parse_ref_action(const struct option *opt, const char *value, int uns
 	return 0;
 }
 
+static int revwalk_contains_merges(struct repository *repo,
+				   const struct strvec *revwalk_args)
+{
+	struct strvec args = STRVEC_INIT;
+	struct rev_info revs;
+	int ret;
+
+	strvec_pushv(&args, revwalk_args->v);
+	strvec_push(&args, "--min-parents=2");
+
+	repo_init_revisions(repo, &revs, NULL);
+
+	setup_revisions_from_strvec(&args, &revs, NULL);
+	if (args.nr != 1)
+		BUG("revisions were set up with invalid argument");
+
+	if (prepare_revision_walk(&revs) < 0) {
+		ret = error(_("error preparing revisions"));
+		goto out;
+	}
+
+	if (get_revision(&revs)) {
+		ret = error(_("replaying merge commits is not supported yet!"));
+		goto out;
+	}
+
+	reset_revision_walk();
+	ret = 0;
+
+out:
+	release_revisions(&revs);
+	strvec_clear(&args);
+	return ret;
+}
+
 static int setup_revwalk(struct repository *repo,
 			 enum ref_action action,
 			 struct commit *original,
@@ -236,6 +271,10 @@ static int setup_revwalk(struct repository *repo,
 		strvec_push(&args, "HEAD");
 	}
 
+	ret = revwalk_contains_merges(repo, &args);
+	if (ret < 0)
+		goto out;
+
 	setup_revisions_from_strvec(&args, revs, NULL);
 	if (args.nr != 1)
 		BUG("revisions were set up with invalid argument");
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
index 6775ed62f9..12a9a7d051 100755
--- a/t/t3451-history-reword.sh
+++ b/t/t3451-history-reword.sh
@@ -203,7 +203,7 @@ test_expect_success 'can reword a merge commit' '
 
 		# It is not possible to replay merge commits embedded in the
 		# history (yet).
-		test_must_fail git history reword HEAD~ 2>err &&
+		test_must_fail git -c core.editor=false history reword HEAD~ 2>err &&
 		test_grep "replaying merge commits is not supported yet" err &&
 
 		# But it is possible to reword a merge commit directly.

-- 
2.53.0.352.gd1286b26eb.dirty

