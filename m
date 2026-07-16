Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1F82EEE84
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 05:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784180004; cv=none; b=T388DZm9Z0VIIQ9I1m1KywQN+h8JwOS6YfFUy+yyg5cEcqO99DuEjlD6Js7V4X7K7yHgQMlu5lHvMeZCXrVIjGGrtd8GlYp2yRkcZll6smM1z2r75gRR9MIDOc5TkV+YSp936ZCYvVpJtFmXqqatE25firX7htX9aeuAfPvECBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784180004; c=relaxed/simple;
	bh=/7OeZX+aS1+yAx24DCO39vgd1nOUxUZv4+5GhWWtVJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uQKxsySRhHR5Q7kHwm2sV6LdkOPp99sbxDDmh8v4izRbOO/KlY4zfk0FbzlUrjQvVQQH32ZWv0h8yV681EbC1auBtYOxdp+uPo90HZ6/IYS18+3/MxZwS8eB5hzZ5feaqd9JfsMvS59Crs3k4v47xZ3Wa/PJ6byuoEGJE3CZOF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h0CZy7md; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PepLTbX8; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h0CZy7md";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PepLTbX8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6ED961D0010C;
	Thu, 16 Jul 2026 01:33:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 16 Jul 2026 01:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784180002;
	 x=1784266402; bh=WCVaJmA8MaWpmCzERrVhKCq3pVzhyir5SV2a+rKzCp8=; b=
	h0CZy7mdjAqz5GvghOKOjMkbxvZa5+cpu+NTuZw00I9JKRZMpzgNEwOe1nyth+WM
	6vwuQrgvKHHASweLA3X0fXfPuR9jG4d0X+OUVC2Sr5+Xw6iRKUoj3Ed444K3mzRt
	LyncL+1g48/SqD0XTAYFeWxFd8929NGQIOfjGucDcYJJgo0bSk6PLbyyBmSG5uSv
	xcp2az8wTp5p9euxYfcpCsYlYXSzN6SXiPOW7mEv+IBVJGUXSuQwysT3EachfgDV
	NEWhs6m1FniZGNNuNo9eo2Myw+S15e111aaWE9ZYr7qmPaML6xlSnbCIOqLGxMCp
	cTF7lk//pbk3kWVryR/5sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784180002; x=
	1784266402; bh=WCVaJmA8MaWpmCzERrVhKCq3pVzhyir5SV2a+rKzCp8=; b=P
	epLTbX8ux0lRCO9YucmxjVMhrL/TEG0QvF+DTzs7d+BXIhsZAoLncfEnBeNM4Fvm
	pEPbg8uCtTvVa6X1ltm/nBwl2Sfn7WaaMNs+rH6qVWdcxZykJS8iOnbbe3BWTUdU
	WlvScgvhalz8Ij27LxRIGQX642iNlZ0IQWnAQNeo3hIua7tmkBn9nrYBtV23e3mk
	5UqNhtZ5YNuyifUdpFCRNHJxnKwQzDHVoAeCY7iyh7s+M9hdtVidvkpOlAXKgo04
	aIQmn+i1uIox+PJ8iFuTFevo1qJ1llzmS6BZSMwvTjj/K3NHP2mr2emu7UvuGMf7
	mSHikskfo1zvh8QdDoEOA==
X-ME-Sender: <xms:Im1Yas2VL3ap7bSC9Z3HY1EKVskg_MQl5j8zDUTje-2zGBDM1ai9kA>
    <xme:Im1YaujtpqN0ktBNaPrS6jPY5-j2QUxtQuLrVAORDv2Ip0_TV1mjL_yMAHc3zLOVs
    91EHjn6nnDCKSTAzjrVZ2Wa0HrQd-xEPC-tClZYT4baUe8pqdMadA>
X-ME-Received: <xmr:Im1YaiTEL14QB1dIgCPo3uCUZmC9PapMml6YpN2ky9VxvXQFIPaCvH5Bmq74hI_-OAz7KTs4cxdPKt6u_uIAJ8A23ioi7sIsu3343Ac3>
X-ME-Proxy-Cause: dmFkZTE3sd9Rgq0aRyFtptZUq81EFixIPvqz3pxNdSCnN20LGThertVtMVbre27mftpmEH
    qGs+EpopQa2hsq1ogJehRFK/z5tOf9MQPhGL0+9xQ9ejaxOniWyxLQkI1zFZ6RSnjjvvJf
    L1NdgMe137p63bb/fu7hdzzHAIDzMSB5Wwnt3+iFZyE8bMuRZlWaA/5BCJ1a1ayI5QuR8P
    D8sp9u17MkpxUCCq5pJuwtzLCi0Bb6TEpRusMhhPMKUeiiEi4ErvBD0vBiFniU/3WdI9F2
    898u8vaP4WMsA7FyLLF5BfnREOORK9tSe+kpbdjyzGV6ZTqZ2c5Qnzzdbw7ZNn9bhG8mfR
    XVbXgqTxKf3Xo1Q8C8Q/sfT1k9ILt5nJYhoK6QpjhYPJB7Q+YM6+lm1uKht+MvjjxfERQD
    ktHgkDON/E7wUbw3SItabgHJErTibkqxY6cdQwXsowYXQ3M45EcsI5/iQzulFvVRPpe82e
    htYj9co6YCyndtnjHSLB4YOk3e0TgVvSQnaz9f/6tW+/xIwb3LgVk7q6LNi61xSKsSYFVI
    JeglD/W01o0Omhlw9YVECvXnPVtfgYANlYdaVUN6TC7LlRhkbwzWlPhHXAROLy6DLTVBkX
    0Mp918Ra7NXuRYbrb6Lfujt1vhsKWoNK/InceWsRTcLZszUOHG0wUKwd7CxQ
X-ME-Proxy: <xmx:Im1Yavheifb8KBS1g_Zt_nQ35TnkxXBgif0DbeOLuVp24_H3FwcMAg>
    <xmx:Im1Yai670WpVzjedmi8wBVopymnHKlq_BmeAudX2D_Rx4lUXy6ZEfg>
    <xmx:Im1YasCHcWaPxr2ENU9BXx8ERlttPC107DW-kUbzH6ihxC4RLiEyzQ>
    <xmx:Im1YapZWILE-OxVpcOJoPM_joLX1hk1UNRwX8LmS_JCNzTh1faV3Jg>
    <xmx:Im1YakJDFuIvtZ7E0VstQio67IKr-faedZlVZNgFNETvP9b8ZS0ye06O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 01:33:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ad26124e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jul 2026 05:33:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jul 2026 07:33:04 +0200
Subject: [PATCH v3 3/6] worktree: refactor code to use available
 repositories
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-pks-refs-wo-the-repository-v3-3-db0a804e0224@pks.im>
References: <20260716-pks-refs-wo-the-repository-v3-0-db0a804e0224@pks.im>
In-Reply-To: <20260716-pks-refs-wo-the-repository-v3-0-db0a804e0224@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
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

