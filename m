Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D39721F453
	for <e@80x24.org>; Thu, 25 Apr 2019 14:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfDYO7D (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 10:59:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37040 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfDYO7C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 10:59:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id z8so1561374pln.4
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hUHivn+OkT/7E90g/6gN4oqlh93tbn7HbFgTgIC5I5c=;
        b=b8gD5ABYl5f9SUSM5iKkdcgjjibf4KGcwZ9Iemdh1YEK5aOeHGlhN5k/2WpLRtIOuT
         hKtLSPTsLPHRQFYkjeVWPbYGQ2fXnxgg7kNwGaTej9V6AfnCaeSQUlYz7EZGHpagV5mH
         V5OkfhDWqifu+6fJmrMtV6Hdoqvku6P4pvCmaOIaw8SmOnMfpJUTdeAgqTR797/Vx3Xl
         bmwbIg+V1VsQK+50txQebkHa9tWYX8v+6lrtglQAISKf7RMo2fW6dcB3qE2af3Ecx3NA
         DhiEA+sb0d1UEnkWKDQL6K2UNmycEi1uW0rTWgmiuG4drbfL2o8DZEPQt1TZ9IfUyTad
         4scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hUHivn+OkT/7E90g/6gN4oqlh93tbn7HbFgTgIC5I5c=;
        b=lJ2HkWctijwRQGGrBWOcWE7lyaeuJAeh34lFv2tHxNRA2DJpk+S1wBTtdiCl3/tz87
         bwu0RMl460b7NpmCVEUY8QanTQP37qhs/wdL/yv8WCU4B5GFrRNeV8jfaLIn4X7h9TH1
         z74kMQWxaq2WDTnmf+fupW2MF6Mgf/GGKj1igMDdqPtonwhtVezd9jfAgsD57oTCGcUP
         +rk/cc+qjk/SBb5yqDGlfvHxyZCF4MDYnl/PyBeoSiYtGCngO6LGlaNJHtSJOgNwwOkL
         s7gawiNXVDPlfbxgPfL9RgRxFly9vAXOWKftCi7M3ftRquV1nS8vgUTTH40fm9DyZFdF
         7lyw==
X-Gm-Message-State: APjAAAV40FkHowt0V61UcnGl+2si30Y5KTf7EgYAOFjIKPW6QBrr0lEN
        3/U8TcOhVma5W/OmdlndKp0=
X-Google-Smtp-Source: APXvYqzix4N/B4W0hGUJ1AqQqqEs5f1Bxw4ZPXfcHTgh8PSspL5Dr9FOGAtagkJMSMRYVPAsp7RywQ==
X-Received: by 2002:a17:902:263:: with SMTP id 90mr40386322plc.257.1556204341149;
        Thu, 25 Apr 2019 07:59:01 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id k10sm23808996pgo.82.2019.04.25.07.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Apr 2019 07:59:00 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2] Honor core.precomposeUnicode in more places
Date:   Thu, 25 Apr 2019 07:58:54 -0700
Message-Id: <20190425145854.5185-1-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.503.g24b69a0db9
In-Reply-To: <20190423173056.28523-1-newren@gmail.com>
References: <20190423173056.28523-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mac's HFS where git sets core.precomposeUnicode to true automatically
by git init/clone, when a user creates a simple unicode refname (in NFC
format) such as españa:

  $ git branch españa

different commands would display the branch name differently.  For
example, git branch, git log --decorate, and git fast-export all used

  65 73 70 61 c3 b1 61  (or "espa\xc3\xb1a")

(NFC form) while show-ref would use

  65 73 70 61 6e cc 83 61  (or "espan\xcc\x83a")

(NFD form).  A stress test for git filter-repo was tripped up by this
inconsistency, though digging in I found that the problems could
compound; for example, if the user ran

  $ git pack-refs --all

and then tried to check out the branch, they would be met with:

  $ git checkout españa
  error: pathspec 'españa' did not match any file(s) known to git

  $ git checkout españa --
  fatal: invalid reference: españa

  $ git branch
    españa
  * master

Note that the user could run the `git branch` command first and copy and
paste the `españa` portion of the output and still see the same two
errors.  Also, if the user added --no-prune to the pack-refs command,
then they would see three branches: master, españa, and españa (those
last two are NFC vs. NFD forms, even if they render the same).

Further, if the user had the `españa` branch checked out before
running `git pack-refs --all`, the user would be greeted with (note
that I'm trimming trailing output with an ellipsis):

  $ git rev-parse HEAD
  fatal: ambiguous argument 'HEAD': unknown revision or path...

  $ git status
  On branch españa

  No commits yet...

Or worse, if the user didn't check this stuff first, running `git
commit` will create a new commit with all changes of all of history
being squashed into it.

In addition to pack-refs, one could also get into this state with
upload-pack or anything that calls either pack-refs or upload-pack (e.g.
gc or clone).

Add code in a few places (pack-refs, show-ref, upload-pack) to check and
honor the setting of core.precomposeUnicode to avoid these bugs.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Changes since v1:
  * Excised unnecessary portion of the first sentence of the commit message

 builtin/pack-refs.c | 2 ++
 builtin/show-ref.c  | 3 +++
 upload-pack.c       | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index f3353564f9..cfbd5c36c7 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "config.h"
 #include "parse-options.h"
 #include "refs.h"
 #include "repository.h"
@@ -16,6 +17,7 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "prune", &flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
 		OPT_END(),
 	};
+	git_config(git_default_config, NULL);
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
 	return refs_pack_refs(get_main_ref_store(the_repository), flags);
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 6a706c02a6..6456da70cc 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "config.h"
 #include "refs.h"
 #include "object-store.h"
 #include "object.h"
@@ -182,6 +183,8 @@ static const struct option show_ref_options[] = {
 
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
+	git_config(git_default_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, 0);
 
diff --git a/upload-pack.c b/upload-pack.c
index d098ef5982..159f751ea4 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1064,6 +1064,8 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 		allow_ref_in_want = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowsidebandall", var)) {
 		allow_sideband_all = git_config_bool(var, value);
+	} else if (!strcmp("core.precomposeunicode", var)) {
+		precomposed_unicode = git_config_bool(var, value);
 	}
 
 	if (current_config_scope() != CONFIG_SCOPE_REPO) {
-- 
2.21.0.503.g24b69a0db9

