Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91AFF1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 20:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfGAUUx (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 16:20:53 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:55902 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfGAUUx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 16:20:53 -0400
Received: by mail-pf1-f201.google.com with SMTP id i26so9414410pfo.22
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 13:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P9pKwrlGaOOfj9iFXWKlglN3yvYMcUQW+AiUlhwNiJ0=;
        b=LzF0QmM5M/I6lBdKAhhlMmomK9n3Wx2T/lP1njlFJkDv2H3nKzeodP8+WaBvEoPD1u
         sk0RbBBg8lvh60kt8gMTUv7rPiLXpU74EngBZWu3LuBb1bc0olIIdBXyo1FUAcP7ipYu
         z7um6ErUMH0hdA7DrzlIFnIWzZMxkDffzViYaXyQui1nRbcGZYwEazluGLFmV9p/Zlod
         s1Ood/Hpw0t6nniQIUqYSL55e33Ik4elctICyZoipFVOPIkO7N7sMyC4MOU4tPED7KwO
         olV9xCiBWBAq52yHdg35eGwW8EkAl3Gp+To5j2J5h7M6miGeGmHgv2tkqVS9q/ObWPHw
         KMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P9pKwrlGaOOfj9iFXWKlglN3yvYMcUQW+AiUlhwNiJ0=;
        b=efFgPFqW7vF6T94XZhN3mS+Z0T7/dDfjSL49XibI8fALN+UvfO/Gq8D2sBwtRJChh/
         xYaZxaY+8NQ3gNDXQRv7TN3Rpaxysdx7JPdEcwG3xLJDQY11XrgDz9AVmuDZ5X7aOeON
         c7eNmc61gN7GZZ9tmy4gihsfwohPr0iP47fkApwoSa89fW/S1UkCLK0yreIxGWO6L2ef
         vOXpbArSZfsqmIKFwpXdX1P5b4WNnaBAZjsUXfsXo/bwovWDCVQGK+DOZZVPc8zRzEmN
         MgvdzLS2uuIE4cSmXCX5VGWrky01nB9qs4jchpqxR90Ha6uc0o0yDCr2BvgWiXMDkPtk
         hz2w==
X-Gm-Message-State: APjAAAVi+dXWe4BGG3ckI9HQQu4NXMiMN3n8D6SZibF+3YyJ1uv18tTD
        YDAepDAg0K1HTeWggYtxMXlD98FFwq4Erp+DMmwM9g/KmouFJsJlVI0voUpo2Bu9RQkO1d9DjDR
        qrPP86hE+Xi01CnosuIDl9V1I6DPC4Y0BXMyw3CJJ4fuMldGDIKCK/0Nr2FZOOM6GY55niAT2iQ
        ==
X-Google-Smtp-Source: APXvYqwjSK+R3xtIB5KFGKSkE0OA6BGoUeVDZmKh9/W3/jBDkvo75lMCc0sHGpPHcnQjKrpJRQ62FsRiYV5Ur9hEG7A=
X-Received: by 2002:a63:6cc3:: with SMTP id h186mr26182874pgc.292.1562012452457;
 Mon, 01 Jul 2019 13:20:52 -0700 (PDT)
Date:   Mon,  1 Jul 2019 13:20:13 -0700
In-Reply-To: <20190701202014.34480-1-emilyshaffer@google.com>
Message-Id: <20190701202014.34480-13-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190701201934.30321-1-emilyshaffer@google.com> <20190701202014.34480-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v3 12/13] walken: count omitted objects
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It may be illuminating to see which objects were not included within a
given filter. This also demonstrates, since filter-spec "tree:1" is
used, that the 'omitted' list contains all objects which are omitted,
not just the first objects which were omitted - that is, it continues to
dereference omitted trees and commits.

This is part of a tutorial on performing revision walks.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/walken.c b/builtin/walken.c
index 7b46377a2e..1638f679f2 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -146,6 +146,11 @@ static void walken_show_object(struct object *obj, const char *str, void *buf)
 static void walken_object_walk(struct rev_info *rev)
 {
 	struct list_objects_filter_options filter_options = {};
+	struct oidset omitted;
+	struct oidset_iter oit;
+	struct object_id *oid = NULL;
+	int omitted_count = 0;
+	oidset_init(&omitted, 0);
 
 	rev->tree_objects = 1;
 	rev->blob_objects = 1;
@@ -180,13 +185,19 @@ static void walken_object_walk(struct rev_info *rev)
 			walken_show_commit, walken_show_object, NULL, NULL);
 	}
 
+	/* Count the omitted objects. */
+	oidset_iter_init(&omitted, &oit);
+
+	while ((oid = oidset_iter_next(&oit)))
+		omitted_count++;
+
 	/*
 	 * This print statement is designed to be script-parseable. Script
 	 * authors will rely on the output not to change, so we will not
 	 * localize this string. It will go to stdout directly.
 	 */
-	printf("commits %d\n blobs %d\n tags %d\n trees %d\n", commit_count,
-	       blob_count, tag_count, tree_count);
+	printf("commits %d\n blobs %d\n tags %d\n trees %d omitted %d\n",
+	       commit_count, blob_count, tag_count, tree_count, omitted_count);
 }
 
 /*
-- 
2.22.0.410.gd8fdbe21b5-goog

