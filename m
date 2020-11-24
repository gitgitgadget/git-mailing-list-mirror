Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A707CC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04CDE2076B
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVOSE3M7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733123AbgKXLzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733119AbgKXLzH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 06:55:07 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA08FC0617A6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:55:06 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id x22so2162859wmc.5
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GRoVRP4QySZ5/9Pn0yvmD8pJKNPn9KN/8nvgjR/CvIE=;
        b=HVOSE3M7ov6H+9OY2RVBo0+uPfH07pWGJ/xBHKh4mBuIhUl32xcbF1SW4UaIDcyJqW
         /GA6boSYoXay2Ox/WNp/dJ10WGvwKag1aq5tWdc4EH/DmnyQfiMVlOk6e1tjoHYrMT2e
         hTBEBzvaluQIbpyz1smTAcPRKsRY3FfxV9APJe35ZlcJZcSskkHYmNHx/lxdiV9n2y7k
         EBcbwZGce8sKWtUOf+JfQ5ZAejw8ppFvQgVrO36hrQGfbA/nSe9yQfeMahMUeLQgu2dK
         YPs9LFrbkmujT285SpIR6rCyOt2TOYq372LOWOxZXDhz96o49rqGEi2zJjhSzAgc14Oy
         cAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GRoVRP4QySZ5/9Pn0yvmD8pJKNPn9KN/8nvgjR/CvIE=;
        b=peO0vQvPIoJuKnCUIJrFyKa3LzxnAPPpoRe1rf1gJB/m1+AFWzKmYpE1VqYgxJSaxC
         oQc930JKEHRBKTqbpAQwEVBqtejwmhjOp2T6D++XaSWT/iIodpJ2Dk39pEXJKMx82Tz2
         N8q+tkC90tukfdcBzFIm3I2l1F9BiZRBI6a1iWn0zOw/QmYVpFALhKet4tTTUgrlcvS4
         gu7jyvHNVuOfjs0dnqrhEl4tOoV4jhj3mTK+5K62dEyXRCIZ0s1f4X2UJMkVIbQqf62/
         whNjdNmdbQ6w4gXfGBOrcxNJEvGavOwFggCGawqNC1K1pPrHa5qzn36IWG5IhuA1y0X7
         BFbA==
X-Gm-Message-State: AOAM533SWSY6SuV5nI1T+zS9yAQq5qF8kL4gQ9hGyYKZEywxR3Sp8ujS
        b7vPgu8l52mCoAwuqH7jviHi2cyBYtk=
X-Google-Smtp-Source: ABdhPJyFkaPSta7xK8qLwiwcmh1FX3r2DOQjAD9JOcoKV3syoL9DO3ZZ+kHrN7PcLiXmc2SRZAKnwA==
X-Received: by 2002:a05:600c:218a:: with SMTP id e10mr4158144wme.73.1606218905278;
        Tue, 24 Nov 2020 03:55:05 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-307-224.w86-199.abo.wanadoo.fr. [86.199.90.224])
        by smtp.googlemail.com with ESMTPSA id l13sm25893227wrm.24.2020.11.24.03.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 03:55:04 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 08/13] merge-recursive: move better_branch_name() to merge.c
Date:   Tue, 24 Nov 2020 12:53:10 +0100
Message-Id: <20201124115315.13311-9-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124115315.13311-1-alban.gruin@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
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
2.29.2.260.ge31aba42fb

