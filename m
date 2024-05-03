Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B9B146A71
	for <git@vger.kernel.org>; Fri,  3 May 2024 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720645; cv=none; b=b2Scp+9CzVtTxb7uopfj4DW+RgSjWpqA7OE1ENjmx/X/Y+CDolusr/P9MFBON1iEyDDqJAAMg/2NTwLWppLHZamEpuaQbWBJKTeCntr8eJ8uIGas2MkLaUe71ZQzlRLzdtysf8OP4LspAQ/U7lffgGQqHTaxLFEDubeEBGLfQu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720645; c=relaxed/simple;
	bh=y2HHKlW41zd5Hy3zJfgQ5oeTJUJ40WfxSr5v0vcEsjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gp+y2Yz0ecjPFjS8i68Vbls2tDJUCn2sS5Ew/ftQugphMIWnTzAC8xblIRIHZaFBJtiLXBpDlN4BgePS/VQFPtLAMYPuu2uWmjMSVV1QWXnqolv/25cSGkx7apK1E08bASKy2T1FnVLuUTSr4Bef147jAKxeL/S2FC2mVp2ihl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=CxoFGsPe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DaBaiG8S; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="CxoFGsPe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DaBaiG8S"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 792F71C00138;
	Fri,  3 May 2024 03:17:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 03 May 2024 03:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714720642; x=
	1714807042; bh=SHa5u2GLUjmNQVCpSrO7f0MYHrjmi2GKHlTAusN9ufM=; b=C
	xoFGsPefoCqyG5CwYkTrc53bSIKns8suLD1eHyrDRFUQ0VC0yeKGp8YpqFVK/u2y
	WEBnqOmOZw6iquBgJMKhmgJAW8/fxifV1QVpbaZdEBJVLXdMV568tMqB2hVB/TSR
	nt1gvyfWvt8pJXbEvsSwWRDC9ny7osZlpEsi+csv/gVz9S7w4MUeTtSFhW8Lw336
	z7FH7u2V9Kg6RKNnthSq2hv7530sn5EgwRBraRphaOIV/RqiKHvI1YMUz4E4A6l4
	ZBbMA3MlJXVKHJDirsvjBcEgLLThaEiIBzR5l8C3EU2oCELz1BwxAAjz1uYq+siH
	Syiu6Y4CnQhUV7CyREwGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714720642; x=
	1714807042; bh=SHa5u2GLUjmNQVCpSrO7f0MYHrjmi2GKHlTAusN9ufM=; b=D
	aBaiG8SI5FwmM5fg/WtRLBEBncRd2nold92yD6V6voTHiu2Q+pAwmKcog9D5EB6N
	qeFbKyPgtt7tyqyKOwqR51a75d3J77z3iIuWUqFq2uV/dh3odkdcFnjqNJG/4DRP
	5VWeYoLCAP+ZNcUN6c8vE2yBGrVr8WdxbbK5oxsOIqZKpE7GnftBjK/XySbbXgDk
	6RrcTvuMwzixxV7Cu0/QFo+MUPt2yXB8kUSZArPXPr1r/dTi2JjcBHKpc11U9T8q
	LdIVdj3wIVT9g5k8A2CJ1L6Jz2w3xucAgKofteIdJX0BwQPpExAXZKA1t1ELSS8v
	20jHtCkY3OZAl5ZLs1tPQ==
X-ME-Sender: <xms:gY80ZuwS47jXtcsoQpm4EywICRZfAyvyTZWPVn0u0HQe4FOfYPu_mg>
    <xme:gY80ZqQyNR04BTrHHt17Q8bn1WW4CAkfOkleNaHGUFuV1-aCUaEtwis0HCgLObqhK
    dNOOspiXq8YdDYD6A>
X-ME-Received: <xmr:gY80ZgVAthnns40v9JXSUAcqiXLDp7Pp3P2vxsvQsKKTfw0nFdlihSMKNii6b13ip3cErGyoe8gtZ1zoMmIBbQNz1EKlJIXJonbPbIqnwJLavedCp_aJy-aO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomheplfgrmhgvshcunfhiuhcuoehjrghmvghssehjrghmvghs
    lhhiuhdrihhoqeenucggtffrrghtthgvrhhnpeeljedtuedugfetgeefieduheelueetvd
    fhueeuueehveeljeekleetteefvefhjeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:gY80ZkgsnU9386TrXV3wsxhk1PnTVH2RpRVRt7hruCV8kKo31wBn2Q>
    <xmx:gY80ZgBPWJroeg4_C2Iq1OrqQBEyIPQ5VhA3bHmqEgm5TQFQPfzwug>
    <xmx:gY80ZlI_emNiJ7i3XYdfMh98p2csk5uocdwRjj61V1sSH1mOSliV3Q>
    <xmx:gY80ZnAzJh6i8OMi1DqmKVC1F8t1zhZqp55xf_wG-w2y6IYy7syeIw>
    <xmx:go80ZjM8PuYlHUXEBhnmhou16hUeQqyFiXUaEEy7cON3pAlWLAFQw8y6>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 03:17:20 -0400 (EDT)
From: James Liu <james@jamesliu.io>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>
Subject: [PATCH v4 1/3] doc: clean up usage documentation for --no-* opts
Date: Fri,  3 May 2024 17:17:04 +1000
Message-ID: <20240503071706.78109-2-james@jamesliu.io>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503071706.78109-1-james@jamesliu.io>
References: <20240430014724.83813-1-james@jamesliu.io>
 <20240503071706.78109-1-james@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll be adding another option to the --no-* class of options soon.

Clean up the existing options by grouping them together in the OPTIONS
section, and adding missing ones to the SYNOPSIS.

Signed-off-by: James Liu <james@jamesliu.io>
---
 Documentation/git.txt | 14 +++++++-------
 git.c                 |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7a1b112a3e..7fa75350b2 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -11,9 +11,9 @@ SYNOPSIS
 [verse]
 'git' [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]
     [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
-    [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
-    [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
-    [--config-env=<name>=<envvar>] <command> [<args>]
+    [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--no-lazy-fetch]
+    [--no-optional-locks] [--bare] [--git-dir=<path>] [--work-tree=<path>]
+    [--namespace=<name>] [--config-env=<name>=<envvar>] <command> [<args>]
 
 DESCRIPTION
 -----------
@@ -186,6 +186,10 @@ If you just want to run git as if it was started in `<path>` then use
 	This is equivalent to setting the `GIT_NO_LAZY_FETCH`
 	environment variable to `1`.
 
+--no-optional-locks::
+	Do not perform optional operations that require locks. This is
+	equivalent to setting the `GIT_OPTIONAL_LOCKS` to `0`.
+
 --literal-pathspecs::
 	Treat pathspecs literally (i.e. no globbing, no pathspec magic).
 	This is equivalent to setting the `GIT_LITERAL_PATHSPECS` environment
@@ -207,10 +211,6 @@ If you just want to run git as if it was started in `<path>` then use
 	Add "icase" magic to all pathspec. This is equivalent to setting
 	the `GIT_ICASE_PATHSPECS` environment variable to `1`.
 
---no-optional-locks::
-	Do not perform optional operations that require locks. This is
-	equivalent to setting the `GIT_OPTIONAL_LOCKS` to `0`.
-
 --list-cmds=<group>[,<group>...]::
 	List commands by group. This is an internal/experimental
 	option and may change or be removed in the future. Supported
diff --git a/git.c b/git.c
index 654d615a18..7654571b75 100644
--- a/git.c
+++ b/git.c
@@ -36,9 +36,9 @@ struct cmd_struct {
 const char git_usage_string[] =
 	N_("git [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]\n"
 	   "           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
-	   "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]\n"
-	   "           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
-	   "           [--config-env=<name>=<envvar>] <command> [<args>]");
+	   "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--no-lazy-fetch]\n"
+	   "           [--no-optional-locks] [--bare] [--git-dir=<path>] [--work-tree=<path>]\n"
+	   "           [--namespace=<name>] [--config-env=<name>=<envvar>] <command> [<args>]");
 
 const char git_more_info_string[] =
 	N_("'git help -a' and 'git help -g' list available subcommands and some\n"
-- 
2.44.0

