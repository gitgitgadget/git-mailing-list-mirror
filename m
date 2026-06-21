Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3DD4964F
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 05:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782021517; cv=none; b=T3ZuPxVuLZYn5E0BPEpfVOt2N6enQtGaMgdKs3UfS7CT0lcc44TOknUZbnTC7Shg8gQ0Khz2G59TJ5Y26b6vMK7y+x2rp0i/LWXmkkzp8/z/x2x5aJfVks6rFnliM7Y1a5u4hAJLJcQ/nqDT0xekJv9bzBNEf6m3NN2nMWnZSXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782021517; c=relaxed/simple;
	bh=n+qJDLog2jPZy073r1VmG3RSlN0QACTpLT5qdiiCHak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDZe5/0mFaPLI1/qgaMvJ0q564zmN6qnHIOcCGKhyZNhjQwOS9Lj8sjohXnBssYPCPSoIZGhi1aPUZWJUdIyNN1H9SAKcXD3RsSj/Nwl+4hGAVEkCwG34v239xW2YpAUlCE7DmJYmgcUyQyTaxUQNDhslsz10HuftyY9cpvilUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHZN5cxB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHZN5cxB"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c858014845aso1361725a12.1
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 22:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782021515; x=1782626315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6Xd2H+Y1FY7xr2FP4Xni8Rf5CChf/tZe0e8fz5JJiQ=;
        b=WHZN5cxBHkbg4GlrHzDVal0D1zVGDoRUxhwohHQjKtYFuQe5yd1jobQq4YLwb3U/DW
         pIBoBUcJXRbXz8kmiK2XAiyeZpcqcOYeJFcq1p9RUm3EH8AFfm+DXdGTJIYC6qhaIsuZ
         XiPCmI2uPzN2O6fHWF8kdOfOK9pT4thL3ksxvNLFxL9fKLfLwKbYdpDMLYdn9tj0v+RR
         wo75DVhVE/Ub2wEcYvhCIBvy0U7y7U7wuj6WS/3Tj5UBGMzPclzpMsM0A/3goA3sTaAB
         EPOAchOjR/gyCAF4PqL+bfWHGmCvCbqYbsAKyHbdr2RvHr6UoSZsUSEZ8nuBp+SPfdHd
         rxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782021515; x=1782626315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+6Xd2H+Y1FY7xr2FP4Xni8Rf5CChf/tZe0e8fz5JJiQ=;
        b=QPf7txhlUNPsfeyWyUxZDN/YAtz62U3YskAlqU9QwuAmZ8rhrlKn+tQsG3cui+o1rn
         etZuu8u/Iwfty91IJJEqMAxCQUZkegL+s+W6AbuJc3vdndJWIk22mP+19UgeEnqlPkl8
         kN3ivd4qk0DypTr5sVGP21vTbPbxOeXO4KEweRz91idPP1LZoigL/ZyTlY+eIkWdEMFt
         PgbxQWAjYBQAGvXBmWZe2HDPPYB3nePTe8s+pRmhuqoqQVFXz3B2S38N7gJh+WxTuYU4
         bm9H9N8nlFGZV+R+IuGDjnnDR4PffdxsVrJP6CddEq97mzWaYw9rbpzYVLcJSjAt9gvB
         1UQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+rlAjPagnqvn/OOw2rH+2CIxG/viNk/rR5dIzS/KuWJ0qERlxG4i6gPIlR28GbXUW9bPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqqi0VRJGYqHuXRTd6XwHMea3pSmZKhtpOHi9h+01sWh9QlBbK
	gJXEwL46MtstIE0t6ijPnnZTaFtJAeg2I/7JrJCPqW64QTJCLRnLJL3q
X-Gm-Gg: AfdE7ck5eMD5IBH2Bt93DN0Ps6VLf4H0lWzyj70gEw7yVm/WwvkAnkhbrGBFADrCll3
	juxzIsfBleJRnJBpeKYSS6E7fA8XV8vTuXbrjkgoZXQVbAklXxO28t8KJ3wsqSf4hSpGvmlFV0/
	xXM8J/vYWShwbK7K4jDnF2NH4J+kwprKjJsvEtchvRZiNt6eQoncePjL4Izr7cAPZi4FvCEQ382
	6p+y10ZymkuWmUNddPPJxHjFlDuenD9CV5mMZqZ64vleFN9UgKnFr8aryFABV5bEGzeSfJ3+ma/
	H5OOIfvN2eX+gcvVZ19iuEYVuRclsUDXwtc58D9hQiYDmfDGhf6UqaBB2aSiJchT9rsU9IjWHm9
	e48HsW6xDoyiCV95tKbwQf1l3G2U9lKkSgZ4yGDtCFG44zCwpkMZ50HBKqPGuoLmsUy5prIWSa4
	JDERWPAf2f4/VkNHr2HZ42NLo94UoL1ZkIeRM6c1CWarvU6go8fUM3twDdMfF4S//823xFZK159
	Txk+t/8cMA5Ht224ZHf6novtLm+flchxw==
X-Received: by 2002:a05:6a20:43a5:b0:3a2:ebfc:6bfc with SMTP id adf61e73a8af0-3bb3594b50bmr8551746637.17.1782021515309;
        Sat, 20 Jun 2026 22:58:35 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ed3bd8sm3606669b3a.56.2026.06.20.22.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 22:58:34 -0700 (PDT)
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
Subject: [GSoC Patch v7 2/3] repo: add path.commondir with absolute and relative suffix formatting
Date: Sun, 21 Jun 2026 11:25:33 +0530
Message-ID: <20260621055534.46798-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.0-rc1
In-Reply-To: <20260621055534.46798-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260621055534.46798-1-jayatheerthkulkarni2005@gmail.com>
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
2.55.0-rc1

