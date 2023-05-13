Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C6AC77B7C
	for <git@archiver.kernel.org>; Sat, 13 May 2023 09:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbjEMJaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 May 2023 05:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjEMJaH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2023 05:30:07 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119E610D9
        for <git@vger.kernel.org>; Sat, 13 May 2023 02:30:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30786c87cdaso8129307f8f.2
        for <git@vger.kernel.org>; Sat, 13 May 2023 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683970204; x=1686562204;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Is++gNE3nkGcxknP6d0sQEnXdTlnG8ED0bAigj61VA=;
        b=I6E0w2zYYp3SpIIzQ6LLkHLBY5z/XxzZRiD+l/nk/EtLCVrY9QNW6dKzs3gP4RFzMG
         oRXk8idaeTLYmJ3fbfquYXIELeHb1a4AunZO3vtohAssw64cxz2DrOnI7dDVmE/9EDK1
         fZJSR6LuPYOjCT9Hx9B+kkA06oCMP6A3ROlkxMnZUkWOcbTgf+e0BGmOfh2umYHPBGQA
         Ui9aG/BiC+Pnejag2arw+Qy2I5fuj5iDVdqBo+j75vnJNDKwbWBroA9zfmFSn2X9rIVu
         G1mmpomirvs1ZN+Xf1k/K9I5mNysE41KcQjgdfUBFQQ17oo4Ufvzw68YjaGzSyKCmL/F
         aWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683970204; x=1686562204;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Is++gNE3nkGcxknP6d0sQEnXdTlnG8ED0bAigj61VA=;
        b=EhDbpUr/HdzRCyWMJ1BQHoUmfKjG7DKPjkHH+CvPZfTpHRdyCOtmruZT36hnQHlGg9
         UciE68+Hs/vSNLoa1Iaz29iNBRIch7vMKEqscs9hRfWpqVz7LvcSun6L3F3k38uSo0DT
         rYcAUe3duqRc3DWYGnuDslAwCj6C0KaEnoIUghMkVqUktb8PmQ8oMi6eQA8gokSA1FlO
         kLnwD/CwPYd5PZk+5rF/LvScrcQimfcpTwH/2Y2FZFKXYH1rWCrJcF1YgKdzPwKROFgN
         nfKXwB1RYNKEXL5Jee/JPeOs65VjqkkcL/ijKFnPmqwqsX7Cs5Jgs9sugy1PHpfkWJGY
         CTBA==
X-Gm-Message-State: AC+VfDx58HGTpvGsvA2WKcEayZhrMPi2D2nPcpme1sOWp61TXd7OF0RA
        TyjCVopfAbChRdbj4rQlO9ZHZAriBpc=
X-Google-Smtp-Source: ACHHUZ5DbNgbZ/RyjxKDUhKtSZ7AM7kHJJGqV+M7Bo5Y+fWfX1xkJ8OOaa7TkbTv+5FsNwoeZnqilQ==
X-Received: by 2002:a5d:5011:0:b0:307:8a39:5568 with SMTP id e17-20020a5d5011000000b003078a395568mr19790650wrt.7.1683970204234;
        Sat, 13 May 2023 02:30:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d6212000000b0030796e103a1sm17530157wru.5.2023.05.13.02.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 02:30:04 -0700 (PDT)
Message-Id: <pull.1507.git.git.1683970203084.gitgitgadget@gmail.com>
From:   "Corentin Garcia via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 May 2023 09:30:02 +0000
Subject: [PATCH] doc/git-config: add unit for http.lowSpeedLimit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Corentin Garcia <corenting@gmail.com>,
        Corentin Garcia <corenting@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Corentin Garcia <corenting@gmail.com>

Add the unit (bytes per second) for http.lowSpeedLimit
in the documentation.

Signed-off-by: Corentin Garcia <corenting@gmail.com>
---
    doc/git-config: add unit for http.lowSpeedLimit
    
    Add the unit (bytes per second) for http.lowSpeedLimit in the
    documentation.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1507%2Fcorenting%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1507/corenting/master-v1
Pull-Request: https://github.com/git/git/pull/1507

 Documentation/config/http.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index afeeccfbfa7..51a70781e58 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -246,8 +246,9 @@ significantly since the entire buffer is allocated even for small
 pushes.
 
 http.lowSpeedLimit, http.lowSpeedTime::
-	If the HTTP transfer speed is less than 'http.lowSpeedLimit'
-	for longer than 'http.lowSpeedTime' seconds, the transfer is aborted.
+	If the HTTP transfer speed, in bytes per second, is less than
+	'http.lowSpeedLimit' for longer than 'http.lowSpeedTime' seconds,
+	the transfer is aborted.
 	Can be overridden by the `GIT_HTTP_LOW_SPEED_LIMIT` and
 	`GIT_HTTP_LOW_SPEED_TIME` environment variables.
 

base-commit: 5597cfdf47db94825213fefe78c4485e6a5702d8
-- 
gitgitgadget
