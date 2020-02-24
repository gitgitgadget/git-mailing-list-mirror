Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D01C11D35
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 15:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C7B2082F
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 15:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBI7+Obs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgBXPNZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:13:25 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40094 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgBXPNY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 10:13:24 -0500
Received: by mail-ed1-f68.google.com with SMTP id p3so12268629edx.7
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 07:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=trjYfZkQ/5hUjX/V5bYRnJZfvNYcpZhcjp8sogVSBUo=;
        b=cBI7+ObsiK3xGzY3wCnCT4Ct5Y5JcvdvWSX3M1G0GEI8kFO0MI1Z2zV7ckVtqbaQ89
         r5lhYB2nZTOg02L8pWaGAabJOjmD6LXsKyKwBU2x18HCutnZD3lHj35jOnnMcGxEpgie
         rcO4V007LT3JM3jBU8VPuhXWWyupcAsQVQRjKURr1N0gA5Jm6Eu8CeXzY9iJVSdzo+ti
         2N/mdDyLljxp6gySmp0nEXL31dmZtiqGCf7ZZpAxafIwolQzBpwZpLuZWg0QVr/gQJTs
         tBrmGKH81B8PBQxDTGO3VpoVAAEnFJZJq1fFc46s6hfQzYZ9ljDimKExBl+PbGj03c2x
         CO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=trjYfZkQ/5hUjX/V5bYRnJZfvNYcpZhcjp8sogVSBUo=;
        b=plLdg71N6YYazs8BEvwlna7Kl9w85No8F8+RMY38xpJ+shfM6s+AvKZr7BFC/JCFyv
         nOqRFnIyokLZIh1JUHq1yspkd6wUaspgHj7TfMzdEzypVj/kNO+GC5OCXVh3GDRQtIvF
         XlIZFhNN3PtD4RUjmHHyuxQaJbhru1b6wrZAsRiWnyfu2JXOQUv1S897MdzeAQlxvhUD
         P1GVQolTouSbwStsPRMSd3u7tnS1PfnEiy6danMowIEVNzbrHMnJZfESQshjBO1hrDgf
         LrXyPRMq24j7LM10NuI7FnXbpllDZjBQQ0QYXi8ZFTw74xT0sCcugXCxKB/SIblSsc9p
         A4Yg==
X-Gm-Message-State: APjAAAWmDkfEWEDEjuDts4W76DT4t4NQsetdqQlmmfcfB+NRgfHDP9l6
        roG2GTiGsR4YlVAW34ft6t1+niMQ
X-Google-Smtp-Source: APXvYqzi+YQwFcm/iYz5Z1jeH1lOAKW+bcg91yF+xMReux24+Tudbo3LaIv2tMODMSAfc5mC1O1a8w==
X-Received: by 2002:a17:906:ecea:: with SMTP id qt10mr48445682ejb.235.1582557202304;
        Mon, 24 Feb 2020 07:13:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j15sm799726ejy.55.2020.02.24.07.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:13:21 -0800 (PST)
Message-Id: <04c3e5760f60cf394af66bfdb4fe1d561a093567.1582557199.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
References: <pull.548.v3.git.1582144442.gitgitgadget@gmail.com>
        <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Feb 2020 15:13:17 +0000
Subject: [PATCH v4 2/3] advice: revamp advise API
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

A list of config variables 'advice_config_keys' is added to be used by
list_config_advices() instead of 'advice_config[]' because we'll get
rid of 'advice_config[]' and the global variables once we migrate all
the callers to use the new APIs.

Also change the advise call in tag library from advise() to
advise_if_enabled() to construct an example of the usage of the new
API.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Makefile               |  1 +
 advice.c               | 84 ++++++++++++++++++++++++++++++++++++++++--
 advice.h               | 52 ++++++++++++++++++++++++++
 t/helper/test-advise.c | 19 ++++++++++
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  1 +
 t/t0018-advice.sh      | 28 ++++++++++++++
 7 files changed, 182 insertions(+), 4 deletions(-)
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
index fd836332dad..ff25087fa7e 100644
--- a/advice.c
+++ b/advice.c
@@ -96,13 +96,55 @@ static struct {
 	{ "pushNonFastForward", &advice_push_update_rejected }
 };
 
-static void vadvise(const char *advice, va_list params)
+static const char *advice_config_keys[] = {
+	[FETCH_SHOW_FORCED_UPDATES]		 = "fetchShowForcedUpdates",
+	[PUSH_UPDATE_REJECTED]			 = "pushUpdateRejected",
+	/* make this an alias for backward compatibility */
+	[PUSH_UPDATE_REJECTED_ALIAS]		 = "pushNonFastForward",
+
+	[PUSH_NON_FF_CURRENT]			 = "pushNonFFCurrent",
+	[PUSH_NON_FF_MATCHING]			 = "pushNonFFMatching",
+	[PUSH_ALREADY_EXISTS]			 = "pushAlreadyExists",
+	[PUSH_FETCH_FIRST]			 = "pushFetchFirst",
+	[PUSH_NEEDS_FORCE]			 = "pushNeedsForce",
+	[PUSH_UNQUALIFIED_REF_NAME]		 = "pushUnqualifiedRefName",
+	[STATUS_HINTS]				 = "statusHints",
+	[STATUS_U_OPTION]			 = "statusUoption",
+	[STATUS_AHEAD_BEHIND_WARNING]		 = "statusAheadBehindWarning",
+	[COMMIT_BEFORE_MERGE]			 = "commitBeforeMerge",
+	[RESET_QUIET_WARNING]			 = "resetQuiet",
+	[RESOLVE_CONFLICT]			 = "resolveConflict",
+	[SEQUENCER_IN_USE]			 = "sequencerInUse",
+	[IMPLICIT_IDENTITY]			 = "implicitIdentity",
+	[DETACHED_HEAD]				 = "detachedHead",
+	[SET_UPSTREAM_FAILURE]			 = "setupStreamFailure",
+	[OBJECT_NAME_WARNING]			 = "objectNameWarning",
+	[AMWORKDIR]				 = "amWorkDir",
+	[RM_HINTS]				 = "rmHints",
+	[ADD_EMBEDDED_REPO]			 = "addEmbeddedRepo",
+	[IGNORED_HOOK]				 = "ignoredHook",
+	[WAITING_FOR_EDITOR] 			 = "waitingForEditor",
+	[GRAFT_FILE_DEPRECATED]			 = "graftFileDeprecated",
+	[CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME]	 = "checkoutAmbiguousRemoteBranchName",
+	[NESTED_TAG]				 = "nestedTag",
+	[SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = "submoduleAlternateErrorStrategyDie"
+};
+
+static const char turn_off_instructions[] =
+N_("\n"
+   "Disable this message with \"git config %s false\"");
+
+static void vadvise(const char *advice, va_list params,
+		    int display_instructions, char *key)
 {
 	struct strbuf buf = STRBUF_INIT;
 	const char *cp, *np;
 
 	strbuf_vaddf(&buf, advice, params);
 
+	if(display_instructions)
+		strbuf_addf(&buf, turn_off_instructions, key);
+
 	for (cp = buf.buf; *cp; cp = np) {
 		np = strchrnul(cp, '\n');
 		fprintf(stderr,	_("%shint: %.*s%s\n"),
@@ -119,8 +161,42 @@ void advise(const char *advice, ...)
 {
 	va_list params;
 	va_start(params, advice);
-	vadvise(advice, params);
+	vadvise(advice, params, 0, "");
+	va_end(params);
+}
+
+static int get_config_value(enum advice_type type)
+{
+	int value = 1;
+	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
+	git_config_get_bool(key, &value);
+	free(key);
+	return value;
+}
+
+int advice_enabled(enum advice_type type)
+{
+	switch(type) {
+	case PUSH_UPDATE_REJECTED:
+		return get_config_value(PUSH_UPDATE_REJECTED) &&
+		       get_config_value(PUSH_UPDATE_REJECTED_ALIAS);
+	default:
+		return get_config_value(type);
+	}
+}
+
+void advise_if_enabled(enum advice_type type, const char *advice, ...)
+{
+	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
+	va_list params;
+
+	if(!advice_enabled(type))
+		return;
+
+	va_start(params, advice);
+	vadvise(advice, params, 1, key);
 	va_end(params);
+	free(key);
 }
 
 int git_default_advice_config(const char *var, const char *value)
@@ -159,8 +235,8 @@ void list_config_advices(struct string_list *list, const char *prefix)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(advice_config); i++)
-		list_config_item(list, prefix, advice_config[i].name);
+	for (i = 0; i < ARRAY_SIZE(advice_config_keys); i++)
+		list_config_item(list, prefix, advice_config_keys[i]);
 }
 
 int error_resolve_conflict(const char *me)
diff --git a/advice.h b/advice.h
index b706780614d..61a7ee82827 100644
--- a/advice.h
+++ b/advice.h
@@ -32,9 +32,61 @@ extern int advice_checkout_ambiguous_remote_branch_name;
 extern int advice_nested_tag;
 extern int advice_submodule_alternate_error_strategy_die;
 
+/**
+ To add a new advice, you need to:
+ - Define an advice_type.
+ - Add a new entry to advice_config_keys list.
+ - Add the new config variable to Documentation/config/advice.txt.
+ - Call advise_if_enabled to print your advice.
+ */
+enum advice_type {
+	FETCH_SHOW_FORCED_UPDATES = 0,
+	PUSH_UPDATE_REJECTED = 1,
+	PUSH_UPDATE_REJECTED_ALIAS = 2,
+	PUSH_NON_FF_CURRENT = 3,
+	PUSH_NON_FF_MATCHING = 4,
+	PUSH_ALREADY_EXISTS = 5,
+	PUSH_FETCH_FIRST = 6,
+	PUSH_NEEDS_FORCE = 7,
+	PUSH_UNQUALIFIED_REF_NAME = 8,
+	STATUS_HINTS = 9,
+	STATUS_U_OPTION = 10,
+	STATUS_AHEAD_BEHIND_WARNING = 11,
+	COMMIT_BEFORE_MERGE = 12,
+	RESET_QUIET_WARNING = 13,
+	RESOLVE_CONFLICT = 14,
+	SEQUENCER_IN_USE = 15,
+	IMPLICIT_IDENTITY = 16,
+	DETACHED_HEAD = 17,
+	SET_UPSTREAM_FAILURE = 18,
+	OBJECT_NAME_WARNING = 19,
+	AMWORKDIR = 20,
+	RM_HINTS = 21,
+	ADD_EMBEDDED_REPO = 22,
+	IGNORED_HOOK = 23,
+	WAITING_FOR_EDITOR = 24,
+	GRAFT_FILE_DEPRECATED = 25,
+	CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME = 26,
+	NESTED_TAG = 27,
+	SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE = 28,
+};
+
+
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
 void advise(const char *advice, ...);
+
+/**
+ Checks if advice type is enabled (can be printed to the user).
+ Should be called before advise().
+ */
+int advice_enabled(enum advice_type type);
+
+/**
+ Checks the visibility of the advice before printing.
+ */
+void advise_if_enabled(enum advice_type type, const char *advice, ...);
+
 int error_resolve_conflict(const char *me);
 void NORETURN die_resolve_conflict(const char *me);
 void NORETURN die_conclude_merge(void);
diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
new file mode 100644
index 00000000000..279cad6460e
--- /dev/null
+++ b/t/helper/test-advise.c
@@ -0,0 +1,19 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "advice.h"
+
+int cmd__advise_if_enabled(int argc, const char **argv)
+{
+	if (!argv[1])
+	die("usage: %s <advice>", argv[0]);
+
+	setup_git_directory();
+
+	/*
+	  Any advice type can be used for testing, but NESTED_TAG was selected
+	  here and in t0018 where this command is being executed.
+	 */
+	advise_if_enabled(NESTED_TAG, argv[1]);
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
index 00000000000..f4cdb649d51
--- /dev/null
+++ b/t/t0018-advice.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description='Test advise_if_enabled functionality'
+
+. ./test-lib.sh
+
+cat > expected <<EOF
+hint: This is a piece of advice
+hint: Disable this message with "git config advice.nestedTag false"
+EOF
+test_expect_success 'advise should be printed when config variable is unset' '
+	test-tool advise "This is a piece of advice" 2>actual &&
+	test_i18ncmp expected actual
+'
+
+test_expect_success 'advise should be printed when config variable is set to true' '
+	test_config advice.nestedTag true &&
+	test-tool advise "This is a piece of advice" 2>actual &&
+	test_i18ncmp expected actual
+'
+
+test_expect_success 'advise should not be printed when config variable is set to false' '
+	test_config advice.nestedTag false &&
+	test-tool advise "This is a piece of advice" 2>actual &&
+	test_must_be_empty actual
+'
+
+test_done
-- 
gitgitgadget

