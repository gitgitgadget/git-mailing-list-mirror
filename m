Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851DB2D7D41
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379968; cv=none; b=dj4ITnq7kCYZxNjf6oKdsTe8OdWVAaUa6EJLDLzrlu3IEZ83pCQlobLoS2mruDplOATrul6k/3jCmEkK8BCvjE6zWdntQ54JRx9UFbkMl2lE9wrTYspfwSEpGj90GLWroTdmT7Os4mKUrY8KXyhtTXUnknsB2m4DdgAK2E3JvEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379968; c=relaxed/simple;
	bh=02gwW6PpW+McC68DNodon2dULfYnW6YnhFSARSsHoEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiY5a34JK05/cTzFVi62f4ow7afpV09f+lDbXQBNlaqKQSkEhtWHnTZ8Ho1HX8foiSDnM0FV+jfTfF61gZfpqdxngPzv9dbqMU3LBaq3v/nnWkQMou8UyMJGyFuJxKZfLUlrm7l86llK+SOSYnI04cP0R/J4M4L2emMe8uKlM2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UARhSDtv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UARhSDtv"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-26c209802c0so43525105ad.0
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 11:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760379963; x=1760984763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5VggYu+JeKv5dRh52HodcDc3bBmr4pgLiOjlreS5og=;
        b=UARhSDtvHKBCv3xztW7wV1b3L/2ceD7N41nSWQxOHD3UrjEnrYwG2gNw2xB6CAPahB
         +kUtvHL0I1dGltYk5SLNL1f9TmfhSXFKowmnHm2pLRCxZezrqWEq6FhvkymSIqW6VzYo
         SDglYQt/IXWqG3EmVvxZaOY0SRuwwL9kf7REKLPXGG10haTeIkAQe8kjfxqqFtZZunwY
         lPBpidYSdBz/zX/ozqtbyVQkf1xR171QQmSRhgxlYVH6Q+HUzR4XldIDJOQGRHwzZWp1
         HiaQYedsfsdwrXMs4HnvzDOKpBsPKZDDVnB+k2i6InSb7UA5JPzImFwWXhsQ7Oeuhs4c
         Deow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379963; x=1760984763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5VggYu+JeKv5dRh52HodcDc3bBmr4pgLiOjlreS5og=;
        b=wY0p8v1vGb88tNDJ9shT4Tl5MXtQF1LZhRvP2h65mEmWsjQmKClbVRPUvZRDc8P0JB
         7FofBWngo3DhaXiJYGZkF6aN6e5+YrmchQO0uhueV6nMxO1A633CU2t3IDQwvDWTPvsg
         aVNEKbkLiJlbgRRWTqqUzrm91Waxb1yG7RLO3X1PiRFWUlEr0xAKCEVPRRiWiC5mrwjK
         jCh3M9MI8MkWZZihKPQvOUxAxz8mVVWtWk0rJFVq1fj3b/AQHbZswCa7QzrJfM79Ju/z
         yW7MWy7dqzYZ8097lcZuN5JGwrpBnLvwcWCZCZ6pU6mvXJ7BM1l+J25d3nGVmltFhjK3
         YphQ==
X-Gm-Message-State: AOJu0YzzCsOE31EkW1eyy92TmUbKiJyOBiGHUhQsg5URisiAvBLDdVd3
	xw21X4L+ebUbBULpjozT9tceVK9sTJzUL9sk3tEa2W2QunmtevCDuieSX40we8qgswk=
X-Gm-Gg: ASbGncvcSz3DolgVdeAI9XHzYT/SlIU1a/vzM5JbNpmyJa/ASp9UDrtKz0nyS8gCrrO
	qRSWF2fEzHrz29pC2xIhczBkRy7mIGUmm8cRXv87WWzpjXEn6grOZvhigNLwPHHB+7NCbxlUz1J
	3Mf3LAFzFO6Sp9hYnRQ1Lqx/Szo++XRviyVobImKuXY9mbdwuULXvtzNTdaZjGk33M5ti4OxsNF
	/cP2qzpPYnwNy4gAJlr+lfa2Hf5a+1jUxI7Pui+MXTHVpHlQbsuzIpiQlFzvj7jiCxQ8AAFmooz
	40f9oocqCWuvj6vV+o3o+OMZRAKq1+WR72N5LmAAe29xv7Wa0W9UsF5Yg7muM1LiRKWzJaIFQFc
	WB1/TZi/caWESlQDCkfkf8cyhJaV6o5l+BSe0FijqWbxU9be5HnxB6qdGOdNfB804gGiV2L6Zd8
	h9tmoFdHE/aa1trUU2zivwLmbjYZ03cShETwrJcEi08g+DMVYD2oar+5HguPnxZp41vRx94Q==
X-Google-Smtp-Source: AGHT+IE/TQMeEsvLWbA7ZIk0+WgsKqjA+fnk36ILviyKYbkxgIcAJBUR3JaF34nf9hfpAwVMPhVuhg==
X-Received: by 2002:a17:903:37d0:b0:24d:1f99:713a with SMTP id d9443c01a7336-290273ef0a6mr278597915ad.31.1760379963189;
        Mon, 13 Oct 2025 11:26:03 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:56:dc83:edd1:7853:510f:d37e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b62657166sm12913501a91.11.2025.10.13.11.25.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 11:26:02 -0700 (PDT)
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
Subject: [PATCH v3 3/3] replay: add replay.defaultAction config option
Date: Mon, 13 Oct 2025 23:55:30 +0530
Message-ID: <20251013182530.33041-4-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013182530.33041-1-siddharthasthana31@gmail.com>
References: <20251013182530.33041-1-siddharthasthana31@gmail.com>
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
--update-refs=print with every command.

The config option uses enum string values for extensibility:
  * replay.defaultAction = update-refs (default): atomic ref updates
  * replay.defaultAction = show-commands: output commands for pipeline

The command-line --update-refs option always overrides the config setting,
allowing users to temporarily change behavior for a single invocation.

Implementation details:

In cmd_replay(), before parsing command-line options, we read the
configuration using repo_config_get_string_tmp(). If the config variable
is set, we validate the value and map it to an internal mode:

  Config value         Internal mode    Behavior
  ────────────────────────────────────────────────────────────────
  "update-refs"        "yes"            Atomic ref updates (default)
  "show-commands"      "print"          Pipeline output
  (not set)            "yes"            Atomic ref updates (default)
  (invalid)            error            Die with helpful message

If an invalid value is provided, we die() immediately with an error
message explaining the valid options. This catches configuration errors
early and provides clear guidance to users.

The command-line --update-refs option, when provided, overrides the
config value. This precedence allows users to set their preferred default
while still having per-invocation control:

  git config replay.defaultAction show-commands  # Set default
  git replay --update-refs=yes --onto main topic  # Override once

The config option uses different value names ('update-refs' vs
'show-commands') compared to the command-line option ('yes' vs 'print')
for semantic clarity. The config values describe what action is being
taken, while the command-line values are terse for typing convenience.

The enum string design (rather than a boolean like 'replay.updateRefs')
allows future expansion to additional modes without requiring new
configuration variables. For example, if we later add custom format
support (--update-refs=format), we can extend the config to support
'replay.defaultAction = format' without breaking existing configurations
or requiring a second config variable.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Elijah Newren <newren@gmail.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/config/replay.adoc | 14 ++++++++++
 builtin/replay.c                 | 20 ++++++++++++--
 t/t3650-replay-basics.sh         | 47 +++++++++++++++++++++++++++++++-
 3 files changed, 77 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/config/replay.adoc

diff --git a/Documentation/config/replay.adoc b/Documentation/config/replay.adoc
new file mode 100644
index 0000000000..6012333cc1
--- /dev/null
+++ b/Documentation/config/replay.adoc
@@ -0,0 +1,14 @@
+replay.defaultAction::
+	Control the default behavior of `git replay` for updating references.
+	Can be set to:
++
+--
+* `update-refs` (default): Update refs directly using an atomic transaction.
+* `show-commands`: Output update-ref commands that can be piped to
+  `git update-ref --stdin`.
+--
++
+This can be overridden with the `--update-refs` command-line option.
+Note that the command-line option uses slightly different values
+(`yes` and `print`) for brevity, but they map to the same behavior
+as the config values.
diff --git a/builtin/replay.c b/builtin/replay.c
index 457225363e..3c618bf100 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -8,6 +8,7 @@
 #include "git-compat-util.h"
 
 #include "builtin.h"
+#include "config.h"
 #include "environment.h"
 #include "hex.h"
 #include "lockfile.h"
@@ -359,9 +360,22 @@ int cmd_replay(int argc,
 	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
 				  contained, "--contained");
 
-	/* Set default mode if not specified */
-	if (!update_refs_mode)
-		update_refs_mode = "yes";
+	/* Set default mode from config if not specified on command line */
+	if (!update_refs_mode) {
+		const char *config_value = NULL;
+		if (!repo_config_get_string_tmp(repo, "replay.defaultaction", &config_value)) {
+			if (!strcmp(config_value, "update-refs"))
+				update_refs_mode = "yes";
+			else if (!strcmp(config_value, "show-commands"))
+				update_refs_mode = "print";
+			else
+				die(_("invalid value for replay.defaultAction: '%s' "
+				      "(expected 'update-refs' or 'show-commands')"),
+				    config_value);
+		} else {
+			update_refs_mode = "yes";
+		}
+	}
 
 	/* Validate update-refs mode */
 	if (strcmp(update_refs_mode, "yes") && strcmp(update_refs_mode, "print"))
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index c2c54fbba7..239d7bd87a 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -299,7 +299,7 @@ test_expect_success 'replay atomic guarantee: all refs updated or none' '
 	# Store original states
 	START_TOPIC1=$(git rev-parse topic1) &&
 	START_TOPIC3=$(git rev-parse topic3) &&
-	test_when_finished "git branch -f topic1 $START_TOPIC1 && git branch -f topic3 $START_TOPIC3 && rm -f .git/refs/heads/topic1.lock" &&
+	test_when_finished "git branch -f topic1 $START_TOPIC1 && git branch -f topic3 $START_TOPIC3" &&
 
 	# Create a lock on topic1 to simulate a concurrent update
 	>.git/refs/heads/topic1.lock &&
@@ -308,6 +308,9 @@ test_expect_success 'replay atomic guarantee: all refs updated or none' '
 	# This should fail atomically - neither branch should be updated
 	test_must_fail git replay --contained --onto main main..topic3 2>error &&
 
+	# Remove the lock before checking refs
+	rm -f .git/refs/heads/topic1.lock &&
+
 	# Verify the transaction failed
 	grep "failed to commit ref transaction" error &&
 
@@ -354,4 +357,46 @@ test_expect_success 'replay validates --update-refs mode values' '
 	grep "invalid value for --update-refs" error
 '
 
+test_expect_success 'replay.defaultAction config option' '
+	# Store original state
+	START=$(git rev-parse topic2) &&
+	test_when_finished "git branch -f topic2 $START && git config --unset replay.defaultAction" &&
+
+	# Set config to show-commands
+	git config replay.defaultAction show-commands &&
+	git replay --onto main topic1..topic2 >output &&
+	test_line_count = 1 output &&
+	grep "^update refs/heads/topic2 " output &&
+
+	# Reset and test update-refs mode
+	git branch -f topic2 $START &&
+	git config replay.defaultAction update-refs &&
+	git replay --onto main topic1..topic2 >output &&
+	test_must_be_empty output &&
+
+	# Verify ref was updated
+	git log --format=%s topic2 >actual &&
+	test_write_lines E D M L B A >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'command-line --update-refs overrides config' '
+	# Store original state
+	START=$(git rev-parse topic2) &&
+	test_when_finished "git branch -f topic2 $START && git config --unset replay.defaultAction" &&
+
+	# Set config to update-refs but use --update-refs=print
+	git config replay.defaultAction update-refs &&
+	git replay --update-refs=print --onto main topic1..topic2 >output &&
+	test_line_count = 1 output &&
+	grep "^update refs/heads/topic2 " output
+'
+
+test_expect_success 'invalid replay.defaultAction value' '
+	test_when_finished "git config --unset replay.defaultAction" &&
+	git config replay.defaultAction invalid &&
+	test_must_fail git replay --onto main topic1..topic2 2>error &&
+	grep "invalid value for replay.defaultAction" error
+'
+
 test_done
-- 
2.51.0

