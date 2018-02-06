Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05CD31F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeBFAT1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:19:27 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38717 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbeBFATZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:19:25 -0500
Received: by mail-pg0-f66.google.com with SMTP id l18so161565pgc.5
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aq5f9Epm2v2KCaU73X6PULI/DRkF6Dcl3qVTsF2boNM=;
        b=tiChxBiEgVn9EMjmrIDr3xqviqpnu8L4EV3fYfYZ6zEp7eljMI8y4Yyn49L2xN1ouM
         shhVj/KqB/XaI/6A428cYJD4MVz+7nh0XBdy5nMU9mrPfs8iBK5N5mBiMMlfwjpXdOos
         LnwPWJdZJHE0WX73+oKZeG9vmKrynfv9XndnElmnFxkRDUd0vj24qzPridsFaJMLP+hz
         DAPDgnqF7ORCWNb+nbSoJRogOBcVMZNlUxnP5dMuCUg8C5sb+gRDV+Q/ySFOjJtaTD14
         4r3sgoxudVtjk6mmRPnpQEYG6bogXhoy5xmy6XnNb9BftMjuZztmhMS543xWz5EfYMjQ
         /8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aq5f9Epm2v2KCaU73X6PULI/DRkF6Dcl3qVTsF2boNM=;
        b=B6B4gx8vHI+y2oiIGKGvACfQDe7ZsSKxnRwekLzqPL8IZeOYOiajzpg8gBO2tr0/Kr
         l6oEviP0MjBv1hAwqvJxCrD01UrVA4eQSPyOmdzGqrp/qa9+zs2PEwN/ZZ+bil7Pm+tr
         xVT/fO1NexUZieq/a1stOtyEnhmklyfRvzIj6HRTXTHudu2rWOYz1xi17BFOjHLddyaC
         Kw0xBRIJuIQwAj+J0agDi3MtAZ3UzuFtGknEYG2E3+I3qjgZWPqxxk1KWRJjvNc9p2QE
         08cfxCSe6pPEwTGll4V4v3JL4p6zr4cygWMcoabrVUxDHdhnrtsRXeNGJ6ZJ6HvZe8L+
         /BaQ==
X-Gm-Message-State: APf1xPCi19Wmlr0G6X5N6b1hIu0NII6BL6R0Z3Ae8Eg+p2wSE//8tEDy
        MBrHLYF0AuS3DMx+LtYoIYj95Tzdibc=
X-Google-Smtp-Source: AH8x226vkvaVjvqUBLlry6Y2pmC7vwsUKXC0vkr5WQ0I6xj4Btpf9pndJr8XoX+IpjyQB9/Pq62k3Q==
X-Received: by 10.99.119.195 with SMTP id s186mr425777pgc.203.1517876364466;
        Mon, 05 Feb 2018 16:19:24 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id l10sm10187440pfc.133.2018.02.05.16.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:19:23 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 108/194] alternates: add repository argument to add_to_alternates_memory
Date:   Mon,  5 Feb 2018 16:16:23 -0800
Message-Id: <20180206001749.218943-10-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow callers of add_to_alternates_memory
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 alternates.h              | 3 ++-
 builtin/grep.c            | 2 +-
 sha1_file.c               | 2 +-
 submodule.c               | 2 +-
 t/helper/test-ref-store.c | 2 +-
 tmp-objdir.c              | 2 +-
 6 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/alternates.h b/alternates.h
index 2d06b71e50..e4520ae5c7 100644
--- a/alternates.h
+++ b/alternates.h
@@ -56,7 +56,8 @@ extern void add_to_alternates_file_the_repository(const char *dir);
  * recursive alternates it points to), but do not modify the on-disk alternates
  * file.
  */
-extern void add_to_alternates_memory(const char *dir);
+#define add_to_alternates_memory(r, d) add_to_alternates_memory_##r(d)
+extern void add_to_alternates_memory_the_repository(const char *dir);
 
 /*
  * Returns a scratch strbuf pre-filled with the alternate object directory,
diff --git a/builtin/grep.c b/builtin/grep.c
index a9a908d92a..a83e87a676 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -433,7 +433,7 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 	 * object.
 	 */
 	grep_read_lock();
-	add_to_alternates_memory(submodule.objectdir);
+	add_to_alternates_memory(the_repository, submodule.objectdir);
 	grep_read_unlock();
 
 	if (oid) {
diff --git a/sha1_file.c b/sha1_file.c
index 066aa187a1..aa564e3ad4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -581,7 +581,7 @@ void add_to_alternates_file_the_repository(const char *reference)
 	free(alts);
 }
 
-void add_to_alternates_memory(const char *reference)
+void add_to_alternates_memory_the_repository(const char *reference)
 {
 	/*
 	 * Make sure alternates are initialized, or else our entry may be
diff --git a/submodule.c b/submodule.c
index 9c4c01ba73..f9426beff1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -165,7 +165,7 @@ static int add_submodule_odb(const char *path)
 		ret = -1;
 		goto done;
 	}
-	add_to_alternates_memory(objects_directory.buf);
+	add_to_alternates_memory(the_repository, objects_directory.buf);
 done:
 	strbuf_release(&objects_directory);
 	return ret;
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 93ea6f781e..8442ee8146 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -31,7 +31,7 @@ static const char **get_store(const char **argv, struct ref_store **refs)
 		ret = strbuf_git_path_submodule(&sb, gitdir, "objects/");
 		if (ret)
 			die("strbuf_git_path_submodule failed: %d", ret);
-		add_to_alternates_memory(sb.buf);
+		add_to_alternates_memory(the_repository, sb.buf);
 		strbuf_release(&sb);
 
 		*refs = get_submodule_ref_store(gitdir);
diff --git a/tmp-objdir.c b/tmp-objdir.c
index bf34315adf..a9334d3fc5 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -288,5 +288,5 @@ const char **tmp_objdir_env(const struct tmp_objdir *t)
 
 void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
 {
-	add_to_alternates_memory(t->path.buf);
+	add_to_alternates_memory(the_repository, t->path.buf);
 }
-- 
2.15.1.433.g936d1b9894.dirty

