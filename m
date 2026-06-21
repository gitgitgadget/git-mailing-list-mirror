Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F06D4964F
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 05:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782021484; cv=none; b=OUE4ZK1WaOvLu2c0XXuMCN/dYfgdusiJQ9c1xpqkDAD2yq2d7dZcsv2MMLdUmX94YSNJXjVCA9fizRN14JwlTGSzIFcef+d0DpXIUB6kCGzNdLB9XIzBy5rFVIoFmjWH0xYMDeZ/i7NOZxsEXiWmtKxRmpENtr5S/vwU0LBNK9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782021484; c=relaxed/simple;
	bh=AzNSGy/dQF1opzJ/P69OcO0UzoKcu/0N/fInjMdo+Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apDH2NmhMhUkoahLEMS8hNteGx66vnP7l/u4SMXcq/emWwfg3xWmeSoggesDqWA0ce5Ztl3hcOybhVuW6R85JBPJSF/f8WPd1fCeaJiqqSgraNcZN6eqnlWNvr+TuUNeC2OvnwjY+kgQmz4jw8k8M3xLScNq3L2eaNFOMOWuRZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GagtJ6T7; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GagtJ6T7"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84540eb70b2so1737937b3a.2
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 22:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782021482; x=1782626282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mf5qw9XUIPmDn2ZBqI6XXtAPbyWLbW90DEQtWwNsXkw=;
        b=GagtJ6T7qOX1+GtTVsSqafHCgtOzUH8V+qiOfUHS61gw66CHo1bHipYypkGp5UTyw5
         EAQ/DfaebqiUA16hNNNzewZo7uydf5z7oQmZ3V8qSw1yg46PA7r5c+vqAq9Az0pgANrf
         BR6fuHvj7frHqebQSMuCVAtRd9I0diC9/8dhxAuUYT6wBh5mjFZSh39/hWu+/2KYQLzl
         jUpxgdncqKCtXxNFLYsRuAZKTsOO4xMCfqdJ5pKN6k8xsrnGWYasWOrH8OuVHDm8HlJs
         sUZE72EJXqmM6Zd0vlAxh4jLotRNfo3bkkFNwwAbtPnPHBhpnN+Ssk06enTw5juzCnBJ
         Aakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782021482; x=1782626282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mf5qw9XUIPmDn2ZBqI6XXtAPbyWLbW90DEQtWwNsXkw=;
        b=a/HA3EPdKCut09i42cznC1ArDkdRpyTMLJpg6hFYDg4536eU3vGqBwQVCGCDzRFU24
         vs4IL58vI87aqodSiH05WSxAKNpWfsaWPUqETz3MrPOX4LtDzD4jiSH1oThc2PNpYpk2
         SzfT383bFHVco5rOxNlGnof+LkblHlMgpruMFh1yq0FhFBn2X8Xp2vripRbM+8AZ7ZIY
         vk7TTcAp3S22LgztqMy78KHdEV1+o0fdGisiML75s4uL1SdfIqmAanG2fyNVSDgrg5nx
         XYVME6MJHs5+tVnjr/MJLOW8BQbUTQcuFymMJZb0o9sif0cC4ANawjUe5Su5idpsRLNg
         Nl5g==
X-Forwarded-Encrypted: i=1; AFNElJ8QbwtkmKp61VO6cljR5NCxVrMsqC56CGIRrzNqLeB/8dzj/+WIHSHBUf515kZ7G6VaHRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7tsFONHd6tKUiig9hfA4/BmPyGa9rAebv34IJtjlLE8I6gtJE
	PJFbXB0yRLB1tR+wRaH4t0o+FcplO1rDN++AtSz0pdIU74EYlHdn9qk5
X-Gm-Gg: AfdE7cl1JLjZd6bk30AbBpJRC++U3El2AN5IRiMvGVhKTEV6YhI2K3OzqskrXotiBwp
	jwe1TU5qaD4Mn3357vrX5d6FbhqUmrCxNuwK1bZxKCAzY85yhguWPbjW+zUII/lI3lyZzrMNbVx
	63eaOK3RVcvuryVihKju8pvUF3PD/mQ8tiC9U3sQGchOygDcrZSXW8zdanUwPvOagZ56SDmchvy
	+1vbe0SXk0SdxEykZpALa01+5evr7DIldBhq6nBCn0mhh3Ffo+Xno2C7KjLPi19k8cRSWJBA9Oy
	M+R0CniAd3XlWdozrXN6M1/3cJpsyxDzTTQbdBzjciDpBFGfaUA0nUI2r2lmhxdvInHel8aUppP
	8p2DJ9m9ej8GGrVFIZ/Fwlme74e6Vu1iQrNrkuuxSCc3k01ujHRHeNurJ8FYVPMKvU+EYU9NhHK
	yDU2dapjOwNuhOHLbCtSwJzcVdMYobauPQSvi2P7yZ3kxygfABFl4bJ+2F05ZOFqxMI3bQOwT8/
	Qmow7yj4bctSAHM5Lu4968=
X-Received: by 2002:a05:6a00:4c9c:b0:842:5da3:9b8b with SMTP id d2e1a72fcca58-84562560d43mr5797791b3a.36.1782021482511;
        Sat, 20 Jun 2026 22:58:02 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ed3bd8sm3606669b3a.56.2026.06.20.22.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 22:58:02 -0700 (PDT)
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
Subject: [GSoC Patch v7 1/3] path: extract append_formatted_path() and use in rev-parse
Date: Sun, 21 Jun 2026 11:25:32 +0530
Message-ID: <20260621055534.46798-2-jayatheerthkulkarni2005@gmail.com>
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

Path formatting logic in builtin/rev-parse.c writes directly to
stdout. Other builtins cannot reuse it.

Extract this logic into append_formatted_path() in path.c and expose
a path_format enum in path.h.

Convert rev-parse to use the new helper in the same step to validate
the API against existing tests and avoid introducing dead code.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/rev-parse.c | 73 ++++++++++++++++++---------------------------
 path.c              | 69 ++++++++++++++++++++++++++++++++++++++++++
 path.h              | 30 +++++++++++++++++++
 3 files changed, 128 insertions(+), 44 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index bb882678fe..6de01466db 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -653,53 +653,38 @@ enum default_type {
 	DEFAULT_UNMODIFIED,
 };
 
-static void print_path(const char *path, const char *prefix, enum format_type format, enum default_type def)
+static void print_path(const char *path, const char *prefix,
+		       enum format_type format, enum default_type def)
 {
-	char *cwd = NULL;
-	/*
-	 * We don't ever produce a relative path if prefix is NULL, so set the
-	 * prefix to the current directory so that we can produce a relative
-	 * path whenever possible.  If we're using RELATIVE_IF_SHARED mode, then
-	 * we want an absolute path unless the two share a common prefix, so don't
-	 * set it in that case, since doing so causes a relative path to always
-	 * be produced if possible.
-	 */
-	if (!prefix && (format != FORMAT_DEFAULT || def != DEFAULT_RELATIVE_IF_SHARED))
-		prefix = cwd = xgetcwd();
-	if (format == FORMAT_DEFAULT && def == DEFAULT_UNMODIFIED) {
-		puts(path);
-	} else if (format == FORMAT_RELATIVE ||
-		  (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE)) {
-		/*
-		 * In order for relative_path to work as expected, we need to
-		 * make sure that both paths are absolute paths.  If we don't,
-		 * we can end up with an unexpected absolute path that the user
-		 * didn't want.
-		 */
-		struct strbuf buf = STRBUF_INIT, realbuf = STRBUF_INIT, prefixbuf = STRBUF_INIT;
-		if (!is_absolute_path(path)) {
-			strbuf_realpath_forgiving(&realbuf, path,  1);
-			path = realbuf.buf;
-		}
-		if (!is_absolute_path(prefix)) {
-			strbuf_realpath_forgiving(&prefixbuf, prefix, 1);
-			prefix = prefixbuf.buf;
+	struct strbuf sb = STRBUF_INIT;
+	enum path_format fmt;
+
+	if (format == FORMAT_RELATIVE) {
+		fmt = PATH_FORMAT_RELATIVE;
+	} else if (format == FORMAT_CANONICAL) {
+		fmt = PATH_FORMAT_CANONICAL;
+	} else /* FORMAT_DEFAULT */ {
+		switch (def) {
+		case DEFAULT_RELATIVE:
+			fmt = PATH_FORMAT_RELATIVE;
+			break;
+		case DEFAULT_RELATIVE_IF_SHARED:
+			fmt = PATH_FORMAT_RELATIVE_IF_SHARED;
+			break;
+		case DEFAULT_CANONICAL:
+			fmt = PATH_FORMAT_CANONICAL;
+			break;
+		case DEFAULT_UNMODIFIED:
+		default:
+			fmt = PATH_FORMAT_UNMODIFIED;
+			break;
 		}
-		puts(relative_path(path, prefix, &buf));
-		strbuf_release(&buf);
-		strbuf_release(&realbuf);
-		strbuf_release(&prefixbuf);
-	} else if (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE_IF_SHARED) {
-		struct strbuf buf = STRBUF_INIT;
-		puts(relative_path(path, prefix, &buf));
-		strbuf_release(&buf);
-	} else {
-		struct strbuf buf = STRBUF_INIT;
-		strbuf_realpath_forgiving(&buf, path, 1);
-		puts(buf.buf);
-		strbuf_release(&buf);
 	}
-	free(cwd);
+
+	append_formatted_path(&sb, path, prefix, fmt);
+	puts(sb.buf);
+
+	strbuf_release(&sb);
 }
 
 int cmd_rev_parse(int argc,
diff --git a/path.c b/path.c
index d7e17bf174..6d8e892ada 100644
--- a/path.c
+++ b/path.c
@@ -1579,6 +1579,75 @@ char *xdg_cache_home(const char *filename)
 	return NULL;
 }
 
+void append_formatted_path(struct strbuf *dest, const char *path,
+			   const char *prefix, enum path_format format)
+{
+	switch (format) {
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
index 4c2958a903..4d982a2c8e 100644
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
2.55.0-rc1

