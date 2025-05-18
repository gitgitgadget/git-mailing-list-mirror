Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F8B663
	for <git@vger.kernel.org>; Sun, 18 May 2025 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747554894; cv=none; b=QoTDOxuiQsU2RD70aLiajatbrgK5ziqe/abc4ZDD61HakJN0gqNTUGgpW+w3PmSzrqKKipxp91aYGcTP6P5/YcGYAy4FB4j/4kp32Kbg+KL09nOEYcQMCBydO7FQOwdv3dq+MyyQD9ET3bMuYh2PSTqtgWvJqKj0fz9BL1ldirw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747554894; c=relaxed/simple;
	bh=oSyqWV0HOj4VQnuw4bOh1J7vifsUti1z+CUr2liFe4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1phaKCAyIP+aiA2trsXhEH3PqDEN0KebnfFyoQJXrMUVAzSiXBWNhLN/lGTmg71dJ9UTKIUbhFHqPUE4MxbY2vuQGwMnV4woO8K/nxt9y3Y1mKk0mcIZrth3oLIkrAKX01ZNxr3T+zLJiH3HgtSvnvQmr28PSQnIrVNlro6uE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eny12R/v; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eny12R/v"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30e7e46cb47so2214960a91.1
        for <git@vger.kernel.org>; Sun, 18 May 2025 00:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747554892; x=1748159692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWE9g73U4bjtJhmXdkDwwm5O3vNNzcy9VJ6WRq1xSks=;
        b=Eny12R/vFlFCZBlPOp2U3Sxk7SK9b9cEXtnSu4AaTujNfNnexQFoNd5bUxz85b14KY
         UBmtng1j6J8pEms2N39NKrvq9bX74OcKMHT6ark1L+heZ6GgnXZPcdenKBYYqDGxqGKi
         IGuaoDz3Nmfv2gIis+b8BEXp1dzQxJQuXCxj9IppcyGGFvcJtBHm+BUd/OrNyjpP5VFm
         PfwbJd+h2QjrwzkOHiWBtMtCc3OrjX9IhBlsibOw8ZzuvTRkf9oIIDHQBDbosJ5ae5zU
         MDnB6SsJ/EiL1/UQdoE3zhzGbgjJ++CICtoQVlEWRsR7hefiOZBd5jG1rxmwH903SxLY
         /lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747554892; x=1748159692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWE9g73U4bjtJhmXdkDwwm5O3vNNzcy9VJ6WRq1xSks=;
        b=L5xluTCmMWtVjcrOH0v/gJMNkyC4PoC32S3+ZpKJZu9pmpHOtCbLjAh2Xi2YsqXkDW
         o3N+OoMLzKC6mytEzfxsXhx1iGEebN70dT4SZVSbUUZqyyAYHNHGr16ZDqbRnDPFRcnS
         gPwDYmRAP4G+hDxccylh7thmpRZQf2IwgT+zrrOUZcA01ivzAHmu0+E5RVmBb27WK766
         TM4VxyZSm6lR8/Z1TvGvCeNL84HQo405eM6HXwB/D7n2WoRqnv10Fymk8TpMRyp3Z1FQ
         tgp2uOn4wDLNZwH9RD6p8yenmWXjC8gA+ewlzB1Ohuo8JAHzgkfTbvrSaf181+Zut7QN
         wp4g==
X-Gm-Message-State: AOJu0Yzdj1R6HOIpxnW3IS7PRYEPrUDI5c7/hd7CDwtIInA8P35BYQBl
	8upCPrWtd3kX/9Agw5fzFoJz6zXRUy20fjhhU6SIFaCvkvymjWdVTiyq
X-Gm-Gg: ASbGnctIzvptrh0BCg9hzQAK6iJWo58VOm1C9BXTm61fheGrMPtMAIUvUJiv9Y8T4L8
	dx6wIx9UyEIY0LCDz17GYPDig/MJqwsVYA7PF/h8VFiYUULCFxgbASixHx8oNfBqEPd50JUUI17
	vWNDK6Mu6HqmSveLECh9Y2FQrZ0Y84LhF+0VorAjjP/RAoZgTlMzoFGUN0GTCRxTiZlyT3Tseb6
	0u8i4TpN72mAkxp0uvTZFArC3OloC165rUCkamby0TrfP/s3o0V2zzxL7mGolZQfoLopWrc41wX
	YN22Lywa6/hsPLnltuKmiKJBwHzAOhh1eNDJ4TMrJujr0NziAUgvt2zuNLI2nfHqHBw=
X-Google-Smtp-Source: AGHT+IHWJONX8Mr0KNxvTbqoa6+pVKtvm/7qA0HEL5aUa0dZm7zSuBQPhnkR/6E8pLUue4WDDWQB7Q==
X-Received: by 2002:a17:90b:56c8:b0:30a:214e:befc with SMTP id 98e67ed59e1d1-30e83216303mr13229215a91.27.1747554891829;
        Sun, 18 May 2025 00:54:51 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e33401768sm8187600a91.3.2025.05.18.00.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 00:54:51 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	mlell08@gmail.com
Subject: [PATCH v5] submodule: prevent overwriting .gitmodules entry on path reuse
Date: Sun, 18 May 2025 13:24:35 +0530
Message-ID: <20250518075436.75139-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <CA+rGoLfLA_s_xYN1N41w=vaOg0WPTNo_9TGKvG6ZQDqqWmzFPA@mail.gmail.com>
References: <CA+rGoLfLA_s_xYN1N41w=vaOg0WPTNo_9TGKvG6ZQDqqWmzFPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a submodule is added, Git writes submodule.<name>.active = true
to the repository configuration to mark it as active. This happens even
when the submodule path already matches a pattern in submodule.active.
This results in redundant configuration entries that are unnecessary
and clutter the config, especially when pattern-based activation is used.

Avoid writing the submodule.<name>.active entry if the path is already
covered by a pattern in submodule.active.

Reported-by: Moritz <mlell08@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/submodule--helper.c | 59 ++++++++++++++++++++++++++++++-------
 t/t7400-submodule-basic.sh  | 23 +++++++++++++++
 2 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 53da2116dd..5a9c8bdc0c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -32,6 +32,8 @@
 #include "advice.h"
 #include "branch.h"
 #include "list-objects-filter-options.h"
+#include "strbuf.h"
+#include "wildmatch.h"
 
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
@@ -3328,6 +3330,9 @@ static void configure_added_submodule(struct add_data *add_data)
 	char *key;
 	struct child_process add_submod = CHILD_PROCESS_INIT;
 	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
+	const struct string_list *values;
+	size_t i;
+	int matched = 0;
 
 	key = xstrfmt("submodule.%s.url", add_data->sm_name);
 	git_config_set_gently(key, add_data->realrepo);
@@ -3370,20 +3375,25 @@ static void configure_added_submodule(struct add_data *add_data)
 	 * is_submodule_active(), since that function needs to find
 	 * out the value of "submodule.active" again anyway.
 	 */
-	if (!git_config_get("submodule.active")) {
-		/*
-		 * If the submodule being added isn't already covered by the
-		 * current configured pathspec, set the submodule's active flag
-		 */
-		if (!is_submodule_active(the_repository, add_data->sm_path)) {
+	if (git_config_get("submodule.active") || /* key absent */
+	   git_config_get_string_multi("submodule.active", &values)) {
+		/* submodule.active is missing -> force-enable */
+		key = xstrfmt("submodule.%s.active", add_data->sm_name);
+		git_config_set_gently(key, "true");
+		free(key);
+	} else {
+		for (i = 0; i < values->nr; i++) {
+			const char *pat = values->items[i].string;
+			if (!wildmatch(pat, add_data->sm_path, 0)) { /* match found */
+				matched = 1;
+				break;
+			}
+		}
+		if (!matched) { /* no pattern matched -> force-enable */
 			key = xstrfmt("submodule.%s.active", add_data->sm_name);
 			git_config_set_gently(key, "true");
 			free(key);
 		}
-	} else {
-		key = xstrfmt("submodule.%s.active", add_data->sm_name);
-		git_config_set_gently(key, "true");
-		free(key);
 	}
 }
 
@@ -3443,7 +3453,11 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	int force = 0, quiet = 0, progress = 0, dissociate = 0;
 	struct add_data add_data = ADD_DATA_INIT;
 	const char *ref_storage_format = NULL;
+	const struct submodule *existing;
 	char *to_free = NULL;
+	struct strbuf buf = STRBUF_INIT;
+	int i;
+	char *sm_name_to_free = NULL;
 	struct option options[] = {
 		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
 			   N_("branch of repository to add as submodule")),
@@ -3546,6 +3560,30 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	if(!add_data.sm_name)
 		add_data.sm_name = add_data.sm_path;
 
+	existing = submodule_from_name(the_repository,
+					null_oid(the_hash_algo),
+					add_data.sm_name);
+
+	if (existing && strcmp(existing->path, add_data.sm_path)) {
+		if (!force) {
+			die(_("submodule name '%s' already used for path '%s'"),
+			add_data.sm_name, existing->path);
+		}
+
+		/* --force: build <name><n> until unique */
+		for (i = 1; ; i++) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "%s%d", add_data.sm_name, i);
+			if (!submodule_from_name(the_repository,
+						null_oid(the_hash_algo),
+						buf.buf)) {
+				break;
+			}
+		}
+
+		add_data.sm_name = sm_name_to_free = strbuf_detach(&buf, NULL);
+	}
+
 	if (check_submodule_name(add_data.sm_name))
 		die(_("'%s' is not a valid submodule name"), add_data.sm_name);
 
@@ -3561,6 +3599,7 @@ static int module_add(int argc, const char **argv, const char *prefix,
 
 	ret = 0;
 cleanup:
+	free(sm_name_to_free);
 	free(add_data.sm_path);
 	free(to_free);
 	strbuf_release(&sb);
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index d6a501d453..5c3f471338 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1482,4 +1482,27 @@ test_expect_success '`submodule init` and `init.templateDir`' '
 	)
 '
 
+test_expect_success 'submodule add fails when name is reused' '
+	git init test-submodule &&
+	(
+		cd test-submodule &&
+		git commit --allow-empty -m "initial commit" &&
+
+		git init ../child-origin &&
+		git -C ../child-origin commit --allow-empty -m "initial commit" &&
+
+		git submodule add ../child-origin child &&
+		git commit -m "Add submodule child" &&
+
+		git mv child child_old &&
+		git commit -m "Move child to child_old" &&
+
+		# Create another submodule repo
+		git init ../child2-origin &&
+		git -C ../child2-origin commit --allow-empty -m "initial commit" &&
+
+		test_must_fail git submodule add ../child2-origin child
+	)
+'
+
 test_done
-- 
2.49.GIT

