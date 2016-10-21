Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DB7320229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755244AbcJUMYH (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:24:07 -0400
Received: from mout.gmx.net ([212.227.15.15]:58853 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754423AbcJUMYF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:24:05 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lt1eU-1cudo03zKs-012Vc0; Fri, 21 Oct 2016 14:23:47
 +0200
Date:   Fri, 21 Oct 2016 14:23:45 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 00/27] Prepare the sequencer for the upcoming rebase -i
 patches
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zLtOoMRkZ6T2PTZCWoGBidShCK0B4gvKFsR2N+tmmcCY7psdwgk
 TvZ/kE2/EIelXQF61qj3rZH+Yyt9D1mXTYS4cjxyYURVrqcAcG0PvPGfx1k+468k+HIreSe
 dFxSFtLL5bF7Gn4Z0sgyhDej0Op1ubfKQZFsxxc/X9/edO4gz8QpMAt+vURlroYKWCoU3LF
 IaX3mU1yA5UF3PTs0uKEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:feEStPOAjp4=:g07KXsBLuklpibO/W9wbWH
 XZBaAlaNSDYFWPTSt2jUANdOr6PUOOfSCkNjqq+Fnhn92lp90d0Dw8+gqKem2NQ8VHTWMARkx
 uu893AUlWXKAwOnx6+Prl5z71eFirOA75hQBcv4l61DWSMkwrykekyc5KSt1cwNqWPmjjuoos
 wQqLL9dTUvJrAsnCS982bc67ej2uXoHSWA+/1NjYYyPI23JznnUszKDbfbHoakzXpr+pdoK++
 UUeWMptvWyAWZn9uBEOLuBmO58Klr4kdKMsnov51N+SxsNO7v7YdvNX2pnGwF/fV+aM3zPi1h
 7oXt5OjJLYYlB/hkDt46ssfx985HprLBS09xh6KNsTg45u9xnppoVC+8owfQ+OsoKJO4wzWHy
 woScBy4U5fxcDRnj4vxMVKN8Ty+yJCA5VkC2Xj4H2hrj8//RT3gb7rKrRvvxgw/Nwq1ccCYvH
 3YT5t2m0oTH+ERbBJDHJvF/dNWD159XiDxwrBORipZLOXrC8Fj48Uif28FqJLCVBtD2lEQpcr
 ocZiXtRnAN47IG39jjKwUBprfwg1ws46CPnp6wdXD+yE4amGbCgnxbsZGNXqMIxsysIuMjwW6
 aMiU13/yQ3q0NBgxgfqkPF9uONkJ8of5Ghkd4gVpSuG3ptgJMt6wg2P9vZj4UAHmjzEMhKCaP
 pFbSJ1hnh2xZOwtxN1aUH64WWCsWWeJFLYFjkUzAwjjJvugLxMsqRu8w2EYC/k0Dj4QTlY1S5
 MyIGksQl9pDzL+8aXd+G8U55AOFcidqFEO6ERT8O0DnYJru+xHs+fCpchYoVeRxBvvHbd3qqJ
 KO1V9on
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series marks the '4' in the countdown to speed up rebase -i
by implementing large parts in C (read: there will be three more patch
series after that before the full benefit hits git.git: sequencer-i,
rebase--helper and rebase-i-extra). It is based on the `libify-sequencer`
patch series I submitted earlier.

The patches in this series merely prepare the sequencer code for the
next patch series that actually teaches the sequencer to run rebase -i's
commands.

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
and it is time to put it into the users' hands. To that end, I already
integrated the whole shebang into Git for Windows 2.10.0 and 2.10.1
where it has been running without complaints (and some quite positive
feedback).

It would be *really* nice if we could get this patch series at least into
`next` soon, as it gets late and later for the rest of the patches to make
it into `master` in time for v2.11 (and it is not for lack of trying on my
end...).

Changes vs v4:

- clarified in a code comment that read_oneliner() is lenient when it
  comes to multi-line files: it still reads the entire file, but strips
  off only the final EOL (if any).

- rephrased a commit message to stop judging Junio's taste ;-)

- changed "strip LF" to "skip LF", as requested.

- rephrased a commit message to talk about pluggin memory leaks instead
  of stating that the memory is now eventually released.

- dropped the "sequencer: do not try to commit when there were merge
  conflicts" patch that appears to be no longer necessary.

- split and modified the commit refactoring write_message() according to
  Junio's suggestions.


Johannes Schindelin (27):
  sequencer: use static initializers for replay_opts
  sequencer: use memoized sequencer directory path
  sequencer: avoid unnecessary indirection
  sequencer: future-proof remove_sequencer_state()
  sequencer: plug memory leaks for the option values
  sequencer: future-proof read_populate_todo()
  sequencer: refactor the code to obtain a short commit name
  sequencer: completely revamp the "todo" script parsing
  sequencer: strip CR from the todo script
  sequencer: avoid completely different messages for different actions
  sequencer: get rid of the subcommand field
  sequencer: remember the onelines when parsing the todo file
  sequencer: prepare for rebase -i's commit functionality
  sequencer: introduce a helper to read files written by scripts
  sequencer: allow editing the commit message on a case-by-case basis
  sequencer: support amending commits
  sequencer: support cleaning up commit messages
  sequencer: left-trim lines read from the script
  sequencer: stop releasing the strbuf in write_message()
  sequencer: roll back lock file if write_message() failed
  sequencer: refactor write_message() to take a pointer/length
  sequencer: teach write_message() to append an optional LF
  sequencer: remove overzealous assumption in rebase -i mode
  sequencer: mark action_name() for translation
  sequencer: quote filenames in error messages
  sequencer: start error messages consistently with lower case
  sequencer: mark all error messages for translation

 builtin/commit.c              |   2 +-
 builtin/revert.c              |  46 ++-
 sequencer.c                   | 680 ++++++++++++++++++++++++++++--------------
 sequencer.h                   |  23 +-
 t/t3501-revert-cherry-pick.sh |   2 +-
 5 files changed, 492 insertions(+), 261 deletions(-)


base-commit: 659889482ac63411daea38b2c3d127842ea04e4d
Published-As: https://github.com/dscho/git/releases/tag/prepare-sequencer-v5
Fetch-It-Via: git fetch https://github.com/dscho/git prepare-sequencer-v5

Interdiff vs v4:

 diff --git a/sequencer.c b/sequencer.c
 index 1cf70f7..a61fe76 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -234,8 +234,8 @@ static void print_advice(int show_hint, struct replay_opts *opts)
  	}
  }
  
 -static int write_with_lock_file(const char *filename,
 -				const void *buf, size_t len, int append_eol)
 +static int write_message(const void *buf, size_t len, const char *filename,
 +			 int append_eol)
  {
  	static struct lock_file msg_file;
  
 @@ -258,16 +258,12 @@ static int write_with_lock_file(const char *filename,
  	return 0;
  }
  
 -static int write_message(struct strbuf *msgbuf, const char *filename)
 -{
 -	int res = write_with_lock_file(filename, msgbuf->buf, msgbuf->len, 0);
 -	strbuf_release(msgbuf);
 -	return res;
 -}
 -
  /*
 - * Reads a file that was presumably written by a shell script, i.e.
 - * with an end-of-line marker that needs to be stripped.
 + * Reads a file that was presumably written by a shell script, i.e. with an
 + * end-of-line marker that needs to be stripped.
 + *
 + * Note that only the last end-of-line marker is stripped, consistent with the
 + * behavior of "$(cat path)" in a shell script.
   *
   * Returns 1 if the file was read, 0 if it could not be read or does not exist.
   */
 @@ -762,12 +758,14 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  					 head, &msgbuf, opts);
  		if (res < 0)
  			return res;
 -		res |= write_message(&msgbuf, git_path_merge_msg());
 +		res |= write_message(msgbuf.buf, msgbuf.len,
 +				     git_path_merge_msg(), 0);
  	} else {
  		struct commit_list *common = NULL;
  		struct commit_list *remotes = NULL;
  
 -		res = write_message(&msgbuf, git_path_merge_msg());
 +		res = write_message(msgbuf.buf, msgbuf.len,
 +				    git_path_merge_msg(), 0);
  
  		commit_list_insert(base, &common);
  		commit_list_insert(next, &remotes);
 @@ -777,6 +775,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  		free_commit_list(common);
  		free_commit_list(remotes);
  	}
 +	strbuf_release(&msgbuf);
  
  	/*
  	 * If the merge was clean or if it failed due to conflict, we write
 @@ -808,7 +807,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  		res = allow;
  		goto leave;
  	}
 -	if (!res && !opts->no_commit)
 +	if (!opts->no_commit)
  		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
  				     opts, allow, opts->edit, 0, 0);
  
 @@ -934,7 +933,7 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
  	for (i = 1; *p; i++, p = next_p) {
  		char *eol = strchrnul(p, '\n');
  
 -		next_p = *eol ? eol + 1 /* strip LF */ : eol;
 +		next_p = *eol ? eol + 1 /* skip LF */ : eol;
  
  		if (p != eol && eol[-1] == '\r')
  			eol--; /* strip Carriage Return */

-- 
2.10.1.583.g721a9e0

