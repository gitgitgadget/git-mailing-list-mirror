Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F50CC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 05:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiGAFXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 01:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiGAFX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 01:23:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105BE205C3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 22:23:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d17so1502207wrc.10
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 22:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AxzoeF7yxKuO2ENG2h5ng4XglA2GKbSgkHokpO7INQk=;
        b=izQPk5hnLJj18JIhCcDNkJSN0j+yHiOrn82BUzBfrZzDzZOlnwtk7j2QjiKHer1ZkQ
         Req6wsjHJ39W+ek0lGjC061/u04nLak7GWMeQsq9V2ojmUOveSs5Uuv6rLclSJXU7qg8
         EPwvTWkK8tYIhZwYDEJaMgdKnPnY/ezjkpLQirGJ/AkVCyx3lYHPwMLWUaq/+zsVyAo5
         tQb4/qMa4FepmWuEeE2yKM88o6ieaKwzy1Nv5grUcY1aHDEJMyrbw+d1EUIY+wV68ik8
         u0Ycf50MnohwbzfudLtOFeqIsLcDsunWaB2SKVlNAk+6D/SSRF5jxaJT87binEtVyalV
         nykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AxzoeF7yxKuO2ENG2h5ng4XglA2GKbSgkHokpO7INQk=;
        b=25znLinDQLTO72dxCQ7+BPCwVlqrl+8FIJ0ORVDpCbiFVFQHylVMm1/m9hu+Z1bVzS
         1RHGIZdztIYxEzroGfKv4miWR8ajj93UHgUhEHzUjhqpDqkjRF5pni7LM4tGZeQxn73Y
         CUehlORN4SZHEC0RmxdpSsqPPVQPdPL2HqjVg0tPNNMEu3Ub40cYt8VfhIzB78oL9UEM
         VEWxnmDrWe0EkUiTx3JYPh0Ut+P4Zhbc5g0eumSeY/rjn1xus4Mbck7ihf9HLligDF67
         PaM2KhGo5HB4s3N2r+j6XT1lCSy7TMyejnC+J7HEnx6uFVTHQgUoD4Kr1j235bcP1t/k
         8S3Q==
X-Gm-Message-State: AJIora9oIEnjBe4ukiSPiigoQuc8LBaU5WmypvSY6BMCjcFHQSS0gNiw
        JTZmx4to6sND9/s8r8zCJG7bfIfxvK0=
X-Google-Smtp-Source: AGRyM1sRsbL3j+2jALVWlkq8Uvp4GF66sZNO9f2DgAddlxVAq4cSRf9jGfLYcM+sfnV6TLchdHgHNw==
X-Received: by 2002:a5d:64a4:0:b0:21d:133d:cbb4 with SMTP id m4-20020a5d64a4000000b0021d133dcbb4mr11159108wrp.208.1656653005288;
        Thu, 30 Jun 2022 22:23:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1-20020adff5c1000000b0020d07d90b71sm20779761wrp.66.2022.06.30.22.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 22:23:24 -0700 (PDT)
Message-Id: <f5f87acbbd281966288968288ed78fe053933786.1656653000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
References: <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
        <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jul 2022 05:23:18 +0000
Subject: [PATCH v3 3/5] merge-ort: make a separate function for freeing struct
 collisions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@palantir.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@palantir.com>

This commit makes no functional changes, it's just some code movement in
preparation for later changes.

Signed-off-by: Elijah Newren <newren@palantir.com>
---
 merge-ort.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index ff037cca8d2..1514dd173c0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2259,6 +2259,27 @@ static void compute_collisions(struct strmap *collisions,
 	}
 }
 
+static void free_collisions(struct strmap *collisions)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	/* Free each value in the collisions map */
+	strmap_for_each_entry(collisions, &iter, entry) {
+		struct collision_info *info = entry->value;
+		string_list_clear(&info->source_files, 0);
+	}
+	/*
+	 * In compute_collisions(), we set collisions.strdup_strings to 0
+	 * so that we wouldn't have to make another copy of the new_path
+	 * allocated by apply_dir_rename().  But now that we've used them
+	 * and have no other references to these strings, it is time to
+	 * deallocate them.
+	 */
+	free_strmap_strings(collisions);
+	strmap_clear(collisions, 1);
+}
+
 static char *check_for_directory_rename(struct merge_options *opt,
 					const char *path,
 					unsigned side_index,
@@ -3029,8 +3050,6 @@ static int collect_renames(struct merge_options *opt,
 	int i, clean = 1;
 	struct strmap collisions;
 	struct diff_queue_struct *side_pairs;
-	struct hashmap_iter iter;
-	struct strmap_entry *entry;
 	struct rename_info *renames = &opt->priv->renames;
 
 	side_pairs = &renames->pairs[side_index];
@@ -3076,20 +3095,7 @@ static int collect_renames(struct merge_options *opt,
 		result->queue[result->nr++] = p;
 	}
 
-	/* Free each value in the collisions map */
-	strmap_for_each_entry(&collisions, &iter, entry) {
-		struct collision_info *info = entry->value;
-		string_list_clear(&info->source_files, 0);
-	}
-	/*
-	 * In compute_collisions(), we set collisions.strdup_strings to 0
-	 * so that we wouldn't have to make another copy of the new_path
-	 * allocated by apply_dir_rename().  But now that we've used them
-	 * and have no other references to these strings, it is time to
-	 * deallocate them.
-	 */
-	free_strmap_strings(&collisions);
-	strmap_clear(&collisions, 1);
+	free_collisions(&collisions);
 	return clean;
 }
 
-- 
gitgitgadget

