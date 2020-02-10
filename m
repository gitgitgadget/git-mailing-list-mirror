Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2B8C35254
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 05:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FB722464
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 05:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt7hO8Dq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgBJFEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 00:04:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38990 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgBJFEN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 00:04:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so8945984wme.4
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 21:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=sHUtkb9IxKs3JR5JXCyi2/+h3bf/n/DmUaHMUJD9/RY=;
        b=Pt7hO8DqkMiEVCRn1xT+2kytxLJxRAMK4n5ozTa3WyK4XwiIFrzOWCIkT4ZHRln6Zz
         5qDqUwEeEaOM9aoY8/YV0Rj9oCboLD5Yw7KP0nWaIYq6meaIytYfYBsOXXHNmThHZN8p
         vjU4lXGkB59v5AP1IB6TwXL1PRBbGPoCwjZDWAXS9WdpnaA40DYYni4O3Eu3SMKz3eSh
         NinmYsoXSe5W9fpvsqHZNWJliTfSEvRLzU+aMjy5uJ52I6wpPi/OxftlXzDFg5aYw6Ub
         WtILbLuWhK0xK3igiTKLzEvVAgzylEU22KytnryG+12RIItm4f4u/DuV42pcLJbCQL5L
         vo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sHUtkb9IxKs3JR5JXCyi2/+h3bf/n/DmUaHMUJD9/RY=;
        b=Ws0FSIqVJhS5w/BOhqZl1f/yQ3LNrxojQPR1CZY+mA0TFI85EOyL0nETysXh+yMARQ
         4NkFQ6tvIoTPl33sagKggQhucgIgmQKSYJwPUpImvPQcoOsOMjOa9KDgYrAnVN8imo4Z
         +kEyjd1p91XiEJvc1gPYTlLYjT7KLJGrjC8/p6+B3x3SgZnddsmUc3W0GDUWdSGVoqgS
         rJ0Al2qCNZLENmlFJAaPaWWh0nH75+xlosrxIBsQZ3ngj1ZOndHjMUl1UIBAl1gq3105
         EubMU6OTYzCD8CxCdalCVluYhLE8AQZ1MZAln8+94b3GzzE8/0psVi0jmyVnZzem7Xcj
         ZHow==
X-Gm-Message-State: APjAAAVJ91DbDz2C1fluf6xZhrU16hgceTC7++H7s3IKxqCVzPRqpQGf
        d0ZtbCRgG8UY0QPH15z6U6y4s3hg
X-Google-Smtp-Source: APXvYqx6/mF/DXXZ4t2DurTN+cGbyQ9jdPAySspunz053wnsnInuxd+3sUkrfM60M6cDUVRQzImF1A==
X-Received: by 2002:a1c:e28a:: with SMTP id z132mr12683955wmg.157.1581311050614;
        Sun, 09 Feb 2020 21:04:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm13760920wmh.26.2020.02.09.21.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 21:04:10 -0800 (PST)
Message-Id: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 05:04:09 +0000
Subject: [PATCH] advice: refactor advise API
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

Add a new advise_ng function that can check the visibility of advice
messages before printing.

Currently it's very easy for the callers to miss checking the
visibility step. Also, it makes more sense for this step to be handled
by the advice library.

Also change the advise call in tag library from advise() to advise_ng()
to construct an example of the usage of the new API.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
    [RFC][Outreachy] advice: refactor advise API
    
    The advice API is currently a little bit confusing to call. quoting from
    [1]:
    
    When introducing a new advice message, you would
    
     * come up with advice.frotz configuration variable
    
     * define and declare advice_frotz global variable that defaults to
       true
    
     * sprinkle calls like this:
    
      if (advice_frotz)
        advise(_("helpful message about frotz"));
    
    A new approach was suggested in [1] which this patch is based upon.
    
    A new advise_ng() is introduced to gradually replace advise()
    
    pros of the new advise():
    
     * The caller doesn't need to define a new global variable when
       introducing a new message.
     * The caller doesn't need to check the visibility of the message before
       calling advise_ng().
     * The caller still needs to come up with advice.frotz config variable
       and will call advice_ng as follows: advice_ng("advice.frotz",
       _("helpful message about frotz"));
    
    After this patch the plan is to migrate the rest of the advise calls to
    advise_ng and then finally remove advise() and rename advise_ng() to
    advise()
    
    [1] 
    https://public-inbox.org/git/xmqqzhf5cw69.fsf@gitster-ct.c.googlers.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-548%2FHebaWaly%2Fadvice_refactoring-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-548/HebaWaly/advice_refactoring-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/548

 Makefile               |  1 +
 advice.c               | 37 +++++++++++++++++++++++++++++++++++--
 advice.h               |  6 +++++-
 builtin/tag.c          |  4 ++--
 t/helper/test-advise.c | 15 +++++++++++++++
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  1 +
 t/t0018-advice.sh      | 29 +++++++++++++++++++++++++++++
 t/t7004-tag.sh         |  2 ++
 9 files changed, 91 insertions(+), 5 deletions(-)
 create mode 100644 t/helper/test-advise.c
 create mode 100755 t/t0018-advice.sh

diff --git a/Makefile b/Makefile
index 09f98b777c..ed923a3e81 100644
--- a/Makefile
+++ b/Makefile
@@ -695,6 +695,7 @@ X =
 
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
+TEST_BUILTINS_OBJS += test-advise.o
 TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-ctype.o
diff --git a/advice.c b/advice.c
index 249c60dcf3..4793e59223 100644
--- a/advice.c
+++ b/advice.c
@@ -29,7 +29,6 @@ int advice_ignored_hook = 1;
 int advice_waiting_for_editor = 1;
 int advice_graft_file_deprecated = 1;
 int advice_checkout_ambiguous_remote_branch_name = 1;
-int advice_nested_tag = 1;
 int advice_submodule_alternate_error_strategy_die = 1;
 
 static int advice_use_color = -1;
@@ -89,7 +88,6 @@ static struct {
 	{ "waitingForEditor", &advice_waiting_for_editor },
 	{ "graftFileDeprecated", &advice_graft_file_deprecated },
 	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
-	{ "nestedTag", &advice_nested_tag },
 	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
 
 	/* make this an alias for backward compatibility */
@@ -118,6 +116,41 @@ void advise(const char *advice, ...)
 	strbuf_release(&buf);
 }
 
+static const char turn_off_instructions[] =
+N_("\n"
+"Turn this message off by running\n"
+"\"git config %s false\"");
+
+void advise_ng(const char *key, const char *advice, ...)
+{
+	int value = 1;
+	struct strbuf buf = STRBUF_INIT;
+	va_list params;
+	const char *cp, *np;
+	
+	git_config_get_bool(key, &value);
+	
+	if(value)
+	{
+		va_start(params, advice);
+		strbuf_vaddf(&buf, advice, params);
+		va_end(params);
+
+		strbuf_addf(&buf, turn_off_instructions, key);
+		
+		for (cp = buf.buf; *cp; cp = np) {
+			np = strchrnul(cp, '\n');
+			fprintf(stderr,	_("%shint: %.*s%s\n"),
+				advise_get_color(ADVICE_COLOR_HINT),
+				(int)(np - cp), cp,
+				advise_get_color(ADVICE_COLOR_RESET));
+			if (*np)
+				np++;
+		}
+		strbuf_release(&buf);
+	}
+}
+
 int git_default_advice_config(const char *var, const char *value)
 {
 	const char *k, *slot_name;
diff --git a/advice.h b/advice.h
index b706780614..ad4da2d65d 100644
--- a/advice.h
+++ b/advice.h
@@ -29,12 +29,16 @@ extern int advice_ignored_hook;
 extern int advice_waiting_for_editor;
 extern int advice_graft_file_deprecated;
 extern int advice_checkout_ambiguous_remote_branch_name;
-extern int advice_nested_tag;
 extern int advice_submodule_alternate_error_strategy_die;
 
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
 void advise(const char *advice, ...);
+
+/**
+ Checks the visibility of the advice before priniting.
+ */
+void advise_ng(const char *key, const char *advice, ...);
 int error_resolve_conflict(const char *me);
 void NORETURN die_resolve_conflict(const char *me);
 void NORETURN die_conclude_merge(void);
diff --git a/builtin/tag.c b/builtin/tag.c
index e0a4c25382..7fe1ff3ed0 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -231,8 +231,8 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 	if (type <= OBJ_NONE)
 		die(_("bad object type."));
 
-	if (type == OBJ_TAG && advice_nested_tag)
-		advise(_(message_advice_nested_tag), tag, object_ref);
+	if (type == OBJ_TAG)
+		advise_ng("advice.nestedTag", _(message_advice_nested_tag), tag, object_ref);
 
 	strbuf_addf(&header,
 		    "object %s\n"
diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
new file mode 100644
index 0000000000..b6ec90fd18
--- /dev/null
+++ b/t/helper/test-advise.c
@@ -0,0 +1,15 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "advice.h"
+
+int cmd__advise_ng(int argc, const char **argv)
+{
+	if (!argv[1] || !argv[2])
+	die("usage: %s <key> <advice>", argv[0]);
+
+	setup_git_directory();
+
+	advise_ng(argv[1], argv[2]);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index f20989d449..f903f32bb6 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -14,6 +14,7 @@ struct test_cmd {
 };
 
 static struct test_cmd cmds[] = {
+	{ "advise", cmd__advise_ng },
 	{ "chmtime", cmd__chmtime },
 	{ "config", cmd__config },
 	{ "ctype", cmd__ctype },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 8ed2af71d1..e5e955beb9 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -4,6 +4,7 @@
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "git-compat-util.h"
 
+int cmd__advise_ng(int argc, const char **argv);
 int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
 int cmd__ctype(int argc, const char **argv);
diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
new file mode 100755
index 0000000000..d012db515d
--- /dev/null
+++ b/t/t0018-advice.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description='Test advise_ng functionality'
+
+. ./test-lib.sh
+
+cat > expected <<EOF
+hint: This is a piece of advice
+hint: Turn this message off by running
+hint: "git config advice.configVariable false"
+EOF
+test_expect_success 'advise should be printed when config variable is unset' '
+	test-tool advise "advice.configVariable" "This is a piece of advice" 2>actual &&
+	test_i18ncmp expected actual
+'
+
+test_expect_success 'advise should be printed when config variable is set to true' '
+	test_config advice.configVariable true &&
+	test-tool advise "advice.configVariable" "This is a piece of advice" 2>actual &&
+	test_i18ncmp expected actual
+'
+
+test_expect_success 'advise should not be printed when config variable is set to false' '
+	test_config advice.configVariable false &&
+	test-tool advise "advice.configVariable" "This is a piece of advice" 2>actual &&
+	test_must_be_empty actual
+'
+
+test_done
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 6db92bd3ba..b7c8d41899 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1726,6 +1726,8 @@ test_expect_success 'recursive tagging should give advice' '
 	hint: already a tag. If you meant to tag the object that it points to, use:
 	hint: |
 	hint: 	git tag -f nested annotated-v4.0^{}
+	hint: Turn this message off by running
+	hint: "git config advice.nestedTag false"
 	EOF
 	git tag -m nested nested annotated-v4.0 2>actual &&
 	test_i18ncmp expect actual

base-commit: c7a62075917b3340f908093f63f1161c44ed1475
-- 
gitgitgadget
