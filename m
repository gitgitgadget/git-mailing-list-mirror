Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81C2285C92
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334284; cv=none; b=c2DfbXqfn8XYOp1bjFjKtb5iFt7GnlqMEfuwjb772sQkWxHIr9k4pBXH2jK6du1hNvd2hRm3gl9hVRKf718X7sIPBHONbkDaZny8z9ROsvkxNfgoz985Oo2f3wY4HLa48ft85aJHj2xfgJewHNIoZ73K07WoAIjTdwPz1V7Z2S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334284; c=relaxed/simple;
	bh=CrzZAJvfwBWQQFO42abj/enRFMDQxy8/ODdYCF9LUUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sW8EEpYLG3aDtxOXXQh6+5uvCfejS9+ZFIEaMlo/1FbvbMTkXjVAS5C5Etwypim2Bdl/XPinHLxvQESe3QZyRh9lQNcj8TrPd6Lz3xMrPjJipWGtHWSunxuvLoluASWa7w38X8Gla0Mk57jSNiFPFW7a8vkeycTbTgphFJhXnC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q/98hyL0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=newrONVe; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q/98hyL0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="newrONVe"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EFA817A0320;
	Wed,  1 Oct 2025 11:58:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 01 Oct 2025 11:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759334281;
	 x=1759420681; bh=aRZ9Zudb7q2hukmZoGMmlIZEINo0OcO4HvqSMrpVIWM=; b=
	Q/98hyL0HgFjfpbNVa6w7ty8uc4o966xt3qwCdaJgPwvFgJfBL9BGfQKcR2go7Rm
	fFtIcFWGM5OdoY3JoW5iy24k7isjgrOdTuizU7NR3OyKzKKXiCdhEpW4gNx//mC6
	cyfEVZs+ccwZ+uSOZfkvkuGhfLzSfQLktVb0WsueRKKZdt0lbwIFF+eC6SUjdpqe
	A4nIFObXajdSQ/Ap161uIocYZI0WfoEn/UsQOoWG8/J3Nyq0ofnCsenLqeAhEz2D
	s345cx1pKFFONqzyTfeXfFLY8xRqa5CiekrxCCXAEk2647tNkrYcH6x62VKOzXzd
	VUaA7G4rq8fP6eOSszsjDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759334281; x=
	1759420681; bh=aRZ9Zudb7q2hukmZoGMmlIZEINo0OcO4HvqSMrpVIWM=; b=n
	ewrONVepfYtax6vFc/k6fALYF2mUEgx94mTWD3VKCZB4DdUScwfZCyMd2OsCjB7K
	GkB8MzSssQd5FQ9yEklm1C1y0SUFfEMuYikNwJAq0OwHgbVKw8dV0haKXpC7RjJ9
	JbNVexP/T7hRypyRl3YgpH3fCl+W86vGEfiRbgeU6GeGx7azSvKh9NIpp17wEbBY
	UkIi/8K43qlcZL+hrYVGzuWVY8UTDIoegIL2s+a63y74dGlrhCqVVN4z7WGFh2Sp
	Llc/A9IY32X6UBb9YZJ6PVREOgegdnFBXhbFSI5n/b7C5AaKuyX6vssmcZ/VKQwv
	gGOl175ihme/YvrnoWtng==
X-ME-Sender: <xms:iU_daA1v2m027aMwGNcfsnM3U13ea06UpDmE0wZ8ErpTiGrWCRc2fA>
    <xme:iU_daKLxKzri2cAFPRgTmfe7pGKl5TYsqEANGQWSlwrcod0r4Egpoerg9-vqLnt19
    XWnckMHBfs-DwdWQ89hJrbLWF2ngL1dL8nRBoVX6dzycbLJstrQBA>
X-ME-Received: <xmr:iU_daPErshDN5Ms8cjrKvoDUq0l2Caf7N2FdeM0puP2rtV0LBYcM7UcaTDOj_QAi3ng4et3UMTf770UUe6dxKAt5xBLJjg5Rt92cQqpU3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhope
    hjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:iU_daGVZbCQCeW7JLo-DccyrC1EOO6PJWcKEPJ2JnBLDMuTxCcBO6w>
    <xmx:iU_daHxczQFPgnWpLLeLUcbOiDfO6U_lnqu-_ca5TZFCkDwh3mjAFw>
    <xmx:iU_daLTGj_BOieaMai6TrTHX37YJYs3IHhJngMPVr56k23_8SUwG8g>
    <xmx:iU_daDijcGLnnxzsp0IfXygjTofK7Tf03GoE426VJloG0tPOXgtMoA>
    <xmx:iU_daKydS_hS6eOGaz6R0_jh8HQiELhyY8ucWqymehFnYv630W17H0zx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 11:58:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 47eef6f9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 1 Oct 2025 15:57:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Oct 2025 17:57:31 +0200
Subject: [PATCH v4 05/12] builtin: add new "history" command
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-b4-pks-history-builtin-v4-5-8e61ddb86317@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.2

When rewriting history via git-rebase(1) there are a couple of very
common use cases:

  - The ordering of two commits should be reversed.

  - A commit should be split up into two commits.

  - A commit should be dropped from the history completely.

  - Multiple commits should be squashed into one.

While these operations are all doable, it often feels needlessly cludgy
to do so by doing an interactive rebase, using the editor to say what
one wants, and then perform the actions. Furthermore, some operations
like splitting up a commit into two are way more involved than that and
require a whole series of commands.

Add a new "history" command to plug this gap. This command will have
several different subcommands to imperatively rewrite history for common
use cases like the above. These commands will be implemented in
subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitignore                     |  1 +
 Documentation/git-history.adoc | 45 ++++++++++++++++++++++++++++++++++++++++++
 Documentation/meson.build      |  1 +
 Makefile                       |  1 +
 builtin.h                      |  1 +
 builtin/history.c              | 22 +++++++++++++++++++++
 command-list.txt               |  1 +
 git.c                          |  1 +
 meson.build                    |  1 +
 t/meson.build                  |  1 +
 t/t3450-history.sh             | 17 ++++++++++++++++
 11 files changed, 92 insertions(+)

diff --git a/.gitignore b/.gitignore
index 802ce70e48..3de9f9f16f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -77,6 +77,7 @@
 /git-grep
 /git-hash-object
 /git-help
+/git-history
 /git-hook
 /git-http-backend
 /git-http-fetch
diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
new file mode 100644
index 0000000000..1537960374
--- /dev/null
+++ b/Documentation/git-history.adoc
@@ -0,0 +1,45 @@
+git-history(1)
+==============
+
+NAME
+----
+git-history - EXPERIMENTAL: Rewrite history of the current branch
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
+This command is similar to linkgit:git-rebase[1] and uses the same
+underlying machinery. You should use rebases if you either want to
+reapply a range of commits onto a different base, or interactive rebases
+if you want to edit a range of commits.
+
+Note that this command does not (yet) work with histories that contain
+merges. You should use linkgit:git-rebase[1] with the `--rebase-merges`
+flag instead.
+
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
+
+COMMANDS
+--------
+
+This command requires a subcommand. Several subcommands are available to
+rewrite history in different ways:
+
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.adoc[]
+
+include::config/sequencer.adoc[]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index e34965c5b0..36500879e4 100644
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
index 5960c80736..4e405509e9 100644
--- a/Makefile
+++ b/Makefile
@@ -1262,6 +1262,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
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
index d020eef021..c7c13cea67 100644
--- a/git.c
+++ b/git.c
@@ -560,6 +560,7 @@ static struct cmd_struct commands[] = {
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
+	{ "history", cmd_history, RUN_SETUP },
 	{ "hook", cmd_hook, RUN_SETUP },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init_db },
diff --git a/meson.build b/meson.build
index c320bdba9f..7630a8fb0a 100644
--- a/meson.build
+++ b/meson.build
@@ -604,6 +604,7 @@ builtin_sources = [
   'builtin/grep.c',
   'builtin/hash-object.c',
   'builtin/help.c',
+  'builtin/history.c',
   'builtin/hook.c',
   'builtin/index-pack.c',
   'builtin/init-db.c',
diff --git a/t/meson.build b/t/meson.build
index 7974795fe4..8b31eb0858 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -382,6 +382,7 @@ integration_tests = [
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
2.51.0.700.g236ee7b076.dirty

