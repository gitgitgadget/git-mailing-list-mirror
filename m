Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39813E8343
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 08:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585783; cv=none; b=X9930ZUAZnb8O500n3xMhiwQTdh/w/vGxAWk1Of5igloGFM8YNejllWmWI8Lx6AHk1zTEtgj656MUW81lHdAgFBXtl2wXJG9OnmKlHOziTcKYa9Bnt5kExKKRGTxKIeqVCl2Qd9vv5trW7Zc1+AmCN23/q7Q43p8MLQ0WtHZp+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585783; c=relaxed/simple;
	bh=0qmvbfg+Wahw20UVU0g+TPJXk/jbKMC/IMHp0vpaI9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hiZoqskrA+7UPqYvSM+mDlCw7TCv2uU8T6URbHDuQQqmxpmUiSmJtyD9XsLcX5vg36Wn9jPX/amspTMjvxQOkX366uZE6ctrfmA2lL6pnNoXu/UaJKGFaBg4gKmr8/5UAlIZMGQEXLQQBNCsUIWLG1JUEqHNcQs+96K2i1VGcws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EfJ5KVd+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BWiTtfJ6; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EfJ5KVd+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BWiTtfJ6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 83EE77A0148
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 04:29:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 09 Jul 2026 04:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783585781;
	 x=1783672181; bh=fxIydexJcuDGSfaDHjH6aClFz5mc5+JFZ3Fa1fCQPgY=; b=
	EfJ5KVd+xN7fKuGQWoGt4vH4ta/0X6Uk0HKc3pr8N+GGLGm6NHY3LM+x664W3p7y
	sebG9dW4OySlE7noPEPF/ilVj80UhszdAaSoxVh2iJPf0HBJHX8g+n6/gIaK7ybQ
	PPs8uZlDWBjSlwegfbIiwPFeWfLdWbEtKa7G8tueox23DcxpRfQ8O9hogHr4qt4C
	gfG5CYIfe6rZxaqP+aBUuDGoUcspuXXKl+bBVZGH2YU666342+wgJ4RvKq9EvPSs
	OuW5Vm6POJeSHGWbh+heeongbDE9DT97OmBPlhV9xg/zRfQ7TB4jUwXXYOmr+qB6
	U7Qz/V9i1HGV6zeP6qen9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783585781; x=
	1783672181; bh=fxIydexJcuDGSfaDHjH6aClFz5mc5+JFZ3Fa1fCQPgY=; b=B
	WiTtfJ6FsyQUnWPeIHgpaxf+/n20tE3cM8+f99vMDxVQllIM0WVn9qHBP0i48XST
	8yPzu5jgHw7e/FCMEtW4bpsemToafxqpoVVS018fKKD6D+gv1knUYD4wQ16XMmVk
	S/0iNLe8Zvb+HgWz3ap3NLY0vfo9q+5MaWR0O+ry1mlKpG9PPHlP8oRSc5Q/sgug
	cxOK4u98JuCLN1qL0W2CUIHp2rl+pzsYhg36CkhNrKXrL9OPPMm43twazUTJuA38
	WpYkXOVuzJyNCeFEdCYuEm73pHqMoPzZgAi21RlOArfZs/LAyfne8C+H8CrGbI87
	o0zdawXqCVKOmymIIkcww==
X-ME-Sender: <xms:9VtParol3d3AiWh8BnOQiMSksW94Sklg4askTs0KIVdU8Mf40U0m4w>
    <xme:9VtPaslAJuFSSq_8CewK5RxGhPlnxf4I0qBwLGhCBGA2DFcV9cZhCaAmhfWyBMOIF
    U-MBMHxm4j4R5wCJ0ysObc3NjdZxQ4nVyL_GBMW2jrMYxBy5kCQYQ>
X-ME-Received: <xmr:9VtPat2W7L6RiWtDTlykvUNB29RPbQPm_RRzt7OaEYpYuJUg-engI-UrG_mtu8F8XVZrrNs4zDUiR5NNOOt4F58S0ytEKuPUcgfn4KkLxg>
X-ME-Proxy-Cause: dmFkZTF2YEkw3GlKnf422ZK5xSDrgKWTJta7tPPIkHyWCqHXCKhy5rtZsPXLbbmOx11qNK
    Pq4NZCgekSLabKFJ43kuYWKfKAOmDfq8N6a1JoNPhUlfj6dFYJE32jv/GWoLkGuvVFvYh1
    zq5pAouDeRUsL7DtvG9WnhKri5//eSQZZjV205PnlKxfoMR2D8WKzcW+5Efuuzpr2cJnnS
    iXk7lznZdezxn0TNtGMP215ib7jqCP9HQKWJoii0a3xtmubVd/K/r9f1knEQru8T7bU5Bc
    MyK05X0vc4MRvefkx7V9jZuMzTITaSpZCVzHdgtKrnGLOgYuqJ/vCFTZ+NjzkcKPwIYZoH
    cmQ/qJ6dPUycuqAfmNrYDj+SrdHzM072w5rcMvrSEcEyG3r7b3Octbz+HOwiATgLjWJtoz
    +kLWi+0qaFkXCSHPHfanh1eJqEVZGVj8W80Hq8yRlS/Vvub7bPG1e/ZuPBPDehFF/qK55O
    wHwrvKnGjWRVIeolq3wmmG5Fszn4FJ9UcnsRg+sfRbcawq3UB+Y+5pqBOWk1VpCQw0sc6w
    chiMG0F4nAhCWAaE4CTHee9c0kq2Su0fil3YLC/tTADXTrXEx4qmS09XJjsJiLA3QLVo19
    SzBrhA/g+Hw0bmJtoOUBHpvq9QTXjoR+2sT1MpOnqJTnb56WIl+oehK4RdSw
X-ME-Proxy: <xmx:9VtPakBLePwrLdn4cefyJ-aUN35qmnptvXRNW7Bc4LW6NOvYM1sT_Q>
    <xmx:9VtPaqx_-BKHvb7ON3ahnLsJYZ2bvIWnFuo578A5ok_JqMHqJD661w>
    <xmx:9VtPainRvfLik3yvTSrEo2CvqnOYuLtX4yejqgEnRNzLFkjrEUnWtw>
    <xmx:9VtPavHth1NYg7mwDXLKZQOOukhIoXLQNVavY3FZXzXC66TG6qFLYQ>
    <xmx:9VtParLqFYarYHP-uPZf0AEmK0zUzylstcLyBxQ2OzL8pVAZpP6oesEe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 9 Jul 2026 04:29:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fe7447ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 9 Jul 2026 08:29:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Jul 2026 10:29:15 +0200
Subject: [PATCH 4/7] worktree: refactor code to use available repositories
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-pks-refs-wo-the-repository-v1-4-1ad6f27529c9@pks.im>
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
In-Reply-To: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In "worktree.c" we have lots of users of `the_repository` that already
have a repository available to them. Convert all of them to use that
repository instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 worktree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/worktree.c b/worktree.c
index 30125827fd..8b10dea179 100644
--- a/worktree.c
+++ b/worktree.c
@@ -392,7 +392,7 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
 	if (!is_absolute_path(wt->path)) {
 		strbuf_addf_gently(errmsg,
 				   _("'%s' file does not contain absolute path to the working tree location"),
-				   repo_common_path_replace(the_repository, &buf, "worktrees/%s/gitdir", wt->id));
+				   repo_common_path_replace(wt->repo, &buf, "worktrees/%s/gitdir", wt->id));
 		goto done;
 	}
 
@@ -414,12 +414,12 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
 		goto done;
 	}
 
-	strbuf_realpath(&realpath, repo_common_path_replace(the_repository, &buf, "worktrees/%s", wt->id), 1);
+	strbuf_realpath(&realpath, repo_common_path_replace(wt->repo, &buf, "worktrees/%s", wt->id), 1);
 	ret = fspathcmp(path, realpath.buf);
 
 	if (ret)
 		strbuf_addf_gently(errmsg, _("'%s' does not point back to '%s'"),
-				   wt->path, repo_common_path_replace(the_repository, &buf,
+				   wt->path, repo_common_path_replace(wt->repo, &buf,
 								      "worktrees/%s", wt->id));
 done:
 	free(path);
@@ -440,7 +440,7 @@ void update_worktree_location(struct worktree *wt, const char *path_,
 	if (is_main_worktree(wt))
 		BUG("can't relocate main worktree");
 
-	wt_gitdir = repo_common_path(the_repository, "worktrees/%s/gitdir", wt->id);
+	wt_gitdir = repo_common_path(wt->repo, "worktrees/%s/gitdir", wt->id);
 	strbuf_realpath(&gitdir, wt_gitdir, 1);
 	strbuf_realpath(&path, path_, 1);
 	strbuf_addf(&dotgit, "%s/.git", path.buf);
@@ -658,7 +658,7 @@ static void repair_gitfile(struct worktree *wt,
 		goto done;
 	}
 
-	path = repo_common_path(the_repository, "worktrees/%s", wt->id);
+	path = repo_common_path(wt->repo, "worktrees/%s", wt->id);
 	strbuf_realpath(&repo, path, 1);
 	strbuf_addf(&dotgit, "%s/.git", wt->path);
 	strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
@@ -727,7 +727,7 @@ void repair_worktree_after_gitdir_move(struct worktree *wt, const char *old_path
 	if (is_main_worktree(wt))
 		goto done;
 
-	path = repo_common_path(the_repository, "worktrees/%s/gitdir", wt->id);
+	path = repo_common_path(wt->repo, "worktrees/%s/gitdir", wt->id);
 	strbuf_realpath(&gitdir, path, 1);
 
 	if (strbuf_read_file(&dotgit, gitdir.buf, 0) < 0)
@@ -1042,7 +1042,7 @@ int init_worktree_config(struct repository *r)
 	 */
 	if (r->repository_format_worktree_config)
 		return 0;
-	if ((res = repo_config_set_gently(the_repository, "extensions.worktreeConfig", "true")))
+	if ((res = repo_config_set_gently(r, "extensions.worktreeConfig", "true")))
 		return error(_("failed to set extensions.worktreeConfig setting"));
 
 	common_config_file = xstrfmt("%s/config", r->commondir);

-- 
2.55.0.175.ge4962bd3d5.dirty

