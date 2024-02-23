Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40DBC8CE
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 03:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658319; cv=none; b=F7+PBetU5k54DhtAAcVEf24Otxfow8T+D8FwejXvk7yEUz49rtOeeSeJAjJm6bUM9pxTzMI0hSz1YZLy8PdTt9AM3RTCgrXNvv+ZvVyurb7V8WUi4yG9QeXJYWwDJOmeNa4RnHPo8/3lusi3NozNcxbJjvLohzX6ZbKVH5dJZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658319; c=relaxed/simple;
	bh=xwwjxYlk0GoqT68YQSxD4qNy63+zETfjSYr+zKyQqEQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ccM93YHni/7VtiPZ4bNdAPDiZdW3IOqy6ppecceKbl6dGpOb6+KgpzDUdU6ksL8/MSBYq1JevcT0bbJOWGM0IZ+/H6/HhWf1qxLZogSn7ma2rTMJvskLrKrq6vD2101ELxT+mKjXiP4Y83vMn/6LteSsbDFHv5GbOOdxMsXgqSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVxzQ+W1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVxzQ+W1"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so3135255e9.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 19:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708658316; x=1709263116; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NdkiaalWQSUju4Cy2JLcnEWt1y46LCzKnjE2/QmSec=;
        b=WVxzQ+W1FDeb0T5MbUILgwYFyMzsaIVvdSU/qIhgzbGGQU6Xk3aEhaLa73ZNadhsHV
         WqxfrzB2dfpoWG7dWWrbm/+J+B6G8Z4GwlBYwa9167Lnq8D+EIbh+hthvYnEQncut0sL
         acJGbofmePAyAYsrS5oK3b36aPWmLE2P8O0tCRGWnvj7O9i2GeRW7ve4NwlRR+U0c1/D
         TgKdL9+QDqOwfqV1JqZdhzS/JTAXqu1P/r/wyhkcvRYfljd+UD4fponhA3cQKN2TL5js
         Td4Z9AbueL4t+REySXuyXlwiCgyUlArLYx6CnMoTSCdDHhoNguL9Me5Qd/GrRsi8+rrG
         Mn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708658316; x=1709263116;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NdkiaalWQSUju4Cy2JLcnEWt1y46LCzKnjE2/QmSec=;
        b=dnu4uECv2Bj6N7NzQPyXPsbyEeOwXcjNNH19PyHsZLRDVldH8aITaxpZv3HcOMiKo5
         lpXFnMNsZfye7ZpMIkcCpNgsJ1KbEuRAaYmI+hSgWCKmwU0O0AEpra+rPEARJlCUI5sw
         XN09EcVSVpTYj7HlfbqYd05cANWuCY8vTy+/mqcY2ctc14N6xIoOcPe39blspCNjL9/l
         ym/EbXZVNH13UmVrtn/RrggPMa5tEUGco1SEka1zXkVf0e64JMmNOPGV5MjR6t9W63X+
         6PVy3yZSFttC4FIIsuQ9BBSDRtbeoGeQQv3d4zxKXnXEW2D+XD6v9wBMv2LeXPZ9CT+l
         ypNQ==
X-Gm-Message-State: AOJu0YwZh37vi1EhDbHEr3+fy+ZJfbof6VOdFZXWittsE98QJhP3ToqP
	gQqDqgaiN8REii9Q99U6n3HRYExgM4R0pktmrWdzqVygFNRg6dGO78U5A0Oa
X-Google-Smtp-Source: AGHT+IHGjSpIGoz16qnVOygXufwG8702yXucFmYgMAxmlXWKpsbgA8tX2hIdQDQdvmOGU5LaQVj0EQ==
X-Received: by 2002:a05:600c:a39e:b0:412:8c43:98ef with SMTP id hn30-20020a05600ca39e00b004128c4398efmr348728wmb.21.1708658315680;
        Thu, 22 Feb 2024 19:18:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc19-20020a05600c525300b0041285ffec13sm578415wmb.41.2024.02.22.19.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 19:18:35 -0800 (PST)
Message-ID: <288f3f4e54e98a68d72e97125b1520605c138c3c.1708658300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 03:18:18 +0000
Subject: [PATCH v2 14/16] fsmonitor: support case-insensitive events
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Teach fsmonitor_refresh_callback() to handle case-insensitive
lookups if case-sensitive lookups fail on case-insensitive systems.
This can cause 'git status' to report stale status for files if there
are case issues/errors in the worktree.

The FSMonitor daemon sends FSEvents using the observed spelling
of each pathname.  On case-insensitive file systems this may be
different than the expected case spelling.

The existing code uses index_name_pos() to find the cache-entry for
the pathname in the FSEvent and clear the CE_FSMONITOR_VALID bit so
that the worktree scan/index refresh will revisit and revalidate the
path.

On a case-insensitive file system, the exact match lookup may fail
to find the associated cache-entry. This causes status to think that
the cached CE flags are correct and skip over the file.

Update event handling to optionally use the name-hash and dir-name-hash
if necessary.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/fsmonitor.c b/fsmonitor.c
index 739ddbf7aca..ac638a61c00 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -5,6 +5,7 @@
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
 #include "fsmonitor-ipc.h"
+#include "name-hash.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "trace2.h"
@@ -186,6 +187,102 @@ static int query_fsmonitor_hook(struct repository *r,
 static size_t handle_path_with_trailing_slash(
 	struct index_state *istate, const char *name, int pos);
 
+/*
+ * Use the name-hash to do a case-insensitive cache-entry lookup with
+ * the pathname and invalidate the cache-entry.
+ *
+ * Returns the number of cache-entries that we invalidated.
+ */
+static size_t handle_using_name_hash_icase(
+	struct index_state *istate, const char *name)
+{
+	struct cache_entry *ce = NULL;
+
+	ce = index_file_exists(istate, name, strlen(name), 1);
+	if (!ce)
+		return 0;
+
+	/*
+	 * A case-insensitive search in the name-hash using the
+	 * observed pathname found a cache-entry, so the observed path
+	 * is case-incorrect.  Invalidate the cache-entry and use the
+	 * correct spelling from the cache-entry to invalidate the
+	 * untracked-cache.  Since we now have sparse-directories in
+	 * the index, the observed pathname may represent a regular
+	 * file or a sparse-index directory.
+	 *
+	 * Note that we should not have seen FSEvents for a
+	 * sparse-index directory, but we handle it just in case.
+	 *
+	 * Either way, we know that there are not any cache-entries for
+	 * children inside the cone of the directory, so we don't need to
+	 * do the usual scan.
+	 */
+	trace_printf_key(&trace_fsmonitor,
+			 "fsmonitor_refresh_callback MAP: '%s' '%s'",
+			 name, ce->name);
+
+	untracked_cache_invalidate_trimmed_path(istate, ce->name, 0);
+
+	ce->ce_flags &= ~CE_FSMONITOR_VALID;
+	return 1;
+}
+
+/*
+ * Use the dir-name-hash to find the correct-case spelling of the
+ * directory.  Use the canonical spelling to invalidate all of the
+ * cache-entries within the matching cone.
+ *
+ * Returns the number of cache-entries that we invalidated.
+ */
+static size_t handle_using_dir_name_hash_icase(
+	struct index_state *istate, const char *name)
+{
+	struct strbuf canonical_path = STRBUF_INIT;
+	int pos;
+	size_t len = strlen(name);
+	size_t nr_in_cone;
+
+	if (name[len - 1] == '/')
+		len--;
+
+	if (!index_dir_find(istate, name, len, &canonical_path))
+		return 0; /* name is untracked */
+
+	if (!memcmp(name, canonical_path.buf, canonical_path.len)) {
+		strbuf_release(&canonical_path);
+		/*
+		 * NEEDSWORK: Our caller already tried an exact match
+		 * and failed to find one.  They called us to do an
+		 * ICASE match, so we should never get an exact match,
+		 * so we could promote this to a BUG() here if we
+		 * wanted to.  It doesn't hurt anything to just return
+		 * 0 and go on becaus we should never get here.  Or we
+		 * could just get rid of the memcmp() and this "if"
+		 * clause completely.
+		 */
+		return 0; /* should not happen */
+	}
+
+	trace_printf_key(&trace_fsmonitor,
+			 "fsmonitor_refresh_callback MAP: '%s' '%s'",
+			 name, canonical_path.buf);
+
+	/*
+	 * The dir-name-hash only tells us the corrected spelling of
+	 * the prefix.  We have to use this canonical path to do a
+	 * lookup in the cache-entry array so that we repeat the
+	 * original search using the case-corrected spelling.
+	 */
+	strbuf_addch(&canonical_path, '/');
+	pos = index_name_pos(istate, canonical_path.buf,
+			     canonical_path.len);
+	nr_in_cone = handle_path_with_trailing_slash(
+		istate, canonical_path.buf, pos);
+	strbuf_release(&canonical_path);
+	return nr_in_cone;
+}
+
 /*
  * The daemon sent an observed pathname without a trailing slash.
  * (This is the normal case.)  We do not know if it is a tracked or
@@ -319,6 +416,19 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 	else
 		nr_in_cone = handle_path_without_trailing_slash(istate, name, pos);
 
+	/*
+	 * If we did not find an exact match for this pathname or any
+	 * cache-entries with this directory prefix and we're on a
+	 * case-insensitive file system, try again using the name-hash
+	 * and dir-name-hash.
+	 */
+	if (!nr_in_cone && ignore_case) {
+		nr_in_cone = handle_using_name_hash_icase(istate, name);
+		if (!nr_in_cone)
+			nr_in_cone = handle_using_dir_name_hash_icase(
+				istate, name);
+	}
+
 	if (nr_in_cone)
 		trace_printf_key(&trace_fsmonitor,
 				 "fsmonitor_refresh_callback CNT: %d",
-- 
gitgitgadget

