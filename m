Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654C372608
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753144161; cv=none; b=b1Jqr0TOpW1W2LImVIQ9FQUlkYHcpzohK4MDbUtOsLZ6bzDkwIM1q6KOs/MhlRpHNZXYYR+sBPYxOEM/A74yAR1vIdmkFDs3UHlOt0K5qxMigZBj9u1bOIzPADjP2XMFpTlCxuLPPgKN/zjP4HZ9+PH0vNyXVdwJ+leqJhPB284=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753144161; c=relaxed/simple;
	bh=zA6uCAVfNljxy9/TUw1inx60Ed9zAaMx/qm1fXa5MbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dgZ049BP7XuTLaRkwNSF+4bYtAKkd9AicPISQv1u7IjDyHs5m9M0FRKyHeVICIsWjZrLV7YrH0Eg9rBYEPW6ACjunWswUAHOZ7YLSZW2n980VyhgnV30B9TuLI4ssgbwdguNkY+9xnkBiOnobQXBwb2qxXJCRXXs3zP83b83XJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E52r3vkG; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E52r3vkG"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5313eff2649so1261215e0c.0
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 17:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753144157; x=1753748957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBBjpIapeWnpGOlkAkq5Jx0anWQhVzVLO34EvEAlBpY=;
        b=E52r3vkGJOKE7hsPg+5eoTK5lgUcp2xelTBr/LZ05qxTlU+GHd1iWlcFRmF10ZYM7/
         uiHzURgrzoT/QTA7DwyL3MWNBuaBkOqXyUAtyC2JAfpMgRnBCDfz7/u2OfLxOTTUiFLD
         awCDA4KDYfl2bdlhAVpIQ+LA7Aa6j/O2FebSEiRna1jIsIHM8TKBRiuozWc6In6vxrcp
         EZBiv5Zk9yCc/FZqF1eDaA0hRWAacycnZyow4SVaoxqpVIuFS80ftCPJG5aPipDpKZFJ
         xcRYGsNfP7Qq+ByrRwQ0w4yxpWkolBtCPO1aNpkbplj5DAEczhXyamGg63N86C96l/ib
         BNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753144157; x=1753748957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBBjpIapeWnpGOlkAkq5Jx0anWQhVzVLO34EvEAlBpY=;
        b=Jxofav/4bcWw/zPDoql4qXj+2owv2NqlLjZFANrZAuzlHsBnPNbImYcYRsnZ3UQzeW
         S4hQb9stfZWtl0O31jZDqiF16ZeXSm7dSE0kO4YlnUAmWlUT7wqpuC7Xo1eZMSjgf94f
         srMSAtYjdcE9nqy/1HsguveC1k+RV9JSxhzVLRwdEtDL6dR6ZK382/i5OapSfv7MYVRz
         1lxxmAyMkphJof+4L11p9Pr7x2LVMACrJe0InXdQ+oGypNQA/jgHLRNGAKMrRZQ0RiWv
         BcT4zJRZiziU14NT3OrGG7rOqBl5uuWfhUyE5tBh5NDSry86onvDIL5F+wcumJWN17yM
         M+cA==
X-Gm-Message-State: AOJu0Yw+L8WERpIFbxAGYHMwng3jjraCphRZnkZdaZP2r6fmvSYo5/Aw
	9iRCnWPZ5aI1iKv00HASmlHMpd9IM2Q9ojReNSyulloYDld1WzDdCWbhV6Jj2w==
X-Gm-Gg: ASbGnctWbhQt87klTUAbBrlN1zd1O0Hn2fF3VkMb+zDnUaNZB5VGQWfrcZwE8aM7zgq
	H3htBTooCeyJqW7U16eF4foKTWNmf3by+hrjRUNc1KcXMbKykS0x56T5tJYCnuz+DVlFRpFNslP
	CRtCy0MhIme4GlVtgLoUL21vlKZFwRt27SFevoSLSEF3agVHR7LCxeK+bteVXWHsQleiBIC4PKA
	2N2xKTeg2E1pCEgau8vlQzZwzANwh31n5lLA+fo8ZweClpaiNNMH3vbY0e01bdnGZFs8fK+ecgn
	0RN7+vqCdyM+BuIscGJW9nmxoPxB/VsZtThiOWmTuVFBc6PLkgIE3QLSy+2oxcNFePzZpCNOhAm
	CN4LHb7MN5NCkPYA/h8SpLrGvb/g/c0FUNMPL+5k5aezSsl0x5zPO4Po=
X-Google-Smtp-Source: AGHT+IErqeT5fPDjwyQw+kI64BHOlyxf4LSSrsbaDj0Ni8S0jQJlM5DPvL6VIHY3AR0vzk8kEFemmA==
X-Received: by 2002:a05:6102:4420:b0:4e2:aafe:1bde with SMTP id ada2fe7eead31-4f95f2aa5b6mr10749095137.9.1753144157038;
        Mon, 21 Jul 2025 17:29:17 -0700 (PDT)
Received: from localhost.localdomain ([179.113.63.169])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b0ad603easm3344169241.16.2025.07.21.17.29.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Jul 2025 17:29:16 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de,
	ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v5 2/5] repo: add the field references.format
Date: Mon, 21 Jul 2025 21:28:32 -0300
Message-Id: <20250722002835.33428-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250722002835.33428-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit is part of the series that introduces the new subcommand
git-repo-info.

The flag `--show-ref-format` from git-rev-parse is used for retrieving
the reference format (i.e. `files` or `reftable`). This way, it is
used for querying repository metadata, fitting in the purpose of
git-repo-info.

Then, add a new field `references.format` to the repo-info subcommand
containing that information.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc |  4 ++
 builtin/repo.c              | 75 ++++++++++++++++++++++++++++++++++++-
 t/meson.build               |  1 +
 t/t1900-repo.sh             | 50 +++++++++++++++++++++++++
 4 files changed, 128 insertions(+), 2 deletions(-)
 create mode 100755 t/t1900-repo.sh

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index caee7d8aef..cf8483ec49 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -29,6 +29,10 @@ INFO KEYS
 The set of data that `git repo` can return is grouped into the following
 categories:
 
+`references`::
+Reference-related data:
+* `format`: the reference storage format
+
 SEE ALSO
 --------
 linkgit:git-rev-parse[1]
diff --git a/builtin/repo.c b/builtin/repo.c
index d4f01e35e2..5beae0f781 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -1,12 +1,83 @@
 #include "builtin.h"
 #include "parse-options.h"
+#include "refs.h"
 
-static int repo_info(int argc UNUSED, const char **argv UNUSED,
-		     const char *prefix UNUSED, struct repository *repo UNUSED)
+typedef const char *get_value_fn(struct repository *repo);
+
+struct field {
+	const char *key;
+	get_value_fn *add_field_callback;
+};
+
+static const char *get_references_format(struct repository *repo)
+{
+	return ref_storage_format_to_name(repo->ref_storage_format);
+}
+
+/* repo_info_fields keys should be in lexicographical order */
+static const struct field repo_info_fields[] = {
+	{ "references.format", get_references_format },
+};
+
+static int repo_info_fields_cmp(const void *va, const void *vb)
+{
+	const struct field *a = va;
+	const struct field *b = vb;
+
+	return strcmp(a->key, b->key);
+}
+
+static get_value_fn *get_value_callback(const char *key)
 {
+	const struct field search_key = { key, NULL };
+	const struct field *found = bsearch(&search_key, repo_info_fields,
+					    ARRAY_SIZE(repo_info_fields),
+					    sizeof(struct field),
+					    repo_info_fields_cmp);
+	return found ? found->add_field_callback : NULL;
+}
+
+static int qsort_strcmp(const void *va, const void *vb)
+{
+	const char *a = *(const char **)va;
+	const char *b = *(const char **)vb;
+
+	return strcmp(a, b);
+}
+
+static int print_fields(int argc, const char **argv, struct repository *repo)
+{
+	const char *last = "";
+
+	QSORT(argv, argc, qsort_strcmp);
+
+	for (int i = 0; i < argc; i++) {
+		get_value_fn *callback;
+		const char *key = argv[i];
+		const char *value;
+
+		if (!strcmp(key, last))
+			continue;
+
+		callback = get_value_callback(key);
+
+		if (!callback)
+			return error("key %s not found", key);
+
+		value = callback(repo);
+		printf("%s=%s\n", key, value);
+		last = key;
+	}
+
 	return 0;
 }
 
+static int repo_info(int argc, const char **argv, const char *prefix UNUSED,
+		     struct repository *repo)
+{
+	return print_fields(argc - 1, argv + 1, repo);
+}
+
 int cmd_repo(int argc, const char **argv, const char *prefix,
 	     struct repository *repo)
 {
diff --git a/t/meson.build b/t/meson.build
index 1af289425d..8693e6abc4 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -245,6 +245,7 @@ integration_tests = [
   't1700-split-index.sh',
   't1701-racy-split-index.sh',
   't1800-hook.sh',
+  't1900-repo.sh',
   't2000-conflict-when-checking-files-out.sh',
   't2002-checkout-cache-u.sh',
   't2003-checkout-cache-mkdir.sh',
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
new file mode 100755
index 0000000000..f072c7c67b
--- /dev/null
+++ b/t/t1900-repo.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='test git repo-info'
+
+. ./test-lib.sh
+
+# Test if a field is correctly returned in the null-terminated format
+#
+# Usage: test_repo_info <label> <init command> <key> <expected value>
+#
+# Arguments:
+#   label: the label of the test
+#   init command: a command that creates a repository called 'repo', configured
+#      accordingly to what is being tested
+#   key: the key of the field that is being tested
+#   expected value: the value that the field should contain
+test_repo_info () {
+	label=$1
+	init_command=$2
+	key=$3
+	expected_value=$4
+
+	test_expect_success "$label" '
+		test_when_finished "rm -rf repo" &&
+		eval "$init_command" &&
+		echo "$expected_value" >expected &&
+		git -C repo repo info "$key" >output &&
+		cut -d "=" -f 2 <output >actual &&
+		test_cmp expected actual
+	'
+}
+
+test_repo_info 'ref format files is retrieved correctly' '
+	git init --ref-format=files repo' 'references.format' 'files'
+
+test_repo_info 'ref format reftable is retrieved correctly' '
+	git init --ref-format=reftable repo' 'references.format' 'reftable'
+
+test_expect_success "only one value is returned if the same key is requested twice" '
+	test_when_finished "rm -f expected_key expected_value actual_key actual_value output" &&
+	echo "references.format" >expected_key &&
+	git rev-parse --show-ref-format >expected_value &&
+	git repo info references.format references.format >output &&
+	cut -d "=" -f 1 <output >actual_key &&
+	cut -d "=" -f 2 <output >actual_value &&
+        test_cmp expected_key actual_key &&
+        test_cmp expected_value actual_value
+'
+
+test_done
-- 
2.39.5 (Apple Git-154)

