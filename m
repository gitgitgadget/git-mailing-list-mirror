Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FAC2038C3
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905869; cv=none; b=tNapwlne0nqF/RZcaOyaHEkdjuWCI0f9cwdctmFFHHXm/QHCXrrEG4aYr6qa03zbpI4ZtWEnF+ED0/ifErxv82YrXSlzeKhYIS6iTIFdQ3+a/s/CvveW0zCOeIsOVR8nIZyxMaaYyDpn8bywghePDOjLV4DAmAGzfXDkDXPYkJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905869; c=relaxed/simple;
	bh=E1RIfDxELfRaW5FB9hwOr7f5JDCn6Gqdt1aIGLt5qtc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nt/QRQa6saTtblPKEeyP1cIUYJ+CkFiWCctHBDqGLXRym89duqLxklL7RbKERbQWHYbT1HvQ24Dh7mTCw+16+WiZW4KSBHPpvZ/GxzWYyneMUS22F/o9Ha1j5DO3v94qjvgRQ5RPTdR7ni70mBzqnCmjdBHkKIpHDhHF94y6aig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=0j8HHFgd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OfXI3fYk; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="0j8HHFgd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OfXI3fYk"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6EB92114016A
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:11:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 06 Nov 2024 10:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905866; x=1730992266; bh=pTDghMoMNV
	n0seo0uEBnuaJXSvPHUz3m7O6p4IiSQXQ=; b=0j8HHFgdZtTPTWjK3MMRY++HXm
	jlDB8vk5GrVNliXA5x8EFrZcUuY0y8zljw5zni/2Pwn/ji0co9LkW7C6xwx28Ye4
	LtJPetfQusVx7+YDaXueEcah5nrq//9Tfs87GyhKc7oPHnj14EeKABogITFLtSwC
	wCmCHCbVJBdrss5qSmU3SjhbAJaTbkCkW43Qh0Zg9siYtk/tl4nc8sBwAf15Y17U
	FXiV86BOwFlPYtGn4bTj8kF/HqnE2N2xM+Cl1wFr9xRi/xikQwUtln8CXoo1NviW
	Kfd8Pw8cAfGaTPJvX33svkKXP4sSSbbaxT0CN/JxslOjkF0gS5aCwEWgj0sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905866; x=1730992266; bh=pTDghMoMNVn0seo0uEBnuaJXSvPHUz3m7O6
	p4IiSQXQ=; b=OfXI3fYkLXg40b946rTsbCPB+42yAqO8+9Qk5ZRX7EYsDZhj1or
	Y/uuI2egc8yB2QSrvs5jMIkwRcwhfWUFt3fOR+bsG9FDQvnKV8hVV1MtYi5Q6jDX
	XjjsHBBy88p+DLfq22SRM3ehH9rf6FV2HoIuI9PhCqdMRHTGKfp93aukyHujnuXH
	0V+pwDqZs2eJLDVsWtzYUWV4+geAbMyjZsEjizq6+AE+D7E41V3t8Abr4QEe/ta7
	fJymDYktKlk2fp3Iy4Fqcmos7bh/5VGmuw1udNIJslD8mvitYKaHsff5TxF/ybuz
	cbvIqwc+Qmgl9UDAcki5o+vf81SfooKCdIA==
X-ME-Sender: <xms:CocrZ_t0PnmfRJg56Rz9XdVZqf7IKK0MXjWepG8OTK-jmN06NN-TQQ>
    <xme:CocrZwdtC4Z8q-VA8YhET2YASxZXpnd3hDKOsyyACX25hWrtSegxZRCAC8wtD1jl9
    PY0lHzXf0agNhMVPQ>
X-ME-Received: <xmr:CocrZywOpuLZkARs9uvF3ri4GKU7JFcfYRJNQUFlXYwjqPxqfCUm_tOgXqnotBB68-xRbvlT1qFPs0px9uNWhrO90X3sidkXDCUarTK5NTOpNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CocrZ-P84i6KQncK9npBZ3JDVlQPhKdrmZ3A3TJdMvveXZzVIZ_uFA>
    <xmx:CocrZ_9iYR31lsDIcrvpkMOwvs3hsQLOBczWIZUm0LRy8QBVbJk82Q>
    <xmx:CocrZ-XcYufdxE7t7FJAGY5mvDrpnlv5Id4UQHFofuK3ydeslHsN0w>
    <xmx:CocrZwddRwOhr5Vaq9pTFViuHZ9GHyOt3wUY2BpnrynbCc5lkTbNpg>
    <xmx:CocrZ5mheavc4p5F1rwu34N1loPUhMwqmLPYjO9tfVBeLq7mqBb4TknQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:11:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f5b4564b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:10:40 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:10:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 13/26] builtin/sparse-checkout: fix leaking sanitized patterns
Message-ID: <712613c10ac2bb5d3588b03aa3b0fcd01350e865.1730901926.git.ps@pks.im>
References: <cover.1730901926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730901926.git.ps@pks.im>

Both `git sparse-checkout add` and `git sparse-checkout set` accept a
list of additional directories or patterns. These get massaged via calls
to `sanitize_paths()`, which may end up modifying the passed-in array by
updating its pointers to be prefixed paths. This allocates memory that
we never free.

Refactor the code to instead use a `struct strvec`, which makes it way
easier for us to track the lifetime correctly. The couple of extra
memory allocations likely do not matter as we only ever populate it with
command line arguments.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/sparse-checkout.c | 61 +++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 49aedc1de81..698d93a9ec5 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -669,7 +669,7 @@ static void add_patterns_literal(int argc, const char **argv,
 	add_patterns_from_input(pl, argc, argv, use_stdin ? stdin : NULL);
 }
 
-static int modify_pattern_list(int argc, const char **argv, int use_stdin,
+static int modify_pattern_list(struct strvec *args, int use_stdin,
 			       enum modify_type m)
 {
 	int result;
@@ -679,13 +679,13 @@ static int modify_pattern_list(int argc, const char **argv, int use_stdin,
 	switch (m) {
 	case ADD:
 		if (core_sparse_checkout_cone)
-			add_patterns_cone_mode(argc, argv, pl, use_stdin);
+			add_patterns_cone_mode(args->nr, args->v, pl, use_stdin);
 		else
-			add_patterns_literal(argc, argv, pl, use_stdin);
+			add_patterns_literal(args->nr, args->v, pl, use_stdin);
 		break;
 
 	case REPLACE:
-		add_patterns_from_input(pl, argc, argv,
+		add_patterns_from_input(pl, args->nr, args->v,
 					use_stdin ? stdin : NULL);
 		break;
 	}
@@ -706,12 +706,12 @@ static int modify_pattern_list(int argc, const char **argv, int use_stdin,
 	return result;
 }
 
-static void sanitize_paths(int argc, const char **argv,
+static void sanitize_paths(struct strvec *args,
 			   const char *prefix, int skip_checks)
 {
 	int i;
 
-	if (!argc)
+	if (!args->nr)
 		return;
 
 	if (prefix && *prefix && core_sparse_checkout_cone) {
@@ -721,8 +721,11 @@ static void sanitize_paths(int argc, const char **argv,
 		 */
 		int prefix_len = strlen(prefix);
 
-		for (i = 0; i < argc; i++)
-			argv[i] = prefix_path(prefix, prefix_len, argv[i]);
+		for (i = 0; i < args->nr; i++) {
+			char *prefixed_path = prefix_path(prefix, prefix_len, args->v[i]);
+			strvec_replace(args, i, prefixed_path);
+			free(prefixed_path);
+		}
 	}
 
 	if (skip_checks)
@@ -732,20 +735,20 @@ static void sanitize_paths(int argc, const char **argv,
 		die(_("please run from the toplevel directory in non-cone mode"));
 
 	if (core_sparse_checkout_cone) {
-		for (i = 0; i < argc; i++) {
-			if (argv[i][0] == '/')
+		for (i = 0; i < args->nr; i++) {
+			if (args->v[i][0] == '/')
 				die(_("specify directories rather than patterns (no leading slash)"));
-			if (argv[i][0] == '!')
+			if (args->v[i][0] == '!')
 				die(_("specify directories rather than patterns.  If your directory starts with a '!', pass --skip-checks"));
-			if (strpbrk(argv[i], "*?[]"))
+			if (strpbrk(args->v[i], "*?[]"))
 				die(_("specify directories rather than patterns.  If your directory really has any of '*?[]\\' in it, pass --skip-checks"));
 		}
 	}
 
-	for (i = 0; i < argc; i++) {
+	for (i = 0; i < args->nr; i++) {
 		struct cache_entry *ce;
 		struct index_state *index = the_repository->index;
-		int pos = index_name_pos(index, argv[i], strlen(argv[i]));
+		int pos = index_name_pos(index, args->v[i], strlen(args->v[i]));
 
 		if (pos < 0)
 			continue;
@@ -754,9 +757,9 @@ static void sanitize_paths(int argc, const char **argv,
 			continue;
 
 		if (core_sparse_checkout_cone)
-			die(_("'%s' is not a directory; to treat it as a directory anyway, rerun with --skip-checks"), argv[i]);
+			die(_("'%s' is not a directory; to treat it as a directory anyway, rerun with --skip-checks"), args->v[i]);
 		else
-			warning(_("pass a leading slash before paths such as '%s' if you want a single file (see NON-CONE PROBLEMS in the git-sparse-checkout manual)."), argv[i]);
+			warning(_("pass a leading slash before paths such as '%s' if you want a single file (see NON-CONE PROBLEMS in the git-sparse-checkout manual)."), args->v[i]);
 	}
 }
 
@@ -780,6 +783,8 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
 			 N_("read patterns from standard in")),
 		OPT_END(),
 	};
+	struct strvec patterns = STRVEC_INIT;
+	int ret;
 
 	setup_work_tree();
 	if (!core_apply_sparse_checkout)
@@ -791,9 +796,14 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
 			     builtin_sparse_checkout_add_options,
 			     builtin_sparse_checkout_add_usage, 0);
 
-	sanitize_paths(argc, argv, prefix, add_opts.skip_checks);
+	for (int i = 0; i < argc; i++)
+		strvec_push(&patterns, argv[i]);
+	sanitize_paths(&patterns, prefix, add_opts.skip_checks);
 
-	return modify_pattern_list(argc, argv, add_opts.use_stdin, ADD);
+	ret = modify_pattern_list(&patterns, add_opts.use_stdin, ADD);
+
+	strvec_clear(&patterns);
+	return ret;
 }
 
 static char const * const builtin_sparse_checkout_set_usage[] = {
@@ -826,6 +836,8 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 			   PARSE_OPT_NONEG),
 		OPT_END(),
 	};
+	struct strvec patterns = STRVEC_INIT;
+	int ret;
 
 	setup_work_tree();
 	repo_read_index(the_repository);
@@ -846,13 +858,18 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 	 * top-level directory (much as 'init' would do).
 	 */
 	if (!core_sparse_checkout_cone && !set_opts.use_stdin && argc == 0) {
-		argv = default_patterns;
-		argc = default_patterns_nr;
+		for (int i = 0; i < default_patterns_nr; i++)
+			strvec_push(&patterns, default_patterns[i]);
 	} else {
-		sanitize_paths(argc, argv, prefix, set_opts.skip_checks);
+		for (int i = 0; i < argc; i++)
+			strvec_push(&patterns, argv[i]);
+		sanitize_paths(&patterns, prefix, set_opts.skip_checks);
 	}
 
-	return modify_pattern_list(argc, argv, set_opts.use_stdin, REPLACE);
+	ret = modify_pattern_list(&patterns, set_opts.use_stdin, REPLACE);
+
+	strvec_clear(&patterns);
+	return ret;
 }
 
 static char const * const builtin_sparse_checkout_reapply_usage[] = {
-- 
2.47.0.229.g8f8d6eee53.dirty

