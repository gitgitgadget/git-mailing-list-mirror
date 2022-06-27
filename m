Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67153C433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 23:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241829AbiF0XUX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 19:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241117AbiF0XUW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 19:20:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CCF2408F
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 16:20:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o4so11166096wrh.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 16:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7O0JW1YeyGLYQ/boC6Lsk5ZRa1VVtTah6mpLiweSmBI=;
        b=mEFgNures3Iei5KKEZPzs2yhQyWensYreoB7bBk75BTC+0+NkdqtF8ajjQ9zcZYVaO
         3ItwrzwZdxx7bry5MLZuappYlnH7u5pvV3YzqIGIYmE2huSwSHief6TgZQ2jgWqV4Cyl
         LdJh9FGuu5CN9aRSl5yQa4ILnhn6HYr98deulFj4cZ7GfEbJXu75tDrV1EFtwoonHAD3
         o/aBvzSeyBEaeBr25TBFDS9zkOiN57HigGMdNUf3BzdB5//bWTjuTZdrovW1p1qwQGaV
         pmEzJYklwXD8SN8wwvMDIDvofufMiA1zBKgypmIHSvrfwWRQ6g9DVCH1qZSZGokzEVus
         RrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7O0JW1YeyGLYQ/boC6Lsk5ZRa1VVtTah6mpLiweSmBI=;
        b=rx5tbTM9Ta3rj5QbhuN5x84UnHXPr7hnm29Hct4UliAQreq79x4brbY/veF4Xtm/kL
         gvfjWv8DVM0qdgwcHG2qig/vZJyp60KOSvSBdSn9PClCJSFGD+x5SFYF+C2ffLKsCTF2
         rmJ1iEEyyUkYCZibCW3fh6MZcSxO2YqCx/o86ofcbTL5FouNZRJYNWW0MrcaCUMNa84g
         oc20hSxJ4zSRtKKljICVEf478YR3+NitnvIXFE89SoKpD4t7INP7Uv5dMsi4rMTx2Lp6
         kJzQggAH0GOdqgn6umrwo5bwwy3wXx54XIaCjNLRDQyBZ6nXtaGRyw1dMsdY7LvTU23r
         +iBQ==
X-Gm-Message-State: AJIora+YOoZZT3fW2zwYy6cx5HqMxZNPi87BKlleuYh8so5onfb2ay5u
        ZQiRS49g468TvsQsLK3yBuzyTHWjMa7N/A==
X-Google-Smtp-Source: AGRyM1t/z7ogHRj0nDSAzFATf1NzGMTa6pfKzSAxqiQxiOiHF6RXJdvTvPj9uZ7regXcbpRwZeXFQw==
X-Received: by 2002:a5d:6812:0:b0:21b:8a2f:f732 with SMTP id w18-20020a5d6812000000b0021b8a2ff732mr14184659wru.202.1656372019706;
        Mon, 27 Jun 2022 16:20:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5-20020adfe545000000b0021b81855c1csm14264937wrm.27.2022.06.27.16.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:20:19 -0700 (PDT)
Message-Id: <473548f2fa473b9b94fcc099a81613c622a32022.1656372017.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 23:20:13 +0000
Subject: [PATCH 1/5] submodule--helper update: use display path helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

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
 builtin/submodule--helper.c | 22 +++++---------
 t/t7406-submodule-update.sh | 59 +++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c597df7528e..63c661b26a6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1949,30 +1949,22 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	const char *update_string;
 	enum submodule_update_type update_type;
 	char *key;
-	struct strbuf displaypath_sb = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
-	const char *displaypath = NULL;
+	char *displaypath = NULL;
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
-		strbuf_addch(out, '\n');
+		strbuf_addf(out, _("Skipping unmerged submodule '%s'\n"), displaypath);
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
@@ -2062,7 +2054,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 					      "--no-single-branch");
 
 cleanup:
-	strbuf_release(&displaypath_sb);
+	free(displaypath);
 	strbuf_release(&sb);
 	if (need_free_url)
 		free((void*)url);
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 43f779d751c..e1dc3b1041b 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1116,4 +1116,63 @@ test_expect_success 'submodule update --filter sets partial clone settings' '
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
+	# Create an upstream commit in each repo
+	test_commit -C bottom upstream_commit &&
+	(cd middle &&
+	 git -C bottom fetch &&
+	 git -C bottom checkout -f FETCH_HEAD &&
+	 git add bottom &&
+	 git commit -m "upstream_commit"
+	) &&
+	(cd top &&
+	 git -C middle fetch &&
+	 git -C middle checkout -f FETCH_HEAD &&
+	 git add middle &&
+	 git commit -m "upstream_commit"
+	) &&
+
+	# Create a downstream conflict
+	(cd top-cloned/middle &&
+	 test_commit -C bottom downstream_commit &&
+	 git add bottom &&
+	 git commit -m "downstream_commit" &&
+	 git fetch --recurse-submodules origin &&
+	 test_must_fail git merge origin/main
+	) &&
+	# Make the update of "middle" a no-op, otherwise we error out
+	# because of its unmerged state
+	test_config -C top-cloned submodule.middle.update !true &&
+	git -C top-cloned submodule update --recursive 2>actual.err &&
+	grep "Skipping unmerged submodule .middle/bottom." actual.err
+'
+
+test_expect_success 'submodule update --recursive skip submodules with strategy=none' '
+	test_when_finished "rm -fr top-cloned" &&
+	cp -r top-clean top-cloned &&
+
+	test_commit -C top-cloned/middle/bottom downstream_commit &&
+	git -C top-cloned/middle config submodule.bottom.update none &&
+	git -C top-cloned submodule update --recursive 2>actual.err &&
+	grep "Skipping submodule .middle/bottom." actual.err
+'
+
 test_done
-- 
gitgitgadget

