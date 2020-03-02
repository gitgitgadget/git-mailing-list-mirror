Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E0EC3F2D8
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 20:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537A221556
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 20:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bW95mXhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgCBUCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:02:09 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52634 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBUCI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 15:02:08 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so430299wmc.2
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 12:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G8hwyZE9b4aqVlxtmUDYzzZgBnctZROt+fRirvWBF6E=;
        b=bW95mXhvE7M1NJvJK6YBbTBZWwVBLP/K3pMjpjtLR/YIX/gblSPLxR61VjeBBhMx+C
         S95eLx563d3VY8fFvl6eBJr+laCsn4JOK2oSi8LDI0VjTXtyumJrSJk5coYe9Tzrknf3
         k+JghrRbYQQybketk65STzYEa0SNX4T10K3erZDtlIx/yQ6mfTFPziJT+dyRJ8viL07T
         dhdznvfd/zOJuCEaq6BQrLT1sw+DEcg8D4sIR3wStw4178bIK759tETNNWrDXh1pWYN7
         yCFxs6AxDPLDw3goFaJ3RP3zmvEOgdEDKIJqpR3ko2JQ4qZi0d/2xwcie63Vzk6hLZOL
         iQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G8hwyZE9b4aqVlxtmUDYzzZgBnctZROt+fRirvWBF6E=;
        b=roGnTYftRuWGTZR6KnuM3bjZiYAMx3I3SP5kRGtaduF9/q+QpcNs05eNpoFYev7YKp
         A78X2bGYbZhluzkHb1qDeB+yJWWi8JliV+SXuA1zcWqGxeDsNd/yJh79dpId4QRW0JYd
         fS15swy0TSrBz2IUKf2uAEYnHKwRHDOCz82cdbLT0yRheyZreY60rfbv+p6AUuRV0df8
         vb8XCYzl3MMLYXAFJGC9t7j30ZMQVbJYeOscbtfTOvnKIsKITRcRapEIuE1y+ur0n0jY
         464JvH8iitL84r4Rw2V2HK8BXjPGR8dVSr1YflTJwukb0LUrzyKPvCVQ+XIYUvLZmx/A
         VY6Q==
X-Gm-Message-State: ANhLgQ0aYyG5QT/rUilbT5C9S/X52zarpZJu1hCCnjg6Y6RVDK5G+60+
        q2pietEwcake0PZ8M3gYXaciVky3
X-Google-Smtp-Source: ADFU+vvE4d2B24HKNZyDDVHrKJB9qGW67hdHNq9YMH+VDE6tig5XAHHvpFoaeIOmfVCVIbnStwp2JQ==
X-Received: by 2002:a1c:156:: with SMTP id 83mr82111wmb.151.1583179324805;
        Mon, 02 Mar 2020 12:02:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h17sm30993087wro.52.2020.03.02.12.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 12:02:04 -0800 (PST)
Message-Id: <a4673803eaf881f7caa25d97e432c0ff0d065060.1583179320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v7.git.1583179320.gitgitgadget@gmail.com>
References: <pull.548.v6.git.1582778112.gitgitgadget@gmail.com>
        <pull.548.v7.git.1583179320.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Mar 2020 20:01:59 +0000
Subject: [PATCH v7 3/4] advice: revamp advise API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Currently it's very easy for the advice library's callers to miss
checking the visibility step before printing an advice. Also, it makes
more sense for this step to be handled by the advice library.

Add a new advise_if_enabled function that checks the visibility of
advice messages before printing.

Add a new helper advise_enabled to check the visibility of the advice
if the caller needs to carry out complicated processing based on that
value.

A list of advice_settings is added to cache the config variables names
and values, it's intended to replace advice_config[] and the global
variables once we migrate all the callers to use the new APIs.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Makefile               |  1 +
 advice.c               | 84 ++++++++++++++++++++++++++++++++++++++++--
 advice.h               | 51 +++++++++++++++++++++++++
 t/helper/test-advise.c | 21 +++++++++++
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  1 +
 t/t0018-advice.sh      | 32 ++++++++++++++++
 7 files changed, 187 insertions(+), 4 deletions(-)
 create mode 100644 t/helper/test-advise.c
 create mode 100755 t/t0018-advice.sh

diff --git a/Makefile b/Makefile
index 09f98b777ca..ed923a3e818 100644
--- a/Makefile
+++ b/Makefile
@@ -695,6 +695,7 @@ X =
 
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
+TEST_BUILTINS_OBJS += test-advise.o
 TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-ctype.o
diff --git a/advice.c b/advice.c
index 258cc9ba7af..9814d6cdfd8 100644
--- a/advice.c
+++ b/advice.c
@@ -96,13 +96,59 @@ static struct {
 	{ "pushNonFastForward", &advice_push_update_rejected }
 };
 
-static void vadvise(const char *advice, va_list params)
+static struct {
+	const char *key;
+	int enabled;
+} advice_setting[] = {
+	[ADVICE_ADD_EMBEDDED_REPO]			= { "addEmbeddedRepo", 1 },
+	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir", 1 },
+	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName", 1 },
+	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
+	[ADVICE_DETACHED_HEAD]				= { "detachedHead", 1 },
+	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates", 1 },
+	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated", 1 },
+	[ADVICE_IGNORED_HOOK]				= { "ignoredHook", 1 },
+	[ADVICE_IMPLICIT_IDENTITY]			= { "implicitIdentity", 1 },
+	[ADVICE_NESTED_TAG]				= { "nestedTag", 1 },
+	[ADVICE_OBJECT_NAME_WARNING]			= { "objectNameWarning", 1 },
+	[ADVICE_PUSH_ALREADY_EXISTS]			= { "pushAlreadyExists", 1 },
+	[ADVICE_PUSH_FETCH_FIRST]			= { "pushFetchFirst", 1 },
+	[ADVICE_PUSH_NEEDS_FORCE]			= { "pushNeedsForce", 1 },
+
+	/* make this an alias for backward compatibility */
+	[ADVICE_PUSH_UPDATE_REJECTED_ALIAS]		= { "pushNonFastForward", 1 },
+
+	[ADVICE_PUSH_NON_FF_CURRENT]			= { "pushNonFFCurrent", 1 },
+	[ADVICE_PUSH_NON_FF_MATCHING]			= { "pushNonFFMatching", 1 },
+	[ADVICE_PUSH_UNQUALIFIED_REF_NAME]		= { "pushUnqualifiedRefName", 1 },
+	[ADVICE_PUSH_UPDATE_REJECTED]			= { "pushUpdateRejected", 1 },
+	[ADVICE_RESET_QUIET_WARNING]			= { "resetQuiet", 1 },
+	[ADVICE_RESOLVE_CONFLICT]			= { "resolveConflict", 1 },
+	[ADVICE_RM_HINTS]				= { "rmHints", 1 },
+	[ADVICE_SEQUENCER_IN_USE]			= { "sequencerInUse", 1 },
+	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure", 1 },
+	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning", 1 },
+	[ADVICE_STATUS_HINTS]				= { "statusHints", 1 },
+	[ADVICE_STATUS_U_OPTION]			= { "statusUoption", 1 },
+	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie", 1 },
+	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor", 1 },
+};
+
+static const char turn_off_instructions[] =
+N_("\n"
+   "Disable this message with \"git config advice.%s false\"");
+
+static void vadvise(const char *advice, int display_instructions,
+		    const char *key, va_list params)
 {
 	struct strbuf buf = STRBUF_INIT;
 	const char *cp, *np;
 
 	strbuf_vaddf(&buf, advice, params);
 
+	if (display_instructions)
+		strbuf_addf(&buf, turn_off_instructions, key);
+
 	for (cp = buf.buf; *cp; cp = np) {
 		np = strchrnul(cp, '\n');
 		fprintf(stderr,	_("%shint: %.*s%s\n"),
@@ -119,7 +165,30 @@ void advise(const char *advice, ...)
 {
 	va_list params;
 	va_start(params, advice);
-	vadvise(advice, params);
+	vadvise(advice, 0, "", params);
+	va_end(params);
+}
+
+int advice_enabled(enum advice_type type)
+{
+	switch(type) {
+	case ADVICE_PUSH_UPDATE_REJECTED:
+		return advice_setting[ADVICE_PUSH_UPDATE_REJECTED].enabled &&
+		       advice_setting[ADVICE_PUSH_UPDATE_REJECTED_ALIAS].enabled;
+	default:
+		return advice_setting[type].enabled;
+	}
+}
+
+void advise_if_enabled(enum advice_type type, const char *advice, ...)
+{
+	va_list params;
+
+	if (!advice_enabled(type))
+		return;
+
+	va_start(params, advice);
+	vadvise(advice, 1, advice_setting[type].key, params);
 	va_end(params);
 }
 
@@ -149,6 +218,13 @@ int git_default_advice_config(const char *var, const char *value)
 		if (strcasecmp(k, advice_config[i].name))
 			continue;
 		*advice_config[i].preference = git_config_bool(var, value);
+		break;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(advice_setting); i++) {
+		if (strcasecmp(k, advice_setting[i].key))
+			continue;
+		advice_setting[i].enabled = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -159,8 +235,8 @@ void list_config_advices(struct string_list *list, const char *prefix)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(advice_config); i++)
-		list_config_item(list, prefix, advice_config[i].name);
+	for (i = 0; i < ARRAY_SIZE(advice_setting); i++)
+		list_config_item(list, prefix, advice_setting[i].key);
 }
 
 int error_resolve_conflict(const char *me)
diff --git a/advice.h b/advice.h
index b706780614d..d72ab4a06c1 100644
--- a/advice.h
+++ b/advice.h
@@ -32,9 +32,60 @@ extern int advice_checkout_ambiguous_remote_branch_name;
 extern int advice_nested_tag;
 extern int advice_submodule_alternate_error_strategy_die;
 
+/*
+ * To add a new advice, you need to:
+ * Define a new advice_type.
+ * Add a new entry to advice_setting array.
+ * Add the new config variable to Documentation/config/advice.txt.
+ * Call advise_if_enabled to print your advice.
+ */
+ enum advice_type {
+	ADVICE_ADD_EMBEDDED_REPO,
+	ADVICE_AM_WORK_DIR,
+	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
+	ADVICE_COMMIT_BEFORE_MERGE,
+	ADVICE_DETACHED_HEAD,
+	ADVICE_FETCH_SHOW_FORCED_UPDATES,
+	ADVICE_GRAFT_FILE_DEPRECATED,
+	ADVICE_IGNORED_HOOK,
+	ADVICE_IMPLICIT_IDENTITY,
+	ADVICE_NESTED_TAG,
+	ADVICE_OBJECT_NAME_WARNING,
+	ADVICE_PUSH_ALREADY_EXISTS,
+	ADVICE_PUSH_FETCH_FIRST,
+	ADVICE_PUSH_NEEDS_FORCE,
+	ADVICE_PUSH_NON_FF_CURRENT,
+	ADVICE_PUSH_NON_FF_MATCHING,
+	ADVICE_PUSH_UNQUALIFIED_REF_NAME,
+	ADVICE_PUSH_UPDATE_REJECTED_ALIAS,
+	ADVICE_PUSH_UPDATE_REJECTED,
+	ADVICE_RESET_QUIET_WARNING,
+	ADVICE_RESOLVE_CONFLICT,
+	ADVICE_RM_HINTS,
+	ADVICE_SEQUENCER_IN_USE,
+	ADVICE_SET_UPSTREAM_FAILURE,
+	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
+	ADVICE_STATUS_HINTS,
+	ADVICE_STATUS_U_OPTION,
+	ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
+	ADVICE_WAITING_FOR_EDITOR,
+};
+
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
 void advise(const char *advice, ...);
+
+/**
+ * Checks if advice type is enabled (can be printed to the user).
+ * Should be called before advise().
+ */
+int advice_enabled(enum advice_type type);
+
+/**
+ * Checks the visibility of the advice before printing.
+ */
+void advise_if_enabled(enum advice_type type, const char *advice, ...);
+
 int error_resolve_conflict(const char *me);
 void NORETURN die_resolve_conflict(const char *me);
 void NORETURN die_conclude_merge(void);
diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
new file mode 100644
index 00000000000..cdafa413e37
--- /dev/null
+++ b/t/helper/test-advise.c
@@ -0,0 +1,21 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "advice.h"
+#include "config.h"
+
+int cmd__advise_if_enabled(int argc, const char **argv)
+{
+	if (!argv[1])
+	die("usage: %s <advice>", argv[0]);
+
+	setup_git_directory();
+	git_config(git_default_config, NULL);
+
+	/*
+	  Any advice type can be used for testing, but NESTED_TAG was selected
+	  here and in t0018 where this command is being executed.
+	 */
+	advise_if_enabled(ADVICE_NESTED_TAG, argv[1]);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index f20989d4497..6977badc690 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -14,6 +14,7 @@ struct test_cmd {
 };
 
 static struct test_cmd cmds[] = {
+	{ "advise", cmd__advise_if_enabled },
 	{ "chmtime", cmd__chmtime },
 	{ "config", cmd__config },
 	{ "ctype", cmd__ctype },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 8ed2af71d1b..ca5e33b842f 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -4,6 +4,7 @@
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "git-compat-util.h"
 
+int cmd__advise_if_enabled(int argc, const char **argv);
 int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
 int cmd__ctype(int argc, const char **argv);
diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
new file mode 100755
index 00000000000..e03554d2f34
--- /dev/null
+++ b/t/t0018-advice.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='Test advise_if_enabled functionality'
+
+. ./test-lib.sh
+
+test_expect_success 'advice should be printed when config variable is unset' '
+	cat >expect <<-\EOF &&
+	hint: This is a piece of advice
+	hint: Disable this message with "git config advice.nestedTag false"
+	EOF
+	test-tool advise "This is a piece of advice" 2>actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'advice should be printed when config variable is set to true' '
+	cat >expect <<-\EOF &&
+	hint: This is a piece of advice
+	hint: Disable this message with "git config advice.nestedTag false"
+	EOF
+	test_config advice.nestedTag true &&
+	test-tool advise "This is a piece of advice" 2>actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'advice should not be printed when config variable is set to false' '
+	test_config advice.nestedTag false &&
+	test-tool advise "This is a piece of advice" 2>actual &&
+	test_must_be_empty actual
+'
+
+test_done
-- 
gitgitgadget

