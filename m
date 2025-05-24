Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960AE1DE89A
	for <git@vger.kernel.org>; Sat, 24 May 2025 07:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748072199; cv=none; b=d5NZJX1ib0c1SfdkdarBxC81LCIshr7P6G9Mpvye7zGPq/mpN2Vwa20O+wSJccmYQgE+qyQItj0jyiqfhaaKJFj7slPo02BQ+j3NOla70bERCu0alODBhg1h56yxdv6tuaUsl7O1nQRSJ2RkCKx4n+5Zkpu+IUzzWxCaE/EqHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748072199; c=relaxed/simple;
	bh=q8Akl121jmS7kRg2XglobppyvbiAT8s3aasTDTjXw8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ao4VFfi7Wph6L9WWTifWpXgEWM0JzJB+HnTv+/xs5c9e89Xvz/lsazDrgMFoEiPNuJELbNG7Mp0NJgI/ALWAgj/pguVgaFzlJcHXbuxDoLzCaHOP8C5w5xLkLwWmQKZ63Rbpi/5cVDMyciYz1i8OE/w82hXNng2UtvK138/MG2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYJPJnXh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYJPJnXh"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-231f6af929eso6430085ad.2
        for <git@vger.kernel.org>; Sat, 24 May 2025 00:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748072196; x=1748676996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zn4c4PCmDJMUg85HGnleFtljhV+IX89IZGFP+BD/+28=;
        b=OYJPJnXh4MgU4j6QeDompKmRttB5gftvmpRIELvP/O4rugLuz9o9vhFtu72gdRpkNM
         VseOc+cTMDq8qb6J2jTo/tLSBDsS90O1m6qTH3EsVUbgnNa5Pu5RlveoHM6D+u+1/Zsz
         fxwb4p0+gTSATqyLi3JVjtXrMJmbTiv/v1D/5u2DmWHxqrmUltOYEFihFqaXcgYbDf4q
         znpxkIvIVD+urGxehtlflIiZGK4c1HtGx5K50oHqyduj0iooT+B5nZDBU5oUuNniZlTp
         FEtbZ2YRfhwTVa90piFjdL0yGvcA6pWJqs6/Ic2R2D++Ol1lAa0/6oOe45Xd5bFQQsOQ
         tudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748072196; x=1748676996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zn4c4PCmDJMUg85HGnleFtljhV+IX89IZGFP+BD/+28=;
        b=fvbfLcnxPO6CmCkgqWxdzpEfTUTyzHh2wcChxgviPKOQTf4KTItlaaWOluZj9HlnsM
         5ZOn57hHYnm/o+hgg+VJsbPZBuUiw/Rt4CyqMQFZhlb6CBJicRhbZ5n+tWRcNfVMJKGE
         gFs2/of1Ux5TN2z2v8TgpxaTOFuAS9a6z9AoGMlYtH3vsBks3NWLXjBsiyRheYSWqI3u
         R05g9vbCbIVPhwLpr9hcyVHwShAlQdEG0jrAV6gqpm8ry1N/0FqgFmNasobxgXKrSyXI
         brP4s75zYKpllKIR6mbBzSk7W3yupwjWmXHp/G5R3dWrvErScPVhDQHfQKk/eLFdvTEZ
         9u8Q==
X-Gm-Message-State: AOJu0YzXokxacZCGj/jqvYjgrH7J72z5f40BCxAo7fYrjLIIfzCUNjLJ
	y+XdP84z6XXEO4ro0j3+VLDKhg6m2VbbTuEsdVHzDEddIOLnKGQBqUe9U3QduruN
X-Gm-Gg: ASbGncvnIf8Rv25IxWw0bLMWlSM1Il/vNI3RbpXcaEGL0w3Ju39ipp+HwmiuFOM1f+K
	ImV1T3gngDSRedQD5INfLwI/Y/Qi22UV4P508ndhki+cC2LQpwizXjYWVw6dn8I5rW9Jbtrixdl
	LpC3lsh9SZutb02VBrhdrDGNoB9SKD24hzkuVX7e2tCPj2PEQKu/3fPMeX0xUwmCsy5SFubYkXJ
	QbzG4PibG1j74lvhRn8aWg9q27GCYriaYy0RkS+maTaSHTA+YWIB/kkvhfwTzuRTgxg3SDhYcW2
	bnJ8atTZ2qvFOuae9/j+OKxc1z1LFc3UiqUjG63pfgpZcMNvP+g+5y2UkHjl5tH49oY=
X-Google-Smtp-Source: AGHT+IEbxUsyJnoFsbPB/RH15eZCxdq/uyTGpAyvBJ4zBz1+xCa3As1SmOIKEYHOyUP3f7z+ftse9A==
X-Received: by 2002:a17:903:1a45:b0:224:23be:c569 with SMTP id d9443c01a7336-23414f80419mr39538115ad.22.1748072196618;
        Sat, 24 May 2025 00:36:36 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231e2118b07sm131949475ad.43.2025.05.24.00.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 00:36:36 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [PATCH v7 1/2] submodule: prevent overwriting .gitmodules entry on path reuse
Date: Sat, 24 May 2025 13:06:27 +0530
Message-ID: <20250524073628.58944-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250524073628.58944-1-jayatheerthkulkarni2005@gmail.com>
References: <20250524073628.58944-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding a submodule at a path that previously hosted another submodule
(e.g., 'child') reuses the submodule name derived from the path. If the
original submodule was only moved (e.g., to 'child_old') and not renamed,
this silently overwrites its configuration in .gitmodules.

This behavior loses user configuration and causes confusion when the
original submodule is expected to remain intact. It assumes that the
path-derived name is always safe to reuse, even though the name might
still be in use elsewhere in the repository.

Teach `module_add()` to check if the computed submodule name already
exists in the repository's submodule config, and if so, refuse the
operation unless the user explicitly renames or uses force to auto increment.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/submodule--helper.c | 28 ++++++++++++++++++++++++++++
 t/t7400-submodule-basic.sh  | 23 +++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 53da2116dd..9f6df833f0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3444,6 +3444,10 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	struct add_data add_data = ADD_DATA_INIT;
 	const char *ref_storage_format = NULL;
 	char *to_free = NULL;
+	const struct submodule *existing;
+	struct strbuf buf = STRBUF_INIT;
+	int i;
+	char *sm_name_to_free = NULL;
 	struct option options[] = {
 		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
 			   N_("branch of repository to add as submodule")),
@@ -3546,6 +3550,29 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	if(!add_data.sm_name)
 		add_data.sm_name = add_data.sm_path;
 
+	existing = submodule_from_name(the_repository,
+					null_oid(the_hash_algo),
+					add_data.sm_name);
+
+	if (existing && strcmp(existing->path, add_data.sm_path)) {
+		if (!force) {
+			die(_("submodule name '%s' already used for path '%s'"),
+			add_data.sm_name, existing->path);
+		}
+
+		/* --force: build <name><n> until unique */
+		for (i = 1; ; i++) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "%s%d", add_data.sm_name, i);
+			if (!submodule_from_name(the_repository,
+						null_oid(the_hash_algo),
+						buf.buf)) {
+				break;
+			}
+		}
+
+		add_data.sm_name = sm_name_to_free = strbuf_detach(&buf, NULL);
+	}
 	if (check_submodule_name(add_data.sm_name))
 		die(_("'%s' is not a valid submodule name"), add_data.sm_name);
 
@@ -3561,6 +3588,7 @@ static int module_add(int argc, const char **argv, const char *prefix,
 
 	ret = 0;
 cleanup:
+	free(sm_name_to_free);
 	free(add_data.sm_path);
 	free(to_free);
 	strbuf_release(&sb);
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index d6a501d453..f5514decab 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1482,4 +1482,27 @@ test_expect_success '`submodule init` and `init.templateDir`' '
 	)
 '
 
+test_expect_success 'submodule add fails when name is reused' '
+	git init test-submodule &&
+	(
+		cd test-submodule &&
+		git commit --allow-empty -m init &&
+
+		git init ../child-origin &&
+		git -C ../child-origin commit --allow-empty -m init &&
+
+		git submodule add ../child-origin child &&
+		git commit -m "Add submodule child" &&
+
+		git mv child child_old &&
+		git commit -m "Move child to child_old" &&
+
+		# Now adding a *new* repo at the old name must fail
+		git init ../child2-origin &&
+		git -C ../child2-origin commit --allow-empty -m init &&
+		test_must_fail git submodule add ../child2-origin child
+	)
+'
+
+
 test_done
-- 
2.49.GIT

