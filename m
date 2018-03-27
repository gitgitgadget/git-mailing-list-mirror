Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88C091F404
	for <e@80x24.org>; Tue, 27 Mar 2018 22:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeC0W7J (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 18:59:09 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43441 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752649AbeC0W7H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 18:59:07 -0400
Received: by mail-pf0-f193.google.com with SMTP id j2so213706pff.10
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 15:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UlobyW3yRQxYzjlJzX4AOScwQK+BwsdKL7UO41syHV8=;
        b=T6hd353a4yxwq+WL5ySQauySXskv4KAOR4v115p47EnswtFAc30tmh3urjLOOlpHl0
         62zqIMhj5v8ASMziw4VoXEgnL4SPUSoqaulL1d4vH6oCAXJFvj0k5boikksXf6u6DaRI
         F/ArvcHZXR+VvvryZTcqu7CMbNE3a7F+c2WaiSZ97G1eEp2ZGeCDW48WE8X5VIibPRAe
         2gE9Nb3/5EhdyxDKxQjcFwwEAukIq5/AN2eFRlnpRV1FNoLLIM8Q2IsE8wgTguAaZffb
         oqcjCZEJvXTj1m4v3D7uCRDGH85zWDgaevd6J2SN5R5xMPe6QA3CFekLgUQ1rXHTitpE
         uJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UlobyW3yRQxYzjlJzX4AOScwQK+BwsdKL7UO41syHV8=;
        b=MBgRDCBofkwoRe+GkrWztuAXBOd+zz+02WYlC3vdDl4RgGmj6/Wi4KdQ7TnKVXLSYb
         Em+5hIio50fBoUg9GwIHshBgCk1lvbWJfIawrpmjNjGTicbgwP4tClsvR+pk8C0GbaeU
         R+cdYdetvjbhLjsxapprpJJEr6o7QAKAi7X/at30GuUUc0YfVJ8CdkOeCDCyfJ+Y1gV6
         E4qFJd7AwJduG+5S/6ROk3Z6ANTQlmzl/OiZaq3TU7GDzmnIDw2fRcFQ73FVFT8pA1Fi
         pNTkv6IYtAWgIjINuD8nrzDUDl9okyZQ7iBe27bqj+0A4QEFhoM+ZB2gR84hxR9UJ4tb
         NDCQ==
X-Gm-Message-State: AElRT7G7pQnqaxeCbfqslZBNsFXCMG+YXqHzGmpvjFl7JQz9MG/jl9er
        sGHNwQEPmhxLfY+WlVant3o1UA==
X-Google-Smtp-Source: AIpwx4+9liF5s1ROfigFHgjcn6TUoyr2EQt+F07LqFkWnI0FGrF9HmAdDMgiyMkjR7YGXJ6adRXF0w==
X-Received: by 10.98.76.68 with SMTP id z65mr910770pfa.181.1522191546898;
        Tue, 27 Mar 2018 15:59:06 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id a82sm4870328pfj.153.2018.03.27.15.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Mar 2018 15:59:05 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com, git@vger.kernel.org
Cc:     bmwill@google.com, hvoigt@hvoigt.net, seanwbehan@riseup.net,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] grep: remove "repo" arg from non-supporting funcs
Date:   Tue, 27 Mar 2018 15:58:50 -0700
Message-Id: <20180327225850.166523-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.16.0.rc0.35.ga4d78ce26
In-Reply-To: <20180327213918.77851-3-sbeller@google.com>
References: <20180327213918.77851-3-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of commit f9ee2fcdfa ("grep: recurse in-process using 'struct
repository'", 2017-08-02), many functions in builtin/grep.c were
converted to also take "struct repository *" arguments. Among them were
grep_object() and grep_objects().

However, at least grep_objects() was converted incompletely - it calls
gitmodules_config_oid(), which references the_repository.

But it turns out that the conversion was extraneous anyway - there has
been no user-visible effect - because grep_objects() is never invoked
except with the_repository.

Revert the changes to grep_objects() and grep_object() (which conversion
is also extraneous) to show that both these functions do not support
repositories other than the_repository.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Patch 1/5 of your series is obviously correct.

I investigated the change to grep_objects() in patch 2/5, and here is a
patch summarizing my findings. Consider including this patch before 2/5
(or before 1/5). You'll probably need to write
"submodule_free(the_repository);" instead of what you have currently,
but other than that, I don't think this affects your patch set much.
---
 builtin/grep.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 789a89133..f286f2375 100644
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
@@ -654,8 +652,8 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
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
@@ -1107,7 +1105,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		if (cached)
 			die(_("both --cached and trees are given."));
 
-		hit = grep_objects(&opt, &pathspec, the_repository, &list);
+		hit = grep_objects(&opt, &pathspec, &list);
 	}
 
 	if (num_threads)
-- 
2.16.0.rc0.35.ga4d78ce26

