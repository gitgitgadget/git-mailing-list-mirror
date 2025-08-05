Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2547279DCD
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406714; cv=none; b=n8UMSzngkjK0aouEpcUl7XV0gMAw7eijBOrTLASisRGt+bkWlooCjs9X94EtLll7EilcThvl5U8vFAIKkW1yWOPAtYA5zhp+upXLzoDaJ7yxxNLj6Bi9SqGWCmvQT5YjY74L2FhWt+QxbxxRdJj4vBp7WBhSkOvy3DxYKR8b2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406714; c=relaxed/simple;
	bh=Hc11O7oG0nRH74yo2fzNLygCJa5qgWnS67d/Nk2zVaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rips1OW80U1kSW7UXeZBACxeC5rASc9e+RKgd9Z0qBRgiqg0dCdZaJbtOTSnWH/+0DSBywnlSgjmwb6aTxcB1piEHfyQTATrgsQqV4TIUqjCzdtJ+e14HFUK/r+XB42Dg3XeBINP0JxCY088DC7jmYtGlnndXmwXRRWT9munOUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LDRvsAW1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hV3gyPGw; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LDRvsAW1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hV3gyPGw"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F12B3140004C;
	Tue,  5 Aug 2025 11:11:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 05 Aug 2025 11:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754406711;
	 x=1754493111; bh=unEgfeLs+zTBUArnihMrcWP1mZCFpRpWgWdPgmpfT8I=; b=
	LDRvsAW1oN1GxssoIwZlEFLi4zju3/rX7P7y7FRTCAlV6VLwrLaIyPVW/sKCTb5l
	5h4FKaVADBNGlsUjKoWlebhNElZEdsbY/sacV/z1CYlX8gDLrI1N2+yGOvS7m5Ei
	zL7YFTHnRyVohvcc8eRst9pos1NA2a4PgQGbpxJrggdCV4cPnQ1E3NMl/WF3haBH
	yU0yWJkLhILtgG2iPLljEexjlApeB2XnFq5ASRuVxyJbjY3tBnQKcwng/dIooUFk
	/CP10sh6sGHTF4+cp5r+flm5jowOoj9MCrRYMkrmmM96IzyCpT3E5vlSMX/4aFsz
	IM/SdOqwe5Whak0JE1+lJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754406711; x=
	1754493111; bh=unEgfeLs+zTBUArnihMrcWP1mZCFpRpWgWdPgmpfT8I=; b=h
	V3gyPGw3TXbOja3qRlmM7ThwZYX32G97EnRE2YUxcLd5uhAPyHw308Kv/cBwnycE
	Ibshrrqt8EeKBGdMpC/uwRkUCD3GaYUdBQrqg5nylcjq4slrdZwnJkV9zuyi4bkD
	UCMWcUZfd4YvVP5te/5l24j2VXcfpG8/K7tw+BdFfGHUhps59ncMLyIdTxGH0YRT
	wyNwysU1f5vYwbyb4qym8lL0SVKHhnLLg+lZvm46B+Mf3Yt0MTEZx0rslaQsE/uW
	t9HM176L02uhpauVAXgIAmCLpzZsqsDpkDAioFvdCrvUbrZ9xKYBqP0C9kE8iYRI
	gz3xhVr2fIASAMOmUxFZA==
X-ME-Sender: <xms:Nx-SaIqVXdQKQqcBN2AzerVjpMHsyB1a3sqfi0TfpQbBO8BZ1nF8yg>
    <xme:Nx-SaLh8iI5nuCSwfKyEN3RJWbSQNg8OlStH4ZqFACBYnxmzT-sKZK3sBxn-5qtBk
    tfV5c9zAflLWcno2A>
X-ME-Received: <xmr:Nx-SaM8fV-fzZNvYlWFB4SRJyUhtvQzWnN6jefCW5BhKd4B5VOV3wry8x4BgjTYrtiiPFaQDqfl3OayMTuFXBMB7dJYPLbD0g4EqfOKGOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtth
    hopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeek
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:Nx-SaPW0AB0RMi5DtpeZM21ja3LCXoD3F_yMwU6HeB21vV1ZFUuFgQ>
    <xmx:Nx-SaIDgXlX3kjpbgA23TR5N6i2xjAE1TGbnupmcMuLspmrVnbOmKQ>
    <xmx:Nx-SaMGSH1Yx6gCwIeAxVvpjugezhLX5rMOCjxRZ05LNVDaeCLm0DQ>
    <xmx:Nx-SaB7JAinH_627qne4vpFTKkqCnUXjJQrnGzaWDcRG6QXf85i0tw>
    <xmx:Nx-SaMFZkBQ5lHXHDnPxoWLIlxutX8d_l61u5bV-2gYOfB5LdQa2--UB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 11:11:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bfced13e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 15:11:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 05 Aug 2025 17:11:32 +0200
Subject: [PATCH v5 2/9] builtin/reflog: improve grouping of subcommands
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-pks-reflog-append-v5-2-050997db09d5@pks.im>
References: <20250805-pks-reflog-append-v5-0-050997db09d5@pks.im>
In-Reply-To: <20250805-pks-reflog-append-v5-0-050997db09d5@pks.im>
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
index 707a9b39ed..c3801b82fb 100644
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
index 3acaf3e32c..b00b3f9edc 100644
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
2.50.1.723.g3e08bea96f.dirty

