Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E11430AAB8
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788122928; cv=none; b=b0kRgrqPi3ynt05HxeOZy3zvsJJpIGuJ/0x7ZsnNhZ+jNd+x48PS2nk2thiK1+i5bT9pobt+uS24+Az1sWu6/gr9CfZNFPGFdS9IVNWs1cL7tVhNJPcoVhySqMRjQS5QX6Kgr0MO+NynitmMWexEh4baAupBvL4RVEK/0363ANM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788122928; c=relaxed/simple;
	bh=gQT11GYiCPdFsSMRPjw0KEVypAH6Jr3FkFLj8g+ZTks=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5VJowqx91JKFA3VyEVCwfwgUNZQ6SQ4qkv+vpyOZgQ4L2iu2ExiXnIFmokpa4gbBjsfQJmnbT3eXVsZ3Yh0xrJHbvO3bkfjL7xN4et1b5o1+GUeHZW+b6wOMX/2XB3oR/hTqNJt+aqQrPFAPQXB6cA8qIT3dTPVH4jSnvm0CIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tdGOu9HE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EsddRJVv; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tdGOu9HE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EsddRJVv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CC84914000CF;
	Sun, 30 Aug 2026 16:48:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 30 Aug 2026 16:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788122926; x=
	1788209326; bh=YKlrzG70umC37U8sWXXDevfoInF4XqkXQpBqyRlrris=; b=t
	dGOu9HEG/yuReUL4VK2vgNeqnhr2r4rACv6g5SglUBOxO4Xn83aHkx885riJlfyU
	A3zlvzLPiUu1MJrEsAxD/qrT/0smfhOt2q/stYp4qNEXf2VLMqK1eTGKLyoTOw+Z
	u8IaxY9Kk9pBbbuTv0Bt+MNw2GJIikqMcooYcGpbAQczIX2FueezgeKY/28FR8ht
	+vdVvO2IOGbuX3R+VtesRMDsnAg15unzb2Il6avY4ekMdq93jovsQUdDkv941WJ2
	D2ta2y0JV6KBgQ441Shf23IagF/P/xc5Zf6dDShlyNX9AAfj5vy1GlkHX1f6kqvo
	NVcZdU1zwwwH0//gMN0rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1788122926; x=1788209326; bh=YKlrzG70umC37U8sWXXDevfoInF4
	XqkXQpBqyRlrris=; b=EsddRJVvSjRJmpqj2MpJzJWOxyFyNpqCoUm5aGJQz7HP
	GHaPlk0wSbo2D6DVLv3vnoFkYkUzFztjppt0h9j98IGbbheAA8RxOMCF4TIG3RmK
	97wJwyHhWKl7/JfqdiJpQwIitJg7cs6hGa3ImREkUkmE4LnL3dUaqhNH8LBNsm4o
	FYMVxeqY0qgFwwu1gVySTtQFktya1TGFR77NyNAgVi5+uSJn9k2e3K1fnwLtoZvc
	atcaB5/xDJ/KQpm4/UzZJllSBepvzdCLlzCnRyyFUaW8mexcy+x+lFAcJM4FBLVB
	rJ+1sqnLwwBOTAdyzU7egNKSq14wrahKt4JARz/L/w==
X-ME-Sender: <xms:LpeUatrFmK6Ynx_p-9V9yoFCAom-QSWFBiVU5_wyis_qHLSpiFGR6A>
    <xme:LpeUalq5WeJONFJDXXbTzCQ_Iq3_CoZ5TbnK9LPUdNG_tN7dT1acfv1XcUGGicLS6
    8ph2yo3pQleqVy5-qJUa7sA0v5b9NBR_tLk2p5OgaaVIPf_YinF>
X-ME-Received: <xmr:LpeUan29-xs271rgIwnbbpHnoX5ison24gZocGry61rWRB7Sp64jguA_i71VYK-7XccRVLgljS2o9pr1RtbKHJKxtIPonaHA7A>
X-ME-Proxy-Cause: dmFkZTEQbBtPgYkS/zewLDFKkOpXjeUjuQbZySv7JkCot0bNQf0M3imQzT0Cigu141QPEY
    wZfYg+WlpXyw7xhr2aMFt78S3bJQlmsUB39KfGE8xLAaG3dixc2mic4PUV/0OkLaf9Yqy4
    qWh+e2fkK4HeZTiTo8k27RhGm4ac7PgGAXvwWVx804Hdz/+hgDSqwkk1MZ+/XXcoPJ8nSv
    d0RelN/55BVwfvaeAFGcXop9lugjugpNsEyS67nsNtOPkakh/Nz8R0MJLMuaTlUDao8L5I
    HDf1t2nB7wE2aUX9njqTEDDI4paqkfQfCr3rNNjERzLead+6aN/GHlz96mKW8AJlXQ3GfQ
    JcP2LOJSJhFULaqpMMLSzH1tXTEj+MQ12boDXaf6kIDrd/oRPMQlEIUYoQk9QF4lxSBeS+
    sfzJyd2ydwaYx0soNeAlpy0okuYFoXCF/zoCDyepZJECYrTjZN3pedqS6x8JhIHdO144mw
    LFcpJgbjpJl3yGiPzJp+98H8ibyyiktePQnxbvssaK9bKlMFUW+kxdiuii5iCp79Njns0D
    0ib/6bJc+eXuCeqIGWDF8wQpjQGm1NqzAn0MtWogvf9xobv82463RW16ybU5rH5I/LXOt1
    gQOqmwQSWpcHdN3099u8FcO2JcmldSgyDeCQV2WPh26ojFG1kd1q9RSxYnmQ
X-ME-Proxy: <xmx:LpeUakBFhFOuao4O9J9TlBE9IVggjGkjfQYfwhRpZgsu6OPxW9EnFQ>
    <xmx:LpeUavd5T6Y7B7p4F8jurBFftF1ePmSMNdOYE_5eNCLSDb2kKthsPQ>
    <xmx:LpeUapjDtnZOxqTmuV39JvcqrY-rNTVMXW6vdE9qlGNwOD7BvT29DA>
    <xmx:LpeUanqKQLslLj8UJj9cLz6ygaXSrAD72SVq_MGFL_CXGUlf18otSw>
    <xmx:LpeUahDJl78zKpRaH08jxBCFeTmEfGY97nckxTjJIr6MRr7g_fGUbh5q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Aug 2026 16:48:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 7/8] checkout: wrap overly long lines
Date: Sun, 30 Aug 2026 13:48:34 -0700
Message-ID: <20260830204835.1040408-8-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-884-g76cf8659c2
In-Reply-To: <20260830204835.1040408-1-gitster@pobox.com>
References: <20260828225206.310500-1-gitster@pobox.com>
 <20260830204835.1040408-1-gitster@pobox.com>
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
 builtin/checkout.c | 63 ++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 22 deletions(-)

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

