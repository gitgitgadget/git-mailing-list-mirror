Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF9401F461
	for <e@80x24.org>; Mon,  1 Jul 2019 20:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfGAUUd (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 16:20:33 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:54632 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAUUc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 16:20:32 -0400
Received: by mail-qt1-f201.google.com with SMTP id r57so14365365qtj.21
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 13:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c8xROOoy7OcOqiVdstCH/iWg1ZGb/TGPkK7Dlp8iY2w=;
        b=I1GNsZHcDfbO0G6dymYNnHv1hn1ez8BhWfnEEICivIrzWLf8gg8ZrFCYWloJDPn506
         MoiJxFhg9nC9sJJHSM83Eq1vapW21FTa0Pe4Acuwt581Lwk9r3DIhu/STqS4dX4ckQld
         W2XR2cCj8Z7TK5t6W6Nq2+j6rPOgrT/ec/mAF7y65n7zC2KKU4Nn6+tZZ/wypLnT9k5a
         9YGl3/tZmLR2pbYYtZuUiTT4DNuLPIwQWaWRhF16rKrdF8bQRCBwbcNiwEuXHOQ57eFk
         3XeYIP1Sw3B+S8tM5AKLLKuyEfWxsLdraDDy7y2nYUWqSvvz+GoeJjBwMCBlWdAx6+u2
         ZX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c8xROOoy7OcOqiVdstCH/iWg1ZGb/TGPkK7Dlp8iY2w=;
        b=C6LqG5G/0/imWZ/D4Ul8cjQt0pAQoQ/MPTSf4866jv4R/DHcE+79yqkBSosjqblt0V
         L5ayUMVVezMm0RRDQtW+RLGrTeobcH8t3AEKXAv7k9N77RnLxBxt1qLvmkMu2l0mqwdy
         ZQLAyEMDAJO0dFgjqaGEK6KpO8EGNZneQxwIiiX0YaNfYMsb/NnhkWkW16VvoGcmX3Ja
         WEy7fA6axVYNvswJNPmbu4T5TFtMqIJVDa45wjBtvUtqbB5EHJMVM6/UEcHfthwv0WHG
         xdNrPMC5VUN3DeOaMBg+Pao2h1d3uT/ZHnLOQa9WC1Ge1iR82EMC0j0xccdIofrXoKGQ
         oxkw==
X-Gm-Message-State: APjAAAWH1MVsZEVyktefv9FQ5+D1Q/Wc5c2NxFJN3KbIX+8AAA7lfS9y
        HL5FHv7vqDlOax4izlCQqPKrxlBxcoXDmlUSI8erxHmdbQVcJIT7vk37qI9u94yrOB7OieV3WwM
        btesG/KL7oBvjO66+xcCkWJGZqEnSszyHoV1te59EWp82pxYa8DuMYPJVL3ffSnLsqQUU8672MA
        ==
X-Google-Smtp-Source: APXvYqyL+sIxqcaufTqkTHrI3tPujMAG4MReEQmhmSOvDFtAgdZg23gP5YE3F+PpaZarlPsjjUX2U1zdrttZTmD+kc8=
X-Received: by 2002:ac8:156:: with SMTP id f22mr21774808qtg.58.1562012431791;
 Mon, 01 Jul 2019 13:20:31 -0700 (PDT)
Date:   Mon,  1 Jul 2019 13:20:05 -0700
In-Reply-To: <20190701202014.34480-1-emilyshaffer@google.com>
Message-Id: <20190701202014.34480-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190701201934.30321-1-emilyshaffer@google.com> <20190701202014.34480-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v3 04/13] walken: add handler to git_config
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For now, we have no configuration options we want to set up for
ourselves, but in the future we may need to. At the very least, we
should invoke git_default_config() for each config option; we will do so
inside of a skeleton config callback so that we know where to add
configuration handling later on when we need it.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/builtin/walken.c b/builtin/walken.c
index 19657b5e31..e53c42ea18 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -5,6 +5,7 @@
  */
 
 #include "builtin.h"
+#include "config.h"
 #include "parse-options.h"
 
 
@@ -16,11 +17,36 @@
 static void init_walken_defaults(void)
 {
 	/*
-	 * We don't actually need the same components `git log` does; leave this
-	 * empty for now.
+	 * We don't use any other components or have settings to initialize, so
+	 * leave this empty.
 	 */
 }
 
+/*
+ * This method will be called back by git_config(). It is used to gather values
+ * from the configuration files available to Git.
+ *
+ * Each time git_config() finds a configuration file entry, it calls this
+ * callback. Then, this function should compare it to entries which concern us,
+ * and make settings changes as necessary.
+ *
+ * If we are called with a config setting we care about, we should use one of
+ * the helpers which exist in config.h to pull out the value for ourselves, i.e.
+ * git_config_string(...) or git_config_bool(...).
+ *
+ * If we don't match anything, we should pass it along to another stakeholder
+ * who may otherwise care - in log's case, grep, gpg, and diff-ui. For our case,
+ * we'll ignore everybody else.
+ */
+static int git_walken_config(const char *var, const char *value, void *cb)
+{
+	/*
+	 * For now, we don't have any custom configuration, so fall back on the
+	 * default config.
+	 */
+	return git_default_config(var, value, cb);
+}
+
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
 	/*
@@ -44,6 +70,8 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 
 	init_walken_defaults();
 
+	git_config(git_walken_config, NULL);
+
 	/*
 	 * This line is "human-readable" and we are writing a plumbing command,
 	 * so we localize it and use the trace library to print only when
-- 
2.22.0.410.gd8fdbe21b5-goog

