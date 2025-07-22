Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73332E3384
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183273; cv=none; b=FxnxDxmirHsNKI5QmtoNKNU3hh6Y+ZC/uQSQ4dnEGb+jl5UB0c3MNwXxSYyZ7WgK0gsCpQCw/qm/0aXbQ9jiOnZACyMSVxR3FncED9x1spHJiECSAY86EAz4sN6Oj9j7ED5KLvgOimqdTEdsAtvYVQCPEkrHfSoDyzBrrIeiDrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183273; c=relaxed/simple;
	bh=ieQ4ViKFA/5ct6xcIzgDIE+Hc+5lXU8mcwQKhvrb4NQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jpUMRtXD5WFGMBbgJis4+iXKEJPk3dyvsmprMt4bKfRpq1J957QupG3AZ4O25MdgPnxPeZLdzYwDzmgV4vDJHL32dajtw3l6iYkdl94uPfbjuiQiEdWfuToLdJZxbNgGcMAUk1WmCWGIZKNGlqTIQnM+N+9F7+/QkVpJJDdaVsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kUISvN/z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D1p6akOk; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kUISvN/z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D1p6akOk"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 100FB1D0024C;
	Tue, 22 Jul 2025 07:21:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Jul 2025 07:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753183269;
	 x=1753269669; bh=w74W61J4FvDhnKAXoof3+HV/QHmnRGpTUTLh9jQXR/E=; b=
	kUISvN/zSSTQY9rxDZcbb7LuxPfoV97NcD3nQzjIBb6SRjMGEqXaOiBbyxqJPtn+
	COaSFF1PH8OYeKJcH/I/VHp//zVdghCgOth2b2hkSo4mK0sM3zdO5kkJ/SHE/tAE
	MEQ4F/Dn9O0VouvRjF2q1jYkO+CCpYBa6pfRk2CHXOvNlbqBJwYH/pg/XtZqMFho
	lefn9xDjNItBZHEJN/1MdM3oGO4z8hEcUlob8UrfU4krl0jQ+BmKep1G6KkWdye7
	6TgAcQt3OzRnzrwnnBc5Oc8f+kalpZkIjKRvzFlfkdUw2qLAV18lXaw6U/KIR2ph
	9dYmWFlRSvcvs1QX1lnPbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753183269; x=
	1753269669; bh=w74W61J4FvDhnKAXoof3+HV/QHmnRGpTUTLh9jQXR/E=; b=D
	1p6akOkhu9iszTxGRfq98AMSmdPwi10bDmTAbRTkfnDlg7lWk96QYRYD45HaHhO0
	0v8Icglm1oD1sulvVmUjCoQOPyqmtXzPgekTWnZdjlvA+YuBx8bknMGeNThG/sdG
	0nXdEUFYhTga4m3hIAXkDNbVJTpBaqMEZl8CKfcip2othaotXA/5/vZiwWsKEBDj
	2g/i2oUgn0qRJ261ONHonkgwSphEJfE8zRaGGrNdMYtGKijjKJkZWryKY76klz1o
	l3V+ku92jW42Tc4L04smJBrRCN78IMuXxoJtyTp3x6fT1xOl9SYYWJvMak+rcFUA
	3836sqVnboSzvtbm8rDPA==
X-ME-Sender: <xms:JXR_aE0ONnKio9eWUyPFAGCWG8JX47BWcfnSfNFh31qeoYYpUSXgXA>
    <xme:JXR_aPQ6IluKYWMtgWksi2jkk2rEVLM3m-wJuvZwez7W0sYA3hRRDcoj7tuwBOoVz
    n9VGnQ7pWvN5SsVuw>
X-ME-Received: <xmr:JXR_aOuaVKeM5wKJHnkDR4867QCBFu_4RKpSoUZQwYYREzkiQqo8n0eY3ZDvTBqV385EyCF0ozBMLzdbG2Ha5rRDfqDwoPK7NbQWQXR9rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JXR_aMaVn8aDy-WdX6--MCKDCdwIopKzCrRU8kt0RayifeBlpWV4dg>
    <xmx:JXR_aLuUolY1nXeb5-MdfCLdm2aLIQWVwlXgXDwgacGC3KbX6hF6nw>
    <xmx:JXR_aGEI0hazpxyH-B_nouElnjuf4PW5fNZNPhcd02w1GujJ2LCDWw>
    <xmx:JXR_aOyuMvT2xEFBclfbsOaI5KKNpZKUU7Ss6uudnEkEXd-wd5gyaA>
    <xmx:JXR_aPH3iU5vdzqMp2WPlmxwk2AoMe-ZlzCMy7720dnmIoC1KCguAU7C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 07:21:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a904d647 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Jul 2025 11:21:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 22 Jul 2025 13:20:51 +0200
Subject: [PATCH 2/8] builtin/reflog: improve grouping of subcommands
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-pks-reflog-append-v1-2-183e5949de16@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
In-Reply-To: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The way subcommands of git-reflog(1) are layed out does not make any
immediate sense. Reorder them such that read-only subcommands precede
writing commands for a bit more structure.

Furthermore, move the "expire" subcommand last. This prepares for a
subsequent change where we are about to introduce a new "write" command
to append reflog entries. Like this, the writing subcommands are ordered
such that those affecting a single reflog come before those spanning
across all reflogs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-reflog.adoc |  8 ++++----
 builtin/reflog.c              | 38 +++++++++++++++++++-------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
index 707a9b39edb..6ae13e772b8 100644
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
2.50.1.465.gcb3da1c9e6.dirty

