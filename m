Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7802C1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 20:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388809AbfKHUIc (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 15:08:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45154 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388674AbfKHUIb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 15:08:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id w11so4608369pga.12
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 12:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0DoWm0A7VQBZW3Lg8j3CyYuCKT3yzFB03195yAJyrKI=;
        b=Fkl3v9K4mHdmymiMD4dsn7YgMRKIF6e0QiWLqqS0HSF3/XldTZCqKZ+8qwK2mca7rv
         BigCDVFm4dZ4Lo0QHI1FGXAF2LeELGQDJSweu0zXgDfCI5J/5Vw/fPVb5ouGJugGcU19
         XWj51LLLlwqWAJodtjvrnC8jzip8fAkDbz3u2oAX/w6kaj/dTg8CRQup/Xp/jMKCIzLu
         aD9f6MoqxR4O1XGhpCRTeba/u5h3X8qYNL8z3Kf6LtWIilkuL1kZkanpFjPkPB7eCQ7H
         nDFS7dTm4gcUq20ckvUnKSm56kqncW+oQCI8P+FX/FbzM08iFBzY1pFMfSPk3ye2w5J0
         I1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0DoWm0A7VQBZW3Lg8j3CyYuCKT3yzFB03195yAJyrKI=;
        b=GbTzdhcfWw4jhJiDyfdxmnzz0H9O/is3NuGbzw6uudPx2B6/penPWP4CslgEXLfoGp
         ZwoOLAUGrxYhwzK7ptvKae7Dv8kEA9SuM3D/l+AOxx/Yy/Eq9Ij0+ftQ5pZjCMq2RNG1
         HhCfzEFQev14vy0T5D5N+4WnFglYlkv36iXXIini5VBwk8ZBeTY4D8DiZWTyhqWC18Ll
         WvIWpGusBIEiGSrkjVW4kY+bw/lqTcVAUWwyemkrj87j2fZqXbbDYWsjXiPeXbD+2Iw3
         LAemLzfC0mitVDPv+CrdG9eovUZQli5dxWXTlde+scwlyzNb+FYwHP8TDGS7kGUd98Vz
         9l0g==
X-Gm-Message-State: APjAAAWfTlNPmxcCbFAAv1SWfAWR6JxaVF6izvgOGBwr6ArcaE68FrUU
        F3o0+eoqKQUfRdLantUoH6mS/+fy
X-Google-Smtp-Source: APXvYqzpcMaey3Tf9lxp1tuKi2406yDxtNdPL1HRfK2zl49k33eY5PKJuCBZepL0W2d+1IS9t4Eyaw==
X-Received: by 2002:a63:ec50:: with SMTP id r16mr11593968pgj.284.1573243709989;
        Fri, 08 Nov 2019 12:08:29 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id y36sm6358959pgk.66.2019.11.08.12.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 12:08:29 -0800 (PST)
Date:   Fri, 8 Nov 2019 12:08:28 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/10] pretty.c: extract functionality to
 repo_format_commit_generic()
Message-ID: <fd2bbcd16972b9f41bff995eda3c5a1b87fe98a6.1573241590.git.liu.denton@gmail.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
 <cover.1573241590.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573241590.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we will be reusing common functionality from
repo_format_commit_message(). Extract this common functionality into
repo_format_commit_generic() so that it can be reused in the future.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 pretty.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/pretty.c b/pretty.c
index 6f2b0ad917..a6e5fc115a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1605,10 +1605,14 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w)
 	strbuf_release(&dummy);
 }
 
-void repo_format_commit_message(struct repository *r,
-				const struct commit *commit,
-				const char *format, struct strbuf *sb,
-				const struct pretty_print_context *pretty_ctx)
+static void repo_format_commit_generic(struct repository *r,
+				       const struct commit *commit,
+				       struct strbuf *sb,
+				       const struct pretty_print_context *pretty_ctx,
+				       void (*fn)(struct strbuf *,
+						  struct format_commit_context *,
+						  void *),
+				       void *data)
 {
 	struct format_commit_context context = {
 		.commit = commit,
@@ -1625,9 +1629,7 @@ void repo_format_commit_message(struct repository *r,
 					       &context.commit_encoding,
 					       utf8);
 
-	context.wrap_start = sb->len;
-	strbuf_expand(sb, format, format_commit_item, &context);
-	rewrap_message_tail(sb, &context, 0, 0, 0);
+	fn(sb, &context, data);
 
 	/* then convert a commit message to an actual output encoding */
 	if (output_enc) {
@@ -1651,6 +1653,25 @@ void repo_format_commit_message(struct repository *r,
 	repo_unuse_commit_buffer(r, commit, context.message);
 }
 
+static void do_repo_format_commit_message(struct strbuf *sb,
+					  struct format_commit_context *context,
+					  void *data)
+{
+	const char *format = data;
+	context->wrap_start = sb->len;
+	strbuf_expand(sb, format, format_commit_item, context);
+	rewrap_message_tail(sb, context, 0, 0, 0);
+}
+
+void repo_format_commit_message(struct repository *r,
+				const struct commit *commit,
+				const char *format, struct strbuf *sb,
+				const struct pretty_print_context *pretty_ctx)
+{
+	repo_format_commit_generic(r, commit, sb, pretty_ctx,
+				   do_repo_format_commit_message, (void *)format);
+}
+
 static void pp_header(struct pretty_print_context *pp,
 		      const char *encoding,
 		      const struct commit *commit,
-- 
2.24.0.298.g3e88fbd976

