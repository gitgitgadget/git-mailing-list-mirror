Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E272E5B2D
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154378; cv=none; b=rNtpt+Iz2t+PXPM9edAUVBhNk76RBAYFazW4GhJ68RAd0jVWDhtn4c0DE3xvk8aKVK+zs7v0CQrsR93QKsRQ7XSbV6PlqVfK8aEq27utFg6j8YRP1MGn/mvfrImVVJw4WPUQU+6Hdt/aGOhoxdaoHF0kCwAxCGkk60i8eN0xNzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154378; c=relaxed/simple;
	bh=b8xx0nVcyHHmlFv5SVsYvXuooxa9fF5NmOuYqBifhTE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=O0gPU7tD5UESVd5cLp2+rYaej5DM5XcqYcxYooBmiZyfMpepqdImfM4ltx+4OTCoWipTeqSXNZtVCoDpPbhzicLAYqUafh7Jubu6TFmuBoz2CnDaCC/VPvKCJQ85mxSkmIbP7g6BdCJSeJNwY4WpRTAHplVrfKlqcj6NxeITeIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ylegcz7z; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ylegcz7z"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35f1f76ea84so3525253eec.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 05:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792154376; x=1792759176; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gTfifuPfZKV+a7zzeBEKjP5aBaCMnP5SUDABhJStk7A=;
        b=Ylegcz7z/1f5JlDqG2AzefxWQZrxRcYhR2N4xE3naMCerg4eTXvgz+nYvQ7ZViVVrh
         JPAZZ45YE8a72VMIT3bqhF2VmBvnMc1s6bXRW4oD+vZmQ+HXVEMsrOtbTmK0RaQe3CTa
         SqtzCDxU446vjpfEq2CidubifhsfMLWC+yYsXPIfRz45IsDXyrCdzpcDONzjNsas4D+l
         S5mMMB7tRq6N8gNKzGKcTcicqaj9w015BN6krGBsB2XYlZjkxLiK/wA37vWCtdrMmKDz
         NDuiFeT7FQHoXmDZwlF2IOkIOhUW3d8dQ5bP7NZMKDsllDRn7ipQb7asag8K/rkIRQAl
         spHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792154376; x=1792759176;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gTfifuPfZKV+a7zzeBEKjP5aBaCMnP5SUDABhJStk7A=;
        b=u8AHftbPQrTrUmzyEbz400TyeSBYmlWSc34sgEpdERG5v5JlnlkYgrBs+m+6LiVpWk
         YPkmD9H9Ef3J3x2fArDS4c39fXdCPiRwfZqHrqYmCAOwPH0/61HPaG+NEXOSDg95zfyk
         44t2vEksR9SdSFeZrJ+sdRCcOnUK/mz5xMy/VXASzt4w7kiKiWSPjVqNesj6qd5uI/0y
         OXcDXgThLNWZtNwSNN1NcDAuYGEvjXJjusbU8UI3buGUxWlkK470SZxTOoLU3JpNseFW
         fH3YucXbe4GxQLuLE7ipYSNAFIHhlYYBfuoiCVndGiKJvuNVlIypDqIZ9ikHbn4aRyPE
         p6EQ==
X-Gm-Message-State: AFq9FYIohqKMb9lNNTxyMFcsFHLBm7EecjirT8yVNM8tsusPs6wtQtWS
	gEKW3gftbUFDbBBcmBIgq+QTNZS5d8/m61euVKd6vGU0ueeDsSxqCxFhSfXtnQ==
X-Gm-Gg: AYBFou2IA6yoCjRm7qzk8noY/6IjN1NHACaezejO7D1ohe/E9E1Jak17408ljY8BQVv
	iwjpbL6TqG8gL+L9Y/kWi6Hm9672BLp8HufWp1rN3196HPsC9izMu2Vo8x/uh5tW06T4NWZw4SL
	O2DbJox+AhRjwat+PkkXxOiCAGxw1EjHHvdPPnf6tAvTE7taPbgAmPui7coK1QFHqNSRc8DGPeH
	yOUFlzTfiJcoUt19o2PMCVH2ajyTCK3tYnpDQn8GcJeHijmozQ3LdUqRYcETSoa4A7sYsVYXFAU
	+DmT7npUJuqJ3cCy0r0mJiVA2uWVAwEitBuc0DQfC+IuZgIm516hnemeKAPx7tFG4oh0I61xV0K
	ZyzN6G/mUaeRJGPTKt14boiOxkG85y7ze8XMCJ2/WTvkRB+HuR5gvZDHrMoy3CLFaZU37yH2yYT
	oJah2UGrUi2FmK6OeZOA8eFmL7HzOwcvt4YS8DUaqDf6eXyf8VcUZVWm5sk2lUkYgI5PXR40iUV
	YBHuYuaPB1F2Jw=
X-Received: by 2002:a05:7022:282:20b0:181:5cac:8f27 with SMTP id a92af1059eb24-1815cac907cmr5610247c88.35.1792154375973;
        Fri, 16 Oct 2026 05:39:35 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.209.243])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ba424a6sm5927624c88.17.2026.10.16.05.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 05:39:35 -0700 (PDT)
Message-Id: <pull.2261.git.1792154374653.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Oct 2026 12:39:34 +0000
Subject: [PATCH] sideband: skip unrecognized allowControlCharacters keywords
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

Since 128914438a (sideband: add options to allow more control
sequences to be passed through, 2026-03-05), the value of
sideband.allowControlCharacters is a comma-separated list of
keywords. When the parser meets a keyword it does not know, it warns
but stays on that keyword, so the warning repeats forever.

As the setting is read whenever a transport is set up, a typo like
"colour", a list written as "color, cursor" with a space, or a
keyword that only a newer version of Git knows is enough to make
every fetch, push, clone and ls-remote hang this way.

Move on to the next keyword after the warning, and name only the
unrecognized keyword in it, not the rest of the list.

Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
    sideband: skip unrecognized allowControlCharacters keywords

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2261%2Fthomasbachem%2Fsideband-control-characters-loop-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2261/thomasbachem/sideband-control-characters-loop-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2261

 sideband.c                          | 19 ++++++++++++-------
 t/t5409-colorize-remote-messages.sh | 25 +++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/sideband.c b/sideband.c
index 374187402e..ed6840bf89 100644
--- a/sideband.c
+++ b/sideband.c
@@ -62,18 +62,23 @@ int sideband_allow_control_characters_config(const char *var, const char *value)
 
 	allow_control_characters = ALLOW_NO_CONTROL_CHARACTERS;
 	while (*value) {
-		if (skip_prefix_in_csv(value, "color", &value))
+		if (skip_prefix_in_csv(value, "color", &value)) {
 			allow_control_characters |= ALLOW_ANSI_COLOR_SEQUENCES;
-		else if (skip_prefix_in_csv(value, "cursor", &value))
+		} else if (skip_prefix_in_csv(value, "cursor", &value)) {
 			allow_control_characters |= ALLOW_ANSI_CURSOR_MOVEMENTS;
-		else if (skip_prefix_in_csv(value, "erase", &value))
+		} else if (skip_prefix_in_csv(value, "erase", &value)) {
 			allow_control_characters |= ALLOW_ANSI_ERASE;
-		else if (skip_prefix_in_csv(value, "true", &value))
+		} else if (skip_prefix_in_csv(value, "true", &value)) {
 			allow_control_characters = ALLOW_ALL_CONTROL_CHARACTERS;
-		else if (skip_prefix_in_csv(value, "false", &value))
+		} else if (skip_prefix_in_csv(value, "false", &value)) {
 			allow_control_characters = ALLOW_NO_CONTROL_CHARACTERS;
-		else
-			warning(_("unrecognized value for '%s': '%s'"), var, value);
+		} else {
+			const char *end = strchrnul(value, ',');
+
+			warning(_("unrecognized value for '%s': '%.*s'"),
+				var, (int)(end - value), value);
+			value = end + !!*end;
+		}
 	}
 	return 0;
 }
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index 5da8b0ad64..6117579eb1 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -190,4 +190,29 @@ test_expect_success 'allow all control sequences for a specific URL' '
 	test_grep ! "\\^\\[\\[K" decoded
 '
 
+test_expect_success 'unrecognized keywords in allowControlCharacters are skipped' '
+	write_script .git/eraser <<-\EOF &&
+	printf "error: Ohai!\\r\\033[K" >&2
+	exec "$@"
+	EOF
+	test_config_global uploadPack.packObjectsHook ./eraser &&
+	test_commit unrecognized-keyword &&
+
+	# Cap the output, so that a parser stuck on the unrecognized
+	# keyword fails the test instead of warning forever.
+	git -c sideband.allowControlCharacters=bogus,erase \
+		ls-remote . 2>&1 >/dev/null |
+	head -n 2 >warnings &&
+	test_line_count = 1 warnings &&
+	test_grep "allowcontrolcharacters.: .bogus.$" warnings &&
+
+	rm -rf throw-away &&
+	git -c sideband.allowControlCharacters=bogus,erase \
+		clone --no-local . throw-away 2>stderr &&
+	test_decode_color <stderr >color-decoded &&
+	test_decode_csi <color-decoded >decoded &&
+	test_grep "CSI \\[K" decoded &&
+	test_grep ! "\\^\\[\\[K" decoded
+'
+
 test_done

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
