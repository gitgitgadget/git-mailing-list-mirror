Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B552E2663
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790509631; cv=none; b=BgRbUzNPa1vIkXZ3wAptOEpOG1VtB0iUDns1Gc2alrlsDKSIvoSLru7kZ/cybsnk3W0Co0QvrZ1fWVfy9Qzsn/6O/xVeCOTU6pPd99nomuaUtUsaTNGzzxsJzsvIjmX3n2spIn2cUTExlPdvVlo3lt4jdxqrR/rU2/P9rZqp3aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790509631; c=relaxed/simple;
	bh=qROKwjCj6tYvMIRBAD3EvcpnYPUISNVtqNtyqTk/42o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qph3qF0nhtwYKgP9nE/3kjMcAjCBrcfqVFkdTJadk0e0hE6IOm/nIt7Lkak7Y9S7CMdfosSWiVlY8bAdMxVh23bVoIuWJskNP0ahnfFuWFPhwxWX5Gahl67AGQpsZ0ZaOiBqkfEPhK6FNkMBuc2Bz7QVUHpxPBqpqZcBTgvQbrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTi8AM5L; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTi8AM5L"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34346932d93so665407eec.3
        for <git@vger.kernel.org>; Sun, 27 Sep 2026 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790509629; x=1791114429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=67HH8lsy1LPbQuI90X+YqJ0NB0Sr3nBThr15tMDRLsE=;
        b=ZTi8AM5LwytAr+U35RD9khM0uDhEcwYs/FBN/0BvLT86wtZwzUmrYYPBDB3GZ0wGeE
         UbQXPva0WRNu/a9esWCZwZlxcdZ9J3ZnV6tNmsuWrn8PsFIs3D96XmMFi9FSwF/GwYy8
         gDgLj458ytcfV6h2FiDwOVa4PAJw62cbKu3AuA9yY4AtwKFKPda0xv+kPuyX2n8SIbhE
         FvQ28KVb5Stpwx7CbIbSn1mcLWqYN57DuRxWv4LwDyXYeizZML7+9Eq++gLhkBdyM+qK
         BqtVy5BWV9wz6pLi/z94dFWSALCA7SQos8cBVuKqQatVKrXzDeMM8JrhDUuPLndLl2ZR
         Pc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790509629; x=1791114429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=67HH8lsy1LPbQuI90X+YqJ0NB0Sr3nBThr15tMDRLsE=;
        b=2CsSLt/aFqTTXTg189LJPL7w0VS3MzKLSKg/KG5ogOIXvO7lPvBOz1E0+vc+oOq7of
         WhFdUJz+Cs0BDrjfZI4+RaV9lOY5QP8YLgEDOopfRfKCJF+FS9Y2+6NT+OHVFsEwwr7Y
         RtiiP0/lVXWOldDpt1bZbUrGFGrYgfS0L868m1vkLmWkKmYelG1UA9mJ870W1aTcjLWW
         s6otcJo8likOThqShS8fbWfUTNkyiGsOUb04hl92QfM7mn5EMfcUxc8ujwV0IYASdMoS
         t0UgjePpRmxYm5wpMbqa9q0c1WKEFtKsdn5IpUiWY/WUEDkpKedcWZAamGP1ejAYZcWV
         DaKA==
X-Gm-Message-State: AFuF++nP6LoEESP/BfE8PX75j1QcwNorAyP/7moBZD1udLUePqMfkG0w
	Y9QJRo7CvUmzPPMnmH4K2T05npGrfIYwzQuc2xmCmAbq08qdRL8VqYLM
X-Gm-Gg: AYBFou3ZQzS2NY+B3Hi0MlGwIOXCoz3GDtU2zojGvdpX0Zb/wI3lbLINBJ/e+22+5EV
	xCfs5I0iMQIyioUFU/VhVXGUpyAuaw6Zei5gZFnZiNAGRW7QB+iqfOXRwr27F8jtqfuL/pGuNyW
	kYx+W1BE4FfBiZAoC4Yyqvo3rJfyN4JrK8symT+H4MfCJJNjWitLCY5WBorEu/iwToXvbg0v5H2
	SLXOLuYbsfN31S8QBac6k2n8DqpeFgkwr9/2/ZxUVSn9DBjywixjYij/McS0yM43cK1VGyYteAL
	Ljr3yz1w5PZlwe3CNVzATtm9nrkITjYZ2MWOzPbDy5/wfvBd3DK0dKPRAVZ/V48c5oEzglgMuKZ
	080VJY9CfvcFURRM/re6BF+NX9oXowarfE4aTIHoPBbthrJhp8V0Lrp4UXBT5tkT2+M9oUETF0v
	WgSRNRyGt+9IPykhAPwGZwcXXVUeYKDxxbjd3wNRmr6V6pSRysz7A48z0Gfjw5Q4n6wldblmHyr
	Gp+wKQT86fKmhF7kEytidIie63qvGtDHBOMZcAGI4V9GPJDVQpGacd3204ccusFGe31GTyiCqOo
	1AT5
X-Received: by 2002:a05:7022:5f05:b0:144:fbc6:59dd with SMTP id a92af1059eb24-146d0871d65mr5262508c88.45.1790509629123;
        Sun, 27 Sep 2026 04:47:09 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145a7318afcsm17450424c88.0.2026.09.27.04.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 04:47:08 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v7 8/8] repo: add path.cdup
Date: Sun, 27 Sep 2026 17:14:20 +0530
Message-ID: <20260927114420.59724-9-jayatheerthkulkarni2005@gmail.com>
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

Scripts sometimes need the relative path from the current working
directory to the repository's working tree root (cdup). While this
information can be retrieved through `git rev-parse --show-cdup`,
`git repo info` does not currently expose it as a scriptable key.

Introduce the `path.cdup` key to `git repo info`. The key returns the
path from the current working directory to the root of the working tree,
returning the empty string when invoked from the working tree root.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  5 +++++
 builtin/repo.c              | 23 +++++++++++++++++++++
 t/t1900-repo-info.sh        | 40 +++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index fb5aceae8f..7e14aac244 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -104,6 +104,11 @@ values that they return:
 `object.format`::
 	The object format (hash algorithm) used in the repository.
 
+`path.cdup`::
+	When the command is invoked from a subdirectory, show the
+	path of the top-level directory relative to the current
+	directory (typically a sequence of "../", or an empty string).
+
 `path.commondir.absolute`::
 	The canonical absolute path to the Git repository's common
 	directory (the shared `.git` directory containing objects,
diff --git a/builtin/repo.c b/builtin/repo.c
index ce78cdc44e..d4083abedc 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -78,6 +78,28 @@ static int get_object_format(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_cdup(struct repository *repo, struct strbuf *buf)
+{
+	const char *pfx = repo->prefix;
+
+	if (!is_inside_work_tree(repo)) {
+		const char *worktree = repo_get_work_tree(repo);
+
+		if (worktree) {
+			strbuf_addstr(buf, worktree);
+		}
+	}
+
+	while (pfx) {
+		pfx = strchr(pfx, '/');
+		if (pfx) {
+			pfx++;
+			strbuf_addstr(buf, "../");
+		}
+	}
+	return 0;
+}
+
 static int get_path_commondir_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *common_dir = repo_get_common_dir(repo);
@@ -252,6 +274,7 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "path.cdup", get_path_cdup },
 	{ "path.commondir.absolute", get_path_commondir_absolute },
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.git-prefix", get_path_git_prefix },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index b689445b7a..c600074c24 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -215,6 +215,46 @@ test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.cdup at repository root' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		echo "path.cdup=" >expect &&
+		git repo info path.cdup >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'path.cdup in subdirectory' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	mkdir -p repo/sub/dir &&
+	(
+		cd repo/sub/dir &&
+		echo "path.cdup=../../" >expect &&
+		git repo info path.cdup >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'path.cdup cwd outside the working tree' '
+	test_when_finished "rm -rf repo" &&
+	mkdir -p repo/tmp/x &&
+	cd repo &&
+	git init test &&
+	(
+		echo path.cdup=$(pwd)/tmp/x >./test/expect &&
+		cd test &&
+		GIT_WORK_TREE=../tmp/x &&
+		export GIT_WORK_TREE &&
+		GIT_DIR=$(pwd)/.git &&
+		export GIT_DIR &&
+		git repo info path.cdup >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'path.git-prefix at repository root' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.56.0-rc2

