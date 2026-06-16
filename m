Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641913C8C7F
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 04:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781585549; cv=none; b=tBNQx2jEGE9IZCrj9xPot/VNOH5m9keC3HvxnknymKDHuE2uD8MZuOtGeX0oexjIBV0dRWS2jy4TBWGwFT3+QAvAz/5+2EPi0CTr0E6POfF4l3IDW98LPxc6Eo05whe1vOio6igz+bZZ7bAPH49zi8Hv6J+or+nyYpbBBQ/WXbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781585549; c=relaxed/simple;
	bh=Yc2yxD9bEqSP0MR8RHRWJ6bbSrG/Mrsgmr5ILH3vxOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItfplvfCIQSKJ5cJ9/NfUqtjKPjJpKSpixkHxTOP65bgNZZSn/+9Fkv2wd5XtGMtUsjzOzN0VgXAwOEXbHQwqVfdEBzbwhERQDSG72hAQ14+436nWeOzmcdW3aFx3BaWkxTXgSET43+wd9wWJcMbi3LbBEHtMG5gPYSTeK/W60Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iatd5A9U; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iatd5A9U"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-842d37438d8so1591487b3a.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 21:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781585548; x=1782190348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3Bcdbfa6a+BcKyNh/zBD6ljh4QJNqQatE3grOsjrVI=;
        b=iatd5A9USJPiA1NMKBx06AfZewYkP1VQa7dz9WZ5mvx6woE9twKaHWt92nVT/Nq2Qh
         SbpwkXOckX3XrxlFyT4cEKkqCIgQyl3fZVul9puShhAaX/5RJHJ4cFFjIKsaXXh5R1tR
         LI+21xITXj/TTHU8qFNoe4WnXkmXN5kLV2Haiv/Vi7VhgshYNvaiGQl9bQsDq8D1fyvR
         TZuRr92yzHZhHgS2wTJPZbthaVtJ/b4n3e4BLtPzZg6DmomEq+OgxHvyNuJHhD6ULwmd
         IhHq331KpUHVs7AfhwCEmIertjQbFlJD0ucfWh6+sjT/t32EvWJcvl5j/DIKatcxfFBj
         dM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781585548; x=1782190348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s3Bcdbfa6a+BcKyNh/zBD6ljh4QJNqQatE3grOsjrVI=;
        b=ABwKxLNllOq7ZPWO1mrL6VsWBaYkLiLYhRdsDy3R7ORNld0I7/hOn7Hw6IVJtBxRMQ
         jCfZGXNz2IgMuTgAOWpd6elJ9HHHw22SdF1oupMmZ4JtLbi/cwFe95yjE6PvouGX/ZwU
         ScL/+EEa5r2DYX2LPpd1KF/KD6lRCqkzHG9wBa3d/MSOyb4G6CMxeFEzg25lwS974eec
         P6WhD3YfpxCsO54bv+vDZH/rDZSAjlx3JAUFAIl++vFF+ZJBESWzREpIjXWb1+FQxVxh
         J9Aw6Chrtll6lSCuJoiETgFJrbZc9RC48RBK1e7Az/FGqit6/g8kWfrHjl2ktElbfJbO
         1ZEA==
X-Gm-Message-State: AOJu0YwP4lpzxX32m9sBI/TXpLaWlJ6fDtXdw4S+9SblshqZnrJKBO+B
	BzUWeR9x6kWzWcMxc1Y+gsDlO64tO3Gqb5skjjJFKFnhHNqGY9YEwFk5YyoAIw==
X-Gm-Gg: Acq92OEVXeJtv5M2+GYQxUIU1eE6dyK+vtvN7H6uTuLCJh2v+R0BjeYU7HVnDOxIuwM
	KwS/JWiFMye05/N1TXjxLOcXzLeLBlq43QZGC31OcrE0dmzpn68yWPn0xzffUJWJtJWtkaI4JVv
	CLlm5nauTcajN1de9fqy3RIi15Spy/uUg1isS33t9yIzGDhAr1+UFVdgnGxyKXjfTuunQ5mnMvd
	UNx/Jfn6ax5GH6Feya6MLZ+pFdltfVFqjDE4LqTahReS/JgCQ7Gwe7wqEFleJeLOh8JpYl3kMGG
	E28VeufpbRlP/jW7yzPPfUzsIiaykaUpnuGzlW+06KSwaUH19/wWBw766R07ijKlQmbc6GBM77Y
	jX0ssDtiMGS1QPltRMCT4sA9+PsaJhEGQghv0gPBZ3FKquVloKjZWptlNaWOHU+s2dL86f44teq
	IurMFMaOTMPwmBCAHElbTC+ARsDzthkSWl9HH9oRqVtzO1CuoFkwKPTllejaZgeIb6fvJNnzjRJ
	Yg8xKVNaorh6fZUjCI6ARfdvJoRK6hUgg==
X-Received: by 2002:a05:6a00:2c94:b0:842:5719:4552 with SMTP id d2e1a72fcca58-845155811c4mr1843294b3a.46.1781585547751;
        Mon, 15 Jun 2026 21:52:27 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b040718sm12122614b3a.51.2026.06.15.21.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 21:52:26 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net,
	kumarayushjha123@gmail.com,
	a3205153416@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch v5 3/4] repo: add path.commondir with absolute and relative suffix formatting
Date: Tue, 16 Jun 2026 10:19:52 +0530
Message-ID: <20260616044953.184806-4-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616044953.184806-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260616044953.184806-1-jayatheerthkulkarni2005@gmail.com>
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

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  9 +++++++
 builtin/repo.c              | 26 +++++++++++++++++++
 t/t1900-repo-info.sh        | 52 +++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

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
index 39bb77dda0..09158d29f9 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -155,4 +155,56 @@ test_expect_success 'git repo info -h shows only repo info usage' '
 	test_grep ! "git repo structure" actual
 '
 
+# Helper function to test path keys in both absolute and relative formats.
+# $1: label for the test
+# $2: field_name (e.g., commondir)
+# $3: expected_dir (the directory name, e.g., .git or custom-common)
+# $4: init_command (extra setup like exporting env vars)
+test_repo_info_path () {
+	label=$1
+	field_name=$2
+	expected_dir=$3
+	init_command=$4
+
+	test_expect_success "absolute: $label" '
+		test_when_finished "rm -rf repo" &&
+		git init repo &&
+		(
+			mkdir -p repo/sub &&
+			cd repo/sub &&
+			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
+			eval "$init_command" &&
+			echo "path.$field_name.absolute=$ROOT/$expected_dir" >expect &&
+			git repo info "path.$field_name.absolute" >actual &&
+			test_cmp expect actual
+		)
+	'
+
+	test_expect_success "relative: $label" '
+		test_when_finished "rm -rf repo" &&
+		git init repo &&
+		(
+			mkdir -p repo/sub &&
+			cd repo/sub &&
+			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
+			eval "$init_command" &&
+			echo "path.$field_name.relative=../$expected_dir" >expect &&
+			git repo info "path.$field_name.relative" >actual &&
+			test_cmp expect actual
+		)
+	'
+}
+
+test_repo_info_path 'commondir standard' 'commondir' '.git'
+
+test_repo_info_path 'commondir with GIT_COMMON_DIR and GIT_DIR' 'commondir' \
+	'custom-common' \
+	'GIT_COMMON_DIR="$ROOT/custom-common" && export GIT_COMMON_DIR &&
+	 GIT_DIR="../.git" && export GIT_DIR &&
+	 git init --bare "$ROOT/custom-common"'
+
+test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
+	'.git' \
+	'GIT_DIR="../.git" && export GIT_DIR'
+
 test_done
-- 
2.54.0

