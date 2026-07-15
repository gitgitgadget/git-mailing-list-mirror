Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D1197A7D
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101191; cv=none; b=e8z5zSu63ycw7WDkLXz3O5AEE65dvlovZoZNAmuSPLSJOW7Hq0cHTlddUl+lS0SYScnCQ0kr+YQ0CSqGxV6twHrkc/h5HGcJdvJpyc+OQwUSdCxv8mQ/BHcg1bvKi34i929NLiG/Rt/zcxkYz51uQ+G1Ogmtrf0U9Jlr30T/OWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101191; c=relaxed/simple;
	bh=/7OeZX+aS1+yAx24DCO39vgd1nOUxUZv4+5GhWWtVJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gjPQje8QLb1PWXqgo69A6zAcSPaJkErQmFak82YyT+L5otAmUVOFqC8AqAgUz6ypp9q3KOPwzxWUY/4ENJoSPD65Ac8hQu+W1S7moPRcTf+L0SoFL8URhb51D+EZgOBy/sSDKdTAzB8QbLBo3CWJFpRCZnpm6YpMfIxAFhRPAt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DwV71tI8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F1fS3jT0; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DwV71tI8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F1fS3jT0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A2BD7A0144;
	Wed, 15 Jul 2026 03:39:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 15 Jul 2026 03:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784101189;
	 x=1784187589; bh=WCVaJmA8MaWpmCzERrVhKCq3pVzhyir5SV2a+rKzCp8=; b=
	DwV71tI8klmXPF+d153HewNDxW7343jos/t7nnJiO4KJFR+rdsoUhTbJQJ81osa3
	S8okcZccZZnP9mLUE3p/5eTxI4acFVG0jzcfscxHe8FcPIDi2HeLthD0dJVJ8Dxo
	yyr1qrWfK9VNmZKHfrCK3i/uB/A4oq64dDjbPidSvU4xQTPdtLK2o9Dh/UHf7Z96
	hyjhWFWwqNplgAK9DhJRaPGSZOpte8mJrxQQjaafaYggvOGOO0sIoD57A2nYMiSa
	F2qB+GeNGAszyBnwyxaJLsWTPzCxKW8c+s2Oab+tNPch1SVO72kzzTTbLJxneWZB
	Z6SE3xyeP6rKAGlMJDItYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784101189; x=
	1784187589; bh=WCVaJmA8MaWpmCzERrVhKCq3pVzhyir5SV2a+rKzCp8=; b=F
	1fS3jT0+lYZ80OmvRwi4r4tvcdSJNPmcertx0IFSlCacqPt7G2gOQEgihlnXxU4r
	d27i/DKJ+D86NomidUjEJD8Ao+jYqAnHnC6HCSMFByVgKpJjufmjjpLpcH1iHK2W
	XzbReZVX+WLroDV6rVlvzvzqfPQMb/DWKRlCuRwkDhl+OULsbKEQCxs/f5wxzy0m
	S9grQwwXIBZrDCOcZBA/dVGuWSZiXc/TzsU1VAzZee5k7yJI8Oop5JXkuPNnDSCu
	jLA+JTTSPCYAHOWbpbghzQm8uvAsZDZ2YVOeVGZSrwm4L6clnBlrq+f81O2BbPTd
	sfoqJEqJW13+H4HO+cLGA==
X-ME-Sender: <xms:RTlXatJJ57ZriJADLsu7oMBeO6W_l8FdwvmQRyXqdRzZtmz_4tuqNA>
    <xme:RTlXavK5-K73dWrlNpscgiggLw6i3OpE7ZAfeDr-l5pttcOAofGTssg9DWxx7omcg
    qiAR91XHdRsJzEBEYhIjJ5MrGs-qQrX7AgVqfXHIm6v203Mf_MURA>
X-ME-Received: <xmr:RTlXajWOV3KEwtqhiqMOG3hd34Sa1wVTKS4cTs4obfva_HMqnMdCQnDAonMKn2r9pYVTdVAp664fDrYIT-74pO1FRMTHsjb8qP2vX3IBLtQ>
X-ME-Proxy-Cause: dmFkZTE8kcxFSyb+drJLMk0DIjZMqgd822Wmf4Ur1AdgU508Yw3Nne5WOv5zrm6QA754Ea
    4SfjMsSPxY88tVfJAWj5HxfDfiwe8Ks3rFh4utGxX4rLgIcuZDkO4fXZLbSyhwmpYpSUnh
    TNGRrNpsJfjIuw7MiDOdw7M7OKWHk/4ty8a1dpMyW+n5zL1sRiB7wF9jnYfW0l3f5ylNRF
    yXRGcEZ4xhYz5+WVR5FaRFwqoKzfdY5DC3TCFKZolbzt6jltVQILnYGcgXM6vPqVzFXnoL
    Nax1ld4vBpOQVkkv1jKd2LFzI7uJsC0gLtlViDbI3F/lsVWR7ZzoNEHCRzhdpwtAbz6GO4
    LIc5bB/uU23XO2YDuCyOEHZzwbI0vG0PB459Ipap9d7z4gFRruc6Zi3l0MMtavT2IZox/d
    qKIt/XCDZNceoEpU5zzZoXCfn+fTL0Ha5zlBUyO6LwSnobLVKXoCZmb4X0aqvI0yINkGT/
    QXZwBqDtAaOxlm8fIDjNYJRiN8iAZNaN27SkWpgjlHnORN67d/WTxZq6q/o5wbPApwwZn/
    xn5bpqPmDkxCchb+ErCle8uaEdWK4IEa4T6adSuGIq/MJ5xRudmKlXwn6bu4pl3r0HhVDV
    mgcS78wESERoTBN0309OanqJpSrKQPyHLUZy4SRBYdKIwzxObG43s0F2cl4Q
X-ME-Proxy: <xmx:RTlXaphzwY8Q0eUhPSYoAoaSM-KjhJveYFaDW-GwAWiyHfa-TS7ZmA>
    <xmx:RTlXam9FH03u9VVm6z23A7m004EeVLymw6E4IImLXOnC6aHkNIX71w>
    <xmx:RTlXarA1ntC8AmLcPlebCQEF_zLycDfMJAuWCQ1XfrSlNGf3XAmuUg>
    <xmx:RTlXarKubfEAYYWb7K4EKSmKhRVcF_SbBZEpkDlHWs4ESeVEIm_Ybg>
    <xmx:RTlXagipD-5uoY7n7JUD4agkH1XhaCYPjC8XHWLCfKD0oULVfkekSrOn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 03:39:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 85a986d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 07:39:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Jul 2026 09:39:37 +0200
Subject: [PATCH v2 4/7] worktree: refactor code to use available
 repositories
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-pks-refs-wo-the-repository-v2-4-d00d364f5a3e@pks.im>
References: <20260715-pks-refs-wo-the-repository-v2-0-d00d364f5a3e@pks.im>
In-Reply-To: <20260715-pks-refs-wo-the-repository-v2-0-d00d364f5a3e@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
2.55.0.313.g8d093f411d.dirty

