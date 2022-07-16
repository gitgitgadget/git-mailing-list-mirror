Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BC4C43334
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 07:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiGPHlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 03:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiGPHla (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 03:41:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396FE3A48A
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 00:41:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p9so7467806pjd.3
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 00:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QJxZj0Jrgy5mlqfq/AM1YpVdYgsX4/X/ABLCtc7qxKE=;
        b=NGOXP48eQNn73BiDffHkDZZK9HNQx9cPVKXoPz/CU2F0sPC3ncphnejJL9vVRY3doF
         PDhw6mFV1L6T0O0bId9KaLb/7IlyKru7Ez6jwWkxCYLVmsiiHUKVR/+pOflRTkvtHX4+
         wVQrG7Xz+YTIhvooIjT4yQbLC8o/ALNmSfQdCc+na+jzKgF6CRxtYl6MPFH8V8iGRhF8
         Kl0AaA/CHHIesK3w8rddZGDSsBwSkYY1v0RbDyUXWsgPHhwafFkUsvnLwrkY504XCP7l
         pM+a6ocY06gBkkHFNgNZ09jEy+gCJzJGwTJPgCQ+yQuFuPcZiJy1YmL9X/w7t/Y1moOZ
         g9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJxZj0Jrgy5mlqfq/AM1YpVdYgsX4/X/ABLCtc7qxKE=;
        b=WCjIOXfU5XVHvEer1w7PRXzgSqtWjimGkcEqZIdZCn9SpVpTQxDQIQ8aoW3BgkldBS
         TWBxiJfG2sus9+duAVu2eupsBXcOUxw+uIiqJ3lOq0ELdjUuiqwaG4ePWaIKNqv8iyWY
         bc8UQ1bWG7r3+eyTUQxqsLPsgEHPxeY2hLqDvCKg9E2KeatKjH7GDlEoR84tJrZ/1+i6
         G+a9LvSX3bJGFSMG+nUUNtA1OIqp6Cx2zLWtrbQOlGNzTxT9OQbhX9kiOT4hOZrF8rJu
         qGDRGE3EZBumdeFKCmcFd9WOz3ZYbQ8rhS+hWRmk7xlRlJD22VLKD7m7qRr5X29c54lX
         b+UQ==
X-Gm-Message-State: AJIora96ohAUq5JvE8TTVbHU2mAPedsr2Lgm7oJe6sMhCJuE7Nldsk2q
        1jlH4VomTD4OzrV8un0m7bvO4/ZiUOA5nNXz
X-Google-Smtp-Source: AGRyM1vMoOwL/lCl3aYw1A0qR0JEAMyN1i8nFbHEWy93nWXB94sN34pzOtVqAGaZajPICi0+j8TRNA==
X-Received: by 2002:a17:902:e891:b0:16c:3344:d8a0 with SMTP id w17-20020a170902e89100b0016c3344d8a0mr17391230plg.62.1657957288114;
        Sat, 16 Jul 2022 00:41:28 -0700 (PDT)
Received: from HB2.. ([110.225.168.189])
        by smtp.gmail.com with ESMTPSA id i27-20020a63541b000000b004161e62a3a5sm4325923pgb.78.2022.07.16.00.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 00:41:27 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, congdanhqx@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v5 3/4] ident: rename commit_rewrite_person() to apply_mailmap_to_header()
Date:   Sat, 16 Jul 2022 13:10:54 +0530
Message-Id: <20220716074055.1786231-4-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.1.120.g001f220fb8
In-Reply-To: <20220716074055.1786231-1-siddharthasthana31@gmail.com>
References: <20220712160634.213956-1-siddharthasthana31@gmail.com>
 <20220716074055.1786231-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit_rewrite_person() takes a commit buffer and replaces the idents
in the header with their canonical versions using the mailmap mechanism.
The name "commit_rewrite_person()" is misleading as it doesn't convey
what kind of rewrite are we going to do to the buffer. It also doesn't
clearly mention that the function will limit itself to the header part
of the buffer. The new name, "apply_mailmap_to_header()", expresses the
functionality of the function pretty clearly.

We intend to use apply_mailmap_to_header() in git-cat-file to replace
idents in the headers of commit and tag object buffers. So, we will be
extending this function to take tag objects buffer as well and replace
idents on the tagger header using the mailmap mechanism.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 cache.h    | 6 +++---
 ident.c    | 4 ++--
 revision.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 16a08aada2..4aa1bd079d 100644
--- a/cache.h
+++ b/cache.h
@@ -1689,10 +1689,10 @@ struct ident_split {
 int split_ident_line(struct ident_split *, const char *, int);
 
 /*
- * Given a commit object buffer and the commit headers, replaces the idents
- * in the headers with their canonical versions using the mailmap mechanism.
+ * Given a commit or tag object buffer and the commit or tag headers, replaces
+ * the idents in the headers with their canonical versions using the mailmap mechanism.
  */
-void commit_rewrite_person(struct strbuf *, const char **, struct string_list *);
+void apply_mailmap_to_header(struct strbuf *, const char **, struct string_list *);
 
 /*
  * Compare split idents for equality or strict ordering. Note that we
diff --git a/ident.c b/ident.c
index 83007e3e5d..c0f56bc752 100644
--- a/ident.c
+++ b/ident.c
@@ -394,8 +394,8 @@ static ssize_t rewrite_ident_line(const char *person, struct strbuf *buf,
 	return 0;
 }
 
-void commit_rewrite_person(struct strbuf *buf, const char **header,
-						   struct string_list *mailmap)
+void apply_mailmap_to_header(struct strbuf *buf, const char **header,
+							 struct string_list *mailmap)
 {
 	size_t buf_offset = 0;
 
diff --git a/revision.c b/revision.c
index 14dca903b6..6ad3665204 100644
--- a/revision.c
+++ b/revision.c
@@ -3792,7 +3792,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 		if (!buf.len)
 			strbuf_addstr(&buf, message);
 
-		commit_rewrite_person(&buf, commit_headers, opt->mailmap);
+		apply_mailmap_to_header(&buf, commit_headers, opt->mailmap);
 	}
 
 	/* Append "fake" message parts as needed */
-- 
2.37.1.120.g001f220fb8

