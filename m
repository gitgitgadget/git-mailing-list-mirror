Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3343C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2873208B6
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBHKNf1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgIYRDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIYRDg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 13:03:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8025BC0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:36 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m34so3101210pgl.9
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rZPRjnG2HhpL+Aoyj6iVFR0o0kEbQEV9uOPnjxjKf6I=;
        b=DBHKNf1vcdD2RTtCNZVtL6nT9+HEMbaUvWCTEjv0OS1XhVbAKvv0Yk4gxwqbr84dfV
         osQ0tZC5pkKeNpcH/KCeoJNER810Hrfc8diEnDPi8BXIMwJnSPbF6or8eoX3DanEDrsm
         AQsnccYmP4AiD1Jf+lwbOU5i5DFSVYiskmIlzoWtobcrVSZBnFELSlHBjISht3ZAgEmi
         kxw618EltzEZ2UaiznwGJux0zqMb35N7YSdIOAOe9blqSkxs2UJd78TrzMvp0b7+tWzI
         lqp8l7CTuhSgfUWZIeBkIJdAEFLzvWnrwKKNmBye/OzWULayzBwtZ/UqZIRhKI94Or3I
         4lJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZPRjnG2HhpL+Aoyj6iVFR0o0kEbQEV9uOPnjxjKf6I=;
        b=c37S1zijAMcTTwShQQs4looY3mCy2n9ODfxbDq5mGNtKJwmZ7CYvfZtFneymu7tDx4
         f6UjKMPUgW7/h8OPdqBSOqXSGIebLZXdEClabZA2jMbGEQbvPhpQyb/yLXS5RNHruw1A
         0W/FeW+4Tnlm87PtI1Xb8mTFYIh3tG9kb33xeLKlYu9uSSzKH00NtrjbLDiWdECBXMvc
         BdSKzXWfO35j82Zquymr8JpaLWG3EfPySeG4pvKinaCHpnn/bbimfJqAaw7zB9rBFbaG
         AyFU3B6KupuBwkN5rZwFaxv/EPZ+DtFXlcktbt/pak50FvF1r3NgJz++WajTsi5lDeFV
         WrqQ==
X-Gm-Message-State: AOAM532P+hUv1L6NktHjOvZlJMT+UCQmFnN/k+nRDmNARHn/BA/KKvq/
        lkWj6xWhFc7iSrMvMFEFPz7lkICzoGkZUQ==
X-Google-Smtp-Source: ABdhPJyT7/SLDClMaO/NkOu+sr1mz3iqF9EF+Fm3BvRm7D79AJ2hi4CT598jh1LdGhMmnxjehHYMdw==
X-Received: by 2002:a17:902:8305:b029:d1:cbfc:79b7 with SMTP id bd5-20020a1709028305b02900d1cbfc79b7mr339318plb.33.1601053415744;
        Fri, 25 Sep 2020 10:03:35 -0700 (PDT)
Received: from localhost.localdomain ([47.9.163.48])
        by smtp.gmail.com with ESMTPSA id k27sm2822467pgm.29.2020.09.25.10.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 10:03:34 -0700 (PDT)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Cc:     Shubham Verma <shubhunic@gmail.com>
Subject: [PATCH 09/11] t7001: use here-docs instead of echo
Date:   Fri, 25 Sep 2020 22:32:54 +0530
Message-Id: <20200925170256.11490-10-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925170256.11490-1-shubhunic@gmail.com>
References: <20200925170256.11490-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Shubham Verma <shubhunic@gmail.com>

Change from old style to current style by taking advantage of
here-docs instead of echo commands.

Signed-off-by: shubham verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 94c5b10f8a..30714a8200 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -222,7 +222,10 @@ test_expect_success 'git mv to move multiple sources into a directory' '
 	git add dir/?.txt &&
 	git mv dir/a.txt dir/b.txt other &&
 	git ls-files >actual &&
-	{ echo other/a.txt; echo other/b.txt; } >expect &&
+	cat >expect <<-\EOF &&
+	other/a.txt
+	other/b.txt
+	EOF
 	test_cmp expect actual
 '
 
-- 
2.25.1

