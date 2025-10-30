Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF9C23D2B8
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761852012; cv=none; b=j6GlTABVuPUJm6m5+J54B09/74nqjH8cVFgsQVeXt1dRT6IKkL5d/Ep88101W4o9Kud3d0o+EYtBtv33dQIRHZ8E4NUT7XO3/i1Z/0/8BeXekqKIvSm7ETHz3fyGZDl5ncth8Co2GekbMzKBzK2/l8vgLrsqnv0SxKHsJsvA0Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761852012; c=relaxed/simple;
	bh=ajSIgnWt1FdWf5Ji5azJTh2pkIgeEY+JK6IRDYU2D3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0GcxJj9WKKxVqjIthLJEO4rm0m2w2RlMuyxR41IqscqWka4jCOOJYWHRrRajvWXWgJN4kk7uwFAw3w9+9VLktlQoGFBDssT6e/oABcnw2cgandmwkdiXjBRYM8yPTcXbcmCObjaYFu2dmWqhwXBol+iGykeERBOI4lCDzYGR2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPQl+UJ4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPQl+UJ4"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a683385ad8so1010335b3a.3
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 12:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761852009; x=1762456809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7J5yjySuj8cT4PhgY+83ZFEVQxMXUZzCGFxKJoeU1Pk=;
        b=gPQl+UJ4f2scrbSjrfLvYafF9vz5toAhicSe1i4myM87OLnrzT/NcoyXo23cUPENEo
         3BoqDGApOHa7ToiuqHIppG5rBiYgli8n/mI6GwPdqKJiBY83JFpw4UhHUtL4xL4X2BXn
         AtfX4GqE74pubsOHGUNj+rfmkXG8mzm78e8oNgCPEQkhmvZ9p2Wdu9d25cXOaZANNnru
         Abfg54C7qm/gGF1EzLVg2ryO/9zJmwB0fvFAA/l4nLb3HzLrPqtMfQSD4s7SXBzLqJmG
         RjE7e1dt3lEfjBAtJYOpSLZOX4jMKJP5M4XDQ22agCPCUd8QYu8eC/aj9tcBtbIDYGK1
         pZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761852009; x=1762456809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7J5yjySuj8cT4PhgY+83ZFEVQxMXUZzCGFxKJoeU1Pk=;
        b=LeENlMlmsspAppcDWHPed6iobav9DEq2PQKh4SsYT/ctzk+JokybG/+nJlFvxQtiUn
         DwRForPu8a+/bHTyGk0QIxAmNsp/4FgrBJRO9qkK7R3GNZSXEcl+wzK//moR7bTKZpHy
         EBH1cAzl5GBetrvkitErwKo3ok2SDUjEmBWkCyWjF9QlzHtN+gQy3rPBiqC83IMgHDMk
         bVzmc5hGwtqYVggzhhtyu2PFc7DIJmfqol8gBOF3mwSnRGfqVL19sLVJ6gJavJkv7Fbt
         kZFGuifhDceY35Uyd3u98Ivakhq9hevl4zFWmW2xpQPIP+0I3Kx5jQ2SB0n59/r1Kl0J
         Tajw==
X-Gm-Message-State: AOJu0YyZ+ekItl0kDfvtlkhjqH7BJYA2QlT+X3g3yLPaP0DIFk6SnxlT
	tLjzL8Z59zBfAQUi8KTA1ncZtUz8iao2VQmnXMO8uIu4tGdHMQLjCLPmjw8eOOl8epU=
X-Gm-Gg: ASbGncszzM1HHU9f9MKfF/vEjYr8HBn743+uFrw6Qfb4IqumuI7WleBLx7laZ3Lh28m
	Y+t/ke6e3M/M+INjCSAFrQAnSJccoifg4T+ryfxT+NRkMQ3CRKlpKa3ezqyd1i4u37NjrgZkwO3
	jQxHYIRn39cip5FxXMCGFHq24y8Sw4hdRCAYaxy6rp2JBqawBQ3v0a4W9R/55M1D3UGMJ+E79M0
	nsuyDb0Lie/2JsLkrWe5MUahfz2NoYIm83EQlFBM+I7RIeTsKLFg//Imt1phEFJpYBieBLpMk8y
	1DTOODcjFvGFVbIA/59L0AIdf7CBe6qTq3b53OjfcmKXbs5NmHCasbvKmPLBuFhx0plMTC5payB
	9OIu399scAJ7kT1suuhOvidQaGYZo3Yhqd+BzYZ3HJejEkLj8LaKqO6FzR1aus9EdCaq8WbUFAP
	ZIdzDxnBa5AO3QnqRTf61NwYntyvSD/roNenxrwGgISFeq6ncHOFwWgYC2YgROlb7waAO6ruksu
	0sTGCxS2v/BOT1e66XIW8P8P4UzX6H2YQ==
X-Google-Smtp-Source: AGHT+IFuxktEZUvbe1DmO9qVqXc6yzcgSfn9Uh8MgxWWUJOGjdJWd7KS4RlJzxZ2wC+4/1EEgPm0VA==
X-Received: by 2002:a05:6a00:2d0b:b0:7a2:7aa9:a00c with SMTP id d2e1a72fcca58-7a777d3c06bmr736351b3a.14.1761852009094;
        Thu, 30 Oct 2025 12:20:09 -0700 (PDT)
Received: from localhost.localdomain ([2409:40e3:177:42ef:e197:ba89:d0f7:5538])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a445156004sm10359135b3a.51.2025.10.30.12.20.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Oct 2025 12:20:08 -0700 (PDT)
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
Subject: [PATCH v6 3/3] replay: add replay.refAction config option
Date: Fri, 31 Oct 2025 00:49:31 +0530
Message-ID: <20251030191931.30837-4-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030191931.30837-1-siddharthasthana31@gmail.com>
References: <20251028214609.10041-1-siddharthasthana31@gmail.com>
 <20251030191931.30837-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a configuration option to control the default behavior of git replay
for updating references. This allows users who prefer the traditional
pipeline output to set it once in their config instead of passing
--ref-action=print with every command.

The config option uses string values that mirror the behavior modes:
  * replay.refAction = update (default): atomic ref updates
  * replay.refAction = print: output commands for pipeline

The command-line --ref-action option always overrides the config setting,
allowing users to temporarily change behavior for a single invocation.

Implementation details:

In cmd_replay(), after parsing command-line options, we check if
--ref-action was provided. If not, we read the configuration using
repo_config_get_string_tmp(). If the config variable is set, we validate
the value and use it to set the ref_action_str:

  Config value      Internal mode    Behavior
  ──────────────────────────────────────────────────────────────
  "update"          "update"         Atomic ref updates (default)
  "print"           "print"          Pipeline output
  (not set)         "update"         Atomic ref updates (default)
  (invalid)         error            Die with helpful message

If an invalid value is provided, we die() immediately with an error
message explaining the valid options. This catches configuration errors
early and provides clear guidance to users.

The command-line --ref-action option, when provided, overrides the
config value. This precedence allows users to set their preferred default
while still having per-invocation control:

  git config replay.refAction print         # Set default
  git replay --ref-action=update --onto main topic  # Override once

The config and command-line option use the same value names ('update'
and 'print') for consistency and clarity. This makes it immediately
obvious how the config maps to the command-line option, addressing
feedback about the relationship between configuration and command-line
options being clear to users.

Examples:

$ git config --global replay.refAction print
$ git replay --onto main topic1..topic2 | git update-ref --stdin

$ git replay --ref-action=update --onto main topic1..topic2

$ git config replay.refAction update
$ git replay --onto main topic1..topic2  # Updates refs directly

The implementation follows Git's standard configuration precedence:
command-line options override config values, which matches user
expectations across all Git commands.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Elijah Newren <newren@gmail.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/config/replay.adoc | 11 ++++++++
 builtin/replay.c                 | 39 ++++++++++++++++++--------
 t/t3650-replay-basics.sh         | 48 +++++++++++++++++++++++++++++++-
 3 files changed, 86 insertions(+), 12 deletions(-)
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
diff --git a/builtin/replay.c b/builtin/replay.c
index 0564d4d2e7..810068f8ef 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -8,6 +8,7 @@
 #include "git-compat-util.h"
 
 #include "builtin.h"
+#include "config.h"
 #include "environment.h"
 #include "hex.h"
 #include "lockfile.h"
@@ -289,6 +290,31 @@ static struct commit *pick_regular_commit(struct repository *repo,
 	return create_commit(repo, result->tree, pickme, replayed_base);
 }
 
+static enum ref_action_mode parse_ref_action_mode(const char *ref_action, const char *source)
+{
+	if (!ref_action || !strcmp(ref_action, "update"))
+		return REF_ACTION_UPDATE;
+	if (!strcmp(ref_action, "print"))
+		return REF_ACTION_PRINT;
+	die(_("invalid %s value: '%s'"), source, ref_action);
+}
+
+static enum ref_action_mode get_ref_action_mode(struct repository *repo, const char *ref_action_str)
+{
+	const char *config_value = NULL;
+
+	/* Command line option takes precedence */
+	if (ref_action_str)
+		return parse_ref_action_mode(ref_action_str, "--ref-action");
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
@@ -367,17 +393,8 @@ int cmd_replay(int argc,
 	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
 				  contained, "--contained");
 
-	/* Default to update mode if not specified */
-	if (!ref_action_str)
-		ref_action_str = "update";
-
-	/* Parse ref action mode */
-	if (!strcmp(ref_action_str, "update"))
-		ref_action = REF_ACTION_UPDATE;
-	else if (!strcmp(ref_action_str, "print"))
-		ref_action = REF_ACTION_PRINT;
-	else
-		die(_("unknown --ref-action mode '%s'"), ref_action_str);
+	/* Parse ref action mode from command line or config */
+	ref_action = get_ref_action_mode(repo, ref_action_str);
 
 	advance_name = xstrdup_or_null(advance_name_opt);
 
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 123734b49f..2e90227c2f 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -219,7 +219,8 @@ test_expect_success 'merge.directoryRenames=false' '
 
 test_expect_success 'default atomic behavior updates refs directly' '
 	# Store original state for cleanup
-	test_when_finished "git branch -f topic2 topic1" &&
+	START=$(git rev-parse topic2) &&
+	test_when_finished "git branch -f topic2 $START" &&
 
 	# Test default atomic behavior (no output, refs updated)
 	git replay --onto main topic1..topic2 >output &&
@@ -232,6 +233,10 @@ test_expect_success 'default atomic behavior updates refs directly' '
 '
 
 test_expect_success 'atomic behavior in bare repository' '
+	# Store original state for cleanup
+	START=$(git rev-parse topic2) &&
+	test_when_finished "git branch -f topic2 $START" &&
+
 	# Test atomic updates work in bare repo
 	git -C bare replay --onto main topic1..topic2 >output &&
 	test_must_be_empty output &&
@@ -245,4 +250,45 @@ test_expect_success 'atomic behavior in bare repository' '
 	git -C bare update-ref refs/heads/topic2 $(git -C bare rev-parse topic1)
 '
 
+test_expect_success 'replay.refAction config option' '
+	# Store original state
+	START=$(git rev-parse topic2) &&
+	test_when_finished "git branch -f topic2 $START" &&
+
+	# Set config to print
+	test_config replay.refAction print &&
+	git replay --onto main topic1..topic2 >output &&
+	test_line_count = 1 output &&
+	test_grep "^update refs/heads/topic2 " output &&
+
+	# Reset and test update mode
+	git branch -f topic2 $START &&
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

