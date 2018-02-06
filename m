Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A92431F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbeBFAU0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:20:26 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39068 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbeBFAUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:20:25 -0500
Received: by mail-pg0-f67.google.com with SMTP id w17so161275pgv.6
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vHX3ygjpgwSz8paUZlUEzhO5SpR//sR+YePfZzgy8oQ=;
        b=bS5f/hpcwH46LbsoTeZQLqYn7DzmQzX1WTVAxD+Hm59Nybz9e1ZgYvROGRTUa8Mixe
         JF3Sgt7LPmN3pwkkkwDZ3+YDNQw3St9vdlqyfUgoiwN06ksgZLSTmWeD4L78kPOGVFW1
         1+lF3u8vkllFAIb31VoJ34UVAk46MuLjKap4LLmdMzp5BaPkaC6GV0/cOCF7vT4uLpaD
         QKJ0LfOv00z5sxTyhEQJv6q5+DhnhOnfLpi+wsCs41UYociuD++zui6mL6bHQZjWt9XN
         xvfFF8KIbQnHMbGl2tmEKJGlSJF39/OBXRcL5nm+4CWraK5cjSMzt2EFvKm+CjuY/URi
         2PGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vHX3ygjpgwSz8paUZlUEzhO5SpR//sR+YePfZzgy8oQ=;
        b=e2kUhe2TGMJlwFMeBn61jC866s0K2u0UD01ql9IIORQf4FJeGFh0xt3butZ3/trMP+
         EBdd8OW+1CS/6DtvKEAaaRYmXE/mv62T/eWWEP4THH7b3thWPAK6FGFQMTWuCNS+xNy9
         FM0K+O6ap2T34No+VkFEx2pgYoedm56BwEnVENlkLNb4Hgrp/aMETdhyM642cMgM45wI
         l7Oi+q8XX4SMGUdlhKQjjzCAW5HF9IVdVDnJYaKzAKgBLFKYYC2hMRbSBB6JUMcdZLgQ
         JrSE6pCRiq4/0fEL/xjOM2k4pkCCSeyWvY5Qb9qEjjQWT1mhMrMTiGhSPMtKo3RjkVj7
         x5Hg==
X-Gm-Message-State: APf1xPB2BEIuAjIi1ZY3p2NST97gzZBWXCEmSiJdNY/MqUYscIuP5P1N
        vOtxAnTkoeZ2JFPoy8uth97DqylQ8Cg=
X-Google-Smtp-Source: AH8x226/r8Tpy45xqA2BtGdsqNk55afxFOTcFjSeVdJPoV8H8E0b0Ze6fUPDxBqqvKljgd/hMCEffw==
X-Received: by 10.99.160.102 with SMTP id u38mr403571pgn.199.1517876423538;
        Mon, 05 Feb 2018 16:20:23 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id w12sm17903116pfd.86.2018.02.05.16.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:20:22 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 115/194] packfile: add repository argument to has_packed_and_bad
Date:   Mon,  5 Feb 2018 16:16:30 -0800
Message-Id: <20180206001749.218943-17-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of has_packed_and_bad
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Add the cocci patch that converted the callers.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c  | 2 +-
 packfile.h  | 4 +++-
 sha1_file.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/packfile.c b/packfile.c
index f7e8a81ded..28453739b2 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1004,7 +1004,7 @@ void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1)
 	p->num_bad_objects++;
 }
 
-const struct packed_git *has_packed_and_bad(const unsigned char *sha1)
+const struct packed_git *has_packed_and_bad_the_repository(const unsigned char *sha1)
 {
 	struct packed_git *p;
 	unsigned i;
diff --git a/packfile.h b/packfile.h
index f8d2825cce..b5122d455e 100644
--- a/packfile.h
+++ b/packfile.h
@@ -140,7 +140,9 @@ extern int packed_object_info(struct repository *r,
 			      off_t offset, struct object_info *);
 
 extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
-extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
+
+#define has_packed_and_bad(r, s) has_packed_and_bad_##r(s)
+extern const struct packed_git *has_packed_and_bad_the_repository(const unsigned char *sha1);
 
 extern int find_pack_entry(struct repository *r,
 			   const unsigned char *sha1,
diff --git a/sha1_file.c b/sha1_file.c
index ca567b64d6..e1427c0982 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1386,7 +1386,7 @@ void *read_sha1_file_extended_the_repository(const unsigned char *sha1,
 		die("loose object %s (stored in %s) is corrupt",
 		    sha1_to_hex(repl), path);
 
-	if ((p = has_packed_and_bad(repl)) != NULL)
+	if ((p = has_packed_and_bad(the_repository, repl)) != NULL)
 		die("packed object %s (stored in %s) is corrupt",
 		    sha1_to_hex(repl), p->pack_name);
 
-- 
2.15.1.433.g936d1b9894.dirty

