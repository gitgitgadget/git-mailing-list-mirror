Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340C02749E0
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779339; cv=none; b=nNGoS9JTQRjnTqKtZ5rvQy7SEx3sHNlEDRYfdL9EltL/Je5M55lOxDP+1S4504sHpAy5fpZXy9zTT5GN22ANiBTmGMkNyi35g1OzQ8crKTtJOZY7V/swb9sW7sonclvTkbVYC2pPJdE4xbIC8UdyTj9c07+ugj7VewxLQMF/u98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779339; c=relaxed/simple;
	bh=g2nHNGPaLycvqfZHoiE617KC9wL1g1k04ahQjTbPP5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t7Td8P9BCOYFFGYfoEB0gB9XVbNv7xywsXkocBfGJvEvWHHoUtF2YailwlgPbmmzMevom1TuKvMdvai/UDR6V2CVMGyfiCQaFshaJv4Yqy6wkDwgTXR8ky9n9GfLjpBKq0qLGNLpSJYy5D4GOIIYmFQuAwESKWwsKn6IQ8HF3AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QQySUFGA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ddr7JeqF; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QQySUFGA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ddr7JeqF"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id A02481D002E5;
	Tue, 29 Jul 2025 04:55:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 29 Jul 2025 04:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753779334;
	 x=1753865734; bh=R0bAJwcL0HMWX1ZBBIx1EpmQuio+kZ3ZG0UVFCWchJ0=; b=
	QQySUFGAGLdyT5+Ztd+JTk513l8ghgVWljL3aWraifFF0/pzGe7j5e/iX76FN82i
	ijmP/6Xpg9FsZQwkjNKQuQyv8rXKbwpPV4NHnhc2/J/McCaurSv71gM9RMQoo0pe
	aDCXPgFEcbUCOQGtZApDwNC2tYBiPaCL7eebtiiCqX+96l/ActHj8C/frQFrTgST
	B3DYtCoWoJuPoqqqGFGqXlXd10CJ6kl2U5Tj6bBmoDZeRAAm9f35Jva+0enCvls9
	WZl7kxKBLB7tFTKdHXb67lCQWM84kEG3kKYRV3qKbOSgFdUl/2MN00wQ5PwRSYRt
	6KT8aZaehetmTa7DoLefqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753779334; x=
	1753865734; bh=R0bAJwcL0HMWX1ZBBIx1EpmQuio+kZ3ZG0UVFCWchJ0=; b=D
	dr7JeqFiHBXxp2Pzks32xVTNs6wmXVemtWcbANK9VrCbav5R8nQJFSsSU2ljbJlL
	YeStC+C//KoxMV/ow80PS9wnMeVhlut/UpSv20CwT4LCXaSvb1TPjwfQ/QmwcxiW
	72sG/m15mI1oo6POigj5zZk3l8YAbTo786dSzqBzkBp2Zzg+WpaCZqFKCPWlYlzL
	erpy9E9Ub5x6ewLnFY+2cdtyQPAjph9IkNREVFLMvR/Itr5pimj43+ic0D6ZCPUB
	tK0+JFw0UQtpChX5PFywMa8jPOngj66GBRYeMuPuqZvLk9QVH9U4pkQzji+jAVlx
	C2Ve+DPEjxtWiILzp/v4A==
X-ME-Sender: <xms:hoyIaGu4wQXd4E5KtgXVuDCToSnOTkYXo5I13n6CnkWhiqpNUAYLMg>
    <xme:hoyIaIV87dLfR6xW95IBOsIUp1hXY9aoZxkXnwaY-vJUG2QKTnpwLTP-GMgmp0hiS
    gtkEwebzVLSgckJwg>
X-ME-Received: <xmr:hoyIaBg4Jlvf28rzNLBc56gYFLlpTPdGfXCRQel_N2i3q8IzLJ0OtZAxrgTrgH058tQ5e2AVl0x3dbkWYgh9-s7jI3mRS-f8daA7YRbDoDk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehtohhonhesihho
    thgtlhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:hoyIaAqiSy1kmAmygOu4CVgYd6zwDIvljlden4it4Fw7Znd6dA7KDA>
    <xmx:hoyIaHGwolv4DiThjCd5IRSecct8LezNa0YtbMGXIt25czBdhFYN0Q>
    <xmx:hoyIaF6i_Z1DvT4sWdyEDe1zB5NVrjlPzZ09U6IZuhcfj7jdmLkfYg>
    <xmx:hoyIaPd8Us-db1LEaR3UvbrW5trEC5ACqZW1iGTbisheyiH8X9ie8w>
    <xmx:hoyIaFyWjJcqeuqYmcIYTjA_EQgG-FLeQ5_6as7DodTkTPAdZcSibyPu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 04:55:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f671e7a3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 08:55:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Jul 2025 10:55:20 +0200
Subject: [PATCH v3 2/9] builtin/reflog: improve grouping of subcommands
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-pks-reflog-append-v3-2-9614d310f073@pks.im>
References: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
In-Reply-To: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Ben Knoble <ben.knoble@gmail.com>
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
2.50.1.619.g074bbf1d35.dirty

