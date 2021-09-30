Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E286C433FE
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 17:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 425C561216
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 17:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352483AbhI3RDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 13:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352475AbhI3RDf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 13:03:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BACC061776
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 10:01:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ce20-20020a17090aff1400b0019f13f6a749so6975167pjb.4
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A5Xel3ExkB+C0/nXPTgnGFF1CIQPY7WoHSwf2uT/Bsc=;
        b=VsdadnbRLWJv8gxVVO98uW1y8sSINbsJ+k9Vtt02oB8VWGZho6mvP36+5/xxpgnKNe
         bvlrDDbrg/DBpMFZmzBneCSljmru2E1IHxm8ihIC2xnx5IFBwzF0HouhHS5MTS/68JWE
         tCe0aBlU0+RRX2NQnYxHzNTHC2sM/Qu824k6oaHpjCV/iujCigkzseS1y4bu/2hj9Dvv
         59LlI6TMENGcMSNW9pe+ezxzECabNJ68atMzFV+lyr78mgngF26um3gRzRP5pFg0cwIe
         E7gPgd4scvmlKIkROZdR3Ipscr3MHlTyA0kJr9k2WLLEc8FCBrxyM7B0suiuwnDbr6pv
         2jmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5Xel3ExkB+C0/nXPTgnGFF1CIQPY7WoHSwf2uT/Bsc=;
        b=zrtqokFgCqrqrvr7AvzcRfLBH7H5bQLsSkjwyIDFy67qA4eO2sM1w92eg3v8kiXUbc
         HDIStV02Tq2vlMvjTB/GqAW2tV6m5zBESYO966J4zDznekDVWK7KVy0/bDbpT7okhyl+
         Z27Sy4NwecDeE9m81gN5A6BG/DeGhHaXHHphcOSE6aImON+HqH9jHU5uZOSCvxqC8zOi
         r3XfmgKb7ZT2sTP8VkfXMBFmoQeFzRggBDVALVQvqc7XBola8zJho+kXf5F5+jW86f7R
         r+9Auu9xGLxr5FdJuhg0h9FKFnhxGgNaLuiHs4TXkE6rqYWWEAXgF/zPxyOJhNpHUtBU
         ulIQ==
X-Gm-Message-State: AOAM532GjSHW0QgG690jT3YvjzLgiFV8m0cfIlaskKu6s2W3YpbjhxKT
        bTqi0ixkAXdvYA9qH99KckSD+PVTcrE=
X-Google-Smtp-Source: ABdhPJxNDMzZXf3khdtotj3LFtLtH6Qktrpa+26+2pkP+b7wn2LTY+z+tnMBsk8o79pRhRRFZwtu9w==
X-Received: by 2002:a17:90a:8413:: with SMTP id j19mr7637884pjn.181.1633021311603;
        Thu, 30 Sep 2021 10:01:51 -0700 (PDT)
Received: from sarawiggum.fas.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id p4sm2740678pjo.0.2021.09.30.10.01.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Sep 2021 10:01:51 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 2/5] difftool: add a missing space to the run_dir_diff() comments
Date:   Thu, 30 Sep 2021 10:01:43 -0700
Message-Id: <20210930170146.61489-2-davvid@gmail.com>
X-Mailer: git-send-email 2.33.0.887.g8db6ae3373
In-Reply-To: <20210930170146.61489-1-davvid@gmail.com>
References: <20210930170146.61489-1-davvid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Trivial tweak. Unchanged but resubmitted for ease of application.

 builtin/difftool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 9d2dfd3361..fdaaa86bff 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -542,7 +542,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	}
 
 	/*
-	 * Symbolic links require special treatment.The standard "git diff"
+	 * Symbolic links require special treatment. The standard "git diff"
 	 * shows only the link itself, not the contents of the link target.
 	 * This loop replicates that behavior.
 	 */
-- 
2.33.0.887.g8db6ae3373

