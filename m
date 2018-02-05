Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48D281F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752181AbeBEX4W (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:56:22 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39030 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbeBEXzz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:55:55 -0500
Received: by mail-pl0-f67.google.com with SMTP id o13so84361pli.6
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e5yo+eNYOcjp7SNidNdFub3W2NrSxImqt1e758dJ+Vg=;
        b=FxW/vyeRvxAIGp/FAhX8sssqR/dFZs0aNPauzv0ye4sNWbT6HJ74l5cuYwmZ0n0q+7
         7codJV9ergv9VNldXGwJHmX4TFbHASxtyCdUueFlfl/1EybdrbTI7Z6ylkwcbl98o0CQ
         67UdVXA5kmt7M8B7HgmopVS76DXTRwEppb0b7Kj2rp45qpCjpNheNVAHAaWV8SJniMwE
         k3eriQ4313tyNBvnJh2EebYzqk4bJtkMDfdJSqBIZvzm+6dbwEkUz0Wp/wpEVSuYR4dn
         qHzrnrVCND61hiCHqnRxZIiu3QG6OLsXLCJf1cgPMWZub8cc3Ud++twzHFq7HzzeX2fh
         XQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e5yo+eNYOcjp7SNidNdFub3W2NrSxImqt1e758dJ+Vg=;
        b=UWlQXV/PrdfyAsVp9CVIG13L8SlSjccp8EWYZQtV9w2zUW1l697B6z6L/zP5KvlyK/
         FEO3iJ1PhiSMEmFkliRrzcPUbhmPe2ZmctOTBnJ75POowmEbrzrRLGWLfr9CyxjJ4JZC
         E1cB4BbdzbXbJ1ycZUpcYnR6X6rhevT8cOTB108E8ATeGnzTRc3i5nifxRBE7hEla5N3
         113f/L0+HylNu3EvIyLTPNxqK+Ctr52bn8lsHrZpvq8U/ITCS06OSYP+ITBi4gc3paWI
         NZ0lg7K41wItNJiUHusS986bgyhnUUVhugGlXg/vY29HDeYfuFk5O8HtbUN4/+tZ8MFQ
         J3GA==
X-Gm-Message-State: APf1xPCG3BBIU+Q5jp7VPW0zERt2IvXvwUBVj+8RvtVzpE0PQFpm17uT
        AUUO4KVfm3vaPF8YhSY609pArDi9nfQ=
X-Google-Smtp-Source: AH8x226fFtY7VDxlR6yAkRH8OIaxMhZ56YAngtbWtR8njDlcbDxiT0WfmBQ1ZUFD0qhqqd8W56az4Q==
X-Received: by 2002:a17:902:8496:: with SMTP id c22-v6mr515071plo.36.1517874954577;
        Mon, 05 Feb 2018 15:55:54 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id p64sm14871478pga.55.2018.02.05.15.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:55:53 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 016/194] pack: add repository argument to install_packed_git
Date:   Mon,  5 Feb 2018 15:52:10 -0800
Message-Id: <20180205235508.216277-17-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow install_packed_git callers to be
more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fast-import.c | 2 +-
 http.c        | 3 ++-
 packfile.c    | 4 ++--
 packfile.h    | 3 ++-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 1685fe59a2..67550584da 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1038,7 +1038,7 @@ static void end_packfile(void)
 		if (!new_p)
 			die("core git rejected index %s", idx_name);
 		all_packs[pack_id] = new_p;
-		install_packed_git(new_p);
+		install_packed_git(the_repository, new_p);
 		free(idx_name);
 
 		/* Print the boundary */
diff --git a/http.c b/http.c
index ab989b88dd..979d9b3e46 100644
--- a/http.c
+++ b/http.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "http.h"
+#include "repository.h"
 #include "config.h"
 #include "object-store.h"
 #include "pack.h"
@@ -2068,7 +2069,7 @@ int finish_http_pack_request(struct http_pack_request *preq)
 		return -1;
 	}
 
-	install_packed_git(p);
+	install_packed_git(the_repository, p);
 	free(tmp_idx);
 	return 0;
 }
diff --git a/packfile.c b/packfile.c
index fbb2385bad..0f63ec79c8 100644
--- a/packfile.c
+++ b/packfile.c
@@ -671,7 +671,7 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	return p;
 }
 
-void install_packed_git(struct packed_git *pack)
+void install_packed_git_the_repository(struct packed_git *pack)
 {
 	if (pack->pack_fd != -1)
 		pack_open_fds++;
@@ -773,7 +773,7 @@ static void prepare_packed_git_one(char *objdir, int local)
 			     * corresponding .pack file that we can map.
 			     */
 			    (p = add_packed_git(path.buf, path.len, local)) != NULL)
-				install_packed_git(p);
+				install_packed_git(the_repository, p);
 		}
 
 		if (!report_garbage)
diff --git a/packfile.h b/packfile.h
index 0cdeb54dcd..7e6959d440 100644
--- a/packfile.h
+++ b/packfile.h
@@ -34,7 +34,8 @@ extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
-extern void install_packed_git(struct packed_git *pack);
+#define install_packed_git(r, p) install_packed_git_##r(p)
+extern void install_packed_git_the_repository(struct packed_git *pack);
 
 /*
  * Give a rough count of objects in the repository. This sacrifices accuracy
-- 
2.15.1.433.g936d1b9894.dirty

