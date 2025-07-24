Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC412EA478
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370678; cv=none; b=apwVpOKYVwP04nK8Gda5/OiZMJtGM+Kt362UWXiswrUSiO5fIPJSL/vBBwIHF6AkVZfqM80bgaslnEEw9pUQl9by105FJytVCdqKVzVdzH3AqUEPAVqQvRXF8LgCWDiOTa9UVkpwpuNDD7tRiOuUfl9EQEgMYzNc9cpCHb3hJfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370678; c=relaxed/simple;
	bh=4+o5aRuDTt+v6gUaY8xxZGggSg4XBy1ZPIk3Za7bbUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+QpesGN0RxRHFx4QCvIHd7i8UnG4Vx7tFxGV5/SpSfsaIunZLMcBfPT3+G25v0nC/RhIR8hQ2xYux2tWEmYxPjJra9HTeZ5mKdTBaKMerFE5Snmeveym8/OFD8xrZAI3OcwSSlrRiVeMuZS9xut/krfO60G3bCPUmDtyQTezZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAiq1q0q; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAiq1q0q"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-75ce780af03so1094739b3a.2
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 08:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753370675; x=1753975475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXofcNxEDJMyi1q8JdZirA1wL9yDZBpW8UQMPqOMqwA=;
        b=QAiq1q0qs+0mCpb0sWOnSfsnX3Z2gFp4BQRNDb8skA4Fczj9g1e3SnifNjGAt6Poc4
         J9J7LYOwXATP2KG6ZGBaDLPRLSQYkuQsKgk9cF518fw+48pimlD8Qahf5A80AD6AyO0w
         bStaw1n92MDD0oBAJ16xQEnogtIpizGRu2TDpqn5heH/UAgVCwYVrAMQUeGz9/YwQHad
         QXEEPh8ecl0wQ0S82uPQb893cNMZbF5yn+rgTNaTQK2Q21Fb86wY2nCaL5J0rnvbL7dz
         wjr68xNEeEl9DOQEaQbqQT8SqATdg+hHnhOelPLLKpcjuqLMtgYnLBt01T+aNcJXwMnp
         LCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753370675; x=1753975475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXofcNxEDJMyi1q8JdZirA1wL9yDZBpW8UQMPqOMqwA=;
        b=tWCEwMYX8DO/wmOWm8rer1HFLE2usLKJ5yzNTdarFj359E2dvnD+++f8PzaJKxPL0k
         SmXTvDSrKNCSyLdUXIKUHBxWsJEu0f5JJD8V9zPF8d71h9NEwWzb1HbeWWwiRW8TdtzI
         uw/8mhVbc3LV1pvcEN8DV8Dl/s6/e+KoAt7OL6zCkQC3JYvMnjEKyBDmBV09qDhQpMrt
         5B4HQ6o7Dx/Z75AWvYJt9OIILOzArFVi5RK6QZOs3LwXeS3tmY1BnKHTSB9gQhHcNbjs
         VBzT9YBao9SsiwTpOiiXFWBZ6t/kX/sVDclGy/u1Vd0hELtbDU1qfUT/TR41JPJo92Sw
         7Tiw==
X-Gm-Message-State: AOJu0Yz9RQ3McehxM73HCLEPCFVUOCW8nvKhqmTT8rb3FycGJ3iODEaK
	rY1m0QuzLS5L0AS+dfSku+L82AkIcc2VxJvBCmlxt5zCSe8ngPulslBwRshu+w==
X-Gm-Gg: ASbGnctSe3+PftJsXovLY5BcZ1BVU6+ZE5ggT92T9+HCNM29dQxClHRBQJhJN4nSmoz
	qbwJQf2OfQVYpdOrDrAK+4tSZsVOSMkbx4s27MMTYqdEdQq+nMahmw8I84ECd9T8gLqRHdA8ZqL
	q+cZ6lMxOzcFD9Bx4gMXS4Ljzj+07GTNkTm86jkqwcQlAtgt4c11qAhBmTWI8GJsNvJdWcsk+FO
	sy3rZ1kjunS1QH0Ptu0U2eNztyiOjGJqQqqBDLXHVpi955Ekw6CKoqPo9y9+Bkvwk7l3zFYIKp2
	DazoziLbdyBRtGSujnqJGnivceiI/29aElvRMxuA3VXCQcSVavNqjje7b9yUMOlDn67cXWpHFte
	+DL1+LDJ0UmgNLsDEbNvWX6V/wdVKtrYNlRCOhcL0BF+mJQ==
X-Google-Smtp-Source: AGHT+IG2bUVOitxWH0Dm11fGmm0+bkAKph+D1oax5u6m43wSwbH512CoBjWhNhpcyJ0dSvPLMAUKSA==
X-Received: by 2002:a05:6a00:a1c:b0:748:eedb:902a with SMTP id d2e1a72fcca58-760353f328fmr9721777b3a.17.1753370674367;
        Thu, 24 Jul 2025 08:24:34 -0700 (PDT)
Received: from fedora ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761ae63df65sm1917849b3a.63.2025.07.24.08.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 08:24:34 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [PATCH 1/2] submodule: prevent overwriting .gitmodules on path reuse
Date: Thu, 24 Jul 2025 20:54:17 +0530
Message-ID: <20250724152418.45226-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.50.GIT
In-Reply-To: <20250724152418.45226-1-jayatheerthkulkarni2005@gmail.com>
References: <20250724152418.45226-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding a submodule at a path that previously hosted
another submodule (e.g., 'child') reuses the submodule
name derived from the path. If the original submodule
was only moved (e.g., to 'child_old') and not renamed,
this silently overwrites its configuration in .gitmodules.

This behavior loses user configuration and causes
confusion when the original submodule is expected
to remain intact. It assumes that the path-derived
name is always safe to reuse, even though the name
might still be in use elsewhere in the repository.

Teach module_add() to check if the computed submodule
name already exists in the repository's submodule config,
and if so, refuse the operation unless the user explicitly
renames the submodule or uses the --force option,
which will automatically generate a unique name by
appending a number (e.g., child1).

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-submodule.adoc |  7 +++++++
 builtin/submodule--helper.c      | 27 +++++++++++++++++++++++++++
 t/t7400-submodule-basic.sh       | 22 ++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
index 87d8e0f0c5..503c84a200 100644
--- a/Documentation/git-submodule.adoc
+++ b/Documentation/git-submodule.adoc
@@ -307,6 +307,13 @@ OPTIONS
 --force::
 	This option is only valid for add, deinit and update commands.
 	When running add, allow adding an otherwise ignored submodule path.
+	This option is also used to bypass a check that the submodule's name
+	is not already in use. By default, 'git submodule add' will fail if
+	the proposed name (which is derived from the path) is already registered
+	for another submodule in the repository. Using '--force' allows the command
+	to proceed by automatically generating a unique name by appending a number
+	to the conflicting name (e.g., if a submodule named 'child' exists, it will
+	try 'child1', and so on).
 	When running deinit the submodule working trees will be removed even
 	if they contain local changes.
 	When running update (only effective with the checkout procedure),
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d8a6fa47e5..b4f5d6e26a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3423,6 +3423,10 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	struct add_data add_data = ADD_DATA_INIT;
 	const char *ref_storage_format = NULL;
 	char *to_free = NULL;
+	const struct submodule *existing;
+	struct strbuf buf = STRBUF_INIT;
+	int i;
+	char *sm_name_to_free = NULL;
 	struct option options[] = {
 		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
 			   N_("branch of repository to add as submodule")),
@@ -3525,6 +3529,28 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	if(!add_data.sm_name)
 		add_data.sm_name = add_data.sm_path;
 
+	existing = submodule_from_name(the_repository,
+					null_oid(the_hash_algo),
+					add_data.sm_name);
+	
+	if (existing && strcmp(existing->path, add_data.sm_path)) {
+		if (!force) {
+			die(_("submodule name '%s' already used for path '%s'"),
+			add_data.sm_name, existing->path);
+		}
+		/* --force: build <name><n> until unique */
+		for (i = 1; ; i++) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "%s%d", add_data.sm_name, i);
+			if (!submodule_from_name(the_repository,
+						null_oid(the_hash_algo),
+						buf.buf)) {
+				break;
+			}
+		}
+		add_data.sm_name = sm_name_to_free = strbuf_detach(&buf, NULL);
+	}
+
 	if (check_submodule_name(add_data.sm_name))
 		die(_("'%s' is not a valid submodule name"), add_data.sm_name);
 
@@ -3540,6 +3566,7 @@ static int module_add(int argc, const char **argv, const char *prefix,
 
 	ret = 0;
 cleanup:
+	free(sm_name_to_free);
 	free(add_data.sm_path);
 	free(to_free);
 	strbuf_release(&sb);
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index d6a501d453..6812df3081 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1482,4 +1482,26 @@ test_expect_success '`submodule init` and `init.templateDir`' '
 	)
 '
 
+test_expect_success 'submodule add fails when name is reused' '
+	git init test-submodule &&
+	(
+		cd test-submodule &&
+		git commit --allow-empty -m init &&
+
+		git init ../child-origin &&
+		git -C ../child-origin commit --allow-empty -m init &&
+
+		git submodule add ../child-origin child &&
+		git commit -m "Add submodule child" &&
+
+		git mv child child_old &&
+		git commit -m "Move child to child_old" &&
+
+		# Now adding a *new* repo at the old name must fail
+		git init ../child2-origin &&
+		git -C ../child2-origin commit --allow-empty -m init &&
+		test_must_fail git submodule add ../child2-origin child
+	)
+'
+
 test_done
-- 
2.50.GIT

