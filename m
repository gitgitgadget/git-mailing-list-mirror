Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27184C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 01:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E583164E31
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 01:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhBWBLl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 20:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhBWBLb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 20:11:31 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77129C061786
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 17:10:51 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id r24so1902373qtt.8
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 17:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AV30jvg19iiOQp5i8GIiqK0WZIwnIM0Qoe0MlTFkSmk=;
        b=VH+di2mWMX1HoEDsTEHGfEq/RxAed47nOqXq58RtNrroifLFzOmJsyxsM6+kqfRNJ4
         GfyUTtNM9jTzVWjMzLzURGNvQBANJWIa5Cv3A7J5N98VhP2/myEFEoxKUr9dEKuouOF+
         HPlvVuIRKYUDNsrcHoSq+DOV3EAvK0oXxYTjysyavZV8SdVjlnTPcJE4ANxs3mmNVU8p
         e14gDSgu/n76docYz6S9P4oHFVvY7hccvgXjb6yzjto42XgBReD7sWYPtu4xUr0QTKDY
         wzIM0I6z0TRfntTQhj/4vAFvHHHpsiMWvxQfw1U7/+wvdglNPhx8KAZ1qvXVHQrNCsVQ
         sr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AV30jvg19iiOQp5i8GIiqK0WZIwnIM0Qoe0MlTFkSmk=;
        b=nHR62fgoWxVkbJExWdrd77ds4tdHu5A+JvQdp0aNhuz24+ZRYsx5+9n2d+AIHUnmtK
         HSUK/QmjKcM/EAztrhzD0Ro6VweEf4DafAWKFuB6swFZ3JCJolt6Zt0uNsTFpJ5Y/XZM
         0Nxz0hvMgZIWZydw3PMIBI8QJwv4T/u8OM5j0Xve8ooE5FXj99Ot8PE5/O9s7iibX6O/
         ipjsK6kM8I4gbetrfiIjKwt5UrrMbchpKWHJmieIMyiZdl4/niNZ6BUQ4Vm3ntfRh7gz
         YD8TuuimTxYf+ci3zj2xFll0mIVgWZq1dwxIAUNfhtBUpDWF9N0OCmz0o2LP7oU9Cdc+
         nwPg==
X-Gm-Message-State: AOAM5327IG+xTGffqDe9mtHH1P7hP4smF1Xjs/MCx6YUXCo3iU4nSOyC
        iZ8Zy084d1bCFs7AjKzo9GpKCsTlrQ1h+A==
X-Google-Smtp-Source: ABdhPJxwpD82dmEBqfNQ7iQbdhaX3XyTTlV6OHEztg2VnDTxNy7bWVz29EYTu1SShlRETFWm767auA==
X-Received: by 2002:ac8:74d2:: with SMTP id j18mr7143662qtr.28.1614042650323;
        Mon, 22 Feb 2021 17:10:50 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id v75sm13599070qkb.14.2021.02.22.17.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 17:10:49 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com
Subject: [PATCH 2/3] add: mark --chmod error string for translation
Date:   Mon, 22 Feb 2021 22:10:34 -0300
Message-Id: <b65d3a1c3771617caea175830409a103f45e9c73.1614037664.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1614037664.git.matheus.bernardino@usp.br>
References: <cover.1614037664.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This error message is intended for humans, so mark it for translation.
Also use error() instead of fprintf(stderr, ...), to make the
corresponding line a bit cleaner, and to display the "error:" prefix,
which helps classifying the nature/severity of the message.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/add.c  | 2 +-
 t/t3700-add.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 1e33ab81f2..0c5f53c0bb 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -55,7 +55,7 @@ static void chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 			err = S_ISREG(ce->ce_mode) ? 0 : -1;
 
 		if (err < 0)
-			fprintf(stderr, "cannot chmod %cx '%s'\n", flip, ce->name);
+			error(_("cannot chmod %cx '%s'"), flip, ce->name);
 	}
 }
 
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index fc81f2ef00..6a8b94a4f7 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -398,7 +398,7 @@ test_expect_success 'git add --chmod --dry-run reports error for non regular fil
 	git reset --hard &&
 	test_ln_s_add foo foo4 &&
 	git add --chmod=+x --dry-run foo4 2>stderr &&
-	grep "cannot chmod +x .foo4." stderr
+	test_i18ngrep "cannot chmod +x .foo4." stderr
 '
 
 test_expect_success 'git add --chmod --dry-run reports error for unmatched pathspec' '
-- 
2.30.1

