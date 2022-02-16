Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992B7C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 10:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiBPKPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:15:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiBPKP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 05:15:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6AC66212
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:15:15 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q7so2554562wrc.13
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WdLBO6ImqXGB0biveFsNC4iFcF4RB6vpchYYrUxpuaU=;
        b=auRmorPbiycQ/XyOAFU5rLpierbmrxMiccn3PCcVL2M9JYw0gTLN4Z8eJkisxbbPvR
         5OH7wlRVxo7/Bxd/AG29ABZDHVfUxBLT6a6fLBTM8vvBdubNjwPA9S+tIOsnmEvMgIT+
         FUegcSTdI1580eXHqhlCxry8X/2SIVBQiBGvbrjpK+Is4Rzc15CiE3iLuyAx5cPhTDXw
         /5DhKhM343WDrSEA/nZa2HW79yCEe+YXL6WVapHiP/YIGgQpLtJjWum0BXwTUGC5o+oJ
         qxiMccGm3urkZkR/+omOpuvfUjTLUFCYW+DS45x7JMXxsxQ9Daq9m9X4IobkhHyzE8os
         uFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WdLBO6ImqXGB0biveFsNC4iFcF4RB6vpchYYrUxpuaU=;
        b=vX5Pc3uXvDWCRpMioxYlIDTpE9eJPMUTl5nOzVLf9K/gsRXQm/D4tFuOMT3ZNkiMA9
         66ei40cbmyQD9D1jz0JCHax4lxZQRNEWeTaeHFA8MSSvo2JSFizIh3b1fWyoYYRHfCJD
         E2ETDvPVk2xuRaOJryK+vFTrGGm0VjKXVI8QLM0H0zktjbddsODHYrsGTTUNxQrB+wib
         3YoOATdVpEyLaji/TPL/2IvfF/Z5dY4x4exhbT0Yv7j1i+CgIHW1YuIGCW0wcLxbD7Y7
         Es7WlMWwSXwpmTpDuUKJpx5DjmJbPZpEtEq/71ij92VvQSiJYDOPIi+/mNQOscwHnjZd
         ydVw==
X-Gm-Message-State: AOAM530jdvPe7al5kxQf0c1nRsm2asrHsbym/66LaIdmg/PM2ECH9YzU
        O+W7l+j/A4M+nSwGD97ei2wZQz75chE=
X-Google-Smtp-Source: ABdhPJyUYxB81lTRiTcrsihMz9Gy2xQBAJ1EJfBpIaafY/NXtgynDu3+6qLbsJGwVFaFmwRSIttArQ==
X-Received: by 2002:a5d:4a84:0:b0:1e3:2b6b:c723 with SMTP id o4-20020a5d4a84000000b001e32b6bc723mr1663680wrq.666.1645006513074;
        Wed, 16 Feb 2022 02:15:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay38sm20844222wmb.3.2022.02.16.02.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 02:15:12 -0800 (PST)
Message-Id: <fec1f4a4152dbde8909ad640bf7adbd7622a64da.1645006510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v2.git.1645006510.gitgitgadget@gmail.com>
References: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
        <pull.1140.v2.git.1645006510.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 10:15:07 +0000
Subject: [PATCH v2 2/4] xdiff: handle allocation failure in patience diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Edward Thomson <ethomson@edwardthomson.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Other users of libxdiff such as libgit2 need to be able to handle
allocation failures. As NULL is a valid return value the function
signature is changed to be able report allocation failures.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xpatience.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index e8de8d150ce..1a21c6a74b3 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -198,7 +198,7 @@ static int binary_search(struct entry **sequence, int longest,
  * item per sequence length: the sequence with the smallest last
  * element (in terms of line2).
  */
-static struct entry *find_longest_common_sequence(struct hashmap *map)
+static int find_longest_common_sequence(struct hashmap *map, struct entry **res)
 {
 	struct entry **sequence = xdl_malloc(map->nr * sizeof(struct entry *));
 	int longest = 0, i;
@@ -211,6 +211,9 @@ static struct entry *find_longest_common_sequence(struct hashmap *map)
 	 */
 	int anchor_i = -1;
 
+	if (!sequence)
+		return -1;
+
 	for (entry = map->first; entry; entry = entry->next) {
 		if (!entry->line2 || entry->line2 == NON_UNIQUE)
 			continue;
@@ -230,8 +233,9 @@ static struct entry *find_longest_common_sequence(struct hashmap *map)
 
 	/* No common unique lines were found */
 	if (!longest) {
+		*res = NULL;
 		xdl_free(sequence);
-		return NULL;
+		return 0;
 	}
 
 	/* Iterate starting at the last element, adjusting the "next" members */
@@ -241,8 +245,9 @@ static struct entry *find_longest_common_sequence(struct hashmap *map)
 		entry->previous->next = entry;
 		entry = entry->previous;
 	}
+	*res = entry;
 	xdl_free(sequence);
-	return entry;
+	return 0;
 }
 
 static int match(struct hashmap *map, int line1, int line2)
@@ -358,14 +363,16 @@ static int patience_diff(mmfile_t *file1, mmfile_t *file2,
 		return 0;
 	}
 
-	first = find_longest_common_sequence(&map);
+	result = find_longest_common_sequence(&map, &first);
+	if (result)
+		goto out;
 	if (first)
 		result = walk_common_sequence(&map, first,
 			line1, count1, line2, count2);
 	else
 		result = fall_back_to_classic_diff(&map,
 			line1, count1, line2, count2);
-
+ out:
 	xdl_free(map.entries);
 	return result;
 }
-- 
gitgitgadget

