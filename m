Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D4CC4742C
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D150206D5
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWlujxU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgKPKXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 05:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbgKPKXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 05:23:16 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62009C0613D1
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 02:23:16 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c9so23196267wml.5
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 02:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=erCmlE+BY3YMPeBRvPZQFAVR4wjD0xnNAA1juWeRcK8=;
        b=UWlujxU+UndbHuUFvor1vjsf4nCRlck+uL5s8USLmYqIcLMTadFW4Hpq5vkxPOAxLW
         Y4vnq+ATq1ZzneiqTVUrs6egONhS9bQIMq01FEL1ASBHPOa3MoZ7SfPVtnlMnt+Or1FC
         WQbaJF3grYzOovvNsNV3zVKcF/FozCNdwMWtUXXzGlj/SEF4keIFiJ/hgLgZcBejySfU
         N6JzCHxmQbOnI1hyI9wuYOur9qKDjicAWBDXjrJyMfs+GxePsKFFybBwAs50EICmmbKR
         ZaG10j3CSDntRnKwpl+mGMAMycXA+P2ZTmnWZoTGH45vdzRYvO6ZTV+E4P1vOnZywnnU
         G+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=erCmlE+BY3YMPeBRvPZQFAVR4wjD0xnNAA1juWeRcK8=;
        b=r2+nWRqayx6IcvP4XEBnPzkPLOXodB2nFF3ND2N73OYjHT2PY/1VR6aW9jqFwfyBAq
         sG7JOuN6yDQY5G62v39MOhqj2q5hhp8NoNxUk9oFU+WxyEZBKeOupfk3oxUwl0/i5jPN
         ZKXWEWkbsftxLIzUCpyGNLjN8FCAugbPCLT12iYn1NnI2ycQb4a+c5lYCUQdlVsfPoyb
         aKYSVGYmOw+cMoKg6gG+z6y6cUfPWLIIqiIonugVmXQiO75E8mn2C3W+o8G/v7D+r7F4
         1pdSV9t7wPoNonwqS3ROZbVcMbxLlJQdBGkHarAeOKeFEEk8vwUmaNEEM2ZgcLvTiYqO
         /p7A==
X-Gm-Message-State: AOAM530iiTu6PXHJ0Ed+FM+QeyR1jW8kCAS+jEzN07ijUSYiIlrckOLh
        rVholSQstaAAxxGs1OcURAirS8tUfgo=
X-Google-Smtp-Source: ABdhPJxvPau7cZkzcX2X7RR+iNnYItAJp33mY6gVqb39uUQC065Fe7vyVu4vyg00G+APydDUhQBBLg==
X-Received: by 2002:a1c:df04:: with SMTP id w4mr14566438wmg.3.1605522194818;
        Mon, 16 Nov 2020 02:23:14 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-426-233.w2-6.abo.wanadoo.fr. [2.6.209.233])
        by smtp.googlemail.com with ESMTPSA id f5sm22884520wrg.32.2020.11.16.02.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:23:14 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 07/12] merge-recursive: move better_branch_name() to merge.c
Date:   Mon, 16 Nov 2020 11:21:53 +0100
Message-Id: <20201116102158.8365-8-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201116102158.8365-1-alban.gruin@gmail.com>
References: <20201113110428.21265-1-alban.gruin@gmail.com>
 <20201116102158.8365-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

better_branch_name() will be used by merge-octopus once it is rewritten
in C, so instead of duplicating it, this moves this function
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
index be16ab3215..2d844576ea 100644
--- a/cache.h
+++ b/cache.h
@@ -1933,7 +1933,7 @@ int checkout_fast_forward(struct repository *r,
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
2.20.1

