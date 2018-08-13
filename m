Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5F951F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbeHMS6U (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:20 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43630 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeHMS6T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id f135-v6so11648515lfg.10
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Rw6NTpsvgdRwsuh6ZmKBLpxcWZGSwvu+23ESC1wzYo=;
        b=GENABJSGr4v2ItD+CQmjmYyBqutyLgV9g9SOnQVOdZoLeSy5ooz5M4/O3JK0rSfbQT
         MmQ5sTW4CpU6EE9Cu6tf2xStiAOBrTar8sM8JRaiIE4KuA2th4J1WwOVYD91CyKABUsM
         IFv3o8m6HIDDOHfLAcAwhczGEhhs2+z4xjgEYWdFgQ39pGfNJDcbN3mvu++KGo67RZN/
         1R0QKjO6XbebI+fpu5uGO3XqeGnGtI2SFxPSficf8GOcJHqvZ+AKhjhrVMHPF3Aqa0uz
         5tUWC1fzotO/MCzZeZ+8fpxVnZl+xPAZagwB4E6Ho+nGtqByJ34mFKrcWZ7CRkMucJxc
         zU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Rw6NTpsvgdRwsuh6ZmKBLpxcWZGSwvu+23ESC1wzYo=;
        b=l8+ChO+XbnPKCVZGfqBXkiG56+xnq66cwVsWXjtXo7YO4ifoOrq9u7QQUJhBepZuJ7
         djcl4sXQSfwydZas1d5A3R/tdFS04MhCJHn9KhemYZ20IGHrbWi5dHGN1MA3Whvym83V
         a4p31sEslbOtVR3obHcghm5mkpP1UfLBjXQxuIPN7io+RfhM3mtMNPW7n+MbFTXwTWgw
         7oOn/0bASgIuENohH3z1LRk2VRcsI8WK017wP6j/eSAlwqn+GHzoOzo746qig3LSaONW
         sBIjRgxDhpcgllvTyfFqgwtpEd34UCR8P1nBJ3F9hEoZ1Jrj9P1R43ZCCPkEJ5EHhuO2
         I/tg==
X-Gm-Message-State: AOUpUlH9bl9ipb7vADUdQLuupX0pGXJshh/rOzOPNwcTdJuG7nfuqXwo
        PONewB9Fd+CQY6hk/+NiOb/NBxl3
X-Google-Smtp-Source: AA+uWPyahBAPzfXVej11lKxggLgWaDWf93ctJoLbI6UGT6jRNvFi/gww/eEwxOmIwmNEON9SMbB8Pg==
X-Received: by 2002:a19:9a81:: with SMTP id c123-v6mr11459449lfe.106.1534176923864;
        Mon, 13 Aug 2018 09:15:23 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:22 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/24] convert.c: remove an implicit dependency on the_index
Date:   Mon, 13 Aug 2018 18:14:21 +0200
Message-Id: <20180813161441.16824-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the convert API take an index_state instead of assuming the_index
in convert.c. All external call sites are converted blindly to keep
the patch simple and retain current behavior. Individual call sites
may receive further updates to use the right index instead of
the_index.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 apply.c            |  2 +-
 archive.c          |  2 +-
 builtin/cat-file.c |  2 +-
 builtin/ls-files.c |  2 +-
 convert.c          | 41 ++++++++++++++++++++++++-----------------
 convert.h          | 15 ++++++++++-----
 diff.c             |  2 +-
 entry.c            |  6 +++---
 merge-recursive.c  |  2 +-
 sha1-file.c        |  4 ++--
 10 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/apply.c b/apply.c
index 2594927248..2476f06ebd 100644
--- a/apply.c
+++ b/apply.c
@@ -4335,7 +4335,7 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	if (fd < 0)
 		return 1;
 
-	if (convert_to_working_tree(path, buf, size, &nbuf)) {
+	if (convert_to_working_tree(&the_index, path, buf, size, &nbuf)) {
 		size = nbuf.len;
 		buf  = nbuf.buf;
 	}
diff --git a/archive.c b/archive.c
index a8397e6173..31de1bba52 100644
--- a/archive.c
+++ b/archive.c
@@ -79,7 +79,7 @@ void *object_file_to_archive(const struct archiver_args *args,
 		size_t size = 0;
 
 		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
-		convert_to_working_tree(path, buf.buf, buf.len, &buf);
+		convert_to_working_tree(&the_index, path, buf.buf, buf.len, &buf);
 		if (commit)
 			format_subst(commit, buf.buf, buf.len, &buf);
 		buffer = strbuf_detach(&buf, &size);
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 4a44b2404f..c726ee1092 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -39,7 +39,7 @@ static int filter_object(const char *path, unsigned mode,
 			     oid_to_hex(oid), path);
 	if ((type == OBJ_BLOB) && S_ISREG(mode)) {
 		struct strbuf strbuf = STRBUF_INIT;
-		if (convert_to_working_tree(path, *buf, *size, &strbuf)) {
+		if (convert_to_working_tree(&the_index, path, *buf, *size, &strbuf)) {
 			free(*buf);
 			*size = strbuf.len;
 			*buf = strbuf_detach(&strbuf, NULL);
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 88bb2019ad..d996734b45 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -63,7 +63,7 @@ static void write_eolinfo(const struct index_state *istate,
 		struct stat st;
 		const char *i_txt = "";
 		const char *w_txt = "";
-		const char *a_txt = get_convert_attr_ascii(path);
+		const char *a_txt = get_convert_attr_ascii(&the_index, path);
 		if (ce && S_ISREG(ce->ce_mode))
 			i_txt = get_cached_convert_stats_ascii(istate,
 							       ce->name);
diff --git a/convert.c b/convert.c
index 1935bde929..8acfe8ae45 100644
--- a/convert.c
+++ b/convert.c
@@ -1291,7 +1291,8 @@ struct conv_attrs {
 	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
 };
 
-static void convert_attrs(struct conv_attrs *ca, const char *path)
+static void convert_attrs(const struct index_state *istate,
+			  struct conv_attrs *ca, const char *path)
 {
 	static struct attr_check *check;
 
@@ -1303,7 +1304,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 		git_config(read_convert_config, NULL);
 	}
 
-	if (!git_check_attr(&the_index, path, check)) {
+	if (!git_check_attr(istate, path, check)) {
 		struct attr_check_item *ccheck = check->items;
 		ca->crlf_action = git_path_check_crlf(ccheck + 4);
 		if (ca->crlf_action == CRLF_UNDEFINED)
@@ -1340,11 +1341,11 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 		ca->crlf_action = CRLF_AUTO_INPUT;
 }
 
-int would_convert_to_git_filter_fd(const char *path)
+int would_convert_to_git_filter_fd(const struct index_state *istate, const char *path)
 {
 	struct conv_attrs ca;
 
-	convert_attrs(&ca, path);
+	convert_attrs(istate, &ca, path);
 	if (!ca.drv)
 		return 0;
 
@@ -1359,11 +1360,11 @@ int would_convert_to_git_filter_fd(const char *path)
 	return apply_filter(path, NULL, 0, -1, NULL, ca.drv, CAP_CLEAN, NULL);
 }
 
-const char *get_convert_attr_ascii(const char *path)
+const char *get_convert_attr_ascii(const struct index_state *istate, const char *path)
 {
 	struct conv_attrs ca;
 
-	convert_attrs(&ca, path);
+	convert_attrs(istate, &ca, path);
 	switch (ca.attr_action) {
 	case CRLF_UNDEFINED:
 		return "";
@@ -1392,7 +1393,7 @@ int convert_to_git(const struct index_state *istate,
 	int ret = 0;
 	struct conv_attrs ca;
 
-	convert_attrs(&ca, path);
+	convert_attrs(istate, &ca, path);
 
 	ret |= apply_filter(path, src, len, -1, dst, ca.drv, CAP_CLEAN, NULL);
 	if (!ret && ca.drv && ca.drv->required)
@@ -1424,7 +1425,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 			      int conv_flags)
 {
 	struct conv_attrs ca;
-	convert_attrs(&ca, path);
+	convert_attrs(istate, &ca, path);
 
 	assert(ca.drv);
 	assert(ca.drv->clean || ca.drv->process);
@@ -1437,14 +1438,15 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
 
-static int convert_to_working_tree_internal(const char *path, const char *src,
+static int convert_to_working_tree_internal(const struct index_state *istate,
+					    const char *path, const char *src,
 					    size_t len, struct strbuf *dst,
 					    int normalizing, struct delayed_checkout *dco)
 {
 	int ret = 0, ret_filter = 0;
 	struct conv_attrs ca;
 
-	convert_attrs(&ca, path);
+	convert_attrs(istate, &ca, path);
 
 	ret |= ident_to_worktree(path, src, len, dst, ca.ident);
 	if (ret) {
@@ -1478,22 +1480,25 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 	return ret | ret_filter;
 }
 
-int async_convert_to_working_tree(const char *path, const char *src,
+int async_convert_to_working_tree(const struct index_state *istate,
+				  const char *path, const char *src,
 				  size_t len, struct strbuf *dst,
 				  void *dco)
 {
-	return convert_to_working_tree_internal(path, src, len, dst, 0, dco);
+	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, dco);
 }
 
-int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst)
+int convert_to_working_tree(const struct index_state *istate,
+			    const char *path, const char *src,
+			    size_t len, struct strbuf *dst)
 {
-	return convert_to_working_tree_internal(path, src, len, dst, 0, NULL);
+	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, NULL);
 }
 
 int renormalize_buffer(const struct index_state *istate, const char *path,
 		       const char *src, size_t len, struct strbuf *dst)
 {
-	int ret = convert_to_working_tree_internal(path, src, len, dst, 1, NULL);
+	int ret = convert_to_working_tree_internal(istate, path, src, len, dst, 1, NULL);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
@@ -1927,12 +1932,14 @@ static struct stream_filter *ident_filter(const struct object_id *oid)
  * Note that you would be crazy to set CRLF, smuge/clean or ident to a
  * large binary blob you would want us not to slurp into the memory!
  */
-struct stream_filter *get_stream_filter(const char *path, const struct object_id *oid)
+struct stream_filter *get_stream_filter(const struct index_state *istate,
+					const char *path,
+					const struct object_id *oid)
 {
 	struct conv_attrs ca;
 	struct stream_filter *filter = NULL;
 
-	convert_attrs(&ca, path);
+	convert_attrs(istate, &ca, path);
 	if (ca.drv && (ca.drv->process || ca.drv->smudge || ca.drv->clean))
 		return NULL;
 
diff --git a/convert.h b/convert.h
index 0a0fa15b58..6d0ee887ed 100644
--- a/convert.h
+++ b/convert.h
@@ -60,15 +60,18 @@ extern char *check_roundtrip_encoding;
 const char *get_cached_convert_stats_ascii(const struct index_state *istate,
 					   const char *path);
 const char *get_wt_convert_stats_ascii(const char *path);
-const char *get_convert_attr_ascii(const char *path);
+const char *get_convert_attr_ascii(const struct index_state *istate,
+				   const char *path);
 
 /* returns 1 if *dst was used */
 int convert_to_git(const struct index_state *istate,
 		   const char *path, const char *src, size_t len,
 		   struct strbuf *dst, int conv_flags);
-int convert_to_working_tree(const char *path, const char *src,
+int convert_to_working_tree(const struct index_state *istate,
+			    const char *path, const char *src,
 			    size_t len, struct strbuf *dst);
-int async_convert_to_working_tree(const char *path, const char *src,
+int async_convert_to_working_tree(const struct index_state *istate,
+				  const char *path, const char *src,
 				  size_t len, struct strbuf *dst,
 				  void *dco);
 int async_query_available_blobs(const char *cmd,
@@ -86,7 +89,8 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 			      const char *path, int fd,
 			      struct strbuf *dst,
 			      int conv_flags);
-int would_convert_to_git_filter_fd(const char *path);
+int would_convert_to_git_filter_fd(const struct index_state *istate,
+				   const char *path);
 
 /*****************************************************************
  *
@@ -96,7 +100,8 @@ int would_convert_to_git_filter_fd(const char *path);
 
 struct stream_filter; /* opaque */
 
-struct stream_filter *get_stream_filter(const char *path,
+struct stream_filter *get_stream_filter(const struct index_state *istate,
+					const char *path,
 					const struct object_id *);
 void free_stream_filter(struct stream_filter *);
 int is_null_stream_filter(struct stream_filter *);
diff --git a/diff.c b/diff.c
index 72ce8007fd..3670206d23 100644
--- a/diff.c
+++ b/diff.c
@@ -3893,7 +3893,7 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 	temp->tempfile = mks_tempfile_ts(tempfile.buf, strlen(base) + 1);
 	if (!temp->tempfile)
 		die_errno("unable to create temp-file");
-	if (convert_to_working_tree(path,
+	if (convert_to_working_tree(&the_index, path,
 			(const char *)blob, (size_t)size, &buf)) {
 		blob = buf.buf;
 		size = buf.len;
diff --git a/entry.c b/entry.c
index b5d1d3cf23..b2381fd9f6 100644
--- a/entry.c
+++ b/entry.c
@@ -266,7 +266,7 @@ static int write_entry(struct cache_entry *ce,
 	const struct submodule *sub;
 
 	if (ce_mode_s_ifmt == S_IFREG) {
-		struct stream_filter *filter = get_stream_filter(ce->name,
+		struct stream_filter *filter = get_stream_filter(&the_index, ce->name,
 								 &ce->oid);
 		if (filter &&
 		    !streaming_write_entry(ce, path, filter,
@@ -314,14 +314,14 @@ static int write_entry(struct cache_entry *ce,
 		 * Convert from git internal format to working tree format
 		 */
 		if (dco && dco->state != CE_NO_DELAY) {
-			ret = async_convert_to_working_tree(ce->name, new_blob,
+			ret = async_convert_to_working_tree(&the_index, ce->name, new_blob,
 							    size, &buf, dco);
 			if (ret && string_list_has_string(&dco->paths, ce->name)) {
 				free(new_blob);
 				goto delayed;
 			}
 		} else
-			ret = convert_to_working_tree(ce->name, new_blob, size, &buf);
+			ret = convert_to_working_tree(&the_index, ce->name, new_blob, size, &buf);
 
 		if (ret) {
 			free(new_blob);
diff --git a/merge-recursive.c b/merge-recursive.c
index 1446e92bea..defcbff93b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -966,7 +966,7 @@ static int update_file_flags(struct merge_options *o,
 		}
 		if (S_ISREG(mode)) {
 			struct strbuf strbuf = STRBUF_INIT;
-			if (convert_to_working_tree(path, buf, size, &strbuf)) {
+			if (convert_to_working_tree(&the_index, path, buf, size, &strbuf)) {
 				free(buf);
 				size = strbuf.len;
 				buf = strbuf_detach(&strbuf, NULL);
diff --git a/sha1-file.c b/sha1-file.c
index dfa8a35d68..0016d46052 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1860,7 +1860,7 @@ static int index_stream_convert_blob(struct object_id *oid, int fd,
 	struct strbuf sbuf = STRBUF_INIT;
 
 	assert(path);
-	assert(would_convert_to_git_filter_fd(path));
+	assert(would_convert_to_git_filter_fd(&the_index, path));
 
 	convert_to_git_filter_fd(&the_index, path, fd, &sbuf,
 				 get_conv_flags(flags));
@@ -1950,7 +1950,7 @@ int index_fd(struct object_id *oid, int fd, struct stat *st,
 	 * Call xsize_t() only when needed to avoid potentially unnecessary
 	 * die() for large files.
 	 */
-	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(path))
+	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(&the_index, path))
 		ret = index_stream_convert_blob(oid, fd, path, flags);
 	else if (!S_ISREG(st->st_mode))
 		ret = index_pipe(oid, fd, type, path, flags);
-- 
2.18.0.1004.g6639190530

