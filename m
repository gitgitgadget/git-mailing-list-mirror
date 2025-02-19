Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6E81E04BF
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997251; cv=none; b=gie/CYuF2+5+u3fU9TY1PnO5lP8kv4/qz2u0eVEi2rm5tmK/jLNpIBPDUd/tgNfY+ixAgwu4a3EHbJVf1eH7xU9pYej1HQMNOjQgNSM+ihycvhI75maQGlsAfjMP4rXpZX7OUHjKuPdgqvpWbSk3OI5PQWXcF6RHi8lYAOr19IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997251; c=relaxed/simple;
	bh=kLPDFj4Ia9yzff1Oef1rinDP52YX/HKHujSIIM0fook=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PW6YbuNOmnsE26ycia9v5qux/y9WS0sSG3yz6HlKrsSXNCccP0AvS8tY1W+AtSWGr+Kkt2JthIA4PLxXdQcIOoRYcgd2SifBp9l60lRcdBBl1UhBspZJM2cUwW9LH/wD2pLzr3sjndMivNm0NrkhNQ00tzenFhM/Q8Os/l+mFLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPiSMQ/R; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPiSMQ/R"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22113560c57so2661625ad.2
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 12:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739997249; x=1740602049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgSa/y+E/WevQ5WW9AJboIU3q8WEJMd2/SdLJ8g4mGs=;
        b=UPiSMQ/RwSe9rzmbbqmaM+CBxrfFlmtcSxIMFuvBgUOStsGeFL06NhnjTkTawwnhcn
         3JUMVKoWpO9UriVp4dnqMcp/lUMuRB9TLWYNGPIuEbx6+Pziln10d8TYGe9XAnWlEgiV
         /kg1Bj0jxiGTEkV9BbZa/UCs1VLXC5kzbVdi4zCkpt2+cEKsAQ9n4RlSLTKfFTTyNgni
         2jZIeyQfpdU6zC9J6O7a0CgD5464T7zju6ftMsVx9v0PqiDvj4N8U8CXZulgyUGpOyLL
         hzD/e0Da6XXpRhkw7bEATldyGiRstFVLbAWKh8yZyzFDNgCv2k7M/MOY8G9FZvQb+0fS
         jcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997249; x=1740602049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgSa/y+E/WevQ5WW9AJboIU3q8WEJMd2/SdLJ8g4mGs=;
        b=iCPiDo90pnUK+Fp1KGwO2ay3LLi+5fW9fs5wDm7jyLRC9uu9V/449MsU1yuFeYnUL1
         cj1Kwqn/fO2GSxhGRRemNGNABcZZAabO57CK/naceJx2Bum6f+CDmW08Cbr1YpEkuDAc
         cPoblqLGiH4oym2nUnR0Q2MQbtb6NGjkxfyqjzG+6dg6kZ8tYWvHDoaM5kM6QxdbJcbg
         0WB9aDynqJVVfNT3W1tFSyNEL5zqHNS6IP9O+HGU+OOoXE2WVX0H2a7LX0B5KP7bs5L5
         AZJ1/XnG+qAoMZMxQgMab5C5ecrstglyKaaNAaZIazqVshPyRKN+kLjpAlSPqJuAD+jy
         h2VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXmS1m9sqfraqn6uGdDHQ1tzmFJN5m4W8DCCg39xjUnVnxoWPCTr2AlrIz8thjRRa0vj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHz38EZ2sHLAMTRRITA9HZFkClmh/TSwIQETNhnBPeNBAhyO9C
	Ecgx6J81TS0j7kMqhTXQxIwl0HLrhP4yAIwi8IZl+cm9CMyq+gGz
X-Gm-Gg: ASbGncv8zXNP61XZirCYN5CFpUdzzecQPQdxC5jaRMcyHkOBnVaESTNWCs7W/3Q8NYA
	CR3bAvVwvYAXKyxvA2t7n6gNfIwMnuWNh4Vcg3UPTDlRNpwTclm/g2NsgintRYIDaVBMIUa7fwH
	fgj0RiwMmkox5pn5U4hP7DrwfXyRejIdFnctTgfSYUhkrhrhJCVez2DojATmg+6VXySmhFzYnqP
	qjx1lOK9q9Bqt3kCze2WW5kTCaGJrkqL267pgLN+RlJMkSrFKjIjsjvA5yaGkUaX0qkBcmg2bMR
	QjeD3NB8KvqhkBiydO87tgAd5T4yMjti1KQlE38o
X-Google-Smtp-Source: AGHT+IGOgzbYzhleAIMZAMmec0OE5FwOFnVdvdrMYm1lxjFTWHAD/dLLJFdAQJwXf/440KaFsBZKZA==
X-Received: by 2002:a17:902:e80b:b0:220:cd9a:a167 with SMTP id d9443c01a7336-22103ef5284mr332296635ad.4.1739997248732;
        Wed, 19 Feb 2025 12:34:08 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53499dasm107791355ad.12.2025.02.19.12.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:34:08 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: gitster@pobox.com,
	christian.couder@gmail.com,
	git@vger.kernel.org
Cc: me@ttaylorr.com,
	chriscool@tuxfamily.org,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH v2 04/12] builtin/verify-commit: stop using `the_repository`
Date: Thu, 20 Feb 2025 02:02:52 +0530
Message-ID: <20250219203349.787173-5-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
 <20250219203349.787173-1-usmanakinyemi202@gmail.com>
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
give the options help and exit, without having to consult much of the
configuration file.

Pass the repository available in the calling context to `verify_commit()`
to remove it's dependency on the global `the_repository` variable.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/verify-commit.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index ae0c625777..037032d15c 100644
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
@@ -72,13 +71,13 @@ int cmd_verify_commit(int argc,
 	if (verbose)
 		flags |= GPG_VERIFY_VERBOSE;
 
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 
 	/* sometimes the program was terminated because this signal
 	 * was received in the process of writing the gpg input: */
 	signal(SIGPIPE, SIG_IGN);
 	while (i < argc)
-		if (verify_commit(argv[i++], flags))
+		if (verify_commit(repo, argv[i++], flags))
 			had_error = 1;
 	return had_error;
 }
-- 
2.48.1

