Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DD62D738A
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380424; cv=none; b=QE95nbzVkXFlm8s1/+Azn2Y0Cm3nCTzxynhYoYXUHMS1W7OGop5h49O8iOQjPJ6TqHPnzJYd/eXeXiT511SQ1+tn3yM724nC2YluiWPVrNFzJf3USrSz/I6Mz5AFUdo7rm7yW01iYzDKSelSKwOR+vJdh8H9mW9J5toEZypDdwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380424; c=relaxed/simple;
	bh=02gwW6PpW+McC68DNodon2dULfYnW6YnhFSARSsHoEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuINACoA+A7DvJMsHMiQoeB1wQONeKiF/MKK5czuN0/zKozOlv0wKFbtzokOqXnzFGOwybmuaMhhlBoJVQdaA6xGlnaZLvl/MNHii8IVMHtjwWsVFmeegysydMflVtLAitEoUmDKJhX4yginsOzluj+XDTDb6/KZWD911N91vcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3BstGut; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3BstGut"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b632a6b9effso2740370a12.1
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 11:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760380422; x=1760985222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5VggYu+JeKv5dRh52HodcDc3bBmr4pgLiOjlreS5og=;
        b=E3BstGutNOByuUd1KUrVY/8jyLlo1Ilg9HRGcjob7otnu693IW8xCiBdjlaZl49aMf
         MoYl8gZUPpIOlml2yuS5uOXhXiMqH4hTykwg2XE/jpyzi8u+6l+v7DxGLYJzlphD9zHQ
         42qyzOPY0T/5rEgUS1zhHCbp1LKHv4C0EhEQ6t3ZEGZg6R5Cckuyqvz9NrR6L+3RQ/qA
         Wc6N3eAANKcg+Y8L8Dsf6I5j3jRHDSijo45a7e8tB7Mi7aWJ69lQ65I7EeIUJwndHjSA
         X8Em+r4WTXZ6XqSEyVlB67KY5b4oefeTe0xxSrNuj//h8wpGjgm5PBqogKbQ+Ywjh5GU
         pI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760380422; x=1760985222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5VggYu+JeKv5dRh52HodcDc3bBmr4pgLiOjlreS5og=;
        b=HvYOARDW+bP2EpI2LaXuoJPTQwT+ghddeG7i2iA6IT3HNDHgMV4qtDyOZWgzBInkL1
         73T2ZXQL9dgpmmn/xrd0YNrlFDIff8kGIxVIG9CpGhs8dPOqI7C7a5ahhzd6/aGobrKh
         EaWuI2bzZcf82/JGhpAbfjOalYpJ1yyfOWsAf4Hd7atdjM/bVqA0X42sMFVUBq+xyQfh
         5eN3L1rAXpF/S5Wt52Wjcf5WXbbk0nlCOwPVmWWrAIis+yye+1DOWHZUHxSJwb8kIuHp
         ++fY7Rax/5jHpmBxGwXeM3UuMnFD6cZbO0HpWQjOEKy6xk+JMleinmT9OVfLDlu2WFh9
         n4/Q==
X-Gm-Message-State: AOJu0YyXNBQlWHCJGpG7chPC54w0VdQcB4C73zd2+yOgLCPgQUfWxkck
	rOSuzok2CL2+ng2PDJWsoYQWpfKs3b7p8ygFXg3i9FyJwSexggyPrNbsL+FLJXgc+g4=
X-Gm-Gg: ASbGncsUDAlu1PtxfbJ4BE5sHR0v/9/Ai5qTOO2ZJkvZ9R3ryXeJiIO6tnbNSOsjDfg
	TZVScQTMVW0+CUWxMPxAz6dwg/hedrRXvFfIrnChCKhxUA2p4G/arcaTjLW6lPoRKF2KzeqanBm
	Ya40Qix5EeRs5qBcYpcy4vAfZAfFUmxCWuAPFAjwy+33OVXMy51CWS7onv1fHyivZPFRNz66oEM
	jqLcJLw1WE31ZsGczqEbc5yndS16SpR51AgGqsacusBhGUaWyd/9CDK9WDzHXzi6dgi+2smTtsi
	qo48Dck2I3nVchOjy7YkrUxqK/mlpt8N1eeeMFBZ+UaLP41kKm45ckdUIab7ptBh1QHHXIB3ake
	CRFDwKhz02vSa/oDecrESpGFKKAbuSd1Tf3Gv8WnxQPD5lx0otO/fTKgEuTL3uk4bG5ZddHcfuu
	JRXRtW0lmokMImgSmSJ+np/GWRUzqTCboYHchA6S1oJ7//DO4tCVKeZlpBpWDW1qehDqoPLQ==
X-Google-Smtp-Source: AGHT+IFV/mLGwn65q6EsgXPiX34d1VVxZ/GNf83NLK9kbRV5LGxmjGyjLPz0NvRfYdlYnB9gNqECqw==
X-Received: by 2002:a17:902:ccc8:b0:28d:18d3:46ce with SMTP id d9443c01a7336-290273ed885mr277340775ad.31.1760380421662;
        Mon, 13 Oct 2025 11:33:41 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:56:dc83:edd1:7853:510f:d37e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6c70sm140019905ad.13.2025.10.13.11.33.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 11:33:41 -0700 (PDT)
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
Date: Tue, 14 Oct 2025 00:03:11 +0530
Message-ID: <20251013183311.33329-4-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013183311.33329-1-siddharthasthana31@gmail.com>
References: <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <20251013183311.33329-1-siddharthasthana31@gmail.com>
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

