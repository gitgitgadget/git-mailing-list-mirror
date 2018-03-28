Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC5FA1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 22:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753613AbeC1Wfl (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 18:35:41 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43070 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753429AbeC1Wfi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 18:35:38 -0400
Received: by mail-pg0-f68.google.com with SMTP id i124so1736669pgc.10
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 15:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WmuI+OT7C/daBq7ohiOJ9wmggA3j70lhLouMqH4cp+M=;
        b=RW/9TkUOovZpe1avj8GCt5VqG/0g5zXyU6j/lTXX9JPAswZ9HnemjNUlKOkqOXpsrX
         hLxaRPkrkS+6Ijyd+xQ68rImJ0Uo3qlwQfCd5/ZbtOsHb+yYcpDsArT3vAh6DFoxhw0k
         pdqjz9I+PcPlaTcplhrqiGVD3YMrZzGg0HhWskcmhWPuaEPd0LD05/jP2z4V6vd/htrx
         s/ZR2H0XJr14Hg4ITmiuUaj2Hmmu1fW08nChQt7jBA471nUy2LRIBeBtdMERAfyERcVo
         N216eQTOUGInIWDLTcnuWU9dQKY2kMvVN1/vfgMIvBQCZ+tFOXIrDg4Rma871FFNt1Kj
         RU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WmuI+OT7C/daBq7ohiOJ9wmggA3j70lhLouMqH4cp+M=;
        b=ImGtNQe19eFMD+Vjn0VHgb07cJ6V+vARRo7mWYO08J+UpL1okzg7n1BfaDbwc042el
         XA7JHBI7Y9PIwQV5BZ13mpiwo6pECdLuXcUHXW3VFoYsmBvKjRUXXTylYpahCESZ1rAc
         XVpxCnrTuEgILcOCsM8vOO5HBnwWZrZxFC5bdQgKbk7asotXhr1DA+qRXNDIo+tDMh1F
         DW/F+lWjwBiVrzkql286PjmZaek5NNroDgnUQ8oYGMdnw75dm+9co8Y/fVtVzjGP9gUf
         Ng+CG2kDjk6l0mZiHGvK6CkGmIS/qgJFUv019TkyS8xaLmN+XbAtp457Z18lrXG+bf3g
         GuvA==
X-Gm-Message-State: AElRT7F854sdMmF4ted2uLN5cf0HX/8ON3HOuD918s+XUFkONa9pp2T5
        Ss0PqErX3auXZFNuzcj4rQrNqQT/1Yk=
X-Google-Smtp-Source: AIpwx4+ZjGrHFAI7hZNqcoDpO7mxLSn8U82T9oCbSHcpuiVefF/uOYe+M7i3OCSkzuqE6YF0UXCLhg==
X-Received: by 10.98.174.6 with SMTP id q6mr4348946pff.140.1522276537643;
        Wed, 28 Mar 2018 15:35:37 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id q2sm7760997pgp.70.2018.03.28.15.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 15:35:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        hvoigt@hvoigt.net, sbeller@google.com, seanwbehan@riseup.net
Subject: [PATCHv3 2/6] grep: remove "repo" arg from non-supporting funcs
Date:   Wed, 28 Mar 2018 15:35:27 -0700
Message-Id: <20180328223531.241920-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <20180328223531.241920-1-sbeller@google.com>
References: <20180328105416.3add54858bac92573d7d1130@google.com>
 <20180328223531.241920-1-sbeller@google.com>
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
 builtin/grep.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 1e9cdbdf78..754eb6da3b 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -595,8 +595,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 }
 
 static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
-		       struct object *obj, const char *name, const char *path,
-		       struct repository *repo)
+		       struct object *obj, const char *name, const char *path)
 {
 	if (obj->type == OBJ_BLOB)
 		return grep_oid(opt, &obj->oid, name, 0, path);
@@ -623,7 +622,7 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		}
 		init_tree_desc(&tree, data, size);
 		hit = grep_tree(opt, pathspec, &tree, &base, base.len,
-				obj->type == OBJ_COMMIT, repo);
+				obj->type == OBJ_COMMIT, the_repository);
 		strbuf_release(&base);
 		free(data);
 		return hit;
@@ -632,7 +631,6 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 }
 
 static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
-			struct repository *repo,
 			const struct object_array *list)
 {
 	unsigned int i;
@@ -648,8 +646,8 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 			submodule_free();
 			gitmodules_config_oid(&real_obj->oid);
 		}
-		if (grep_object(opt, pathspec, real_obj, list->objects[i].name, list->objects[i].path,
-				repo)) {
+		if (grep_object(opt, pathspec, real_obj, list->objects[i].name,
+				list->objects[i].path)) {
 			hit = 1;
 			if (opt->status_only)
 				break;
@@ -1098,7 +1096,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		if (cached)
 			die(_("both --cached and trees are given."));
 
-		hit = grep_objects(&opt, &pathspec, the_repository, &list);
+		hit = grep_objects(&opt, &pathspec, &list);
 	}
 
 	if (num_threads)
-- 
2.17.0.rc1.321.gba9d0f2565-goog

