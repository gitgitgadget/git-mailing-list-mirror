Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE81CC7EE24
	for <git@archiver.kernel.org>; Thu, 11 May 2023 21:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbjEKVUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 17:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239364AbjEKVTp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 17:19:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D606A3C30
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:19:43 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3077d134028so5310032f8f.3
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683839982; x=1686431982;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJNQBIN8cv2IchSTc2C2hIT3DWCVK/uxXNnC+904g2s=;
        b=Uac8k5GOC8KVtT5WyRNb+OAkugwDHgwKK6N7lCMmPIFRut2npXsywh3hZHf3uoVtp8
         zgu4+i6QpwDDqGEylxVW9Ahfi9SeAf5J752/G5eIdu6NgZo5iKdG2lG9CsavfQULSDrR
         r5fqpChkG7TuxbIUJTqRc+ZbvxIT/v0AuAV0TnSt2Bkg9klYZv6hdEn+a+iwLiswe9SI
         TNqlWE2+NjE2/MMqWI/mxxNUXNwo+6PhqN1iEWHqYGK/2xJjwTaT20earbfLjyhKbIo+
         n8XADrZ7RFcSWQOzxb9vmcTXFSNEkBFpkNO0TXGs14dEmYHEUQgD3Q9FhSqcn7HHvwFR
         p7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683839982; x=1686431982;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJNQBIN8cv2IchSTc2C2hIT3DWCVK/uxXNnC+904g2s=;
        b=GhH67Pqwhp+WD+qDcBJGsQBHfPtBJ+c8q4zEh0btMgIk2M/AwGjbTQTnX7BdrYXs6O
         cZTLkJtZjzL3Zr92gH1At0WO1mQfMiSJ8+Sa5cyBt43WkTn95eTDWaFP4ujf7XqwidWE
         c0Q9r0ctju3091s0mEua+Q/GINsPncVoqozaMxXGWttr2poxGnW+oBoHJJ3CxhVmXe3p
         j3T4xs//lcJ6dKIZQd5cjmHKMjHMPBpHB+cspTQgVVO3wFA8LzEJpKgI4dDuRhQyHfXU
         nQWLZnrnyKvrjOG7BF+6r+t/oYfFlPXFGNFPrXvgmmOrWScT2ds1Bxdwxwh/pVQqqGMk
         TtNw==
X-Gm-Message-State: AC+VfDzKhY6RYGJ/IlzxWRCxX7aknuf9idCN7onJL4vX3hB8ZI5+NCO0
        m3Yyyf8GvNfV2ozuYCJhd7eu79P5vDE=
X-Google-Smtp-Source: ACHHUZ4HekGXl1VPouv+MXKm+nouQQymhziuD/fIijvqj+xdEEDxl0b70h1AKd4oKjUxNE2IBxLz1g==
X-Received: by 2002:a5d:40cf:0:b0:306:39a8:6fa2 with SMTP id b15-20020a5d40cf000000b0030639a86fa2mr13989720wrq.61.1683839982118;
        Thu, 11 May 2023 14:19:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d4091000000b003078a3f3a24sm17693758wrp.114.2023.05.11.14.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 14:19:41 -0700 (PDT)
Message-Id: <8aaf9e27d98cc823efaa9032a07cb2994a3cae48.1683839975.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 May 2023 21:19:34 +0000
Subject: [PATCH v2 8/9] doc: trailer: mention 'key' in DESCRIPTION
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

The 'key' option is used frequently in the examples at the bottom but
there is no mention of it in the description.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 32a26c59f8a..245a66a7a85 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -48,7 +48,9 @@ token: value
 ------------------------------------------------
 
 This means that the trimmed <token> and <value> will be separated by
-`': '` (one colon followed by one space).
+`': '` (one colon followed by one space). If the <token> should have a different
+string representation than itself, then the 'key' can be configured with
+'trailer.<token>.key'.
 
 By default the new trailer will appear at the end of all the existing
 trailers. If there is no existing trailer, the new trailer will appear
-- 
gitgitgadget

