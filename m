Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="lRloUT+J"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9044B269D
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 03:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1701863537; x=1702468337; i=l.s.r@web.de;
	bh=Z2KAtMlAnKkxVgsQqWkaLDl1RL1w9S/rGzm5Bg1XFtU=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=lRloUT+JDxuRnYm2zXtaZ7vy7tCO3NnmDV3KBkuWQylpd1mtVm5n/6WjrW9zpQdf
	 KIebqymMXQ2N4DqNladCUN6BAyTpZ/51yVzgdcXF6s1z0saq0sn48pG6JRomAk8b+
	 klipAI/dZTUncIdACCgD+GQG3t41LLj4TyNi1gU8JeeNbUXPs3dmxFPam/ovVilJo
	 7rm7FtMozI2LQM2+eAxFPB5HmRq09gRqicnXpXvXPmSTNd2ugpooAqjGKsoXxfAxZ
	 2UYQIrK1bKstambM3rJqLPZNc5vKaPHYEdv8XnabNm99++MeS5/jOFIJ9/bKp4HEQ
	 g9DY3YWtaxvhahssow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.29.38]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MSIJ0-1qmYGG3cj2-00SiNN for <git@vger.kernel.org>; Wed, 06 Dec 2023 12:52:16
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 4/7] revision, rev-parse: factorize incompatibility messages about --exclude-hidden
Date: Wed,  6 Dec 2023 12:51:58 +0100
Message-ID: <20231206115215.94467-5-l.s.r@web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206115215.94467-1-l.s.r@web.de>
References: <20231206115215.94467-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7BfOCIPG5pl+P1dWucy9ly4/QujrT+glZqxwId/R7BWjtz8XVO7
 bPOmQGLq1T9mBmGk1ZRxsoTkXRZ1LhKVVP2K6b8Gor9jiFel7Mu92xAvkMEarDB1aJZvsDT
 MElrm9vMjLQRO6fTe6a1HU7MzDDaZpyXxnhOePN2lKFLfVZIjqM9SXf8DXQzqMnIIGcf5rD
 HmMhTbo9LbG9oxP4pqXlg==
UI-OutboundReport: notjunk:1;M01:P0:cG6HfNJF7lU=;vLQWYQptPtXCJkH9dZTg1PMQjTG
 FJf4uv3hwm5aWr00oA/iwQwbXKbOSxg8penLBd6dtQvzyuL70ABFyQokxuyAtJMKRlzFoWGsq
 YxaeEtEGgnT2nN7s2VZZwe5Q2vRpYYt3NgltGwJcTOAjIQS+wlBwtblEE2tQx6AUUJL48SSoW
 ea+5PT064eK7UzkA8rajv5UkAtxgdo5hl3zizwDV8hX3RogIjEgZyZKKCsJySViINO970nUTP
 /6qDVJ4Kn4f5OVsxgPYAmZidk1N1pW29/+TBowSFg1DKnFIbW6wCzF25XtSo5BYyNYVUXcsne
 Tw1zmLTjnf64ra6UXVQ3VY9Ld+ImsQpbXmSUJDp5/GVrbC/ZHTeILRWJVMywByXQ2dhXs02Bq
 wOShB4ucnOA7ItdyA/uAxJ56WVV69q1dwcKyd6ftyGfBzbk2fmO7zbeFZwvjn5Kysv/HA+48m
 PxQPmUTtVJWgUTbSGQaDtVteCreyc6H510f6j8zI4ZZwuByzIxEww/C8UgxPWb8svekv64F3Z
 gpGhmVQURokeCB7UedwDYGKF1p9dosZpzYG9Femt7EI/k9DEZ3bY8X9tOaykXEzil5HYCcNrT
 Fcr4nskDrlWNnOBYx8DMSr5p9psAOVJJUDCBeq44tPSyVxcr6s/vCVvPFmkwQnj9xeasQG/Yt
 4dvXmMIuCNPfcBeP/R1pT2EUSG43HHvshTt9ezQtuhgw26R/QC3ZrkUrBsf3K0stxCViO2Vfg
 hh3JVZkoCUtWF03VOGphcF+kQpTkVFHiyP/C/vTZ1A1c4nFvk0g7bZB5KmdJDZdLZYFYxYyN0
 nijlzWwfT2O04qoeRqcM7hG9Qxl2r0mG+p12/kVZ8L2KNwv752FP7nBPfUzSO0fcDS0MY5PHP
 e0Bp/Fib9yFKE2oYbcZfbUIVo70eQKgIWV2nkVXQugUXpYyvg2Lo/7BdD6uRoMoXv/2Ok1o/h
 7wT7TA==

Use the standard parameterized message for reporting incompatible
options to report options that are not accepted in combination with
=2D-exclude-hidden.  This reduces the number of strings to translate and
makes the UI a bit more consistent.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/rev-parse.c                |  9 ++++++---
 revision.c                         | 18 ++++++++++++------
 t/t6018-rev-list-glob.sh           |  6 ++----
 t/t6021-rev-list-exclude-hidden.sh |  4 ++--
 4 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index fde8861ca4..917f122440 100644
=2D-- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -893,13 +893,15 @@ int cmd_rev_parse(int argc, const char **argv, const=
 char *prefix)
 			}
 			if (opt_with_value(arg, "--branches", &arg)) {
 				if (ref_excludes.hidden_refs_configured)
-					return error(_("--exclude-hidden cannot be used together with --bran=
ches"));
+					return error(_("options '%s' and '%s' cannot be used together"),
+						     "--exclude-hidden", "--branches");
 				handle_ref_opt(arg, "refs/heads/");
 				continue;
 			}
 			if (opt_with_value(arg, "--tags", &arg)) {
 				if (ref_excludes.hidden_refs_configured)
-					return error(_("--exclude-hidden cannot be used together with --tags=
"));
+					return error(_("options '%s' and '%s' cannot be used together"),
+						     "--exclude-hidden", "--tags");
 				handle_ref_opt(arg, "refs/tags/");
 				continue;
 			}
@@ -909,7 +911,8 @@ int cmd_rev_parse(int argc, const char **argv, const c=
har *prefix)
 			}
 			if (opt_with_value(arg, "--remotes", &arg)) {
 				if (ref_excludes.hidden_refs_configured)
-					return error(_("--exclude-hidden cannot be used together with --remo=
tes"));
+					return error(_("options '%s' and '%s' cannot be used together"),
+						     "--exclude-hidden", "--remotes");
 				handle_ref_opt(arg, "refs/remotes/");
 				continue;
 			}
diff --git a/revision.c b/revision.c
index 1b7e1af6c6..25335a74ad 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -2709,7 +2709,8 @@ static int handle_revision_pseudo_opt(struct rev_inf=
o *revs,
 		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--branches")) {
 		if (revs->ref_excludes.hidden_refs_configured)
-			return error(_("--exclude-hidden cannot be used together with --branch=
es"));
+			return error(_("options '%s' and '%s' cannot be used together"),
+				     "--exclude-hidden", "--branches");
 		handle_refs(refs, revs, *flags, refs_for_each_branch_ref);
 		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--bisect")) {
@@ -2720,12 +2721,14 @@ static int handle_revision_pseudo_opt(struct rev_i=
nfo *revs,
 		revs->bisect =3D 1;
 	} else if (!strcmp(arg, "--tags")) {
 		if (revs->ref_excludes.hidden_refs_configured)
-			return error(_("--exclude-hidden cannot be used together with --tags")=
);
+			return error(_("options '%s' and '%s' cannot be used together"),
+				     "--exclude-hidden", "--tags");
 		handle_refs(refs, revs, *flags, refs_for_each_tag_ref);
 		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--remotes")) {
 		if (revs->ref_excludes.hidden_refs_configured)
-			return error(_("--exclude-hidden cannot be used together with --remote=
s"));
+			return error(_("options '%s' and '%s' cannot be used together"),
+				     "--exclude-hidden", "--remotes");
 		handle_refs(refs, revs, *flags, refs_for_each_remote_ref);
 		clear_ref_exclusions(&revs->ref_excludes);
 	} else if ((argcount =3D parse_long_opt("glob", argv, &optarg))) {
@@ -2743,21 +2746,24 @@ static int handle_revision_pseudo_opt(struct rev_i=
nfo *revs,
 	} else if (skip_prefix(arg, "--branches=3D", &optarg)) {
 		struct all_refs_cb cb;
 		if (revs->ref_excludes.hidden_refs_configured)
-			return error(_("--exclude-hidden cannot be used together with --branch=
es"));
+			return error(_("options '%s' and '%s' cannot be used together"),
+				     "--exclude-hidden", "--branches");
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, optarg, "refs/heads/", &cb);
 		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (skip_prefix(arg, "--tags=3D", &optarg)) {
 		struct all_refs_cb cb;
 		if (revs->ref_excludes.hidden_refs_configured)
-			return error(_("--exclude-hidden cannot be used together with --tags")=
);
+			return error(_("options '%s' and '%s' cannot be used together"),
+				     "--exclude-hidden", "--tags");
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, optarg, "refs/tags/", &cb);
 		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (skip_prefix(arg, "--remotes=3D", &optarg)) {
 		struct all_refs_cb cb;
 		if (revs->ref_excludes.hidden_refs_configured)
-			return error(_("--exclude-hidden cannot be used together with --remote=
s"));
+			return error(_("options '%s' and '%s' cannot be used together"),
+				     "--exclude-hidden", "--remotes");
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, optarg, "refs/remotes/", &cb);
 		clear_ref_exclusions(&revs->ref_excludes);
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index 67d523d405..3b181f771c 100755
=2D-- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -214,15 +214,13 @@ do
 	for pseudoopt in branches tags remotes
 	do
 		test_expect_success "rev-parse --exclude-hidden=3D$section fails with -=
-$pseudoopt" '
-			echo "error: --exclude-hidden cannot be used together with --$pseudoop=
t" >expected &&
 			test_must_fail git rev-parse --exclude-hidden=3D$section --$pseudoopt =
2>err &&
-			test_cmp expected err
+			test_grep "error: options .--exclude-hidden. and .--$pseudoopt. cannot=
 be used together" err
 		'

 		test_expect_success "rev-parse --exclude-hidden=3D$section fails with -=
-$pseudoopt=3Dpattern" '
-			echo "error: --exclude-hidden cannot be used together with --$pseudoop=
t" >expected &&
 			test_must_fail git rev-parse --exclude-hidden=3D$section --$pseudoopt=
=3Dpattern 2>err &&
-			test_cmp expected err
+			test_grep "error: options .--exclude-hidden. and .--$pseudoopt. cannot=
 be used together" err
 		'
 	done
 done
diff --git a/t/t6021-rev-list-exclude-hidden.sh b/t/t6021-rev-list-exclude=
-hidden.sh
index cdf7aa9427..51df02105d 100755
=2D-- a/t/t6021-rev-list-exclude-hidden.sh
+++ b/t/t6021-rev-list-exclude-hidden.sh
@@ -151,12 +151,12 @@ do
 	do
 		test_expect_success "$section: fails with --$pseudoopt" '
 			test_must_fail git rev-list --exclude-hidden=3D$section --$pseudoopt 2=
>err &&
-			test_grep "error: --exclude-hidden cannot be used together with --$pse=
udoopt" err
+			test_grep "error: options .--exclude-hidden. and .--$pseudoopt. cannot=
 be used together" err
 		'

 		test_expect_success "$section: fails with --$pseudoopt=3Dpattern" '
 			test_must_fail git rev-list --exclude-hidden=3D$section --$pseudoopt=
=3Dpattern 2>err &&
-			test_grep "error: --exclude-hidden cannot be used together with --$pse=
udoopt" err
+			test_grep "error: options .--exclude-hidden. and .--$pseudoopt. cannot=
 be used together" err
 		'
 	done
 done
=2D-
2.43.0

