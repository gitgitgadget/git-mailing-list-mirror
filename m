Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1239E2BD038
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749410; cv=none; b=C1TBz7dtLHN2DUEtH4qmLnA7imroccqRmrAp8RbOt3FehffvYwn1pehWnOwLLnoqDdRfbAmXu3gA0DjH8YbJ+IPUXhht5wp5QYCdMd7VWUqaKRV99x9/HF2oX20XVrUB9rIr6+SGwU+QNoVAST7rQKQxwBxhmK0yY/Bi6KJsnIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749410; c=relaxed/simple;
	bh=OcnJkQIYNYrWpZtlNbnpYYRNT7vPw7RKpSkp1Xt3aoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I4/8e9LR1tpub5Ztvrou7rKtg4eYqkkbUiVImMUE66HCmvEx/6NC7QEFFAen/6KoQHELUYReCbyIMCbYfIj18VUbXK9O4mkxp07nUBxUA6UpK/79oTNc4SmpcEKZDUUB5fmm6OP4MZ4UCmc/NKSZRrHAdnkPu2tOhaki5ttQqN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AMfQ0zxC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zkd+s+KX; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AMfQ0zxC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zkd+s+KX"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 3BCA41D00166
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 06:50:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 17 Jul 2025 06:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752749408;
	 x=1752835808; bh=GTOGf+PgwqwFAscCQVx3jQSDj20yp3MA/qBpFKElO48=; b=
	AMfQ0zxCokyCi0dOMm3OfrDCpVqqyAg/elen3otptspP3VfT63xDdHTiG25IBupL
	Uns4rI4fZ3BO21uzcYIjwtiCFrLAW71ovYpQREQ12J53iqz4fiHvguuBHkxtNYRh
	+UMQf3sJUIu+RIOhXgEY0BtDj74ecm9xdkjQgSA9LZ9OA4nkgEsah6fge71uAjHY
	V4fIUCO+CBQDkBOaV97mC55IrkMciHOG6GYcroS3faNzYJlS9Ex5xoDPaWlL6DIm
	vZHJKjjIi1UqbPk/yI6opC0HvQg7H4+5UEbmc0by+RAnMliJVb/i8vyp6jHD7W8P
	+L4wrg1ucXVwpwtnWuHUTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752749408; x=
	1752835808; bh=GTOGf+PgwqwFAscCQVx3jQSDj20yp3MA/qBpFKElO48=; b=Z
	kd+s+KXEFKlC0CP1kGxkCTzwerSaOFBpX3/NAeIFpwQcG1SHbrV+zzFLx7oJGCd/
	0Jx+JDVV33AlsrfM8jS8bV9MkPBGMt77BAWxZYmR4qW94W8LvR+FeowNO97UjUaz
	pbR366GOuIEUw0UnQIdKXF9yZkU5TeiNCVct1JL+7ZY1NXOAOCcs0drmRtWvcH0r
	JPqjp0AzhMrv3NzFd2hJhV305k5ac1TwbKawUcy2PQuTX04DmVBRh/UZCk2OVHla
	WEpNx2Tyi0uL8ngtEICCrCbsoBsy/5+/c7sbAtoYTum+kV1vIBv+3o+Rt2duAay7
	DAlLI9n+h090vwTp9Zp3g==
X-ME-Sender: <xms:X9V4aJAi_XJXyywafvT1BjSAuV2f6VT0e3RXThYOQvyP3ObtYML4bQ>
    <xme:X9V4aJiCt5sGalwm_n0SHYPSMwJVLBldljfgyymKHWxt-hF7_k-VkPFVrTiZIp8ri
    mREat2mA2Y22H42mQ>
X-ME-Received: <xmr:X9V4aN-rDMn2oMIR_kADzD7QKoKEDItJaPnQoy79f7IAd2Nig9P03WYtk_JoI-PUvEkzvit_bx4yQOG1rFXFtSGM3BmzBg9aRS0zdwxsq97g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:X9V4aF99iHEOeQyT2h7V4jWTYU9VNISxqUiWgs5pMfruVIerRHtDlQ>
    <xmx:X9V4aGCo_6612Kj4_RNKknWz8S6nhGx_HORBIrr_tivQ3Fp5I7mjyg>
    <xmx:X9V4aFz6n7vEwJuAbX_0oJLq49k_lNWoS5mg7JKb_1qr6NQpSW3Udw>
    <xmx:X9V4aLTgbwtf6RqnWjolMTwZ7HFp3M7eg3WxuwHykHBwegZ4jnos-Q>
    <xmx:YNV4aA642SWS-wOtDve2Y-xX2cTaytFP5laigz-JdpOfFhuaD3yEbc9M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 17 Jul 2025 06:50:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 645bfac0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 17 Jul 2025 10:50:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 12:49:32 +0200
Subject: [PATCH 12/21] config: drop `git_config_set_in_file()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-config-wo-the-repository-v1-12-d888e4a17de1@pks.im>
References: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
In-Reply-To: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

In 036876a1067 (config: hide functions using `the_repository` by
default, 2024-08-13) we have moved around a bunch of functions in the
config subsystem that depend on `the_repository`. Those function have
been converted into mere wrappers around their equivalent function that
takes in a repository as parameter, and the intent was that we'll
eventually remove those wrappers to make the dependency on the global
repository variable explicit at the callsite.

Follow through with that intent and remove `git_config_set_in_file()`.
All callsites are adjusted so that they use
`repo_config_set_in_file(the_repository, ...)` instead. While some
callsites might already have a repository available, this mechanical
conversion is the exact same as the current situation and thus cannot
cause any regression. Those sites should eventually be cleaned up in a
later patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/submodule--helper.c | 10 +++++-----
 config.h                    |  6 ------
 dir.c                       |  4 ++--
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d2ab31835b5..0be737ac4ff 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1810,12 +1810,12 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 	/* setup alternateLocation and alternateErrorStrategy in the cloned submodule if needed */
 	repo_config_get_string(the_repository, "submodule.alternateLocation", &sm_alternate);
 	if (sm_alternate)
-		git_config_set_in_file(p, "submodule.alternateLocation",
-				       sm_alternate);
+		repo_config_set_in_file(the_repository, p, "submodule.alternateLocation",
+					sm_alternate);
 	repo_config_get_string(the_repository, "submodule.alternateErrorStrategy", &error_strategy);
 	if (error_strategy)
-		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
-				       error_strategy);
+		repo_config_set_in_file(the_repository, p, "submodule.alternateErrorStrategy",
+					error_strategy);
 
 	free(sm_alternate);
 	free(error_strategy);
@@ -2522,7 +2522,7 @@ static int ensure_core_worktree(const char *path)
 		abs_path = absolute_pathdup(path);
 		rel_path = relative_path(abs_path, subrepo.gitdir, &sb);
 
-		git_config_set_in_file(cfg_file, "core.worktree", rel_path);
+		repo_config_set_in_file(the_repository, cfg_file, "core.worktree", rel_path);
 
 		free(cfg_file);
 		free(abs_path);
diff --git a/config.h b/config.h
index c9f582c7c55..b4f79d4d4cc 100644
--- a/config.h
+++ b/config.h
@@ -734,12 +734,6 @@ static inline int git_config_get_pathname(const char *key, char **dest)
 	return repo_config_get_pathname(the_repository, key, dest);
 }
 
-static inline void git_config_set_in_file(const char *config_filename,
-					  const char *key, const char *value)
-{
-	repo_config_set_in_file(the_repository, config_filename, key, value);
-}
-
 static inline int git_config_set_gently(const char *key, const char *value)
 {
 	return repo_config_set_gently(the_repository, key, value);
diff --git a/dir.c b/dir.c
index 02873f59ea6..dfb4d40103f 100644
--- a/dir.c
+++ b/dir.c
@@ -4091,8 +4091,8 @@ void connect_work_tree_and_git_dir(const char *work_tree_,
 	write_file(gitfile_sb.buf, "gitdir: %s",
 		   relative_path(git_dir, work_tree, &rel_path));
 	/* Update core.worktree setting */
-	git_config_set_in_file(cfg_sb.buf, "core.worktree",
-			       relative_path(work_tree, git_dir, &rel_path));
+	repo_config_set_in_file(the_repository, cfg_sb.buf, "core.worktree",
+				relative_path(work_tree, git_dir, &rel_path));
 
 	strbuf_release(&gitfile_sb);
 	strbuf_release(&cfg_sb);

-- 
2.50.1.465.gcb3da1c9e6.dirty

