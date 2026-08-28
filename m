Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F51FF1C7
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787957538; cv=none; b=YRIfr0+wXo71RHDDmRM3TuayvBrVfHfSQat9URSBnFxpb4qlgQzzCLiJkTW3qB29lqil3IFDYhXzfSKTIF3/g4GoHtKqDbforXMseXyga8+XI+SltjVuEHmIy5ST0GUzZSHMQJ1n4dnXd84XPdVmhJfHb1PFHpg29X/AgtBRQBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787957538; c=relaxed/simple;
	bh=+pibVRtydhMYz8xUI2gYHmsPUaF59/VdS94O2AUC8XI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XctmMRQA39MaeqVJsfJ385moozi3pHhjuBPKsqHsyDDcH+yeERwZQ1rca61ccgWDIktBgP2CdN4xXO8rLRoJrJqpSN1idYEEVU+mttXsRV4qyYhCrHCohiS3zlIL5Pez3hAAs4NpOZp3udUk2DwvkqJwVnTbcJuJeLQIUTjIafg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MBzGg7lt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UaCmpJ+7; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MBzGg7lt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UaCmpJ+7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 551AF7A0015;
	Fri, 28 Aug 2026 18:52:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 28 Aug 2026 18:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787957536; x=
	1788043936; bh=AbX7CPBPGn9ZgDDFDS32r1pJ8bHX0Ux0FEyW7LKTn1Q=; b=M
	BzGg7ltk2h1vJb2zCQDhSHog2+U/58UTVv2/me66xDmTzOs+pB64TYwK1Df1QxNl
	Q6M8a+ejrhOMELSdUL6dLq3hF/xvc+nnTNgmQYEaRzYqoja3udYDsW4quhsJIZ5Q
	YvkkeD7/XA9UHa+JtwBibnxFQntkl6f63kKakgPuH8V6YSF6v72OSXrIFwRERmTp
	0QWvhA4oWr2YjEp3T6sXcxjdnsYR7m0tpHrqVOhPZaje/erLkv1ItL++9OQKT45W
	fqckc9eK6zrcQUYSFbC6sYpJXCoMeXRQ7YKBvcw4FFDg5mmPGBCSWADkrtTOb1ue
	BP5zkc1azbmJ/VmExOPRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787957536; x=1788043936; bh=AbX7CPBPGn9ZgDDFDS32r1pJ8bHX
	0Ux0FEyW7LKTn1Q=; b=UaCmpJ+7uVzpkQxJsLP0YeIBsQvr7bg6yDIuaJTUlzh+
	2dy/r5txcnnQcw02ggvgyUsD6eG+D5/arwjzFxisv5f+ZMPnGDNl9e8EYSrNYSnM
	14RVhVvvELBH+GElhvpnYrTVtUlWIKpdEXKYu1Nk8Y/T3kYkQuE8UcCi30BCRdYu
	0VAFjFmZtHl9DDPsXCn8xVE27F7p/oCF7nrDRwl72H37Ntl/valYMqdWq4VdOW+J
	lCONWdLhy4iQDl9ezYPy0D3EBDiaw2dvPPBTtK8yj2hPkaAIfrQPtfk2asTCLgCs
	mTFt9USQw8Il4CgyCfqYwDSlOuvUyIqrwcz5Vi5p1A==
X-ME-Sender: <xms:IBGSakHo6IVvd0ZQel4o59BLGfE0zrE1REr6CvQlDYXXFBaCck-I3Q>
    <xme:IBGSajXpVJdTjqxiw3pHGNEYGUaQLYbGuAFHmtMRs_FCLprNjfgq7DmP-3yloJ83A
    TgzCBNg0nWx0dWYXv5zGOaazqh3YsfGq-365ME5v0Z4ZEJmTPJRrTk>
X-ME-Received: <xmr:IBGSarzf0d-575_0kQRUYWNiQkg7xU9j2pqw7PYSCZJi0csz20z4O8mDUccVocuiBuTe6o6SSYlGdUumwS3_dwkfutO59DYPwA>
X-ME-Proxy-Cause: dmFkZTE8HSBiUYKAihHQGCjSLUGFOkVNQpyDUrhWXHEKvmzv05O+eqoeMCm/5GE1dYJoeC
    KcMRnVSaHOb8ssr9ggukJhNQIMBPixhlR7iOLnIj308qielNVl41pgRj1EeVskNi04txui
    QoT6PbZvHJFzV3ujColZT5dtnyDBVRlqbknqfT6byJ4ZzbO1sp9dUyBKfT8sdSpO4GHrPD
    uQrxnYPwFQgQiJLYLJNPfLui6hpKFGtmkhtHsDS20k/dT+1J/zhK7s79Jm9w/A3fiHlayB
    GSRVqkC/S3iI7twukxpME+cvblCSBkoHt7k9iVccwDve8mmdvsQq4lr2tCi9T6x2pm88YQ
    Tl4xYUDKXrJWOdGhZKlSSC1esydb7A2Lhlyy8XAfc5vhNAj3Bd2AnhfmxqHqkLaEHIj5K9
    65pOE1KNAj+kxoHOnqeLcPjxqUsshkaLHcgbuMVwMyCXxxClpvobyBg+FmlQ5o3CfSkvGX
    RXgTMhwRSHs02xjnXxk9SE3EYO0adafJlFLxa5EkiLECFhaJIpExl+inpC0SaMl4klp6GE
    7Gm3Pla2LFANiSJY77wxb1WIlbFaV/z6Dxx1027l7iXBMUoxf4Pv288SfQ+fEiNx1RwSuH
    dhqeLxZtRUCagztI0IQXbQtY094PmH6shkqXVnaRDpL3W2uJmgmUxWc0FX0w
X-ME-Proxy: <xmx:IBGSahN0iUzw8Wug3E8zouaMU4tXXL6IJdMMV-oRaJleWO8gKGo87Q>
    <xmx:IBGSas77GXotNcbjv38PyDXVRMkTDkZqtaE0oUI3SBsXkCkQ46xHIg>
    <xmx:IBGSaiM2y7i9yC7G2tbRfVsnnF0BJbtn-sjWKX-ECZTdX0CjXyreng>
    <xmx:IBGSaqkxAl9ONTVxGXKmFze7zG_rRn32ZC5lWfw7uiYQpbmE2jy26Q>
    <xmx:IBGSavcqBKGGzqYKs26mmsr53LuKlMaTobr9DJtoBqSSUWti5uDxQbiF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 18:52:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 5/8] checkout: extract branch setup and tracking helpers
Date: Fri, 28 Aug 2026 15:52:03 -0700
Message-ID: <20260828225206.310500-6-gitster@pobox.com>
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

