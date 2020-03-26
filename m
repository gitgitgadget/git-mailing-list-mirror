Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0C0C2D0E8
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11CB2070A
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuJY6+F8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgCZI2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:28:17 -0400
Received: from mail-qv1-f46.google.com ([209.85.219.46]:33623 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgCZI2R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 04:28:17 -0400
Received: by mail-qv1-f46.google.com with SMTP id p19so2506853qve.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 01:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4jymsQpxanrvM7CdWabBQETlbYp4h+uHC9F0qbhN6ag=;
        b=WuJY6+F8IVmCLd5/Ffd7xClODXp12dBbURgKQXiP7Ak2M09AOmfjeijijlq74nM1PB
         TgiqCdHDCNg9sAtqSU3b5kVGmzq2prhcay+8ZdOo0JipZBoYPHpR9NPGIOHoTSEUOnx4
         RSiVa5v7xmIGq1Cvppj/KcpsgCsExXs6OXLoo6L4g2X9LFR1gNZfoUTBJZqFmUWFkTrJ
         zJ6tIfUy0TRF3irkdzc2fQn9KDYyfidP5c70RQH2eQSuCsRjH615CLQ+uQB/x9GnSg/8
         Jt0xTyPivxiQBZh/ZgemnbIGUeQZgT3xI4q5VIB3EAqr+iUzihjC1+VcZmJOX5ZZYRUh
         s1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4jymsQpxanrvM7CdWabBQETlbYp4h+uHC9F0qbhN6ag=;
        b=BjZARNFjNvH8ivK4wtD//aLeB0s6ClhRpVu97IDcF8j7SJQJApvGfG1hfef3V+K31a
         +DQtJWffncWen8d/uqhTbKrTNclzKLZ5pWnai0HpnHaUwz04t7IL5GbmN3h4RE9VZUuL
         v3SPr7uhg9Rpw0SLtaV9SMqEGcST9QYGvg3v/nUKNFWTA3M7wbtRh/esZUyZTPStfKj7
         09Zyjh0RGz+dSQplC6qJPjDcvlFNdsp36QZy5YKEbiYiskC8DzI3yyhLOIQfYNmCDssW
         hiOK9JyekwsUm2Hl6mPeNHpM4/jqVIXyWUYBZcPN+/TDnR+KlU25Rmbo0bxzJmqeAhfy
         qjuQ==
X-Gm-Message-State: ANhLgQ3VmqH67HGZp33w5GbZvokv3JMML4kDensKxNgNo4YLV5GvUv32
        Lp8Xw/r6mnHEd+NHtxKXiE1HKxuq
X-Google-Smtp-Source: ADFU+vuvtniglwUq4Y1sfdjfe4tGBH61XCeZvLJtU3VHrLV86FujIsY/I970ySooE29g5/cveWvPhA==
X-Received: by 2002:ad4:5a05:: with SMTP id ei5mr7106492qvb.127.1585211295959;
        Thu, 26 Mar 2020 01:28:15 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id g187sm935789qkf.115.2020.03.26.01.28.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 01:28:15 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2 1/8] t5512: don't use `test_must_fail test_cmp`
Date:   Thu, 26 Mar 2020 04:27:48 -0400
Message-Id: <3d7dc8428d1992d3bc2802f5c828e8d77fe4de3b.1585209554.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585209554.git.liu.denton@gmail.com>
References: <cover.1585115341.git.liu.denton@gmail.com> <cover.1585209554.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail function should only be used for git commands since
we should assume that external commands work sanely. Since test_cmp() just
wraps an external command, replace `test_must_fail test_cmp` with
`! test_cmp`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5512-ls-remote.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 04b35402c7..08b98f12b8 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -92,7 +92,7 @@ test_expect_success 'use "origin" when no remote specified' '
 
 test_expect_success 'suppress "From <url>" with -q' '
 	git ls-remote -q 2>actual_err &&
-	test_must_fail test_cmp exp_err actual_err
+	! test_cmp exp_err actual_err
 '
 
 test_expect_success 'use branch.<name>.remote if possible' '
-- 
2.26.0.159.g23e2136ad0

