Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7862DC76188
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjDDBYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjDDBXT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:23:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E31A3AB7
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h17so31124276wrt.8
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571370;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2aHIJqiq7FpLnD06QEt4GuLUgXlJyadp+cCT/FH4kY=;
        b=p9HhG6hibp3fxprTthdGg9zGYBymZFecAnWSnh6/WBSUDhsMl7fR8egYW+RG2DAN9q
         oyC+pElXoSbbglCIH4vkZo9XUxMwbgcpOATqQK4qFcoRAZpCjSdtv57zhBy1vLEEYJxh
         yrHvMphBDF5PnSdWBHXeD3w2kLZMXC8TaYGpl4RNGV/S+l5tRJKkC6mFv3VVlXmBfSp7
         oJXHTvcyZ+njIkCL5w5triAR0DgFCK7t79QI6gzJ1hbETUW5f3csup5fNG8W5VaKZbN0
         XAbqfZ/urBxOCBckK6/3T3JafiYkZJaMZFTST/pb1DH1MvztPRu+9DDQFjW3aByy9gGJ
         rhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571370;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2aHIJqiq7FpLnD06QEt4GuLUgXlJyadp+cCT/FH4kY=;
        b=SBQOIgOYzB4NZ4c3vgSSbYGzoEaBGaGDc/uKXQuUIkl9QNd3uCRNPspl12DACKSWG2
         KzA6TpREa+cDLOu1IGQZLQbYil8fHDHnR3gUQ9QzrXRjPQYStUFJsLhMO5yfMZM6VRp/
         VNmuV/Z3iutqGyPAgCOMhfrHmbvRqBR0fnfSvnA3MyByAAz2FuKeVfvsEW9w1UbMrt8Q
         ejtOo3vBz7RAgEqF75X3jeRU4DXRoI/sS1ZKED0Mnbw/2YSwGmhOdcnc+/wBiXyXqxBV
         GAcNCYrlAisjwqjFSKO5TNCTb/fTj1tP/2+06fFdlHyrqDK0I6MLlUEyPC0/OilsrQ9J
         SijA==
X-Gm-Message-State: AAQBX9fjBxpfCrYeHGStGjMO3L2h8FLJEl4zmOYSSlmEuVsi6m3vx3H4
        f1NPe1GwcgpvgUwnYMNIXFVLuzLAoCc=
X-Google-Smtp-Source: AKy350alzXHQVE+E1VdTliFIssqPoyUuMi+L909h7WyIa/MMIdYLcLC4wksmMI1336/DZ0tzsgHh4A==
X-Received: by 2002:adf:ecc9:0:b0:2ce:a8f0:5e1f with SMTP id s9-20020adfecc9000000b002cea8f05e1fmr247508wro.71.1680571370299;
        Mon, 03 Apr 2023 18:22:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c1-20020adfef41000000b002d322b9a7f5sm10953369wrp.88.2023.04.03.18.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:50 -0700 (PDT)
Message-Id: <30e37a37c1263cc7bc38469e828765d4bd0faa8c.1680571352.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:28 +0000
Subject: [PATCH v2 24/24] mailmap, quote: move declarations of global vars to
 correct unit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Since earlier commits removed the inclusion of cache.h from mailmap.c
and quote.c, it feels odd to have the extern declarations of
global variables in cache.h rather than the actual header included
by the source file.  Move these global variable extern declarations
from cache.h to mailmap.c and quote.c.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h   | 5 -----
 config.c  | 1 +
 mailmap.h | 3 +++
 quote.h   | 2 ++
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 16b5fc9fa31..2f21704da9e 100644
--- a/cache.h
+++ b/cache.h
@@ -599,8 +599,6 @@ void set_alternate_index_output(const char *);
 extern int verify_index_checksum;
 extern int verify_ce_order;
 
-extern int quote_path_fully;
-
 #define MTIME_CHANGED	0x0001
 #define CTIME_CHANGED	0x0002
 #define OWNER_CHANGED	0x0004
@@ -655,9 +653,6 @@ struct pack_entry {
 /* Dumb servers support */
 int update_server_info(int);
 
-extern const char *git_mailmap_file;
-extern const char *git_mailmap_blob;
-
 #define COPY_READ_ERROR (-2)
 #define COPY_WRITE_ERROR (-3)
 int copy_fd(int ifd, int ofd);
diff --git a/config.c b/config.c
index 11e3295419b..9beba19b41c 100644
--- a/config.c
+++ b/config.c
@@ -18,6 +18,7 @@
 #include "ident.h"
 #include "repository.h"
 #include "lockfile.h"
+#include "mailmap.h"
 #include "exec-cmd.h"
 #include "strbuf.h"
 #include "quote.h"
diff --git a/mailmap.h b/mailmap.h
index 7e99fccb46c..0f8fd2c586f 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -3,6 +3,9 @@
 
 struct string_list;
 
+extern const char *git_mailmap_file;
+extern const char *git_mailmap_blob;
+
 int read_mailmap(struct string_list *map);
 void clear_mailmap(struct string_list *map);
 
diff --git a/quote.h b/quote.h
index 87ff458b06d..0300c291041 100644
--- a/quote.h
+++ b/quote.h
@@ -3,6 +3,8 @@
 
 struct strbuf;
 
+extern int quote_path_fully;
+
 /* Help to copy the thing properly quoted for the shell safety.
  * any single quote is replaced with '\'', any exclamation point
  * is replaced with '\!', and the whole thing is enclosed in a
-- 
gitgitgadget
