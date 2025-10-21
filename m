Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AEA2236FA
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056174; cv=none; b=OCRhpWfOYPm6cuPmpm/LkWixKqC1mj2klyzo9pYcF0Rx+pFQPV+50dbnQXlE1iDlXi9pPu2BPhM/Otr3NkJhz5N3j9FsUG3A77M+PmlwgGgTShNDqmoFSREOQqv/uh2a+DxnTmMnPYrP1L6mWDFNRCy5NHvGWdWE0IRDvw3s0Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056174; c=relaxed/simple;
	bh=zvysQj+8FuUS3+/Z2b6rC/wdPiTo6Z4tQibWFVFudjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jBiqxG1PIg2gZegUvXfnvehngEAiDOcmgOK6CSaqfHlAc+bNiZCYRhFbVvyfdAcVoNBYBQGoWZF4+vrCXAuiL/dauMkhmwtyPzY5FQz2JHPI9PJSz+r2nXQB3RNyD25+Prww5xTMi9g5SwKyMHVGZcvz1prI92k/rOEoBmmYey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XfLgHTWl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hzfZJ1ho; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XfLgHTWl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hzfZJ1ho"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 47C0DEC0136;
	Tue, 21 Oct 2025 10:16:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 21 Oct 2025 10:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761056172;
	 x=1761142572; bh=pJajhwBAOyaRRV+NBvkFsMjJChD7WVtg03ssD0/wCRg=; b=
	XfLgHTWlPJ/+HocZPKNBf3DqON2lqaqy9uTUrjrexU64w6boMb2GTAJ02c80YT/L
	C8mjrNQusr3Igzu2mOXeRp714X5fOW/MZxGzZ62fe7Pz7OoYTYpWDjVglhk78mbu
	ZpXe46YcXiLPAvsjKLLB2xRcqiMkdxi7Zs8eFtO+OcmsIefazW3eVEdIo3Ge6p7A
	66TpvM++hKWjTeBNUTiwnfe4O/YJSn2u6Zus0RyjjQLEpz2LH8CDlGDo4cttx2tH
	ruq2b8rkesacU1b5H7p7ot3nMJygIfHWj/nrmJu4XDstPFfaQlAn7Bzm7tgxRakT
	w20hKoKYTx6zxqMAeepLnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761056172; x=
	1761142572; bh=pJajhwBAOyaRRV+NBvkFsMjJChD7WVtg03ssD0/wCRg=; b=h
	zfZJ1hoTlLogZEudxaeYU1us3sXGHrcmiK0fTi+1Yk6s1ZStDe2FHfzWujupvxEb
	AYG7THxgIwavFpwDFAcDMKoVVhHA9DD6Crep4QxHZhXxhDJ+Guan2TWe7TQDNGop
	TL0WMGTKkPmvzYjIHPT9cPPZe38c+bS1hOcaJXvX3KL22gqAZbz8higpaGd2dpoI
	0XB/egKirJR4UcBc5dFcRngDr2pxU8sXI0enLZknkh7zElnioj9bSpUVwm4powi0
	72tGR9CxX5BCXN0BjXr6Z3MblDFSQyGfX//8B+vUCfFjzPYdPK6s4m06gTlFKzMn
	zKtvqOlQkHIPcXI6CImoA==
X-ME-Sender: <xms:rJX3aLG8cve8fu0Z6zioz4iOZCt9RYR7fgWAD_IufG6uLtSCwtzLEg>
    <xme:rJX3aK49QRU5w9F9wx-apiIKigZhC1hp1hl6bMS1K-AvvijOeDS9ATE7mX9Yq9MrK
    ObrlpEq_-vugVRLxHHTDb2MoCWqVz_P42iShcjgBaBT9uVUmqZx5w>
X-ME-Received: <xmr:rJX3aAxst_EI4mXL1R9N2zqXiSxGMZi1v5qVtd4vE_SrJkb42uuwUz8yvElsKW2tDlP6R5MYMBT5cHnLbnYg8N-DObWeABSLYX6yOwqDrqhFWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtth
    hopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    rhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:rJX3aJN-yMarFedyI6WzscQNNU6piN7SLRxZ1-Qz1vKd6YrkZ8VpMA>
    <xmx:rJX3aGkmGnCil1jAywn-pqgtCGRo5tmWgHYoUoPT1M7X1uwAystCaQ>
    <xmx:rJX3aORmEsKvUhYMgeeKdv-VXo-4blMP_F4QMLSrW-kMfendfFASHg>
    <xmx:rJX3aFWjfYXO0cI44rPDa0VohVlXeeZTJlI4fqSZs3SwCcP_0fOkjw>
    <xmx:rJX3aOzYwXfrdD9Eh20Lq-DEy0V8_H_KEn-6YRq2ZB59VTUC0NEvl76L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:16:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id da6ce83b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 14:16:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Oct 2025 16:15:53 +0200
Subject: [PATCH v5 05/12] builtin: add new "history" command
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-b4-pks-history-builtin-v5-5-78d23f578fe6@pks.im>
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
In-Reply-To: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

When rewriting history via git-rebase(1) there are a couple of very
common use cases:

  - The ordering of two commits should be reversed.

  - A commit should be split up into two commits.

  - A commit should be dropped from the history completely.

  - Multiple commits should be squashed into one.

While these operations are all doable, it often feels needlessly kludgey
to do so by doing an interactive rebase, using the editor to say what
one wants, and then perform the actions. Furthermore, some operations
like splitting up a commit into two are way more involved than that and
require a whole series of commands.

Add a new "history" command to plug this gap. This command will have
several different subcommands to imperatively rewrite history for common
use cases like the above. These subcommands will be implemented in
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
index 78a45cb5bec..24635cf2d6f 100644
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
index 00000000000..57560525a70
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
+underlying machinery. You should use rebases if you want to reapply a range of
+commits onto a different base, or interactive rebases if you want to edit a
+range of commits.
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
index 44f94cdb7ba..cf551a28ae7 100644
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
index 01c171b4f03..1380ee1e196 100644
--- a/Makefile
+++ b/Makefile
@@ -1395,6 +1395,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
+BUILTIN_OBJS += builtin/history.o
 BUILTIN_OBJS += builtin/hook.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
diff --git a/builtin.h b/builtin.h
index 1b35565fbd9..93c91d07d4b 100644
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
index 00000000000..f6fe32610b0
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
index accd3d0c4b5..f9005cf4597 100644
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
index c5fad56813f..744cb6527e0 100644
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
index ae8d4fef059..2d789612a01 100644
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
index 401b24e50e0..019435918fa 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -384,6 +384,7 @@ integration_tests = [
   't3436-rebase-more-options.sh',
   't3437-rebase-fixup-options.sh',
   't3438-rebase-broken-files.sh',
+  't3450-history.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3450-history.sh b/t/t3450-history.sh
new file mode 100755
index 00000000000..417c343d43b
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
2.51.1.851.g4ebd6896fd.dirty

