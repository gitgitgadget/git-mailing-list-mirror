From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Wed, 09 Jul 2008 19:32:44 -0700
Message-ID: <7vabgqsc37.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
 <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
 <7vwskjazql.fsf@gitster.siamese.dyndns.org>
 <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
 <7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
 <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
 <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
 <7vprpwhp7t.fsf@gitster.siamese.dyndns.org>
 <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org>
 <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 10 04:34:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGlyu-0002Y8-LQ
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 04:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbYGJCdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 22:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753370AbYGJCdB
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 22:33:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61211 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbYGJCc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 22:32:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B9C701B94F;
	Wed,  9 Jul 2008 22:32:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 552111B94E; Wed,  9 Jul 2008 22:32:53 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 816478D8-4E28-11DD-B018-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87933>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be applied to the maintenance series have "maint-" in their
names.

It already is beginning to become clear what 1.6.0 will look like.  What's
already in 'next' all are well intentioned (I do not guarantee they are
already bug-free --- that is what cooking them in 'next' is for) and are
good set of feature enhancements.  Bigger changes will be:

 * Port for MinGW.

 * With the default Makefile settings, most of the programs will be
   installed outside your $PATH, except for "git", "gitk", "git-gui" and
   some server side programs that need to be accessible for technical
   reasons.  Invoking a git subcommand as "git-xyzzy" from the command
   line has been deprecated since early 2006 (and officially announced in
   1.5.4 release notes); use of them from your scripts after adding
   output from "git --exec-path" to the $PATH will still be supported in
   1.6.0, but users are again strongly encouraged to adjust their
   scripts to use "git xyzzy" form, as we will stop installing
   "git-xyzzy" hardlinks for built-in commands in later releases.

 * git-merge will be rewritten in C.

 * default pack and idx versions will be updated as scheduled for some
   time ago.

 * GIT_CONFIG, which was only documented as affecting "git config", but
   actually affected all git commands, now only affects "git config".
   GIT_LOCAL_CONFIG, also only documented as affecting "git config" and
   not different from GIT_CONFIG in a useful way, is removed.

----------------------------------------------------------------
[New Topics]

* xx/merge-in-c-into-next (Wed Jul 9 13:51:46 2008 -0700) 4 commits
 + Teach git-merge -X<option> again.
 + Merge branch 'jc/merge-theirs' into xx/merge-in-c-into-next
 + builtin-merge.c: use parse_options_step() "incremental parsing"
   machinery
 + Merge branch 'ph/parseopt-step-blame' into xx/merge-in-c-into-next

I've described what this is in a separate message.

* jc/branch-merged (Tue Jul 8 17:55:47 2008 -0700) 3 commits
 + branch --merged/--no-merged: allow specifying arbitrary commit
 + branch --contains: default to HEAD
 + parse-options: add PARSE_OPT_LASTARG_DEFAULT flag

This builds on top of the parse-options enhancement series that
has been cooking in 'next' for some time.

* rs/imap (Wed Jul 9 22:29:02 2008 +0100) 5 commits
 + Documentation: Improve documentation for git-imap-send(1)
 + imap-send.c: more style fixes
 + imap-send.c: style fixes
 + git-imap-send: Support SSL
 + git-imap-send: Allow the program to be run from subdirectories of
   a git tree

* om/rerere-careful (Mon Jul 7 14:42:48 2008 +0200) 1 commit
 + builtin-rerere: more carefully find conflict markers

----------------------------------------------------------------
[Will merge to master soon]

* js/pick-root (Fri Jul 4 16:19:52 2008 +0100) 1 commit
 + Allow cherry-picking root commits

* ab/bundle (Sat Jul 5 17:26:40 2008 -0400) 1 commit
 + Teach git-bundle to read revision arguments from stdin like git-
   rev-list.

* sg/stash-k-i (Tue Jul 8 00:40:56 2008 -0700) 2 commits
 + Documentation: tweak use case in "git stash save --keep-index"
 + stash: introduce 'stash save --keep-index' option

One weakness of our "partial commit" workflow support used to be that the
user can incrementally build what is to be committed in the index but that
state cannot be tested as a whole in the working tree.  This allows you to
temporarily stash the remaining changes in the working tree so that the
index state before running "stash save --keep-index" can be seen in the
working tree to be tested and then committed.

* am/stash-branch (Mon Jul 7 02:50:10 2008 +0530) 2 commits
 + Add a test for "git stash branch"
 + Implement "git stash branch <newbranch> <stash>"

Creates a new branch out of the stashed state, after returning from the
interrupt that forced you to create the stash in the first place.

* tr/add-i-e (Thu Jul 3 00:00:00 2008 +0200) 3 commits
 + git-add--interactive: manual hunk editing mode
 + git-add--interactive: remove hunk coalescing
 + git-add--interactive: replace hunk recounting with apply --recount

Adds 'e/dit' action to interactive add command.

* jc/report-tracking (Sun Jul 6 02:54:56 2008 -0700) 5 commits
 + branch -r -v: do not spit out garbage
 + stat_tracking_info(): clear object flags used during counting
 + git-branch -v: show the remote tracking statistics
 + git-status: show the remote tracking statistics
 + Refactor "tracking statistics" code used by "git checkout"

Makes the "your branch is ahead of the tracked one by N commits" logic and
messages available to other commands; status and branch are updated.

----------------------------------------------------------------
[Actively Cooking]

* jc/rebase-orig-head (Tue Jul 8 00:12:22 2008 -0400) 2 commits
 + Documentation: mention ORIG_HEAD in am, merge, and rebase
 + Teach "am" and "rebase" to mark the original position with
   ORIG_HEAD

* ph/parseopt-step-blame (Wed Jul 9 23:38:34 2008 +0200) 18 commits
 + revisions: refactor handle_revision_opt into parse_revision_opt.
 + git-shortlog: migrate to parse-options partially.
 + git-blame: fix lapsus
 + git-blame: migrate to incremental parse-option [2/2]
 + git-blame: migrate to incremental parse-option [1/2]
 + revisions: split handle_revision_opt() from setup_revisions()
 + Merge branch 'jc/blame' (early part) into HEAD
 + parse-opt: add PARSE_OPT_KEEP_ARGV0 parser option.
 + parse-opt: fake short strings for callers to believe in.
 + parse-opt: do not print errors on unknown options, return -2
   intead.
 + parse-opt: create parse_options_step.
 + parse-opt: Export a non NORETURN usage dumper.
 + parse-opt: have parse_options_{start,end}.
 + git-blame --reverse
 + builtin-blame.c: allow more than 16 parents
 + builtin-blame.c: move prepare_final() into a separate function.
 + rev-list --children
 + revision traversal: --children option

Became active again ;-) This probably is ready for 'master' already,
except for the last two which I only looked at the patch and have not
used heavily in production yet.

* jc/merge-theirs (Mon Jun 30 22:18:57 2008 -0700) 5 commits
 + Make "subtree" part more orthogonal to the rest of merge-
   recursive.
 + Teach git-pull to pass -X<option> to git-merge
 + Teach git-merge to pass -X<option> to the backend strategy module
 + git-merge-recursive-{ours,theirs}
 + git-merge-file --ours, --theirs

Punting a merge by discarding your own work in conflicting parts but still
salvaging the parts that are cleanly automerged.  It is likely that this
will result in nonsense mishmash, but somehow often people want this, so
here they are.  The interface to the backends is updated so that you can
say "git merge -Xours -Xsubtree=foo/bar/baz -s recursive other" now.

* mv/merge-in-c (Mon Jul 7 19:24:20 2008 +0200) 15 commits
 + Build in merge
 + Fix t7601-merge-pull-config.sh on AIX
 + git-commit-tree: make it usable from other builtins
 + Add new test case to ensure git-merge prepends the custom merge
   message
 + Add new test case to ensure git-merge reduces octopus parents when
   possible
 + Introduce reduce_heads()
 + Introduce get_merge_bases_many()
 + Add new test to ensure git-merge handles more than 25 refs.
 + Introduce get_octopus_merge_bases() in commit.c
 + git-fmt-merge-msg: make it usable from other builtins
 + Move read_cache_unmerged() to read-cache.c
 + Add new test to ensure git-merge handles pull.twohead and
   pull.octopus
 + Move parse-options's skip_prefix() to git-compat-util.h
 + Move commit_list_count() to commit.c
 + Move split_cmdline() to alias.c

----------------------------------------------------------------
[Graduated to "master"]

* js/apply-root (Sun Jul 6 18:36:01 2008 -0700) 3 commits
 + git-apply --directory: make --root more similar to GNU diff
 + apply --root: thinkofix.
 + Teach "git apply" to prepend a prefix with "--root=<root>"

* jc/reflog-expire (Sat Jun 28 22:24:49 2008 -0700) 2 commits
 + Make default expiration period of reflog used for stash infinite
 + Per-ref reflog expiry configuration

As 1.6.0 will be a good time to make backward incompatible changes, the
tip commit makes the default expiry period of stash 'never', unless you
configure them to expire explicitly using gc.refs/stash.* variables.
Needs consensus, but I am guessing that enough people would want stash
that does not expire.

* jk/pager-config (Thu Jul 3 07:46:57 2008 -0400) 1 commit
 + Allow per-command pager config

----------------------------------------------------------------
[On Hold]

* sg/merge-options (Sun Apr 6 03:23:47 2008 +0200) 1 commit
 + merge: remove deprecated summary and diffstat options and config
   variables

This was previously in "will be in master soon" category, but it turns out
that the synonyms to the ones this one deletes are fairly new invention
that happend in 1.5.6 timeframe, and we cannot do this just yet.  Perhaps
in 1.7.0.

* jc/dashless (Thu Jun 26 16:43:34 2008 -0700) 2 commits
 + Revert "Make clients ask for "git program" over ssh and local
   transport"
 + Make clients ask for "git program" over ssh and local transport

This is the "botched" one.  Will be resurrected during 1.7.0 or 1.8.0
timeframe.

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use, but gitk will be
hit due to tcl/tk's limitation, so I am holding this back for now.

----------------------------------------------------------------
[Stalled/Needs more work]

* sb/sequencer (Tue Jul 1 04:38:34 2008 +0200) 4 commits
 . Migrate git-am to use git-sequencer
 . Add git-sequencer test suite (t3350)
 . Add git-sequencer prototype documentation
 . Add git-sequencer shell prototype

* jc/grafts (Wed Jul 2 17:14:12 2008 -0700) 1 commit
 - [BROKEN wrt shallow clones] Ignore graft during object transfer

Cloning or fetching from a repository from grafts did not send objects
that are hidden by grafts, but the commits in the resulting repository do
need these to pass fsck.  This fixes object transfer to ignore grafts.

Another fix is needed to git-prune so that it ignores grafts but treats
commits that are mentioned in grafts as reachable.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 7 commits
 - blame: show "previous" information in --porcelain/--incremental
   format
 - git-blame: refactor code to emit "porcelain format" output
 + git-blame --reverse
 + builtin-blame.c: allow more than 16 parents
 + builtin-blame.c: move prepare_final() into a separate function.
 + rev-list --children
 + revision traversal: --children option

The blame that finds where each line in the original lines moved to.  This
may help a GSoC project that wants to gather statistical overview of the
history.  The final presentation may need tweaking (see the log message of
the commit ""git-blame --reverse" on the series).

The tip two commits are for peeling to see what's behind the blamed
commit, which we should be able to separate out into an independent topic
from the rest.
