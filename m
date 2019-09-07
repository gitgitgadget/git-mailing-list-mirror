Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 401761F461
	for <e@80x24.org>; Sat,  7 Sep 2019 11:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392166AbfIGLvU (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 07:51:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41497 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbfIGLvT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 07:51:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so6273586pfo.8
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 04:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+5qvvo0szWuOjireI1PHSWDe2sV0Qa4+nGDfWePk/Ls=;
        b=cXbkrw0LqjxjwEqNItqMiL9nIcUzA+wPFh3ZxgfCq6Iq0hhDZtl5GWSBV9f2ONkcat
         4jkAv4Db0gHLkIhs3QDmjZG5FAbNiVfww3lhPBUYQ26j8nz+GJskQnQHm3Ct2sL4v5nQ
         kXoafW2gQ37ldJhai0ivHHD/ulaMkp8MCizcGdN0c60+aKveqXNHSxjiQB0jaoRq939h
         VEIf2m3fFb0vKg40yG/XW1AYjsQn1wkYUn3TNOGGUvj2BFSJ5gJ6WlFwECUCKjEq2OOZ
         02RpGKXexocl/LVJMb7zG8ry6XX5f0ZVGg3MlNZZLwgcYaPPGz6Li7dPkDOYgwT8pkE0
         FOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+5qvvo0szWuOjireI1PHSWDe2sV0Qa4+nGDfWePk/Ls=;
        b=DpwX/9+kXBqbe+z7UWK9VO6dbc9gm8uvbQ0lpT4ehsmeYXAan5Q24UVTvxY2nvmBP9
         wJ4xwCcFJ1R/o+IJBcdRsBg2bs622/hmyY+RY8cTt3UhGdFeksB9qJlo+06wSJeCP1kp
         fWPGVNRo2EfORlOgwleszUGf2zmJPWbhDUHujuINKaiW0e97chHCAZY7n0bLLmiVjz8a
         X5VnhXRGKMFFRBO47I7xoEntS55dKJgNXJl1fYN8+VoACCAEeyLKlYL3D/eYisfC8mtQ
         FvBpuJzi9dV29GVRbUPYXB9XuL2oBDh2zi5A+iDRFhBHWO/VH4iE5gSvwdL5maMdYK5M
         GfLA==
X-Gm-Message-State: APjAAAVruaD2HDO4yGrLulzMFPtJi2XcyU5Xd2K/RueJbhtCyntHrJ7L
        oPbcRYsAwU/ysKxCvaxDyOR3PNl2wnk=
X-Google-Smtp-Source: APXvYqzhAfODFPtED3F1PzpksK5ip+see95xiqAv474DLmKA94qhO2w7dS1dpa9uMrh3md1B9JqCRw==
X-Received: by 2002:a17:90a:e28b:: with SMTP id d11mr13197123pjz.110.1567857078918;
        Sat, 07 Sep 2019 04:51:18 -0700 (PDT)
Received: from ar135.mshome.net ([103.37.200.225])
        by smtp.gmail.com with ESMTPSA id a11sm18134792pfg.94.2019.09.07.04.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 04:51:18 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [PATCH v4 6/6] rebase: add --reset-author-date
Date:   Sat,  7 Sep 2019 17:20:34 +0530
Message-Id: <20190907115034.14933-7-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190907115034.14933-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190907115034.14933-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit introduced --ignore-date flag to interactive
rebase, but the name is actually very vague in context of rebase -i
since there are two dates we can work with. Add an alias to convey
the precise purpose.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 Documentation/git-rebase.txt | 1 +
 builtin/rebase.c             | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index e7ac9fae0b..ec62ba36b8 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -391,6 +391,7 @@ See also INCOMPATIBLE OPTIONS below.
 	as the committer date. This implies --force-rebase.
 
 --ignore-date::
+--reset-author-date::
 	Instead of using the given author date, reset it to the value
 	same as the current time. This implies --force-rebase.
 +
diff --git a/builtin/rebase.c b/builtin/rebase.c
index e6f90f61dd..57e411dd59 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1431,6 +1431,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "committer-date-is-author-date",
 			 &options.committer_date_is_author_date,
 			 N_("make committer date match author date")),
+		OPT_BOOL(0, "reset-author-date", &options.ignore_date,
+			 "ignore author date and use current date"),
 		OPT_BOOL(0, "ignore-date", &options.ignore_date,
 			 "ignore author date and use current date"),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
-- 
2.21.0

