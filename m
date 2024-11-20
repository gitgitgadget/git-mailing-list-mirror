Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95C21BC07B
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110009; cv=none; b=HZAQ1e98BfPYnODv1JGYEv6xiAPqB3nvjVJt03N0LRl91yjokGC04o6sFQ/smdyOpAFWYJ0LorgpeMrTRNLNujDyXxczzW6NwWiHeBCK3lmjhIegtfGQrO2QNOQ1AL0CvWJAhkcVTlz4s/lLa74V735wcOKrJuy9lFlxKEHloeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110009; c=relaxed/simple;
	bh=DvjT9BOnucw9+Bif1CxDuITJcU2pRElLdXV8XxAVzmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kzrkc51AA5x45rsBWqacYoUe8B30wXBwvvF693xXHRXtr6BTjiRoWhd1jMCO82p8VSanlfVGrTbzy3gIyDsGMm0BPO9dNPoPU9hZhln1aR+CJFK1pK448imuMMqbVh0Ah7wU+GlHZUj1CwHH09CUvGv7pUGcKruXF8gVkTrX1AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l8ijrzTx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lM6c0HcC; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l8ijrzTx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lM6c0HcC"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 139B413806CF;
	Wed, 20 Nov 2024 08:40:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 20 Nov 2024 08:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732110007;
	 x=1732196407; bh=zR8Q1K480B9bSapBFTm/NQ4Xa+W4tgSKAH9FeZl1wzQ=; b=
	l8ijrzTxLZBl7u+owLU/rcMr6VnBpyULyokLMR7rLXzmBZQGkprS4DY7pbMmVpiE
	tvDeihweZM0W7i1LP8nWMFuwdxVGaCxSJWRCuWxgr5Frn/VPPiLuNyN1LgDMXYOw
	4CnyFkdYqGNJPdyihf9M0xI1uKzq8f0AILgbIrh2drSvvK9E9KHUwb8Hve0+wZhv
	Oj7hrY/aWphnLuTAO4IaIG26uKQgu+j0oQNJGYovvn83GXwMl/HjbWZJamShF4LS
	D6GmwoQROP9+fha9jI2UEKy8+3H1bRu89Fqyf2JCtacStGFBCwVJhuQcoVJqORyq
	dmpHlby3g0wbQ2O9+yc+Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732110007; x=
	1732196407; bh=zR8Q1K480B9bSapBFTm/NQ4Xa+W4tgSKAH9FeZl1wzQ=; b=l
	M6c0HcCCw2jLY91JL8LFDWx71haCbiYyez/cmMsfklEo24wJO8dJeqyq2HnU7kme
	KN/ZoMWWjemDYqZ6soH10U/jUd58PKU2dn+zS2nFQJ0LZLDUCWhiEI/s/I0OZxH1
	0zgPdg1BAHWGD8Hurx3ID4u3I48PW5EhX6k5HO+dLaCj9XQ2mQZiZH8QGltvWveK
	wONy8908zxmaogu+b1ma6SBzEP0oBD0PPJ3y/AxCxBk2DB72ndyIsq2OhhYvNxOp
	WfHeVZIIGVanvbbkKIZIZpoN225+wTpqIrPD79OVbP7+dd5L03fcN1s2kRlTqDMl
	8nn5cehdWHJYXxq4yQcGw==
X-ME-Sender: <xms:tuY9ZzNmSj-7PmdiC3H3wiytcIAUQ4kxfytW1VSx_y2QEkGCUsQKcA>
    <xme:tuY9Z99xeYNOEHMxN-xHt5YNbnHTvsFqzORyBt0UJcO7TMu18GiSydGyeM5OFHxJR
    Qz0Syhxk-Gd-499bQ>
X-ME-Received: <xmr:tuY9ZyQu-GkqRcHjopFE6cLVU5ibOnH9LQNJS4JgLBjNxwvK_ADTksQ3ccLT-WLj0lNgRGDRAw2HHILRhUFXVmItPxZHyS5yy0yGvhQn45iXmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprhhjuhhsthhosehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:tuY9Z3tpMx5v27cKge519U7xkzcXFVgiZvUsksYK18Gx7WMQvFq9aQ>
    <xmx:tuY9Z7cvUDCUSoLy1JOeSvF0cbz5u3E5_5NqLKqfBn4EtnFVV2EhpQ>
    <xmx:tuY9Zz1XncyVkVMDIwdoGmpev3mDNDUixN6ozisyBuB83zWV64VV8Q>
    <xmx:tuY9Z3-EOEAC1XAXT8TeNNmWe287Alzcz2H6Q1Oq0pest7sYwiGrTw>
    <xmx:t-Y9Zy6E4L1J67eH6hpIkCInw2MnKjZBIzx5qi7GRDpnYp0exvCemteo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:40:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d65f20e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:39:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:47 +0100
Subject: [PATCH v3 18/27] builtin/init-db: fix leaking directory paths
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-18-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
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
2.47.0.274.g962d0b743d.dirty

