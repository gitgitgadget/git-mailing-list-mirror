Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D79C4363D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394C22078D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dS1iMExP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgJEM1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 08:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgJEM1q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 08:27:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C72C0613AA
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 05:27:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e2so8579340wme.1
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 05:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JLgOXavqtjFnKYe5ckatFzoZzjriXixtr2raTCetDHY=;
        b=dS1iMExP3fUhga+IP6U3OoXLBSBcoIc6hEsLGaDe7oJlb6i15oyDkKPuuBA8Y1pige
         GITv5ubMHo4XRgHaSEYC8OeX+I34Mi9bXHjbJNjp7DZs5C3+zPCFE6xxOOXf0zAgc3J+
         erDCrwVqSv3kITZ9Q6+iXNZU8KF0re7kmLQIEnUe++kL5QYvmktk8bh3dTlqosDUYZCE
         HQS/ElKvGCleyVyJW3cs3gGlYSEaPhXRDWFm+6V49uis33Ra8+Fqe1w94Z9jH5Cr3Wm+
         D0GTt+d46IPuYRL5MPRvbWt6pjJlh8YKL/m33qkr6v72xfEHaKVtAybSN7xKLLjDwxgA
         zs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLgOXavqtjFnKYe5ckatFzoZzjriXixtr2raTCetDHY=;
        b=BMhtAwcdLUuKTlYDNkaZY9KI+dxrhJmPVCQfprwg3xgiV1YvONyjgKASTt/1c08SKs
         YSx+sTADOTsMDU6bG7dqQgTtVCwJsfb8ZXoSL6rDASFMR9L9AQpQOgOZrY8atSox0xE8
         N4LEcC4Pbpnru26DqvDHVfsXybIE3lv25ihHmNEZj6UfmcX4Fh/t0OdCIdt0mr3xzVsH
         sXZy4Yxg3wvBlAc50vG69Hso5Tg9dSmcFOMgOvwfEdDRyfrqxl6oK1DgTwDz9lDUTNGO
         72JXgoRLWE3Dk219IeS9rI938+9GCVt+Om3MDoYgzYSYn4z4upDyys7fw5BwwtF4pzgb
         kWbg==
X-Gm-Message-State: AOAM532XTVhwJ52feCaYMY9/2PatHqspa4ZvbRZ3QoVg3PssKt4uRydC
        J4Ey9A0Xz+PFiX/tVYjV4QGMA9am07c=
X-Google-Smtp-Source: ABdhPJxeHITGL9YySXDXUngA2iaTzEWQVZqmItor5PFvO/N0Av4OQYRo37ed+7ssdG1708moSXxX8g==
X-Received: by 2002:a1c:b78a:: with SMTP id h132mr15484921wmf.172.1601900863980;
        Mon, 05 Oct 2020 05:27:43 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-293-21.w86-199.abo.wanadoo.fr. [86.199.76.21])
        by smtp.googlemail.com with ESMTPSA id n2sm13270400wma.29.2020.10.05.05.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:27:43 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 06/11] merge-recursive: move better_branch_name() to merge.c
Date:   Mon,  5 Oct 2020 14:26:41 +0200
Message-Id: <20201005122646.27994-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201005122646.27994-1-alban.gruin@gmail.com>
References: <20200901105705.6059-1-alban.gruin@gmail.com>
 <20201005122646.27994-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index c0072d43b1..5fa0ed8d1a 100644
--- a/cache.h
+++ b/cache.h
@@ -1928,7 +1928,7 @@ int checkout_fast_forward(struct repository *r,
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
2.28.0.662.ge304723957

