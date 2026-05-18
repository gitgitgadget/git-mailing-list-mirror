Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021093E63B0
	for <git@vger.kernel.org>; Mon, 18 May 2026 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096712; cv=none; b=LZc/fx2Qrl2XHS6xMPLeTGJs1JEmsS1rw0WH1A5ijyTK7zNe6F1hqNn3u/X5B0vxADCRQe5GhJhuMgqCsS+MI0tIEcd02/lzeACbGaVjeiWqxMyocpGS96jdVwVjqyuEabe7rPYI9P7HVNTx+6OEaSWcHQZoyU7vAxC6zk1bju0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096712; c=relaxed/simple;
	bh=V6melUA8Xgu9vv7zBDnFDZsuX8NEzYdzygn0Gbcc38M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhBEW49Jo3oxQTVb2pHzfEsB1banooTCpCvqQLPDLviZ8Z2nOAehB+mhaIECrhzNMH7x3oZyh+f8ea2IjCF+jk1QB0TJIumacxj1w/Cdxk4/uZuwBar27yZuIuFhNdZKCouKAPz8OP0l/pcRSCwWNAyS4m89sf8EcoC9vIhHY2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LGNITxKs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eYwiRm1o; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LGNITxKs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eYwiRm1o"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 354F51D00061;
	Mon, 18 May 2026 05:31:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 18 May 2026 05:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779096710;
	 x=1779183110; bh=CzZF3rBuls+PdgzEpm3XYJ9PP7rCpkTafYAJQ5SlKQA=; b=
	LGNITxKsSwuUbutgPZeWU2AtpTggW9XQgoez1WpkULpkXJlKs1ZGD5LF6Pcoiq0m
	FioiJd7Wb8n7dPAqrNdF4ov/UFK1xZqbfq1VMoF8ZXxRXJDmXLuiBI7ttoGPEFQA
	DLYCSzQB6PSrlOgyGr4hm5pGaBC9WBPApHn0SugiICa+5NB1W3zcLTBKq6tTf4b5
	e4XC8ow+jidvf0hkwH6xGdbPcu99zKadkH1bffj3NWxtLVRifmb++GcCr+dl6qUi
	vIjmmBBF0JTVA6tJvHFh1fSAi7vj8CAd0brY2JcrD+V7gjB0YG4ozgJxrF1RS2yU
	kwCKIAoZDv61BbIPUDw3eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779096710; x=
	1779183110; bh=CzZF3rBuls+PdgzEpm3XYJ9PP7rCpkTafYAJQ5SlKQA=; b=e
	YwiRm1op2fL+olxBpn19pwuv5CqWX7H66QvHZW/8OxyvolvPmw78UAsSu7rViBzo
	L9hCXkDx6HhcgLBO5l0jpoqZU+ajjFxfGNftKB2zPIY8Tp57IuiGdBevJ8zgtB3X
	CkCJJABOK/0ReICTl27ORYalXlbJn5eAm2Ev+w0Gojt6/TKnc0WDZ08SNEiFiS2C
	hFn3WdnupgB7m/FhpdoKbuVB76fCRmq1n0DzAaA8+jnbpeWYVHVmRHbkLobCAo9K
	ko0sgGizlQA/nazNc2hnwg0knRjvNur66REv8c8jyZ3x8lAZ3Jnphq5J3v59lrcm
	K/KURkeqAGKYtlV/7am/A==
X-ME-Sender: <xms:htwKaortjijcd6Jbagzji1F2RryvhAGSOKIiMeOSv9gYs1nPyEuBgA>
    <xme:htwKalgGqnALNryR9IX_j92Z1UyrU8cAqslIfc4wY_U_1A6Q6lgGLQDZWWrIG45zN
    dKOOXXlSngc1J35Xf4XGNbYcWauCqjmjttMXcMeNXURGOrEXYTQ_A>
X-ME-Received: <xmr:htwKalhWSoYJjBoHrJfmr9ryxzWtlIu1StNuPhgDuBNsXFEIB8IYZ-Q1wFN8SX_uDliA9sFpSxGJFTT5QtX1OeolaR_pKXJJUYhLAaB23g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegtrghtsehmrghlohhnrdguvghvpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:htwKarj9-mUYuqWbXKW6LBSJAZIU9JgdMV2NqL1kxyFH_OKFB3OkXg>
    <xmx:htwKalIUh5a1rsm54dHQnyid46y_j8X1QBHlCqlPFFvsY7j8lxoPtg>
    <xmx:htwKaqGsWU8J574bkuKvZPZRf7wFAUyNYsUzFJOKC-c7E_oEjEwwAQ>
    <xmx:htwKapRu7HIyxcpHkR0YqXrvNlbfpkQJ5RCnu97nMoXJYiP1DP5aaQ>
    <xmx:htwKaowdeQM4Z5OehqT_N97G0B2-O5VkcbrEAB-sFVQcJm4eQfXY4bz3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 05:31:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 85a0307d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 May 2026 09:31:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 18 May 2026 11:31:08 +0200
Subject: [PATCH v2 17/18] setup: stop using `the_repository` in
 `create_reference_database()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-pks-setup-wo-the-repository-v2-17-6933c0f1d568@pks.im>
References: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
In-Reply-To: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

Stop using `the_repository` in `create_reference_database()` and instead
accept the repository as a parameter. The injection of `the_repository`
is thus bumped one level higher, where callers now pass it in
explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c |  2 +-
 setup.c         | 13 +++++++------
 setup.h         |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 24fe0eead5..53a41629e6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1444,7 +1444,7 @@ int cmd_clone(int argc,
 	hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 	initialize_repository_version(the_repository, hash_algo, the_repository->ref_storage_format, 1);
 	repo_set_hash_algo(the_repository, hash_algo);
-	create_reference_database(NULL, 1);
+	create_reference_database(the_repository, NULL, 1);
 
 	/*
 	 * Before fetching from the remote, download and install bundle
diff --git a/setup.c b/setup.c
index e09483ba34..9c49319568 100644
--- a/setup.c
+++ b/setup.c
@@ -2468,13 +2468,14 @@ static int is_reinit(struct repository *repo)
 	return ret;
 }
 
-void create_reference_database(const char *initial_branch, int quiet)
+void create_reference_database(struct repository *repo,
+			       const char *initial_branch, int quiet)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *to_free = NULL;
-	int reinit = is_reinit(the_repository);
+	int reinit = is_reinit(repo);
 
-	if (ref_store_create_on_disk(get_main_ref_store(the_repository), 0, &err))
+	if (ref_store_create_on_disk(get_main_ref_store(repo), 0, &err))
 		die("failed to set up refs db: %s", err.buf);
 
 	/*
@@ -2486,14 +2487,14 @@ void create_reference_database(const char *initial_branch, int quiet)
 
 		if (!initial_branch)
 			initial_branch = to_free =
-				repo_default_branch_name(the_repository, quiet);
+				repo_default_branch_name(repo, quiet);
 
 		ref = xstrfmt("refs/heads/%s", initial_branch);
 		if (check_refname_format(ref, 0) < 0)
 			die(_("invalid initial branch name: '%s'"),
 			    initial_branch);
 
-		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", ref, NULL) < 0)
+		if (refs_update_symref(get_main_ref_store(repo), "HEAD", ref, NULL) < 0)
 			exit(1);
 		free(ref);
 	}
@@ -2830,7 +2831,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 				      &repo_fmt, init_shared_repository);
 
 	if (!(flags & INIT_DB_SKIP_REFDB))
-		create_reference_database(initial_branch, flags & INIT_DB_QUIET);
+		create_reference_database(the_repository, initial_branch, flags & INIT_DB_QUIET);
 	create_object_directory(the_repository);
 
 	if (repo_settings_get_shared_repository(the_repository)) {
diff --git a/setup.h b/setup.h
index c33b675ccf..21737e9bd6 100644
--- a/setup.h
+++ b/setup.h
@@ -236,7 +236,7 @@ void initialize_repository_version(struct repository *repo,
 				   int hash_algo,
 				   enum ref_storage_format ref_storage_format,
 				   int reinit);
-void create_reference_database(const char *initial_branch, int quiet);
+void create_reference_database(struct repository *repo, const char *initial_branch, int quiet);
 
 /*
  * NOTE NOTE NOTE!!

-- 
2.54.0.771.g3ed373ac14.dirty

