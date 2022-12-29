Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D221CC4332F
	for <git@archiver.kernel.org>; Thu, 29 Dec 2022 17:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbiL2RSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 12:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiL2RSt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 12:18:49 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF6A32F
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 09:18:48 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bx10so17951021wrb.0
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 09:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsnI4flAK2RLrkg2MPgWVQ4E8WD10zyUZULF0rT6uqc=;
        b=E2BmiGj9BlAfblKKYR0QyRf45iliX2cysRYvthUeAZkigR+euy0rsDfCkvlZcI3f3A
         HcgAUO62iB7etiD7l6z4sj65zm2xFnBfiLixHwYJnlFfDms8Ow5cJpvkLOcc4JA7W136
         i2TnRzfZWd6Ibs945Xii9xGVVmPpA4nGDNkkRQd/DjvxCX3RWDtjhHN8v2WLximp6j7A
         YiAJxoQBRmnvG+ZcvH1mDHePYkyhqmhu47fjizrKyfLl1UCuQTPLpzU/jOZ4yypZGmOV
         PAyeCXgrCSi28yXbScDWUqhFubqGNXJ2h+7GH0p05ngFXBTgB/HovDcfprNlXRMSNVa5
         y/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsnI4flAK2RLrkg2MPgWVQ4E8WD10zyUZULF0rT6uqc=;
        b=EoQC07/PwI6CECcS/fK6gbLA08uW4Wts+IrPIc72VloWN/JtZjvrdQeyeEYtMAULpj
         XydtzsVBVZTeAxYOTIDbh+UnxPMuH5/b6VBVThtMVInazoUIVktfMmrsLS3brHdQzee7
         9JEDa1p/BuUjpNcfHbhdBE7sbFDc2LDxN6//D02SgyiQTjR3F41NIE28MXl6AY8XupzN
         rE0386XETlM5ZW5VNJbTMMrZSgJJBPLej2jEMTG6Z9ur35GwqJniScRCXfgqfzwaurz7
         J+Ihd3RYcqXkYraRJ/Liu7nZ3wJ/QLT2PvblmeKGe21nVEoQdW76t5k+urN6CSw13Pu6
         jxTw==
X-Gm-Message-State: AFqh2kqd2Rx0cgQp3S9tmpVOPW4UnnHNM6vS6YL1pFhDS+JjZRE61js8
        VcFGr4lHZiLXYQFbfeurtp0Fmzve6/c=
X-Google-Smtp-Source: AMrXdXtTGFYCDb4IBJPwRzsVcPE8hSUdmPcH1I2KnFrgIuJ/7/oBrrCcUeTfAFvLXzLlvBUQrfJeeg==
X-Received: by 2002:adf:f785:0:b0:274:c45:5c3c with SMTP id q5-20020adff785000000b002740c455c3cmr13442497wrp.46.1672334315436;
        Thu, 29 Dec 2022 09:18:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16-20020a056000005000b002258235bda3sm18645309wrx.61.2022.12.29.09.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 09:18:35 -0800 (PST)
Message-Id: <pull.1418.v2.git.git.1672334314401.gitgitgadget@gmail.com>
In-Reply-To: <pull.1418.git.git.1672333122193.gitgitgadget@gmail.com>
References: <pull.1418.git.git.1672333122193.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Dec 2022 17:18:34 +0000
Subject: [PATCH v2] grep: simplify is_empty_line
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    grep: simplify is_empty_line
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1418%2FAtariDreams%2FisEmpty-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1418/AtariDreams/isEmpty-v2
Pull-Request: https://github.com/git/git/pull/1418

Range-diff vs v1:

 1:  03a97005a67 ! 1:  b193c9537de grep: simplify is_empty_line
     @@ grep.c: static int fill_textconv_grep(struct repository *r,
       static int is_empty_line(const char *bol, const char *eol)
       {
      -	while (bol < eol && isspace(*bol))
     --		bol++;
     --	return bol == eol;
     -+	while (bol < eol)
     ++	while (bol < eol) {
      +		if (!isspace(*bol))
      +			return 0;
     + 		bol++;
     +-	return bol == eol;
     ++	}
      +	return 1;
       }
       


 grep.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 06eed694936..d78ee08da6f 100644
--- a/grep.c
+++ b/grep.c
@@ -1483,9 +1483,12 @@ static int fill_textconv_grep(struct repository *r,
 
 static int is_empty_line(const char *bol, const char *eol)
 {
-	while (bol < eol && isspace(*bol))
+	while (bol < eol) {
+		if (!isspace(*bol))
+			return 0;
 		bol++;
-	return bol == eol;
+	}
+	return 1;
 }
 
 static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int collect_hits)

base-commit: 6bae53b138a1f38d8887f6b46d17661357a1468b
-- 
gitgitgadget
