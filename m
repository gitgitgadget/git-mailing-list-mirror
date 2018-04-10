Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E561F1F42D
	for <e@80x24.org>; Tue, 10 Apr 2018 12:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbeDJM35 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:29:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:59777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752997AbeDJM3z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:29:55 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LoEwL-1eZ1gi08IT-00gIKO; Tue, 10 Apr 2018 14:29:49 +0200
Date:   Tue, 10 Apr 2018 14:29:48 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v6 05/15] sequencer: introduce the `merge` command
In-Reply-To: <cover.1523362469.git.johannes.schindelin@gmx.de>
Message-ID: <8a5ae61f603df8d8cb19268e1b8470f0a4993445.1523362469.git.johannes.schindelin@gmx.de>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:d6ZYaCgaBIpMCmSfjw9trY2jtuIvhjjEXI6tME/7WicAwRZ+iw7
 jQTW7qm44RhznlodKz4GfwYKjeYStj0820o5IR1JlOF0kg+yOvThUdRe3MpCWR0ZPHId+uF
 xQfEc7CW1oWvNEPkB4LSN8aL/TxYwTZ/0TowJEVWIH5jmWwJr7fhc1ZrGWCW5vLvOATOVFk
 o0Dxc1b/LXzsoDx7fU0rA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IiS2dCZlJ8c=:dY00pwChw+2fYDd5Esf2A0
 PyZ3DtQxFIBGAWE0hW14u2aI6CsnQRfKXKSrMNGQr+dhOHV8sb2fd3uHyeaGdoLcfsUM+nqIZ
 e27YQrbkI7AT5nm3DmbR9+nRR/AUq/TtPTIa8/YJZCsp/p+TVtFfyRN/F+im5FwC/g/cSvnmT
 N0x9xZu8SCn2PSjOfRVYegzkOUKVZvPanZLXuytY39AjnUJ7sKIDUTrJJk8MdBZnL+7LYyQxz
 ieIM+AMWHLJCDmnGoyjGNGRjl5qpfL6ngCLX9aebDPWixwBRow1X4E4zMQfwVEaDZgn3wSpQ+
 FHF66yhYdiyEgy0b197RtowElwtcYb7NhJy1Xv4rQ+FDm1i5/JmZXWNR2zw8l8M4ozuvKrjyC
 IKGsJ6BDhDXNOX7A5cRCYxN7dPiznXGgjjXRfjBkqrtS1FcNddFsIbCO1Y8aIU3Q3B5tNadRp
 M2zsDfZfdXLfk+712ZyP/EKVkYH6tLCi96EGbPq7rMU2QVkSYTmyjE+knSrnLpxWC9VVtGqva
 7luou5z5gruTpgU/x0EC7Tn37T3WT9bsqp0XkWOKsL062ADJhrBU0B7gUuSuZJ6SHznHbe7Sq
 JcG7QoljlxMDSaYRf3lXkU2gx54M8tjOZ7d7PvqPeGBz2MDqrDxiHST3xn5g+YWpC0peLzlfY
 pVeUbV4v6sHXWP8olQ/voYKx4qf+SNpJ1u27QKHbtdOPzORp/Yk4tEFUF0x4S2vvpBxeV5PhB
 Im+jP+MXOy/gDLJ48bNoqhygiw7PHs5Z6cHwnnPAu6+mQ1tQ9rAOAS3kOQcM8JPe6BTYw03U4
 yalwi7HxCz40Qm24YqqGyC3OLkNAp6w0TCLGzWtpdkvfMXApC0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch is part of the effort to reimplement `--preserve-merges` with
a substantially improved design, a design that has been developed in the
Git for Windows project to maintain the dozens of Windows-specific patch
series on top of upstream Git.

The previous patch implemented the `label` and `reset` commands to label
commits and to reset to labeled commits. This patch adds the `merge`
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
 git-rebase--interactive.sh |   4 +
 sequencer.c                | 170 +++++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e8d3a7d7588..ccd5254d1c9 100644
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
index c63d47f5e09..1b5f1441102 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1305,6 +1305,7 @@ enum todo_command {
 	TODO_EXEC,
 	TODO_LABEL,
 	TODO_RESET,
+	TODO_MERGE,
 	/* commands that do nothing but are counted for reporting progress */
 	TODO_NOOP,
 	TODO_DROP,
@@ -1325,6 +1326,7 @@ static struct {
 	{ 'x', "exec" },
 	{ 'l', "label" },
 	{ 't', "reset" },
+	{ 'm', "merge" },
 	{ 0,   "noop" },
 	{ 'd', "drop" },
 	{ 0,   NULL }
@@ -1752,9 +1754,14 @@ static int read_and_refresh_cache(struct replay_opts *opts)
 	return 0;
 }
 
+enum todo_item_flags {
+	TODO_EDIT_MERGE_MSG = 1
+};
+
 struct todo_item {
 	enum todo_command command;
 	struct commit *commit;
+	unsigned int flags;
 	const char *arg;
 	int arg_len;
 	size_t offset_in_buf;
@@ -1789,6 +1796,8 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	char *end_of_object_name;
 	int i, saved, status, padding;
 
+	item->flags = 0;
+
 	/* left-trim */
 	bol += strspn(bol, " \t");
 
@@ -1838,6 +1847,21 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 		return 0;
 	}
 
+	if (item->command == TODO_MERGE) {
+		if (skip_prefix(bol, "-C", &bol))
+			bol += strspn(bol, " \t");
+		else if (skip_prefix(bol, "-c", &bol)) {
+			bol += strspn(bol, " \t");
+			item->flags |= TODO_EDIT_MERGE_MSG;
+		} else {
+			item->flags |= TODO_EDIT_MERGE_MSG;
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
@@ -2632,6 +2656,141 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
 	return ret;
 }
 
+static int do_merge(struct commit *commit, const char *arg, int arg_len,
+		    int flags, struct replay_opts *opts)
+{
+	int run_commit_flags = (flags & TODO_EDIT_MERGE_MSG) ?
+		EDIT_MSG | VERIFY_MSG : 0;
+	struct strbuf ref_name = STRBUF_INIT;
+	struct commit *head_commit, *merge_commit, *i;
+	struct commit_list *bases, *j, *reversed = NULL;
+	struct merge_options o;
+	int merge_arg_len, oneline_offset, ret;
+	static struct lock_file lock;
+	const char *p;
+
+	oneline_offset = arg_len;
+	merge_arg_len = strcspn(arg, " \t\n");
+	p = arg + merge_arg_len;
+	p += strspn(p, " \t\n");
+	if (*p == '#' && (!p[1] || isspace(p[1]))) {
+		p += 1 + strspn(p + 1, " \t\n");
+		oneline_offset = p - arg;
+	} else if (p - arg < arg_len)
+		BUG("octopus merges are not supported yet: '%s'", p);
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
+		return -1;
+	}
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
+		struct strbuf buf = STRBUF_INIT;
+		int len;
+
+		strbuf_addf(&buf, "author %s", git_author_info(0));
+		write_author_script(buf.buf);
+		strbuf_reset(&buf);
+
+		if (oneline_offset < arg_len) {
+			p = arg + oneline_offset;
+			len = arg_len - oneline_offset;
+		} else {
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
+	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
+		      git_path_merge_head(), 0);
+	write_message("no-ff", 5, git_path_merge_mode(), 0);
+
+	bases = get_merge_bases(head_commit, merge_commit);
+	for (j = bases; j; j = j->next)
+		commit_list_insert(j->item, &reversed);
+	free_commit_list(bases);
+
+	read_cache();
+	init_merge_options(&o);
+	o.branch1 = "HEAD";
+	o.branch2 = ref_name.buf;
+	o.buffer_output = 2;
+
+	ret = merge_recursive(&o, head_commit, merge_commit, reversed, &i);
+	if (!ret)
+		rerere(opts->allow_rerere_auto);
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
@@ -2820,6 +2979,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			res = do_label(item->arg, item->arg_len);
 		else if (item->command == TODO_RESET)
 			res = do_reset(item->arg, item->arg_len, opts);
+		else if (item->command == TODO_MERGE)
+			res = do_merge(item->commit, item->arg, item->arg_len,
+				       item->flags, opts);
 		else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
@@ -3302,8 +3464,16 @@ int transform_todos(unsigned flags)
 					  short_commit_name(item->commit) :
 					  oid_to_hex(&item->commit->object.oid);
 
+			if (item->command == TODO_MERGE) {
+				if (item->flags & TODO_EDIT_MERGE_MSG)
+					strbuf_addstr(&buf, " -c");
+				else
+					strbuf_addstr(&buf, " -C");
+			}
+
 			strbuf_addf(&buf, " %s", oid);
 		}
+
 		/* add all the rest */
 		if (!item->arg_len)
 			strbuf_addch(&buf, '\n');
-- 
2.17.0.windows.1.4.g7e4058d72e3


