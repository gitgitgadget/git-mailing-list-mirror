Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CCA30F548
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788122926; cv=none; b=WM7fnLXzyEOAhBGiuljk35axxNq/jEOwumo/GTxJhH8yfJsoKtMPMs1WpGXXbHKIn0H0bG1SZfyCT0Dunm2mf8Sic7iUMLJMFapLMZSJlK1fkgZTyp7k4LIk28yVdhQNFRpknoiTvAezQBmCKkYDZmCmlwfLM/zYaU1iVcHGnQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788122926; c=relaxed/simple;
	bh=+pibVRtydhMYz8xUI2gYHmsPUaF59/VdS94O2AUC8XI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTeyJGYatXZvjChU7FyXtOb6wRWA0wy/qcQVVVdOv6E+FIADWsSwh2uIhrhGD4npiheeFVinTlZhahuFIpttgY9470mAayMkEA/tJHOVomnwtEKJDprSv5z9hlY747KUlSNwoZEjoi5tV1sYeXr87z9+moFOrHPHBagCHHBSd6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dVeDmC2g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RZcZjQzj; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dVeDmC2g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RZcZjQzj"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 0C3B2EC0086;
	Sun, 30 Aug 2026 16:48:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sun, 30 Aug 2026 16:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788122924; x=
	1788209324; bh=AbX7CPBPGn9ZgDDFDS32r1pJ8bHX0Ux0FEyW7LKTn1Q=; b=d
	VeDmC2gR2mK1+/pQNJbj4qOzjfGQX7R/F/XvxykEdF78ej5VHtBzTSi+zyi9Q6bl
	cpTriozmHIY1/6AiAmH7Dw9IjTesWxc16B/woJLYMWDW9SpHbz1T7nBiDVL2PG5F
	QoeSAykdueh4x6ndJH/6PaOF3S9zhxhlpscwFwO1YbD2jPQhnDsXq2Y26U7rsXsF
	XyC/6dNaZZPePaKpeyVmlMMXsBSuWBgt6dzAIrIVtlVVHVYO+jQJ6e7zuGOHIBfK
	tLepIQAFPc14TQYJkcoNqegEQXa9OEGFaM9t2HFMVeVaMtSge2xLU15KSi6RnyY0
	xHhVlUD9ZkDE3ogjMp/cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1788122924; x=1788209324; bh=AbX7CPBPGn9ZgDDFDS32r1pJ8bHX
	0Ux0FEyW7LKTn1Q=; b=RZcZjQzjxGJ0iBmE+EU/lcEsGC/j2KE8USd8JKNZJklP
	EYBcmUIus/5qcH41NfORrwcyV1wdmQmF/F/nGSwT5AiBD3m8AS1dCz6hflsxfltY
	fZcdb9Ow2KSJVqhBaOxORHSi3wlK2FahcEsqh6CnjjM6vfkxpaAzN+NFwmIKR677
	7y59TeqagD7iSa7uTapE3jta2/eKu4qwIh2Lj5tTBtCa/tCnKEQcJ61urHsY2mSW
	nxfjoLfGEgOIkf+6EHC5vLfBqFkoDvkf5Dxup4lug53itfIoHDKI+d2k0bssAPhX
	6FbAzcAX0TrUbKJVZG/HwoLZ92FCqcce3PubCKyQag==
X-ME-Sender: <xms:K5eUauXwaNFl7rR4mucSbs2VZXL5Iljufcow_pJOeM_ZWj3kSdUh6Q>
    <xme:K5eUagnvy_MOK8FCgiiqusZoZcyUdaBrI3KR0KmnrS1e50ezjLgdbXtaIMFH4-En9
    utAm3c8jaoIHOWAfwlgEQ5P_1sXdPWb52Qyy_m6QYM1-W3o68LIbwU>
X-ME-Received: <xmr:K5eUagDTK2VyQhA8RXnUPjOsqoAICx9HalueokwfQMnCb2f-exb5OUgM8B7c3SC1jz5XAbzhWgyZCwbuioQjoO5rFjf8mItUTw>
X-ME-Proxy-Cause: dmFkZTGpxBreKong0VtR4qC+o1j65EClxmMKtlNb51ZMOKkI04uXcAfuEsFsLLc+HbJj8e
    0uh5su56pJDxkDNagV0UC6S6uMVhaFZ5jIBZtwvmdengJmUhCxcdsNjG/XEMam3+verCk7
    H+yUAW193Pbb3PboqDdPE/X+dfwuUuh2WZmN90YifjKjFoJ/OdNwHqTxOnRMHKgE6nqZwD
    pOQh6dMLhuJEriX8QtN7iSSj4zlM3sswf6gW+Yby+7EWb/cJnyEE9EV6EcsgdIp0VBsK2F
    PlRVcO5jVI2l+wZNp7rE7xBEphaLUgejJ5SSXParYGKyF4xabIUgL1OXOhxq+EnrXoy+gF
    Meq0UCSPm3i3DS4lwvohFq2+s/1Wgnfe84zAGYj/AMHGKZCAhr3/Y2BquSWt/5c2yZAK/z
    ay7b0IvfjNKeowaza87zYxUM+o1/75qIRhYrRjtQF7k0Y4N6qJXpwaQ0LSoDyDnlUMee6E
    +BPqJSjqsmVsp6AFaxYzG5btBnTfFjwDmh1oiMZGesel7lCletEaYU7VEv/B48DxlpHyMh
    c18FrFIwaZwiukA5I9xWkEig/qDJ0BfyYyjh0FeJwymeufDkSSeSD3jAJX5vEY7zZyaJwH
    LM6FXNz9D6KWEhmNoM5udtYTG5UNPv3an0QNuiVrsZ8rqQUa7tmZ/wM9Tvow
X-ME-Proxy: <xmx:K5eUagcgFR9giMNw7ZQRMZAKniBtORmZXa-rrWuFXl_8zV37WNPu0w>
    <xmx:K5eUarJq_7g8MPvRfSHLDqyxq_W0luS3lwTklD07bTEj2OjNPrdw3Q>
    <xmx:K5eUajdFTJT3cRWV9iVO7HDdrgx3hsZVxuVFpPmMsHNPITdvc4PX8g>
    <xmx:K5eUai2V8QZs2Yhr0lJcsSTr2LJpovWI4o8hVj9B9QGOsXylUfwjew>
    <xmx:LJeUaptVCRUuHVYURvD3WRJ6d_naVjZBoJDSX7niTWXMUgj864T0YK9_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Aug 2026 16:48:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 5/8] checkout: extract branch setup and tracking helpers
Date: Sun, 30 Aug 2026 13:48:32 -0700
Message-ID: <20260830204835.1040408-6-gitster@pobox.com>
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

The checkout_main() function validates branch-creation options,
DWIMs tracking branch options, and sets up branch information
directly in its body.

Extract these branch setup operations into static helper functions:

  - validate_branch_options() validates compatibility of '-b', '-B',
    and '--orphan' options.

  - dwim_branch_track_option() infers the branch name when '--track'
    is given without an explicit branch name.

  - setup_branch_name_and_info() drives branch validation and parses
    the branch name argument.

Call the new setup helper from checkout_main().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c | 104 +++++++++++++++++++++++----------------------
 1 file changed, 54 insertions(+), 50 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8d567def7e..2edaca5539 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1938,6 +1938,57 @@ static void parse_pathspec_from_file_options(struct checkout_opts *opts,
 	opts->pathspec.recursive = 1;
 }
 
+static void validate_branch_options(struct checkout_opts *opts, char cb_option)
+{
+	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
+		die(_("options '-%c', '-%c', and '%s' cannot be used together"),
+			cb_option, toupper(cb_option), "--orphan");
+
+	if (opts->new_branch_force)
+		opts->new_branch = opts->new_branch_force;
+
+	if (opts->new_orphan_branch)
+		opts->new_branch = opts->new_orphan_branch;
+}
+
+static void dwim_branch_track_option(int argc, const char **argv,
+				     struct checkout_opts *opts, char cb_option)
+{
+	/* --track without -c/-C/-b/-B/--orphan should DWIM */
+	if (opts->track != BRANCH_TRACK_UNSPECIFIED && !opts->new_branch) {
+		const char *argv0 = argv[0];
+		if (!argc || !strcmp(argv0, "--"))
+			die(_("--track needs a branch name"));
+		skip_prefix(argv0, "refs/", &argv0);
+		skip_prefix(argv0, "remotes/", &argv0);
+		argv0 = strchr(argv0, '/');
+		if (!argv0 || !argv0[1])
+			die(_("missing branch name; try -%c"), cb_option);
+		opts->new_branch = argv0 + 1;
+	}
+}
+
+static int setup_branch_name_and_info(int argc, const char **argv,
+				      struct checkout_opts *opts,
+				      struct branch_info *new_branch_info,
+				      char cb_option)
+{
+	validate_branch_options(opts, cb_option);
+	dwim_branch_track_option(argc, argv, opts, cb_option);
+
+	if (argc) {
+		struct object_id rev;
+		int dwim_ok =
+			!opts->patch_mode &&
+			opts->dwim_new_local_branch &&
+			opts->track == BRANCH_TRACK_UNSPECIFIED &&
+			!opts->new_branch;
+		return parse_branchname_arg(argc, argv, dwim_ok, cb_option,
+					    new_branch_info, opts, &rev);
+	}
+	return 0;
+}
+
 static int checkout_main(int argc, const char **argv, const char *prefix,
 			 struct checkout_opts *opts, struct option *options,
 			 enum checkout_command which_command)
@@ -1992,10 +2043,6 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	validate_path_options(opts);
 	prepare_common_options(opts);
 
-	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
-		die(_("options '-%c', '-%c', and '%s' cannot be used together"),
-			cb_option, toupper(cb_option), "--orphan");
-
 	/*
 	 * convenient shortcut: "git restore --staged [--worktree]" equals
 	 * "git restore --staged [--worktree] --source HEAD"
@@ -2003,52 +2050,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	if (!opts->from_treeish && opts->checkout_index)
 		opts->from_treeish = "HEAD";
 
-	/*
-	 * From here on, new_branch will contain the branch to be checked out,
-	 * and new_branch_force and new_orphan_branch will tell us which one of
-	 * -b/-B/-c/-C/--orphan is being used.
-	 */
-	if (opts->new_branch_force)
-		opts->new_branch = opts->new_branch_force;
-
-	if (opts->new_orphan_branch)
-		opts->new_branch = opts->new_orphan_branch;
-
-	/* --track without -c/-C/-b/-B/--orphan should DWIM */
-	if (opts->track != BRANCH_TRACK_UNSPECIFIED && !opts->new_branch) {
-		const char *argv0 = argv[0];
-		if (!argc || !strcmp(argv0, "--"))
-			die(_("--track needs a branch name"));
-		skip_prefix(argv0, "refs/", &argv0);
-		skip_prefix(argv0, "remotes/", &argv0);
-		argv0 = strchr(argv0, '/');
-		if (!argv0 || !argv0[1])
-			die(_("missing branch name; try -%c"), cb_option);
-		opts->new_branch = argv0 + 1;
-	}
-
-	/*
-	 * Extract branch name from command line arguments, so
-	 * all that is left is pathspecs.
-	 *
-	 * Handle
-	 *
-	 *  1) git checkout <tree> -- [<paths>]
-	 *  2) git checkout -- [<paths>]
-	 *  3) git checkout <something> [<paths>]
-	 *
-	 * including "last branch" syntax and DWIM-ery for names of
-	 * remote branches, erroring out for invalid or ambiguous cases.
-	 */
-	if (argc && opts->accept_ref) {
-		struct object_id rev;
-		int dwim_ok =
-			!opts->patch_mode &&
-			opts->dwim_new_local_branch &&
-			opts->track == BRANCH_TRACK_UNSPECIFIED &&
-			!opts->new_branch;
-		int n = parse_branchname_arg(argc, argv, dwim_ok, cb_option,
-					     &new_branch_info, opts, &rev);
+	if (opts->accept_ref) {
+		int n = setup_branch_name_and_info(argc, argv, opts,
+						   &new_branch_info, cb_option);
 		argv += n;
 		argc -= n;
 	} else if (!opts->accept_ref && opts->from_treeish) {
-- 
2.55.0-884-g76cf8659c2

