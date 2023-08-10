Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5557AC04A6A
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 16:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbjHJQfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 12:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjHJQfG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 12:35:06 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E474190
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:35:03 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso10389455e9.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691685302; x=1692290102;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfaR1DsJbmzySd8MAZZ0uJQWuPOxdrx72NBoPEpVV2w=;
        b=gCpevvaQdD+60MQRN1Mwx7Lzq6doOInerulWeXQFdOkpUVGtKTxsEQR8Imv3i1X3ro
         PfAbwx6lp/EsCNR+Iw0SuEDPB8Urw5leMHGsZeSCR720jaCbQ9Ix5xtY+wu2qEn7HPVQ
         2Hoi0ii/Y/MYTzrfqB0Se5tAEJKvaf6GNSK4ntLmHtjxLnWxuJoBSD9V7gnmA3KEbzg3
         wa/l9vUj4k0EFRbRbqJOOoy0kEaNuu8IQ2x2M113FHwu/6gugy5qmddvcH8oC87TLoU9
         N8Qd89uSNpgSjWySRuQ24x0wC+YTw1rifY+wgE4xI/9XjxU4TsmGWwLB3mGyQ7Cf/0TI
         vF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685302; x=1692290102;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfaR1DsJbmzySd8MAZZ0uJQWuPOxdrx72NBoPEpVV2w=;
        b=MkGgQjJY1WgwYtzODAb6Luf/gQDCep8aGMRn0CSvAO5hEjKZbGmI2IH/EjQOBQ1YoQ
         s53yoz7cbj2dM0HC72lqoIrYXe6KzGQ+BEvESzuLE8OPmjXPNO0jwETSGDfvYJmUTUl2
         /2K1NWq8k3tdaJCZWqbtmjt5dwKmV87nwSVeMI8Qi1HkwJKYw9Q8MiSVw0FU53wnGhlX
         0cErM6w9t74chdZGfDKhYpug6E+0YBuHtgr53SvY25nBa7FJLP3qcjyJHBzOTU7sgQ8s
         YHUa8OLVmzTDHGHXb92x15IOedzPj60C5ah8aOo2JzhRGBYCqxnLjjfSkdEzlBoj59eO
         sXUA==
X-Gm-Message-State: AOJu0YybonGxIWXcsG/v2C7ragHjRhm0EoOY7/Pt0R1KyTrD2Rn9AB5d
        4PfUAh9NzXpzAZuOywgYABN3tMkTTmA=
X-Google-Smtp-Source: AGHT+IEBn954YO14LQrYD5QHNdtzZBSPq7YcwzuJk6MXks4Zn7j0XSqB2IyL1LRXBxpySoKOtWJpFA==
X-Received: by 2002:a05:600c:2196:b0:3fe:108d:7f88 with SMTP id e22-20020a05600c219600b003fe108d7f88mr2285238wme.36.1691685302009;
        Thu, 10 Aug 2023 09:35:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1-20020a05600c0b4100b003fa95f328afsm5536078wmr.29.2023.08.10.09.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:35:01 -0700 (PDT)
Message-ID: <4971e3c52504bf965aa754c9a5d31abddbcc1466.1691685300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1562.git.git.1691685300.gitgitgadget@gmail.com>
References: <pull.1562.git.git.1691685300.gitgitgadget@gmail.com>
From:   "Mark Ruvald Pedersen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 16:34:59 +0000
Subject: [PATCH 1/2] sequencer: truncate labels to accommodate loose refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Mark Ruvald Pedersen <mped@oticon.com>,
        Mark Ruvald Pedersen <mped@demant.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mark Ruvald Pedersen <mped@demant.com>

Some commits may have unusually long subject lines. When those subject
lines are used as labels in the `--rebase-merges` mode of `git rebase`,
they can cause errors when writing the corresponding loose refs because
most file systems have a maximal file name length of 255 (`NAME_MAX`).
The symptom looks like this:

	$ git rebase --continue
	error: cannot lock ref 'refs/rewritten/SANITIZED-SUBJECT': Unable to create '.git/refs/rewritten/SANITIZED-SUBJECT.lock': File name too long - where SANITIZED-SUBJECT is very long

Let's accommodate this situation by truncating the labels.

Care must be taken in case the subject line contains multi-byte
characters so as not to truncate in the middle of a character.

Signed-off-by: Mark Ruvald Pedersen <mped@demant.com>
Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 git-compat-util.h |  4 ++++
 sequencer.c       | 41 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index d32aa754ae1..3e7a59b5ff1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -422,6 +422,10 @@ char *gitdirname(char *);
 #define PATH_MAX 4096
 #endif
 
+#ifndef NAME_MAX
+#define NAME_MAX 255
+#endif
+
 typedef uintmax_t timestamp_t;
 #define PRItime PRIuMAX
 #define parse_timestamp strtoumax
diff --git a/sequencer.c b/sequencer.c
index adc9cfb4df3..be837bd2948 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -51,6 +51,15 @@
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
+/*
+ * To accommodate common filesystem limitations, where the loose refs' file
+ * names must not exceed `NAME_MAX`, the labels generated by `git rebase
+ * --rebase-merges` need to be truncated if the corresponding commit subjects
+ * are too long.
+ * Add some margin to stay clear from reaching `NAME_MAX`.
+ */
+#define GIT_MAX_LABEL_LENGTH ((NAME_MAX) - (LOCK_SUFFIX_LEN) - 16)
+
 static const char sign_off_header[] = "Signed-off-by: ";
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
@@ -5396,6 +5405,8 @@ static const char *label_oid(struct object_id *oid, const char *label,
 		}
 	} else {
 		struct strbuf *buf = &state->buf;
+		int label_is_utf8 = 1; /* start with this assumption */
+		size_t max_len = buf->len + GIT_MAX_LABEL_LENGTH;
 
 		/*
 		 * Sanitize labels by replacing non-alpha-numeric characters
@@ -5404,14 +5415,34 @@ static const char *label_oid(struct object_id *oid, const char *label,
 		 *
 		 * Note that we retain non-ASCII UTF-8 characters (identified
 		 * via the most significant bit). They should be all acceptable
-		 * in file names. We do not validate the UTF-8 here, that's not
-		 * the job of this function.
+		 * in file names.
+		 *
+		 * As we will use the labels as names of (loose) refs, it is
+		 * vital that the name not be longer than the maximum component
+		 * size of the file system (`NAME_MAX`). We are careful to
+		 * truncate the label accordingly, allowing for the `.lock`
+		 * suffix and for the label to be UTF-8 encoded (i.e. we avoid
+		 * truncating in the middle of a character).
 		 */
-		for (; *label; label++)
-			if ((*label & 0x80) || isalnum(*label))
+		for (; *label && buf->len + 1 < max_len; label++)
+			if (isalnum(*label) ||
+			    (!label_is_utf8 && (*label & 0x80)))
 				strbuf_addch(buf, *label);
+			else if (*label & 0x80) {
+				const char *p = label;
+
+				utf8_width(&p, NULL);
+				if (p) {
+					if (buf->len + (p - label) > max_len)
+						break;
+					strbuf_add(buf, label, p - label);
+					label = p - 1;
+				} else {
+					label_is_utf8 = 0;
+					strbuf_addch(buf, *label);
+				}
 			/* avoid leading dash and double-dashes */
-			else if (buf->len && buf->buf[buf->len - 1] != '-')
+			} else if (buf->len && buf->buf[buf->len - 1] != '-')
 				strbuf_addch(buf, '-');
 		if (!buf->len) {
 			strbuf_addstr(buf, "rev-");
-- 
gitgitgadget

