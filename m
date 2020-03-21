Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83D2C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 16:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F67B20757
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 16:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtCbI1y1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgCUQN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 12:13:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56075 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbgCUQN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 12:13:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id 6so9710941wmi.5
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 09:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z8Yb5WR++1HxbvWIB9L6nzzudaA0Wn2XAlyOHhESk/E=;
        b=CtCbI1y1VZWMwP7/WtW/cXRFtRE+z3TVQb/dWRa7GiPHDfO/KP+yYYKMWitNu8abbG
         UFYlBXqrCBjcU5tPc5SFZFdXA/6v7zPSK5+d5oyUodLCVXn5ZKyvU4DLgMK5uG8REjWV
         0vpn7wormyMi9NThFnkFcmZzrgn7B8xxmvDLMYvBM1dq07rOHMZeQlVM8wWi0qcoeYAK
         bDIENlu/97UEW+03S962wPwjS1vilcJL++5eSff2Le1oXWUzzoDi0T6A77ufOmTRsIQ8
         5QV89vSUfx7VLr6FYtOT0AUA4GCPujv71NMrRlYTNhDW3kCv/W8qx/MG0HpkmLt7Iwy0
         iUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z8Yb5WR++1HxbvWIB9L6nzzudaA0Wn2XAlyOHhESk/E=;
        b=FptAYUHo0N6roO2i/LakJ6tn6iZmlNa5pUoWxa60S0dNhY98PO4mDS0Zxdnq6+4QyA
         yKad0yJMsEGaQisk77G/5dy3uHe6ULkh8zpZbKn8ASv/ne1Fg2/i5Zllx+BOL37TtKTq
         BW6eScrOIjWDc+dGbVZYqQ9SYcykQigkLU3+gqJuO+ZjNxPuf0bjdZ3EImm2FgQkRfaE
         KrAoc9zfD+zfE2H20U2hhda9WR+iVr2eAUiQJT2bgmMW7fZFz0feoyLIJgMWLYNcrd3f
         LpXCj+lM7meMb6jjxTSKAGtcKVW4viyQQrPMMuZ14smvNaWADwUoNbQ/uVVWVm3auu4G
         v+rg==
X-Gm-Message-State: ANhLgQ3r7uoTFB/mT/488DSqaQm71nUmeoUgzl6aHQUUoLZcKOJWbPrI
        J70OTBm3Y3EnI81dkGy88Vjofik+
X-Google-Smtp-Source: ADFU+vsp0emPAP1MJgprCTC6rBKMRgNfrhSqZlufIh5+uk3E1YfjJGbiaVa766NEAW0QOcTyG4QMAw==
X-Received: by 2002:a1c:b356:: with SMTP id c83mr16740393wmf.10.1584807234852;
        Sat, 21 Mar 2020 09:13:54 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id f22sm13992285wmf.2.2020.03.21.09.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 09:13:54 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 05/11] bisect--helper: retire `--bisect-clean-state` subcommand
Date:   Sat, 21 Mar 2020 17:10:14 +0100
Message-Id: <20200321161020.22817-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200321161020.22817-1-mirucam@gmail.com>
References: <20200321161020.22817-1-mirucam@gmail.com>
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
index 84aac08ced..0534adf216 100644
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
@@ -809,7 +808,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		NEXT_ALL = 1,
 		WRITE_TERMS,
-		BISECT_CLEAN_STATE,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -826,8 +824,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
-			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
@@ -869,10 +865,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

