Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91EC3D5C2A
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408928; cv=none; b=UUx3n7kFd7sMpbwx58wNQxQLj5VefFSX51+wDdeJfXp2iD5dOOgY5vP5xqq7En5Fns1BIBcuGO3CJVX0c9EJgsLZvbKUKGKBsfa6HGNfTIc5ThLq3HMa2ME8I4L71fD1SKlLxO7bRUIMXRXCvsZ8rfOqmmYPlcbHdoKDjUdsI78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408928; c=relaxed/simple;
	bh=SipiGkpxGW2cMGfxqfn6mFyVglLkqUtNEO3+gYGSbVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=co/TBHyM7WfoidcCDDm/ySY/OhMuZ3TwfL6NJD7+NqSsHAU8eminoXnIJVnaN9IcMVT3sGVCKCnjln3j5Y12pIP7WGA9OQZ01jQjLvjmVkMXSvpGXEmlOcr7/IsxQ+lDQESdEu/8IA0G+X459f04WMcnpl2JLaQ7sQLtaP/UVRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jpt9arGm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ax1Ke4Eb; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jpt9arGm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ax1Ke4Eb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 68FEB1D00153;
	Tue,  7 Jul 2026 03:22:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 07 Jul 2026 03:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783408921;
	 x=1783495321; bh=8O0xe6NcuOjPjg5TaL991gwi/RXJIkGHMh9pZgK/q4g=; b=
	jpt9arGm3knxak5kq11doQVuFirbhKTsyKfnfHLr/q30sw3MulybfjOa1sZwWeui
	1F3JUMpefa4Yvtz82ckG6lYcRdridIh/zyzN0NI6IHLuUn+6SXZZ1kSuwnoq/nZa
	TO4T9I0zl5xDWh4RMAoZqM/obJHr8oVe3HpgOfOz2JnZjEaKeRA7/vWwTwN+CT93
	u8mTfEq+oLz5oGtngAKXdSfo4sIcY/UWw4DdxHXn3YPhrDqwFOw8Wv8jbCGBjePu
	lpTo7e499QS+7ANDYE0MR4OUS/upLKeW8dmxbOCHvRQzil8r0drGYglpZHKOgO78
	MUjIdF4SVmhPDzpd00VN+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783408921; x=
	1783495321; bh=8O0xe6NcuOjPjg5TaL991gwi/RXJIkGHMh9pZgK/q4g=; b=A
	x1Ke4Eb+nzV3WYK0e4dfkTL1b21OabDa2hJYbXVO/ZyL5dQ7YTSEepIuTTI6s/nk
	uk3okhtJ7yKfYn3YgJZlN2+8BfqqwZFTWHeSgcfYXGxotP9jK3fMoFzJfOdZFNav
	YDVG7/J46cXEF/aVFJgIxYY4p5fQo2h4wOcBEPsfhupaWHWXDkXw4ycaMueFnga2
	oR4uQxb8co125qQTa0WxdIn2Ie5z5CBRhh/0+nF/CbZFSmJU6Wg/HpydLocJJBuK
	0D6JK8RDhil3OQzlHfwUr1JSmKPmTGm0NbwI48e67kYbRDJ24XCuKs8A54wdqWAe
	9WOtzcQX94NB6ED5nk2yw==
X-ME-Sender: <xms:GalMaqiS7OO3Leuet0Ad0JFYVUrfMPn5L5Z1yyOo0WsjiDGNoufx1w>
    <xme:GalMauRp266j2pmglCJY2HasWrh1kqplE3kXahuaZZjktxpHZCxl-XgxdO_imaXAO
    zJMKkH19RrBPztsZraRFZ2ahSoNGW1SswMrZe8L_ymDsy52F0Q_PQ>
X-ME-Received: <xmr:GalMarhxidNwD4mHOCx8hhjDkTYAFCTr3S32qSrG5ov9-WS731oewvlyq1rlOoe2iN2FL82Tju4OPDAnTUwMSWIOvWyce_u3yATAamTAaw>
X-ME-Proxy-Cause: dmFkZTGmQpYtT6Apve4KQe7D4X93KYsvL/LEsAiXaXhbfkBm/nau87rWi39LKPEOvana1k
    y57lt3Un8wWzhDonY+n+Fyg/VWihMy+E6BwOfc8vl2XevBtLbMCwZRHbl78Dg4sJ0Zrs61
    C/1RUD1STabv1VBmqETrX7LrR17F6qEQnY5Gmf59q1JdDSK0FWyVp0pAIBVjr3NWBd6mQa
    pRe/14IU9y0Pupiw/PlO+kTtdw+vVuripirbXsK4EVrUI7Ke52VEZBbIQ3wo9z5YMmzaQz
    HqsE3579xzgh9cw3mUrNR1L0wJ9Xfrli0H3Aly6UUuM3gxkgoJG28chrqn1yreXiZl2mqS
    JS3nOktNn8uq8R3vUk9Xeu7f+CRsY8AjaYO3Uk7nx143qBUcY7X0XvfaDGU57IFDGMY4Ao
    t11dzLLuMlZcbkM7BOTKozkGFdnXQDhU2KqqTv/rejkCl2D9uPtm71ou7ZcPi9y49UAsrg
    qJ/4xg+g9jX/gWC3OxmrW57B8Xul7V9RFdwXOXnKx7QHOBpr/RqWJhi9o35+2rSBFVtGIi
    f0c7rAA8YVZU5szXbTsdQoFHdgaGormhcrYSsoXh3nwpdWkUNZaD4poaQA9ZbtUpenjW8z
    0CeKglNWSdq3AHlDmPLwZavuIntW7hypUycbjoEqamzlfZKzneDe7pK2OfBA
X-ME-Proxy: <xmx:GalMau42sl30VFF8YDIqc50fXbz0nRQhOtEeiqzeiSbWZ4hR8HqOVw>
    <xmx:GalMaoC4NBSRr5rOX0bG9sPLamcdqBO-wIj1uUZUxVg-qI2ntGxiwg>
    <xmx:GalMalaYCHwA9boSGFRwtk6qBZDefgskNYiFYGsIh4vjt1UZrOfuVg>
    <xmx:GalMajbh_O6h_wxYeabyW_j_4rAqG5jA64-tuNF4_4OGqIzY_C1GUA>
    <xmx:GalMam6j3bvGlojRNXOKWL6xN0vdcPONlREe_OhVhYknOQSKqexUdxes>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 03:22:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3c8e50b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 07:21:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 09:21:31 +0200
Subject: [PATCH v2 12/13] setup: pass worktree to `init_db()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-pks-setup-split-discovery-and-setup-v2-12-aab372cd227c@pks.im>
References: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
In-Reply-To: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

In the preceding commits we have refactored how we discover and set up
repositories so that we cannot end up with partially-configured repos.
Instead, we apply the gitdir, worktree and repository format in a single
location, only.

Initializing a new repository has the same antipattern though: while
most of the information for the new repository is passed via parameters,
the work tree is instead propagated by configuring the repository's work
tree.

Refactor the code so that we also pass the work tree as an explicit
parameter. Like this, configuration fo the repository happens in a
single spot, too, just as with repository discovery.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c   |  8 ++++----
 builtin/init-db.c | 34 ++++++++++------------------------
 setup.c           |  7 ++++++-
 setup.h           |  4 +++-
 4 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index d60d1b60bc..9d08cd8722 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1116,7 +1116,6 @@ int cmd_clone(int argc,
 			die_errno(_("could not create work tree dir '%s'"),
 				  work_tree);
 		junk_work_tree = work_tree;
-		set_git_work_tree(the_repository, work_tree);
 	}
 
 	if (real_git_dir) {
@@ -1186,9 +1185,10 @@ int cmd_clone(int argc,
 	 * repository, and reference backends may persist that information into
 	 * their on-disk data structures.
 	 */
-	init_db(the_repository, git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN,
-		ref_storage_format, NULL,
-		do_not_override_repo_unix_permissions, INIT_DB_QUIET | INIT_DB_SKIP_REFDB);
+	init_db(the_repository, git_dir, real_git_dir, work_tree, option_template,
+		GIT_HASH_UNKNOWN, ref_storage_format, NULL,
+		do_not_override_repo_unix_permissions,
+		INIT_DB_QUIET | INIT_DB_SKIP_REFDB);
 
 	if (real_git_dir) {
 		free((char *)git_dir);
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 566732c9f4..e96b1283b7 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -231,39 +231,25 @@ int cmd_init_db(int argc,
 	if (!bare) {
 		const char *git_dir_parent = strrchr(git_dir, '/');
 
-		if (work_tree) {
-			set_git_work_tree(the_repository, work_tree);
-		} else {
-			char *work_tree_cfg = NULL;
-
+		if (!work_tree) {
 			if (git_dir_parent) {
 				char *rel = xstrndup(git_dir, git_dir_parent - git_dir);
-				work_tree_cfg = real_pathdup(rel, 1);
+				work_tree = real_pathdup(rel, 1);
 				free(rel);
+			} else {
+				work_tree = xgetcwd();
 			}
-
-			if (!work_tree_cfg)
-				work_tree_cfg = xgetcwd();
-
-			set_git_work_tree(the_repository, work_tree_cfg);
-
-			free(work_tree_cfg);
 		}
 
-		if (access(repo_get_work_tree(the_repository), X_OK))
-			die_errno (_("Cannot access work tree '%s'"),
-				   repo_get_work_tree(the_repository));
-	}
-	else {
-		if (real_git_dir)
-			die(_("--separate-git-dir incompatible with bare repository"));
-		if (work_tree)
-			set_git_work_tree(the_repository, work_tree);
+		if (access(work_tree, X_OK))
+			die_errno (_("Cannot access work tree '%s'"), work_tree);
+	} else if (real_git_dir) {
+		die(_("--separate-git-dir incompatible with bare repository"));
 	}
 
 	flags |= INIT_DB_EXIST_OK;
-	ret = init_db(the_repository, git_dir, real_git_dir, template_dir, hash_algo,
-		      ref_storage_format, initial_branch,
+	ret = init_db(the_repository, git_dir, real_git_dir, work_tree,
+		      template_dir, hash_algo, ref_storage_format, initial_branch,
 		      init_shared_repository, flags);
 
 	free(template_dir_to_free);
diff --git a/setup.c b/setup.c
index 088e7b85f7..683b8e65a2 100644
--- a/setup.c
+++ b/setup.c
@@ -2823,7 +2823,9 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 }
 
 int init_db(struct repository *repo,
-	    const char *git_dir, const char *real_git_dir,
+	    const char *git_dir,
+	    const char *real_git_dir,
+	    const char *worktree,
 	    const char *template_dir, int hash,
 	    enum ref_storage_format ref_storage_format,
 	    const char *initial_branch,
@@ -2852,6 +2854,9 @@ int init_db(struct repository *repo,
 		git_dir = repo_get_git_dir(repo);
 	}
 
+	if (worktree)
+		set_git_work_tree(repo, worktree);
+
 	/*
 	 * Check to see if the repository version is right.
 	 * Note that a newly created repository does not have
diff --git a/setup.h b/setup.h
index c01a244fe9..bf3e3f3ea6 100644
--- a/setup.h
+++ b/setup.h
@@ -263,7 +263,9 @@ const char *get_template_dir(const char *option_template);
 #define INIT_DB_SKIP_REFDB (1 << 2)
 
 int init_db(struct repository *repo,
-	    const char *git_dir, const char *real_git_dir,
+	    const char *git_dir,
+	    const char *real_git_dir,
+	    const char *worktree,
 	    const char *template_dir, int hash_algo,
 	    enum ref_storage_format ref_storage_format,
 	    const char *initial_branch, int init_shared_repository,

-- 
2.55.0.141.g00534a21ce.dirty

