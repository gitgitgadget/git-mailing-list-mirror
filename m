Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B872F5C48
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279750; cv=none; b=jRKlmulfpJkBDjuWLmwdzNi+be5hMriRF9UK+1KupoFsBfu4RTHev9vKmBNwGg/oVsQx+pdgHufz7fVRNEz/ne2O2v19Ji9qvVrNMc2jRd2ddpGRGeB8C6PVD/I/++84Klc5OD7DCuOC9YED6hFeTqSTa5lWVuGHN5q19UaHFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279750; c=relaxed/simple;
	bh=BWzcG6E74/xVf4LJCu0mS9byRIke7XPWIXaAQc2r1NU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ce2btqWmqGMTo0ORmd6jhzB0Xg+z8A4kU46Ey9nlSOIqxFN7hXtPKJ37uHHl39WpD6AmiQs8d6MqGAMWzhHAA/XmXb/04zA4mixQzspdt1DLjeZjMFKj/PE6XIni7Xb3RAwXE8ITSOT4kEgZujHS24LxfQfTQSn9AeyrgmVF1+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TBBNqaaJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F9un5aDH; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TBBNqaaJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F9un5aDH"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 7351EEC19D2;
	Wed, 23 Jul 2025 10:09:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 23 Jul 2025 10:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753279748;
	 x=1753366148; bh=NR43M2EN1mUDWoyKQGwk7SsT+FuoLBAjMj39mLKP9iI=; b=
	TBBNqaaJzoilcWae1JxwuYUlc8wIJr8dohqYTrZaww05SKbAsFEkzrNQ1uSAuUV7
	/SwDv/BF9TTvy0H8A/fU4/X5Rnc0ua3hkauSM16NE83ppTlXvyJOnAicq2A6PhSA
	8DJR/Soq4KPZ5J8rvA/kwVREy/O997OCVjIdVjjpYrik0PP653I8gCsliNO0bhZQ
	ZLSo7d3kssFNQqjHwzWEVMR2aeusJSZyREcKtk3/FAtSv3QCyjT4y6zxSLvrXv/H
	P+bXJaTQ9Q1CPHQGvshijIoV1kjDPOMJtVcDqrL41mnu5qsSry83vwVSOMldXTZy
	npkdvy52Iu/dmLu+C6xtlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753279748; x=
	1753366148; bh=NR43M2EN1mUDWoyKQGwk7SsT+FuoLBAjMj39mLKP9iI=; b=F
	9un5aDHRCEt1cVTRZAlYM9FYAwqMdMP4moxatpzGFofBO9fuCsEZWljWwVq//MlD
	wxhHRju/kaD4M9fswHEpd7S82gXctJ+yK3CSJITlIHF8hMVLh5rdG3CvxDDV75HE
	Nyph7UTPsCwHojt8BfL/1la5JyXPp1x5J2ySn09Z/nzI8q0nQIbh2amMaoi9acPq
	qOAVcI/1aIg7N3SMV8LIujbTQPQCrj7I4TPwLJHscmH7oO94J0tpkWEBw98NeDMU
	0PNBoar+KnyFjm/vn/15R8D7q21JNyomajiVIRbsFgz47WZUjiOd21TWCRCpvYiz
	2v2JR/1vvQ/52NSXHV1tA==
X-ME-Sender: <xms:BO2AaB731tC70iZq3Lv3UlEpQW8d-Nn73dSHy-X1NIFcO8PyNCKIJA>
    <xme:BO2AaPEhfRWuSoLgxAyTmtClN16dsUAr5B6WQ6ZbkVlpL9ajX2OTUAnCI5pu6nh6V
    uHsZcHZnUGWXUUtYg>
X-ME-Received: <xmr:BO2AaKRCzAJKVc76RkNJdtv-yZ5aBDKEX7hQ-blLUcLU8lhNoZZtBcJIK4ENrDLVt8FqYSr6BNQjI6puEneagk1kkfQj07eZDqY_E3FvVPxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:BO2AaIs1zkVkZVw-96K4FKr63Z2T196o5WfmJtm0XOnS0adj9m0iow>
    <xmx:BO2AaJyZo4DRwIvhWWZvXSKUaF8tXlQUZcy3fD9jCgq7dSrY4HL2uA>
    <xmx:BO2AaC5CD4HTuXZmDfArm4mSGCM4K7xrTgnxnNUAqS6Qq1Vjl0-lyQ>
    <xmx:BO2AaDV5LkFbnNo5a0GYW41JVKhsS9_33wjfpV3dXUyL4Di1wdai6g>
    <xmx:BO2AaNJFSVbYfG25wDhl1MREZgA4iBRr0L8f7hcBtBCr_jSocRPb2eFC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 10:09:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5891dab5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 14:09:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Jul 2025 16:08:33 +0200
Subject: [PATCH v2 12/21] config: drop `git_config_set_in_file()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-pks-config-wo-the-repository-v2-12-1502d60d3867@pks.im>
References: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
In-Reply-To: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
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
2.50.1.552.g942d659e1b.dirty

