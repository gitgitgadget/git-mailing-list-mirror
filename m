Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C088AC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 14:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbiF3OgB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237063AbiF3Ofp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 10:35:45 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9876F3467F
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 07:25:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g20-20020a17090a579400b001ed52939d72so3024849pji.4
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 07:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xy/I+EplgyB/GS249BF9za/rVFU5ltk8kxgEDHAUt2A=;
        b=oivpO6wRKOZvanjdS6RRyAwq78srZTFHPO49MdfFo8CQOpVBkTA11ekljd+51YfISr
         5pKb0sHAsejhZ5Q6XW7FmNpCIyJKfKDePcsEykfwX5mlwrUfu+QihOKr9Gh8IHxjAVQQ
         jPeWfA+9DSxs7q4P4hOHINnEDj00ZVeBQyaPVfbaP4lOny4WaF/g9fRkXtJJdLqDhPto
         5DZsQjdZJj77UzaSMHHKmLWFuKIuKbSZpx9uX/aiwq/RKxWR5YjodQt/ALqqZeDTMiTK
         k1jbuCid0Ceo7P8zim1xqXng1+w+Wnqqzbf+UFoTZ7n3yagyipL5V666pRXdRXK6cnLN
         bR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xy/I+EplgyB/GS249BF9za/rVFU5ltk8kxgEDHAUt2A=;
        b=tsOLS3hrLnI6RSknvu2Fn3rcL9hiRUvdTC/3rqQWA7+nlVQu9vg9MZC1Q0+l5xNU0K
         LB7HJp8dLU9UWfivHV7P2rX0Xci0DJ6nAbVdNZ5mUJI4P08Rgz00iQrSuLafJDPr7eaS
         i3jdXaOGj32UqzmBrgX6pvIdR6SprCxlBxaqakS0ugrQZuatBsNaJMV3GnGyRfxpDE9y
         ARZkM2Ue3Rfk6HTZQYGwjqTGurIljbpZvaGveGV6NoKHqvlhPpniSFH9zcB8cSP46NNL
         zIYMrAUaY9DiWsy/8mukyQfAWvEqllw0OZMNQ2LzIUD3FyG7gjohoHND3QMcgxjuzO6X
         jzNw==
X-Gm-Message-State: AJIora+sFeOZ19ySnn0H33w52wFtZMZs6bgCoamdxb55u8GViEik3IBY
        qHlvRXVnjiHQSrPkiNQTptvAUzXPTAFHNEnU
X-Google-Smtp-Source: AGRyM1uhymyTm/EAz93nwdzSAa7ATXTBBN9ropzaSlvqJ9DqW1BbHq3wvFVYkd4eUj6EPdpwAt+GrQ==
X-Received: by 2002:a17:90b:1c08:b0:1ec:ea57:14ba with SMTP id oc8-20020a17090b1c0800b001ecea5714bamr10380466pjb.17.1656599107615;
        Thu, 30 Jun 2022 07:25:07 -0700 (PDT)
Received: from HB2.. ([106.212.243.72])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b0016909678e2csm13647377ple.292.2022.06.30.07.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 07:25:07 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: [PATCH 2/3] ident: rename commit_rewrite_person() to rewrite_ident_line()
Date:   Thu, 30 Jun 2022 19:54:43 +0530
Message-Id: <20220630142444.651948-3-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.0.3.gdab82d6f0b
In-Reply-To: <20220630142444.651948-1-siddharthasthana31@gmail.com>
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We will be using commit_rewrite_person() in git-cat-file to rewrite
ident line in commit/tag object buffers.

Following are the reason for renaming commit_rewrite_person():
- the function can be used not only on a commit buffer, but also on a
  tag object buffer, so having "commit" in its name is misleading.
- the function works on the ident line in the commit/tag object buffers,
  just like "split_ident_line()". Since these functions are related they
  should have similar terms for uniformity.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
---
 cache.h    | 2 +-
 ident.c    | 2 +-
 revision.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 442bfe5f6a..c8a98d8a80 100644
--- a/cache.h
+++ b/cache.h
@@ -1694,7 +1694,7 @@ int split_ident_line(struct ident_split *, const char *, int);
  * name and email using mailmap mechanism. Signals a success with
  * 1 and failure with a 0.
  */
-int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap);
+int rewrite_ident_line(struct strbuf *buf, const char *what, struct string_list *mailmap);
 
 /*
  * Compare split idents for equality or strict ordering. Note that we
diff --git a/ident.c b/ident.c
index 8c890bd474..d15f579fd5 100644
--- a/ident.c
+++ b/ident.c
@@ -347,7 +347,7 @@ int split_ident_line(struct ident_split *split, const char *line, int len)
 	return 0;
 }
 
-int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap)
+int rewrite_ident_line(struct strbuf *buf, const char *what, struct string_list *mailmap)
 {
 	char *person, *endp;
 	size_t len, namelen, maillen;
diff --git a/revision.c b/revision.c
index da49e73cd6..0c8243a8e0 100644
--- a/revision.c
+++ b/revision.c
@@ -3790,8 +3790,8 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 		if (!buf.len)
 			strbuf_addstr(&buf, message);
 
-		commit_rewrite_person(&buf, "\nauthor ", opt->mailmap);
-		commit_rewrite_person(&buf, "\ncommitter ", opt->mailmap);
+		rewrite_ident_line(&buf, "\nauthor ", opt->mailmap);
+		rewrite_ident_line(&buf, "\ncommitter ", opt->mailmap);
 	}
 
 	/* Append "fake" message parts as needed */
-- 
2.37.0.3.g2093cce7fe.dirty

