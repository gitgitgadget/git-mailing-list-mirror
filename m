Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 185631F405
	for <e@80x24.org>; Fri, 10 Aug 2018 00:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeHJChj (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 22:37:39 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:37189 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeHJChj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 22:37:39 -0400
Received: by mail-ua1-f73.google.com with SMTP id w15-v6so100234uao.4
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 17:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hvHzoAfBekcVBq1XRLvlnUmAdU5AaLPKB093IlJMhD0=;
        b=UtOW175AkCNSZ1Sgq8GC7k6Q23SxIxW296mm0Zn88fGObYjj1zHqZwUQlk4WPZ3OJ5
         Zc5unhMiS/3jaSTLO0atFb3uEXFDyIe403OgB1i7rEsNCTRDzivQa23FIA2hCbxEV4zM
         2n10JDi6xYPGm29TmC2TS+BQEYrEXvzhU6Twr+9BWFbZfqUHoITdqM6uCo3kMcosDmJ9
         FaY9eREW41O/Q9qMRHMNAu+ZRQo4CioKVbJJxpcMxF9lTX1+Tdc9oCySLA+hlgalaVYy
         0YRDeK1Prl9gxfWU2M9IXvYVRlEHtqMTVx/xq6eEgzZn4SGI5DNWvhUjrezPBxMhhNVa
         FfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hvHzoAfBekcVBq1XRLvlnUmAdU5AaLPKB093IlJMhD0=;
        b=SPqu0IXR1X+dTlzMB8561EJrzlGek4FBxApUsQcjT08dJDN4Dj+7lIu429gZRZs5Oz
         MOoDowXjzDNLmeJlC2kWeNR2h1W7DoDFPDaGhx/JDeOGMKgmNoGhow55ZoMKiYHKXfxK
         m2aKjB4i9Uz7/eh1jSe1rgZ6AfxZ5N9Bsbje9mLxr2z/bc2Fw63c0Lr3kR7lXwrDvzXu
         6YcJ5PEnlUICs16+CacVdrEW6L5to83AyaSwusKtgBZY9E6iZsCKHAqj8n1IUXV4QNaK
         sr5KGdFFzYakmTC7uQHqFVSN+CmCS5evxWV7Db4HNNhmF4H17Uk48p2XrIjZs9mqxbdL
         5+6A==
X-Gm-Message-State: AOUpUlHjqtu+P8srqzEy89kjuLXmcaGqt6gp9+81/4/oS5/IwgfxSrj5
        POVTNWCxdIqHTuigxWtWvKEtyNepL3Wt
X-Google-Smtp-Source: AA+uWPw+Sqf1GNUkWKMTnNDpfK//kDsJF+tCSsc0btSO5JXC9lGGgLkm7hKx8BZRMwCV8rSygdXR8h+KStGC
X-Received: by 2002:a9f:3766:: with SMTP id a35-v6mr1989703uae.19.1533859822493;
 Thu, 09 Aug 2018 17:10:22 -0700 (PDT)
Date:   Thu,  9 Aug 2018 17:10:09 -0700
In-Reply-To: <20180810001010.58870-1-sbeller@google.com>
Message-Id: <20180810001010.58870-2-sbeller@google.com>
Mime-Version: 1.0
References: <20180724003619.185290-1-sbeller@google.com> <20180810001010.58870-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 1/2] WIP: range-diff: take extra arguments for different diffs.
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can use the range-diff on the same range to examine differences in the
diff algorithm.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 range-diff.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 347b4a79f25..a977289b7dc 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -28,7 +28,8 @@ struct patch_util {
  * Reads the patches into a string list, with the `util` field being populated
  * as struct object_id (will need to be free()d).
  */
-static int read_patches(const char *range, struct string_list *list)
+static int read_patches(const char *range, struct string_list *list,
+			struct argv_array *extra_log_args)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	FILE *in;
@@ -36,7 +37,12 @@ static int read_patches(const char *range, struct string_list *list)
 	struct patch_util *util = NULL;
 	int in_header = 1;
 
-	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
+	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges", NULL);
+
+	if (extra_log_args)
+		argv_array_pushv(&cp.args, extra_log_args->argv);
+
+	argv_array_pushl(&cp.args,
 			"--reverse", "--date-order", "--decorate=no",
 			"--no-abbrev-commit", range,
 			NULL);
@@ -419,14 +425,20 @@ int show_range_diff(const char *range1, const char *range2,
 {
 	int res = 0;
 
+	struct argv_array extra = ARGV_ARRAY_INIT;
+
 	struct string_list branch1 = STRING_LIST_INIT_DUP;
 	struct string_list branch2 = STRING_LIST_INIT_DUP;
 
-	if (read_patches(range1, &branch1))
+	argv_array_push(&extra, "--diff-algorithm=patience");
+	argv_array_push(&extra, "--indent-heuristic");
+
+	if (read_patches(range1, &branch1, NULL))
 		res = error(_("could not parse log for '%s'"), range1);
-	if (!res && read_patches(range2, &branch2))
+	if (!res && read_patches(range2, &branch2, &extra))
 		res = error(_("could not parse log for '%s'"), range2);
 
+	diffopt->color_moved = COLOR_MOVED_DEFAULT;
 	if (!res) {
 		find_exact_matches(&branch1, &branch2);
 		get_correspondences(&branch1, &branch2, creation_factor);
-- 
2.18.0.597.ga71716f1ad-goog

