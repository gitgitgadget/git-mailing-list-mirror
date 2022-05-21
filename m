Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C03C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 14:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355303AbiEUOtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 10:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354011AbiEUOtO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 10:49:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86216C57E
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r6-20020a1c2b06000000b00396fee5ebc9so5747119wmr.1
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ah9dx3lCIjys14TYDWqaobQW8mneNvKLGgmPl3Bbfok=;
        b=OocSf3QPcPP/D7PcHr0g2hDNC2BoRICwerPWW2zwGK/iGoTZ+89911VhiUcC9IVNv+
         47FmTdF9AI760PePa/KSj4Gr4j31dKXSNRXPhBvR6khHQQ3+E8umFnzvAh8ogE2Mq8Dh
         qRGLyrbgiZzI1QbPsXUE/y7IbMW1bt5ak5wv9Xiwb+t69own8zm503y6qdXnkBVlhTBM
         DlwQXC4xrFZs5rtGLxaU08GN+MKQIZG1CItxONlxLEiM6ZHRrzMfy1uHXa1HNVt453B+
         iK7d88mLqlpeZ45VRD2oAD4Era3rDDYBI5BpX+3hTICKdzBnkhMmVMshjcxP3apY27ij
         iiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ah9dx3lCIjys14TYDWqaobQW8mneNvKLGgmPl3Bbfok=;
        b=Qp9S9dC2yIXCzBxCDsJbLA5gvlYEu0H753r9rFUbwiMM65+UWQS936WSlOmstBu8yO
         2KVJsgwESCeRnuliCyXVEuadMXCeklpU2azlfyaX5hQpdmMhlPjTqVmCTz2a0Ja6mkgR
         pNwe1xuTEDCH0SCu37o+bxnZ2ibkwxFNb9+IjzMp6JCEA7+zvCCXcYLFJtQf+MLpsjl5
         vw6Bo6zdvsEPBX5MFH8tC+YCUok0zNTqF7kqdfKGd8O6lsCvXP3lnjpC3OXaF7UXOHo3
         /D5I5PgM187txST/mZcWKEu16xU8biMNWZAtFRkCqYVpFod0EDk3enLVarMjRCOXME/o
         iWlA==
X-Gm-Message-State: AOAM533ArL1rjH/vgaVkdaXFy3xtRR1mcLS0wGVnO2YZ9nB+Br5rlIle
        Gwqb5QdJCvXVqwch/1HzknOCYkT7zY8=
X-Google-Smtp-Source: ABdhPJxRtqpcCt8lixK/Jyd5hd3F/7Hmsi6SftzrH69sOCfTZrjuAUYEd0Uhyds0lGaxRqRtrPbjjg==
X-Received: by 2002:a1c:7702:0:b0:397:3f81:2168 with SMTP id t2-20020a1c7702000000b003973f812168mr3406257wmi.168.1653144551166;
        Sat, 21 May 2022 07:49:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17-20020a05600c0a1100b003973f4f3cdfsm1996179wmp.6.2022.05.21.07.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 07:49:10 -0700 (PDT)
Message-Id: <955ccd4d8c895ec635b5937bec657c13e5c5e830.1653144546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
References: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
        <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 14:48:53 +0000
Subject: [PATCH v3 02/15] bisect: avoid double-quoting when printing the
 failed command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We already quote the command via `sq_quote_argv()`, no need to enclose
the result in an extraneous pair of single-quotes.

Pointed out by Elijah Newren.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 207479ee9ff..0f49f52ac10 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1221,7 +1221,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 
 		if (res < 0 || 128 <= res) {
 			error(_("bisect run failed: exit code %d from"
-				" '%s' is < 0 or >= 128"), res, command.buf);
+				" %s is < 0 or >= 128"), res, command.buf);
 			break;
 		}
 
-- 
gitgitgadget

