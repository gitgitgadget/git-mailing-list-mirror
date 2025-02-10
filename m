Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FB225B66E
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211071; cv=none; b=qRP1wgBbWe7cxp1ENuaXavkWZhAbBmpUoG1VsGvWoSsHdIjsbhusQdQcUVmk5LZb3yRQOoUXCJk9qCD8ov16yDklOQYHZAWNHsv0CI+jDmhCOVax3oA1C2h2o023ScfHipB6YoTIz4A12eH2KNpsb4ixEsg6QHlaMQgxuGfSPvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211071; c=relaxed/simple;
	bh=zOgTXQYZIKvBiMNOoOWGdz9au7hRDl9/Vu6LWeE7LXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4Zgpdr3+j7gcPQo0rAASLiPXs0yN2N0dIkMV8XufYWMW0oLCdgsgX5b1ALxxDMswHndS/uQ7DLQ3gm6ieZ1nib1MgUqaXGNCpVkC7bwBfE93LOoVsP7JzEPaSz+9r36KEdPeVH+d7YxkpDA5p7bRMzcnfCsZbrf13dOmq+8nag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StANaWzy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StANaWzy"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f7f03d856so33061445ad.1
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 10:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739211069; x=1739815869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LExtHvwUeR+o1wx5LBgwz14cSaSG7W6ya0Jt3Vr28ls=;
        b=StANaWzy9eZmXvXJGvfrNeMO/jcxPo5H3WqID3LV1mgPhC2isCF7c4t4IStOiDzzMf
         hBBsT0pnKdrynZua8NSC2A7dz8q1eJSkNVONkIgG9BOE3vf2jaw5sBYuoVf+/8g5I9Ao
         YP4oqJ08M3lYL7OI+xItsTOsx+MSkq3/R8alTG1J6DLw6yFWPcUI8sbM9khI5bxPXEOJ
         9b4NsOe7HNkahlBtwvwesEtocO4gMMNejIaFj4/e7k8NbOgefOLCtagwZP0kbgPGuUVf
         zlAsUHtnO7J/rDxFL+ttnU4VYb31X+/eBDYHRtpcpyGdLDVunG1JbiHbATIEML5eemOW
         BFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739211069; x=1739815869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LExtHvwUeR+o1wx5LBgwz14cSaSG7W6ya0Jt3Vr28ls=;
        b=GnR4JddcJTJOBZh2MPvJ4NpGFokk37EB2azhzxK6fuxl4k93Qhxi8Lg8CKzSUyn85r
         wai2D/1b8v131a6aYuWOdrAJi3TuZDOAvXLWgCgeq1prrABGEFBRe/nV8CUx0WdB/1Ep
         1GYD8pxSDXnPLar3qLnTZLt6zDbjE4yUySiomuwZFQTbP1ZPGkaK5tzng4iEVDkuunv7
         CWOcqbp0hMsTJ6GvuQRGoDjyEmSb38j03Ucd1TT3zFKjlfIxpvtpRNrUEskA27fGcmMA
         kK2rQ1aaRxuCYOyQWk96d0yUAMgEWpyrIga0hYNUORzq5jKzz8gNwkpRpQPqftndUxOk
         Usxw==
X-Gm-Message-State: AOJu0Yy9okit3cxiBcxaU9Nf2EkIeS5mCAILns9Kdhkg5yjFc4alMObc
	O+OjAYSIfZovNWscRfmN7mr6oRLCjpCoKf6EFKRiLFLdNQytw/X3Tx+D1/Ag
X-Gm-Gg: ASbGncs7vd9SM+0hecHvc0FALRscNeXkJJtWi1qJNalKc6VrwE4jQfH1erUa4IsXlhI
	V8AEPezDY4KwJ6nlDc5y5x6HDym6FwWSAVIkcjLpG9BPphugraa4OkWIY5npJ92DLdF+GhgH4Xs
	I8961cNJ45VFLCxDZhgG1GU00s0pXqQXZdBXjKLl8TkKs/tdRaiRSP/efYqyYzeCh+UoTHiRwQB
	xWJCZFQx3E8GvptoHciro0LCA/EvthH7OI3Jiju6HeCk+Um9KgyF47YDKKiFBdqBmmW1cOpcnzl
	f3ftaNlDJ1OIHjCXC14pIu4n97gC6QrqtRORQ1zB
X-Google-Smtp-Source: AGHT+IHgzUVpHEv8QHymcDdwSkCyvoYwRuWZZJZuUXkfZAR6JIqxUzZIPdVFLg1pKQnQPV6fUsDy6w==
X-Received: by 2002:a05:6a00:882:b0:71e:6b8:2f4a with SMTP id d2e1a72fcca58-7305d47c9d1mr23627173b3a.12.1739211069093;
        Mon, 10 Feb 2025 10:11:09 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7307cf77a3asm3974540b3a.68.2025.02.10.10.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:11:08 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: ps@pks.im,
	shejialuo@gmail.com,
	johncai86@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [Outreachy][PATCH v2] builtin/update-server-info: remove the_repository global variable
Date: Mon, 10 Feb 2025 23:40:30 +0530
Message-ID: <20250210181103.3609495-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210142820.3588250-1-usmanakinyemi202@gmail.com>
References: <20250210142820.3588250-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/update-server-info.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_update_server_info()` function
with `repo` set to NULL and then early in the function, "parse_options()"
call will give the options help and exit, without having to consult much
of the configuration file. So it is safe to omit reading the config when
`repo` argument the caller gave us is NULL.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/update-server-info.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
index 47a3f0bdd9..d7467290a8 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
@@ -13,7 +12,7 @@ static const char * const update_server_info_usage[] = {
 int cmd_update_server_info(int argc,
 			   const char **argv,
 			   const char *prefix,
-			   struct repository *repo UNUSED)
+			   struct repository *repo)
 {
 	int force = 0;
 	struct option options[] = {
@@ -21,11 +20,12 @@ int cmd_update_server_info(int argc,
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	if (repo)
+		repo_config(repo, git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options,
 			     update_server_info_usage, 0);
 	if (argc > 0)
 		usage_with_options(update_server_info_usage, options);
 
-	return !!update_server_info(the_repository, force);
+	return !!update_server_info(repo, force);
 }
-- 
2.48.1

