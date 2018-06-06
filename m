Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6BF1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 07:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932359AbeFFHk2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 03:40:28 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46103 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932274AbeFFHkD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 03:40:03 -0400
Received: by mail-lf0-f68.google.com with SMTP id j13-v6so7537264lfb.13
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 00:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S/tTtRAWHjTHnRAdB3nnsEgAzLE3j+oQJ40DStrNGTs=;
        b=nn4mFS3F874jAJkiSk1ya103wqHdFH8PQlj3mc/rXyoNX4V0r4/7j1q7+71u2W9zsZ
         eelIYtQWgm2/iCLszclsqfDilO+n8W1/Xs881+0f2+R7K+zqF4GZiU/HKVasagN0ErOS
         HjJgeqRHJBpGRrFXJiQfmeWfUutXOkAQJUpfDh9MD5BZ9gwIK+YE45ShE7K2Yh89vde1
         45JWsZ0XZLRCRNZ3Bjo7gQQT3EH7KFsuaZ+U/Enw9B+9hVMVPEQcSYP8cxqiOQQ/rfb+
         mMVPMtyLqPrbeCR3XZy0Moz4sHs9kN5Uyn8++itU6KgR6VlIiNSVR9JYv3j7me46D6M/
         CNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S/tTtRAWHjTHnRAdB3nnsEgAzLE3j+oQJ40DStrNGTs=;
        b=g1W3l2XDYmTsRYkOiO0NziBJ9kvOV+ApdEsNYf2OsNxxP+/aD0EicLu6KROcGRnKjY
         4JKJqGQkJbqjIepP6SPMkP5HVCBl3p809UtWdGFsv+ihl5Bnk+268ONDGaUhbnMlV11P
         rdw+HXdWOS9++oIfbb2hRZVatuAA18FOFiQxbvQa1A9LZRLWvl2bHXZ2BzT0ZZWVzAL6
         ESUJKB4x/No+qyqhSgjr8kNcS/ZEtmvomzJOJEPvy8uQWRsacFpk+5h+jHiQ63kw60at
         dPfBU9v26tOc5uLGt/sR14eTGmWm78ypJT4f8HQsNGaLofOGxYhl7r/eVlBjW+l6D80J
         Sm1g==
X-Gm-Message-State: APt69E0XxqUns9XAEUTKslYNiw85jYsTZ+FPKprLPbhFQonpSQu84z6/
        3dehBHqV7u5v+jqSio2dCMg=
X-Google-Smtp-Source: ADUXVKJEcMSUSmr5DXWmsDQ+Qo7gy9BUwC5LholraZkMBhEfCe2OI2adNvjQMyUUcvrZXqtJ3kkOZA==
X-Received: by 2002:a19:cd08:: with SMTP id d8-v6mr1169119lfg.41.1528270801868;
        Wed, 06 Jun 2018 00:40:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4189048lji.4.2018.06.06.00.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 00:40:01 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v3 15/20] attr: remove index from git_attr_set_direction()
Date:   Wed,  6 Jun 2018 09:39:28 +0200
Message-Id: <20180606073933.14755-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606073933.14755-1-pclouds@gmail.com>
References: <20180606050207.13556-1-pclouds@gmail.com>
 <20180606073933.14755-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since attr checking API now take the index, there's no need to set an
index in advance with this call. Most call sites are straightforward
because they either pass the_index or NULL (which defaults back to
the_index previously). There's only one suspicious call site in
unpack-trees.c where it sets a different index.

This code in unpack-trees is about to checking out entries from the
new/temporary index after merging is done in it. The attributes will
be used by entry.c code to do crlf conversion if needed. entry.c now
respects struct checkout's istate field, and this field is correctly
set in unpack-trees.c, there should be no regression from this change.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 archive.c            |  2 +-
 attr.c               | 15 +++------------
 attr.h               |  3 +--
 builtin/check-attr.c |  2 +-
 unpack-trees.c       |  4 ++--
 5 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/archive.c b/archive.c
index 1b44503ebb..d1d0a0d6b3 100644
--- a/archive.c
+++ b/archive.c
@@ -273,7 +273,7 @@ int write_archive_entries(struct archiver_args *args,
 		init_tree_desc(&t, args->tree->buffer, args->tree->size);
 		if (unpack_trees(1, &t, &opts))
 			return -1;
-		git_attr_set_direction(GIT_ATTR_INDEX, &the_index);
+		git_attr_set_direction(GIT_ATTR_INDEX);
 	}
 
 	err = read_tree_recursive(args->tree, "", 0, 0, &args->pathspec,
diff --git a/attr.c b/attr.c
index 863fad3bd1..98e4953f6e 100644
--- a/attr.c
+++ b/attr.c
@@ -708,10 +708,8 @@ static struct attr_stack *read_attr_from_array(const char **list)
  * another thread could potentially be calling into the attribute system.
  */
 static enum git_attr_direction direction;
-static const struct index_state *use_index;
 
-void git_attr_set_direction(enum git_attr_direction new_direction,
-			    const struct index_state *istate)
+void git_attr_set_direction(enum git_attr_direction new_direction)
 {
 	if (is_bare_repository() && new_direction != GIT_ATTR_INDEX)
 		BUG("non-INDEX attr direction in a bare repo");
@@ -720,7 +718,6 @@ void git_attr_set_direction(enum git_attr_direction new_direction,
 		drop_all_attr_stacks();
 
 	direction = new_direction;
-	use_index = istate;
 }
 
 static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
@@ -750,17 +747,11 @@ static struct attr_stack *read_attr_from_index(const struct index_state *istate,
 	struct attr_stack *res;
 	char *buf, *sp;
 	int lineno = 0;
-	const struct index_state *to_read_from;
 
-	/*
-	 * Temporary workaround for c24f3abace (apply: file commited
-	 * with CRLF should roundtrip diff and apply - 2017-08-19)
-	 */
-	to_read_from = use_index ? use_index : istate;
-	if (!to_read_from)
+	if (!istate)
 		return NULL;
 
-	buf = read_blob_data_from_index(to_read_from, path, NULL);
+	buf = read_blob_data_from_index(istate, path, NULL);
 	if (!buf)
 		return NULL;
 
diff --git a/attr.h b/attr.h
index 3daca3c0cb..01dab4a126 100644
--- a/attr.h
+++ b/attr.h
@@ -77,8 +77,7 @@ enum git_attr_direction {
 	GIT_ATTR_CHECKOUT,
 	GIT_ATTR_INDEX
 };
-void git_attr_set_direction(enum git_attr_direction new_direction,
-			    const struct index_state *istate);
+void git_attr_set_direction(enum git_attr_direction new_direction);
 
 void attr_start(void);
 
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index f7b59993d3..c05573ff9c 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -120,7 +120,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	}
 
 	if (cached_attrs)
-		git_attr_set_direction(GIT_ATTR_INDEX, NULL);
+		git_attr_set_direction(GIT_ATTR_INDEX);
 
 	doubledash = -1;
 	for (i = 0; doubledash < 0 && i < argc; i++) {
diff --git a/unpack-trees.c b/unpack-trees.c
index 3ace82ca27..8cb407173e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -361,7 +361,7 @@ static int check_updates(struct unpack_trees_options *o)
 	progress = get_progress(o);
 
 	if (o->update)
-		git_attr_set_direction(GIT_ATTR_CHECKOUT, index);
+		git_attr_set_direction(GIT_ATTR_CHECKOUT);
 
 	if (should_update_submodules() && o->update && !o->dry_run)
 		load_gitmodules_file(index, NULL);
@@ -421,7 +421,7 @@ static int check_updates(struct unpack_trees_options *o)
 	stop_progress(&progress);
 	errs |= finish_delayed_checkout(&state);
 	if (o->update)
-		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
+		git_attr_set_direction(GIT_ATTR_CHECKIN);
 	return errs != 0;
 }
 
-- 
2.18.0.rc0.333.g22e6ee6cdf

