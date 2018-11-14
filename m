Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19AE61F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbeKNKO4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:14:56 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:44190 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbeKNKO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:14:56 -0500
Received: by mail-pf1-f202.google.com with SMTP id 129-v6so11702776pfx.11
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=D2k+iH8QhVa1BNqc2yyTHw7BYpFZyZ6tcgdp5lnz6LM=;
        b=hxqXG7qbhiUkj9EA7ZRNRK0PElPLfBGKQPwF9EBxe2ucTx82NXiDu+trLvUXVTNrQl
         LRxpmeUKgU+yDgjb9zCoRjxg6fZV2TXQ/rt0QUwmb/9/6VNP6+EpbB8q6Rs40GOV0ZjI
         dStuaZFcZH3sfk4Lt4qOJkTZqYMyfRa9GLBZaG7NEjEF7ZKLBJqsOyQiPL5jeTO/Zt3A
         7hlC3zaBiDORq3pmF/u9TQgJS7w9FU8fq88wHWrvNiE+/ZhmrGBez3/ZWHyLjkQkfrKn
         0vQMQKnRDIRK7Xjy+wr7O4jSKDhSDFoMGbuQDf0JtQlukyb8L1RfobRR1guEQqdtq3mB
         IPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D2k+iH8QhVa1BNqc2yyTHw7BYpFZyZ6tcgdp5lnz6LM=;
        b=WSz0tH7hnHeV4+6wek0al6j5r2H+B5UADc+EANtxpjvl5jVlEihkx1Qg3jkmeM/9RJ
         7pX0ApzqBCBFOvBcmq5zMwsVhNM9EaYCZgXJnEpVL9gCECvCaf4B63rVOy3mAHee1W7O
         BZ2W/KQ7Q/RuWRvMJNWFKIcG8y/efrgYn5zDlkUr69Et0E8uX49FVDTzAf7vN4i7LAIw
         Hp1yb2JtNnlaUxnt216frH2VLeNYnziDKfYHyNNz1tuCRDtP4Q29NWckjo+d8U5AVhNs
         2UvmnpJwSEN2B+W/SaW8429FuCsnEA2Eei6Q1uC2qFt1z3DvvTNN2SAyzo3nNw9AuhFW
         6ozw==
X-Gm-Message-State: AGRZ1gJSohSNEKYYyRuxnHOQbfJEsrw4E8OnXkN90S2x9Pu/hkAZ8HS4
        vgtBpY+hps8iPjqDMDLE6rME1vQXyGV6
X-Google-Smtp-Source: AJdET5c0Ut3zSVaLBz2PjqqycKjB28crg/HDarR54lTYF4ydrE+3fKYkaAM2k7CEt03ehqg+zgX+ADmRT6Z9
X-Received: by 2002:a62:e053:: with SMTP id f80mr93443pfh.106.1542154452993;
 Tue, 13 Nov 2018 16:14:12 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:12:59 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-17-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 16/23] commit: prepare logmsg_reencode to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.h                                        |  8 ++++++++
 contrib/coccinelle/the_repository.pending.cocci |  9 +++++++++
 pretty.c                                        | 13 +++++++------
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/commit.h b/commit.h
index 57375e3239..2e6b799b26 100644
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
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 516f19ffee..f5b42cfc62 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -123,3 +123,12 @@ expression F;
 - unuse_commit_buffer(
 + repo_unuse_commit_buffer(the_repository,
   E, F);
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
index 8ca29e9281..b359b68750 100644
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
2.19.1.1215.g8438c0b245-goog

