Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0B3C433EB
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D11206BE
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFeBsgj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgGQKyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgGQKyo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 06:54:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDE5C08C5CE
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w3so16372503wmi.4
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0kviOj2gVA7cJvrLstGMSTiWT6uX82jRGwEC0u2kn4A=;
        b=sFeBsgj/nzcgJfVPDsWpxe9e76K6I3wmDjxCylfPHjBVSiOBLzyrK5iKlFMCMoKa0C
         00hmhMNiHnz2f+RY5T8VvL3E1RZSJZa3F32MvwXkUgbuSLovPGRDH63gL9hEWnivkXO7
         mGYHYx1XMyU5q3It6UwvnHaOeXAerGjTY1uKvJ3m9xDRrVsP1fwihKQ7vFLZyK3cIltX
         qovTQZt8a4fCDevOFCCdOH7+PIpikDC89ApAiBMT5b8b8xkNgFDC8ixvezT8F5u/GfQe
         J967ua4Nq7k5Dl9xoVrPwYUCI5j2+Lb8lTLBxC+UmwOPeWtM4zX+CiTRgSjQhfb66pyp
         2EAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0kviOj2gVA7cJvrLstGMSTiWT6uX82jRGwEC0u2kn4A=;
        b=lgdRfpdZTEf07dXIjsfRKAeE0i5/2HNUPI432s1S6H2IC3TZvg3Fb6k7YScqqL0qF3
         ezz1DsemZFiLN5Wl5vcqmcVvbvFxl0hREpyAldh5hO4ToNny9l/dS7R6CJ5OY8Vtv5Y5
         dEwYMCJHwj0s/61+63H0LvPXM5oGe86t7cJ9bWf5vurT1zs1gXjaHhEV0DRwvDUmK7SY
         JEJdAlpnwcEgdFdbThuSXDYRLRddLKVOekEnWdJm/8F/O3O0B+lWOzS51J6gBV+erJkd
         319FSCflh9wexPZzt7lCmMoLguxjSnoKi3qXhg3uK+jqYT53Sb/jRg4to7KbdZaZK2dx
         TooQ==
X-Gm-Message-State: AOAM531NgA8cMKCqIJht2KNBrCV/p/ITfWtaGn/fxqLwb9INn9TAosDO
        OB5PvXSjhLYfTpJssyaNDrlqtymX
X-Google-Smtp-Source: ABdhPJz2wrTemiRhKF1oGG0wqx6hq9yfTjgPVDv5ilOwPkltDYHDz0NnWwhe7KSL6Lmb7UKAWKzKCg==
X-Received: by 2002:a05:600c:4114:: with SMTP id j20mr8532112wmi.74.1594983282039;
        Fri, 17 Jul 2020 03:54:42 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id w14sm13924474wrt.55.2020.07.17.03.54.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 03:54:41 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 08/13] bisect--helper: retire `--bisect-clean-state` subcommand
Date:   Fri, 17 Jul 2020 12:54:01 +0200
Message-Id: <20200717105406.82226-9-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200717105406.82226-1-mirucam@gmail.com>
References: <20200717105406.82226-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--bisect-clean-state` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function
`bisect_clean_state()` is directly called from the C
implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 2b7bad558a..a8742dc37d 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -22,7 +22,6 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
-	N_("git bisect--helper --bisect-clean-state"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
@@ -864,7 +863,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		NEXT_ALL = 1,
 		WRITE_TERMS,
-		BISECT_CLEAN_STATE,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -882,8 +880,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
-			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
@@ -927,10 +923,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
 		return write_terms(argv[0], argv[1]);
-	case BISECT_CLEAN_STATE:
-		if (argc != 0)
-			return error(_("--bisect-clean-state requires no arguments"));
-		return bisect_clean_state();
 	case CHECK_EXPECTED_REVS:
 		check_expected_revs(argv, argc);
 		return 0;
-- 
2.25.0

