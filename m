Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70831D5CC9
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 03:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781925500; cv=none; b=nr/lfPRZbHnd25T+ZnARsjTbU/Ai0gF2kFfbf83etEikP4SnR+XuE+TaXGafpYh0lDqw9GakVWhXbqPR/8EtqYAlCTprLr0+hh1OYCO9KDGU72ND+wgLKkHLf9DiD0AZTiavPBUfxjYD/578gST1AYGZQ6EuGYvfF2pilegXCCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781925500; c=relaxed/simple;
	bh=Yc2yxD9bEqSP0MR8RHRWJ6bbSrG/Mrsgmr5ILH3vxOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkx/NOGe0hZ7ycqUVYXQ/jXiLn6gh+kTATAQufUxhIrxJCda1swrYXknOphCyOfM2kyNyDWjD9v9nPPgg8XnHqT4gwI8jQJL6/2rSEKxkPI0AmTbrs/tKr9YIwQDYRPIW1NN0RDwKO6+9PdPietTu0pFu1qRqF0r6iczlXbOCBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYqGJd6E; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYqGJd6E"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c6ab886da6so16162715ad.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 20:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781925498; x=1782530298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3Bcdbfa6a+BcKyNh/zBD6ljh4QJNqQatE3grOsjrVI=;
        b=iYqGJd6EEd0pBMEfFih4szSuPSTPKMfUlRiDh3FH++woEF+aw8vu2TIXIdIwauc88z
         6lcE+yE/CBT06wcg41m7mEef7abYdO1VdidXNm+4108HXiC2su2ANpU7c0S9NLaqevfw
         pU0Gw60SVVyh8wOeoFcIBRt5rSPXnb4HTPwZVgjS9TKDJamWV8t6OdcofqQuIYoiVOCX
         ilesGhEuAlKytAS/4TqsZyTzQXybnIufJ5YERB3wa0eoTe9qlXPVoygJdKHs7k2y11OW
         sr78BZ1avqTnFkm4W/r03NyLk2h/gajjH8Y/Lwt+l6UmB3cIhoO7k6Mh05vA3DuusWf+
         QSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781925498; x=1782530298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s3Bcdbfa6a+BcKyNh/zBD6ljh4QJNqQatE3grOsjrVI=;
        b=SpX/lVV17ZyBYGf3kyrO/hPsHmEpgIV4vYf0jLuT79+ZLm0CHWz6XsjmvzA2f/J8dV
         fzFEgJH9wCTDTRmq2ajVqxYgIQg58QAMFvLHNfANvsTV1sChw+dEwlF5/IEgAJgEhrji
         Mpg+bPC31JxTet9XXM5rGqrcQVIuOfIvQNh7oyxWi5JFnN4gwwuSgGLpE+MnAEMhN7lM
         2dn+cgrn3izdmn2GqYVMuFo2Edzn7SqEHFRhOBykx667G1+mG8NiGEVhb8+fhCm9A1rC
         JPJo1eULYZoMuoyG/jeXshTHO7ekXPDGEQb8V/UqdBBIMF1rDnDzCdM1kWiNSDnQ4X/j
         pypw==
X-Gm-Message-State: AOJu0YwUP3RIihIDnRZdeo/1U2UR/6YnIRH2UUsUz/IHwGoNF6wy/ywN
	NfK9y7SrEwlkeRsqqfnT5RlEb7tYH5JyxBLB1vVAKyMoZ40mXHXrxaL7Tf4tvA==
X-Gm-Gg: AfdE7cmMxvrUw8S86XESBDi2+nUuOqG6Nrqugg0KuytC/QD7WnqbxIRWxeyJduvLmt1
	z+30JrVH8VQ6uLOramXQf5qiJ9vzsby/ZKp533DUhuDofLiev6ZdV/rYYR0c78E+DyIEMDY8nQz
	ChGytdOsYXYp2GsmBG0suRZ75+2uToAvZucXJ9Y/p/0xReccxRo7R8UexAKjvvy7c8cj7X42GGF
	rTdlufrurbicvKc3nB0zgmumpbKQ2NZzBBxemJmE9kWnk5pRalJTeJ2hAP019thUa96CWdaerXQ
	vLOat2BEB3KZ2YLqy4gUv2zRfMWFs4wl3+0HhFA5oKagCDht4sNewqBVxlwHVB92Rop53BHepX2
	4FT0SSWpjnUa9D8SoPi0BgJayO2876UVKGBNQjpuB/Roxm3Kron17QrlU7xB8hYzEan3D6CrFsc
	EfeqR4EpL+pHzLtVDeY0Gw51nAtWG3B6VL5CPAlLXtgH0ER/rnMR6qoAE48fwaZz8b9K1Eembm4
	7Yzz0XndSNf+3XLgxQ=
X-Received: by 2002:a17:903:2ec7:b0:2c0:3400:5c34 with SMTP id d9443c01a7336-2c718c879fbmr64346375ad.3.1781925498135;
        Fri, 19 Jun 2026 20:18:18 -0700 (PDT)
Received: from jayatheerth ([2409:40f0:f:5924:9ce6:f181:f81b:c57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af590sm9581675ad.17.2026.06.19.20.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 20:18:17 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net,
	kumarayushjha123@gmail.com,
	a3205153416@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch v6 3/4] repo: add path.commondir with absolute and relative suffix formatting
Date: Sat, 20 Jun 2026 08:46:43 +0530
Message-ID: <20260620031644.353772-4-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620031644.353772-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260620031644.353772-1-jayatheerthkulkarni2005@gmail.com>
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

