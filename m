Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF94CE7ABA
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 19:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjIVTv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 15:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjIVTvI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 15:51:08 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6161B2
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:50:54 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-405524e6769so1667165e9.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695412252; x=1696017052; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIjzqide8w4bht+LrQY9bA4gqXbbebQ/O7VplvZnCaQ=;
        b=igPG0e0VqsVb6r7NuGB9UA/h9DdGWPp1Xpv3ywPE2xTBb1Ye/iyitVaKthvdNJtqYc
         TPQEsWi+f7L4PBrVkqjn4nsjBulFpG/9QHL5IUbqVk2HqiqRC1BwfSj++W1TvrReGHe7
         gkXzHL/DOFFzKjNlJCqFULp5dNPay788f5BW9Z6eZTdteBE4Dq/2UF+OG61KwMzbCqCT
         3fh4zFFbJiabE5aVl5JeKJuUi3nXMMWvHXIhduQz8p6tAXTWPvYIA9FIWwi13iIoWU3a
         kiYrl7THef3fsO3q2HuS8vszUcqCo6nTc2bjCIv4cbofAWKAm2dJyYATT7WwSg21DgbG
         +Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695412252; x=1696017052;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIjzqide8w4bht+LrQY9bA4gqXbbebQ/O7VplvZnCaQ=;
        b=Jm1+GQVHJVxMslV+GfgJgACDqPjt2pbOdxfkZRPNd2HCynSLccjcc6KlRK8SuQab8P
         uxz4vCek2gnpXik2H7TpQVit12FI2ST1kUXoFt3NkfwrG2terZzCDp9VnoyI2iN+Rp9x
         tmWdW44Cb5Eh7KrNsl4TFLqAZWOWr/yS0URAf8iohXWlOOs7xuK4LdmefLDrCxYIv24S
         Oy90Vm1iFDKUvdriVTNkruofRFstovhAbNY75zSpUAKOG8KiUb8/CYP4NL9MeJhRlLWY
         in93nx3FbKewQUk9fAKZeVIUhbLs6mhLmuOsuAjbnKwOHVM973GIKXHvxZThwuKPYit1
         Tqyg==
X-Gm-Message-State: AOJu0Yx5h7r655P1WqoDvWphUUuIPkS7a7VHrMgziiC+JzbxRCuKa/dI
        w8JgcDRkyDfmt1pTF7rk0wu7O6ICUAY=
X-Google-Smtp-Source: AGHT+IFAGVFXllfQBUciGDVQtWgGBZ4ssrL/ec2K0o0CIN3Ce/k0Et60A9bED8Oiwpvt8+z/CWikWA==
X-Received: by 2002:a05:600c:8608:b0:400:140c:6083 with SMTP id ha8-20020a05600c860800b00400140c6083mr2679574wmb.2.1695412252170;
        Fri, 22 Sep 2023 12:50:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c300900b003fe407ca05bsm4148022wmh.37.2023.09.22.12.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:50:51 -0700 (PDT)
Message-ID: <1762f78a613f4a744e76ad515b6d27ca9bea47ed.1695412245.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
References: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
        <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 19:50:44 +0000
Subject: [PATCH v3 8/9] trailer: only use trailer_block_* variables if
 trailers were found
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <glencbz@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Previously, these variables were overloaded to act as the end of the log
message even if no trailers were found.

Remove the overloaded meaning by adding a new end_of_log_message field
to the trailer_info struct. The trailer_info struct consumers now only
refer to the trailer_block_start and trailer_block_end fields if
trailers were found (trailer_nr > 0), and otherwise refer to the
end_of_log_message.

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 31 +++++++++++++++++++++++--------
 trailer.h | 12 +++++++-----
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/trailer.c b/trailer.c
index 471c2722536..9a3837be770 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1086,9 +1086,14 @@ void process_trailers(const char *file,
 
 	parse_trailers(&info, sb.buf, &head, opts);
 
-	/* Print the lines before the trailers */
-	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, info.trailer_block_start, outfile);
+	/* Print the lines before the trailers (if any) as is. */
+	if (!opts->only_trailers) {
+		if (info.trailer_nr) {
+			fwrite(sb.buf, 1, info.trailer_block_start, outfile);
+		} else {
+			fwrite(sb.buf, 1, info.end_of_log_message, outfile);
+		}
+	}
 
 	if (!opts->only_trailers && !info.blank_line_before_trailer)
 		fprintf(outfile, "\n");
@@ -1108,9 +1113,14 @@ void process_trailers(const char *file,
 	free_all(&head);
 	trailer_info_release(&info);
 
-	/* Print the lines after the trailers as is */
-	if (!opts->only_trailers)
-		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
+	/* Print the lines after the trailers (if any) as is. */
+	if (!opts->only_trailers) {
+		if (info.trailer_nr) {
+			fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
+		} else {
+			fwrite(sb.buf + info.end_of_log_message, 1, sb.len - info.end_of_log_message, outfile);
+		}
+	}
 
 	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
@@ -1156,8 +1166,13 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 
 	info->blank_line_before_trailer = ends_with_blank_line(str,
 							       trailer_block_start);
-	info->trailer_block_start = trailer_block_start;
-	info->trailer_block_end = end_of_log_message;
+	info->trailer_block_start = 0;
+	info->trailer_block_end = 0;
+	if (nr) {
+		info->trailer_block_start = trailer_block_start;
+		info->trailer_block_end = end_of_log_message;
+	}
+	info->end_of_log_message = end_of_log_message;
 	info->trailers = trailer_strings;
 	info->trailer_nr = nr;
 }
diff --git a/trailer.h b/trailer.h
index 4dcb9080327..5e2843d320a 100644
--- a/trailer.h
+++ b/trailer.h
@@ -38,14 +38,16 @@ struct trailer_info {
 
 	/*
 	 * Offsets to the trailer block start and end positions in the input
-	 * string. If no trailer block is found, these are both set to the
-	 * "true" end of the input, per find_true_end_of_input().
-	 *
-	 * NOTE: This will be changed so that these point to 0 in the next
-	 * patch if no trailers are found.
+	 * string. If no trailer block is found, these are set to 0.
 	 */
 	size_t trailer_block_start, trailer_block_end;
 
+	/*
+	 * Offset to the end of the log message in the input (may not be the
+	 * same as the end of the input).
+	 */
+	size_t end_of_log_message;
+
 	/*
 	 * Array of trailers found.
 	 */
-- 
gitgitgadget

