Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26853C433E0
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 19:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D73D320780
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 19:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rp0O8vYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgGBTZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgGBTZK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 15:25:10 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE17C08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 12:25:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l6so9757613pjq.1
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 12:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C37hs+DKZr1Wotm8BuquSGZoJKVrwVMYSUFR9VF2C3o=;
        b=Rp0O8vYiRSHlnCZwyy4ws5n3HtQMfyZKnmXVhqHmBy0dPc19zfE3Y0q8g1ZnOUTr9I
         9dNVUIVt2iqgVyqz5CJ9sdv9Gezdti/SvpCIUlgjv2kd6TXBNrkgLFVaiQvKvu/1O/Ai
         wtB0MoAOtQdVMtyD6FsLoB85ArHZLig/HNxCNU9QEArsiN9Cq3CnQa3bjQ6nDnrOiv9q
         bhQ9VzTcQlxKWQcZuIT4eQzz7it4YTV8RcevsSXyH30Bb5YlhyJgIuzmobZimEilvxZW
         jBVcGe/n/UU6krWjjXPYrVnaKFmsKrZ+SsHOOawfbIFI9cE3dUmV+iWNiyyJnhV4/nzx
         MtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C37hs+DKZr1Wotm8BuquSGZoJKVrwVMYSUFR9VF2C3o=;
        b=hrAfRHkE4j2IVErlclHkddgWi3V0ZbKTFHis+k3s4HBab0XgKIoMbGKfVm2NJzSZhW
         0BymUotD9Dx27H9w7MP5Jm2rUOH5IarUYz7lD4siw22nYRRbC9WfdB6M3Dmct2BfW7uN
         Fqv7eBjm/22hj/rQ9Ai7+tsJe32uBa3afai4lVhsHLO6XkwSg7F93rQsTs3IMxQUbYmi
         vmD5HarojBNWXTwApeDUVTD2YwbCK6QdnQcUNkg2g98fiDxFUSX10mhOYF5KxOjF5Gq8
         4M51fCj3zSu6959TY9mjktpIdOuCcC9modKDe2fe9Sn5v5W2gB2JMtTAR6tTdpHnAgny
         nX9w==
X-Gm-Message-State: AOAM531w7dwojlT68O0qreK7eqgiCGrlUaMea659bdxh4hqmvEGZZkWG
        VMWgEqr/rPeyBWe72MFWLuebJq5bZR5ZJA==
X-Google-Smtp-Source: ABdhPJyBFHLzYhPCMQ1FCattJ+3FlxaY+r62u5v3VarnG8eZocgmwi6JQSkBcSqxqjKQ/yJkg2cwrA==
X-Received: by 2002:a17:902:fe0d:: with SMTP id g13mr27923800plj.326.1593717909238;
        Thu, 02 Jul 2020 12:25:09 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.244])
        by smtp.gmail.com with ESMTPSA id c2sm9266739pgk.77.2020.07.02.12.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 12:25:08 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, sbeller@google.com, pclouds@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH 4/4] submodule: port submodule subcommand 'summary' from shell to C
Date:   Fri,  3 Jul 2020 00:54:09 +0530
Message-Id: <20200702192409.21865-5-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702192409.21865-1-shouryashukla.oo@gmail.com>
References: <20200702192409.21865-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Prathamesh Chavan <pc44800@gmail.com>

The submodule subcommand 'summary' is ported in the process of
making git-submodule a builtin. The function cmd_summary() from
git-submodule.sh is ported to functions module_summary(),
compute_summary_module_list(), prepare_submodule_summary() and
generate_submodule_summary(), print_submodule_summary().

The first function module_summary() parses the options of submodule
subcommand and also acts as the front-end of this subcommand.
After parsing them, it calls the compute_summary_module_list()

The functions compute_summary_module_list() runs the diff_cmd,
and generates the modules list, as required by the subcommand.
The generation of this module list is done by the using the
callback function submodule_summary_callback(), and stored in the
structure module_cb.

Once the module list is generated, prepare_submodule_summary()
further goes through the list and filters the list, for
eventually calling the generate_submodule_summary() function.

The function generate_submodule_summary() takes care of generating
the summary for each submodule and then calls the function
print_submodule_summary() for printing it.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 builtin/submodule--helper.c | 451 ++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 186 +--------------
 2 files changed, 452 insertions(+), 185 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index eea3932c40..1dbdb934f1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -927,6 +927,456 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct module_cb {
+	unsigned int mod_src;
+	unsigned int mod_dst;
+	struct object_id oid_src;
+	struct object_id oid_dst;
+	char status;
+	const char *sm_path;
+};
+#define MODULE_CB_INIT { 0, 0, NULL, NULL, '\0', NULL }
+
+struct module_cb_list {
+	struct module_cb **entries;
+	int alloc, nr;
+};
+#define MODULE_CB_LIST_INIT { NULL, 0, 0 }
+
+struct summary_cb {
+	int argc;
+	const char **argv;
+	const char *prefix;
+	unsigned int cached: 1;
+	unsigned int for_status: 1;
+	unsigned int quiet: 1;
+	unsigned int files: 1;
+	int summary_limit;
+};
+#define SUMMARY_CB_INIT { 0, NULL, NULL, 0, 0, 0, 0, 0 }
+
+enum diff_cmd {
+	DIFF_INDEX,
+	DIFF_FILES
+};
+
+static int verify_submodule_object_name(const char *sm_path,
+					  const char *sha1)
+{
+	struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
+
+	cp_rev_parse.git_cmd = 1;
+	cp_rev_parse.no_stdout = 1;
+	cp_rev_parse.dir = sm_path;
+	prepare_submodule_repo_env(&cp_rev_parse.env_array);
+	argv_array_pushl(&cp_rev_parse.args, "rev-parse", "-q",
+			 "--verify", NULL);
+	argv_array_pushf(&cp_rev_parse.args, "%s^0", sha1);
+
+	if (run_command(&cp_rev_parse))
+		return 1;
+
+	return 0;
+}
+
+static void print_submodule_summary(struct summary_cb *info, int errmsg,
+				      int total_commits, int missing_src,
+				      int missing_dst, const char *displaypath,
+				      int is_sm_git_dir, struct module_cb *p)
+{
+	if (p->status == 'T') {
+		if (S_ISGITLINK(p->mod_dst))
+			printf(_("* %s %s(blob)->%s(submodule)"),
+				 displaypath, find_unique_abbrev(&p->oid_src, 7),
+				 find_unique_abbrev(&p->oid_dst, 7));
+		else
+			printf(_("* %s %s(submodule)->%s(blob)"),
+				 displaypath, find_unique_abbrev(&p->oid_src, 7),
+				 find_unique_abbrev(&p->oid_dst, 7));
+	} else {
+		printf("* %s %s...%s",
+			displaypath, find_unique_abbrev(&p->oid_src, 7),
+			find_unique_abbrev(&p->oid_dst, 7));
+	}
+
+	if (total_commits < 0)
+		printf(":\n");
+	else
+		printf(" (%d):\n", total_commits);
+
+	if (errmsg) {
+		/*
+		 * Don't give error msg for modification whose dst is not
+		 * submodule, i.e. deleted or changed to blob
+		 */
+		if (S_ISGITLINK(p->mod_src)) {
+			if (missing_src && missing_dst) {
+				printf(_("  Warn: %s doesn't contain commits %s and %s\n"),
+				       displaypath, oid_to_hex(&p->oid_src),
+				       oid_to_hex(&p->oid_dst));
+			} else if (missing_src) {
+				printf(_("  Warn: %s doesn't contain commit %s\n"),
+				       displaypath, oid_to_hex(&p->oid_src));
+			} else {
+				printf(_("  Warn: %s doesn't contain commit %s\n"),
+				       displaypath, oid_to_hex(&p->oid_dst));
+			}
+		}
+	} else if (is_sm_git_dir) {
+		struct child_process cp_log = CHILD_PROCESS_INIT;
+
+		cp_log.git_cmd = 1;
+		cp_log.dir = p->sm_path;
+		prepare_submodule_repo_env(&cp_log.env_array);
+		argv_array_pushl(&cp_log.args, "log", NULL);
+
+		if (S_ISGITLINK(p->mod_src) && S_ISGITLINK(p->mod_dst)) {
+			if (info->summary_limit > 0)
+				argv_array_pushf(&cp_log.args, "-%d",
+						 info->summary_limit);
+
+			argv_array_pushl(&cp_log.args, "--pretty=  %m %s",
+					 "--first-parent", NULL);
+			argv_array_pushf(&cp_log.args, "%s...%s",
+					 oid_to_hex(&p->oid_src),
+					 oid_to_hex(&p->oid_dst));
+		} else if (S_ISGITLINK(p->mod_dst)) {
+			argv_array_pushl(&cp_log.args, "--pretty=  > %s",
+					 "-1", oid_to_hex(&p->oid_dst), NULL);
+		} else {
+			argv_array_pushl(&cp_log.args, "--pretty=  < %s",
+					 "-1", oid_to_hex(&p->oid_src), NULL);
+		}
+		run_command(&cp_log);
+	}
+	printf("\n");
+}
+
+static void generate_submodule_summary(struct summary_cb *info,
+				       struct module_cb *p)
+{
+	int missing_src = 0;
+	int missing_dst = 0;
+	char *displaypath;
+	int errmsg = 0;
+	int total_commits = -1;
+	int is_sm_git_dir = 0;
+	struct strbuf sm_git_dir_sb = STRBUF_INIT;
+
+	if (!info->cached && oideq(&p->oid_dst, &null_oid)) {
+		if (S_ISGITLINK(p->mod_dst)) {
+			/*
+			 * NEEDSWORK: avoid using separate process with
+			 * the help of the function head_ref_submodule()
+			 */
+			struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
+			struct strbuf sb_rev_parse = STRBUF_INIT;
+
+			cp_rev_parse.git_cmd = 1;
+			cp_rev_parse.no_stderr = 1;
+			cp_rev_parse.dir = p->sm_path;
+			prepare_submodule_repo_env(&cp_rev_parse.env_array);
+
+			argv_array_pushl(&cp_rev_parse.args, "rev-parse",
+					 "HEAD", NULL);
+			if (!capture_command(&cp_rev_parse, &sb_rev_parse, 0)) {
+				strbuf_strip_suffix(&sb_rev_parse, "\n");
+				get_oid_hex(sb_rev_parse.buf, &p->oid_dst);
+			}
+			strbuf_release(&sb_rev_parse);
+		} else if (S_ISLNK(p->mod_dst) || S_ISREG(p->mod_dst)) {
+			struct child_process cp_hash_object = CHILD_PROCESS_INIT;
+			struct strbuf sb_hash_object = STRBUF_INIT;
+
+			cp_hash_object.git_cmd = 1;
+			argv_array_pushl(&cp_hash_object.args, "hash-object",
+					 p->sm_path, NULL);
+			if (!capture_command(&cp_hash_object,
+					     &sb_hash_object, 0)) {
+				strbuf_strip_suffix(&sb_hash_object, "\n");
+				get_oid_hex(sb_hash_object.buf, &p->oid_dst);
+			}
+			strbuf_release(&sb_hash_object);
+		} else {
+			if (p->mod_dst)
+				die(_("unexpected mode %d\n"), p->mod_dst);
+		}
+	}
+
+	strbuf_addstr(&sm_git_dir_sb, p->sm_path);
+	if (is_nonbare_repository_dir(&sm_git_dir_sb))
+		is_sm_git_dir = 1;
+
+	if (is_sm_git_dir && S_ISGITLINK(p->mod_src))
+		missing_src = verify_submodule_object_name(p->sm_path,
+							   oid_to_hex(&p->oid_src));
+
+	if (is_sm_git_dir && S_ISGITLINK(p->mod_dst))
+		missing_dst = verify_submodule_object_name(p->sm_path,
+							   oid_to_hex(&p->oid_dst));
+
+	displaypath = get_submodule_displaypath(p->sm_path, info->prefix);
+
+	if (!missing_dst && !missing_src) {
+		if (is_sm_git_dir) {
+			struct child_process cp_rev_list = CHILD_PROCESS_INIT;
+			struct strbuf sb_rev_list = STRBUF_INIT;
+			char *range;
+
+			if (S_ISGITLINK(p->mod_src) && S_ISGITLINK(p->mod_dst))
+				range = xstrfmt("%s...%s", oid_to_hex(&p->oid_src),
+						oid_to_hex(&p->oid_dst));
+			else if (S_ISGITLINK(p->mod_src))
+				range = xstrdup(oid_to_hex(&p->oid_src));
+			else
+				range = xstrdup(oid_to_hex(&p->oid_dst));
+
+			cp_rev_list.git_cmd = 1;
+			cp_rev_list.dir = p->sm_path;
+			prepare_submodule_repo_env(&cp_rev_list.env_array);
+
+			argv_array_pushl(&cp_rev_list.args, "rev-list",
+					 "--first-parent", range, "--", NULL);
+			if (!capture_command(&cp_rev_list, &sb_rev_list, 0)) {
+				if (sb_rev_list.len)
+					total_commits = count_lines(sb_rev_list.buf,
+								    sb_rev_list.len);
+				else
+					total_commits = 0;
+			}
+
+			free(range);
+			strbuf_release(&sb_rev_list);
+		}
+	} else {
+		errmsg = 1;
+	}
+
+	print_submodule_summary(info, errmsg, total_commits,
+				missing_src, missing_dst,
+		      		displaypath, is_sm_git_dir, p);
+
+	free(displaypath);
+	strbuf_release(&sm_git_dir_sb);
+}
+
+static void prepare_submodule_summary(struct summary_cb *info,
+				      struct module_cb_list *list)
+{
+	int i;
+	for (i = 0; i < list->nr; i++) {
+		struct module_cb *p = list->entries[i];
+		struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
+
+		if (p->status == 'D' || p->status == 'T') {
+			generate_submodule_summary(info, p);
+			continue;
+		}
+
+		if (info->for_status) {
+			char *config_key;
+			const char *ignore_config = "none";
+			const char *value;
+			const struct submodule *sub = submodule_from_path(the_repository,
+									  &null_oid,
+									  p->sm_path);
+
+			if (sub && p->status != 'A') {
+				config_key = xstrfmt("submodule.%s.ignore",
+						     sub->name);
+				if (!git_config_get_string_const(config_key, &value))
+					ignore_config = value;
+				else if (sub->ignore)
+					ignore_config = sub->ignore;
+
+				free(config_key);
+				if (!strcmp(ignore_config, "all"))
+					continue;
+			}
+		}
+
+		/* Also show added or modified modules which are checked out */
+		cp_rev_parse.dir = p->sm_path;
+		cp_rev_parse.git_cmd = 1;
+		cp_rev_parse.no_stderr = 1;
+		cp_rev_parse.no_stdout = 1;
+
+		argv_array_pushl(&cp_rev_parse.args, "rev-parse",
+				 "--git-dir", NULL);
+
+		if (!run_command(&cp_rev_parse))
+			generate_submodule_summary(info, p);
+	}
+}
+
+static void submodule_summary_callback(struct diff_queue_struct *q,
+				       struct diff_options *options,
+				       void *data)
+{
+	int i;
+	struct module_cb_list *list = data;
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		struct module_cb *temp;
+
+		if (!S_ISGITLINK(p->one->mode) && !S_ISGITLINK(p->two->mode))
+			continue;
+		temp = (struct module_cb*)malloc(sizeof(struct module_cb));
+		temp->mod_src = p->one->mode;
+		temp->mod_dst = p->two->mode;
+		temp->oid_src = p->one->oid;
+		temp->oid_dst = p->two->oid;
+		temp->status = p->status;
+		temp->sm_path = xstrdup(p->one->path);
+
+		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
+		list->entries[list->nr++] = temp;
+	}
+}
+
+static const char *get_diff_cmd(enum diff_cmd diff_cmd)
+{
+	switch (diff_cmd) {
+	case DIFF_INDEX: return "diff-index";
+	case DIFF_FILES: return "diff-files";
+	default: BUG("bad diff_cmd value %d", diff_cmd);
+	}
+}
+
+static int compute_summary_module_list(char *head,
+				         struct summary_cb *info,
+				         enum diff_cmd diff_cmd)
+{
+	struct argv_array diff_args = ARGV_ARRAY_INIT;
+	struct rev_info rev;
+	struct module_cb_list list = MODULE_CB_LIST_INIT;
+
+	argv_array_push(&diff_args, get_diff_cmd(diff_cmd));
+	if (info->cached)
+		argv_array_push(&diff_args, "--cached");
+	argv_array_pushl(&diff_args, "--ignore-submodules=dirty", "--raw",
+			 NULL);
+	if (head)
+		argv_array_push(&diff_args, head);
+	argv_array_push(&diff_args, "--");
+	if (info->argc)
+		argv_array_pushv(&diff_args, info->argv);
+
+	git_config(git_diff_basic_config, NULL);
+	init_revisions(&rev, info->prefix);
+	rev.abbrev = 0;
+	precompose_argv(diff_args.argc, diff_args.argv);
+
+	diff_args.argc = setup_revisions(diff_args.argc, diff_args.argv,
+					 &rev, NULL);
+	rev.diffopt.output_format = DIFF_FORMAT_NO_OUTPUT | DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = submodule_summary_callback;
+	rev.diffopt.format_callback_data = &list;
+
+	if (!info->cached) {
+		if (diff_cmd ==  DIFF_INDEX)
+			setup_work_tree();
+		if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
+			perror("read_cache_preload");
+			return -1;
+		}
+	} else if (read_cache() < 0) {
+		perror("read_cache");
+		return -1;
+	}
+
+	if (diff_cmd == DIFF_INDEX)
+		run_diff_index(&rev, info->cached);
+	else
+		run_diff_files(&rev, 0);
+	prepare_submodule_summary(info, &list);
+	return 0;
+}
+
+static int module_summary(int argc, const char **argv, const char *prefix)
+{
+	struct summary_cb info = SUMMARY_CB_INIT;
+	int cached = 0;
+	int for_status = 0;
+	int quiet = 0;
+	int files = 0;
+	int summary_limit = -1;
+	struct child_process cp_rev = CHILD_PROCESS_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	enum diff_cmd diff_cmd = DIFF_INDEX;
+	int ret;
+
+	struct option module_summary_options[] = {
+		OPT__QUIET(&quiet, N_("Suppress output of summarising submodules")),
+		OPT_BOOL(0, "cached", &cached,
+			 N_("Use the commit stored in the index instead of the submodule HEAD")),
+		OPT_BOOL(0, "files", &files,
+			 N_("To compare the commit in the index with that in the submodule HEAD")),
+		OPT_BOOL(0, "for-status", &for_status,
+			 N_("Skip submodules with 'ignore_config' value set to 'all'")),
+		OPT_INTEGER('n', "summary-limit", &summary_limit,
+			     N_("Limit the summary size")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper summary [<options>] [commit] [--] [<path>]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_summary_options,
+			     git_submodule_helper_usage, 0);
+
+	if (!summary_limit)
+		return 0;
+
+	cp_rev.git_cmd = 1;
+	argv_array_pushl(&cp_rev.args, "rev-parse", "-q", "--verify",
+			 argc ? argv[0] : "HEAD", NULL);
+
+	if (!capture_command(&cp_rev, &sb, 0)) {
+		strbuf_strip_suffix(&sb, "\n");
+		if (argc) {
+			argv++;
+			argc--;
+		}
+	} else if (!argc || !strcmp(argv[0], "HEAD")) {
+		/* before the first commit: compare with an empty tree */
+		struct stat st;
+		struct object_id oid;
+		if (fstat(0, &st) < 0 || index_fd(&the_index, &oid, 0, &st, 2,
+						  prefix, 3))
+			die("Unable to add %s to database", oid.hash);
+		strbuf_addstr(&sb, oid_to_hex(&oid));
+		if (argc) {
+			argv++;
+			argc--;
+		}
+	} else {
+		strbuf_addstr(&sb, "HEAD");
+	}
+
+	if (files) {
+		if (cached)
+			die(_("--cached and --files are mutually exclusive"));
+		diff_cmd = DIFF_FILES;
+	}
+
+	info.argc = argc;
+	info.argv = argv;
+	info.prefix = prefix;
+	info.cached = !!cached;
+	info.for_status = !!for_status;
+	info.quiet = quiet;
+	info.files = files;
+	info.summary_limit = summary_limit;
+
+	ret = compute_summary_module_list((diff_cmd == DIFF_FILES) ? NULL : sb.buf,
+					   &info, diff_cmd);
+	strbuf_release(&sb);
+	return ret;
+}
+
 struct sync_cb {
 	const char *prefix;
 	unsigned int flags;
@@ -2341,6 +2791,7 @@ static struct cmd_struct commands[] = {
 	{"print-default-remote", print_default_remote, 0},
 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
 	{"deinit", module_deinit, 0},
+	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 43eb6051d2..899b8a409a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -59,31 +59,6 @@ die_if_unmatched ()
 	fi
 }
 
-#
-# Print a submodule configuration setting
-#
-# $1 = submodule name
-# $2 = option name
-# $3 = default value
-#
-# Checks in the usual git-config places first (for overrides),
-# otherwise it falls back on .gitmodules.  This allows you to
-# distribute project-wide defaults in .gitmodules, while still
-# customizing individual repositories if necessary.  If the option is
-# not in .gitmodules either, print a default value.
-#
-get_submodule_config () {
-	name="$1"
-	option="$2"
-	default="$3"
-	value=$(git config submodule."$name"."$option")
-	if test -z "$value"
-	then
-		value=$(git submodule--helper config submodule."$name"."$option")
-	fi
-	printf '%s' "${value:-$default}"
-}
-
 isnumber()
 {
 	n=$(($1 + 0)) 2>/dev/null && test "$n" = "$1"
@@ -831,166 +806,7 @@ cmd_summary() {
 		shift
 	done
 
-	test $summary_limit = 0 && return
-
-	if rev=$(git rev-parse -q --verify --default HEAD ${1+"$1"})
-	then
-		head=$rev
-		test $# = 0 || shift
-	elif test -z "$1" || test "$1" = "HEAD"
-	then
-		# before the first commit: compare with an empty tree
-		head=$(git hash-object -w -t tree --stdin </dev/null)
-		test -z "$1" || shift
-	else
-		head="HEAD"
-	fi
-
-	if [ -n "$files" ]
-	then
-		test -n "$cached" &&
-		die "$(gettext "The --cached option cannot be used with the --files option")"
-		diff_cmd=diff-files
-		head=
-	fi
-
-	cd_to_toplevel
-	eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"
-	# Get modified modules cared by user
-	modules=$(git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- "$@" |
-		sane_egrep '^:([0-7]* )?160000' |
-		while read -r mod_src mod_dst sha1_src sha1_dst status sm_path
-		do
-			# Always show modules deleted or type-changed (blob<->module)
-			if test "$status" = D || test "$status" = T
-			then
-				printf '%s\n' "$sm_path"
-				continue
-			fi
-			# Respect the ignore setting for --for-status.
-			if test -n "$for_status"
-			then
-				name=$(git submodule--helper name "$sm_path")
-				ignore_config=$(get_submodule_config "$name" ignore none)
-				test $status != A && test $ignore_config = all && continue
-			fi
-			# Also show added or modified modules which are checked out
-			GIT_DIR="$sm_path/.git" git rev-parse --git-dir >/dev/null 2>&1 &&
-			printf '%s\n' "$sm_path"
-		done
-	)
-
-	test -z "$modules" && return
-
-	git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- $modules |
-	sane_egrep '^:([0-7]* )?160000' |
-	cut -c2- |
-	while read -r mod_src mod_dst sha1_src sha1_dst status name
-	do
-		if test -z "$cached" &&
-			is_zero_oid $sha1_dst
-		then
-			case "$mod_dst" in
-			160000)
-				sha1_dst=$(GIT_DIR="$name/.git" git rev-parse HEAD)
-				;;
-			100644 | 100755 | 120000)
-				sha1_dst=$(git hash-object $name)
-				;;
-			000000)
-				;; # removed
-			*)
-				# unexpected type
-				eval_gettextln "unexpected mode \$mod_dst" >&2
-				continue ;;
-			esac
-		fi
-		missing_src=
-		missing_dst=
-
-		test $mod_src = 160000 &&
-		! GIT_DIR="$name/.git" git rev-parse -q --verify $sha1_src^0 >/dev/null &&
-		missing_src=t
-
-		test $mod_dst = 160000 &&
-		! GIT_DIR="$name/.git" git rev-parse -q --verify $sha1_dst^0 >/dev/null &&
-		missing_dst=t
-
-		display_name=$(git submodule--helper relative-path "$name" "$wt_prefix")
-
-		total_commits=
-		case "$missing_src,$missing_dst" in
-		t,)
-			errmsg="$(eval_gettext "  Warn: \$display_name doesn't contain commit \$sha1_src")"
-			;;
-		,t)
-			errmsg="$(eval_gettext "  Warn: \$display_name doesn't contain commit \$sha1_dst")"
-			;;
-		t,t)
-			errmsg="$(eval_gettext "  Warn: \$display_name doesn't contain commits \$sha1_src and \$sha1_dst")"
-			;;
-		*)
-			errmsg=
-			total_commits=$(
-			if test $mod_src = 160000 && test $mod_dst = 160000
-			then
-				range="$sha1_src...$sha1_dst"
-			elif test $mod_src = 160000
-			then
-				range=$sha1_src
-			else
-				range=$sha1_dst
-			fi
-			GIT_DIR="$name/.git" \
-			git rev-list --first-parent $range -- | wc -l
-			)
-			total_commits=" ($(($total_commits + 0)))"
-			;;
-		esac
-
-		sha1_abbr_src=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_src 2>/dev/null ||
-			echo $sha1_src | cut -c1-7)
-		sha1_abbr_dst=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_dst 2>/dev/null ||
-			echo $sha1_dst | cut -c1-7)
-
-		if test $status = T
-		then
-			blob="$(gettext "blob")"
-			submodule="$(gettext "submodule")"
-			if test $mod_dst = 160000
-			then
-				echo "* $display_name $sha1_abbr_src($blob)->$sha1_abbr_dst($submodule)$total_commits:"
-			else
-				echo "* $display_name $sha1_abbr_src($submodule)->$sha1_abbr_dst($blob)$total_commits:"
-			fi
-		else
-			echo "* $display_name $sha1_abbr_src...$sha1_abbr_dst$total_commits:"
-		fi
-		if test -n "$errmsg"
-		then
-			# Don't give error msg for modification whose dst is not submodule
-			# i.e. deleted or changed to blob
-			test $mod_dst = 160000 && echo "$errmsg"
-		else
-			if test $mod_src = 160000 && test $mod_dst = 160000
-			then
-				limit=
-				test $summary_limit -gt 0 && limit="-$summary_limit"
-				GIT_DIR="$name/.git" \
-				git log $limit --pretty='format:  %m %s' \
-				--first-parent $sha1_src...$sha1_dst
-			elif test $mod_dst = 160000
-			then
-				GIT_DIR="$name/.git" \
-				git log --pretty='format:  > %s' -1 $sha1_dst
-			else
-				GIT_DIR="$name/.git" \
-				git log --pretty='format:  < %s' -1 $sha1_src
-			fi
-			echo
-		fi
-		echo
-	done
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper summary ${GIT_QUIET:+--quiet} ${prefix:+--prefix "$prefix"} ${for_status:+--for-status} ${files:+--files} ${cached:+--cached} ${summary_limit:+-n $summary_limit} "$@"
 }
 #
 # List all submodules, prefixed with:
-- 
2.27.0

