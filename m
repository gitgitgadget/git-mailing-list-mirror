Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51437E8181F
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 06:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbjIZGXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 02:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbjIZGXG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 02:23:06 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA48ADF
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 23:22:58 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c131ddfc95so123918701fa.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 23:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695709377; x=1696314177; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rwbg0EHFrct7ZzWHjVPCjko4EDWAGutEr1RanG0Sgg=;
        b=PMTJorQ3v+jev8ChsqcfgWymfMoDS5mgVJoWtNt/ONNcqQCSSmjh3FT/dM17VELLUt
         3Jy4zCvdV07H20mnIogkcYs9WzH6E0Pjb6cd/CXUDvrHp0StRuljpR+0yQMxsvxXRJFd
         2cxvBcmJKpLoRHW3NKk4+v/+ZXd3tRZ7+/Ti/RWyl76yUXsj/fQVfQoxT1GxWUQExA8J
         ZX3dEwTtIe2PmcHMWIUUHf+1IxuBft3bSGINMjZ6phssoH9ivMiFI2sRKDcbytAFiFym
         YoIjNcQxnK+e/rZu7Ct+aCx7MRqGQzoRk+5mfeWUzDgmTKRjLzujEgVFNc716U8WllSl
         PPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695709377; x=1696314177;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rwbg0EHFrct7ZzWHjVPCjko4EDWAGutEr1RanG0Sgg=;
        b=VK6dp1OlqYIVQIIQZ57h3fNxp+IUynhGAZ7OtyMaQh3BgA6NrT+NYbTnm5TEhX+1aX
         8iJ0wpao9WBk/UVTPhd+StUu+f/ns1Ow0QfqG3axLEPs/MijmpDosOwH/YvjRnQU6mfi
         2oYpucnM7BcMtjbcbOO3Iz6xquI6HMPmz5Ja3IMql5UeZE0prCO9Jpm2Q7UIkW3w6kam
         Y0BDL67/IdZTWvcJWL9D4W2Td8hbBnAF7VnYmO75JmlmcjCQviOhM8FMgjkliPBlYnr5
         DmnHWpnG2VlkD38rgUodJ4ZVDmgYbSnbCaTN1x3RZeahjsGm7S2Cp+9G0pF2og9uLYeU
         JULg==
X-Gm-Message-State: AOJu0YyIPbO/1gBVdVziRbbQfUeTQVC+TnVZxOa1cBXJ5S6hIe30ffV4
        1Z/Kiun6qzO1WI9Pkw/bCfFD4cxMpFE=
X-Google-Smtp-Source: AGHT+IHYRCMSU73w4CFmx/r4UBYAKdpbJIJqQvXD6J7MdyWU1BJk6Rl+Ca94kOP37ju9wi2ZUg0zRw==
X-Received: by 2002:a2e:b7d4:0:b0:2c0:d06:9e65 with SMTP id p20-20020a2eb7d4000000b002c00d069e65mr6637619ljo.8.1695709376865;
        Mon, 25 Sep 2023 23:22:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3-20020a2e9043000000b002bbacc6c523sm2549587ljg.49.2023.09.25.23.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 23:22:56 -0700 (PDT)
Message-ID: <c904caba7e17b6f2784933e9f18634ea66f28537.1695709372.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v4.git.1695709372.gitgitgadget@gmail.com>
References: <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
        <pull.1563.v4.git.1695709372.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Sep 2023 06:22:50 +0000
Subject: [PATCH v4 2/4] trailer: find the end of the log message
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
index 3c54b38a85a..96cb285a4ea 100644
--- a/trailer.c
+++ b/trailer.c
@@ -809,21 +809,47 @@ static ssize_t last_line(const char *buf, size_t len)
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
@@ -925,12 +951,6 @@ continue_outer_loop:
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
@@ -1101,7 +1121,7 @@ void process_trailers(const char *file,
 void trailer_info_get(struct trailer_info *info, const char *str,
 		      const struct process_trailer_options *opts)
 {
-	int patch_start, trailer_end, trailer_start;
+	int end_of_log_message, trailer_start;
 	struct strbuf **trailer_lines, **ptr;
 	char **trailer_strings = NULL;
 	size_t nr = 0, alloc = 0;
@@ -1109,16 +1129,11 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 
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
@@ -1141,7 +1156,7 @@ void trailer_info_get(struct trailer_info *info, const char *str,
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

