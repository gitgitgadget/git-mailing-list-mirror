Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D2FC433F5
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 21:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343768AbiCTV43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 17:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343756AbiCTV4V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 17:56:21 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A1D10FD0
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 14:54:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a1so17078718wrh.10
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 14:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MeEzhbEHtTaBVg6MOBhhPaE+R0IoY5wZDi9UCIaHSQg=;
        b=BnpY1MW4KV+eXLfuJbbTZC7ZLp/QVq5rNPJ5cTHLCzZnkgj0cy0ivYoipsNX6l+76p
         DVASZPPqV1RLy2npxdVzu7I0ANoKMBEBAeEq/tMv0fsb59AVkZyRqXJ7HwBOlNPqdJP/
         63+AptJGMcAkhyb+p+10MequVZAO6jZWDdCMxe4AMbVfKAtByGMNIekrn1pvtSdgatol
         0eFGkMmvXKYLI/ZAW+9AEWPgzFGX1ijX9x5939uEOeC3BNZ6YJppeYAtOE8yBiCdS5SF
         9EKdWC6gYNnZWBPNFjbNVn9xpNURtJfVmF1Jzg0dVEoHFDusX0zwhuYN5K8FJM+xqyM3
         Q/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MeEzhbEHtTaBVg6MOBhhPaE+R0IoY5wZDi9UCIaHSQg=;
        b=aW15btN5fDD9HrDyglVJko8chyl6HLQtGCvWAD/S3iSY3Y3668IP13r+fU5KLetn4f
         g39KkDvDjvAvAiJlyIVgNSYEPciRdyZqe6ISL6kXn3OTFN/RCMtG4qulz2bx7xaoMYTZ
         l/KYu7opxjpJ6mN5GZKBOmF/9eGMR5exxHSd5jmknbECt6cc90OfParxhetpt75omflX
         /YHfbbBLkLqRqgSuIfbs55HA25YrgEwMjV2zORLzeUn3A6AzPTbtIEkf28ST8QyjNKWK
         LWBr6xSL1JjHZqhTQvvCV40z34lVGzICsj3JjUDPabzOcWuQzJd7CJsf1Z3r0KrYX1dA
         dUyw==
X-Gm-Message-State: AOAM531KEOlrVCsg7EW7NA2g4HmKy8Di+rAAhcDBixlUDvjGHBNjLdhF
        rdr+0J6OCXQ1maPzi3xBZTPT+jmVfIA=
X-Google-Smtp-Source: ABdhPJw+XToKUF4kbXfuvUmu8c4tCJZmNDcjiFQ88AOx4NwhO+HfYgZrIbplRPbXG/1llkINVbKcqA==
X-Received: by 2002:a05:6000:1d8b:b0:203:df82:ff8d with SMTP id bk11-20020a0560001d8b00b00203df82ff8dmr15900768wrb.623.1647813295720;
        Sun, 20 Mar 2022 14:54:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k35-20020a05600c1ca300b0038ca38626c0sm2039844wms.16.2022.03.20.14.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 14:54:55 -0700 (PDT)
Message-Id: <8bdbb32f54421f99be55493257b31b203a11f202.1647813292.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
From:   "Bagas Sanjaya via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Mar 2022 21:54:46 +0000
Subject: [PATCH 2/7] sequencer: factor GIT_AUTHOR_* from message strings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Bagas Sanjaya <bagasdotme@gmail.com>

Factor messages containing GIT_AUTHOR_* variable.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 sequencer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 84eed9e96bc..647f5efa656 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -848,17 +848,17 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 	for (i = 0; i < kv.nr; i++) {
 		if (!strcmp(kv.items[i].string, "GIT_AUTHOR_NAME")) {
 			if (name_i != -2)
-				name_i = error(_("'GIT_AUTHOR_NAME' already given"));
+				name_i = error(_("'%s' already given"), "GIT_AUTHOR_NAME");
 			else
 				name_i = i;
 		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_EMAIL")) {
 			if (email_i != -2)
-				email_i = error(_("'GIT_AUTHOR_EMAIL' already given"));
+				email_i = error(_("'%s' already given"), "GIT_AUTHOR_EMAIL");
 			else
 				email_i = i;
 		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_DATE")) {
 			if (date_i != -2)
-				date_i = error(_("'GIT_AUTHOR_DATE' already given"));
+				date_i = error(_("'%s' already given"), "GIT_AUTHOR_DATE");
 			else
 				date_i = i;
 		} else {
@@ -867,11 +867,11 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 		}
 	}
 	if (name_i == -2)
-		error(_("missing 'GIT_AUTHOR_NAME'"));
+		error(_("missing '%s'"), "GIT_AUTHOR_NAME");
 	if (email_i == -2)
-		error(_("missing 'GIT_AUTHOR_EMAIL'"));
+		error(_("missing '%s'"), "GIT_AUTHOR_EMAIL");
 	if (date_i == -2)
-		error(_("missing 'GIT_AUTHOR_DATE'"));
+		error(_("missing '%s'"), "GIT_AUTHOR_DATE");
 	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
 		goto finish;
 	*name = kv.items[name_i].util;
-- 
gitgitgadget

