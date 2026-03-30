Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640223D3D0C
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876685; cv=none; b=etB11wZm8mKcAQJqyrTYPUFT21ktTapPOsSi518MQAvBfU7oxo6me7BJ7mlvlBizHky6m1Gt81+rqd38k65D0KAiuydzE0UnWLnsaNTEXYz+kRXagHimUh6qzKPB5YT8YiPIaB+jFA2n5YYv8KvB4RMKVs9UHFHTNxeH4n2pNlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876685; c=relaxed/simple;
	bh=7TM0jzUltIUztXqXHAewCbO6gySqRbDXInXwv+lO8vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TvzkhHzTjlqF3w3xFRD3Z1BZe6PkqQFwfy2oBc5kU6J0gYV0ViKeG0NBBLW6s8deH0K1hy1Kyz7dPKaKYXRbnlMeDzi7cArAshh/EPA77L83G7TdqLcNxLCm5edCfTPJaOsLj3+OO/3hQB7bz8B3zvqXI3PB+XRLS9P/LbJ01+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X2dLMZRo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K83n9jPM; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X2dLMZRo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K83n9jPM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B70E51D00026
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 30 Mar 2026 09:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774876683;
	 x=1774963083; bh=g+HTi1L65AX+kPCuncJ6C+fEBKdRV4YdeTKFqCd2XeQ=; b=
	X2dLMZRoO2kONDpvENZE9fwEjAWNVCO8YxPxjr8GyXyohnWe/adKHYwPCS6YAG3M
	7zvzw1NbyDY1nDockqfwCWmMzAKwRyi+sgIkIw8cjhiMeJFBQJV/QFpYp9h1955E
	vcsqfr2FAk4+jhTLnWPUrlKhBhLMRk0hTcYNQDXDLZ+NFops+vQUJ3kLmSunvVhl
	1LLzLL9u6iP7SwinRqFr6hdDXyEOyRfjizPVaQqqZpCG1BRPrvbF8eIUCIWXttOt
	ZO29PA8Ijuazcv+DE0Y/GnwlH/+l5rKDTD8wBr6YmWOpdk8IAgKNIXwLgi82P7Tw
	CltxRM2aJFE5CYtjBtglMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774876683; x=
	1774963083; bh=g+HTi1L65AX+kPCuncJ6C+fEBKdRV4YdeTKFqCd2XeQ=; b=K
	83n9jPMo00kAxc2H1rDTElGmTi4fS+mnstEyK3HyRiO4vZBhgGMu40kjsBUw4he6
	dyX+b4KvlKWpx/8/Vh/4SF3gUvMETacUwuaumi8imc2aZ8MyDAB+O+iDOtFmZz3I
	YEj4LJzK26fxNtk3gix788eUAJ/oA6vnqRPm5rdHhkx1x7LJPD4lH4OJ/plPTOWY
	7Tkf3Yzl7IQt4vXSru9l34uQk9ZiSklkOr6zf5KVNg9V3OPlBWWj+5mdaaq0NK89
	gMnzUxrnKfQvNaMSXGt4lePEjssZYR6BSJFBjhHH1I2f7w1LgO3kPHMmh2okaAxf
	4urcVtZ0UkgsFMyWuTtXA==
X-ME-Sender: <xms:C3jKabmdlyZ8qr9F3ohOAwhFHmoZc1wrAyUYx_HpzRK5Sb2m7AutBQ>
    <xme:C3jKaVxybiGFOPSHyeBBBysfRBd_LavAIW-zlNMJA1DZ-9Skw1nZYz1NF7QM9FS99
    psBbhnMRhKgXTlqdbMVTOGUNziPnsx-gtkdIaOf39puJhfWGNYI3Q>
X-ME-Received: <xmr:C3jKaXTEtycnaItHAJ9d1GGSopfCiO0y72h2lLn_e-y9z1r8orbX-oD0S3cVCkIYQSjjRe_gw6Cwd8guNm2peLCpTtdkeI9aYCefMYO-iQ1NBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:C3jKaYteJB_SyIj4Vuv_8B8jZl4mkYs0FqyNlSUWj_zOVOZ1pNu3QA>
    <xmx:C3jKaZsYtkJzSz7kHTwSxBKDOH3dGOfrZNh1s4Nmju9Ul1op81n6hA>
    <xmx:C3jKaeyoMtwJPvxCtBkpCythw3leTB-_eIwKK91aycbaYgAQtY-lIQ>
    <xmx:C3jKafj95LX-g1D-tvYpSgUMMxA_tkIR9G7znokQBwvH3utFygR1eA>
    <xmx:C3jKab1m6YkVy-6Mxnj7dw7DcEQHdQb4A6f1V7IUTrR-Mon8YSMFJUdg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 83d6f54b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Mar 2026 13:18:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Mar 2026 15:17:29 +0200
Subject: [PATCH 07/18] setup: stop using `the_repository` in
 `verify_non_filename()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-pks-setup-wo-the-repository-v1-7-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

Stop using `the_repository` in `verify_non_filename()` and instead
accept the repository as a parameter. The injection of `the_repository`
is thus bumped one level higher, where callers now pass it in
explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/checkout.c | 2 +-
 builtin/grep.c     | 2 +-
 builtin/reset.c    | 2 +-
 revision.c         | 4 ++--
 setup.c            | 4 ++--
 setup.h            | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e031e61886..d7069765e7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1485,7 +1485,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 * it would be extremely annoying.
 		 */
 		if (argc)
-			verify_non_filename(opts->prefix, arg);
+			verify_non_filename(the_repository, opts->prefix, arg);
 	} else if (opts->accept_pathspec) {
 		argcount++;
 		argv++;
diff --git a/builtin/grep.c b/builtin/grep.c
index b0e350cf89..4ec0c016b1 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1151,7 +1151,7 @@ int cmd_grep(int argc,
 
 		object = parse_object_or_die(the_repository, &oid, arg);
 		if (!seen_dashdash)
-			verify_non_filename(prefix, arg);
+			verify_non_filename(the_repository, prefix, arg);
 		add_object_array_with_path(object, arg, &list, oc.mode, oc.path);
 		object_context_release(&oc);
 	}
diff --git a/builtin/reset.c b/builtin/reset.c
index 1ac374d31b..11f57605b5 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -281,7 +281,7 @@ static void parse_args(struct pathspec *pathspec,
 			 * Ok, argv[0] looks like a commit/tree; it should not
 			 * be a filename.
 			 */
-			verify_non_filename(prefix, argv[0]);
+			verify_non_filename(the_repository, prefix, argv[0]);
 			rev = *argv++;
 		} else {
 			/* Otherwise we treat this as a filename */
diff --git a/revision.c b/revision.c
index 57cf00ae6b..9071a38b85 100644
--- a/revision.c
+++ b/revision.c
@@ -2082,7 +2082,7 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 
 	if (!cant_be_filename) {
 		*dotdot = '.';
-		verify_non_filename(revs->prefix, arg);
+		verify_non_filename(the_repository, revs->prefix, arg);
 		*dotdot = '\0';
 	}
 
@@ -2227,7 +2227,7 @@ static int handle_revision_arg_1(const char *arg_, struct rev_info *revs, int fl
 		goto out;
 	}
 	if (!cant_be_filename)
-		verify_non_filename(revs->prefix, arg);
+		verify_non_filename(the_repository, revs->prefix, arg);
 	object = get_reference(revs, arg, &oid, flags ^ local_flags);
 	if (!object) {
 		ret = (revs->ignore_missing || revs->do_not_die_on_missing_objects) ? 0 : -1;
diff --git a/setup.c b/setup.c
index 736f950bd0..c6b5b85f3a 100644
--- a/setup.c
+++ b/setup.c
@@ -297,9 +297,9 @@ void verify_filename(struct repository *repo,
  * and we parsed the arg as a refname.  It should not be interpretable
  * as a filename.
  */
-void verify_non_filename(const char *prefix, const char *arg)
+void verify_non_filename(struct repository *repo, const char *prefix, const char *arg)
 {
-	if (!is_inside_work_tree(the_repository) || is_inside_git_dir(the_repository))
+	if (!is_inside_work_tree(repo) || is_inside_git_dir(repo))
 		return;
 	if (*arg == '-')
 		return; /* flag */
diff --git a/setup.h b/setup.h
index 24a6f66629..364c2c728a 100644
--- a/setup.h
+++ b/setup.h
@@ -146,7 +146,7 @@ void verify_filename(struct repository *repo,
 		     const char *prefix,
 		     const char *name,
 		     int diagnose_misspelt_rev);
-void verify_non_filename(const char *prefix, const char *name);
+void verify_non_filename(struct repository *repo, const char *prefix, const char *name);
 int path_inside_repo(struct repository *repo, const char *prefix, const char *path);
 
 void sanitize_stdfds(void);

-- 
2.53.0.1185.g05d4b7b318.dirty

