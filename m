Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3416F20E030
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 02:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787969222; cv=none; b=Ujb7xrN8QHeN2MpnlHzjOUW1tZZjXaCClZKJXpqquCcmFBmjBpcLyP4qqYORN4LBn85Mw855vGQyzp3WoyMcf2C5mxf+sarQr4t/CU8QlCMECLLxjtD5gTdfTzLFQ/k6Cv65VSNiZpPOMaMYQssjnmGv5Z9rcviRn+EP43PXCXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787969222; c=relaxed/simple;
	bh=1cOl2i/Dyc407Y8l4spOPcoeALdpId3WXSkigULPjEg=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cESufKgN/9/emKHJIfspNKWc26n2HMIkreWkISJ26Sikup6wdae/FtZcIh6kwE6zDR9lT9O/Ih+ENx5Y9A4krvW2AlSpfUsGxar0r/mnwtUkkrcL0H1dO04PoAedmdBbb4kJA9W0frH3KwzYZSkyY6sef8llXgjnHqgv9jt8Jjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bt2WLeBq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HkmnWTgr; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bt2WLeBq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HkmnWTgr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6A51F140016C;
	Fri, 28 Aug 2026 22:07:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 28 Aug 2026 22:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787969220; x=1788055620; bh=sBFsmvtu3f
	VnX4SGmETQA1d0kcJO25Bl67EGCO/qBHY=; b=bt2WLeBqRbGVGsEQllc1pPTfWo
	wxTgIHYWy7yPsiGCpCAnhcZ8BuT5THlfadB3paJ6ud0mgKJ2hbm8VKh20PL9Yrub
	NanCZ8BzWHRSKMdFxxjZAsZux8pgebnJqTfmwxeF4UeO6uG2s1Ue1ePD7bZLDZi7
	2AULoIXUkM4l/ATydDnAR1eaCBmDz4KUd0Y38yVUwujI7GD2G6TfDmVJFy2DiL++
	GICH7olBR9zocjcYtrtcvm93cRF+a4Mq2WY6jddSYGyZnNW8EFAQOUpbizvWnmeP
	h2LTH4hQUIAUCBrIpiwLrHjnMiKqOv/dND5WXWGqMT8N7HvHD9n5RxFMmUhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787969220; x=1788055620; bh=sBFsmvtu3fVnX4SGmETQA1d0kcJO25Bl67E
	GCO/qBHY=; b=HkmnWTgrIeho+wd+vZHbTiIdpBgume8pwM9073ZtK+cc4dVt4x0
	A8Fna/Hnmx4rPudTQRGcj4VoBJcUee5ckFLvkH0vYm9b8RR6j5+maTqQjupRh/In
	r9bxrP3Vy5fzVDKo411vX9lt1qvx/OmxD4mbKIkx687a6+IW5g+FWULj/yGLk5kw
	b3VrTZPOGHNcb+6HJkf5VeH3VvzKD+AO2fJSIwsZmSbo0VOX9zR+9OFK11YT8zKb
	CPwxnJsn3Zc54DwRaSmPpD1CVYhUuRkUPJdgayI/lZfNjMP3CqYPg3iKUXiWkW3r
	c6mTqABqbysFPL20+RnmpnyfzsDGNPMcUIg==
X-ME-Sender: <xms:xD6SakkX_kwWV9zx15Gu9whICmJnLdMXaiXzyGmie6PrANg5Z0NZTg>
    <xme:xD6Sap0f-65PgyMBuFcHIHW83TTUNaFYoatqQkUKxbMILmAaNCigYqgVNfC85gMb-
    yrlb9XeVVwpAfGQ0sQhqlA9Rkc7fOm3LH1v2MKZ5bq-nKqlFqB5QLs>
X-ME-Received: <xmr:xD6SagR6WJ5gcx8GP2rtWMAJkLXNALSwcRQqr5aCakkO6-OqQeJJDqle7H_AAhUKz1-c-GucH1zOSa4kH2D9N-O_xHG1GlU-aA>
X-ME-Proxy-Cause: dmFkZTFgusQnN6wvyOiXZbRGbky4UEHDPV8C8b58CebtZQRiP0lVAeTd1Hwd4fNRYeIP6s
    dTN3foJfSlevEuWtvSp3Y1fwI+Rm8AWVmqwOkaibQ3cgBCaI6dhD6WBzs6AjJIHTjSjKOE
    DmhNENi0V33BgV4/63Sm3iFvEOKkXMIcwYbFyBvGYxzS1zsmCIozqQBqrs4ipPpDnSleHd
    jPQFE7rPiX4m68d2JDXV5Erll87KOzBlU3Qc2XqD1eb8Q2PS2dBg39449nRfh9qJr3Lkzs
    UeEZ+v8U3oQmD/LcSnshsKtf76av7Ky5M+FYcXAXloqsyinhCSfFOaLxvUUGm2TB3lUwnR
    AtWxXbEMxCcY2yYv8489s/QYk485bEqOGMti0E0/DyucqE204kDHhtnAU5YklZtmV1/e02
    wgksTEN/4K/waXDeGQDSjXVz73DGZzKyIvnawgP4aVqpz4l3g3D5YrUj6YF3ieLOW/B9op
    7fLVjdqdasT4X4GHg7/e27mIF8ZggTHZSFJ87RnIqjreCC8+FhB05Ngmc+z5uGrMjud34a
    I5Oe7MtSmqOsCJ/qnycLyc6W3sbNwwcE6XGP22SBj1vmq3FH5wdll8im30VwMzaQfLec0u
    HafDhRqSwRoWnuGMuku6bTueMp52Bf4gETD1CvkYf4CIxPZ0a/hGgaVwSKzg
X-ME-Proxy: <xmx:xD6SarvU1QRR_gdit7ZupeRV0yX9jQG_L8bfzZT2XKoS154eRXEZ1Q>
    <xmx:xD6SalYTVlxB3xzpwfERUr2hkGS0Ju77xqjRYWTxid01EyEn6xoV-g>
    <xmx:xD6Sagtr5aqwdGpxQp7CJhomRYT89bffLwcUSCApKpIwnAERO-rIYg>
    <xmx:xD6SanEok_XgUHsAmKve0SbIrmx6cH_bsoKerksNKm1kCAHMqQfnfw>
    <xmx:xD6Sav99xXT5gBy_nc7TazN1UU8je9gru0uInzacOMz1b2RkWMNUyjWh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 22:07:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH 7/8] checkout: wrap overly long lines
In-Reply-To: <xmqqcxv13ldw.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	28 Aug 2026 15:55:55 -0700")
References: <xmqqh5kd3lm3.fsf@gitster.g>
	<20260828225206.310500-1-gitster@pobox.com>
	<20260828225206.310500-8-gitster@pobox.com>
	<xmqqcxv13ldw.fsf@gitster.g>
Date: Fri, 28 Aug 2026 19:06:59 -0700
Message-ID: <xmqqo6el1xz0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> +	die_for_incompatible_opt3(opts->new_branch,
>> +				  new_branch_opt,
>> +				  opts->new_new_branch_force,
>
> Editor slip.  This should of course be "opts->new_branch_force".

Not just that, but some uses of die_for_incompatible_optN() changed
the order of the options in the error message.  Here is a fixed
version.

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b18515ac7f..9771c848c5 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1864,15 +1864,18 @@ static void validate_path_options(struct checkout_opts *opts)
 
 	if (!opts->patch_mode) {
 		if (opts->patch_context != -1)
-			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
+			die(_("the option '%s' requires '%s'"),
+			    "--unified", "--patch");
 		if (opts->patch_interhunk_context != -1)
-			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
+			die(_("the option '%s' requires '%s'"),
+			    "--inter-hunk-context", "--patch");
 		if (!opts->auto_advance)
-			die(_("the option '%s' requires '%s'"), "--no-auto-advance", "--patch");
+			die(_("the option '%s' requires '%s'"),
+			    "--no-auto-advance", "--patch");
 	}
 
-	if (opts->overlay_mode == 1 && opts->patch_mode)
-		die(_("options '%s' and '%s' cannot be used together"), "-p", "--overlay");
+	die_for_incompatible_opt2(opts->patch_mode, "-p",
+				  opts->overlay_mode == 1, "--overlay");
 
 	if (opts->checkout_index >= 0 || opts->checkout_worktree >= 0) {
 		if (opts->checkout_index < 0)
@@ -1914,19 +1917,25 @@ static void parse_pathspec_from_file_options(struct checkout_opts *opts,
 {
 	if (opts->pathspec_from_file) {
 		if (opts->pathspec.nr)
-			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
-
-		if (opts->force_detach)
-			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--detach");
-
-		if (opts->patch_mode)
-			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
-
-		parse_pathspec_file(&opts->pathspec, 0,
-				    0,
-				    prefix, opts->pathspec_from_file, opts->pathspec_file_nul);
+			die(_("'%s' and pathspec arguments cannot be used together"),
+			    "--pathspec-from-file");
+
+		die_for_incompatible_opt2(!!opts->pathspec_from_file,
+					  "--pathspec-from-file",
+					  opts->force_detach,
+					  "--detach");
+
+		die_for_incompatible_opt2(!!opts->pathspec_from_file,
+					  "--pathspec-from-file",
+					  opts->patch_mode,
+					  "--patch");
+
+		parse_pathspec_file(&opts->pathspec, 0, 0,
+				    prefix, opts->pathspec_from_file,
+				    opts->pathspec_file_nul);
 	} else if (opts->pathspec_file_nul) {
-		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
+		die(_("the option '%s' requires '%s'"),
+		    "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	opts->pathspec.recursive = 1;
@@ -1934,9 +1943,17 @@ static void parse_pathspec_from_file_options(struct checkout_opts *opts,
 
 static void validate_branch_options(struct checkout_opts *opts, char cb_option)
 {
-	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
-		die(_("options '-%c', '-%c', and '%s' cannot be used together"),
-			cb_option, toupper(cb_option), "--orphan");
+	char new_branch_opt[] = "-c";
+	char new_branch_force_opt[] = "-C";
+
+	new_branch_opt[1] = cb_option;
+	new_branch_force_opt[1] = toupper(cb_option);
+
+	die_for_incompatible_opt3(!!opts->new_branch,
+				  new_branch_opt,
+				  !!opts->new_branch_force,
+				  new_branch_force_opt,
+				  !!opts->new_orphan_branch, "--orphan");
 
 	if (opts->new_branch_force)
 		opts->new_branch = opts->new_branch_force;
@@ -2147,10 +2164,12 @@ int cmd_checkout(int argc,
 			   N_("create and checkout a new branch")),
 		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
 			   N_("create/reset and checkout a branch")),
-		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
+		OPT_BOOL('l', NULL, &opts.new_branch_log,
+			 N_("create reflog for new branch")),
 		OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
 			 N_("second guess 'git checkout <no-such-branch>' (default)")),
-		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode (default)")),
+		OPT_BOOL(0, "overlay", &opts.overlay_mode,
+			 N_("use overlay mode (default)")),
 		OPT_BOOL(0, "auto-advance", &opts.auto_advance,
 			 N_("auto advance to the next file when selecting hunks interactively")),
 		OPT_END()
-- 
2.55.0-884-g76cf8659c2

