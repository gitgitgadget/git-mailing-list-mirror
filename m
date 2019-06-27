Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 284661F461
	for <e@80x24.org>; Thu, 27 Jun 2019 09:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfF0J3s (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 05:29:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37195 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfF0J3r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 05:29:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id 25so751437pgy.4
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 02:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+71tyz5S8FC6U1D522veTq3yfAHghgCGmInSf5VkLs=;
        b=X5XaSrIzhxk76PoZRaf2CkHHrwMulWzMRSkwGMFGAdwJx0ePIPvTR9PaLXtEOWbET+
         RNUsIhvC+UUMnULhd55pJSe1j1eawx4LrIlPbfkb8aNqaCjfCwXScDtHtEptYPymNXR5
         YiIqFWJIijIkPiU4P8J1JhDi44uwrTDM12fMSBZo5nJ/7Kx2zfckq0ZMcN1BiW0G00Qg
         8y2GluakeR7EBlNj0nnHWaZJz2LdCK+w0tJ7kbG81z9i8+NTqhFvUUbGyJXV7/9bhPt8
         6tEmA3eT9nBlEppHCSugLyaQMDsNUTOgKNy0pSwBhBTnZ6tvqfyLdwE0wzTsG3eTJJh7
         UVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+71tyz5S8FC6U1D522veTq3yfAHghgCGmInSf5VkLs=;
        b=uIuw35lVhSpARDYxyTRuwWU4t+KDVjjQd0ed7jRTrOz6C5gAiTHrKyma7QHt6m9ZLs
         TVrVohyPChStNJL40ERbaanQgpfv6Wk3vcTSQRtFUz5E6lrjCEuoqCmYso8kasU0Ahwv
         rJNjI1/gJvEKYFabEzeLRAQmrMQVtuHRlYdxQ+Urzl/ub/bI+MOFiZhaig3BL9kF4s3G
         yVjRGPejwriYFqmDRBjxBfoJR7yShVY6VSwSXUQt5rF/TAsd6VLJEEFA5bhX4B/06raT
         SQUTd9U2iqRC8qOw3xF+1dOUG+BNtYRs9lhwZDKcr7DmLT8LInJICmNQnzMcCkR9VfBQ
         E10Q==
X-Gm-Message-State: APjAAAUo1i1B+RmdHdW0QVMm87GO3uwQO1OCT/RQjrQaRMbrivwGPC3Y
        bTWlVDmCJqYfnk3vSUYNLxIJLcwI
X-Google-Smtp-Source: APXvYqzp0TQRqip535+RwGsoHasFhq1vl8qS4maMBDlgjBnrVfRkYEek0oEExDp/1GhUHRXU7ExefQ==
X-Received: by 2002:a17:90a:24e4:: with SMTP id i91mr5037524pje.9.1561627786840;
        Thu, 27 Jun 2019 02:29:46 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id o13sm5915692pje.28.2019.06.27.02.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 02:29:46 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 27 Jun 2019 16:29:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 5/6] match-trees.c: remove the_repo from shift_tree*()
Date:   Thu, 27 Jun 2019 16:28:51 +0700
Message-Id: <20190627092852.11326-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190627092852.11326-1-pclouds@gmail.com>
References: <20190624095533.22162-1-pclouds@gmail.com>
 <20190627092852.11326-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h                     |  4 ++--
 match-trees.c               | 12 +++++++-----
 merge-recursive.c           |  4 ++--
 t/helper/test-match-trees.c |  2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index cd84cc9bbe..ddefda2bb6 100644
--- a/cache.h
+++ b/cache.h
@@ -1786,8 +1786,8 @@ int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int
 extern int diff_auto_refresh_index;
 
 /* match-trees.c */
-void shift_tree(const struct object_id *, const struct object_id *, struct object_id *, int);
-void shift_tree_by(const struct object_id *, const struct object_id *, struct object_id *, const char *);
+void shift_tree(struct repository *, const struct object_id *, const struct object_id *, struct object_id *, int);
+void shift_tree_by(struct repository *, const struct object_id *, const struct object_id *, struct object_id *, const char *);
 
 /*
  * whitespace rules.
diff --git a/match-trees.c b/match-trees.c
index de7e8a6783..f6c194c1cc 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -248,7 +248,8 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
  * other hand, it could cover tree one and we might need to pick a
  * subtree of it.
  */
-void shift_tree(const struct object_id *hash1,
+void shift_tree(struct repository *r,
+		const struct object_id *hash1,
 		const struct object_id *hash2,
 		struct object_id *shifted,
 		int depth_limit)
@@ -290,7 +291,7 @@ void shift_tree(const struct object_id *hash1,
 		if (!*del_prefix)
 			return;
 
-		if (get_tree_entry(the_repository, hash2, del_prefix, shifted, &mode))
+		if (get_tree_entry(r, hash2, del_prefix, shifted, &mode))
 			die("cannot find path %s in tree %s",
 			    del_prefix, oid_to_hex(hash2));
 		return;
@@ -307,7 +308,8 @@ void shift_tree(const struct object_id *hash1,
  * Unfortunately we cannot fundamentally tell which one to
  * be prefixed, as recursive merge can work in either direction.
  */
-void shift_tree_by(const struct object_id *hash1,
+void shift_tree_by(struct repository *r,
+		   const struct object_id *hash1,
 		   const struct object_id *hash2,
 		   struct object_id *shifted,
 		   const char *shift_prefix)
@@ -317,12 +319,12 @@ void shift_tree_by(const struct object_id *hash1,
 	unsigned candidate = 0;
 
 	/* Can hash2 be a tree at shift_prefix in tree hash1? */
-	if (!get_tree_entry(the_repository, hash1, shift_prefix, &sub1, &mode1) &&
+	if (!get_tree_entry(r, hash1, shift_prefix, &sub1, &mode1) &&
 	    S_ISDIR(mode1))
 		candidate |= 1;
 
 	/* Can hash1 be a tree at shift_prefix in tree hash2? */
-	if (!get_tree_entry(the_repository, hash2, shift_prefix, &sub2, &mode2) &&
+	if (!get_tree_entry(r, hash2, shift_prefix, &sub2, &mode2) &&
 	    S_ISDIR(mode2))
 		candidate |= 2;
 
diff --git a/merge-recursive.c b/merge-recursive.c
index b051066795..6d772eb0eb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -153,9 +153,9 @@ static struct tree *shift_tree_object(struct repository *repo,
 	struct object_id shifted;
 
 	if (!*subtree_shift) {
-		shift_tree(&one->object.oid, &two->object.oid, &shifted, 0);
+		shift_tree(repo, &one->object.oid, &two->object.oid, &shifted, 0);
 	} else {
-		shift_tree_by(&one->object.oid, &two->object.oid, &shifted,
+		shift_tree_by(repo, &one->object.oid, &two->object.oid, &shifted,
 			      subtree_shift);
 	}
 	if (oideq(&two->object.oid, &shifted))
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index 96857f26ac..b9fd427571 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -20,7 +20,7 @@ int cmd__match_trees(int ac, const char **av)
 	if (!two)
 		die("not a tree-ish %s", av[2]);
 
-	shift_tree(&one->object.oid, &two->object.oid, &shifted, -1);
+	shift_tree(the_repository, &one->object.oid, &two->object.oid, &shifted, -1);
 	printf("shifted: %s\n", oid_to_hex(&shifted));
 
 	exit(0);
-- 
2.22.0.rc0.322.g2b0371e29a

