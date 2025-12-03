Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503982F25F4
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758933; cv=none; b=MFkQhWS4gsLo9yPsWylHz8exzBRp4xdfH7cczedhfFcBTEDKHakov0N7NUbF1fSUfj7EaLNEARUMRA4LStFkwB5IXky8hqJM+xgml46vsrW0vpg/+x/LVBjKGIOFxdt3LKy5d2JPNHSRhDVDqKr3AbU8RKmW2CJwyDZp4jja1Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758933; c=relaxed/simple;
	bh=9hEUg5WSAhxqnL0RURoB1W0EZ6QsBqp6ix3P15XioG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f+0wqvyO78p3Bf+aRnMr11sX2WQgPwkc3fwF8xgjDS5YcnEUZ8CsIH+BUCN889GrPvY37JYmmP6nHAQk9eDUt4jcALgmS2PeRILdgFujOyu0Af+neaQb+kl0PcQ6oNiQ721mZ0m1o4xJ+VGqV2RffqAYiIziLXXGY/P/fMu1qXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XlX0+lOr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dSzFQnQf; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XlX0+lOr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dSzFQnQf"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8608F140017C;
	Wed,  3 Dec 2025 05:48:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 03 Dec 2025 05:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764758930;
	 x=1764845330; bh=/S+RpEAGize7X1miXpoVLyDgxV5oPftGbhheIwI6ksc=; b=
	XlX0+lOr4EZ8t1VFUoQp9ndWPqqT+hYXKOuZd6U5+9TXPoaRE+MXHWAPumnWYfnF
	p9B4s74ON3Xx4Gjh+BGEF5y+fw4q81WhtDNmVO0iKijbk1EVu/qytiRnd3eTsNqC
	h0j67dnX5Qqb5RGwFxDT4v/rOxCoFDBBJCc20M0kW6B6z9JGa1FxJSALbACg8mYi
	sBRid5dE/Zs7+T3pBZtM2V4S4HjvBqK735ROYGpqEFwX39GV530VZVQxDssFgih1
	P5zAJruGJghwezLJ1qlNk2hqTo1/+zElFKUav8Qiw4VRqJrXUGSXDybeiGs8OTe7
	018NjH7qJAgSixknkTWKdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764758930; x=
	1764845330; bh=/S+RpEAGize7X1miXpoVLyDgxV5oPftGbhheIwI6ksc=; b=d
	SzFQnQfMpsZDFI04t3hA3TjXxxSDA5d09d4SsBN6UOm2tRL+ad2IQJtOECEIbD1z
	uGwvuMjgTJTDhrzdm9FGElPGc6L9ElyKDLoKijddqLpL6YX8tXB7d5XmEkuxvC80
	0fjB+gbbwyTTSOaklcCGLpma46JjeP+Lk41HR/7XkOf9j5Zbktb9rLf2c3LX6J9d
	Rp8hBb6a1GkUKOfVNJSPKfeg5rrU5sBVH2+a2UEEyOK/20r3y2Yi70iEYIp6L32c
	pA/fp4uFPuvgqPVJA+XgDKeB9Uhv0nRKfZjauMfuK2b9qSo7FM49oEJb6RCKNko/
	cTqK8/eWLaG8M8swbh8XQ==
X-ME-Sender: <xms:khUwaYXiTOaHOTTwDQ6rmBcOEqWLSDaojA77OLI4N9_LJLDWF-tthQ>
    <xme:khUwafLQj33Z7EHqcF3U1xDUq0zQjujS0ICRnfv5-UIvF2M_R338Kql9luvNxQW0P
    GpEzE6xWFmvQIHp95bvfI9Y-7tD8ZjKpoI8z9iKdA2uPwDCH0PwEA>
X-ME-Received: <xmr:khUwaQA4K65zQLAJrPA0x--DjOrUGTRiWYmnOW8BC1zAMmsM1BwCR7DubYdbIbjO2JQXmr-syvqGDMdJEkJVAiOX4DRJdHr47QjYKxI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghv
    ihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvoh
    hniiesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:khUwaXeNQ6pf2lWUGVi8vxcF60Exk0WHCsg8KuK0i69VXrP5Sxcr1w>
    <xmx:khUwaX1VEE1cUzwRqIsAWPBE0tTZjMlk3En8psI7D0VTee-_o3olBQ>
    <xmx:khUwaWhqoMMiGRQTVdIiMhUfmy6vg65pYUY9N4GTVMBTDAOtFSnrJg>
    <xmx:khUwaYm6zXvJ4Fe7nLNt7QBoPvHNL3gpfEzkQJ4pmiGcIjb-Gbl4lw>
    <xmx:khUwadCtZ0hVo5Kno9fyDQF6ayoCx4N-IrkVI83LUsEFRS3xjkHF9ema>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 05:48:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ab0ec802 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Dec 2025 10:48:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Dec 2025 11:48:31 +0100
Subject: [PATCH v7 04/12] builtin: add new "history" command
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-b4-pks-history-builtin-v7-4-9e9f849bfd0e@pks.im>
References: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
In-Reply-To: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
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
one wants, and then perform the actions. Furthermore, some operations
like splitting up a commit into two are way more involved than that and
require a whole series of commands.

Add a new "history" command to plug this gap. This command will have
several different subcommands to imperatively rewrite history for common
use cases like the above. Some of these subcommands will be implemented
in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitignore                     |  1 +
 Documentation/git-history.adoc | 42 ++++++++++++++++++++++++++++++++++++++++++
 Documentation/meson.build      |  1 +
 Makefile                       |  1 +
 builtin.h                      |  1 +
 builtin/history.c              | 22 ++++++++++++++++++++++
 command-list.txt               |  1 +
 git.c                          |  1 +
 meson.build                    |  1 +
 t/meson.build                  |  1 +
 t/t3450-history.sh             | 17 +++++++++++++++++
 11 files changed, 89 insertions(+)

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
index 0000000000..67b8ce2040
--- /dev/null
+++ b/Documentation/git-history.adoc
@@ -0,0 +1,42 @@
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
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
+
+This command is related to linkgit:git-rebase[1] in that both commands can be
+used to rewrite history. You should use rebases if you want to reapply a range
+of commits onto a different base, or interactive rebases if you want to edit a
+range of commits.
+
+Note that this command does not (yet) work with histories that contain
+merges. You should use linkgit:git-rebase[1] with the `--rebase-merges`
+flag instead.
+
+COMMANDS
+--------
+
+Several commands are available to rewrite history in different ways:
+
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.adoc[]
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
index 809b094595..458841178b 100644
--- a/Makefile
+++ b/Makefile
@@ -1408,6 +1408,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
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
index 1878dff2b1..f07a308fb8 100644
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
index 7c994d4643..62f5dca098 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -386,6 +386,7 @@ integration_tests = [
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
2.52.0.239.gd5f0c6e74e.dirty

