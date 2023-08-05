Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9D5C001DE
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 05:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjHEFE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 01:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHEFEp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 01:04:45 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9143C4ED6
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 22:04:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3178dd81ac4so2305884f8f.3
        for <git@vger.kernel.org>; Fri, 04 Aug 2023 22:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691211882; x=1691816682;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8CTofYNZZM9A5a0ncF2B46mjObmCWt2hkkcf9PsnLU=;
        b=pPYjuEfxrNSZeGfv6SdAZlyQRnO6jFXpmDpYYQJQy+Vk7uZy/GPuqqTxFCfMthx8Sw
         s9j61SEkN3rJSPogjm/bLuh2AstOMVA8D0sGafsjKDAgHgVYQ4xVog/9zeRUmO9QF1Ze
         O0/oed41ATP/HJCK3+Za8H8Hs6zc4D2uhQk/wpm1Tlthpk2eWoNawfU22QErDOUYOmV4
         rkgxPo0qVR5TVQ3D3H4kJ2d/aj8lmsgDaVifsyjqJquyrieVCwvSal9tm/rzeKCmAyF6
         rLuP8yFH9emOgjlp9+uDk4uq799+9aXMQRBucGcx29JQcyMXDSte/7wcE9wcyxfS0a/Y
         wP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691211882; x=1691816682;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8CTofYNZZM9A5a0ncF2B46mjObmCWt2hkkcf9PsnLU=;
        b=J5KCzrsaPAjAzJQc12CCvZxB93le/VDh5knyaPY61J4j2pkDapw/3v/ayB1X2sG+E8
         MAQ3i3CBGPye0r6TtonSO8A764TRmTwA90PiRU+XW5Xb0WgSnKkpxeAG4A30F/mPIxso
         eu/wa2wyJqeJyYgUaWR/UvZUcGkNToosYboBb+ZD+leSscNDe7cix+yTX+4fjxDvdP/+
         Q98AqaAw2rVOfcXICUb1NMHccKp96Fq2Qunegvy+z+3yzg1qpbowbykuFEURWQ7oCf31
         69pV74gy0NN+M54SkaHr+Qtn/vSuMNZeMyXiX5A6086bEsupkIqlNdi+K/OPgI+VPR+X
         wLHg==
X-Gm-Message-State: AOJu0Yw+HXXixNdJb+NjwVs3zq4Fz13gD8OOvyDw8l/QbbUnA304mMar
        fahxoCUbOQmukLH4mHkfToQupgHWU28=
X-Google-Smtp-Source: AGHT+IEH2YDWSUnhEgfWCGgR+98w6FawDbtFktZAaEwW0rwhcX5E0pG0uL5OEd/UV2sidXjqSrU53w==
X-Received: by 2002:adf:e253:0:b0:317:5e73:7594 with SMTP id bl19-20020adfe253000000b003175e737594mr2855909wrb.28.1691211881854;
        Fri, 04 Aug 2023 22:04:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z12-20020adff1cc000000b0031434c08bb7sm4126639wro.105.2023.08.04.22.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 22:04:41 -0700 (PDT)
Message-ID: <d023c297dcac0bb96f681dc1fc0116a649c2efec.1691211879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Aug 2023 05:04:36 +0000
Subject: [PATCH 2/5] trailer: split process_input_file into separate pieces
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Currently, process_input_file does three things:

    (1) parse the input string for trailers,
    (2) print text before the trailers, and
    (3) calculate the position of the input where the trailers end.

Rename this function to parse_trailers(), and make it only do
(1). The caller of this function, process_trailers, becomes responsible
for (2) and (3). These items belong inside process_trailers because they
are both concerned with printing the surrounding text around
trailers (which is already one of the immediate concerns of
process_trailers).

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/trailer.c b/trailer.c
index dff3fafe865..16fbba03d07 100644
--- a/trailer.c
+++ b/trailer.c
@@ -961,28 +961,23 @@ static void unfold_value(struct strbuf *val)
 	strbuf_release(&out);
 }
 
-static size_t process_input_file(FILE *outfile,
-				 const char *str,
-				 struct list_head *head,
-				 const struct process_trailer_options *opts)
+/*
+ * Parse trailers in "str" and populate the "head" linked list structure.
+ */
+static void parse_trailers(struct trailer_info *info,
+			     const char *str,
+			     struct list_head *head,
+			     const struct process_trailer_options *opts)
 {
-	struct trailer_info info;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
 	size_t i;
 
-	trailer_info_get(&info, str, opts);
-
-	/* Print lines before the trailers as is */
-	if (!opts->only_trailers)
-		fwrite(str, 1, info.trailer_start - str, outfile);
+	trailer_info_get(info, str, opts);
 
-	if (!opts->only_trailers && !info.blank_line_before_trailer)
-		fprintf(outfile, "\n");
-
-	for (i = 0; i < info.trailer_nr; i++) {
+	for (i = 0; i < info->trailer_nr; i++) {
 		int separator_pos;
-		char *trailer = info.trailers[i];
+		char *trailer = info->trailers[i];
 		if (trailer[0] == comment_line_char)
 			continue;
 		separator_pos = find_separator(trailer, separators);
@@ -1003,9 +998,7 @@ static size_t process_input_file(FILE *outfile,
 		}
 	}
 
-	trailer_info_release(&info);
-
-	return info.trailer_end - str;
+	trailer_info_release(info);
 }
 
 static void free_all(struct list_head *head)
@@ -1054,6 +1047,7 @@ void process_trailers(const char *file,
 {
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
+	struct trailer_info info;
 	size_t trailer_end;
 	FILE *outfile = stdout;
 
@@ -1064,8 +1058,16 @@ void process_trailers(const char *file,
 	if (opts->in_place)
 		outfile = create_in_place_tempfile(file);
 
+	parse_trailers(&info, sb.buf, &head, opts);
+	trailer_end = info.trailer_end - sb.buf;
+
 	/* Print the lines before the trailers */
-	trailer_end = process_input_file(outfile, sb.buf, &head, opts);
+	if (!opts->only_trailers)
+		fwrite(sb.buf, 1, info.trailer_start - sb.buf, outfile);
+
+	if (!opts->only_trailers && !info.blank_line_before_trailer)
+		fprintf(outfile, "\n");
+
 
 	if (!opts->only_input) {
 		LIST_HEAD(arg_head);
-- 
gitgitgadget

