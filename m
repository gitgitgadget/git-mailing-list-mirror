Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC333E556D
	for <git@vger.kernel.org>; Mon, 18 May 2026 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096707; cv=none; b=P5pzbphZ8WjYXhyPC74wvUxJFhPonRvTg0hMyrHRWRreJVYF3IST7bCHXNIyBgn5KRIsqQDT/UrRI8OlaUwJmcKuHQAyQAHc4VJtNzAz5xJDzFLtWX9aKOaGo+Byzzn0NCVMhY5P6mSl9KJjUXOXouaM5PaPTp8ZXDDW7XZyIOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096707; c=relaxed/simple;
	bh=gIexqYvS5Z+p63Psi3E+MkEYUuAqAvi3jFkpux5JaKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ShLS/HtivN5HbzYIWROsmQPrgh7lZ5C1Ted3ElAPRBqr5juqdajOTlM1WJz6FILgNXheL8f6r5+wJUbxCWSY4vv2tvqeKHDuGEEbyHPeGwsZFHOvkg80zoKjDwAaZyBO0xWIqxr3iulHkWryDbGaVxjIzdf4OoJ8dzsTJ2/I8R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UnhKHNyw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YhSwaFpY; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UnhKHNyw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YhSwaFpY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 27C851D0007A;
	Mon, 18 May 2026 05:31:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 18 May 2026 05:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779096705;
	 x=1779183105; bh=Zxz0a2PPZDX277oAHkKobOxAuGeJaXm2q4lh8nI7ttk=; b=
	UnhKHNywceDmBNpO80ME/34DwPeP8n2vzrJEsrxVc3ipw56bniTuEIIy6+eZqQL/
	yHtiwN83HLzIGP92emqDsxxwZZVtdJd0vuFKAl4m/w/E9Rko4HGe6gO7ir4MPtSQ
	JRCwIJ1wCEyf90XcgaGJc0aKI6nNkQN2uT0wBuoZNGg3heNUl0+qn61PlMPHBJxI
	Zjof95aZtxR5XlP66q6ERWi1TUviduaFRBs2IrWClmXEFGlaviVtUPW8s41Wh46q
	vZ0Z3C/5uC7MnoRoBmwnfCx2s4+1xOyveWHUF0Av33a/SijuFPpUQKWFuTFJZNnI
	acWqLRwX1hDoB6FE5VJ8Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779096705; x=
	1779183105; bh=Zxz0a2PPZDX277oAHkKobOxAuGeJaXm2q4lh8nI7ttk=; b=Y
	hSwaFpYQYRpWIGK8wRKkVq70NmEJ0yRMIr3SZkJOjkuvqZAHXEd6BcgY7AdNj0b6
	S42hzdcnQpalajJ+AiRuoBIHHdHV6H7OcwsL4c6VBMOYQPnMh0UbuFMyqu4ykklJ
	hDRknqWDp7rCAcVWhf5dEEXCIc0Cm138485OyKyzeVu+NtBtAhSdFm6z9lJ5DLmQ
	9/X4SptEhpcmBwLDZU2q4W4xVq29FOm+3TWeqNqz+EHsUz9x7JDanaFVbiuEHBvq
	2mBgjQHqe/Z42uVZgFrK76FDrJtHaBEKefDhOY20Ahww0YSnW1IUrNIkIsFHCX31
	2+yq5lotySLNPbOaX3yWw==
X-ME-Sender: <xms:gNwKapKXWtkV2LtqoCqox47-wKQ1ceHErgw6M3qgVEyhceRcFFfurw>
    <xme:gNwKasCbhGGlhRKE2NNe3Rwie8CQO2VKZSWTeqCwCzkNMbx28cqhFfJ-3uZQa5rqq
    HReT95lmJ6y4wwoEWlOdhDmaa9G7ECyKklaNEQBKUfCV-GNnYJHats>
X-ME-Received: <xmr:gNwKaqBjd2EHafjshFbgv456AuPztV8mNeOJDcak5SF3g3TJN4rB-PyANJ3nY3zlNdh8aklFj3awWecIBPs8a6QTyPb37BegLEvz1nJvDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopegtrghtsehmrghlohhnrdguvghvpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gNwKamBVeOB_vUHKpCBJtQH9caZjWWVLPEeajwV8MYYzQLKwWAK_6Q>
    <xmx:gNwKatpWhtlTdhM9LD6ayC9ClN7ylk4uMsdwe6dZAFU0Kt1CKafbTQ>
    <xmx:gNwKaokwL3GDFZydIhcUiqWT4zkEqxkUh6hiOV6sLzrR5XeEJml4_w>
    <xmx:gNwKalwIOHlGYxXNw6FGy__XWMDmfB9MXKMgrAWzz2fDQRI2teVRIA>
    <xmx:gdwKanV-_4TColYi5cJeRVDC3E-hgO49brtwLlMsFBGj-Mxar1aCFIC0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 05:31:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c79cb377 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 May 2026 09:31:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 18 May 2026 11:31:06 +0200
Subject: [PATCH v2 15/18] setup: stop using `the_repository` in
 `check_repository_format()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-pks-setup-wo-the-repository-v2-15-6933c0f1d568@pks.im>
References: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
In-Reply-To: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

Stop using `the_repository` in `check_repository_format()` and instead
accept the repository as a parameter. The injection of `the_repository`
is thus bumped one level higher, where callers now pass it in
explicitly.

Furthermore, the function is never used outside "setup.c". Drop its
declaration in "setup.h" and make it static. Note that this requires us
to reorder the function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 58 +++++++++++++++++++++++++++++++++-------------------------
 setup.h | 10 ----------
 2 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/setup.c b/setup.c
index ed0c14e98e..406984b62c 100644
--- a/setup.c
+++ b/setup.c
@@ -1758,6 +1758,37 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
 	return result;
 }
 
+/*
+ * Check the repository format version in the path found in repo_get_git_dir(repo),
+ * and die if it is a version we don't understand. Generally one would
+ * set_git_dir() before calling this, and use it only for "are we in a valid
+ * repo?".
+ *
+ * If successful and fmt is not NULL, fill fmt with data.
+ */
+static void check_repository_format(struct repository *repo, struct repository_format *fmt)
+{
+	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
+	if (!fmt)
+		fmt = &repo_fmt;
+	check_repository_format_gently(repo, repo_get_git_dir(repo), fmt, NULL);
+	startup_info->have_repository = 1;
+	repo_set_hash_algo(repo, fmt->hash_algo);
+	repo_set_compat_hash_algo(repo, fmt->compat_hash_algo);
+	repo_set_ref_storage_format(repo,
+				    fmt->ref_storage_format,
+				    fmt->ref_storage_payload);
+	repo->repository_format_worktree_config =
+		fmt->worktree_config;
+	repo->repository_format_submodule_path_cfg =
+		fmt->submodule_path_cfg;
+	repo->repository_format_relative_worktrees =
+		fmt->relative_worktrees;
+	repo->repository_format_partial_clone =
+		xstrdup_or_null(fmt->partial_clone);
+	clear_repository_format(&repo_fmt);
+}
+
 const char *enter_repo(struct repository *repo, const char *path, unsigned flags)
 {
 	static struct strbuf validated_path = STRBUF_INIT;
@@ -1832,7 +1863,7 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 
 	if (is_git_directory(".")) {
 		set_git_dir(repo, ".", 0);
-		check_repository_format(NULL);
+		check_repository_format(repo, NULL);
 		return path;
 	}
 
@@ -2107,29 +2138,6 @@ int git_config_perm(const char *var, const char *value)
 	return -(i & 0666);
 }
 
-void check_repository_format(struct repository_format *fmt)
-{
-	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
-	if (!fmt)
-		fmt = &repo_fmt;
-	check_repository_format_gently(the_repository, repo_get_git_dir(the_repository), fmt, NULL);
-	startup_info->have_repository = 1;
-	repo_set_hash_algo(the_repository, fmt->hash_algo);
-	repo_set_compat_hash_algo(the_repository, fmt->compat_hash_algo);
-	repo_set_ref_storage_format(the_repository,
-				    fmt->ref_storage_format,
-				    fmt->ref_storage_payload);
-	the_repository->repository_format_worktree_config =
-		fmt->worktree_config;
-	the_repository->repository_format_submodule_path_cfg =
-		fmt->submodule_path_cfg;
-	the_repository->repository_format_relative_worktrees =
-		fmt->relative_worktrees;
-	the_repository->repository_format_partial_clone =
-		xstrdup_or_null(fmt->partial_clone);
-	clear_repository_format(&repo_fmt);
-}
-
 /*
  * Returns the "prefix", a path to the current working directory
  * relative to the work tree root, or NULL, if the current working
@@ -2804,7 +2812,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_repository_format(&repo_fmt);
+	check_repository_format(the_repository, &repo_fmt);
 
 	repository_format_configure(the_repository, &repo_fmt, hash, ref_storage_format);
 
diff --git a/setup.h b/setup.h
index b779661ce7..a820041af0 100644
--- a/setup.h
+++ b/setup.h
@@ -221,16 +221,6 @@ void clear_repository_format(struct repository_format *format);
 int verify_repository_format(const struct repository_format *format,
 			     struct strbuf *err);
 
-/*
- * Check the repository format version in the path found in repo_get_git_dir(the_repository),
- * and die if it is a version we don't understand. Generally one would
- * set_git_dir() before calling this, and use it only for "are we in a valid
- * repo?".
- *
- * If successful and fmt is not NULL, fill fmt with data.
- */
-void check_repository_format(struct repository_format *fmt);
-
 const char *get_template_dir(const char *option_template);
 
 #define INIT_DB_QUIET      (1 << 0)

-- 
2.54.0.771.g3ed373ac14.dirty

