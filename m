Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96723257420
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739214948; cv=none; b=ZeIE7v6dUrxOD8JP6fNVJ/PX3DmxuaU5ugNBAFupPrxOOxXmkFfSFOxTocQOYVn/7LyVXJ30DnXPR1uZ1OPOUUNIAiqFhL0u832YstwOqv2o/N3BNbW6lftG6DRJWViExG0Z8DvEjg9Enw2Rb8BciaAxXTI7qdx9f8DqF2zON0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739214948; c=relaxed/simple;
	bh=M3ZGKqLwRNlH1HnMEqvvYG2nVGzPEzzwPKujRnPxR/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plIXlJrbdfrt3QsGr0UDDbhU9vp2+IBMDsKKElr0qVnhBla1e/TZuBhI0WTI/Xjz6bJwy4CkUxwb5imG8SH7EtfRymgh11V2OL5apzOc6TzGFhekJF91bWUl8mgyiP6PnB4sVF7poZgtfXARQF57Mlem8mddY+SlWw5fqoNIoko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=bee4my4X; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="bee4my4X"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361f664af5so53200115e9.1
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 11:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1739214944; x=1739819744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8SFhBCAeXmdQYFE+XynSX0Rq1Q0vE/j9sWqj/YvvQs=;
        b=bee4my4Xo/fxLGqZDGsnsj08weLTsKA8wtEfZUdDXJdfw1WDRFB31eWK0qM2+MZ2Kj
         r9fJb7/SxgdhX7K+VNpMTLeGKd/E18AvDZ/hsysN8hRo1IcjwrcjcOMmxryZae2Sf2sq
         RU2QN8yOl7QH5kouizRqFVKipSA4lcHIFU0s4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739214944; x=1739819744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8SFhBCAeXmdQYFE+XynSX0Rq1Q0vE/j9sWqj/YvvQs=;
        b=Cb/WKbYn4NuP3b5pt5d9MVQ+Sn4gQ9frTHYV+BGbyFndkfKNRDxQ+M5WzI3FEh9Ys2
         NoTPBcJ+Dx3gwWag1lEnsDJWfR+qlamm5d0FB6TAGSMymhqWArwMblu08zPDZVNrPIAL
         M0DEKTF34ms7+E5bV+ZKZMEeXJnx5HOcN6hhJRv1CqrGZawhh4yhuiXCIKLa9e01/siS
         vws1T15Lax82V0/B1MLPq+H8Cx7g/2yU/NvcPWsKgDfWmVpl+sJiNPEIiph3PRQyNhzp
         uOfFDHwRls+28sU8KOpfJqPCGJmEv6rVfq3GK5+CJlBSiS91TIwX7oEmt5Zz4q0BBVo+
         9vdg==
X-Gm-Message-State: AOJu0Ywnr6Z+ym/KxeE4Le6z6JId/9xjGl6XR5+q1prL/y/DryZYBz8B
	OmMmyIvFaK8Y0X2F1bXNUoCoPhVMs1G8dHvNQyjjFzssijAI9Pp7oAHjEfRXEik9+TqfWF/1EzG
	GSs54Rg==
X-Gm-Gg: ASbGnct/P7XwPb68LZ8ubvGAwKp5pTd/lH9/nq0I95q8lJJT7p1ZXMv0i9jsYP6tk4Y
	vngaZjCnNFmTprvkK5/Vl6mSF7nOwjRhFsIZS4K+X5hFyl8C75A1cyD9/GVeuVK84pEOGgb0OUt
	EVb3UdijusHWwtkryqxbduOkJkTE8DJ50TwtBjHkx5zwwwJux5gRUCs3XWpTSOxZHlPxMLqyMX7
	jzncVswodSE1M2sGCm9cqPt3YAfoAya5HSOnJgj7Tx2rS//BYGZD1rgSHFivv3VHYZXBlqeTwGz
	FvVgVjEQrxF7qFLLXxwDU7jJCRDEaTAEQw==
X-Google-Smtp-Source: AGHT+IG7UiNp96cgaAqH4Ar2FYBsDePhpQM8YrQoyaGLqQQZtWO5EUtFvMaqK+lFbz58bwLKSZzVqA==
X-Received: by 2002:a05:6000:1848:b0:38d:d3f7:74b0 with SMTP id ffacd0b85a97d-38dd3f777acmr8078440f8f.20.1739214944483;
        Mon, 10 Feb 2025 11:15:44 -0800 (PST)
Received: from able.tailbefcf.ts.net ([91.151.136.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43946bff4d4sm30477055e9.3.2025.02.10.11.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:15:44 -0800 (PST)
From: Ivan Shapovalov <intelfx@intelfx.name>
To: git@vger.kernel.org
Cc: Ivan Shapovalov <intelfx@intelfx.name>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH 2/3] clean: rename `ignored` -> `remove_ignored`
Date: Mon, 10 Feb 2025 23:14:38 +0400
Message-ID: <20250210191504.309661-3-intelfx@intelfx.name>
X-Mailer: git-send-email 2.48.1.5.g9188e14f140
In-Reply-To: <20250210191504.309661-1-intelfx@intelfx.name>
References: <20250210191504.309661-1-intelfx@intelfx.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No behavior change.

Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>
---
 builtin/clean.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index eaddf6a06e..ec58338049 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -923,7 +923,7 @@ int cmd_clean(int argc,
 	      struct repository *repo UNUSED)
 {
 	int i, res;
-	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
+	int dry_run = 0, remove_directories = 0, quiet = 0, remove_ignored = 0;
 	int ignored_only = 0, force = 0, errors = 0, gone = 1;
 	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
 	struct strbuf abs_path = STRBUF_INIT;
@@ -942,7 +942,7 @@ int cmd_clean(int argc,
 				N_("remove whole directories")),
 		OPT_CALLBACK_F('e', "exclude", &exclude_list, N_("pattern"),
 		  N_("add <pattern> to ignore rules"), PARSE_OPT_NONEG, exclude_cb),
-		OPT_BOOL('x', NULL, &ignored, N_("remove ignored files, too")),
+		OPT_BOOL('x', NULL, &remove_ignored, N_("remove ignored files, too")),
 		OPT_BOOL('X', NULL, &ignored_only,
 				N_("remove only ignored files")),
 		OPT_END()
@@ -963,9 +963,9 @@ int cmd_clean(int argc,
 
 	dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
 
-	if (ignored && ignored_only)
+	if (remove_ignored && ignored_only)
 		die(_("options '%s' and '%s' cannot be used together"), "-x", "-X");
-	if (!ignored)
+	if (!remove_ignored)
 		setup_standard_excludes(&dir);
 	if (ignored_only)
 		dir.flags |= DIR_SHOW_IGNORED;
@@ -995,7 +995,7 @@ int cmd_clean(int argc,
 		 * recursing into a directory which is itself ignored.
 		 */
 		dir.flags |= DIR_SHOW_IGNORED_TOO;
-		if (!ignored)
+		if (!remove_ignored)
 			dir.flags |= DIR_SHOW_IGNORED_TOO_MODE_MATCHING;
 
 		/*
-- 
2.48.1.5.g9188e14f140

