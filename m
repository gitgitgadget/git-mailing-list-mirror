Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299E047D926
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184376; cv=none; b=FLAEEeDREBr7W5M61SOOS849pHt3iw+3+G4Z40oJumG9AlLP4/S596E2KpHSb5c9a9w/rl+OhKqW1PFoQieP1TiGItvrGANW5v8MSQTlJtodfVL6hOhQdFOGzef+otw1/tS/HC/ptIEDV6JCGe0vL27B2zSIkR4YB20NPz9HEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184376; c=relaxed/simple;
	bh=5Lzq+1dO6dYaLwn1tE0zdPuwo4hlCHu84Ul0S2XMa/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OtvsR2zU14thATPtU3llApS7PdxKsj2AHQWGDVfP8OZ6uHd8k2AL287kFaPPL3YWTatM56azWIgBeW6sEZO8rSBWJmUIYX3ocJLXAe4OlFd4sZ2Hmq1/WvhDKWPfsSEd2U7XC3Q8BhNmvl9fJxIY6sau1F2ICbHHCapp8vB9TmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lwrA3hVj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZSPCJrHu; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lwrA3hVj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZSPCJrHu"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6BE621D0009E;
	Tue, 19 May 2026 05:52:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 19 May 2026 05:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779184369;
	 x=1779270769; bh=Pvj13noLJzFtQPgFnY0525vMtJO1ikduaZLQ5aW+BxQ=; b=
	lwrA3hVjkuBM0JYb4CDvB5NqqOff9d0tVXGBBrIlA861GccaMbUHtiT+I176loNf
	zIG35ACvxG9Wqcvk3CzFPyzdE4cZe/ijS86eR4Dz3oZrhLyStQ8ugjd0fn1myGSe
	sUcTwngo8R48hmKugi47h89vUvPhdbjvBrNkZA5ctlmmSYkxTxSQ4EG5c3sagoPr
	VR0qutSOfun41aC3wyy4VFGExqu6cJsggsvGKHV00UhptqT3H6ccUwlWIQZYWpCx
	UBzEAbtWdgH37bUaI8p7iXOC6VPLrBlvFHeXu8fL9BxNJzaqniMaQSixXkpEBcZ2
	yyv7icO9uGFXHdpIaWuMCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779184369; x=
	1779270769; bh=Pvj13noLJzFtQPgFnY0525vMtJO1ikduaZLQ5aW+BxQ=; b=Z
	SPCJrHulSq0SVaew8Zs3Vc2DEKCdy7HTnPgzv5CQCrY+pcnQeacnXHGqAPMTbuw+
	6a/G3DxiOCwR0vsyOjBiMPp1pBRQBJzO/XXKMcC8frDTeJcZWncP/hEnIXN+M6Mq
	1rSl8IotuvpP8espGuCqmwy2eFb62ykL7sDX7WQ1ZKMoAeBcPBjt6fdaW0aguwam
	CzUpA6c+4+dy7Fq46hjtZXajyhbKqtbVOWnuJNar1bI0kIiq6dYhoI1pDK1vj1kY
	aVuxekv8LwBkGaHVU3lw+OaQSizrZxaRIJZaCuwiiSzc/f4zLoZlCP/vVTwmwYmR
	3Z1Ipek/X5IP6HlrthJjQ==
X-ME-Sender: <xms:8TIMarh8X-s2ZMEysDuON4T7N7Qkf8WKLZzcPIcsrYXqZKhPO_BX7g>
    <xme:8TIMau5Qgqa3StYJEv82IoR3Eb1OoxwviZsX_A2Ko-VYgwRAcZPg7EF0MBb-eLbJB
    j8kF2lw6OmIX7k3CnGXSKHV2IJVefGcBf3GdH8y9D5Nh7p7pS-Hbg>
X-ME-Received: <xmr:8TIMajbcrJyyU693oKYOFSz1nFVrzEPzDnQ2XCw4lsnYSIJmDAq8TsBCjtY3u9Ocn0IvI7oBsHghBaHPaueCA-96LAaYMPxOLO-0vIQ6kfk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggrthesmh
    grlhhonhdruggvvhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8TIMaj5x214PeGNpZqDm5Emij8QKWKC9L11fBYDs3dbOdPmvdnlxTQ>
    <xmx:8TIMamCoaumQy7WF7xq1JV0idSjZzUpDNgpBWb6kMY3otH376oSOuA>
    <xmx:8TIMapdKLLIpzwsNDkNr-4gIAD_ukU_w4SOZfLA8Ne-gXV9cMCXtpQ>
    <xmx:8TIMalK0TLPoZnU1Ob01G3qykmGcC4YBTR9B4RHUF3N378ybSADNKQ>
    <xmx:8TIMamIsyN_uEqLn_QV9Dj_Ew9v2lDUCiIznPSITRDAhRw1QQVDOOiWv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 05:52:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1947bda9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 09:52:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 May 2026 11:52:18 +0200
Subject: [PATCH v3 14/18] setup: stop using `the_repository` in
 `upgrade_repository_format()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-pks-setup-wo-the-repository-v3-14-a00d8ea8b07f@pks.im>
References: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
In-Reply-To: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

Stop using `the_repository` in `upgrade_repository_format()` and instead
accept the repository as a parameter. The injection of `the_repository`
is thus bumped one level higher, where callers now pass it in
explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 list-objects-filter-options.c | 2 +-
 repository.h                  | 2 +-
 setup.c                       | 6 +++---
 worktree.c                    | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index cef67e5919..bc5d98f9e6 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -378,7 +378,7 @@ void partial_clone_register(
 			 */
 			return;
 	} else {
-		if (upgrade_repository_format(1) < 0)
+		if (upgrade_repository_format(the_repository, 1) < 0)
 			die(_("unable to upgrade repository format to support partial clone"));
 
 		/* Add promisor config for the remote */
diff --git a/repository.h b/repository.h
index d391aff8ab..c3ec0f4b79 100644
--- a/repository.h
+++ b/repository.h
@@ -281,6 +281,6 @@ void repo_update_index_if_able(struct repository *, struct lock_file *);
  * Return 1 if upgrade repository format to target_version succeeded,
  * 0 if no upgrade is necessary, and -1 when upgrade is not possible.
  */
-int upgrade_repository_format(int target_version);
+int upgrade_repository_format(struct repository *repo, int target_version);
 
 #endif /* REPOSITORY_H */
diff --git a/setup.c b/setup.c
index 5dc27caf15..ed0c14e98e 100644
--- a/setup.c
+++ b/setup.c
@@ -811,7 +811,7 @@ static int check_repository_format_gently(struct repository *repo,
 	return 0;
 }
 
-int upgrade_repository_format(int target_version)
+int upgrade_repository_format(struct repository *repo, int target_version)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
@@ -819,7 +819,7 @@ int upgrade_repository_format(int target_version)
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 	int ret;
 
-	repo_common_path_append(the_repository, &sb, "config");
+	repo_common_path_append(repo, &sb, "config");
 	read_repository_format(&repo_fmt, sb.buf);
 	strbuf_release(&sb);
 
@@ -841,7 +841,7 @@ int upgrade_repository_format(int target_version)
 	}
 
 	strbuf_addf(&repo_version, "%d", target_version);
-	repo_config_set(the_repository, "core.repositoryformatversion", repo_version.buf);
+	repo_config_set(repo, "core.repositoryformatversion", repo_version.buf);
 
 	ret = 1;
 
diff --git a/worktree.c b/worktree.c
index d874e23b4e..988be84a30 100644
--- a/worktree.c
+++ b/worktree.c
@@ -1104,7 +1104,7 @@ void write_worktree_linking_files(const char *dotgit, const char *gitdir,
 	strbuf_realpath(&repo, repo.buf, 1);
 
 	if (use_relative_paths && !the_repository->repository_format_relative_worktrees) {
-		if (upgrade_repository_format(1) < 0)
+		if (upgrade_repository_format(the_repository, 1) < 0)
 			die(_("unable to upgrade repository format to support relative worktrees"));
 		if (repo_config_set_gently(the_repository, "extensions.relativeWorktrees", "true"))
 			die(_("unable to set extensions.relativeWorktrees setting"));

-- 
2.54.0.771.g3ed373ac14.dirty

