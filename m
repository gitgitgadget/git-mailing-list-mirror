Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DB62E2663
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790509582; cv=none; b=iZL0L/Ox3dbP/sbJUQTi4629LH4Sp4T4U0s7pCljl4Uo72P2DJZoc7P1C9eZJAiW8w980NkLLcPFFSltg0MbzVJsQJ5EoSNX4/UJNE5Cr1mnkE49igp5iGdHB10XbkKb663Z8UsAZW1aHFyXNSsEu41PUj17NmS1vtgHxXUINvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790509582; c=relaxed/simple;
	bh=DFvqv0kZ962Jzr7ewyVUfEJHkYb4pE70nP7PkSA4oSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eauMh0O3+fX9Xq2AvkoGxh8qTlQ72mfqVv/I48At9VgB12sQZKQogMbqoGsCAHp6DhDi5wzQafdHsPpNstiP9dME0yrnDnsTMJl8Jp+qFUU9+rvTY3FgOM4/BjMlh5V3XPB9c3jpjdVlkkL5WCWbOavPErrdDYtmqGIqMSVrkNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNFG3mM1; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNFG3mM1"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-145ab8fd39cso2028682c88.2
        for <git@vger.kernel.org>; Sun, 27 Sep 2026 04:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790509579; x=1791114379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JICFOH5diEYk056bV2KBOFIil/UKVBwE5+yXe4TZuFw=;
        b=QNFG3mM18ROqEjjeJHjeHFGzWrQmiMKIM/SPOXqER9DY42llGNK2yPuZRABbGDBAZX
         GpP67hQm9mXXHL6irr688DTpIMrmE3+AtGFStHEhO9tgtDVA51oxbxEmURdJT86cFdpg
         EqfXxjdW1JnuDshAwhYziOVNHqfF8WHL5Dtw17aqZ17BVHz5Fzerhsnsh7RAQp9dxqfH
         uYmtkpHJdeSVyf/yBIhM84jkYBtrtlZI4YidlPV+gJCygR4TMqnRQr8vvNvP+QZhvZJ/
         A3ht61BdFfeldeDO8PO89viv8/79avZPRg7XLWn00rBRl3ldhD8P76Jmb1s70WmX+40M
         8Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790509579; x=1791114379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JICFOH5diEYk056bV2KBOFIil/UKVBwE5+yXe4TZuFw=;
        b=H1kliVMHSVg6eY6PHww5H09zXHH0hyUz8F34mBIZABqp0T0r+Nyn03DuosCjZN4fTQ
         fT5g61Z4jQa1/uldl2P4aaD3w07mOEewV0ysFUX5pWq+p2zCKbEul5j7QIFPfEHvalFL
         djzGcQKI+d7TvDhAx7MN1HInqRRkbzj0KXU/TKm8PF8VfH10chxDuGGe1XpeQx5P2Yy1
         7ByISWC9rRCAuCCGGkJ8vZMnzUPHcEJM5gAjz5pX01mX/AXG3cnsKUeTBEqx2lnos2g7
         5kntBQp2oR1wf2HCjnmL0ivab1W9MWFpaGq1aGnn+DikDNt9+VL0yKV0uIHPxOsnD7NW
         MdHQ==
X-Gm-Message-State: AFuF++nMZF6U3s7NIo72wO66gftrtgusq/Zq9WGQsodEBzCpf+rUq6jM
	abj1dzGOunr9o8AEKZCoWPsQeClVwu2mR4LnooXBW79kce7l1T7kJ2vJ
X-Gm-Gg: AYBFou1IPpBVysm7KWWfZue+4pn1QMGoxNLD/eHc2Ww8caQl17CclhLtYLxrNpwhIs3
	qqay+qn3DXZBJDDJxbYcZAjoy3GzXWnXQ9EFo8qOZQf3IxaiYLYu2nCkQ5NoAWTIvZhXNQB7YVE
	q5qgNOf9bYxglVlR4M/vGnt+Y8yGr02KsCSRID2rjP+vMdh530uyAH79dp0RZ9OiWlr2y6+BM0O
	XQHK4fFGFROowBAZRTef0cVtalF+zWO/eT9o6iYpf+9vq5/wYorGfxczvp/mnjXDhdU6CQXGh08
	8g0aa/ROao8N027dNmLFGy/8YUyxJpjebAtfZDdjS8IMe/WK0dTMc64UEbZGHFaBuuxrqXyndjK
	rRCSsu1M+3aw6+7LLpYvnZMAbkVUxNsuZpsCybv/8n9oZOqEdYtLSQCo8oPoFEyt0eivV6I5Wlb
	hlsrnHBSmTPyax41pkUT8G0vmpIbo4uGFULGzxCX2toGoM3PdBCygjEYEmgFMkLKNESzWJxL+/+
	Kk+FpX9/p3v8phTQ7PwH3ofzSM9+keV138q+ztuxbamCXv/vtXC9BiZcUwGNNh0g/ndKdBhctea
	RKA9
X-Received: by 2002:a05:701b:20de:20b0:145:5c7:71bc with SMTP id a92af1059eb24-146cddbcfddmr6417269c88.5.1790509579025;
        Sun, 27 Sep 2026 04:46:19 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145a7318afcsm17450424c88.0.2026.09.27.04.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 04:46:18 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v7 6/8] repo: add path.grafts with absolute and relative suffixes
Date: Sun, 27 Sep 2026 17:14:18 +0530
Message-ID: <20260927114420.59724-7-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.56.0-rc2
In-Reply-To: <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The repository grafts file specifies alternate parent relationships for
commits and may be used by repository tooling that needs to inspect or
manage grafts. Scripts currently retrieve its location by invoking
`git rev-parse --git-path info/grafts`.

Introduce `path.grafts.absolute` and `path.grafts.relative` keys to
`git repo info`. This exposes the grafts file location as a scriptable
config-like key using standard format rules, allowing scripts to
retrieve it through the same interface as other repository path
information.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 11 +++++++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        |  6 ++++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 08ef47750c..868ab0ed9f 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,17 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.grafts.absolute`::
+	The canonical absolute path to the repository's graft file.
+	Respects the `GIT_GRAFT_FILE` environment override. The path is
+	returned regardless of whether the file currently exists on disk.
+
+`path.grafts.relative`::
+	The path to the repository's graft file relative to the current
+	working directory. Respects the `GIT_GRAFT_FILE` environment
+	override. The path is returned regardless of whether the file
+	currently exists on disk.
+
 `path.hooks.absolute`::
 	The canonical absolute path to the repository's hooks directory.
 	Respects the `core.hooksPath` configuration. If `core.hooksPath` is
diff --git a/builtin/repo.c b/builtin/repo.c
index a4ea2022eb..8144b74361 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -122,6 +122,28 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_grafts_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *graft_file = repo_get_graft_file(repo);
+
+	if (!graft_file)
+		return error(_("unable to get graft file"));
+
+	format_path(buf, graft_file, "", PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_grafts_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *graft_file = repo_get_graft_file(repo);
+
+	if (!graft_file)
+		return error(_("unable to get graft file"));
+
+	format_path(buf, graft_file, repo->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_path_hooks_absolute(struct repository *repo, struct strbuf *buf)
 {
 	struct strbuf hooks_path = STRBUF_INIT;
@@ -224,6 +246,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.grafts.absolute", get_path_grafts_absolute },
+	{ "path.grafts.relative", get_path_grafts_relative },
 	{ "path.hooks.absolute", get_path_hooks_absolute },
 	{ "path.hooks.relative", get_path_hooks_relative },
 	{ "path.index.absolute", get_path_index_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 431a4842d4..adc4a92487 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -221,6 +221,12 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_repo_info_path 'grafts standard' 'grafts' '.git/info/grafts'
+
+test_repo_info_path 'grafts with GIT_GRAFT_FILE override' 'grafts' \
+	'custom-graft-file' \
+	'GIT_GRAFT_FILE="$ROOT/custom-graft-file" && export GIT_GRAFT_FILE'
+
 test_repo_info_path 'hooks standard' 'hooks' '.git/hooks'
 
 test_repo_info_path 'hooks with core.hooksPath override' 'hooks' \
-- 
2.56.0-rc2

