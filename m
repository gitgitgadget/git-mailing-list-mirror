Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCB6C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjEHR2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 13:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbjEHR1z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 13:27:55 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D66E5FE1
        for <git@vger.kernel.org>; Mon,  8 May 2023 10:27:54 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f1950f569eso31899745e9.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683566873; x=1686158873;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/gvh1lMjD+NsQr37NlxiPcoKDYyAgHQXPzj+Wx7ZrE=;
        b=N3A2fMwh/7n2o0CkTxFvEObZa63781RzgBzLK4BkincGpn32lEcWlE3gcAMIUVKZo6
         yY9KxDpTvct6MV5C1MXKy/nDBN1rDfO9q86AAKMZDUnMJcJYfH/fRH2/MtblyDCa4YVb
         f+aChBL1jRwyvQ87be3FcF/wPb7iYAru9v4lXVnZmBLDta59YobFwpqsaH9S/dYn2SF9
         ExAdzGb8hdbRSwTRRsZ8r49XfoU+qvtYuWFWV8+jRlrpzSSFpCD4uxkzQHKqK33KwzW0
         QxNKO0c6XNCPbGJWZIh0KzbBBFeUIbwNzSUZtpMDwflaEIdEE4fQLvvdxAJRdDGfYVD8
         2OEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566873; x=1686158873;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/gvh1lMjD+NsQr37NlxiPcoKDYyAgHQXPzj+Wx7ZrE=;
        b=RWY4DJSs/sML7EmWeU1RiiWyz6fXKvlmYZ5TO338IL1Z6oQ+O/WaoLxazvoEGysS+2
         pxJwws3NNrq9UK9xb4OMtlCK0OLtBMXDu961+WyhzfdkCpgcUlYCeMCgaxvVRVl/dkzS
         inSvf4hmAADBaq2PNuwGiSQkQ+1Xfyx0n026ZLfCnhi7pjClPEMR1M6QJ11OHVQIyoxM
         VPDyEabgwM1uJOFrlEkAPfckzGS8zRZv31Erox3c/ClywLcdbZKIWkCoqrsunXJhL6ow
         orZMgmfS8gp0LCMD3yPQ2SoEH9r+gEmw9vfd0lieYYqnz3hRWeYK1PXx7BWfgvCKge4Y
         xPKw==
X-Gm-Message-State: AC+VfDyE7Slxz7PbUeoW1kF5O9xDSmik/FTnHSV7tv3lfAMNxRgmdz91
        38CCFROcn8tSAlZcqXu5m1f0E5L7xMY=
X-Google-Smtp-Source: ACHHUZ5xEQ+tAnJTabwD8eZp4W+7utgzajS1hyf/Y2BHVzXQHYEn/RYi/9/rzTcfUFxdBDB7wNCDcQ==
X-Received: by 2002:a7b:c8c6:0:b0:3f4:2220:28d5 with SMTP id f6-20020a7bc8c6000000b003f4222028d5mr3998044wml.29.1683566872736;
        Mon, 08 May 2023 10:27:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z22-20020a7bc7d6000000b003f42813b315sm2081804wmk.32.2023.05.08.10.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:27:52 -0700 (PDT)
Message-Id: <b771742443723e74459a998fd3b1d0207165b167.1683566870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 17:27:41 +0000
Subject: [PATCH 02/11] doc: trailer: swap verb order
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

This matches the order already used in the NAME section.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index e695977fbfa..593bc1a1f4e 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Parse or add 'trailer' lines, that look similar to RFC 822 e-mail
+Add or parse 'trailer' lines, that look similar to RFC 822 e-mail
 headers, at the end of the otherwise free-form part of a commit
 message.
 
-- 
gitgitgadget

