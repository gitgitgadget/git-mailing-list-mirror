Return-Path: <SRS0=qItC=6C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F930C352BE
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 20:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9DD21D93
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 20:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZ9HdTvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgDRUS6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727927AbgDRUS5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Apr 2020 16:18:57 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601E6C061A0C
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 13:18:57 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r7so5686712ljg.13
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 13:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UCXzrL/gM6cVJk20aTlr3/YzVSvu4ZTXyduC2AEG228=;
        b=oZ9HdTvpi/qQFj6CdfCTiJk6VFGqpND7Vt9wKtMCY8itpKnYhJB6E4u+qc4e8kQgm4
         4lNBuObjJcjHZbtdWJ2FQyo9AyQ5AelAQ1LV24wsoGWTxbMd8lU2AqZQFL2E4qMuyfYb
         0NfPqKbr5gVT2IijpkpjG+W/VkTO0lCJvdClNGTi8PspYqGr/RhhbhqaZLYiP6ZNiqTg
         gGE9OYjJS/qGSd+VNFgCSEpu8nChSlCdKSSr17ZdNPDPbJSjewseQrEZAmPXQwpgiIYV
         Nr5lW+QH/RxMcOPI4Bnnp+wGqFt/z45OIPJ2F1sly1lLgFlUdw+tbJPHbp0tThrI3eRu
         TBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UCXzrL/gM6cVJk20aTlr3/YzVSvu4ZTXyduC2AEG228=;
        b=Yed/vSJO3LI/QRaiQxlFcw9bXgw3qP90Vi/dijKwI2+knj9Y0r+VFzSL2gAGC+1yEH
         +Sf0oW0hLS4nw2O7CXfMKjEVnQ3Z7N1KJzNt3njbLx7YjvJYhNH7CX4R2sM4aauVR8Vd
         fJCvlUK27ySugjN1eCFhbM432kcPbPVwagmWGE1arjj0Kg+EgwNOThpbsGIYvaDeR5ui
         HW9QvnDZtap7dxQQz1RMUxWIkokY//9DalvSubtMGSbqjtDyjfPWa/fk4IJuYNNIgmJ4
         Lx8IBnX3Wt8uipdKVMxbwbZF5cYCN4j//XQb/lKv7URNRLpid6RSXPzu7nSlOlSV4TaZ
         OwpQ==
X-Gm-Message-State: AGi0PuY7UNS0z9RJonEo+qd/GdFyt3Wdxx08/L6cqXW8YgXlOlwNoKbG
        LATLHH0MJX+d42U0dbv88MluthhJ
X-Google-Smtp-Source: APiQypK5MuMcwPDwfEAp+SMXXNyYZwRP5eaipb3ny8kbnTMHCBQe8wJs0+QFg/KDaTAyUYLOVRIWrw==
X-Received: by 2002:a2e:3209:: with SMTP id y9mr92381ljy.154.1587241135618;
        Sat, 18 Apr 2020 13:18:55 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id 73sm218713ljj.72.2020.04.18.13.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:18:55 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 2/6] strbuf_attach: correctly pass in `strlen() + 1` for `alloc`
Date:   Sat, 18 Apr 2020 22:18:25 +0200
Message-Id: <54f3966f1f3a3e88bcd650cce89b47e650ba005b.1587240635.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587240635.git.martin.agren@gmail.com>
References: <CAN0heSppn6BBX4V1T1qgKc4XP+8i6qbcEqd1_3NqWQtZJLaJww@mail.gmail.com> <cover.1587240635.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is similar to the previous commit where we corrected a use of
`strbuf_attach()` to not pass in the same value for `len` and `alloc`.
The sites addressed in this commit all use `strlen()`, which makes it
obvious that we're working with NUL-terminated strings and that we can
safely switch to providing `len + 1` for `alloc`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 mailinfo.c           | 2 +-
 path.c               | 2 +-
 refs/files-backend.c | 2 +-
 trailer.c            | 3 ++-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 742fa376ab..af5d2cad31 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -459,7 +459,7 @@ static int convert_to_utf8(struct mailinfo *mi,
 		return error("cannot convert from %s to %s",
 			     charset, mi->metainfo_charset);
 	}
-	strbuf_attach(line, out, strlen(out), strlen(out));
+	strbuf_attach(line, out, strlen(out), strlen(out) + 1);
 	return 0;
 }
 
diff --git a/path.c b/path.c
index 9bd717c307..5745a71d36 100644
--- a/path.c
+++ b/path.c
@@ -816,7 +816,7 @@ const char *enter_repo(const char *path, int strict)
 			if (!newpath)
 				return NULL;
 			strbuf_attach(&used_path, newpath, strlen(newpath),
-				      strlen(newpath));
+				      strlen(newpath) + 1);
 		}
 		for (i = 0; suffix[i]; i++) {
 			struct stat st;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 561c33ac8a..76bb2ef490 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1514,7 +1514,7 @@ static int commit_ref(struct ref_lock *lock)
 		size_t len = strlen(path);
 		struct strbuf sb_path = STRBUF_INIT;
 
-		strbuf_attach(&sb_path, path, len, len);
+		strbuf_attach(&sb_path, path, len, len + 1);
 
 		/*
 		 * If this fails, commit_lock_file() will also fail
diff --git a/trailer.c b/trailer.c
index 0c414f2fed..135f71aef1 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1095,7 +1095,8 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 	for (ptr = trailer_lines; *ptr; ptr++) {
 		if (last && isspace((*ptr)->buf[0])) {
 			struct strbuf sb = STRBUF_INIT;
-			strbuf_attach(&sb, *last, strlen(*last), strlen(*last));
+			strbuf_attach(&sb, *last, strlen(*last),
+				      strlen(*last) + 1);
 			strbuf_addbuf(&sb, *ptr);
 			*last = strbuf_detach(&sb, NULL);
 			continue;
-- 
2.26.1

