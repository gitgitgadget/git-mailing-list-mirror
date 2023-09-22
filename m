Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B687DCE7AB7
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 19:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjIVTvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 15:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjIVTvA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 15:51:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6891AB
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:50:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c8321c48fso2893342f8f.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695412251; x=1696017051; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYXXRIc3EYjIisAKYJNnEVEWQxe8YlHyuNCTiVa/+Gk=;
        b=KI3hWUWCEfDr1iEAs94hf63mhDpjGguqS12ZMERMuPFlWvDfVP6d9hlkSNHFyn/8dc
         vkDZ3vMwGFSt3MYGZ4yS8gyXA30uUFbOdh/m4aaeqsPJM6lsRLFPcytsKDUYwOYkqLx6
         M+Pa60eOEQ5NWFHwAcAYaHdu607WJ2hohqMqW3/2/a6UYRef0G5x0V/X0WBLndMlLiU7
         Ia7/bog6YE5RVK3/maMQgzB9kl25jlsm8SFHzy4nv5lc8gpAjFU09SC2QwoNgmmh8MD1
         9+jNvLYp7yVT4LPMkKGXOEc+nFFvViW1MrAcBNnP95zvsaNqw8ju5Q0eSbrQQYOZwRlk
         3pBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695412251; x=1696017051;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYXXRIc3EYjIisAKYJNnEVEWQxe8YlHyuNCTiVa/+Gk=;
        b=YCR7EdOLAH0GjnXsw2cGd10s3MCWd3/HUbdFE6RAggaipcV4uER/o6LfGwu0BdT+XZ
         Oe4mexrT790Ceil/FJqZ9Pn2u+NVvffTt1GQVMOMbxnA5jUR5w8YSORgEgdvESyqKJEy
         KLD9ah6EsFfBynetpMlVla1cpKIo5PhUXZ1MssselMMZrzqQdPjkluU0tYWjks/aQsYD
         yIEeh2N6b9NdofgDQDZ8L3hmcyR1oK150Xv7meYteUm52Xz2ATDkH8PcIAgNfxOYWSNX
         wlr+xqQUmzCoyVfuwi2jj76ZnC8/6HcACNw/SJPFGgRD5Ln+lq/+OPINoC3jikf56eXZ
         fHjg==
X-Gm-Message-State: AOJu0YwnN0SncNoUVDCLbgPK8UgxxDqCuJT912s2bcPhRNTmJDi5F3FX
        QzuhQu6y6qnpjt1sQR6TF1acwuh0ksI=
X-Google-Smtp-Source: AGHT+IEWwiR0i1jUu9Q8g3E3U9U8SNp97Byta2Wtfb6ikalZz/ewzvVfCZUo5TnjXpw5xwkx9meInw==
X-Received: by 2002:adf:ec04:0:b0:317:6734:c2ae with SMTP id x4-20020adfec04000000b003176734c2aemr2820142wrn.11.1695412250715;
        Fri, 22 Sep 2023 12:50:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e24-20020a5d5958000000b00317ab75748bsm5183099wri.49.2023.09.22.12.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:50:50 -0700 (PDT)
Message-ID: <ab8a6ced1435580ad3e8585e464e447d40805232.1695412245.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
References: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
        <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 19:50:42 +0000
Subject: [PATCH v3 6/9] trailer: find the end of the log message
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

Previously, trailer_info_get() computed the trailer block end position
by

(1) checking for the opts->no_divider flag and optionally calling
    find_patch_start() to find the "patch start" location (patch_start), and
(2) calling find_trailer_end() to find the end of the trailer block
    using patch_start as a guide, saving the return value into
    "trailer_end".

The logic in (1) was awkward because the variable "patch_start" is
misleading if there is no patch in the input. The logic in (2) was
misleading because it could be the case that no trailers are in the
input (yet we are setting a "trailer_end" variable before even searching
for trailers, which happens later in find_trailer_start()). The name
"find_trailer_end" was misleading because that function did not look for
any trailer block itself --- instead it just computed the end position
of the log message in the input where the end of the trailer block (if
it exists) would be (because trailer blocks must always come after the
end of the log message).

Combine the logic in (1) and (2) together into find_patch_start() by
renaming it to find_end_of_log_message(). The end of the log message is
the starting point which find_trailer_start() needs to start searching
backward to parse individual trailers (if any).

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 61 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/trailer.c b/trailer.c
index 185b3e2707f..9da89df9d8a 100644
--- a/trailer.c
+++ b/trailer.c
@@ -812,21 +812,47 @@ static ssize_t last_line(const char *buf, size_t len)
 }
 
 /*
- * Return the position of the start of the patch or the length of str if there
- * is no patch in the message.
+ * Find the end of the log message as an offset from the start of the input
+ * (where callers of this function are interested in looking for a trailers
+ * block in the same input). We have to consider two categories of content that
+ * can come at the end of the input which we want to ignore (because they don't
+ * belong in the log message):
+ *
+ * (1) the "patch part" which begins with a "---" divider and has patch
+ * information (like the output of git-format-patch), and
+ *
+ * (2) any trailing comment lines, blank lines like in the output of "git
+ * commit -v", or stuff below the "cut" (scissor) line.
+ *
+ * As a formula, the situation looks like this:
+ *
+ *     INPUT = LOG MESSAGE + IGNORED
+ *
+ * where IGNORED can be either of the two categories described above. It may be
+ * that there is nothing to ignore. Now it may be the case that the LOG MESSAGE
+ * contains a trailer block, but that's not the concern of this function.
  */
-static size_t find_patch_start(const char *str)
+static size_t find_end_of_log_message(const char *input, int no_divider)
 {
+	size_t end;
+
 	const char *s;
 
-	for (s = str; *s; s = next_line(s)) {
+	/* Assume the naive end of the input is already what we want. */
+	end = strlen(input);
+
+	/* Optionally skip over any patch part ("---" line and below). */
+	for (s = input; *s; s = next_line(s)) {
 		const char *v;
 
-		if (skip_prefix(s, "---", &v) && isspace(*v))
-			return s - str;
+		if (!no_divider && skip_prefix(s, "---", &v) && isspace(*v)) {
+			end = s - input;
+			break;
+		}
 	}
 
-	return s - str;
+	/* Skip over other ignorable bits. */
+	return end - ignored_log_message_bytes(input, end);
 }
 
 /*
@@ -928,12 +954,6 @@ continue_outer_loop:
 	return len;
 }
 
-/* Return the position of the end of the trailers. */
-static size_t find_trailer_end(const char *buf, size_t len)
-{
-	return len - ignored_log_message_bytes(buf, len);
-}
-
 static int ends_with_blank_line(const char *buf, size_t len)
 {
 	ssize_t ll = last_line(buf, len);
@@ -1104,7 +1124,7 @@ void process_trailers(const char *file,
 void trailer_info_get(struct trailer_info *info, const char *str,
 		      const struct process_trailer_options *opts)
 {
-	int patch_start, trailer_end, trailer_start;
+	int end_of_log_message, trailer_start;
 	struct strbuf **trailer_lines, **ptr;
 	char **trailer_strings = NULL;
 	size_t nr = 0, alloc = 0;
@@ -1112,16 +1132,11 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 
 	ensure_configured();
 
-	if (opts->no_divider)
-		patch_start = strlen(str);
-	else
-		patch_start = find_patch_start(str);
-
-	trailer_end = find_trailer_end(str, patch_start);
-	trailer_start = find_trailer_start(str, trailer_end);
+	end_of_log_message = find_end_of_log_message(str, opts->no_divider);
+	trailer_start = find_trailer_start(str, end_of_log_message);
 
 	trailer_lines = strbuf_split_buf(str + trailer_start,
-					 trailer_end - trailer_start,
+					 end_of_log_message - trailer_start,
 					 '\n',
 					 0);
 	for (ptr = trailer_lines; *ptr; ptr++) {
@@ -1144,7 +1159,7 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 	info->blank_line_before_trailer = ends_with_blank_line(str,
 							       trailer_start);
 	info->trailer_start = str + trailer_start;
-	info->trailer_end = str + trailer_end;
+	info->trailer_end = str + end_of_log_message;
 	info->trailers = trailer_strings;
 	info->trailer_nr = nr;
 }
-- 
gitgitgadget

