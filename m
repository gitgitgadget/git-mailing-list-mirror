Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 065031F404
	for <e@80x24.org>; Sat, 24 Mar 2018 20:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeCXUiO (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 16:38:14 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34972 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752893AbeCXUiI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 16:38:08 -0400
Received: by mail-lf0-f65.google.com with SMTP id t132-v6so22936160lfe.2
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 13:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXZzkmtu904584SbCWXSfcK6MPGFZQADUPEK7nqQEC4=;
        b=lJhBN3JzzOMnELjOW45JR55bLSacShbNGVJoStRDfbxAlptvbQX6KIKgDI62Tuoi+I
         PNgxSxty4Rf+ot2eiFpmkqlWh8uAwWNWomzX7INVG80YuzSAVucFlmaj5gLO3MDemD21
         Ld5QSQt+B6u7EIqaIaxAmJvRhShNZWYHLafPSZlk3oD4sJNmVt0VQwyU/+23/oXd3e7X
         sI4swwKlN7lpf72uzbtshxM/4f4+YatcUWwfdaa68ylVTVQWqSb5jfxWKVWqfWDSGTDO
         MFkRpo0TpGf5XNsBwgG1y1FjBO94VfLhD3PKn65WF8IqNtOXSBZKEiDIiOxp4Mz2JMaL
         SMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXZzkmtu904584SbCWXSfcK6MPGFZQADUPEK7nqQEC4=;
        b=KcaXEsKmshDFNzEb8ecm77sw6iGl/jawsSm3boRqCh1SSa3LQNZrJyWfcoqYa4WR0s
         x5JuUdif2MVoNS3sILnFFarLIQDfmgCt8FDk6Ok1RrwvHQjv8n42vl3Oa5SB9HQl9Tz9
         sp6x3H1cBWGpl/pFFZBo96KbH/K/tfzeKq2tvwqoCcBUlNG4QGA5Ck+nih7oyP13aSFB
         OgoAxNxMpM2WB/wSfg0u+AD8jegQeEBTmyCbt2tsVtxHuonXDsULSBPO2/8fAeeSsjAE
         nGED+VHlDHFnyfH1cqls0itLqMXPBvuQhNWevRqau4eBYjGX1RGjCSlkwp1pulGO437/
         DIbQ==
X-Gm-Message-State: AElRT7HfIIhLKo2sA1u64FGy8dGSNRwrHa2d7a45xMoRYh2LcsPisOAf
        JACslIOjtWCsaaAeitb1d60=
X-Google-Smtp-Source: AG47ELtMtvQCfduYvjEF3plA4X0DgDnRicf8kAVT2vGyOFnUgd+i6D9QC4uq9EXEcW4cWK3zj8hwGQ==
X-Received: by 10.46.68.14 with SMTP id r14mr15538087lja.44.1521923886886;
        Sat, 24 Mar 2018 13:38:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n2sm972680lji.75.2018.03.24.13.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 13:38:06 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/8] git.c: add hidden option --list-parseopt-builtins
Date:   Sat, 24 Mar 2018 21:35:19 +0100
Message-Id: <20180324203525.24159-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324203525.24159-1-pclouds@gmail.com>
References: <20180321193039.19779-1-pclouds@gmail.com>
 <20180324203525.24159-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is another step to help automate git-completion.bash. This option
gives a list of all builtin commands that do use parse_options(),
which supports another hidden option --git-completion-helper. The
output is prepared for easy consumption by git-completion.bash and
separates items by spaces instead of \n

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 git.c | 90 ++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 49 insertions(+), 41 deletions(-)

diff --git a/git.c b/git.c
index bc4a5459d3..3a89893712 100644
--- a/git.c
+++ b/git.c
@@ -14,11 +14,12 @@
 #define NEED_WORK_TREE		(1<<3)
 #define SUPPORT_SUPER_PREFIX	(1<<4)
 #define DELAY_PAGER_CONFIG	(1<<5)
+#define NO_PARSEOPT		(1<<6) /* parse-options is not used */
 
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
-	int option;
+	unsigned int option;
 };
 
 const char git_usage_string[] =
@@ -35,7 +36,7 @@ const char git_more_info_string[] =
 
 static int use_pager = -1;
 
-static void list_builtins(void);
+static void list_builtins(unsigned int exclude_option, char sep);
 
 static void commit_pager_choice(void) {
 	switch (use_pager) {
@@ -223,7 +224,10 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			(*argv)++;
 			(*argc)--;
 		} else if (!strcmp(cmd, "--list-builtins")) {
-			list_builtins();
+			list_builtins(0, '\n');
+			exit(0);
+		} else if (!strcmp(cmd, "--list-parseopt-builtins")) {
+			list_builtins(NO_PARSEOPT, ' ');
 			exit(0);
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
@@ -367,18 +371,18 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 static struct cmd_struct commands[] = {
 	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
-	{ "annotate", cmd_annotate, RUN_SETUP },
+	{ "annotate", cmd_annotate, RUN_SETUP | NO_PARSEOPT },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
 	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
-	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
+	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "cat-file", cmd_cat_file, RUN_SETUP },
 	{ "check-attr", cmd_check_attr, RUN_SETUP },
 	{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
 	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
-	{ "check-ref-format", cmd_check_ref_format },
+	{ "check-ref-format", cmd_check_ref_format, NO_PARSEOPT  },
 	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
 	{ "checkout-index", cmd_checkout_index,
 		RUN_SETUP | NEED_WORK_TREE},
@@ -388,30 +392,30 @@ static struct cmd_struct commands[] = {
 	{ "clone", cmd_clone },
 	{ "column", cmd_column, RUN_SETUP_GENTLY },
 	{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
-	{ "commit-tree", cmd_commit_tree, RUN_SETUP },
+	{ "commit-tree", cmd_commit_tree, RUN_SETUP | NO_PARSEOPT },
 	{ "config", cmd_config, RUN_SETUP_GENTLY | DELAY_PAGER_CONFIG },
 	{ "count-objects", cmd_count_objects, RUN_SETUP },
-	{ "credential", cmd_credential, RUN_SETUP_GENTLY },
+	{ "credential", cmd_credential, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "describe", cmd_describe, RUN_SETUP },
-	{ "diff", cmd_diff },
-	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
-	{ "diff-index", cmd_diff_index, RUN_SETUP },
-	{ "diff-tree", cmd_diff_tree, RUN_SETUP },
+	{ "diff", cmd_diff, NO_PARSEOPT },
+	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
+	{ "diff-tree", cmd_diff_tree, RUN_SETUP | NO_PARSEOPT },
 	{ "difftool", cmd_difftool, RUN_SETUP | NEED_WORK_TREE },
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
 	{ "fetch", cmd_fetch, RUN_SETUP },
-	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
+	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP | NO_PARSEOPT },
 	{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
 	{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
 	{ "format-patch", cmd_format_patch, RUN_SETUP },
 	{ "fsck", cmd_fsck, RUN_SETUP },
 	{ "fsck-objects", cmd_fsck, RUN_SETUP },
 	{ "gc", cmd_gc, RUN_SETUP },
-	{ "get-tar-commit-id", cmd_get_tar_commit_id },
+	{ "get-tar-commit-id", cmd_get_tar_commit_id, NO_PARSEOPT },
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
-	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
+	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
@@ -419,27 +423,27 @@ static struct cmd_struct commands[] = {
 	{ "ls-files", cmd_ls_files, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
-	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY },
-	{ "mailsplit", cmd_mailsplit },
+	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY | NO_PARSEOPT },
+	{ "mailsplit", cmd_mailsplit, NO_PARSEOPT },
 	{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
 	{ "merge-base", cmd_merge_base, RUN_SETUP },
 	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
-	{ "merge-index", cmd_merge_index, RUN_SETUP },
-	{ "merge-ours", cmd_merge_ours, RUN_SETUP },
-	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
-	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
-	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
-	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
-	{ "merge-tree", cmd_merge_tree, RUN_SETUP },
-	{ "mktag", cmd_mktag, RUN_SETUP },
+	{ "merge-index", cmd_merge_index, RUN_SETUP | NO_PARSEOPT },
+	{ "merge-ours", cmd_merge_ours, RUN_SETUP | NO_PARSEOPT },
+	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-tree", cmd_merge_tree, RUN_SETUP | NO_PARSEOPT },
+	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
 	{ "mktree", cmd_mktree, RUN_SETUP },
 	{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 	{ "name-rev", cmd_name_rev, RUN_SETUP },
 	{ "notes", cmd_notes, RUN_SETUP },
 	{ "pack-objects", cmd_pack_objects, RUN_SETUP },
-	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP },
+	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP | NO_PARSEOPT },
 	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
-	{ "patch-id", cmd_patch_id, RUN_SETUP_GENTLY },
+	{ "patch-id", cmd_patch_id, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "pickaxe", cmd_blame, RUN_SETUP },
 	{ "prune", cmd_prune, RUN_SETUP },
 	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
@@ -450,14 +454,14 @@ static struct cmd_struct commands[] = {
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
 	{ "remote", cmd_remote, RUN_SETUP },
-	{ "remote-ext", cmd_remote_ext },
-	{ "remote-fd", cmd_remote_fd },
+	{ "remote-ext", cmd_remote_ext, NO_PARSEOPT },
+	{ "remote-fd", cmd_remote_fd, NO_PARSEOPT },
 	{ "repack", cmd_repack, RUN_SETUP },
 	{ "replace", cmd_replace, RUN_SETUP },
 	{ "rerere", cmd_rerere, RUN_SETUP },
 	{ "reset", cmd_reset, RUN_SETUP },
-	{ "rev-list", cmd_rev_list, RUN_SETUP },
-	{ "rev-parse", cmd_rev_parse },
+	{ "rev-list", cmd_rev_list, RUN_SETUP | NO_PARSEOPT },
+	{ "rev-parse", cmd_rev_parse, NO_PARSEOPT },
 	{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
 	{ "rm", cmd_rm, RUN_SETUP },
 	{ "send-pack", cmd_send_pack, RUN_SETUP },
@@ -468,23 +472,23 @@ static struct cmd_struct commands[] = {
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
-	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX},
+	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 	{ "tag", cmd_tag, RUN_SETUP | DELAY_PAGER_CONFIG },
-	{ "unpack-file", cmd_unpack_file, RUN_SETUP },
-	{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
+	{ "unpack-file", cmd_unpack_file, RUN_SETUP | NO_PARSEOPT },
+	{ "unpack-objects", cmd_unpack_objects, RUN_SETUP | NO_PARSEOPT },
 	{ "update-index", cmd_update_index, RUN_SETUP },
 	{ "update-ref", cmd_update_ref, RUN_SETUP },
 	{ "update-server-info", cmd_update_server_info, RUN_SETUP },
-	{ "upload-archive", cmd_upload_archive },
-	{ "upload-archive--writer", cmd_upload_archive_writer },
-	{ "var", cmd_var, RUN_SETUP_GENTLY },
+	{ "upload-archive", cmd_upload_archive, NO_PARSEOPT },
+	{ "upload-archive--writer", cmd_upload_archive_writer, NO_PARSEOPT },
+	{ "var", cmd_var, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "verify-commit", cmd_verify_commit, RUN_SETUP },
 	{ "verify-pack", cmd_verify_pack },
 	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 	{ "version", cmd_version },
 	{ "whatchanged", cmd_whatchanged, RUN_SETUP },
-	{ "worktree", cmd_worktree, RUN_SETUP },
+	{ "worktree", cmd_worktree, RUN_SETUP | NO_PARSEOPT },
 	{ "write-tree", cmd_write_tree, RUN_SETUP },
 };
 
@@ -504,11 +508,15 @@ int is_builtin(const char *s)
 	return !!get_builtin(s);
 }
 
-static void list_builtins(void)
+static void list_builtins(unsigned int exclude_option, char sep)
 {
 	int i;
-	for (i = 0; i < ARRAY_SIZE(commands); i++)
-		printf("%s\n", commands[i].cmd);
+	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		if (exclude_option &&
+		    (commands[i].option & exclude_option))
+			continue;
+		printf("%s%c", commands[i].cmd, sep);
+	}
 }
 
 #ifdef STRIP_EXTENSION
-- 
2.17.0.rc0.348.gd5a49e0b6f

