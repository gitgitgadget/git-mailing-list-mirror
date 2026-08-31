Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD573D9DDF
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170541; cv=none; b=WVAy8LzsX+MnkHFRA7rjYVA3W5kzHVg3/TFO9JZZg9h5E1m9fTlwGobGzmPZWMJzDi+svBCnHn/fkhdL43z/tlxoQtZ9o0dJIgxbpMzdG3YitlXBRrvX/HtkQAUSC093hKacAeWtGRdqb9D+5ijoH8fdWjYk53hPK9d/wEkTe28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170541; c=relaxed/simple;
	bh=oJvzmcM6Fib8vwmfNoB6lKz67fUHfVNQ7MHLRaWDsOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=udhAsrsY3qCKzCLytaMn6E6G0tLttgTlh58+bkJ41JYxaJNWCcGvhf3VXI7yMk5/8lOOf60kChIlr5P0aaMfeNyWibMIS5emIooyuyygezHYStLVw+ZyyVQYvLmx7N5sI4U/JaIMqqZT8Dle83SBjr6t+ZHimWZ04FGMH66m2Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=caIp6sso; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hr5emNuP; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="caIp6sso";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hr5emNuP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 54B101D00131;
	Mon, 31 Aug 2026 06:02:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 31 Aug 2026 06:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788170539;
	 x=1788256939; bh=TgFZd3uiEcl9TvkuXyNnKNK+icPZoeg2T7H5tTfP088=; b=
	caIp6ssoTPjNDRVH+rohmzB9iNQDSXwAehi57XmUWHw+E3S4h64U5xhtU3p+1U/S
	EhMgWxiESSMI0kC2VD+H1K9C//SOUmeomKpqmv1UrEyl2wXjbLgRxBzJTDlvZk/O
	6cmpHzvYPQy6u+1NHMhvXeHAwnxRAdguXsC10/NCadt6WdZH7yAbJ/MbLvXHFsrY
	ocuLgaRNRAScO9pIf3XA9q3BJjRkJB+VOeR+/iqt2i/QpzcvmRWPEaUiL3yidBo8
	0lQTp62R1yLvcto+pj9mBx9q0xTu/VfpcpNApU7W66Ge+gSWAwSKDxb6XNwemxz7
	2DRJaTilWmw+7qc0AkDJMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788170539; x=
	1788256939; bh=TgFZd3uiEcl9TvkuXyNnKNK+icPZoeg2T7H5tTfP088=; b=h
	r5emNuPeoCwqBGzYhc+WI+SCQMYgXHZhw1uaGI8RbxIsVvmO3ioWu4Xnpanuv4qm
	JDISUiED+QM2SxBdfKKH5nUjq3mX1JcttfEI9xzPtg6zZRhzJhBCSimDPPPKvG/s
	zuPP+d7lSkGHLCxrczFCkkEpJDhOOQMKBsptLKdN3jThYM14gHisr3AbbKXbD9Da
	15XkJnQoO6y7tCU0H+bPkqmcfDM36/EujOsK5EvA2a7g0kIgxC/TH4FmLG0ov5CZ
	rA1jcgxwPA9xK92sKlDFbRSpSxnDavaMcTNmIud7C143G1Nl0R0YYreOI+j+1lDD
	ueAt7aRe+MVbex7pvBG8A==
X-ME-Sender: <xms:K1GValboyjHF8PM-ueGEQL1b4mjPIulljNRQTQU2MxxAR0j-Mlk2bA>
    <xme:K1GVaj0oPPVSjMt-2HNbUOmnMoJ1i-VOHyb6K4lcdcVHJpKrqtzs0Uo10GlVuGH2L
    U0G6HLKCL7TNBGnomsAj1UAhODxDD67b0pd3D9VtDJ4ZCA5n0FVTw>
X-ME-Received: <xmr:K1GValX4fakph63CkKzNSftou0O47iZNsJaxQcNlCzsR-qu3e4NXQNI3oUVwDI14Iq6ETA>
X-ME-Proxy-Cause: dmFkZTGHUA7KqT16GbV2AYtUMBXxZvbu0kHMHaGO2coG/xVALTL8GSgyyIm6N4JdTXGfGp
    fZgPoMuN16ezFPjkmTXw3ziS2HXJgeJN2u7RxLp4/LgPv5xacW5PfCcKnb5b4BL205mE+I
    LPzc7ig+H/7vlqOlBDYFsxEqoSVhsqlhJXzerLQAQubOaj+1f4HSzWEz4Wp3WhiIFLKi8v
    jJ/q9MY7B2IaedZpcYmNkRiuikA0csHZ7Dh/n05pQ0EdCKVmkWbFPiTuI2XkI6P0vvpmyU
    k8dQQ2PDEWJ6sYY8TYIz6BCO8Q6LquTNE350JkEmKCAN/krpBthd+MbEaRYqTa3EANbHHw
    eDbIBeOq5Mbma1aNt8gxdQneEQZ9PWJiZ8KISEldqt5LXjxt4Eph4gpoIBVWd9D/r+378d
    UrzNF7jb7MoGjgN0HDYPt4VqKcK+vVyer4WjVi5DN0P2RXi5SY3U8UXWHYB1z4diYfQoJp
    e9o1DUpJyDl3P6nXUQnuqKcod0/3XeHZFmavGklgHIMfjCum5wt5nh1EwC7oaKP0BvjqQn
    /iaqydJ5Z7X3PfZ+3JBhwtm24qzN6seaD45PbNIGn54ZjB7+aUmAXAcGHOzQIeXMZTaLJk
    SkIYPCo+hg/WBzrNoQbPj0Q9c1JXFAxTC0sGorrdhR047XSRHKjVRP9UpdjA
X-ME-Proxy: <xmx:K1GVatWd5eRgv-OjO9lCaN-h-yIsOiys9q80KGS00rMGb7eapRP-BA>
    <xmx:K1GVakcNT2L_hmoc54n3JcvWHYkVtOzs9zJdeSTin8Kj8hCqGQ1Jmg>
    <xmx:K1GVamXym7scckmQ3CkQsRXA6P8jyNUppJoLNBX9DBZZQmGv52GdZw>
    <xmx:K1GVatf8G3a5HQty3DqfnOr4mqgjVToHufQgkzTcU4YcVaEp7Y-sVQ>
    <xmx:K1GVagcEr0yj4EQI5szogkNN4Kj5u6TUiWVab1DL4RUlqCU3i3rayRp5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 06:02:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e6e5b7c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 10:02:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Aug 2026 12:02:05 +0200
Subject: [PATCH v2 1/8] builtin/clone: defer setup of the object database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-pks-odb-write-alternates-at-creation-time-v2-1-aecd2382ba1c@pks.im>
References: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
In-Reply-To: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When cloning a repository we defer initialization of the reference
database. This is because we don't yet know all details required for us
to initialize the refdb in the first place. Most importantly, what we
are missing is information about the object hash.

We don't do the same thing for the object database yet, but here we
essentially have the same problem. While the "files" database does not
need any information about the object format at creation time, alternate
backends are likely to require that information so that they can
properly set up their data structures.

Besides this forward-looking future proofing though, we also have a
second use case for deferring initialization of the object database,
namely alternates. When initializing the object database we do not yet
know whether we'll need alternates or not because this depends on the
repository we're about to clone from. If it is a local repository and
the user has passed "--refernce{,-if-able}", then we will end up writing
alternates into the object database.

The ugly part though is that we cannot determine where the repository is
getting cloned from before it has been initialized. While we of course
already have access to the user-provided URI, that URI can be very well
rewritten via "url.<base>.insteadOf". We can of course read the global-
and system-level configuration to resolve it. But we explicitly resolve
the URI a second time after we have initialized the repository because
it can happen that we copy a ".git/config" over from our templates, and
that file may cause us to rewrite the path.

In a subsequent commit though we'll start to write alternates as part of
the repository initialization, so we'll need to have the URI properly
resolved before we can initialize the object database. This is ugly, but
as mentioned above it makes sense for us to defer its initialization
anyway so that we also know about the object hash already.

Introduce a new flag that makes `init_db()` skip initializing the object
database. Expose `create_object_database()` and make use of it after we
have resolved the URI.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 12 ++++++++----
 setup.c         |  8 +++++---
 setup.h         | 15 ++++++++++-----
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5b25cca510..0a67492ebd 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1184,11 +1184,14 @@ int cmd_clone(int argc,
 	 * database. We do not yet know about the object format of the
 	 * repository, and reference backends may persist that information into
 	 * their on-disk data structures.
+	 *
+	 * Furthermore, we skip initializing the object database so that we can
+	 * first resolve potential alternates before creating it.
 	 */
 	init_db(the_repository, git_dir, real_git_dir, work_tree, option_template,
 		GIT_HASH_UNKNOWN, ref_storage_format, NULL,
 		do_not_override_repo_unix_permissions,
-		INIT_DB_QUIET | INIT_DB_SKIP_REFDB);
+		INIT_DB_QUIET | INIT_DB_SKIP_REFDB | INIT_DB_SKIP_ODB);
 
 	if (real_git_dir) {
 		free((char *)git_dir);
@@ -1311,9 +1314,6 @@ int cmd_clone(int argc,
 		strbuf_reset(&key);
 	}
 
-	if (option_required_reference.nr || option_optional_reference.nr)
-		setup_reference();
-
 	remote = remote_get_early(remote_name);
 
 	if (!option_rev)
@@ -1342,6 +1342,10 @@ int cmd_clone(int argc,
 	if (option_local > 0 && !is_local)
 		warning(_("--local is ignored"));
 
+	create_object_database(the_repository);
+	if (option_required_reference.nr || option_optional_reference.nr)
+		setup_reference();
+
 	transport = transport_get(remote, path ? path : remote->url.v[0]);
 	transport_set_verbosity(transport, option_verbosity, option_progress);
 	transport->family = family;
diff --git a/setup.c b/setup.c
index d90654f584..e654e27d05 100644
--- a/setup.c
+++ b/setup.c
@@ -2647,7 +2647,7 @@ static int create_default_files(struct repository *repo,
 	return reinit;
 }
 
-static void create_object_database(struct repository *repo)
+void create_object_database(struct repository *repo)
 {
 	/*
 	 * Create the "objects" directory in the common directory. This is done
@@ -2829,7 +2829,8 @@ int init_db(struct repository *repo,
 	    const char *template_dir, int hash,
 	    enum ref_storage_format ref_storage_format,
 	    const char *initial_branch,
-	    int init_shared_repository, unsigned int flags)
+	    int init_shared_repository,
+	    enum init_db_flags flags)
 {
 	int reinit;
 	int exist_ok = flags & INIT_DB_EXIST_OK;
@@ -2903,7 +2904,8 @@ int init_db(struct repository *repo,
 
 	if (!(flags & INIT_DB_SKIP_REFDB))
 		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
-	create_object_database(repo);
+	if (!(flags & INIT_DB_SKIP_ODB))
+		create_object_database(repo);
 
 	startup_info->have_repository = 1;
 
diff --git a/setup.h b/setup.h
index 763fd384e8..570ebcd150 100644
--- a/setup.h
+++ b/setup.h
@@ -256,9 +256,12 @@ int apply_repository_format(struct repository *repo,
 
 const char *get_template_dir(const char *option_template);
 
-#define INIT_DB_QUIET      (1 << 0)
-#define INIT_DB_EXIST_OK   (1 << 1)
-#define INIT_DB_SKIP_REFDB (1 << 2)
+enum init_db_flags {
+	INIT_DB_QUIET = (1 << 0),
+	INIT_DB_EXIST_OK = (1 << 1),
+	INIT_DB_SKIP_REFDB = (1 << 2),
+	INIT_DB_SKIP_ODB = (1 << 3),
+};
 
 int init_db(struct repository *repo,
 	    const char *git_dir,
@@ -266,13 +269,15 @@ int init_db(struct repository *repo,
 	    const char *worktree,
 	    const char *template_dir, int hash_algo,
 	    enum ref_storage_format ref_storage_format,
-	    const char *initial_branch, int init_shared_repository,
-	    unsigned int flags);
+	    const char *initial_branch,
+	    int init_shared_repository,
+	    enum init_db_flags flags);
 void initialize_repository_version(struct repository *repo,
 				   int hash_algo,
 				   enum ref_storage_format ref_storage_format,
 				   int reinit);
 void create_reference_database(struct repository *repo, const char *initial_branch, int quiet);
+void create_object_database(struct repository *repo);
 
 /*
  * NOTE NOTE NOTE!!

-- 
2.55.0.979.g7e5102b832.dirty

