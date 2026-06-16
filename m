Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AE2750ED
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 04:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781585486; cv=none; b=DnXUhbVZ63YST2P71eitlSBxMHRh2nAXtUnTjg5Zy12MZsiQ+28+17LCxusUII1R864JcGf072ol++cLZ2DkiRsNjE2r2PumBDXYjy6bRPgzxqQ0HLwchRWa1wDdHrqFid66xudNuV/3upw2ztWxn4BSDvAd4TVbZ0eVIa0N/j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781585486; c=relaxed/simple;
	bh=mbEEUiZymbg4G5XJHWjdbpElpDwrzIu1aN5RCut61sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adrxdU9cDvrywbI6cOJcyxj5NQ9yq9re0oJpEFsZOUzQ4uYWVykdC+ttIr4yEwi/douWjUBodw9D4aar8Yhp3uxePY0LfO5YzJeWdY2aM2GLBTvHoqxjUeI/hoZjrHCvwq6Sg8rmKQNKELYmqj4+oGc6tLNkZvkzkWHn4rPDcm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWfiQNnF; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWfiQNnF"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84347ad88edso2822694b3a.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 21:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781585485; x=1782190285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhfHHHPF0SkqPQSI0xfLwOJuPPm1a1LI6Y08SVx9jXI=;
        b=YWfiQNnF27ssBhSKIai4fCIPwO93yXA3VWVCZ7K4S5Bv0ancBa9bz17DHQc9uL3V8f
         j+lkd1VX7ZO/nCcYeUuLWRWFm4KXwJAoRtmosLDuCOwhV5dHcaygp/7NHxGExIyACNaL
         uPG48DzXaiET/LlmqXdhJv9TQbvilZyX1med/jyeB5pzbbPzD6dfQhoo1T53dUKS9aNk
         rjYuvaUjqvRdRgAjHBGPwKfFr1vR8IvdYtlJdvOW8gL1gFlNAp/tkqkyOjMnxha69/DO
         Dft1uvhgdwMU22ONUvpPmjINX5jhKPpnTACB54kuVhVCerkP/QY4f+L2mWhJ95xQNOzj
         UpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781585485; x=1782190285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GhfHHHPF0SkqPQSI0xfLwOJuPPm1a1LI6Y08SVx9jXI=;
        b=Wyf0Dmr2xXY+4T4rmoY7MjHJzAzbxiWjOJhYrfxm9idJQKDaZGjF6bvA1Ek4HPW5bv
         qhlrOvJVQm92Xqau6X330ejXKgj3klzbCOxm+9AIbC0xMVwJA5p/y5QlrMpntyJOz/bD
         Y/mpz2XrJ/rohUs9670ak7GrqozIPHNnR/VCILB44HM+JQzbVtbFMzjBvI+8XbRGjXK0
         pm5biF19kq1Py2defclqcBKdkqejdUQYkVpphJ2SYBcaqYH39TbAPzUjjMilXz6rN1DZ
         QErwLF/Rw6XpZWkeY/UfOOhqdyT7v2bI1sOb4pQkCRJDVrSivAU41sFTIzj3iM+vYQUP
         m99A==
X-Gm-Message-State: AOJu0YxYEfzC5Mdu7V8RUYQO8DT6xnu2m/UgcdA3qzz2EqP22LuYj4sW
	qF0CM+rhcY0hs9iRYHi6dts37p19ePVugQfA0Obqf/s8U+p7f2+CL3nomF3jQQ==
X-Gm-Gg: Acq92OEUVVXbsfQIY8CmINhgUdiaY8/cp+DJBWLtSBRHm9xvrL8Nto34WyJf+7hg+k2
	07ZJRawM/fpFVghrN5MZnVrcebJI2B4xGE7aYLBLh07pLk0NaosaqQN19rhM7JkaQwUrGibzw+/
	9KC2132TYZHT21rwfzweygeyM/FlCUAFbDV99vjLxgmyMvJlkzO52gI/wE/79XR0dxIoUtVBhc6
	6Yqd/MODSSuP0mNW+oHrbaTSYdva0lxshBy4ddsUdmUhxnKk1aiOivliqrSKmWIY6euHPtoNXTF
	7l7Qisqz5JSwKkewm3yKrDjADIQuU9L9pC2J4I5LS42aEHEBOYVvy8khVsBR8COK6jb6DnIXZ5V
	YjR6PWRG/5//90BdulgzvD48RXpR6N75wgv3Z66ChuUGITA/ZzcTupwCsFhxagpNZJuDOjA5HJV
	TLZEE0ALCtY4qLhfLdzkLZDCEXXollKbTHmqLVkySk0SdKmtAGtQzfwCtDPovmCfdAzKQ0F1cSq
	xz4vD4J9vY0AkPFxBvEhqZflOSxLzQP9Q==
X-Received: by 2002:a05:6a00:181e:b0:842:6099:c55c with SMTP id d2e1a72fcca58-845153dc503mr1862626b3a.3.1781585485033;
        Mon, 15 Jun 2026 21:51:25 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b040718sm12122614b3a.51.2026.06.15.21.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 21:51:24 -0700 (PDT)
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
Subject: [GSoC Patch v5 1/4] path: introduce append_formatted_path() for shared path formatting
Date: Tue, 16 Jun 2026 10:19:50 +0530
Message-ID: <20260616044953.184806-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616044953.184806-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260616044953.184806-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The path-formatting logic in builtin/rev-parse.c is tightly coupled
to that command and writes directly to stdout, making it impossible
for other builtins to reuse.

Extract the core algorithm into append_formatted_path() in path.c
and expose a path_format enum in path.h so that any builtin can
format paths consistently without duplicating logic.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 path.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 path.h | 36 ++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/path.c b/path.c
index d7e17bf174..5e83e3e4f6 100644
--- a/path.c
+++ b/path.c
@@ -1579,6 +1579,76 @@ char *xdg_cache_home(const char *filename)
 	return NULL;
 }
 
+void append_formatted_path(struct strbuf *dest, const char *path,
+			   const char *prefix, enum path_format format)
+{
+	switch (format) {
+	case PATH_FORMAT_DEFAULT:
+	case PATH_FORMAT_UNMODIFIED:
+		strbuf_addstr(dest, path);
+		break;
+
+	case PATH_FORMAT_RELATIVE: {
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
+		strbuf_addstr(dest, relative_path(path, prefix, &relative_buf));
+
+		strbuf_release(&relative_buf);
+		strbuf_release(&real_path);
+		strbuf_release(&real_prefix);
+		free(cwd);
+		break;
+	}
+
+	case PATH_FORMAT_RELATIVE_IF_SHARED: {
+		struct strbuf relative_buf = STRBUF_INIT;
+
+		/*
+		 * If we're using RELATIVE_IF_SHARED mode, then we want an
+		 * absolute path unless the two share a common prefix, so don't
+		 * default the prefix to the current working directory. Doing so
+		 * would cause a relative path to always be produced if possible.
+		 */
+		strbuf_addstr(dest, relative_path(path, prefix, &relative_buf));
+		strbuf_release(&relative_buf);
+		break;
+	}
+
+	case PATH_FORMAT_CANONICAL: {
+		struct strbuf canonical_buf = STRBUF_INIT;
+
+		strbuf_realpath_forgiving(&canonical_buf, path, 1);
+		strbuf_addbuf(dest, &canonical_buf);
+
+		strbuf_release(&canonical_buf);
+		break;
+	}
+
+	default:
+		BUG("unknown path_format value %d", format);
+	}
+}
+
 REPO_GIT_PATH_FUNC(squash_msg, "SQUASH_MSG")
 REPO_GIT_PATH_FUNC(merge_msg, "MERGE_MSG")
 REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
diff --git a/path.h b/path.h
index 0434ba5e07..6aca53b100 100644
--- a/path.h
+++ b/path.h
@@ -262,6 +262,42 @@ enum scld_error safe_create_leading_directories_no_share(char *path);
 int safe_create_file_with_leading_directories(struct repository *repo,
 					      const char *path);
 
+/**
+ * The formatting strategy to apply when writing a path into a buffer.
+ */
+enum path_format {
+	/*
+	 * Represents the default formatting behavior. Treated as
+	 * PATH_FORMAT_UNMODIFIED by append_formatted_path().
+	 */
+	PATH_FORMAT_DEFAULT,
+
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
+ * `dest`   : The string buffer to append the formatted path to.
+ * `path`   : The path string that needs to be formatted.
+ * `prefix` : The directory prefix to calculate relative offsets against.
+ * Pass NULL to default to the current working directory where applicable.
+ * `format` : The formatting behavior rule to execute.
+ */
+void append_formatted_path(struct strbuf *dest, const char *path,
+			   const char *prefix, enum path_format format);
+
 # ifdef USE_THE_REPOSITORY_VARIABLE
 #  include "strbuf.h"
 #  include "repository.h"
-- 
2.54.0

