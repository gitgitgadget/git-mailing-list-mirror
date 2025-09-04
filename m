Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD2930AD04
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996083; cv=none; b=gnh5Xabk+hdzdts2/CxJ8tk5GAKcu9YmIr1a3R9YRTzudto0y4HvLJSwLpUHDrzLBietFutD6yu4rKKAJwSmVIXxQrqGPk9OfM+80CK69aU4F8WGIc/h2uDT4N5idwPvf+0RwgvlPYr9dCfN+CBe4giJsT+J6tG9dJlLhsSd7Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996083; c=relaxed/simple;
	bh=f4+5FEvV0xARflXzJel2CESzWPoRkc0xNyJwzSv8muQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jpb2MQ/tMdR85WOMkK6iIxfzMjiktoZd+rUbh9fDEoLqCS/d6WIUbc77MlDq+NbyYsBSJ8he2RCbNYvUE06lM+Q+USKwEecQYQgb462rYG89+koKrfiMF3ysdkZH5hEAF8CrIzu1QPEaABh7mgTUpe1dMjW/x+t04/ceKcRrVnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JbCwuNfj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hTdFeZs2; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JbCwuNfj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hTdFeZs2"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 602FE7A0354;
	Thu,  4 Sep 2025 10:28:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 04 Sep 2025 10:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756996080;
	 x=1757082480; bh=/OKtq3zYetVR0Wi6GICpH8EXdzX8+2aRVreoO8YWBVE=; b=
	JbCwuNfjxT/NQyzAXhaQKXPzhPpDAS6/meeuy7OF7J6aXG8NbOr/ulX/oUet7/T4
	YiBQXf00EtIafB/B6Qa4xrHlilDpVM9RbpDhi2Dua3SuBhG5caJq0Gp/yYpn/2OT
	VJQNGBvkiw/8vHMJhvtDrLDnJK7941Pm+TlgXu7IhGt5kXPawDgFeWHBINd0w1fZ
	EKOOaZeHCN6HOlXbVeqLQ/rTjDlPf6pXd5OuKWlz0apuOZl3K/CRTzuYN9PS34Y6
	toOsh0X+t+YzcjkTz8RyCtagRPHRlX67guYDibWjl8T1yjW1KSlwCeQ5AwMKUTW9
	ti/+KR3CTFglHTrjsA/TSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756996080; x=
	1757082480; bh=/OKtq3zYetVR0Wi6GICpH8EXdzX8+2aRVreoO8YWBVE=; b=h
	TdFeZs2TK5VHVr8gPFw+UDNvH7T88/G+T14rPxYM6ulra4cEK1wiXTafEItu9GQD
	RDvc5t+jJ2ojdeJDdXLl8oOHvddvYq3bX2ZkEc0DJwXXh+PSzipPWaoEGGXmvPwn
	qWS2ipe6UJTq2q5A14K4gqbqkNs2hf1E2+WYXjeNLIcPBepQVPWrEGuNTc87UBdr
	cAk1DxwfVCYKf/zVmZXlWGScNIIKF3p1QF0KjKOkjRrBZNj9a290jYVrr7BFOJZ7
	TW+OTtswjb2RoE7uOtaBtzFiC2UNx66WsK9QmPbs2YkzaavKdBQKAUZyMQNbv8TA
	yyUwiH8UAOJ0FJI+g9EBA==
X-ME-Sender: <xms:8KG5aBN1o2T4LiFLfrYLpLKq56U37CFUuykh1nbvoJ3vEo0gUxg2qg>
    <xme:8KG5aBjHjwcAlitpmrFvTzKSmwAzt4Qu-7LaFHycl11CINJpppUE4Aw56YD8dQzqI
    lmPWjuHp4WLQHiefg>
X-ME-Received: <xmr:8KG5aGvD5k2VRqeLgzADA1sq3UY5i04SWsuMbb6SdjNb21AjgJU2V18M7_24mM_GmypPllGbqJk-fEiVYLGrOFkj8vuddfiuj3df6BXzPT8pEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinh
    hvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:8KG5aPQqLLddqs7DPcZ9efOBnu75HyLw9mEbD2HS2zwXDFwM5dLH-g>
    <xmx:8KG5aK3hoi8p55V00aetU5AwxgrGpzEso3FepGSkbdS_AZsTMIMgDw>
    <xmx:8KG5aEvgcSRkyBb-DaccXZh-cDLL110a6W4e0SSFZCDDikyMR17YGg>
    <xmx:8KG5aAjdjDHaCM-6enYQ0b17TnIA1-03zOhNkwrlDWznXCqrIN42jg>
    <xmx:8KG5aPYPeXKDVAdpDm-fF1p3aS13h6X3ULNcsw76yN0cKvtf85n0s56f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:27:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 14f9cbac (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:27:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 16:27:37 +0200
Subject: [PATCH RFC v3 07/18] builtin: add new "history" command
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-history-builtin-v3-7-509053514755@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
In-Reply-To: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
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
 builtin/history.c              | 20 +++++++++++++++++++
 command-list.txt               |  1 +
 git.c                          |  1 +
 meson.build                    |  1 +
 t/meson.build                  |  3 ++-
 t/t3450-history.sh             | 12 +++++++++++
 11 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 04c444404e..3932d4d618 100644
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
index 4404c623f0..a30b5307fd 100644
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
index e11340c1ae..bed6eda5e6 100644
--- a/Makefile
+++ b/Makefile
@@ -1261,6 +1261,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
+BUILTIN_OBJS += builtin/history.o
 BUILTIN_OBJS += builtin/hook.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
diff --git a/builtin.h b/builtin.h
index bff13e3069..2934f4479a 100644
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
index 0000000000..d1a40368e0
--- /dev/null
+++ b/builtin/history.c
@@ -0,0 +1,20 @@
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
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index b7ade3ab9f..f95f0ce926 100644
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
index 83eac0aeab..9d2cba2906 100644
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
index 5dd299b496..0e40778a23 100644
--- a/meson.build
+++ b/meson.build
@@ -603,6 +603,7 @@ builtin_sources = [
   'builtin/grep.c',
   'builtin/hash-object.c',
   'builtin/help.c',
+  'builtin/history.c',
   'builtin/hook.c',
   'builtin/index-pack.c',
   'builtin/init-db.c',
diff --git a/t/meson.build b/t/meson.build
index bbeba1a8d5..966d7c14f4 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -376,6 +376,7 @@ integration_tests = [
   't3436-rebase-more-options.sh',
   't3437-rebase-fixup-options.sh',
   't3438-rebase-broken-files.sh',
+  't3450-history.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
@@ -1214,4 +1215,4 @@ if perl.found() and time.found()
       timeout: 0,
     )
   endforeach
-endif
\ No newline at end of file
+endif
diff --git a/t/t3450-history.sh b/t/t3450-history.sh
new file mode 100755
index 0000000000..9eb1ed6749
--- /dev/null
+++ b/t/t3450-history.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+test_description='tests for git-history command'
+
+. ./test-lib.sh
+
+test_expect_success 'refuses to do anything without subcommand' '
+	test_must_fail git history 2>err &&
+	test_grep foo err
+'
+
+test_done

-- 
2.51.0.417.g1ba7204a04.dirty

