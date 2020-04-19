Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17DDC38A30
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 11:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFBD92223D
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 11:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uDPenPEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgDSLA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 07:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725964AbgDSLAz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Apr 2020 07:00:55 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80FCC061A0F
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 04:00:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b8so3491890pfp.8
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 04:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2VUP80jFzAnCg9aWY0sUi+iE1GIn/o4YKWuenijr2sg=;
        b=uDPenPEseGIahn0rI6KfxVuvN3n4fwBt/1eJZDeoDwVAqh9+CuFBPbo/Ep69C2dgh9
         /ZW2h5ou3klFqAt5xFF7oIXBqutWQp0LdQYmSe+o0RstR0zmRCNgNBGeqT1IEsJRNquo
         LqDYNgxKYNmucKrEFYjxjfLYexTQcnvBadRrKy0Ms/p5a9YYG4SQ8ckIJ2Smq1SQZ4If
         1MwhLx5sYchmtK7hR/ATwbRFhnh48ryELgT6NqTVKS7BE0iavbMf1CJqmAkLDSYIMZBU
         E7xPcSGSVex+gVDQdJiMu6SyEf7WZCg4Kr8/4e9Ht2KsucdCiq25BaVtQ/GZeQaOCYX5
         /GkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2VUP80jFzAnCg9aWY0sUi+iE1GIn/o4YKWuenijr2sg=;
        b=piHpqU3FaD9CcbA/pbpbR6C99U28QHdbA3uMkHQDpdFWzNcPU6/YAHp4eNk7YRgjUH
         PvAl/MxO6s585GtjeesWmZin4Pt22Hiq/kGqFkzI/BE3GyMPZUAJrcDpDgF+zzlbIulq
         AGNSUEs20i3L07jHgLGNfsBIzMEMbfBMHxDHUvBTZaGsHFG6FpUgLnKYE3TSW/jd6uS7
         /AyKmGSd22j49eUP0jF4T+lQl6p7QHzhTHIbyGoItx+ECiaZZ8t6tvjWFrzLUXYcNx4K
         zDOneU6IgUB3C2KE7pvAvYFHtztSduuTp0WDyAL4ESw8JB0H0xNM7ain6EL/0/PQ/x4R
         4d7w==
X-Gm-Message-State: AGi0PuYvtmW4GIbHMBHr161p1cmNDxefGpwP5TQRS2aIRrakhLLGT/jx
        TPqo9udhWWUyK51bRMWE+oLeAN6/
X-Google-Smtp-Source: APiQypJEniIe+sR8ocfYla2CgsWAMcnhqJvMqYCFNxZVI1BxyLWYav5mD+SJQOovq/gJuWz8Gth1bw==
X-Received: by 2002:a63:2c07:: with SMTP id s7mr11203413pgs.230.1587294054338;
        Sun, 19 Apr 2020 04:00:54 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:5380:b9e1:93e1:68db:b9f6])
        by smtp.gmail.com with ESMTPSA id b20sm361692pff.8.2020.04.19.04.00.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 04:00:53 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 3/3] mailinfo: disallow NUL character in mail's header
Date:   Sun, 19 Apr 2020 18:00:42 +0700
Message-Id: <cb96947b36b8ab314f5692daee6f627273ca66d3.1587289680.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb
In-Reply-To: <cover.1587289680.git.congdanhqx@gmail.com>
References: <20200418035449.9450-1-congdanhqx@gmail.com> <cover.1587289680.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 mailinfo.c            | 5 +++++
 t/t4254-am-corrupt.sh | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/mailinfo.c b/mailinfo.c
index 0e9911df6d..c31991e621 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1138,6 +1138,11 @@ static void handle_info(struct mailinfo *mi)
 		else
 			continue;
 
+		if (memchr(hdr->buf, '\0', hdr->len)) {
+			error("a NUL byte in %s is not allowed.", header[i]);
+			mi->input_error = -1;
+		}
+
 		if (!strcmp(header[i], "Subject")) {
 			if (!mi->keep_subject) {
 				cleanup_subject(mi, hdr);
diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index 98cda32d0a..d9d1ac6c7d 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -69,9 +69,11 @@ test_expect_success "NUL in commit message's body" '
 	grep "a NUL byte in commit log message not allowed" err
 '
 
-test_expect_failure "NUL in commit message's header" '
+test_expect_success "NUL in commit message's header" '
 	test_when_finished "git am --abort" &&
 	write_nul_patch subject >subject.patch &&
+	test_must_fail git mailinfo msg patch <subject.patch 2>err &&
+	grep "a NUL byte in Subject is not allowed" err &&
 	test_must_fail git am subject.patch 2>err &&
 	grep "a NUL byte in Subject is not allowed" err
 '
-- 
2.26.1.301.g55bc3eb7cb

