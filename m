Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFF8331203
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 21:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780348852; cv=none; b=Vxdmo/3IpFGy85A/B7SScDlcXSJD1qwRFISGtac8MlViMS3FF5GGc9kcCGfR3jx4FEkxRgzgl2vdK3+cCmNiE31DyKhprlMycTG8B+hWOTnvoBQwzAvDAxSAld4QMe+efAU1MzNsT6V5zoHlhu8/a9QodfUSewhcRQCwuq18N60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780348852; c=relaxed/simple;
	bh=4d7hjy7M1tHmtsO1Q33nsw6BWH3F6xn2aWwS2wytwvU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pmx/PyFGemMuuyGTkwNAf0mwDQjd9T0GdIL5N/bpc27Vg6TSjwaXl7ob188/19/rJRxufssuKNekn8C59PoTYeUAayJh7KuP0Qo12PtSskPEqv8dbxBXurvlHG6iWvLtqb92mXmpk/XBHC15tu8Ho5nNg1iYJi1l9t8zOePHRwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaD9614H; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaD9614H"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf1f074a12so37858575ad.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 14:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780348850; x=1780953650; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eINhWPh2AiREVr5h4aQjPz6GFKnpy9gJVMqaHrRcPPI=;
        b=DaD9614HlMWpw01dQGQikMq22epuvPC31dLaF5SgMpy7gFL9NSI1b6UZsRH7EV5FIT
         bgpBTGLQWKUC7t3rkzKB2pNqBWzs1csbmHgmC9ZTqpXs1/ibco6f+obCs3GeoF8t6vwt
         gyvpzF4kMAMzNGXTQIz1MkHoXlaN9q9BF3duS7YN2Kxz2/iyTitDbgqyJVOVWhBweOY5
         /PE/A/qKbE1ujSKum/VDVB39ymBhnjm+VV/w+hV2VWjUtNaABd9X6bIYQYdU3sxByxRy
         +RLcU4DzqmhiYUyIIuZ8sbaUkRQa9HxttmK1KYODUWa6m9tlY+wB6ExGPSJMWQz5FjMl
         i9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780348850; x=1780953650;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eINhWPh2AiREVr5h4aQjPz6GFKnpy9gJVMqaHrRcPPI=;
        b=N09q6/HeMS2+gkFH7pm/vXeSPpZ/AOnEVh0zjvOvCzHrkk8CpOgP0lBYbD7YUHIMYn
         IDoGYflnCbD0+7VJppUP4rKjJvOhIaq4nKFtrK+gR+LbonCKh1CJRAiA7ts6ISDYPGnE
         YkPjDXJwasyhPYhsh7SeJ/X+GoLv82XrwpA7Ks9QDbfTY4SsnAGTjx4PhJ0i5JL4Zkb+
         1+f3iOGUrwOjoiDs7uczFXPFfFe1QmT9v04HqYZR4awMhmgbyOGYyw8PTSzOSOWO/p0B
         3k08fT6B8dadN5AITSpjYCwkVYFLW0i0pmVqvIrr4E/HcpHAvhsqu9mLq70j1e3ry6RC
         b4zA==
X-Gm-Message-State: AOJu0YzeeBvctmxW+K9k9C9JqETbGbIQmb2fCc3sSg0tjbGiLTwGZFYQ
	E6EJJWtmO8Z2+SjpzHsfprqIDXdJwJZnyPZEy9afbYyZbqQ5p5QiwszxXGnwdA==
X-Gm-Gg: Acq92OGqZMtWYeBSeOgpyWbplhYZlJFyXDh9BPqNlDoS1kKh7Yr5Sr5kkkmG9Dov/pO
	UPweFtXTETkw2Vr33FT7jxm+Y7Kr5LK2DZ1pdSH8Yv1S9YYAfw5zaXu1YKrQ1AewoRSgMppvN8h
	D4aEtff0udB1/HW79FZVF1tq1jHuiDtziQdGoe9wQ85pPefWJAzS9sdmFs3g3wAmHQsRjE9Jf7s
	YgUjdGTWyrjGXvCqc2wzkkacfn08zuR0eegn2aib5oZqpDN+A7QBwCPuzNGKGr0rsfALjPv5+hW
	WOQ7VpRlnajJtZoJeM4Kz8wWpHqxgkU0vugNeA493OkcoV9K7p8dklwNJxf6qR/oZ4mJ9M9hveU
	Ud8Rnac49edJFgGyuh/LLiz/lQ+UVEGVtDSuu29/ZRF98J/GadRB+IlW8limZx26j95FWfNtvJC
	03G2Jm4yeEywdIsEL+eTOBb/NOJlq/J/11f1a5GU5UEGUWJA==
X-Received: by 2002:a17:902:d48b:b0:2c0:cce6:a45d with SMTP id d9443c01a7336-2c0cce6a899mr75143955ad.23.1780348849910;
        Mon, 01 Jun 2026 14:20:49 -0700 (PDT)
Received: from [127.0.0.1] ([20.3.183.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e71cbsm111218155ad.15.2026.06.01.14.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 14:20:49 -0700 (PDT)
Message-Id: <pull.2133.v2.git.1780348848489.gitgitgadget@gmail.com>
In-Reply-To: <pull.2133.git.1780287309846.gitgitgadget@gmail.com>
References: <pull.2133.git.1780287309846.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 01 Jun 2026 21:20:47 +0000
Subject: [PATCH v2] sub-process: use gentle handshake to avoid die() on
 startup failure
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

    $ git -c filter.myfilter.process="/path with space/tool" \
          -c filter.myfilter.required=true add file.txt
    /path with space/tool: line 1: /path: No such file or directory
    fatal: the remote end hung up unexpectedly

After this change, the proper error is reported:

    $ git ... add file.txt
    /path with space/tool: line 1: /path: No such file or directory
    error: could not read greeting from subprocess '/path with space/tool'
    error: initialization for subprocess '/path with space/tool' failed
    fatal: file.txt: clean filter 'myfilter' failed

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2133%2Fmmontalbo%2Fmm%2Fsubprocess-handshake-fix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2133/mmontalbo/mm/subprocess-handshake-fix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2133

Range-diff vs v1:

 1:  c11b01c156 ! 1:  cb7bd777dc sub-process: use gentle handshake to avoid die() on startup failure
     @@ Commit message
          Before this change, a missing filter process at a path containing
          spaces produces a confusing error:
      
     -        $ git -c filter.lfs.process="/path with space/tool" \
     -              -c filter.lfs.required=true add file.txt
     +        $ git -c filter.myfilter.process="/path with space/tool" \
     +              -c filter.myfilter.required=true add file.txt
     +        /path with space/tool: line 1: /path: No such file or directory
              fatal: the remote end hung up unexpectedly
      
          After this change, the proper error is reported:
      
              $ git ... add file.txt
     +        /path with space/tool: line 1: /path: No such file or directory
     +        error: could not read greeting from subprocess '/path with space/tool'
              error: initialization for subprocess '/path with space/tool' failed
     -        fatal: file.txt: clean filter 'lfs' failed
     +        fatal: file.txt: clean filter 'myfilter' failed
      
          Switch the subprocess handshake from the dying packet_read_line()
          to packet_read_line_gently() so that a process that exits during
     @@ sub-process.c: static int handshake_version(struct child_process *process,
       		return error("Could not write flush packet");
       
      -	if (!(line = packet_read_line(process->out, NULL)) ||
     -+	if (packet_read_line_gently(process->out, NULL, &line) <= 0 ||
     - 	    !skip_prefix(line, welcome_prefix, &p) ||
     +-	    !skip_prefix(line, welcome_prefix, &p) ||
     ++	if (packet_read_line_gently(process->out, NULL, &line) < 0)
     ++		return error("could not read greeting from subprocess '%s'",
     ++			     process->args.v[0]);
     ++	if (!line || !skip_prefix(line, welcome_prefix, &p) ||
       	    strcmp(p, "-server"))
       		return error("Unexpected line '%s', expected %s-server",
       			     line ? line : "<flush packet>", welcome_prefix);
      -	if (!(line = packet_read_line(process->out, NULL)) ||
     -+	if (packet_read_line_gently(process->out, NULL, &line) <= 0 ||
     - 	    !skip_prefix(line, "version=", &p) ||
     +-	    !skip_prefix(line, "version=", &p) ||
     ++	if (packet_read_line_gently(process->out, NULL, &line) < 0)
     ++		return error("could not read version from subprocess '%s'",
     ++			     process->args.v[0]);
     ++	if (!line || !skip_prefix(line, "version=", &p) ||
       	    strtol_i(p, 10, chosen_version))
       		return error("Unexpected line '%s', expected version",
       			     line ? line : "<flush packet>");
      -	if ((line = packet_read_line(process->out, NULL)))
     --		return error("Unexpected line '%s', expected flush", line);
     -+	if (packet_read_line_gently(process->out, NULL, &line) < 0 || line)
     -+		return error("Unexpected line '%s', expected flush",
     -+			     line ? line : "<read error>");
     ++	if (packet_read_line_gently(process->out, NULL, &line) < 0)
     ++		return error("could not read version flush from subprocess '%s'",
     ++			     process->args.v[0]);
     ++	if (line)
     + 		return error("Unexpected line '%s', expected flush", line);
       
       	/* Check to make sure that the version received is supported */
     - 	for (i = 0; versions[i]; i++) {
      @@ sub-process.c: static int handshake_capabilities(struct child_process *process,
       	if (packet_flush_gently(process->in))
       		return error("Could not write flush packet");
       
      -	while ((line = packet_read_line(process->out, NULL))) {
     -+	while (packet_read_line_gently(process->out, NULL, &line) > 0) {
     ++	for (;;) {
       		const char *p;
     ++		int len = packet_read_line_gently(process->out, NULL, &line);
     ++
     ++		if (len < 0)
     ++			return error("could not read capabilities from subprocess '%s'",
     ++				     process->args.v[0]);
     ++		if (!line)
     ++			break;
       		if (!skip_prefix(line, "capability=", &p))
       			continue;
     + 
      
       ## t/t0021-conversion.sh ##
      @@ t/t0021-conversion.sh: test_expect_success 'invalid process filter must fail (and not hang!)' '


 sub-process.c         | 26 ++++++++++++++++++++------
 t/t0021-conversion.sh | 17 +++++++++++++++++
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/sub-process.c b/sub-process.c
index 83bf0a0e82..2d5c965169 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -132,17 +132,24 @@ static int handshake_version(struct child_process *process,
 	if (packet_flush_gently(process->in))
 		return error("Could not write flush packet");
 
-	if (!(line = packet_read_line(process->out, NULL)) ||
-	    !skip_prefix(line, welcome_prefix, &p) ||
+	if (packet_read_line_gently(process->out, NULL, &line) < 0)
+		return error("could not read greeting from subprocess '%s'",
+			     process->args.v[0]);
+	if (!line || !skip_prefix(line, welcome_prefix, &p) ||
 	    strcmp(p, "-server"))
 		return error("Unexpected line '%s', expected %s-server",
 			     line ? line : "<flush packet>", welcome_prefix);
-	if (!(line = packet_read_line(process->out, NULL)) ||
-	    !skip_prefix(line, "version=", &p) ||
+	if (packet_read_line_gently(process->out, NULL, &line) < 0)
+		return error("could not read version from subprocess '%s'",
+			     process->args.v[0]);
+	if (!line || !skip_prefix(line, "version=", &p) ||
 	    strtol_i(p, 10, chosen_version))
 		return error("Unexpected line '%s', expected version",
 			     line ? line : "<flush packet>");
-	if ((line = packet_read_line(process->out, NULL)))
+	if (packet_read_line_gently(process->out, NULL, &line) < 0)
+		return error("could not read version flush from subprocess '%s'",
+			     process->args.v[0]);
+	if (line)
 		return error("Unexpected line '%s', expected flush", line);
 
 	/* Check to make sure that the version received is supported */
@@ -171,8 +178,15 @@ static int handshake_capabilities(struct child_process *process,
 	if (packet_flush_gently(process->in))
 		return error("Could not write flush packet");
 
-	while ((line = packet_read_line(process->out, NULL))) {
+	for (;;) {
 		const char *p;
+		int len = packet_read_line_gently(process->out, NULL, &line);
+
+		if (len < 0)
+			return error("could not read capabilities from subprocess '%s'",
+				     process->args.v[0]);
+		if (!line)
+			break;
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
