Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ED9C1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 16:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeJRAhF (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 20:37:05 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:47043 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbeJRAhE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 20:37:04 -0400
Received: by mail-qk1-f196.google.com with SMTP id q12-v6so16861947qkl.13
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 09:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6gP2qUl3U/3DHw8+cgkIMEVWLvvhFyvnEDUIopIF9zE=;
        b=eNH/rveLIN2MoiXa/Exmb/ds4pyo0T7kIpcmMvKPGSe5Rii+nF/RbbT7FDAXzDlv1X
         w3HPuXfaO5Teqcjba6AnSWb4iJSZfKbSRiSBrs8Pst/JrfP2p67kOxme4qGXr53mMxJl
         t22QM7p39Hyw2l2MjFImABn/K8yaPyW65ygtl6unaV/jQKn9ti0+lkTnPcUVYDeZa7yv
         1SWwXoLWnPIKzWp/l7F2X0YNYJX8L6feOujYWufzBkcMNojL0NzH6ipZgWQv6p3XrnUf
         puhsQ/9iOXAduyDm5epUy2jte4kWzsqRgNybbTDFHSkhNUDDIeEUShVltF0zrz+bs3BW
         +0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6gP2qUl3U/3DHw8+cgkIMEVWLvvhFyvnEDUIopIF9zE=;
        b=qZoSHzmivjum2hFx29eEe46DRv0oUNyZxQkNSWkknRAvZtHgym/HQ5tOC3rA2hOPlw
         A4K0HkJM+gDY10eI0g0ZQTEhaJxo3dDZRX6uy9ncdXdodPL1YiCaXEGIsLQq1OSQCYih
         0tjcDVCl7lAmySziOjo3Ce9ftxjZdr5ZqKSKylGQv8z8v2YZL21e+S4kIEVkj2ovF+Ut
         V4xSn552sWefTXcdWMiRUuP9vm0+uxG6GfEx57nyQzSbIHzaVWRVb75EPog232bsjO7u
         i9pGBIqKbWmcfKvePJqm2tjhJbTTk4ej0T2sj+CGH/OiSHJY5yeMEtt6oW0tTdB5JdJb
         tLzg==
X-Gm-Message-State: ABuFfohBI9FnLCuvwUNvFkDMBXvzxWhwsRnM1YxWZSmTwMOLVFq7tMgL
        g8xtMCKtbOsgsVl3MuvoQB6S4P+/4o8=
X-Google-Smtp-Source: ACcGV60h132Pi0rPZ+WyN6FUxlsguzUmdy6mLgzYjHT7h04+ZMRnreFylHzKpInHU5jQP6y05aDaeg==
X-Received: by 2002:a37:9a55:: with SMTP id c82-v6mr24471545qke.153.1539794432912;
        Wed, 17 Oct 2018 09:40:32 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id x12-v6sm10843700qtk.6.2018.10.17.09.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 09:40:32 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v1 2/2] reset: add new reset.quietDefault config setting
Date:   Wed, 17 Oct 2018 12:40:21 -0400
Message-Id: <20181017164021.15204-3-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181017164021.15204-1-peartben@gmail.com>
References: <20181017164021.15204-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Add a reset.quietDefault config setting that sets the default value of the
--quiet flag when running the reset command.  This enables users to change
the default behavior to take advantage of the performance advantages of
avoiding the scan for unstaged changes after reset.  Defaults to false.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/config.txt | 6 ++++++
 builtin/reset.c          | 1 +
 2 files changed, 7 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f6f4c21a54..a5cf4c019b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2728,6 +2728,12 @@ rerere.enabled::
 	`$GIT_DIR`, e.g. if "rerere" was previously used in the
 	repository.
 
+reset.quietDefault::
+	Sets the default value of the "quiet" option for the reset command.
+	Choosing "quiet" can optimize the performance of the reset command
+	by avoiding the scan of all files in the repo looking for additional
+	unstaged changes. Defaults to false.
+
 include::sendemail-config.txt[]
 
 sequence.editor::
diff --git a/builtin/reset.c b/builtin/reset.c
index 0822798616..7d151d48a0 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -306,6 +306,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_reset_config, NULL);
+	git_config_get_bool("reset.quietDefault", &quiet);
 
 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
-- 
2.18.0.windows.1

