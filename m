Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B715E18991F
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540460; cv=none; b=N+RPcZ3kjNoo2w5xW9blcpRshPHIA74UK3s5bKtljoUwtB5tZBvpkeFPfkThW/TefodTHFz7qEKOSchlTxiSwNgMbshmhx1kkfGhsXtxDdbh6yHRgSJWFDePSZvTSM5bxmmIzx4teJGc0UwhMTc4fhEgPutI39mrOdj0tPB38dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540460; c=relaxed/simple;
	bh=dafDExnyr4VPrErAGqepVfwGaUhRzspv0LxVvDYjTk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6ZanyDiogKHt9ljY9RkTrAMiW+nYKW3p9RwEmOtoOhlWuMr06jE+XgsSEQBTLMdgqNhL3p9m4dwD4nCAt0AjgbS7f2axSbBfa1e8DUiX2Jvr48k3w+tR7tCx8qlVkG0plUzn/n/tVgSE8JCmsKeMeTwCYAMMRd0oyctWUF1wpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IxhUVgvI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=awAZRgUx; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IxhUVgvI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="awAZRgUx"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EF8111151A3F;
	Tue, 13 Aug 2024 05:14:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 Aug 2024 05:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540457; x=1723626857; bh=HdoxSwiiyq
	gdhLgYYW4NG9g03l0Xs3Locg9m2zIHOnI=; b=IxhUVgvITyIQEc9nFKp+hRuuiw
	kz7+fhlwXNn4j0jFlB6+4yKwLkiXXPz3KoCT1g1HKZ3basUDZV4KQaBUasiA6+PK
	5qaGiVX++xycg7CxgZDEXcVGQrPDh93LY2oqU41jJiypHu+pQz0LnyS8nGNoypO2
	2we7mTx2c5bTpr+GoBT1e11jbbZe27U47uus4tw2CrBr9jqABZC9MnUJZFxAb1Mw
	rzLGudCF15Ylsev4J/tO+0EyNqjNW9QYeY3uPz0RM7veUlWyQeWXwL6h74HF0cal
	xqc5ckMnt8tP/gNelQLXfmFtJB4XuR976EMJ+PUcdm/YkAwfNwlGeyILeaBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540457; x=1723626857; bh=HdoxSwiiyqgdhLgYYW4NG9g03l0X
	s3Locg9m2zIHOnI=; b=awAZRgUxQ1slfdQWQ/MmUvSOMtfx8kP71KJupb3PWM8Y
	QJjK9y+oD+vMaQoYAw5ANsVi7jXOWzv5FDKoJQN5MSWRAkyJmPNX6jrNhsrruB/j
	SuAN2pmUv8W5IWiDhCQ84sjYnoUOWKqxW9tlEHe0QZuEDJ6RPKUIpYgUJBw9WVms
	drvFcYfLt0v/RQcXSpjcC3H7l9woxpInerkDvDj4RdgO34PkbYGDlIwRDyqLma3s
	714GqdbbnB8FgC8Ka7dJo9j9KdHBAotRN1J+IYt3wAEOWmzi2ZqZyPvJ9ZY4fvJK
	ljFZkiFcAEUjaKq19yfaX1c7SGEOUw/KKoO7aGjMQw==
X-ME-Sender: <xms:6SO7Zs7uxlU9Mf9CEnmAos9HM71Fcm7TBcFkt6k7OrjVUwkdL0iE9Q>
    <xme:6SO7Zt7dHlJtVkUN9SiuOaqKyuBM4OjkVKDTsSwYihj19Z7HvS8X4upXVCmLFbx5E
    fNp3QvzLHLUJ5ZQ-g>
X-ME-Received: <xmr:6SO7ZrdDgrZpn1TDsIoEqgmEDPWpG9quZPzB-w4E5x_n49ErJrNRcOsJsgpYN7JmxaGG2ACHAM4P61y7Mdl3Jj_yvh9q4AJ3KLmHlbbKt9jMkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6SO7ZhKr5CEKowCrygy2ovfxgw1nlH-0mf905k5DtSYi4pzf3uXSvQ>
    <xmx:6SO7ZgLH6mzYeVw9ZbN3WJglFbuiBVMYK35NYepggr2hfviCD4l7Xw>
    <xmx:6SO7ZiwkgQHGOSO6Il9TlV5p0763FdKcee9DQufV8sFaSq80ZbzQeQ>
    <xmx:6SO7ZkKAqZ3dm-hQ1RLFkg87mb0e-mUnahKpBiSD9pDJhPXvDDH0jA>
    <xmx:6SO7Zk1jIdtStmSYiDf71dsfezjlT8Il-OOIlG2MZI_6aEuDKbRpyZk9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:14:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e024e10d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:14:00 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:14:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 17/20] config: don't have setters depend on
 `the_repository`
Message-ID: <1e5cd92e8ed959e83182a6c422cabb68e02dbc52.1723540226.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
 <cover.1723540226.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540226.git.ps@pks.im>

Some of the setters that accept a `struct repository` still implicitly
rely on `the_repository` via `git_config_set_multivar_in_file()`. While
this function would typically use the caller-provided path, it knows to
fall back to using the configuration path indicated by `the_repository`.

Adapt those functions to instead use the caller-provided repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/config.c b/config.c
index ed39922dbb..831c9eacb0 100644
--- a/config.c
+++ b/config.c
@@ -3220,8 +3220,8 @@ int repo_config_set_worktree_gently(struct repository *r,
 	/* Only use worktree-specific config if it is already enabled. */
 	if (r->repository_format_worktree_config) {
 		char *file = repo_git_path(r, "config.worktree");
-		int ret = git_config_set_multivar_in_file_gently(
-					file, key, value, NULL, NULL, 0);
+		int ret = repo_config_set_multivar_in_file_gently(
+					r, file, key, value, NULL, NULL, 0);
 		free(file);
 		return ret;
 	}
@@ -3613,10 +3613,10 @@ int repo_config_set_multivar_gently(struct repository *r, const char *key,
 				    const char *value_pattern, unsigned flags)
 {
 	char *file = repo_git_path(r, "config");
-	int res = git_config_set_multivar_in_file_gently(file,
-							 key, value,
-							 value_pattern,
-							 NULL, flags);
+	int res = repo_config_set_multivar_in_file_gently(r, file,
+							  key, value,
+							  value_pattern,
+							  NULL, flags);
 	free(file);
 	return res;
 }
@@ -3626,8 +3626,8 @@ void repo_config_set_multivar(struct repository *r,
 			      const char *value_pattern, unsigned flags)
 {
 	char *file = repo_git_path(r, "config");
-	git_config_set_multivar_in_file(file, key, value,
-					value_pattern, flags);
+	repo_config_set_multivar_in_file(r, file, key, value,
+					 value_pattern, flags);
 	free(file);
 }
 
-- 
2.46.0.46.g406f326d27.dirty

