Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2A230567D
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785577454; cv=none; b=Q65YqH/bVGB9K/NsrGuUzT6h5q9j6moeZ9OrbQDcCL2bnR+7hqWV/Ts5aIagbnoFIFWfJpCEXSDU8rqtZMW+eX/DocFWol09AxORM8YUKFbN7reVlfn8Lrn1yevjCFRiaeNeECwSL0sFF3wb9axLLAkgRmhVeXuvL8/8AwYYRkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785577454; c=relaxed/simple;
	bh=BKlGLlL6vArsISaKWH5oBVnuqIOybF/kOlTsYz7jyBU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j0d+mwrNKAJkyCZQw6tXHm8VAp54Dn9B58XyhEV4Vq6nxQm+3BYaD5AghQ0z1bq9DF/CW8Sb3JclTd5gpVUSELlWw0lf4DlbJ3VcqP3zjBfm8DLk7476UbRzYFybBUpp6z84ANQA+bm54qncTqm1+N/RsMQb1N327VMMsykZdn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQLacf67; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQLacf67"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cf27856f9cso18775515ad.2
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 02:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785577450; x=1786182250; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FpWe+d5pDDIQ+yeSlO4O0km+FO5mtuHN1Ip4iCC0NTA=;
        b=aQLacf67vT8bVbKinw5awt/2oixfUs5JfbedG8S5xRk8KcjNL1uNxIxPGH6UMsml9q
         AWgTP1saGmn4xdiuDOUfa008E5Yvfi/UjdAel/7j5976Od3XLe3U+2/rGkLurpFTiEmD
         wMf6LTn3fE+aDRJ9StLtRhYbYq8sO0W9QjnISMcDIwBo5y4RDI+tyatVpowp00l4uwk0
         38cpK+LuhXaZ7cJPxIpg9QMGNcLf8YUH96C+pjhNhveS9dbW/xZCn8gJJLWvz1YhPxzr
         +urQEk0PLZHT/8szQbL5LBBel4RqTxKoFJjcL8D1VwBvaltTky8EdFan4BUwyjGHWxBy
         yIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785577450; x=1786182250;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FpWe+d5pDDIQ+yeSlO4O0km+FO5mtuHN1Ip4iCC0NTA=;
        b=eBeOWkSYgJIFqDxDLpEspkt7KIPkS4cZzIY1te0MWqYG6BeF7voi4e0mbx9eQh+uTf
         ReUnFtkAyNtyxYmdLXIAnnzgFs8hPTkTylq7DhiO4KKSLJyR43QfEVUizfEuhMu39yd0
         Uzbc0ke55TVWg1igWj6A5yrZX6x2YlOCqbpKstFRkVia9Y4NpssGNie4BJE8ENKd5lh4
         3WR0EIDNSz8825AGJFpCEKGTR4zZMCBk4isHyTpSzI9lehzeTpEbjDminH9vWr/rfspe
         15W0UJLUL4wYoXyEXmBLoGMiZguUO0NUIF3bTveD/tz3T2xVSe/TwewtyLe1zt9t0deV
         woVw==
X-Gm-Message-State: AOJu0Yxz0gEqudmc0inffsIUJ5mE4fL1i81ZeNeXQ6orl3kkI9UR0Hom
	pN7VjRYN3Krk3exZB/imiVQy+VuntiMi++E0WGNRlbjtaD97vC34fczufmgu7dzP
X-Gm-Gg: AR+sD106EZ6GIiXW0Ju8kbFLFnO8jL7Z8scL7E33DXu5d1biRgYhA+paXQlJyRKj9rX
	+UdKSFIob49aCpMtBK4GSB6Z7I8nM0tInIAizUAUXdl/3mpesvCLj+GyORVpsgm3Z/sz8FmNIRF
	eqhrDUQp9CSntPyABcHek19mTa8DxrI/GZt5/PBaR1HnuDYawYCIgdoO+xtOYD2IJG9J5E1jz7x
	x79GRrwRnbyq57Pknqvdbjk1rvIkpwZxHTIWzFrDbdHPUEFLBsjBl1xk5OGOEkSxL0H6EvIEXkQ
	kqR5e+1/jlKIzZXar8NEWGgdrttewvovMULXsLSNTYWgizI408JxNYxL5hzarqf4rA+76HaU4Op
	ScKCMvMOv1sudFy2d84poFkRyWDSQTdYLMM50/EV1l3YKq7RgyT3bw6sC87M+vbXJZv6EhwNPyf
	pRmsuNt7PNOPV9rGKV8CHn2s0QBZiEik0O4f2ETeNCkc+Ib0CrNlSOU5AH5/xf5YA=
X-Received: by 2002:a17:902:d2c4:b0:2ce:b7b7:30e3 with SMTP id d9443c01a7336-2d0522510efmr30204355ad.17.1785577449876;
        Sat, 01 Aug 2026 02:44:09 -0700 (PDT)
Received: from [127.0.0.1] ([52.238.26.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae68cf7sm15962135ad.31.2026.08.01.02.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:44:09 -0700 (PDT)
Message-Id: <e39670edf4be8bc917a985666f200a88880212ce.1785577445.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2335.v4.git.git.1785577445.gitgitgadget@gmail.com>
References: <pull.2335.v3.git.git.1784538619.gitgitgadget@gmail.com>
	<pull.2335.v4.git.git.1785577445.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 01 Aug 2026 09:44:04 +0000
Subject: [PATCH v4 1/2] bisect: let bisect_reset() optionally check out
 quietly
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a "quiet" parameter to bisect_reset() that passes "--quiet" to the
checkout restoring the original HEAD, suppressing its progress and
branch-status output.

No caller sets the flag yet, so behavior is unchanged.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/bisect.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 3264e2da54..1e0c043249 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -234,7 +234,7 @@ static int write_terms(const char *bad, const char *good)
 	return res;
 }
 
-static int bisect_reset(const char *commit)
+static int bisect_reset(const char *commit, int quiet)
 {
 	struct strbuf branch = STRBUF_INIT;
 
@@ -255,8 +255,10 @@ static int bisect_reset(const char *commit)
 		struct child_process cmd = CHILD_PROCESS_INIT;
 
 		cmd.git_cmd = 1;
-		strvec_pushl(&cmd.args, "checkout", "--ignore-other-worktrees",
-				branch.buf, "--", NULL);
+		strvec_pushl(&cmd.args, "checkout", "--ignore-other-worktrees", NULL);
+		if (quiet)
+			strvec_push(&cmd.args, "--quiet");
+		strvec_pushl(&cmd.args, branch.buf, "--", NULL);
 		if (run_command(&cmd)) {
 			error(_("could not check out original"
 				" HEAD '%s'. Try 'git bisect"
@@ -1096,7 +1098,7 @@ static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
 	if (is_empty_or_missing_file(filename))
 		return error(_("cannot read file '%s' for replaying"), filename);
 
-	if (bisect_reset(NULL))
+	if (bisect_reset(NULL, 0))
 		return BISECT_FAILED;
 
 	fp = fopen(filename, "r");
@@ -1345,7 +1347,7 @@ static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNU
 	if (argc > 1)
 		return error(_("'%s' requires either no argument or a commit"),
 			     "git bisect reset");
-	return bisect_reset(argc ? argv[0] : NULL);
+	return bisect_reset(argc ? argv[0] : NULL, 0);
 }
 
 static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED,
-- 
gitgitgadget

