Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95BB39734A
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289060; cv=none; b=uVEM6eqcqnwcyCAviedgAjr62m8jSTEA//28DA6V1OrfDlv8nQPDWATR4yZZYFdEbwQLUCuiTQR/QIlfoukavr29NSyH9FMfW7AfX37oCRbP3ooFw33viUJzRVa4YkcjohHvp29TldGuIl6gWvIZjXuzxabf6f4cI+ws+zKYfeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289060; c=relaxed/simple;
	bh=seoMbSAeLbmB6ImXZUgioJM9v0UjfEd1TKGz9Ms1RZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0MaVB4wQ6445Anl+3T0O9serdaibp6tV+20HgVI5N/9dPhJYwwF5gHTExLahNa6kMJdLs8ZYzmD8Oci1Tl2WhSda1vJG/c6bdkHc97397zrnEJJIc2WEfns8pZ/E660BOQb8GgdeGNGNSmNXNWglxY0H5gjRraskgwPI9Ebx9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwV0bGPY; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwV0bGPY"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84232e83ca9so717981b3a.2
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 11:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781289058; x=1781893858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8pC8t/C8aOLAtqNdDQZ0QLHNiJOmnIBYDnUXW0IBfw=;
        b=MwV0bGPYS7lhOMdeAdN7bGSyFbsIq0H2LTOYjcrRiahggIVpE2MKwdFdb2In2Yp9vk
         Jt8ZhA9bfUfGA6quX6C5LKt6eoD6PVWfF5M1KPUDqjbT1lsc3WttRrX0Uki9ufpi7fWW
         tKzT4ya78o7N34ZUysypyfWPOvWK7t82esm+0/S3QMzPQpUgZGUntDc9Ozxm4a4BGmaT
         scIj3uRxeGiLV1G2UKmzJXQsHFvK8V6z1loinTblB971K70gyd3iy5ABbif6s1CyXHYf
         qrEI6zoIrswR86BjDyVKkmFGAQYc7/dnMCc0x1QgRow1LTO3BQGaUPpGwlLZ5bGWqJGv
         cplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781289058; x=1781893858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h8pC8t/C8aOLAtqNdDQZ0QLHNiJOmnIBYDnUXW0IBfw=;
        b=ZarnYD1pc0PTXfkZdyaTcezWt0BTiIzXUKyCyPVtQtiZRmXr9ahYB26u6Q63cB4C2B
         MyuoON83GOfzRZzx4ytQWUtRk5PH0uwfKmzi6JEC/or7tyzpTHirZIbDSn+v6m5/ihH3
         2WKKTKOoxLH5V/D5cxAOppXJ/TCpukSiCdVr+MrN/j6K5sqoHSeQnFssvtQIusXhzX2E
         8vRJsV+TX3IIOCZtdJYY1fTvymUsBCXLPs32OIITHFqFIVWUUTUfguaOFCAa/eQaDdn0
         zZqEQb77+nq6DiCxpniBWkJNUTKvZ94S3mBHJOzmjwlpWEhIfmpUircjodhliJol8/HH
         mUVA==
X-Forwarded-Encrypted: i=1; AFNElJ/PTv2j+pBU5CsNSCrGI+bwOTV5tA2k5F515dAOWmFdm88q8VlDSghFnCUnrnoorTlW04U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD/BgrIOm1NsUl1DltPn9Xr6r+GdHwxecWEWdf1TmCZzsTbmM0
	gXV8+agva4rDphgHEDVb/A5AzzyjfasMJJ2HziC40Sv9L/7DRFoXVlxQ
X-Gm-Gg: Acq92OHkS8GV9be2+pmfV1Fo+McYSpEloHTI1Rz/CwP+TCnw/zi8WrqKld+uL3r5tcu
	6T/JIHPG46Nj65a/6L9frS/e+SGDlmPsE31vQ83Qs2+j8HYnMUWprtM4/SsuNHwlDgfwh9lLzH0
	BepBpKX1+i+en9heYUB2o3ziht/B1GWyY9Xw04lW40DMJxXPqfnA6JiNucODRUgdhaM47GUlWAc
	KKd6VIjFAEyGqVHOdo+SJZhY7AVCVvB/4Z//A8JnmxiMJfAnzQlnJP0LYUHJjGwLI8/Vl6NCY2v
	X9+8vmmbRI+OIVVB0npxHefe3Zbt1l2f6n7j1kpYoPSRYYjUQ+IVOFKN5jUQGCyHcnXqb0ImDAh
	5H9UDt3/e/fX5+hWW6sONjziJZ6D9zxXZuxhyAz+yGvcXbjBHjhv4QWsZWvbdF144A2hTY6J3a+
	HzGQnztdhXKJYvwr7kp18yHc8e49WKf0MPAJJY+yJYI1qkc3BhSRx0JkuUaJHXt90I/32cHtOPk
	V3dW9oGh0Zfhb4s8gx4P/2vck6uu9Y97g==
X-Received: by 2002:a05:6a00:ac01:b0:842:6c02:2fa1 with SMTP id d2e1a72fcca58-8434cec1cd2mr4998135b3a.39.1781289058063;
        Fri, 12 Jun 2026 11:30:58 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc9fa8sm3341488b3a.32.2026.06.12.11.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:30:57 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: a3205153416@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	kumarayushjha123@gmail.com,
	lucasseikioshiro@gmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net
Subject: [GSoC Patch v3 3/4] repo: add path.commondir with absolute and relative suffix formatting
Date: Fri, 12 Jun 2026 23:58:46 +0530
Message-ID: <20260612182847.562816-4-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612182847.562816-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260612182847.562816-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts working with worktree setups need a reliable way to discover
the common directory, which diverges from the git directory when
multiple worktrees are in use. There is no way to retrieve this path
from git repo info today.

Introduce path.commondir.absolute and path.commondir.relative keys.
Exposing explicit format variants rather than a single key with a
default avoids ambiguity for scripts that require predictable output.

Add a test helper test_repo_info_path that creates isolated
repositories per test case to prevent state leaks, captures the repo
root before changing directories to avoid eval, and accepts an optional
init_command to cover environment variable overrides such as
GIT_COMMON_DIR and GIT_DIR.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  9 ++++++
 builtin/repo.c              | 26 ++++++++++++++++
 t/t1900-repo-info.sh        | 61 +++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 42262c1983..890c34051d 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -104,6 +104,15 @@ values that they return:
 `object.format`::
 	The object format (hash algorithm) used in the repository.
 
+`path.commondir.absolute`::
+	The canonical absolute path to the Git repository's common
+	directory (the shared `.git` directory containing objects,
+	refs, and global configuration).
+
+`path.commondir.relative`::
+	The path to the Git repository's common directory relative to
+	the current working directory.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index 71a5c1c29c..c4cc3bf3fc 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -7,12 +7,14 @@
 #include "hex.h"
 #include "odb.h"
 #include "parse-options.h"
+#include "path.h"
 #include "path-walk.h"
 #include "progress.h"
 #include "quote.h"
 #include "ref-filter.h"
 #include "refs.h"
 #include "revision.h"
+#include "setup.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "shallow.h"
@@ -75,6 +77,28 @@ static int get_object_format(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_commondir_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *common_dir = repo_get_common_dir(repo);
+
+	if (!common_dir)
+		return error(_("unable to get common directory"));
+
+	append_formatted_path(buf, common_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_commondir_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *common_dir = repo_get_common_dir(repo);
+
+	if (!common_dir)
+		return error(_("unable to get common directory"));
+
+	append_formatted_path(buf, common_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -87,6 +111,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "path.commondir.absolute", get_path_commondir_absolute },
+	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 39bb77dda0..28fe76e25b 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -155,4 +155,65 @@ test_expect_success 'git repo info -h shows only repo info usage' '
 	test_grep ! "git repo structure" actual
 '
 
+# Helper function to test path keys in both absolute and relative formats.
+# $1: label for the test
+# $2: field_name (e.g., commondir)
+# $3: unique repo name for isolation
+# $4: expect_absolute (suffix appended to repo root)
+# $5: expect_relative (the relative path string expected)
+# $6: init_command (extra setup like exporting env vars)
+test_repo_info_path () {
+	label=$1
+	field_name=$2
+	repo_name=$3
+	expect_absolute_suffix=$4
+	expect_relative=$5
+	init_command=$6
+
+	absolute_root="$repo_name-absolute"
+	relative_root="$repo_name-relative"
+
+	test_expect_success "setup: $label" '
+		git init "$absolute_root" &&
+		git init "$relative_root" &&
+		mkdir -p "$absolute_root/sub" "$relative_root/sub"
+	'
+
+	test_expect_success "absolute: $label" '
+		(
+			cd "$absolute_root/sub" &&
+			ROOT="$(test-tool path-utils real_path "..")" && export ROOT &&
+			eval "$init_command" &&
+			expect_path="$ROOT${expect_absolute_suffix:+/$expect_absolute_suffix}" &&
+			echo "path.$field_name.absolute=$expect_path" >expect &&
+			git repo info "path.$field_name.absolute" >actual &&
+			test_cmp expect actual
+		)
+	'
+
+	test_expect_success "relative: $label" '
+		(
+			cd "$relative_root/sub" &&
+			ROOT="$(test-tool path-utils real_path "..")" && export ROOT &&
+			eval "$init_command" &&
+			echo "path.$field_name.relative=$expect_relative" >expect &&
+			git repo info "path.$field_name.relative" >actual &&
+			test_cmp expect actual
+		)
+	'
+}
+
+test_repo_info_path 'commondir standard' 'commondir' 'commondir-std' \
+	'.git' '../.git'
+
+test_repo_info_path 'commondir with GIT_COMMON_DIR and GIT_DIR' 'commondir' \
+	'commondir-envs' 'custom-common' '../custom-common' \
+	'GIT_COMMON_DIR="$ROOT/custom-common" && export GIT_COMMON_DIR &&
+	 GIT_DIR="../.git" && export GIT_DIR &&
+	 git init --bare "$ROOT/custom-common"'
+
+test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
+	'commondir-only-gitdir' '.git' '../.git' \
+	'GIT_DIR="../.git" && export GIT_DIR'
+
 test_done
-- 
2.54.0

