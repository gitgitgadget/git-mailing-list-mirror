Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F15BC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiCUXKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiCUXJe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:09:34 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1148A324D64
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:59 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id o30-20020a05600c511e00b0038c9cfb79cbso458448wms.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s+6I6EC/7xROz/VXlJztaYqPHV7zcNe0TOOyNlcfuSE=;
        b=JJwno/tC0+/vYnEiyjztR1S78OxUfXrzZxQ5ylqs2RdgYLEHHZLZNi/MdfAJxhs5+A
         7z7SvRA7b5qPtpKY1zCztrUfW50CjYinveUrW4lUbS3apoTxonWlEHfKeClQz7P2doUR
         M3b4/uSZviYuvRpqqZSNxHV+J4tL+rtCWxoGX7Xo9Ouf+0hOtHdy4CUilYLaUO+aZv1Z
         kFiJPKZqUtiac7sq0/zb96skJFa1mg7tpVPZ+FjXZvDUhLToiwY4GVrp2S94Smpr5JLM
         7GvVhs/+z83DVF3sdgclft5rOR+o0XIUWRP3IBCWFg97xAWkUyamRsH8LOHn/tWN31k5
         syVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s+6I6EC/7xROz/VXlJztaYqPHV7zcNe0TOOyNlcfuSE=;
        b=QbHldlOLBbr3ggJcIXfI6U/PJRsIU6DnzL25CHM/Aa9FvbclJw9WUFC4hSXh2W9M4f
         JWZv3sLNAz5U80dcAFq4nFFKDy38G2QriMNwZ+LIuyCzZhg6UONx2p/y3Y+UXqEcinmp
         Nb5gFrKtMd8YCYCR7OY8Do8Y/58FUXwy9ZO4NePe/R16dTnAh4XTd/USxWo9R6ON3l6T
         3E3/MDma4wh436Lry5WMNJNdKA5syMZ2Zg+Zn8r0sk7VvJ9q0FxvvPLmFjPOsz35APvr
         6wEJM5ZN0zseZxXk9x++qpTVIWQBbWUDJwuFk82aCgE9tQZor4Phyogh3lBN0Li6B1ZU
         71hg==
X-Gm-Message-State: AOAM533gEi5q8kyAJMiRaV5MtmCBZH7qul8H313pXhGnZzT8/ZHhVn8g
        dZLvJ5T8nQJZZ3enigG6Wu9j79zOFQo=
X-Google-Smtp-Source: ABdhPJyQlD7oorMik26Dfjvdaqi4skSWdT/PRNs0CeDtMmONI4K/kOmuO6vo/KlgmKb7sZDq2bszKQ==
X-Received: by 2002:a1c:7312:0:b0:38c:6f75:ab28 with SMTP id d18-20020a1c7312000000b0038c6f75ab28mr1133332wmb.19.1647903377485;
        Mon, 21 Mar 2022 15:56:17 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:56:17 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 38/41] test-submodule-config.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:20 +0000
Message-Id: <20220321225523.724509-39-gitter.spiros@gmail.com>
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
 t/helper/test-submodule-config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index e2692746df..d4608300d5 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -8,7 +8,7 @@ static void die_usage(int argc, const char **argv, const char *msg)
 {
 	fprintf(stderr, "%s\n", msg);
 	fprintf(stderr, "Usage: %s [<commit> <submodulepath>] ...\n", argv[0]);
-	exit(1);
+	exit(EXIT_FAILURE);
 }
 
 int cmd__submodule_config(int argc, const char **argv)
-- 
2.35.1

