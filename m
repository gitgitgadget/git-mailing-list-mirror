Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F61381B1A
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074619; cv=none; b=nm9kxOaVUQ4WdkdAdNvgioadDFSBWfQi+bUyidSrRgwRuZuKXNjms/wicsXDQtylXyFPTPRemRhmdfMFuuD/ReM/aSGKqGYhve8gqObgpelkS4A8/JkgZtmapC7x7HVNcibXVJuzc4BTTe7RZrCHdLAdbCoOHEp96VZvOuhAjNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074619; c=relaxed/simple;
	bh=eWaV0FVRXfhEyQRWtGtRPTxwTnaqjewwFvIvEMOD5wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d3ak0GZBIqIVPW+fBQ8l6d3dFUEGkUCRLkFaSkdCCrtqoYouYi24e9EEeOSIbp6dhZk02FywHfA83amJ7kYjBXjpSOO9mwo0TBXRV7uhHxpCcdFbqDjASW3x82nefwKWAsr000SpH++mo2wj++nIzkATVcFt3yV4wNqHkTZvt/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BJYmoq3S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RFUwqaGm; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BJYmoq3S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RFUwqaGm"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E2ED41D00106
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 02:56:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 10 Jun 2026 02:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781074617;
	 x=1781161017; bh=6RQgDuL1lka1VG0REOorcBlJ9lAIxPLVc8wxaJ3SheE=; b=
	BJYmoq3SXWl9rOFhspGkxKbXaUj5QWZbp2IPcbIpOLINxLL/yqvsWqVCuIykZ2IS
	aZ44gK1/1RCUZ0NczgzhBzYGSRsSTcuNzkUK5XA9tClDTgBPruDKOJctJjhweULi
	zW5USS0wXE3/iP1oIpNMNcAYH+jFbw1f6JtsAzTQcFd/yBz+NyT4PYmHHad5rx2W
	aWm+syMDJlFiO1sTC0UVJYCJTjJ2Dij0TUIU/GgfEd57JfHGI6QadvpYjhBcWnBY
	onc+q/It5C3uIn7IGh5haZA0kxUSl6EuzajKPIsL9AfRbPTIdA2pO2GAa8kQg083
	1EaRj6PG7OFdqI/ZWxLW4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781074617; x=
	1781161017; bh=6RQgDuL1lka1VG0REOorcBlJ9lAIxPLVc8wxaJ3SheE=; b=R
	FUwqaGmgjTjG/KBfKGxtBgvuz2JOqaPC2B4XBCUqil3RgxP5blRhpMmf/gA696w/
	ptHb0ctGzSsU9IUUqE6w4zwXcOqArB4Meq9Dg/gkKp2cEIU+Mo6kpSX7CIQIzxkb
	e+dfHDrgLwTcqh9w12RzK1q8r/MWvVPVd4FTcOhzT9gcxp0OoMtdcSZdxQY9wtnh
	+LR/pguxUJKJYvP5EMQFYGYf9uRJY3tb70ruEi8Ct2m21razO8gII/FAu+te9JMt
	VaZLxI19eZyAWhOV3ry8rOhP+iYtKnOtT6gEBYGh2XByD5sEwjoZSPBFsbDULaiv
	CjOQMOojLiLDhL4zV06SQ==
X-ME-Sender: <xms:uQopag_EjGQJB5NWFZGbHzSysh-Aole-MJbYz6XQCKvQl6HVaz0-DA>
    <xme:uQopavoIia6Ccixo_jQbD-Kn23fUlTEODttFyQuewUCsSFB7jC5ddQu3urnqWHu4R
    71Jrkd_D7lx7Q6lrR0pyYLr0LREYeQk_HjuEI6AluX8XXCPZ2Am0wA>
X-ME-Received: <xmr:uQoparrZA_3dI-0BMdbXinX7N-Wp5eFW0ocqriewkODdtH_eOt23jImfY11tFcbVrRVJm-apEcgeSNHSMBEoCRLBX4Mv3iFn5sksdHe3wg>
X-ME-Proxy-Cause: dmFkZTE+fRa5nPv4UriTIlVhqvz4ROmLlrRq8TwPibW6u4ARyzYLMmQuwytcJlfdW7JokG
    sXFjuWt1ns3KW4bIlb5QjYadG7JuUn5FnJJvz00vYABRrtYiFn1q9Dto4PZehRa50i4mAX
    7d7OPMWbUACR1gOiHoI6bmdKK9qxpV6k+grHKE0IdgT4KbRpAooCDM4YCTRIyeNbP0FTpk
    BPfExnF/epS9kOj4VGhoG8CvF9lb4/uGP1lvDmzrL5hBAOL6qVTfMuRs5b+8J/mHVDC04V
    fDUsV0terE1rknnub5Y0G635TTwrnfF5AKkn+FMFzFaLrwMQtt7WT7C63NlsOokMke0+YJ
    /Lf+4OpYvbCXY0+KwQlPe2GBLcoX8ADP/PGMUEv/1Yq+4BdHhBclhhh8DZljSYfqhid+TI
    QuGm66bxl8u/NapSQKS/G6/H8ag+O6+p+HMwNew6P1Pu3yabZd/KTiWImI4MAgS+MlvVae
    HG+SFTZG5xCtn+1ZB/guGIf5//g25B+2Q+bNjbLCzUOse4GTHzWmkzyyOSo3hnrtOwmNTE
    cjxa1DdeCIqIH+la7XELmAtFFkw50HI7zDQ/5wf6/Ofkq+1GzYMx4oYnaXyVNt6kYHebH2
    YZK5ZmeUgyBSgNwcQ4kenxcB/6vfC2Ay4ii6nWObKfIjges6zjbj7EXmuW9A
X-ME-Proxy: <xmx:uQopallRLpxljyWdcxi1Uo8IZTpaXad-82dCCVpGhRPChKqkNQ-9uw>
    <xmx:uQopalGO_-leBO19Fny2YBfojY_BpghhEM4OJq36ds0vHyoRdIAQtA>
    <xmx:uQopampLA2718P3dzRqNDneTD_nlyy0nFFKhMPtF11h8sIY-UgGhSg>
    <xmx:uQopap5h303_uEI9vMtGKdxYmroajgmeEVdWXs6lKH4pmdIpEJeWYA>
    <xmx:uQopagupraLYasWW_wVPCk38TpXIlxdDCsS2MJKJzau3utN-wI2PkA1->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 10 Jun 2026 02:56:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1e7d6cbb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 10 Jun 2026 06:56:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 08:56:46 +0200
Subject: [PATCH 1/7] builtin/init: stop modifying global
 `git_work_tree_cfg` variable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-setup-drop-global-state-v1-1-5dff3eec8f06@pks.im>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
In-Reply-To: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When executing git-init(1) we need to figure out the final location of
the worktree. This location can be configured in a couple of ways: via
an environment variable, via the preexisting "core.worktree" config in
case we're reinitializing, or implicitly when reinitializing a non-bare
repository.

When checking for the worktree location in "builtin/init-db.c" we
populate any potentially-discovered value both by setting the global
`git_work_tree_cfg` variable and via `set_git_work_tree()`, which
ultimately ends up modifying `struct repository::worktree`.

Modifying `git_work_tree_cfg` is unnecessary though: we configure the
worktree in `create_default_files()`, and that function derives the
worktree location via `repo_get_work_tree()`. Consequently, propagating
the worktree via `set_git_work_tree()` is sufficient.

Stop munging `git_work_tree_cfg` and make it file-local to "setup.c" and
function-local to `cmd_init_db()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/init-db.c | 4 ++++
 environment.c     | 3 ---
 environment.h     | 1 -
 setup.c           | 3 +++
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index c55517ad94..01bc27904e 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -229,6 +229,8 @@ int cmd_init_db(int argc,
 
 	if (!is_bare_repository_cfg) {
 		const char *git_dir_parent = strrchr(git_dir, '/');
+		char *git_work_tree_cfg = NULL;
+
 		if (git_dir_parent) {
 			char *rel = xstrndup(git_dir, git_dir_parent - git_dir);
 			git_work_tree_cfg = real_pathdup(rel, 1);
@@ -243,6 +245,8 @@ int cmd_init_db(int argc,
 		if (access(repo_get_work_tree(the_repository), X_OK))
 			die_errno (_("Cannot access work tree '%s'"),
 				   repo_get_work_tree(the_repository));
+
+		free(git_work_tree_cfg);
 	}
 	else {
 		if (real_git_dir)
diff --git a/environment.c b/environment.c
index fc3ed8bb1c..4e86335f25 100644
--- a/environment.c
+++ b/environment.c
@@ -100,9 +100,6 @@ int auto_comment_line_char;
 bool warn_on_auto_comment_char;
 #endif /* !WITH_BREAKING_CHANGES */
 
-/* This is set by setup_git_directory_gently() and/or git_default_config() */
-char *git_work_tree_cfg;
-
 /*
  * Repository-local GIT_* environment variables; see environment.h for details.
  */
diff --git a/environment.h b/environment.h
index ccfcf37bfb..5d6e4e6c1b 100644
--- a/environment.h
+++ b/environment.h
@@ -149,7 +149,6 @@ int have_git_dir(void);
 
 extern int is_bare_repository_cfg;
 int is_bare_repository(void);
-extern char *git_work_tree_cfg;
 
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
diff --git a/setup.c b/setup.c
index b4652651df..52228b42a1 100644
--- a/setup.c
+++ b/setup.c
@@ -31,6 +31,9 @@ enum allowed_bare_repo {
 	ALLOWED_BARE_REPO_ALL,
 };
 
+/* This is set by setup_git_directory_gently() and/or git_default_config() */
+static char *git_work_tree_cfg;
+
 static struct startup_info the_startup_info;
 struct startup_info *startup_info = &the_startup_info;
 const char *tmp_original_cwd;

-- 
2.54.0.1189.g8c84645362.dirty

