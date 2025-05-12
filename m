Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A3B242D60
	for <git@vger.kernel.org>; Mon, 12 May 2025 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068023; cv=none; b=WB6Xg8/MicKxir94tV1Co43Kwab8uqPu11+IzQMemDabkH4Tla+LW6CEEB1HHq/w/ovD+/MnH3WajmBbugUg9lGP6LoBz9wRi/P7cnwy6FFraH9r7/HKk5s2zv9hiGODPz+l6gzdX3sh/PG2K1id7mazB0uGeZ2HA8oc21W7/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068023; c=relaxed/simple;
	bh=LnTkUK8Uwx3ro6zhnIKOQNu9QP9fZFMlRTzotcXkVpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAU9ct3Qq/AZa5o/RZhf6U1+mOrhYtOq3s6bsuTPMMmCgKHjSr7JriHLFagkE4bU+U9fbgczB4UDW4LT6XyNPgwwP1FuA9wPZZMRa0A3pr8PACy1TiB+e8z3l5tR3p83cu6I3wz7l8FfNOav9XNA6vq26dPhW0jQ+8lXbOgajDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pnua3jsJ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pnua3jsJ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30c5478017dso2547856a91.2
        for <git@vger.kernel.org>; Mon, 12 May 2025 09:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747068021; x=1747672821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML5VYjzw8lLW3o3R+ck+z2801o6t3lm4UZQCIFuBQ4Q=;
        b=Pnua3jsJe2L1EWIXXN0opnd92uYPTEGt1JzVAP6QvMokNi8W5p04PDMWB5zgO68A5q
         rRZ8ZgL8j+ZLf+VJs5OfIH55FuqStZmMIFbDieyPh9Pm6IBmfA+j025m13wGCmmyXZQo
         7QeIDE5UpcyJgFQbtbGm/9S7W2gYWx7yp4LrWzI57/EdCpUIxmXTqPcVAloogBoZHk/j
         CKcHkzvvZD/OTyypv8pgA4Q77R/1m3FSpJ2srlmRCElyj+SaQF8R23E+8InjkNGawgx5
         on2GiRT0IqWwIjVBzwR7fPSBHeXEzQXzmStWFNTNE5tgKxqjxiFuAUaxwrLHbkIwTGaO
         jTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747068021; x=1747672821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ML5VYjzw8lLW3o3R+ck+z2801o6t3lm4UZQCIFuBQ4Q=;
        b=i36SJc1BMAmzAwRDWbaaQJUxHu+7C/h+cD/7VIH4+sKT9yiSX57+oW4KVdp3DJJ1o4
         uisy2m7K8N0XMqoVkA5NXdBI1WW1sm36AlEVOI73c8kF3Y/0sl+VdMT3IFyIkSnMnA+D
         qvHP3r/Bg/+KAUu5NWSuuucBZuupza3OA4FzXxWJFDvWMm4LAxuYio2AawyMv0yH38mS
         eXAd67AL80o0nG2SWcx2gyWxfZfqOnF4EBgM1WCAv3bXRZX3jgBO9heLeytQS9y2lTCL
         nIAzR1veRZiTaKBL/aHcp+R8uVGtqC3UaL+rUIxqu8TQv6iUFOqlSItoiC0IOqp52Hfc
         cm0Q==
X-Gm-Message-State: AOJu0Yzeo7YyjML+3tqfE+5fBqCRplRnmXPKzjSydABLG5TcKkSrqyfY
	lTJWvn42cYTOr3kZzEHmSwhdU6nvvYoMW2gCTPliksW9g2IMhfxz
X-Gm-Gg: ASbGncssdELr65wJrs0YcuunEFp0NBqwSXcRDr4jqoO7FmjEQyGfU96Gs7MAMhxIRuN
	jdwxqm4k143lbc/X9bE0FDkaHgjq02C3jAUD6YM793B6au8SOZ4yeN3N6AcdmtnUNWCDMav2xi3
	Ta98emzkxIOsEObYBU98cIl/JZVTEAQ/r13ah6uBpJXuFOYO+8kPSwM8+nAE8jCLXVWESr/XXvk
	MI6SIwC1dn39PEczAmz+e4q56pUaex84Yjy3Cin5H08GEVkd4wd5UJ7ZPmoOTNwtKWyrli9ulFb
	NiBHuGIisY0ETy7OcLtcbfTGE5t1BdchePzNxSFjVNO8lKZEMXMwLq4wLK5aYiSPUmY=
X-Google-Smtp-Source: AGHT+IF0n5gbl5akTOaIRIW/ypAhV/KBLzDyeNpSexy32id56H233TqEhnKomrJpcoNXMtOg4BAdsg==
X-Received: by 2002:a17:90b:3a81:b0:301:1d03:93cd with SMTP id 98e67ed59e1d1-30c3d649983mr24369177a91.24.1747068021157;
        Mon, 12 May 2025 09:40:21 -0700 (PDT)
Received: from fedora.. ([2409:40f0:39:2e07:18d6:cc5f:51d0:f20d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39e61040sm6860924a91.31.2025.05.12.09.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 09:40:20 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: smacdonald@kaimaging.com
Cc: git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com
Subject: [PATCH] stash: fix incorrect branch name in stash message
Date: Mon, 12 May 2025 22:10:01 +0530
Message-ID: <20250512164001.62065-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <TO1PPF29324B4CE2F822159A3F1C6A5F3B4CD97A@TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM>
References: <TO1PPF29324B4CE2F822159A3F1C6A5F3B4CD97A@TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating a stash, Git builds the stash commit message using the current
branch name of the superproject. However, in repositories that include
submodules, the stash message may incorrectly show the submodule branch
instead of the superproject.

This happens because `branch_name` is obtained via `refs_resolve_ref_unsafe()`,
which returns a pointer to a static buffer. Later calls to the same function
(e.g., during commit creation or submodule reference resolution) overwrite
this buffer, causing the `branch_name` used in the final stash message to be
incorrect.

Reported-by: Stuart <smacdonald@kaimaging.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/stash.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index cfbd92852a..6a375a3430 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1377,6 +1377,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf commit_tree_label = STRBUF_INIT;
 	struct strbuf untracked_files = STRBUF_INIT;
+	char *branch_name_buf = NULL;
 
 	prepare_fallback_ident("git stash", "git@stash");
 
@@ -1404,11 +1405,20 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 
 	branch_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
 					     "HEAD", 0, NULL, &flags);
-	if (flags & REF_ISSYMREF)
-		skip_prefix(branch_ref, "refs/heads/", &branch_name);
-	head_short_sha1 = repo_find_unique_abbrev(the_repository,
-						  &head_commit->object.oid,
-						  DEFAULT_ABBREV);
+
+	if (flags & REF_ISSYMREF) {
+		const char *tmp = NULL;
+		if (skip_prefix(branch_ref, "refs/heads/", &tmp))
+			branch_name_buf = xstrdup(tmp); 
+	}
+		if (branch_name_buf)
+			branch_name = branch_name_buf;
+		else
+			branch_name = "(no branch)";
+					    
+		head_short_sha1 = repo_find_unique_abbrev(the_repository,
+							&head_commit->object.oid,
+							DEFAULT_ABBREV);					    
 	strbuf_addf(&msg, "%s: %s ", branch_name, head_short_sha1);
 	pp_commit_easy(CMIT_FMT_ONELINE, head_commit, &msg);
 
-- 
2.49.GIT

