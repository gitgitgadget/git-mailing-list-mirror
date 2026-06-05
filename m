Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFC234D93C
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677064; cv=none; b=SLlnq2RkEpJXyrZMte208Wqck27Hq8hne3PxxjZjLygaP0TbSih0oOZVfdzFhoqtjiY0rK3skUDV8qMOgz10isTCulTlZ+T/60ntbh6qgq0rtcKJmjfcH2gyYj8MUPRdegg4VbJadWQwfB3tmBWNsj/IgvoztRGCB/twy6py2gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677064; c=relaxed/simple;
	bh=HHYH1HX1QdR+OblLftCINPC06+HaRASQF3XLQXD3TYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NU/lSbn3dkfTEmr94NI8mCejGGUzSrcLPg/afFLPhg4hu0lt7cIN6KUFV9BC9fA0TLgnJLdjIzgDXdxXOnnU619B0+8q4fbPbOqu0pOcF3wRDNCzYYRa4On5RmrYya+7xOVjiM5/25V+IZcyIVYmODh/Cq/wv6JBQ5tAW7s8CmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oG+pbmJM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oG+pbmJM"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c32f6ce1so15105735ad.2
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 09:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780677057; x=1781281857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vdj3abiNUYXnajY66UT+qnVjjBJI1SSbZRxu9BRfsDs=;
        b=oG+pbmJMyySBy+QIPmIGE4O0OjJDOWfmx5JHcAY36JBKrlWy5wEG2Yr4FJ//O7En2c
         IvB18ifYR0DNR9QnRcMAR+TBMmkC74YrRHrsAXbfC+NTwH5ZcVy47TBZiFF1EF0d6NMv
         G0MvGp7O3A47qQfwUIyJZJiCSel78kIBbmANuIpQlTbB2P8kNI0UMvGYgqahGojjCgIP
         6oZx7m2fsiaNUg12NcJEW/HMv76VA6qyBuObCLy7yi/o3SciJ18ersf554ZtOGFl3tMc
         Ff3HbKOJN/5whs9/x2c61nsOdTATj7eKMpWlhuj0y0cwmC4KhzxGPNPbH6O4edrbOmY1
         6TVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677057; x=1781281857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vdj3abiNUYXnajY66UT+qnVjjBJI1SSbZRxu9BRfsDs=;
        b=KUcEJ+Rc8wLaByepZeneIkIcNdoRFkSWrYYGAl1eax7fSSt/ayZImkinHpZ2JO+JyK
         w3oMcFVlIAxwF73R3zldJiAnOLkeevbebvji4efUcBwgJZM1T6c8CXP22yllyRSshSHN
         IfoMDXKCApaJHFnjbRfLDYyDEzk71GLgbHYP8HcO93+GPq2+/GzXutqDSbNZCK262A7Q
         xzTip7uYAzt5QqRHb6bkzCbq60Ly+u8/bibu9w7OfW1XzAIziGMMXMlglW7HuNPgqcqd
         9SnEw8DIL63MgKCGDWDaAUzmG/CHl3NBUUdNBa5jHFIs7kvftr7IWo2ulT+DZLMZLCXG
         XA3w==
X-Gm-Message-State: AOJu0YxEEnti2xtTQVSn2uTCyrDe30vPsEVDdsIvtprtBnsb3GfJPWTr
	EZrWiCt+/tcCYxoQhhqh3l8v1XN71mU347kr/b8mjtgbkbibdjOXjo1zkxVwOQ==
X-Gm-Gg: Acq92OGAoHNjRwuS0DtXCkeOfQ1T2jIO5GhozQRwutKaLhiZd/lnGZSOFR9GE72tTbr
	QdjWBMVvGsNFmPOCuWUWmOrwnPdPiEC9hSzQ9SX3R38aQB/2tBhCwCWCNBitTlnic25xUF97asT
	tWIb8595shoUtySoQ/Y9Mmn41myMitStfli8HXpWdRoRX7TEQbQJRmXMaY/+CUnYneIg42Dunk/
	HLI9iHew1r4nl/Oqpkt1lOz0AlDZKI1wItucMyveaw1r4bY/8dUlQhw7nTiP6NZH2GOmq+jjOTA
	wgxtjQHaVAbMEPRBy5g53d4H1Xu4Wozpkl4fllOGIUJ5lddmtKoSIFcWRmyp2j9QgjGYRbxCUz9
	rZg8N1gMNmAroKl7CFzdGAeB16nRO26a0dwEcCvEGlQZwRtoohds9HYyYpeHfNTm5CkTZjiE0a8
	sQxAKtLUQD27BmlHLUnB12MbRd1CFhqUXiUXo5DARMnv5UK7YVASMR8nnYQdi9wKu9sEiF0gAdY
	Z12VYfYllf9xLom+856ECOVfy2dHnJsyvT1cuUwJ1lf
X-Received: by 2002:a17:902:fc48:b0:2bf:23ad:8595 with SMTP id d9443c01a7336-2c1e78e4f0emr49856905ad.4.1780677057127;
        Fri, 05 Jun 2026 09:30:57 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f85de1sm95883955ad.20.2026.06.05.09.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 09:30:56 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jayatheerthkulkarni2005@gmail.com,
	a3205153416@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	kumarayushjha123@gmail.com,
	lucasseikioshiro@gmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net
Subject: [GSoC PATCH v2 1/4] path: introduce format_path() for centralized path formatting
Date: Fri,  5 Jun 2026 22:00:09 +0530
Message-ID: <20260605163012.181089-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The path-formatting logic inside `builtin/rev-parse.c` handles absolute,
canonical, and relative formatting rules based on user-supplied options.
However, this logic is tightly coupled to `rev-parse` and writes directly
to stdout.

To allow other builtins (such as the upcoming `git repo` path keys) to
re-use this logic, extract the core path-formatting algorithm into a centralized
helper function, `format_path()`, in `path.c`.

Expose a single, streamlined `path_format` enum in `path.h` to let callers
explicitly declare their formatting strategy (UNMODIFIED, RELATIVE,
RELATIVE_IF_SHARED, or CANONICAL). This decouples the core algorithm from
the localized fallback mechanics specific to `rev-parse`.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 path.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 path.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/path.c b/path.c
index d7e17bf174..2fcd24c5eb 100644
--- a/path.c
+++ b/path.c
@@ -1579,6 +1579,64 @@ char *xdg_cache_home(const char *filename)
 	return NULL;
 }
 
+void format_path(struct strbuf *buf, const char *path,
+		 const char *prefix, enum path_format format)
+{
+	if (format == PATH_FORMAT_UNMODIFIED) {
+		strbuf_addstr(buf, path);
+		return;
+	}
+
+	if (format == PATH_FORMAT_RELATIVE) {
+		struct strbuf relative_buf = STRBUF_INIT;
+		struct strbuf real_path = STRBUF_INIT;
+		struct strbuf real_prefix = STRBUF_INIT;
+		char *cwd = NULL;
+
+		/*
+		 * We don't ever produce a relative path if prefix is NULL,
+		 * so set the prefix to the current directory so that we can
+		 * produce a relative path whenever possible.
+		 */
+		if (!prefix)
+			prefix = cwd = xgetcwd();
+
+		if (!is_absolute_path(path)) {
+			strbuf_realpath_forgiving(&real_path, path, 1);
+			path = real_path.buf;
+		}
+		if (!is_absolute_path(prefix)) {
+			strbuf_realpath_forgiving(&real_prefix, prefix, 1);
+			prefix = real_prefix.buf;
+		}
+
+		strbuf_addstr(buf, relative_path(path, prefix, &relative_buf));
+
+		strbuf_release(&relative_buf);
+		strbuf_release(&real_path);
+		strbuf_release(&real_prefix);
+		free(cwd);
+	} else if (format == PATH_FORMAT_RELATIVE_IF_SHARED) {
+		struct strbuf relative_buf = STRBUF_INIT;
+
+		/*
+		 * If we're using RELATIVE_IF_SHARED mode, then we want an
+		 * absolute path unless the two share a common prefix, so don't
+		 * default the prefix to the current working directory. Doing so
+		 * would cause a relative path to always be produced if possible.
+		 */
+		strbuf_addstr(buf, relative_path(path, prefix, &relative_buf));
+		strbuf_release(&relative_buf);
+	} else if (format == PATH_FORMAT_CANONICAL) {
+		struct strbuf canonical_buf = STRBUF_INIT;
+
+		strbuf_realpath_forgiving(&canonical_buf, path, 1);
+		strbuf_addbuf(buf, &canonical_buf);
+
+		strbuf_release(&canonical_buf);
+	}
+}
+
 REPO_GIT_PATH_FUNC(squash_msg, "SQUASH_MSG")
 REPO_GIT_PATH_FUNC(merge_msg, "MERGE_MSG")
 REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
diff --git a/path.h b/path.h
index 0434ba5e07..a78e0fc141 100644
--- a/path.h
+++ b/path.h
@@ -262,6 +262,36 @@ enum scld_error safe_create_leading_directories_no_share(char *path);
 int safe_create_file_with_leading_directories(struct repository *repo,
 					      const char *path);
 
+/**
+ * The formatting strategy to apply when writing a path into a buffer.
+ */
+enum path_format {
+	/* Output the path exactly as-is without any modifications. */
+	PATH_FORMAT_UNMODIFIED,
+
+	/* Output a path relative to the provided directory prefix. */
+	PATH_FORMAT_RELATIVE,
+
+	/* Output a relative path only if the path shares a root with the prefix. */
+	PATH_FORMAT_RELATIVE_IF_SHARED,
+
+	/* Output a fully resolved, absolute canonical path. */
+	PATH_FORMAT_CANONICAL
+};
+
+/**
+ * Format a path according to the specified formatting strategy and append
+ * the result to the given strbuf.
+ *
+ * `buf`    : The string buffer to append the formatted path to.
+ * `path`   : The path string that needs to be formatted.
+ * `prefix` : The directory prefix to calculate relative offsets against.
+ * Pass NULL to default to the current working directory where applicable.
+ * `format` : The formatting behavior rule to execute.
+ */
+void format_path(struct strbuf *buf, const char *path,
+		 const char *prefix, enum path_format format);
+
 # ifdef USE_THE_REPOSITORY_VARIABLE
 #  include "strbuf.h"
 #  include "repository.h"
-- 
2.54.0

