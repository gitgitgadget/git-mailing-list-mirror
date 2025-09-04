Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E0F30C352
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996085; cv=none; b=dknhcDPS0L6GTQmsZVnFLQ6FjgzCBdEfhutL9xe6k1yHfEphBfHda75JbAL5VLYcUsq69OARaFgCWTeWvAzmfKXbrjZ6tC6Y68L+mf9iepwyO/BEiuwEK22Bu/tDkxwOoMyh/SGJdzQtM0k9c9qjk2dBspxBMQ7ClAOR1Q6FsF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996085; c=relaxed/simple;
	bh=JdZNpXJBDRWiBeRgx1KDjtekFS65P8nOcVBC3n+7PCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FqLf8IqloTBuWpEoC3AL1mBotoY/KXYtErkT2NltA+5uUmB5N0Fv6rqLkLl33W+hR06g8tgQpiRR37WBm+vstudYF7/B/HiqMgrRPz7dJXVjkb15Pgabt/WbrOmqdCid/jRGpFhCQhii5J681TXN6wEM2ekAbqXLuerjV2yaCns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TpwZN3H8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PnVHIwdJ; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TpwZN3H8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PnVHIwdJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 362131D0028C;
	Thu,  4 Sep 2025 10:28:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 04 Sep 2025 10:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756996083;
	 x=1757082483; bh=de4tIdws1jHFaA9p4ehJ7+y68QATco1GAw/zQeTnZgY=; b=
	TpwZN3H8d6nvaWwZbILhwIxBUs8tL1YA5P24yCtwgSDMMo1+9lsCx6ccr/TG/DN6
	GOrRmti3HozYOX6m0COIV94QamxtX3j5Gf+qY1oKTBCaqEVk+X7mgOcDFKMCH+3x
	aQy1xYJDNaeoSgxGuDs5KciZu59YX9yPeJyqSME+C0A6Bgt6LQi0oUEQfnJzNaPy
	+QpNQUhvzCeQajbm2e802K021wi1SKZaFvpB2MsLWzVp5783q7QWZU/F7m4oyvqS
	3if5bef2vdsMirbERYwoTwFe8wK1VWWcGPa0bhEHN7YiTF+2ZDCSbUlkkfJbmDXC
	NNG1uVUwUekaDY+kGbiXUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756996083; x=
	1757082483; bh=de4tIdws1jHFaA9p4ehJ7+y68QATco1GAw/zQeTnZgY=; b=P
	nVHIwdJeTeC38NvNbS1gmUfCEWkRxd+y4NjNO/ZxGnsWhpTmRU0vpJeBLwmFni8H
	D6y9M3cUDSfMuffqzDk72J8Cza37KVHxXGZnrArlt0UKPnkXYmz/c7+SzdyCyPL3
	iX0FE2IbmX3EStplwev1NjteNcFDmJiHwvyuJuA6GN0/bQlBqxheBh1QGnkLwEje
	ikhzmEWqW40vmILD1LX5GBERJtCjrtxXO6W8mTuHUm/ZzZLM/XYljJzjb2qEBt6B
	yAxhf4jbbQcarQKElccFTZFDbDlSp8fVAPVOH214UnJn8GhjTIwOTNwbyC/iWhJS
	1hTHnJEmFytsf3falVbAQ==
X-ME-Sender: <xms:8qG5aNoFW1tgF0eMicNY8AHJ6afwKh68VUv7szS99lZ7Kw0bWuXQDw>
    <xme:8qG5aNM1PwkMFZfoY3K8P6om-q3j69HL7A9SOfwM-7lgz1-5eIFft4iVxMp9da4s8
    V4G3o9bDNdnBejRLw>
X-ME-Received: <xmr:8qG5aArreOFOpTj9eOv0ZYDwodAanxQ8PQejzlmLS2euQ7-0bA2ieXTAfIMLc_IME32PeOmwkfchsmOWnTtlznK_sTrbjJy20Mk8a-6csSFjsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehs
    ohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:8qG5aKfjk0REocOQrBfvm4oMV97_fhiv_73STKPuhO5L50qXkqHwqw>
    <xmx:8qG5aORXwROzWKxb2ASEchalvy64sxenBkVHfXRSWBAhn1fHc3PNVA>
    <xmx:8qG5aLafU1CPjTTP6FiDFXF5XHjC9n5wn6PTeNxy_wfAeHc5kmwmOQ>
    <xmx:8qG5aJd_SfNUwlRZBoMW7JLwvlbTWo_Sw8aRdJcbDpcwk3vqkmK2QQ>
    <xmx:86G5aJokGxc0gHEhQwCT13vIH8d8Lbcr3k22rXVyTyM5IEkHujM86Klf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:28:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 85a0614c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:28:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 16:27:38 +0200
Subject: [PATCH RFC v3 08/18] builtin/history: introduce subcommands to
 manage interrupted rewrites
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-history-builtin-v3-8-509053514755@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
In-Reply-To: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

Introduce subcommands to manage the sequencer state for git-history(1).
These aren't really useful yet, but will become useful in subsequent
commits where we will introduce git-history(1) subcommands that actually
edit history.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-history.adoc |  20 +++++++-
 builtin/history.c              | 114 +++++++++++++++++++++++++++++++++++++++--
 t/t3450-history.sh             |  32 +++++++++++-
 3 files changed, 161 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 1537960374..3e9a789b83 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -8,7 +8,9 @@ git-history - EXPERIMENTAL: Rewrite history of the current branch
 SYNOPSIS
 --------
 [synopsis]
-git history [<options>]
+git history abort
+git history continue
+git history quit
 
 DESCRIPTION
 -----------
@@ -33,6 +35,22 @@ COMMANDS
 This command requires a subcommand. Several subcommands are available to
 rewrite history in different ways:
 
+The following commands are used to manage an interrupted history-rewriting
+operation:
+
+`abort`::
+	Abort the history-rewriting operation and reset HEAD to the original
+	branch.
+
+`continue`::
+	Restart the history-rewriting process after having resolved a merge
+	conflict.
+
+`quit`::
+	Abort the history-rewriting operation but `HEAD` is not reset back to
+	the original branch. The index and working tree are also left unchanged
+	as a result.
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/history.c b/builtin/history.c
index d1a40368e0..0ad45dbfef 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1,20 +1,128 @@
 #include "builtin.h"
+#include "branch.h"
 #include "gettext.h"
 #include "parse-options.h"
+#include "sequencer.h"
+
+static int cmd_history_abort(int argc,
+			     const char **argv,
+			     const char *prefix,
+			     struct repository *repo)
+{
+	const char * const usage[] = {
+		N_("git history abort"),
+		NULL,
+	};
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct replay_opts opts = REPLAY_OPTS_INIT;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc) {
+		ret = error(_("command does not take arguments"));
+		goto out;
+	}
+
+	opts.action = REPLAY_HISTORY_EDIT;
+	ret = sequencer_rollback(repo, &opts);
+	if (ret)
+		goto out;
+
+	ret = 0;
+
+out:
+	replay_opts_release(&opts);
+	return ret;
+}
+
+static int cmd_history_continue(int argc,
+				const char **argv,
+				const char *prefix,
+				struct repository *repo)
+{
+	const char * const usage[] = {
+		N_("git history continue"),
+		NULL,
+	};
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct replay_opts opts = REPLAY_OPTS_INIT;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc) {
+		ret = error(_("command does not take arguments"));
+		goto out;
+	}
+
+	opts.action = REPLAY_HISTORY_EDIT;
+	ret = sequencer_continue(repo, &opts);
+	if (ret)
+		goto out;
+
+	ret = 0;
+
+out:
+	replay_opts_release(&opts);
+	return ret;
+}
+
+static int cmd_history_quit(int argc,
+			    const char **argv,
+			    const char *prefix,
+			    struct repository *repo)
+{
+	const char * const usage[] = {
+		N_("git history quit"),
+		NULL,
+	};
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct replay_opts opts = REPLAY_OPTS_INIT;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc) {
+		ret = error(_("command does not take arguments"));
+		goto out;
+	}
+
+	opts.action = REPLAY_HISTORY_EDIT;
+	ret = sequencer_remove_state(repo, &opts);
+	if (ret)
+		goto out;
+	remove_branch_state(repo, 0);
+
+	ret = 0;
+
+out:
+	replay_opts_release(&opts);
+	return ret;
+}
 
 int cmd_history(int argc,
 		const char **argv,
 		const char *prefix,
-		struct repository *repo UNUSED)
+		struct repository *repo)
 {
 	const char * const usage[] = {
-		N_("git history [<options>]"),
+		N_("git history abort"),
+		N_("git history continue"),
+		N_("git history quit"),
 		NULL,
 	};
+	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
+		OPT_SUBCOMMAND("abort", &fn, cmd_history_abort),
+		OPT_SUBCOMMAND("continue", &fn, cmd_history_continue),
+		OPT_SUBCOMMAND("quit", &fn, cmd_history_quit),
 		OPT_END(),
 	};
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
-	return 0;
+	return fn(argc, argv, prefix, repo);
 }
diff --git a/t/t3450-history.sh b/t/t3450-history.sh
index 9eb1ed6749..aa9d44c03b 100755
--- a/t/t3450-history.sh
+++ b/t/t3450-history.sh
@@ -6,7 +6,37 @@ test_description='tests for git-history command'
 
 test_expect_success 'refuses to do anything without subcommand' '
 	test_must_fail git history 2>err &&
-	test_grep foo err
+	test_grep "need a subcommand" err
+'
+
+test_expect_success 'abort complains about arguments' '
+	test_must_fail git history abort foo 2>err &&
+	test_grep "command does not take arguments" err
+'
+
+test_expect_success 'abort complains when no history edit is active' '
+	test_must_fail git history abort 2>err &&
+	test_grep "no history edit in progress" err
+'
+
+test_expect_success 'continue complains about arguments' '
+	test_must_fail git history continue foo 2>err &&
+	test_grep "command does not take arguments" err
+'
+
+test_expect_success 'continue complains when no history edit is active' '
+	test_must_fail git history continue 2>err &&
+	test_grep "no history edit in progress" err
+'
+
+test_expect_success 'quit complains about arguments' '
+	test_must_fail git history quit foo 2>err &&
+	test_grep "command does not take arguments" err
+'
+
+test_expect_success 'quit does not complain when no history edit is active' '
+	git history quit 2>err &&
+	test_must_be_empty err
 '
 
 test_done

-- 
2.51.0.417.g1ba7204a04.dirty

