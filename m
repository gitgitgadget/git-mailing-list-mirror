Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AFDC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7898B613CF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237877AbhJDQ7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 12:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237878AbhJDQ7m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 12:59:42 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978F4C061746
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 09:57:52 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id t16-20020a1c7710000000b003049690d882so20216802wmi.5
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0YFH/7O9dujfKmmu6ZRk/KJCH7LOCPzTEaGTMr5K95k=;
        b=dbtWF86oX7UdSpUukdxEKgC1IYhk/Oz5U86Z/GB4z/vTIkAEPlWdiE3vJGrwneEIFE
         Crz532JdtDJZXqzX2hALBjCBHgKuIE/VgbKqJpKWX3FFH0oKH26zW+0/VXs8YGR4+R68
         H3diBCX0C91Dpyjv6nULLJMGagmNuvazy0skeNhAXiX4X2tasZ+6KI2GFQit6aHNKsDD
         4dju8TVZB7Ytks1ehtSYQWkV1J6T0VdLd4XkP0hkNvYbELreZEH3g1TYS6AukMSQedKY
         T1CG1ELIPXpTOuRHoHsDSv/cJ8Z+sNN4pdyMDIB9lRJG6k4aShD/BXhROgReeyITZbbt
         cLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0YFH/7O9dujfKmmu6ZRk/KJCH7LOCPzTEaGTMr5K95k=;
        b=Eojm1A7FW6yQoM4DpoqoduL/0Xa1HKXgiQICxnbMqc72IGtOIY9j/kLUfGWYMOEJUH
         L9jWwBDciHSnRS3XvJwQF/HQyILuvKYH044I5Ei3/QOGJttVmcmrmEU3vydDQq43/+Vk
         9fCeUaknfrIyLENZ9CvE0TX1my60QipKQan9yIG+SfMever0tHVMOCv9UrRDQkJ45PEH
         JXouV581zEupeJ6/vX5qjHroNJfjpYFPK7DQQ8MY6OYrjZ2eK8AMew1z3/sZYkXr0z8I
         ty/DOWty97GPaMJTAkggZ9ik9KlDfx+2rK9mIl4dhqRFjLv+QjB2zSLDaGzFBNixuWjx
         KGpA==
X-Gm-Message-State: AOAM532LjVqfDaup6321CKOvGGou+t4y2h0l5eoeR9nV08PgrHeTpMHc
        mO5EFRgsnonL/EXdZHhest/s1xJrDy4=
X-Google-Smtp-Source: ABdhPJxzblJRs+AEUcIbZYHKdhDyC8O9uB+rHRSSZOhiH0nxYidaq0U4RXy63Qurhk9b+nmJp7M7aw==
X-Received: by 2002:a05:600c:350a:: with SMTP id h10mr19444070wmq.163.1633366671245;
        Mon, 04 Oct 2021 09:57:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o8sm8494727wme.38.2021.10.04.09.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:57:50 -0700 (PDT)
Message-Id: <9335646ed91d3472191b8be233839b3a583c9718.1633366667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
References: <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com>
        <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Oct 2021 16:57:41 +0000
Subject: [PATCH v8 3/9] bulk-checkin: rename 'state' variable and separate
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
        Elijah Newren <newren@gmail.com>,
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

