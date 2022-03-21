Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BEEC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiCUXLi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiCUXKL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:10:11 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC155939D
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:58:32 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id p9so22621471wra.12
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DAO9FjifcwP3BPmDlwDJciC8uSNJdsukMFMsbZiEuZQ=;
        b=Zk23avRVrj39hQNfSuS0FgzDRi6zDjANcEiRgUmLi2zCLKZTpAbmnz///cp0swBpss
         +ektmGNXalxrBNQ8+M8pJ1n9dR4vHtCUMfWKQQ/NfZ93DlZWe1k4Uh+aSI6VcXGLz73W
         ykQZcC8HpSErmYFj5+/YM5tBuF6L52tuEr81Z5Jak5+QtLyzFUqJLkVsaTkOtGVJVzwN
         4VoBDmzImgbHTqtTpgKD4N49PU9tdqbiFvBZQ5ijOpogQmUjAjjrZvY4UeD4XGDVs4Hq
         hPPkUF2G/7OogG5tnclpyzATIURfBcOdLZsbEmHU+Fk/wNw/Cua5MpwMkmikQbCdLttQ
         aokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DAO9FjifcwP3BPmDlwDJciC8uSNJdsukMFMsbZiEuZQ=;
        b=qqxVxJpH9BwZPrmc1eFl6EyCTbLkriE6TFwMqTQmZN/gpz3/vSmr5Wxkg4G2JJI8Rq
         0dh5T55SiYZizCDRgzxijoudjyXJaYx5+gqBLaI8pi6H0uieqHJ4tJ/3MdNyOwXNsbji
         SuTtRMU1Lcz6XWzFhZy/mTe+U+roACK9YU+OJSfox7Swi08VNhCCN//ol+pZdUDVTWsz
         Poz8GXl1RLz4YJ7MFuOa8E59bB7v9v7FTldKzElNYcpayRtC1wqBbMhB75iO2VsBQ53Q
         oEu+7WFNljQhZsaO7yNeyICRGcjlidhkQrb5+sEgup7WreiWSjPd2+mQQf4U45h+YHgF
         MEpg==
X-Gm-Message-State: AOAM532HnXJvK0+yPxZnc4G2YpIKT+5xVHAt/Rvx6+ePC09tVLmLpSs2
        8JJKcpcEcAf+YzeJIIItQk5CuJIuWxg=
X-Google-Smtp-Source: ABdhPJx/TYyfak8PQKuMQtPh+31ejI8BzX1ssVJJ5wtg5A2CvTPPXmWDO5BnD8W68Jf1dGd5yp/JNQ==
X-Received: by 2002:adf:fe8d:0:b0:203:e02e:c6c7 with SMTP id l13-20020adffe8d000000b00203e02ec6c7mr20421625wrr.37.1647903378301;
        Mon, 21 Mar 2022 15:56:18 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:56:17 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 39/41] test-submodule-nested-repo-config.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:21 +0000
Message-Id: <20220321225523.724509-40-gitter.spiros@gmail.com>
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
 t/helper/test-submodule-nested-repo-config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-submodule-nested-repo-config.c
index dc1c14bde3..e32b68ceac 100644
--- a/t/helper/test-submodule-nested-repo-config.c
+++ b/t/helper/test-submodule-nested-repo-config.c
@@ -5,7 +5,7 @@ static void die_usage(const char **argv, const char *msg)
 {
 	fprintf(stderr, "%s\n", msg);
 	fprintf(stderr, "Usage: %s <submodulepath> <config name>\n", argv[0]);
-	exit(1);
+	exit(EXIT_FAILURE);
 }
 
 int cmd__submodule_nested_repo_config(int argc, const char **argv)
-- 
2.35.1

