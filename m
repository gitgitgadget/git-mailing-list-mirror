Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFAC3207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752912AbdECKSN (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:18:13 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34583 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752850AbdECKSI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:18:08 -0400
Received: by mail-pg0-f67.google.com with SMTP id t7so27644803pgt.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GPCsLsTk77C1j2rXJbNIlsOsfm22AqyA8J0LIJmW2I4=;
        b=BThXu0V82tDSxU0thLApkDi1mWoCmam3M2q+RP5RKs7ab3LWjUQG8/HOGm6PBZREiT
         tCu5nCsUSu49uVQcloLbMyMTg2rxzTRjEDP47gTzBMjDRlDfjz7x9pIRmmvA3QxMyUYP
         NplODueldATp8G41LOwUSk8io6Dl/8stMZ2I5/auIfqFg1+JH3blBCpZpr7Z7ymMSEMP
         pO2o9+RhBz35jsHfoKLImgnjolpjmPdJiaKR14Ibd21jPPCgso8yzW60Ss6Z6lqqvLp4
         oAE2g5plaoGwAM5FHzEgIrTB2jhQTxcftV/lF7kRZz1zIXE77ITiHDI3XsxUuYf9X+Nw
         oe8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GPCsLsTk77C1j2rXJbNIlsOsfm22AqyA8J0LIJmW2I4=;
        b=cuX7UX494ufKqiBr1AivZbCp0dyInOsariKf4RlGmirSszz3SZZKBPUFDFgVRs0xAf
         gOupo75xC9jJIXJfXIQiFgHMGkQOdl8HL5d1Ohs4xnDXisvbI01ij2vhWmrmLVzXzb2P
         Y+72feHaUaP6UcV0NSz7ORHqM0t+vAuWbKxl/dZj2DPl0mZGRakxduN6P7cLyjCTOkiD
         ERLppdjpnWCBC0Os9hlM1bTDS1tzE5aRMxW+rqqynhJ7cxwvaqALhrzW2C1e1UtToW+E
         5vxZpDjxuxvknxIQdJz429T0GhD5oaiJHwmist0S2bfu+OS7/JZaIzB1HvcmnyeckZzi
         B1dQ==
X-Gm-Message-State: AN3rC/42xUBULIW5H/9kRTPLVZ6VjY8lppfIGul0wu5aPJL5tVPAOsP/
        O3bOUAxeY9COWA==
X-Received: by 10.98.76.26 with SMTP id z26mr4074670pfa.14.1493806686963;
        Wed, 03 May 2017 03:18:06 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id p3sm29921664pgd.36.2017.05.03.03.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:18:06 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:18:02 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 01/21] Use xfopen() in more places
Date:   Wed,  3 May 2017 17:16:46 +0700
Message-Id: <20170503101706.9223-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170503101706.9223-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
 <20170503101706.9223-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

xfopen()

 - provides error details
 - explains error on reading, or writing, or whatever operation
 - has l10n support
 - prints file name in the error

Some of these are missing in the places that are replaced with xfopen(),
which is a clear win. In some other places, it's just less code (not as
clearly a win as the previous case but still is).

The only slight regresssion is in remote-testsvn, where we don't report
the file class (marks files) in the error messages anymore. But since
this is a _test_ svn remote transport, I'm not too concerned.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 bisect.c              | 5 +----
 builtin/am.c          | 8 ++------
 builtin/commit.c      | 5 +----
 builtin/fast-export.c | 4 +---
 builtin/fsck.c        | 3 +--
 builtin/merge.c       | 4 +---
 builtin/pull.c        | 3 +--
 diff.c                | 8 ++------
 fast-import.c         | 4 +---
 remote-testsvn.c      | 8 ++------
 10 files changed, 13 insertions(+), 39 deletions(-)

diff --git a/bisect.c b/bisect.c
index 08c9fb7266..469a3e9061 100644
--- a/bisect.c
+++ b/bisect.c
@@ -438,10 +438,7 @@ static void read_bisect_paths(struct argv_array *array)
 {
 	struct strbuf str = STRBUF_INIT;
 	const char *filename = git_path_bisect_names();
-	FILE *fp = fopen(filename, "r");
-
-	if (!fp)
-		die_errno(_("Could not open file '%s'"), filename);
+	FILE *fp = xfopen(filename, "r");
 
 	while (strbuf_getline_lf(&str, fp) != EOF) {
 		strbuf_trim(&str);
diff --git a/builtin/am.c b/builtin/am.c
index a95dd8b4e6..f5dac7783e 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1275,12 +1275,8 @@ static int parse_mail(struct am_state *state, const char *mail)
 		die("BUG: invalid value for state->scissors");
 	}
 
-	mi.input = fopen(mail, "r");
-	if (!mi.input)
-		die("could not open input");
-	mi.output = fopen(am_path(state, "info"), "w");
-	if (!mi.output)
-		die("could not open output 'info'");
+	mi.input = xfopen(mail, "r");
+	mi.output = xfopen(am_path(state, "info"), "w");
 	if (mailinfo(&mi, am_path(state, "msg"), am_path(state, "patch")))
 		die("could not parse patch");
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 1d805f5da8..eda0d32311 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1695,10 +1695,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		if (!reflog_msg)
 			reflog_msg = "commit (merge)";
 		pptr = commit_list_append(current_head, pptr);
-		fp = fopen(git_path_merge_head(), "r");
-		if (fp == NULL)
-			die_errno(_("could not open '%s' for reading"),
-				  git_path_merge_head());
+		fp = xfopen(git_path_merge_head(), "r");
 		while (strbuf_getline_lf(&m, fp) != EOF) {
 			struct commit *parent;
 
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index e0220630d0..128b99e6da 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -905,9 +905,7 @@ static void export_marks(char *file)
 static void import_marks(char *input_file)
 {
 	char line[512];
-	FILE *f = fopen(input_file, "r");
-	if (!f)
-		die_errno("cannot read '%s'", input_file);
+	FILE *f = xfopen(input_file, "r");
 
 	while (fgets(line, sizeof(line), f)) {
 		uint32_t mark;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index b5e13a4556..00beaaa4e6 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -280,8 +280,7 @@ static void check_unreachable_object(struct object *obj)
 				free(filename);
 				return;
 			}
-			if (!(f = fopen(filename, "w")))
-				die_errno("Could not open '%s'", filename);
+			f = xfopen(filename, "w");
 			if (obj->type == OBJ_BLOB) {
 				if (stream_blob_to_fd(fileno(f), &obj->oid, NULL, 1))
 					die_errno("Could not write '%s'", filename);
diff --git a/builtin/merge.c b/builtin/merge.c
index 703827f006..65a1501858 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -839,9 +839,7 @@ static int suggest_conflicts(void)
 	struct strbuf msgbuf = STRBUF_INIT;
 
 	filename = git_path_merge_msg();
-	fp = fopen(filename, "a");
-	if (!fp)
-		die_errno(_("Could not open '%s' for writing"), filename);
+	fp = xfopen(filename, "a");
 
 	append_conflicts_hint(&msgbuf);
 	fputs(msgbuf.buf, fp);
diff --git a/builtin/pull.c b/builtin/pull.c
index dd1a4a94e4..589c25becf 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -337,8 +337,7 @@ static void get_merge_heads(struct oid_array *merge_heads)
 	struct strbuf sb = STRBUF_INIT;
 	struct object_id oid;
 
-	if (!(fp = fopen(filename, "r")))
-		die_errno(_("could not open '%s' for reading"), filename);
+	fp = xfopen(filename, "r");
 	while (strbuf_getline_lf(&sb, fp) != EOF) {
 		if (get_oid_hex(sb.buf, &oid))
 			continue;  /* invalid line: does not start with SHA1 */
diff --git a/diff.c b/diff.c
index 11eef1c85d..b6597ce568 100644
--- a/diff.c
+++ b/diff.c
@@ -4071,9 +4071,7 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_OPT_CLR(options, FUNCCONTEXT);
 	else if ((argcount = parse_long_opt("output", av, &optarg))) {
 		char *path = prefix_filename(prefix, optarg);
-		options->file = fopen(path, "w");
-		if (!options->file)
-			die_errno("Could not open '%s'", path);
+		options->file = xfopen(path, "w");
 		options->close_file = 1;
 		if (options->use_color != GIT_COLOR_ALWAYS)
 			options->use_color = GIT_COLOR_NEVER;
@@ -4807,9 +4805,7 @@ void diff_flush(struct diff_options *options)
 		 */
 		if (options->close_file)
 			fclose(options->file);
-		options->file = fopen("/dev/null", "w");
-		if (!options->file)
-			die_errno("Could not open /dev/null");
+		options->file = xfopen("/dev/null", "w");
 		options->close_file = 1;
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
diff --git a/fast-import.c b/fast-import.c
index cf58f875b8..420b3a00d3 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3274,9 +3274,7 @@ static void option_export_pack_edges(const char *edges)
 {
 	if (pack_edges)
 		fclose(pack_edges);
-	pack_edges = fopen(edges, "a");
-	if (!pack_edges)
-		die_errno("Cannot open '%s'", edges);
+	pack_edges = xfopen(edges, "a");
 }
 
 static int parse_one_option(const char *option)
diff --git a/remote-testsvn.c b/remote-testsvn.c
index f87bf851ba..50404ef343 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -124,10 +124,8 @@ static int note2mark_cb(const unsigned char *object_sha1,
 static void regenerate_marks(void)
 {
 	int ret;
-	FILE *marksfile = fopen(marksfilename, "w+");
+	FILE *marksfile = xfopen(marksfilename, "w+");
 
-	if (!marksfile)
-		die_errno("Couldn't create mark file %s.", marksfilename);
 	ret = for_each_note(NULL, 0, note2mark_cb, marksfile);
 	if (ret)
 		die("Regeneration of marks failed, returned %d.", ret);
@@ -148,9 +146,7 @@ static void check_or_regenerate_marks(int latestrev)
 	marksfile = fopen(marksfilename, "r");
 	if (!marksfile) {
 		regenerate_marks();
-		marksfile = fopen(marksfilename, "r");
-		if (!marksfile)
-			die_errno("cannot read marks file %s!", marksfilename);
+		marksfile = xfopen(marksfilename, "r");
 		fclose(marksfile);
 	} else {
 		strbuf_addf(&sb, ":%d ", latestrev);
-- 
2.11.0.157.gd943d85

