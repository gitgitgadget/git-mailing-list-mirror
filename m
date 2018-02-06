Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 735191F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeBFATE (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:19:04 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41519 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752074AbeBFAS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:18:59 -0500
Received: by mail-pg0-f66.google.com with SMTP id 141so153637pgd.8
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RwGuxHZxsXlKrjQQ/Dp+o7xQnbtpWWlJwEq3/U66zLM=;
        b=X/M4AX72PtaQGr726HNVtOBGzgUubVovqymbng4jSZAuswmAP1Msg/PF1/GmnPtZrY
         IocNjqGnptlp7grOXeEkCSS+6KDemwbLQDFzeehLZgNvUCXSv6vjuutIIzoRBYI69YyS
         x5YqVJTHjl1JBz9NQx6Cw1WysOd4e/UL0zBJ0pIYkHgPGHosdFzoBGJjxQ4ChVHCg6D6
         BTb24poOxUyHs2NbsmJ599rFUYxEEuvIU3nGyQrWg/dchJemSlNsK9IhXmUSXEjj0ZYE
         7i/xgEtdNjSsY89VP3vjdQL/kyhvnwJHWto0jbu/ryxa1JL3kW2VZQPFFyFDBT/cMZPU
         VIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RwGuxHZxsXlKrjQQ/Dp+o7xQnbtpWWlJwEq3/U66zLM=;
        b=axogVTAkedo1ozZ4Xs2YhY509GKVS8QmjpdPSGVGKxvBIniKbzqiy4djEB2HYOqMqE
         TyW2soDZlKGvFbKTlRecgiVYoDpOJkyQLIdEqruxISsLn6M4XqZNLDXQ/z3FYVhlPo9o
         lSTRmi91rN2AFCu1zQO8oOe7f8MANf6MoyeP21AXfRBuG1WC15FUXtD7bP5d0B564LW1
         s5vj7p/dww/G5ssg6SJmRdGe6l/W2lAuWT8VkMXkP4LrU0pePUy9YyPBFM9iY3y1QPAt
         BAFxfwyZg263dFnnad76R1Aoj+YzR6MQorumpRfHlfu09VjlB+faiPnknFPXGZbYZM5+
         jvrA==
X-Gm-Message-State: APf1xPAtfUHci0sSTnWalGw9g1F+7j1ZtqyMfaxc4xxLE0YwjWKjjitF
        F19HajAB6nKcRFZLwMoYsYTrd2Bwux4=
X-Google-Smtp-Source: AH8x224lPXmPPGyXaORh7SWrMR9YSVw+WzzWl6foxqj4/+ryNxYXqpgUtx00xE5wkGdlcR57qlJPSA==
X-Received: by 10.99.116.92 with SMTP id e28mr424660pgn.227.1517876337993;
        Mon, 05 Feb 2018 16:18:57 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id s90sm19328968pfi.139.2018.02.05.16.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:18:57 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 107/194] alternates: add repository argument to add_to_alternates_file
Date:   Mon,  5 Feb 2018 16:16:22 -0800
Message-Id: <20180206001749.218943-9-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of add_to_alternates_file
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 alternates.h    | 3 ++-
 builtin/clone.c | 9 +++++----
 sha1_file.c     | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/alternates.h b/alternates.h
index df5dc67e2e..2d06b71e50 100644
--- a/alternates.h
+++ b/alternates.h
@@ -48,7 +48,8 @@ struct alternate_object_database *alloc_alt_odb(const char *dir);
  * Add the directory to the on-disk alternates file; the new entry will also
  * take effect in the current process.
  */
-extern void add_to_alternates_file(const char *dir);
+#define add_to_alternates_file(r, d) add_to_alternates_file_##r(d)
+extern void add_to_alternates_file_the_repository(const char *dir);
 
 /*
  * Add the directory to the in-memory list of alternates (along with any
diff --git a/builtin/clone.c b/builtin/clone.c
index 6efe189846..548255f955 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -11,6 +11,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "lockfile.h"
+#include "repository.h"
 #include "alternates.h"
 #include "parse-options.h"
 #include "fetch-pack.h"
@@ -330,7 +331,7 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 	} else {
 		struct strbuf sb = STRBUF_INIT;
 		strbuf_addf(&sb, "%s/objects", ref_git);
-		add_to_alternates_file(sb.buf);
+		add_to_alternates_file(the_repository, sb.buf);
 		strbuf_release(&sb);
 	}
 
@@ -372,12 +373,12 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
 		if (!line.len || line.buf[0] == '#')
 			continue;
 		if (is_absolute_path(line.buf)) {
-			add_to_alternates_file(line.buf);
+			add_to_alternates_file(the_repository, line.buf);
 			continue;
 		}
 		abs_path = mkpathdup("%s/objects/%s", src_repo, line.buf);
 		if (!normalize_path_copy(abs_path, abs_path))
-			add_to_alternates_file(abs_path);
+			add_to_alternates_file(the_repository, abs_path);
 		else
 			warning("skipping invalid relative alternate: %s/%s",
 				src_repo, line.buf);
@@ -456,7 +457,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
 		struct strbuf alt = STRBUF_INIT;
 		get_common_dir(&alt, src_repo);
 		strbuf_addstr(&alt, "/objects");
-		add_to_alternates_file(alt.buf);
+		add_to_alternates_file(the_repository, alt.buf);
 		strbuf_release(&alt);
 	} else {
 		struct strbuf src = STRBUF_INIT;
diff --git a/sha1_file.c b/sha1_file.c
index 0c2e215ae5..066aa187a1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -538,7 +538,7 @@ struct alternate_object_database *alloc_alt_odb(const char *dir)
 	return ent;
 }
 
-void add_to_alternates_file(const char *reference)
+void add_to_alternates_file_the_repository(const char *reference)
 {
 	struct lock_file lock = LOCK_INIT;
 	char *alts = git_pathdup("objects/info/alternates");
-- 
2.15.1.433.g936d1b9894.dirty

