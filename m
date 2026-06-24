Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B7F175A70
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 03:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272491; cv=none; b=DE5s2XRv3y93+y2ycdBgSxOIR+QG+MZKMIwXkEBbWbgxtjmjWelo/suRwNfLOUaHNRxyI/1a5u69C1O+A8e7FpzixPIlGql4m7UwzWhPTPoUROYK9jXh0+BKEf3itGsgG8pJJn4fYw1E1dpbAGaNAV88kB/TY8lza9LlyXRr62w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272491; c=relaxed/simple;
	bh=uOMIb1v1bHFiu+Ds2lC1tXRB1KUmaNPjZr5tXjCAPUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARr0MfCYrumD3UD5QLQSRnJ0XlXJ7z3hR71WZbeyoe1iY/+i+00FLqEgCu3iuYSG88qOOPd8UASB5mME5daPsgbgO3cm6vHpfY+mtAfecXvwZhMfM9UbE/BEqM8t4D+dCmuvgDCbmDUACrUTR5xcO+8c5cxpKi4fQD8Vc91zzeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sbWtW6TR; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbWtW6TR"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30bf132969bso735512eec.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 20:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782272490; x=1782877290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TE1D+kAk7cvTY388QcjdDnhGkSFiCjQ/Ze9X9S9C6LM=;
        b=sbWtW6TRFKZ+vdx6PMuf51WRjQmU+MiH4yMf+z/NzdGRCuaUHWp987RNuiIeLaChf0
         CFhYMPpDnrxyHdidOMdzQYxgYD2h1qISKvhH0GdETobZ/PWg4AoIL61t01/XOhtCm3Tj
         2FkqtMCOTWH0A8pzVULUPq5BsZSB4GDYBaKEvWL8RLhl6L+qaadotq4uJBzK79cW6W+j
         Y6ynjEu5q2wTwUby7iHso8y5gR6OcKDJ8WfX07DbCJhRTC/ZeuFAOgJ5yPX9RX4wUyvL
         exGJ6vl7ON2TfRvDgXIM3nLzapqlYfTa72dNvS2OkEkQJXr16sLo0QghvEdg9IcU+iBN
         wAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782272490; x=1782877290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TE1D+kAk7cvTY388QcjdDnhGkSFiCjQ/Ze9X9S9C6LM=;
        b=OJRVVtlILtBMO+P5muSfIBUx3XDkxYEN7Fnbeo3rxhjI4fjkU4MMqWgxTK48kv2TD0
         2ZECMTG0f8/WPYoKcg5s4vU1vMQjYSPcbrlhqKwd1HFVA87EC6OLkBRGp3eJKQqriQdB
         D8eKKH6yHepoC3glG4LwaYql0zbyrwczx7x7m2F69BFT1h2c3PGttXgArDMKEUCNaWlf
         XMtnKmpM/z8f8xIBwPJrr06iiLUppMMa9MwASxYnIzLFczJn59vOCZ/SCi/xpPDn/zEc
         ZjVYGhmRCOqtcD87S9viwH8XHGYv/03IzZ8ogPsZyAk6maiHENTg5+PIktMn4X9PYi4p
         v3IQ==
X-Forwarded-Encrypted: i=1; AHgh+RqP3odB24KqfJRsqwv7RoJ8XfCImWcO2ASWPK3wTvOkudiZonRaerlrDmXKjjNW8zeS/WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT9bTiHCRPC752vOaLUQqjugkmUDfoSmdHG8oPRGRTnWFBLqTe
	nmKXg0h+bMFSG/VPIeusSWUVShzoXCCC9ywHmZm/5KFBbmw6V8UIFp/A
X-Gm-Gg: AfdE7cmynhLn08bzLBdjnpYp3Sn8bxnRWsOnYxp55INvKY6Fqolr2FEy7NAL1PlUC+m
	6hzuLHXGrTCqSYZoiCGlyaroEOCySLoAbm+eGelsHB6alCkpcYArfnYTgL/nlX0CScA+jZiHF7E
	nHiW3sD9WW7tTenfnREVYtDrJr/VLXrZUAhPlo696B683486PKl46F+9SEgZPE3GqZRfJwDP2pS
	pPhJKNBLoL2xa/4SaTKh/C7/6ZNh++Mn0oQia1YDtbFIOZ3l6yLm6bWalJT+dNhkhNg34zLrBqJ
	oyBTeoNm+Lx3PdsHqG65mScdOmkygyQ/W7ilgw0zSrLiRifbddbV3QdjvaXz6i+X4Qb9mqVBZJe
	aPosXOMAzLqJl2Oe0C06+7fXnN+98XOXceZHLzEXylkGc/iDOiNSdtTFTsDI2fOhpzHpk1D1PDU
	cma9K1Rk65AS9ap+2lOwHcqtJg/0lgpjN5Z7S1A/npzK72mlCXUN0cZWQBc99lWusB7BnMV19oY
	dR7y+aUyczBEBJfy1kzbvs=
X-Received: by 2002:a05:7300:d0f:b0:30b:f0c6:12c8 with SMTP id 5a478bee46e88-30c68ce5d26mr1860028eec.9.1782272489824;
        Tue, 23 Jun 2026 20:41:29 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bddfe34sm23924891eec.20.2026.06.23.20.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 20:41:29 -0700 (PDT)
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
Subject: [GSoC Patch v8 3/3] repo: add path.gitdir with absolute and relative suffix formatting
Date: Wed, 24 Jun 2026 09:07:48 +0530
Message-ID: <20260624033748.108281-4-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.0-rc1
In-Reply-To: <20260624033748.108281-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260624033748.108281-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts need a stable way to locate the git directory without
parsing rev-parse output or relying on its flag-driven path format
selection. There is no way to retrieve this path from git repo info
today.

Introduce path.gitdir.absolute and path.gitdir.relative keys,
consistent with the path.commondir keys added in the previous patch.
Reuse the test_repo_info_path helper introduced there to validate
both variants.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  6 ++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        |  6 ++++++
 3 files changed, 36 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 890c34051d..ed7d80c690 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -113,6 +113,12 @@ values that they return:
 	The path to the Git repository's common directory relative to
 	the current working directory.
 
+`path.gitdir.absolute`::
+	The canonical absolute path to the Git repository directory (the `.git` directory).
+
+`path.gitdir.relative`::
+	The path to the Git repository directory relative to the current working directory.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index 4c3fbc26b9..27c8caff38 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -99,6 +99,28 @@ static int get_path_commondir_relative(struct repository *repo, struct strbuf *b
 	return 0;
 }
 
+static int get_path_gitdir_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *git_dir = repo_get_git_dir(repo);
+
+	if (!git_dir)
+		return error(_("unable to get git directory"));
+
+	format_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *git_dir = repo_get_git_dir(repo);
+
+	if (!git_dir)
+		return error(_("unable to get git directory"));
+
+	format_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -113,6 +135,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "object.format", get_object_format },
 	{ "path.commondir.absolute", get_path_commondir_absolute },
 	{ "path.commondir.relative", get_path_commondir_relative },
+	{ "path.gitdir.absolute", get_path_gitdir_absolute },
+	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 09158d29f9..ae8c22c817 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -207,4 +207,10 @@ test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_repo_info_path 'gitdir standard' 'gitdir' '.git'
+
+test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
+	'.git' \
+	'GIT_DIR="../.git" && export GIT_DIR'
+
 test_done
-- 
2.55.0-rc1

