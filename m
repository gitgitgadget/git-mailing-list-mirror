Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AE92107
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 01:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441656; cv=none; b=aHUJu4Y0iyqQ+HC9MmyqHdAyRrA9stZHtFQfxtta0LK1Tv5bwK61xYETy0TkrTMW3+qGTXJrWW41CHbsZuYxNMSHyUZRhxMUPC2yhJr1Cl/0tDg0AzD35Vsm3UxKTD4juZLRZPppqPJUYziiVxqh+dnH6IeCHO3lI/HJ2BLwmJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441656; c=relaxed/simple;
	bh=saFBvYW3Nj86+28E7ANKEMdi33yaa3AnKSr8xphHjyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LG9EwS6JQbYq+RVEPvGlWOE/2iCyi20UwWH5Ym0B3xKkqliPPlissfv9RJZJbJn43oWHCDzojl6WKg7Baj0hPgz+ugcon9EG5FmYhGJ9ktROuWi+7OEySagR7LLE02PpZiu2is3HARJVZjCp4TTLddE9oWxvtYpBqDaJV4dSjJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=lQa5krjM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Deve7bXH; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="lQa5krjM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Deve7bXH"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 96F72114018D;
	Mon, 29 Apr 2024 21:47:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 Apr 2024 21:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714441653; x=
	1714528053; bh=EcTZzeI51Ul9iVOdpEd4KXDYzeZf9j/dul0sHsGJu1Y=; b=l
	Qa5krjMoyEUepXR5+FIl6GcGUyScmAoQRV5JTUfDGlNyJL9RcJPWcspX2K6AMQXd
	g/Cyk27qBc9UL9GrDKPHpP3HxPEyqP3unBbz8hQaTVmI5gRmihMtfGjjbWOlvilN
	V0vX4Qg7N/AI0vM1F6u51rTNbtP5AHsZnXP10o0JtDlinaXr9CyQrZ+fGYzAN9pO
	MwqdcLrfl45H1fiFe83Dz4EnmbyLSkYLxakLO05R9ExV09N7e2FbHWlZdMV5ogi4
	fHMtaI/Ke74yWl1bBn8Mzqh8WfsHph6w3XIdJ/SQeebIerfCwnUHcNLmPyb5y//z
	0FRgjsIghyUhlLvdyYXpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714441653; x=
	1714528053; bh=EcTZzeI51Ul9iVOdpEd4KXDYzeZf9j/dul0sHsGJu1Y=; b=D
	eve7bXHBFmGC3UdRlDGGXb/p8aPckCOXduZOwxb24LMWoH/pajypHwTrv6yQf4KQ
	CM/gZmK+zj6Sx5Xhvj9McjQkhXX4itO7SgWAsbLAoi5VvUtAB17g7ib6H2lRZTYe
	qRaSxD7fJSIx9YBbtYwa9BB3bscN2hs+LoZRMzfBHcYndjxgT9A4jUTaX4p9d44M
	YdJw0ZOBoVkjR9/kw3nrzo2XpzKrFvySEx/ubHRyo3d81JtuQfQLSnzw3a8qmbQr
	CMHOWj5RGfSBEKvA9qoUyNYbfT8w8VtUj4BBjOSPzkeWKh03qtrOURcyz6trF2B1
	TWTvoSHgZ3SKZtpp4YcqQ==
X-ME-Sender: <xms:tU0wZmh2kNqXgKhSzpOkakCIHSAztkmVJmosgGMyP8IwrT4FFRLarw>
    <xme:tU0wZnD2uXnZmjWIxTy2RugMpzBulx7rxM1LjEXktii-4_remdqmX58ZiNA72p3IY
    dp4loV4-U6sq25BQw>
X-ME-Received: <xmr:tU0wZuHlNi6Yvp9HjHSPB9Z7bcEKy9dfGY6sSYzD3VI3-kXWMlOpPjort5cr1W75-ZHK066tuQ6QBSd5I3jBmWxQiTs0uLwm2_hDnBwcu5FOt7I7YWry1j3I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflrghmvghsucfnihhuuceojhgrmhgvshesjhgrmhgvshhl
    ihhurdhioheqnecuggftrfgrthhtvghrnhepleejtdeuudfgteegfeeiudehleeutedvhf
    euueeuheevleejkeelteetfeevhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:tU0wZvRyN07bhpqA9BvYR0HA5RGF2_eJAbum3Tv2JZlgqoNCkB742w>
    <xmx:tU0wZjzuFuw_KBCt6G86PA4GJ92L6hi8uJh_vCOUg2wAGCia2CrB_g>
    <xmx:tU0wZt7zA0gjlF3YyYsHc9DuVHcwuijtGOC9KK0kbQ-IxkOh5mDHaA>
    <xmx:tU0wZgzbDf6wIO-qGBl2Qw5YiUSBrPlfYmvsqjz7J64z_3WmSsfNtQ>
    <xmx:tU0wZu8GYxyzhfTduP9BZYH0xurIxgpbgGPBxdKAX09UUqMSQZXbyz6q>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 21:47:31 -0400 (EDT)
From: James Liu <james@jamesliu.io>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>
Subject: [PATCH v3 1/1] advice: add --no-advice global option
Date: Tue, 30 Apr 2024 11:47:24 +1000
Message-ID: <20240430014724.83813-2-james@jamesliu.io>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430014724.83813-1-james@jamesliu.io>
References: <20240429010925.93205-1-james@jamesliu.io>
 <20240430014724.83813-1-james@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advice hints must be disabled individually by setting the relevant
advice.* variables to false in the Git configuration. For server-side
and scripted usages of Git where hints aren't necessary, it can be
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
 Documentation/git.txt |  5 ++++-
 advice.c              |  8 +++++++-
 environment.h         |  7 +++++++
 git.c                 |  6 +++++-
 t/t0018-advice.sh     | 20 ++++++++++++++++++++
 5 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7a1b112a3e..ef1d9dce5d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -13,7 +13,7 @@ SYNOPSIS
     [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
-    [--config-env=<name>=<envvar>] <command> [<args>]
+    [--config-env=<name>=<envvar>] [--no-advice] <command> [<args>]
 
 DESCRIPTION
 -----------
@@ -226,6 +226,9 @@ If you just want to run git as if it was started in `<path>` then use
 	linkgit:gitattributes[5]. This is equivalent to setting the
 	`GIT_ATTR_SOURCE` environment variable.
 
+--no-advice::
+	Disable all advice hints from being printed.
+
 GIT COMMANDS
 ------------
 
diff --git a/advice.c b/advice.c
index 75111191ad..abad9ccaa2 100644
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
@@ -126,7 +127,12 @@ void advise(const char *advice, ...)
 
 int advice_enabled(enum advice_type type)
 {
-	int enabled = advice_setting[type].level != ADVICE_LEVEL_DISABLED;
+	int enabled;
+
+	if (!git_env_bool(GIT_ADVICE, 1))
+		return 0;
+
+	enabled = advice_setting[type].level != ADVICE_LEVEL_DISABLED;
 
 	if (type == ADVICE_PUSH_UPDATE_REJECTED)
 		return enabled &&
diff --git a/environment.h b/environment.h
index 05fd94d7be..26e87843e1 100644
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
+#define GIT_ADVICE "GIT_ADVICE"
+
 /*
  * Environment variable used in handshaking the wire protocol.
  * Contains a colon ':' separated list of keys with optional values
diff --git a/git.c b/git.c
index 654d615a18..6283d126e5 100644
--- a/git.c
+++ b/git.c
@@ -38,7 +38,7 @@ const char git_usage_string[] =
 	   "           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
 	   "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]\n"
 	   "           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
-	   "           [--config-env=<name>=<envvar>] <command> [<args>]");
+	   "           [--config-env=<name>=<envvar>] [--no-advice] <command> [<args>]");
 
 const char git_more_info_string[] =
 	N_("'git help -a' and 'git help -g' list available subcommands and some\n"
@@ -337,6 +337,10 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			setenv(GIT_ATTR_SOURCE_ENVIRONMENT, cmd, 1);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "--no-advice")) {
+			setenv(GIT_ADVICE, "0", 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
 			usage(git_usage_string);
diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
index 0dcfb760a2..2ce2d4668a 100755
--- a/t/t0018-advice.sh
+++ b/t/t0018-advice.sh
@@ -29,4 +29,24 @@ test_expect_success 'advice should not be printed when config variable is set to
 	test_must_be_empty actual
 '
 
+test_expect_success 'advice should not be printed when --no-advice is used' '
+	cat << EOF > expect &&
+On branch master
+
+No commits yet
+
+Untracked files:
+	README
+
+nothing added to commit but untracked files present
+EOF
+
+	git init advice-test &&
+  test_when_finished "rm -fr advice-test" &&
+  cd advice-test &&
+  touch README &&
+  git --no-advice status > ../actual &&
+  test_cmp ../expect ../actual
+'
+
 test_done
-- 
2.44.0

