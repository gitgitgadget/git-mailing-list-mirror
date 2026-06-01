Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813C8283CBF
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 04:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780287313; cv=none; b=P6ZglAjt0a7wQchAuvyj3QQAn3gGKJi9/ZnEpCrdkx7BvKa77zMX9DkR8H7MR8lYg1ZAt0h0/Pw0pO1sL6wklabJmR8wzBJt7ELf7Z7BF73S1WYm4axpJ5FUjfpfAcaUktBff0pqcQ5W9sNOj/RGhVyP8W4pGzqI4dGH9tD9/j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780287313; c=relaxed/simple;
	bh=bLOKoEl7NMos28xVctyBjwZQLXc00Wjt4PmsJEwRyS8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=MkCuxSy8mmpVz/+2oBHGTMzAlc8I4eqB9NjnTJHXib8VbAkSE0a/2H1MpFdihdFO+iDMP9jXCK/OfaM+2txd95Nj9PeiGDnMF7OvQ1PIIt4l0CbzA4d/ij+l/wm+MzCLAy36pOC9foE57gEyoPbAw3OoHAko20/LdT6Gv3qsTLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQnXx/b6; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQnXx/b6"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-306f36df4feso510982eec.0
        for <git@vger.kernel.org>; Sun, 31 May 2026 21:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780287312; x=1780892112; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CKYw2Vad8pBg05LuHQ94ZXwnZI+vj30Rs9bXAgWkxE8=;
        b=aQnXx/b69WjGBZASjPYu0kQyVReo5E8Mek90ZdIuNJITNtS1PpVpbKtIPMnO2sc5nL
         Fc8ZRwQQUsvoHl1wcRJbuT9ykrj5iXY0ToOXO5Ou8/PUcwCX8v0llZhNsigaHyugkYck
         x0ACB01ldkuUwrkNIGSRfJP79JXFaInLmtI3PZgUtYxSiw8hz6y4pBlcCUNEZzcc+B4s
         k6Uc2zctw9RntCI3OtxYcsnfUmzNh8Ufa3RSOPwDimtmo4OEG7Rtv/JaH8O4xpYKtkAP
         sdObZB8fW2wmfOUd9R8VTMOFBtNMicLlPgvx7s41sqfFlfhsAHcMStcDDMnRHykOzl0F
         +MmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780287312; x=1780892112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKYw2Vad8pBg05LuHQ94ZXwnZI+vj30Rs9bXAgWkxE8=;
        b=TM2R4f0jtfEbH+4RyqNzw3Bu1tVlIhq5e29LeU9MGnoQoYyGppVd+GceUH1Ic45aHE
         NdUa+D9k0Ke/+Xd96n7XNpRz86OJu9KYv1OxyGeVOZ4n2ajDn2/yxTLr2s4+DpEKjI4X
         c4SOS8Z6VYEQSpJCmRXaS9KVJUYxX1lzeyWlFRZHwShRJQBztuKtJY58GE4dPpS7A/v7
         NNQ864pPKuJKSJjuo9Ho2Paszd1Ya0FMHsWkIzvodUn1uxIaCGxffQ4WYLVpSk+CmLuA
         VPslq4y2pi3nBLjjNBwiXgNffWelIPT06UtXNKyXESTXbzyaAMVCpXW9mo99l6jz8fXD
         O5QQ==
X-Gm-Message-State: AOJu0YyTUK536C7+UAfbFTkyG7nnuNIwibMXw6Rg4eD4Z7DulOAt7cu1
	rt+vrwr/zymVcRZYGPW990kGDBAf7aRiB+x4G67hc2HGXqcF7ay3Wl0xGdqahQ==
X-Gm-Gg: Acq92OE3MGdRGrjnEg4PNOVb4ReO49O0UKOz4i3vZPcXRP05MJCsMDyRDzqf/WmvlNf
	XHP/4h9xlNLypAWYENG2W9r3x6cimJ3oqtHeuWoV0cyPCCDKCJr/+J/bt4rdWAlxjKJP07wg7yH
	We6Cm6BynIg2Erv5B8Kw/0ShziG0P5XBCrRUnD7AtkCwyqM/63kuIbLzPGDmHcN2h13arc94weU
	DMPnw46YyXjWh/qmUDykCx2/h0x2bRm/Pwa47PM2+Ai/8kkHTVL1Il2iaZSI0BBtTdl+2S31QHl
	giV8S8ASrJLDpNhxN2w3fG8S6COdfYGLzgepbo7pr65h5QrpVhYpaC/b9XI5nztOFTiyYtc42GC
	XlHkbXiJdQ52wOOjWyXnhQVbBYumNJoUPkeLWz2JeNKOSaxFA+hfUYmjX/KEj2xhYPm7WmzjO/X
	dS7mhdVcJmlRwdSJHfKBggJruWgHyt/hbAdWLm
X-Received: by 2002:a05:7300:7313:b0:304:13f3:ecdd with SMTP id 5a478bee46e88-304eaccee98mr4417266eec.0.1780287311314;
        Sun, 31 May 2026 21:15:11 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.154.1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed130dafsm7615896eec.0.2026.05.31.21.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 21:15:10 -0700 (PDT)
Message-Id: <pull.2133.git.1780287309846.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 01 Jun 2026 04:15:09 +0000
Subject: [PATCH] sub-process: use gentle handshake to avoid die() on startup
 failure
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

When the configured subprocess command contains shell metacharacters
(such as a space), prepare_shell_cmd() wraps it in "sh -c <cmd>".
The shell itself always starts successfully, so start_command()
returns zero even if the tool inside does not exist.  The subsequent
handshake then reads from a dead pipe and calls die() via the
non-gentle packet_read_line(), killing the parent process instead of
letting it handle the error.

Before this change, a missing filter process at a path containing
spaces produces a confusing error:

    $ git -c filter.lfs.process="/path with space/tool" \
          -c filter.lfs.required=true add file.txt
    fatal: the remote end hung up unexpectedly

After this change, the proper error is reported:

    $ git ... add file.txt
    error: initialization for subprocess '/path with space/tool' failed
    fatal: file.txt: clean filter 'lfs' failed

Switch the subprocess handshake from the dying packet_read_line()
to packet_read_line_gently() so that a process that exits during
startup produces an error return instead of killing the caller.

This affects any subprocess consumer whose command path contains
spaces.  On Windows this routinely happens because programs live
under "C:/Program Files/...", and MSYS2 path conversion can rewrite
absolute paths to include that prefix.  On POSIX it triggers
whenever the configured path naturally contains a space or other
metacharacter.  convert.c (filter.<driver>.process, used by git-lfs
and custom clean/smudge filters) is the primary affected consumer.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
    sub-process: use gentle handshake to avoid die() on startup failure

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2133%2Fmmontalbo%2Fmm%2Fsubprocess-handshake-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2133/mmontalbo/mm/subprocess-handshake-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2133

 sub-process.c         | 11 ++++++-----
 t/t0021-conversion.sh | 17 +++++++++++++++++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/sub-process.c b/sub-process.c
index 83bf0a0e82..22c68bd10d 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -132,18 +132,19 @@ static int handshake_version(struct child_process *process,
 	if (packet_flush_gently(process->in))
 		return error("Could not write flush packet");
 
-	if (!(line = packet_read_line(process->out, NULL)) ||
+	if (packet_read_line_gently(process->out, NULL, &line) <= 0 ||
 	    !skip_prefix(line, welcome_prefix, &p) ||
 	    strcmp(p, "-server"))
 		return error("Unexpected line '%s', expected %s-server",
 			     line ? line : "<flush packet>", welcome_prefix);
-	if (!(line = packet_read_line(process->out, NULL)) ||
+	if (packet_read_line_gently(process->out, NULL, &line) <= 0 ||
 	    !skip_prefix(line, "version=", &p) ||
 	    strtol_i(p, 10, chosen_version))
 		return error("Unexpected line '%s', expected version",
 			     line ? line : "<flush packet>");
-	if ((line = packet_read_line(process->out, NULL)))
-		return error("Unexpected line '%s', expected flush", line);
+	if (packet_read_line_gently(process->out, NULL, &line) < 0 || line)
+		return error("Unexpected line '%s', expected flush",
+			     line ? line : "<read error>");
 
 	/* Check to make sure that the version received is supported */
 	for (i = 0; versions[i]; i++) {
@@ -171,7 +172,7 @@ static int handshake_capabilities(struct child_process *process,
 	if (packet_flush_gently(process->in))
 		return error("Could not write flush packet");
 
-	while ((line = packet_read_line(process->out, NULL))) {
+	while (packet_read_line_gently(process->out, NULL, &line) > 0) {
 		const char *p;
 		if (!skip_prefix(line, "capability=", &p))
 			continue;
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index f0d50d769e..033b00a364 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -857,6 +857,23 @@ test_expect_success 'invalid process filter must fail (and not hang!)' '
 	)
 '
 
+test_expect_success 'missing process filter with space in path does not die' '
+	test_config_global filter.protocol.process "/non existent/tool" &&
+	test_config_global filter.protocol.required true &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+
+		cp "$TEST_ROOT/test.o" test.r &&
+		test_must_fail git add . 2>git-stderr.log &&
+		test_grep "clean filter.*protocol.*failed" git-stderr.log
+	)
+'
+
 test_expect_success 'delayed checkout in process filter' '
 	test_config_global filter.a.process "test-tool rot13-filter --log=a.log clean smudge delay" &&
 	test_config_global filter.a.required true &&

base-commit: 29bd7ed5127255713c1ac2f43b7c6f257d7b4594
-- 
gitgitgadget
