Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEB43976A0
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787957541; cv=none; b=tWf9iThL444pI+rD2/2j+Z6s8WR6bkSfWLEHNMWD+2GhoSNY5SRXS3p5/WTRoEz8XvsQJ40BMWGo1TfOgZ0ZJjTdX/XFIXYyWBZzAu8klZArojxgIOU//w5C4iomGEqxddwnEbs8MvqYPh85xF7fOsO8daEqXlpcwLWoV9ARiJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787957541; c=relaxed/simple;
	bh=GkWouG8Dk34kbuP0FLD6mxjRO9Zenf0Y9TDWjcb9yvQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8wg/mun3FEHYdEO9fZV3B0lm7dv92i/N9aL3dJzQE+2dj+zUKbQV7Ohx86EqVbys/W24YVxmL0hqqAoiHvMPVH9tGdsxEUjiZqfHaQbrypcimf+kD7ZtdOxMR3eXvjgjPx4KSBT5KftJufn0T/KaaEm7ULLvAKYQNNDYjh8xVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=On46lsUa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eRKR9fh3; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="On46lsUa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eRKR9fh3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8B0B11D000B1;
	Fri, 28 Aug 2026 18:52:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 28 Aug 2026 18:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787957539; x=
	1788043939; bh=UzRljrXaI0tJgTR4NLu5nEG907wAx6noO2jwXGC4O0A=; b=O
	n46lsUa0kSD13VfxX8N+BmnL19ikUYxGxxXx2444T+uS8yhobBC6ON4c86LNaNeb
	A5pXvCdUUkF0t02DXbsTznzjVTvMRsiXYjAMk4Apj7Ib7J/OhH7cxbeY0CdEWX/M
	Ieu+J1ihIviN6LkGOW8wsw7AZxzKN46AfEUojlj6FKPFi5phd3SXTG0M7gXVU3D4
	/IURs9P4Kff7R5FqYXsSdBoQJBNEvsZx4AdFGBHa5C9eUbodwIZcEf+SC5MZyXma
	f/ZbiG6y6PnrcehuOkrpHVUuF4Fh4872U1OOS7APsNQmAROSMRjooPihP2p1fBIZ
	k5+q5tVlC4IdcP5zbi9pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787957539; x=1788043939; bh=UzRljrXaI0tJgTR4NLu5nEG907wA
	x6noO2jwXGC4O0A=; b=eRKR9fh30yhwmqNA5u2jyjY2tmIOfgBzPeGzWBgTujEB
	iWo3OaHIegaztTiijNjfleuNV2VDPWnnJ8A4vTK3w79h5kznqXqkIaoqqGW9hdBT
	TW5xrRrqpq9jkgLOVdpYch28wrfmgtiJHZd+g+8UzYlOdD8QQcNU7k+EUysfZCtf
	pAKM8zR3QY7hTXv7FTl9ptoPK2BYdInBcQ6Ci7I+o+AUDSAgOUPOkOcJCTEzyC66
	IdAcCJmW/YxqyYCp0WQu/ZJdox1NSBVqnguTqhjP86g8Gcq49+TJnEEFIQAACpdT
	WBFxXtrgcz7UTfSBg1AbtERRGGH6Ok/Q7sirsZSb0Q==
X-ME-Sender: <xms:IxGSao5f4H4qSx_oK8hy36K3mQyYae5KqMP6pzukO27KH9dlEUth2w>
    <xme:IxGSav7i3a5_Nbg0xYZlFAbUwjtPQ4MSWWDEwlDL_tbU0Ceb3ojmz8B_pZvqGJ1_W
    taXZYfuIRSanMz05EtQrKMIYXI-nbsT_iqn4zTx7eTw0l_BNF6pw4E>
X-ME-Received: <xmr:IxGSalHQ2oj71Y0wUd5LsFHt00VRKS_Zi8V7GRdzpsOP_3Mh9QsRdKPS30BPdEIBjKrWiRdgb0rRf8Yh5S2kb9VYzGf6xF4M0Q>
X-ME-Proxy-Cause: dmFkZTEZIwmOUe+p666Ak5w98WdnZBP6MKTNH3OYl4APods/2Nr7zdPQ+VO0C41673XLHh
    8zH7g6A4rqe/GN1jTzjFnfoR9qaNgNh4Eix/nBLREoI9exiUelnaPpT6wW3XKMJP7XoGY/
    Bl/X7BZ3VzbFncnmlypodImesg4cBrYh1gMshdKiRUN8GWag6B2ZASmFtUez1c0xMIGtU2
    /Bv3tJkAjw3KqdDs94YalaNd9ab+krzfLnl5eut0V8fTPLZKfNfLF5hAto9ckU+KkmZW9z
    fBkA9froXcLo4Sr77UCwMQr4H/C/jQmuQB0NDSs3OQIG20AEud0H+0MdfNJdxQUqLurba+
    JCpURGKOQaroSEQs3FtpffEQo/rRjlwOekSwfkxV+8RCKzQIT5vEBkCo8+CBvnzftSvI4T
    wlGM9pkdk+dsni//lC8RGf+TMRTFevhkStxe6QMZR+qe0zETRxd9WqbkmbTMuLU+PEfquy
    w0Hk0zOBk0yvmgY+DbYsvLPF2SK+3ZlEgFjk3DnshyYMii+b80l2H7SLBj9zMUIAT6bvVK
    bGyi0JsIciZMOTrB4Hdmz3IXhCZwtxU/16HpilShoPZE4wXgWNLPVgqGY6n2NQA2+aNxlG
    fsUZDA/1LDKAeBjT/UqPZthsUYbSgF559IMVVzNZKJvFmk08KvWsUZPmsFGA
X-ME-Proxy: <xmx:IxGSaoTB2UyPfzXi4dwRmpPrvTG5ne9791rTUhmde5fsGA7-3ND83w>
    <xmx:IxGSaut6CiRaBOkgIo0Rb9Rlea20HEeBT3h1NsgMKPZgtsGvzAXByg>
    <xmx:IxGSanxjIXsq4FZhRYUJZJsZDW93RYb8U1_u8ZuTil7vL27uCTMo6A>
    <xmx:IxGSao52fYahOd66EogspwRBvSuGJL3Tp6ouFZwssAU3C7zXZ4XqAw>
    <xmx:IxGSasRMUp_HakvBvHoYOvngthbByjKAf2OdxIaxZsg9EEnhuLqbvirL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 18:52:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 7/8] checkout: wrap overly long lines
Date: Fri, 28 Aug 2026 15:52:05 -0700
Message-ID: <20260828225206.310500-8-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-884-g76cf8659c2
In-Reply-To: <20260828225206.310500-1-gitster@pobox.com>
References: <xmqqh5kd3lm3.fsf@gitster.g>
 <20260828225206.310500-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So far, the patches in this series have tried to leave the original
code intact as much as possible when moving it, to make the
refactoring easier to review.

However, there are quite a few overly long lines that are hard to
read.  There are also several manual checks for mutually
incompatible options where die_for_incompatible_optN() could be
used instead.

Now that most of the refactoring is complete, tidy up these warts to
finish off the series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c | 54 +++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b18515ac7f..f13d70b224 100644
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
+	die_for_incompatible_opt2(opts->overlay_mode == 1, "--overlay",
+				  opts->patch_mode, "-p");
 
 	if (opts->checkout_index >= 0 || opts->checkout_worktree >= 0) {
 		if (opts->checkout_index < 0)
@@ -1914,19 +1917,20 @@ static void parse_pathspec_from_file_options(struct checkout_opts *opts,
 {
 	if (opts->pathspec_from_file) {
 		if (opts->pathspec.nr)
-			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
+			die(_("'%s' and pathspec arguments cannot be used together"),
+			    "--pathspec-from-file");
 
-		if (opts->force_detach)
-			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--detach");
+		die_for_incompatible_opt2(opts->force_detach, "--detach",
+					  1, "--pathspec-from-file");
 
-		if (opts->patch_mode)
-			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
-
-		parse_pathspec_file(&opts->pathspec, 0,
-				    0,
-				    prefix, opts->pathspec_from_file, opts->pathspec_file_nul);
+		die_for_incompatible_opt2(opts->patch_mode, "--patch",
+					  1, "--pathspec-from-file");
+		parse_pathspec_file(&opts->pathspec, 0, 0,
+				    prefix, opts->pathspec_from_file,
+				    opts->pathspec_file_nul);
 	} else if (opts->pathspec_file_nul) {
-		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
+		die(_("the option '%s' requires '%s'"),
+		    "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	opts->pathspec.recursive = 1;
@@ -1934,9 +1938,17 @@ static void parse_pathspec_from_file_options(struct checkout_opts *opts,
 
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
+	die_for_incompatible_opt3(opts->new_branch,
+				  new_branch_opt,
+				  opts->new_new_branch_force,
+				  new_branch_force_opt,
+				  opts->new_orphan_branch, "--orphan");
 
 	if (opts->new_branch_force)
 		opts->new_branch = opts->new_branch_force;
@@ -2147,10 +2159,12 @@ int cmd_checkout(int argc,
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

