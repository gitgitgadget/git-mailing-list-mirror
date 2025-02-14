Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5951C84AC
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739574149; cv=none; b=ZUd8kaBSzYMahHyH6Vylov3oqikDknMLkA8Dj88a66YNq62LlyNaF/XWVP9K+mcRy2IYxQ0RvXTd9RzleAHXmqhdwt/ViDW097dfa87FH86Ap3X2Sp52rO9CUWhpEYN5JRsVnRZuiZ7ivFnDNZEjdPLlko45WzwRIhCKvi5GbT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739574149; c=relaxed/simple;
	bh=CLWf79hCHXa18PmnRPt2IGiNK/+7FwWGqABZYxUludM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqkKSzRxDmgFzu3ndlO2ZCQuUZ8ZAKOWwsSD4FffG/Gb6NdaSZn0PbyUPoaLtPwrrdmQEgC9uduhdO6f7W3NuDnZnhPd75ctDDLpLWqxa6XbSfs9J+363r/bGbdHuB0FFOEOao66QoESl+5Fa/39BtYLeBxQWWo/HnlfkP/VeNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQlRMX/C; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQlRMX/C"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220dc3831e3so35252675ad.0
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 15:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739574147; x=1740178947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGLpxZcYuMveJD8YK4VAdO4MrBe3t2WT0pyBflisuAY=;
        b=kQlRMX/CuadTVQ4jBkkKn/vb7pQJDnkSLeIWTwPSpN/JgmdICyinyxFyhNdQPOaWFB
         hoXLQR7oeP4+6Y7BQ9Zxhfio7C6pZ/eFe+xm+YQZTn36UDp1usqCdcurDydNTzyuGS64
         W+35bV7VNtyUzshYSujvofJIazyjX+gAqhK+wd0sqcsfTy12m92FvRRFPmOKxhR0cYc9
         Co9dq/YRv4i5IcuiZJmLIatGoyNTHenPB4w+GcIw+b4VAdtCZ9IHhpO6CclHXPJn7MP0
         o+21EH5YlmD1aqrt7tkTmE0BOQmpMHqB2XlhTdNIoQPx2GHNKqkW2g3iNXcjV8zw1kIz
         rgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739574147; x=1740178947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGLpxZcYuMveJD8YK4VAdO4MrBe3t2WT0pyBflisuAY=;
        b=L/8s0ViSGIOAwrl42UNZXd3Hl/oDZekWCoSE5ekMh70JAh8mp0qFHhyVp+ck8PNox4
         hHpQYenzzyWGiTU3IsUsh7S8eZA2dBJwhPvXlLctrweEOdmRrRiNKGxkrZp6hbSyXsr6
         TdEj9VTaYuzmIca8qUXmHxu2vdoIPlxn7RAUzqOA6rvu5k1TnVFqgAL46q22l4booFbD
         yyI4wLPxd4Kj6UYhIPcdI12gfomWvz5bX26xFwU+qfQJXtF15B3II3Ahktd+J0aOZ/Q0
         uhiP6CG+s5Eg178LAbuspAuQcR15vSq/xa9mxzNLs7LxITCo/YrsoAyc74NAqrzJKJJO
         2EAg==
X-Gm-Message-State: AOJu0YzNh4XuHc4ddSDV1YTSpAN6DcNFfMn6FqkVTOKDXoWfLpXFll4A
	koFgQM6qagO6rJjYV2+QVuFMlXdjNzrQD2fiIro30okADn5eyj5R34Q8+FOg
X-Gm-Gg: ASbGncsKm9o4qqrnSRlFyRoPClUlMQLReeXW8LmP3GFEYgkTHBI4l6nyQGK0bAcuFE6
	WSP0fUNhCb4+LJr3yBoOIXxHQycJLTSazvguJxqk05wZir/mflXagMBli5B2qIyFyBUizuh+ytA
	x6R/hvD8CuwjdV9MrlXd5SBe5laaojMe6kaKsVnAVpG156e5ImDtWC4dDWTYxLi8/rqivCog21p
	BU07wBzc7GK9bM8z0nluCLpGreCtON2mXn66oGmh9Cv6HRMEwECHVgnuOMdhVl26TetN8nXNbSh
	eABGK+0wZ7B7XMwjCPen1kgMny5yVP191Rb88iCB
X-Google-Smtp-Source: AGHT+IGk+A6I7OAoq2hkT7zfg8qRZRdDj/+acqwdCXLy/xduaHfnA2vl2DNhyIca9L7I2EuT+ifLQA==
X-Received: by 2002:a17:903:22cd:b0:21f:6d63:6f4f with SMTP id d9443c01a7336-220d33a5098mr127828825ad.2.1739574146613;
        Fri, 14 Feb 2025 15:02:26 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22105174c73sm1495245ad.216.2025.02.14.15.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 15:02:26 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH 3/7] builtin/send-pack.c: stop using `the_repository`
Date: Sat, 15 Feb 2025 04:27:19 +0530
Message-ID: <20250214230210.1460111-4-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/send-pack.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_send_pack()` function with `repo` set
to NULL and then early in the function, `parse_options()` call will give
the options help and exit, without having to consult much of the
configuration file. So it is safe to omit reading the config when `repo`
argument the caller gave us is NULL.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/send-pack.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 8d461008e2..737b93e4a8 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "hex.h"
@@ -151,7 +150,7 @@ static int send_pack_config(const char *k, const char *v,
 int cmd_send_pack(int argc,
 		  const char **argv,
 		  const char *prefix,
-		  struct repository *repo UNUSED)
+		  struct repository *repo)
 {
 	struct refspec rs = REFSPEC_INIT_PUSH;
 	const char *remote_name = NULL;
@@ -212,7 +211,8 @@ int cmd_send_pack(int argc,
 		OPT_END()
 	};
 
-	git_config(send_pack_config, NULL);
+	if (repo)
+		repo_config(repo, send_pack_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, send_pack_usage, 0);
 	if (argc > 0) {
 		dest = argv[0];
@@ -317,7 +317,7 @@ int cmd_send_pack(int argc,
 	set_ref_status_for_push(remote_refs, args.send_mirror,
 		args.force_update);
 
-	ret = send_pack(the_repository, &args, fd, conn, remote_refs, &extra_have);
+	ret = send_pack(repo, &args, fd, conn, remote_refs, &extra_have);
 
 	if (helper_status)
 		print_helper_status(remote_refs);
-- 
2.48.1

