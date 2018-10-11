Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19B921F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 21:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeJLEri (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:47:38 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:43070 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJLErh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:47:37 -0400
Received: by mail-yb1-f201.google.com with SMTP id c6-v6so5099296ybm.10
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g/RZAUtkjwNelc7ZyGAmenZWdtG7DXhqBOZRTLYCfOQ=;
        b=YtSHRco4CODNQlJLulzPN5yfRnbI7xsVg2jOzq4dQP1TZFAc6kcOKy0iI1KoYQEJY4
         /Z26dXlvgA0JNnDsSHVi2hutkzzr4lOG906zT0/Gg5Yeu2QkIMpPJYi18zez5IjdGVsE
         odLFHdBYww0Hy1papQf/ZzCLn+kAlkcHE2qdLwlzoqhmnkiLEzr23LaXV3XbXREsllgc
         A5RMf5BS43aQjyVci4J60cM1Z20YmLXmQGSKOQSNDn4BG855Z4Rca8VQi+vySATHJl+S
         7cAfGHlwMk/ozBwPVDba6fXKHypfUfSI1/06c0rcq4amjSG/wTfQPeEL+7WlkbC5hRG+
         MMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g/RZAUtkjwNelc7ZyGAmenZWdtG7DXhqBOZRTLYCfOQ=;
        b=S5GlPrGuxX2MfmNnqoNzbb61sPCrz0g9ToPxutxMHHBIm0M+deDxT3++PPh6sH8uYu
         8/+fqtfYPapqGj9IfVcW+hsy2DYSoVYsb2/OXf6tk8rq7fmzLvaAA2UoBAjBgflAkeA/
         yqhtAtfe88bUmjdIAZP1CR7bcNS2uDV5edP1XOBgj94aAHLPs9ZSjWNaUX5CDCSWNDkY
         1pZRqUX2ilLZY0cKBb7vn8hhzkymN0gm8m0bHRIc3E17VPqyjgHhpkbjWFVVUl6EkTgC
         5LlfrbyVk0uXdJkfFQJOCF29YRSJ/tVTFyKMvsZ5imEslEs194tCkrvKsHun1Ui2U76q
         bXQA==
X-Gm-Message-State: ABuFfohhclrOcf/BJJJ0q7zPGvzpykWTn7yHBMTg8Ip4yUsTjBBrmlkj
        8NPVagQ3LOLWhuD4ruj2DMm3f6c7HTzIDFwDCsv+WkfoPQdkNUuoM948IPHwo7FWwvkjoGgEJFj
        Hec8+gXCthS2S59K77SJ/OlT5pC/S1sP54kMrHvuBdJnfBRXRHIjizNbO4TiP
X-Google-Smtp-Source: ACcGV62Ln4Cnr9OBUKFkCxC0PD7itUPJUOQHpZFX/g36EqseSfZhjviWffSYuLVJMa1WQoZgrifLR4yDUmQ2
X-Received: by 2002:a25:9888:: with SMTP id l8-v6mr1849469ybo.37.1539292712715;
 Thu, 11 Oct 2018 14:18:32 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:17:50 -0700
In-Reply-To: <20181011211754.31369-1-sbeller@google.com>
Message-Id: <20181011211754.31369-16-sbeller@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 15/19] commit: prepare logmsg_reencode to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.h                                |  8 ++++++++
 contrib/coccinelle/the_repository.cocci |  9 +++++++++
 pretty.c                                | 13 +++++++------
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/commit.h b/commit.h
index 0976bf2562..61b05ddd91 100644
--- a/commit.h
+++ b/commit.h
@@ -180,6 +180,14 @@ extern int has_non_ascii(const char *text);
 extern const char *logmsg_reencode(const struct commit *commit,
 				   char **commit_encoding,
 				   const char *output_encoding);
+const char *repo_logmsg_reencode(struct repository *r,
+				 const struct commit *commit,
+				 char **commit_encoding,
+				 const char *output_encoding);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define logmsg_reencode(c, enc, out) repo_logmsg_reencode(the_repository, c, enc, out)
+#endif
+
 extern const char *skip_blank_lines(const char *msg);
 
 /** Removes the first commit from a list sorted by date, and adds all
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index 8c07185195..c81708bb73 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -93,3 +93,12 @@ expression G;
 - in_merge_bases_many(
 + repo_in_merge_bases_many(the_repository,
   E, F, G);
+
+@@
+expression E;
+expression F;
+expression G;
+@@
+- logmsg_reencode(
++ repo_logmsg_reencode(the_repository,
+  E, F, G);
diff --git a/pretty.c b/pretty.c
index 98cf5228f9..26e44472bb 100644
--- a/pretty.c
+++ b/pretty.c
@@ -595,14 +595,15 @@ static char *replace_encoding_header(char *buf, const char *encoding)
 	return strbuf_detach(&tmp, NULL);
 }
 
-const char *logmsg_reencode(const struct commit *commit,
-			    char **commit_encoding,
-			    const char *output_encoding)
+const char *repo_logmsg_reencode(struct repository *r,
+				 const struct commit *commit,
+				 char **commit_encoding,
+				 const char *output_encoding)
 {
 	static const char *utf8 = "UTF-8";
 	const char *use_encoding;
 	char *encoding;
-	const char *msg = get_commit_buffer(commit, NULL);
+	const char *msg = repo_get_commit_buffer(r, commit, NULL);
 	char *out;
 
 	if (!output_encoding || !*output_encoding) {
@@ -630,7 +631,7 @@ const char *logmsg_reencode(const struct commit *commit,
 		 * the cached copy from get_commit_buffer, we need to duplicate it
 		 * to avoid munging the cached copy.
 		 */
-		if (msg == get_cached_commit_buffer(the_repository, commit, NULL))
+		if (msg == get_cached_commit_buffer(r, commit, NULL))
 			out = xstrdup(msg);
 		else
 			out = (char *)msg;
@@ -644,7 +645,7 @@ const char *logmsg_reencode(const struct commit *commit,
 		 */
 		out = reencode_string(msg, output_encoding, use_encoding);
 		if (out)
-			unuse_commit_buffer(commit, msg);
+			repo_unuse_commit_buffer(r, commit, msg);
 	}
 
 	/*
-- 
2.19.0

