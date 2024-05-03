Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC20146A77
	for <git@vger.kernel.org>; Fri,  3 May 2024 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720650; cv=none; b=KtHlAuGEs9ftkKVRTWUpsm8UuQq9dPtHvLPdGZsiy3A/4gmgoijNKfJ8/Cfd2Hyafn6Rn/4Z6+bUL/1zk7v8LxLK6ZA4neS6jZ2pnhHH74PVReY6YKDUoWu1zUDqN+drV6uNaz1h1cG0p5hH49URnRA1TGP0z2wyVQ2UooO8YZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720650; c=relaxed/simple;
	bh=TH0yiIgX2hbPFEGwJUVBkXTBUqoU94ZCTXUDc0S4PJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLDSCiKkMj22i16iUE+vtRueJMGHP2D8/vKmJx3TIFsnxlpEPECSVmOtc/PQIV9ok1TxjPtP4BpPk6ErpGjAr90Jp+loftPX9Zj9P72WeJODPZKx6W23WI1zHuM+4O+t0uqBnlWSNMtY5CHNZuruq9XN+X/yiK+xIUL+URPyBLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=aiFUk96B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iOstiBap; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="aiFUk96B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iOstiBap"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id C59D61C00144;
	Fri,  3 May 2024 03:17:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 03 May 2024 03:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714720647; x=
	1714807047; bh=Mfr/qf/tHPPGBXgn+q0tywRHIYWQSzIiYseU9fvXhZc=; b=a
	iFUk96ByPwiiVlh5sN6nGAvq+yNTvw1r1hQWmw49hDvMEKDDmApnlTe5xSExrPyB
	Ffd0zLF5c5giyzMw204WtVjrisyNb07F+ESCQebS656l4igIGqTgGx7sbjaHCl2J
	8tNlTvzSz/9YtBijakDJz1QOJ9XB4iJjZe1RbhEa/Nqo0vZvhsiyv2kxC/Oicw28
	EcHfHi12YWkSupth5RYNsL/aR8C2xFjEYIxSPwLILhmK24cm8cYyrWV4gG5QtvbF
	Rthj3ybXJFg22IhKJtRJar38Ws6MynyVpB1RhOmJ3NFc9UBmkI2/iBlc3lmdYx1S
	MNDMxOlXhX8ZCN13EmW2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714720647; x=
	1714807047; bh=Mfr/qf/tHPPGBXgn+q0tywRHIYWQSzIiYseU9fvXhZc=; b=i
	OstiBapB9iMlqckIZNN+O3kG7ZJpI5AhgwuEdATtIh5r/2jriGhj3yQ7CyP/6GmR
	Vdn2DpWGpsPHwhzwnhXJBLi2tWzZV6l+LE1v+iOkhBmTfVkPqif8Gen++Tpn8yXo
	fKOk6UD+s+drS+IxoXSwttuuq7FVXkRRgB7s3SdBYXfEodxRH6ZwMBHEiOrvYoFV
	h3Jc3EOOST1mu2zt6lI3NTvKEJueW0cCYJutsLXW6KjtmTY60SUvyvauY4J6S26z
	CidUQ2p+okPMHbKZG1290KxF9u3myt96gNkRNioeMEJrTQq/n6My+L0jplNu5Swk
	glvuPumwhpVhQ98niM1dQ==
X-ME-Sender: <xms:h480ZtX8nva1F6i-N9BkN5OAKpTpaoPW6jU16TII-bLpaJa--XqQjw>
    <xme:h480ZtkgK-uvoaR7noYp3rA0zISdRZ6hO4EFiULTuHMe2haBmCdKMZBehHgLFicbw
    -lAOnNNg8OA58j3hA>
X-ME-Received: <xmr:h480ZpZKTE5SCcDYzO36snrHoBacWAdGsZZjvNj7t0q9pYhPxuiayNDnaOFHJOv9rl2IY-nMNsOKF2CdifpF_xelml_9OUXHyocci6bMsb_DQwqAf-GU-YCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomheplfgrmhgvshcunfhiuhcuoehjrghmvghssehjrghmvghs
    lhhiuhdrihhoqeenucggtffrrghtthgvrhhnpeeljedtuedugfetgeefieduheelueetvd
    fhueeuueehveeljeekleetteefvefhjeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:h480ZgXyqfxFW10r5oc6OzO_RrqFVBFQ4JRHDxmgWLUtvg0Qd-NgjA>
    <xmx:h480ZnlOrPKbx_Rhv58tB9ZPJ0ob_peNrJXaFFNvsIyj-Xs8yxznXg>
    <xmx:h480Zte7UOirORVH53Tujxe6eGKZKydzyylbhFG2Jmf8rzMgkAhi4Q>
    <xmx:h480ZhG29IGBAu4AmDm-GJXapEcDDsKpLNAc9TmcX0LqsxJASF_zoQ>
    <xmx:h480ZsxRO4iF1Q1sZvEGFDNPDbULWEtPjlMO85h-fyvo08MkCQKotSoi>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 03:17:25 -0400 (EDT)
From: James Liu <james@jamesliu.io>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>
Subject: [PATCH v4 3/3] advice: add --no-advice global option
Date: Fri,  3 May 2024 17:17:06 +1000
Message-ID: <20240503071706.78109-4-james@jamesliu.io>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503071706.78109-1-james@jamesliu.io>
References: <20240430014724.83813-1-james@jamesliu.io>
 <20240503071706.78109-1-james@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advice hints must be disabled individually by setting the relevant
advice.* variables to false in the Git configuration. For server-side
and scripted usages of Git where hints can be a hindrance, it can be
cumbersome to maintain configuration to ensure all advice hints are
disabled in perpetuity. This is a particular concern in tests, where
new or changed hints can result in failed assertions.

Add a --no-advice global option to disable all advice hints from being
displayed. This is independent of the toggles for individual advice
hints. Use an internal environment variable (GIT_ADVICE) to ensure this
configuration is propagated to the usage site, even if it executes in a
subprocess.

Signed-off-by: James Liu <james@jamesliu.io>
---
 Documentation/git.txt |  8 +++--
 advice.c              |  7 +++++
 environment.h         |  7 +++++
 git.c                 |  9 ++++--
 t/t0018-advice.sh     | 68 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+), 4 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index d11d3d0c86..a0c07f1db8 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -12,8 +12,9 @@ SYNOPSIS
 'git' [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]
     [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
     [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--no-lazy-fetch]
-    [--no-optional-locks] [--bare] [--git-dir=<path>] [--work-tree=<path>]
-    [--namespace=<name>] [--config-env=<name>=<envvar>] <command> [<args>]
+    [--no-optional-locks] [--no-advice] [--bare] [--git-dir=<path>]
+    [--work-tree=<path>] [--namespace=<name>] [--config-env=<name>=<envvar>]
+    <command> [<args>]
 
 DESCRIPTION
 -----------
@@ -190,6 +191,9 @@ If you just want to run git as if it was started in `<path>` then use
 	Do not perform optional operations that require locks. This is
 	equivalent to setting the `GIT_OPTIONAL_LOCKS` to `0`.
 
+--no-advice::
+	Disable all advice hints from being printed.
+
 --literal-pathspecs::
 	Treat pathspecs literally (i.e. no globbing, no pathspec magic).
 	This is equivalent to setting the `GIT_LITERAL_PATHSPECS` environment
diff --git a/advice.c b/advice.c
index 75111191ad..0a122c2020 100644
--- a/advice.c
+++ b/advice.c
@@ -2,6 +2,7 @@
 #include "advice.h"
 #include "config.h"
 #include "color.h"
+#include "environment.h"
 #include "gettext.h"
 #include "help.h"
 #include "string-list.h"
@@ -127,6 +128,12 @@ void advise(const char *advice, ...)
 int advice_enabled(enum advice_type type)
 {
 	int enabled = advice_setting[type].level != ADVICE_LEVEL_DISABLED;
+	static int globally_enabled = -1;
+
+	if (globally_enabled < 0)
+		globally_enabled = git_env_bool(GIT_ADVICE_ENVIRONMENT, 1);
+	if (!globally_enabled)
+		return 0;
 
 	if (type == ADVICE_PUSH_UPDATE_REJECTED)
 		return enabled &&
diff --git a/environment.h b/environment.h
index 05fd94d7be..0b2d457f07 100644
--- a/environment.h
+++ b/environment.h
@@ -57,6 +57,13 @@ const char *getenv_safe(struct strvec *argv, const char *name);
 #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
 #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
 
+/*
+ * Environment variable used to propagate the --no-advice global option to the
+ * advice_enabled() helper, even when run in a subprocess.
+ * This is an internal variable that should not be set by the user.
+ */
+#define GIT_ADVICE_ENVIRONMENT "GIT_ADVICE"
+
 /*
  * Environment variable used in handshaking the wire protocol.
  * Contains a colon ':' separated list of keys with optional values
diff --git a/git.c b/git.c
index 7654571b75..637c61ca9c 100644
--- a/git.c
+++ b/git.c
@@ -37,8 +37,9 @@ const char git_usage_string[] =
 	N_("git [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]\n"
 	   "           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
 	   "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--no-lazy-fetch]\n"
-	   "           [--no-optional-locks] [--bare] [--git-dir=<path>] [--work-tree=<path>]\n"
-	   "           [--namespace=<name>] [--config-env=<name>=<envvar>] <command> [<args>]");
+	   "           [--no-optional-locks] [--no-advice] [--bare] [--git-dir=<path>]\n"
+	   "           [--work-tree=<path>] [--namespace=<name>] [--config-env=<name>=<envvar>]\n"
+	   "           <command> [<args>]");
 
 const char git_more_info_string[] =
 	N_("'git help -a' and 'git help -g' list available subcommands and some\n"
@@ -337,6 +338,10 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			setenv(GIT_ATTR_SOURCE_ENVIRONMENT, cmd, 1);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "--no-advice")) {
+			setenv(GIT_ADVICE_ENVIRONMENT, "0", 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
 			usage(git_usage_string);
diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
index 0dcfb760a2..b02448ea16 100755
--- a/t/t0018-advice.sh
+++ b/t/t0018-advice.sh
@@ -29,4 +29,72 @@ test_expect_success 'advice should not be printed when config variable is set to
 	test_must_be_empty actual
 '
 
+test_expect_success 'advice should not be printed when --no-advice is used' '
+	q_to_tab >expect <<-\EOF &&
+On branch master
+
+No commits yet
+
+Untracked files:
+QREADME
+
+nothing added to commit but untracked files present
+EOF
+
+	test_when_finished "rm -fr advice-test" &&
+	git init advice-test &&
+	(
+		cd advice-test &&
+		>README &&
+		git --no-advice status
+	) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'advice should not be printed when GIT_ADVICE is set to false' '
+	q_to_tab >expect <<-\EOF &&
+On branch master
+
+No commits yet
+
+Untracked files:
+QREADME
+
+nothing added to commit but untracked files present
+EOF
+
+	test_when_finished "rm -fr advice-test" &&
+	git init advice-test &&
+	(
+		cd advice-test &&
+		>README &&
+		GIT_ADVICE=false git status
+	) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'advice should be printed when GIT_ADVICE is set to true' '
+	q_to_tab >expect <<-\EOF &&
+On branch master
+
+No commits yet
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+QREADME
+
+nothing added to commit but untracked files present (use "git add" to track)
+EOF
+
+	test_when_finished "rm -fr advice-test" &&
+	git init advice-test &&
+	(
+		cd advice-test &&
+		>README &&
+		GIT_ADVICE=true git status
+	) >actual &&
+	cat actual > /tmp/actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.44.0

