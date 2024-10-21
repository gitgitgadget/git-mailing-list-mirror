Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212E81E3DFA
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502923; cv=none; b=nGHMTh5pmVXKtOQnMaltwGBlAE4116/YFBX4m6l6IpqZy4Oo6h5HGwEdnu7WoU02k/x5OdKsjb9Xt0aZXaTfLWN626WSPUeFa3+bLBOjiSztyQzVkshK/WDNnWvbZC1wUyhclqaovhqYiFtqlBNZfNw2h+Xg4msDXX6i5y+QDzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502923; c=relaxed/simple;
	bh=/s89uG+7hdI+CQ7E4ilUcD570tnhQsD+LpsnrJcpIf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtUvp2ZqIaCLH5/OB3xLtzshz5XcWhJKIVAza8u+ijx7mpBWxED8lo4csPB/xXM+sdfcjJlXa5M5Z7fVkGuaUKiyquDgrHc959idiWmCHuP2aSKkzk9k/FqNDgzflIkHBci44roBehb3lDeOQsw0nG/g1VqQ1arFpUMeyFCmZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VgvL7W/K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gTfQHUQX; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VgvL7W/K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gTfQHUQX"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F323114022A;
	Mon, 21 Oct 2024 05:28:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 21 Oct 2024 05:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502921; x=1729589321; bh=e5757l9az1
	ozsqUEMrZRhDc+gTVoag7Gg2e/K/WLpXA=; b=VgvL7W/KgVQb3nt1wStFTVpxff
	vicFgT74kW8234qrXfhHb+zJOuGtBncLxYYbuLVf0zsd8wk/Khi65UGwgQMPtRDI
	iLRGI93Ojy3xjmPtlGo+MFuZT86mKBC2PDNQMLEnqAmiUPZMIoCbO2reNphPc3Jd
	+Nh28sr4AN4eQGX2NUAXoReS1iuYjSfv/kejkCKgaKmW3+VIMZIGClgGMXETo2iD
	R4BooYIJ/bHjStkn61KR+z7D+iJ4s8SV4Ueuqd8ZPIx/eaT5vIhDHCeYd/+fUt0Z
	7EC50lDd/I0srgXtBBYeEUR4SjDSuc1VsQmPo29rCGictSIPNL4qKM8TrLQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502921; x=1729589321; bh=e5757l9az1ozsqUEMrZRhDc+gTVo
	ag7Gg2e/K/WLpXA=; b=gTfQHUQXWeIcOrQc1kbFqq1CbSRMFuILV3q12PFntnE+
	di0yaPGAr+Z00uC70yBlvaH4lvzO/bj+reO5B3B9w/fNl8i+ubhV6bsNN78DOj3E
	X3ohq9Kz1BjnxQDphKbjs573L7Z30A/BgdEhuMfQBCX/t1XMoomHnXrpwDyYoyyp
	JuJkYJ7EXJStONw6NmvSZH2XzZ0pLbtum7WLQUv8BjsLAe3tXuis7RRj2xMFFw8F
	F/eJRC2EfoiO6TeoYGj9Ob5D165g3Go3Uv4gncHLw8kgvE46cDutkzL6n5LpLm8G
	ju0W8ydTPmMfZubhAGoGJWn7ZcZlT11KhD76S2ECNA==
X-ME-Sender: <xms:yR4WZy0J0Ri3Cfpt34KvAWZ9lofwAxe0ywn_AEgKWPK7HfWP7Fg0dw>
    <xme:yR4WZ1FysSJ3kA0DTXdwA6dvHlNUzM_7GEQEqDUW10KWcSR_IUDJYUTtU16vvsPG7
    WNr8qFMAFL4Pkj_Gw>
X-ME-Received: <xmr:yR4WZ67KTsqgEcwQpOWGHvHYpicWzql4Lf6s7BRjGuouM95NDsYis5Emsu6ScZyGEAapFs_x87dlNaVB_Bd2l1pfuK3jj0bqgKWUim2KqpA4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepthhoohhnsehi
    ohhttghlrdgtohhm
X-ME-Proxy: <xmx:yR4WZz0M8O44TPQQiETktOCgMgnm98QXq17SsF-e3gYdKUKyaUOBQQ>
    <xmx:yR4WZ1HIs9EjoHKfstNEURjAkw9p8pE8YLCQ9PIS74J4K3FYpDx5YQ>
    <xmx:yR4WZ8-sFzlqEXBoCQ_pJI9fBLvOxyght0hSvPpldRW1pPyf-09dew>
    <xmx:yR4WZ6kfyNcchVjpifjhSqWL_EBQ1nL5etoWBWB1Odc2PPJ2H-5MFA>
    <xmx:yR4WZ1A99YDG12rpV7jaVAwLmGA4lsmWXO_M2EDYBwM61D7G21QVnUVx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:28:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 23d08834 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:27:13 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:28:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 12/22] builtin/commit: fix leaking cleanup config
Message-ID: <60c3f6146f3d254b80e3b3c8ef3c248b4f9af7f8.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

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
2.47.0.72.gef8ce8f3d4.dirty

