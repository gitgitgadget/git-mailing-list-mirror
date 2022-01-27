Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897BEC433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 19:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245443AbiA0TIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 14:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245436AbiA0TIf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 14:08:35 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3E3C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 11:08:34 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s18so6529552wrv.7
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 11:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DYuGb9rSkace8bGLkTMmHIMDj91JTpOlwsxg0hTlXNo=;
        b=XliGmwBlzz/LOc7VYhAxLyeI3a2kDJD9p8rLFdA/xIXLzvAcp86Vg3wwrsntb++3hD
         W8OAceDc9zLH5SQcbHG1C3XbKRlSlzjuhxsiKBGJgC5ircb/jII9cnMhqf7kX6wYoOdy
         fp2/RZTmzLW8a4IVllbNN1ROO1bRBf1OjO06lf4z5lQ/XwuMvinJYpCsFMdt8IOysGxM
         kOGSNEBFR5pK5CdkxBwtOxNvDvUEcj2026kg1b7LCGGO6/DvZUFm/AsTdis+UIPRl4S3
         CFGaJjE/hdpFgqaGf5Y1s6L4l5HgfnBsqKaER5b7dDFrxx/1j4DaOSolCI0FxT6OSiNd
         0Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DYuGb9rSkace8bGLkTMmHIMDj91JTpOlwsxg0hTlXNo=;
        b=ba+NK/xMCVvBn34PljKDH4oP2JC5ChdS+m0b9T1UnMPWUy4qNjPDL8U7q6OmZbEmUJ
         GLjpB9M4oa+3TXjxKj95A6EyaRvmuh8FOsZ1hbFIv/vU4JrqHXBRQffGqy6K0rcf++9R
         Rx784Sjs/9gniQyQ2Ym25ZN1XBzie5crckWq0zMcRBJOfE1mJ66L+1+cYBOvPe9jpcmd
         6koqLQCP3GcR4A/j+rdyH+J2hV0f4zNXj3a+K23s6nHBtI9pnUf5UkjBP7yoSDOAmm5q
         9KCuxyvq/UNZKZK3rhaBhfV/WIi/bTBz37X+okY/42Dc8nKK19nBMz2zcQMC+xYu5sQr
         bjTw==
X-Gm-Message-State: AOAM533tFV0Qf8/4o7BZHiFDTROvI5uxsjyfTf5+a8/he9g5jcMfJTeO
        8SEvmdywPEhnENoLzR8LNOtEvUdk7Ns=
X-Google-Smtp-Source: ABdhPJyex4Ay2aY6rGMEXTZN17ynymE//Uuuj1ZS2mXg/Pr5PAprUM1mhKwgDEh8m1iz2l+VSTiNJA==
X-Received: by 2002:a5d:47c2:: with SMTP id o2mr4259473wrc.442.1643310513243;
        Thu, 27 Jan 2022 11:08:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17sm100798wmq.41.2022.01.27.11.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:08:32 -0800 (PST)
Message-Id: <19c7223e265962eac2f56d82d87c2fd069f04c6e.1643310510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1127.v2.git.1643310510.gitgitgadget@gmail.com>
References: <pull.1127.git.1643149759.gitgitgadget@gmail.com>
        <pull.1127.v2.git.1643310510.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Jan 2022 19:08:28 +0000
Subject: [PATCH v2 2/3] diff.c: move the diff filter bits definitions up a bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This prepares for a more careful handling of the `--diff-filter`
options over the next few commits.

This commit is best viewed with `--color-moved`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c | 74 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/diff.c b/diff.c
index c862771a589..5081052c431 100644
--- a/diff.c
+++ b/diff.c
@@ -4570,6 +4570,43 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
 	prep_parse_options(options);
 }
 
+static const char diff_status_letters[] = {
+	DIFF_STATUS_ADDED,
+	DIFF_STATUS_COPIED,
+	DIFF_STATUS_DELETED,
+	DIFF_STATUS_MODIFIED,
+	DIFF_STATUS_RENAMED,
+	DIFF_STATUS_TYPE_CHANGED,
+	DIFF_STATUS_UNKNOWN,
+	DIFF_STATUS_UNMERGED,
+	DIFF_STATUS_FILTER_AON,
+	DIFF_STATUS_FILTER_BROKEN,
+	'\0',
+};
+
+static unsigned int filter_bit['Z' + 1];
+
+static void prepare_filter_bits(void)
+{
+	int i;
+
+	if (!filter_bit[DIFF_STATUS_ADDED]) {
+		for (i = 0; diff_status_letters[i]; i++)
+			filter_bit[(int) diff_status_letters[i]] = (1 << i);
+	}
+}
+
+static unsigned filter_bit_tst(char status, const struct diff_options *opt)
+{
+	return opt->filter & filter_bit[(int) status];
+}
+
+unsigned diff_filter_bit(char status)
+{
+	prepare_filter_bits();
+	return filter_bit[(int) status];
+}
+
 void diff_setup_done(struct diff_options *options)
 {
 	unsigned check_mask = DIFF_FORMAT_NAME |
@@ -4774,43 +4811,6 @@ static int parse_dirstat_opt(struct diff_options *options, const char *params)
 	return 1;
 }
 
-static const char diff_status_letters[] = {
-	DIFF_STATUS_ADDED,
-	DIFF_STATUS_COPIED,
-	DIFF_STATUS_DELETED,
-	DIFF_STATUS_MODIFIED,
-	DIFF_STATUS_RENAMED,
-	DIFF_STATUS_TYPE_CHANGED,
-	DIFF_STATUS_UNKNOWN,
-	DIFF_STATUS_UNMERGED,
-	DIFF_STATUS_FILTER_AON,
-	DIFF_STATUS_FILTER_BROKEN,
-	'\0',
-};
-
-static unsigned int filter_bit['Z' + 1];
-
-static void prepare_filter_bits(void)
-{
-	int i;
-
-	if (!filter_bit[DIFF_STATUS_ADDED]) {
-		for (i = 0; diff_status_letters[i]; i++)
-			filter_bit[(int) diff_status_letters[i]] = (1 << i);
-	}
-}
-
-static unsigned filter_bit_tst(char status, const struct diff_options *opt)
-{
-	return opt->filter & filter_bit[(int) status];
-}
-
-unsigned diff_filter_bit(char status)
-{
-	prepare_filter_bits();
-	return filter_bit[(int) status];
-}
-
 static int diff_opt_diff_filter(const struct option *option,
 				const char *optarg, int unset)
 {
-- 
gitgitgadget

