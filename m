Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A173624B8
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160298; cv=none; b=rLOAiCRJm4gGAhJnN88HMBcvyds2Pa9AdYLtndje5dGS1+CAggfyrlgou8QWHdqpGFvmRo0GTnKzDo5zRWB1RDimu26tghp7nHsGRPRBD3BZJIoEoKQn/SDhwPff4fXm07jXp9FPcjUBVndwmGEEP4sDcCKfM/+602puFBgvSVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160298; c=relaxed/simple;
	bh=1zJUIfVP0yZ4TeZtwHJjH0AdaZf/P1RjOweeZFkrgcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VYJsI40qXSIwDu82fRtySlyN1j3iSIrxOgVOQr63ajbeb0TZD+6dkgh5yeggnjkkyLzpBEjo+tY45Khs/foHSA8FSNknG2W1Em19pZGI4nbKIyXpjPx3ucOHtLR0PKafV7tBV0yYJdyJjb6v7mwuvGjDczbOibyC1yId9AjmoXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZLMSTozu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SC6GmNfh; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZLMSTozu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SC6GmNfh"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 27CAD1D000F8;
	Thu, 11 Jun 2026 02:44:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 11 Jun 2026 02:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781160295;
	 x=1781246695; bh=AOdzHf3iWIFe3SStbsPJR+/cWifPhjV1QCISugNeO8g=; b=
	ZLMSTozugSs83s8OybVKy/mOlVWo1tPYnth5iftCtfUykIjLo5+XP4V3w4kTbyXf
	Sydf9SzRoYAjU+t2SXu8pX7amEbXbfy8/NARpG+ZE9swwF9OJHHHQT+UrwR4tPAU
	gpCYpzEQKl4EoproGLh0zcbLi27nmblGorutwr1e+RbkFtuP4wUWhA0ZvacZLU18
	ioPUPa/fiSKNa51cY8IavxSHFYUR2WeP+85I8uEsmQmFLERf3iuliVBKoO2DuExR
	/tsfXf8ILlthCwqhuAhy24TD8XRczlWylfXbqJB7ED2ICkVGvQcGBT7cm3SyumEY
	XZthvJ8f9lektubFj7QLSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781160295; x=
	1781246695; bh=AOdzHf3iWIFe3SStbsPJR+/cWifPhjV1QCISugNeO8g=; b=S
	C6GmNfhAt2v4l36vkUSKFZGVNE/KIvFgbuFnx6TZcytxIJ3wb72QMpXIE6B1Ic0R
	2Ka4ExnnOEAf89Ja3ChBzQKqM4inGUvgI2ybvyQopaf+P9YUZGBCb/vFAPCwDQUl
	CJ2NfLAOQYT2qNg93d6ZMV1pdGc0y2E/h1YDExv7tOz/Nd3oB77r1mxCZV22nAUt
	hFj4I06Ua+hXKsyQOjgT2Sfj7EkKEH9DHczkvQK+WnwVPSBjpniqKR9uIPtdS9Wu
	g62QgMllgWqYJTd3rdLb5oYAMa6076c6J2yFUzcm1CQFlOKbD+4FHeI9gF3A27Zh
	CZ0mm2suuDRE/wGnmtXpA==
X-ME-Sender: <xms:ZlkqahD5TmmAYsdAdzHXR5yw5Jdji5RjpiHgCRog0rZN30Gs-7yfWQ>
    <xme:ZlkqalgLuB20f0MlE492mG89KnTtRxkQ3LE44rfBJP2P6k9fAwacC55iGso_5znaZ
    bGb1XQLHB48mtkTJGCgOM-i2vNdpSzx6gm9fhdHHAJ3VMTca9bG0A>
X-ME-Received: <xmr:ZlkqaqPa9vp1beNl06nbN-IvG8g-c7JqpCkQRUqLmYHXx9PF7oCNSAobeBK5yBadzzpcRwTlzqz9ThauE7Sy5ZzEQ4EMN-rMx-Zk1jPjfMcc>
X-ME-Proxy-Cause: dmFkZTF/+amKZAWEfZ0XKC1clGzeEdUQ0sbNVPmfkao1bjuFszGMFlLsNP6VIL6nYaFhf8
    KuZOlpXDb1+t+UjZzn+rooZ63IyyiHIGHw09HoJoH9KXxBBj+o6sqMXMiAdGpIbsou6I7U
    7SECo8r2jLbqxNxaKEsfWCXGgIZJehesKiCeieg9aFozFaYm4wMsH6ArmFJuaSmaDJUEuX
    X0++evCOGiHAiDfyOmSU+MO7I8nUHuXRF43lJrXyZVLyGz+nBstf2CfiAOFg8A9zs/xB1H
    x33NIndHuVLmXhfJridtUEJvT8M5hbXbLkM+mlDXo3gtSuC3qLjhY4A9mkeHuuoK9wvjgr
    Kf0526yNYI6A2Tgd9EpmanjbhG4CnhnfLXG8al2+m/NbDxlGQtTE8KH5gnyrmEy+/AkxjE
    FCeusASHYVR02XqaBX/b0jhZUSkSxZZB67aiCc8fEJC2NKjsQNs6z8qu1KLofynT3h5Z3v
    qHOdX6ze4sMbl8ViOP37VRjO0ZN9FEEX9rzxjlYmgy2tKL6B9E7sFRpFm3cVVlxAs2R6S5
    wdTyP+QC6YgZ/4BIyFD8hSNgAOpCdd4rM17tGjjMuWWKQdmy+0LtnjJQPehBGB2mk2RBRd
    6ys4OI1wpY+Swm4cXhpo/R5J8ZvZlNeAo0tPZe5xWW+eFB2h6zTbgxp+3o3Q
X-ME-Proxy: <xmx:Zlkqam7Sp7MOpljIdNPasPrJ2FUCuk1AFU9fkgoo7Hwu6aR4Ilga6A>
    <xmx:Zlkqao3qsZBMs1sum75J6TI4iSR4K_NU-R_KkTbDT3HPOuK8j2PKsg>
    <xmx:ZlkqanZ3D5Im4UbtMAdV4aM0-RVvzeE9H7fOXQG52PzOgftJEwGf5w>
    <xmx:ZlkqagCURmZSQ3f2sDBXiqS_2V47t7K42K4nkg47F6bGo-QAY9TyYQ>
    <xmx:Z1kqagwFc38DrcsLbmcMZLqLP66iac7QKtv-5t8oUeo9X1dUQ_Xa5PTm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 02:44:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 77a436c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 06:44:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Jun 2026 08:44:42 +0200
Subject: [PATCH v2 4/7] builtin/init: stop modifying
 `is_bare_repository_cfg`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-pks-setup-drop-global-state-v2-4-a6f7269c841d@pks.im>
References: <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
In-Reply-To: <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

We're modifying `is_bare_repository_cfg` in "builtin/init.c" to indicate
whether the newly created repository is supposed to be a bare repository
or not.

This is ultimately unnecessary though: when initializing the repository
in `init_db()` we eventually set `is_bare_repository_cfg = !work_tree`,
so all that matters is whether or not we have a working tree configured,
and the working tree is set up in the non-bare in "builtin/init.c".

Stop modifying the global variable in "builtin/init.c" in favor of a
local variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/init-db.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index b4343c2804..52aa92fb0a 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -81,6 +81,7 @@ int cmd_init_db(int argc,
 	const char *template_dir = NULL;
 	char *template_dir_to_free = NULL;
 	unsigned int flags = 0;
+	int bare = is_bare_repository_cfg;
 	const char *object_format = NULL;
 	const char *ref_format = NULL;
 	const char *initial_branch = NULL;
@@ -90,7 +91,7 @@ int cmd_init_db(int argc,
 	const struct option init_db_options[] = {
 		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
 				N_("directory from which templates will be used")),
-		OPT_SET_INT(0, "bare", &is_bare_repository_cfg,
+		OPT_SET_INT(0, "bare", &bare,
 				N_("create a bare repository"), 1),
 		{
 			.type = OPTION_CALLBACK,
@@ -116,7 +117,7 @@ int cmd_init_db(int argc,
 
 	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
 
-	if (real_git_dir && is_bare_repository_cfg == 1)
+	if (real_git_dir && bare == 1)
 		die(_("options '%s' and '%s' cannot be used together"), "--separate-git-dir", "--bare");
 
 	if (real_git_dir && !is_absolute_path(real_git_dir))
@@ -160,7 +161,7 @@ int cmd_init_db(int argc,
 	} else if (0 < argc) {
 		usage(init_db_usage[0]);
 	}
-	if (is_bare_repository_cfg == 1) {
+	if (bare == 1) {
 		char *cwd = xgetcwd();
 		setenv(GIT_DIR_ENVIRONMENT, cwd, argc > 0);
 		free(cwd);
@@ -187,7 +188,7 @@ int cmd_init_db(int argc,
 	 */
 	git_dir = xstrdup_or_null(getenv(GIT_DIR_ENVIRONMENT));
 	work_tree = xstrdup_or_null(getenv(GIT_WORK_TREE_ENVIRONMENT));
-	if ((!git_dir || is_bare_repository_cfg == 1) && work_tree)
+	if ((!git_dir || bare == 1) && work_tree)
 		die(_("%s (or --work-tree=<directory>) not allowed without "
 			  "specifying %s (or --git-dir=<directory>)"),
 		    GIT_WORK_TREE_ENVIRONMENT,
@@ -224,10 +225,10 @@ int cmd_init_db(int argc,
 		strbuf_release(&sb);
 	}
 
-	if (is_bare_repository_cfg < 0)
-		is_bare_repository_cfg = guess_repository_type(git_dir);
+	if (bare < 0)
+		bare = guess_repository_type(git_dir);
 
-	if (!is_bare_repository_cfg) {
+	if (!bare) {
 		const char *git_dir_parent = strrchr(git_dir, '/');
 
 		if (work_tree) {

-- 
2.54.0.1189.g8c84645362.dirty

