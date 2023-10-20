Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89411208C2
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dl1qsNIn"
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0C3126
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 12:01:40 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso16796111fa.3
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 12:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697828498; x=1698433298; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o039u5fUixf5GdhKZFrUooxCe68hlMVa7Zg3at1+VM8=;
        b=dl1qsNInsv4Cv2Wl7lLb14JOf0eRlzuLJ/s7zTn/TWGp69qjoHpd1qtaPwn8yIaz0h
         QFfa/zb8fd4fwNRHF0wLgzscxBwDU1Q98+9Y4NnAIUkrqsx3VMgzwFg4qHAhho7A4FSd
         pX6hPdZnCoufeDdmSF6hcXlyTDh49Gwcwolclal0SVWjzMDj9Fy+G/rkaV6PFA4W7XXX
         yQ3Pvkl+K0dYUBXEwZ2C1yROwq6Va9Hj2ebequs3LDMlVTqLQdWiDD+MjM6YfpiEwX9L
         janRoqwI3BDFbC8s2cTzKxnVTHpBTO04ZB/gTkUY3lXBA7ElvUNWEarki+5TCGr1KTKU
         rfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697828498; x=1698433298;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o039u5fUixf5GdhKZFrUooxCe68hlMVa7Zg3at1+VM8=;
        b=F+ZVcsGehau38SKy7/5XjjQ1QCfWrTC3yxMj4RGgSHA6vkuIKMSGoEr5l3LIheKYp7
         EChMh/3divtdM8u24pTgEcdx+bDJz3LG0x9p8obu64VQ3G7/dOn1LKcqYQvdncw3sMFP
         nH6y4BbydRQt2syqrg4Ox1i94ryp3AJqA/r85IDYFN+Qj4pprbnD1gHTimr/oz6p/8R0
         Iv+SHv0QHa9VTGSV9U3bXm3SnfjRxe9DMVShuvRBtk7jrjOnwpF33yh9vFNt8T+WJ3SE
         GQ9XH0SaAbIQm7bHife1JUTInPWxdoqOBxXtL/OKC40jiS0jhz1kyuhFaNOAh5Ro+SoC
         tWEg==
X-Gm-Message-State: AOJu0Yxv1SXOn8HTS4M9w2EXOSr7Kppmk8uwxTGlcNf9Mqw63MBT9Pmg
	BS5vjsXkQbtdDYTRZjHiKuyKj0lJyIg=
X-Google-Smtp-Source: AGHT+IGjt6edJbjZKxQ6X0E6AKC4C+HrAiEKWaAb5yLFZkVEP4hiY1Jauka9mMtMdPJTn6IQYPQmUg==
X-Received: by 2002:a2e:9bd6:0:b0:2c5:c31:eeac with SMTP id w22-20020a2e9bd6000000b002c50c31eeacmr1998920ljj.15.1697828497908;
        Fri, 20 Oct 2023 12:01:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05600c524b00b004064cd71aa8sm2844820wmb.34.2023.10.20.12.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 12:01:37 -0700 (PDT)
Message-ID: <ce25420db29c9953095db652584dbed4e35d67ad.1697828495.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v5.git.1697828495.gitgitgadget@gmail.com>
References: <pull.1563.v4.git.1695709372.gitgitgadget@gmail.com>
	<pull.1563.v5.git.1697828495.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Oct 2023 19:01:34 +0000
Subject: [PATCH v5 2/3] trailer: find the end of the log message
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Glen Choo <glencbz@gmail.com>,
    Christian Couder <chriscool@tuxfamily.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Jonathan Tan <jonathantanmy@google.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

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

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 64 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/trailer.c b/trailer.c
index 3c54b38a85a..70c81fda710 100644
--- a/trailer.c
+++ b/trailer.c
@@ -809,21 +809,50 @@ static ssize_t last_line(const char *buf, size_t len)
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
 	const char *s;
 
-	for (s = str; *s; s = next_line(s)) {
+	/* Assume the naive end of the input is already what we want. */
+	end = strlen(input);
+
+	if (no_divider) {
+		return end;
+	}
+
+	/* Optionally skip over any patch part ("---" line and below). */
+	for (s = input; *s; s = next_line(s)) {
 		const char *v;
 
-		if (skip_prefix(s, "---", &v) && isspace(*v))
-			return s - str;
+		if (skip_prefix(s, "---", &v) && isspace(*v)) {
+			end = s - input;
+			break;
+		}
 	}
 
-	return s - str;
+	/* Skip over other ignorable bits. */
+	return end - ignored_log_message_bytes(input, end);
 }
 
 /*
@@ -925,12 +954,6 @@ continue_outer_loop:
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
@@ -1101,7 +1124,7 @@ void process_trailers(const char *file,
 void trailer_info_get(struct trailer_info *info, const char *str,
 		      const struct process_trailer_options *opts)
 {
-	int patch_start, trailer_end, trailer_start;
+	int end_of_log_message, trailer_start;
 	struct strbuf **trailer_lines, **ptr;
 	char **trailer_strings = NULL;
 	size_t nr = 0, alloc = 0;
@@ -1109,16 +1132,11 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 
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
@@ -1141,7 +1159,7 @@ void trailer_info_get(struct trailer_info *info, const char *str,
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

