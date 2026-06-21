Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F1C233932
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782021546; cv=none; b=tL3antWj6Ua81P6oBxc/FrzIOOdPyywpw0y8HHBgX2SizzRJOWMTMAHz70kroPSCrf6whhKDh8URWY7HDjOxt4xTudqiwo2FPBoWkymAmMb/PO6hiEYrz/CH8mAw2QTS29RrfO/saOv26HSMMo0dqgylsklVXBxI6ULym2Y8p8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782021546; c=relaxed/simple;
	bh=Z1CiiJdfG4RV7+awlUkNxWm4/RquxRZHvBMn4lskagU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJnGSi+Yyw/1z+fAUQB2cxhrQv2m5p1URkEMmZfWPbkjS0OjbdnQHIrX96H3HgHBG15twUehUD+Ef8zaVs4iTV7E5vkm3hxfVIlS0jqNM5VQvZ/1cE7nKkqW7d6Y58UjvVq7E8TCrkNKokszmf0X3Eow3yhfJ8nvuge/9hoLDzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qu3GZmhJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu3GZmhJ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84537777d45so2593863b3a.3
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 22:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782021544; x=1782626344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+1BrT+gS7/HHSkb4HEGN4ILLTHcQnvB7ewtJ1HAJ5A=;
        b=Qu3GZmhJ61ZE3NmzEpPoyPA8pdH6+8ghG95NryyiDfC+cK8NKBptMgJvZtfabtubiX
         LRO1wK8l025226C0ONX51dN1fMw34kvJAVjGfoWXnm/J3ZwdvtQ/X8eFqwGzXBE1l3vv
         cicXW2IbSeD3XEQZIf86EYZdMVTgb1F2erpEemxoRb8AOAWQawssRtWDVxAkfQUCAoT0
         to4uO5FiqKwZ9BibP0twseNAMUSi4aVeppHbTC/YweecLDgJOL5IABC9g/xdkSzQ6ogo
         ZSibLEKM9Zbc0CO2qaGSuz73ygN18m1P8cQ/SgOf420D/AZ3UGbKU7NvZ1h30rHl6zKB
         2mMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782021544; x=1782626344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K+1BrT+gS7/HHSkb4HEGN4ILLTHcQnvB7ewtJ1HAJ5A=;
        b=QKTS/7SNVeEZYBgm1C+h36WgCT2qsbltPE79924fOBEuRTeFCRfz+AM7KKZwjW2vHK
         d+tYZS1QoWp554asB3H5PXmCOnZAV7auxNLCqhWfMqvdGG+FsP2gYCc6bQjeK9ZuHfuu
         FqfsqBk21Ir8TnuxqiysFL6I6Wf5l16cci/42lI4YeIgTgX7/GK4oipqEv1XmaOln2AF
         i9nyq6PEsNrWKyCI1MopydoevF04pza9qbxgZRlLRk2gaZQnTh4Imah2rMgOFmw6OYlg
         /WUxUJSYX9XU0A0B+Aj6euigh2QQtyQ8A7pgbV5x+ZfPaXZGXD89KKJD5izZP/XB8lRJ
         Gw6Q==
X-Forwarded-Encrypted: i=1; AFNElJ888BeHYDfPtz6qSjguH4g+XEq1kDM0shPTGMM5XUq57vfPcW3Sfik1qy4o3JrKvzDMOMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqdKT7z+98UHUDQkMckRbRca+EwCR0jpXiJyi4Gh0TGLsi6bnp
	iMAPrZefzJDPNHjaDJAfrthmbxeUtRh5uBmv7fkbvToNNDYuJfl/qRIJwpgbTw==
X-Gm-Gg: AfdE7cnGjvohUTqVE9D9GnZGVWN7BhwhnnC96f7kDPzVPeI9Dhm0rfxEYGWdQu/17VY
	fHu6EihQGmQwFhDqzHwr6Yzof/TB8t2sFGEPnP4hVFI0K45To/hU7XZ6di5XBf+7WbaKgdsYs2s
	eDF38DfByo+ynDD2Z5wQ8jUp+A+yX7F/4qTNhERwefiuOFyNjj3p1OKlvO1eQdRq+mc7zIpAQfH
	QtuuxeY/1o8DpTU6Aoa5XhRrJ/s67qZlMBtJjReFkAJaGJ842q0DEaQ7wYfFj1PO3C7M1Abr/RI
	7OnxMg7RARlgymVdMsO+LdFz6Z3M5lQ97HTEJwBp6f0Tm+aTzAuh47VqMKQCCYcb7qKVO3okKl0
	n82WrGbvasZfkQ3tIQ54kIq0ILyz8gXwrz0kgo1yTPthVtKCD1FuxibN6h6aIgj0x6jPLcO6qDW
	4HhBn4KQhvzBO52ZxFcnsNOlcXPLrbC117HLMWRgZbJPzKpuctEtwPmn9CWSO9hjI+lqQ3IJXRz
	KkNL1mvJOkTP/i3dOQQ89g=
X-Received: by 2002:a05:6a00:2eaa:b0:842:7992:bdd6 with SMTP id d2e1a72fcca58-845508a31e5mr10203502b3a.36.1782021544240;
        Sat, 20 Jun 2026 22:59:04 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ed3bd8sm3606669b3a.56.2026.06.20.22.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 22:59:03 -0700 (PDT)
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
Subject: [GSoC Patch v7 3/3] repo: add path.gitdir with absolute and relative suffix formatting
Date: Sun, 21 Jun 2026 11:25:34 +0530
Message-ID: <20260621055534.46798-4-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.0-rc1
In-Reply-To: <20260621055534.46798-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260621055534.46798-1-jayatheerthkulkarni2005@gmail.com>
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
index c4cc3bf3fc..9a312d127a 100644
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
+	append_formatted_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
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
+	append_formatted_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
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

