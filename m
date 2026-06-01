Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFF13DCD80
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327387; cv=none; b=BlAEMx2al501uF3a5jwQGIHR9Q9OKM4u7lScsRcs6PxqkgGZmqpkEZEXm7eEaDZhtpbIu+i4AZOgrl5ka9196PyQ+UprXKgVinTNAXicy1mVkpPtSv7FFGY9vXHqtfGpy2n7da21o3u3NoAa9pYxJwKamR5WIoToru+xXZ+K/m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327387; c=relaxed/simple;
	bh=rcV5aLsnvo4Z+fRh7B/5KMxxi0V4nP/QrtbfDJCxfKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOviH3ZoBtT+MuJHLtUMIbiEfbdseO4PoTnnWWBsFSAghjUulAO9YaZsIN7Ogtn3tKJveGjQCAX1PbS9fBnitSYTnwrQG18+sR465/WRBZY1q0A37nFDt1cDfSwnRjPFs8Yj0poDSJk2i7G2v/EILVWxrLz6wspRtLvA/S6eAf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MN/TvIRq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN/TvIRq"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-842319576d5so782311b3a.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327381; x=1780932181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBAIudYg5e8QxfMT5whiLM8UNdlS/+XTuMM7s9+V/7U=;
        b=MN/TvIRqxG4LNyFkWOrX81TPyfntnuBbR5s9lHHU4h1Z1gAMFec+pp56X/gbV2VqEa
         TrJVAfsS+Uh0qgrUrtw/KsLPWwkNlNhvStcWapW9p4p0pJjP6wLGFeuJhTir/AZw6Hji
         UXBzY2UU+M09BCHEyZvX/nP+JHPl2zeiCTfiCmB+lje2DIPK2yAZpihXnxku1AudYqIu
         ZE9YMHnhCkfhr7hq2Y9FwxtEjcavxhiBofLXuarAz7B9kJ4vuP7yLs/xkIBmjeGyRXzw
         g0y5crPw8tknr257L9gIcu46S4/YBXknZb6ibhZXtRmF3ZmNOnG99b2FKss+8YfS+rPG
         TM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327381; x=1780932181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RBAIudYg5e8QxfMT5whiLM8UNdlS/+XTuMM7s9+V/7U=;
        b=GUtiQfretp5tkqpDKLoMu3DlBCDfaroQkHdo83TGBHfyRHjSG2KGdGnFInQiEdME0E
         bfAB4ENhLg3JwBMnjFGIh4vZ778+BBr3cYqD0S0XNT+se712wOtcnC5/Kuv62G2DMoC+
         SO0WEx5Kf9Ap1CE1feVgQYU9F+hvAgVCYwoCB3C0fV61BdSGPAh5HWlDMhRnEQnSszym
         otbYaPaf8ZGCATm9/2Z9EIMXibHfV63wnEB+HcNEUEFlkwafRCmEL90aQ5Msywdo7NFN
         grthkG6mnvibhBeFbXUPh7mAkzaOGKXeOIdTBPNihjv3vuJRFFf87fy7z5+1riTwxzat
         Kt0w==
X-Gm-Message-State: AOJu0YxoYPrlMbErUbcuby/3O6NiY9XnU2N77rMfAcp8MdiqUUxS/bFn
	AISRfU5p+dVlHQIua0d3GzVGoeghDqW68fmeiLzVzTGepo3f8xYqgN5rkmavag==
X-Gm-Gg: Acq92OFR8kAcKpXljhydKlCVpE9iM4nWgyyGXJ8q9kwnX4lxYSX/YZ0EYvSxaj7SL83
	ufdLJP/11hUh2NOt4W3D5Lp2n1JzrfCv5fnxu4htR2k5Al7jrjc32vngbin4lKw79W9PQyIJONC
	oRF6zTM40JofzasRpoty1sZadnWQ1YvD+r/uolQGzgKAYibmgIOc9usET31cMlQjttCOimmufpX
	BSDvXZZRugGf0w3Xy+pzHZsuZoC6Mt+miSLcOkgo3f0aPlaGzNtw5UUOAVwUi7uewqiIw1XNtfa
	FdZz5VngU6YcBpBkJNPhVGq+mBZYpmUgd2jabTQ3rnYX6+eKFU0FLAkgnX8Uc8Lu65w63W/sasd
	c62gnXo3ker8RelJ8fw78tDu/mIsFnyMudVRyH/Wl7BY5aqHPb8uFgtt6KSzvNiPGZTJB9J/HxG
	DfMB50urI9/dZ5pK4xyJp2aPsCS41Kf+iMlsxfdW3MIwY0hizcVLFjafX2V6w1YsC4uqkNoe4xH
	qer2xjyQw5krCckV30GpdVBVwPVGum5t1gBD+Ov4hqh
X-Received: by 2002:a05:6a00:22d2:b0:842:614e:cc97 with SMTP id d2e1a72fcca58-842614ee43fmr2096039b3a.23.1780327380587;
        Mon, 01 Jun 2026 08:23:00 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84232ef8172sm7352779b3a.12.2026.06.01.08.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:23:00 -0700 (PDT)
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
Subject: [GSoC][PATCH 4/4] repo: add path.commondir with absolute and relative suffix formatting
Date: Mon,  1 Jun 2026 20:49:50 +0530
Message-ID: <20260601151950.30686-5-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce `path.commondir.absolute` and `path.commondir.relative` keys
to `git repo info`. These track the repository's common directory path,
extending the path metadata engine alongside the existing `gitdir` fields.

Update `repo_info_field` to store the new keys in proper lexicographical
order to protect binary search operations, and expand the test matrix in
`t/t1900-repo-info.sh` to validate separate queries, bulk dumps, and
key listings.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc |  9 +++++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        |  1 +
 3 files changed, 34 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index a0dca7ce88..ed7d80c690 100644
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
 `path.gitdir.absolute`::
 	The canonical absolute path to the Git repository directory (the `.git` directory).
 
diff --git a/builtin/repo.c b/builtin/repo.c
index c141ef892a..be24a5a8e8 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -77,6 +77,28 @@ static int get_object_format(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_commondir_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *common_dir = repo_get_common_dir(repo);
+
+	if (!common_dir)
+		return error(_("unable to get common directory"));
+
+	strbuf_add_path(buf, common_dir, startup_info->prefix, PATH_FORMAT_CANONICAL, PATH_DEFAULT_UNMODIFIED);
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
+	strbuf_add_path(buf, common_dir, startup_info->prefix, PATH_FORMAT_RELATIVE, PATH_DEFAULT_UNMODIFIED);
+	return 0;
+}
+
 static int get_path_gitdir_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *git_dir = repo_get_git_dir(repo);
@@ -111,6 +133,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "path.commondir.absolute", get_path_commondir_absolute },
+	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "references.format", get_references_format },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 7c7dfbb052..dd2706e1f7 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -184,6 +184,7 @@ test_expect_success 'setup test repository layout for path fields' '
 	mkdir -p test-repo/sub
 '
 
+test_repo_info_path 'commondir' '../.git'
 test_repo_info_path 'gitdir' '../.git'
 
 test_done
-- 
2.54.0
