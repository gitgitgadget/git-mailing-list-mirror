Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CED301F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeC1RZN (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:25:13 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45852 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752594AbeC1RZD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:25:03 -0400
Received: by mail-pg0-f66.google.com with SMTP id y63so1184889pgy.12
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+cKoYGgApQoqA87wVk5tx+s6nPntTiOHXoODrNNEhRU=;
        b=bYhyZ/C8W5v+Wg3dyyCRya8DMhgCLZNHO55yEYMHlkpaCPEYJmuIFJ6V5O/4MPg0um
         y1YlkFDQGpraKE5YkyRyzhr1XK5hXiv6Nh83ZqSoyGxKGRDUoX+ptSO/yBgRSc9lUIYu
         K7/Ae+YychGL+oYRwMVq8zLKelK057QXmJY7qzqa+45h4KdUNU7ZjrhIqJhCFeQiIT+M
         QbbiYPu59oa5WWNLV3cYiA8RnYnf6N9M2QLyZGLuTETLHxzWuqw8ENI+nruLQz/GFUMS
         kROqlQ8W0jSp2vTT0fUe+5DxKJ88iaLvTz/xop65wms8P7xy0CwNYL+dkuSInRCrwLC+
         y3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+cKoYGgApQoqA87wVk5tx+s6nPntTiOHXoODrNNEhRU=;
        b=kldp33WLalatSmC3ehg5j14UC4BNxE+tatk2RHUeG2Nf1gU2Q9GY7OhhGRyvassQDb
         rlIwMzpEbK7Pa6cgnelanQKg6S+XyuU/4piOuoOdyKphxdCl8eYPNykOAfv6C7lTbf7g
         4gXb+Y3rSTIF+v+YqhZgZfOX4qoaX0odRBVK/KdtZlNZfE3pVwKAKazgQmzWU3rjtfgf
         /a73akgm4qHjftKOSybX2Cm+A4Axw0nFZryAAdmWgraEe/xJknC3916IXgfB2bxrSutG
         y6KAtp3Fyb4mh+2AitytLVImsygfy6hWb541tz7cWcYK9ZDI4jiWj1iLxgr9TNROOVz/
         fQuQ==
X-Gm-Message-State: AElRT7HUdFzpV2psnOwsMx8zatJTWQscE2vMFPtm5knt+WRBTNKmtzs0
        cPg1nKs8jLb6VBb/eIHk5kYMcg==
X-Google-Smtp-Source: AIpwx49Wwt3my2IDmOwLTNLsRHMZ2cmAtrUI895ixmilWsmkwO5tFUdCbolUzkvs+bbqfjQ3q5cK5A==
X-Received: by 2002:a17:902:d20d:: with SMTP id t13-v6mr4596595ply.154.1522257902768;
        Wed, 28 Mar 2018 10:25:02 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id t28sm9928404pfk.138.2018.03.28.10.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 10:25:01 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     bmwill@google.com, git@vger.kernel.org, hvoigt@hvoigt.net,
        jonathantanmy@google.com, seanwbehan@riseup.net
Subject: [PATCH 6/6] grep: remove "repo" arg from non-supporting funcs
Date:   Wed, 28 Mar 2018 10:24:49 -0700
Message-Id: <20180328172449.27012-7-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <20180328172449.27012-1-sbeller@google.com>
References: <CAGZ79kaQYjepND8EdgB73meBsShOc5aBporiK2Bo40fqcar0gg@mail.gmail.com>
 <20180328172449.27012-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

As part of commit f9ee2fcdfa ("grep: recurse in-process using 'struct
repository'", 2017-08-02), many functions in builtin/grep.c were
converted to also take "struct repository *" arguments. Among them were
grep_object() and grep_objects().

However, at least grep_objects() was converted incompletely - it calls
gitmodules_config_oid(), which references the_repository.

But it turns out that the conversion was extraneous anyway - there has
been no user-visible effect - because grep_objects() is never invoked
except with the_repository. This is because grepping through objects
cannot be done recursively into submodules.

Revert the changes to grep_objects() and grep_object() (which conversion
is also extraneous) to show that both these functions do not support
repositories other than the_repository.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/grep.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 8f04cde18e..091b3f4cc7 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -601,8 +601,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 }
 
 static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
-		       struct object *obj, const char *name, const char *path,
-		       struct repository *repo)
+		       struct object *obj, const char *name, const char *path)
 {
 	if (obj->type == OBJ_BLOB)
 		return grep_oid(opt, &obj->oid, name, 0, path);
@@ -629,7 +628,7 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		}
 		init_tree_desc(&tree, data, size);
 		hit = grep_tree(opt, pathspec, &tree, &base, base.len,
-				obj->type == OBJ_COMMIT, repo);
+				obj->type == OBJ_COMMIT, the_repository);
 		strbuf_release(&base);
 		free(data);
 		return hit;
@@ -638,7 +637,6 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 }
 
 static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
-			struct repository *repo,
 			const struct object_array *list)
 {
 	unsigned int i;
@@ -651,11 +649,11 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 
 		/* load the gitmodules file for this rev */
 		if (recurse_submodules) {
-			submodule_free(repo);
+			submodule_free(the_repository);
 			gitmodules_config_oid(&real_obj->oid);
 		}
-		if (grep_object(opt, pathspec, real_obj, list->objects[i].name, list->objects[i].path,
-				repo)) {
+		if (grep_object(opt, pathspec, real_obj, list->objects[i].name,
+				list->objects[i].path)) {
 			hit = 1;
 			if (opt->status_only)
 				break;
@@ -1107,7 +1105,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		if (cached)
 			die(_("both --cached and trees are given."));
 
-		hit = grep_objects(&opt, &pathspec, the_repository, &list);
+		hit = grep_objects(&opt, &pathspec, &list);
 	}
 
 	if (num_threads)
-- 
2.17.0.rc1.321.gba9d0f2565-goog

