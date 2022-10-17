Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D60C43219
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 02:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiJQCXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 22:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiJQCXb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 22:23:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DDA4456A
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:23:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so11738457wma.3
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0UkilmK87anbGZ29VLzarKINo9qRuRnMdxXyeK1GGM=;
        b=BJ9YVMg+DEDBSu3QG9sWlfJuGzSKJisM883M57HjIlVn9fUJQLorNhHXkCzFjGP3wN
         9Li9lpSQr1ZxGJAd7ykNE0yrz295+mGYNboblQNRQ9QP2Lnc8aghOF/zy4sCHITTcUcK
         tL0lhLdVLVgzZcKzkpV26p4NCekxANrppg8zoGJ4EtWzPYp7Ry9scpdVvjCOBPhDn0uv
         n34a1i4w7C3vZb/yh6XzB2bLQgYY09MzfibZkVJV3sVOBxKr2MZi6CSTHcaxOtaaaGWx
         58wjAXoEZhAjnfm8fyQ2yjUnac5SGcftXfZWe0E3AQW1V64UXWWT/egOO1+GMMscruXN
         cM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0UkilmK87anbGZ29VLzarKINo9qRuRnMdxXyeK1GGM=;
        b=fyk0XQVzGeXEzI3RHWH0kwqT3V4y+6cpxvtZsRnklUwVG6YUbcmL6b/t8H56+b/txo
         PwC/oCMzc5ILyx9vpUg4kTU3hlYrgx+G4j8fXri6ez8qSO1AnOKGQfr1fPEGwEBOlD3A
         +Nnb9vWfEHElSUqOCggqDt148MKqWXo62nbykOX/3ZKgfG0F+aB3z3qAzgpfkGxWLFoR
         MYwvnGvYdlX8K6FavFCHs3rSIijWGhfTbtf2ZnAvH1EkYiblatO1wyCO6Bq00DA3nrBx
         QUQKftA9YJLmcJpE1QsmLFJ0FY4lWVcbWJP1+zWGvDcn/KNYpDQ01DFu1/b77nJcTHZo
         Sf3w==
X-Gm-Message-State: ACrzQf0uhgxkb9jmJgF4/aptCjqVZoZeaqPilAvb0+DvNHVQAbhLmaT0
        1CI1g6v/1lhTPNdpTCoDKSl3Y6eWHtU=
X-Google-Smtp-Source: AMsMyM4aKwhWT8TrMBRgRgGSEkiVEbAS44+3687FD3ckaztVxg8V5DZNmOscwxW3ahSDSshDS2RXYw==
X-Received: by 2002:a05:600c:2754:b0:3c6:aba7:5c93 with SMTP id 20-20020a05600c275400b003c6aba75c93mr5455659wmw.177.1665973406779;
        Sun, 16 Oct 2022 19:23:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r3-20020a05600c158300b003c21ba7d7d6sm8420313wmf.44.2022.10.16.19.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 19:23:26 -0700 (PDT)
Message-Id: <d3d1738e670d5dbf1378fc5c3209b2e98234a771.1665973401.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
        <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
From:   "Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 02:23:16 +0000
Subject: [PATCH v3 4/9] tree: handle submodule case for read_tree_at properly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heather Lapointe <alpha@alphaservcomputing.solutions>

This supports traversal into an actual submodule for read_tree_at.
The logic is blocked on pathspec->recurse_submodules now,
but previously hadn't been executed due to all fn() cases
returning early for submodules.

Signed-off-by: Heather Lapointe <alpha@alphaservcomputing.solutions>
---
 tree.c | 88 ++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 27 deletions(-)

diff --git a/tree.c b/tree.c
index 13f9173d45e..2a087c010f9 100644
--- a/tree.c
+++ b/tree.c
@@ -8,6 +8,7 @@
 #include "alloc.h"
 #include "tree-walk.h"
 #include "repository.h"
+#include "pathspec.h"
 
 const char *tree_type = "tree";
 
@@ -47,40 +48,73 @@ int read_tree_at(struct repository *r,
 			return -1;
 		}
 
-		if (S_ISDIR(entry.mode))
+		if (S_ISDIR(entry.mode)) {
 			oidcpy(&oid, &entry.oid);
-		else if (S_ISGITLINK(entry.mode)) {
-			struct commit *commit;
 
-			commit = lookup_commit(r, &entry.oid);
+			len = tree_entry_len(&entry);
+			strbuf_add(base, entry.path, len);
+			strbuf_addch(base, '/');
+			retval = read_tree_at(r, lookup_tree(r, &oid),
+						base, pathspec,
+						fn, context);
+			strbuf_setlen(base, oldlen);
+			if (retval)
+				return -1;
+		} else if (pathspec->recurse_submodules && S_ISGITLINK(entry.mode)) {
+			struct commit *commit;
+			struct repository subrepo;
+			struct repository* subrepo_p = &subrepo;
+			struct tree* submodule_tree;
+			char *submodule_rel_path;
+			int name_base_len = 0;
+
+			len = tree_entry_len(&entry);
+			strbuf_add(base, entry.path, len);
+			submodule_rel_path = base->buf;
+			// repo_submodule_init expects a path relative to submodule_prefix
+			if (r->submodule_prefix) {
+				name_base_len = strlen(r->submodule_prefix);
+				// we should always expect to start with submodule_prefix
+				assert(!strncmp(submodule_rel_path, r->submodule_prefix, name_base_len));
+				// strip the prefix
+				submodule_rel_path += name_base_len;
+				// if submodule_prefix doesn't end with a /, we want to get rid of that too
+				if (is_dir_sep(submodule_rel_path[0])) {
+					submodule_rel_path++;
+				}
+			}
+
+			if (repo_submodule_init(subrepo_p, r, submodule_rel_path, null_oid()))
+				die("couldn't init submodule %s", base->buf);
+
+			if (repo_read_index(subrepo_p) < 0)
+				die("index file corrupt");
+
+			commit = lookup_commit(subrepo_p, &entry.oid);
 			if (!commit)
-				die("Commit %s in submodule path %s%s not found",
+				die("Commit %s in submodule path %s not found",
 				    oid_to_hex(&entry.oid),
-				    base->buf, entry.path);
-
-			// FIXME: This is the wrong repo instance (it refers to the superproject)
-			// it will always fail as is (will fix in later patch)
-			// This current codepath isn't executed by any existing callbacks
-			// so it wouldn't show up as an issue at this time.
-			if (repo_parse_commit(r, commit))
-				die("Invalid commit %s in submodule path %s%s",
+				    base->buf);
+
+			if (repo_parse_commit(subrepo_p, commit))
+				die("Invalid commit %s in submodule path %s",
 				    oid_to_hex(&entry.oid),
-				    base->buf, entry.path);
+				    base->buf);
 
-			oidcpy(&oid, get_commit_tree_oid(commit));
-		}
-		else
-			continue;
+			submodule_tree = repo_get_commit_tree(subrepo_p, commit);
+			oidcpy(&oid, submodule_tree ? &submodule_tree->object.oid : NULL);
 
-		len = tree_entry_len(&entry);
-		strbuf_add(base, entry.path, len);
-		strbuf_addch(base, '/');
-		retval = read_tree_at(r, lookup_tree(r, &oid),
-				      base, pathspec,
-				      fn, context);
-		strbuf_setlen(base, oldlen);
-		if (retval)
-			return -1;
+			strbuf_addch(base, '/');
+
+			retval = read_tree_at(subrepo_p, lookup_tree(subrepo_p, &oid),
+						base, pathspec,
+						fn, context);
+			if (retval)
+			    die("failed to read tree for %s", base->buf);
+			strbuf_setlen(base, oldlen);
+			repo_clear(subrepo_p);
+		}
+		// else, this is a file (or a submodule, but no pathspec->recurse_submodules)
 	}
 	return 0;
 }
-- 
gitgitgadget

