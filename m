Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8972F7F1D
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 04:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781499172; cv=none; b=bLt6IxaQBIRlA25eQRhbFvW2FVWNwMYzpLVSbLbaoVgEclt/wpLdIfz6hfqLJMfYh9UP/IXZz/T+ppRxqSd4QPYsgt5OJ4+hvC8x511w79RXJIjkBl+8REigJQ6G1rgL3zL0TFOSSl6zuXt8zMgCHMWAenClERXaaqpg+S2d5nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781499172; c=relaxed/simple;
	bh=Z0H5HLPa/jalzFtQJxhDzZcB8d03hVv3wZ9h14f7Jdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiYGJIxDLe1Tr+0CQoXZo4Lxxo8Qc76vl7opZZY9HglsywqzgOaYCQthu1cJgfcUk7U/Il0jA3iJxiHleQEJZZ6cGAKPy3XFBNuQj61VsXP2a3S5U5vWI5lKf3gXTGGB+FU9bDrgNvAaI9JahOy2F8gJnP8yeao4fOSOHie95T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgGhqyQQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgGhqyQQ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c68190ade4so4134545ad.0
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 21:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781499170; x=1782103970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akZEAPfLIkR44+7whD42iCQhFx0p0sv3Hfy73dshfdM=;
        b=BgGhqyQQjVmSoIt6DfY0AH23DtXllv2cGFbDTZk5wSvlRfVwgRmRYnTiHZdXJcMNZ2
         ZFIEbRzKvq3XrBWwAxfao0U44AyCVEwObA9wBEMG4xd9375CIzv2YwUcocH0y2dk/Pq8
         +ZQ2sx6u5sjhmErbXzZQFnj8wZgE4OGC4/naQX0w52z3D9Oi0LuBt1PXGg1VtkUo8MCv
         6THMCSf65DrCTLlKxga4AylQOcIQsdzULkyItdwK5t7ObhYBAHB4pZh5dJXSoQTbLI1v
         FrrwQPyyecmUcOCE4KwyJZrXOtomfLRhkrQ7peKKm9PJ8bEXJzB8y/yMNuZvRoc4ATTl
         eYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781499170; x=1782103970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=akZEAPfLIkR44+7whD42iCQhFx0p0sv3Hfy73dshfdM=;
        b=pM1vcK3HROPyh8MktVzKa+an+wTzbhM35n2BZpLbGoZaKcRTkpG+ni6RAg0CS+cXCE
         PgmhRX9Jx0cmEx81NTbXVzyLwjNX3U8xcPWilqmM4MqrvqI9k6OyZE0CFoNPmuBPOVzg
         sKSXvp3qXiTX1cOut5UeJ0HnVhntYYm0Xnwr82hgZ8S4lGHrGsoz+WJaxdhg00GIfpdv
         aj+FMZgDfTnCfi1m3zloVTYCmfmGo2eQc/V2ZlbM2TGdb+s7iMVslRRMsgFr47pGEy6M
         ikf6jnbf38g6P2ikq8DfFwM1z2Id1bZMzg1wYDs3Ifq5bH3ZYOkCznCk+0eRq5+DYTi3
         6V4g==
X-Gm-Message-State: AOJu0YwQnpYBvbyQ97X5sXWJjfIwCs8Buuz+IXe3hXu3TR20OMBBErvB
	BJg56AHzqYYbBNj4Z+zrf6NksVNbhcqyyEDhDr7HXvIjUZPRMw0vkHPGGK3ckQ==
X-Gm-Gg: Acq92OHI4kejp4wXa0p9A2wykuK14+HcUpNDUprrLZH2oEh5VsoIG0j3O/aHhGCwKdz
	QZ+UrJjWRT/oROhdneHx+44Ky5XOTxHUsWr/grYmFRKEHJmvOyy9TjBfNx8ELB/E8n1Sg9KOkyT
	XgTr6CKYw/M5AnVrXXJkIDSt3Sjy0y3Hn1qLYIDcDzvNBNbUJqqOcq2s8M9TvzeoZC0iDPnPaKj
	Q/deMb1QuVDbEWb+CSQOJiwphDY6lCGFN3T+WDl4SAznXLRIJAgelA3RrBCfYrIkVIYAGiWktdq
	Qz4ksxL4v8GJxqyFaSrGMQlzIavpbekN/EWy3qneqTBgC04L59rjmqU4cFPFRODdCkMAuIQFbey
	kPWhi+2IV0ayBZd1R0K5Y5pVxblfafUfz4vBBDqMDVQR5VZBQxW3SFBaTrgTeGIWGTH+HHA2FCy
	BLWXwEAHzh4l5i08G3z/dsmI6ZP9VxdzHlMtm09JIU4a6alq4C9o8/TAJtmZjvF4s8MubW/Dl4/
	lscd68K9QZKRlhKxllgsHySpdZPx+FZdeohQcrHQ7xN
X-Received: by 2002:a17:902:e803:b0:2bd:3c21:a053 with SMTP id d9443c01a7336-2c3fd514545mr111955045ad.24.1781499170381;
        Sun, 14 Jun 2026 21:52:50 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a4c1fsm85528075ad.53.2026.06.14.21.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 21:52:49 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: a3205153416@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	kumarayushjha123@gmail.com,
	lucasseikioshiro@gmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net,
	kristofferhaugsbakk@fastmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch v4 3/4] repo: add path.commondir with absolute and relative suffix formatting
Date: Mon, 15 Jun 2026 10:21:11 +0530
Message-ID: <20260615045112.50686-4-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615045112.50686-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260615045112.50686-1-jayatheerthkulkarni2005@gmail.com>
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
index 39bb77dda0..0c0228687f 100755
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
+			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
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
+			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
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

