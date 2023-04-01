Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41534C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjDAPLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjDAPL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:11:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7753224410
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:58 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i9so25198125wrp.3
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361856;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITjUM/DPj52rkXdpLKl4kDFyKatxAMdfpgk650IJLH8=;
        b=czP6hznf8bcBlZA+myqSPyY5lIwCG5VZRQmhNdqlVWqivrlB5w+yUKfAU/bzbXr3/+
         ym/kTNxlGPILC+ST3y+RdlsaUSf3F/yQlMas7OzptlAgJeG68jL3RbNLT+gfb+BfEMQJ
         DA7b81yLYNGbSZ18Wq87SC3AX8F+EzE0AL/RTWwQdeVVzqtWjm4rNWo3PxoXVHAuk/S5
         WLqxOe/ulfi62IQ4iF44GULv/ZNmHkpuEoqwofwLq7qBKLoQIUjOfWna/o7UXlclGvAL
         xjq/9PKspAc+VbL3GInGX/MPTp6rPKuxuT10OT28MpUUNRURbbzAJULfnM4T7e9QE2Nf
         f5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361856;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITjUM/DPj52rkXdpLKl4kDFyKatxAMdfpgk650IJLH8=;
        b=WG7WHgs1uN5bNG6JWLxYgAE5TW2oazVo3JbYoZ2MtWSzVmydpdMhpU5+2MNEzRH4x3
         6bFN7OoFSUhITtfjutY+3CfUedw2PhZQRnBJ+qHmnsgdADlcY2omni6ySqlG+Cx01OdO
         RsojRxsSYLHtwREa446oAqEExTn6svynDIyIuzwkLNe28S/5/EGPFz0EHw6AjQpKh2yy
         zYgFiy1dued4ubjuilcSzpIuAQ+Ui5fvYtBG/LzE9qTK2hchamWpweANBU8U0yVzBSkQ
         c8NGtHaEJfejXH1SpEI22mUT9N+47G+bvy5ksZEXeykeWnXjG8HDILMoGMMabwvFVP5r
         uBYQ==
X-Gm-Message-State: AAQBX9eOh5NTguFv03/g8csegglA+fyb7o63ZeCqBhHGvIT8335Y01BJ
        KTgdIx8kBxFtgAlhOFn8o+FMzLxXWQA=
X-Google-Smtp-Source: AKy350bZtKaDr2k8LHCw/Jh9HFD8xK+nOrjLpDikeBaTs6IULQyGysqBC6z22rr42H66GF1NGQ7AMg==
X-Received: by 2002:a5d:4fcd:0:b0:2e5:d4f4:c43b with SMTP id h13-20020a5d4fcd000000b002e5d4f4c43bmr4294301wrw.55.1680361856622;
        Sat, 01 Apr 2023 08:10:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16-20020adffcd0000000b002d5a8d8442asm5097140wrs.37.2023.04.01.08.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:56 -0700 (PDT)
Message-Id: <2421bb380b151dc80120fc429e74587ea91cc1ea.1680361840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:37 +0000
Subject: [PATCH 24/24] mailmap, quote: move declarations of global vars to
 correct unit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
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
index 3c3e40b52e8..4d64ec95dc6 100644
--- a/cache.h
+++ b/cache.h
@@ -622,8 +622,6 @@ void set_alternate_index_output(const char *);
 extern int verify_index_checksum;
 extern int verify_ce_order;
 
-extern int quote_path_fully;
-
 #define MTIME_CHANGED	0x0001
 #define CTIME_CHANGED	0x0002
 #define OWNER_CHANGED	0x0004
@@ -708,9 +706,6 @@ extern int fetch_if_missing;
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
