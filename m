Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2D23DB33E
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327281; cv=none; b=FETO1L1wITY6RrOgPYrsmbJ0wJkFkDn8JDGM1gw/8s8OLbRX1JGhHqT9jcysJzUvSZ287iVs3tK77QP2JyAUw3s/QQG5bLaB7nCTKj1Z4VNIt4JuHtSOEGlr+ExGpm2V/+I0aMNEI6yLGMXPjT8P5TygAAvOCbH3BH5J01HroBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327281; c=relaxed/simple;
	bh=tZsDoRhKawlQQGABFdKhEjTjF3n3g9SrSBvHOBlJMQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFcn2v43IS80jY+U78UFGpBZ2aK/oeIXG2jpbfVtYSyCy4iec2qOFAdVUquqDcoMQf1ev7Cxr9SxlIrtRnL6k9D9ooUWYDCKYj+6OcMErnY2rkuLjG9bFohNkjxOVckeHIO0NCKpoLSwkD0qyIrM+EDh/J23hoHoByjPT4MFi7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqOhwcEo; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqOhwcEo"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8423f869421so1018550b3a.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 08:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327278; x=1780932078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDNeA3EXwzxjJn3DibzcoJE6AzBd5KKu2askkzBG05E=;
        b=JqOhwcEoYabcCja/+Hkt41wc8sEpugZ4HAt1dJMFpLuHqAwwUpLbiWUzTLsdjbpIdd
         Bmk0dFdo7duzqif4+UKkBQLsB44Z+wi8PyrzqlA23l0ilBNBYAFI2R7L+Q+6k0x5SJOm
         POdLMVsd8xFID84+BpKSjDHUxDLoSbgX+vZalRAeCrm0tPY4bQVdsm94vAJMN1+yEZnP
         Dmx7KVQ+ZOebyUEr7v2SgxmST8xdmzoVvPrqsdnqUDyFkeHQcoOp/IydekM09P7vmvX7
         TaJSYf8dXgKaxeAQt/oZvQXwS9S30AhwPEQx05o0gitnoVtV6GZJ4jIJKYShl7/ZyypL
         JOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327278; x=1780932078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eDNeA3EXwzxjJn3DibzcoJE6AzBd5KKu2askkzBG05E=;
        b=Sf/gRFyER/x93+OgTRI5YXuvXx0rI6jZ96rmadPycrDHYG7t7Kgp5hO0u5SduRyt7Q
         oqb50iZtYb1rUUhGgB2rWfZUgjTS5+L3sezz35uxxeWnT7k5jw05WxTS5ffU3L/1cqJB
         E17LZqoC4/JIfYH07AiABsj3qZAQw2PrnUjpzy0UeD5UC2maqpOyGQrrfXBVDjhoa6gP
         89pFoYvOydwSUy1CGwvsTCFCt7w0/2hruFYm2lQFsEu/Kv+oeCBNfXsPPHSqPIJnKjze
         UiWb+PZYOZl6r1dke6gwavDKWK7XMxP3xQK6rDiGMqVWEvFfChGcBbplRRh8ySwkwaLQ
         hv9A==
X-Gm-Message-State: AOJu0YwgXhPYsMZW8Tza0mFqFDmB40seepsb1bLgB7RzBAGCyjeWsaax
	iAoNLhdBnWsyNcdp5H66wCL0mA+frBWYza0KDHfQfUKnWbysEMhC8N4pZb/VBg==
X-Gm-Gg: Acq92OEsIhCm3NM94ks3118aNGgZ0+QRwJjVzMxjRNeE4bulOty0QLiyIBXWsdPDXlr
	PYOfSUiZZjJmypJFFZ3up04DJqhcKAJD3r6omdy5WTNvAAICs2p9f332CG4v4PPdc3eA8sR2ihb
	YKZGTkd8OEbbF+UWbU3PKm0sy30OS+/txWkfsMd2BBUNld15GpZJ41NGmDqeg0PZniw1Wl7RnVh
	mIZ2C5kTDhYmUA12W65OaeQ9B/0yRX37alspxqm+sMlPFec5kMkuOlVcPi4eEkUS30k1IF8DcPs
	3ZK9brxX/jKf/bJ0FCZETTGZl7sy6thyumGzfe20v8HJzyNf7UGs5oNbjYUWwi8XazXgVaDfLlF
	58aZF6H1okpcn563smWKYkS0gxGQLmapS5EmvyxKYK2gLodI/jpsBU0xFUtG5U5mxw20N9YWn7n
	/0r2+lifcxCbc0FUlMeeZ4rfrgoNBc5SofrXU77MUJsRifd41X36wJamZR3cAB0iRE8mRyqBRSw
	0Lp40t3MbRRrXnDmyiyT/kOLDqKp9tCk3LrVv8IgDhg
X-Received: by 2002:a05:6a00:3a0e:b0:83f:250d:59c with SMTP id d2e1a72fcca58-842255b71bamr10655843b3a.39.1780327278403;
        Mon, 01 Jun 2026 08:21:18 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84232ef8172sm7352779b3a.12.2026.06.01.08.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:21:17 -0700 (PDT)
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
Subject: [GSoC][PATCH 1/4] path: add strbuf_add_path for formatting paths
Date: Mon,  1 Jun 2026 20:49:47 +0530
Message-ID: <20260601151950.30686-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `print_path()` function in `builtin/rev-parse.c` contains
logic for formatting paths as either absolute or relative based on user
preferences and default behaviors. However, this logic is currently
locked inside `rev-parse` and writes directly to stdout using `puts()`.

To allow other builtins (such as the new `git repo` command) to utilize
this same path-formatting logic, extract the core algorithm into a new
string-builder function, `strbuf_add_path()`, in `path.c`.

Additionally, extract the associated enums (`format_type` and
`default_type`), and prefix them with `path_` (e.g., `path_format_type`)
to safely expose them in `path.h` without polluting the global namespace.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 path.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 path.h | 16 ++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/path.c b/path.c
index d7e17bf174..914812320f 100644
--- a/path.c
+++ b/path.c
@@ -1579,6 +1579,64 @@ char *xdg_cache_home(const char *filename)
 	return NULL;
 }
 
+void strbuf_add_path(struct strbuf *sb, const char *path, const char *prefix,
+		     enum path_format_type format, enum path_default_type def)
+{
+	char *cwd = NULL;
+
+	/*
+	 * We don't ever produce a relative path if prefix is NULL, so set the
+	 * prefix to the current directory so that we can produce a relative
+	 * path whenever possible. If we're using RELATIVE_IF_SHARED mode, then
+	 * we want an absolute path unless the two share a common prefix, so don't
+	 * set it in that case, since doing so causes a relative path to always
+	 * be produced if possible.
+	 */
+	if (!prefix && (format != PATH_FORMAT_DEFAULT || def != PATH_DEFAULT_RELATIVE_IF_SHARED))
+		prefix = cwd = xgetcwd();
+
+	if (format == PATH_FORMAT_DEFAULT && def == PATH_DEFAULT_UNMODIFIED) {
+		/* Case 1: Return the path exactly as-is without modifications */
+		strbuf_addstr(sb, path);
+	} else if (format == PATH_FORMAT_RELATIVE ||
+		   (format == PATH_FORMAT_DEFAULT && def == PATH_DEFAULT_RELATIVE)) {
+		/*
+		 * Case 2: Explicitly or implicitly relative.
+		 * inside relative_path(), both targets must be absolute paths
+		 * to compute a reliable relative tracking offset.
+		 */
+		struct strbuf buf = STRBUF_INIT, realbuf = STRBUF_INIT, prefixbuf = STRBUF_INIT;
+
+		if (!is_absolute_path(path)) {
+			strbuf_realpath_forgiving(&realbuf, path, 1);
+			path = realbuf.buf;
+		}
+		if (!is_absolute_path(prefix)) {
+			strbuf_realpath_forgiving(&prefixbuf, prefix, 1);
+			prefix = prefixbuf.buf;
+		}
+
+		strbuf_addstr(sb, relative_path(path, prefix, &buf));
+
+		strbuf_release(&buf);
+		strbuf_release(&realbuf);
+		strbuf_release(&prefixbuf);
+	} else if (format == PATH_FORMAT_DEFAULT && def == PATH_DEFAULT_RELATIVE_IF_SHARED) {
+		/* Case 3: Relative format if they share a common root pathway */
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addstr(sb, relative_path(path, prefix, &buf));
+		strbuf_release(&buf);
+	} else {
+		/* Case 4: Forced absolute / canonical format optimization */
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_realpath_forgiving(&buf, path, 1);
+		strbuf_addbuf(sb, &buf);
+		strbuf_release(&buf);
+	}
+
+	free(cwd);
+}
+
 REPO_GIT_PATH_FUNC(squash_msg, "SQUASH_MSG")
 REPO_GIT_PATH_FUNC(merge_msg, "MERGE_MSG")
 REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
diff --git a/path.h b/path.h
index 0434ba5e07..b9b626ce4a 100644
--- a/path.h
+++ b/path.h
@@ -262,6 +262,22 @@ enum scld_error safe_create_leading_directories_no_share(char *path);
 int safe_create_file_with_leading_directories(struct repository *repo,
 					      const char *path);
 
+enum path_format_type {
+	PATH_FORMAT_DEFAULT,
+	PATH_FORMAT_RELATIVE,
+	PATH_FORMAT_CANONICAL
+};
+
+enum path_default_type {
+	PATH_DEFAULT_RELATIVE,
+	PATH_DEFAULT_RELATIVE_IF_SHARED,
+	PATH_DEFAULT_CANONICAL,
+	PATH_DEFAULT_UNMODIFIED
+};
+
+void strbuf_add_path(struct strbuf *buf, const char *path, const char *prefix,
+		     enum path_format_type format, enum path_default_type def);
+
 # ifdef USE_THE_REPOSITORY_VARIABLE
 #  include "strbuf.h"
 #  include "repository.h"
-- 
2.54.0

