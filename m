Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84198229B1E
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797752; cv=none; b=pD/wYUvS3YOg2MNHSeThGOHoIX/q+pUVmJu2ailKXHqYZuL0VyARw8pEqFrm7sosZKr2pTLvgYeUHRXPnTQ6m63lExINMQp0d0CTFpptJhd691MovNZAxE8grFbpPMBZlojyFn9RnsN7rgLMAbjJ5LHc+felbprm92OeqOlpxvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797752; c=relaxed/simple;
	bh=g28ml5GS+1JG0lkQQ40hkk9QkX5CAfm7BWn+bWfsKyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vF5tNITX6V9jImllUwZyyjmPjPFsXtNhE8MJFULpmG2dStRGpwDCPIuLeOi18zQ+6OOR4HrVAd9aNYGw4BzkE2rJ86hyiGshWtEE1n99H9RotaQqmqHpPFXjPMfz202RJwITwGniebdHG7geFlQSc5u8vmBte204KmtaaL66yH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GdV8ZvKa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kQYKejub; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GdV8ZvKa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kQYKejub"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 85875138017C;
	Wed, 16 Apr 2025 06:02:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 16 Apr 2025 06:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744797748;
	 x=1744884148; bh=44jiKLSD83Xu+/YPtcE1QjeP/cSIoSODcbtVDMG9VCk=; b=
	GdV8ZvKacyK7FD4jByi7vkSVkfl6sQaAx8Jpe8NcNYXfrV9XVHhS34kXKu6e2xb3
	m6EcvjJeOrhbMD1xireFtuFDoyd2nunoLOLx9YBwBhUwNlCxsbwbZUCzbbankH4f
	UXrWfEHeJg8mmvb4sLyKvuvrfiAIFWJkl5id1i8jfMHMskVmQqJEA5m5dZuGLfKM
	uFlBJAsfGpFg4FFh673p2GbNMtnkSB3fdq/CF5FB7899LIXUP8mBe95RiHZmxAWU
	oYRl0VjxfKIhdNre676PQZJvUPDbXBIOVZcHqxRSdOuExfZFZWsMHGM33swATXJ2
	wixY1TMzXfZ/0eJp+srAug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744797748; x=
	1744884148; bh=44jiKLSD83Xu+/YPtcE1QjeP/cSIoSODcbtVDMG9VCk=; b=k
	QYKejubMZEyGVrbeHJHXTHcJAV7gMVKGefYvrqnmpfw5IWnFIRL/nr8XMWCHkJBq
	FoiYaf+z+5Ydwnhf0fqfpeTslqpj4enkOlixDNRKGFI20MYInaZQvM6Ile4c05w4
	uSqhNu37GlKn08fqqERk1ReH9dYZuUny+DLbSAEv8WFCJtYR9gOG0zXnyMfKqylJ
	4hCYO8KZUaycpImPNriCR1CvoDrcs9/0JaK60FKj95H4d9B59yo52iTsyL7fUumR
	T256mRiwTlmI4HLoljm4dq1hg9Bm4YXrYv2HflG0fCNr9MA7oyGmhx6uWDP9dDhG
	DAtqIq6NkawTG+v1yLLzQ==
X-ME-Sender: <xms:NID_Z7bYofYnPsZpjgMzqfvssWTh786s5V6JYaS5YbhHyHWyayo3DQ>
    <xme:NID_Z6blWk-wbokCziX72OTw93Vtr-T2nRQ_I2Aty6w6UCDDlUYksWk491vppHhQM
    dFno2M2_9PsKF5Bbw>
X-ME-Received: <xmr:NID_Z99DbxQdrbWo0GrD4BPJFp1D-1ru-7gp_f4uLyWN41CVNJNcPmSPfjfZscDgz0jpHxxgYK0VUWNKDa8NYeV_WWQoPZr6B0mRStnBBE3RJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeitdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpefgvdefjeeugfegieevveffhfekueehfeeliefh
    uddtteekheffhffhkefggeekieenucffohhmrghinhepfhhlrghgshdrhhgvlhhpnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhdrshdrrhes
    figvsgdruggvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshht
    ohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggv
X-ME-Proxy: <xmx:NID_Zxqs0eKS1nkXJ-_4MXtG2qMOhGGMhxIqJQRE_nCxqJjs1nRDjQ>
    <xmx:NID_Z2pnIWQenUqDAcG0CHSVOBIHVmPx_n9I6xCwlQqCg-4MENLH7g>
    <xmx:NID_Z3TgwGdRI08IeH6d4saGaoFsciO1bND2u74r7Ss0n-iQqWcv4Q>
    <xmx:NID_Z-paVWwTMszq67ljqAW8aX28E3VK2b9WfR5ZJ-Tg88P9AbBG0A>
    <xmx:NID_Z6OzSajEY6DqYQ_9_X4AhA-cUSWWjS610o_I-ZLu0Lm_Q3Tbn3-p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 06:02:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9d1fa254 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 10:02:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 16 Apr 2025 12:02:10 +0200
Subject: [PATCH v3 1/7] global: use designated initializers for options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-b4-pks-parse-options-integers-v3-1-d390746bea79@pks.im>
References: <20250416-b4-pks-parse-options-integers-v3-0-d390746bea79@pks.im>
In-Reply-To: <20250416-b4-pks-parse-options-integers-v3-0-d390746bea79@pks.im>
To: git@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

While we expose macros for most of our different option types understood
by the "parse-options" subsystem, not every combination of fields that
has one as that would otherwise quickly lead to an explosion of macros.
Instead, we just initialize structures manually for those variants of
fields that don't have a macro.

Callsites that open-code these structure initialization don't use
designated initializers though and instead just provide values for each
of the fields that they want to initialize. This has three significant
downsides:

  - Callsites need to specify all values up to the last field that they
    care about. This often includes fields that should simply be left at
    their default zero-initialized state, which adds distraction.

  - Any reader not deeply familiar with the layout of the structure
    has a hard time figuring out what the respective initializers mean.

  - Reordering or introducing new fields in the middle of the structure
    is impossible without adapting all callsites.

Convert all sites to instead use designated initializers, which we have
started using in our codebase quite a while ago. This allows us to skip
any default-initialized fields, gives the reader context by specifying
the field names and allows us to reorder or introduce new fields where
we want to.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 archive.c                     |  35 ++++++++---
 builtin/am.c                  |  28 ++++++---
 builtin/clone.c               |  13 ++++-
 builtin/commit-tree.c         |  12 +++-
 builtin/commit.c              |  62 +++++++++++++++-----
 builtin/config.c              |  13 ++++-
 builtin/describe.c            |  24 ++++++--
 builtin/fetch.c               |  10 +++-
 builtin/fmt-merge-msg.c       |  25 +++++---
 builtin/gc.c                  |  12 +++-
 builtin/grep.c                |  14 +++--
 builtin/init-db.c             |  13 +++--
 builtin/ls-remote.c           |  11 +++-
 builtin/merge.c               |  37 +++++++++---
 builtin/read-tree.c           |  11 +++-
 builtin/rebase.c              |  25 ++++++--
 builtin/revert.c              |  12 +++-
 builtin/show-branch.c         |  12 +++-
 builtin/tag.c                 |  23 ++++++--
 builtin/update-index.c        | 131 +++++++++++++++++++++++++++++-------------
 builtin/write-tree.c          |  12 ++--
 diff.c                        |  13 +++--
 ref-filter.h                  |  15 +++--
 t/helper/test-parse-options.c |  38 +++++++++---
 24 files changed, 443 insertions(+), 158 deletions(-)

diff --git a/archive.c b/archive.c
index 8be4e7ac8db..67bba3cd301 100644
--- a/archive.c
+++ b/archive.c
@@ -650,20 +650,37 @@ static int parse_archive_args(int argc, const char **argv,
 		OPT_STRING(0, "format", &format, N_("fmt"), N_("archive format")),
 		OPT_STRING(0, "prefix", &base, N_("prefix"),
 			N_("prepend prefix to each pathname in the archive")),
-		{ OPTION_CALLBACK, 0, "add-file", args, N_("file"),
-		  N_("add untracked file to archive"), 0, add_file_cb,
-		  (intptr_t)&base },
-		{ OPTION_CALLBACK, 0, "add-virtual-file", args,
-		  N_("path:content"), N_("add untracked file to archive"), 0,
-		  add_file_cb, (intptr_t)&base },
+		{
+			.type = OPTION_CALLBACK,
+			.long_name = "add-file",
+			.value = args,
+			.argh = N_("file"),
+			.help = N_("add untracked file to archive"),
+			.callback = add_file_cb,
+			.defval = (intptr_t) &base,
+		},
+		{
+			.type = OPTION_CALLBACK,
+			.long_name = "add-virtual-file",
+			.value = args,
+			.argh = N_("path:content"),
+			.help = N_("add untracked file to archive"),
+			.callback = add_file_cb,
+			.defval = (intptr_t) &base,
+		},
 		OPT_STRING('o', "output", &output, N_("file"),
 			N_("write the archive to this file")),
 		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
 			N_("read .gitattributes in working directory")),
 		OPT__VERBOSE(&verbose, N_("report archived files on stderr")),
-		{ OPTION_STRING, 0, "mtime", &mtime_option, N_("time"),
-		  N_("set modification time of archive entries"),
-		  PARSE_OPT_NONEG },
+		{
+			.type = OPTION_STRING,
+			.long_name = "mtime",
+			.value = &mtime_option,
+			.argh = N_("time"),
+			.help = N_("set modification time of archive entries"),
+			.flags = PARSE_OPT_NONEG,
+		},
 		OPT_NUMBER_CALLBACK(&compression_level,
 			N_("set compression level"), number_callback),
 		OPT_GROUP(""),
diff --git a/builtin/am.c b/builtin/am.c
index 3b61bd4c333..4afb519830f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2400,11 +2400,16 @@ int cmd_am(int argc,
 		OPT_CMDMODE(0, "quit", &resume_mode,
 			N_("abort the patching operation but keep HEAD where it is"),
 			RESUME_QUIT),
-		{ OPTION_CALLBACK, 0, "show-current-patch", &resume_mode,
-		  "(diff|raw)",
-		  N_("show the patch being applied"),
-		  PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
-		  parse_opt_show_current_patch, RESUME_SHOW_PATCH_RAW },
+		{
+			.type = OPTION_CALLBACK,
+			.long_name = "show-current-patch",
+			.value = &resume_mode,
+			.argh = "(diff|raw)",
+			.help = N_("show the patch being applied"),
+			.flags = PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
+			.callback = parse_opt_show_current_patch,
+			.defval = RESUME_SHOW_PATCH_RAW,
+		},
 		OPT_CMDMODE(0, "retry", &resume_mode,
 			N_("try to apply current patch again"),
 			RESUME_APPLY),
@@ -2417,9 +2422,16 @@ int cmd_am(int argc,
 		OPT_BOOL(0, "ignore-date", &state.ignore_date,
 			N_("use current timestamp for author date")),
 		OPT_RERERE_AUTOUPDATE(&state.allow_rerere_autoupdate),
-		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
-		  N_("GPG-sign commits"),
-		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		{
+			.type = OPTION_STRING,
+			.short_name = 'S',
+			.long_name = "gpg-sign",
+			.value = &state.sign_commit,
+			.argh = N_("key-id"),
+			.help = N_("GPG-sign commits"),
+			.flags = PARSE_OPT_OPTARG,
+			.defval = (intptr_t) "",
+		},
 		OPT_CALLBACK_F(0, "empty", &state.empty_type, "(stop|drop|keep)",
 		  N_("how to handle empty patches"),
 		  PARSE_OPT_NONEG, am_option_parse_empty),
diff --git a/builtin/clone.c b/builtin/clone.c
index 88276e5b7ab..9c3547f41e3 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -930,9 +930,16 @@ int cmd_clone(int argc,
 			 N_("don't use local hardlinks, always copy")),
 		OPT_BOOL('s', "shared", &option_shared,
 			 N_("setup as shared repository")),
-		{ OPTION_CALLBACK, 0, "recurse-submodules", &option_recurse_submodules,
-		  N_("pathspec"), N_("initialize submodules in the clone"),
-		  PARSE_OPT_OPTARG, recurse_submodules_cb, (intptr_t)"." },
+		{
+			.type = OPTION_CALLBACK,
+			.long_name = "recurse-submodules",
+			.value = &option_recurse_submodules,
+			.argh = N_("pathspec"),
+			.help = N_("initialize submodules in the clone"),
+			.flags = PARSE_OPT_OPTARG,
+			.callback = recurse_submodules_cb,
+			.defval = (intptr_t)".",
+		},
 		OPT_ALIAS(0, "recursive", "recurse-submodules"),
 		OPT_INTEGER('j', "jobs", &max_jobs,
 			    N_("number of submodules cloned in parallel")),
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 38457600a4e..c787133d004 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -111,8 +111,16 @@ int cmd_commit_tree(int argc,
 		OPT_CALLBACK_F('F', NULL, &buffer, N_("file"),
 			N_("read commit log message from file"), PARSE_OPT_NONEG,
 			parse_file_arg_callback),
-		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
-			N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		{
+			.type = OPTION_STRING,
+			.short_name = 'S',
+			.long_name = "gpg-sign",
+			.value = &sign_commit,
+			.argh = N_("key-id"),
+			.help = N_("GPG sign commit"),
+			.flags = PARSE_OPT_OPTARG,
+			.defval = (intptr_t) "",
+		},
 		OPT_END()
 	};
 	int ret;
diff --git a/builtin/commit.c b/builtin/commit.c
index 2f459682221..66bd91fd523 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1542,17 +1542,34 @@ struct repository *repo UNUSED)
 			    STATUS_FORMAT_LONG),
 		OPT_BOOL('z', "null", &s.null_termination,
 			 N_("terminate entries with NUL")),
-		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg,
-		  N_("mode"),
-		  N_("show untracked files, optional modes: all, normal, no. (Default: all)"),
-		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
-		{ OPTION_STRING, 0, "ignored", &ignored_arg,
-		  N_("mode"),
-		  N_("show ignored files, optional modes: traditional, matching, no. (Default: traditional)"),
-		  PARSE_OPT_OPTARG, NULL, (intptr_t)"traditional" },
-		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, N_("when"),
-		  N_("ignore changes to submodules, optional when: all, dirty, untracked. (Default: all)"),
-		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+		{
+			.type = OPTION_STRING,
+			.short_name = 'u',
+			.long_name = "untracked-files",
+			.value = &untracked_files_arg,
+			.argh = N_("mode"),
+			.help = N_("show untracked files, optional modes: all, normal, no. (Default: all)"),
+			.flags = PARSE_OPT_OPTARG,
+			.defval = (intptr_t)"all",
+		},
+		{
+			.type = OPTION_STRING,
+			.long_name = "ignored",
+			.value = &ignored_arg,
+			.argh = N_("mode"),
+			.help = N_("show ignored files, optional modes: traditional, matching, no. (Default: traditional)"),
+			.flags = PARSE_OPT_OPTARG,
+			.defval = (intptr_t)"traditional",
+		},
+		{
+			.type = OPTION_STRING,
+			.long_name = "ignore-submodules",
+			.value = &ignore_submodule_arg,
+			.argh = N_("when"),
+			.help = N_("ignore changes to submodules, optional when: all, dirty, untracked. (Default: all)"),
+			.flags = PARSE_OPT_OPTARG,
+			.defval = (intptr_t)"all",
+		},
 		OPT_COLUMN(0, "column", &s.colopts, N_("list untracked files in columns")),
 		OPT_BOOL(0, "no-renames", &no_renames, N_("do not detect renames")),
 		OPT_CALLBACK_F('M', "find-renames", &rename_score_arg,
@@ -1688,8 +1705,16 @@ int cmd_commit(int argc,
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
 		OPT_CLEANUP(&cleanup_arg),
 		OPT_BOOL(0, "status", &include_status, N_("include status in commit message template")),
-		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
-		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		{
+			.type = OPTION_STRING,
+			.short_name = 'S',
+			.long_name = "gpg-sign",
+			.value = &sign_commit,
+			.argh = N_("key-id"),
+			.help = N_("GPG sign commit"),
+			.flags = PARSE_OPT_OPTARG,
+			.defval = (intptr_t) "",
+		},
 		/* end commit message options */
 
 		OPT_GROUP(N_("Commit contents options")),
@@ -1714,7 +1739,16 @@ int cmd_commit(int argc,
 			 N_("terminate entries with NUL")),
 		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
 		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
-		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+		{
+			.type = OPTION_STRING,
+			.short_name = 'u',
+			.long_name = "untracked-files",
+			.value = &untracked_files_arg,
+			.argh = N_("mode"),
+			.help = N_("show untracked files, optional modes: all, normal, no. (Default: all)"),
+			.flags = PARSE_OPT_OPTARG,
+			.defval = (intptr_t)"all",
+		},
 		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
 		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 		/* end commit contents options */
diff --git a/builtin/config.c b/builtin/config.c
index 53a90094e31..f70d6354772 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -131,9 +131,16 @@ struct config_display_options {
 #define TYPE_COLOR		6
 #define TYPE_BOOL_OR_STR	7
 
-#define OPT_CALLBACK_VALUE(s, l, v, h, i) \
-	{ OPTION_CALLBACK, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG | \
-	PARSE_OPT_NONEG, option_parse_type, (i) }
+#define OPT_CALLBACK_VALUE(s, l, v, h, i) { \
+	.type = OPTION_CALLBACK, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.help = (h), \
+	.flags = PARSE_OPT_NOARG | PARSE_OPT_NONEG, \
+	.callback = option_parse_type, \
+	.defval = (i), \
+}
 
 static int option_parse_type(const struct option *opt, const char *arg,
 			     int unset)
diff --git a/builtin/describe.c b/builtin/describe.c
index e2e73f3d757..2da9f4fed01 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -601,12 +601,24 @@ int cmd_describe(int argc,
 			   N_("do not consider tags matching <pattern>")),
 		OPT_BOOL(0, "always",        &always,
 			N_("show abbreviated commit object as fallback")),
-		{OPTION_STRING, 0, "dirty",  &dirty, N_("mark"),
-			N_("append <mark> on dirty working tree (default: \"-dirty\")"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t) "-dirty"},
-		{OPTION_STRING, 0, "broken",  &broken, N_("mark"),
-			N_("append <mark> on broken working tree (default: \"-broken\")"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t) "-broken"},
+		{
+			.type = OPTION_STRING,
+			.long_name = "dirty",
+			.value = &dirty,
+			.argh = N_("mark"),
+			.help = N_("append <mark> on dirty working tree (default: \"-dirty\")"),
+			.flags = PARSE_OPT_OPTARG,
+			.defval = (intptr_t) "-dirty",
+		},
+		{
+			.type = OPTION_STRING,
+			.long_name = "broken",
+			.value = &broken,
+			.argh = N_("mark"),
+			.help = N_("append <mark> on broken working tree (default: \"-broken\")"),
+			.flags = PARSE_OPT_OPTARG,
+			.defval = (intptr_t) "-broken",
+		},
 		OPT_END(),
 	};
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 02af5054690..3a5159d9e69 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2359,8 +2359,14 @@ int cmd_fetch(int argc,
 		OPT_SET_INT_F(0, "refetch", &refetch,
 			      N_("re-fetch without negotiating common commits"),
 			      1, PARSE_OPT_NONEG),
-		{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, N_("dir"),
-			   N_("prepend this to submodule path output"), PARSE_OPT_HIDDEN },
+		{
+			.type = OPTION_STRING,
+			.long_name = "submodule-prefix",
+			.value = &submodule_prefix,
+			.argh = N_("dir"),
+			.help = N_("prepend this to submodule path output"),
+			.flags = PARSE_OPT_HIDDEN,
+		},
 		OPT_CALLBACK_F(0, "recurse-submodules-default",
 			   &recurse_submodules_default, N_("on-demand"),
 			   N_("default for recursive fetching of submodules "
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 189cd1096a0..240cdb474bc 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -20,13 +20,24 @@ int cmd_fmt_merge_msg(int argc,
 	char *into_name = NULL;
 	int shortlog_len = -1;
 	struct option options[] = {
-		{ OPTION_INTEGER, 0, "log", &shortlog_len, N_("n"),
-		  N_("populate log with at most <n> entries from shortlog"),
-		  PARSE_OPT_OPTARG, NULL, DEFAULT_MERGE_LOG_LEN },
-		{ OPTION_INTEGER, 0, "summary", &shortlog_len, N_("n"),
-		  N_("alias for --log (deprecated)"),
-		  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN, NULL,
-		  DEFAULT_MERGE_LOG_LEN },
+		{
+			.type = OPTION_INTEGER,
+			.long_name = "log",
+			.value = &shortlog_len,
+			.argh = N_("n"),
+			.help = N_("populate log with at most <n> entries from shortlog"),
+			.flags = PARSE_OPT_OPTARG,
+			.defval = DEFAULT_MERGE_LOG_LEN,
+		},
+		{
+			.type = OPTION_INTEGER,
+			.long_name = "summary",
+			.value = &shortlog_len,
+			.argh = N_("n"),
+			.help = N_("alias for --log (deprecated)"),
+			.flags = PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN,
+			.defval = DEFAULT_MERGE_LOG_LEN,
+		},
 		OPT_STRING('m', "message", &message, N_("text"),
 			N_("use <text> as start of message")),
 		OPT_STRING(0, "into-name", &into_name, N_("name"),
diff --git a/builtin/gc.c b/builtin/gc.c
index 99431fd4674..6707a26bc6e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -699,9 +699,15 @@ struct repository *repo UNUSED)
 	int ret;
 	struct option builtin_gc_options[] = {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
-		{ OPTION_STRING, 0, "prune", &prune_expire_arg, N_("date"),
-			N_("prune unreferenced objects"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire_arg },
+		{
+			.type = OPTION_STRING,
+			.long_name = "prune",
+			.value = &prune_expire_arg,
+			.argh = N_("date"),
+			.help = N_("prune unreferenced objects"),
+			.flags = PARSE_OPT_OPTARG,
+			.defval = (intptr_t)prune_expire_arg,
+		},
 		OPT_BOOL(0, "cruft", &cfg.cruft_packs, N_("pack unreferenced objects separately")),
 		OPT_MAGNITUDE(0, "max-cruft-size", &cfg.max_cruft_size,
 			      N_("with --cruft, limit the size of new cruft packs")),
diff --git a/builtin/grep.c b/builtin/grep.c
index d1427290f77..c4869733e1b 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1017,10 +1017,16 @@ int cmd_grep(int argc,
 		OPT_BOOL(0, "all-match", &opt.all_match,
 			N_("show only matches from files that match all patterns")),
 		OPT_GROUP(""),
-		{ OPTION_STRING, 'O', "open-files-in-pager", &show_in_pager,
-			N_("pager"), N_("show matching files in the pager"),
-			PARSE_OPT_OPTARG | PARSE_OPT_NOCOMPLETE,
-			NULL, (intptr_t)default_pager },
+		{
+			.type = OPTION_STRING,
+			.short_name = 'O',
+			.long_name = "open-files-in-pager",
+			.value = &show_in_pager,
+			.argh = N_("pager"),
+			.help = N_("show matching files in the pager"),
+			.flags = PARSE_OPT_OPTARG | PARSE_OPT_NOCOMPLETE,
+			.defval = (intptr_t)default_pager,
+		},
 		OPT_BOOL_F(0, "ext-grep", &external_grep_allowed__ignored,
 			   N_("allow calling of grep(1) (ignored by this build)"),
 			   PARSE_OPT_NOCOMPLETE),
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 196dccdd77a..4a950e44d8d 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -93,10 +93,15 @@ int cmd_init_db(int argc,
 				N_("directory from which templates will be used")),
 		OPT_SET_INT(0, "bare", &is_bare_repository_cfg,
 				N_("create a bare repository"), 1),
-		{ OPTION_CALLBACK, 0, "shared", &init_shared_repository,
-			N_("permissions"),
-			N_("specify that the git repository is to be shared amongst several users"),
-			PARSE_OPT_OPTARG | PARSE_OPT_NONEG, shared_callback, 0},
+		{
+			.type = OPTION_CALLBACK,
+			.long_name = "shared",
+			.value = &init_shared_repository,
+			.argh = N_("permissions"),
+			.help = N_("specify that the git repository is to be shared amongst several users"),
+			.flags = PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
+			.callback = shared_callback
+		},
 		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 42f34e12361..01a4d4daa1f 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -67,9 +67,14 @@ int cmd_ls_remote(int argc,
 		OPT__QUIET(&quiet, N_("do not print remote URL")),
 		OPT_STRING(0, "upload-pack", &uploadpack, N_("exec"),
 			   N_("path of git-upload-pack on the remote host")),
-		{ OPTION_STRING, 0, "exec", &uploadpack, N_("exec"),
-			   N_("path of git-upload-pack on the remote host"),
-			   PARSE_OPT_HIDDEN },
+		{
+			.type = OPTION_STRING,
+			.long_name = "exec",
+			.value = &uploadpack,
+			.argh = N_("exec"),
+			.help = N_("path of git-upload-pack on the remote host"),
+			.flags = PARSE_OPT_HIDDEN,
+		},
 		OPT_BIT('t', "tags", &flags, N_("limit to tags"), REF_TAGS),
 		OPT_BIT('b', "branches", &flags, N_("limit to branches"), REF_BRANCHES),
 		OPT_BIT_F('h', "heads", &flags,
diff --git a/builtin/merge.c b/builtin/merge.c
index ba9faf126aa..21787d45165 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -250,9 +250,15 @@ static struct option builtin_merge_options[] = {
 	OPT_BOOL(0, "stat", &show_diffstat,
 		N_("show a diffstat at the end of the merge")),
 	OPT_BOOL(0, "summary", &show_diffstat, N_("(synonym to --stat)")),
-	{ OPTION_INTEGER, 0, "log", &shortlog_len, N_("n"),
-	  N_("add (at most <n>) entries from shortlog to merge commit message"),
-	  PARSE_OPT_OPTARG, NULL, DEFAULT_MERGE_LOG_LEN },
+	{
+		.type = OPTION_INTEGER,
+		.long_name = "log",
+		.value = &shortlog_len,
+		.argh = N_("n"),
+		.help = N_("add (at most <n>) entries from shortlog to merge commit message"),
+		.flags = PARSE_OPT_OPTARG,
+		.defval = DEFAULT_MERGE_LOG_LEN,
+	},
 	OPT_BOOL(0, "squash", &squash,
 		N_("create a single commit instead of doing a merge")),
 	OPT_BOOL(0, "commit", &option_commit,
@@ -274,9 +280,16 @@ static struct option builtin_merge_options[] = {
 	OPT_CALLBACK('m', "message", &merge_msg, N_("message"),
 		N_("merge commit message (for a non-fast-forward merge)"),
 		option_parse_message),
-	{ OPTION_LOWLEVEL_CALLBACK, 'F', "file", &merge_msg, N_("path"),
-		N_("read message from file"), PARSE_OPT_NONEG,
-		NULL, 0, option_read_message },
+	{
+		.type = OPTION_LOWLEVEL_CALLBACK,
+		.short_name = 'F',
+		.long_name = "file",
+		.value = &merge_msg,
+		.argh = N_("path"),
+		.help = N_("read message from file"),
+		.flags = PARSE_OPT_NONEG,
+		.ll_callback = option_read_message,
+	},
 	OPT_STRING(0, "into-name", &into_name, N_("name"),
 		   N_("use <name> instead of the real target")),
 	OPT__VERBOSITY(&verbosity),
@@ -289,8 +302,16 @@ static struct option builtin_merge_options[] = {
 	OPT_BOOL(0, "allow-unrelated-histories", &allow_unrelated_histories,
 		 N_("allow merging unrelated histories")),
 	OPT_SET_INT(0, "progress", &show_progress, N_("force progress reporting"), 1),
-	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
-	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+	{
+		.type = OPTION_STRING,
+		.short_name = 'S',
+		.long_name = "gpg-sign",
+		.value = &sign_commit,
+		.argh = N_("key-id"),
+		.help = N_("GPG sign commit"),
+		.flags = PARSE_OPT_OPTARG,
+		.defval = (intptr_t) "",
+	},
 	OPT_AUTOSTASH(&autostash),
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
 	OPT_BOOL(0, "signoff", &signoff, N_("add a Signed-off-by trailer")),
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index d2a807a828b..a8f352f7cd9 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -135,9 +135,14 @@ int cmd_read_tree(int argc,
 			 N_("3-way merge in presence of adds and removes")),
 		OPT_BOOL(0, "reset", &opts.reset,
 			 N_("same as -m, but discard unmerged entries")),
-		{ OPTION_STRING, 0, "prefix", &opts.prefix, N_("<subdirectory>/"),
-		  N_("read the tree into the index under <subdirectory>/"),
-		  PARSE_OPT_NONEG },
+		{
+			.type = OPTION_STRING,
+			.long_name = "prefix",
+			.value = &opts.prefix,
+			.argh = N_("<subdirectory>/"),
+			.help = N_("read the tree into the index under <subdirectory>/"),
+			.flags = PARSE_OPT_NONEG,
+		},
 		OPT_BOOL('u', NULL, &opts.update,
 			 N_("update working tree with merge result")),
 		OPT_CALLBACK_F(0, "exclude-per-directory", &opts,
diff --git a/builtin/rebase.c b/builtin/rebase.c
index d4715ed35d7..d4083350090 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1122,9 +1122,15 @@ int cmd_rebase(int argc,
 		OPT_BIT('v', "verbose", &options.flags,
 			N_("display a diffstat of what changed upstream"),
 			REBASE_NO_QUIET | REBASE_VERBOSE | REBASE_DIFFSTAT),
-		{OPTION_NEGBIT, 'n', "no-stat", &options.flags, NULL,
-			N_("do not show diffstat of what changed upstream"),
-			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
+		{
+			.type = OPTION_NEGBIT,
+			.short_name = 'n',
+			.long_name = "no-stat",
+			.value = &options.flags,
+			.help = N_("do not show diffstat of what changed upstream"),
+			.flags = PARSE_OPT_NOARG,
+			.defval = REBASE_DIFFSTAT,
+		},
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by trailer to each commit")),
 		OPT_BOOL(0, "committer-date-is-author-date",
@@ -1190,9 +1196,16 @@ int cmd_rebase(int argc,
 		OPT_BOOL(0, "update-refs", &options.update_refs,
 			 N_("update branches that point to commits "
 			    "that are being rebased")),
-		{ OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id"),
-			N_("GPG-sign commits"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		{
+			.type = OPTION_STRING,
+			.short_name = 'S',
+			.long_name = "gpg-sign",
+			.value = &gpg_sign,
+			.argh = N_("key-id"),
+			.help = N_("GPG-sign commits"),
+			.flags = PARSE_OPT_OPTARG,
+			.defval = (intptr_t) "",
+		},
 		OPT_AUTOSTASH(&options.autostash),
 		OPT_STRING_LIST('x', "exec", &options.exec, N_("exec"),
 				N_("add exec lines after each commit of the "
diff --git a/builtin/revert.c b/builtin/revert.c
index aca6c293cdf..4f5ef975494 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -132,8 +132,16 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 		OPT_STRING(0, "strategy", &strategy, N_("strategy"), N_("merge strategy")),
 		OPT_STRVEC('X', "strategy-option", &opts->xopts, N_("option"),
 			N_("option for merge strategy")),
-		{ OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id"),
-		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		{
+			.type = OPTION_STRING,
+			.short_name = 'S',
+			.long_name = "gpg-sign",
+			.value = &gpg_sign,
+			.argh = N_("key-id"),
+			.help = N_("GPG sign commit"),
+			.flags = PARSE_OPT_OPTARG,
+			.defval = (intptr_t) "",
+		},
 		OPT_END()
 	};
 	struct option *options = base_options;
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index fce6b404e92..dab37019d29 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -667,9 +667,15 @@ int cmd_show_branch(int ac,
 			 N_("show remote-tracking branches")),
 		OPT__COLOR(&showbranch_use_color,
 			    N_("color '*!+-' corresponding to the branch")),
-		{ OPTION_INTEGER, 0, "more", &extra, N_("n"),
-			    N_("show <n> more commits after the common ancestor"),
-			    PARSE_OPT_OPTARG, NULL, (intptr_t)1 },
+		{
+			.type = OPTION_INTEGER,
+			.long_name = "more",
+			.value = &extra,
+			.argh = N_("n"),
+			.help = N_("show <n> more commits after the common ancestor"),
+			.flags = PARSE_OPT_OPTARG,
+			.defval = 1,
+		},
 		OPT_SET_INT(0, "list", &extra, N_("synonym to more=-1"), -1),
 		OPT_BOOL(0, "no-name", &no_name, N_("suppress naming strings")),
 		OPT_BOOL(0, "current", &with_current_branch,
diff --git a/builtin/tag.c b/builtin/tag.c
index d3e0943b734..b266f12bb48 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -479,9 +479,15 @@ int cmd_tag(int argc,
 	int edit_flag = 0;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
-		{ OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
-				N_("print <n> lines of each tag message"),
-				PARSE_OPT_OPTARG, NULL, 1 },
+		{
+			.type = OPTION_INTEGER,
+			.short_name = 'n',
+			.value = &filter.lines,
+			.argh = N_("n"),
+			.help = N_("print <n> lines of each tag message"),
+			.flags = PARSE_OPT_OPTARG,
+			.defval = 1,
+		},
 		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete tags"), 'd'),
 		OPT_CMDMODE('v', "verify", &cmdmode, N_("verify tags"), 'v'),
 
@@ -513,9 +519,14 @@ int cmd_tag(int argc,
 			N_("do not output a newline after empty formatted refs")),
 		OPT_REF_SORT(&sorting_options),
 		{
-			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
-			N_("print only tags of the object"), PARSE_OPT_LASTARG_DEFAULT,
-			parse_opt_object_name, (intptr_t) "HEAD"
+			.type = OPTION_CALLBACK,
+			.long_name = "points-at",
+			.value = &filter.points_at,
+			.argh = N_("object"),
+			.help = N_("print only tags of the object"),
+			.flags = PARSE_OPT_LASTARG_DEFAULT,
+			.callback = parse_opt_object_name,
+			.defval = (intptr_t) "HEAD",
 		},
 		OPT_STRING(  0 , "format", &format.format, N_("format"),
 			   N_("format to use for the output")),
diff --git a/builtin/update-index.c b/builtin/update-index.c
index b2f6b1a3fbb..ee64b022679 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -964,29 +964,51 @@ int cmd_update_index(int argc,
 			N_("like --refresh, but ignore assume-unchanged setting"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			really_refresh_callback),
-		{OPTION_LOWLEVEL_CALLBACK, 0, "cacheinfo", NULL,
-			N_("<mode>,<object>,<path>"),
-			N_("add the specified entry to the index"),
-			PARSE_OPT_NOARG | /* disallow --cacheinfo=<mode> form */
-			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
-			NULL, 0,
-			cacheinfo_callback},
+		{
+			.type = OPTION_LOWLEVEL_CALLBACK,
+			.long_name = "cacheinfo",
+			.argh = N_("<mode>,<object>,<path>"),
+			.help = N_("add the specified entry to the index"),
+			.flags = PARSE_OPT_NOARG | /* disallow --cacheinfo=<mode> form */
+				 PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
+			.ll_callback = cacheinfo_callback,
+		},
 		OPT_CALLBACK_F(0, "chmod", &set_executable_bit, "(+|-)x",
 			N_("override the executable bit of the listed files"),
 			PARSE_OPT_NONEG,
 			chmod_callback),
-		{OPTION_SET_INT, 0, "assume-unchanged", &mark_valid_only, NULL,
-			N_("mark files as \"not changing\""),
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, MARK_FLAG},
-		{OPTION_SET_INT, 0, "no-assume-unchanged", &mark_valid_only, NULL,
-			N_("clear assumed-unchanged bit"),
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, UNMARK_FLAG},
-		{OPTION_SET_INT, 0, "skip-worktree", &mark_skip_worktree_only, NULL,
-			N_("mark files as \"index-only\""),
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, MARK_FLAG},
-		{OPTION_SET_INT, 0, "no-skip-worktree", &mark_skip_worktree_only, NULL,
-			N_("clear skip-worktree bit"),
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, UNMARK_FLAG},
+		{
+			.type = OPTION_SET_INT,
+			.long_name = "assume-unchanged",
+			.value = &mark_valid_only,
+			.help = N_("mark files as \"not changing\""),
+			.flags = PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			.defval = MARK_FLAG,
+		},
+		{
+			.type = OPTION_SET_INT,
+			.long_name = "no-assume-unchanged",
+			.value = &mark_valid_only,
+			.help = N_("clear assumed-unchanged bit"),
+			.flags = PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			.defval = UNMARK_FLAG,
+		},
+		{
+			.type = OPTION_SET_INT,
+			.long_name = "skip-worktree",
+			.value = &mark_skip_worktree_only,
+			.help = N_("mark files as \"index-only\""),
+			.flags = PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			.defval = MARK_FLAG,
+		},
+		{
+			.type = OPTION_SET_INT,
+			.long_name = "no-skip-worktree",
+			.value = &mark_skip_worktree_only,
+			.help = N_("clear skip-worktree bit"),
+			.flags = PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			.defval = UNMARK_FLAG,
+		},
 		OPT_BOOL(0, "ignore-skip-worktree-entries", &ignore_skip_worktree_entries,
 			 N_("do not touch index-only entries")),
 		OPT_SET_INT(0, "info-only", &info_only,
@@ -995,22 +1017,39 @@ int cmd_update_index(int argc,
 			N_("remove named paths even if present in worktree"), 1),
 		OPT_BOOL('z', NULL, &nul_term_line,
 			 N_("with --stdin: input lines are terminated by null bytes")),
-		{OPTION_LOWLEVEL_CALLBACK, 0, "stdin", &read_from_stdin, NULL,
-			N_("read list of paths to be updated from standard input"),
-			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
-			NULL, 0, stdin_callback},
-		{OPTION_LOWLEVEL_CALLBACK, 0, "index-info", &nul_term_line, NULL,
-			N_("add entries from standard input to the index"),
-			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
-			NULL, 0, stdin_cacheinfo_callback},
-		{OPTION_LOWLEVEL_CALLBACK, 0, "unresolve", &has_errors, NULL,
-			N_("repopulate stages #2 and #3 for the listed paths"),
-			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
-			NULL, 0, unresolve_callback},
-		{OPTION_LOWLEVEL_CALLBACK, 'g', "again", &has_errors, NULL,
-			N_("only update entries that differ from HEAD"),
-			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
-			NULL, 0, reupdate_callback},
+		{
+			.type = OPTION_LOWLEVEL_CALLBACK,
+			.long_name = "stdin",
+			.value = &read_from_stdin,
+			.help = N_("read list of paths to be updated from standard input"),
+			.flags = PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			.ll_callback = stdin_callback,
+		},
+		{
+			.type = OPTION_LOWLEVEL_CALLBACK,
+			.long_name = "index-info",
+			.value = &nul_term_line,
+			.help = N_("add entries from standard input to the index"),
+			.flags = PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			.ll_callback = stdin_cacheinfo_callback,
+		},
+		{
+			.type = OPTION_LOWLEVEL_CALLBACK,
+			.long_name = "unresolve",
+			.value = &has_errors,
+			.help = N_("repopulate stages #2 and #3 for the listed paths"),
+			.flags = PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			.ll_callback = unresolve_callback,
+		},
+		{
+			.type = OPTION_LOWLEVEL_CALLBACK,
+			.short_name = 'g',
+			.long_name = "again",
+			.value = &has_errors,
+			.help = N_("only update entries that differ from HEAD"),
+			.flags = PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			.ll_callback = reupdate_callback,
+		},
 		OPT_BIT(0, "ignore-missing", &refresh_args.flags,
 			N_("ignore files missing from worktree"),
 			REFRESH_IGNORE_MISSING),
@@ -1036,12 +1075,22 @@ int cmd_update_index(int argc,
 			N_("write out the index even if is not flagged as changed"), 1),
 		OPT_BOOL(0, "fsmonitor", &fsmonitor,
 			N_("enable or disable file system monitor")),
-		{OPTION_SET_INT, 0, "fsmonitor-valid", &mark_fsmonitor_only, NULL,
-			N_("mark files as fsmonitor valid"),
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, MARK_FLAG},
-		{OPTION_SET_INT, 0, "no-fsmonitor-valid", &mark_fsmonitor_only, NULL,
-			N_("clear fsmonitor valid bit"),
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, UNMARK_FLAG},
+		{
+			.type = OPTION_SET_INT,
+			.long_name = "fsmonitor-valid",
+			.value = &mark_fsmonitor_only,
+			.help = N_("mark files as fsmonitor valid"),
+			.flags = PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			.defval = MARK_FLAG,
+		},
+		{
+			.type = OPTION_SET_INT,
+			.long_name = "no-fsmonitor-valid",
+			.value = &mark_fsmonitor_only,
+			.help = N_("clear fsmonitor valid bit"),
+			.flags = PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			.defval = UNMARK_FLAG,
+		},
 		OPT_END()
 	};
 
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 43f233e69b0..5a8dc377ec0 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -31,10 +31,14 @@ int cmd_write_tree(int argc,
 			WRITE_TREE_MISSING_OK),
 		OPT_STRING(0, "prefix", &tree_prefix, N_("<prefix>/"),
 			   N_("write tree object for a subdirectory <prefix>")),
-		{ OPTION_BIT, 0, "ignore-cache-tree", &flags, NULL,
-		  N_("only useful for debugging"),
-		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, NULL,
-		  WRITE_TREE_IGNORE_CACHE_TREE },
+		{
+			.type = OPTION_BIT,
+			.long_name = "ignore-cache-tree",
+			.value = &flags,
+			.help = N_("only useful for debugging"),
+			.flags = PARSE_OPT_HIDDEN | PARSE_OPT_NOARG,
+			.defval = WRITE_TREE_IGNORE_CACHE_TREE,
+		},
 		OPT_END()
 	};
 
diff --git a/diff.c b/diff.c
index 08f5e00a2cc..f2fcc7f3c22 100644
--- a/diff.c
+++ b/diff.c
@@ -5892,10 +5892,15 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_CALLBACK_F(0, "diff-filter", options, N_("[(A|C|D|M|R|T|U|X|B)...[*]]"),
 			       N_("select files by diff type"),
 			       PARSE_OPT_NONEG, diff_opt_diff_filter),
-		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
-		  N_("output to a specific file"),
-		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
-
+		{
+			.type = OPTION_CALLBACK,
+			.long_name = "output",
+			.value = options,
+			.argh = N_("<file>"),
+			.help = N_("output to a specific file"),
+			.flags = PARSE_OPT_NONEG,
+			.ll_callback = diff_opt_output,
+		},
 		OPT_END()
 	};
 
diff --git a/ref-filter.h b/ref-filter.h
index 013d4cfa64b..c98c4fbd4c1 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -114,11 +114,16 @@ struct ref_format {
 }
 
 /*  Macros for checking --merged and --no-merged options */
-#define _OPT_MERGED_NO_MERGED(option, filter, h) \
-	{ OPTION_CALLBACK, 0, option, (filter), N_("commit"), (h), \
-	  PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG, \
-	  parse_opt_merge_filter, (intptr_t) "HEAD" \
-	}
+#define _OPT_MERGED_NO_MERGED(option, filter, h) { \
+	.type = OPTION_CALLBACK, \
+	.long_name = option, \
+	.value = (filter), \
+	.argh = N_("commit"), \
+	.help = (h), \
+	.flags = PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG, \
+	.callback = parse_opt_merge_filter, \
+	.defval = (intptr_t) "HEAD", \
+}
 #define OPT_MERGED(f, h) _OPT_MERGED_NO_MERGED("merged", f, h)
 #define OPT_NO_MERGED(f, h) _OPT_MERGED_NO_MERGED("no-merged", f, h)
 
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index bfe45ec68b0..997f55fd45b 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -124,8 +124,15 @@ int cmd__parse_options(int argc, const char **argv)
 	struct option options[] = {
 		OPT_BOOL(0, "yes", &boolean, "get a boolean"),
 		OPT_BOOL('D', "no-doubt", &boolean, "begins with 'no-'"),
-		{ OPTION_SET_INT, 'B', "no-fear", &boolean, NULL,
-		  "be brave", PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
+		{
+			.type = OPTION_SET_INT,
+			.short_name = 'B',
+			.long_name = "no-fear",
+			.value = &boolean,
+			.help = "be brave",
+			.flags = PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			.defval = 1,
+		},
 		OPT_COUNTUP('b', "boolean", &boolean, "increment by one"),
 		OPT_BIT('4', "or4", &boolean,
 			"bitwise-or boolean with ...0100", 4),
@@ -155,12 +162,27 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_GROUP("Magic arguments"),
 		OPT_NUMBER_CALLBACK(&integer, "set integer to NUM",
 			number_callback),
-		{ OPTION_COUNTUP, '+', NULL, &boolean, NULL, "same as -b",
-		  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH },
-		{ OPTION_COUNTUP, 0, "ambiguous", &ambiguous, NULL,
-		  "positive ambiguity", PARSE_OPT_NOARG | PARSE_OPT_NONEG },
-		{ OPTION_COUNTUP, 0, "no-ambiguous", &ambiguous, NULL,
-		  "negative ambiguity", PARSE_OPT_NOARG | PARSE_OPT_NONEG },
+		{
+			.type = OPTION_COUNTUP,
+			.short_name = '+',
+			.value = &boolean,
+			.help = "same as -b",
+			.flags = PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH,
+		},
+		{
+			.type = OPTION_COUNTUP,
+			.long_name = "ambiguous",
+			.value = &ambiguous,
+			.help = "positive ambiguity",
+			.flags = PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+		},
+		{
+			.type = OPTION_COUNTUP,
+			.long_name = "no-ambiguous",
+			.value = &ambiguous,
+			.help = "negative ambiguity",
+			.flags = PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+		},
 		OPT_GROUP("Standard options"),
 		OPT__ABBREV(&abbrev),
 		OPT__VERBOSE(&verbose, "be verbose"),

-- 
2.49.0.805.g082f7c87e0.dirty

