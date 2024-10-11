Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C3E2F26
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624768; cv=none; b=q2kvCCtQJpoJthrka+r+Z6j46LYHyWc/VMtaPD2FfsQuk2tLP3+acRS6B2nKuaWeGLKNGRuSAl0ICTR0hBekQ/mk6rJpv9zI4CFlwXvo0+Dia8we5g5xkRwQhcYHsg+K/4+oF14asMakzXtbCA9WtYR7OKgPeKzr16j5LPuR7Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624768; c=relaxed/simple;
	bh=zTeJiXPBiztvR/WmiLHPyk5vYo6fEV/yaydKRGyxB8Q=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFR1IYK75xNgTTtO0YyNJWzmxcVM3IYTHegmAUko8SQ5htTngiO/7n+e31Fwlflfi0ix9RAXsxSiJmyzq7XInCXIj45AsYLDeP4qiTOp7IT/o4tXLvSliPYj0VfUhy+4cUd1Mcfkeqmr/RpNDJPCPUEOLR5bsdzpBVB4ym3zF/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IAth5bcJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GkxWMELH; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IAth5bcJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GkxWMELH"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C75EF1140129
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 11 Oct 2024 01:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624765; x=1728711165; bh=qhFa6x0GE6
	5zxmivZ3Ba8v98/skC1YHRXOt2GQ+Ugbk=; b=IAth5bcJav86Y8CEbLmqkdVCOJ
	Y+BXeRREG39bmYRr/Cy58U45MaIXsjsn7srqLWVIedm8hIWI/oLHWesIaWGhUBLR
	pWWWHOeXtxIVBJyGaeqkSLDaJucIZNBRA18ZRfsy8dzkIrnUdf0vS72yzDbYwI/H
	dl+eKw8+tpPvlSb2d5ZaD11DJLtPLnrMQR7lVVjtBqU9lxL1ffdCisBgwBn9yL3z
	/fueFj8BzVOYgC5T+VW/IJhK3bLRbkel+ANvK74EQb/cbfjR5ixvev+oso1AzF0L
	GLhvnJhE/d56QzuJU6Ai4yKL+6eBM4XwO8Kh/nl4/BUSC5W4ADQG5c8g7NVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624765; x=1728711165; bh=qhFa6x0GE65zxmivZ3Ba8v98/skC
	1YHRXOt2GQ+Ugbk=; b=GkxWMELHXW0H+3YoHNZ7O8r/sBCL63gDauutl3yr8Y3G
	DZ8W4tgnrJf8jUGeJa08QYqDC6ITsMudCq4Gsdv6sq9Du9wYLolilN5/NKTbH5DG
	HXflUqRvbr8F7a7epbnFri5MOKsfKxpIaU2GWXfPEsdJMVtYM2BcU5jHdrdK1vyZ
	Tt6Z6iDQR1Zt2wz2zYuXYlkclMjryOGDK4wV2U6kPPkMbmjvzzmQ8kkuaV/08foi
	ArcT4Kz+WjkjtqjZWwrwvyPuNuaDE3WPXjnsRZdbJKCeb8k/EVjEthfO4vvL7OF0
	APNHjEAu1YAxIUzlSl5qC2Na0Q80d1F9x0IO0+42TA==
X-ME-Sender: <xms:fbgIZzbzPTZzmcaasJ3Rh_XRheFI1Fp25I4A_82xRNU_9qPeTHxBFg>
    <xme:fbgIZyYuoRJKLFGiWw7pqugQEhv-k8J4rYUYcO_BzAGB2Pms16uK6sQlLdiEcpjEJ
    OMn3At7GxdOcIGUwA>
X-ME-Received: <xmr:fbgIZ18ifzRkLpIt0YbDF1nUm6H1xQBM4wqzb5s5AHlXAKlcgK6nB4IY6hVhWRev99WNquZbOuTtcZ-1W_G4lqDjGIVujRzL-x8k5riE7b1Agq4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fbgIZ5poeunuH1C5-6HVdV-6d9B-xKlx_Tqiy0j6vhMC9IJMee_9jw>
    <xmx:fbgIZ-qpVJkhTCiXOj7wDjxeGh7Lm9fGfYjIh0Hue1iYPEEKwNUm0A>
    <xmx:fbgIZ_QwU2paXnPcLYUA-Qk1cZ_z8-f4Ke_NfUwD4R2NO_y_MC4Hew>
    <xmx:fbgIZ2qh9C5yBPoRsc19arzeqdPe1oO6mncFBBkNJwMM7G6Xz9jFPA>
    <xmx:fbgIZzAtWP-zh7XiL6abzDf6ZYmdZZyTWNy7kHCy_Y_0Y5US9bXErLPB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8bc6d3a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:31:38 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:32:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 11/21] builtin/commit: fix leaking cleanup config
Message-ID: <8ca4344ed8674b6c40b5fee96d23f64517c7b9e0.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728624670.git.ps@pks.im>

The cleanup string set by the config is leaking when it is being
overridden by an option. Fix this by tracking these via two separate
variables such that we can free the old value.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit.c            | 17 ++++++++++++-----
 t/t7502-commit-porcelain.sh |  1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 18a55bd1b91..71d674138c9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -135,7 +135,7 @@ static struct strvec trailer_args = STRVEC_INIT;
  * is specified explicitly.
  */
 static enum commit_msg_cleanup_mode cleanup_mode;
-static char *cleanup_arg;
+static char *cleanup_config;
 
 static enum commit_whence whence;
 static int use_editor = 1, include_status = 1;
@@ -1387,8 +1387,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (0 <= edit_flag)
 		use_editor = edit_flag;
 
-	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
-
 	handle_untracked_files_arg(s);
 
 	if (all && argc > 0)
@@ -1636,8 +1634,10 @@ static int git_commit_config(const char *k, const char *v,
 		include_status = git_config_bool(k, v);
 		return 0;
 	}
-	if (!strcmp(k, "commit.cleanup"))
-		return git_config_string(&cleanup_arg, k, v);
+	if (!strcmp(k, "commit.cleanup")) {
+		FREE_AND_NULL(cleanup_config);
+		return git_config_string(&cleanup_config, k, v);
+	}
 	if (!strcmp(k, "commit.gpgsign")) {
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
@@ -1658,6 +1658,7 @@ int cmd_commit(int argc,
 	       struct repository *repo UNUSED)
 {
 	static struct wt_status s;
+	static const char *cleanup_arg = NULL;
 	static struct option builtin_commit_options[] = {
 		OPT__QUIET(&quiet, N_("suppress summary after successful commit")),
 		OPT__VERBOSE(&verbose, N_("show diff in commit message template")),
@@ -1757,6 +1758,12 @@ int cmd_commit(int argc,
 	if (verbose == -1)
 		verbose = (config_commit_verbose < 0) ? 0 : config_commit_verbose;
 
+	if (cleanup_arg) {
+		free(cleanup_config);
+		cleanup_config = xstrdup(cleanup_arg);
+	}
+	cleanup_mode = get_cleanup_mode(cleanup_config, use_editor);
+
 	if (dry_run)
 		return dry_run_commit(argv, prefix, current_head, &s);
 	index_file = prepare_index(argv, prefix, current_head, 0);
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index b37e2018a74..84f1ff52b67 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -5,6 +5,7 @@ test_description='git commit porcelain-ish'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 commit_msg_is () {
-- 
2.47.0.dirty

