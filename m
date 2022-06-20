Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F16C433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 12:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242705AbiFTMdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 08:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242772AbiFTMdY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 08:33:24 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA2C13D05
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 05:33:23 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c21so14490414wrb.1
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 05:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gUbCpDN2jTH5+D0bUi+XNXyUq2/eAlfEYKliBR1v7xk=;
        b=Y0/hc2ufSDeAnaNCJY9+ShgEmIKWgFrRob8KOgRv+ml9z5+vY9pBAE1aYE4qr4Ty/D
         YmuCwrZMdfjmnNsaIsAGhohIYsKPmz8GKARY9b2v2+KzIbasoHuFdPq1xLfX895j49vU
         LglO5WIP5re0nMt1jv9flk3TeQr6Idb6MFBxJ+rskP91Rr9oVeLXqiRM5ZUQdDq0C2wg
         nsaE76Td+XBOTB803Kf8pXFVVlYaLhgscvIiWips7upH4nOffc0pGHUTxr+QiiWRFiPD
         mtDpgmHtDVx2kVJ1XUvS2b9szux9mBtwxyRyAAz3SbAK/wXxCKiQSl1tzgqLWVcURvAN
         pkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gUbCpDN2jTH5+D0bUi+XNXyUq2/eAlfEYKliBR1v7xk=;
        b=qIXt6o4CF/RT11F1Hq2nXfDJEgKL0l22GW06aNEJkg35h+Rmg/O/WiKFwiuQaE2961
         6WVE3Mmtq3XmSzIU/T+53O90/HTM2w3WriGL4qVjyiubP+vLD1mUEmY5sXOLxtdq1DE5
         hjUn1tv1/i6yc94yMV2TviVpTxvLxqNHetXX77Yxxu7XoRt4GeFhxxvzOe0gZ0qcWl47
         Gqle1XqSOiHh2pQs28iFZOC29w++e9UZBLqBkmUctJmvkhVBpItCf4phQ5DIC8GMPCmG
         M2tEpqm5KIBrp2WDizl9EdyauyzG9hApmLhHm8Cql8/VS+r74gIvUXC0yP3feJVJUQl5
         frkA==
X-Gm-Message-State: AJIora9iVD7SMjaIuBWivPacDSMwXPZWuIisHfdycCAoCDyGp4ZAhHzY
        pyYUwODlVZx/RpxuVhjTRbAM7x+ExjoXmg==
X-Google-Smtp-Source: AGRyM1vgs8jS1f+7vWFBQ1FiPnUiSek7V3aqgOvQZrf7APOPtobxDJD03dxpQ635auJYrojiAY5+nw==
X-Received: by 2002:a05:6000:18aa:b0:21b:946f:94d8 with SMTP id b10-20020a05600018aa00b0021b946f94d8mr800593wri.259.1655728402661;
        Mon, 20 Jun 2022 05:33:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k20-20020adfc714000000b002103aebe8absm13198064wrg.93.2022.06.20.05.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 05:33:22 -0700 (PDT)
Message-Id: <a404779a30f767f7a05926fb99f354ea7958ab4b.1655728395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Jun 2022 12:33:13 +0000
Subject: [PATCH 5/6] bitmap-commit-table: add tests for the bitmap lookup
 table
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Add tests to check the working of the newly implemented lookup table.

Mentored-by: Taylor Blau <ttaylorr@github.com>
Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 t/t5310-pack-bitmaps.sh       | 14 ++++++++++++++
 t/t5326-multi-pack-bitmaps.sh | 19 +++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index f775fc1ce69..f05d3e6ace7 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -43,6 +43,20 @@ test_expect_success 'full repack creates bitmaps' '
 
 basic_bitmap_tests
 
+test_expect_success 'using lookup table does not affect basic bitmap tests' '
+	test_config pack.writeBitmapLookupTable true &&
+	git repack -adb
+'
+basic_bitmap_tests
+
+test_expect_success 'using lookup table does not let each entries to be parsed one by one' '
+	test_config pack.writeBitmapLookupTable true &&
+	git repack -adb &&
+	git rev-list --test-bitmap HEAD 2>out &&
+	grep "Found bitmap for" out &&
+	! grep "Bitmap v1 test "
+'
+
 test_expect_success 'incremental repack fails when bitmaps are requested' '
 	test_commit more-1 &&
 	test_must_fail git repack -d 2>err &&
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 4fe57414c13..85fbdf5e4bb 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -306,5 +306,24 @@ test_expect_success 'graceful fallback when missing reverse index' '
 		! grep "ignoring extra bitmap file" err
 	)
 '
+test_expect_success 'multi-pack-index write --bitmap writes lookup table if enabled' '
+	rm -fr repo &&
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+		test_commit_bulk 106 &&
+
+		git repack -d &&
+
+		git config pack.writeBitmapLookupTable true &&
+		git multi-pack-index write --bitmap &&
+
+		git rev-list --test-bitmap HEAD 2>out &&
+		grep "Found bitmap for" out &&
+		! grep "Bitmap v1 test "
+
+	)
+'
 
 test_done
-- 
gitgitgadget

