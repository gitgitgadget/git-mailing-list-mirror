Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2370236CDFD
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542183; cv=none; b=oWCuDVfIhubk4klchGrermTfAn+hJZoFkVxQb56kqCvu5MYtdzp+Oc5KgwFsZafq8c29B5GpZFl6nOe8b2s0RMHdsxto2Dd1jbd1TVh7HR6TF1HEN0BCk3rAqE9b40fsexeEyM125RugGLb5SWmGVIqSDwJgu5J9aYW53Yo6pYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542183; c=relaxed/simple;
	bh=3m2LMjbVVB+HfJXlPFt34XhsbB1ZhOXebuRXP0rMC+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9kN5JHlOlPP5L8EA9NGaiesGJl6Ohs0Gz3zZPkwsN4RlSMMJ9G0L/m1ukMZVEl3kqhCg5lICkx4CyeWz0nVXCYtsC6Wd1pLOibYVqxjQKa9feFFTxHnRZSCYhl+EZRHmmbd91VKuNmmQVZTVY+XA05wQZxb5JZawt1tuNBUGEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S3BIfcwC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m+3KkkEo; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S3BIfcwC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m+3KkkEo"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 55DA6EC010B;
	Tue, 27 Jan 2026 14:29:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 27 Jan 2026 14:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1769542181; x=
	1769628581; bh=BI8illkCGxbXUztqEWQ2fxKFZQ1OsR/Sey8FohTBEn8=; b=S
	3BIfcwC98wXSas0bPzc3hRkcCaEvDSiReZ5bxy8oFoDX2lOM2EQm1IGaws2nKuh6
	EwFiJXZ+GL7FbPBLw9LB1ElU1Du2Gx5gL9jgM7iUjRIRM1heWtNEEJNhNlrjPSDr
	kCaXn2hz5zROTHHzJKTBVwvv+dGainnmx164CrDMW/MGzFoY75DzhTZBWhPi+1hm
	vqk8sxc/rG/JXuDpKY3q3trG5mGMJtuVWCCciwRzSBjiGAGf3ncfhW0zEB+DUKDH
	OxqmEcJRhX2GoR/iXNGhvWv4WtP5l8kvjUNIKJRa3SrGHDPn2zCpA1+hMHflPVlK
	7PdKV0evYsZhrr4S8qNkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1769542181; x=1769628581; bh=B
	I8illkCGxbXUztqEWQ2fxKFZQ1OsR/Sey8FohTBEn8=; b=m+3KkkEo6MkMNn3ZG
	ZFxb5Zs54bW9kFnjDJ7Zd3FrwKzT/nL5131rrDRUvPslrcGZFE8YD7/bGqBtSa10
	JGaajXOMEDFdeoM2s4knp/JOEXIlVQXnZUwJJ4Ra1+TlICO/kmTegvcsGy1Smt7e
	uQ0UlKdn4Z2gfa5ezhC4Hw0JjNbT2Uh+JVaIeabdsFzIoTlObOdKJCbEcy/+mrHS
	MtxYBt3Rt45R27KM72JgGWiII9mNVNbSXq1Xp5H9iUXCGRvL6jiT5mEjS7ZoSnKQ
	bpWd0j14zhRanDtAmOFJLdK2dv0SezO07ia9Jd9fipT8zIaVW2cvkGsFPhVr5pBG
	sspKg==
X-ME-Sender: <xms:JRJ5afDwt8ONaawcRggO6JULQEX1anvjSxephKuO6WKC7x4q7N8Clw>
    <xme:JRJ5ac8t24Z-R6QuhZpoUuBuzXUl3mZ9VoDFXPoKolCan18Vf8mBHtEXIA9XeIg70
    Db-blnbFIOoCq7zvcckzWHPazy6RfnkpnTKHb0xLEaR3XbAH2LWsQ>
X-ME-Received: <xmr:JRJ5aX-DzEeP2BQ06axvo89cUXPFkmobDr2GRyRjhcdqG93icPn_6G3K9P5ylZ7qwTGZiQfpFYJv7SKzj3Hkrt7VsMOHTJx5ZKM-zRs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedufeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedvffelhfeutefgkeettdfhudelff
    duteelfeeiueelhfdvudeiueekhfdtvddukeenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgihqhhsihhmohhnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JRJ5abeaFpQ6_Bi2OuzwmxZYckm_MkkvWpvr743Y59dOq2VEG79D3A>
    <xmx:JRJ5aYHFtRlH_nKx9fr6LokntcR1-K_3VvWWKtRlH5Bn4gKcj_my0g>
    <xmx:JRJ5aRd_VD1JRfF0_8vud7Sf3TtvnaOleJpmR1aG_nlN_Ok4jc293Q>
    <xmx:JRJ5aaHQL5B2I1vFsT5sJXyxYDjHkZmFB5Cv_Z8yKaLjhgMx6y-p7g>
    <xmx:JRJ5acmsGROoSeMnRuXJc1VFOTm3XYC6BO_zfqtBFLPV4BD7ohMWzXyx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 14:29:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Simon Cheng <cyqsimon@gmail.com>
Subject: [PATCH 2/2] checkout: tell "parse_remote_branch" which command is calling it
Date: Tue, 27 Jan 2026 11:29:36 -0800
Message-ID: <20260127192936.904719-3-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-rc2-135-gb1217c0133
In-Reply-To: <20260127192936.904719-1-gitster@pobox.com>
References: <20260127192936.904719-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When "git checkout <dwim>" and "git switch <dwim>" need to error out
due to ambiguity of the branch name <dwim>, these command give an
advise message that tells a sample command to show how to
disambiguate from the parse_remote_branch() function.  The sample
command hardcodes "git checkout", since this feature predates "git
switch" by a large margin.  To a user who said "git switch <dwim>"
and got this message, it is confusing.

Pass the "enum checkout_command", which was invented in the previous
step for this exact purpose, down the call chain leading to
parse_remote_branch() function to change the sample command shown to
the user in this advise message.

Reported-by: Simon Cheng <cyqsimon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c        | 29 ++++++++++++++++++++++++-----
 t/t2027-checkout-track.sh | 21 +++++++++++++++++++++
 2 files changed, 45 insertions(+), 5 deletions(-)

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
index a397790df5..e9f8d8ec48 100755
--- a/t/t2027-checkout-track.sh
+++ b/t/t2027-checkout-track.sh
@@ -47,4 +47,25 @@ test_expect_success 'checkout --track -b overrides autoSetupMerge=inherit' '
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
+	test_must_fail git checkout trunk 2>hint &&
+	test_grep "hint: *git checkout --track" hint &&
+	test_grep ! "hint: *git switch --track" hint &&
+
+	{ git update-ref -d refs/heads/trunk || :; } &&
+	test_must_fail git switch trunk 2>hint &&
+	test_grep ! "hint: *git checkout --track" hint &&
+	test_grep "hint: *git switch --track" hint
+'
+
 test_done
-- 
2.53.0-rc2-135-gb1217c0133

