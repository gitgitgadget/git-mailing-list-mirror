Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0DF28D83D
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761159089; cv=none; b=KR3/pYaACBGn0Zvh6xvMBOoU9P0b+iemeE51TWSwmLIfu6RrO3PBl5JH37nEvjEBPAcm/Uv1Zb0s5tz3ROavBoeSruQdR1FLV9+7UBTnW0tqYbvmr6FTtnJBAdPA0ulwGikOYv/P6iK1eDKfbRb5a+pmSp7vSvH48k6QYqvP8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761159089; c=relaxed/simple;
	bh=d58kQdNOFNNwdvYK+/fjg4AyuMFyYoXBApcZiylukmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZ7iZfaVFTzFHO8AaE7O3OfH7uJJkYWInbG+BTzVQBrpUdbMdCvP2DHbCKgGPnAUXyfiOFni+cmlEahPQKMRK5neEjodZNv+FgZ4kLayvYDiQ6lO77ZE7/O3UQKEh+XR5fNzLkUDBUMqztP2wkiHGP7GDOM2ADaWobqPSy7gEI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyzSNDQX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyzSNDQX"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-26a0a694ea8so51591855ad.3
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 11:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761159086; x=1761763886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fy8BrARgvURwxMbPAuIOa2MDri70FzkAMH369kdiPy8=;
        b=VyzSNDQXNUSznQ6E/yXnAFLV7hHc+sJBdce5uE1vU67FoxNkdAm6gkyYS5J8/OXStz
         6F93gmAn+Rl0grGIn8h/noH62QqaNcy7SArxB/0SgqJ1FXYXICOVWaH0tQr6lhE/VEQj
         5QfG+P0/1OurfNuc25bFkYCuq42Zux9K/50s5t6QDgKFXU+vqHcAF66CcXlbp2RZ8tIQ
         QcLXMomYoS0VhXTgcJFA/+j88JXi0FI6AFl3IGgD4O3VtYUe4ObBn7M5cS+eBkWvpgrQ
         8yHVWrm56vU942LolSLCzzFXOD9ErI60hPWgF5VHInzn+QNzNaScxppiGXuVqCG/QCzh
         xMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761159086; x=1761763886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fy8BrARgvURwxMbPAuIOa2MDri70FzkAMH369kdiPy8=;
        b=BZnwFFDxs1rcm0WxBnxQngCAha02JLKLrZMgt3SLZ4h8rgENxH78xN43tToj6dGCoN
         ZA78R9CguSVyLCsArkYokK0vt8GJwlXKLnLLke6ubUzJWtsoNDwzUN+WQTaeOFlXIg5O
         fCc9JxWy3ibxs61DYXz2qTRvSx3l8XlHruaPK0ET9RB79v0YbtAXNJfPN1341ArtWyr2
         37iPHHHerh75da5G2ueGDMqktdKXRu/4IGGzSjT4fNc+Z55RGVJP/3nA85qAUfgBHb6U
         MioJs+uxWRplCG9mQ1Z6r3PJInowKlF4ke5MG8i41Q2S5f4ksroy31tnPUwqGHrNwhzH
         ctxQ==
X-Gm-Message-State: AOJu0Ywc4km47jfIOSL8YmjkvcU9U1wJPh0FVkweZxkcnqWXnGmII2N7
	5XIS6/Y8kCei8AwvW9hkJBhjt/wfrFHoE22NZCs+wCsacwQIqEUfGawFjkF/doMPmW8=
X-Gm-Gg: ASbGncujqo0maOAxltvsGeD5T0AcIxClDBftX3j6atQIL/RbF86Tnvq8Tx/DiVRhEXW
	RkIL5+TBttZS2VvNvG9WcX9vSI5gsb98pqaAAanPc8mgP5HZKlQQv/xW3t+cKlm06KGF5DUnd7B
	hOA5/T9KcN+nqy+E7Tti7+UdyV1p0yvx/Xd3Y3CDRpFRU4ge1+rfPl620fghNM6rcu6SCqfAht0
	BiWMSaA5Q4bk/dmaZqEtGRIs2JHrEUBu2GgaSiSifj9jjzEvjTC9YpQGtaW6jvO4F47XSRplNLo
	1F6DPGHHqqoo1vBhBpMFxbW0K7426Ynf/V55AkMMDGJ1G7e9qHZ3rzkiYcefp8tC514cqy3myZ+
	p0fPgYba5uaVBbn1QwVdkUbzzGpVaoI9hkbnvamo/2HYf7uuNYZ3YaoWGajpwxDMp36mVGoStx2
	TyHfnFruD0/r1AU+kz5R47Vr7rBjve63DO09tVkO0ChOE42Oc3uLejcn9evdkE/c7NyQMkha9sT
	ifJQzQDX4zMwJ7cNgbzK97wDobItJnPyQ==
X-Google-Smtp-Source: AGHT+IHWhow+iZYAFWo6lmMYuF6Th24Te8ZxUILkH0V1xgyr2KZNWj1vfcpmaHDJXdv8+/BPIGdYBQ==
X-Received: by 2002:a17:902:f611:b0:267:44e6:11b3 with SMTP id d9443c01a7336-290cb27af27mr234030335ad.45.1761159086317;
        Wed, 22 Oct 2025 11:51:26 -0700 (PDT)
Received: from localhost.localdomain ([2409:40e3:176:32cf:8d9c:2c8b:22d4:a7e2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2930623208bsm25691755ad.31.2025.10.22.11.51.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Oct 2025 11:51:25 -0700 (PDT)
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
Subject: [PATCH v4 3/3] replay: add replay.refAction config option
Date: Thu, 23 Oct 2025 00:20:45 +0530
Message-ID: <20251022185045.29256-4-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022185045.29256-1-siddharthasthana31@gmail.com>
References: <20251013183311.33329-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-1-siddharthasthana31@gmail.com>
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
 Documentation/config/replay.adoc | 11 +++++++++
 builtin/replay.c                 | 16 +++++++++++-
 t/t3650-replay-basics.sh         | 42 ++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)
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
index 1246add636..bb0420dc99 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -8,6 +8,7 @@
 #include "git-compat-util.h"
 
 #include "builtin.h"
+#include "config.h"
 #include "environment.h"
 #include "hex.h"
 #include "lockfile.h"
@@ -367,7 +368,20 @@ int cmd_replay(int argc,
 	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
 				  contained, "--contained");
 
-	/* Default to update mode if not specified */
+	/* Set default mode from config if not specified on command line */
+	if (!ref_action_str) {
+		const char *config_value = NULL;
+		if (!repo_config_get_string_tmp(repo, "replay.refAction", &config_value)) {
+			if (!strcmp(config_value, "update"))
+				ref_action_str = "update";
+			else if (!strcmp(config_value, "print"))
+				ref_action_str = "print";
+			else
+				die(_("invalid value for replay.refAction: '%s'"), config_value);
+		}
+	}
+
+	/* Default to update mode if still not set */
 	if (!ref_action_str)
 		ref_action_str = "update";
 
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 54c86b87d8..307beb667e 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -217,4 +217,46 @@ test_expect_success 'merge.directoryRenames=false' '
 		--onto rename-onto rename-onto..rename-from
 '
 
+test_expect_success 'replay.refAction config option' '
+	# Store original state
+	START=$(git rev-parse topic2) &&
+	test_when_finished "git branch -f topic2 $START && git config --unset replay.refAction" &&
+
+	# Set config to print
+	git config replay.refAction print &&
+	git replay --onto main topic1..topic2 >output &&
+	test_line_count = 1 output &&
+	grep "^update refs/heads/topic2 " output &&
+
+	# Reset and test update mode
+	git branch -f topic2 $START &&
+	git config replay.refAction update &&
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
+	test_when_finished "git branch -f topic2 $START && git config --unset replay.refAction" &&
+
+	# Set config to update but use --ref-action=print
+	git config replay.refAction update &&
+	git replay --ref-action=print --onto main topic1..topic2 >output &&
+	test_line_count = 1 output &&
+	grep "^update refs/heads/topic2 " output
+'
+
+test_expect_success 'invalid replay.refAction value' '
+	test_when_finished "git config --unset replay.refAction" &&
+	git config replay.refAction invalid &&
+	test_must_fail git replay --onto main topic1..topic2 2>error &&
+	grep "invalid value for replay.refAction" error
+'
+
 test_done
-- 
2.51.0

