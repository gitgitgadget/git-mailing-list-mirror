Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0913429A9C3
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097290; cv=none; b=tywE1Oxvh9j5OZXJ6DcAmtI586M2zqf8DPNbw+e4kizoBwhp1wxlYhN08CzU3Rm8+H/lhu4HNmZCy+ycBC8coARI9kDstD5a0fHVN2NNrlGP1/c53Us3PeWkiSLw+k64KGXrFidZeuCGXh+vysuZAG4LmR1ODN22rsEglheRiAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097290; c=relaxed/simple;
	bh=XACahN5V2SSBwjB0Qnz1YqtQdXmHMwiPIHgSQtlCNmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCa07H4yyLcCQXSv+auRw4OIj5ThfUZYDDhO5o8Btx/pByprLP4V9tz59VY0G6W6KtYbIz30daRsOYu69glZbvCQJR2GjTEZBUqTi0hHoYL/gKDowk1GNdlEt5iqD7Ll8Gu64g8geKFaN3tBgJRyR88zAe/l4Xxm2WMnwUOIVmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=NzV+whhZ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="NzV+whhZ"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d71bcab6fso41153337b3.0
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097286; x=1759702086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F/ohfvaQ/W1EaISt/UK9LVsIsFX6sy4DaMaPsLx1OJY=;
        b=NzV+whhZBm3CzMXZu6uX7/WoNNMUpZbJOzGHEK/Ceg24m+tKUARxDLudaofeK+uW4o
         klAFItaEPph4T+XFSaO/ymPFXW3z53wj7eK6xaHyXrLjsSXKBdZor5lxTYQ0ThdVpxKj
         cTQnWBCH9hD6XZEetZoA1ZFAzcAq3XLKA6282Vm/Ayt7Cufu2WyhLYBFUKuHtx1DrCZ5
         WYVndUsid6eD+ZSOqqePM9bR+//zHwTL7qGobi+DXGBj7537JIk9RxnbLjEjdhVE5BjJ
         x0w6xnz38aXTZId3E3uD8eEquE6T3IVxqoT3bBTDqs2kYNsJfGm7O+B1poOQuV+05bti
         FTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097286; x=1759702086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/ohfvaQ/W1EaISt/UK9LVsIsFX6sy4DaMaPsLx1OJY=;
        b=ZkxNoICeJp/OcCfW5Ft4y5k0Z/lRbRyqK674FKZ25wfXLWzeoeARuNOeWOlXh71H2y
         Kiy/vrfUirTyEi0Pf1PCjMdxxXFInfIeHrqALyI42tC7UK0l2qIdepPKjzF6CvicWTJi
         tvtgkSCPKuoZMRoLNVoVfjruSm5mEXhPZlgkT/tM3zWnwWuOg6RpuxkcIAuCHY5XHMff
         6P1E6Is+iCj0+6iLHaEeco6tBAja5Z3MeHcX0t4jJRdrwjZooinJtwbEqGu0Ct94C5x4
         28ovdjehsnzBchcsIs5Z706SysOp2pYGMq6USJ5OFb/4MvN9OTs3GV+lPmRft9VZ3XpM
         6DGA==
X-Gm-Message-State: AOJu0Yypb+e9E0lpK+ReQAvoblyrXYRvM4PWnd1v7fkfKzOPAYkfQ26B
	bxm85ncFs5eZj00njF+1/VyFeBOdmnTqS6qJnXVddGTj0BJnI24bgQG60gkKLoLIRRzZeOyKEn2
	O5CVVxMk=
X-Gm-Gg: ASbGnctuR8GTgkE982Pubn7IEjPHtAJPDoHS0FyCgNLfRzo+7oIZD3n1jHjqGC5PlEr
	8VhjMBvyU2PxQ89y0xydCEnKfivZPlBoft4ga7tSDEUR4irLGHV+54Hx4ZPEkAj0awrTXWYz9Ue
	urH707pW/ZDkvGDHexwN7L8u4qoXhhPuJW5s3QzXdF+LyigIdkh0DBGmGvc1ToykFWzv+l0crBW
	u6PWLkgkCZ8JrReM5YfeTAWZuItLV4kVkZiMfLQTDSYdQSTYnN75ZGQcbnIUUm+vIlkXXBEEOAu
	i5n5BgfWHDt6SD5pPOGYpDqADASIccEfti+KVdEj4n6eHbF80E3IPPk/38Axqu2j+HLLSEcREj8
	3bKrsPMQiqVPMYeo6rvVSmt376ZAaqBJ0uhQwGUifSltntVF+zzw+Xshqsvrqi0H4MsQ2Q/ixd/
	4Edry5B6EDsOQ8qYRYyvAN0vy+temkpBDujHW7
X-Google-Smtp-Source: AGHT+IFh2rN+rsYmgcdA86ir15PFRL9+n1/q4hU3nB4IHbLaN24GEnjgVCDiFlxLWiMUiC/Sk4vVJw==
X-Received: by 2002:a05:690c:9a85:b0:766:6507:685e with SMTP id 00721157ae682-76665077870mr125720897b3.8.1759097286500;
        Sun, 28 Sep 2025 15:08:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6361e8c25dasm2695914d50.4.2025.09.28.15.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:08:06 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:08:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 14/49] repack: remove 'prepare_pack_objects' from the builtin
Message-ID: <2d9022385d69bf288867f417a1222a8b157d0bd8.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

Now that the 'prepare_pack_objects' function no longer refers to
external, static variables, move it out to repack.h as generic
functionality.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 34 ----------------------------------
 repack.c         | 35 +++++++++++++++++++++++++++++++++++
 repack.h         |  5 +++++
 3 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index f4af830353..ff93654cfe 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -288,40 +288,6 @@ static void collect_pack_filenames(struct existing_packs *existing,
 	strbuf_release(&buf);
 }
 
-static void prepare_pack_objects(struct child_process *cmd,
-				 const struct pack_objects_args *args,
-				 const char *out)
-{
-	strvec_push(&cmd->args, "pack-objects");
-	if (args->window)
-		strvec_pushf(&cmd->args, "--window=%s", args->window);
-	if (args->window_memory)
-		strvec_pushf(&cmd->args, "--window-memory=%s", args->window_memory);
-	if (args->depth)
-		strvec_pushf(&cmd->args, "--depth=%s", args->depth);
-	if (args->threads)
-		strvec_pushf(&cmd->args, "--threads=%s", args->threads);
-	if (args->max_pack_size)
-		strvec_pushf(&cmd->args, "--max-pack-size=%lu", args->max_pack_size);
-	if (args->no_reuse_delta)
-		strvec_pushf(&cmd->args, "--no-reuse-delta");
-	if (args->no_reuse_object)
-		strvec_pushf(&cmd->args, "--no-reuse-object");
-	if (args->name_hash_version)
-		strvec_pushf(&cmd->args, "--name-hash-version=%d", args->name_hash_version);
-	if (args->path_walk)
-		strvec_pushf(&cmd->args, "--path-walk");
-	if (args->local)
-		strvec_push(&cmd->args,  "--local");
-	if (args->quiet)
-		strvec_push(&cmd->args,  "--quiet");
-	if (args->delta_base_offset)
-		strvec_push(&cmd->args,  "--delta-base-offset");
-	strvec_push(&cmd->args, out);
-	cmd->git_cmd = 1;
-	cmd->out = -1;
-}
-
 struct write_oid_context {
 	struct child_process *cmd;
 	const struct git_hash_algo *algop;
diff --git a/repack.c b/repack.c
index a1f5b796fb..91b6e1cc09 100644
--- a/repack.c
+++ b/repack.c
@@ -1,5 +1,40 @@
 #include "git-compat-util.h"
 #include "repack.h"
+#include "run-command.h"
+
+void prepare_pack_objects(struct child_process *cmd,
+			  const struct pack_objects_args *args,
+			  const char *out)
+{
+	strvec_push(&cmd->args, "pack-objects");
+	if (args->window)
+		strvec_pushf(&cmd->args, "--window=%s", args->window);
+	if (args->window_memory)
+		strvec_pushf(&cmd->args, "--window-memory=%s", args->window_memory);
+	if (args->depth)
+		strvec_pushf(&cmd->args, "--depth=%s", args->depth);
+	if (args->threads)
+		strvec_pushf(&cmd->args, "--threads=%s", args->threads);
+	if (args->max_pack_size)
+		strvec_pushf(&cmd->args, "--max-pack-size=%lu", args->max_pack_size);
+	if (args->no_reuse_delta)
+		strvec_pushf(&cmd->args, "--no-reuse-delta");
+	if (args->no_reuse_object)
+		strvec_pushf(&cmd->args, "--no-reuse-object");
+	if (args->name_hash_version)
+		strvec_pushf(&cmd->args, "--name-hash-version=%d", args->name_hash_version);
+	if (args->path_walk)
+		strvec_pushf(&cmd->args, "--path-walk");
+	if (args->local)
+		strvec_push(&cmd->args,  "--local");
+	if (args->quiet)
+		strvec_push(&cmd->args,  "--quiet");
+	if (args->delta_base_offset)
+		strvec_push(&cmd->args,  "--delta-base-offset");
+	strvec_push(&cmd->args, out);
+	cmd->git_cmd = 1;
+	cmd->out = -1;
+}
 
 void pack_objects_args_release(struct pack_objects_args *args)
 {
diff --git a/repack.h b/repack.h
index 12632d7fec..3f7ec20735 100644
--- a/repack.h
+++ b/repack.h
@@ -21,6 +21,11 @@ struct pack_objects_args {
 
 #define PACK_OBJECTS_ARGS_INIT { .delta_base_offset = 1 }
 
+struct child_process;
+
+void prepare_pack_objects(struct child_process *cmd,
+			  const struct pack_objects_args *args,
+			  const char *out);
 void pack_objects_args_release(struct pack_objects_args *args);
 
 #endif /* REPACK_H */
-- 
2.51.0.243.g16eca91f2c0

