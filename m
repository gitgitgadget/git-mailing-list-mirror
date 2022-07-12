Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2805BC433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 16:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiGLQHZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 12:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiGLQHE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 12:07:04 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A957BC84F8
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 09:07:03 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so11931140pjo.3
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 09:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cFJvu+AqqPOe9XgzLb+7cbOS+hj7hA1P6aUDOl8dz74=;
        b=pwcFjxZ3S+idz33d+xSg1lXSYv6oyIhXGROrOTNyeP4LBFauEBnfh3/0NKhjjEGcEa
         H7clM95WYADgPN0WgBV8XTOM4eWomGXA5T0wUQ8VTNgYJYbHofckbpJhxxmDLxOWXzJT
         MsVnIE9ZUUY9laoOzS7Y0cvPFXz73SeBQlDoEHH6wThftj+Yf5Syn2kYBxIomxfCWfC5
         hpBN9fmMLbD9oIwNnkHyQE4NTwBYB7hDCD/2B/svLBceXxMvsEj7cM6KTBbqAUKAUn/v
         g0wEugg8QPngiyoWz5ckd9RUf2M7Nn27epMRvN3sLZ5VylDlBxbeMvDU6bsW4xJm0mG9
         DF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cFJvu+AqqPOe9XgzLb+7cbOS+hj7hA1P6aUDOl8dz74=;
        b=h0puhWpTlykMwulnsMgCmkVKJZwSrPcKHruJP0RYjpXRqrQ30FvuipoG24RVfU8u8N
         it4wgAAq64fFSL9o/Wj4Q/hHs4XiQdVl5XH8bfEjWxvZwtic9x4o12p+meCEqNsDed5e
         NPvR5G/siPRNd8TqiqaNpA76+o5aGQToaKkohuiVOl0kkzbg+82CMwPQO/3FrWUkUBCl
         3u+DvS6Vd5nw8B82yLiBgnQ9uAU8hMQf2c6cUvRzENipikRohyh4xUPds35+OWx660sy
         /7M3mWOuBwldueom1z7GRFoBOQ4hEsvyWXck3VPukzC5QHfatBY2gKCzFcthNgwjhnlB
         UA/w==
X-Gm-Message-State: AJIora8yjb9OITgYJVHZiCOhYLs19t7pIFoLguhiSibLer85dqQTtg1E
        8dKrbXeT2VMLAyCtmaKQMQgQTgRUhalIzw==
X-Google-Smtp-Source: AGRyM1vlBH8NEpwVUEbv/i+rMUr5J6xUXN1pxtvPrawy2aSjSR08JPIttr44qbJi+0XNmf/61m6W9A==
X-Received: by 2002:a17:902:ccd0:b0:16c:5d4f:99f3 with SMTP id z16-20020a170902ccd000b0016c5d4f99f3mr3526967ple.139.1657642022689;
        Tue, 12 Jul 2022 09:07:02 -0700 (PDT)
Received: from HB2.. ([223.230.62.254])
        by smtp.gmail.com with ESMTPSA id u188-20020a6260c5000000b0050dc7628183sm7232376pfb.93.2022.07.12.09.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:07:02 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, congdanhqx@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v4 3/4] ident: rename commit_rewrite_person() to apply_mailmap_to_header()
Date:   Tue, 12 Jul 2022 21:36:33 +0530
Message-Id: <20220712160634.213956-4-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.0.6.g69b7ad898b
In-Reply-To: <20220712160634.213956-1-siddharthasthana31@gmail.com>
References: <20220709154149.165524-1-siddharthasthana31@gmail.com>
 <20220712160634.213956-1-siddharthasthana31@gmail.com>
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
 ident.c    | 2 +-
 revision.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index c9dbe1c29a..9edb7fefd3 100644
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
-void commit_rewrite_person(struct strbuf *buf, const char **commit_headers, struct string_list *mailmap);
+void apply_mailmap_to_header(struct strbuf *buf, const char **headers, struct string_list *mailmap);
 
 /*
  * Compare split idents for equality or strict ordering. Note that we
diff --git a/ident.c b/ident.c
index 9f4f6e9071..5f17bd607d 100644
--- a/ident.c
+++ b/ident.c
@@ -393,7 +393,7 @@ static ssize_t rewrite_ident_line(const char* person, struct strbuf *buf, struct
 	return 0;
 }
 
-void commit_rewrite_person(struct strbuf *buf, const char **headers, struct string_list *mailmap)
+void apply_mailmap_to_header(struct strbuf *buf, const char **headers, struct string_list *mailmap)
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
2.37.0.6.g69b7ad898b

