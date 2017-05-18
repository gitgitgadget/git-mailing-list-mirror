Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DA7A2027B
	for <e@80x24.org>; Thu, 18 May 2017 23:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754796AbdERXWW (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:22:22 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36859 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbdERXWO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:14 -0400
Received: by mail-pg0-f49.google.com with SMTP id x64so29453229pgd.3
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uTBMD5NYv/rW/05KeIP6dykDewfr1Ag4QzAAmw/obc8=;
        b=HMlnxVjUzn4YCQ3BnT3aRPCO8ImXCeh01NcFWjn4xajnjYVEw3fymnTe8mk0A28k4k
         Dsp+alyHYNP/iBxToJkYVykFPsUj+B8c8l2g/a+23dcqWx5kECQnYx+EvgyQ41RiKqCE
         UuaSkK5g99DDkwa0agUea3ntg+2fQhPkjmRWu6RtQJlEobf55MtROuDuCztfQmPhUSX8
         ll2AZCXWT0QASAtc0yzO2GFn0RHWsn6zJVlIjtGPnX1637nvYmryYe0s00uuHIuw8Qtm
         Tx+Q6is+0mENYFIJzViX5V7UL+Z26IFyILkdAMR5DptXPo9NR7xi/Ezfx3g0iRymHf1C
         AMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uTBMD5NYv/rW/05KeIP6dykDewfr1Ag4QzAAmw/obc8=;
        b=TbafY+zpX4OaEBiVOvyaBwJQD/SqoTC1aVcieHIupTQRI2wpj7W+uQoV7cpJ9NJftx
         2sogPT68nbA+zG8csawBHOo+XByoqJ6/Y3++m/6288BQ8heveou6wUPvgPMSOaoVriso
         4l+vV1sDCxOxKWMXN1WubkzQ2EHJAWZXih1F1zHVpSsVK8RXEN8MOc8Z2HA/n39Zh5Er
         pSonBGe+qY457qXtc0ax7qtPT/Rl1HmoPtMjZVZCPTY56b1zAcSkuwmWBdzeiuXeno6P
         0xoXrjiz8F2QLytVcD0tZZklovXMuBZCodfSHeH2qGLwbz2+754u0wh9tBUAtdX3sxzC
         L1jQ==
X-Gm-Message-State: AODbwcAqW3lX7ar4YxJ0biIF4zUoffUKI0KBPjZwQoZRGGGfDVs0j+t+
        Iplr4CpkyjQwjmUZ
X-Received: by 10.84.192.37 with SMTP id b34mr7744601pld.174.1495149733306;
        Thu, 18 May 2017 16:22:13 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:12 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 04/23] convert: convert convert_to_git to take an index
Date:   Thu, 18 May 2017 16:21:15 -0700
Message-Id: <20170518232134.163059-5-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 apply.c         | 2 +-
 builtin/blame.c | 2 +-
 combine-diff.c  | 2 +-
 convert.c       | 7 ++++---
 convert.h       | 8 +++++---
 diff.c          | 6 +++---
 dir.c           | 2 +-
 sha1_file.c     | 4 ++--
 8 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/apply.c b/apply.c
index e6dbab26a..7813faacf 100644
--- a/apply.c
+++ b/apply.c
@@ -2267,7 +2267,7 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
 			return error(_("unable to open or read %s"), path);
-		convert_to_git(path, buf->buf, buf->len, buf, 0);
+		convert_to_git(&the_index, path, buf->buf, buf->len, buf, 0);
 		return 0;
 	default:
 		return -1;
diff --git a/builtin/blame.c b/builtin/blame.c
index 07506a3e4..8a9c0eb01 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2383,7 +2383,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("failed to read from stdin");
 	}
-	convert_to_git(path, buf.buf, buf.len, &buf, 0);
+	convert_to_git(&the_index, path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_oid.hash);
diff --git a/combine-diff.c b/combine-diff.c
index 2848034fe..74f723af3 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1053,7 +1053,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			if (is_file) {
 				struct strbuf buf = STRBUF_INIT;
 
-				if (convert_to_git(elem->path, result, len, &buf, safe_crlf)) {
+				if (convert_to_git(&the_index, elem->path, result, len, &buf, safe_crlf)) {
 					free(result);
 					result = strbuf_detach(&buf, &len);
 					result_size = len;
diff --git a/convert.c b/convert.c
index d50e7f7aa..3d1c7e2b6 100644
--- a/convert.c
+++ b/convert.c
@@ -1179,7 +1179,8 @@ const char *get_convert_attr_ascii(const char *path)
 	return "";
 }
 
-int convert_to_git(const char *path, const char *src, size_t len,
+int convert_to_git(const struct index_state *istate,
+		   const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
 	int ret = 0;
@@ -1195,7 +1196,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		src = dst->buf;
 		len = dst->len;
 	}
-	ret |= crlf_to_git(&the_index, path, src, len, dst, ca.crlf_action, checksafe);
+	ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, checksafe);
 	if (ret && dst) {
 		src = dst->buf;
 		len = dst->len;
@@ -1266,7 +1267,7 @@ int renormalize_buffer(const char *path, const char *src, size_t len, struct str
 		src = dst->buf;
 		len = dst->len;
 	}
-	return ret | convert_to_git(path, src, len, dst, SAFE_CRLF_RENORMALIZE);
+	return ret | convert_to_git(&the_index, path, src, len, dst, SAFE_CRLF_RENORMALIZE);
 }
 
 /*****************************************************************
diff --git a/convert.h b/convert.h
index 3a813a797..60cb41d6a 100644
--- a/convert.h
+++ b/convert.h
@@ -41,15 +41,17 @@ extern const char *get_wt_convert_stats_ascii(const char *path);
 extern const char *get_convert_attr_ascii(const char *path);
 
 /* returns 1 if *dst was used */
-extern int convert_to_git(const char *path, const char *src, size_t len,
+extern int convert_to_git(const struct index_state *istate,
+			  const char *path, const char *src, size_t len,
 			  struct strbuf *dst, enum safe_crlf checksafe);
 extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
 extern int renormalize_buffer(const char *path, const char *src, size_t len,
 			      struct strbuf *dst);
-static inline int would_convert_to_git(const char *path)
+static inline int would_convert_to_git(const struct index_state *istate,
+				       const char *path)
 {
-	return convert_to_git(path, NULL, 0, NULL, 0);
+	return convert_to_git(istate, path, NULL, 0, NULL, 0);
 }
 /* Precondition: would_convert_to_git_filter_fd(path) == true */
 extern void convert_to_git_filter_fd(const struct index_state *istate,
diff --git a/diff.c b/diff.c
index 74283d900..ab19453e1 100644
--- a/diff.c
+++ b/diff.c
@@ -2755,7 +2755,7 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	 * Similarly, if we'd have to convert the file contents anyway, that
 	 * makes the optimization not worthwhile.
 	 */
-	if (!want_file && would_convert_to_git(name))
+	if (!want_file && would_convert_to_git(&the_index, name))
 		return 0;
 
 	len = strlen(name);
@@ -2877,7 +2877,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		 * point if the path requires us to run the content
 		 * conversion.
 		 */
-		if (size_only && !would_convert_to_git(s->path))
+		if (size_only && !would_convert_to_git(&the_index, s->path))
 			return 0;
 
 		/*
@@ -2904,7 +2904,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		if (convert_to_git(s->path, s->data, s->size, &buf, crlf_warn)) {
+		if (convert_to_git(&the_index, s->path, s->data, s->size, &buf, crlf_warn)) {
 			size_t size = 0;
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
diff --git a/dir.c b/dir.c
index 3f3167e55..128fc2f8d 100644
--- a/dir.c
+++ b/dir.c
@@ -795,7 +795,7 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 				 (pos = index_name_pos(istate, fname, strlen(fname))) >= 0 &&
 				 !ce_stage(istate->cache[pos]) &&
 				 ce_uptodate(istate->cache[pos]) &&
-				 !would_convert_to_git(fname))
+				 !would_convert_to_git(istate, fname))
 				hashcpy(sha1_stat->sha1,
 					istate->cache[pos]->oid.hash);
 			else
diff --git a/sha1_file.c b/sha1_file.c
index ab09241d2..feb227a83 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3546,7 +3546,7 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 	 */
 	if ((type == OBJ_BLOB) && path) {
 		struct strbuf nbuf = STRBUF_INIT;
-		if (convert_to_git(path, buf, size, &nbuf,
+		if (convert_to_git(&the_index, path, buf, size, &nbuf,
 				   write_object ? safe_crlf : SAFE_CRLF_FALSE)) {
 			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
@@ -3668,7 +3668,7 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st,
 	else if (!S_ISREG(st->st_mode))
 		ret = index_pipe(sha1, fd, type, path, flags);
 	else if (st->st_size <= big_file_threshold || type != OBJ_BLOB ||
-		 (path && would_convert_to_git(path)))
+		 (path && would_convert_to_git(&the_index, path)))
 		ret = index_core(sha1, fd, xsize_t(st->st_size), type, path,
 				 flags);
 	else
-- 
2.13.0.303.g4ebf302169-goog

