Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6F61A5B96
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068651; cv=none; b=e8xejiXRmsNxsOamkqif8ELp0Ob2mQ2H+w668zLVpWB8SbZ0V4V+XwzUm8LhYMQAhUeRAtSxGwVAAeiJa7Pnvn+O2xmSAQj/xEbJYuPnJX/9X/+8j+wzemoJuPq/lqMIyl2QM7/K0dv/ehyfScHzcyH8pMmKbEFDmUJRGg5uwuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068651; c=relaxed/simple;
	bh=zdDhKcsBXKfNsEzyVdtuHOqhZJViNLrWkhA0v8FQ3yc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qhhwnkx65okJeRlKFVprfzhdOWS9DqWp8q31nMPEIcriEl1ApoCyMB1PP2SknfMHbZpzJtnc3e3sJ7ZzPLZj5nd4wI5VbqKRMjPOVhuddVNKkyFswiDx2MvaOMWX+RzI8pk+FYI/CykANYgoSVSYUzqSLVKb89pZujFPtnlwGrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TkjQOFlz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SPSwtkEt; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TkjQOFlz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SPSwtkEt"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id B811D13826A5;
	Thu, 27 Mar 2025 05:44:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 27 Mar 2025 05:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743068648;
	 x=1743155048; bh=9mbcyVkhrf7O/KFi2pA2hJU9oVCqjeBF0ndzISmRtFM=; b=
	TkjQOFlzqWb7cd0ByqUDf4FPea9KOv3HbPVr2u7ggw/hybGRnM+SphKhwSoAtQ5N
	hJlWJsJ2OUtAoJ3XyfN4NkjKWSOnSP80tn3OYEpTEG2GMJPgwzhg5iSZYbo1WWuF
	5eqTC9PPY7ZWR0vzPqS+kyA9gbM4tSVFjy0bq5EoC3tOD8Q5ap3lN2WcD3lBTo8o
	lS0B7kvxBngA4Lg00mzUjHMWCg6HXb3pRJuoaIFdwh5Gb/k0zLK7+ykOlPuRLKE1
	H6HCqvPMl/3i7NhmxvSpTj/ZP3wrkDurDe8JpaMlSTXMaozCRs7LUvyjYbHdoiaf
	POrugFYXMDoIFZQztBFtkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743068648; x=
	1743155048; bh=9mbcyVkhrf7O/KFi2pA2hJU9oVCqjeBF0ndzISmRtFM=; b=S
	PSwtkEttLbGhLO2uZGl5oXloAPVTo5+PTZ6AMGZV+HO/f1OQHNhNHRPqBh5agBLd
	NPUvTyQXbFKBvIenlkbLcOqLvnwrRy4vnuJPi2sZjd2MaMyGIERaQJWqvWBBfgin
	OeLtEKhjnHYTM1t8naXGIZbnVidIwzuAVAwvcq6wCX8bZNwl02liQwOdGZBiePbS
	Fiy5+jCQmq5P8eSO9WFfU/R3aQbDmLsWpfc8utQH+itooSt7iNfliA8kRbVYb3Bo
	otsBguhESIjQZ5TZI4vMnNA6NS53wBKGhcEbjrbnZ0doPED02/H9IRc8kBqZzU//
	cL1+MSn5jmNp8db64Zt7A==
X-ME-Sender: <xms:6B3lZ1Vq_uKFvOV02uSQHo-VoIgAdktK-mvDCgJERqKjiee4hcsl_Q>
    <xme:6B3lZ1nALT7AxohYCGB9MFoI5SueWqSTu46l1sSZtoVyL6QToUyaYKa9fd23Xec8U
    xa-_xu3WOTaCIrJVA>
X-ME-Received: <xmr:6B3lZxY0twuCJ2CZ133R1rzlya88DyQluW_1mSO7R2BLT0iHWHDlvkJRICSALMruJkUeYIGL3YDpZkcdnam5sYF-Sm0R8s6qgxvT4zuRcqOqpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6B3lZ4Vd-PKWTzPFEPSZPEZUKeH0LINGWRhW2o5irUFzpY8uCUwMtg>
    <xmx:6B3lZ_kTpWDSpHNDJiILGXMpu51OfZIr_0GVlWMOUvTPHZMPuMWrDg>
    <xmx:6B3lZ1fTrU4HCmkokolX_g9uv6GgcSuv7IpO74j9GL2HYTdlY1v-6A>
    <xmx:6B3lZ5G3tGR44kCScTsd0JzEizyaCVxRKI7kSg8LU7QcG_Z1MZw6sw>
    <xmx:6B3lZ6tnNdQpKpg0EbcEhTvypnrT3fGXVx5PbfBjIN3AUFuGwtE1pRiV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 05:44:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 91829db1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 09:44:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 10:43:56 +0100
Subject: [PATCH v2 01/10] builtin/cat-file: rename variable that tracks
 usage
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-pks-cat-file-object-type-filter-v2-1-4bbc7085d7c5@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
In-Reply-To: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
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
2.49.0.472.ge94155a9ec.dirty

