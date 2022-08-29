Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF56C0502C
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 15:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiH2PMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 11:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiH2PMG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 11:12:06 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3B28048C
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 08:12:04 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so8358176wme.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 08:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=s2wDran9qrKhEZfd9bp5Vw0MKm0nDv2S770U3TfCHeA=;
        b=Z0/+Zfh48XzuI8hjFqfvuLNey1KuPr2JR14+dQV2mPklXQB3GC4AQfsUH7vvcf8xsm
         7sD0Xbxg/D6tWNzOahOi5v3hH7+3rDy42bUOQTSkD6w3E3fmu88LBn245M//14QG10X9
         dAjG3kxnKkINKrOOy7U7pubAR1+L/urejdcKf+n6ixJ5NRjwoYkkPoTCXfMzXW+pSkOF
         nXDRfFXi/ZXgf8AvAxSw+JUKL8Ti8FGYEuhZz8SWax4qGz78hwm25ZSF/x7KNBDYEdjN
         KCalvegKztJCEtlb/l9Id6vqzQHQ6ur6lfLRiL16i4DLXtwHP9nC58GUSb5Mwm5fA5xW
         dfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=s2wDran9qrKhEZfd9bp5Vw0MKm0nDv2S770U3TfCHeA=;
        b=0YcyPL0IToW+tnBU9RieZK6mZT2tTKpBUB+V481RP8FWQ/Fz6x3B2+gFVr/G2hl7Ta
         l4mjX2zN60meiD7x8XJQO0tCjePXQsFTU46IsPxujf0jt8E3BmN+8AMwis963A3rnceF
         3vI5blnAMXODaMnG5VNyGFUQzjmMKYTQSA8zp4w94IwRPF+m7oXQN7LJ9+/2/n0SSs+t
         xu2184G43oSPdOo5G285jr9mNMrS5Vyy9HqETf6SyApUbS/826Cx9a0mBIjg6JsdA+Qa
         ihobdrmfIwIkrx4mzpO6XqjOK69BJPyQoGpv/94j9oQWLk+2W+Dtx/eXRI4Y2jOByvQA
         NvYA==
X-Gm-Message-State: ACgBeo3YqSzooUKFb+B8u0Dm8aO0vBzlHVKFq8l5DcyaP7cU+4aJr6DT
        mnOFM+HQ4V3LBqOfPbS8hStNRhmEchc=
X-Google-Smtp-Source: AA6agR4f5MXO1/pSs22zn0wvPdUzS8xDP/GA2VD1we8pIcHLwIGuAIfQifkJZBUZnDy0PDvS1+eShA==
X-Received: by 2002:a05:600c:4f48:b0:3a5:e707:bb8c with SMTP id m8-20020a05600c4f4800b003a5e707bb8cmr7312642wmq.198.1661785922678;
        Mon, 29 Aug 2022 08:12:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6-20020adff486000000b0021e13efa17esm7509899wro.70.2022.08.29.08.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 08:12:02 -0700 (PDT)
Message-Id: <7a9f0b107e636ed57e511d2c145fc63596c1c69b.1661785916.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
References: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
        <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Aug 2022 15:11:54 +0000
Subject: [PATCH v3 3/5] add -p: insert space in colored hunk header as needed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We are about to teach `git add -p` to show the entire hunk header if the
`@@ ... @@` line range cannot be parsed. Previously, we showed only the
remainder of that hunk header as an "colored_extra" part.

To prepare for that, detect if that "colored_extra" part starts with any
non-whitespace character (ignoring ANSI escape sequences) and insert a
space, to make the output much more pleasant.

Note that this has an effect already before we make `git add -p` more
lenient when parsing the hunk headers: diff filters could already remove
the space after the line range, which is precisely what we do in the
regression test introduced by this commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c                | 22 ++++++++++++++++++++++
 t/t3701-add-interactive.sh | 10 +++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index f2fffe1af02..9d575d30ed0 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -8,6 +8,7 @@
 #include "diff.h"
 #include "compat/terminal.h"
 #include "prompt.h"
+#include "utf8.h"
 
 enum prompt_mode_type {
 	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_ADDITION, PROMPT_HUNK,
@@ -635,6 +636,23 @@ static size_t find_next_line(struct strbuf *sb, size_t offset)
 	return eol - sb->buf + 1;
 }
 
+static int starts_with_non_ws(const char *p, size_t len)
+{
+	for (;;) {
+		size_t skip;
+
+		if (!len || isspace(*p))
+			return 0;
+		skip = display_mode_esc_sequence_len(p);
+		if (!skip)
+			return 1;
+		if (skip > len)
+			return 0;
+		p += skip;
+		len -= skip;
+	}
+}
+
 static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 			ssize_t delta, int colored, struct strbuf *out)
 {
@@ -649,6 +667,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 		size_t len;
 		unsigned long old_offset = header->old_offset;
 		unsigned long new_offset = header->new_offset;
+		int needs_extra_space = 0;
 
 		if (!colored) {
 			p = s->plain.buf + header->extra_start;
@@ -658,6 +677,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 			p = s->colored.buf + header->colored_extra_start;
 			len = header->colored_extra_end
 				- header->colored_extra_start;
+			needs_extra_space = starts_with_non_ws(p, len);
 		}
 
 		if (s->mode->is_reverse)
@@ -673,6 +693,8 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 			strbuf_addf(out, ",%lu", header->new_count);
 		strbuf_addstr(out, " @@");
 
+		if (needs_extra_space)
+			strbuf_addch(out, ' ');
 		if (len)
 			strbuf_add(out, p, len);
 		else if (colored)
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index c2187f9cec8..49200b7df68 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -772,7 +772,15 @@ test_expect_success 'handle iffy colored hunk headers' '
 	echo content >test &&
 	printf n >n &&
 	force_color git -c interactive.diffFilter="sed s/@@/XX/g" \
-		add -p <n
+		add -p <n &&
+	force_color git -c interactive.diffFilter="sed \"s/\(.*@@\).*/\1FN/\"" \
+		add -p >output 2>&1 <n &&
+	if test_have_prereq ADD_I_USE_BUILTIN
+	then
+		grep "@ FN\$" output
+	else
+		grep "@FN\$" output
+	fi
 '
 
 test_expect_success 'handle very large filtered diff' '
-- 
gitgitgadget

