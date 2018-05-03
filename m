Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62BA6200B9
	for <e@80x24.org>; Thu,  3 May 2018 23:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeECXBY (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 19:01:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:41789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751369AbeECXBW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 19:01:22 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MV5tl-1er5jF2NDB-00YRdn; Fri, 04 May 2018 01:01:16 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Wink Saville <wink@saville.com>
Subject: [PATCH v2 1/6] sequencer: extract helper to update active_cache_tree
Date:   Fri,  4 May 2018 01:01:15 +0200
Message-Id: <ad31aab8e735f7de813860cacb32abbc406f43d1.1525388472.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.38.g05ca542f78d
In-Reply-To: <cover.1525388472.git.johannes.schindelin@gmx.de>
References: <cover.1524868165.git.johannes.schindelin@gmx.de> <cover.1525388472.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zjgm0JyQRWptNd/9ZVqYF6gKOBF3CL5SmYYccqtQbhRF0wA7hxw
 ofD9sY2kHdfw85ML5/7YMwFIcHHrq8WAhu8IRBCixpIYPgafJ1p2/gZEKnQBORLkVmKIzVX
 hep1+q+GrUFibHUhYodRZ89I9WQZb9jtP+ZVoS1esRTmkjhD6smYvQTRYERmkKvrgvd6xmi
 1+XbWzay5xu84VE4JcnaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1ucD/fFCe+Q=:XRsBDTnuCQ9A8/fyOFasBz
 YCbv1kpLI8qxOzszTpZ03UvhQiRK09gQ/UODkurltxcv9szgIrKaQ6wZSHa7LDnZKPyfcna/f
 ylpDfJGDcYFRUd+TG6GvCzUWbktGBLBR1dmYbUZneQhag4I5i2T6v7P+UjhKlfP42sDmNQnCK
 DEiyitDjHQs9FmaVPmzB8tK0BCvFV3Cf+Da1U0FUmLj1U2M0zrm+yJMQTikFl+YHIIYlYsOt6
 LH0k7EJbRg3BQ6d1nN3ID3+XZKvVRIwjdahku1BSf2XcfvLQyg4+M4YK4WBs+Fd0shMEWnM3G
 SI7TEwUNCcS3bayDBsfGFr3BYgFCIm49Iot63WesVzuovfXYL+KnNNBY1d8WlWdvrTZUuTTye
 xG+2XXdN+zVo4jQ+zOCEv1TUYMy9pRWuUM3JTI1wJlFzVXxhB5Q9o6aub5T/jb5E28NUyCgSj
 2bt8rfrV/f+yhMMKr3Zdzb3ZyR0Jt89wj+unj9hsg5vGOllb68hb7KJUQ14vA5AnJrA5Rw73T
 TSQvU1k0G4cJvAuHYEiHWMxFBJdTMU1e8+aKYMKrc7VzTguBtkq1ICWelZBbs71QGfRGPE8fG
 3BVfaz1mOQEfGhGhAmeXBc5ZHwK3Mr+CSwDqPwFOcKvWA9wObC89phoDXtDcIfKIYB3oD4QSi
 GUa5l85ZavpLRjDE+JdMVmYcl94SjCIAF1WXQeTRkr5IKOGLXC6nWM1EYvEKCloFHQrWDaePE
 wAp+q9LDzd5UjpFFW+C+CXLHJN6RJGzaGHut35N2a72Q2W/4ZbMBRcwHYSZrU3PfRsnz0ogpm
 vBSaU84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch extracts the code from is_index_unchanged() to initialize or
update the index' cache tree (i.e. a tree object reflecting the current
index' top-level tree).

The new helper will be used in the upcoming code to support `git rebase
-i --root` via the sequencer.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e2f83942843..90c8218aa9a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -562,9 +562,23 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	return !clean;
 }
 
+static struct object_id *get_cache_tree_oid(void)
+{
+	if (!active_cache_tree)
+		active_cache_tree = cache_tree();
+
+	if (!cache_tree_fully_valid(active_cache_tree))
+		if (cache_tree_update(&the_index, 0)) {
+			error(_("unable to update cache tree"));
+			return NULL;
+		}
+
+	return &active_cache_tree->oid;
+}
+
 static int is_index_unchanged(void)
 {
-	struct object_id head_oid;
+	struct object_id head_oid, *cache_tree_oid;
 	struct commit *head_commit;
 
 	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
@@ -583,15 +597,10 @@ static int is_index_unchanged(void)
 	if (parse_commit(head_commit))
 		return -1;
 
-	if (!active_cache_tree)
-		active_cache_tree = cache_tree();
-
-	if (!cache_tree_fully_valid(active_cache_tree))
-		if (cache_tree_update(&the_index, 0))
-			return error(_("unable to update cache tree"));
+	if (!(cache_tree_oid = get_cache_tree_oid()))
+		return -1;
 
-	return !oidcmp(&active_cache_tree->oid,
-		       &head_commit->tree->object.oid);
+	return !oidcmp(cache_tree_oid, &head_commit->tree->object.oid);
 }
 
 static int write_author_script(const char *message)
-- 
2.17.0.windows.1.38.g05ca542f78d


