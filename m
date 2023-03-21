Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEF0C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 06:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjCUG0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 02:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjCUG00 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 02:26:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86626301A8
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:25 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t15so12500347wrz.7
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679379983;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xseF45rJFDsz6Zxllwj1WjCkE0KWXhmhICbtjGjrY3A=;
        b=TYrjzztzxvVwK9ANYQn5y3jwfxyP0tevRnVMDV4EvotfGI9G02GD1RkUiPWJYYtZth
         Ef+7qp1vUTyNBNhItBo7lpT94iAJeiN20ijYX1QbsFcXPDVwTzJK+XOwybVChCV9F+j9
         JP0h83n8MUMtZK76S/4sAiNQhPMLHBEzl2vkdTPuTmISuqqH4m3yHx01QJhwDdeIw6gh
         CUKaWFPLXUBJ1pk1oSqEKi3GXCYSATPIjeAxsZWJU1277GA8VqSHSAyfaxtXlfT0i14x
         j36OO7aAvGD92BgfO4vHhHGKt0sRr+zeasXaebBnTWtb6yCBe/5F4XCMsp+doPkMLPkj
         YyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679379983;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xseF45rJFDsz6Zxllwj1WjCkE0KWXhmhICbtjGjrY3A=;
        b=J4sp6KuyrGuOW6dewiad+csjzTSnWUUba7Q87bgxfsuooyB7Dh4ZawRD/tGIszfhd6
         upjOhwWY0HRueYcxTN5hd+tcObpTHjBSZumikR/8xpIqs2D/pbtDqb25IfOUMDpnwYFG
         R1fHVIHHtYZco3P+2c2WHG7S19UDCk0wbJHnYIJH4te/3vZPHrC0tOV5sSpJxw99sAMB
         G4xioJe7e4HpQ5nJS0p03CuXXALksOxOQQyzi0ox9YaTDWYakx1Uzrg+g42sBHu3oWRh
         mYFUMIHQ9ki3BEZHCoOGqJR/R1wuARVUZaBGghDl3fcCLDWpvGCgKodTFizJmV+UGQwe
         ZerA==
X-Gm-Message-State: AO0yUKUg2pF7FKrmQZBlzT/Fu/fQn4Mv/eV6OYG0xzUWLDJWCdp47EAR
        3Cx7t/kpm1wQOSRbgN9quNVMP1QMmlI=
X-Google-Smtp-Source: AK7set9FKVCOrY05ZXC+JTdLObF5EpZZHbhh7wYJM63Q3gUjHzRAMdkeFbfxnTIdcDAfhhPCehnS3g==
X-Received: by 2002:adf:e94d:0:b0:2d7:d4b:b33 with SMTP id m13-20020adfe94d000000b002d70d4b0b33mr1469224wrn.21.1679379983304;
        Mon, 20 Mar 2023 23:26:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10-20020a056000050a00b002d78a96cf5fsm3301294wrf.70.2023.03.20.23.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:26:23 -0700 (PDT)
Message-Id: <805d0a86951eeaf0abf6760e127940c3a0e1dfb6.1679379972.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
        <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Mar 2023 06:25:59 +0000
Subject: [PATCH v2 07/16] cache.h: remove expand_user_path()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

expand_user_path() was renamed to interpolate_path() back in mid-2021,
but reinstated with a #define and a NEEDSWORK comment that we would
eventually want to get rid of it.  Do so now.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h         | 2 --
 gpg-interface.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 260203c7a62..978aa01712b 100644
--- a/cache.h
+++ b/cache.h
@@ -1142,8 +1142,6 @@ enum scld_error safe_create_leading_directories_no_share(char *path);
 
 int mkdir_in_gitdir(const char *path);
 char *interpolate_path(const char *path, int real_home);
-/* NEEDSWORK: remove this synonym once in-flight topics have migrated */
-#define expand_user_path interpolate_path
 const char *enter_repo(const char *path, int strict);
 const char *remove_leading_path(const char *in, const char *prefix);
 const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
diff --git a/gpg-interface.c b/gpg-interface.c
index 632265691e5..f9c5b6c3f53 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1049,7 +1049,7 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 		ssh_signing_key_file = strbuf_detach(&key_file->filename, NULL);
 	} else {
 		/* We assume a file */
-		ssh_signing_key_file = expand_user_path(signing_key, 1);
+		ssh_signing_key_file = interpolate_path(signing_key, 1);
 	}
 
 	buffer_file = mks_tempfile_t(".git_signing_buffer_tmpXXXXXX");
-- 
gitgitgadget

