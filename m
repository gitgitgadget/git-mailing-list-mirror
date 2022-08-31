Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435E6ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiHaUb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiHaUbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:31:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2572EDEA61
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:31:24 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso238517wmr.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=vw2YPkIK4ICW8vAPm9dPPgG8VwTheHZP63gf3yELzns=;
        b=lBQOvDLiIHXOBmWhK+UczH2eruKMxa2Nr12MciGc6hMFR9+ziZISpLvlzgX6jLlmNe
         SDPAOblf726pJdshZRJyHR5CgsYM0L+qmoFjW1OkOGh+2CWeGCqbWN/mOnJntMGV1wSQ
         Z2bOzMJ7tWr8PfnJcOPnqTMPwTEe1C0g924TSCkxM3z/yQ4DvT6U8X1J5JoV5HW3K+n6
         Y5DjjIez18/jGzJsngy1lyOA+x5L8thS84J912da93jlmA0x/0fUWGVEgeHg++cc9z12
         bKe2s10pc/zvzpnYXbCcAqVtGvesSe64g2THMUlcPfp5soM8d6p42bkk2wy5apg43KbI
         izsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=vw2YPkIK4ICW8vAPm9dPPgG8VwTheHZP63gf3yELzns=;
        b=7d3pSzRoECjeFtubtFTjFeCtwQ3kp8dGboftPsvJdL2kv65b0ASED5sCeBZJNRJOjS
         mUmXyKFVI4PW9ez1YD2q6hWwcbuXrWJbQQSyOhScRrxw9PCNMg81i8TlzCWocZrEtxLs
         03m7DLj8yevsTxuSIr+NlPb+pl4U0ZGUUsY0z6cXaxE3vPQ9F/3SviLu1Bv67UFJsisc
         HNv9n8XNeOnCzjPGjAGJ1wL7auv5FwB7DT9UE72+ZQawomKJyxYNxouh343hrPAeZoGa
         Gb1r2bUJ91yl9Q+JH/xW7C6zNAA3L8Mi8EZyrqEq+qaWKLKfUWjQ0PWWgt4T8t0vvJS2
         l2EA==
X-Gm-Message-State: ACgBeo31bFT5v0V98JiOWLcje3FNshSIWCcysbHTcA5dEnEwIgwld3x3
        LILuHn61M5DO+0YFT47E+wDvXUjcmMw=
X-Google-Smtp-Source: AA6agR61GnFqLg8s0trsCQg9wq6+7eN0atJfdhU6vjOV1cvqa26lpHxI89Jy5qUPk/8vTtUOuLnhWw==
X-Received: by 2002:a05:600c:3ac6:b0:3a5:c03f:510d with SMTP id d6-20020a05600c3ac600b003a5c03f510dmr3039698wms.120.1661977882453;
        Wed, 31 Aug 2022 13:31:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6-20020a7bc8c6000000b003a35ec4bf4fsm3050390wml.20.2022.08.31.13.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:31:21 -0700 (PDT)
Message-Id: <cd1c51005068247fc92f1c515469bcd384bfe589.1661977877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
References: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
        <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 20:31:16 +0000
Subject: [PATCH v4 2/3] add -p: gracefully handle unparseable hunk headers in
 colored diffs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In
https://lore.kernel.org/git/ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com,
Phillipe Blain reported that the built-in `git add -p` command fails
when asked to use [`diff-so-fancy`][diff-so-fancy] to colorize the diff.

The reason is that this tool produces colored diffs with a hunk header
that does not contain any parseable `@@ ... @@` line range information,
and therefore we cannot detect any part in that header that comes after
the line range.

As proposed by Phillip Wood, let's take that for a clear indicator that
we should show the hunk headers verbatim. This is what the Perl version
of the interactive `add` command did, too.

This commit is best viewed with `--color-moved --ignore-space-change`.

[diff-so-fancy]: https://github.com/so-fancy/diff-so-fancy

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c                | 42 ++++++++++++++++++++------------------
 t/t3701-add-interactive.sh | 10 +++++++++
 2 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 34f3807ff32..3699ca1fcaf 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -238,6 +238,7 @@ struct hunk_header {
 	 * include the newline.
 	 */
 	size_t extra_start, extra_end, colored_extra_start, colored_extra_end;
+	unsigned suppress_colored_line_range:1;
 };
 
 struct hunk {
@@ -358,15 +359,14 @@ static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
 	if (!eol)
 		eol = s->colored.buf + s->colored.len;
 	p = memmem(line, eol - line, "@@ -", 4);
-	if (!p)
-		return error(_("could not parse colored hunk header '%.*s'"),
-			     (int)(eol - line), line);
-	p = memmem(p + 4, eol - p - 4, " @@", 3);
-	if (!p)
-		return error(_("could not parse colored hunk header '%.*s'"),
-			     (int)(eol - line), line);
+	if (p && (p = memmem(p + 4, eol - p - 4, " @@", 3)))
+		header->colored_extra_start = p + 3 - s->colored.buf;
+	else {
+		/* could not parse colored hunk header, leave as-is */
+		header->colored_extra_start = hunk->colored_start;
+		header->suppress_colored_line_range = 1;
+	}
 	hunk->colored_start = eol - s->colored.buf + (*eol == '\n');
-	header->colored_extra_start = p + 3 - s->colored.buf;
 	header->colored_extra_end = hunk->colored_start;
 
 	return 0;
@@ -666,18 +666,20 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 				- header->colored_extra_start;
 		}
 
-		if (s->mode->is_reverse)
-			old_offset -= delta;
-		else
-			new_offset += delta;
-
-		strbuf_addf(out, "@@ -%lu", old_offset);
-		if (header->old_count != 1)
-			strbuf_addf(out, ",%lu", header->old_count);
-		strbuf_addf(out, " +%lu", new_offset);
-		if (header->new_count != 1)
-			strbuf_addf(out, ",%lu", header->new_count);
-		strbuf_addstr(out, " @@");
+		if (!colored || !header->suppress_colored_line_range) {
+			if (s->mode->is_reverse)
+				old_offset -= delta;
+			else
+				new_offset += delta;
+
+			strbuf_addf(out, "@@ -%lu", old_offset);
+			if (header->old_count != 1)
+				strbuf_addf(out, ",%lu", header->old_count);
+			strbuf_addf(out, " +%lu", new_offset);
+			if (header->new_count != 1)
+				strbuf_addf(out, ",%lu", header->new_count);
+			strbuf_addstr(out, " @@");
+		}
 
 		if (len)
 			strbuf_add(out, p, len);
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 8a594700f7b..47ed6698943 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -767,6 +767,16 @@ test_expect_success 'detect bogus diffFilter output' '
 	grep "mismatched output" output
 '
 
+test_expect_success 'handle iffy colored hunk headers' '
+	git reset --hard &&
+
+	echo content >test &&
+	printf n >n &&
+	force_color git -c interactive.diffFilter="sed s/.*@@.*/XX/" \
+		add -p >output 2>&1 <n &&
+	grep "^[^@]*XX[^@]*$" output
+'
+
 test_expect_success 'handle very large filtered diff' '
 	git reset --hard &&
 	# The specific number here is not important, but it must
-- 
gitgitgadget

