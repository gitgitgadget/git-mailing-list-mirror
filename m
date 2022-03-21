Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915B2C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiCUXLL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbiCUXJj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:09:39 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7224E331455
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:58:05 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so367044wmp.5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WuVtDQaIHEBAJfbLOr9Szg5DhnU3l/HI2iWx9LjxB/k=;
        b=cq1OWDXq29gVkLk1lcTgxrtVF1pBwdUgyRy07VWyn4ncs+1C8ywk3Vc8IHHRiNTiCA
         uBBVZtEgR8Quv+Lur+lJz0T2NpByGaUmfBrBJr3LUPLfP2KDhUHfHD8wY5JT/2z5LOat
         hrwa4wL9iQ+4f3flXp+zCuAOBE/33dDUFZJInn9qg9k5NVlq3G36+PwjkSozFBpsXZQY
         K6/ShO0cDuXjTxiol+CcngEnx/kVjTMIe7cCVgspdtkyrQeQfEgY3IOcmZKnTPfKCUn1
         QR5d8heq0wktsss/+u9H2D0TYD4yW/zdxuYRRFkW5XPEGf4qEA6MypO1+ySuVOaoLjPP
         ie2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WuVtDQaIHEBAJfbLOr9Szg5DhnU3l/HI2iWx9LjxB/k=;
        b=dLJdlIw87XOlOac4G7RC0ojemXRS/7lAxLkvztwPepyw2IvVZXlG8D9Vqzrd/02zwf
         Eg7Pw/WnhKeioQxlD1uQJsDWfvRFNeca6jzbj7EbXyQ2VjYLlYgDDqQ7WW1sb8mnLYOA
         Gy2UwEIQuaoLbZEf+wdEUvx/m38Wfb+Z7IbOZ7+BInrESOrGWwV74FZCHpHBU01cYuMm
         SoIBzU1s0aGzbYNr8Y5oCi3RQe7xFI8zd8Gvx7Lja9LDo4OWnKXRc8ierEg9rU9BSwEh
         bKBmmzz/qveX1XpDDmp/eVnBL8mqro0arWKJE3NQdtZgLfD92dyFMi1Glywa3Ruxx5Hy
         XIlA==
X-Gm-Message-State: AOAM533fRmKqDDXuxT6S4SiGRd2T2dipVCbQ07igX5ddsD1AKUCCIQtq
        jyNVOxFSZHFs3uvni4Ay0qyiI7Xingg=
X-Google-Smtp-Source: ABdhPJwJhGjiiWra4W9SqmL5XaAcv8NiujquJHdEKZ0pfp34p9WPKFjUyA37tUcfYQWm/oh4UR2plQ==
X-Received: by 2002:a05:600c:252:b0:381:3461:1c64 with SMTP id 18-20020a05600c025200b0038134611c64mr1131044wmj.94.1647903376508;
        Mon, 21 Mar 2022 15:56:16 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:56:16 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 37/41] test-reach.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:19 +0000
Message-Id: <20220321225523.724509-38-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Use the C standard EXIT_SUCCESS and EXIT_FAILURE to indicate the program exit
status instead of "0" or "1", respectively. In <stdlib.h> EXIT_FAILURE has the
value "1": use EXIT_FAILURE even if the program uses exit(-1), ie 255, for
consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/helper/test-reach.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 2f65c7f6a5..b5c4cbf6cc 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -40,7 +40,7 @@ int cmd__reach(int ac, const char **av)
 	setup_git_directory();
 
 	if (ac < 2)
-		exit(1);
+		exit(EXIT_FAILURE);
 
 	A = B = NULL;
 	X = Y = NULL;
-- 
2.35.1

