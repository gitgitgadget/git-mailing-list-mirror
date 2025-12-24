Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A6A298CB7
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 23:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766619689; cv=none; b=UAl0pq0fKswZ5K79IP/KNT1t/0EZR0txFI72y9z1HmCAgsS8ice+8NvBQ8juwvBHL/5AFk9u2G2y7NtMCKlomaKv2rE8Q0i8hfZTKBA9senVf7p+fIAQSKcX7Dk6akVKo9VnVN2MzS8G9ZSyEhxiOhkbrKdl8o0oLBA3AG39uvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766619689; c=relaxed/simple;
	bh=R6cVNSGf6cv+Q0Bp6XhJtfldfDQPLLJUxcWhQJTC8Ds=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BbXFstIp8w1e0vYqWEWnpEEVUPpArk32+Vrle9kSK2KSviHMeygZeMJXnib34VTnegf939q4XiUzomf5LmFyhjUe25N/hVoefcaeuU/qYr7D4BNzPiGWq8WjRmAdYxHPydwLL482nPErOMC3wAknIXZXBgFOCoNhhfKsgKpM5EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anWu2emv; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anWu2emv"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88860551e39so49738726d6.3
        for <git@vger.kernel.org>; Wed, 24 Dec 2025 15:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766619686; x=1767224486; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HK3Nyt0Spl7S5ovEhMaOrBfJxy4qKpKBc+fBFhbb5tI=;
        b=anWu2emv82x4gAZxg/xKh0UJBPQkFmybwuE3Po0gEfqCNRqErSH8kV7pWudjx+iU4n
         VdqpPVSm/OAuqogS8gzNmkl5vT2V61HCVSSasu1bMs4t2QY2QuD7DgaSnbVq4M9ipYTS
         G0gol341UeAghcz7OCnhD9zgH288+3JAcRKC55Hf7GQxnzxZe5T0rdacQ1OrXF7JknV6
         zs+FowahAiqu1YtEoayesSqVprhxabzS8Y4moYK6L6eunsBDOAQ2ujn2JGE3WRv6uBuW
         mx0l1aT3YaqSW1UpNwpTXfyfZ/h/dNeQauDsG4KeB1Sx+oIHvKz/xwYgYuRfyPlSb4DN
         kBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766619686; x=1767224486;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HK3Nyt0Spl7S5ovEhMaOrBfJxy4qKpKBc+fBFhbb5tI=;
        b=grE9FQoleWaDi3j10hKcq6UuaHEZWA0+7ieN4/SbyvISgOHJT7dEfL7h9FbSWqcB51
         d7qWm/d6NtOkxSDeZkC1aJchcjRIIU02eKSeP0diBGrGmpZ72Csl4FAfVVHtH/Hei5+I
         Ujj06tQlzuBaZCp/RWpqj71KLpqZSX49FX514GubfUUB00UHP0ucnp4Q4kFzUIuZ0N99
         bUK0pbnVgVCrEpxaxu2A+KirP7OM/iscVlx6Rw4YkSue5sAXV98uMJsi8A8VrtGLJzxB
         ggu8i7E0MxRKCLCSgn/O7uVgnXUuZAnkSSe8P0ubH9x+PAUGpHjdGRgDvAOoa86qb/Rt
         uMHA==
X-Gm-Message-State: AOJu0Yw/ZJAeHBRIIMkD99ZxnoG9mvDQX+u5XNLZcG9Wr5j21VwUYxlH
	aqDPY91FMTq5IZHV+vLQycEsEUet6pzPppqDMd4etzS6MwxX3kfbEtRB30sv/w==
X-Gm-Gg: AY/fxX4V5gh3pTPglVdZA83NsTXMS9Y6a36XyExsvPSM+mqXkClERSRvNyObyLVYE9/
	lbcJBlisrh6sqz73j5xY12h9CFwbxbbQ2GitEefZhQnQmV5UsA2WzKn2fvO3lG6Lx8P0QPtFb1l
	4Q+UOFtjS8RT64mzS/PaRYDEWQWWwVJGmgEeqNaJl74/hROc12ucq4DDyyHClyAWQiFSkWTYUVs
	MugRnuIUaSKpvegbCY71Cx1BshyvSaGRAGHMtug+NB0evDQ839QzdeD8QpUQ+shv4f7xGv664Fd
	LJ8Rmsbl5WjXOedE5ZxglBEGDt7CffqbwxD6HrRqQpKTdEZl6yNXpX3ClEMbrL1n5ugdbfldEoL
	5gX3zmT6RnlB4EuoosI3OKbExCtIuEzsh4Vzl2rdk+3vX4KWiCuM0T+LtoSsuzxcj+B2O6udX65
	H6fPxGFJcUbIvyBw==
X-Google-Smtp-Source: AGHT+IHykX/3E+QgE4/nNqS66YddinsBrolco0YjZV/i6uGyzfy98BUx6vsqCH5IN+UuF7iBkP30Hw==
X-Received: by 2002:a05:620a:4116:b0:8b2:ec5c:20cf with SMTP id af79cd13be357-8c08f657b3bmr2811076985a.9.1766619685987;
        Wed, 24 Dec 2025 15:41:25 -0800 (PST)
Received: from [127.0.0.1] ([64.236.135.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0968927c0sm1421211585a.21.2025.12.24.15.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 15:41:24 -0800 (PST)
Message-Id: <0e308141da0b639ba4ba15c640b8e4260689a42a.1766619672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v6.git.git.1766619672.gitgitgadget@gmail.com>
References: <pull.2138.v5.git.git.1766572715.gitgitgadget@gmail.com>
	<pull.2138.v6.git.git.1766619672.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Dec 2025 23:41:10 +0000
Subject: [PATCH v6 4/6] Rename default_remote to goal_branch
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Rename variables and functions from 'default' to 'goal' to better
reflect that they represent the goal branch from config rather than
a default remote. Also move the goal branch lookup to where it's used.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c | 63 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/remote.c b/remote.c
index edb6d374e7..99c0e18df4 100644
--- a/remote.c
+++ b/remote.c
@@ -2237,7 +2237,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
-static char *get_default_remote_ref(char **full_ref_out)
+static char *get_goal_branch_ref(char **full_ref_out)
 {
 	const char *config_value;
 	const char *resolved;
@@ -2253,8 +2253,11 @@ static char *get_default_remote_ref(char **full_ref_out)
 		return NULL;
 
 	slash_pos = strchr(config_value, '/');
-	if (!slash_pos || slash_pos == config_value || !slash_pos[1])
+	if (!slash_pos || slash_pos == config_value || !slash_pos[1]) {
+		warning(_("invalid value for repo.settings.statusGoalBranch: '%s' (expected format: remote/branch)"),
+			config_value);
 		return NULL;
+	}
 
 	strbuf_addf(&ref_buf, "refs/remotes/%.*s/%s",
 		    (int)(slash_pos - config_value), config_value,
@@ -2277,38 +2280,38 @@ static char *get_default_remote_ref(char **full_ref_out)
 	return ret;
 }
 
-static void format_default_branch_comparison(struct strbuf *sb,
+static void format_goal_branch_comparison(struct strbuf *sb,
 					     const char *branch_refname,
-					     const char *default_full,
-					     const char *default_short,
+					     const char *goal_full,
+					     const char *goal_short,
 					     enum ahead_behind_flags abf)
 {
-	int default_ours = 0, default_theirs = 0;
+	int goal_ahead = 0, goal_behind = 0;
 
-	if (stat_branch_pair(branch_refname, default_full,
-			     &default_ours, &default_theirs, abf) <= 0)
+	if (stat_branch_pair(branch_refname, goal_full,
+			     &goal_ahead, &goal_behind, abf) <= 0)
 		return;
 
 	strbuf_addstr(sb, "\n");
 
-	if (default_ours > 0 && default_theirs == 0) {
+	if (goal_ahead > 0 && goal_behind == 0) {
 		strbuf_addf(sb,
 			Q_("Ahead of '%s' by %d commit.\n",
 			   "Ahead of '%s' by %d commits.\n",
-			   default_ours),
-			default_short, default_ours);
-	} else if (default_theirs > 0 && default_ours == 0) {
+			   goal_ahead),
+			goal_short, goal_ahead);
+	} else if (goal_behind > 0 && goal_ahead == 0) {
 		strbuf_addf(sb,
 			Q_("Behind '%s' by %d commit.\n",
 			   "Behind '%s' by %d commits.\n",
-			   default_theirs),
-			default_short, default_theirs);
-	} else if (default_ours > 0 && default_theirs > 0) {
+			   goal_behind),
+			goal_short, goal_behind);
+	} else if (goal_ahead > 0 && goal_behind > 0) {
 		strbuf_addf(sb,
 			Q_("Diverged from '%s' by %d commit.\n",
 			   "Diverged from '%s' by %d commits.\n",
-			   default_ours + default_theirs),
-			default_short, default_ours + default_theirs);
+			   goal_ahead + goal_behind),
+			goal_short, goal_ahead + goal_behind);
 	}
 }
 
@@ -2323,8 +2326,6 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
-	char *default_full = NULL;
-	char *default_short = NULL;
 
 	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
 	if (sti < 0) {
@@ -2336,14 +2337,6 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
 					    full_base, 0);
 
-	default_short = get_default_remote_ref(&default_full);
-	if (default_short && !strcmp(base, default_short)) {
-		free(default_short);
-		free(default_full);
-		default_short = NULL;
-		default_full = NULL;
-	}
-
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
@@ -2398,13 +2391,19 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
 	}
 
-	if (default_short && !upstream_is_gone && sti >= 0 && abf != AHEAD_BEHIND_QUICK)
-		format_default_branch_comparison(sb, branch->refname, default_full,
-						 default_short, abf);
+	if (!upstream_is_gone && sti >= 0 && abf != AHEAD_BEHIND_QUICK) {
+		char *goal_full = NULL;
+		char *goal_short = get_goal_branch_ref(&goal_full);
+
+		if (goal_short && strcmp(base, goal_short))
+			format_goal_branch_comparison(sb, branch->refname, goal_full,
+						     goal_short, abf);
+
+		free(goal_short);
+		free(goal_full);
+	}
 
 	free(base);
-	free(default_short);
-	free(default_full);
 	return 1;
 }
 
-- 
gitgitgadget

