Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90D81FBE8A
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 07:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740124060; cv=none; b=etrJ8+E4G6g3SWxmbITnug5y8nExU04tNRSoz/xv7S8HoV+OdjSx2X+7Jq5KWh35QBsApq/adQzWjNu9cddoYfR40yA7IWaGKnMsXEyjvpCB/+7q3khUZ6ySaWMK63FhqC/GT9C46jAmubVukQrIrYAd4F9ooVDjvVS6oOyqgI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740124060; c=relaxed/simple;
	bh=rwHp0Cxp3Pm+qz6KIADVlO8lPpSHQ5KQDukGWME/vlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EUx8UhXzDJ83fvz9srzKblWWrhaDdNHtVTKbfjO/p3vXrHbEuT/RVUM+8d3buoGmp/UbgleNgAJD0ohBrzhHnDZkPvTHAk/vWSen3bPOfZA59qz8lQxlXILwFTa5DD9gG7JQqXOb7YPnlXxro0LOX3yGgeGmRZIhZI1d9QzuRIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eAwzN0ql; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AtrSGX4x; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eAwzN0ql";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AtrSGX4x"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id BDD1A114018D
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 02:47:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 21 Feb 2025 02:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740124056;
	 x=1740210456; bh=zuBoiMnpKA5w2FY+EsstOTs3UqsVb7fAADghl0l4bVk=; b=
	eAwzN0ql3lVCWUFaGibSbG8Qdrum2tGYT4kV5M913XDr0i6fqpB15ZUv+blyI8Yb
	onVMIXYVO35d+vZSgYQEVLyGubd058mu/e2BthN9zn51O4JlFN3HyWfJZSfGWTaD
	DUIkaeOZFZF+c9ZElP18XUZHXu2IwPBsnwLG3dPisMw9WmTGXWkD/btG47jd2Vm0
	1hV3cCPNuvuh/Gv5gvvsosmIp7biZfjvAdreW62CCIcbTUUafxVXW3LRNDxudeSN
	zPPso3iTY9LXTponn5BvTsLZqetMtgqTja3mcdMUsuZI9fXCjKA8CM8EnoJFOlft
	P7b4bXT3DA3yVkxC6Ap3QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740124056; x=
	1740210456; bh=zuBoiMnpKA5w2FY+EsstOTs3UqsVb7fAADghl0l4bVk=; b=A
	trSGX4xwUvR4MRzOQFRRyMhqdz57P0EKLAzvQUZNvgYAfX/MbJtQZWyrcxL8sJOq
	zl4AlCWUYnVcsFaOJdL88I+qZa0Cos9vNNk8VoOB7E1rvkpXTfd30WWYs/BxzIq2
	GgOji5NNciOtYZD3nV5GWR2jwlDTkOZ9OYWokyPbzCgrhdo7w2zBnwumpYRdZH5z
	CFPtCYUtRSMX3jAeDZc5vi5l1Gvkh2hFaawgzqigcUrOxSarW7lIqe28NmC+ZNEE
	HB2SY9dS3OZx2TboM33zrgm7pVyySjjgwrPAjFjBdyDeoKAnmTR1Ke15nMfK13ZZ
	fsi7W4LaVmmu211Qw/TiA==
X-ME-Sender: <xms:mC-4Z0pzHxAFwV570ky-J0o_AX6ccFIzI3a4-jOE6xRFhjeHW4h-Jw>
    <xme:mC-4Z6quJtvVbMh34LWZLJpnK_ShDtLA6BA7NRT-MWhMDBusfhT0SynxDZm_NwnWf
    6Z_VLRsgyUtcS002g>
X-ME-Received: <xmr:mC-4Z5NyfXh9gkWzJemetx5uUDLh-dp82PJ7tj9TOtyyWckyvDOUtuHms5FV8ohguENSwmmmGftuMT3Jd7Zop2cUjBAiaQUH6g8oi4_TEfBEiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mC-4Z75GwWCHmrZj21lNRwHkRMVil8YQcrkxKxchB4htyHTXISjpZQ>
    <xmx:mC-4Zz6XRQ8fd43Rskuc9gCuJlLp8wHdQC5mzC0x72-yfCi7d_zBPw>
    <xmx:mC-4Z7i1kbi3bbnSvGZap6H53hm_QNSZn0N4gFAxukokFNy0hSntnw>
    <xmx:mC-4Z95Aiwe0pT-6UL0hGNPDdxQyCAT3joyXRpeU5sh-OAKr0PxjNg>
    <xmx:mC-4Z9Qrp9oBPhAzJc-WAotoeFPKiqh_Q5retG4zsK0aFOV3Wrs1SUyT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 21 Feb 2025 02:47:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0818e057 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 21 Feb 2025 07:47:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Feb 2025 08:47:26 +0100
Subject: [PATCH 1/9] builtin/cat-file: rename variable that tracks usage
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-pks-cat-file-object-type-filter-v1-1-0852530888e2@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
In-Reply-To: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The usage strings for git-cat-file(1) that we pass to `parse_options()`
and `usage_msg_optf()` are stored in a variable called `usage`. This
variable shadows the declaration of `usage()`, which we'll want to use
in a subsequent commit.

Rename the variable to `builtin_catfile_usage`, which is in line with
how the variable is typically called in other builtins.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b13561cf73b..8e40016dd24 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -941,7 +941,7 @@ int cmd_cat_file(int argc,
 	int input_nul_terminated = 0;
 	int nul_terminated = 0;
 
-	const char * const usage[] = {
+	const char * const builtin_catfile_usage[] = {
 		N_("git cat-file <type> <object>"),
 		N_("git cat-file (-e | -p) <object>"),
 		N_("git cat-file (-t | -s) [--allow-unknown-type] <object>"),
@@ -1007,7 +1007,7 @@ int cmd_cat_file(int argc,
 
 	batch.buffer_output = -1;
 
-	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	argc = parse_options(argc, argv, prefix, options, builtin_catfile_usage, 0);
 	opt_cw = (opt == 'c' || opt == 'w');
 	opt_epts = (opt == 'e' || opt == 'p' || opt == 't' || opt == 's');
 
@@ -1021,7 +1021,7 @@ int cmd_cat_file(int argc,
 	/* Option compatibility */
 	if (force_path && !opt_cw)
 		usage_msg_optf(_("'%s=<%s>' needs '%s' or '%s'"),
-			       usage, options,
+			       builtin_catfile_usage, options,
 			       "--path", _("path|tree-ish"), "--filters",
 			       "--textconv");
 
@@ -1029,19 +1029,19 @@ int cmd_cat_file(int argc,
 	if (batch.enabled)
 		;
 	else if (batch.follow_symlinks)
-		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
+		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage, options,
 			       "--follow-symlinks");
 	else if (batch.buffer_output >= 0)
-		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
+		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage, options,
 			       "--buffer");
 	else if (batch.all_objects)
-		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
+		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage, options,
 			       "--batch-all-objects");
 	else if (input_nul_terminated)
-		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
+		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage, options,
 			       "-z");
 	else if (nul_terminated)
-		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
+		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage, options,
 			       "-Z");
 
 	batch.input_delim = batch.output_delim = '\n';
@@ -1063,9 +1063,9 @@ int cmd_cat_file(int argc,
 			batch.transform_mode = opt;
 		else if (opt && opt != 'b')
 			usage_msg_optf(_("'-%c' is incompatible with batch mode"),
-				       usage, options, opt);
+				       builtin_catfile_usage, options, opt);
 		else if (argc)
-			usage_msg_opt(_("batch modes take no arguments"), usage,
+			usage_msg_opt(_("batch modes take no arguments"), builtin_catfile_usage,
 				      options);
 
 		return batch_objects(&batch);
@@ -1074,22 +1074,22 @@ int cmd_cat_file(int argc,
 	if (opt) {
 		if (!argc && opt == 'c')
 			usage_msg_optf(_("<rev> required with '%s'"),
-				       usage, options, "--textconv");
+				       builtin_catfile_usage, options, "--textconv");
 		else if (!argc && opt == 'w')
 			usage_msg_optf(_("<rev> required with '%s'"),
-				       usage, options, "--filters");
+				       builtin_catfile_usage, options, "--filters");
 		else if (!argc && opt_epts)
 			usage_msg_optf(_("<object> required with '-%c'"),
-				       usage, options, opt);
+				       builtin_catfile_usage, options, opt);
 		else if (argc == 1)
 			obj_name = argv[0];
 		else
-			usage_msg_opt(_("too many arguments"), usage, options);
+			usage_msg_opt(_("too many arguments"), builtin_catfile_usage, options);
 	} else if (!argc) {
-		usage_with_options(usage, options);
+		usage_with_options(builtin_catfile_usage, options);
 	} else if (argc != 2) {
 		usage_msg_optf(_("only two arguments allowed in <type> <object> mode, not %d"),
-			      usage, options, argc);
+			      builtin_catfile_usage, options, argc);
 	} else if (argc) {
 		exp_type = argv[0];
 		obj_name = argv[1];

-- 
2.48.1.683.gf705b3209c.dirty

