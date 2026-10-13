Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452D05304AC
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906502; cv=none; b=Qz/X/kv9jAo/B2xlNVPlP+tHORixCOcV0QfWZE1xOU/5bEoYXvAz/PM+cYdRe/hY+2LCakLAL3Gdll62VhfbhN10lstw2IjciWFSZCeuh//CscFvy4qkNXsU5kQ64yQCngQMApQ4aqXWfTskpV+moMA20Bj9IzEucovQXe9uTAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906502; c=relaxed/simple;
	bh=JNi9O/G873ZdorLoR0Kq1mkwlrxJlVuRhx0YKblxmnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rq1Y0G1hT3uWdh3qa1iXPi32Tq1r0QykyW+Tqz2aodhz5c7R8+1Nlq/7omxtBVY92sPngKjLIYusO/bUAKW3tR+MsQjkjLATDOlGMQ+omwymNjyUWs1GulwjtlywdWG3Z14B/Id+ErVtMZsjlk3HXqFfndMCRPW+xi/BScgUfMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f84zXqyU; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f84zXqyU"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48b060ec084so2036736f8f.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 08:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791906498; x=1792511298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=utd/Nf3k+OrpRR2oXkxSjpCtjrbSZ0s3AerQyUQWqX0=;
        b=f84zXqyUyxDfmcnBeZIyjUAhXB3vQ9vFncnHXXuLUyhdi8JygqoDwuPumF847zcmA5
         pTmI735I7nlHppMJ7mKlKllZMdscjyYxOanx8TLn3g005rNK1vtjKbra7Vs+rkcEstL5
         SfKF+vRStmn83+hKanElc1hhk7CsViUUO5Ae7t8C2qtEbZpk+sEltEapZugYHbAvlKv1
         PcM4zF3jOn5PZ0IBX/1L2IebpV2+2+35UGRLlnpnGpyhW7fRt8GHMuj8BcHTDyBwt/Nh
         Kf9WNV8+DiVRHXavNQUBCn8UgX1GUaQ6nVnugALcwtGK/r/dgKdH++YIckaepgV1cpLn
         kdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791906498; x=1792511298;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=utd/Nf3k+OrpRR2oXkxSjpCtjrbSZ0s3AerQyUQWqX0=;
        b=scKs0uREwkT1oQ5o8sk9YDBUckUc8zqFH3l5xhnf16P7zjChxyOqVwObfHT8GtyS+Y
         /+LZQkA7Jv9JP81uU0xVdyUx5iJbrYUgX07LpH4zMOTXU1QtCylemLGprswG9v9Kr/L0
         OgKypm5PgGenBdLlNyocwmaELyh3olpL6jUAZrgqsBxGZG5TNswjWGFDwtRRmZ7avLyD
         ZHHz1HrspJqO0L4dbcqn3Tkb2Z2veTI9HPTkjoPkwXezULYmHK5A9xHiGI73X5zAD7Zc
         F+XKdOLcpmAJH5+JlU/sE+07501tGiEUNkZyBiOcFbqTQxrzT9pXrOzd2aYE7ruqp7LB
         RcyQ==
X-Gm-Message-State: AFq9FYKwfF8TwjF6hoTwsPD0gFRcrxR4JYAUaXtmHisrvbqzM9Ufr8OH
	UDBMbxBBV3JwsJi1IqyRKvLupUaSvh9PciRfDiAEqYeORjJYQNxUiOXnszlhdg==
X-Gm-Gg: AYBFou1anf8MiBU/v31z+HJnxryGYFah5exLKPdZxQP63dAIbZhV/uKhpi1X4W5AgsC
	oQQXNsRJ0Ab6GF3/O9pCijnXWcxpl8XxqwsVdhJY0+9MkJkSWJA9+fpvkgE3bvteZfPXOznD3Wu
	gyd11gZLfl+ZMdynOsA9lTzMUTt78VGKNogbpePPHJ2Kend7BpTQk9txHxMo39s+2cvO9JdKpPy
	kLpbBtUgeVQBhaWa3Tp7M/1hXT+kiYu1rAMDtB++DdMzwWCwh/M4b/ZB+dWfnKcf66pyf4b91KX
	KQg1SYlWgmTQENLvnRW/+a3a/xoyIjr0QYtabgIt/FIRWiYJtDm5kFcb9StxlkbG5pj5U0eYgHs
	+aCD+oSFwxjWo8zWCy9GQ+CQRDQYZxKcF4ePti8hPAPE/fbYGgqlgKdzx6JsLJzr/VAneELvC57
	SnVYFe+eLoFdd4Vgz/rbjQ7RTegTDkTIbJVRIZORE3TKCtJQiLR6fLfpePE4u9fclo9d+53UvsL
	w==
X-Received: by 2002:a05:6000:2085:b0:488:7496:15b5 with SMTP id ffacd0b85a97d-48dbacf126amr23768185f8f.47.1791906498362;
        Tue, 13 Oct 2026 08:48:18 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc85b1sm5603561f8f.54.2026.10.13.08.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:48:17 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 1/3] remove_branch_state: convert boolean argument to flags
Date: Tue, 13 Oct 2026 16:47:53 +0100
Message-ID: <86ef0f848a35c66b2d68f96c5f307a6c80f74c78.1791906474.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1791906474.git.phillip.wood@dunelm.org.uk>
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk> <cover.1791906474.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Convert the "verbose" boolean argument to a flag so that we can add
more flags in a future commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 branch.c           | 4 ++--
 branch.h           | 3 ++-
 builtin/checkout.c | 6 +++++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/branch.c b/branch.c
index 22f4f46b96..8bc7a395a7 100644
--- a/branch.c
+++ b/branch.c
@@ -871,9 +871,9 @@ void remove_merge_branch_state(struct repository *r)
 	save_autostash_ref(r, "MERGE_AUTOSTASH");
 }
 
-void remove_branch_state(struct repository *r, int verbose)
+void remove_branch_state(struct repository *r, unsigned flags)
 {
-	sequencer_post_commit_cleanup(r, verbose);
+	sequencer_post_commit_cleanup(r, flags & REMOVE_BRANCH_STATE_VERBOSE);
 	unlink(git_path_squash_msg(r));
 	remove_merge_branch_state(r);
 }
diff --git a/branch.h b/branch.h
index e9b1f7b37d..42d1b12918 100644
--- a/branch.h
+++ b/branch.h
@@ -127,6 +127,7 @@ int validate_branchname(const char *name, struct strbuf *ref);
  */
 int validate_new_branchname(const char *name, struct strbuf *ref, int force);
 
+#define REMOVE_BRANCH_STATE_VERBOSE (1u << 0)
 /*
  * Remove information about the merge state on the current
  * branch. (E.g., MERGE_HEAD)
@@ -137,7 +138,7 @@ void remove_merge_branch_state(struct repository *r);
  * Remove information about the state of working on the current
  * branch. (E.g., MERGE_HEAD)
  */
-void remove_branch_state(struct repository *r, int verbose);
+void remove_branch_state(struct repository *r, unsigned flags);
 
 /*
  * Configure local branch "local" as downstream to branch "remote"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index c0f0d2c700..bdd2d816b6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -950,6 +950,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 {
 	struct strbuf msg = STRBUF_INIT;
 	const char *old_desc, *reflog_msg;
+	unsigned flags = 0;
+
 	if (opts->new_branch) {
 		if (opts->new_orphan_branch) {
 			enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
@@ -1044,7 +1046,9 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 						   old_branch_info->path);
 		}
 	}
-	remove_branch_state(the_repository, !opts->quiet);
+	if (!opts->quiet)
+		flags |= REMOVE_BRANCH_STATE_VERBOSE;
+	remove_branch_state(the_repository, flags);
 	strbuf_release(&msg);
 	if (!opts->quiet &&
 	    !opts->force_detach &&
-- 
2.56.0.134.g299a3c16181

