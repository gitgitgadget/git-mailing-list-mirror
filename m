Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FD8201266
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 05:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459671; cv=none; b=pLdKNj4O44GoQzOi+xtxdYbC22aXkWAPPBlylDP+oSpowHMfTtM/iQgaCDXcdYARCoAHhm/3NTdy9HtmEgXHmdaZEpx56qm64v2WEL5u+C1le0lAQZBCeTG0ARNGK0ilmXHW+jRpyiOFcmLNxuCPuN2Ecv4tVXmlBJN5SNo2l2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459671; c=relaxed/simple;
	bh=NMlHKrumL+ng9rFGuBdnqcrH8cU8jdXOLDH/OFJpU9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A3qs5YZPc2GKfulux2Ygac0RJ5fA+AwWkVCXjga1f/LGeroewO6U4QnG8lvaydoFVr4qvU++PKzkPhEmmdofvtxoqC2+1Gg7gX4wsQ3ADvBX/ECvc4R+uYA0CopMIbYzxLPJzkrVfRFx0BZTf2cPP7ujS6nkmwIsaoFh7yCemU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=My47plLv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lvwQ/69z; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="My47plLv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lvwQ/69z"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A791B1D000F9;
	Wed,  6 Aug 2025 01:54:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 06 Aug 2025 01:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754459668;
	 x=1754546068; bh=PloBno4xWCs5xaT96hP90XBVMD33cml107eI5bQwe3g=; b=
	My47plLvQr3xDFEh2UhyeXSupi0exNc8HrEvwBvdkvkuXWHCyCUCxLaEQKZtFxW+
	MWF371Xa0crYdJebOFFlB/1gYVROHeu20nzRBxylpIEysNs6mXDzZTamjMCFypk2
	EZjDm16wzROLCWr8mZ+3g2Zf9kGjIe3k6jItNRFQQ8rm8nsdV9YMchVgsphyXaxC
	S3m4ATR+uzjTf7Hg3wNsPtalUu7CFUxdOZBqqlddZH+kL6ojcOoh1wocG/opqsOX
	hsBa62j2Iiy6cc4EKtO0FmjsHBDx3cF/AvmawQt8YQKV24LOAnlB/uGLVIoJP1ra
	e6qfcm90GUFg2jVlSbeqHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754459668; x=
	1754546068; bh=PloBno4xWCs5xaT96hP90XBVMD33cml107eI5bQwe3g=; b=l
	vwQ/69zuWBzQIcga0j9fLXJQ1eWYwpR5+FExsUlF1HJV9VhdHsrbWDgF9xd5VCoP
	rlPCMuXz5Jz4cozaR7KNAuKvsVg62bjhTFEDv+BUscYQuEW61WaZi9qACupNJKED
	6YL/CieXMxndfFvftVDl21SRxO7LW7YwgWTC70czmzu0Ihj+Cebjoi5BBJ4gaPFo
	0uQnc5vHafpj9dt6H4UwFDT7d55VL/XPnNheDdyLw0nYbzQepuMvxyes/gJ/dTwb
	pvey/5RNi7BE+UhXG/osueyjkfy9QPnEYB8GMs2tC45HveIG9ZaQKyvBegQKwjCc
	z5jyQeC3jLA+lXKEPIC6Q==
X-ME-Sender: <xms:FO6SaAGGA7fmvMvWMuhsrP5pgZUqLSARjYU5kVnrRO1uPHI07oOePw>
    <xme:FO6SaFAtd_GulDtzrW3qpxurqjPegbYMJF93slndyCwXRrKRaqURPly0AYzKDccAl
    zfPa7CbTrWyJrrplQ>
X-ME-Received: <xmr:FO6SaGksqTjpTS4M9O-pOYftdHcVwwVy-rEMQO7ss_h9hQP_3GmcX_2aHBQ5nbKKLsxsSDVc8Z6ps2P10KSdNorbssbAGp5k32Q_nc2eMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsh
    iivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgr
    sehfrhgvvgdrfhhrpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:FO6SaLMW2HjB4ylNA1k3BGzw_zW265OqpX8B8aa5FOZRBS1Pf5Amew>
    <xmx:FO6SaL_zbJj9uMzUNVoglyaziEK4Rv5vGfndc5heb1HTYT9YOy_P7g>
    <xmx:FO6SaFHLNbORquB4GytX4M-vN2J6h12rltNNgHXwcnBgBmfe9lq8FA>
    <xmx:FO6SaChosBEZLQWEIG62MXt3KJzcteD43JkVSimof3sUnJuVF64A6g>
    <xmx:FO6SaIJP0lTBk9vhNUrhQs-yT3dDk1qv2Mqllz-4kY6L6IBuYha5m4gK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 01:54:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f651da4f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 05:54:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 06 Aug 2025 07:54:13 +0200
Subject: [PATCH v6 2/9] builtin/reflog: improve grouping of subcommands
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-pks-reflog-append-v6-2-a50839653766@pks.im>
References: <20250806-pks-reflog-append-v6-0-a50839653766@pks.im>
In-Reply-To: <20250806-pks-reflog-append-v6-0-a50839653766@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Ben Knoble <ben.knoble@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
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
index 0d6601fdea..4eb6c25607 100644
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
+`--all`::
+	Drop the reflogs of all references from all worktrees.
+
+`--single-worktree`::
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
-`--all`::
-	Drop the reflogs of all references from all worktrees.
-
-`--single-worktree`::
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
2.51.0.rc0.215.g125493bb4a.dirty

