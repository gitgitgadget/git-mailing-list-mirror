Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2F8C4BA10
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CE2222C2
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAmmZLVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgBZKQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:16:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39869 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbgBZKQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 05:16:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id c84so2369862wme.4
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 02:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CVB4seLHVfIiwJJD9XnKMYBGthqGVKE6zCwSyWAb6AU=;
        b=mAmmZLVikO8hJmakaUQL54qO2Ye7UqAmty/VmtiKKHtq1Uj9tnNKjM9FvGtU18ETOs
         IeUrsuyiHe7BLvQ6uI1RS3OhvfYE0bfo4/z1KW/nGVoKdk88MZfxt2LH1u7dhyYFMvS9
         dWtiwR/jfrk+cgGe2DX4Yqv72W/NK23C4fQNhDWLkPMudAFxiwXTME4Tf3fsll2A2oHH
         QRena32hAR6GKH98Z3ULvqub1S/+ORm5gLd+AXCVUxmfhLnz5qBqRtbzXoABB1UWAzAz
         YGelN3/O3u5EMyV2tIvgSlPHYSMLc/sPhigRoson3fKCQEOfgQf1hBL4EtV6VE1XRBDI
         +Qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CVB4seLHVfIiwJJD9XnKMYBGthqGVKE6zCwSyWAb6AU=;
        b=KJ8juQ8E76IrFvYD0Y82nExIBi2Bep/RJPvTqEGPMLPeBbbljBsXr2fzIjSg/9GKgN
         gdL4aOuhwCDgXW6JYfVkwn3PDCMc7c2kRxIx2Drmx9MfH7pXyilD/VecvYJ+Pz93XOey
         wCRUIiN5K7/9Bu7RjhjEPBz8LyH3er9lZrCA/OqtLiZIirrSgLYYXKHRr7znaQIge7mm
         PsRZArA1V4JA9C4F9kMtkhVWKRhGk+YU9JlN7j0YINTOtODgQzobWI8kRQTUuBoz7v4b
         9kY7vrxPwEvcYWVyF576IF5ffjqLTrVDANSYv1WByFcWB7tXLtjsthbRXgiu+Zgvycqd
         wIeQ==
X-Gm-Message-State: APjAAAV8tb9YqK7AyVrJVTT9pLzYYc2Iq4CELbMmBaIoQX8+wXN6NalR
        ZXzqYTsg5xmpXINlThfpq7AAjViY
X-Google-Smtp-Source: APXvYqyltwQV2tRDGA9BMVopA2O9lGka4KSh1PVMhzxu9H/YFAGmmfmfOzWhQk63LXGGj8MBHKhFiw==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr4665946wmc.36.1582712172548;
        Wed, 26 Feb 2020 02:16:12 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id t3sm2577081wrx.38.2020.02.26.02.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 02:16:11 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 05/10] bisect--helper: retire `--next-all` subcommand
Date:   Wed, 26 Feb 2020 11:14:24 +0100
Message-Id: <20200226101429.81327-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226101429.81327-1-mirucam@gmail.com>
References: <20200226101429.81327-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--next-all` subcommand is no longer used from the git-bisect.sh
shell script. Instead the function `bisect_next_all()` is called from
the C implementation of `bisect_next()`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1792751179..c3bb936a40 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,7 +20,6 @@ static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
@@ -807,8 +806,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int no_checkou
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		NEXT_ALL = 1,
-		WRITE_TERMS,
+		WRITE_TERMS = 1,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -821,8 +819,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "next-all", &cmdmode,
-			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
@@ -859,9 +855,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	switch (cmdmode) {
-	case NEXT_ALL:
-		res = bisect_next_all(the_repository, prefix, no_checkout);
-		break;
 	case WRITE_TERMS:
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
-- 
2.25.0

