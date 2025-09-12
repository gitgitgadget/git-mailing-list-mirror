Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427A2EBBB7
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673025; cv=none; b=VpT3HN8Nq6ypFxnEFVtVCV6EzhFj3cQhs5sCR80BvH46gMF7kG0Gs+E2rBsi1pi/VYhwRT89Ll+nVqvt4jrE3hWQQc9DzM4H9+mPCTdhwHYjiMZywrN1sCY9snA3Kt9Fq+6J7bw8ioNMMLegTcWpau16ptUieROhHQI59Fs7K74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673025; c=relaxed/simple;
	bh=X5xiXFXzP8dzY2aM4jZMPexnRZsYEPCDxNbfJBJ7PiY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k8dc/3c4r0oo7EvhAdJpeK4m8ePLZkbUNXknvqeaAUMka/F7jcc25XUctLy/tFQzFfEWaasu9WuXlpRolnNRWoOS43WgYLP8N5D9/rlHVrl0reKs/fGceY2VjAeB0/9G6AMWt5tNpAyVZJpRRu+TgkVBFqEJxDHVSKOS5oRxbvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4iskx30; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4iskx30"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b54a8c2eb5cso966988a12.2
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 03:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757673021; x=1758277821; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxwB2QoaYvRkWTmIgV9nqaukUVYrKsvimEXxYP4jUXs=;
        b=C4iskx30H3ti5CXyOxNE911g1QZOkoHWXLN31/UX6jC2e3fYymoYgUH2wInuRAF1+S
         teP6FVI+ddEL2+GjNE1QiU7u9CQcpHmAo5ZGTdAvVwFZqTn95keqcnMtNHhr7NT19KD9
         2kafghzm9NeF5evLVVWGgDohs26COm7epfo7L2v/yvKacnuQzFVcrFOmvM7SkDvfRxOK
         Rvi7hGCUiLnmcDDKNZM5y7cg0fPDs5ojDz5w1h2mAO7RyOZxqehrpNJlRNebddIJDqU7
         jM6fAu0UOH1UMVnq8kI0TuNWShwSDnAPCM7pRmmDLPbgKZ0XbpVEf99v3Ha9Z0WEF1jy
         C4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757673021; x=1758277821;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxwB2QoaYvRkWTmIgV9nqaukUVYrKsvimEXxYP4jUXs=;
        b=Z2+1p8zAj6EWYHS4ZCyqfBWCoOKWln5d+QRQrhgSqhVAEt0lAxlMA4Nl8kbP/YcJMh
         AYK82o5ffIYMi3Hvlf+S/r8qg3+v97GQrPqbmPyiFx/m4T8kT98wp/umX5FI9fV1lzga
         ZnBU+UF7juGV9q2ywCDlZloLSctv/KQtXzrmZK8hiLHX4GefrAQZBnPZ242ETJu/CFov
         /HfUycHItJ8vaJMzyOAfsAdjCDVKtCFgxmfRIZauy0O/MXaNHvca1fCpG/WSzkN1VDH5
         lpJUuNCf2GZcooCs/tJ3kNjCphzSqw2Z03aBHhp1965ybyY/hV9wN+eTVrRmsEXzgN2w
         00DQ==
X-Gm-Message-State: AOJu0YxeDI7u0QlEju5+mk4NWQNaNqf2f0fZG9MSaDfMels81TG65lZZ
	OQSNer6WI7mf0yWPCle3ikWK9Xtrzoa8jXqQfuMRhxdWtGjxB1GgLaaSOUStIQ==
X-Gm-Gg: ASbGncvfjrEjZPuw7vnSXoGT8krPp1wJ5ePXtoS1nDzfTtFOYK9+bh8pfX4LoZj8QzC
	7lf1KoLwq3hVW9xMrieZSX3C2Yy+VOtEzIS/MtLj+WoVCXOJQdgJI5rnzFlL7zwj7FdPQ5sRC8k
	na/m8n51e47wpKZou6b0Lrce4C3c2y+UkUkkZmrrfAJWmPNdcSCFbg8+dsqb/4eKPxyKw6eyVY1
	K8UqH46YlUg8w+OIbXg2gRT9F+V1sjTd2bedLm9/QYFFBw1Z5ZMxz5Rt9KH3+vRf8GSm08PkyaB
	Nspvh0n+Nhc6tNQEO4jMNxSdmnqTEQJ9mUjO3ZD3V6KcgnQegZnYtjPwfT+GYPDSMzCT1giZeJj
	CnDjE4n3zxvuVg0uhPgWUAxE89vYIGfAbBLRYtw==
X-Google-Smtp-Source: AGHT+IE2dqVtRzKJfGMzHh7yoMYCeuYASpRvXC4tOPQvjmRjY9N/UGL4zjtBRj30gn0jJmdaR0T15A==
X-Received: by 2002:a17:903:22c9:b0:24c:c8e7:60b5 with SMTP id d9443c01a7336-25d25978775mr28865135ad.16.1757673021276;
        Fri, 12 Sep 2025 03:30:21 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.175.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc6cc5sm45122345ad.27.2025.09.12.03.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:30:20 -0700 (PDT)
Message-Id: <6b29dda4b8961a999855ada42996de120513f218.1757673011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
	<pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Sep 2025 10:30:08 +0000
Subject: [PATCH v3 4/7] dir: add generic "walk all files" helper
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    newren@gmail.com,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

There is sometimes a need to visit every file within a directory,
recursively. The main example is remove_dir_recursively(), though it has
some extra flags that make it want to iterate over paths in a custom
way. There is also the fill_directory() approach but that involves an
index and a pathspec.

This change adds a new for_each_file_in_dir() method that will be
helpful in the next change.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 dir.c | 28 ++++++++++++++++++++++++++++
 dir.h | 14 ++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/dir.c b/dir.c
index 71108ac79b..194b36a8c4 100644
--- a/dir.c
+++ b/dir.c
@@ -30,6 +30,7 @@
 #include "read-cache-ll.h"
 #include "setup.h"
 #include "sparse-index.h"
+#include "strbuf.h"
 #include "submodule-config.h"
 #include "symlinks.h"
 #include "trace2.h"
@@ -87,6 +88,33 @@ struct dirent *readdir_skip_dot_and_dotdot(DIR *dirp)
 	return e;
 }
 
+int for_each_file_in_dir(struct strbuf *path, file_iterator fn, const void *data)
+{
+	struct dirent *e;
+	int res = 0;
+	size_t baselen = path->len;
+	DIR *dir = opendir(path->buf);
+
+	if (!dir)
+		return 0;
+
+	while (!res && (e = readdir_skip_dot_and_dotdot(dir)) != NULL) {
+		unsigned char dtype = get_dtype(e, path, 0);
+		strbuf_setlen(path, baselen);
+		strbuf_addstr(path, e->d_name);
+
+		if (dtype == DT_REG) {
+			res = fn(path->buf, data);
+		} else if (dtype == DT_DIR) {
+			strbuf_addch(path, '/');
+			res = for_each_file_in_dir(path, fn, data);
+		}
+	}
+
+	closedir(dir);
+	return res;
+}
+
 int count_slashes(const char *s)
 {
 	int cnt = 0;
diff --git a/dir.h b/dir.h
index fc9be7b427..20d4a078d6 100644
--- a/dir.h
+++ b/dir.h
@@ -536,6 +536,20 @@ int get_sparse_checkout_patterns(struct pattern_list *pl);
  */
 int remove_dir_recursively(struct strbuf *path, int flag);
 
+/*
+ * This function pointer type is called on each file discovered in
+ * for_each_file_in_dir. The iteration stops if this method returns
+ * non-zero.
+ */
+typedef int (*file_iterator)(const char *path, const void *data);
+
+struct strbuf;
+/*
+ * Given a directory path, recursively visit each file within, including
+ * within subdirectories.
+ */
+int for_each_file_in_dir(struct strbuf *path, file_iterator fn, const void *data);
+
 /*
  * Tries to remove the path, along with leading empty directories so long as
  * those empty directories are not startup_info->original_cwd.  Ignores
-- 
gitgitgadget

