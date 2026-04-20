Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F11388394
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673413; cv=none; b=V+x2STTkZaYOuid5oEsXCCK1V62QQ9nYR0rcjqD63UUZL5kon7bQJQdM3ovRrBIJvk/2QRLda4H8uxwSgKR9/MPr4V1552c6D+l7P8t9KOgMI3mEWeCNTvGNFVi+gCYslN7rvMaXQm0LHFfDW3AM4s+V+9nCoHKUgUxg2ycTrAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673413; c=relaxed/simple;
	bh=zhM648B43gSoDSNdpjN6iv4eJ5Yk4NPvcY4unyyzElg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gbTOx5l1T66NquBo/EJPsn3uQauwN8jt5+HvgjyTjvBy9y9Swt2SQrLXLtkz1LxE/ciWDIApgX94Eo79hIBd8Z+8NU2k7q/BPqN6Ry1u71DSxyxrYs8WVBojuGCEsSikqe9fBf9Sd5DATrbNjQpIc/cMR2gYdtNd54HAhnaPlrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZTocKu3+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EwtHgHB6; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZTocKu3+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EwtHgHB6"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C5FBEC03F2;
	Mon, 20 Apr 2026 04:23:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 20 Apr 2026 04:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776673411;
	 x=1776759811; bh=6DD66uLYf0xsAjR/k8QGgqsUtYr1Bu2xk8jFBccmZ80=; b=
	ZTocKu3+DSe9Abbhp0zgj9HUgLC9HrEmDo2pPD0HcSIAIE+gnE04aqUtkgQJoQD0
	jGpb9aRBLlGp6pHA0URzT+H7RbLmg4z3YoF5n1WZwXprRxsTWeDo5h9lFJsoJPQD
	bLt1WoosvHblsqfjgnJD3/Gut8bim7Dz/e01/A6f+rKUCpbhN2xqOFAsDRB3rGmm
	CeNSTfkO/eyRTB+eRBey+y7FMZsxbfdOFY+x6Wx+YC0H0F3H5zxqLMazuUmpHgWj
	cFf3w7mJfJMPlDXtDnNvlxpSwkMDdlTt9C84wj5upPsQ86DLjLm1y8tschAOGpQ1
	VDLUa+hQk+oLNMbRNqMHBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776673411; x=
	1776759811; bh=6DD66uLYf0xsAjR/k8QGgqsUtYr1Bu2xk8jFBccmZ80=; b=E
	wtHgHB6Sid8CmuaDZGlvWZyI15mnNrX0DgCLzYcSOuBYDpwYaJqaZGmG6UiacI+S
	ElEDU8Nd+qK2p8cgsoIGjpPxn39Kk2oW/QYPFD43SBAZSmauYNkzKyJzRbmS2Dm4
	3jt3W4ExKViRJXpoCPkRmb8CYKfYIpWSQpqkoAT7QC6Pekh90PVWRPN8BBPEo5sk
	qf8mBl4HW2yKDw0VF+urmQEiWp3NB0tAxYVdiBnp5TwGyqUhD10nK5oF2nqakTdd
	/OTgQVcHacGp9xpS5IJSsrrYL5rBpoBd5Mu2LWUCIpyzcsOXVSClcurwtBLhRGyw
	Xao2Z7u2hsEL/bFO14XxA==
X-ME-Sender: <xms:g-LlaQK0bJIvtW7eO44XQh_Bgq53fIy0AQe4FNKCyoaFrlC07ARmjA>
    <xme:g-LlaXIxCRM_gO3phoBoMabh1uVnu-FnGKD-ywkuFwXZcEtbf3FQY6-RDGvoJ3_lH
    mMRatDmYJh9fGz0LHi6Eo0iH_ir9P-kCHVGPMyhNTRLzNTlpY8N>
X-ME-Received: <xmr:g-LlaVuHWDzjtTfDTCkXBjEDWc_xZlEKdHCyfCZF6g1T728oeQCr6UUPL6fwW5Ad7_7AJpjY8kkwQRSE4GvZr2bl0h1F5tdFeng_Bb9pY8FM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:g-LlacRxUcbUy2IM4-8n45m--3olsqKACc1KSrVcv56tl32E2NMxig>
    <xmx:g-LlaTO-1CJUj-HJriU_At6G_VHtot3sK9-XAZjvTfwv4QfgSiwmWQ>
    <xmx:g-LlaZYbEdfNRing6Fn26eX7xK4mXBisahl5Hnqxx6gFb1M5EcpAaw>
    <xmx:g-LlaVyWRPssPEdnVfXnWpZQ6nkrPYnrvhxvtkZnFO6Udgl-1R-O4Q>
    <xmx:g-LlaVNN8VGRW1XGjVaq-r3ixM-BjVuVrfkksR8ccLXlg-XYonYdXkIq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 04:23:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8274f632 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 08:23:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 10:22:45 +0200
Subject: [PATCH 15/18] setup: stop using `the_repository` in
 `check_repository_format()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-pks-setup-wo-the-repository-v1-15-f4a81c4988e8@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
In-Reply-To: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

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
index a4e294b096..803d482849 100644
--- a/setup.c
+++ b/setup.c
@@ -1749,6 +1749,37 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
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
@@ -1823,7 +1854,7 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 
 	if (is_git_directory(".")) {
 		set_git_dir(repo, ".", 0);
-		check_repository_format(NULL);
+		check_repository_format(repo, NULL);
 		return path;
 	}
 
@@ -2098,29 +2129,6 @@ int git_config_perm(const char *var, const char *value)
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
@@ -2795,7 +2803,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
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
2.54.0.rc2.529.gd9106f7525.dirty

