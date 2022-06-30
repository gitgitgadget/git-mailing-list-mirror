Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE3BC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 22:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiF3WMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiF3WMP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 18:12:15 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC1A57237
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:12:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3177608c4a5so5157967b3.14
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eBLyHJ7Vj4gMfX0LabfZAIoVNiAmswRt04r+Z0L2ESQ=;
        b=avjOCQ2RGH14gqVwM6pyzqUzTfUSrTmg2/04cEn+nMCTrMtyWAKzImx/RLMUE/Etij
         AwHvC78ctCAl//EK/g00RasLZ5Bn7xjE9D3z4UX8r5CxmjdYM+WXgqxSTUCkpD+gw0Tc
         u/kElIaOBzhU5jVjY8sTUK0KMWB4RVw4dQpMAyb/acpm0A/p4/sJ8YkaHPH3/BrWlh1Q
         53QY0h1v8YIdupXC0iNR7jHeLGhRE/HzHwmiLkOnali5aX0QQOalXt2nYSSWgT0Uo8qE
         0YJiBYAG6BG6VWOXl+GXKntu298dAgIekIyM7UyGN6FU9FG5wTvNDf15TeV5U9gPdA1h
         /0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eBLyHJ7Vj4gMfX0LabfZAIoVNiAmswRt04r+Z0L2ESQ=;
        b=YvXs/TgzxFxw+c2gZCGtA9cn4Y88O856L49fWhml7se6OyUqfEgdwiZagfWtQaWITW
         63D7Na8jC9oFd4d0u6y3xkPfOiUNKK6TuZFdwreVIA6mc0RtS+QLe+dhUfUCtLgpUDwk
         1HJKoGObWfx8yIB9DjZIVJpgyuWHtv3PL0umv3PrKtrPB/QBGIvjdbNDp4bw+GcMfGL7
         J06K/c2Sst+Xgp4NfrtvWUiPO5WdtDspL9N5RoGoNhgfd+AMzIbcIHBt6+f6crtyfXCG
         m0kuwrEeiowNLWFOqmvd4wVTpvxY165wIvu3UOwa19Yy7OiGAkR1BjU9MyZjNmOMxZKK
         5WOA==
X-Gm-Message-State: AJIora8isqiADgPHZDF5IS3T7b8WTVxyoef/I2lR9iM0AkUQ9Znwqnr4
        L3em7+dG4AHeduPOenj9j3ZfDGPMDtxfIMJRFdeJjlReTTD4uQWb5IofgcM+7ZxG9MjI38+O1ht
        qUljj73DPAfflpvBEARJUtpbb4TnAMG5F+ZkSTj5eFVKkTd4hlnXFAr0TqGwK2wE=
X-Google-Smtp-Source: AGRyM1tsGT7uIzZ09nOcxi4X2gNON5GKmxy5SfOL9JDZc4rfGyO/8CmNx7j0bp6br0jCZPGQvZfspBeiLXp66g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a81:8ce:0:b0:31c:49d1:1731 with SMTP id
 197-20020a8108ce000000b0031c49d11731mr4855845ywi.376.1656627127564; Thu, 30
 Jun 2022 15:12:07 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:11:47 -0700
In-Reply-To: <20220630221147.45689-1-chooglen@google.com>
Message-Id: <20220630221147.45689-7-chooglen@google.com>
Mime-Version: 1.0
References: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com> <20220630221147.45689-1-chooglen@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 6/6] submodule--helper: remove display path helper
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

All invocations of do_get_submodule_displaypath() pass
get_super_prefix() as the super_prefix arg, which is exactly the same
as get_submodule_displaypath().

Replace all calls to do_get_submodule_displaypath() with
get_submodule_displaypath(), and since it has no more callers, remove
it.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 41177332dd..3e0ceb5258 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -118,10 +118,11 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
-static char *do_get_submodule_displaypath(const char *path,
-					  const char *prefix,
-					  const char *super_prefix)
+/* the result should be freed by the caller. */
+static char *get_submodule_displaypath(const char *path, const char *prefix)
 {
+	const char *super_prefix = get_super_prefix();
+
 	if (prefix && super_prefix) {
 		BUG("cannot have prefix '%s' and superprefix '%s'",
 		    prefix, super_prefix);
@@ -137,13 +138,6 @@ static char *do_get_submodule_displaypath(const char *path,
 	}
 }
 
-/* the result should be freed by the caller. */
-static char *get_submodule_displaypath(const char *path, const char *prefix)
-{
-	const char *super_prefix = get_super_prefix();
-	return do_get_submodule_displaypath(path, prefix, super_prefix);
-}
-
 static char *compute_rev_name(const char *sub_path, const char* object_id)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -488,7 +482,7 @@ static void init_submodule(const char *path, const char *prefix,
 	struct strbuf sb = STRBUF_INIT;
 	char *upd = NULL, *url = NULL, *displaypath;
 
-	displaypath = do_get_submodule_displaypath(path, prefix, get_super_prefix());
+	displaypath = get_submodule_displaypath(path, prefix);
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
@@ -1947,9 +1941,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	int needs_cloning = 0;
 	int need_free_url = 0;
 
-	displaypath = do_get_submodule_displaypath(ce->name,
-						   suc->update_data->prefix,
-						   get_super_prefix());
+	displaypath =
+		get_submodule_displaypath(ce->name, suc->update_data->prefix);
 
 	if (ce_stage(ce)) {
 		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath);
@@ -2461,9 +2454,8 @@ static int update_submodule(struct update_data *update_data)
 {
 	ensure_core_worktree(update_data->sm_path);
 
-	update_data->displaypath = do_get_submodule_displaypath(update_data->sm_path,
-								update_data->prefix,
-								get_super_prefix());
+	update_data->displaypath = get_submodule_displaypath(
+		update_data->sm_path, update_data->prefix);
 
 	determine_submodule_update_strategy(the_repository, update_data->just_cloned,
 					    update_data->sm_path, update_data->update_default,
-- 
2.37.0.rc0.161.g10f37bed90-goog

