Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73690C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 22:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiF3WMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiF3WMA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 18:12:00 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7227C5721E
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:11:58 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id h18-20020a170902f55200b0016a4a78bd71so295715plf.9
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LVTHjkAYlaiepUv4M45wNpA3phOsy2EDVQqr3hLaclQ=;
        b=leA1SaCrJgxU6EQt+ozatNOXwpHs96PMHSWl7iQz9/di7+cv9qRtZXLRlj4uf+C3W/
         F/2+AYLdhwWfNi2RztVESLLX5F9VvJL1y4Yb1QJqHmc/6WKzF6PobhWian1iylrC4sMn
         beKNNjiMZn3WFbFbT0oAUqHR0Zyo118VsbU4GqNMZbCL3vInsDJRC0cs4xUKExWDtFLV
         ne9AfQzTG9YRyxqS5UhkSZfUOHOXO7Fi/AVHERXvIy8uOz5PuMPzsxHsrAvvnf5K4z2c
         7fOofVlq09nuCAVrMk2qvYvv+f/LISLeJilyMOo34RA2Y+mTSzmdavjYQXyx+IUbmTUR
         UUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LVTHjkAYlaiepUv4M45wNpA3phOsy2EDVQqr3hLaclQ=;
        b=WW9lsGzb3STqRAlAR3rZToufU6yhwtZlrSIoBqLRg++ynIL0qawWh9X+tzmUq/Gjc7
         Mr1+kvTufAOgP9RC+pxgiMkj/9Tgh45heUE9DWsxiJZY5nyxGKxJfi8dT5Y9TiGkxFNR
         6DZRqIadrZ02Slnyv7NHzHcsynyj0rIhmkTQbB21lp730VKZLBIkeUjDFwHbmlKP78sC
         ARvD9mkRWjQt3tJAH+bnW58lbQ9oPQepfmFU5GuvKU8ug8MV/MWQdiAuPBKv+GuzycHG
         LE9ioJOaofKtnPk9ZUm0dg9Yqm2Js+5HdwctpVSgi0FDIXs0bK7TcMXN/PjUB8FaEXPM
         p9Sg==
X-Gm-Message-State: AJIora/B9LxXKzhTeycOOyBBzlOd7lpgWzwpwsZeXMHT9ButsLdxxD8O
        ljO8PQwOKZv5OUvdDfRvgXvEXj8xqPr2oPW/FYbjNNvIZdbbCFnjAkUiwYmnGg6RvvIiiYMw9Nx
        rVqwewj/K+tabKt+dWwBjS+D0aV82Bcayxao4N8QhLoZn9lKi+xz19GD+Pw3TF+A=
X-Google-Smtp-Source: AGRyM1u0cyLncqrojKO2lnsju1c/zZts7bQskFdvTI9mW7CXD+bRBpQvP0OTlTSBfsIIPdP1aPeU48jOJSBHHw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:15cc:b0:525:8b07:71c3 with SMTP
 id o12-20020a056a0015cc00b005258b0771c3mr17840363pfu.57.1656627117829; Thu,
 30 Jun 2022 15:11:57 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:11:42 -0700
In-Reply-To: <20220630221147.45689-1-chooglen@google.com>
Message-Id: <20220630221147.45689-2-chooglen@google.com>
Mime-Version: 1.0
References: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com> <20220630221147.45689-1-chooglen@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 1/6] submodule--helper update: use display path helper
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two locations in prepare_to_clone_next_submodule() that
manually calculate the submodule display path, but should just use
do_get_submodule_displaypath() for consistency.

Do this replacement and reorder the code slightly to avoid computing
the display path twice.

This code was never tested, and adding tests shows that both these sites
have been computing the display path incorrectly ever since they were
introduced in 48308681b0 (git submodule update: have a dedicated helper
for cloning, 2016-02-29) [1]:

- The first hunk puts a "/" between recursive_prefix and ce->name, but
  recursive_prefix already ends with "/".
- The second hunk calls relative_path() on recursive_prefix and
  ce->name, but relative_path() only makes sense when both paths share
  the same base directory. This is never the case here:
  - recursive_prefix is the path from the topmost superproject to the
    current submodule
  - ce->name is the path from the root of the current submodule to its
    submodule.
  so, e.g. recursive_prefix="super" and ce->name="submodule" produces
  displayname="../super" instead of "super/submodule".

While we're fixing the display names, also fix inconsistent quoting of
the submodule name.

[1] I verified this by applying the tests to 48308681b0.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 21 +++++---------
 t/t7406-submodule-update.sh | 56 +++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 389b900602..db2d5ab799 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1947,30 +1947,23 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	const char *update_string;
 	enum submodule_update_type update_type;
 	char *key;
-	struct strbuf displaypath_sb = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
-	const char *displaypath = NULL;
+	char *displaypath;
 	int needs_cloning = 0;
 	int need_free_url = 0;
 
+	displaypath = do_get_submodule_displaypath(ce->name,
+						   suc->update_data->prefix,
+						   suc->update_data->recursive_prefix);
+
 	if (ce_stage(ce)) {
-		if (suc->update_data->recursive_prefix)
-			strbuf_addf(&sb, "%s/%s", suc->update_data->recursive_prefix, ce->name);
-		else
-			strbuf_addstr(&sb, ce->name);
-		strbuf_addf(out, _("Skipping unmerged submodule %s"), sb.buf);
+		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath);
 		strbuf_addch(out, '\n');
 		goto cleanup;
 	}
 
 	sub = submodule_from_path(the_repository, null_oid(), ce->name);
 
-	if (suc->update_data->recursive_prefix)
-		displaypath = relative_path(suc->update_data->recursive_prefix,
-					    ce->name, &displaypath_sb);
-	else
-		displaypath = ce->name;
-
 	if (!sub) {
 		next_submodule_warn_missing(suc, out, displaypath);
 		goto cleanup;
@@ -2060,7 +2053,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 					      "--no-single-branch");
 
 cleanup:
-	strbuf_release(&displaypath_sb);
+	free(displaypath);
 	strbuf_release(&sb);
 	if (need_free_url)
 		free((void*)url);
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 06d804e213..f0408c5cc4 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1116,4 +1116,60 @@ test_expect_success 'submodule update --filter sets partial clone settings' '
 	test_cmp_config -C super-filter/submodule blob:none remote.origin.partialclonefilter
 '
 
+# NEEDSWORK: Clean up the tests so that we can reuse the test setup.
+# Don't reuse the existing repos because the earlier tests have
+# intentionally disruptive configurations.
+test_expect_success 'setup clean recursive superproject' '
+	git init bottom &&
+	test_commit -C bottom "bottom" &&
+	git init middle &&
+	git -C middle submodule add ../bottom bottom &&
+	git -C middle commit -m "middle" &&
+	git init top &&
+	git -C top submodule add ../middle middle &&
+	git -C top commit -m "top" &&
+	git clone --recurse-submodules top top-clean
+'
+
+test_expect_success 'submodule update should skip unmerged submodules' '
+	test_when_finished "rm -fr top-cloned" &&
+	cp -r top-clean top-cloned &&
+
+	# Create an upstream commit in each repo, starting with bottom
+	test_commit -C bottom upstream_commit &&
+	# Create middle commit
+	git -C middle/bottom fetch &&
+	git -C middle/bottom checkout -f FETCH_HEAD &&
+	git -C middle add bottom &&
+	git -C middle commit -m "upstream_commit" &&
+	# Create top commit
+	git -C top/middle fetch &&
+	git -C top/middle checkout -f FETCH_HEAD &&
+	git -C top add middle &&
+	git -C top commit -m "upstream_commit" &&
+
+	# Create a downstream conflict
+	test_commit -C top-cloned/middle/bottom downstream_commit &&
+	git -C top-cloned/middle add bottom &&
+	git -C top-cloned/middle commit -m "downstream_commit" &&
+	git -C top-cloned/middle fetch --recurse-submodules origin &&
+	test_must_fail git -C top-cloned/middle merge origin/main &&
+
+	# Make the update of "middle" a no-op, otherwise we error out
+	# because of its unmerged state
+	test_config -C top-cloned submodule.middle.update !true &&
+	git -C top-cloned submodule update --recursive 2>actual.err &&
+	grep -F "Skipping unmerged submodule middle/bottom" actual.err
+'
+
+test_expect_success 'submodule update --recursive skip submodules with strategy=none' '
+	test_when_finished "rm -fr top-cloned" &&
+	cp -r top-clean top-cloned &&
+
+	test_commit -C top-cloned/middle/bottom downstream_commit &&
+	git -C top-cloned/middle config submodule.bottom.update none &&
+	git -C top-cloned submodule update --recursive 2>actual.err &&
+	grep -F "Skipping submodule ${SQ}middle/bottom${SQ}" actual.err
+'
+
 test_done
-- 
2.37.0.rc0.161.g10f37bed90-goog

