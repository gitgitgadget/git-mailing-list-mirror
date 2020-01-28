Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E212C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC8E20716
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOMLqCNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgA1OlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:41:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45502 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbgA1OlT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 09:41:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id a6so1693887wrx.12
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 06:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z+0sLYrP58eeovRExl7dsWUvPzeYQuBQyVbe8IQ/XvY=;
        b=gOMLqCNK+SCd1RXm7VOlOA40j9CuTJdbpaDIDbJA8xS1/w4+49uYwRP9lTwlbraSpF
         eNwD3JlI9Fl2r7fblIht6+6xRM/aVEELZoI4OUbYhyjUgruBmACXaZ5R92hKsNLaBRNp
         s777+fmUNFzZvPLqc62nxXInbtm+xzA8g72GyjB61PejmOAHyHCqQgfEffzqcQGQAIOd
         mcKN88x53rRMYJ/3BlFFcNRlnUFnRXdZAN/R5qbz0VfcXYbzK3OB884sEv+1+pawbWx9
         EF3Bkg4mZY1/p194kIuwrSlqONW63TNfZV83XPlkas4Xp9wS/FWVOnjvn4MS1i8//LLc
         jfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z+0sLYrP58eeovRExl7dsWUvPzeYQuBQyVbe8IQ/XvY=;
        b=imMduORqAaOr/bRBm63s89yi8pQKYcaUtbrBvfPqH0bo8dD+WgOgYYbDYc4u9LLeZ5
         NMOmWNNtWXoC1ZJ804C5THxKF3zOCq0wWY5X9LMzn5Y2Hcvn7HioSbhBwb0eD/ZVcE07
         jIr6W7f4GKLetcrh3zcTnLSNERLsqtkM684Pb9tUhEoopKUJ8BTeHR0bL4dQyMMt8eCa
         IMp3qTRNu842c5JOqwzetuWJGTXDP7DaIUatd0YoLnmjj915v3kEZKnd+vfO0AqI7oXw
         bfg0aXtyAr+LNd10y89I9gNosToTXeybhRQC8uzPmEzhtQxMai6VAP827caMOIENqSk+
         fTPg==
X-Gm-Message-State: APjAAAV6J0VEjPzqWKBfLOfbXdWS1yJmV7CaDDPmMHZDoBckX0ygGjWq
        o8krcTSeFoqVE3pDLvXKf1pS6r2Q
X-Google-Smtp-Source: APXvYqzveMRsjJD27jXM2Wcph/mIxQX0PozvxlJ/9VhOR48Zi1FF/xbUkKmO6UzhDNpvxknmx6loSA==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr30624585wrp.292.1580222478094;
        Tue, 28 Jan 2020 06:41:18 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id g7sm25732439wrq.21.2020.01.28.06.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 06:41:17 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 05/11] bisect--helper: introduce new `decide_next()` function
Date:   Tue, 28 Jan 2020 15:40:20 +0100
Message-Id: <20200128144026.53128-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200128144026.53128-1-mirucam@gmail.com>
References: <20200128144026.53128-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tanushree Tumane <tanushreetumane@gmail.com>

Let's refactor code from bisect_next_check() into a new
decide_next() helper function.

This removes some goto statements and makes the code simpler,
clearer and easier to understand.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 62 +++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 21de5c096c..826fcba2ed 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -291,26 +291,14 @@ static const char need_bisect_start_warning[] =
 	   "You then need to give me at least one %s and %s revision.\n"
 	   "You can use \"git bisect %s\" and \"git bisect %s\" for that.");
 
-static int bisect_next_check(const struct bisect_terms *terms,
-			     const char *current_term)
+static int decide_next(const struct bisect_terms *terms,
+		       const char *current_term, int missing_good,
+		       int missing_bad)
 {
-	int missing_good = 1, missing_bad = 1, res = 0;
-	const char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
-	const char *good_glob = xstrfmt("%s-*", terms->term_good);
-
-	if (ref_exists(bad_ref))
-		missing_bad = 0;
-
-	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
-			     (void *) &missing_good);
-
 	if (!missing_good && !missing_bad)
-		goto finish;
-
-	if (!current_term) {
-		res = -1;
-		goto finish;
-	}
+		return 0;
+	if (!current_term)
+		return -1;
 
 	if (missing_good && !missing_bad &&
 	    !strcmp(current_term, terms->term_good)) {
@@ -321,7 +309,7 @@ static int bisect_next_check(const struct bisect_terms *terms,
 		 */
 		warning(_("bisecting only with a %s commit"), terms->term_bad);
 		if (!isatty(0))
-			goto finish;
+			return 0;
 		/*
 		 * TRANSLATORS: Make sure to include [Y] and [n] in your
 		 * translation. The program will only accept English input
@@ -329,21 +317,35 @@ static int bisect_next_check(const struct bisect_terms *terms,
 		 */
 		yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
 		if (starts_with(yesno, "N") || starts_with(yesno, "n"))
-			res = -1;
-		goto finish;
-	}
-	if (!is_empty_or_missing_file(git_path_bisect_start())) {
-		res = error(_(need_bad_and_good_revision_warning),
-			       vocab_bad, vocab_good, vocab_bad, vocab_good);
-	} else {
-		res = error(_(need_bisect_start_warning),
-			       vocab_good, vocab_bad, vocab_good, vocab_bad);
+			return -1;
+		return 0;
 	}
 
-finish:
+	if (!is_empty_or_missing_file(git_path_bisect_start()))
+		return error(_(need_bad_and_good_revision_warning),
+			     vocab_bad, vocab_good, vocab_bad, vocab_good);
+	else
+		return error(_(need_bisect_start_warning),
+			     vocab_good, vocab_bad, vocab_good, vocab_bad);
+}
+
+static int bisect_next_check(const struct bisect_terms *terms,
+			     const char *current_term)
+{
+	int missing_good = 1, missing_bad = 1;
+	const char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
+	const char *good_glob = xstrfmt("%s-*", terms->term_good);
+
+	if (ref_exists(bad_ref))
+		missing_bad = 0;
+
+	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
+			     (void *) &missing_good);
+
 	free((void *) good_glob);
 	free((void *) bad_ref);
-	return res;
+
+	return decide_next(terms, current_term, missing_good, missing_bad);
 }
 
 static int get_terms(struct bisect_terms *terms)
-- 
2.21.1 (Apple Git-122.3)

