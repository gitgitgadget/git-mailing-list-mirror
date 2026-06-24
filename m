Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C0B309EEC
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 03:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272477; cv=none; b=rQoGIRCa6xz6ByrZs454xujy1iOH1e81V+Aa+xMF+Lmy7dZJzmatGreZSrq/iLgNYLjHMUP1LjzjeCizT10HZRPKjpsWHTRlOiGHAtzHLrB4GKBxQTO3Ne7evI0bNPRkj4aAS9SHdTYhC6OxkyiWqNnLEbSLGY+8hhHswhKXzhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272477; c=relaxed/simple;
	bh=9GjP65m8K2wy/CSvG0vGxZA0oB9WdqzXFOlzjaIzeUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcV+7RMAlm2D9hGyIaPZ8h6Ya8MCO4Sdkx0XJd3N2+CrAtcr1Vo4Lux0sfaIRwKdXajKG3LteeFMagLEI22yJm9WnmsQuIYivAeadsMr0kp0SJVhLwCRckeoFX3pl3QcFrrOZKXaUZzx5XTAD4ZTaf2he3XkPVMv7NR237+55dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbidKGag; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbidKGag"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30bf8b2bd20so1136169eec.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 20:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782272475; x=1782877275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSRQYMUB0777UxNUAsL8tqja+GAds4/1JOVh9Fjxysc=;
        b=TbidKGag67kbx2hNi6Clc4/E/2YUsAzSazCBn12Gtwdbv3tYoz7N9HrRwlsyU8Ntek
         WO6Nx9xvHnE5nXWjCjhbLDO91/JWANoCbViqxJF7/lNyhMmEU5CJw7APRrzQFmXMZs6F
         F8VtFaU+OMWG8lLPkZC22x2JJgkmjUMEC9FhVh/J2TxUXo79iBEWDnEx2ammdWGuGrSk
         Vw15i5I5EuiyYMfYjWdOLuBeW1S4+MtHS4E+h1D+kr4P5EC2HZv7uDe7irKMl5Tom8AN
         6GsvewX7qkAt64Jm97hwi8yNBwu6Wj2PrAxT2gsH9TlzvDbq25qDfx3TdCG8hPWBOTqT
         MKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782272475; x=1782877275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VSRQYMUB0777UxNUAsL8tqja+GAds4/1JOVh9Fjxysc=;
        b=IV8ijChoxby9iCSrEdV0XsXncneArMON9U1zMtpaQYGwiQFZP5izOUPfBb+w9H7pdl
         JV2tkIss9TQ2FIY976e4CBB2/XMSEGNoZ7rVdOr54jfmyN1BR+En91uQZWCSXufvfz4o
         d1srnOOrx5lXLjQ8ek7k+LKFgNg3UignnuCvpX7rKoMaD2+rxtiYgdlnjAlEv0+Tq9iG
         RVv4hbzL++SJoANDqSm707vqq8E4Vp+OnJxsoJKOcYfoug4iL9YDOdzzEvJFkNoZ7BQj
         KLAtCFWM5olS6w+W5oJEsIJd9lrFQhZFZX6I6y9P2VKU5Tw/cr/JLTG7fvgvcZK+EsuA
         N35g==
X-Forwarded-Encrypted: i=1; AHgh+Rq6v5RI5rKAGsU6jccTg3x25QHiIUl8ghHP5xYhOOI1eig1blIWwWpG6sB5myZ13HCBXO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKnqCHV56Bk1YkAiB7a/ZX9WifcZ5rZTFxNjlstb8dDb7sqhEl
	cIdIs5/2jRgER86I2xSgTAF9YLhEJWsBrFncgNa7I5qITFylV5Y3Hy0Z
X-Gm-Gg: AfdE7cntz2M6ByDxoa0705oatkOesAdNQRDeDWOvubi0xV0EFrSSfixL8I2lE7UmNB7
	uPBp408SeWgfLgqQ9JZwQSJ/6eagUQcDbOfBIm6s6MRxImmYabitjmX0gMZAMkYLdRe/WZ/8o4I
	d+EMp1LDhSSDaVx3+CHFEaipZiUrqrjlMNoNy/rsnPmwVnZOvKvuoXF5fasFDteAtJhH2lD26rU
	pLA0M2PuF4hTgeN6ZXkY6UXOSMq5Ykm8uCtQxv+nkrkJKvg/2LLudse9rEdq3ppslPt41Jd7IGr
	MPQL1wbjRvyOTBjkANi2NhUvKCGZWOqFABeFpwLS1j8bbpjZIEojjEsNCmOsOzQfTB/5SJPv67k
	XDtdxHGY478H9fOR7gSs0yDEdHyEg+ykwl1IdLfDbtJjMuzZc0ZXra11rZMrbdGv4R4sJF+Indb
	pPaKIDd7TWlyyi8APc5PIBunbuptVbrEbgsTXTZAFk9moKI5RVzGLNbFCBrjEBvkQNcJ0Y31ddT
	x13WCkXFTEXOCR4mWMYtxU=
X-Received: by 2002:a05:7300:3b21:b0:30c:5456:d9cf with SMTP id 5a478bee46e88-30c5456e144mr6836486eec.1.1782272474650;
        Tue, 23 Jun 2026 20:41:14 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bddfe34sm23924891eec.20.2026.06.23.20.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 20:41:14 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: a3205153416@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	kumarayushjha123@gmail.com,
	lucasseikioshiro@gmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net
Subject: [GSoC Patch v8 2/3] repo: add path.commondir with absolute and relative suffix formatting
Date: Wed, 24 Jun 2026 09:07:47 +0530
Message-ID: <20260624033748.108281-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.0-rc1
In-Reply-To: <20260624033748.108281-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260624033748.108281-1-jayatheerthkulkarni2005@gmail.com>
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
index 71a5c1c29c..4c3fbc26b9 100644
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
+	format_path(buf, common_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
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
+	format_path(buf, common_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
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
2.55.0-rc1

