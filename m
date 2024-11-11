Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846E719925B
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321545; cv=none; b=kIy5HmN5bZAmphyqCUm8ITk0HGsh5bYK7Lrro6ak+LRPv0gv8q9mTtBlvsCWUFayAF2Ot2LNrTXCav1YDbEsEoqff/YjgftypG+JunSKuEKtmoSPPLDuoZRocqOOvXphnuXJ6Of+iOZmKpXSvnF1cMacDmyTF/IIuh7fVGaQucA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321545; c=relaxed/simple;
	bh=/FQtblFgBMQqOytdUWpQZsJO0+qT6M1OLhJjdoyNfQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MokJyS7X9RIa41uXRB9379w7aKQqyaNPmfL4umdLn9VivAx0R7PE7Bd8ZcbFB8aXMeX+KjZWKA17z8TBunkZ0GqUrX0QFVD0S8S4C5POSEhHf9iku6KSUbcv0nq1scoOAoIznQnZL/EodMs0+kcpptadEHYCvgY/wcZuQh1kuDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SVwUbcaV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OUmaNef7; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SVwUbcaV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OUmaNef7"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id CB3C813802D7;
	Mon, 11 Nov 2024 05:39:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 11 Nov 2024 05:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321542;
	 x=1731407942; bh=SfD+rZwQ/lV+7o/So7PheGC/X0DMaUJH9F5t8R3sL9M=; b=
	SVwUbcaVUOPABgNsScqq4VTczpJxWEwRzBkknk+FDi6yHAhdHi0z7xdchXV1lY4V
	4g6Gis2d1g8ht3f8K9dk3gD5TWC/65/SsZlILIv9TZ3g0nvpSKSpF0ZAX0ZaZOWs
	Q0bhpf6y/b9D+UvKejcbXMaO2sHWrqWV2dH2nrLrULDRZRNW9OMhx3BTvxVs5bEN
	3kMrTJvQBxhSK4GStyFos3SqeGan5HveMJHzxTAx4L7eOg4avQo9gv96GVSMKhlA
	hEuP64KopiOiA4SRkVm7o8fVV3KXauIuwY+OiPeckk0WxjzDKTb78/ePtrn7zkez
	4XCRzuNGAvUSoXmHkixwig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321542; x=
	1731407942; bh=SfD+rZwQ/lV+7o/So7PheGC/X0DMaUJH9F5t8R3sL9M=; b=O
	UmaNef7HHtxNDv8rQPIsUJfiwheZHumr7gBbGYtrMKiGWxRkOV93lRTLerkE9N38
	fjQaIvLeD8P0XWbd7t33T8/kmUD9JtoL1iwepplj3YovH0dchl0KcTukUeE60Zp3
	z/eBT+/ND7NAq+QJBgV225/qLXOz29Vfks+/8Qxoc0TJnixfagORZZWKxLrV+oHy
	W8yTjSCMxuL4Fa/9WNuSkSLmBGd6r07utO/A6ZehrC3qOnwGmw8JUj/PJorrYDDe
	jqNRf/ctMl46gIyoDKrct43yAM8ugBucd1Eg16Vygg5pgzwT8GSLAMzRWadQJt3A
	FAX8SpDSKIp/SGjV0HYNQ==
X-ME-Sender: <xms:xt4xZ362tMYtjdQp1b1SCkJAi7UOqL6u9dJBaN0Dr5Sa8X_EToneLA>
    <xme:xt4xZ84DBb8Rn-tk7N-rF7UeYKrxNjme5rzSDpCzdylHWSaCGln8bElqfYakBbN-8
    PgAO3xaCXLwc8aaUg>
X-ME-Received: <xmr:xt4xZ-cK1vMV1IkzgIp64mIhtlQ5D3A7tiVZN7hexdgU19_aFo1_S7owE8Xob8Op_64AV1YBNoE63AG-2QWFknne2EEiKvKxttN0sPOaie54TP-Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehrjhhushhtohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:xt4xZ4KaxcOdtyaD33QIinPE9ez8M7Jjre030A2hqLnGi4YJm3LNsA>
    <xmx:xt4xZ7JZD0zrHD_HpxAxIapeIMtakMzzzs9JcTRB6TOGZVwApyuLXA>
    <xmx:xt4xZxy5Hbri9o0wGXGWSpTYWqXX3Njehj9C94MmT3atlxDFPy018Q>
    <xmx:xt4xZ3KKZFMtIjE2OXSJ9-GFgmAUcoWHs3LQUzJcut1I3IvHWBZalQ>
    <xmx:xt4xZyUrNZhgu2LomindCcn_Av3ZfnYEv984drpLV5TndDI8IRsVih2v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:39:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ac467322 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:47 +0100
Subject: [PATCH v2 18/27] builtin/init-db: fix leaking directory paths
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-18-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

We've got a couple of leaking directory paths in git-init(1), all of
which are marked with `UNLEAK()`. Fixing them is trivial, so let's do
that instead so that we can get rid of `UNLEAK()` entirely.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/init-db.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 7e00d57d654e6820c7ad2418cafc3a9aca815816..096f96b9c4a2035b8d1edd0ac90de0dd73d7d508 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -75,10 +75,12 @@ int cmd_init_db(int argc,
 		const char *prefix,
 		struct repository *repo UNUSED)
 {
-	const char *git_dir;
+	char *git_dir;
 	const char *real_git_dir = NULL;
-	const char *work_tree;
+	char *real_git_dir_to_free = NULL;
+	char *work_tree = NULL;
 	const char *template_dir = NULL;
+	char *template_dir_to_free = NULL;
 	unsigned int flags = 0;
 	const char *object_format = NULL;
 	const char *ref_format = NULL;
@@ -106,6 +108,7 @@ int cmd_init_db(int argc,
 			   N_("specify the reference format to use")),
 		OPT_END()
 	};
+	int ret;
 
 	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
 
@@ -113,12 +116,10 @@ int cmd_init_db(int argc,
 		die(_("options '%s' and '%s' cannot be used together"), "--separate-git-dir", "--bare");
 
 	if (real_git_dir && !is_absolute_path(real_git_dir))
-		real_git_dir = real_pathdup(real_git_dir, 1);
+		real_git_dir = real_git_dir_to_free = real_pathdup(real_git_dir, 1);
 
-	if (template_dir && *template_dir && !is_absolute_path(template_dir)) {
-		template_dir = absolute_pathdup(template_dir);
-		UNLEAK(template_dir);
-	}
+	if (template_dir && *template_dir && !is_absolute_path(template_dir))
+		template_dir = template_dir_to_free = absolute_pathdup(template_dir);
 
 	if (argc == 1) {
 		int mkdir_tried = 0;
@@ -192,7 +193,7 @@ int cmd_init_db(int argc,
 	 * Set up the default .git directory contents
 	 */
 	if (!git_dir)
-		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
+		git_dir = xstrdup(DEFAULT_GIT_DIR_ENVIRONMENT);
 
 	/*
 	 * When --separate-git-dir is used inside a linked worktree, take
@@ -213,6 +214,7 @@ int cmd_init_db(int argc,
 			if (chdir(mainwt.buf) < 0)
 				die_errno(_("cannot chdir to %s"), mainwt.buf);
 			strbuf_release(&mainwt);
+			free(git_dir);
 			git_dir = strbuf_detach(&sb, NULL);
 		}
 		strbuf_release(&sb);
@@ -245,12 +247,14 @@ int cmd_init_db(int argc,
 			set_git_work_tree(work_tree);
 	}
 
-	UNLEAK(real_git_dir);
-	UNLEAK(git_dir);
-	UNLEAK(work_tree);
-
 	flags |= INIT_DB_EXIST_OK;
-	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
-		       ref_storage_format, initial_branch,
-		       init_shared_repository, flags);
+	ret = init_db(git_dir, real_git_dir, template_dir, hash_algo,
+		      ref_storage_format, initial_branch,
+		      init_shared_repository, flags);
+
+	free(template_dir_to_free);
+	free(real_git_dir_to_free);
+	free(work_tree);
+	free(git_dir);
+	return ret;
 }

-- 
2.47.0.229.g8f8d6eee53.dirty

