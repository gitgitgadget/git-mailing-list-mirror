Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 988971F991
	for <e@80x24.org>; Thu,  3 Aug 2017 18:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbdHCSU2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 14:20:28 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36025 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbdHCSUW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 14:20:22 -0400
Received: by mail-pg0-f50.google.com with SMTP id v77so9280380pgb.3
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 11:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rkb1PeM8dRhHZ2dBfm+e1ZOO0sQPfXzGaUWVGbhCwoU=;
        b=NS8KtFUOlgikxFg+VNcHCZ5Ts0YumP4y12SoMYUh2YUCLBEj/X9Pyrqm8j0pXa7KHv
         hoXv6cJ1AOPgyfWIjJOyWVE3ht+bXMJGj4YRQz2QgiDOlXaz/CtcdnSJXgytT+m114Jt
         dZ0qyXEYGmXtmg61tMfGeEp31Aaf86gWFzmdwigW6kGYUl7n1KjztroOZFw9e9DpYf8v
         igQ7oTDbtgQRj0YEQkmUcu2kezbB9+88wHJBx8O22KQQ7u2wGB/pBa0+x6sYU1r04pll
         ngm8MSoYexfaW8sXOAaHZDSThxOIMEYS75/3ekdMQnI6eKFEorGuvERNNk0dLpE7IGW1
         k1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rkb1PeM8dRhHZ2dBfm+e1ZOO0sQPfXzGaUWVGbhCwoU=;
        b=AnRuJiquKhE0njlLHsHI4tHq4QnaxgNNbm6Nv70pOophO0PrbJ+4t3Aqs51uqHBv3W
         rkqzTbjK/HKUe5yM2Tq3CYWsqKdErdK8kF0Ny+UUccLdbOFLjTzgkT86475Zxpmc47Ny
         qZcZ8/BqlgBgnvPILB78MW+1rTG4DNKW8GSOWGjxMP43+TeJJIEDN2GfQ0erU6YShWDS
         5E7pWz2NJVSsxqfX3VULbzicIoWL2NnGaHxXRIUVXuAn+HZZETJx5jfVskIPHmS16hrr
         IOBkgPGEG8LVWR6H+DUw4kMm70swgqSUATQ8RRGQwGmkMwg1tCjstHBUyrWvXqPjIpCE
         qgQA==
X-Gm-Message-State: AIVw112XxftGp3g5U5Mb3rtW3V31QP/HYyAhsWgVZqW6gnL4jzyF/hWe
        7P1LL35heStfKS3f+3HdcA==
X-Received: by 10.84.196.129 with SMTP id l1mr2809690pld.337.1501784421333;
        Thu, 03 Aug 2017 11:20:21 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm10706293pgc.57.2017.08.03.11.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 11:20:19 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 09/15] submodule: remove submodule_config callback routine
Date:   Thu,  3 Aug 2017 11:19:54 -0700
Message-Id: <20170803182000.179328-10-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170803182000.179328-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170803182000.179328-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the last remaining caller of 'submodule_config()' as well as the
function itself.

With 'submodule_config()' being removed the submodule-config API can be
a little simpler as callers don't need to worry about whether or not
they need to overlay the repository's config on top of the
submodule-config.  This also makes it more difficult to accidentally
add non-submodule specific configuration to the .gitmodules file.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/submodule--helper.c |  1 -
 submodule.c                 | 25 ++-----------------------
 submodule.h                 |  1 -
 3 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 36df7ab78..ba767c704 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1205,7 +1205,6 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 			     git_submodule_helper_usage, 0);
 
 	gitmodules_config();
-	git_config(submodule_config, NULL);
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
 		return 1;
diff --git a/submodule.c b/submodule.c
index f913c2341..3b383d8c4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -180,27 +180,6 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 	}
 }
 
-/* For loading from the .gitmodules file. */
-static int git_modules_config(const char *var, const char *value, void *cb)
-{
-	if (starts_with(var, "submodule."))
-		return parse_submodule_config_option(var, value);
-	return 0;
-}
-
-/* Loads all submodule settings from the config. */
-int submodule_config(const char *var, const char *value, void *cb)
-{
-	if (!strcmp(var, "submodule.recurse")) {
-		int v = git_config_bool(var, value) ?
-			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
-		config_update_recurse_submodules = v;
-		return 0;
-	} else {
-		return git_modules_config(var, value, cb);
-	}
-}
-
 /* Cheap function that only determines if we're interested in submodules at all */
 int git_default_submodule_config(const char *var, const char *value, void *cb)
 {
@@ -271,8 +250,8 @@ void gitmodules_config_oid(const struct object_id *commit_oid)
 	struct object_id oid;
 
 	if (gitmodule_oid_from_commit(commit_oid, &oid, &rev)) {
-		git_config_from_blob_oid(submodule_config, rev.buf,
-					 &oid, NULL);
+		git_config_from_blob_oid(gitmodules_cb, rev.buf,
+					 &oid, the_repository);
 	}
 	strbuf_release(&rev);
 }
diff --git a/submodule.h b/submodule.h
index 48586efe7..4f70c4944 100644
--- a/submodule.h
+++ b/submodule.h
@@ -40,7 +40,6 @@ extern int remove_path_from_gitmodules(const char *path);
 extern void stage_updated_gitmodules(void);
 extern void set_diffopt_flags_from_submodule_config(struct diff_options *,
 		const char *path);
-extern int submodule_config(const char *var, const char *value, void *cb);
 extern int git_default_submodule_config(const char *var, const char *value, void *cb);
 
 struct option;
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

