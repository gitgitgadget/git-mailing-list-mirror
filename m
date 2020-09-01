Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EA5C2BD11
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F02A206EF
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLyO2LzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgIAK7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIAK6f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 06:58:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCEEC06124F
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 03:58:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t10so167156wrv.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1pPjLdjLHw6XH236q6sVPtEcsHTz241ZzunGG6JLbsI=;
        b=uLyO2LzUoZvXNEGfHaxFFSlU1cmXWY2wSdTrdJnIXy5gU3QKOuNtbEZA77TuvwbkvJ
         QPr292vVJ5hhLbRPfJCfuRsjCLrvbrF2ASip0VCQ7NaLM0JQFO9vzni6wi0dHrgOZxue
         yS3mJnLl72A/k/EjNmM7hOB5sTVif8r5J38NWi15/MMQW3dS14swWjViXdvaYtvUxpUM
         I7agNbZ6djN69faq/AU6XwXVK4CNaCOQRF4Rd2O3XVOIx4ik8HQODgPHfauUwuwV9M6M
         wvLSAr2vI7YoS9abn1MrqizPQNJesQzcoAhStT35oUUpuFVuy1RpL+rMK7/SL+zeh0lR
         0LzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1pPjLdjLHw6XH236q6sVPtEcsHTz241ZzunGG6JLbsI=;
        b=nai1eK9HVZZpGhQRhgbXj4NTi8nGJ45YwMBsu/5a1wjKBFDA1uXq9aTVG1mlWkhvbJ
         Bf6cSNgPN423ZhvgR9NGJk2Dn7CSxH7E1O8vcmF21l7ogykhgZWqwxcF5qi1BQDKIs/h
         6L59OXvrLeN8j6gd7XjZ6PiN5TsCKjIeBzrIDLYQvrUvLRZQt9lsvXWiNR6A0FSTqTi8
         fpILqfD4Vn8dS+bS0QFLo9Bmgwg3e8lgOkxyLmfr29eR60Sof49nbzmyuuSlPaS0dUC3
         mpb47Ivku42AALB2U1lI1MBsyDNylKO74sAvAM1veJYjP+1KFsC/grOvCwNgPOcbD8x+
         XdGQ==
X-Gm-Message-State: AOAM532VQa6hjwcfJd3b+gdJDRDtXo98w1tXQEKCO4rBquakchfrPGla
        /0UWlVMUcDl+V0hkK8RRZav1bqr0oSo=
X-Google-Smtp-Source: ABdhPJwhtfqykXHG9ysQcn/rroPRsEWS4CD4FqRhSMTlvHQ0JS/ZzX78fJe4xT5xQ5EgGZls5HJAAQ==
X-Received: by 2002:adf:81e6:: with SMTP id 93mr616322wra.412.1598957895640;
        Tue, 01 Sep 2020 03:58:15 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-378-135.w86-199.abo.wanadoo.fr. [86.199.233.135])
        by smtp.googlemail.com with ESMTPSA id x16sm1705875wrq.62.2020.09.01.03.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 03:58:15 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 06/11] merge-recursive: move better_branch_name() to merge.c
Date:   Tue,  1 Sep 2020 12:57:00 +0200
Message-Id: <20200901105705.6059-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901105705.6059-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
 <20200901105705.6059-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get_better_branch_name() will be used by rebase-octopus once it is
rewritten in C, so instead of duplicating it, this moves this function
preventively inside an appropriate file in libgit.a.  This function is
also renamed to reflect its usage by merge strategies.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge-recursive.c | 16 ++--------------
 cache.h                   |  2 +-
 merge.c                   | 12 ++++++++++++
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index a4bfd8fc51..972243b5e9 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -8,18 +8,6 @@
 static const char builtin_merge_recursive_usage[] =
 	"git %s <base>... -- <head> <remote> ...";
 
-static char *better_branch_name(const char *branch)
-{
-	static char githead_env[8 + GIT_MAX_HEXSZ + 1];
-	char *name;
-
-	if (strlen(branch) != the_hash_algo->hexsz)
-		return xstrdup(branch);
-	xsnprintf(githead_env, sizeof(githead_env), "GITHEAD_%s", branch);
-	name = getenv(githead_env);
-	return xstrdup(name ? name : branch);
-}
-
 int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 {
 	const struct object_id *bases[21];
@@ -75,8 +63,8 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	if (get_oid(o.branch2, &h2))
 		die(_("could not resolve ref '%s'"), o.branch2);
 
-	o.branch1 = better1 = better_branch_name(o.branch1);
-	o.branch2 = better2 = better_branch_name(o.branch2);
+	o.branch1 = better1 = merge_get_better_branch_name(o.branch1);
+	o.branch2 = better2 = merge_get_better_branch_name(o.branch2);
 
 	if (o.verbosity >= 3)
 		printf(_("Merging %s with %s\n"), o.branch1, o.branch2);
diff --git a/cache.h b/cache.h
index 4cad61ffa4..a926b0bc87 100644
--- a/cache.h
+++ b/cache.h
@@ -1917,7 +1917,7 @@ int checkout_fast_forward(struct repository *r,
 			  const struct object_id *from,
 			  const struct object_id *to,
 			  int overwrite_ignore);
-
+char *merge_get_better_branch_name(const char *branch);
 
 int sane_execvp(const char *file, char *const argv[]);
 
diff --git a/merge.c b/merge.c
index 5fb88af102..801d673c5f 100644
--- a/merge.c
+++ b/merge.c
@@ -109,3 +109,15 @@ int checkout_fast_forward(struct repository *r,
 		return error(_("unable to write new index file"));
 	return 0;
 }
+
+char *merge_get_better_branch_name(const char *branch)
+{
+	static char githead_env[8 + GIT_MAX_HEXSZ + 1];
+	char *name;
+
+	if (strlen(branch) != the_hash_algo->hexsz)
+		return xstrdup(branch);
+	xsnprintf(githead_env, sizeof(githead_env), "GITHEAD_%s", branch);
+	name = getenv(githead_env);
+	return xstrdup(name ? name : branch);
+}
-- 
2.28.0.370.g2c2dc3cc62

