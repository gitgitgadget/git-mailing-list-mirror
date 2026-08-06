Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A05A43A819
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011673; cv=none; b=bglOYEGaw24WRzxQij2b/QvanzadM1XxhElHaSUqWp+PVbs+Q6qeUXHZOz+kjxoAo/H+yI/LOJJvxZVBDzgLXrH/2gN4ZW0utT14aC2E+FX1FzdiFBY2xAZZZ7ywvEg8YSex9dEEs8oMbCWzOfcGxTTQLy4njz1Fpnubd0ImxNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011673; c=relaxed/simple;
	bh=nwt9nxEHqU9siYKFuvTALlYu2uI+3pKvoICYWEgsZN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVzRA1Ujq+aDaVkm9O4dahBSvC1W8Nz/v5WFu9CyKZA7DdyAFHa0iwhHmdHs0kp6qaZLJgnlVinV44NNyNnUQ23gfC0v0/HNTlm/VjFQep/dIgK6oJPlUQAI0y86XlqDdqLL1aOYXg8Cm564f634595Du7TntacDU6xjY3eny+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haXO1VXY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haXO1VXY"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84874b52eabso2890369b3a.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 03:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786011671; x=1786616471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ByEN84H5JRQiUNGbtgZOocffYahQ1w251ssolj35yI=;
        b=haXO1VXYxDJq10fHGgaNwEht6RZM3r4SM5yYhaQCYFmnXgEDGC6BzBSA7Gpzab1iOs
         dR1Rb15modysOtTYYz7k5YRGPdWGvUOulEnnk6a3or8d4xxbHzqhQKsTmWivLmoVbm0o
         N7FddF6cemh+bisEpcgE8OIsrSu86jD1Y6ae9CbgUWzaAqw3Yp+xuskDOhTnTj3WEIpN
         30FNesg0+tUe8BYdePLx2sgbLqTCpV3vQtU8Z/5cUHHu9rxey5lLMBj2y8bMt0pv628r
         0afiKeC/oZuenO1OOygF/+M07I5mU1AgFkfi9++pIe7buuOnPZO+ZebsahMiAPRv7zBy
         a/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011671; x=1786616471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ByEN84H5JRQiUNGbtgZOocffYahQ1w251ssolj35yI=;
        b=PmLD4V4EoTZVK+TDYOadARK5qAlixvdQSPAPOHtQazpw5xEn0EGeD/xxJNBuj8qWhS
         6xxgJrNpOedegajPsNWEfu4zxD7oqkwJ0lMJAEvJluqLLP5bPiJPXC2PNF/kQPEyHng7
         FY/sqBm6X9N4iahOuGh+9qExirzNd4Nrd/zEbnJryCB9wgmOCgc90BQWLLu3iizuCTVy
         pvz7mJM01d9ZzjmxQwdJpga+EG8feRsUJ2NypIyFMBR2oWE61AdBjglAtNULaQqRQ8s7
         wkt5onJXCZqvYiQTBKLiZKUVcbOPq3heAkSFPWv52Cwgf+9TQeJkaKhY9TeT3Q4rU156
         2j2w==
X-Gm-Message-State: AOJu0Yz70AuAl7dh3PWz8kXCJnMsdryxRyX9MY4V+o2vOGMfH1xdtTkD
	9GcPsX5byLUYxvuY/P82M+PQM4w7vz2x2qD4ELYPD91+Tes47PvHFMDZ
X-Gm-Gg: AR+sD10BWeiSETY9+IlE4DyBq4K1sW9D+c2YJdqccRwrqx0nNrEM//8/h1KOYRiMxi5
	4JIBH8vF2nXcA3qo67Mh/TiYzw1hRoKL7Xv3+SkP985VqtjuHYf/o3ZG5I/KdmnX5FVodppoka4
	+JseWO8wui/j0wDB0HLqp+uDtf1iSJ2/M5NaHkh5d2cW1Y17kIsjsMhJ667Oq6DcYBo0+w5TisR
	Z0kURxNaBwabJdzCXiUtQTwVtrJBKocW85/D72eZSTwCn1jgfjMYg9a1WoFa4s63NI7WJr1JzZ/
	4/Wp3V7RinqlhuI9RwG0iyBLr/sPbrZnjxOHB2y0F3BKbkzjyFCjrZVdNBUQrhY/dlD+sC/Ik1t
	THwivjjzBgbETxk4N9cLgk8o3/GgVEAT3huZuRSiB+UUKFfziu7dBeF/kLNBwUmHbh3tlYki4GB
	MLkR+q/5Or9QZ4/ojfniQswGw1wgWo4sKCs5u4mruoo9AuoryHNytWG3U6fOYwn4jLp3xfxaHio
	ymzKFILM+h9tSnqNhRMB2ZuWpGAfhyLI7VMUk+IlsKraHRTODgLcmmLTiZ42iOrJGhkv+Q=
X-Received: by 2002:a05:6a21:ae11:b0:3cb:96dd:2477 with SMTP id adf61e73a8af0-3cb96dd25e0mr8248066637.8.1786011670843;
        Thu, 06 Aug 2026 03:21:10 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b76cfsm25525901eec.4.2026.08.06.03.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:21:10 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC PATCH v4 2/7] repo: add path.superproject-root with absolute and relative suffixes
Date: Thu,  6 Aug 2026 15:45:51 +0530
Message-ID: <20260806101556.162940-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260806101556.162940-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260806101556.162940-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts working in multi-repository setups often need to identify the
top-level working tree of a superproject from within a submodule.
Currently, this is only exposed via `git rev-parse
--show-superproject-working-tree`.

Introduce `path.superproject-root.absolute` and
`path.superproject-root.relative` keys to `git repo info`.
This exposes the core submodule context via a scriptable config-like key
using standard format rules.

If requested when not inside a submodule, the command returns an empty
string.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 10 ++++++++++
 builtin/repo.c              | 31 +++++++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 39 +++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index e34abe5fea..e524a07f53 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,16 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.superproject-root.absolute`::
+	The canonical absolute path to the working tree root of the superproject
+	if the current repository is an initialized submodule. Outputs an empty
+	string if not in a submodule.
+
+`path.superproject-root.relative`::
+	The path to the working tree root of the superproject relative to the
+	current working directory if the current repository is an initialized
+	submodule. Outputs an empty string if not in a submodule.
+
 `path.toplevel.absolute`::
 	The canonical absolute path to the top-level directory of the
 	repository's working tree. Outputs an empty string if the repository
diff --git a/builtin/repo.c b/builtin/repo.c
index c31e9cfa70..47c4fce293 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -18,6 +18,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "shallow.h"
+#include "submodule.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "utf8.h"
@@ -121,6 +122,34 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_superproject_absolute(struct repository *repo UNUSED, struct strbuf *buf)
+{
+	struct strbuf superproject = STRBUF_INIT;
+
+	if (!get_superproject_working_tree(&superproject)) {
+		strbuf_release(&superproject);
+		return 0;
+	}
+
+	format_path(buf, superproject.buf, "", PATH_FORMAT_CANONICAL);
+	strbuf_release(&superproject);
+	return 0;
+}
+
+static int get_path_superproject_relative(struct repository *repo, struct strbuf *buf)
+{
+	struct strbuf superproject = STRBUF_INIT;
+
+	if (!get_superproject_working_tree(&superproject)) {
+		strbuf_release(&superproject);
+		return 0;
+	}
+
+	format_path(buf, superproject.buf, repo->prefix, PATH_FORMAT_RELATIVE);
+	strbuf_release(&superproject);
+	return 0;
+}
+
 static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *work_tree = repo_get_work_tree(repo);
@@ -159,6 +188,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.superproject-root.absolute", get_path_superproject_absolute },
+	{ "path.superproject-root.relative", get_path_superproject_relative },
 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
 	{ "path.toplevel.relative", get_path_toplevel_relative },
 	{ "references.format", get_references_format },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 9417d1ab65..eec576a1d9 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,6 +213,45 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.superproject-root absolute and relative' '
+	test_when_finished "rm -rf sub super" &&
+	git init sub &&
+	test_commit -C sub initial &&
+	git init super &&
+	(
+		cd super &&
+		git -c protocol.file.allow=always submodule add "../sub" sub &&
+		git commit -m "add submodule" &&
+
+		cd sub &&
+		ROOT="$(test-tool path-utils real_path ..)" &&
+
+		echo "path.superproject-root.absolute=$ROOT" >expect.abs &&
+		git repo info path.superproject-root.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.superproject-root.relative=../" >expect.rel &&
+		git repo info path.superproject-root.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
+test_expect_success 'path.superproject-root returns empty when not in a submodule' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "path.superproject-root.absolute=" >expect.abs &&
+		git repo info path.superproject-root.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.superproject-root.relative=" >expect.rel &&
+		git repo info path.superproject-root.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
 test_expect_success 'path.toplevel absolute and relative' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.55.GIT

