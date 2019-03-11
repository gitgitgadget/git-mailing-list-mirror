Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0A2520248
	for <e@80x24.org>; Mon, 11 Mar 2019 03:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfCKDmx (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 23:42:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40232 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfCKDmx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 23:42:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id h1so2682157pfo.7
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 20:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H1LWfN6vl2Eba+GE65H81XSPwWjJOnQdeaN4Wu74MPU=;
        b=obeXSDZBg22SLlw/DRq50jh19dmaf1hcugtOYR3eWYg/JyxudtrdYKqSOdDAHwyEZc
         Wg1bY1OZLDyLvqSWn07ha+cDFXe2zDFmUfO8Wq32xhcuhfF7S7WAGYMQl7WTj/neDzks
         FzNk+YNmLfgsIbgDn6F1jrJBBCKAHtk01Ee2vXyv7rpjZX655d8piVh2jxUbgSvM9ppe
         x67yBtAwB1hPkaQpJZMO3Zjd/YxXSPpVdI75ESuJj/BP36VypZppsi9RO69+BwAIsaaD
         b1465uHl82gX+npF8y7dmj3KgDIxAGrV6JCzv8HQu5qvdRSujmxQYRrhXTBYP0F1aLaA
         17Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H1LWfN6vl2Eba+GE65H81XSPwWjJOnQdeaN4Wu74MPU=;
        b=E5DYbPuzTyUMEgMQjUPNu21SNERT0FIxOVd9mjno1TLsG5F5z85Bnu490B6oujeLWc
         HnkkyRSxbUf/ssHXhNmGl7CsHNA/UN48w5jAFC/w8EqKzawkJ1va+vSQqavV5y/jEiEe
         CC/X/l1EN4AFM7d8uVD5S9tBly0JGHirQBNZdbV3E8CzTTB33ZgYiJGMOJjvw8VklqDX
         tZnG7qzGe9UqcCbvho9mEZSi1AwpaIH6X+UpBl4VlhUH3E0F7lLjDrlH6AgNlFELkD2P
         5o0e8vZn2T6p9nj72yxcOzvQWkPf/w0aylx4S7+Z+DwPJkD0NzpfgA/y2XOlnjog+dgW
         EMxQ==
X-Gm-Message-State: APjAAAUEJ4ChNhNr/wCxtiKt1J7qQ2YE8HAuxXVSp8tgpYXX071afA4u
        OEt7S1TeVPtAZkFULIdYQ57Iroqk
X-Google-Smtp-Source: APXvYqxYlExQFIYbKoCKB7zcynGSM7pgf5MNFyQyXhzE24AawP8JCv+e5U2bOeTlLf7EgNh4cToc2w==
X-Received: by 2002:a63:d4f:: with SMTP id 15mr28293144pgn.162.1552275771439;
        Sun, 10 Mar 2019 20:42:51 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id t23sm7079695pfa.111.2019.03.10.20.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 20:42:50 -0700 (PDT)
Date:   Sun, 10 Mar 2019 20:42:49 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 8/8] cherry-pick/revert: add scissors line on merge
 conflict
Message-ID: <5b30d939674542b2cfeeeef8341ab25c7d6c0543.1552275703.git.liu.denton@gmail.com>
References: <cover.1548219737.git.liu.denton@gmail.com>
 <cover.1552275703.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552275703.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug where the scissors line is placed after the Conflicts:
section, in the case where a merge conflict occurs and
commit.cleanup = scissors.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-cherry-pick.txt |  7 +++
 Documentation/git-revert.txt      |  7 +++
 builtin/merge.c                   |  9 +---
 builtin/rebase--interactive.c     |  2 +-
 builtin/revert.c                  |  5 ++
 sequencer.c                       | 22 +++++---
 sequencer.h                       |  3 +-
 t/t3507-cherry-pick-conflict.sh   | 86 +++++++++++++++++++++++++++++++
 8 files changed, 123 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index b8cfeec67e..b4ff8e136d 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -57,6 +57,13 @@ OPTIONS
 	With this option, 'git cherry-pick' will let you edit the commit
 	message prior to committing.
 
+--cleanup=<mode>::
+	This option determines how the commit message will be cleaned up before
+	being passed on. See linkgit:git-commit[1] for more details. In
+	addition, if the '<mode>' is given a value of `scissors`, scissors will
+	be appended to MERGE_MSG before being passed on in the case of a
+	conflict.
+
 -x::
 	When recording the commit, append a line that says
 	"(cherry picked from commit ...)" to the original commit
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 837707a8fd..bd4ad395a9 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -66,6 +66,13 @@ more details.
 	With this option, 'git revert' will not start the commit
 	message editor.
 
+--cleanup=<mode>::
+	This option determines how the commit message will be cleaned up before
+	being passed on. See linkgit:git-commit[1] for more details. In
+	addition, if the '<mode>' is given a value of `scissors`, scissors will
+	be appended to MERGE_MSG before being passed on in the case of a
+	conflict.
+
 -n::
 --no-commit::
 	Usually the command automatically creates some commits with
diff --git a/builtin/merge.c b/builtin/merge.c
index b620d4bfcb..671d6a19a4 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -923,14 +923,7 @@ static int suggest_conflicts(void)
 	 * Thus, we will get the cleanup mode which is returned when we _are_ using
 	 * an editor.
 	 */
-	if (get_cleanup_mode(cleanup_arg, 1, 1) == COMMIT_MSG_CLEANUP_SCISSORS) {
-	    fputc('\n', fp);
-	    wt_status_add_cut_line(fp);
-	    /* comments out the newline from append_conflicts_hint */
-	    fputc(comment_line_char, fp);
-	}
-
-	append_conflicts_hint(&the_index, &msgbuf);
+	append_conflicts_hint(&the_index, &msgbuf, get_cleanup_mode(cleanup_arg, 1, 1));
 	fputs(msgbuf.buf, fp);
 	strbuf_release(&msgbuf);
 	fclose(fp);
diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 888390f911..cf2151b271 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -199,10 +199,10 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	opts.action = REPLAY_INTERACTIVE_REBASE;
 	sequencer_init_config(&opts);
 	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
 
-	opts.action = REPLAY_INTERACTIVE_REBASE;
 	opts.allow_ff = 1;
 	opts.allow_empty = 1;
 
diff --git a/builtin/revert.c b/builtin/revert.c
index a47b53ceaf..e8168e0214 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -96,11 +96,13 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
+	const char *cleanup_arg = NULL;
 	int cmd = 0;
 	struct option base_options[] = {
 		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
 		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
 		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
+		OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
 		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
 		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
 		OPT_NOOP_NOARG('r', NULL),
@@ -137,6 +139,9 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	if (opts->keep_redundant_commits)
 		opts->allow_empty = 1;
 
+	if (cleanup_arg)
+		opts->default_msg_cleanup = get_cleanup_mode(cleanup_arg, 1, 1);
+
 	/* Check for incompatible command line arguments */
 	if (cmd) {
 		char *this_operation;
diff --git a/sequencer.c b/sequencer.c
index 5d94e2c865..496554a474 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -176,6 +176,11 @@ struct cleanup_config_mapping cleanup_config_mappings[] = {
 	{ NULL, 0, 0 }
 };
 
+static inline int is_rebase_i(const struct replay_opts *opts)
+{
+	return opts->action == REPLAY_INTERACTIVE_REBASE;
+}
+
 static int git_sequencer_config(const char *k, const char *v, void *cb)
 {
 	struct replay_opts *opts = cb;
@@ -188,7 +193,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
 		if (status)
 			return status;
 
-		opts->default_msg_cleanup = get_cleanup_mode(s, 0, 0);
+		opts->default_msg_cleanup = get_cleanup_mode(s, !is_rebase_i(opts), 0);
 
 		free((char *)s);
 		return status;
@@ -212,11 +217,6 @@ void sequencer_init_config(struct replay_opts *opts)
 	git_config(git_sequencer_config, opts);
 }
 
-static inline int is_rebase_i(const struct replay_opts *opts)
-{
-	return opts->action == REPLAY_INTERACTIVE_REBASE;
-}
-
 static const char *get_dir(const struct replay_opts *opts)
 {
 	if (is_rebase_i(opts))
@@ -557,10 +557,16 @@ const char *get_config_from_cleanup(enum commit_msg_cleanup_mode cleanup_mode)
 }
 
 void append_conflicts_hint(struct index_state *istate,
-			   struct strbuf *msgbuf)
+		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode)
 {
 	int i;
 
+	if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
+		strbuf_addch(msgbuf, '\n');
+		wt_status_append_cut_line(msgbuf);
+		strbuf_addch(msgbuf, comment_line_char);
+	}
+
 	strbuf_addch(msgbuf, '\n');
 	strbuf_commented_addf(msgbuf, "Conflicts:\n");
 	for (i = 0; i < istate->cache_nr;) {
@@ -628,7 +634,7 @@ static int do_recursive_merge(struct repository *r,
 			_(action_name(opts)));
 
 	if (!clean)
-		append_conflicts_hint(r->index, msgbuf);
+		append_conflicts_hint(r->index, msgbuf, opts->default_msg_cleanup);
 
 	return !clean;
 }
diff --git a/sequencer.h b/sequencer.h
index e3c1f44807..95ff9db508 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -115,7 +115,8 @@ int rearrange_squash(struct repository *r);
  */
 void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
 
-void append_conflicts_hint(struct index_state *istate, struct strbuf *msgbuf);
+void append_conflicts_hint(struct index_state *istate,
+		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode);
 enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
 	int use_editor, int die_on_error);
 const char *get_config_from_cleanup(enum commit_msg_cleanup_mode cleanup_mode);
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 74ff925526..c3894ca9d6 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -189,6 +189,46 @@ test_expect_success 'failed cherry-pick registers participants in index' '
 	test_cmp expected actual
 '
 
+test_expect_success \
+	'cherry-pick conflict, ensure commit.cleanup = scissors places scissors line properly' '
+	pristine_detach initial &&
+	git config commit.cleanup scissors &&
+	cat <<-EOF >expected &&
+		picked
+
+		# ------------------------ >8 ------------------------
+		# Do not modify or remove the line above.
+		# Everything below it will be ignored.
+		#
+		# Conflicts:
+		#	foo
+		EOF
+
+	test_must_fail git cherry-pick picked &&
+
+	test_i18ncmp expected .git/MERGE_MSG
+'
+
+test_expect_success \
+	'cherry-pick conflict, ensure cleanup=scissors places scissors line properly' '
+	pristine_detach initial &&
+	git config --unset commit.cleanup &&
+	cat <<-EOF >expected &&
+		picked
+
+		# ------------------------ >8 ------------------------
+		# Do not modify or remove the line above.
+		# Everything below it will be ignored.
+		#
+		# Conflicts:
+		#	foo
+		EOF
+
+	test_must_fail git cherry-pick --cleanup=scissors picked &&
+
+	test_i18ncmp expected .git/MERGE_MSG
+'
+
 test_expect_success 'failed cherry-pick describes conflict in work tree' '
 	pristine_detach initial &&
 	cat <<-EOF >expected &&
@@ -335,6 +375,52 @@ test_expect_success 'revert conflict, diff3 -m style' '
 	test_cmp expected actual
 '
 
+test_expect_success \
+	'revert conflict, ensure commit.cleanup = scissors places scissors line properly' '
+	pristine_detach initial &&
+	git config commit.cleanup scissors &&
+	cat >expected <<-EOF &&
+		Revert "picked"
+
+		This reverts commit OBJID.
+
+		# ------------------------ >8 ------------------------
+		# Do not modify or remove the line above.
+		# Everything below it will be ignored.
+		#
+		# Conflicts:
+		#	foo
+		EOF
+
+	test_must_fail git revert picked &&
+
+	sed "s/$OID_REGEX/OBJID/" .git/MERGE_MSG >actual &&
+	test_i18ncmp expected actual
+'
+
+test_expect_success \
+	'revert conflict, ensure cleanup=scissors places scissors line properly' '
+	pristine_detach initial &&
+	git config --unset commit.cleanup &&
+	cat >expected <<-EOF &&
+		Revert "picked"
+
+		This reverts commit OBJID.
+
+		# ------------------------ >8 ------------------------
+		# Do not modify or remove the line above.
+		# Everything below it will be ignored.
+		#
+		# Conflicts:
+		#	foo
+		EOF
+
+	test_must_fail git revert --cleanup=scissors picked &&
+
+	sed "s/$OID_REGEX/OBJID/" .git/MERGE_MSG >actual &&
+	test_i18ncmp expected actual
+'
+
 test_expect_success 'failed cherry-pick does not forget -s' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick -s picked &&
-- 
2.21.0.370.g4fdb13b891

