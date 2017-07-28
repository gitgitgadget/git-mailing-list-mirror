Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C57481F89D
	for <e@80x24.org>; Fri, 28 Jul 2017 17:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbdG1RSa (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 13:18:30 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36743 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752292AbdG1RS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 13:18:27 -0400
Received: by mail-pf0-f174.google.com with SMTP id z129so58692196pfb.3
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 10:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=djcUyFhQ4fQPbsoNs+lFYEtOzZg8hbjPuj0yeyGtEiA=;
        b=T2qKIeKWOrhGbcDX2dMlgZkJoDAwf9xEqNZOui+6Wa3+WP30nCr0p3Fg7UrEwvyohT
         771zl9xshet5xeXC7TOat6EWN62HOKzuGJVbYliRTyy8nvGdcnjgpon7IlrgoPVJ1HlC
         xZF02d6QCsKoDntWoKNvB32rLIrLy4iZJzF7cCOxV+bFRBj71jW1AjZgkzm+QTbBggZo
         bFXHPPNC2N2g5CPcjXL6AvlWuXp6qLUlYSV1PTMeOrcWH/tKtqTM0HA31q0INvvu9RFu
         Y+LPmw/+L2drYea4Wkq5AUvXIxhzUO/IayHrle36XahOdrwzHPj6UA9oyHdk+A2L7iuQ
         rWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=djcUyFhQ4fQPbsoNs+lFYEtOzZg8hbjPuj0yeyGtEiA=;
        b=R0On78+vQXf4MWjrUxCF0QB4FYIh9VRalggtjbI38sHmWmafBFLXLXl9+sH3+/zvj/
         95w0LFlW7cUGG+RY5EcxMpOsEMA9FeDrsyIMK3N2bznN/qtML9gzdUHFN1fQ7mDdIYly
         BN8h//tSOaL2QRI4svich1JiPk0VyG8IHfGDksK6wtYhgVqvUjqZr4/GvyuVjA/jil6L
         KbWWbpB4vfK4//svNrZG5vFca+aopY+NEqbnuC/llKImed2L+Ea71+4DO9olokNF/uAk
         E9jmKJZ+lJ6gv6wuHxgIDQVB4q5eRy0/7W8obXxLDps7aMmoanx2R5fM7NXh5L0GytKY
         uliQ==
X-Gm-Message-State: AIVw112TohBRvNGVllrPU8R8mXQRIBEz/9EESYiiuQ+z2PD9y4PNg/TK
        cE6ZbZ4gyxRSLt6XJZYmlg==
X-Received: by 10.98.215.18 with SMTP id b18mr8238190pfh.272.1501262306731;
        Fri, 28 Jul 2017 10:18:26 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:d9da:4cf2:5968:beb4])
        by smtp.gmail.com with ESMTPSA id l124sm39694248pfl.169.2017.07.28.10.18.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Jul 2017 10:18:25 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] alter hash function: expose test dependencies on sha1
Date:   Fri, 28 Jul 2017 10:18:16 -0700
Message-Id: <20170728171817.21458-2-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <20170728171817.21458-1-sbeller@google.com>
References: <20170728171817.21458-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DO NOT APPLY.

Alter the hash function such that with this patch
any dependency on sha1 in tests will make the test
fail. This patch applied on master yields this list:

./t0000-basic.sh
./t0002-gitfile.sh
./t0005-signals.sh
./t0013-sha1dc.sh
./t0021-conversion.sh
./t0090-cache-tree.sh
./t1001-read-tree-m-2way.sh
./t1007-hash-object.sh
./t1011-read-tree-sparse-checkout.sh
./t1013-read-tree-submodule.sh
./t1100-commit-tree-options.sh
./t1200-tutorial.sh
./t1300-repo-config.sh
./t1304-default-acl.sh
./t1400-update-ref.sh
./t1411-reflog-show.sh
./t1450-fsck.sh
./t1507-rev-parse-upstream.sh
./t1512-rev-parse-disambiguation.sh
./t1700-split-index.sh
./t2011-checkout-invalid-head.sh
./t2013-checkout-submodule.sh
./t2015-checkout-unborn.sh
./t2017-checkout-orphan.sh
./t2022-checkout-paths.sh
./t2101-update-index-reupdate.sh
./t2107-update-index-basic.sh
./t2203-add-intent.sh
./t3033-merge-toplevel.sh
./t3102-ls-tree-wildcards.sh
./t3103-ls-tree-misc.sh
./t3201-branch-contains.sh
./t3301-notes.sh
./t3305-notes-fanout.sh
./t3306-notes-prune.sh
./t3308-notes-merge.sh
./t3309-notes-merge-auto-resolve.sh
./t3310-notes-merge-manual-resolve.sh
./t3311-notes-merge-fanout.sh
./t3400-rebase.sh
./t3404-rebase-interactive.sh
./t3405-rebase-malformed.sh
./t3408-rebase-multi-line.sh
./t3415-rebase-autosquash.sh
./t3419-rebase-patch-id.sh
./t3421-rebase-topology-linear.sh
./t3501-revert-cherry-pick.sh
./t3502-cherry-pick-merge.sh
./t3503-cherry-pick-root.sh
./t3506-cherry-pick-ff.sh
./t3509-cherry-pick-merge-df.sh
./t3600-rm.sh
./t3700-add.sh
./t3701-add-interactive.sh
./t3702-add-edit.sh
./t3903-stash.sh
./t3905-stash-include-untracked.sh
./t4002-diff-basic.sh
./t4007-rename-3.sh
./t4008-diff-break-rewrite.sh
./t4010-diff-pathspec.sh
./t4011-diff-symlink.sh
./t4013-diff-various.sh
./t4014-format-patch.sh
./t4015-diff-whitespace.sh
./t4020-diff-external.sh
./t4022-diff-rewrite.sh
./t4029-diff-trailing-space.sh
./t4030-diff-textconv.sh
./t4033-diff-patience.sh
./t4034-diff-words.sh
./t4039-diff-assume-unchanged.sh
./t4042-diff-textconv-caching.sh
./t4044-diff-index-unique-abbrev.sh
./t4045-diff-relative.sh
./t4048-diff-combined-binary.sh
./t4050-diff-histogram.sh
./t4052-stat-output.sh
./t4054-diff-bogus-tree.sh
./t4060-diff-submodule-option-diff-format.sh
./t4126-apply-empty.sh
./t4151-am-abort.sh
./t4202-log.sh
./t4205-log-pretty-formats.sh
./t4208-log-magic-pathspec.sh
./t4211-line-log.sh
./t4300-merge-tree.sh
./t5150-request-pull.sh
./t5300-pack-object.sh
./t5306-pack-nobase.sh
./t5308-pack-detect-duplicates.sh
./t5309-pack-delta-cycles.sh
./t5313-pack-bounds-checks.sh
./t5512-ls-remote.sh
./t5515-fetch-merge-logic.sh
./t5516-fetch-push.sh
./t5520-pull.sh
./t5521-pull-options.sh
./t6000-rev-list-misc.sh
./t6012-rev-list-simplify.sh
./t6020-merge-df.sh
./t6022-merge-rename.sh
./t6024-recursive-merge.sh
./t6030-bisect-porcelain.sh
./t6031-merge-filemode.sh
./t6035-merge-dir-to-symlink.sh
./t6300-for-each-ref.sh
./t6500-gc.sh
./t7003-filter-branch.sh
./t7012-skip-worktree-writing.sh
./t7063-status-untracked-cache.sh
./t7102-reset.sh
./t7106-reset-unborn-branch.sh
./t7112-reset-submodule.sh
./t7201-co.sh
./t7400-submodule-basic.sh
./t7506-status-submodule.sh
./t7507-commit-verbose.sh
./t7508-status.sh
./t7600-merge.sh
./t7607-merge-overwrite.sh
./t7609-merge-co-error-msgs.sh
./t8008-blame-formats.sh

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 sha1dc/sha1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 25eded1399..e18acee9ca 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -1756,7 +1756,7 @@ static void sha1_process(SHA1_CTX* ctx, const uint32_t block[16])
 void SHA1DCInit(SHA1_CTX* ctx)
 {
 	ctx->total = 0;
-	ctx->ihv[0] = 0x67452301;
+	ctx->ihv[0] = 0x07452301;
 	ctx->ihv[1] = 0xEFCDAB89;
 	ctx->ihv[2] = 0x98BADCFE;
 	ctx->ihv[3] = 0x10325476;
-- 
2.14.0.rc0.3.g6c2e499285

