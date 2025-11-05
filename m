Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEF931BCA3
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370253; cv=none; b=A0HBkaPpMg9IR7hfGOnoPIg/UNJExm8oUUk4m6TZayNUc0Hk8pQ6wh3VJbEfBOL7BGFHaDk4l1uUgorqMfwNAp7f8XrlIzyaFJp/8NKiJ3crXJsvBv+BU2SZSXYOuO2oEbkmgN6K++4gqKEj85Gx8in2sBUlRW+JCSzYHfAn1Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370253; c=relaxed/simple;
	bh=xwvfj6I+5FstSDumDbzqtdmIwgF4fbkiNBrGBMAdjc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKljORGy8gkAIK8g4Po5fJMXAcU+kViWQZeJaMvPMsrZS/cOzo76AUp8e/PdDqrKEBhkjkJ4Fg9Z/E78tOJHXWMWVhP2NcK/U6Mo8fz2btqVhKI29VKlAd4NbTfVwkdsIifCUqvpOhHSKsl0FfVIoG4RO2D9MDJfLOUuk7J7OhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=me/evr6D; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="me/evr6D"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso206432a91.2
        for <git@vger.kernel.org>; Wed, 05 Nov 2025 11:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762370249; x=1762975049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufzwL2xo8Vq1P7ylWequETuDDjvIkNGNEjxlUtNDmhc=;
        b=me/evr6DRfkETghr4ttDLkk6A+H4wU3vmUD9BAlERr1SLnT1jUc4hASStihuEDUN6O
         IX6qXCF8KHCckCYzfjQS+1tL6ZyvdqdLahDt2LP4OxXQLA3xidVQzxfZb3DpUSj8Zt4t
         B3TGPJ4EmCh8qy1/D6h2fxjB7fMa5vh0/RqkQYDSzG+vhD5rNp+a1aXRr2JJjOlTsqMZ
         EJS7+x0ans6ufd682I9jMDRtjB9UmZDtkchamKJuQnc1TRuOrhabdrFZgigOB3JMIxrb
         seyDEwuQYZUy1htP/BJZPLqW7bPQ6LBRGnvzehUpNJwIa+LvtKjMHAZfqDCReUujC2fb
         S14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762370249; x=1762975049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufzwL2xo8Vq1P7ylWequETuDDjvIkNGNEjxlUtNDmhc=;
        b=iB9+b0z+i+zAV6JtbUDLW4wa8d5XgirhWAnn3nXjBP3BycrEXOB7TwdB9DWTqkfcQE
         MSuLRcv7vaouNSn6CymR7w4g2sOH3oI2lj6DDmKd5dwwB1PHapmDDbZELOL7SuX2QRSX
         hQK/Lj40QIdxhT9EspTEeYkaYy+JV+EPWhTFltyOthlHawnnnYZqqbVwMNq6sLkYBfn8
         wI81mgC4JS9C6aqJES+Ib7xgekcIzbwPidrxNeMZFqYWNB1YNi1HHB2DLlFJht0Xox6t
         bdwT2tRujAT2iWDTX4hOGbhEq1SFZD2V+1WcH9Sr0x9MLaB3D/PwUe69kRtBx2VqCV9q
         rltg==
X-Gm-Message-State: AOJu0YxhArcRvxRPbGxY0VEjqOXSyiwmMXxqR30L30BOsHM+J9hLwnKr
	/z73XvSVHr/qiOwvzkn0M/xn7RLFx8ofDo4iDerh4sWqsgbLa6gsj8agkyRfNWvy
X-Gm-Gg: ASbGnctPm1COq0acetZyxSdOLLuKAuUrjLiZy267TGZaE7Iizx2GB3Uug+BfczeKWxp
	jeIlWDWr5ZtB6gMAsqx5pjyS2bfY23d/DYkmL1kOiCmYzlL52xI2AMB0Wq/nuxfL8zohvnE9mkm
	sZAaVH4T/claYL3Yf2pCwUDzwIxHEWuolZz1Ib9x4Zv+kecCG4njsf6K9BsOJ5Q4eyXthl3Vphw
	0RSxQ0RbSx9S6oAYtCP9O69n4A/TKZjy4V5uiHbx1IBJllQWQlmQXmcAQPZe1OMqoGCAwRvBhoe
	mh77AMKSeLKbmzH/o63c25kZXlhvycbyk526elNrlI3VxzdeFlTeTSEdFknSX4gaUOIh+qDVAgz
	x3Df2yFctm9eqT0GjkE9dB18R71KVPfTBwd8sUeLS4qiS1sd1vEIaNgwpp67A0+82QXqMztGO9U
	Zljix/lh6I2UYpsnSBxV7hAjsmQppZmGXt5QDc/bTcVdPKvkKgUmo63zgxsKlUO5Isw7bmDQ8Sr
	Ug3wrs8WopD3WqEcN55nVeaO6H6VfWV/nfE7THD0n/O
X-Google-Smtp-Source: AGHT+IEPYoVmgHZsYhCn1gTtacLbjN+llveODDGVryFcpcuGbyIiHR8mjaCc6rt7EpUGmNJs+yOTtw==
X-Received: by 2002:a17:90b:48c2:b0:341:8ab9:6882 with SMTP id 98e67ed59e1d1-341a6ddeb10mr6346588a91.17.1762370249371;
        Wed, 05 Nov 2025 11:17:29 -0800 (PST)
Received: from localhost.localdomain ([2409:40e3:177:42ef:11ba:85fd:f5fe:a9a5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417bc8e9b7sm3056687a91.2.2025.11.05.11.17.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Nov 2025 11:17:28 -0800 (PST)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	newren@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	karthik.188@gmail.com,
	code@khaugsbakk.name,
	rybak.a.v@gmail.com,
	jltobler@gmail.com,
	toon@iotcl.com,
	johncai86@gmail.com,
	johannes.schindelin@gmx.de,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v7 3/3] replay: add replay.refAction config option
Date: Thu,  6 Nov 2025 00:46:01 +0530
Message-ID: <20251105191650.89975-4-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105191650.89975-1-siddharthasthana31@gmail.com>
References: <20251030191931.30837-1-siddharthasthana31@gmail.com>
 <20251105191650.89975-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a configuration variable to control the default behavior of git replay
for updating references. This allows users who prefer the traditional
pipeline output to set it once in their config instead of passing
--ref-action=print with every command.

The config variable uses string values that mirror the behavior modes:
  * replay.refAction = update (default): atomic ref updates
  * replay.refAction = print: output commands for pipeline

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Elijah Newren <newren@gmail.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/config/replay.adoc | 11 ++++++++
 Documentation/git-replay.adoc    |  2 ++
 builtin/replay.c                 | 24 ++++++++++++++---
 t/t3650-replay-basics.sh         | 46 ++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/config/replay.adoc

diff --git a/Documentation/config/replay.adoc b/Documentation/config/replay.adoc
new file mode 100644
index 0000000000..7d549d2f0e
--- /dev/null
+++ b/Documentation/config/replay.adoc
@@ -0,0 +1,11 @@
+replay.refAction::
+	Specifies the default mode for handling reference updates in
+	`git replay`. The value can be:
++
+--
+	* `update`: Update refs directly using an atomic transaction (default behavior).
+	* `print`: Output update-ref commands for pipeline use.
+--
++
+This setting can be overridden with the `--ref-action` command-line option.
+When not configured, `git replay` defaults to `update` mode.
diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 2ef74ddb12..dcb26e8a8e 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -51,6 +51,8 @@ which uses the target only as a starting point without updating it.
 	* `print`: Output update-ref commands for pipeline use. This is the
 	  traditional behavior where output can be piped to `git update-ref --stdin`.
 --
++
+The default mode can be configured via the `replay.refAction` configuration variable.
 
 <revision-range>::
 	Range of commits to replay. More than one <revision-range> can
diff --git a/builtin/replay.c b/builtin/replay.c
index 94e60b5b10..6606a2c94b 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -8,6 +8,7 @@
 #include "git-compat-util.h"
 
 #include "builtin.h"
+#include "config.h"
 #include "environment.h"
 #include "hex.h"
 #include "lockfile.h"
@@ -298,6 +299,22 @@ static enum ref_action_mode parse_ref_action_mode(const char *ref_action, const
 	die(_("invalid %s value: '%s'"), source, ref_action);
 }
 
+static enum ref_action_mode get_ref_action_mode(struct repository *repo, const char *ref_action)
+{
+	const char *config_value = NULL;
+
+	/* Command line option takes precedence */
+	if (ref_action)
+		return parse_ref_action_mode(ref_action, "--ref-action");
+
+	/* Check config value */
+	if (!repo_config_get_string_tmp(repo, "replay.refAction", &config_value))
+		return parse_ref_action_mode(config_value, "replay.refAction");
+
+	/* Default to update mode */
+	return REF_ACTION_UPDATE;
+}
+
 static int handle_ref_update(enum ref_action_mode mode,
 			     struct ref_transaction *transaction,
 			     const char *refname,
@@ -332,7 +349,7 @@ int cmd_replay(int argc,
 	const char *onto_name = NULL;
 	int contained = 0;
 	const char *ref_action = NULL;
-	enum ref_action_mode ref_mode = REF_ACTION_UPDATE;
+	enum ref_action_mode ref_mode;
 
 	struct rev_info revs;
 	struct commit *last_commit = NULL;
@@ -378,9 +395,8 @@ int cmd_replay(int argc,
 	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
 				  contained, "--contained");
 
-	/* Parse ref action mode */
-	if (ref_action)
-		ref_mode = parse_ref_action_mode(ref_action, "--ref-action");
+	/* Parse ref action mode from command line or config */
+	ref_mode = get_ref_action_mode(repo, ref_action);
 
 	advance_name = xstrdup_or_null(advance_name_opt);
 
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index ec79234c80..cf3aacf355 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -268,4 +268,50 @@ test_expect_success 'reflog message for --advance mode' '
 	test_cmp expect-reflog reflog-msg
 '
 
+test_expect_success 'replay.refAction=print config option' '
+	# Store original state
+	START=$(git rev-parse topic2) &&
+	test_when_finished "git branch -f topic2 $START" &&
+
+	# Test with config set to print
+	test_config replay.refAction print &&
+	git replay --onto main topic1..topic2 >output &&
+	test_line_count = 1 output &&
+	test_grep "^update refs/heads/topic2 " output
+'
+
+test_expect_success 'replay.refAction=update config option' '
+	# Store original state
+	START=$(git rev-parse topic2) &&
+	test_when_finished "git branch -f topic2 $START" &&
+
+	# Test with config set to update
+	test_config replay.refAction update &&
+	git replay --onto main topic1..topic2 >output &&
+	test_must_be_empty output &&
+
+	# Verify ref was updated
+	git log --format=%s topic2 >actual &&
+	test_write_lines E D M L B A >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'command-line --ref-action overrides config' '
+	# Store original state
+	START=$(git rev-parse topic2) &&
+	test_when_finished "git branch -f topic2 $START" &&
+
+	# Set config to update but use --ref-action=print
+	test_config replay.refAction update &&
+	git replay --ref-action=print --onto main topic1..topic2 >output &&
+	test_line_count = 1 output &&
+	test_grep "^update refs/heads/topic2 " output
+'
+
+test_expect_success 'invalid replay.refAction value' '
+	test_config replay.refAction invalid &&
+	test_must_fail git replay --onto main topic1..topic2 2>error &&
+	test_grep "invalid.*replay.refAction.*value" error
+'
+
 test_done
-- 
2.51.0

