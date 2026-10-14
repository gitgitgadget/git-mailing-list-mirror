Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870DB54CF53
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992440; cv=none; b=bo8FNLdaaicLHqtP/Ch/D8L/u9prCYWrkQ6YGcod2cldaV68JfxO9UPbevwUpxY0xDk52CjrNAAmdXoxCxRSY61gtVd4Wd0JDHz5RN26lHx8rOpBue5HM7ozzLP9lxdCxrNlhKZ2I1j49vH65DEcUNGCqKuUeZyH9ELvnlZgxKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992440; c=relaxed/simple;
	bh=mOkty1KY6hA1pgQpsrXbGPg9Ln2hVoNjrHXceg9TcD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTDXsVzC2Na5kedmYVyBdDKQxfSjVqWcpI4jNcewi9ggJXiRSqHrIDe7oyacDs0yF0XQXIC5v3L6VF+/+lZlhFpncJkWaMHFiP1oKB8/GHzNvdBRgAST0LsdMixQsvyFaU0OvcC0F70TVZdjnkKB1HpJ/7NnFOb3pz5ZV8KCoYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKKYt0PZ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKKYt0PZ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48bbb06e746so422543f8f.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791992435; x=1792597235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pm9KFLtmGWE5QfGKMpYKE8l4xuVGeAotogfwM5r9QII=;
        b=BKKYt0PZuz2oKGW+dpl8RDBU3KDl3qv9xocVcJ60CEA/65g5LPTU+47c0xBByecMAx
         +vUj8Wx0q4ij+56K70Of1oFoQfzOYYu1b38YIVolukeQ4PDkCDrjfK0GwS55d9Bc4ve+
         svXEV9+3iUkpcJDkLRQVv5JlRCRji/dqRVxP+hR7ESB1XqdkDiD3aSEFQpFk7O20ZkAn
         g//ljE55R7BouUDMnpY1kQ0gJXWkYK2LEsJcYkiLihnCn72O0BWbPak8YhM26OF2MdLW
         xiASmQOEQMyflyRYpC0Lb6YtyMVZt5zNqT0N+mLlobOzw8ZlYhRZsVB7Hd9/gq3nb6vQ
         nc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791992435; x=1792597235;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pm9KFLtmGWE5QfGKMpYKE8l4xuVGeAotogfwM5r9QII=;
        b=eaqPSJI5kukHxBcevIjtqIPwWKwKRkWTW+sfoLPLQN9sU8WqCyuPEkkkQsf6tG7UGl
         V+RAiuTqRvOJc0cOKoeZfE5fd11xdypIrx06dEtTKJq1hQNYvSC9aIn5NM708v+c3Moc
         gL2qdy4CMNxsmTTegtastc3/fn1wlQvfDO6cNQ+ig21nksLBLwV2g9gMJF0qiOuuxDQZ
         xNhSApD7+2GTLCaYKYrhn+D4NHVqJ5CLOOjDjcxl8FCHs2a6dvl9mmKnmgV2EwMX1Hto
         h5cToOTBB/aDWYyssUJjRCN2QeiTtWkQfrocmp5zG4GBX4ucGffRKZRT3i6EKAYzwCch
         RcfA==
X-Gm-Message-State: AFq9FYKwq3auP4ULmIOiwOOAidaabRFpQX6kn/xaQ17XCPCSdbT3kp+2
	QkEZT/E+P3i38sAqYaMWR6HIrGZ4Pp4blTvHdgZa0vH+BmxWzR/hT3sduICTHA==
X-Gm-Gg: AYBFou01BW9tQe86wbsLbqk8nwbutZedPWElLY2Quah4BgbqjCdzgzPVFm2Swg+xvLa
	HNNUqV3LF2w9t8dSwiieA13Kgj6fYwU9RAFAjUEigyFXnPO/uUv/F6IJtYYZ2d9Cvz9Xsts1WtP
	4V9JB9DymlwPNr9HBtAcj3tPs0G1gmbb26UOuHaswY7qiG7LJPDgyPCWI/g43mruRX/UdQAHT4x
	FFsGcFxUgipmB0lyocUfIWNJWeU4RZWmfyJxeToRAZxJJtjrPNSuKlfBQ/8oDfFrGDbzeXuX3s2
	MDpYyAiOBXOJV65BnTGjDFxHP0q+Tr9nUYzg5c0eFt4B4COaysbvmDaCoNrXd48/f/DTz/APwk1
	yQyokVpXEm/q60zlwYUZCzHUaNe72HuTmZanr2nHd9uw+yIts9Ub1NGpoTxW/FEhO4CWAGd+gkQ
	t3MQdPIsOD3X1+a9hCXrQHRqgO1V8bOSl0ASwCvsc1FOCq5lPyAixO+J9qW3KoeSSbpN5YotkJl
	A==
X-Received: by 2002:a5d:64c4:0:b0:48d:f034:7fcd with SMTP id ffacd0b85a97d-48df0348085mr2003547f8f.51.1791992435353;
        Wed, 14 Oct 2026 08:40:35 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967acasm10324829f8f.2.2026.10.14.08.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:40:34 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 2/7] stash create: remove duplicate changes detection
Date: Wed, 14 Oct 2026 16:40:14 +0100
Message-ID: <d56b7c6f67274175416f4d5344675a9679d31f96.1791992404.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1791992404.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk> <cover.1791992404.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Before it creates a stash, git checks if there are any unstaged,
or uncommitted changes. If there isn't anything to stash it bails
out. Since ef0f0b4509 (stash: optimize `get_untracked_files()`
and `check_changes()`, 2019-02-25) "git stash create" has checked
for changes twice, once in create_stash() before we refresh the
index and then again in do_create_stash() after the index has been
refreshed. That commit claims it is an optimization but it is not
clear what it is trying to optimize by checking for changes twice,
especially as checking for changes before refreshing the index is
unreliable (the scripted version of "git stash create", called "git
update-index -q --refresh" before looking for any changes).

Avoid checking for changes twice by removing the call to
check_changes_tracked_files() from create_stash(). In principle we
could remove the call to check_changes() from do_create_stash()
instead, but it is more convenient to keep it there, rather than
require each caller to call it instead.

The remaining callers of check_changes_tracked_files() sensibly read
and refresh the index before calling it, so it no-longer needs to
call to repo_read_index().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 3e50ccfb40..f461f002e5 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1248,9 +1248,6 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 	if (repo_get_oid(the_repository, "HEAD", &dummy))
 		return -1;
 
-	if (repo_read_index(the_repository) < 0)
-		return -1;
-
 	repo_init_revisions(the_repository, &rev, NULL);
 	copy_pathspec(&rev.prune_data, ps);
 
@@ -1662,8 +1659,6 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
 	strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
 
 	memset(&ps, 0, sizeof(ps));
-	if (!check_changes_tracked_files(&ps))
-		return 0;
 
 	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
 			      NULL, 0);
-- 
2.56.0.134.g299a3c16181

