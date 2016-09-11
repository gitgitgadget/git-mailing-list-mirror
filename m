Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C536B207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755610AbcIKKwr (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:52:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:53418 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755542AbcIKKwo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:52:44 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MN604-1bgpRz1zbs-006gD6; Sun, 11 Sep 2016 12:52:27
 +0200
Date:   Sun, 11 Sep 2016 12:52:25 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 00/25] Prepare the sequencer for the upcoming rebase -i
 patches
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/xRW/wjGhoaehx9u/uJSpljgxb5BAuYioAvLkGlkL713OzgnnLl
 7qEx1pSQmURyUvTGjOIG3czGuFrYMRK7o/lLdDQaC4jCbmZwlcUccK83H+C07Tf6X1mX2cn
 I6jq+D0YCUMFhwwNn0D4w9WjKhHG8+Ydwh/+TyMAj4zFcAIA9ivC2PhPY7jwks404eBB3Sc
 4+s0Rc5dL+KHaZb8BdtkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c1mQU2mQrOc=:hrf55pLubujboBtZEHmKDX
 zFV9g+muVKwgm7eaSbE8JscaBJ0ZLg7gvnnBPzHHxnu2ncP3LiV8LNesqHzOtTVlDrx6eiBjN
 MWSuyTyfXadLjVRkxEVqBzAbRnQ9oeI6i9u3ssEVf0w7ycMWTLEcx8uW0SF1RCos0aM6O7RI/
 zgD+LhZv77CCB5saZzPgGardXiS/gN8yCfsI8de/177QlYVUr2gz+rBTNJjKVphgF8kXuykGM
 s/dthsMjT36l/751UHPRj0eBaeiIhXNTTi1f9AGtGMznOdfGHdDnU1x0LBiXxqh1qJIVLnk+/
 yFtqK4oYnKSF6pkjNLySW4zldPAFZItxk3EGC0eTASCQUmpg/5iewtkicqk6PQnLWtWmKL3W2
 pv7Kg9iiKaSaYRutXmAzNcJKUlqD3tU4FV8t9E0AAL31eh/jBLQpsYmh4T2uGAp13e26jywAq
 IAzo/9BDA+nM+gxeJcrrDwa3tbNtWl+jrRQ6bAUkh8N3W1BlCrbjCTF8R3Xj9LBdK0zXc663j
 pe32gwrg531Z+heIJBcnuquFm9lRwnwCdSdmm4WJAkBoBYFBmSqvAV4CQth7MLI6H7+xjCL3I
 gA+uOhB2bA66qzADiSfhg7F/WHKSnrwUAu6uOZkinLNJ9agy9gv2xLrkzx9+5zY7PdYqKpIp6
 x/UQeO3lr/sQ5JEUf87If4eBaxnjmD6e3ltomJvv9rMEoLoSfMabF+FAC/3WMB3AVkGpJmND+
 OtEXmUBfgjCppRKZktPvz3DYc+fRo+pBJJ8xrTp2cLu4veyUz8Oqn/7MvYyFBDXgLoNEBUDMy
 svt/0lF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series marks the  '4' in the countdown to speed up rebase -i
by implementing large parts in C. It is based on the `libify-sequencer`
patch series that I submitted last week.

The patches in this series merely prepare the sequencer code for the
next patch series that actually teaches the sequencer to run an
interactive rebase.

The reason to split these two patch series is simple: to keep them at a
sensible size.

The two patch series after that are much smaller: a two-patch "series"
that switches rebase -i to use the sequencer (except with --root or
--preserve-merges), and a couple of patches to move several pretty
expensive script processing steps to C (think: autosquash).

The end game of this patch series is a git-rebase--helper that makes
rebase -i 5x faster on Windows (according to t/perf/p3404). Travis says
that even MacOSX and Linux benefit (4x and 3x, respectively).

I have been working on this since early February, whenever time allowed,
and it is time to put it into the users' hands. To that end, I will most
likely submit the remaining three patch series in the next two days, and
integrate the whole shebang into Git for Windows 2.10.0.

Therefore I would be most grateful for every in-depth review.

Changes vs v1:

- clarified why the code refactoring into the short_commit_name()
  function is desirable.

- fixed a typo in a commit message (s/se/so/).

- removed a bogus call to read_and_refresh_cache(opts) that was added
  to sequencer_rollback() by mistake.

- clarified in the commit message why the TODO_LIST_INIT macro does not
  assign all-zeroes.

- converted IS_REBASE_I() into an inline function.

- clarified the comment about retaining author metadata when calling
  sequencer_commit() in rebase -i mode.

- simplified TODO_LIST_INIT and REPLAY_OPTS_INIT.

- added an example how to use sequencer_entrust() to the commit message
  introducing it.

- the gpg_sign option's value is now also entrusted to the sequencer
  (i.e. it is released in sequencer_remove_state()).

- renamed the "set_me_free_after_use" to "to_free". Since that is still
  not a self-explanatory name, add a comment to the function
  declaration.

- clarified in the "completely revamped todo parsing" commit message
  that the main benefit of the early parsing is for rebase -i.

- start the `enum todo_command` with TODO_PICK that is explicitly
  assigned the value 0.

- an error was marked as translatable.

- converted one forgotten git_path_todo_file() to use
  get_todo_path(opts) instead.

- fixed numbering of "malformed instruction sheet"s after removing one.

- reintroduced the overzealous assumption that todo scripts can only
  perform revert commands during `git revert` and pick commands during
  `git cherry-pick`. This overzealous assumption is *still* disabled in
  rebase -i mode, of course.

- clarified in the commit message why we call the field "arg", not
  "oneline", and fixed the description that claimed that we store the
  end offset (we store the length instead).

- clarified in the commit message of "allow editing the commit message
  on a case-by-case basis" that we are talking about the
  sequencer_commit() function, and how things were done previously.

- some grammar touch-ups.

- marked a couple of error messages for translation.

- explicitly assign the first todo_command the value 0, so that we can
  be certain that the array of command strings matches up.

- removed code to skip CR/LF at the end of line after reading with
  read_oneliner(): That function already ensures that.

- ensured that the todo_list is released even when reading/parsing fails.

- replaced an error(..., strerror()) call with an error_errno(...) one.

- clarified in the commit message why the new todo_list maintains the
  script as an array instead of a linked list.

- renamed the append_todo() function into append_new_todo(), to explain
  better what the function does and why it does not take the values as
  parameters that should populate the new todo_item.

- marked action_name() for translation.

- surrounded all file names in error messages in sequencer.c with single
  quotes, for consistency.

- removed a bogus hint for translators that asked them to translate
  commands of the git-rebase-todo file (or cherry-pick's equivalent).

- turned capitals after semicolons to lower-case.


Johannes Schindelin (25):
  sequencer: use static initializers for replay_opts
  sequencer: use memoized sequencer directory path
  sequencer: avoid unnecessary indirection
  sequencer: future-proof remove_sequencer_state()
  sequencer: allow the sequencer to take custody of malloc()ed data
  sequencer: release memory that was allocated when reading options
  sequencer: future-proof read_populate_todo()
  sequencer: completely revamp the "todo" script parsing
  sequencer: avoid completely different messages for different actions
  sequencer: get rid of the subcommand field
  sequencer: refactor the code to obtain a short commit name
  sequencer: remember the onelines when parsing the todo file
  sequencer: prepare for rebase -i's commit functionality
  sequencer: introduce a helper to read files written by scripts
  sequencer: prepare for rebase -i's GPG settings
  sequencer: allow editing the commit message on a case-by-case basis
  sequencer: support amending commits
  sequencer: support cleaning up commit messages
  sequencer: remember do_recursive_merge()'s return value
  sequencer: left-trim lines read from the script
  sequencer: refactor write_message()
  sequencer: remove overzealous assumption in rebase -i mode
  sequencer: mark action_name() for translation
  sequencer: quote filenames in error messages
  sequencer: remove bogus hint for translators

 builtin/commit.c |   2 +-
 builtin/revert.c |  42 ++--
 sequencer.c      | 632 +++++++++++++++++++++++++++++++++++++------------------
 sequencer.h      |  31 +--
 4 files changed, 468 insertions(+), 239 deletions(-)

Based-On: libify-sequencer at https://github.com/dscho/git
Fetch-Base-Via: git fetch https://github.com/dscho/git libify-sequencer
Published-As: https://github.com/dscho/git/releases/tag/prepare-sequencer-v2
Fetch-It-Via: git fetch https://github.com/dscho/git prepare-sequencer-v2

Interdiff vs v1:

 diff --git a/sequencer.c b/sequencer.c
 index 7d56676..cdff0f1 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -41,7 +41,10 @@ static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
  static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
  
  /* We will introduce the 'interactive rebase' mode later */
 -#define IS_REBASE_I() 0
 +static inline int is_rebase_i(const struct replay_opts *opts)
 +{
 +	return 0;
 +}
  
  static const char *get_dir(const struct replay_opts *opts)
  {
 @@ -145,12 +148,12 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
  	return buf.buf;
  }
  
 -void *sequencer_entrust(struct replay_opts *opts, void *set_me_free_after_use)
 +void *sequencer_entrust(struct replay_opts *opts, void *to_free)
  {
  	ALLOC_GROW(opts->owned, opts->owned_nr + 1, opts->owned_alloc);
 -	opts->owned[opts->owned_nr++] = set_me_free_after_use;
 +	opts->owned[opts->owned_nr++] = to_free;
  
 -	return set_me_free_after_use;
 +	return to_free;
  }
  
  int sequencer_remove_state(struct replay_opts *opts)
 @@ -173,7 +176,7 @@ int sequencer_remove_state(struct replay_opts *opts)
  
  static const char *action_name(const struct replay_opts *opts)
  {
 -	return opts->action == REPLAY_REVERT ? "revert" : "cherry-pick";
 +	return opts->action == REPLAY_REVERT ? N_("revert") : N_("cherry-pick");
  }
  
  struct commit_message {
 @@ -248,11 +251,11 @@ static int write_with_lock_file(const char *filename,
  	if (msg_fd < 0)
  		return error_errno(_("Could not lock '%s'"), filename);
  	if (write_in_full(msg_fd, buf, len) < 0)
 -		return error_errno(_("Could not write to %s"), filename);
 +		return error_errno(_("Could not write to '%s'"), filename);
  	if (append_eol && write(msg_fd, "\n", 1) < 0)
 -		return error_errno(_("Could not write eol to %s"), filename);
 +		return error_errno(_("Could not write eol to '%s"), filename);
  	if (commit_lock_file(&msg_file) < 0)
 -		return error(_("Error wrapping up %s."), filename);
 +		return error(_("Error wrapping up '%s'."), filename);
  
  	return 0;
  }
 @@ -309,10 +312,10 @@ static struct tree *empty_tree(void)
  static int error_dirty_index(struct replay_opts *opts)
  {
  	if (read_cache_unmerged())
 -		return error_resolve_conflict(action_name(opts));
 +		return error_resolve_conflict(_(action_name(opts)));
  
  	error(_("Your local changes would be overwritten by %s."),
 -		action_name(opts));
 +		_(action_name(opts)));
  
  	if (advice_commit_before_merge)
  		advise(_("Commit your changes or stash them to proceed."));
 @@ -330,7 +333,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
  	if (checkout_fast_forward(from, to, 1))
  		return -1; /* the callee should have complained already */
  
 -	strbuf_addf(&sb, _("%s: fast-forward"), action_name(opts));
 +	strbuf_addf(&sb, _("%s: fast-forward"), _(action_name(opts)));
  
  	transaction = ref_transaction_begin(&err);
  	if (!transaction ||
 @@ -406,7 +409,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
  	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
  		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
  		return error(_("%s: Unable to write new index file"),
 -			action_name(opts));
 +			_(action_name(opts)));
  	rollback_lock_file(&index_lock);
  
  	if (opts->signoff)
 @@ -488,9 +491,13 @@ static char **read_author_script(void)
   * If we are cherry-pick, and if the merge did not result in
   * hand-editing, we will hit this commit and inherit the original
   * author date and name.
 + *
   * If we are revert, or if our cherry-pick results in a hand merge,
 - * we had better say that the current user is responsible for that
 - * (except, of course, while running an interactive rebase).
 + * we had better say that the current user is responsible for that.
 + *
 + * An exception is when sequencer_commit() is called during an
 + * interactive rebase: in that case, we will want to retain the
 + * author metadata.
   */
  int sequencer_commit(const char *defmsg, struct replay_opts *opts,
  			  int allow_empty, int edit, int amend,
 @@ -501,7 +508,7 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
  	int rc;
  	const char *value;
  
 -	if (IS_REBASE_I()) {
 +	if (is_rebase_i(opts)) {
  		env = read_author_script();
  		if (!env) {
  			const char *gpg_opt = gpg_sign_opt_quoted(opts);
 @@ -513,7 +520,7 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
  				"If they are meant to go into a new commit, "
  				"run:\n\n"
  				"  git commit %s\n\n"
 -				"In both case, once you're done, continue "
 +				"In both cases, once you're done, continue "
  				"with:\n\n"
  				"  git rebase --continue\n", gpg_opt, gpg_opt);
  		}
 @@ -613,7 +620,7 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
  }
  
  enum todo_command {
 -	TODO_PICK,
 +	TODO_PICK = 0,
  	TODO_REVERT
  };
  
 @@ -690,8 +697,6 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  		return fast_forward_to(commit->object.oid.hash, head, unborn, opts);
  
  	if (parent && parse_commit(parent) < 0)
 -		/* TRANSLATORS: The first %s will be "revert" or
 -		   "cherry-pick", the second %s a SHA1 */
  		return error(_("%s: cannot parse parent commit %s"),
  			command_to_string(command),
  			oid_to_hex(&parent->object.oid));
 @@ -833,14 +838,14 @@ static int read_and_refresh_cache(struct replay_opts *opts)
  	if (read_index_preload(&the_index, NULL) < 0) {
  		rollback_lock_file(&index_lock);
  		return error(_("git %s: failed to read the index"),
 -			action_name(opts));
 +			_(action_name(opts)));
  	}
  	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
  	if (the_index.cache_changed && index_fd >= 0) {
  		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK)) {
  			rollback_lock_file(&index_lock);
  			return error(_("git %s: failed to refresh the index"),
 -				action_name(opts));
 +				_(action_name(opts)));
  		}
  	}
  	rollback_lock_file(&index_lock);
 @@ -861,7 +866,7 @@ struct todo_list {
  	int nr, alloc, current;
  };
  
 -#define TODO_LIST_INIT { STRBUF_INIT, NULL, 0, 0, 0 }
 +#define TODO_LIST_INIT { STRBUF_INIT }
  
  static void todo_list_release(struct todo_list *todo_list)
  {
 @@ -871,7 +876,7 @@ static void todo_list_release(struct todo_list *todo_list)
  	todo_list->nr = todo_list->alloc = 0;
  }
  
 -struct todo_item *append_todo(struct todo_list *todo_list)
 +struct todo_item *append_new_todo(struct todo_list *todo_list)
  {
  	ALLOC_GROW(todo_list->items, todo_list->nr + 1, todo_list->alloc);
  	return todo_list->items + todo_list->nr++;
 @@ -925,11 +930,11 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
  	for (i = 1; *p; i++) {
  		char *eol = strchrnul(p, '\n');
  
 -		item = append_todo(todo_list);
 +		item = append_new_todo(todo_list);
  		item->offset_in_buf = p - todo_list->buf.buf;
  		if (parse_insn_line(item, p, eol)) {
 -			error("Invalid line: %.*s", (int)(eol - p), p);
 -			res |= error(_("Could not parse line %d."), i);
 +			res |= error(_("Invalid line %d: %.*s"),
 +				i, (int)(eol - p), p);
  			item->command = -1;
  		}
  		p = *eol ? eol + 1 : eol;
 @@ -948,16 +953,31 @@ static int read_populate_todo(struct todo_list *todo_list,
  	strbuf_reset(&todo_list->buf);
  	fd = open(todo_file, O_RDONLY);
  	if (fd < 0)
 -		return error_errno(_("Could not open %s"), todo_file);
 +		return error_errno(_("Could not open '%s'"), todo_file);
  	if (strbuf_read(&todo_list->buf, fd, 0) < 0) {
  		close(fd);
 -		return error(_("Could not read %s."), todo_file);
 +		return error(_("Could not read '%s'."), todo_file);
  	}
  	close(fd);
  
  	res = parse_insn_buffer(todo_list->buf.buf, todo_list);
  	if (res)
 -		return error(_("Unusable instruction sheet: %s"), todo_file);
 +		return error(_("Unusable instruction sheet: '%s'"), todo_file);
 +
 +	if (!is_rebase_i(opts)) {
 +		enum todo_command valid =
 +			opts->action == REPLAY_PICK ? TODO_PICK : TODO_REVERT;
 +		int i;
 +
 +		for (i = 0; i < todo_list->nr; i++)
 +			if (valid == todo_list->items[i].command)
 +				continue;
 +			else if (valid == TODO_PICK)
 +				return error(_("Cannot cherry-pick during a revert."));
 +			else
 +				return error(_("Cannot revert during a cherry-pick."));
 +	}
 +
  	return 0;
  }
  
 @@ -1003,22 +1023,16 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
  
  static int read_populate_opts(struct replay_opts *opts)
  {
 -	if (IS_REBASE_I()) {
 +	if (is_rebase_i(opts)) {
  		struct strbuf buf = STRBUF_INIT;
  
  		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
 -			if (buf.len && buf.buf[buf.len - 1] == '\n') {
 -				if (--buf.len &&
 -				    buf.buf[buf.len - 1] == '\r')
 -					buf.len--;
 -				buf.buf[buf.len] = '\0';
 -			}
 -
  			if (!starts_with(buf.buf, "-S"))
  				strbuf_reset(&buf);
  			else {
  				opts->gpg_sign = buf.buf + 2;
 -				strbuf_detach(&buf, NULL);
 +				sequencer_entrust(opts,
 +					strbuf_detach(&buf, NULL));
  			}
  		}
  
 @@ -1034,7 +1048,7 @@ static int read_populate_opts(struct replay_opts *opts)
  	 * are pretty certain that it is syntactically correct.
  	 */
  	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), opts) < 0)
 -		return error(_("Malformed options sheet: %s"),
 +		return error(_("Malformed options sheet: '%s'"),
  			git_path_opts_file());
  	return 0;
  }
 @@ -1044,13 +1058,14 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
  {
  	enum todo_command command = opts->action == REPLAY_PICK ?
  		TODO_PICK : TODO_REVERT;
 +	const char *command_string = todo_command_strings[command];
  	struct commit *commit;
  
  	if (prepare_revs(opts))
  		return -1;
  
  	while ((commit = get_revision(opts->revs))) {
 -		struct todo_item *item = append_todo(todo_list);
 +		struct todo_item *item = append_new_todo(todo_list);
  		const char *commit_buffer = get_commit_buffer(commit, NULL);
  		const char *subject;
  		int subject_len;
 @@ -1061,8 +1076,7 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
  		item->arg_len = 0;
  		item->offset_in_buf = todo_list->buf.len;
  		subject_len = find_commit_subject(commit_buffer, &subject);
 -		strbuf_addf(&todo_list->buf, "%s %s %.*s\n",
 -			opts->action == REPLAY_PICK ?  "pick" : "revert",
 +		strbuf_addf(&todo_list->buf, "%s %s %.*s\n", command_string,
  			short_commit_name(commit), subject_len, subject);
  		unuse_commit_buffer(commit, commit_buffer);
  	}
 @@ -1077,7 +1091,7 @@ static int create_seq_dir(void)
  		return -1;
  	}
  	else if (mkdir(git_path_seq_dir(), 0777) < 0)
 -		return error_errno(_("Could not create sequencer directory %s"),
 +		return error_errno(_("Could not create sequencer directory '%s'"),
  				   git_path_seq_dir());
  	return 0;
  }
 @@ -1096,12 +1110,12 @@ static int save_head(const char *head)
  	strbuf_addf(&buf, "%s\n", head);
  	if (write_in_full(fd, buf.buf, buf.len) < 0) {
  		rollback_lock_file(&head_lock);
 -		return error_errno(_("Could not write to %s"),
 +		return error_errno(_("Could not write to '%s'"),
  				   git_path_head_file());
  	}
  	if (commit_lock_file(&head_lock) < 0) {
  		rollback_lock_file(&head_lock);
 -		return error(_("Error wrapping up %s."), git_path_head_file());
 +		return error(_("Error wrapping up '%s'."), git_path_head_file());
  	}
  	return 0;
  }
 @@ -1136,9 +1150,6 @@ int sequencer_rollback(struct replay_opts *opts)
  	unsigned char sha1[20];
  	struct strbuf buf = STRBUF_INIT;
  
 -	if (read_and_refresh_cache(opts))
 -		return -1;
 -
  	f = fopen(git_path_head_file(), "r");
  	if (!f && errno == ENOENT) {
  		/*
 @@ -1149,9 +1160,9 @@ int sequencer_rollback(struct replay_opts *opts)
  		return rollback_single_pick();
  	}
  	if (!f)
 -		return error_errno(_("cannot open %s"), git_path_head_file());
 +		return error_errno(_("cannot open '%s'"), git_path_head_file());
  	if (strbuf_getline_lf(&buf, f)) {
 -		error(_("cannot read %s: %s"), git_path_head_file(),
 +		error(_("cannot read '%s': %s"), git_path_head_file(),
  		      ferror(f) ?  strerror(errno) : _("unexpected end of file"));
  		fclose(f);
  		goto fail;
 @@ -1183,16 +1194,14 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
  
  	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0);
  	if (fd < 0)
 -		return error_errno(_("Could not lock '%s'"),
 -				   git_path_todo_file());
 +		return error_errno(_("Could not lock '%s'"), todo_path);
  	offset = next < todo_list->nr ?
  		todo_list->items[next].offset_in_buf : todo_list->buf.len;
  	if (write_in_full(fd, todo_list->buf.buf + offset,
  			todo_list->buf.len - offset) < 0)
 -		return error(_("Could not write to %s (%s)"),
 -			todo_path, strerror(errno));
 +		return error_errno(_("Could not write to '%s'"), todo_path);
  	if (commit_lock_file(&todo_lock) < 0)
 -		return error(_("Error wrapping up %s."), todo_path);
 +		return error(_("Error wrapping up '%s'."), todo_path);
  	return 0;
  }
  
 @@ -1279,21 +1288,25 @@ int sequencer_continue(struct replay_opts *opts)
  
  	if (!file_exists(get_todo_path(opts)))
  		return continue_single_pick();
 -	if (read_populate_opts(opts) ||
 -			read_populate_todo(&todo_list, opts))
 +	if (read_populate_opts(opts))
  		return -1;
 +	if ((res = read_populate_todo(&todo_list, opts)))
 +		goto release_todo_list;
  
  	/* Verify that the conflict has been resolved */
  	if (file_exists(git_path_cherry_pick_head()) ||
  	    file_exists(git_path_revert_head())) {
 -		int ret = continue_single_pick();
 -		if (ret)
 -			return ret;
 +		res = continue_single_pick();
 +		if (res)
 +			goto release_todo_list;
 +	}
 +	if (index_differs_from("HEAD", 0)) {
 +		res = error_dirty_index(opts);
 +		goto release_todo_list;
  	}
 -	if (index_differs_from("HEAD", 0))
 -		return error_dirty_index(opts);
  	todo_list.current++;
  	res = pick_commits(&todo_list, opts);
 +release_todo_list:
  	todo_list_release(&todo_list);
  	return res;
  }
 diff --git a/sequencer.h b/sequencer.h
 index e272549..688fff1 100644
 --- a/sequencer.h
 +++ b/sequencer.h
 @@ -40,9 +40,13 @@ struct replay_opts {
  	void **owned;
  	int owned_nr, owned_alloc;
  };
 -#define REPLAY_OPTS_INIT { -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, 0 }
 +#define REPLAY_OPTS_INIT { -1 }
  
 -void *sequencer_entrust(struct replay_opts *opts, void *set_me_free_after_use);
 +/*
 + * Make it the duty of sequencer_remove_state() to release the memory;
 + * For ease of use, return the same pointer.
 + */
 +void *sequencer_entrust(struct replay_opts *opts, void *to_free);
  
  int sequencer_pick_revisions(struct replay_opts *opts);
  int sequencer_continue(struct replay_opts *opts);
 diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
 index 6465edf..7b7a89d 100755
 --- a/t/t3510-cherry-pick-sequence.sh
 +++ b/t/t3510-cherry-pick-sequence.sh
 @@ -459,6 +459,17 @@ test_expect_success 'malformed instruction sheet 1' '
  	test_expect_code 128 git cherry-pick --continue
  '
  
 +test_expect_success 'malformed instruction sheet 2' '
 +	pristine_detach initial &&
 +	test_expect_code 1 git cherry-pick base..anotherpick &&
 +	echo "resolved" >foo &&
 +	git add foo &&
 +	git commit &&
 +	sed "s/pick/revert/" .git/sequencer/todo >new_sheet &&
 +	cp new_sheet .git/sequencer/todo &&
 +	test_expect_code 128 git cherry-pick --continue
 +'
 +
  test_expect_success 'empty commit set' '
  	pristine_detach initial &&
  	test_expect_code 128 git cherry-pick base..base

-- 
2.10.0.windows.1.10.g803177d

base-commit: 8a04d01a511ecffba8a397d26ee7fa6ca56b6e7e
