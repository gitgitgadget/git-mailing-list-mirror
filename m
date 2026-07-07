Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F291E3C4546
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408906; cv=none; b=U3BjeRtqY0XbxJxS3pcqoAMmFmkMXhThhJUh+UiL+WNmSijYIGqbaGHSij3jHVJT4WaeqkvaohZM/EnpKVsMRwvlM8n1XRYU7eUeL+loFXMVicOUUTciCpD/+4QT0TSbC27Gz74L4purTBkthCc0sSsk8upCtPakSZHHFvQDP8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408906; c=relaxed/simple;
	bh=8sqllUV/DFnh7RJZMwsqJK6fMYtyay+Zp6IqZcNYt7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dNPWTGVtSoPRcqLEaZFi4lS8YYidy/uC473HilQ/tb4LUxQKH1OPoWMdxEuUzkuFg34LGtujLYwVWFGjCi4JyPWTWomWHX9br/HT6E87LhpputQsXGYosm1NOWGszEXgEylubmQ4/nln22qBaJD2XfscevdVmvtzuUBB4LjehpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MYjEGjm/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cKlV+F3h; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MYjEGjm/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cKlV+F3h"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5EA547A012C;
	Tue,  7 Jul 2026 03:21:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 07 Jul 2026 03:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783408895;
	 x=1783495295; bh=AzlgK3QNfA8LD59Je3w+NN7lSHiSMvRiYjcU9o0COK0=; b=
	MYjEGjm/xN7pSuMZvtIiTZRTX3AvrO/E/mdriT5taw41lvS823CipYq0Sssl+8D+
	iOfNFED9XV8bGtlzMp5HDH9wpOsYvHBFsT5EmGeyigeR7IrUjhER5ed/gwKhkO7+
	Id0MhAMbE8YemoToFCzt4RIURtARAmm637kfmLFLvLq6El4Oi1J9obaf2ArPTT1R
	TGA1/4hcn/9GCtCVPW3v9bst3MlfLhycTW9/GS8YJ9k0iFdRpv6qyIgND0Odsr+C
	WHCvHV1fW59RzYJ2l6Fim2o58BxShq6h+E6ysMTJwO/efQR1l3Q/USAbSbwYK9wU
	96sg/BEkxiSNe2+5xWHLhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783408895; x=
	1783495295; bh=AzlgK3QNfA8LD59Je3w+NN7lSHiSMvRiYjcU9o0COK0=; b=c
	KlV+F3hNc3xbCPw7fODyCyH3JhdFNWwrP1PLVxAtkAGoeR34+oZD6sYIZqDithUi
	lSIo+5s1siFQp+qkuZSWJzjomcY5m5OEGGqaBKG4OADx+DMSkXxVu0pCoUlR5oSa
	W4E8dYNeL8gpSzJOfJoPxE4LvKFoEgFsCKBkNsbpBM/yMFXgpnYvMgPyGnb19moV
	y+aIQy8qxJIiK7XQIcOXFOeLHLO2FDwXv7HhR9+FfUJ0V11vpn4vH+rTJGwbbcER
	2P8UqG2YFhM1zkk2ICEoqqcl3QKoW/rWOm8H+M+jLz6CY/xo2ts5LiRPkNNjSzE0
	SpSFpQyZoDl/1a2nyHcqA==
X-ME-Sender: <xms:_6hMatDRNK50H-YEDuxDhPfYDYAHBvXkmO0q0YPRB9MSl_EnLKtRuA>
    <xme:_6hMai8tkB6E1xJmNifS7Avuh8haQSI65vZiNO55-cnh7Xx9iOEkhJOYxQ3_Dnczu
    e0o4BZP_eZyEvxuRcOyM4DOpQqePbULAeIEzYGm7pzd9roGGH7UUlo>
X-ME-Received: <xmr:_6hMal9_zSnsx6vfM3rmkmaxVKo05wcyHWXCPopsTmnY9dpm3oh3rKJGDErp2dqTAxPWAuWTGyhhJDRgXhIHKUZ6avS24T0LfLBpRCDTng>
X-ME-Proxy-Cause: dmFkZTGAyfwDroKZieLnOSPugQnCDQn14Mmdt+3EK+/ESXAYfd1wI6Uk7u9qvA9t7LMY/I
    M05ShRmMN32YsM8ymhZ/gvlsp+/MrOY1dlkNg3iz1JLS4Mzu6tjPLsankE3BzkkDsA/4D1
    Rk3uCd7YloGMMrWbesWbGxgUQ4oijeptd8CziEzopMeRsibT0viLIL9afP4G69Uegwis52
    tAglxxzy6NVpHBQFKG9bl/FzZn6Ss67m3skr9mzNYx9FkUnQqH6SOards66DP/Bg2IYXVj
    OsSQ84uUwrmecWzn0xHXoxi4xuqQXdPKjRtawcEW390ufFox8a8XOVBcaILZY1knLHzhhY
    +oK2hHBQ6mgTc/7jG7LewNOjFE6xZkRngPk8YOGbXA34JdKXsN+q3xOthK6S7bBtnbQ2VY
    MbrSlTR5a8A6Y8VEBqWErqGqZ4I+LSNvlUKDgJ35OPVoCALpAfd3nU37fDjG9GvTWsGXVU
    B905YtZpJTVJ7K7r3RpSZlFyyxJguwye6K/VqXUPN+ROjzfKS5WVwpmLlIABPX6fOBXXfJ
    dtJByOWNV9b8jXbjKYYFyWREEeOR07XvvMaCqFpQ2zGJoFfIqk+t8lWyd4JCdU36kxisPa
    VqnXtsL1DZe2NtE5K8bhQ/ATChViuOzbVLy92KrLI2XWKyo+x3MdSQHtMPxQ
X-ME-Proxy: <xmx:_6hMahcZTSMF-cpasteZ111QgBvtADtgo_xZnj7VgQS8eYmZ4KjMJw>
    <xmx:_6hMamHU88njvM9H_BVs4WwcmtVHHBViAwRRh3l5GGJUIRYxYgMVQw>
    <xmx:_6hMancUnv-fkyJZ0chv3MjltoBHQ3E56Zm3QVRdVMNP7vvu1gsYMg>
    <xmx:_6hMaoGqOFoGWI7wA5DkGcwpjJ5S6V88Apfl9CEd27x4fAVKWUfeCA>
    <xmx:_6hMai-IOU2bOG4tq7h0fQDXZ1LeHHxnhf9ZCutgdRst9pgFoo9LybaS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 03:21:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c8393031 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 07:21:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 09:21:21 +0200
Subject: [PATCH v2 02/13] setup: mark bogus worktree in
 `apply_repository_format()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-pks-setup-split-discovery-and-setup-v2-2-aab372cd227c@pks.im>
References: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
In-Reply-To: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When a repository is configured to have both "core.worktree" and
"core.bare" we emit a warning and mark the worktree configuration as
bogus so that the next call to `setup_work_tree()` will cause us to die.
This allows us to still use the misconfigured repository, at least as
long as we don't try to use its worktree.

This condition is handled in `setup_explicit_git_dir()`. In a subsequent
commit we'll refactor this function so that it doesn't receive a repo as
input anymore though, and consequently we cannot set the "bogus" bit
anymore.

Move the logic into `apply_repository_format()` instead to prepare for
this. While at it, fix up formatting a bit.

Note that this change requires us to also explicitly unset the value of
"core.worktree" in case we have the "GIT_WORK_TREE" environment variable
set. This is because the environment variable overrides the repository's
configuration, and we don't want to warn or die in case the work tree
has been configured explicitly regardless of whether or not "core.bare"
is set.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/setup.c b/setup.c
index 118416e350..1d8c193375 100644
--- a/setup.c
+++ b/setup.c
@@ -1147,24 +1147,24 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 	}
 
 	/* #3, #7, #11, #15, #19, #23, #27, #31 (see t1510) */
-	if (work_tree_env)
+	if (work_tree_env) {
+		/*
+		 * The environment variable overrides "core.worktree". This
+		 * also has the consequence that we don't want to flag cases as
+		 * bogus where we have both "core.worktree" and "core.bare", so
+		 * we have to explicitly unset the configuration.
+		 */
+		FREE_AND_NULL(repo_fmt->work_tree);
 		set_git_work_tree(repo, work_tree_env);
-	else if (repo_fmt->is_bare > 0) {
-		if (repo_fmt->work_tree) {
-			/* #22.2, #30 */
-			warning("core.bare and core.worktree do not make sense");
-			repo->worktree_config_is_bogus = true;
-		}
-
+	} else if (repo_fmt->is_bare > 0) {
 		/* #18, #26 */
 		set_git_dir(repo, gitdirenv, 0);
 		free(gitfile);
 		return NULL;
-	}
-	else if (repo_fmt->work_tree) { /* #6, #14 */
-		if (is_absolute_path(repo_fmt->work_tree))
+	} else if (repo_fmt->work_tree) { /* #6, #14 */
+		if (is_absolute_path(repo_fmt->work_tree)) {
 			set_git_work_tree(repo, repo_fmt->work_tree);
-		else {
+		} else {
 			char *core_worktree;
 			if (chdir(gitdirenv))
 				die_errno(_("cannot chdir to '%s'"), gitdirenv);
@@ -1176,15 +1176,14 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 			set_git_work_tree(repo, core_worktree);
 			free(core_worktree);
 		}
-	}
-	else if (!git_env_bool(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, 1)) {
+	} else if (!git_env_bool(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, 1)) {
 		/* #16d */
 		set_git_dir(repo, gitdirenv, 0);
 		free(gitfile);
 		return NULL;
-	}
-	else /* #2, #10 */
+	} else { /* #2, #10 */
 		set_git_work_tree(repo, ".");
+	}
 
 	/* set_git_work_tree() must have been called by now */
 	worktree = repo_get_work_tree(repo);
@@ -1768,6 +1767,12 @@ int apply_repository_format(struct repository *repo,
 	if (verify_repository_format(format, err) < 0)
 		return -1;
 
+	if (format->is_bare > 0 && format->work_tree) {
+		/* #22.2, #30 */
+		warning("core.bare and core.worktree do not make sense");
+		repo->worktree_config_is_bogus = true;
+	}
+
 	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV) {
 		object_directory = xstrdup_or_null(getenv(DB_ENVIRONMENT));
 		alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));

-- 
2.55.0.141.g00534a21ce.dirty

