Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C29DF1F404
	for <e@80x24.org>; Sun, 11 Feb 2018 00:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeBKAK2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 19:10:28 -0500
Received: from mout.gmx.net ([212.227.15.15]:34667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752987AbeBKAK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 19:10:26 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0MfF6I-1eLzja02Di-00Onb2; Sun, 11 Feb 2018 01:10:20 +0100
Date:   Sun, 11 Feb 2018 01:10:19 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 05/12] sequencer: introduce the `merge` command
In-Reply-To: <cover.1518307771.git.johannes.schindelin@gmx.de>
Message-ID: <852814d99f39281224c8f75668b18adae57864b9.1518307771.git.johannes.schindelin@gmx.de>
References: <cover.1517266437.git.johannes.schindelin@gmx.de> <cover.1518307771.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QAgEM+j3YZMlzj5AVAa0ZaeGTbeGe+QwbC5J6MOsRPSibkMYI7U
 p9gvYsn0nONkiH0oYxtjQMAlfNVM2lgFhXZns4cYVmc4vfFc8a0Xd1TFQCh2eYXwjgZzLEV
 6bJVw7G++gpkVKWlExdrYajLWEbvM83gv16h+KH1EASdGCyuTPui0nJuObtprSNTVK8WREz
 kKGBipGtOavyi44e1jMaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hRXXEJupcuI=:K4pdBjOe8RLztMH5y3co8i
 Zypl4sU/GOZZhjI22+xdLAxhh/WG94OIyG5QVjzjZUte3kv3+lGffdO/u2uH7DfKvSvwjRmRz
 vwkgIQQEZxz9gMXbD8moL4GOtnEKV/mwHuBAAeXdSTnl1DxXn6XNUiTSKia+ajYRv4Ja/N9xI
 dJLwfwVUaaFVWQfLrMQXQs78ywXzpGnqAqw2/rEt9w+mqt2qBYvq7j2Pa8zkb8iRDRvFmHscA
 1wH/+lGJHGfwe+gjBfcyCkl2TrQGoJYXGNrx+heflJ1Ezo+jTGa4hd/z6uutBsrIVgIRnxwt5
 cv2xfpFUVHkuoDz3P/8bLu61h9JnhBeaTCQoXZ3j+t1Mmn3/UqYgnIDSpoIOPaY2bgTcjON8m
 7R8vgF8iYrNX2Ro3Wdxl84GmQoOBNX34sVsgOLROZ6JIqzd2u2NKqdatsDDv2pJ9qIpxSe9pE
 FtZyiRYC7Fch3sNkIf2mx97WlrM8aLiL6sfkopkNmo4u7ImxdxwfgubvwB10QpYixYodTTXDs
 SAJejq/MXgGM47eH+ov+uVhZVJu5LaffmaeL1V7nfWSgO3fkKC7O+b5cFdUtyRtCPr5PJf8xE
 ilHnhNbL1DYqzg4/EzvC1AnmdNU91nfxjYjoYLe2+vqnAMz3a2aikcqAvBhQ8/ZsNu58w7P4w
 LR85+UIuWEypTT8a0AxvithV0M6cohTyGQePPEKWtFWxBlxKf5iVw+xudtqi7cggz5yldfdw2
 TdrkCSlC2e1Agc4ecArlF8JIV0Gj2mxjmaiVgeJAOZGNQFV3Z7QawUtxxuy4+mZ+PUxLT9NcH
 NbZnPn/lCWoMPxh617RptAh2E0cCRM3re8UN4rYVa6dfawrOsM=
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

	merge [-C <commit>] <rev> # <oneline>

The <commit> parameter in this instance is the *original* merge commit,
whose author and message will be used for the merge commit that is about
to be created.

The <rev> parameter refers to the (possibly rewritten) revision to
merge. Let's see an example of a todo list:

	label onto

	# Branch abc
	reset onto
	pick deadbeef Hello, world!
	label abc

	reset onto
	pick cafecafe And now for something completely different
	merge -C baaabaaa abc # Merge the branch 'abc' into master

To edit the merge commit's message (a "reword" for merges, if you will),
use `-c` (lower-case) instead of `-C`; this convention was borrowed from
`git commit` that also supports `-c` and `-C` with similar meanings.

To create *new* merges, i.e. without copying the commit message from an
existing commit, simply omit the `-C <commit>` parameter (which will
open an editor for the merge message):

	merge abc

This comes in handy when splitting a branch into two or more branches.

Note: this patch only adds support for recursive merges, to keep things
simple. Support for octopus merges will be added later in a separate
patch series, support for merges using strategies other than the
recursive merge is left for the future.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh |   4 ++
 sequencer.c                | 158 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 162 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 7e5281e74aa..9d9d91f25e3 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -164,6 +164,10 @@ x, exec <commit> = run command (the rest of the line) using shell
 d, drop <commit> = remove commit
 l, label <label> = label current HEAD with a name
 t, reset <label> = reset HEAD to a label
+m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
+.       create a merge commit using the original merge commit's
+.       message (or the oneline, if no original merge commit was
+.       specified). Use -c <commit> to reword the commit message.
 
 These lines can be re-ordered; they are executed from top to bottom.
 " | git stripspace --comment-lines >>"$todo"
diff --git a/sequencer.c b/sequencer.c
index 8638086f667..e577c213494 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -795,6 +795,8 @@ enum todo_command {
 	TODO_EXEC,
 	TODO_LABEL,
 	TODO_RESET,
+	TODO_MERGE,
+	TODO_MERGE_AND_EDIT,
 	/* commands that do nothing but are counted for reporting progress */
 	TODO_NOOP,
 	TODO_DROP,
@@ -815,6 +817,8 @@ static struct {
 	{ 'x', "exec" },
 	{ 'l', "label" },
 	{ 't', "reset" },
+	{ 'm', "merge" },
+	{ 0, "merge" }, /* MERGE_AND_EDIT */
 	{ 0,   "noop" },
 	{ 'd', "drop" },
 	{ 0,   NULL }
@@ -1317,6 +1321,21 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 		return 0;
 	}
 
+	if (item->command == TODO_MERGE) {
+		if (skip_prefix(bol, "-C", &bol))
+			bol += strspn(bol, " \t");
+		else if (skip_prefix(bol, "-c", &bol)) {
+			bol += strspn(bol, " \t");
+			item->command = TODO_MERGE_AND_EDIT;
+		} else {
+			item->command = TODO_MERGE_AND_EDIT;
+			item->commit = NULL;
+			item->arg = bol;
+			item->arg_len = (int)(eol - bol);
+			return 0;
+		}
+	}
+
 	end_of_object_name = (char *) bol + strcspn(bol, " \t\n");
 	saved = *end_of_object_name;
 	*end_of_object_name = '\0';
@@ -2096,6 +2115,134 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
 	return ret;
 }
 
+static int do_merge(struct commit *commit, const char *arg, int arg_len,
+		    int run_commit_flags, struct replay_opts *opts)
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
+		if (*p == '#' && isspace(p[1]))
+			p += 1 + strspn(p + 1, " \t");
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
+	ret = run_git_commit(git_path_merge_msg(), opts, run_commit_flags);
+	strbuf_release(&ref_name);
+
+	return ret;
+}
+
 static int is_final_fixup(struct todo_list *todo_list)
 {
 	int i = todo_list->current;
@@ -2283,6 +2430,11 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			res = do_label(item->arg, item->arg_len);
 		else if (item->command == TODO_RESET)
 			res = do_reset(item->arg, item->arg_len, opts);
+		else if (item->command == TODO_MERGE ||
+			 item->command == TODO_MERGE_AND_EDIT)
+			res = do_merge(item->commit, item->arg, item->arg_len,
+				       item->command == TODO_MERGE_AND_EDIT ?
+				       EDIT_MSG | VERIFY_MSG : 0, opts);
 		else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
@@ -2764,8 +2916,14 @@ int transform_todos(unsigned flags)
 					  short_commit_name(item->commit) :
 					  oid_to_hex(&item->commit->object.oid);
 
+			if (item->command == TODO_MERGE)
+				strbuf_addstr(&buf, " -C");
+			else if (item->command == TODO_MERGE_AND_EDIT)
+				strbuf_addstr(&buf, " -c");
+
 			strbuf_addf(&buf, " %s", oid);
 		}
+
 		/* add all the rest */
 		if (!item->arg_len)
 			strbuf_addch(&buf, '\n');
-- 
2.16.1.windows.1


