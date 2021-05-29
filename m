Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1FEC47082
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA40613D1
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhE2Hqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhE2Hqq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:46:46 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACACFC06174A
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:09 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so5785568otl.3
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dbJtFb/rZfDlb3PO8aGvYcMBmd/mozuwH+0fjBLxGdk=;
        b=iDy3iYfqTI6/g1gA8XwFzIhdgFjEJLeTGUQ2In0fAlKEzBWFOM1rdQKOg+J8w80H9a
         f0w5vuQXw6SW856Z9CEtAJkSvQaDOAzNciizEJ+PqFPRF8/aHDtH4CHJPmJLMGL1J4s+
         67KnD/OxwaPjT3yqyznSsbiQaG/4LOD6FmgBVuH6IgR+bRpDhOTjOM7gDP3IZjFvcOOd
         xwrE4qarRVSoHwrnIZ/cwg/e7VBxLPqJO7StEWhG+ZdYV+0MpXkN8LC/zvGFkSC1WZLw
         W9UIaXijma6NgN+d9tupcpB3p39u3vQh+rn3t4CYGgGztyG797hW+TbfBilX1kifNRGn
         YdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dbJtFb/rZfDlb3PO8aGvYcMBmd/mozuwH+0fjBLxGdk=;
        b=n/CL45RuuZ5Kqu1qGCXRqiJeHs/ArZa8ucAZLRtRlA+FU1dC1Omy5Bh+uh+cI/+Y3J
         Wh/EBSETrQl+2Cc5Z1L7WQeoqpmLRulsbrK8WOIJH2921GY80NjX2niQrf60K09JlTIo
         UYoulcMT2PgC5NoAydBqAvfRfJN3PwaPBPp2i7+W+AzXV2kkgOIQyotSuZGa5yCHowyb
         46ljzP3KQvTWQ8d6zBIxoFt4KhzbxBfJPKz7RefsKJ9m3XF1wjFkU3SFDNUTQYVgEVzZ
         I0VklkPVtpx6Y+AZKqdhDu65CCBAE8p+GzcnkohFCkH4njVbTSQPIAEl2XISQXMzdmvp
         IMrA==
X-Gm-Message-State: AOAM533Tq7ezp4gPLS6tBaiZZSdFzHL1NFWSnSumh2pIaCDp62zYCJUf
        t1PVKkQmOXQxdBdHTW1SGG44NZ/ode0eWw==
X-Google-Smtp-Source: ABdhPJyB/ucRYtx/pzh7CpWyUeRXNIxHCp+NPmv/dt47+S7xXGxYa0y4h263qm1irh4myBPXLyXswg==
X-Received: by 2002:a9d:585:: with SMTP id 5mr10325571otd.12.1622274308879;
        Sat, 29 May 2021 00:45:08 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id y44sm1582022ooi.0.2021.05.29.00.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:45:08 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/15] push: make setup_push_* return the dst
Date:   Sat, 29 May 2021 02:44:49 -0500
Message-Id: <20210529074458.1916817-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of the setup_push_* functions are appending a refspec. Do this only
once in the parent function.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 4b3a14278a..23b1908a5c 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -202,8 +202,8 @@ static const char *get_upstream_ref(struct branch *branch, const char *remote_na
 	return branch->merge[0]->src;
 }
 
-static void setup_push_upstream(struct remote *remote, struct branch *branch,
-				int triangular)
+static const char *setup_push_upstream(struct remote *remote, struct branch *branch,
+	int triangular)
 {
 	const char *upstream_ref;
 	upstream_ref = get_upstream_ref(branch, remote->name);
@@ -212,16 +212,15 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
 		      "your current branch '%s', without telling me what to push\n"
 		      "to update which remote branch."),
 		    remote->name, branch->name);
-
-	refspec_appendf(&rs, "%s:%s", branch->refname, upstream_ref);
+	return upstream_ref;
 }
 
-static void setup_push_current(struct remote *remote, struct branch *branch)
+static const char *setup_push_current(struct remote *remote, struct branch *branch)
 {
-	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
+	return branch->refname;
 }
 
-static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
+static const char *setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
 {
 	if (!triangular) {
 		const char *upstream_ref;
@@ -232,7 +231,7 @@ static void setup_push_simple(struct remote *remote, struct branch *branch, int
 		if (strcmp(branch->refname, upstream_ref))
 			die_push_simple(branch, remote);
 	}
-	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
+	return branch->refname;
 }
 
 static int is_workflow_triangular(struct remote *remote)
@@ -245,6 +244,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 {
 	struct branch *branch;
 	int triangular = is_workflow_triangular(remote);
+	const char *dst;
 
 	switch (push_default) {
 	case PUSH_DEFAULT_MATCHING:
@@ -266,17 +266,19 @@ static void setup_default_push_refspecs(struct remote *remote)
 	default:
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
-		setup_push_simple(remote, branch, triangular);
-		return;
+		dst = setup_push_simple(remote, branch, triangular);
+		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-		setup_push_upstream(remote, branch, triangular);
-		return;
+		dst = setup_push_upstream(remote, branch, triangular);
+		break;
 
 	case PUSH_DEFAULT_CURRENT:
-		setup_push_current(remote, branch);
-		return;
+		dst = setup_push_current(remote, branch);
+		break;
 	}
+
+	refspec_appendf(&rs, "%s:%s", branch->refname, dst);
 }
 
 static const char message_advice_pull_before_push[] =
-- 
2.32.0.rc0

