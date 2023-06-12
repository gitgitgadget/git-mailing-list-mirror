Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF92C7EE25
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbjFLMxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbjFLMxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E92CE6E
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30aebe2602fso2807745f8f.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574383; x=1689166383;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2WpL2LnEIDybO0wRqkmHT0eENwkULnxZnfbhvEDvYk=;
        b=n2mRQOGATPKpiuaMfYl9XruwR85sKwmbIMl4Gp4/Lzi1qb5mxgKHIsMkrm4IEBJ8QP
         sT7y0T8v6A4DF59EaTnuoJ+vhlYtc2rfn9dALOAnUQGbmQMdnZlKaZlc7cTv/KO2tzni
         CGYamw27nxCyxvDsBNUvu6OfK12D/iiYoBk85886J0cs1spVTf/TseyIY4U2B7+o7AMi
         k+8BTCganGviF+94cvJ/bVh+V7+4Hnnzvh1zOrdRDgGVrlkxa/YSdmvvgrNx8DZfGHGj
         cbsSC8KOTndYHRTNqq645PAbwVYfLgSw1a7705xmiKb/yPu/ImWdmCaHzoVjg0BjSTsu
         4TKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574383; x=1689166383;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2WpL2LnEIDybO0wRqkmHT0eENwkULnxZnfbhvEDvYk=;
        b=FHZk5sY4CB7Zv7d8osDvLaki850ZhN8jvnHUS1wpcjW/yWn/waQVhLyVC6u4STuPS+
         YkTYH0NsHn3z1uxhSIbY7w14IK2CKYVStEZE7Q0Hihezjs8BMTIyKiTQEuf1syqFmcmN
         7pci8e2UtaO7eyVHHvKNTpmDxPvz7lQW4cJe0y3OMZdIvGgY6PaXAv3kDZh5yQZgw2yF
         TpjEdiHhYBgAmP7TF13sgiRrJQM3I9j744bhGJWgAog0hW/AtjlmecN2WGhOcgcspwkI
         fgdCOyWluUoIQblVGQhOMJV7dHWqq6v8ZK3rCK7XN/uXqGDlW5DWcZwQEKrJuVVzzWn1
         T7YA==
X-Gm-Message-State: AC+VfDyWqH4iJABCtaKyPqABZylS7PqiQcbqwpxN90EajdLlu4Xr+w25
        wHjqsVEFgEoXQhV98Kfq68i8simhtwU=
X-Google-Smtp-Source: ACHHUZ5ndqNiEk+dvwD7JTdrhKAAtg1SvJAz+U+NKUEYMa7lgAaeh9odFnv2LMmHV/LIPBOoB4AX5w==
X-Received: by 2002:a5d:594c:0:b0:30f:c423:bac6 with SMTP id e12-20020a5d594c000000b0030fc423bac6mr1501170wri.53.1686574383323;
        Mon, 12 Jun 2023 05:53:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m11-20020a5d6a0b000000b0030b5d203e7esm12422931wru.97.2023.06.12.05.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:53:02 -0700 (PDT)
Message-Id: <053f9e8620aa369f04eff8f1235eb57d15fe8755.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:37 +0000
Subject: [PATCH v2 09/25] completion: complete --find-renames
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 392fdbedd9f..0fa86dcde6f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1740,7 +1740,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--color-moved --color-moved= --no-color-moved
 			--color-moved-ws= --no-color-moved-ws
 			--full-index --binary --abbrev --diff-filter=
-			--find-copies --find-object
+			--find-copies --find-object --find-renames
 			--find-copies-harder --ignore-cr-at-eol
 			--text --ignore-space-at-eol --ignore-space-change
 			--ignore-all-space --ignore-blank-lines --exit-code
-- 
gitgitgadget

