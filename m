Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0BEA40
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714352981; cv=none; b=oOcywli7E9yv8s4Yc2nMBweQGZvdP+bhWSFFcRFJmva2KNKvzW3rOf1UfvYQc1veU+X/Sj+FgAJEvihwglqgspelMLqufC8o2JSm5umxjRV8gabq1UpeZMY1orQnDwhrzdGF5bgczW8qClZ09AJEKfkyrpKAr+ojMqvAEG9ZPHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714352981; c=relaxed/simple;
	bh=RHVDUmeVMXnpc6EFCwCNzKWT9UfhfR+JQyb5Cbtn3Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5a7iXKHn2dT/09aT6sxmsxglY5DKxTp/VUXkad+l6M4V/Xrx9UZbs7fip+dHdVLmpDKkrtVeYdPKwrgBmI2pndpjt3n0mAsuf+BhKtUCWNL6anaQbFvz7VV2pSyKPC6Lzill58W+0jhi5dc6JLnD6aMx6N05UvvHfB0oB70pYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=AqcD4cTB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E2tz9NCC; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="AqcD4cTB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E2tz9NCC"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AB301114010F;
	Sun, 28 Apr 2024 21:09:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 28 Apr 2024 21:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714352978; x=
	1714439378; bh=MP2nRGyMifc9eim7CiucX16/eCD2q8JGORH1A8PCF0w=; b=A
	qcD4cTBYR0SEqNt2zf4NOnSXX5v1YTcEGJcVI05bLH1H1Ar4XM+7aNX+CctmN1Qo
	NBgf0NGX945n4E5OqcKP6EOUIgIneJEqysZacqJwkIcsAvwdVVWQBSjB9VEkIPmS
	pmCOmOvwFv3i8Wdbxyc7wVyhIp6EIooVp7Akj6KHV6mcVqRpWSzUzQQp2k7FiVvs
	mqQzvE/wpq2qmyJ4udJa8XbLaQzrt60XXa1cCe1EXCGeL8kefRpY6LaV/74inQK5
	cwrOIKDieZb+l/+yci6s4TuC48zXs+qJTxwJx2cShgUnHIB/1WmNiasDLHB8Mafu
	1Cl3DmHme98ilJvGhyWfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714352978; x=
	1714439378; bh=MP2nRGyMifc9eim7CiucX16/eCD2q8JGORH1A8PCF0w=; b=E
	2tz9NCCi93S0T/3x5satcbCuAzaLbi2a6RAB0qdWc6NbAmm0hrRbx/O0+XO2gIDJ
	seK+jJwAhd2I95Y1ZI7KciuttXZmp9QtmPQTvln6O3EEY2rM2eNzmRyDBO8Gzn9r
	c12HggQDbfXY10IMjoYkM0ayn76572eJtO75d6oT8edOjPCkvqKYu1VyXsFHI7UI
	hGAREYbwN1avukHnLadLc3Xx1m89XZf6HatqDQVGaKsmfRiXVXf0QdSl4zIUY66V
	X3qfQqM3tiQxwdDZzRnuebfx3q1cO955V1U8sYeSzo+TYLGuvRCjexpMIHftaqVx
	X/GXK0jkIQUMiPaLM/+iQ==
X-ME-Sender: <xms:UvMuZo_UcyC3aMIBJK8wjMt6KsaDwKqhmSTPKR8hYNp1hQ383ZCeEg>
    <xme:UvMuZgsXFCA4gpf4F27E58GncYUoO4tXCIK_0MIcqJXjbSOVyS2KfncznZcLx8lay
    5DVw5LaqugydJbDxA>
X-ME-Received: <xmr:UvMuZuAJxnTMJv7O8B02qH5-fRhE8hPHey8fHcgmOQmjdhSAIPVVYSe86Znc6MA1fXqJCXooK9OsjwMmeXiLZUphJqGO5GAjP0LeA_7IVyUxJvlaojtzdbOK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtjedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflrghmvghsucfnihhuuceojhgrmhgvshesjhgrmhgvshhl
    ihhurdhioheqnecuggftrfgrthhtvghrnhepleejtdeuudfgteegfeeiudehleeutedvhf
    euueeuheevleejkeelteetfeevhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:UvMuZofglETpkOs2PAAWO6dzV7ugcys4KTB1HUMo4lm5dMx4zRUAgw>
    <xmx:UvMuZtOn1D-Bep59j6tpvu1w-eeCldo8stlFlPLbcjw1k0yodq-mmQ>
    <xmx:UvMuZimjvW2h7gOHh9WNzZMUHW-bkFRZEHAdg7rV4s8-kRBcJDv0eQ>
    <xmx:UvMuZvvfvoTVUimJo-hg-jnNQaBcpp6IatF7oULXECY06X1gVXndJQ>
    <xmx:UvMuZma871kBcngFGerJkL25Jpn9LswEFmR783-zaSUcCAptkAEhYLqg>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Apr 2024 21:09:37 -0400 (EDT)
From: James Liu <james@jamesliu.io>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>
Subject: [PATCH v2 1/1] advice: add --no-advice global option
Date: Mon, 29 Apr 2024 11:09:25 +1000
Message-ID: <20240429010925.93205-2-james@jamesliu.io>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429010925.93205-1-james@jamesliu.io>
References: <20240424035857.84583-1-james@jamesliu.io>
 <20240429010925.93205-1-james@jamesliu.io>
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
hints.

Signed-off-by: James Liu <james@jamesliu.io>
---
 Documentation/git.txt |  5 ++++-
 advice.c              |  8 +++++++-
 environment.h         |  1 +
 git.c                 |  6 +++++-
 t/t0018-advice.sh     | 20 ++++++++++++++++++++
 5 files changed, 37 insertions(+), 3 deletions(-)

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
index 75111191ad..f6282c3bde 100644
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
+	if (getenv(GIT_NO_ADVICE))
+		return 0;
+
+	enabled = advice_setting[type].level != ADVICE_LEVEL_DISABLED;
 
 	if (type == ADVICE_PUSH_UPDATE_REJECTED)
 		return enabled &&
diff --git a/environment.h b/environment.h
index 05fd94d7be..30c2684269 100644
--- a/environment.h
+++ b/environment.h
@@ -56,6 +56,7 @@ const char *getenv_safe(struct strvec *argv, const char *name);
 #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
 #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
 #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
+#define GIT_NO_ADVICE "GIT_NO_ADVICE"
 
 /*
  * Environment variable used in handshaking the wire protocol.
diff --git a/git.c b/git.c
index 654d615a18..ffeb832ca9 100644
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
+			setenv(GIT_NO_ADVICE, "1", 1);
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

