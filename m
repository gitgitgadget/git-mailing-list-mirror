Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B59EC76188
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjDDBXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjDDBXO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:23:14 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4153A3A94
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:50 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso268901wmo.0
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571368;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+giBddeP/vAOtEknKR5vDnEexHLIbZoW933D35Ivkg=;
        b=JAyjth+yTjuyUJHkVzV4NEBiy0J4jiyBnN/VCubSTn4dWRfLwi/DDw3d57OKO+Qw9C
         xafiXjmr1zqHckJBrsUREAScnKKAlm/B3ui5X4A6vP0gxb7jgODqdq3jsrTnazzj8NLb
         2AgQlK4eQKRXnTrhslIqBoQKtHH/7xw/F81XwMNSnamWmLLGWXJuIHtOCv0gPPDlhj4M
         mBMbp6YgjCC/iBGCB+JPPnp9OoAhC83lV3zLoStegnbG2DvDK0scjCj7YxrrEPOSwm9R
         l78SlRcHwoDjZbEigi2QBbvriMuJCa4MR4qNT6Eld54IQ24lWoMGzY9WpU3w0DYMHt88
         ehBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571368;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+giBddeP/vAOtEknKR5vDnEexHLIbZoW933D35Ivkg=;
        b=XYDf+yWiumHeQBfJcXqWtztxzsezBtKHkQgTJ16EYYkM4YNsSXow67mDa36iTwJf5g
         xd05NszLZcSsA9UU7lfEK/ACilepyPxoU71oaar+59BWy+607e+xKAfNlGGqs/MGge7a
         y4CnBFVA/Lka3l9SZjfiVvWOqqXxvgF/j8L8THzVg/DUkhJqOuJeQDTFZz4I/ISPOEvr
         pjD/ebkbfpJ/s5hoeN2yDeLuFrzWy/vDj/YRBY0/dFRQ0Y29sNJhA7mjLWTaQc7hwDsG
         FLDq4FEiXYF0xhM7XpO0gw+DBD6WBQBKiqzsSZcE0lzI2YawYwGv1ti9FOTkCQQIGs+S
         9XQw==
X-Gm-Message-State: AAQBX9d6dhbHiWE1XLz4RwFG27tUoidOvxtAphDJjFuwyuwGPta9k0aa
        HZlsGcJI5wWiZy4TyPdcqk00x0ze90s=
X-Google-Smtp-Source: AKy350a4JYPGt7BL3E9mNJnXJZ4keTWOsg/rgvTSfWo8YhDCB6r5egJLIWSkuYiMh7RTD/CodQqmpw==
X-Received: by 2002:a7b:ca55:0:b0:3ed:93de:49ff with SMTP id m21-20020a7bca55000000b003ed93de49ffmr822347wml.0.1680571368540;
        Mon, 03 Apr 2023 18:22:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c4f0700b003ef5deb4188sm20899251wmq.17.2023.04.03.18.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:48 -0700 (PDT)
Message-Id: <47afc6a6c8757032d9d69a2f9aaaeb427c5a003f.1680571352.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:25 +0000
Subject: [PATCH v2 21/24] strbuf: move forward declarations to beginning of
 file
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strbuf.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index 3dfeadb44c2..547696fb233 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -1,6 +1,8 @@
 #ifndef STRBUF_H
 #define STRBUF_H
 
+struct object_id;
+struct repository;
 struct string_list;
 
 /**
@@ -72,12 +74,6 @@ struct strbuf {
 extern char strbuf_slopbuf[];
 #define STRBUF_INIT  { .buf = strbuf_slopbuf }
 
-/*
- * Predeclare this here, since cache.h includes this file before it defines the
- * struct.
- */
-struct object_id;
-
 /**
  * Life Cycle Functions
  * --------------------
@@ -634,7 +630,6 @@ void strbuf_list_free(struct strbuf **list);
  * Add the abbreviation, as generated by repo_find_unique_abbrev(), of `sha1` to
  * the strbuf `sb`.
  */
-struct repository;
 void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
 				   const struct object_id *oid, int abbrev_len);
 void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
-- 
gitgitgadget

