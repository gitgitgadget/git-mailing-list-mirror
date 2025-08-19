Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB23326D69
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600977; cv=none; b=XklEOO0jVDAVyAWIOatV3XPZaTCbUsxNe0U/1ZwlB8BTyqzUUk/5RNwuUrH5hWm0D8VPQOq60QjcFHxlDh2V3EjX/nxiW2b6DDy3SUPFp83BqpjMHzH++n1c/5nj1K0nFZzNKbMvjRnjXh8y87olNYQ80mDgUvinPEB9rvvWb6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600977; c=relaxed/simple;
	bh=IEMcnKyY2v844XAw6UZRSCOeeztLz7Ob7CxBb3udhZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TY1LjFbt1ofO8cvm5BA/GaoJO3868LDQz9GCINtu6LIwy6Vq0lEgDihb/KQG7SA8jnv19ZedCgxE7C/Ea3TRhUJdUXwCoEtsokTMMvsSZJndCUYSUjVM/11OE7+7g/CBphsGKt4fYMCEM+WjAubgPmNarhlpMPYAgnuOVITqJVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VA4ezufn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J56Q0fEq; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VA4ezufn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J56Q0fEq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id F004F1D0020A
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 06:56:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 19 Aug 2025 06:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755600974;
	 x=1755687374; bh=5iEE9n0nMsSb9Ao8D9gIjYv4rtt10swJ0Fo2Jrz2gs0=; b=
	VA4ezufn1kohHHThtyK6qnnMog1ySdgLGHdXSmjr/h45dgEKluOAyXkqSBWIQcTh
	aqgrIMcdqZ4lq80SHWPzKTMprD2SJEoymb4sj6+HGGX09Ju9NgEOS16vaKfnb38I
	7i1NIFKGf8n+c5c7R+K8NAslAInUXEBXjGJue4bP80MnVEjOi25uS3JSder7qbRC
	Jny1FQ8ID5G3meTQj6iB0GWMjBmyk/uPY8T5vQiyyQ8qm5G6u8ud5JbDUDckV/vz
	0Zbv8UL4Mq4hthZSSWbQzfX7hwzlYnjD5pWYQdGD0zIIVx7uJro0HixqHDOoo0k0
	UJSAev9uY7vrC7VrTSavoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755600974; x=
	1755687374; bh=5iEE9n0nMsSb9Ao8D9gIjYv4rtt10swJ0Fo2Jrz2gs0=; b=J
	56Q0fEqIRMBhYCrK9fSheFmBoYVbOpqsKm0rONGrzFYwcRQ9m6xmp6peNhRt9BxR
	MSZm7b6D1vXCex3qQt0h4u7igaUAcgo+sLFRjhRUU88gdmLU4yRvL12GO1ausg4x
	V9Gg1KxcLsYfp91+dkcKwqgvlkutaK2EP5IsXpr9rxhypkb+iaS5YO8whLKfQhra
	N92XOmCUCbS1hKrBbT/grPWX1nSPBrq4Qx3WoEk85p/QDUrg1jsL/kTV9tixSf5o
	PIOrr9pYLf28O0E62uD84qEzlHwtTLa0LMBJ9KHYz+exn6DaTWEFbBHVKlmMc5jc
	nugkn0+JyGYpj3Uce5xjg==
X-ME-Sender: <xms:TlikaMT1q4rsGASHc2FM1_F26fcjam-940L88GPnWjk9oqqLLRI3QA>
    <xme:TlikaLwn2I46QKNQFUNGdkeB0HHDZEXR6qiWlIuV1iQF0XQ0FT0durX-hOqXKl4xm
    NIGvlAXGkDrbDKhAg>
X-ME-Received: <xmr:TlikaDNUgRc2lHQppIQT8Ta1f7lXjX3Qvun2HtpHdknre2k1R9MPlmJUCgpqydMVZT2OOjhFWJqlu6zIYA6EbCzc3FwjAtNCNED6vPsfKCtU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:TlikaCOh361J2VsStOIsP0eUMtFH4VMMoQK8djQaO4FDto5HlWE8dA>
    <xmx:TlikaNT665q3hTw2ozNPA1ZjYGy0S5vDZCgThWeH4Hb1HRjisyUSYQ>
    <xmx:TlikaMBNQxz6FFqMWIjFxzAsginDD-z3okFLMe1tTx_FvcmYO3IbKA>
    <xmx:TlikaEg6FoY2P1oqa-eW0CLNm1GR25GKuzCj2Zczemal8gm4JxbsMQ>
    <xmx:TlikaNJUEdvwbQpcNdbTrCs-W4jZ5spLCunOOAL6LQvSLttKnhgTXNwN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 06:56:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e5ea1d50 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 10:56:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 12:56:00 +0200
Subject: [PATCH RFC 04/11] builtin: add new "history" command
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-history-builtin-v1-4-9b77c32688fe@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
In-Reply-To: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
To: git@vger.kernel.org
Cc: 
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
 Documentation/git-history.adoc | 43 ++++++++++++++++++++++++++++++++++++++++++
 Documentation/meson.build      |  1 +
 Makefile                       |  1 +
 builtin.h                      |  1 +
 builtin/history.c              | 20 ++++++++++++++++++++
 git.c                          |  1 +
 meson.build                    |  1 +
 8 files changed, 69 insertions(+)

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
index 0000000000..9dafb8fc16
--- /dev/null
+++ b/Documentation/git-history.adoc
@@ -0,0 +1,43 @@
+git-history(1)
+==============
+
+NAME
+----
+git-history - Rewrite history of the current branch
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
+COMMANDS
+--------
+
+This command requires a subcommand. Several subcommands are available to
+rewrite history in different ways.
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

-- 
2.51.0.261.g7ce5a0a67e.dirty

