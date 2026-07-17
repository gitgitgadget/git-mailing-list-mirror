Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77F33FC5D3
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295324; cv=none; b=ERgNUMsUqn2LnYgMn0uyyMA9yFzk2m7PURQ73bT1apctwQWqZvOh+BM3pxct+/X7/gx8ct9ddVi+EPslhnVEehf7fFukRwL1+Ampr80jrozhksr2dx2d0k/yAOEqNnx5OJvDptqMYMcu/9yxLxpFLbP3CPlyejgw9flmiHrgmZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295324; c=relaxed/simple;
	bh=g1touH7pr+Nytc2Bjf2N5BakiFK79JoZs4PzRtlZgmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=df5oxrdohPN8n8qbe62YQyRnuBgLWFTHzFXf+t+e+0gRi3Yc4ldKMFsuDNaEqpl509AocNTCrkXbT2T5gJfB4iHfQJqDfwdcYEFenxeeP+efSa5BVIulKnzfCeYpOF1Ii0/epbnjlsUDEiC067zNyvi2o4WzuaNycVW0kaQ3+uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlRgrNI+; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlRgrNI+"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso5391594a12.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784295322; x=1784900122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O9vgetOkdCTp5BrK5JdaOW3/QZo8zlfdTsb99bRwe6I=;
        b=dlRgrNI+JYyJDdB3x4XUtHBM4xl2qa4Uq6g+sE6OE2uABKf3MKvb4hJh+jIe3jBZzK
         ocNtqVrOgHsD26cVnuFR/U41NXfwXMZ1LBb7y7nvs9XE8wPYTw6MhTFINYHeGDGXwtkQ
         jrjvW7mrf4aTlyp/jhVg3tNUbLDp3MG22dxCMCebyiKAEIVL8pgzSPmfRHdegk6Hje5N
         GoisuqsMcowSJuWBHuelH8MUW+lLaZynr+uNW9gBLZwsRYd6v0zyvaXhw/5q35iFP/Vf
         I3JikQQ8wE9XuZ3kxyAZdECw5Z1h4cShWr+zGb7P9C+KkHfbepqNFYsy5Yx0ylti0Esz
         BecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295322; x=1784900122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O9vgetOkdCTp5BrK5JdaOW3/QZo8zlfdTsb99bRwe6I=;
        b=hBHw0UrOIl175JxaopMrnV9M4eb2Q5n/noVhXbX3g1QaaDx9c3SsQoshFJUp9vN9B4
         1aADuLGaXj/yqivFgj5zk6vxGKDlC9thq42EHOxVURd0lvlHJtzUDoLWGpMJMqcRLaU2
         3gLocmtfTtb1wvTYDZPiRbJyRfL1vosPDW4egwmumVEk49VRNiEB32gvU8xmAREa4KPF
         8NA6xE2f1dgfCyXrl/kecrMNKIASdlkle6RqT7XmiiOk0VSR++OhFgLT2k9rxEc+mIbL
         6VCwzNvjXsXKjYNw6cOEf8KYYoO+qa2ZLfwpowRrmr5ypbOLHriPePQaB5JEsmxfoRPo
         y3+w==
X-Gm-Message-State: AOJu0YwyaJ+zB9iU70H3nUG4Wo/449+WhbEIs3jzc9AYiwfv0GTmag+f
	HZgk4/PaWToblLMHJOUQ7+RabZGEWi/j8X0DTeuDM6tWp9zhZqiAn2fHQDHwXw==
X-Gm-Gg: AfdE7cnVp1KuuBCejgOOmZMD199rKgxFsSFoPpOlLV/3Jp2n20k2W2jMMJmgHr4mCuN
	s9MLftH6wGYrNEj+ld4ZfLcW+mApFgIxOu9PrCvmPsuettBhlIohs4gBjo5plMrnggRpIoMAIib
	Ay3uO3suMpyzK2crbw1UbGJGRkU7NcxSxLSI03+OvMoO2m0b5dBTjzCaLPCA0VVebmJAerXJr5g
	zuR2iF0Hi+/w0U2kByaitfI4GXe/OhHOT49QUieOAEq3rRQv4qp/Ha7/uuOfTt1TMt/e/cFJweO
	1qDqFa+twS9OdHburaBevEU6kM3KyWKqe7aVCcixD0ikClEvALDOor9OPTiCQ+BKFQ/jKI46Ob1
	TeW2896DK7WE0KJ1xB1vaGNq8TLa33It1p6o6a56wrHqAyX55uLlbsesKpSil6ZhM0CiFqT4KYj
	aCUX8DrVVBg4kZI3L9pbrbeDsJqQpKIkiRpdGfKEUuCDnCNzuhc9GAW1x93lEXfSTkRzucvp7Uj
	sS2YYLLUIDM
X-Received: by 2002:a17:90a:d40f:b0:38e:542:6485 with SMTP id 98e67ed59e1d1-38e4b4461e1mr2652426a91.12.1784295321686;
        Fri, 17 Jul 2026 06:35:21 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20cfe3sm7867411eec.30.2026.07.17.06.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:35:21 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC Patch v2 6/7] repo: add path.grafts with absolute and relative suffix formatting
Date: Fri, 17 Jul 2026 19:00:14 +0530
Message-ID: <20260717133015.32040-7-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260717133015.32040-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260717133015.32040-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

External toolchains managing specialized history rewrites or legacy
history splices require access to the location of the repository grafts
file. Currently, this requires a legacy call to `git rev-parse --git-path info/grafts`.

Introduce `path.grafts.absolute` and `path.grafts.relative` keys to
`git repo info`. This allows scripting layers to query the active grafts
context cleanly while scaling transparently with active `GIT_GRAFT_FILE`
environment variable overrides.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  8 ++++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        |  6 ++++++
 3 files changed, 38 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 3a837c573e..6c962620ec 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,14 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.grafts.absolute`::
+	The canonical absolute path to the repository grafts file.
+	Respects the `GIT_GRAFT_FILE` environment override.
+
+`path.grafts.relative`::
+	The path to the repository grafts file relative to the current working
+	directory. Respects the `GIT_GRAFT_FILE` environment override.
+
 `path.hooks.absolute`::
 	The canonical absolute path to the repository's hooks directory.
 	Respects `core.hooksPath` configuration adjustments.
diff --git a/builtin/repo.c b/builtin/repo.c
index 66bf4c67cc..a97ad71649 100644
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
+	format_path(buf, graft_file, startup_info->prefix, PATH_FORMAT_CANONICAL);
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
+	format_path(buf, graft_file, startup_info->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_path_hooks_absolute(struct repository *repo, struct strbuf *buf)
 {
 	struct strbuf hooks_path = STRBUF_INIT;
@@ -258,6 +280,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.grafts.absolute", get_path_grafts_absolute },
+	{ "path.grafts.relative", get_path_grafts_relative },
 	{ "path.hooks.absolute", get_path_hooks_absolute },
 	{ "path.hooks.relative", get_path_hooks_relative },
 	{ "path.index.absolute", get_path_index_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 04e6b8553c..6c47989df7 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,6 +213,12 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_repo_info_path 'grafts standard' 'grafts' '.git/info/grafts'
+
+test_repo_info_path 'grafts with GIT_GRAFT_FILE override' 'grafts' \
+	'custom-graft-file' \
+	'GIT_GRAFT_FILE="$ROOT/custom-graft-file" && export GIT_GRAFT_FILE'
+
 test_repo_info_path 'hooks standard fallback' 'hooks' '.git/hooks'
 
 test_repo_info_path 'hooks with core.hooksPath override' 'hooks' \
-- 
2.55.GIT

