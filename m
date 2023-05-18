Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFEDC77B7A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjERUDc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjERUDa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:03:30 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF22AE4F
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:29 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f475366514so17195525e9.2
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440208; x=1687032208;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTT3iWbX7HYgDASFuqJNh+b1OeGkOPitNcI4xBfI5C8=;
        b=RHkI6L8HdiW43aUEhhX06AepPj0GMQ9/3zgUXWjV1Yu7GF+OlYCRt5Ma/V4NGkPga0
         6BcZB14hwkFKxkdIUhrILyVnej69agLFYLAmy1YsNPb2HwDn6yxfXEivFD0te0SnMgPB
         yjeIkJNcNqlzmtU2CSwjKsZQegjPPJhIAFOHiSD2z9L/OdTI7aZOSyLmiSBXIzfTI+Nj
         yJYuFImi+Ook07PlafHOPX3+6KCIFqcpTnIMDsX4EKP9X9fhUV7i0MqIjFiX3AuTpCSR
         J1wnhzmvVIAW9T66ZJX7N30R6E/xoE7M0H98L59jveMNUKY9k4YdtRkFd5/E8K8bxRjp
         98og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440208; x=1687032208;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTT3iWbX7HYgDASFuqJNh+b1OeGkOPitNcI4xBfI5C8=;
        b=GbYD/JtGx+AE2F+n1HCZhQqlNapBbdV/ztWuEc0T/VWx7LVfeFEA1cR9bTsnfVAReV
         J2SgQmsh/9n43ZvoN7PylbXd6mOcDxfA6Vs6mRKWmmgqUeEP7IQNg1cte9FG6eLAIOkt
         c0Wc/YqPTU1gEzYNjadXFCBy4cf07a2kP7zQxeWkUXUw+YLv9jFtXgJPjwqed1lYM8kp
         efjBph05xZYX8R8xFk0lZ73rfYwvujrGcE7T+3698Rd6yTMjgAID/YKmoV7VI8EwRn39
         3VtFyqgncYIuHpnXsC1lQRvMUgDCB153zNAMQc5boDgCpCDDTab3CFblO1Ufxfdjnl+2
         1cDQ==
X-Gm-Message-State: AC+VfDygbhfOjpbgKpphRsx9W/VJLzsgs9b+XUyvtrAbI+0J/WThYbBC
        E7ei0h2oIl2E6fbBHtAY61fsTj6jXm4=
X-Google-Smtp-Source: ACHHUZ4lA3y63yGL2c3DZHfH5GsiifbmP+nZ4V/6fF0traR9pPgddYD2mA88M+LT+I2K4xvYGLZsWQ==
X-Received: by 2002:adf:f451:0:b0:306:342a:6a01 with SMTP id f17-20020adff451000000b00306342a6a01mr2345343wrp.47.1684440207919;
        Thu, 18 May 2023 13:03:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i3-20020adff303000000b0030795b2be15sm3043065wro.103.2023.05.18.13.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:27 -0700 (PDT)
Message-Id: <b974c43ef661db2f34b157c853d59b01f35a4767.1684440205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:06 +0000
Subject: [PATCH 01/20] t1000-basic: modernize test format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Some tests in t1000-basic.sh used the older four space indent format.
Update these to use tabs.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t0000-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 8ea31d187a9..6e300be2ac5 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1014,7 +1014,7 @@ test_expect_success 'validate object ID for a known tree' '
 '
 
 test_expect_success 'showing tree with git ls-tree' '
-    git ls-tree $tree >current
+	git ls-tree $tree >current
 '
 
 test_expect_success 'git ls-tree output for a known tree' '
-- 
gitgitgadget

