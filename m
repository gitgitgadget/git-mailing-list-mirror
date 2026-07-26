Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D54218C2C
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785062957; cv=none; b=oMod6V2DppYYnWr7B1skf4QVN5hCD5DyjfnL7NuGcnyydVSbxhcKAun/vlv3k3DXpveEnu644kTSwWSn0U2S+6ttplCHabPj7sxP51JD6bXwCv8icBaoiuWpMmh5Pk7nQIuKhgkBaCx2tQyc2SQyh0N8xQSSrJC9HTIzX7j/yQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785062957; c=relaxed/simple;
	bh=zei9EjS4tnNJ9TVzTloFLnzD9hUW6VFsdEAoQvYllJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+uq9ynyZd6EzhAeiPUNiQeYRkErZds/oKM7Hc64LseznVqKf6L3DYe3bK2J7M5houYRLf0wtWD1Ro0Kemc0ft+wgPEQuLVIzoEgvFTd3PED4NehEznFzpdGJOH+e517MyZtp1K2S7oNs1KZo1y6mPHfvTYD40p6ruiLm2wcHpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ns3fBHux; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns3fBHux"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e58034d05so1952220a91.2
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 03:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785062955; x=1785667755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=70lPGpDIc7cUnUUoq0w6Ir61EmtDinex21UGCxj0AAc=;
        b=ns3fBHuxWHYbEQFm8WvwIqa2+f+1ZxhM3aZqXSRWJIRySYULeSBz70heOKgdHQi4mu
         WxkTrjqekLOKbEP2xZ1sL9EFKBSc/RSFHtYeuiiewOvexJRxYHB1D2rpwnLaVN/ToKoa
         rmnW7vin2lfW+gTuMrwq6ySVb3Yjk1JbpH3vtV+XIVQjxHskJxFH1D6NDkLEy8qAKK0/
         A5wxM8ctynRkLFYhRG0MDAyAAP18/vXueItcnO0POjRmRLsmUbbx2gnE5eIGLSd3DA5A
         GLhPy7zw2NU/44nOg4a2/hAa5P6VzpsQaNWUlHKHcW3gMTLzPRdPhFX+dJlzcgpJkMlJ
         73ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785062955; x=1785667755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=70lPGpDIc7cUnUUoq0w6Ir61EmtDinex21UGCxj0AAc=;
        b=EaUbk03KPSdgjbRwIiS0DZ6v6zLt88sA3ZeKjigiMELtBWV2Q0Uqd6Gy3AXMXhIZEc
         MjDuuFF8BHH0lsWqAzH+hIGK3IJvQGe02/FfeZBXzpBG8IopZhZtqi/f0p5RqUgfVw8L
         DEruGLc8OaBgL4hmFRTbgyLMsItiKWmduL9GRaeHOIYO+5CF7uAJ1ziz1BN/21ZraryW
         UIabj56adeM9/oT2NzkIEh+a1wmBztjkdx/U+rZZRt7py1TnKNGtDQnDMdVVdsfbe3Ik
         8TKsvDBbxkntp+r/st1Ww9hY3bZmmexzRqjJ0a/riyMnBFpW5ttrQQrWuRNn5JhdUg7d
         g0HA==
X-Gm-Message-State: AOJu0Yy2MUjja2epwUAy/RAQcSvUnmw9LKua+Q0igrNTOPDXJtX7cXc2
	Y87J8M8HH7MzcD8YK+7kceJ2poXn1DvJ+u/Qxa/ThuEvVeaixrVdl/Ac
X-Gm-Gg: AR+sD102qw8vmNGVl+wZP+orvsGyDNLZc1YIj5YZAe2d4f3QDHXNJCIzQjF8QVIis81
	8iBQ9mu6epQlZe+wjwQFqyMP7Dyc/P8AxJtZAuCK/8P5g8m3DPFuJXpmBc0zHriaABgNR443wsg
	0D6qlBm1ksl38W9hcVmn0SHGO+87B/a+6f/Wbm/p+4I84pNPWI0N+Agidob5lQBS9UjM/KC2SzU
	+7QEw3P2AO6Aq8O0/KcYqT6PvUDxCq+UExri7XOF4ti0bvs7DoO+SbuL05uF/Ldt/6ouCqvTcJ6
	HUWZXtli1d4JEWolzKhl0F+A+Ka0AruEgRgV6PDHamWJgfJKet3BxNR9E+CgmPUrulEKZ+3zS5I
	QZVF06YFl42+AhoZ3n3ha/3u2N3/yuJfFzXgRXott18oJNDGn2BwkYJf1mKmhbg4BanaBLS54P/
	uc9bsAJD/N5pIRmdaKiJplVN3GmHLBl25rE+DWJDlOihUetzws0LtMYM+909joNFyuOf0Pm4AMx
	ulhJfSOlswr
X-Received: by 2002:a17:90b:1b01:b0:37f:bfd6:8b40 with SMTP id 98e67ed59e1d1-38f293cff5bmr4538300a91.5.1785062955426;
        Sun, 26 Jul 2026 03:49:15 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1255sm30371438eec.4.2026.07.26.03.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 03:49:14 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [PATCH v3 7/7] repo: add path.git-prefix path key
Date: Sun, 26 Jul 2026 16:13:43 +0530
Message-ID: <20260726104343.16933-8-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts and command-line prompt integrations frequently need to know their
relative depth inside a repository working tree layout. Currently, this
is retrieved using `git rev-parse --show-prefix`.

Introduce the `path.git-prefix` key to `git repo info`. This mirrors the
prefix location tracking framework as a standalone key, returning the
exact relative path offset complete with a trailing slash, or an empty
string if run directly at the repository working tree root.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  5 +++++
 builtin/repo.c              | 11 +++++++++++
 t/t1900-repo-info.sh        | 19 +++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index def888da91..98282ea668 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -113,6 +113,11 @@ values that they return:
 	The path to the Git repository's common directory relative to
 	the current working directory.
 
+`path.git-prefix`::
+	The relative path from the top-level directory of the working tree to
+	the current working directory (including a trailing slash). Outputs an
+	empty string if executed at the root of the working tree.
+
 `path.gitdir.absolute`::
 	The canonical absolute path to the Git repository directory (the `.git` directory).
 
diff --git a/builtin/repo.c b/builtin/repo.c
index a97ad71649..b93c140c74 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -100,6 +100,16 @@ static int get_path_commondir_relative(struct repository *repo, struct strbuf *b
 	return 0;
 }
 
+static int get_path_git_prefix(struct repository *repo UNUSED, struct strbuf *buf)
+{
+	/*
+	 * startup_info->prefix is NULL if we are at the working tree root.
+	 * We add an empty string to ensure the buffer is cleanly initialized.
+	 */
+	strbuf_addstr(buf, startup_info->prefix ? startup_info->prefix : "");
+	return 0;
+}
+
 static int get_path_gitdir_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *git_dir = repo_get_git_dir(repo);
@@ -278,6 +288,7 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "object.format", get_object_format },
 	{ "path.commondir.absolute", get_path_commondir_absolute },
 	{ "path.commondir.relative", get_path_commondir_relative },
+	{ "path.git-prefix", get_path_git_prefix },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "path.grafts.absolute", get_path_grafts_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 15a4ec9b78..2879e54668 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -207,6 +207,25 @@ test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.git-prefix at root and in a subdirectory' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "path.git-prefix=" >expect.root &&
+		git repo info path.git-prefix >actual.root &&
+		test_cmp expect.root actual.root &&
+
+		mkdir -p sub/dir &&
+		cd sub/dir &&
+
+		echo "path.git-prefix=sub/dir/" >expect.sub &&
+		git repo info path.git-prefix >actual.sub &&
+		test_cmp expect.sub actual.sub
+	)
+'
+
 test_repo_info_path 'gitdir standard' 'gitdir' '.git'
 
 test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
-- 
2.55.GIT

