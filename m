Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEA831F453
	for <e@80x24.org>; Mon, 22 Oct 2018 13:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbeJVVhQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 17:37:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36332 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbeJVVhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 17:37:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id u34-v6so46140580qth.3
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 06:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qD4TLfw1OwL1VFC/O8gyhnKjtVkTooSK/hzVsEyxswI=;
        b=YO9WNQix+D0WrUfqeJgSCdoBEtIlTghZZRq+FIHJUeq4I4AFn8QtEA8LMWDPVqYZHU
         NE1GUDqGOB9oJbF3K8QiwkFiB/4edfMa9gtdeRz1NVMdMIskxNU5JN8JT7UyfS/UQUqm
         93QDDQjF6gj1I7lo/s1F1lcE8/QTeLaAX5j/JNxXLqxO0ljTnA+2WoCtD6Wmr6ARaAwa
         +SF3GqEOvv/wf8M6WOo8oFBCNM14/f1NlC+1AAnr72RCGcKCta9DxQ7PBqfCHUWBb540
         EXRRCAfCMi+/9tk0FmxeZ6O4PIk5OB1OBa26yXeHXyincNs1HxXIAzSTvMdwEfGhz5Ow
         24mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qD4TLfw1OwL1VFC/O8gyhnKjtVkTooSK/hzVsEyxswI=;
        b=nX1+YSalbbfpWcPFpghKv3vfKR7lBgiToaeVLn/+oUcDllwwUuanMFmxOEg8kUa4Ue
         ah5KzPhopV/nbACqQDpCEs4xDRBEk8hf/xMPBLZ0lEvOwlmbzpBrwmDMMpwuBSJyY26e
         kHDjLE7KNhspqJSV0WAyq5CuxJ5QUud9yhVMUmuko1l89cSGZqZNeoppJphljjVNt3+M
         Zgrd/1J/x42KoJHLTC8A8Gv6JLjqc7aeDvRBmPfDhVRoLl/kXv36D7Rx1QLEQpSbF+SJ
         Avlbedh9ETrJD71IRMoW/6nJQtF5XeJkzGS9dVmOtpMPm8JTteHHQllkFEAFT5w3KcZ8
         LRBQ==
X-Gm-Message-State: ABuFfog4pAYYl0BRwIHfKz++K830gd64io70Y8SHzoOF+LFNgENZu3/q
        4mvk/ggma6uqBSRrzv2eDwCh68NL81E=
X-Google-Smtp-Source: ACcGV62I1iv4tuIOjTcifi7XRGhFipAz+DwpNYxhJzdzA7oOl8rPHgI6CCqx6HvjQPkwBXUSNUNCeA==
X-Received: by 2002:a0c:9689:: with SMTP id a9mr25509798qvd.103.1540214321777;
        Mon, 22 Oct 2018 06:18:41 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id n39-v6sm746052qtn.36.2018.10.22.06.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 06:18:40 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, peartben@gmail.com,
        peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v3 2/3] reset: add new reset.quiet config setting
Date:   Mon, 22 Oct 2018 09:18:27 -0400
Message-Id: <20181022131828.21348-3-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181022131828.21348-1-peartben@gmail.com>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181022131828.21348-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Add a reset.quiet config setting that sets the default value of the --quiet
flag when running the reset command.  This enables users to change the
default behavior to take advantage of the performance advantages of
avoiding the scan for unstaged changes after reset.  Defaults to false.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/config.txt    | 3 +++
 Documentation/git-reset.txt | 4 +++-
 builtin/reset.c             | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f6f4c21a54..a2d1b8b116 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2728,6 +2728,9 @@ rerere.enabled::
 	`$GIT_DIR`, e.g. if "rerere" was previously used in the
 	repository.
 
+reset.quiet::
+	When set to true, 'git reset' will default to the '--quiet' option.
+
 include::sendemail-config.txt[]
 
 sequence.editor::
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 1d697d9962..51a427a34a 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -95,7 +95,9 @@ OPTIONS
 
 -q::
 --quiet::
-	Be quiet, only report errors.
+--no-quiet::
+	Be quiet, only report errors. The default behavior respects the
+	`reset.quiet` config option, or `--no-quiet` if that is not set.
 
 
 EXAMPLES
diff --git a/builtin/reset.c b/builtin/reset.c
index 04f0d9b4f5..3b43aee544 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -306,6 +306,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_reset_config, NULL);
+	git_config_get_bool("reset.quiet", &quiet);
 
 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
-- 
2.18.0.windows.1

