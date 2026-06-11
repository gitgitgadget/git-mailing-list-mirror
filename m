Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB157363C72
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160291; cv=none; b=W9+6QRnDmRbGet575alLU1mopv2X5g5aNsMC4qPwzfX71qkm5MCmkrkrnvQP88J9Kq3aNh+22f0ZNc24s7qM/5ZbY3VmMalvukGcalfKZpkkIy53UqeAZL6gzNMuTEruKGiN/2En1rYEHqxzhLFcVSFXqMI82qOAwmLVDoV5g1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160291; c=relaxed/simple;
	bh=rSqxays+cbwom7dZjPv2tBBGS6IuLrCgY7pktMpYxsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LHUHAKmd8Mf3Znd99o9BPy/qztWZSqngwpvXIZHW2Tt7bDdKYNDOJk6VUA5HEqvfrzZpA86i8Z+nBVO80QLqHP/8XpN3gc3vLBSb4POzI6y0otMXFLWTtwrzqB+oL5SwQ1hnSgNX3oDxIInfguRPkFeBWjJmRSAiqiP7b70mBSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JRbyCYIJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g02TZhnu; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JRbyCYIJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g02TZhnu"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E71101D00112;
	Thu, 11 Jun 2026 02:44:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 11 Jun 2026 02:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781160289;
	 x=1781246689; bh=KRbnpo6m98uJVNsV0xV8sVm5tjOi6BkTYh/nGOTd6bs=; b=
	JRbyCYIJu7NRaU+xddYUt4fZUbZ33JmcGUqK0iJH3C88HE5HOEnqLU+RMKWFfDdX
	rfXra7pk3dnRfEe/yT73CNYuEVBdOnrAfF95a+GxUFmoCrjiP6CJsPJYjcYvX4f2
	uCtBISn5AgJMzHx/lkUamUDRPw6WScydjNUo6GX9ifowWHwTLbV/9o+El1OBR+1Q
	cZlVSx+E8rhqtb1JxdW0tIbfl571ZesptyzSi+FD9gm/UEdTKNtuSLM+PmMdzTzV
	BmQGg5SbtowI8QCRpSl/dwmqcG6XseQ041rQLNEtfUd3Mae75pP2Egp6z4f/h6p9
	V75MB7uSocc/LOhKziyFIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781160289; x=
	1781246689; bh=KRbnpo6m98uJVNsV0xV8sVm5tjOi6BkTYh/nGOTd6bs=; b=g
	02TZhnuR+dQtCPwHzT7uLwv0y6cQC49m68E7XT2buhq9sFsSkAOtVc08psOxd+e8
	PgQA5Ov3NN2rDEj7qmoIvochFuF+h/53EIpM1R68zG2FAiQ+CvBu30QLQHnZpcz8
	yosRNYya/kwVy3s8Ffn+ZdBXnQP5nCS4TLhDDQgedetU89tb3VNafNaJIttYdVa0
	840/IoJS1AZteS4GLWWReOGqTSnvlXutbc4ky9lBm+OE0qnRfb7KoSoSCHKnrZ2B
	EfvRUYVEaHol6XaklaTk3HMGad/Q1vmI2MxfPdxRkzSx8YIl8khPsU/IfuiLWWZ8
	LAvITxxj7zxAjtCjfQ2Qg==
X-ME-Sender: <xms:YVkqaigklTDcqDNfONlEy_DQuhLFS1xyPG-OLlacOy6ahIcMgQ4q_g>
    <xme:YVkqapD0b4tcJYGPsOO6fjWy5cCZW3iazpLln8xxxmPZxfstQ8cKK-ph7J6Siww5u
    Yh9UekvAqKNKkhwJxgk5kysjkBF8FuSgzTgCjDGCy8pWnl8lh_mdQ>
X-ME-Received: <xmr:YVkqant3bX0cw1skuFH6wBRbdPF-Kza51n8o3mGcVeeTPypMsQ1mjkpqmyqwgjuX2PpKHki60lEN-e-DF6rxEMRioM2FU_MSj8TXqwqhcd9G>
X-ME-Proxy-Cause: dmFkZTF/+amKZAWEfZ0XKC1clGzeEdUQ0sbNVPmfkao1bjuFszGMFlLsNP6VIL6nYaFhf8
    KuZOlpXDb1+t+UjZzn+rooZ63IyyiHIGHw09HoJoH9KXxBBj+o6sqMXMiAdGpIbsou6I7U
    7SECo8r2jLbqxNxaKEsfWCXGgIZJehesKiCeieg9aFozFaYm4wMsH6ArmFJuaSmaDJUEuX
    X0++evCOGiHAiDfyOmSU+MO7I8nUHuXRF43lJrXyZVLyGz+nBstf2CfiAOFg8A9zs/xB1H
    x33NIndHuVLmXhfJridtUEJvT8M5hbXbLkM+mlDXo3gtSuC3qLjhY4A9mkeHuuoK9wvjcU
    iuwUt89Xqh1Rj+o+mQ3dPuHOesvS8dzaYTMUKDJbrRJdYNptFR4xaLmLAouFwV7jJ+dZ9C
    /6fcQT97X99ueaYCYPDbqcBuqS9YBCA9b/124uAz/lvLDMG8eywtOmSK2mDPxA94ovcWOu
    wKr2+zkich0Q86RZresnDyZwPEK3R67blLmCi9mkCjhkDfT7QzzsEmP62cH4EhyjXc/TN0
    zUWHz/VhDL6tMiFChiZawY3fG8lhZ08lv73xazCkonTrWXzU6jI4Q0+77EaZgfqcCo2Y06
    I5TT/vU/MKhgIVabIPkQh7uZMpJ6cGq015IGrkh6+wvuJwpduEfI6KnPIt0w
X-ME-Proxy: <xmx:YVkqamaqMrgNEwQR9QrsVCy50XUpQqJGx2ONlsP71JgEEh5t_b2t9A>
    <xmx:YVkqaiWveGbhfSo815kqDb3aWAiSsnmda135XvZB3re7YrWsVK5yxg>
    <xmx:YVkqai68cTiCWd95m5se7qrS0UN0HpsMw6d9SQDpx6irDW0NmZ6K_g>
    <xmx:YVkqalgme3HetIj8icwFrGVDocOmtRq5wDE1qU4_C6Y39OvE-f5mXg>
    <xmx:YVkqaqQhrL7FCzsDytcwPeBPUUWUgTqzuCIr6g68JrK7gYR7JEEmEIhv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 02:44:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 04e05eda (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 06:44:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Jun 2026 08:44:40 +0200
Subject: [PATCH v2 2/7] builtin/init: simplify logic to configure worktree
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-pks-setup-drop-global-state-v2-2-a6f7269c841d@pks.im>
References: <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
In-Reply-To: <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
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

