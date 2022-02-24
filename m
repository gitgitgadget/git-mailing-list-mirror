Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B6FC433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiBXJeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiBXJdx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:33:53 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1E326A3A2
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:23 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id y5so763387wmi.0
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sMdNw3VriV1e50nIS0h3xQ9LPdwUoL8xUaByLwSZKD0=;
        b=IAOn1MDVLUeFcTaJHgs18c2fVwaqX8yYk12+NhD45a9WZlCJG6q0L4ga1CElhEIjP/
         4MnQR0Enmm+Ft6yqFnf3Mee9T4QwyEgGBl7H5Fb9ixdEXvfFFgr19RcqfktTnmIVPFRw
         nRWp6wRgQCW8+tzX9oYeSvwqcPOCEjN74f87dKCdTcB54SUyQ2hxX545xOzbjhlewITj
         L8x17fotkEn829iJaye0+Mq50+vzN23T8zl+u35T3AVLDx6yxCyD4uMbqEhKYfYNEbOJ
         GC++vTkVuR3j44v1vkhmCIQlBEuyLkqeiRHto4DGXt2IWOHdA7Pmky0QBbYYn1lkSGbN
         Ud1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sMdNw3VriV1e50nIS0h3xQ9LPdwUoL8xUaByLwSZKD0=;
        b=y7uGXVCM9F55rfit/PJuOggdod6ET6raul5541+Kv1sCDkbxF4NVQfOxtTnRstcXoY
         XdEInq8VlSqG+JXnRwlcemnxFuHBSIDfwxtDORsc7h11bDu1VgJx6N1PtVp1yN06F2PJ
         HoqJKzXDnAR1hBRhXdeMuA5F/Gi2cBaOyFljuEnrLu9qHM8hffopl/zO/ptKpeAfGXfA
         n1R83ypfXAKwmSxxj+qjH8/i4I6OXzJLmwxt+G6G0EZAwumJxNANUVVTyPqo3phk4bPf
         3nskzyaes9hF9jzODcOqXBvYKKtTXR+ISicsydZzVE21t8Zep8KLe23bq8FeaB3hZBRP
         NmBg==
X-Gm-Message-State: AOAM533dN5gepcc6q6w2op/e93RHXgk8FSgb/ZCV2JIZnmtNlsrx8QJb
        v171JqlhZPMHdxoMlvHiD7ylJMNFRfoM2w==
X-Google-Smtp-Source: ABdhPJyeXFOlcbtonhACfKWyN0tCG3isiJEke6H0d0Ml1NY2g97wnj6X9/pSl8h8q+0m2E9/PL7DxA==
X-Received: by 2002:a1c:7915:0:b0:381:9d:3c6b with SMTP id l21-20020a1c7915000000b00381009d3c6bmr1517760wme.163.1645695201669;
        Thu, 24 Feb 2022 01:33:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q13sm2109742wrd.78.2022.02.24.01.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:33:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/12] misc *.c: use designated initializers for "partial" struct assignments
Date:   Thu, 24 Feb 2022 10:33:07 +0100
Message-Id: <patch-12.12-d39622453d4-20220224T092805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1157.g524e2d5a0db
In-Reply-To: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a few existing non-designated initializer assignments to use
"partial" designated initializer assignments. I.e. we're now omitting
the "NULL" or "0" fields and letting the initializer take care of them
for us.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fast-import.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 2b2e28bad79..2c244c68f7e 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -176,8 +176,9 @@ static int global_argc;
 static const char **global_argv;
 
 /* Memory pools */
-static struct mem_pool fi_mem_pool =  {NULL, 2*1024*1024 -
-				       sizeof(struct mp_block), 0 };
+static struct mem_pool fi_mem_pool = {
+	.block_alloc = 2*1024*1024 - sizeof(struct mp_block),
+};
 
 /* Atom management */
 static unsigned int atom_table_sz = 4451;
@@ -205,7 +206,9 @@ static int import_marks_file_done;
 static int relative_marks_paths;
 
 /* Our last blob */
-static struct last_object last_blob = { STRBUF_INIT, 0, 0, 0 };
+static struct last_object last_blob = {
+	.data = STRBUF_INIT,
+ };
 
 /* Tree management */
 static unsigned int tree_entry_alloc = 1000;
@@ -231,7 +234,10 @@ static struct tag *last_tag;
 static whenspec_type whenspec = WHENSPEC_RAW;
 static struct strbuf command_buf = STRBUF_INIT;
 static int unread_command_buf;
-static struct recent_command cmd_hist = {&cmd_hist, &cmd_hist, NULL};
+static struct recent_command cmd_hist = {
+	.prev = &cmd_hist,
+	.next = &cmd_hist,
+};
 static struct recent_command *cmd_tail = &cmd_hist;
 static struct recent_command *rc_free;
 static unsigned int cmd_save = 100;
-- 
2.35.1.1157.g524e2d5a0db

