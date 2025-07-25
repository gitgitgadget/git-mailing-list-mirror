Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC728A1EE
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753426720; cv=none; b=iStOh0tgxGquTBZ0KzN4+5bmQPR/1H9qXw06CHaJbW8cpudksbsQqDCCmg2jb/UMeuRB2dNvkvQmQBtuYzj5bMPckp5YRXhBdXYOo1O39WD0Kwk+TRHogKGwsnG5Wg5UAwLxP7L6d7vgOHugRAyzcoW0mBVFmqxpddbBmSnx+JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753426720; c=relaxed/simple;
	bh=I9MR6SQuwqg134Ls121XRuKqtRP2XB4O8lIbrV5OR3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eyPIKGx3w10FjdWwTpqUonq6tAmoINU3JJHYyiVaSiqVAvphAtvUq6dQRiPLbPqVycuOJ/OLDE59MbBeDgzE5m7HFe+aj51D/0vQIcO3qYznbTrrHsXStG+mEFceDlqvBK0OcmKUZcAM9mEBC4fqt223v6jHPfQHYKwdx0byYWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iDbp9+Xq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h1K44h7k; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iDbp9+Xq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h1K44h7k"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7B390EC03D3;
	Fri, 25 Jul 2025 02:58:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 25 Jul 2025 02:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753426717;
	 x=1753513117; bh=eqU7B2ePyQi8YVG86Ga+VshyJCSUrHNCWL7tmwC3HQ0=; b=
	iDbp9+XqFK7wFzsoyYaC8guYQP/q6bFb6RbBQfLY0Cvt+mxM2D8bh+y+bneMV2ZJ
	sjH4eTfKCcRxtpLLBXUxzq8snd7nZKRUnySwL1+S5ENe1aB61PzHLG5P/fo9qd3m
	kWxGdwU7w07v+OxGHssSnQjJxuIEt6HyWr3Q1jBKRWSn4eOqseU1owTckyLLqF0/
	P6xXK78G3Nr1oHlLsxpH1ESmBD+SizOYEexRhdRyeU3ZCOganXo3hQAWZ/AQebNf
	THP5egaghUbimvo4JOYiKpNqXdTSKITw0poJ0osLLIZS8LweBlqK9MFtVf7S1U3E
	cImu667h58s5QzEC18pzNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753426717; x=
	1753513117; bh=eqU7B2ePyQi8YVG86Ga+VshyJCSUrHNCWL7tmwC3HQ0=; b=h
	1K44h7kZ2phA5IWDrOyJaSUujzrpMMrLKCBdmzZoIJ1H+LXv1dGsCI4vJNvtjvcv
	MJ5D2LbFYR45GL7fLO3MXHKZ8/L6ynbJwdJe3UmKUfBDvN+528mONSFsOKoH/4UG
	Z91nreyLT1+e13u2J7AnZcO980x7VRjmpq+ex2CJD2sRlhFb/n0SdFB1KE55j/Xm
	KtsfWn5b9Uynu0hGua9xKxESrGyEdaejYAw7rUKzXyz1bo0HUpnFD17p6vY0jwe7
	NovLzqFqAa4J3To3vFSPvTwhdQfiKZjJoByJIlP/oBJ2KmveubJ+F7D008Wm/C/v
	jzzoxp34/+C2Rg+bPfN0Q==
X-ME-Sender: <xms:HSuDaPt31BQRJtuO-sWYYwu06bBlcyH2mQYSO6t6OS1zy7tsjlsseQ>
    <xme:HSuDaI7yaVAvIJARrTBFtH5j5-D_Bgget99QBUgPTRAtMkaN5HtlnhH6Ru7PMM4RI
    EgSe-Yf98a9H-l4Ew>
X-ME-Received: <xmr:HSuDaDNK3Q9baeupDiV6L5N4b42aUzwfjXP9AQShF_lMxaknklE-puY2k7ArLaRYmBeoOrbqCNw4OI9QPsyhv5CuCqBD0RzJdb_MiIIubIf4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekvdekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohho
    nhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:HSuDaOs4XJlgFtWx0Br3sS6tqGKctfEXBUH4q5g2-o7nvJVieKbGQQ>
    <xmx:HSuDaOZ8O_m92EDGXWeJmkho1DCOF4QzOEkz3-rS9jvDpO3Op8nbjQ>
    <xmx:HSuDaIxImza4qT79WJa7V26btOA7cVY1Lj8ccK7yrb0T4akxzYzwfA>
    <xmx:HSuDaOivKQsgUn1pSsxz89oqKetb5dTnUmd2hgawnuYE0x817Ca9dw>
    <xmx:HSuDaIMJc0-rLUrTA1Nhtkd2ikP4A8m-RNQhbTmsLTS1GM7hf9gFCyA9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 02:58:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4fae4906 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Jul 2025 06:58:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Jul 2025 08:58:24 +0200
Subject: [PATCH v2 2/8] builtin/reflog: improve grouping of subcommands
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-pks-reflog-append-v2-2-e4e7cbe3f578@pks.im>
References: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
In-Reply-To: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

The way subcommands of git-reflog(1) are laid out does not make any
immediate sense. Reorder them such that read-only subcommands precede
writing commands for a bit more structure.

Furthermore, move the "expire" subcommand last. This prepares for a
subsequent change where we are about to introduce a new "write" command
to append reflog entries. Like this, the writing subcommands are ordered
such that those affecting a single reflog come before those spanning
across all reflogs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-reflog.adoc | 61 ++++++++++++++++++++++---------------------
 builtin/reflog.c              | 38 +++++++++++++--------------
 2 files changed, 50 insertions(+), 49 deletions(-)

diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
index 707a9b39edb..c3801b82fb6 100644
--- a/Documentation/git-reflog.adoc
+++ b/Documentation/git-reflog.adoc
@@ -11,13 +11,13 @@ SYNOPSIS
 [synopsis]
 git reflog [show] [<log-options>] [<ref>]
 git reflog list
-git reflog expire [--expire=<time>] [--expire-unreachable=<time>]
-	[--rewrite] [--updateref] [--stale-fix]
-	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
+git reflog exists <ref>
 git reflog delete [--rewrite] [--updateref]
 	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
 git reflog drop [--all [--single-worktree] | <refs>...]
-git reflog exists <ref>
+git reflog expire [--expire=<time>] [--expire-unreachable=<time>]
+	[--rewrite] [--updateref] [--stale-fix]
+	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
 
 DESCRIPTION
 -----------
@@ -43,11 +43,9 @@ actions, and in addition the `HEAD` reflog records branch switching.
 
 The "list" subcommand lists all refs which have a corresponding reflog.
 
-The "expire" subcommand prunes older reflog entries. Entries older
-than `expire` time, or entries older than `expire-unreachable` time
-and not reachable from the current tip, are removed from the reflog.
-This is typically not used directly by end users -- instead, see
-linkgit:git-gc[1].
+The "exists" subcommand checks whether a ref has a reflog.  It exits
+with zero status if the reflog exists, and non-zero status if it does
+not.
 
 The "delete" subcommand deletes single entries from the reflog, but
 not the reflog itself. Its argument must be an _exact_ entry (e.g. "`git
@@ -58,9 +56,11 @@ The "drop" subcommand completely removes the reflog for the specified
 references. This is in contrast to "expire" and "delete", both of which
 can be used to delete reflog entries, but not the reflog itself.
 
-The "exists" subcommand checks whether a ref has a reflog.  It exits
-with zero status if the reflog exists, and non-zero status if it does
-not.
+The "expire" subcommand prunes older reflog entries. Entries older
+than `expire` time, or entries older than `expire-unreachable` time
+and not reachable from the current tip, are removed from the reflog.
+This is typically not used directly by end users -- instead, see
+linkgit:git-gc[1].
 
 OPTIONS
 -------
@@ -71,6 +71,25 @@ Options for `show`
 `git reflog show` accepts any of the options accepted by `git log`.
 
 
+Options for `delete`
+~~~~~~~~~~~~~~~~~~~~
+
+`git reflog delete` accepts options `--updateref`, `--rewrite`, `-n`,
+`--dry-run`, and `--verbose`, with the same meanings as when they are
+used with `expire`.
+
+Options for `drop`
+~~~~~~~~~~~~~~~~~~
+
+--all::
+	Drop the reflogs of all references from all worktrees.
+
+--single-worktree::
+	By default when `--all` is specified, reflogs from all working
+	trees are dropped. This option limits the processing to reflogs
+	from the current working tree only.
+
+
 Options for `expire`
 ~~~~~~~~~~~~~~~~~~~~
 
@@ -130,24 +149,6 @@ which didn't protect objects referred to by reflogs.
 	Print extra information on screen.
 
 
-Options for `delete`
-~~~~~~~~~~~~~~~~~~~~
-
-`git reflog delete` accepts options `--updateref`, `--rewrite`, `-n`,
-`--dry-run`, and `--verbose`, with the same meanings as when they are
-used with `expire`.
-
-Options for `drop`
-~~~~~~~~~~~~~~~~~~
-
---all::
-	Drop the reflogs of all references from all worktrees.
-
---single-worktree::
-	By default when `--all` is specified, reflogs from all working
-	trees are dropped. This option limits the processing to reflogs
-	from the current working tree only.
-
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 3acaf3e32c2..b00b3f9edc9 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -17,21 +17,21 @@
 #define BUILTIN_REFLOG_LIST_USAGE \
 	N_("git reflog list")
 
-#define BUILTIN_REFLOG_EXPIRE_USAGE \
-	N_("git reflog expire [--expire=<time>] [--expire-unreachable=<time>]\n" \
-	   "                  [--rewrite] [--updateref] [--stale-fix]\n" \
-	   "                  [--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]")
+#define BUILTIN_REFLOG_EXISTS_USAGE \
+	N_("git reflog exists <ref>")
 
 #define BUILTIN_REFLOG_DELETE_USAGE \
 	N_("git reflog delete [--rewrite] [--updateref]\n" \
 	   "                  [--dry-run | -n] [--verbose] <ref>@{<specifier>}...")
 
-#define BUILTIN_REFLOG_EXISTS_USAGE \
-	N_("git reflog exists <ref>")
-
 #define BUILTIN_REFLOG_DROP_USAGE \
 	N_("git reflog drop [--all [--single-worktree] | <refs>...]")
 
+#define BUILTIN_REFLOG_EXPIRE_USAGE \
+	N_("git reflog expire [--expire=<time>] [--expire-unreachable=<time>]\n" \
+	   "                  [--rewrite] [--updateref] [--stale-fix]\n" \
+	   "                  [--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]")
+
 static const char *const reflog_show_usage[] = {
 	BUILTIN_REFLOG_SHOW_USAGE,
 	NULL,
@@ -42,9 +42,9 @@ static const char *const reflog_list_usage[] = {
 	NULL,
 };
 
-static const char *const reflog_expire_usage[] = {
-	BUILTIN_REFLOG_EXPIRE_USAGE,
-	NULL
+static const char *const reflog_exists_usage[] = {
+	BUILTIN_REFLOG_EXISTS_USAGE,
+	NULL,
 };
 
 static const char *const reflog_delete_usage[] = {
@@ -52,23 +52,23 @@ static const char *const reflog_delete_usage[] = {
 	NULL
 };
 
-static const char *const reflog_exists_usage[] = {
-	BUILTIN_REFLOG_EXISTS_USAGE,
-	NULL,
-};
-
 static const char *const reflog_drop_usage[] = {
 	BUILTIN_REFLOG_DROP_USAGE,
 	NULL,
 };
 
+static const char *const reflog_expire_usage[] = {
+	BUILTIN_REFLOG_EXPIRE_USAGE,
+	NULL
+};
+
 static const char *const reflog_usage[] = {
 	BUILTIN_REFLOG_SHOW_USAGE,
 	BUILTIN_REFLOG_LIST_USAGE,
-	BUILTIN_REFLOG_EXPIRE_USAGE,
+	BUILTIN_REFLOG_EXISTS_USAGE,
 	BUILTIN_REFLOG_DELETE_USAGE,
 	BUILTIN_REFLOG_DROP_USAGE,
-	BUILTIN_REFLOG_EXISTS_USAGE,
+	BUILTIN_REFLOG_EXPIRE_USAGE,
 	NULL
 };
 
@@ -404,10 +404,10 @@ int cmd_reflog(int argc,
 	struct option options[] = {
 		OPT_SUBCOMMAND("show", &fn, cmd_reflog_show),
 		OPT_SUBCOMMAND("list", &fn, cmd_reflog_list),
-		OPT_SUBCOMMAND("expire", &fn, cmd_reflog_expire),
-		OPT_SUBCOMMAND("delete", &fn, cmd_reflog_delete),
 		OPT_SUBCOMMAND("exists", &fn, cmd_reflog_exists),
+		OPT_SUBCOMMAND("delete", &fn, cmd_reflog_delete),
 		OPT_SUBCOMMAND("drop", &fn, cmd_reflog_drop),
+		OPT_SUBCOMMAND("expire", &fn, cmd_reflog_expire),
 		OPT_END()
 	};
 

-- 
2.50.1.565.gc32cd1483b.dirty

