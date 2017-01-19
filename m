Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78D3A20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 12:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbdASM0l (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 07:26:41 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34702 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752341AbdASM0k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 07:26:40 -0500
Received: by mail-pf0-f193.google.com with SMTP id y143so3296469pfb.1
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 04:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lKD1SIol35GH++jPL7IF4V17eyC9Ww2RXyXSUzhEMWU=;
        b=fiN5r2csoVSBmVYlT4QXhe5goynTGCv9Ic4/CYtKwkwgWuJCIOPvcJiZHazzoaAbz1
         cSCCYOQtdKwaXaB2ibcUjR5ya8rTIsK9jyp2YxjW1LkpSEnqUKRF1W2STGP7HTkKBR2O
         n5a1qtR5cgIYctsrnkNyNxvIGs9aWPHnVWf6ijyR4b6xEVkIrUBgjaYf51VqK+nB5/Ky
         TbjeIhRhNHzNXh+LfYIykJp9pKh0PW3lrsyoOqOrYbqgYGSvEy3HCjSWeRa2TVBd9f4z
         DeFin/J4qQRGn83sC4Hi054zrhDzciLy9F/GbaPe2SkK7wzMz1IfcaNA7JpOAAl3KaiJ
         Y41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lKD1SIol35GH++jPL7IF4V17eyC9Ww2RXyXSUzhEMWU=;
        b=e/azuKwS3LgOaSB3NSHz5qcZJNwFIMK5gWCIE0yhu6wd5t/Og62q7+ElQi02ElZzkh
         QLehKGu3Unnt1v+/e/tZNDgWYcPhiNBezuX+mfrKj4p9lpH4oxEZvOT/OOsPfr4YqOrZ
         aIiLsW1qVGn7F7dhTQPCH+yCBCTKIUvNpApCi1bu/M62fBkcWsbCisMqnLg8dhX/bSLy
         AkkOFoOKDs7soMUecKP1BKe9rd4g8fqnn3caKIGl5hIlwvDVmhI7qL7zOW9SjO67BniO
         r/5Ueu/S9cs5i79aC1/ZfcPUkj8imWH6y+82tLPu7EoBETIzB0kUE+ywqFwbL6Y5ImVv
         BUwg==
X-Gm-Message-State: AIkVDXJqot7xvvfAT7B3jpDnIILAcNru/wgvGAbcoNz1M5dkSacMgSGu/5arioZb4obf5w==
X-Received: by 10.99.95.216 with SMTP id t207mr10111362pgb.0.1484828799042;
        Thu, 19 Jan 2017 04:26:39 -0800 (PST)
Received: from ash ([115.72.179.24])
        by smtp.gmail.com with ESMTPSA id z29sm8675893pgc.7.2017.01.19.04.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jan 2017 04:26:38 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 19 Jan 2017 19:26:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] log: new option decorate reflog of remote refs
Date:   Thu, 19 Jan 2017 19:26:30 +0700
Message-Id: <20170119122630.27645-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is most useful when you fork your branches off a remote ref and
rely on ref decoration to show your fork points in `git log`. Then you
do a "git fetch" and suddenly the remote decoration is gone because
remote refs are moved forward. With this, we can still see something
like "origin/foo@{1}"

This is for remote refs only because based on my experience, docorating
local reflog is just too noisy. You will most likely see HEAD@{1},
HEAD@{2} and so on. We can add that as a separate option in future if we
see a need for it.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 I've been using this for many weeks and it has proven its usefulness
 (to me). Looks like good material to send upstream.

 Documentation/git-log.txt |  5 +++++
 builtin/log.c             | 10 +++++++++-
 log-tree.c                | 43 +++++++++++++++++++++++++++++++++++++++----
 log-tree.h                |  2 +-
 pretty.c                  |  4 ++--
 revision.c                |  2 +-
 6 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 32246fd..f5ee575 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -38,6 +38,11 @@ OPTIONS
 	are shown as if 'short' were given, otherwise no ref names are
 	shown. The default option is 'short'.
 
+--decorate-remote-reflog[=<n>]::
+	Decorate `<n>` most recent reflog entries on remote refs, up
+	to the specified number of entries. By default, only the most
+	recent reflog entry is decorated.
+
 --source::
 	Print out the ref name given on the command line by which each
 	commit was reached.
diff --git a/builtin/log.c b/builtin/log.c
index 55d20cc..c208703 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -36,6 +36,7 @@ static int default_follow;
 static int default_show_signature;
 static int decoration_style;
 static int decoration_given;
+static int decorate_remote_reflog;
 static int use_mailmap_config;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
@@ -141,6 +142,10 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		OPT_BOOL(0, "use-mailmap", &mailmap, N_("Use mail map file")),
 		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, N_("decorate options"),
 		  PARSE_OPT_OPTARG, decorate_callback},
+		{ OPTION_INTEGER, 0, "decorate-remote-reflog",
+		  &decorate_remote_reflog, N_("n"),
+		  N_("decorate the last <n> reflog entries of remote refs"),
+		  PARSE_OPT_OPTARG | PARSE_OPT_NONEG, NULL, 1 },
 		OPT_CALLBACK('L', NULL, &line_cb, "n,m:file",
 			     N_("Process line range n,m in file, counting from 1"),
 			     log_line_range_callback),
@@ -195,9 +200,12 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			rev->abbrev_commit = 0;
 	}
 
+	if (decorate_remote_reflog > 0 && !decoration_style)
+		decoration_style = DECORATE_SHORT_REFS;
 	if (decoration_style) {
 		rev->show_decorations = 1;
-		load_ref_decorations(decoration_style);
+		load_ref_decorations(decoration_style,
+				     decorate_remote_reflog);
 	}
 
 	if (rev->line_level_traverse)
diff --git a/log-tree.c b/log-tree.c
index 8c24157..3d85ebc 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -88,14 +88,37 @@ const struct name_decoration *get_name_decoration(const struct object *obj)
 	return lookup_decoration(&name_decoration, obj);
 }
 
+struct reflog_cb {
+	int type;
+	int count;
+	int nth;
+	const char *refname;
+};
+
+static int add_nth_reflog(unsigned char *osha1, unsigned char *nsha1,
+			  const char *email, unsigned long timestamp, int tz,
+			  const char *message, void *cb_data)
+{
+	struct reflog_cb *cb = cb_data;
+	struct commit *commit;
+
+	commit = lookup_commit(nsha1);
+	if (commit && cb->nth) {
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addf(&sb, "%s@{%d}", cb->refname, cb->nth);
+		add_name_decoration(cb->type, sb.buf, &commit->object);
+		strbuf_release(&sb);
+	}
+	cb->nth++;
+	return cb->nth >= cb->count;
+}
+
 static int add_ref_decoration(const char *refname, const struct object_id *oid,
 			      int flags, void *cb_data)
 {
 	struct object *obj;
 	enum decoration_type type = DECORATION_NONE;
 
-	assert(cb_data == NULL);
-
 	if (starts_with(refname, git_replace_ref_base)) {
 		struct object_id original_oid;
 		if (!check_replace_refs)
@@ -135,6 +158,17 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 			parse_object(obj->oid.hash);
 		add_name_decoration(DECORATION_REF_TAG, refname, obj);
 	}
+
+	if (cb_data && type == DECORATION_REF_REMOTE) {
+		struct reflog_cb cb;
+
+		memset(&cb, 0, sizeof(cb));
+		cb.refname = refname;
+		cb.type = type;
+		cb.count = *(int *)cb_data + 1 /* for @{0} */;
+
+		for_each_reflog_ent_reverse(refname, add_nth_reflog, &cb);
+	}
 	return 0;
 }
 
@@ -147,13 +181,14 @@ static int add_graft_decoration(const struct commit_graft *graft, void *cb_data)
 	return 0;
 }
 
-void load_ref_decorations(int flags)
+void load_ref_decorations(int flags, int remote_reflog)
 {
 	if (!decoration_loaded) {
+		void *cb = remote_reflog ? &remote_reflog : NULL;
 
 		decoration_loaded = 1;
 		decoration_flags = flags;
-		for_each_ref(add_ref_decoration, NULL);
+		for_each_ref(add_ref_decoration, cb);
 		head_ref(add_ref_decoration, NULL);
 		for_each_commit_graft(add_graft_decoration, NULL);
 	}
diff --git a/log-tree.h b/log-tree.h
index c8116e6..bb46c53 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -25,7 +25,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **subject_p,
 			     const char **extra_headers_p,
 			     int *need_8bit_cte_p);
-void load_ref_decorations(int flags);
+void load_ref_decorations(int flags, int reflog);
 
 #define FORMAT_PATCH_NAME_MAX 64
 void fmt_output_commit(struct strbuf *, struct commit *, struct rev_info *);
diff --git a/pretty.c b/pretty.c
index 5e68383..ec8e1cc 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1189,11 +1189,11 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		strbuf_addstr(sb, get_revision_mark(NULL, commit));
 		return 1;
 	case 'd':
-		load_ref_decorations(DECORATE_SHORT_REFS);
+		load_ref_decorations(DECORATE_SHORT_REFS, 0);
 		format_decorations(sb, commit, c->auto_color);
 		return 1;
 	case 'D':
-		load_ref_decorations(DECORATE_SHORT_REFS);
+		load_ref_decorations(DECORATE_SHORT_REFS, 0);
 		format_decorations_extended(sb, commit, c->auto_color, "", ", ", "");
 		return 1;
 	case 'g':		/* reflog info */
diff --git a/revision.c b/revision.c
index b37dbec..4d5cbf5 100644
--- a/revision.c
+++ b/revision.c
@@ -1743,7 +1743,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->simplify_by_decoration = 1;
 		revs->limited = 1;
 		revs->prune = 1;
-		load_ref_decorations(DECORATE_SHORT_REFS);
+		load_ref_decorations(DECORATE_SHORT_REFS, 0);
 	} else if (!strcmp(arg, "--date-order")) {
 		revs->sort_order = REV_SORT_BY_COMMIT_DATE;
 		revs->topo_order = 1;
-- 
2.8.2.524.g6ff3d78

