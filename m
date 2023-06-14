Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCEDEB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 16:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbjFNQtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 12:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236036AbjFNQtV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 12:49:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6731BC6
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 09:49:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-561eb6c66f6so12185677b3.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 09:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686761360; x=1689353360;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T9AJ3jJkRj+aS+FH4rQ7aMad7zEBLZV4V/tvqKuna2Y=;
        b=YTTufpG631iWovvG5RZhffXNEw1+hgf+6XGq7fUALaCGUKN7K2AH79Pej2xUMmVri8
         pVIXzwoGQJyTL894QE/aMr9k/X4m3KdsQtEM6e+wR+epblMoSB/hxABauiRDNOixxMfC
         3ga5y+iD0nU/cTmWpVGJCeLqxpN0Cc35N4iUB2foofoSh4YngZHuNsfUsnnmx4lfZVz0
         T5MR/Vrtl+l7AqKe/A3LmHPp7L9LNwCqJsYewWLZGHeC7L1h0sRP9rYfVaq0rcW2HKKn
         ebOVumt/C8JmzbI9XP9lY6D9iN18eo5b3tr8Ioir+vB1L7lQDUDKzo7e67BgMlto7hAD
         IGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686761360; x=1689353360;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T9AJ3jJkRj+aS+FH4rQ7aMad7zEBLZV4V/tvqKuna2Y=;
        b=F4ZxISLJTGOX+tgNad+6xkTI2V2CXjBk+nlK6PbcTpvE7GpRPDidvTM7KEO4Efbjo4
         NIIxn7cw7rhXAZa1sFynhQMNfxF1jRz92oaPUxkTVNabLj6C7RMkI0BHf7On3/RtBvWJ
         uL6gx9FLgaw33bl/+yFGB6zlGPsZGMvUru5QNsR5fV0AhYhdtuScrqpaDkWmUNeRjoCo
         nz6n/eIOhG3yw6FEWb2vuCe1Bq6UHuDjyrE3GOmf6RzIZp/442bY5jOjBw2TfNTxJmW2
         nve5yV1vS6iLYF09o0WrNKAZxWat+YuZEd6SmZ/n6ZbHFEbyUz0jnCxK3zG/LHMa9OCw
         R6vw==
X-Gm-Message-State: AC+VfDzeCWY9pJvt3nWzS1ZPdJEEWdLvC0fpU/c1Q1PZOYBHyvYGpnno
        ibzBNpIec5LrW/14E9fQho4Ij8RRE9/JKpsWrY+4h42B1IyixKBe69VXOy4/8kWhPytteRmVrit
        Dmp9Bg4rVLQp5aYEe8dFe7MADV3f71utZm3rKibNE2LjwMcM6v0mqCAYhnSxhUAk=
X-Google-Smtp-Source: ACHHUZ6ZEgYp4HqgFZKK7TdIwC+f5Oyn69Qzejw/Z+p0bTu6t76k7SthrLVFXZL2ugoMfikCTcQmibURk9Qdjg==
X-Received: from sokac.sfo.corp.google.com ([2620:15c:11a:202:d1e8:6e0c:96d0:4f23])
 (user=sokcevic job=sendgmr) by 2002:a81:ce0c:0:b0:56d:7a5:2887 with SMTP id
 t12-20020a81ce0c000000b0056d07a52887mr1081742ywi.2.1686761359860; Wed, 14 Jun
 2023 09:49:19 -0700 (PDT)
Date:   Wed, 14 Jun 2023 09:48:57 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614164856.3186012-2-sokcevic@google.com>
Subject: [PATCH v4] diff-lib: honor override_submodule_config flag bit
From:   Josip Sokcevic <sokcevic@google.com>
To:     git@vger.kernel.org
Cc:     Josip Sokcevic <sokcevic@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `diff.ignoreSubmodules = all` is set and submodule commits are
manually staged (e.g. via `git-update-index`), `git-commit` should
record the commit  with updated submodules.

`index_differs_from` is called from `prepare_to_commit` with flags set to
`override_submodule_config = 1`. `index_differs_from` then merges the
default diff flags and passed flags.

When `diff.ignoreSubmodules` is set to "all", `flags` ends up having
both `override_submodule_config` and `ignore_submodules` set to 1. This
results in `git-commit` ignoring staged commits.

This patch restores original `flags.ignore_submodule` if
`flags.override_submodule_config` is set.

Signed-off-by: Josip Sokcevic <sokcevic@google.com>
---
 diff-lib.c                  |  9 ++++++++-
 t/t7406-submodule-update.sh | 23 +++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/diff-lib.c b/diff-lib.c
index 60e979dc1b..1918517ebd 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -669,8 +669,15 @@ int index_differs_from(struct repository *r,
 	setup_revisions(0, NULL, &rev, &opt);
 	rev.diffopt.flags.quick = 1;
 	rev.diffopt.flags.exit_with_status = 1;
-	if (flags)
+	if (flags) {
 		diff_flags_or(&rev.diffopt.flags, flags);
+		/*
+		 * Now that flags are merged, honor override_submodule_config
+		 * and ignore_submodules from passed flags.
+		 */
+		if (flags->override_submodule_config)
+			rev.diffopt.flags.ignore_submodules = flags->ignore_submodules;
+	}
 	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
 	run_diff_index(&rev, 1);
 	has_changes = rev.diffopt.flags.has_changes;
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index f094e3d7f3..00651c25cb 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1179,4 +1179,27 @@ test_expect_success 'submodule update --recursive skip submodules with strategy=
 	test_cmp expect.err actual.err
 '
 
+add_submodule_commit_and_validate () {
+	HASH=$(git rev-parse HEAD) &&
+	git update-index --add --cacheinfo 160000,$HASH,sub &&
+	git commit -m "create submodule" &&
+	echo "160000 commit $HASH	sub" >expect &&
+	git ls-tree HEAD -- sub >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'commit with staged submodule change' '
+	add_submodule_commit_and_validate
+'
+
+test_expect_success 'commit with staged submodule change with ignoreSubmodules dirty' '
+	test_config diff.ignoreSubmodules dirty &&
+	add_submodule_commit_and_validate
+'
+
+test_expect_success 'commit with staged submodule change with ignoreSubmodules all' '
+	test_config diff.ignoreSubmodules all &&
+	add_submodule_commit_and_validate
+'
+
 test_done
-- 
2.41.0.162.gfafddb0af9-goog

