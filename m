Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D9E3126C5
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769713583; cv=none; b=DpTwJhtUJd+viXdkomd/0V9raOT0KFGRbQN9PrnYKSQIL8TM4QPRhkmZK3Pn2h0sVsNOLZkNsygeb3ABq7oV5EBas0IrVrZ9NfLp/qpsMKcqBfSnKUP71AxS4y3XUKTRPJr/uf3UwF4MAIOzMmsx9g8ix+mLNpdfHO0d2z9GI7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769713583; c=relaxed/simple;
	bh=BPVI0pQoGVuZGtEEyxc3aCE5r6x4+ezc8g0TeyZeqTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfRC2aUATmPo+1WVtOuDdlTqY8MnE5d29/v/kba5K7o7pxPHzb8waxmc+rei4+IipcF/sNE+F70fBQN5OoxMEFzZmadQd5PvKgtChcaD3R5HSpXxGUivoddtXmk7EfFeFKw+yq8U8pVLIMZk8oR2ktULqq8jXA2XifdsWGHGyM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XtUXjmPM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=InhNiOYN; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XtUXjmPM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="InhNiOYN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E66D1400094;
	Thu, 29 Jan 2026 14:06:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 29 Jan 2026 14:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1769713581; x=
	1769799981; bh=lF+FBG69nSeLdhb5Rxv5Lsr93QrdwM5as8CzzDlqvdA=; b=X
	tUXjmPMVypXtMQWZzz9FvpgMbvGiAxKuueatORctu8ssjOIjFXdfuPetZwL4a+Cq
	jkw7XOWvKV+YhEj1hjIaQAwt3vSQM6Ln/wJr085PdUi/62dVTvWh6D3i9BiVINBX
	fnylWO9eLDrdvu14NDy+qMElkF2j9X97tE2MSBnTysLKJPIfw4TcDi4rcJdOqgMr
	P4/DEDRALxrtT1u6K4BfrZ2GpZJDGEJZIsJqYmw8DeYZZ3alehFO9cF1riBtP+xN
	u6j4SiUdAZ8xIwgMUS/dCJ7/kBBPCeBkigeQUk7m1q4gcpYGiwsr0ZJkHsmKAZ2m
	avqyyB7EArgs9lEv5j02g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1769713581; x=1769799981; bh=l
	F+FBG69nSeLdhb5Rxv5Lsr93QrdwM5as8CzzDlqvdA=; b=InhNiOYNM9TD2GH5Q
	A9g1IBySmUTRqASFqKRbgARjslXsUE9/TwgZSRoYAidIQatKaO5n1MW/ZQmpAdqM
	8TNZ4aRpGjLf7OfrvK6sFMT1cGMbdzx1hT7+Ra/98cDc0iHcCYKicevi9+2vpKt7
	hpiZbct73sjC26Oq865lvEZzFdigFiqN8ujNG3U0qC3nqoQptAhneRxcoytPRZ4q
	kaQFPISDGN/UG8yUY3fyGkNO2iQAG/lVGaAdgGNLOcqvmAmjjzToaMXWCG4KD7Ci
	WDG+4FZ4OSE2egDQGv2Gjrk9hKf274nKNxXj69VFdthsane7y5zTcoKfQbdUK0Rt
	v7KVA==
X-ME-Sender: <xms:ra97aepNMOQyjw592uUTUzqrmt7SM_5kyrEaIRe-1NnVoJArb5NGQw>
    <xme:ra97aTopeLHfKQEi1nLTETXAco-1WCq3r0_bGq4vnB14jGR8Pl_c3rlBNxSTvXupu
    k46bDXH5lRw907QpQBKtipUiBKkAvbtrzQ9KBHMlPfOtsLpN2D8nao>
X-ME-Received: <xmr:ra97aYO3lUAGTuuChIct2sCkOrTS4zVvVfkY5a6eYDAC_MC5G09HozTBsPCpz3geMVnp1tKEaY9AnBY8tQZVIHPo8w0fvBINqx0thEk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeileekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepvdfflefhueetgfektedthfduleffudetleefieeulefhvdduieeukefhtddv
    udeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegthihqshhimhhonhesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhi
    shhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ra97aczigqK4ursxggGYyAd-_0SkHdAwU3UR05Bo975Rcd-_QT7UkA>
    <xmx:ra97aZsOz3J597Gm_jao8TMrw3Na5t5QYnoNvRA2aSn9ziRNWsBM9g>
    <xmx:ra97ad7HwhisKFjF_vl_4to9Js_b8dZd74fCd_1xBYr-e1-lHf9mdA>
    <xmx:ra97aQShE9eVt826IGx6L2IhApS-HyfGVnH8ugo5kXTi-qRP_6Vh_w>
    <xmx:ra97aXs_VXt5JomsWztpH7cF9vwmlZYqsFrPM7R6lsohxUcQB7LlVdA0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 14:06:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Simon Cheng <cyqsimon@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 2/2] checkout: tell "parse_remote_branch" which command is calling it
Date: Thu, 29 Jan 2026 11:06:16 -0800
Message-ID: <20260129190616.645471-3-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-rc2-149-g6536429cee
In-Reply-To: <20260129190616.645471-1-gitster@pobox.com>
References: <20260127192936.904719-1-gitster@pobox.com>
 <20260129190616.645471-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When "git checkout <dwim>" and "git switch <dwim>" need to error out
due to ambiguity of the branch name <dwim>, these two commands give
an advise message with a sample command that tells the user how to
disambiguate from the parse_remote_branch() function.  The sample
command hardcodes "git checkout", since this feature predates "git
switch" by a large margin.  To a user who said "git switch <dwim>"
and got this message, it is confusing.

Pass the "enum checkout_command", which was invented in the previous
step for this exact purpose, down the call chain leading to
parse_remote_branch() function to change the sample command shown to
the user in this advise message.

Also add a bit more test coverage for this "fail to DWIM under
ambiguity" that we lack, as well as the message we produce when we
fail.

Reported-by: Simon Cheng <cyqsimon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c        | 29 ++++++++++++++++++++++++-----
 t/t2027-checkout-track.sh | 18 ++++++++++++++++++
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4f189fde48..17f31c30b2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1286,7 +1286,8 @@ enum checkout_command {
 
 static char *parse_remote_branch(const char *arg,
 				 struct object_id *rev,
-				 int could_be_checkout_paths)
+				 int could_be_checkout_paths,
+				 enum checkout_command which_command)
 {
 	int num_matches = 0;
 	char *remote = unique_tracking_name(arg, rev, &num_matches);
@@ -1299,14 +1300,30 @@ static char *parse_remote_branch(const char *arg,
 
 	if (!remote && num_matches > 1) {
 	    if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME)) {
+		    const char *cmdname;
+
+		    switch (which_command) {
+		    case CHECKOUT_CHECKOUT:
+			    cmdname = "checkout";
+			    break;
+		    case CHECKOUT_SWITCH:
+			    cmdname = "switch";
+			    break;
+		    default:
+			    BUG("command <%d> should not reach parse_remote_branch",
+				which_command);
+			    break;
+		    }
+
 		    advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 			     "you can do so by fully qualifying the name with the --track option:\n"
 			     "\n"
-			     "    git checkout --track origin/<name>\n"
+			     "    git %s --track origin/<name>\n"
 			     "\n"
 			     "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
 			     "one remote, e.g. the 'origin' remote, consider setting\n"
-			     "checkout.defaultRemote=origin in your config."));
+			     "checkout.defaultRemote=origin in your config."),
+			   cmdname);
 	    }
 
 	    die(_("'%s' matched multiple (%d) remote tracking branches"),
@@ -1318,6 +1335,7 @@ static char *parse_remote_branch(const char *arg,
 
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
+				enum checkout_command which_command,
 				struct branch_info *new_branch_info,
 				struct checkout_opts *opts,
 				struct object_id *rev)
@@ -1427,7 +1445,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 
 		if (recover_with_dwim) {
 			remote = parse_remote_branch(arg, rev,
-						     could_be_checkout_paths);
+						     could_be_checkout_paths,
+						     which_command);
 			if (remote) {
 				*new_branch = arg;
 				arg = remote;
@@ -1916,7 +1935,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			opts->dwim_new_local_branch &&
 			opts->track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts->new_branch;
-		int n = parse_branchname_arg(argc, argv, dwim_ok,
+		int n = parse_branchname_arg(argc, argv, dwim_ok, which_command,
 					     &new_branch_info, opts, &rev);
 		argv += n;
 		argc -= n;
diff --git a/t/t2027-checkout-track.sh b/t/t2027-checkout-track.sh
index a397790df5..c01f1cd617 100755
--- a/t/t2027-checkout-track.sh
+++ b/t/t2027-checkout-track.sh
@@ -47,4 +47,22 @@ test_expect_success 'checkout --track -b overrides autoSetupMerge=inherit' '
 	test_cmp_config refs/heads/main branch.b4.merge
 '
 
+test_expect_success 'ambiguous tracking info' '
+	# Set up a few remote repositories
+	git init --bare --initial-branch=trunk src1 &&
+	git init --bare --initial-branch=trunk src2 &&
+	git push src1 one:refs/heads/trunk &&
+	git push src2 two:refs/heads/trunk &&
+
+	git remote add -f src1 "file://$PWD/src1" &&
+	git remote add -f src2 "file://$PWD/src2" &&
+
+	# DWIM
+	test_must_fail git checkout trunk 2>hint.checkout &&
+	test_grep "hint: *git checkout --track" hint.checkout &&
+
+	test_must_fail git switch trunk 2>hint.switch &&
+	test_grep "hint: *git switch --track" hint.switch
+'
+
 test_done
-- 
2.53.0-rc2-135-gb1217c0133

