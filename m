Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D996EC77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 14:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbjFBOdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 10:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjFBOdq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 10:33:46 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F6499
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 07:33:45 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so924757e87.2
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 07:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685716423; x=1688308423;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EE+h74ILP/1MKzKfVINgrovpJr0l7hUl/j7o9LH69m0=;
        b=ecmL07XWWEFUQgaMXBxdOOILrGmBgd2hL+f6Ce95fYRN9vwu3iz6+FRfgTH52xu3BK
         qxQvCEvailC7V3+ujytbv+h3UvIzuA/zrjrCvlavh+DKqD67EGoXyHgGhyyniFyQTVai
         dM7HtQk8vzWiej3cyd37zPwXx7XGag/5jEAKETyKZeT1t0jYlLa8XrYEAjzkrUxiFZkA
         odZn8mfnSPMErvOOKVVM36p+mP1gek4olUqacy5GU2G04KRuAbzkLGvJgwpscOlpegrQ
         p7dC8mavA7ErKmrruT5N9LgRfGiBJcvaIc4xoDGoRANuiUSStvBjwxrNWRKnYcZNgK5N
         HRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685716423; x=1688308423;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EE+h74ILP/1MKzKfVINgrovpJr0l7hUl/j7o9LH69m0=;
        b=fs9QoW05QjLjOVPLFFn2ls8BJtDMFAi7p2Bhpf7eI4pu1RmHwzQPOVKxiiBm3wMYob
         0NlZwz3c9U5F3wfhXnqia5jV7gpmQBEAJuchoIta1obx7jsCuXelCdftKfSVVN5w2BkE
         pz5q0szH1TtAQmfIEHY2L5pwFr53EMglcKIp/0oTzVohhQxfk3w+2b3AOfQXp9LjxQb3
         TBmemUFCH2cv7Rlmp8VC92VKWN9BCEzvf3AhTw+TEoKDj6+S1R4DLz4g4Jq/TqZ9AcS+
         w7YhOd9+AiUjcgcxiKeey+70gccu4+w/hakdtcndh7tzz0C5r1qddYMlVUM6GASc/AYq
         BqyQ==
X-Gm-Message-State: AC+VfDx1jo/zldozj8UhhUn9PSQs8OganpxHWt5aEVLhI6QJ6YJkBL6I
        iUk3mwNSYM4wVEcc3JyhhBPPQ4eXBTc=
X-Google-Smtp-Source: ACHHUZ7KCe3gvjJKkfzEhT3uQtP/eekjsIEcLJG4oEbMQpJC8G/PAUkHCkLwAsrcRLQPD9guX0wKlA==
X-Received: by 2002:ac2:5477:0:b0:4f6:56:c40e with SMTP id e23-20020ac25477000000b004f60056c40emr2105674lfn.28.1685716422856;
        Fri, 02 Jun 2023 07:33:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a7-20020adffb87000000b002ca864b807csm1894533wrr.0.2023.06.02.07.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:33:42 -0700 (PDT)
Message-Id: <a42dd9397d07b2dc4a0d7e75bfe1af2e46cad262.1685716420.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1539.git.1685716420.gitgitgadget@gmail.com>
References: <pull.1539.git.1685716420.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Jun 2023 14:33:35 +0000
Subject: [PATCH 1/6] config: create new global config helpers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, johannes.schindelin@gmx.de, newren@gmail.com,
        peff@peff.net, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Git's default config is loaded by each builtin at some point during its
cmd_*() method. If this is forgotten, then Git can behave strangely
compared to user expectations.

To avoid this kind of bug, create a new system for loading common
"global" config (config not currently scoped to a repository struct).

The basic idea is that we will add config values one-by-one to the
int_config_key enum (and non-int values can follow a similar pattern
later).

To access the value, a consumer calls get_int_config_global() with the
appropriate enum value. This method will check if the config has been
loaded already (using the 64-bit-for-now global_ints_initialized
bitmask) and decide whether to use the stored value or to load a value
from config.

While this method is not currently used by any consumer, there are cases
where some of our default config settings are looked up by global
variable before Git has a chance to load config. This cannot be helped,
due to paths not being initialized at that point in time. We could
remove the dependencies on those values, but it would require changing
things in some difficult ways or lead to unnecessary duplication across
methods.

For now, create the declare_config_available() method, which is called
in cmd_main() when it is appropriate to "unlock" looking up these values
from config. Before this method is called, get_int_config_global() will
return the default value.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Makefile             |  1 +
 git.c                |  4 ++++
 global-config.c      | 44 ++++++++++++++++++++++++++++++++++++++++++++
 global-config.h      | 25 +++++++++++++++++++++++++
 t/helper/test-tool.c |  3 +++
 5 files changed, 77 insertions(+)
 create mode 100644 global-config.c
 create mode 100644 global-config.h

diff --git a/Makefile b/Makefile
index e440728c246..d088589d818 100644
--- a/Makefile
+++ b/Makefile
@@ -1033,6 +1033,7 @@ LIB_OBJS += fsmonitor-ipc.o
 LIB_OBJS += fsmonitor-settings.o
 LIB_OBJS += gettext.o
 LIB_OBJS += git-zlib.o
+LIB_OBJS += global-config.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
diff --git a/git.c b/git.c
index 3252d4c7661..72632e659d0 100644
--- a/git.c
+++ b/git.c
@@ -12,6 +12,7 @@
 #include "shallow.h"
 #include "trace.h"
 #include "trace2.h"
+#include "global-config.h"
 
 #define RUN_SETUP		(1<<0)
 #define RUN_SETUP_GENTLY	(1<<1)
@@ -443,6 +444,9 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	if (!help && p->option & NEED_WORK_TREE)
 		setup_work_tree();
 
+	/* At this point, we can allow loading config. */
+	declare_config_available();
+
 	trace_argv_printf(argv, "trace: built-in: git");
 	trace2_cmd_name(p->cmd);
 	trace2_cmd_list_config();
diff --git a/global-config.c b/global-config.c
new file mode 100644
index 00000000000..db9643afd7a
--- /dev/null
+++ b/global-config.c
@@ -0,0 +1,44 @@
+#include "git-compat-util.h"
+#include "global-config.h"
+#include "config.h"
+
+static int global_ints[] = {
+	[INT_CONFIG_NONE] = 0, /* unused*/
+};
+
+/* Bitmask for the enum. */
+static uint64_t global_ints_initialized;
+
+static const char *global_int_names[] = {
+	[INT_CONFIG_NONE] = NULL, /* unused*/
+};
+
+static int config_available;
+
+void declare_config_available(void)
+{
+	config_available = 1;
+}
+
+int get_int_config_global(enum int_config_key key)
+{
+	uint64_t key_index;
+
+	if (key < 0 || key >= sizeof(global_ints))
+		BUG("invalid int_config_key %d", key);
+
+	key_index = (uint64_t)1 << key;
+
+	/*
+	 * Is it too early to load from config?
+	 * Have we already loaded from config?
+	 */
+	if (!config_available || (global_ints_initialized & key_index))
+		return global_ints[key];
+	global_ints_initialized |= key_index;
+
+	/* Try getting a boolean value before trying an int. */
+	if (git_config_get_maybe_bool(global_int_names[key], &global_ints[key]) < 0)
+		git_config_get_int(global_int_names[key], &global_ints[key]);
+	return global_ints[key];
+}
diff --git a/global-config.h b/global-config.h
new file mode 100644
index 00000000000..407dff19ee9
--- /dev/null
+++ b/global-config.h
@@ -0,0 +1,25 @@
+#ifndef GLOBAL_CONFIG_H
+#define GLOBAL_CONFIG_H
+
+enum int_config_key {
+	INT_CONFIG_NONE = 0,
+};
+
+/**
+ * During initial process loading, the config system is not quite available.
+ * The config global system needs an indicator that the process is ready
+ * to read config. Before this method is called, it will return the
+ * default values.
+ */
+void declare_config_available(void);
+
+/**
+ * Given a config key (by enum), return its value.
+ *
+ * If declare_config_available() has not been called, then this returns
+ * the default value. Otherwise, it guarantees that the value has been
+ * filled from config before returning the value.
+ */
+int get_int_config_global(enum int_config_key key);
+
+#endif /* GLOBAL_CONFIG_H */
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index abe8a785eb6..36340d36307 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -3,6 +3,7 @@
 #include "test-tool-utils.h"
 #include "trace2.h"
 #include "parse-options.h"
+#include "global-config.h"
 
 static const char * const test_tool_usage[] = {
 	"test-tool [-C <directory>] <command [<arguments>...]]",
@@ -127,6 +128,8 @@ int cmd_main(int argc, const char **argv)
 	if (working_directory && chdir(working_directory) < 0)
 		die("Could not cd to '%s'", working_directory);
 
+	declare_config_available();
+
 	for (i = 0; i < ARRAY_SIZE(cmds); i++) {
 		if (!strcmp(cmds[i].name, argv[1])) {
 			argv++;
-- 
gitgitgadget

