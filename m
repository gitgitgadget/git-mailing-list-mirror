Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1DDC7EE2A
	for <git@archiver.kernel.org>; Mon, 22 May 2023 21:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjEVVsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 May 2023 17:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjEVVsR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2023 17:48:17 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7DB9B
        for <git@vger.kernel.org>; Mon, 22 May 2023 14:48:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561d565cb0aso67617807b3.3
        for <git@vger.kernel.org>; Mon, 22 May 2023 14:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684792094; x=1687384094;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZUYYQQ1BpRMoDUQ1kAi/oHnQvlgf9G9N53iDWEzsXk=;
        b=fKdJ/BILedtPqbgiNtqLRIfh1D5PGepdhZdW3Q+19lf7cVntruy+JFk1wIKoGoKATZ
         ndU+NGRsuLaWLHjSvW2HAOcC/UGiWeo24POVzaohVRhGtCsVXcdUNarE3GRF0egXC6n+
         bGoqhGdLAAOsmSn4NozKTj0sNIed8vPBziiDHT90HVh8vvfxg5xaNDbCPK5TIcwbNjme
         JgpnLfQfcAFDzxxg0IDShPf/1rw9Kur6sfdGLgzCgGvc6SWzR+gKkSw6A6Pt26foldTx
         PfKvCF0o1SQNQvgF0lkybBW3YMuttQSPgknwRgmI4ib7IssStaksx1I6uCaEX9ezHVqg
         Rq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684792094; x=1687384094;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZUYYQQ1BpRMoDUQ1kAi/oHnQvlgf9G9N53iDWEzsXk=;
        b=RKdfMN0sgSTLqXqeu4COYs1bO2qs1M6tigRoMPPYLQtwmch2RxniPpOzi1h4zYYoFB
         OHHa6TpkgfBY9LYbz+xxkRQywuN3FhtFbNw4nVxtlbDfwbzx68Ukqx8Jokx+ClZUGqWO
         Gh/y3U2dLIkCICUn19x60ZNX8kxIEQn5aI5rDQaBrnB+onJGvOsC6DidLPhSlwPsu/DF
         Z0UjEp7+Nih4BNc1tnrKJQ9ieA0tLVfuSx8IbAl27ATL546OukfXM/dsjIlMxzLANque
         Mb1EZbfqovnewd490106kQ6GtJ3slppo/jTbzi1wc+J/tskDXlIHudvHBELQNhT1UY19
         8X8g==
X-Gm-Message-State: AC+VfDxy3Dvq4s6vp6OEdvAaRLp/kvQBevMX2DC1Tz7ik1aGSPUARC5S
        /O0L/AHBc0AyVd/yIDTJhqeeMzyOvGZOX8Nzp+wKhUd7TBjazz3eLR8OuKLWAbASW5MuyoRjW9b
        Se4LRmLb0Ddtc2dU7LsbrfRt2bRRQdc33DhAOwA4fHWSYvyWqNDin6V9bgFLNHwDHJ8Wi+fJ00S
        QL
X-Google-Smtp-Source: ACHHUZ46CR1rMXyuVH5gSKQef3Fckk86YwOyq2IMXOQKOww6t+0+n+9xpk6wlhlnMmZYTecTeXMFWZCT6cYGi+Oekvis
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:e715:4b4d:d1be:8ec0])
 (user=jonathantanmy job=sendgmr) by 2002:a81:ad48:0:b0:55d:d5b1:c2bd with
 SMTP id l8-20020a81ad48000000b0055dd5b1c2bdmr7657779ywk.8.1684792094368; Mon,
 22 May 2023 14:48:14 -0700 (PDT)
Date:   Mon, 22 May 2023 14:48:06 -0700
In-Reply-To: <cover.1684790529.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <2e154c9088e83fa9433ebe3e9ddf99dc30155d94.1684790529.git.jonathantanmy@google.com>
Subject: [PATCH 1/2] t4216: test wrong bloom filter version rejection
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test that checks that Git does not make use of changed path
filters that have an unrecognized version.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t4216-log-bloom.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index fa9d32facf..f14cc1c1f1 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -85,6 +85,36 @@ test_bloom_filters_not_used () {
 	test_cmp log_wo_bloom log_w_bloom
 }
 
+get_bdat_offset () {
+	perl -0777 -ne \
+		'print unpack("N", "$1") if /BDAT\0\0\0\0(....)/ or exit 1' \
+		.git/objects/info/commit-graph
+}
+
+test_expect_success 'incompatible bloom filter versions are not used' '
+	cp .git/objects/info/commit-graph old-commit-graph &&
+	test_when_finished "mv old-commit-graph .git/objects/info/commit-graph" &&
+
+	BDAT_OFFSET=$(get_bdat_offset) &&
+
+	# Write an arbitrary number to the least significant byte of the
+	# version field in the BDAT chunk
+	cat old-commit-graph >new-commit-graph &&
+	printf "\aa" |
+		dd of=new-commit-graph bs=1 count=1 \
+			seek=$((BDAT_OFFSET + 3)) conv=notrunc &&
+	mv new-commit-graph .git/objects/info/commit-graph &&
+	test_bloom_filters_not_used "-- A" &&
+
+	# But the correct version number works
+	cat old-commit-graph >new-commit-graph &&
+	printf "\01" |
+		dd of=new-commit-graph bs=1 count=1 \
+			seek=$((BDAT_OFFSET + 3)) conv=notrunc &&
+	mv new-commit-graph .git/objects/info/commit-graph &&
+	test_bloom_filters_used "-- A"
+'
+
 for path in A A/B A/B/C A/file1 A/B/file2 A/B/C/file3 file4 file5 file5_renamed file_to_be_deleted
 do
 	for option in "" \
-- 
2.40.1.698.g37aff9b760-goog

