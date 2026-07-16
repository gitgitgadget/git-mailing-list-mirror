Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F64923D2A4
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 01:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784165071; cv=none; b=SKXRKQkV770YFrA7aRyu3SbmnbHcjSLCRpXY+b6HDUT+yr8gZ5FTCzcNUv0T1K58yTtmoUe6SUJZyYgH6JCSNL+RQWZUdtiMqn3aHVzyJ3qzBrWLwx6TIIhaU+PlswBy/V3EWKXFL4x1TPvhz1UqLa/DkcHFozc2cyRl/wtfl+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784165071; c=relaxed/simple;
	bh=D0UzlKS8KNciqFkG/qLNPAwNkJ3q5dFcRzV5tqakWDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoD5FuuGxdjW7nF2anOrh5vKWDmNQ1jh+4c7ii1Pfkw3PQyzwau4pkpafKl5xjzVdaMmvnC2XC53QVG+7dA9vphXryB7k06FqnyBSpVlItu7rxh/RtnNvtiokx7AKqFbdU4qIgHmWjbva62deEmLQcFlCI0NasDiBE/0vThpwYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fA7RWtkt; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fA7RWtkt"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c981c2c37cbso3600457a12.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 18:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784165067; x=1784769867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zay3cx5eKZG9Q9J+UQQRGifWu10M72QE9f/xrYkNXBM=;
        b=fA7RWtktg7FOKoUiYj2UqS6ybPpcH536Ojg5O1ZR7ep5PFRZEhBzbTmlhDbuUs/EmN
         XoTt8rNLAkhAL/04PntZiz75JOxWPirAhja6T4o/xtaFpsX0YeUGBf0cxGSUliFzhK4J
         aehPWOvza4DRgW22MdSVaLshxy/3YXc6ddpWovCcIRezcv6A48rCtrvnxofiyzLtA+Vm
         EoKsr06Em7Dm+MkhsXuaeVwNX9nyX81Kmo42Rgp14SnV6QjIChAYZIdon7LE+EQYnHG6
         qd1rntqsQ/d1oSKQv6kVS5yI2rQXhUM/a+mihYsGm7m+7Jh7L70KwqNCm2wvk70LPtHT
         JhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784165067; x=1784769867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zay3cx5eKZG9Q9J+UQQRGifWu10M72QE9f/xrYkNXBM=;
        b=tCfseB6UXgzer0rkmBZZpGs76nk3x++DHtNmeNbtt0wYTdXSALacjoM3Nau0E2e0c0
         K965gtvf2M8u6Ltk2Un1sxgxj47OkWy9qCbqbKGX5DtFQBgpkB6L7NbshgsNL2Fm7O9b
         Pwpwrta6DBtpfICKn1HYVsATE41hosJ1UQNv43vCo5JYXWkIL7aknim3gBeBKJa2JKtO
         XO8xtIproDtdQwv5BPFgynhexfmFTYiGnKD+sPd0o6KF2XHtEaGiyekd3uBWm96myvEW
         ojKum8whDSLyVnvyyMBbF8hZEYGFcSKYfpgWPD6tR22Lu+VabAYjCBUnNlZ9b7pS9IHC
         3q1Q==
X-Gm-Message-State: AOJu0YzkNFFmL0usjT51vaQhNkW+Oj71VZ+luBYpQUr9sIatfU3gK4MB
	OdPhJAfc+GPcRZ0DdB4xuwR3+pReMvvHE3c6eCe3aV0HYci7cIJRbq6QRqNHIQ==
X-Gm-Gg: AfdE7clEAZNOiUKEj7aQFbgUbCiUEhG+ZemCXfmNnOjaHRShQ1oAn2vtenvq+EjGhZP
	TFSZxuctJAUiahJQN/KvyowLDSZ3ms7Gg/87+jSswOqgSSXapYjvAHIugA5ZQSHYsZhjU/rIUzK
	Y/mQTtrwFyENHZB+I6Beeb1QBjeELnqZpThJhYg0u1SqibyWeesg9uHsADO1r/p07ytOZueuHTu
	Tksfl8YRBIQTvU/cZXP1ZAOj7d6GLNOL0ifKIIPem4fSH8GQiL/UfeeXInBOaAEJgG7fr4pK+/3
	q7wpCSJArkR+2QmQUG2G9XOksNbCZ73JmEX6JYDG23zp8A38QSJcosMZKTU/U+1EzqGHza4Vh9X
	hUGMAoLPvOLIejqjz8Qvn7Yxu4DQu6YG57DW5oCVXVVtcNCZg/mBpnuQfGLMhzTo/LA2x0dArZD
	2gjSFTrG41sOFKEGhIvjKEw8OtV37SiOHtQfDikFwrvKZyclzNHH5qwwgDFlEjV/eYIu7aLjf8R
	u70Ay4sgOwF
X-Received: by 2002:a05:6a20:6a03:b0:3c3:812a:2198 with SMTP id adf61e73a8af0-3c3812a62femr2891311637.4.1784165066760;
        Wed, 15 Jul 2026 18:24:26 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6e9edfsm5377490eec.28.2026.07.15.18.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 18:24:25 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch 3/7] repo: add path.objects with absolute and relative suffix formatting
Date: Thu, 16 Jul 2026 06:51:34 +0530
Message-ID: <20260716012138.6714-4-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tools and deployment hooks frequently query the location of the object
database directory. Currently, this relies on legacy parsing methods or
manually inspecting `git rev-parse --git-path objects`.

Introduce `path.objects.absolute` and `path.objects.relative` keys to
`git repo info`. This allows tools to discover the object database
location safely while natively adhering to active `GIT_OBJECT_DIRECTORY`
environment variable overrides.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  9 +++++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        |  7 +++++++
 3 files changed, 40 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 03aa57942f..8429a44b43 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,15 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.objects.absolute`::
+	The canonical absolute path to the repository's object database directory.
+	Respects the `GIT_OBJECT_DIRECTORY` environment override.
+
+`path.objects.relative`::
+	The path to the repository's object database directory relative to the
+	current working directory. Respects the `GIT_OBJECT_DIRECTORY`
+	environment override.
+
 `path.superproject-working-tree.absolute`::
 	The canonical absolute path to the working tree root of the superproject
 	if the current repository is an initialized submodule. Outputs an empty
diff --git a/builtin/repo.c b/builtin/repo.c
index 82359473e9..d6bdd5bcfa 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -122,6 +122,28 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_objects_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *obj_dir = repo_get_object_directory(repo);
+
+	if (!obj_dir)
+		return error(_("unable to get object directory"));
+
+	format_path(buf, obj_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_objects_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *obj_dir = repo_get_object_directory(repo);
+
+	if (!obj_dir)
+		return error(_("unable to get object directory"));
+
+	format_path(buf, obj_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_path_superproject_absolute(struct repository *repo UNUSED, struct strbuf *buf)
 {
 	struct strbuf superproject = STRBUF_INIT;
@@ -194,6 +216,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.objects.absolute", get_path_objects_absolute },
+	{ "path.objects.relative", get_path_objects_relative },
 	{ "path.superproject-working-tree.absolute", get_path_superproject_absolute },
 	{ "path.superproject-working-tree.relative", get_path_superproject_relative },
 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 220b3d4d3d..260f4fde43 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,6 +213,13 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_repo_info_path 'objects standard' 'objects' '.git/objects'
+
+test_repo_info_path 'objects with GIT_OBJECT_DIRECTORY override' 'objects' \
+	'custom-objects' \
+	'GIT_OBJECT_DIRECTORY="$ROOT/custom-objects" && export GIT_OBJECT_DIRECTORY &&
+	 mkdir -p "$ROOT/custom-objects"'
+
 test_expect_success 'path.superproject-working-tree absolute and relative' '
 	test_when_finished "rm -rf sub super" &&
 	git init sub &&
-- 
2.55.GIT

