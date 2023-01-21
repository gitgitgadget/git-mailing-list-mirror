Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4D7C27C76
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 01:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjAUBzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 20:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjAUBzl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 20:55:41 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CD573AF5
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 17:55:32 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q5so1620417wrv.0
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 17:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plAJbCWypx9jd658PaOF7uuhWjzMqMCfFQvg/QJRHHo=;
        b=byUw6WP1l/ACXn+FWDfq2zwbjyvFpl1unsstZ7JC6HESyxS8S8JKlhdAt/LJL+9qai
         5tlR8c7Is1jNvp/vJgthO4PfDZ/nBK0eyinj0RVpN6ezQ55XLfK7WcyrLSRszVNqECDl
         T+X6fu7U2+Yl1y3E0VbJqkXYPz0fNYwzfoRdpVxIte/A7N0CbH4L+bWTKwAEKvfBRUjo
         DSXlWo4DgLipD87SmHTluCowf4WwwDzZfTIDPWbT1+hdx69fXMTdFQ6ozOIXaLMcYD+1
         8iIo1qApxFe6u1iMBH7oABCEKFyjMRHRHeWylIrtccb8Im3s7e0gG453UUaJR6g6ZFqo
         3CTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plAJbCWypx9jd658PaOF7uuhWjzMqMCfFQvg/QJRHHo=;
        b=qAOmYv+y+70QgR0kIJzwOXWuxobufG7akfv2KDic5UEWzY56gOQfGvfhbqH18FAYov
         JQUW7xNC0TlGZrsDcNyEv4RUjoAoCPxyhb4SppcfS11pG0yd/djiOrdxg6LmcV74LQ43
         iNRmgUTCll285BRgzpCk58ZlSPIbmQ8cNVn4tpisaGornp2rcdS73p+9OIZGX2ZvilHG
         CX1O/5BvuarzFGwmNVLuB5m82P330+HWBjy3R13WRE8AkhVZv98iMnmzBtHHIVQBWntt
         R5v7d40VQEpwAYOA0zyA5q0i3JeYa8pp7ADxWdPbKj37wLJvlWEcUWaIWDXw2VJbAbyZ
         r7Yw==
X-Gm-Message-State: AFqh2krastI2MOA6s9s8v/T0Q+F+Z2ct3aoJ+ZTILhzC4PIEAIu7tQc0
        GYWvRYqfTprivC/5AdMGTU53NByDuiM=
X-Google-Smtp-Source: AMrXdXumyqHyI3MpbxM7/YMWH0vB5zdmdzoDJKmoNnkG8xWrKAsz3MCRghi14yQ2HXxxeNRWAuSf8w==
X-Received: by 2002:adf:dd84:0:b0:2be:4fbe:42d5 with SMTP id x4-20020adfdd84000000b002be4fbe42d5mr6065521wrl.5.1674266130711;
        Fri, 20 Jan 2023 17:55:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16-20020a5d50d0000000b002755e301eeasm19164432wrt.100.2023.01.20.17.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 17:55:30 -0800 (PST)
Message-Id: <f4fbfd40d4599542b041081880e89075f4ff792b.1674266126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
References: <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
        <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Jan 2023 01:55:22 +0000
Subject: [PATCH v3 3/7] rebase: remove --allow-empty-message from incompatible
 opts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

--allow-empty-message was turned into a no-op and even documented
as such; the flag is simply ignored.  Since the flag is ignored, it
shouldn't be documented as being incompatible with other flags.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 00d21d7287d..3929535c0cd 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -640,7 +640,6 @@ are incompatible with the following options:
  * --merge
  * --strategy
  * --strategy-option
- * --allow-empty-message
  * --[no-]autosquash
  * --rebase-merges
  * --interactive
-- 
gitgitgadget

