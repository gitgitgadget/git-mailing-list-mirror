Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DE633DF
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390561; cv=none; b=NMgobBz452LBi2yKmBbcIIe4MGdJ5TP4fKVSbBp4MVPjmzTizqUmrpl+IaTmXVYjHmpx2SshDxAziXNYjQIo/XxyRd17six1FJxEfZjn9po5mkXshS4eEaJXhdfCgb+pb+EGJ3rOk8dxBx7gb/cQhjdVW5xnYl/2kjV7BCj6iNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390561; c=relaxed/simple;
	bh=U6cmTbxV4tCdvBmncexg+swheF19OVuQ+W1ra8DB9vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpJp4IuNLs8J065q8Vkbk+HmuiyFbvgu/IqkQV4ztN189CUIGkOqO9eHPufKPqnAqM94Q6hxPd3FP6EeURXbGFli66bDWSJBKrZWPNJSGwZx65bSLGVVVOMJ04U/PHIHd1IQsGCWqc5wG2nqzH9QBfw2yaPcSeDqifAEzI5s6T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1hdlVe4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1hdlVe4"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2240b4de12bso23619645ad.2
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 15:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390559; x=1741995359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzH0GxcUvPZP2/UeP0dJFg2sRLWgXweOioqvjIfY+08=;
        b=S1hdlVe4qkiFpNN7Z7tT8q2i8N7+hGN8FSOZUzsp2KuvEUCYRZsBYZ7JW8/ywA3Z1a
         whUVqcRfhwRBIw6kDWRMHZ/9ioWDAWoH+S1YaFAO2fHHJ/euFpfOxNmeIwk8ltbLYWQE
         uLea2UojUkVY7A5DHjNyLCYXaSiYiuXILr+2LsFI4jKq7CkSlHfAKCOpeFd/8JwMS7W6
         X9YA/xC85VgWWplOMP33OMrj/helXGN0VTcFSDRlS1EvnWfaSFuyTA1NmvC9zncneMxN
         DYxO/ogyPCFd9qBpi9BHZ1PIs8R3g9yksxMFa9TxypQ3aT3OC6buwTUpG5K6c5+OYEro
         h9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390559; x=1741995359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzH0GxcUvPZP2/UeP0dJFg2sRLWgXweOioqvjIfY+08=;
        b=Fy5D8BFw8iXRYLassyShulx00/WN36qBLYhlqXNJEejWrVIUYgLSapasA+gvXygAaA
         IFDsmBX7y0BKdcg+P4g1wULHY8vzYGaJAGhVmnbNsJmh7HdvRDblLxmk6fT224pCR7ht
         d0p7OLmKsmZj/eRMpSnqCm+txiCT16ZV+4w5eoQoOXlwQVK0Lx/VV9ni1xq88dIr3QrT
         0ph3O383eENPTptbjSBWz/OjqfPkaR/fHkvUGYYucrGs+s9DtoBFVDzwc4MogOcrxEyh
         nwOBQq7rEKdNXzfgvx19dNHpvPPDRnXHUffkmXwysTkfqScUnmXqnjwCwMYFif0Fq+iK
         7qzw==
X-Gm-Message-State: AOJu0YyL1zB+bCU/jMmo3bv9QwHshdkfuZ4biMdlYN20e6AqfI43Qz4i
	nI3cZHgik1lwgbRMAXb/RS2FxK/0ArT1COnzvzvRj9W0CQ2R0pFeCPjRpEHsQOI=
X-Gm-Gg: ASbGncuiORv9gu06g1q6y8PP4iMWSZOEij1GZVP46zOZITVzJsryMqu0GDdzpIAVIsc
	Ao2lfJ0XpvwqcvOmwsk0ID48mmpWbRENzYJSuwSwdN/RPDYkWNp5pNbu0e3xq0L5k90WB56SB3x
	M/H7g+nYckBx3UFQaA+wFo52e53Ogy3XJL7Uaz+8FRw42yA+/+OU4VQ29TIamv5oA0EPeGN5nHb
	bQHSLWZKXJA9OvPc9+W8QUUOO06I6RpQihotahPZeAzXW7MnabKFhz5E7pcHl4tiBWbDzujvWaX
	5GN9fc5Ddr6k/rf4GY8qKI4gH+TW4EMRBvZ8EJlsTYb1NMMvta0+qAKPLKW/eejgufCd0Q==
X-Google-Smtp-Source: AGHT+IFREfuW3WgdtUyIbWfKFzWk/RP6oWrLjot0vjzzygvCHkvWUd75iHecBDy7xp2OB7Cmpv/NBw==
X-Received: by 2002:a17:903:32ce:b0:224:1acc:14db with SMTP id d9443c01a7336-22428993912mr82522345ad.29.1741390558836;
        Fri, 07 Mar 2025 15:35:58 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736bcb8de04sm423880b3a.154.2025.03.07.15.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:35:58 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	phillip.wood123@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 3/8] builtin/verify-commit: stop using `the_repository`
Date: Sat,  8 Mar 2025 05:05:02 +0530
Message-ID: <20250307233543.1721552-4-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307233543.1721552-1-usmanakinyemi202@gmail.com>
References: <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
 <20250307233543.1721552-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/verify-commit.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_verify_commit()` function with `repo`
set to NULL and then early in the function, `parse_options()` call will
give the options help and exit.

Pass the repository available in the calling context to `verify_commit()`
to remove it's dependency on the global `the_repository` variable.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/verify-commit.c  | 13 ++++++-------
 t/t7510-signed-commit.sh |  7 +++++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 779b7988ca..5f749a30da 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -5,7 +5,6 @@
  *
  * Based on git-verify-tag
  */
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
@@ -33,15 +32,15 @@ static int run_gpg_verify(struct commit *commit, unsigned flags)
 	return ret;
 }
 
-static int verify_commit(const char *name, unsigned flags)
+static int verify_commit(struct repository *repo, const char *name, unsigned flags)
 {
 	struct object_id oid;
 	struct object *obj;
 
-	if (repo_get_oid(the_repository, name, &oid))
+	if (repo_get_oid(repo, name, &oid))
 		return error("commit '%s' not found.", name);
 
-	obj = parse_object(the_repository, &oid);
+	obj = parse_object(repo, &oid);
 	if (!obj)
 		return error("%s: unable to read file.", name);
 	if (obj->type != OBJ_COMMIT)
@@ -54,7 +53,7 @@ static int verify_commit(const char *name, unsigned flags)
 int cmd_verify_commit(int argc,
 		      const char **argv,
 		      const char *prefix,
-		      struct repository *repo UNUSED)
+		      struct repository *repo)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	unsigned flags = 0;
@@ -64,7 +63,7 @@ int cmd_verify_commit(int argc,
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, verify_commit_options,
 			     verify_commit_usage, PARSE_OPT_KEEP_ARGV0);
@@ -78,7 +77,7 @@ int cmd_verify_commit(int argc,
 	 * was received in the process of writing the gpg input: */
 	signal(SIGPIPE, SIG_IGN);
 	while (i < argc)
-		if (verify_commit(argv[i++], flags))
+		if (verify_commit(repo, argv[i++], flags))
 			had_error = 1;
 	return had_error;
 }
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 0d2dd29fe6..39677e859a 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -8,6 +8,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
+test_expect_success GPG 'verify-commit does not crash with -h' '
+	test_expect_code 129 git verify-commit -h >usage &&
+	test_grep "[Uu]sage: git verify-commit " usage &&
+	test_expect_code 129 nongit git verify-commit -h >usage &&
+	test_grep "[Uu]sage: git verify-commit " usage
+'
+
 test_expect_success GPG 'create signed commits' '
 	test_oid_cache <<-\EOF &&
 	header sha1:gpgsig
-- 
2.48.1

