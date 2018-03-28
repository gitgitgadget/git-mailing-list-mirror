Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 961161F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753291AbeC1R41 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:56:27 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39493 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753181AbeC1R4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:56:24 -0400
Received: by mail-lf0-f66.google.com with SMTP id p142-v6so4726726lfd.6
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x2dmtagEF2bdTa59Q7drMJVTo9tSW4UGIVJRnLpcZ3A=;
        b=dpS8lEix0974J3le0IlagEIsF1aksv3GR4SqENDVsd0S5rvBIX6D/az6p80Ybx0MQT
         iu1j4EHVUYOrozW9wYhF44EBVgnVqJTmcNz6Dr8NtIbbfH96+an+Eqijs1D8UK+zaaNS
         g6Mu/HgJhDOdPhXfF51iDR0AWrgH4D69mIlxyYCWcUxBB1NibCKUcZMRXYxM5tdeiFkw
         pY+h6Tsih6Ur/Rv0tlAzdzoT+4cnntjjpDxpkKu63RMPpRnT0LnhztLogc6yky9uFL2a
         gCjwLrleD9fPn7MKZsHtYevclwou+wXdeL2PYKeBN9n2WkH/bZwabkgGF/qbqAX+dk+P
         7UwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x2dmtagEF2bdTa59Q7drMJVTo9tSW4UGIVJRnLpcZ3A=;
        b=t04QP7EIwZJGHTEW4TEGIP/e0NlDuyHH6sbzOa/vMmiDHQ1+FVQ/ks/e7iOe4UnfJD
         UqcODJGqYaTTmF0iLjSxWIz87W4vMNZ3YsXapz/09Oh1bWoAj2JQxUdjoYBlfA256QI6
         tDt1Ue30Pbk0SqrdGjVFG5p8ZY4hvmns5cuta8+DnDKQ9fK5ZuiF2TlTIBltLGkyQmeA
         jjzncQvlBQW56qQH6oKHA5zUtPjyfBkYe0i5SY65SnNp46uOEENRaxn30OgZITzDtrWr
         q+hTLUPOS5aZRlNsbdnlPgCl+zFMpkXcv/4lcxcypMIP6IPn3HLnuoNjKAIHy5p8pty4
         nP5g==
X-Gm-Message-State: AElRT7GATfDWZikLJSkhULZOi/HUvKOslOeHoRiSiAZRpMDBxQTxV8+g
        Sdo8Fz8kio7R8gtyraUcBI3MsA==
X-Google-Smtp-Source: AIpwx494UgKjJdqjxz7x8ENy99cCstVVKGibVmjCMmosbAMqb4+12TaSa3YxUxkicUfB+c33QoXvkw==
X-Received: by 2002:a19:a003:: with SMTP id j3-v6mr2955855lfe.8.1522259782626;
        Wed, 28 Mar 2018 10:56:22 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s12sm706658ljj.49.2018.03.28.10.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 10:56:21 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Rafael Ascensao <rafa.almas@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 1/8] strbuf.c: add strbuf_ensure_trailing_dr_sep()
Date:   Wed, 28 Mar 2018 19:55:30 +0200
Message-Id: <20180328175537.17450-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.439.gca064e2955
In-Reply-To: <20180328175537.17450-1-pclouds@gmail.com>
References: <20180328094733.GA1523@sigill.intra.peff.net>
 <20180328175537.17450-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Duy Nguyen <pclouds@gmail.com>

This is just good cleanup and the logic will also be needed in new
patches.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 abspath.c          | 4 +---
 builtin/difftool.c | 6 ++----
 dir-iterator.c     | 3 +--
 path.c             | 9 +++------
 strbuf.c           | 6 ++++++
 strbuf.h           | 2 ++
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/abspath.c b/abspath.c
index 9857985329..994075b5c8 100644
--- a/abspath.c
+++ b/abspath.c
@@ -122,9 +122,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 			continue;
 		}
 
-		/* append the next component and resolve resultant path */
-		if (!is_dir_sep(resolved->buf[resolved->len - 1]))
-			strbuf_addch(resolved, '/');
+		strbuf_ensure_trailing_dir_sep(resolved);
 		strbuf_addbuf(resolved, &next);
 
 		if (lstat(resolved->buf, &st)) {
diff --git a/builtin/difftool.c b/builtin/difftool.c
index ee8dce019e..8d125c7968 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -88,8 +88,7 @@ static int parse_index_info(char *p, int *mode1, int *mode2,
 static void add_path(struct strbuf *buf, size_t base_len, const char *path)
 {
 	strbuf_setlen(buf, base_len);
-	if (buf->len && buf->buf[buf->len - 1] != '/')
-		strbuf_addch(buf, '/');
+	strbuf_ensure_trailing_dir_sep(buf);
 	strbuf_addstr(buf, path);
 }
 
@@ -362,8 +361,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	strbuf_addf(&ldir, "%s/left/", tmpdir);
 	strbuf_addf(&rdir, "%s/right/", tmpdir);
 	strbuf_addstr(&wtdir, workdir);
-	if (!wtdir.len || !is_dir_sep(wtdir.buf[wtdir.len - 1]))
-		strbuf_addch(&wtdir, '/');
+	strbuf_ensure_trailing_dir_sep(&wtdir);
 	mkdir(ldir.buf, 0700);
 	mkdir(rdir.buf, 0700);
 
diff --git a/dir-iterator.c b/dir-iterator.c
index 34182a9a1c..249b5325cf 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -65,8 +65,7 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			 * Note: dir_iterator_begin() ensures that
 			 * path is not the empty string.
 			 */
-			if (!is_dir_sep(iter->base.path.buf[iter->base.path.len - 1]))
-				strbuf_addch(&iter->base.path, '/');
+			strbuf_ensure_trailing_dir_sep(&iter->base.path);
 			level->prefix_len = iter->base.path.len;
 
 			level->dir = opendir(iter->base.path.buf);
diff --git a/path.c b/path.c
index 3308b7b958..cd0ad89868 100644
--- a/path.c
+++ b/path.c
@@ -408,8 +408,7 @@ static void do_git_path(const struct repository *repo,
 {
 	int gitdir_len;
 	strbuf_worktree_gitdir(buf, repo, wt);
-	if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
-		strbuf_addch(buf, '/');
+	strbuf_ensure_trailing_dir_sep(buf);
 	gitdir_len = buf->len;
 	strbuf_vaddf(buf, fmt, args);
 	if (!wt)
@@ -512,8 +511,7 @@ static void do_worktree_path(const struct repository *repo,
 			     const char *fmt, va_list args)
 {
 	strbuf_addstr(buf, repo->worktree);
-	if(buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
-		strbuf_addch(buf, '/');
+	strbuf_ensure_trailing_dir_sep(buf);
 
 	strbuf_vaddf(buf, fmt, args);
 	strbuf_cleanup_path(buf);
@@ -608,8 +606,7 @@ static void do_git_common_path(const struct repository *repo,
 			       va_list args)
 {
 	strbuf_addstr(buf, repo->commondir);
-	if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
-		strbuf_addch(buf, '/');
+	strbuf_ensure_trailing_dir_sep(buf);
 	strbuf_vaddf(buf, fmt, args);
 	strbuf_cleanup_path(buf);
 }
diff --git a/strbuf.c b/strbuf.c
index 83d05024e6..d5b7cda61e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -122,6 +122,12 @@ void strbuf_ltrim(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
+void strbuf_ensure_trailing_dir_sep(struct strbuf *sb)
+{
+	if (sb->len && !is_dir_sep(sb->buf[sb->len - 1]))
+		strbuf_addch(sb, '/');
+}
+
 int strbuf_reencode(struct strbuf *sb, const char *from, const char *to)
 {
 	char *out;
diff --git a/strbuf.h b/strbuf.h
index c4de5e4588..62dc7f16fa 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -189,6 +189,8 @@ extern void strbuf_ltrim(struct strbuf *);
 
 /* Strip trailing directory separators */
 extern void strbuf_trim_trailing_dir_sep(struct strbuf *);
+/* Append trailing directory separator if necessary */
+extern void strbuf_ensure_trailing_dir_sep(struct strbuf *sb);
 
 /**
  * Replace the contents of the strbuf with a reencoded form.  Returns -1
-- 
2.17.0.rc1.439.gca064e2955

