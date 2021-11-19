Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204CCC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0124861AFB
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbhKSMtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 07:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbhKSMti (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 07:49:38 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABD6C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:46:37 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id y196so8372841wmc.3
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QMqRx43aDbtkwrmd95CrtGxhcDTQEuTtjUsND/x6etM=;
        b=Y2fBhVmhtzrEmRv198LgSX64NpLOjKeY31muu9dkdYfmmjL1iohTSKm3ypgqzVO2Eh
         JTv4MU27gbyx3gO5R35DT1112OOb/UxlbtYuxByUchQ2dyh57tzy4jFxcWSX7owFnDUO
         nthB8QDckzT+4BuCSu9fzT7Ei/w/nKq4Bew7B2s6BhrQZN3jLHOYXOrqWPPJTgzmwDUp
         yNOUOkjfbP6dTNdxJ64pSperi8ZXd3Kku41n7Y6nGNa4eTv6164UtSWCR296F/BZbpY8
         60Q4zYkpVjptEAHCT0GiTCMB2cFwTEfXR8/+MFjmDZERlm0Vlkk0F3De52uHvuPlCGhf
         AybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QMqRx43aDbtkwrmd95CrtGxhcDTQEuTtjUsND/x6etM=;
        b=e0v3iNYdIBdjD1wO1bSFlMqbTgWlIICbjRAuplWQ2RnjncK6stLiadNYybNRxIeOwS
         Rn1IqO8kiVlQN5+XP2Cu7LNz6Hh2S4W1J3OpW6IRXIR0RtFaUEHfEuecaNqT6exhFyHm
         Z/5Jmxn5NYCAUw4TyaKiiqfrHXCsFLpCcwcpKHHhe7bR0cVIrePa18KLLZfiHuAfTuzO
         wYHZwM8BcANZ/n6d+xXXxSQKxeGgw6dz4azNw/VQCpE6sBqX9ORGXL1+ytuez7yIgt6j
         eZpKXtezunbZFV8KoQyrxeC/UFtvH40uIubrh3QvBWct44TtI8hyvYmsfGrtxj5iWvtY
         +K3w==
X-Gm-Message-State: AOAM533Te5/ejNudQasqq+YAoTQoaeZot2r4QFLxvhsKBg/QOeFAQpCx
        Xeezpj96FvMFF0nQO2BHwqxbenm4oeeRQA==
X-Google-Smtp-Source: ABdhPJymRLNZV6i/be9IAoCux+jo6hHCxfzdodyKK4f3YQt83ufv75qt+l4djTLA1xArhL2s2gWX7w==
X-Received: by 2002:a05:600c:3c91:: with SMTP id bg17mr6592024wmb.80.1637325995404;
        Fri, 19 Nov 2021 04:46:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w7sm2857567wru.51.2021.11.19.04.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 04:46:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/6] alloc.[ch]: remove alloc_report() function
Date:   Fri, 19 Nov 2021 13:46:24 +0100
Message-Id: <patch-4.6-bd8aa9b1554-20211119T124420Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.817.gb03b3d32691
In-Reply-To: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The alloc_report() function has been orphaned since its introduction
in 855419f764a (Add specialized object allocator, 2006-06-19), it
appears to have been used for demonstration purposes in that commit
message.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 alloc.c | 19 -------------------
 alloc.h |  1 -
 2 files changed, 20 deletions(-)

diff --git a/alloc.c b/alloc.c
index 957a0af3626..bf7982712f1 100644
--- a/alloc.c
+++ b/alloc.c
@@ -122,22 +122,3 @@ void *alloc_commit_node(struct repository *r)
 	init_commit_node(c);
 	return c;
 }
-
-static void report(const char *name, unsigned int count, size_t size)
-{
-	fprintf(stderr, "%10s: %8u (%"PRIuMAX" kB)\n",
-			name, count, (uintmax_t) size);
-}
-
-#define REPORT(name, type)	\
-    report(#name, r->parsed_objects->name##_state->count, \
-		  r->parsed_objects->name##_state->count * sizeof(type) >> 10)
-
-void alloc_report(struct repository *r)
-{
-	REPORT(blob, struct blob);
-	REPORT(tree, struct tree);
-	REPORT(commit, struct commit);
-	REPORT(tag, struct tag);
-	REPORT(object, union any_object);
-}
diff --git a/alloc.h b/alloc.h
index 371d388b552..3f4a0ad310a 100644
--- a/alloc.h
+++ b/alloc.h
@@ -13,7 +13,6 @@ void init_commit_node(struct commit *c);
 void *alloc_commit_node(struct repository *r);
 void *alloc_tag_node(struct repository *r);
 void *alloc_object_node(struct repository *r);
-void alloc_report(struct repository *r);
 
 struct alloc_state *allocate_alloc_state(void);
 void clear_alloc_state(struct alloc_state *s);
-- 
2.34.0.817.gb03b3d32691

