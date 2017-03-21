Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67F6820958
	for <e@80x24.org>; Tue, 21 Mar 2017 05:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756384AbdCUFyB (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 01:54:01 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35714 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756316AbdCUFx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 01:53:59 -0400
Received: by mail-pg0-f67.google.com with SMTP id g2so23514051pge.2
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 22:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NAZrNKpyXZOFqJ3tXG2i3qpGpTT0WNpxL1lBiOKKOk8=;
        b=eW3LJzCX78JkWqnROVlp4P2YMTfXSzjf4gKBZUqA8Ckm4G1z0srSzWsQL+xNu/VFr0
         tQIlUFvDyd1o8hcWd7NSCtVPBuD9JCUIw3UfZ3E1oW8tmbt23rRwd6N1KgOyo/cgKfzf
         postqt0gVcgQiWffluzOAw3O9EsY5rHBpxML3Er7lFeYNuHSklVKWRHCf4KQmVDBQ178
         X+BQjHmDVoYdbgeormmZdAuZx61GBkJ6VRPEMSwd+wjE+l1/yaMwLHxjoQAq8T0xCsVs
         iaKeDhDDdvhZExwrb4zqn/b2AvOXgQ22kU4C5rFz37RsayxMrW4QTYaixkHAJBVocdcG
         lgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NAZrNKpyXZOFqJ3tXG2i3qpGpTT0WNpxL1lBiOKKOk8=;
        b=QTAie+XeCKNp7EmuWmlBE/vjXjTf6os6YDBxqCADEJnSKqTTUSOFwR4/WEtjI+sBXE
         PHQ89Sn8sWcgO2hrwoxogotdcsUnXH+RJKAZzJbShsmxZlf6hEmrIhOTAiKpHLOar3yt
         ria8sRp7WrOwb+42xU974sNnHRH7wgQ0X+Qw+GXIo4aKThjPsNhY4tOCLN5ijQn/I7Og
         07OOj8gEP6u2ce18F6fnuqhrTeLH2wHYK5hssBQDBMfCid2DScuTtk0skFV0H5GndMca
         MpXIeSZUtoBMaBw/r77gr1rnj0LVq4sRzCzaJ9fIbge3gih5bGgfW6NnmpIynL2Fy7Wc
         87sw==
X-Gm-Message-State: AFeK/H0xMJnLRLcXBX3xQb3TpwIC3rzaIWBKFbqVteuxRMFkSilXRPRlgFLpbDXNlTr8fg==
X-Received: by 10.99.107.73 with SMTP id g70mr35710358pgc.129.1490075637898;
        Mon, 20 Mar 2017 22:53:57 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:4101:1302::bd0])
        by smtp.gmail.com with ESMTPSA id h71sm36582738pfj.65.2017.03.20.22.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Mar 2017 22:53:56 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] log: if --decorate is not given, default to --decorate=auto
Date:   Mon, 20 Mar 2017 23:52:03 -0600
Message-Id: <20170321055203.26488-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.12.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's branching and merging system can be confusing, especially to new
users. When teaching people Git, I tell them to set log.decorate=auto.
This preference greatly improves the user's awareness of the local and
remote branches. So for the sake of user friendliness, I'd like to
change the default from log.decorate=no to log.decorate=auto.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/log.c  | 9 ++++++++-
 t/t4202-log.sh | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 281af8c1e..ddb4515dc 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -52,6 +52,11 @@ struct line_opt_callback_data {
 	struct string_list args;
 };
 
+static int auto_decoration_style()
+{
+	return (isatty(1) || pager_in_use()) ? DECORATE_SHORT_REFS : 0;
+}
+
 static int parse_decoration_style(const char *var, const char *value)
 {
 	switch (git_config_maybe_bool(var, value)) {
@@ -67,7 +72,7 @@ static int parse_decoration_style(const char *var, const char *value)
 	else if (!strcmp(value, "short"))
 		return DECORATE_SHORT_REFS;
 	else if (!strcmp(value, "auto"))
-		return (isatty(1) || pager_in_use()) ? DECORATE_SHORT_REFS : 0;
+		return auto_decoration_style();
 	return -1;
 }
 
@@ -405,6 +410,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		if (decoration_style < 0)
 			decoration_style = 0; /* maybe warn? */
 		return 0;
+	} else {
+		decoration_style = auto_decoration_style();
 	}
 	if (!strcmp(var, "log.showroot")) {
 		default_show_root = git_config_bool(var, value);
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 48b55bfd2..3aa8daba3 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -520,7 +520,7 @@ test_expect_success 'log --graph with merge' '
 '
 
 test_expect_success 'log.decorate configuration' '
-	git log --oneline >expect.none &&
+	git log --oneline --no-decorate >expect.none &&
 	git log --oneline --decorate >expect.short &&
 	git log --oneline --decorate=full >expect.full &&
 
-- 
2.12.0

