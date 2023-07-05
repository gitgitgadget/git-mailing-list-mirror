Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76C9C0015E
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 17:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjGERKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 13:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjGERJv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 13:09:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2DF19A3
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 10:09:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c647150c254so812072276.1
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 10:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688576985; x=1691168985;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KjvjrM2solQaB/yRMs3mzirHvRh2EwQtgVo7BMlQxIU=;
        b=S4CO76LrG/JF8loN8ghEfg9tDz7iJBxA0ADQbgLdVleAvVhngG3/esMHupRM4r5PnV
         Hlj5g9ZFjiJn1gbYon9so3w5e2bmG75QvgVvlhXUFW5ed7Gj4r8xd4wHGbhD8TZ0d5/O
         iF4xbNGdV/L3IPcXePx/sDrfXeu20V09rhqM0W7m1l3WEGhRGOQMMs7CixSGEBcI0maX
         6T7Hi4G9w9aID8Cglu+o+ySVmZJbF67s9bArggeZoA9Ag2mNFRx7bubBJGagiPq3EF72
         KUiS7P/s6IxwCGh4ifE1kdFU/tTW70T/sBrjXqpvGT1IQ9pJsLuKYnTj1Gtt7rOfheJT
         o4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688576985; x=1691168985;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjvjrM2solQaB/yRMs3mzirHvRh2EwQtgVo7BMlQxIU=;
        b=bfmk7STN5B7Eo6lzrW3W7Gb3gUD0SAHP9JNR64n25Pw5HuVOEK0GkYmuQbNh7vPx9X
         NmlAytXWZ5M/lQY561nY9GQYFEakNGyfmFRsnbAQSS6jTsYXqCnly5oi0jqerA8XRy4N
         sXjXT0dEu4P1l9AjFxeBa6rSQioBPmwUmHImbEnoz29VYTawEg3Hz12NmXu72esIk0Gv
         NOst4cEESQq2YsUMATFcOCU1C6tvo2Au/PQMBKhLn+2hCb8jqwcyK9Mbio0b7G1n4puL
         rIoYtXU8fQPunnUJhtuGr9uEnm+h7+HPf/AepyX3NSE+zxm7rptekB2feehMbBBD+oMI
         xkGQ==
X-Gm-Message-State: ABy/qLby8QG+e5pzHdf6yPaes8wNgh1//h7/ZSSX1T3ew4E35jSfSuEQ
        KxIDvhQMIXs/dXCdkS7hYsoGgTCLwhjicuRRqr+z5bMqQJ5iKCG0RZKHk0pWNnbl6RWYSQTyVQm
        BhzWFmdM4pRDHk25sFLD/6nHEtmjPNeGoeuazoi1ErvM13KDewKHisfVG0HXnQRi+fA==
X-Google-Smtp-Source: APBJJlETXnhSIMfWumiMrUjUp670qossiKBwIKZcmckO/fwxQlIZXrUvXyidfzL3s5UZjDPnCUPnToci9+Ha/BI=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:ca58:0:b0:bc3:cdb7:4ec8 with SMTP id
 a85-20020a25ca58000000b00bc3cdb74ec8mr36041ybg.6.1688576985574; Wed, 05 Jul
 2023 10:09:45 -0700 (PDT)
Date:   Wed,  5 Jul 2023 17:09:22 +0000
In-Reply-To: <20230705170812.3833103-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230705170812.3833103-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230705170924.3833828-4-calvinwan@google.com>
Subject: [PATCH v5 4/6] kwset: move translation table from ctype
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This table was originally introduced to solely be used with kwset
machinery (0f871cf56e), so it would make sense for it to belong in
kwset.[ch] rather than ctype.c and git-compat-util.h. It is only used in
diffcore-pickaxe.c, which already includes kwset.h so no other headers
have to be modified.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 ctype.c           | 36 ------------------------------------
 git-compat-util.h |  3 ---
 kwset.c           | 36 ++++++++++++++++++++++++++++++++++++
 kwset.h           |  2 ++
 4 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/ctype.c b/ctype.c
index fc0225cebd..3451745550 100644
--- a/ctype.c
+++ b/ctype.c
@@ -28,39 +28,3 @@ const unsigned char sane_ctype[256] = {
 	A, A, A, A, A, A, A, A, A, A, A, R, R, U, P, X,		/* 112..127 */
 	/* Nothing in the 128.. range */
 };
-
-/* For case-insensitive kwset */
-const unsigned char tolower_trans_tbl[256] = {
-	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
-	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
-	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
-	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
-	 ' ',  '!',  '"',  '#',  '$',  '%',  '&', 0x27,
-	 '(',  ')',  '*',  '+',  ',',  '-',  '.',  '/',
-	 '0',  '1',  '2',  '3',  '4',  '5',  '6',  '7',
-	 '8',  '9',  ':',  ';',  '<',  '=',  '>',  '?',
-	 '@',  'a',  'b',  'c',  'd',  'e',  'f',  'g',
-	 'h',  'i',  'j',  'k',  'l',  'm',  'n',  'o',
-	 'p',  'q',  'r',  's',  't',  'u',  'v',  'w',
-	 'x',  'y',  'z',  '[', 0x5c,  ']',  '^',  '_',
-	 '`',  'a',  'b',  'c',  'd',  'e',  'f',  'g',
-	 'h',  'i',  'j',  'k',  'l',  'm',  'n',  'o',
-	 'p',  'q',  'r',  's',  't',  'u',  'v',  'w',
-	 'x',  'y',  'z',  '{',  '|',  '}',  '~', 0x7f,
-	0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
-	0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
-	0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97,
-	0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f,
-	0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7,
-	0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf,
-	0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7,
-	0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf,
-	0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
-	0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf,
-	0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7,
-	0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf,
-	0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7,
-	0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef,
-	0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
-	0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
-};
diff --git a/git-compat-util.h b/git-compat-util.h
index 5f916e1094..1832444fa2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1152,9 +1152,6 @@ static inline size_t xsize_t(off_t len)
 #define HOST_NAME_MAX 256
 #endif
 
-/* in ctype.c, for kwset users */
-extern const unsigned char tolower_trans_tbl[256];
-
 #include "sane-ctype.h"
 
 /*
diff --git a/kwset.c b/kwset.c
index 4b14d4f86b..bbfcf815a5 100644
--- a/kwset.c
+++ b/kwset.c
@@ -49,6 +49,42 @@ static void *obstack_chunk_alloc(long size)
 
 #define U(c) ((unsigned char) (c))
 
+/* For case-insensitive kwset */
+const unsigned char tolower_trans_tbl[256] = {
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
+	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
+	 ' ',  '!',  '"',  '#',  '$',  '%',  '&', 0x27,
+	 '(',  ')',  '*',  '+',  ',',  '-',  '.',  '/',
+	 '0',  '1',  '2',  '3',  '4',  '5',  '6',  '7',
+	 '8',  '9',  ':',  ';',  '<',  '=',  '>',  '?',
+	 '@',  'a',  'b',  'c',  'd',  'e',  'f',  'g',
+	 'h',  'i',  'j',  'k',  'l',  'm',  'n',  'o',
+	 'p',  'q',  'r',  's',  't',  'u',  'v',  'w',
+	 'x',  'y',  'z',  '[', 0x5c,  ']',  '^',  '_',
+	 '`',  'a',  'b',  'c',  'd',  'e',  'f',  'g',
+	 'h',  'i',  'j',  'k',  'l',  'm',  'n',  'o',
+	 'p',  'q',  'r',  's',  't',  'u',  'v',  'w',
+	 'x',  'y',  'z',  '{',  '|',  '}',  '~', 0x7f,
+	0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
+	0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
+	0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97,
+	0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f,
+	0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7,
+	0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf,
+	0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7,
+	0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf,
+	0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
+	0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf,
+	0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7,
+	0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf,
+	0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7,
+	0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef,
+	0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
+	0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
+};
+
 /* Balanced tree of edges and labels leaving a given trie node. */
 struct tree
 {
diff --git a/kwset.h b/kwset.h
index f50ecae573..d42a793a30 100644
--- a/kwset.h
+++ b/kwset.h
@@ -26,6 +26,8 @@
    The author may be reached (Email) at the address mike@ai.mit.edu,
    or (US mail) as Mike Haertel c/o Free Software Foundation. */
 
+extern const unsigned char tolower_trans_tbl[256];
+
 struct kwsmatch
 {
   int index;			/* Index number of matching keyword. */
-- 
2.41.0.255.g8b1d071c50-goog

