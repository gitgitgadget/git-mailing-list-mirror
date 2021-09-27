Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0B8C433FE
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 089326103B
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbhI0QgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 12:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbhI0Qfl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 12:35:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782FEC06176E
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:55 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k7so1112413wrd.13
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zU0LDvN716nciP0nufay8LdjyzhL3MrjsT30DOiqbpY=;
        b=Q0s4lTzYEUG/tPCSG4MkVD1dMyEek6R9sgUA1oVWoSJ8wXBtDC/qwJwnwXXXsTm9EV
         1w6w4/Q3/qzmZXqGIS0+d2xOShEHqu6AAbId7/1LUJ3htsflIJMlG26XB08oO3dlC0e7
         9sLuGBOFaGYFRLqKkSaJ2GCnWXKDb0gVNMHXxAtwXfZ4AUALYLZU9Yaf7qSCxn3/Nayl
         Zd+YlXVg0fr+SEke5FlMWr4kWKP9eVpId5BqXaLjd7jNadnMc0E8p9H7GcwwWQaL7iSe
         c43mo/w/W6azySiLZMBSn8iVJ1aZhYRnM44MPs+12xgZf/iGCH0ilyNwqtlZHc9w5/7M
         CW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zU0LDvN716nciP0nufay8LdjyzhL3MrjsT30DOiqbpY=;
        b=vFQGpTifyhVJ+/jtDZgPHDJzmeDi4jWA9AFBLox9hE18YNdR4BpjHAicuHbx6sHYT1
         niHFaHimiKzDOlgkSTyQ8uBezCg6QW+nTUHPfdCY5Lel1YVW1xKXnEzamYs/G7FC+Y79
         MSdwYzNuYE5Q59AUPnhz4wAtNYBpm6xpIbVH9qDWSBVl3pmiQisg1v7wzNmxjUfodt9l
         WqaO/HZKdJ8it7R3m8gEtQ36+EC4r9UkO13aPW3vGtBVNL9weCBWQwAI0rCbnKrMfA+M
         G0BiprthrPWM7Y+PDWpxLNojruG2zS+4J/XgvuZ6yeOyXz/rcSdgLeN/+aDL5NUQDTKe
         iMQg==
X-Gm-Message-State: AOAM5307l4x+h1DhUTaMIeHyW1arqSEu83YmCiPq0DUZpllnc1Le0U00
        s7jWs9AoKJTz3x+oDtA9hvitnDz5Hug=
X-Google-Smtp-Source: ABdhPJxiGadVi/22lNvh0xxN2pkrb0yfx98voAoehCyL43Mg99dpHU3F+CKURmBulaAQowq3mIYO8Q==
X-Received: by 2002:a5d:64e2:: with SMTP id g2mr857720wri.323.1632760434168;
        Mon, 27 Sep 2021 09:33:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a25sm321wmj.34.2021.09.27.09.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:33:53 -0700 (PDT)
Message-Id: <e4c42d43b094070ae635431ed3d0903722f42039.1632760428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
        <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Sep 2021 16:33:45 +0000
Subject: [PATCH v3 08/11] unpack-trees: avoid nuking untracked dir in way of
 unmerged file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2500-untracked-overwriting.sh |  2 +-
 unpack-trees.c                   | 35 ++++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overwriting.sh
index 18604360df8..5ec66058cfc 100755
--- a/t/t2500-untracked-overwriting.sh
+++ b/t/t2500-untracked-overwriting.sh
@@ -197,7 +197,7 @@ test_expect_failure 'git stash and untracked files' '
 	)
 '
 
-test_expect_failure 'git am --abort and untracked dir vs. unmerged file' '
+test_expect_success 'git am --abort and untracked dir vs. unmerged file' '
 	test_setup_sequencing am_abort_and_untracked &&
 	(
 		cd sequencing_am_abort_and_untracked &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 812e4c66713..080118f2325 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2178,9 +2178,15 @@ static int icase_exists(struct unpack_trees_options *o, const char *name, int le
 	return src && !ie_match_stat(o->src_index, src, st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
 }
 
+enum absent_checking_type {
+	COMPLETELY_ABSENT,
+	ABSENT_ANY_DIRECTORY
+};
+
 static int check_ok_to_remove(const char *name, int len, int dtype,
 			      const struct cache_entry *ce, struct stat *st,
 			      enum unpack_trees_error_types error_type,
+			      enum absent_checking_type absent_type,
 			      struct unpack_trees_options *o)
 {
 	const struct cache_entry *result;
@@ -2215,6 +2221,10 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 		return 0;
 	}
 
+	/* If we only care about directories, then we can remove */
+	if (absent_type == ABSENT_ANY_DIRECTORY)
+		return 0;
+
 	/*
 	 * The previous round may already have decided to
 	 * delete this path, which is in a subdirectory that
@@ -2235,6 +2245,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
  */
 static int verify_absent_1(const struct cache_entry *ce,
 			   enum unpack_trees_error_types error_type,
+			   enum absent_checking_type absent_type,
 			   struct unpack_trees_options *o)
 {
 	int len;
@@ -2261,7 +2272,8 @@ static int verify_absent_1(const struct cache_entry *ce,
 								NULL, o);
 			else
 				ret = check_ok_to_remove(path, len, DT_UNKNOWN, NULL,
-							 &st, error_type, o);
+							 &st, error_type,
+							 absent_type, o);
 		}
 		free(path);
 		return ret;
@@ -2276,7 +2288,7 @@ static int verify_absent_1(const struct cache_entry *ce,
 
 		return check_ok_to_remove(ce->name, ce_namelen(ce),
 					  ce_to_dtype(ce), ce, &st,
-					  error_type, o);
+					  error_type, absent_type, o);
 	}
 }
 
@@ -2286,14 +2298,23 @@ static int verify_absent(const struct cache_entry *ce,
 {
 	if (!o->skip_sparse_checkout && (ce->ce_flags & CE_NEW_SKIP_WORKTREE))
 		return 0;
-	return verify_absent_1(ce, error_type, o);
+	return verify_absent_1(ce, error_type, COMPLETELY_ABSENT, o);
+}
+
+static int verify_absent_if_directory(const struct cache_entry *ce,
+				      enum unpack_trees_error_types error_type,
+				      struct unpack_trees_options *o)
+{
+	if (!o->skip_sparse_checkout && (ce->ce_flags & CE_NEW_SKIP_WORKTREE))
+		return 0;
+	return verify_absent_1(ce, error_type, ABSENT_ANY_DIRECTORY, o);
 }
 
 static int verify_absent_sparse(const struct cache_entry *ce,
 				enum unpack_trees_error_types error_type,
 				struct unpack_trees_options *o)
 {
-	return verify_absent_1(ce, error_type, o);
+	return verify_absent_1(ce, error_type, COMPLETELY_ABSENT, o);
 }
 
 static int merged_entry(const struct cache_entry *ce,
@@ -2367,6 +2388,12 @@ static int merged_entry(const struct cache_entry *ce,
 		 * Previously unmerged entry left as an existence
 		 * marker by read_index_unmerged();
 		 */
+		if (verify_absent_if_directory(merge,
+				  ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o)) {
+			discard_cache_entry(merge);
+			return -1;
+		}
+
 		invalidate_ce_path(old, o);
 	}
 
-- 
gitgitgadget

