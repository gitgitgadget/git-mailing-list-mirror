Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780F72528E6
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739197709; cv=none; b=f9sowJyyjh+9Fq1BBXANC8Gc5y0cDWhK61elnpA9hSURbIS3mB7/FvY1Tpf5N0mEvXqBH2de+dnYbhhxEN5cL4pvcKb49KCbBPgcFe7Fks9cM46RG2+pMdNOFmluEVGL+W9MKrJ2J8YBoymKeAuMk5+mxmN/gg1EzMr0gpdKzQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739197709; c=relaxed/simple;
	bh=JuVBvcfEUx0kSGTY2Z10wL6xXqiiB1iWYsmgEqZytQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DFVRH7P3fYRVHUe4JEWrZcY/ueQLzYjywcnGfyM1vUhrRW359QqQHGNRwGL62H/o2xwZW1Z8h+pnELLNuhDPrn0ofaGBzwK71QeqCIdyLxm60nS4H+9AxYhz3kRKIo8VSsLXAO+degXC/3MH9B0RdXTaLmI8X3V+rzHPsG8G+5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLJTbCwN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLJTbCwN"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f464b9a27so71865965ad.1
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 06:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739197706; x=1739802506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0qXPNdCu7RzNZlwAky/vZr2OHKBIZFrnnDOpKgPK2cQ=;
        b=nLJTbCwN9lRkdo+z4gLSwtTdN4i6VbiB+MKNYu+XREnI5lxZL++VgK8xMJB3rFmNzx
         S9jNRiSejrXZc9VYMrXUmkEbwdOEhy416pqyAQvswvx+eXnjYijdyupNS2NEn/3EJn1J
         O2BD93OJyKUTGoQ1fLDkCESdywtMOwAtn6+i2xBNlhZoV7hCPV2mPsvP3615FTiVlyFg
         5mYaioh64bC/P/ss6MaBgZE7VBYPthR6QgHKBgQQX/aPaBKGLhEZ0gKe0QbDa+CWzgrO
         aPAfNypQgHa/gQHSaSwLphXeGxYNCcDQL894ki79C6Xx2cmMZa+E+tD+1Qx61da+VuXO
         pi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739197706; x=1739802506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qXPNdCu7RzNZlwAky/vZr2OHKBIZFrnnDOpKgPK2cQ=;
        b=eQQWnCjwkg3UDHZHIyhiY5Y/kLLVi1Bf4j0+bfhn2THSUKjCRgPeLQi2NgWe5Fx6vb
         w4cfA8YIRFSCbCeXCHKnLWvASIiqpHVFPQZ1/xJWQD5oeTJEkKxEIWP9Ij46tnN1UF9n
         a6wJlQhOE8BLZOOUFY6qlHhGly+R0AWkY8f62NsLYEmfg+nRknJHSPQqt8zwaXM7DOLZ
         mo6IE2dsNmFJKs3gChIo4LVpB1JVKiG7MZX7NizL0w75AjUQ+Bp6WX+tv0lYfoW0E0xH
         9IydN5UK29stJqzbt4hFtIb4yvvXol3Yo0JKLOKrrC6ZVANiWSBsd3kT9O0sCcUjCUpK
         qUIQ==
X-Gm-Message-State: AOJu0YzJovlFhVx+8xNswbEP8mg0ZgwwZ/wKJ4IOkQmqCXiU6ZjkEaBA
	aD1viA3HjOtgRoDNVLrSOl/o5nZSJX66l/lzXPl+uLOxBQUKtZDQfWYyc6l9
X-Gm-Gg: ASbGncuaei3PdJ6cAmrDTbsSpNY/Um4Y4hmGWSVaVuFhMWlKvOqoIhjsbbgBQAwsPtm
	6l3Tmzjlm6/P+CbVhvo/SCd/wBPWekir8cXaKI7tlkURRMqupkQvk4P5SAgxLJH0XiaaKShCN/Z
	qxsqdlmdIgS7CZSvGd47J+cCxs77ePrNudlW5g7eYDzaIZjPHeJSGaVhVW5etm15sttkGFUMBwP
	5A1ptiY2eSXmCUeolpdnkjSUjgk/wXrm0OKg45awRIxxHhcPTmZv6qJTYFjxsjldklf57P5gPYj
	ZZsK3H3/iVv/dUXBfRxL9TA0CaKoQZXBUSIH0YuO
X-Google-Smtp-Source: AGHT+IGY1R6uARwr6/4tcCBZ5VrnajEydWKfjvR303UuTmG/leiGLai2mIXk4XrykGN7+A2U5XH7KA==
X-Received: by 2002:a17:903:1c8:b0:210:fce4:11ec with SMTP id d9443c01a7336-21f4e1cb33emr200796575ad.1.1739197706122;
        Mon, 10 Feb 2025 06:28:26 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad558af9ae2sm1284589a12.54.2025.02.10.06.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 06:28:25 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: ps@pks.im,
	shejialuo@gmail.com,
	johncai86@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [Outreachy][PATCH] builtin/update-server-info: remove the_repository global variable
Date: Mon, 10 Feb 2025 19:58:10 +0530
Message-ID: <20250210142820.3588250-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/upload-server-info.c".

The RUN_SETUP macro is used in "git.c" when the 'update-server-info'
command is wired to the 'cmd_update_server_info()' function."
This means we can be sure that the `run_builtin()` function inside
"git.c" will always pass a valid `repo` variable to `cmd_update_server_info()`
when the `update-server-info` command is run inside a Git repository.

When the command is run outside a Git repository without the `-h`
option, the command will fail (`die`) inside the `run_builtin()` function
when the `setup_git_directory()` is called. So, the `cmd_update_server_info()`
would not be called at all. When `-h` is passed to the command outside a
Git repository, the `run_builtin()` will call the `cmd_update_server_info()`
function with `repo` set as NULL.

It is certain that the `update_server_info()` function would not be
called when the `repo` config is `NULL` since this only happens when the
`-h` option is used and the command would exit with code 129 before
getting to the `update_server_info()` function inside the
`usage_with_options()` function.

To prevent accessing a `NULL` value `repo`, it is necessary to check if
the `repo` has a valid value before calling the `repo_config` option
inside "update-server-info.c" since it comes before the
`usage_with_options()` function.

So, this change is safe and would not lead to any breakage.

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

