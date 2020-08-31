Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ADEC433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A326B2068F
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0HuCuEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgHaKw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgHaKvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 06:51:25 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D24C06123C
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v4so4129573wmj.5
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f9PSN2XV2fPFK8tKe/1D2bkQXSX7LTlnPhd4r2tNgxU=;
        b=M0HuCuEWe4Cb7SpD4SX1BtSXTXqCnF+bJejotrJuATNqoCtvetnFn/qerYtpYCx2G+
         LEOgbNiWXbIC9eYqfzNZJaFWczrp3WxhxpsV5SrA8PN4kIEhFvPRHuDHZqopg9mGHOkZ
         NKLGpiJ1oTIU0Cs3Aik2Qft9ZXlvdEmTvRfuX+A2c03CBXHGWYd9Iu1xDaPpOeUuT/az
         9X+VMgdJaKgeOWEkGzO3zLVzyJsZVTBVD28P70yCN6dP7eo1zvQLToKb6wnDpKA9dzGX
         sj9yInPLuRoSnnopvLkY8zy+IeHoWs2uQlwlUGtE0ilHXgywL44U13kvhmCOHqlyxHSv
         kcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9PSN2XV2fPFK8tKe/1D2bkQXSX7LTlnPhd4r2tNgxU=;
        b=cc3yDAymUa0r1YpWLK9pUy58UvgnuALg1/VNj1MzleilzoUMYyHPLqO5zgeznN2T3y
         jmleVEJO1y3FhOIy+olHfY6CWNetgluTnynyzcRz1sDzC9zdadZbViYEl4KL8vDvWnal
         oL8rWpJ1u3NVaewZDtoh0mPEPaE3mdw5H2JOyLFxmzm1Wb5LTvOzg4U/A/MJZXIFoGAw
         1Ien+8r27EVFCzGeJxDsxtt/BspWhJj0llGz1YoQJ07hvE0hBlP3N4VyTYQxWpY2Ee/U
         e8dZ3eBavNSQqI8Gslx/Y2gbvGRUcZPGiKvW5G/6mak6jCQqccNoA7FRW/9vZBcLtBtv
         My7Q==
X-Gm-Message-State: AOAM530a/QwKfWcduKcp5Nw+DaH5+Yv5AQC+7IgNs5XaAgMUZ6jHdI/1
        d3L+YyGjNmXmHGTKztzoPJ9BR4M4OCA=
X-Google-Smtp-Source: ABdhPJwDHRGV1AhHbXp59hnQVfz40/NPPzR+ovZ2s3aXxjG/T/qpWZ/yEZrIjCJKsf+HNrV+GtNZuw==
X-Received: by 2002:a1c:f30f:: with SMTP id q15mr841412wmq.60.1598871083035;
        Mon, 31 Aug 2020 03:51:23 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id k84sm7674454wmf.6.2020.08.31.03.51.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 03:51:22 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v7 12/13] bisect--helper: retire `--write-terms` subcommand
Date:   Mon, 31 Aug 2020 12:50:42 +0200
Message-Id: <20200831105043.97665-13-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200831105043.97665-1-mirucam@gmail.com>
References: <20200831105043.97665-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--write-terms` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function `write_terms()`
is called from the C implementation of `set_terms()` and
`bisect_start()`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index da203c2091..46ddfd5710 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,7 +20,6 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
@@ -909,8 +908,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		WRITE_TERMS = 1,
-		BISECT_RESET,
+		BISECT_RESET = 1,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
@@ -923,8 +921,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "write-terms", &cmdmode,
-			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
@@ -959,10 +955,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	switch (cmdmode) {
-	case WRITE_TERMS:
-		if (argc != 2)
-			return error(_("--write-terms requires two arguments"));
-		return write_terms(argv[0], argv[1]);
 	case BISECT_RESET:
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
-- 
2.25.0

