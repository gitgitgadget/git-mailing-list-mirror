Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F58DEEB581
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 06:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241795AbjIIGQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 02:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbjIIGQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 02:16:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BDE1BEA
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 23:16:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31c7912416bso2833379f8f.1
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 23:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694240183; x=1694844983; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YK2z70GM8Fp4oC98UaS8TS5iRN8Wgk4+ZVqIY4alM2I=;
        b=J3vNOhwCgy07upl/fec0V94lZ2NHk/Fi79HToFYo1TZiXwXTEmaAuZ/ERW6x2x7dq1
         nVmJUbSNmkBOY1BqPF9fNefUdidJJepelStIXwS5R5CmNmfSWPY4Lx3BGsKwuXej8Z60
         kOYG/Ce45E2p7lesIHf+EDZ47C+pJbRpe5ybHIwlx9B55VJcwq0ViAldLim6prxhYcXE
         kKRxO20lhVJTQfDV92PLG9Zp01RrK0R2wHrPiU9JYvGvmL2nr45W4WvTu93YSlNkhkgs
         9qj6f5Xh0jwhKyeuA8LHZEX9hQF6ibKKdD7tyfAgIHlQBC8BYr0SflWuHcJkNyq96gRe
         8KkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694240183; x=1694844983;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YK2z70GM8Fp4oC98UaS8TS5iRN8Wgk4+ZVqIY4alM2I=;
        b=J3OS9Fb7/3c+PhKyno5lvHN8Oc2LciX6dpXWKfHYha+VRdMm41SitRZvHZFMH+uQoi
         3D7dlZzSRMWnfuk9/4nPe0fkNJ4zJ3/meI1R4GBDVWeTznbR/rDsM5I4Sf+lyzHubOFf
         DAP9P22Kq09SNAQ+WQs8ZDDSGpvzadNHjTSp36nL2F/KJydcKyiNoWfSIzQpU+u7XvVQ
         /iv5mIAXSAmojrSQAF5Hct3W5/RhGprSSpH0M+tewNZk0Lj2DDws605q6M5uEbgC+BYQ
         FA0jhd7dn+Xh6zHj9RIF/a0X+OIop3WuU3StDTgvotuYB2JrE4raHjWKMFJs4I87iE0b
         ED0Q==
X-Gm-Message-State: AOJu0YzTkPCka4A2ZgrIar/aL4BDhVafLkgWDgLJ/VrVRiraZ8aXwjKG
        e+RnxfnDawwfm6/fJ+57/ygIhtFvHGU=
X-Google-Smtp-Source: AGHT+IGneyhP2tfsfDTsNrrlOcUEgz/RgYKuRxddMVhjy8h7FBtlIaBowOEXp8CoDU5jAbopjS82KA==
X-Received: by 2002:a5d:42ca:0:b0:31c:6409:df17 with SMTP id t10-20020a5d42ca000000b0031c6409df17mr3450161wrr.41.1694240183372;
        Fri, 08 Sep 2023 23:16:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 14-20020a056000154e00b0031f8be5b41bsm825731wry.5.2023.09.08.23.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 23:16:22 -0700 (PDT)
Message-ID: <0463066ebe0889b72b6a1f6c344f2de127458391.1694240177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
        <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 Sep 2023 06:16:17 +0000
Subject: [PATCH v2 6/6] trailer: use offsets for trailer_start/trailer_end
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Previously these fields in the trailer_info struct were of type "const
char *" and pointed to positions in the input string directly (to the
start and end positions of the trailer block).

Use offsets to make the intended usage less ambiguous. We only need to
reference the input string in format_trailer_info(), so update that
function to take a pointer to the input.

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 17 ++++++++---------
 trailer.h |  7 +++----
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/trailer.c b/trailer.c
index 6ad2fbca942..00326720e81 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1055,7 +1055,6 @@ void process_trailers(const char *file,
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
 	struct trailer_info info;
-	size_t trailer_end;
 	FILE *outfile = stdout;
 
 	ensure_configured();
@@ -1066,11 +1065,10 @@ void process_trailers(const char *file,
 		outfile = create_in_place_tempfile(file);
 
 	parse_trailers(&info, sb.buf, &head, opts);
-	trailer_end = info.trailer_end - sb.buf;
 
 	/* Print the lines before the trailers */
 	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, info.trailer_start - sb.buf, outfile);
+		fwrite(sb.buf, 1, info.trailer_start, outfile);
 
 	if (!opts->only_trailers && !info.blank_line_before_trailer)
 		fprintf(outfile, "\n");
@@ -1092,7 +1090,7 @@ void process_trailers(const char *file,
 
 	/* Print the lines after the trailers as is */
 	if (!opts->only_trailers)
-		fwrite(sb.buf + trailer_end, 1, sb.len - trailer_end, outfile);
+		fwrite(sb.buf + info.trailer_end, 1, sb.len - info.trailer_end, outfile);
 
 	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
@@ -1104,7 +1102,7 @@ void process_trailers(const char *file,
 void trailer_info_get(struct trailer_info *info, const char *str,
 		      const struct process_trailer_options *opts)
 {
-	int patch_start, trailer_end, trailer_start;
+	size_t patch_start, trailer_end = 0, trailer_start = 0;
 	struct strbuf **trailer_lines, **ptr;
 	char **trailer_strings = NULL;
 	size_t nr = 0, alloc = 0;
@@ -1139,8 +1137,8 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 
 	info->blank_line_before_trailer = ends_with_blank_line(str,
 							       trailer_start);
-	info->trailer_start = str + trailer_start;
-	info->trailer_end = str + trailer_end;
+	info->trailer_start = trailer_start;
+	info->trailer_end = trailer_end;
 	info->trailers = trailer_strings;
 	info->trailer_nr = nr;
 }
@@ -1155,6 +1153,7 @@ void trailer_info_release(struct trailer_info *info)
 
 static void format_trailer_info(struct strbuf *out,
 				const struct trailer_info *info,
+				const char *msg,
 				const struct process_trailer_options *opts)
 {
 	size_t origlen = out->len;
@@ -1164,7 +1163,7 @@ static void format_trailer_info(struct strbuf *out,
 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
 	    !opts->separator && !opts->key_only && !opts->value_only &&
 	    !opts->key_value_separator) {
-		strbuf_add(out, info->trailer_start,
+		strbuf_add(out, msg + info->trailer_start,
 			   info->trailer_end - info->trailer_start);
 		return;
 	}
@@ -1219,7 +1218,7 @@ void format_trailers_from_commit(struct strbuf *out, const char *msg,
 	struct trailer_info info;
 
 	trailer_info_get(&info, msg, opts);
-	format_trailer_info(out, &info, opts);
+	format_trailer_info(out, &info, msg, opts);
 	trailer_info_release(&info);
 }
 
diff --git a/trailer.h b/trailer.h
index a689d768c79..13fbf0dcd12 100644
--- a/trailer.h
+++ b/trailer.h
@@ -37,11 +37,10 @@ struct trailer_info {
 	int blank_line_before_trailer;
 
 	/*
-	 * Pointers to the start and end of the trailer block found. If there
-	 * is no trailer block found, these 2 pointers point to the end of the
-	 * input string.
+	 * Offsets to the trailer block start and end positions in the input
+	 * string. If no trailer block is found, these are set to 0.
 	 */
-	const char *trailer_start, *trailer_end;
+	size_t trailer_start, trailer_end;
 
 	/*
 	 * Array of trailers found.
-- 
gitgitgadget
