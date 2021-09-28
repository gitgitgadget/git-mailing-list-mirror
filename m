Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED689C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD67613A5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243276AbhI1Xeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243249AbhI1Xeg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 19:34:36 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ACAC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 16:32:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s21so1094934wra.7
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 16:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0YFH/7O9dujfKmmu6ZRk/KJCH7LOCPzTEaGTMr5K95k=;
        b=aWCZ1T65XqMImHd5TfY2pNbp/BJL8DrinLcRkn3g+hHl/8ZbFVpiyLtG05uULVKSD1
         y7Z7gD16oR8xMPRCTFYUszre2ZnlHR6howvGcFsiLpa7mfW2ADrqV4soZ3UJgbJmknI4
         eW+3cVZ4H3wcsSa5yhCEkIIH+XEKmmsmr8eMsOHDJyMPpL2ySFzHRNMcHVpsx/RLdCqn
         6UgmlQV3gKUpLZonlzmVsOx8SlDx22Ea20XPWYbWZxTov4rYjnBR+A6IaK7/48vhWlDw
         RW/51pydDf+XlPf0iGIRHhhVjj61hm4Ha6UUILoD/D4a6/FW97al7Gk/N07k3ULFFra2
         eNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0YFH/7O9dujfKmmu6ZRk/KJCH7LOCPzTEaGTMr5K95k=;
        b=rFeUUriHyWx4Fn/YBjWnfboMLMakw1MZK9Yidv+XbK8MUcOTbkCVmyNVLc2vvQ5qBS
         a1yKZelVd13LYQTBQqHfXe3szNi+mq3ftQzsQYIpB+hBxJOh6F7WkvTEMvMXNbU8RpBU
         kHN5xQUgFca9Jg6ZeRFdxpQ30tsGuqPrhBKQyqJpbWA6u523NxD0Xqg/8/6kMj9BAkRO
         RjdQ0hrc8p3BTLAX3puvuLxKpEUlHYOcxR3Vm0i7uxuru0v/lVcYEx3tiCaYN7S/5cEZ
         9RkKeXU3Rk0V8V2p44BblKSl20RgI+XIgLm/DBhaFIAPDU2k3I4Jzrz3lfMSqyQQctFV
         AvTQ==
X-Gm-Message-State: AOAM533cLCKU3Ak0vY76q+41e8ogI5Ixd8vUF4JrLcUqymkuRclMegcJ
        nWuXtSADYOXeBaCFWFc7GKBnTU1vmlw=
X-Google-Smtp-Source: ABdhPJz1z7vFPay/gLgXpi/cIYzrYKpBX4UXVhJayCE0+jdlDnSbUAL5Y1xIg8MZQzwCN4VzNwdGqw==
X-Received: by 2002:a5d:61c1:: with SMTP id q1mr3140536wrv.154.1632871974559;
        Tue, 28 Sep 2021 16:32:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r27sm460163wrr.70.2021.09.28.16.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:32:54 -0700 (PDT)
Message-Id: <c272f8776fa26a1f52e04e45886643bbce3246bc.1632871972.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com>
References: <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
        <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Sep 2021 23:32:45 +0000
Subject: [PATCH v7 3/9] bulk-checkin: rename 'state' variable and separate
 'plugged' boolean
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Preparation for adding bulk-fsync to the bulk-checkin.c infrastructure.

* Rename 'state' variable to 'bulk_checkin_state', since we will later
  be adding 'bulk_fsync_state'.  This also makes the variable easier to
  find in the debugger, since the name is more unique.

* Move the 'plugged' data member of 'bulk_checkin_state' into a separate
  static variable. Doing this avoids resetting the variable in
  finish_bulk_checkin when zeroing the 'bulk_checkin_state'. As-is, we
  seem to unintentionally disable the plugging functionality the first
  time a new packfile must be created due to packfile size limits. While
  disabling the plugging state only results in suboptimal behavior for
  the current code, it would be fatal for the bulk-fsync functionality
  later in this patch series.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 bulk-checkin.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 8785b2ac806..6ae18401e04 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -10,9 +10,9 @@
 #include "packfile.h"
 #include "object-store.h"
 
-static struct bulk_checkin_state {
-	unsigned plugged:1;
+static int bulk_checkin_plugged;
 
+static struct bulk_checkin_state {
 	char *pack_tmp_name;
 	struct hashfile *f;
 	off_t offset;
@@ -21,7 +21,7 @@ static struct bulk_checkin_state {
 	struct pack_idx_entry **written;
 	uint32_t alloc_written;
 	uint32_t nr_written;
-} state;
+} bulk_checkin_state;
 
 static void finish_tmp_packfile(struct strbuf *basename,
 				const char *pack_tmp_name,
@@ -277,21 +277,23 @@ int index_bulk_checkin(struct object_id *oid,
 		       int fd, size_t size, enum object_type type,
 		       const char *path, unsigned flags)
 {
-	int status = deflate_to_pack(&state, oid, fd, size, type,
+	int status = deflate_to_pack(&bulk_checkin_state, oid, fd, size, type,
 				     path, flags);
-	if (!state.plugged)
-		finish_bulk_checkin(&state);
+	if (!bulk_checkin_plugged)
+		finish_bulk_checkin(&bulk_checkin_state);
 	return status;
 }
 
 void plug_bulk_checkin(void)
 {
-	state.plugged = 1;
+	assert(!bulk_checkin_plugged);
+	bulk_checkin_plugged = 1;
 }
 
 void unplug_bulk_checkin(void)
 {
-	state.plugged = 0;
-	if (state.f)
-		finish_bulk_checkin(&state);
+	assert(bulk_checkin_plugged);
+	bulk_checkin_plugged = 0;
+	if (bulk_checkin_state.f)
+		finish_bulk_checkin(&bulk_checkin_state);
 }
-- 
gitgitgadget

