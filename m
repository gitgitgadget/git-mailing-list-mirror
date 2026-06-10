Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A727382368
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074627; cv=none; b=AVmPQDRXjlLfdbz27WGS6Rl+anFwxA3fb/qMPfqCOa++7wZutJaIRAnotpyj2uJ4GhjIAxNj8z+W16+7C3/bVq+tcOdQienIVgsRh5brn5KMa7P8jqfeSrarLWZ4/b0b12erxbTlMm1Finu8iKTZZED23MNRK/bKay7WoM3YndM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074627; c=relaxed/simple;
	bh=1zJUIfVP0yZ4TeZtwHJjH0AdaZf/P1RjOweeZFkrgcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NE83+WOhygEvGg+HTT28IX4rfxtqvCelCDh3jfHKQn+ZmxREDATiwah9vhVmvwZ3TLgxIgl0PgfhsQdzAmNw/IuuAljtSYr/YPKDlDCbXblSSQsn75t24l2h5TP176E9xnwys2FV/LI6UvHGbi5Qhaj5Pz7k7OPVh5eLTr+YYFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jlQtS/IF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RKyIiBbG; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jlQtS/IF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RKyIiBbG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AB3147A0108
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 02:57:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 10 Jun 2026 02:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781074625;
	 x=1781161025; bh=AOdzHf3iWIFe3SStbsPJR+/cWifPhjV1QCISugNeO8g=; b=
	jlQtS/IFqhByTB0s5zBxaUVHacnOROjYWrN14ayxJrOgesq+Un/GGOwuj0F2pQZA
	dQghLhlPC+F+IWXYP0YAYeMX2IRtnWY+7k9yCN9+r72kGyq8Cji2XkVY9niqDI/L
	7h9dhNBwzuQFItPG+f0hUqbl0FltYv8ZnzzUVlaeJog0/ISizSrrmPnizszci1km
	i4JuD+gqyQ+lCN82vnLyzAsOnfAmerj3Ud5JBwuOXoxJZdFRSYi17yO6uXfubKeX
	bnP9CFH/893+S1Sd09iNuwQUQ61otjf8vScfj4hGFa3IV9p3iFlir5nhdIMgWqVu
	TK1GdqTYl8eKjwu6kfjoeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781074625; x=
	1781161025; bh=AOdzHf3iWIFe3SStbsPJR+/cWifPhjV1QCISugNeO8g=; b=R
	KyIiBbG3or5mtdze2CN1oe67QIQbqfz6myYY9yt4UNPuts5PO2MTHgx9iYlMc66r
	o4EJyGzDpQ5jUj5GhOu+qLejnmN+ltgcAmrOoQlWFEmRWXV4qLiDbcNbJLOCP5hq
	V6FXc587Z0MYz6qN+mLzkBd9ZZ8g4mqCodK93Rtl1l0Xd782n4K2V2KrQBxkFRLA
	7/calYFW+3ArhqdvEICopRVUtBXobAoaS2adoNs6OK4r21EENeR2YzhIsZz1jyUb
	tig1OTgP9wJYB/MlhRFZNRXoyihEuORbMjEKDexgjajkPHCycb8dXM9ri0Y9k0hA
	CpWdpLNlEtX+LEWrxKarA==
X-ME-Sender: <xms:wQopau3Q_OesQixkWZySGZUDx2Ky7yECP_yg4dwTrQ6wVfzs2Zl6kA>
    <xme:wQopaoD3dbFocs6r6CzC-YcjHjqfHg5U1x75IsA2n77a153UOnbx0fx3CGDnEj-cF
    tBTDFzNqcSAnKOomNRJ3uuUawOcPvMTMSZu9ewTTEEsruAiHsiEJg>
X-ME-Received: <xmr:wQopasjMuTH34pma59Mrz9v87v6-sZgYmZYNLNdhZ0K6J4CfSGuhPH0iOTBCLJgaV1Y2rQ7lCGvLfznFkwV0Dzrv0-pyomm4x-j7jtJn2Q>
X-ME-Proxy-Cause: dmFkZTG24ZBvDSK4CvrR8bovwQcTp3UFfnMVqu0y1abi4aT0IJNKC3HCbt1QXBfQR4Nf39
    rX3qF7slQe2GiIcHObaWFUHstpL8EEe7Z0pX+5ERIVfEXBRMiMrQAVet3vridDH13dbKJ3
    TEjZAJd6reYrQZgftF4g1QDwkyqt3ERzz+NXphShDxRnCk7uC5Jmp3x0AMDuC3r1mE5c25
    zoMtcyxHgNvqr0XuCNsa4RJ8qs6M6KAPezKigN3waW0yW+rr/odb0BbsLCVovoqn7u89bq
    9n50rJCx5Yh4NWkeEKx73KAiX869jmTwxV9nFCSxvsNdHFIOCAnmYwQ2wMBpICx6jELPI3
    i0y0z1XydSo+y07Fikcap4OcqYmb1PKHVSccnaLwfKIp+UTs4vfc8wJKIDI/LvhyOwb29t
    Hf9FaVppvROpkhG1vEnrTBwmvx0osmyJ2qt3KuYU998zARBg1ywHGWlcCd1w0J/v6uyD/G
    h4ToEimKDcGc4FpxOjeoI5FSvU07wvrlLfX7mz2cr8wqrUkqxn2TTe2g63oWIUeDM9wntq
    +jU8o70kOnbZGwP56Jv+svAOS4BbPt08+Qmk8SvfzTt9YnA+b0hjWPl3AmZAPA+1tWNgSJ
    vMuLs/NMexg5NVGirZHEoQMEr3/I15LNwX8QbaqYjZGvwmD+cjq/jqHdmqmw
X-ME-Proxy: <xmx:wQopak9i7bp3bAxXuvMk0qFyi6WXT0OUFpDNhlPSKVCwbtwvFdycaw>
    <xmx:wQopag_LXqGDZHVvTDPf0cRlx6HxJM8emOvDkArKuFs5zrVd1Ep9dA>
    <xmx:wQopalDcStXQegOb8LOhlC6vJ6qhewSih7519s0qgiLGY3ToYl-HDw>
    <xmx:wQopaoy3jptK3lRr1xiEcf5hYcEBC4PNheYT1gRIYoEBml3O4BQucA>
    <xmx:wQopaoHjyt70xAdL9Zx6Jik3ZAr_Pr7N-nvsMC3gG-XSfOnb6KIf7CaH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 10 Jun 2026 02:57:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cc2b0ba2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 10 Jun 2026 06:57:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 08:56:49 +0200
Subject: [PATCH 4/7] builtin/init: stop modifying `is_bare_repository_cfg`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-setup-drop-global-state-v1-4-5dff3eec8f06@pks.im>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
In-Reply-To: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
To: git@vger.kernel.org
Cc: 
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

