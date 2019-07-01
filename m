Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02E5D1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 20:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfGAUUi (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 16:20:38 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:38431 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfGAUUf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 16:20:35 -0400
Received: by mail-vk1-f201.google.com with SMTP id u202so3910066vku.5
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 13:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZqS/0TlHfrtjHVcRz25wK1cSiHaTc/U2bYD0raG+XV8=;
        b=J5zSFIRYsgxfRUbzuJJKFCdJqVSpTyI+z6F1S1fCMFz4JQsM0+yJI8Eu1xPhuZ5utn
         1DnM2Cq3s6fCjiHMoTQ7843J332LEUX3w11s+WFYAvwh5wBkPFkVG+dS0tUFi1OJaCs8
         usum6wKgBq1GOAZ8Kycs7RO3IaWuBxQGK6vlqgDtyk8b3yZ2FLIBTWmy2TU1IS1f77FH
         YtLOHIFZ3flNglfRlc6TvNj5SeI4SrO/iGE8Sj7xTjezkx/oigtVQ8pXknvJgYMotbKz
         b4XHDHDu4zWMmAuSUn1gzTn2/dUG2o5DsfLByG1R+J5V+wx1ZGHXKqFAIF829Oo3Fxh5
         Or9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZqS/0TlHfrtjHVcRz25wK1cSiHaTc/U2bYD0raG+XV8=;
        b=fX85FLfd/eXocEvXCMganBJmhFR7/XXVy0mFyx7hna8uWi6TfhPHmHM8HR0Us52nE2
         QoMEsmygIV9mJNO19Prz1j9lV7Jg4LkTpz4F6Y6GBTbzMkatFL8QfEFcxoItKIuca8nR
         qtj5lDWvcO0Kt5ilbZ5Axos/NxmkaamxObV4JP9zLxzh/rIsii8x66fFA0klLscs7Tnt
         +48WrcIaMlN+IFTQqB2ZPxhUfMh0v+vSUyyJi4TrkMrddqoe4BX1kftNPWZuhE8qgWU+
         KnN5nxxDEhWvK8qi5ZePEkirKRYaEue60NKHZeiGR9zqqqAGJImK1w85lb53+Cw+OQJf
         NpdQ==
X-Gm-Message-State: APjAAAXYiUAQPUqBnl4DKl8AdYmrQfHC6JwAqMjmNMpgW7mgAdtKI9IK
        HFkIv/xsqASFBCuonCJB9WLBjbicUqbnPnJZKPovDXIfhypXHDiK9LzQxm/0HdHHofm1AcsiFRp
        FWDZqvOYQVTwwoKBC8b+THAKXUyjb7DVvkCng1GNv+oP9A/UF/KDJv9QG/HAgymnhCriJo5JzlQ
        ==
X-Google-Smtp-Source: APXvYqyqzef/n5jYmI2CBRobUiAMBn4XHUHrybI/CI27WRfyP3obHTN2hDe2Eg1qnHkM+oimSIuWt+Jys5f3zwU4VuI=
X-Received: by 2002:a1f:2896:: with SMTP id o144mr3522476vko.73.1562012434285;
 Mon, 01 Jul 2019 13:20:34 -0700 (PDT)
Date:   Mon,  1 Jul 2019 13:20:06 -0700
In-Reply-To: <20190701202014.34480-1-emilyshaffer@google.com>
Message-Id: <20190701202014.34480-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190701201934.30321-1-emilyshaffer@google.com> <20190701202014.34480-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v3 05/13] walken: configure rev_info and prepare for walk
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`struct rev_info` is what's used by the walk itself.
`repo_init_revisions()` initializes the struct; then we need to set it
up for the walk we want to perform, which is done in
`final_rev_info_setup()`.

The most important step here is adding the first object we want to walk
to the pending array. Here, we take the easy road and use
`add_head_to_pending()`; there is also a way to do it with
`setup_revision_opt()` and `setup_revisions()` which we demonstrate but
do not use. If we were to forget this step, the walk would do nothing -
the pending queue would be checked, determined to be empty, and the walk
would terminate immediately.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Change-Id: I76754b740227cf17a449f3f536dbbe37031e6f9a
---
 builtin/walken.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index e53c42ea18..333d9ecc5e 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -5,6 +5,7 @@
  */
 
 #include "builtin.h"
+#include "revision.h"
 #include "config.h"
 #include "parse-options.h"
 
@@ -22,6 +23,40 @@ static void init_walken_defaults(void)
 	 */
 }
 
+/*
+ * Perform configuration for commit walk here. Within this function we set a
+ * starting point, and can customize our walk in various ways.
+ */
+static void final_rev_info_setup(int argc, const char **argv, const char *prefix,
+		struct rev_info *rev)
+{
+	/*
+	 * Optional:
+	 * setup_revision_opt is used to pass options to the setup_revisions()
+	 * call. It's got some special items for submodules and other types of
+	 * optimizations, but for now, we'll just point it to HEAD. First we
+	 * should make sure to reset it. This is useful for more complicated
+	 * stuff but a decent shortcut for the first pass is
+	 * add_head_to_pending().
+	 */
+
+	/*
+	 * struct setup_revision_opt opt;
+
+	 * memset(&opt, 0, sizeof(opt));
+	 * opt.def = "HEAD";
+	 * opt.revarg_opt = REVARG_COMMITTISH;
+	 * setup_revisions(argc, argv, rev, &opt);
+	 */
+
+	/* add the HEAD to pending so we can start */
+	add_head_to_pending(rev);
+
+	/* Let's force oneline format. */
+	get_commit_format("oneline", rev);
+	rev->verbose_header = 1;
+}
+
 /*
  * This method will be called back by git_config(). It is used to gather values
  * from the configuration files available to Git.
@@ -62,6 +97,8 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	struct rev_info rev;
+
 	/*
 	 * parse_options() handles showing usage if incorrect options are
 	 * provided, or if '-h' is passed.
@@ -72,6 +109,19 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 
 	git_config(git_walken_config, NULL);
 
+	/*
+	 * Time to set up the walk. repo_init_revisions sets up rev_info with
+	 * the defaults, but then you need to make some configuration settings
+	 * to make it do what's special about your walk.
+	 */
+	repo_init_revisions(the_repository, &rev, prefix);
+
+	/*
+	 * Before we do the walk, we need to set a starting point by giving it
+	 * something to go in `pending` - that happens in here
+	 */
+	final_rev_info_setup(argc, argv, prefix, &rev);
+
 	/*
 	 * This line is "human-readable" and we are writing a plumbing command,
 	 * so we localize it and use the trace library to print only when
-- 
2.22.0.410.gd8fdbe21b5-goog

