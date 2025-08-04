Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08E624677F
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300780; cv=none; b=OjCUj/23AsDq/91fQ9LQ1SbQRAI8p8TMF4TqSEa8u86sSIsfpYhBAe23/uQ8Bk6o7a0wgNAhw0jJIuXK6/ma9V3V3SB2j+Xs6dHFBzZS14q+jQG6prOwKJiDrqDbmUwykNftUldmifAkvO7vjyQQZKhPj7WKa6VWKisgbONQKq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300780; c=relaxed/simple;
	bh=Hc11O7oG0nRH74yo2fzNLygCJa5qgWnS67d/Nk2zVaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IvFyNsQzuYxtN8DlnVVPQgTxUk8OkuQX/YxoY7mRfQBJ7NNgYZyseUe3lUNvuFGp6X46suYlCjxCLXtz5n7eh8OVglP2A1OHEDHqOUTXw/E1tWeokPK4IoCIlJYwTcxkXNeDtfqRLXj3QoEORwxfpGWU1u5bxllDQpqxUqgT35A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KLk5eaZZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JMF9uX4g; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KLk5eaZZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JMF9uX4g"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AF6C67A00C1;
	Mon,  4 Aug 2025 05:46:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 04 Aug 2025 05:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754300777;
	 x=1754387177; bh=unEgfeLs+zTBUArnihMrcWP1mZCFpRpWgWdPgmpfT8I=; b=
	KLk5eaZZ6/BdNb9TLpG4I9txWPj3ztn2N2wQKPndTGNnspq1w6SB3QhMqcboYB2+
	xWXMqwh0JYn20yTPdHABftTIYGfX9KANhz3uwVrx6eFXXnsya6dywdwQ9bmN+EW6
	OFcB8LPy3b8m7rDPuoOZLkRc69Q4mff/jn/UevEv1gj9zl2f8p66EPp+aOKFzPfz
	DCb8EYpRC7YYKKliEN/Y5o0i8K7+35LqmIQq7XAGfbNXT6WpnNNWbu0+AaRVl1xE
	YVXSwmpvaWU6RX10O36t2WxN7FNaf49ustv4/V6NgLMrP8BHtueaRYBc7HGlPPgP
	/Mxzy64o5UdtV4clxvgUlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754300777; x=
	1754387177; bh=unEgfeLs+zTBUArnihMrcWP1mZCFpRpWgWdPgmpfT8I=; b=J
	MF9uX4gpraXNzlf6SaPvoE64aOGOfuCK/ZPTUPqZ/mOTx0RKgtTQpZ778rdR+9tX
	oq26ZO0YsGdSvsr8DUtLyRWxbqax4zo9TkfvitTBM3bVsuBPgzmUR54ca9LD0igp
	TL+edbTuCePa0KOgplXRyAg7PR2m/L2xwnGSPHrTpOsoQ9Gt9aSIk8wTOUefnBCb
	MPIHMmS9QUyYXBhKWITZ1/E+Osny0QyHeiIVrYHSTwTEZDloK4HQ13pTOpWZvF8M
	QYQ/eFc6ARojj2p4xJN9NniflovgavzLlEBsPV6AcknRct3ngAGbjehglSGrD4xX
	k+5NJOYayyJoDhGfUqVSQ==
X-ME-Sender: <xms:aYGQaOx_xb10Gxsep-OBQtn1fcw6h3T0gzxYRtObwrdeBMVBvipqag>
    <xme:aYGQaHJUs1oP112lc4OoxchcGi0u_uoAF5l8Bo59ooWR3aeYwal86qTtrHrkZQQQt
    8mQQvaPtHNILUTrgg>
X-ME-Received: <xmr:aYGQaAEW3n49V9FElp4dF-E2OahOo4TU4RTVPLGad3G2enVFfTaSme68L9oVzPrg091ALS8gaRPrK8P8AT2kd4iNp6KI8YMRO5cSVLIPjfk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdr
    uggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:aYGQaD90wDR9jSzLahmoYcX_lmrA2JqQyan6Aq3O2wn2KJ7IxcocYQ>
    <xmx:aYGQaALPFzwTJqwroo9RXuDrG63qL4igDEm-sVpge0JIfZTEF5N6lw>
    <xmx:aYGQaBvs_VT3JLBav5j4PMsSD2zTVTCdj1OLFuHDHc2RuIqx8XHFJA>
    <xmx:aYGQaHCw7dyfSJIPI4djQW6UXKS2r8xncuA9rGg9yGwJm2zz4WTV6Q>
    <xmx:aYGQaLEFrqpmJyBypOmAcv69KgJzRHBFl0e0-yFxucWZEZaNutXREv7C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:46:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ddc407d2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 09:46:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 11:46:02 +0200
Subject: [PATCH v4 2/9] builtin/reflog: improve grouping of subcommands
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-pks-reflog-append-v4-2-13213fef7200@pks.im>
References: <20250804-pks-reflog-append-v4-0-13213fef7200@pks.im>
In-Reply-To: <20250804-pks-reflog-append-v4-0-13213fef7200@pks.im>
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

