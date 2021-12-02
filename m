Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED930C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 18:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376413AbhLBSnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 13:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242281AbhLBSn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 13:43:29 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E65DC06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 10:40:06 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u1so608765wru.13
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 10:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jL466pEYc6tScMJdo6weuZggZZcoDMfxZ5k5yFTYTd0=;
        b=Xt2Nz4TLJ3UO932DRnxNiFpK3T02ORvwhLfTj4uVt7yT8PLcdJefoYnIPtksd0QSVy
         MIOjSu5NpE2bUrLPchJw812Q75k2wU3TnUkfVFbbJQ12+imoDJE7OrQKKgpT6Noz5mrd
         T3DrCii70GQ6cnffDfahZaY6WP/J2KN9IN4lCPKn8/d/3i90Fwp+AT4rjE9RxsswxhE1
         lSuc3Sk7jAWolcvWkGqcb8xtM3Bhz9c3GH67EMuM3796wlqr8SknRumFOgPRj3eOXqHx
         XlCjLpC8PITvNZH5SjDCl+t/Hg+ttaA0Zd2aViUdQKT7Pl+XdwTAvx190HBKnqyisBt+
         w0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jL466pEYc6tScMJdo6weuZggZZcoDMfxZ5k5yFTYTd0=;
        b=vevuQw1p7H9reqXuqc1HsaHNITozPBiKXqz2VQgou/MhffhWMBRUl3LUJhikP9wpSk
         PIkrsiVXsKILm68+KSeO3fqHbjx6/C9e8HcWMvc29VRVyKGGDo41MR2x0/UL2o8oKxp7
         DjRPzqRpV7zz0envWzO0MgJvj52r66RDbmigHWY28K4jubsi4YGSWDDWjN6qsEIYLTto
         QL1EqqR3z+TPDmh+mY/HBd8NZsWEHHSaSzKvpLsRwfNtPqCNhJE243NItY/4fOSuuKqn
         XvSc9LgIwbuN/D7djvhu66f8RDdsuKx1PtPJdit4qJfrQaF9mGkfb4KPWzxNoIy/uK8a
         4W8A==
X-Gm-Message-State: AOAM531EjFJq6g2LTozjLASL5jSIBhujo7IT85gd+spTRjLTna963vdf
        NrKdtg+eUCZPywA0F3nW6D60bC/1Ce8=
X-Google-Smtp-Source: ABdhPJwM0aDLh3TJVTZPSysuBHmOPT0x31ud3OShOQ/GxsX9DszWOvuc2T45miBVLQV3gt1ujPvkLg==
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr16510486wrd.179.1638470404770;
        Thu, 02 Dec 2021 10:40:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17sm3009657wmq.15.2021.12.02.10.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 10:40:04 -0800 (PST)
Message-Id: <3649ef6d0fa14ea1796264188466cdfc42d6d9e1.1638470403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
References: <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
        <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Dec 2021 18:39:55 +0000
Subject: [PATCH v3 1/8] test-ref-store: remove force-create argument for
 create-reflog
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Nobody uses force_create=0, so this flag is unnecessary.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-ref-store.c      | 2 +-
 t/t1405-main-ref-store.sh      | 5 ++---
 t/t1406-submodule-ref-store.sh | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 3986665037a..b795a56eedf 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -182,9 +182,9 @@ static int cmd_reflog_exists(struct ref_store *refs, const char **argv)
 static int cmd_create_reflog(struct ref_store *refs, const char **argv)
 {
 	const char *refname = notnull(*argv++, "refname");
-	int force_create = arg_flags(*argv++, "force-create");
 	struct strbuf err = STRBUF_INIT;
 	int ret;
+	int force_create = 1;
 
 	ret = refs_create_reflog(refs, refname, force_create, &err);
 	if (err.len)
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 49718b7ea7f..5e0f7073286 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -35,8 +35,7 @@ test_expect_success 'delete_refs(FOO, refs/tags/new-tag)' '
 	git rev-parse FOO -- &&
 	git rev-parse refs/tags/new-tag -- &&
 	m=$(git rev-parse main) &&
-	REF_NO_DEREF=1 &&
-	$RUN delete-refs $REF_NO_DEREF nothing FOO refs/tags/new-tag &&
+	$RUN delete-refs REF_NO_DEREF nothing FOO refs/tags/new-tag &&
 	test_must_fail git rev-parse --symbolic-full-name FOO &&
 	test_must_fail git rev-parse FOO -- &&
 	test_must_fail git rev-parse refs/tags/new-tag --
@@ -108,7 +107,7 @@ test_expect_success 'delete_reflog(HEAD)' '
 '
 
 test_expect_success 'create-reflog(HEAD)' '
-	$RUN create-reflog HEAD 1 &&
+	$RUN create-reflog HEAD &&
 	git reflog exists HEAD
 '
 
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index 0a87058971e..f1e57a9c051 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -92,7 +92,7 @@ test_expect_success 'delete_reflog() not allowed' '
 '
 
 test_expect_success 'create-reflog() not allowed' '
-	test_must_fail $RUN create-reflog HEAD 1
+	test_must_fail $RUN create-reflog HEAD
 '
 
 test_done
-- 
gitgitgadget

