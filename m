Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDFF3812F6
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074622; cv=none; b=OlP0Kuz/Ap/SP72grsrzkyHwTRZvHRwR3dh3bN+ui/PZOHkQr96+o/Q5ZxyvXtRy6PESG1i5P73lrcV04PjY9WtVDSRd01uuDJG0F1lLI5tVd+ZwLpCW1dRsY7TPW+SdIgMIewFoZoFHEM5a1QytlzhtXSNEJL9peKM04VKWCqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074622; c=relaxed/simple;
	bh=rSqxays+cbwom7dZjPv2tBBGS6IuLrCgY7pktMpYxsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=StNw8sd5qC/Dauf74x/1ukNNbC2YB3JG0MMhpzwo71J+ktLnJBXGfopJLgf9D7481arJedfFDe1yG4I/JFMpsGtxz2y1W9a/YDoSr5wmYvAWyU2zx6qdgcbVkvnOPf+K8isWFLtFMyGOyovXJBxZuqC+gIu2dVmPb76Y90ytNL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dGKIdXrj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RRxW2gH/; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dGKIdXrj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RRxW2gH/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E00B91D00064
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 02:57:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 10 Jun 2026 02:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781074620;
	 x=1781161020; bh=KRbnpo6m98uJVNsV0xV8sVm5tjOi6BkTYh/nGOTd6bs=; b=
	dGKIdXrjJM9gREvC2ZLke5YIPgdS/LvtONV4is84iCjK58H7nJTQCtMBQxSi6Y69
	7z3v2UtHxYhzGn/Z/byPdkQDVDNwhHP4CilAg/G5LeHELX7v4PTfg9DgImqySHMp
	ncz+lxPyKL+k3yZjtCHTdj2oAm2yvpqmXt7XezqOH/ta8rZerbCcl5h3oxvENHUU
	EqLb1hYqqvJ8HJdvGYs45Q5Yoe4SSPzK2C4ooaj/NvzTVmS31TrQpRdlabtJK80w
	c2jaVCIlsHbhKeBAUx3v5AJqBs0ufqxW/UlyjIs97gbZyRhsrybCpSCwvBuhc81Y
	iVSDh/NPNhkmBJ2tHLiCxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781074620; x=
	1781161020; bh=KRbnpo6m98uJVNsV0xV8sVm5tjOi6BkTYh/nGOTd6bs=; b=R
	RxW2gH/pVE+j3rAOvV8uu6CCGcZd7vBsiJqsX6GPSQLe4/LnwM8GjsN4+4u2sUah
	QKyN0VU9h0v4uIopZcXrJIACE8A4eDwj/JrAS9uXWJrWzokkzRchB8V7mmXaNYOO
	ocadxUGItHKAeY7JipD/rGvDNRMG68RdtWMS33DhlxNieO3GtPgpEjgwYP73ssmQ
	eEtr/7wsu+EPJ9AOIPRbYSg0HrkwyKbfDqYsPjpozbXImiMkvm7H/Xp/QDo4cdjl
	bWnu84H2CYVtupKX8SvPVAUifGnkXbDXGfH0+zH3+u0u3K5iku05zxjvOvepCEzJ
	KlcebjWKyue2PIYZkz4aA==
X-ME-Sender: <xms:vAopatst-xVvP2SyOG3jKJ-OpwrjXkBqjEXCylJz71pa5CzW99mJ5g>
    <xme:vAopatZcqd0kkEhdsqrFhkzNegubhsRPACgyyhBsySyI2xUpU64VN71DdWOg5Jp35
    f9SxAiV2jfEDzPKWWNHA_WpJb1xswK0FPOajcDc2Haws3mYZAtvog>
X-ME-Received: <xmr:vAopamY27y_m0jPVMQudvyAF4T4lv-7ygollRt5HKYGg9k66X5GkARjp3ks-a4uuPKB8586qi9ECMKs5VDv1nhbZ117hFLNZ3KgDkCgDUA>
X-ME-Proxy-Cause: dmFkZTFJQyD/VDIFXGhA/jRdOE7X0CWqy4qn5bLIQ65+hJjnYMEZatWqVuJesENoaQuPko
    Q5yf9Ry5wPhjX33q2dK9sHGnfBKOzkBg0Fwf0Euz1csXFFXOoVZSdIt9bU96CpPP96cxvm
    iUoOvM9A2npWuhPfuaDrI9ga5F+8qrLiKhqumx6Qwll+m5rKkfyYq5hI7mi04n/AN6ouVj
    q07bwAnUH38srt2quBUglYFlAN96lY7NECZcAUdi7SoKR9VCqz6AG5eO7qBO0c4Sk6Jr/+
    UL6aIQZZDbChCYhzkgC4nhrWfVxUsoXxklal67cwhekFk2m5OdrYlWhx8ceK8l3d8VOJMb
    aMA2QCd0PswKxQwnkkAXeHtLYdttfQB1FkODAz5EtFr9tHvutOfRtFb/QFZatb/iag7ljq
    C4quVyTujPSDV/jFs7qIyRrTwgbtxO72mWk4nHoresEyJUN6EU4ZkVPZerqx6B08Rr4Mox
    2+67sQ9nJPAt59Ijb663UQeKgK4wdn5btskIU0Vr1ywlmEhSkL5hADP+swItHGrhahnKq+
    PLXqgCn90MYopx8mDicPYYvqaqhF8wQn64wlrxqE9o40M6caEezin3K64nxpZC6EN6q+h/
    oTCMJGwhWMqpNsUF0/qlTb+xAHPhm6QCXKGBcHZ79lwYBwRnZMF0TcFXG+hQ
X-ME-Proxy: <xmx:vAopapVON1YwEDTDa-yOzIh47jxJmnmXuM58_nbsXk8OhdkgyrA9oA>
    <xmx:vAopat1Ip66ApUqnVv1UleKoa3PPaCSKWAMZbQfIdiLpenJKWS2DUQ>
    <xmx:vAopagaBFzy36OOVlcvBtElavE3iNeMnndqKCil3UH411Mb-9992qA>
    <xmx:vAopagpddOgQnxF-Gy_yleT3wRPWjr03K1QHNW74cXBfn-e0vb56Tg>
    <xmx:vAopakdtIDCbDJgUd-UKiyxpAwaWzFl5HLAtK3zNifJlQg-7VFsoIroL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 10 Jun 2026 02:57:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 67afaaf5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 10 Jun 2026 06:56:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 08:56:47 +0200
Subject: [PATCH 2/7] builtin/init: simplify logic to configure worktree
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-setup-drop-global-state-v1-2-5dff3eec8f06@pks.im>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
In-Reply-To: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In the preceding commit we have stopped modifying the global
`git_work_tree_cfg` variable. With this change there's now some code
paths where we end up setting the local `git_work_tree_cfg` variable,
but without actually using the value for anything.

Refactor the code a bit so that we only set the worktree configuration
in case it's actually needed. Furthermore, reflow it a bit to make the
code easier to follow.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/init-db.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 01bc27904e..b4343c2804 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -229,24 +229,29 @@ int cmd_init_db(int argc,
 
 	if (!is_bare_repository_cfg) {
 		const char *git_dir_parent = strrchr(git_dir, '/');
-		char *git_work_tree_cfg = NULL;
 
-		if (git_dir_parent) {
-			char *rel = xstrndup(git_dir, git_dir_parent - git_dir);
-			git_work_tree_cfg = real_pathdup(rel, 1);
-			free(rel);
-		}
-		if (!git_work_tree_cfg)
-			git_work_tree_cfg = xgetcwd();
-		if (work_tree)
+		if (work_tree) {
 			set_git_work_tree(the_repository, work_tree);
-		else
-			set_git_work_tree(the_repository, git_work_tree_cfg);
+		} else {
+			char *work_tree_cfg = NULL;
+
+			if (git_dir_parent) {
+				char *rel = xstrndup(git_dir, git_dir_parent - git_dir);
+				work_tree_cfg = real_pathdup(rel, 1);
+				free(rel);
+			}
+
+			if (!work_tree_cfg)
+				work_tree_cfg = xgetcwd();
+
+			set_git_work_tree(the_repository, work_tree_cfg);
+
+			free(work_tree_cfg);
+		}
+
 		if (access(repo_get_work_tree(the_repository), X_OK))
 			die_errno (_("Cannot access work tree '%s'"),
 				   repo_get_work_tree(the_repository));
-
-		free(git_work_tree_cfg);
 	}
 	else {
 		if (real_git_dir)

-- 
2.54.0.1189.g8c84645362.dirty

