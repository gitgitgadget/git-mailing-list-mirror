Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6202512F5
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227455; cv=none; b=CtpLh8T1ttHMYE9wKCpqfgb2ud0ypboaxS5neJ3xSniYT8fmb5dsE4vNxJismxrg31TSAn0SmjBtA05+uDGAvdTzp0HqmmJYbq8AvOD+YV1X/tDm74oREmjK+Ob6HWzUAmxrJ8a7GYsmaUJVu+cc0+8VAJHvK0LefTc6ECTnd4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227455; c=relaxed/simple;
	bh=OfJ01EBxrwzhoBXmd38LcNgiTuyFDoTnTvBEYvHfczI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LSF2nMFOBZKgfajk2AwPD8vXxUmg6+4+kxe7aUhnbOS02Yv1tNuOcPRsysaleuT5mqkUQGhWnEDSI/siK7OBeLrWBTNCe3LZ1xZDqOkhiExy5pwxKsdsne2zGFVtT4tHB8mg/3OK6LsPmF54JtC1yvRw6y3ZdNqSWTqAluP63KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NnRMMFCr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nYcOGg0E; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NnRMMFCr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nYcOGg0E"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BFEB614000D5;
	Mon, 12 Jan 2026 09:17:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 12 Jan 2026 09:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768227446;
	 x=1768313846; bh=exFpp08c4C8Pcnfe11xAO0L2Ia49dW8t3sUJXmlx5N8=; b=
	NnRMMFCrDwxW8OPnxkV/+Ch/4DmPL3IEtltFM1vNfdIcbJRGcYDkGaOzfyE0IB56
	VycuPR11b+wUl+ZFrFbd+58h0lbEM97KWxj/BN6OVaCpLPsIN3fP2/giv8WCfWZ7
	ZmD6BnYEKp9e+mBH6ltz+lNyAecV/PSYFenA8rgawbSKzFB9m9f7rVObKyx9nA2q
	IC+zDR9QJzRRbJwJCCXjbvtBLoADDAR/feZDYdLGR4z3TI+Y4dYHJF+P8vcTN5Ho
	llgPXlKpFwl7qB6eRt4kSsSv86s+kNdoeYNMb/qpdOxUBwMb/hLevl0OJIMf0Pmk
	4gmMi4QYvKwYaCXTt5oHCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768227446; x=
	1768313846; bh=exFpp08c4C8Pcnfe11xAO0L2Ia49dW8t3sUJXmlx5N8=; b=n
	YcOGg0E6EfbPceXQiSAvfoQSwl8jLMJ2r36Clq1URrmZBA0ydcdlCa+Tju7qw1wJ
	l8C605WPfsxMUrkosHVb4qAdpfu+iGn1ypUhofxkqOddpNVFbdYRov7VKPmCfrcU
	v1T0BLr21QnQ20Pf+auLvj1HnGN7pnBQez1gxJ5eXBTWIiY5zEH1yaelaR2nb41k
	XMFrOi3Nq0bSvkUKFs1xwVJDihVgyoO4DWlmdIC7hPId3DedputIjIXuMHBkKHlj
	XANgjaIqDm5LfIgrDq6SPiHVP6MNRTEKu7+shgmUaRDiMldsGofUqzEI5Puy6m5i
	suLFhqOh7Iyry+90dyaLQ==
X-ME-Sender: <xms:dgJlacZaM_UlTJXHMtAkpe0lDEFJWUh3-IerdF-w2ggPoeyVhQzx5w>
    <xme:dgJlaTP1JKprVxyKl2_-0-nWVIh0vmfzFW4GOy4NFOg67JpcZz1LTfLJ5RILCCmgg
    d3jcc9lJ3Hk1p8M91jMrIjD3_DwlAyv08gGdQ_cCdxQt17nRnk7TQ>
X-ME-Received: <xmr:dgJlaSVyXbMYQQDn0TUf7n9am2W8dTdo9Dyw1MtQcRb5Ojdy8dhaCeVhDvFhtM769x1X1NaPN6zg2CHJ2xkuzfMj6OcRxGxIHMZhShM4Ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhn
    iiesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:dgJlaQIVIdb_6Xu2euDU8eB1xcDQbeGvgCCqzBf2AxdvanU-_fljlw>
    <xmx:dgJlaVpUWEWia1uuJQpnvpuf0wk8sJ_Rwox6MLMsGIE_Htr_I_zZzA>
    <xmx:dgJlafyXW9zjjRwxRDCJX5nL1HQ_zbtIcvRTxNIAR1QStati59oAlg>
    <xmx:dgJlaRssdYvsYflupCPJ-8wSSuQlgqBIqq5zpy6m2_GeXEBHCAwUgQ>
    <xmx:dgJlaWZik9uEFF-iwHkLL43ZNnV2wvkJ8giAgU1PAkl1Si1GYfMBFK9L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 09:17:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 43154271 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 14:17:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 15:15:19 +0100
Subject: [PATCH v10 7/8] builtin: add new "history" command
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-b4-pks-history-builtin-v10-7-e3c6aa5b4cec@pks.im>
References: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im>
In-Reply-To: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Matthias Beyer <mail@beyermatthias.de>
X-Mailer: b4 0.14.3

When rewriting history via git-rebase(1) there are a few very common use
cases:

  - The ordering of two commits should be reversed.

  - A commit should be split up into two commits.

  - A commit should be dropped from the history completely.

  - Multiple commits should be squashed into one.

  - Editing an existing commit that is not the tip of the current
    branch.

While these operations are all doable, it often feels needlessly kludgey
to do so by doing an interactive rebase, using the editor to say what
one wants, and then perform the actions. Also, some operations like
splitting up a commit into two are way more involved than that and
require a whole series of commands.

Rebases also do not update dependent branches. The use of stacked
branches has grown quite common with competing version control systems
like Jujutsu though, so it clearly is a need that users have. While
rebases _can_ serve this use case if one always works on the latest
stacked branch, it is somewhat awkward and very easy to get wrong.

Add a new "history" command to plug these gaps. This command will have
several different subcommands to imperatively rewrite history for common
use cases like the above.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitignore                     |  1 +
 Documentation/git-history.adoc | 57 ++++++++++++++++++++++++++++++++++++++++++
 Documentation/meson.build      |  1 +
 Makefile                       |  1 +
 builtin.h                      |  1 +
 builtin/history.c              | 22 ++++++++++++++++
 command-list.txt               |  1 +
 git.c                          |  1 +
 meson.build                    |  1 +
 t/meson.build                  |  1 +
 t/t3450-history.sh             | 17 +++++++++++++
 11 files changed, 104 insertions(+)

diff --git a/.gitignore b/.gitignore
index 78a45cb5be..24635cf2d6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -79,6 +79,7 @@
 /git-grep
 /git-hash-object
 /git-help
+/git-history
 /git-hook
 /git-http-backend
 /git-http-fetch
diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
new file mode 100644
index 0000000000..68c35f36b9
--- /dev/null
+++ b/Documentation/git-history.adoc
@@ -0,0 +1,57 @@
+git-history(1)
+==============
+
+NAME
+----
+git-history - EXPERIMENTAL: Rewrite history
+
+SYNOPSIS
+--------
+[synopsis]
+git history [<options>]
+
+DESCRIPTION
+-----------
+
+Rewrite history by rearranging or modifying specific commits in the
+history.
+
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
+
+This command is related to linkgit:git-rebase[1] in that both commands can be
+used to rewrite history. There are a couple of major differences though:
+
+* linkgit:git-history[1] can work in a bare repository as it does not need to
+  touch either the index or the worktree.
+* linkgit:git-history[1] does not execute any linkgit:githooks[5] at the
+  current point in time. This may change in the future.
+* linkgit:git-history[1] by default updates all branches that are descendants
+  of the original commit to point to the rewritten commit.
+
+Overall, linkgit:git-history[1] aims to provide a more opinionated way to modify
+your commit history that is simpler to use compared to linkgit:git-rebase[1] in
+general.
+
+Use linkgit:git-rebase[1] if you want to reapply a range of commits onto a
+different base, or interactive rebases if you want to edit a range of commits
+at once.
+
+LIMITATIONS
+-----------
+
+This command does not (yet) work with histories that contain merges. You
+should use linkgit:git-rebase[1] with the `--rebase-merges` flag instead.
+
+Furthermore, the command does not support operations that can result in merge
+conflicts. This limitation is by design as history rewrites are not intended to
+be stateful operations. The limitation can be lifted once (if) Git learns about
+first-class conflicts.
+
+COMMANDS
+--------
+
+No commands are supported yet.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index f02dbc20cb..fd2e8cc02d 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -64,6 +64,7 @@ manpages = {
   'git-gui.adoc' : 1,
   'git-hash-object.adoc' : 1,
   'git-help.adoc' : 1,
+  'git-history.adoc' : 1,
   'git-hook.adoc' : 1,
   'git-http-backend.adoc' : 1,
   'git-http-fetch.adoc' : 1,
diff --git a/Makefile b/Makefile
index 1c64a5d2ae..c0569ed8e4 100644
--- a/Makefile
+++ b/Makefile
@@ -1418,6 +1418,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
+BUILTIN_OBJS += builtin/history.o
 BUILTIN_OBJS += builtin/hook.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
diff --git a/builtin.h b/builtin.h
index 1b35565fbd..93c91d07d4 100644
--- a/builtin.h
+++ b/builtin.h
@@ -172,6 +172,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix, struc
 int cmd_grep(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_hash_object(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_help(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_history(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_hook(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_index_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_init_db(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/builtin/history.c b/builtin/history.c
new file mode 100644
index 0000000000..f6fe32610b
--- /dev/null
+++ b/builtin/history.c
@@ -0,0 +1,22 @@
+#include "builtin.h"
+#include "gettext.h"
+#include "parse-options.h"
+
+int cmd_history(int argc,
+		const char **argv,
+		const char *prefix,
+		struct repository *repo UNUSED)
+{
+	const char * const usage[] = {
+		N_("git history [<options>]"),
+		NULL,
+	};
+	struct option options[] = {
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc)
+		usagef("unrecognized argument: %s", argv[0]);
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index accd3d0c4b..f9005cf459 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -115,6 +115,7 @@ git-grep                                mainporcelain           info
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
 git-help                                ancillaryinterrogators          complete
+git-history                             mainporcelain           history
 git-hook                                purehelpers
 git-http-backend                        synchingrepositories
 git-http-fetch                          synchelpers
diff --git a/git.c b/git.c
index c5fad56813..744cb6527e 100644
--- a/git.c
+++ b/git.c
@@ -586,6 +586,7 @@ static struct cmd_struct commands[] = {
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
+	{ "history", cmd_history, RUN_SETUP },
 	{ "hook", cmd_hook, RUN_SETUP },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init_db },
diff --git a/meson.build b/meson.build
index a5a4e99b25..3a1d12caa4 100644
--- a/meson.build
+++ b/meson.build
@@ -610,6 +610,7 @@ builtin_sources = [
   'builtin/grep.c',
   'builtin/hash-object.c',
   'builtin/help.c',
+  'builtin/history.c',
   'builtin/hook.c',
   'builtin/index-pack.c',
   'builtin/init-db.c',
diff --git a/t/meson.build b/t/meson.build
index 459c52a489..73006b095a 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -387,6 +387,7 @@ integration_tests = [
   't3436-rebase-more-options.sh',
   't3437-rebase-fixup-options.sh',
   't3438-rebase-broken-files.sh',
+  't3450-history.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3450-history.sh b/t/t3450-history.sh
new file mode 100755
index 0000000000..417c343d43
--- /dev/null
+++ b/t/t3450-history.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description='tests for git-history command'
+
+. ./test-lib.sh
+
+test_expect_success 'does nothing without any arguments' '
+	git history >out 2>&1 &&
+	test_must_be_empty out
+'
+
+test_expect_success 'raises an error with unknown argument' '
+	test_must_fail git history garbage 2>err &&
+	test_grep "unrecognized argument: garbage" err
+'
+
+test_done

-- 
2.52.0.590.g1f87b77810.dirty

