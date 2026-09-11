Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8896339FCDB
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138093; cv=none; b=WNxVc0tFEIjAEtRX1e1KUYgQ2Hwimp2AbyXVN9Lzgn7rTYp/DQl66lGU7Qee3mfMki4R6GcMtaLo4rE+JrX5G70gLVT9bbd4mDzyCGCz2+B1W+tDXMqrbzrBnj4FrI10YbOo/hJMreG7tWrUqYrS+/ZcfiHE64qDJGtI+l4pc2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138093; c=relaxed/simple;
	bh=R2+2AkjcCAvVmFjuocJOMT8goER3xyF8MULfqVpTPXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dERhEWssonzJDohgC6x8cQVq+C4JQ6hspheccegyqheRVCahCVz2p5V8ahshS5y5CVyRV6yoVHG339HisafuLcmtUvrb0ghIfWtWjMGs6eQaNRB62MwPisNumlZZ/fHqxypxAmFGCDdJf+rXac26Vv0UdTo3TPbMh3RGpfZXyIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8yZnsDK; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8yZnsDK"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-469d76ce704so994500fac.2
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 07:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789138090; x=1789742890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LOBW+9aFsqboyB0dVz5jLWyhe0J2Tzdr8+z/fE/TJtY=;
        b=K8yZnsDKo1wsa7dsz31YIs4UJUNWVWQkWAO4wO0gYZ1J0BtoJUyPb3Y9YJ//mYgZL9
         qKpF3vUxwB+bwQbbiXnETvxkkfL41BsixODVu+GClQ3JTl6c84L1UqAQjCGTU5lUKI0m
         gY5e4rn7mC0gXIp5+5OAPqRRTfpe2ifwvdcGDlBDQwjq5fPLeQTJvCshPIfjkNswBte0
         lO5v6Ey2MRmqBp2UUIUWDbxC6S3MizdcRJhvGCkjzc8TciHuirX3ahkqhu5NSToq01TY
         QguIBUb7TiNXV4Yt956sb4akda4b/GVTRXP2Goi2v2ToQlZXm5vFFye52hk2LWDyA4Yt
         Kedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138090; x=1789742890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LOBW+9aFsqboyB0dVz5jLWyhe0J2Tzdr8+z/fE/TJtY=;
        b=VYyaqc9iGD6ZYfZNJLrQDfktgC8Egr8ksfwrmG+YfMWH8X2hjhQVZq9MmpCxDQjaU3
         aV41Rs2a6clT8YRD8hQs0p7/FjcO2AzS49i0fI9GWpKsKnqrZ/zORBrtWpb/dt5e20XC
         wsN1DHuJgDVXe0Za6WzrZBWrhAdns6zijT9dkPy+l5T1TiurVHoP1VggkNBmhOMeErfP
         eCtf2IHm21bBoOnCH/Jv5MTHH57TryBKlFIfm9YK7bzFDpljkkGpHHNlNxZAB4r3DqI+
         RYaJBSiHKYJgWQYWz/2RXw0YoU0Ntv2wXS0ejAe4lgGViULsrmIImTflTt3/Ck/XZzdq
         MjMw==
X-Gm-Message-State: AFuF++kUsiWeLJumwSXfO+NW0dWYfgUWkaE8FfBmK7bfEKKpAUeafGqE
	VYZ/UyJYdvWfB2q1Bv/BPB5fHPwHRCxyZn+Iz87ZgOFAZClwMUkRmZDZ
X-Gm-Gg: AYBFou1NIKEzw8mkNm2n61uKtXpXCXXB4pPo1KONdVpFxW+GEH5q7uQtuC2SK8B4TlZ
	atU+if93Tx09ywYDTZA/QjJWm3rdcFWPBnDblHOMGY8Riofj56na7znMNT7Pq7zGqPxlfzk8ma1
	qXChOJ9nKg2NSzCkRvElJ/Ekld9bDKe8q3myQqOJPMLy3mCUNqGEnPegPUogk4qDszAqjXM1paS
	Cn+2e8WFVxs11mXr5KzCPt0TwCwe2HUfTqGNu6ixBRdSP2qLemuW94xDyiLzd8djKepHoHV5WHz
	//TXZpCZhY2Lq7FQDNC4DgiZsYnXmSQe/Etv/N5NfEnorBFaKSSuIS7F+zHJpQkVha7X9TSxnqk
	/qF36wZwj/EP9IG9MR1BlSCHYev21LBleV9KFxGkoy515vOQKOXnggHW0evU/Y4iDPref+DAmVY
	Rv+pJRaF/6zY7+tJgN762LEfahDk7mfIGyOI2a/GOsDQKvR8aX6676tjeI8cnnVk7unCFZfk6Ew
	jGPslV9gRBH9pkp4qUMFF7RBScDxU3ITD0V4Rva//omcFtC1tg/+7Px8WicUGyPD/w8/9pcZy2W
	Z5jL8g==
X-Received: by 2002:a05:6820:8590:20b0:6b1:9f9d:7a04 with SMTP id 006d021491bc7-6c0b8d892dfmr2512906eaf.7.1789138090490;
        Fri, 11 Sep 2026 07:48:10 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b759d0sm7843335c88.7.2026.09.11.07.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:48:09 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v6 7/7] repo: add path.cdup
Date: Fri, 11 Sep 2026 20:15:19 +0530
Message-ID: <20260911144519.1011780-8-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>
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
 builtin/repo.c              | 15 +++++++++++++++
 t/t1900-repo-info.sh        | 23 +++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index fb5aceae8f..0a30c0d6ab 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -104,6 +104,11 @@ values that they return:
 `object.format`::
 	The object format (hash algorithm) used in the repository.
 
+`path.cdup`::
+	The path to the root of the working tree relative to the current
+	working directory. Returns the empty string when the current
+	working directory is the root of the working tree.
+
 `path.commondir.absolute`::
 	The canonical absolute path to the Git repository's common
 	directory (the shared `.git` directory containing objects,
diff --git a/builtin/repo.c b/builtin/repo.c
index b5e1567809..bb129c9fee 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -78,6 +78,20 @@ static int get_object_format(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_cdup(struct repository *repo, struct strbuf *buf)
+{
+	const char *pfx = repo->prefix;
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
@@ -258,6 +272,7 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "path.cdup", get_path_cdup },
 	{ "path.commondir.absolute", get_path_commondir_absolute },
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.git-prefix", get_path_git_prefix },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 10bbec8139..5790d70316 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -215,6 +215,29 @@ test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
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
 test_expect_success 'path.git-prefix at repository root' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.55.GIT

