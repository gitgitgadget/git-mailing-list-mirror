Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64A9A1FAE2
	for <e@80x24.org>; Mon, 29 Jan 2018 22:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeA2Wyy (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:54:54 -0500
Received: from mout.gmx.net ([212.227.15.18]:50019 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751649AbeA2Wyx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:54:53 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MYwyp-1eJWOj3FHn-00Vk1a; Mon, 29 Jan 2018 23:54:46 +0100
Date:   Mon, 29 Jan 2018 23:54:46 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 03/10] sequencer: introduce the `merge` command
In-Reply-To: <cover.1517266437.git.johannes.schindelin@gmx.de>
Message-ID: <42839735d7aa3e56411cb68fd645349e09239777.1517266437.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <cover.1517266437.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NG54hPdsuLGv99z2rwfs9LN3uhtaWy2gCQM/gD0jibnMa4Bf2QN
 TbwtzoEAHyGMPWi11r0hqQ5EWnyjhCmHTJuqUE77dzeqSbGtejFTtIf2+A3x/3sUiGvyUU7
 KBAPgq7jbBLuRLpmqX3EXsCkO24utnVxBOPgVHttwuRlR1XSCSI5lV/DSDW9TuInQBGA2ar
 Kbtp+9j+bShlj7HbNwXNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PK//krmyyzc=:mVdMdLU9G/dhR5EeOCyA3y
 LDmHnmTiMg86N7QimH5SdiElNElK/Nwt+CztYNbDOpHE5TQLGiZIyU3BEhB87xDo3GtwF7eq0
 r65t84CdFbAi31BeYOiyN1u149mf4RWxnYSpIKxjFpoEwV7yMReysplfddkfIGnIDUV0Tq6yd
 4uuXrJyqRI6bMnYOSp/TUBgK8HICbHmDoBj35zOexn2AEnA9qx1yFbK82EZb/eZNvaLYSPm1o
 vwYNZWbEjQ+8U9pxKTYehS1ADE8nDw1FLuGrWPrLhBYuvNcmSHFOEXT6zOEqt/LvGeLgIrHiH
 fLxVFIgwy2Gg/Vz6f8wm1JZu1ui3BairlDlQQLpoh3X2Tpz8z3wGCZMI+VsZV7RKawxmWUj1L
 Zj0p/d/hWoyFCzId8sJY5SqtrwGFgxc8W+9HqcDWg9qBuxwbXdlzbaumEBgnQkt9NruTR0RbE
 k5bEXQq8rZec866y8Kg/h1Z/1Ay22HHVmSAVHG5bSburdKIJ1aqkaNAoENPzGFalsu4sQkfJS
 QEtaBDE0eK2uNTvlPmAVujrv05PbRqBQ5CM+adiPb22uvsabJGF3IKB7A9ws1g9QleG/h9MqQ
 YLkWGb09ztgVvPvWYqkNDzt8VX6WNIEpXawapEKY6EJb7kEtZRABWo1rCx1d7adYtyIhyhldx
 wZ0Tv3RVmIibNIurCJzkOHbk3m1muUDjWDwGXktxs3iLbCLvUiWsWY9tYME902La2rwA8r13g
 1nkaJWevxREdeEqd7CtnAweU5p9YnvS2rAcTX2TKqUDGawTjNgpNc9+mEUeVSyW6Qo0FhbF0P
 2qzOsuLz0KP8rLDIQQOiSDv1EwprNY9iDdjr7oLVbHQY6OM2g6qGo3qgCo3MfSl/xTxSEit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch is part of the effort to reimplement `--preserve-merges` with
a substantially improved design, a design that has been developed in the
Git for Windows project to maintain the dozens of Windows-specific patch
series on top of upstream Git.

The previous patch implemented the `label` and `reset` commands to label
commits and to reset to a labeled commits. This patch adds the `merge`
command, with the following syntax:

	merge <commit> <rev> <oneline>

The <commit> parameter in this instance is the *original* merge commit,
whose author and message will be used for the to-be-created merge
commit.

The <rev> parameter refers to the (possibly rewritten) revision to
merge. Let's see an example of a todo list:

	label onto

	# Branch abc
	reset onto
	pick deadbeef Hello, world!
	label abc

	reset onto
	pick cafecafe And now for something completely different
	merge baaabaaa abc Merge the branch 'abc' into master

To support creating *new* merges, i.e. without copying the commit
message from an existing commit, use the special value `-` as <commit>
parameter (in which case the text after the <rev> parameter is used as
commit message):

	merge - abc This will be the actual commit message of the merge

This comes in handy when splitting a branch into two or more branches.

Note: this patch only adds support for recursive merges, to keep things
simple. Support for octopus merges will be added later in a separate
patch series, support for merges using strategies other than the
recursive merge is left for the future.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh |   4 ++
 sequencer.c                | 146 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 146 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 7e5281e74aa..d6fd30f6c09 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -164,6 +164,10 @@ x, exec <commit> = run command (the rest of the line) using shell
 d, drop <commit> = remove commit
 l, label <label> = label current HEAD with a name
 t, reset <label> = reset HEAD to a label
+m, merge <original-merge-commit> ( <label> | \"<label>...\" ) [<oneline>]
+.       create a merge commit using the original merge commit's
+.       message (or the oneline, if "-" is given). Use a quoted
+.       list of commits to be merged for octopus merges.
 
 These lines can be re-ordered; they are executed from top to bottom.
 " | git stripspace --comment-lines >>"$todo"
diff --git a/sequencer.c b/sequencer.c
index 92ca8d2adee..dfc9f9e13cd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -778,6 +778,7 @@ enum todo_command {
 	TODO_EXEC,
 	TODO_LABEL,
 	TODO_RESET,
+	TODO_MERGE,
 	/* commands that do nothing but are counted for reporting progress */
 	TODO_NOOP,
 	TODO_DROP,
@@ -798,6 +799,7 @@ static struct {
 	{ 'x', "exec" },
 	{ 'l', "label" },
 	{ 't', "reset" },
+	{ 'm', "merge" },
 	{ 0,   "noop" },
 	{ 'd', "drop" },
 	{ 0,   NULL }
@@ -1302,14 +1304,20 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	}
 
 	end_of_object_name = (char *) bol + strcspn(bol, " \t\n");
+	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
+	item->arg_len = (int)(eol - item->arg);
+
+	if (item->command == TODO_MERGE && *bol == '-' &&
+	    bol + 1 == end_of_object_name) {
+		item->commit = NULL;
+		return 0;
+	}
+
 	saved = *end_of_object_name;
 	*end_of_object_name = '\0';
 	status = get_oid(bol, &commit_oid);
 	*end_of_object_name = saved;
 
-	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
-	item->arg_len = (int)(eol - item->arg);
-
 	if (status < 0)
 		return -1;
 
@@ -2072,6 +2080,132 @@ static int do_reset(const char *name, int len)
 	return ret;
 }
 
+static int do_merge(struct commit *commit, const char *arg, int arg_len,
+		    struct replay_opts *opts)
+{
+	int merge_arg_len;
+	struct strbuf ref_name = STRBUF_INIT;
+	struct commit *head_commit, *merge_commit, *i;
+	struct commit_list *common, *j, *reversed = NULL;
+	struct merge_options o;
+	int ret;
+	static struct lock_file lock;
+
+	for (merge_arg_len = 0; merge_arg_len < arg_len; merge_arg_len++)
+		if (isspace(arg[merge_arg_len]))
+			break;
+
+	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
+		return -1;
+
+	head_commit = lookup_commit_reference_by_name("HEAD");
+	if (!head_commit) {
+		rollback_lock_file(&lock);
+		return error(_("cannot merge without a current revision"));
+	}
+
+	if (commit) {
+		const char *message = get_commit_buffer(commit, NULL);
+		const char *body;
+		int len;
+
+		if (!message) {
+			rollback_lock_file(&lock);
+			return error(_("could not get commit message of '%s'"),
+				     oid_to_hex(&commit->object.oid));
+		}
+		write_author_script(message);
+		find_commit_subject(message, &body);
+		len = strlen(body);
+		if (write_message(body, len, git_path_merge_msg(), 0) < 0) {
+			error_errno(_("could not write '%s'"),
+				    git_path_merge_msg());
+			unuse_commit_buffer(commit, message);
+			rollback_lock_file(&lock);
+			return -1;
+		}
+		unuse_commit_buffer(commit, message);
+	} else {
+		const char *p = arg + merge_arg_len;
+		struct strbuf buf = STRBUF_INIT;
+		int len;
+
+		strbuf_addf(&buf, "author %s", git_author_info(0));
+		write_author_script(buf.buf);
+		strbuf_reset(&buf);
+
+		p += strspn(p, " \t");
+		if (*p)
+			len = strlen(p);
+		else {
+			strbuf_addf(&buf, "Merge branch '%.*s'",
+				    merge_arg_len, arg);
+			p = buf.buf;
+			len = buf.len;
+		}
+
+		if (write_message(p, len, git_path_merge_msg(), 0) < 0) {
+			error_errno(_("could not write '%s'"),
+				    git_path_merge_msg());
+			strbuf_release(&buf);
+			rollback_lock_file(&lock);
+			return -1;
+		}
+		strbuf_release(&buf);
+	}
+
+	strbuf_addf(&ref_name, "refs/rewritten/%.*s", merge_arg_len, arg);
+	merge_commit = lookup_commit_reference_by_name(ref_name.buf);
+	if (!merge_commit) {
+		/* fall back to non-rewritten ref or commit */
+		strbuf_splice(&ref_name, 0, strlen("refs/rewritten/"), "", 0);
+		merge_commit = lookup_commit_reference_by_name(ref_name.buf);
+	}
+	if (!merge_commit) {
+		error(_("could not resolve '%s'"), ref_name.buf);
+		strbuf_release(&ref_name);
+		rollback_lock_file(&lock);
+		return -1;
+	}
+	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
+		      git_path_merge_head(), 0);
+	write_message("no-ff", 5, git_path_merge_mode(), 0);
+
+	common = get_merge_bases(head_commit, merge_commit);
+	for (j = common; j; j = j->next)
+		commit_list_insert(j->item, &reversed);
+	free_commit_list(common);
+
+	read_cache();
+	init_merge_options(&o);
+	o.branch1 = "HEAD";
+	o.branch2 = ref_name.buf;
+	o.buffer_output = 2;
+
+	ret = merge_recursive(&o, head_commit, merge_commit, reversed, &i);
+	if (ret <= 0)
+		fputs(o.obuf.buf, stdout);
+	strbuf_release(&o.obuf);
+	if (ret < 0) {
+		strbuf_release(&ref_name);
+		rollback_lock_file(&lock);
+		return error(_("conflicts while merging '%.*s'"),
+			     merge_arg_len, arg);
+	}
+
+	if (active_cache_changed &&
+	    write_locked_index(&the_index, &lock, COMMIT_LOCK)) {
+		strbuf_release(&ref_name);
+		return error(_("merge: Unable to write new index file"));
+	}
+	rollback_lock_file(&lock);
+
+	ret = run_git_commit(git_path_merge_msg(), opts, 0);
+	strbuf_release(&ref_name);
+
+	return ret;
+}
+
 static int is_final_fixup(struct todo_list *todo_list)
 {
 	int i = todo_list->current;
@@ -2259,6 +2393,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			res = do_label(item->arg, item->arg_len);
 		else if (item->command == TODO_RESET)
 			res = do_reset(item->arg, item->arg_len);
+		else if (item->command == TODO_MERGE)
+			res = do_merge(item->commit,
+				       item->arg, item->arg_len, opts);
 		else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
@@ -2758,7 +2895,8 @@ int transform_todos(unsigned flags)
 					  oid_to_hex(&item->commit->object.oid);
 
 			strbuf_addf(&buf, " %s", oid);
-		}
+		} else if (item->command == TODO_MERGE)
+			strbuf_addstr(&buf, " -");
 		/* add all the rest */
 		if (!item->arg_len)
 			strbuf_addch(&buf, '\n');
-- 
2.16.1.windows.1


