Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E14C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiCUXLd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbiCUXIh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:08:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2D351E6B
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r7so9412210wmq.2
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7dHAMdZPEOD8YhLsDhMpTMCV6/ucq37yxEPYK+1Zz9s=;
        b=OZpCDDStulYcYFXz38STDhQ+S+KmMj58v/0C9uFtcd3iMuRQAryekpWpPryLvn5O4A
         3hsAmataQ9BvLM6zkFi1XIWgs1cJ/levWVfKurlDX0B51TPjVRlDU1vTwR1ZHTx/D2zk
         bOu73EZ5YS8Z73jq2BnVAXAH+XzgSPIKAxtsPPJZdDXdkgOCBkR6Lg6Yz3meCEhfE546
         E2nHIanyDWxXqj4ti/w2CSKJA2c0cwZnCf6OyOVnNc6VvWEIK1zzHJJRddXfeOZujeIo
         q469JY5NAMiHd6Qto+3CKznFtm5f2jIlRDZbJeMoVK23DDS4JXQFsSMbVypksUUMAMjL
         oU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7dHAMdZPEOD8YhLsDhMpTMCV6/ucq37yxEPYK+1Zz9s=;
        b=DF9FUIHHznCpuukX4tW1Q1jwj1LBB/1is7kJ6UZ8DPQov4EAzyFKco29YmhF6HU7R0
         3NbkRv9X+fzovvIOVqoZhOGlrAFEckluISWlbrMjzKMDi/Yso61kpXY7p2No2Y1e6x8j
         pcpVFnfrlDBFF4oU/pNBGFk7V9pQ0zKQir6fCXvnckl0B+WTEE1Tha3wnZrOE6hWWKam
         G6Wz6T5yWP3P8+YJMNxWM+AOVTRCuPOFYmkKkVaWgsFVaGfS/ceTA/ScNiWVZ8yU7+Mi
         YHGupPb33PLYRII5dF65aab/Z9yxpoU0Ed1Wq+4zf/VgsfIETqgDM1hVbswLMpCKu279
         l/IA==
X-Gm-Message-State: AOAM532rM5izcqgYM9s7NKkuAJ3Xi+Hmf4aGpwZjOzhCR7hn1DNawgVm
        pFEkTsOJ//wqTdxz3yUTP82vCSmW020=
X-Google-Smtp-Source: ABdhPJzRzS2OQK/sIjANDSJzaJKcZpr2EFdIbAO4WBI3ZuT2jKcEvatsJJbVFNJWoMFQouBXSzp65g==
X-Received: by 2002:a05:600c:378d:b0:38b:e12f:edde with SMTP id o13-20020a05600c378d00b0038be12feddemr1112146wmr.69.1647903375615;
        Mon, 21 Mar 2022 15:56:15 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:56:15 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 36/41] test-json-writer.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:18 +0000
Message-Id: <20220321225523.724509-37-gitter.spiros@gmail.com>
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
 t/helper/test-json-writer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-json-writer.c b/t/helper/test-json-writer.c
index 37c452535f..61c5a3dac1 100644
--- a/t/helper/test-json-writer.c
+++ b/t/helper/test-json-writer.c
@@ -322,7 +322,7 @@ static void cmp(const char *test, const struct json_writer *jw, const char *exp)
 
 	printf("error[%s]: observed '%s' expected '%s'\n",
 	       test, jw->json.buf, exp);
-	exit(1);
+	exit(EXIT_FAILURE);
 }
 
 #define t(v) do { make_##v(0); cmp(#v, &v, expect_##v); } while (0)
-- 
2.35.1

