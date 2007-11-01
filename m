From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Wed, 31 Oct 2007 22:41:06 -0700
Message-ID: <7vmytycykt.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 06:41:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InSo4-000486-W1
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 06:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbXKAFlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 01:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753315AbXKAFlN
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 01:41:13 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:42146 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873AbXKAFlM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 01:41:12 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 06E4B2F0;
	Thu,  1 Nov 2007 01:41:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 004BB8EEB1;
	Thu,  1 Nov 2007 01:41:31 -0400 (EDT)
X-master-at: afc05f9f13beded8caf15d8e58d06fd64e0f7808
X-next-at: f8c835e2fa59ebe9e2038e9d2fdde0ae27c12505
In-Reply-To: <7vzly84qwf.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 24 Oct 2007 05:51:28 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62920>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

I think it is time to plan freezing for 1.5.4 and this list is a
good place to start.

* js/forkexec (Fri Oct 19 21:48:06 2007 +0200) 14 commits
 + Use the asyncronous function infrastructure to run the content
   filter.
 + Avoid a dup2(2) in apply_filter() - start_command() can do it for
   us.
 + t0021-conversion.sh: Test that the clean filter really cleans
   content.
 + upload-pack: Run rev-list in an asynchronous function.
 + upload-pack: Move the revision walker into a separate function.
 + Use the asyncronous function infrastructure in builtin-fetch-
   pack.c.
 + Add infrastructure to run a function asynchronously.
 + upload-pack: Use start_command() to run pack-objects in
   create_pack_file().
 + Have start_command() create a pipe to read the stderr of the
   child.
 + Use start_comand() in builtin-fetch-pack.c instead of explicit
   fork/exec.
 + Use run_command() to spawn external diff programs instead of
   fork/exec.
 + Use start_command() to run content filters instead of explicit
   fork/exec.
 + Use start_command() in git_connect() instead of explicit
   fork/exec.
 + Change git_connect() to return a struct child_process instead of a
   pid_t.

I haven't seen anything wrong with this series and we haven't
heard breakages from people on 'next' who have been running with
this for the past ten days.  Will merge to 'master'.

* db/remote-builtin (Mon Oct 29 22:03:42 2007 -0400) 4 commits
 - Use built-in send-pack.
 - Build-in send-pack, with an API for other programs to call.
 - Build-in peek-remote, using transport infrastructure.
 - Miscellaneous const changes and utilities

Will be in 'next' soon after reviewing it again; hopefully in
'master' before 1.5.4.

* ph/parseopt (Tue Oct 30 14:15:21 2007 -0500) 23 commits
 + Fixed a command line option type for builtin-fsck.c
 + Make builtin-pack-refs.c use parse_options.
 + Make builtin-name-rev.c use parse_options.
 + Make builtin-count-objects.c use parse_options.
 + Make builtin-fsck.c use parse_options.
 + Update manpages to reflect new short and long option aliases
 + Make builtin-for-each-ref.c use parse-opts.
 + Make builtin-symbolic-ref.c use parse_options.
 + Make builtin-update-ref.c use parse_options
 + Make builtin-revert.c use parse_options.
 + Make builtin-describe.c use parse_options
 + Make builtin-branch.c use parse_options.
 + Make builtin-mv.c use parse-options
 + Make builtin-rm.c use parse_options.
 + Port builtin-add.c to use the new option parser.
 + parse-options: allow callbacks to take no arguments at all.
 + parse-options: Allow abbreviated options when unambiguous
 + Add shortcuts for very often used options.
 + parse-options: make some arguments optional, add callbacks.
 + Rework make_usage to print the usage message immediately
 + Add tests for parse-options.c
 + parse-options: be able to generate usages automatically
 + Add a simple option parser.

It appears 1.5.4 will be, to a certain extent, a "Let's clean up
the internal implementation" release.  This series should become
part of it.  Hopefully will merge to 'master' soon, but I
haven't looked this series very closely yet.

* kh/commit (Mon Sep 17 20:06:47 2007 -0400) 4 commits
 + Export rerere() and launch_editor().
 + Introduce entry point add_interactive and add_files_to_cache
 + Enable wt-status to run against non-standard index file.
 + Enable wt-status output to a given FILE pointer.

These four alone do not change anything user visible, as the
final goal of this series which is "git-commit in C" is not here
yet.  But with the other topics touching internal API left and
right that is understandable.  Will merge to 'master'.

* sp/help (Sat Oct 27 01:36:55 2007 -0700) 7 commits
 + shell should call the new setup_path() to setup $PATH
 + include $PATH in generating list of commands for "help -a"
 + use only the $PATH for exec'ing git commands
 + list_commands(): simplify code by using chdir()
 + "current_exec_path" is a misleading name, use "argv_exec_path"
 + remove unused/unneeded "pattern" argument of list_commands
 + "git" returns 1; "git help" and "git help -a" return 0

Will merge to 'master'.

* sp/mergetool (Thu Oct 18 12:25:34 2007 +0200) 3 commits
 + mergetool: avoid misleading message "Resetting to default..."
 + mergetool: add support for ECMerge
 + mergetool: use path to mergetool in config var
   mergetool.<tool>.path

Will merge to 'master'.

* jc/stash-create (Mon Jul 9 00:51:23 2007 -0700) 2 commits
 + rebase: allow starting from a dirty tree.
 + stash: implement "stash create"

Will revert at least the latter one, but perhaps both, from
'next'.  The traditional behaviour of refusing to work in a
dirty tree is much safer, as the tool cannot decide where to
unstash for you.

* js/reflog-delete (Wed Oct 17 02:50:45 2007 +0100) 1 commit
 + Teach "git reflog" a subcommand to delete single entries

This by itself is not useful; will stay in 'next' until it is
used by selective clearing of stash or something else.

* jc/revert-merge (Tue Oct 23 13:33:26 2007 -0700) 1 commit
 + revert/cherry-pick: work on merge commits as well

This allows cherry-pick and revert to act on a merge commit if
you specify which parent to pick the changes from.  I think it
would probably be handy when the need arises, but I suspect such
a need is felt only occasionally.  I haven't heard any comment
on the list since it was posted.  I am somewhat tempted to merge
this, but I am not in a hurry.

* np/progress (Wed Oct 31 23:57:04 2007 -0400) 17 commits
 . Show total transferred as part of throughput progress display
 - add throughput display to git-push
 - add some copyright notice to the progress display code
 - add throughput display to index-pack
 - add throughput to progress display
 - relax usage of the progress API
 - make struct progress an opaque type
 - prune-packed: don't call display_progress() for every file
 + Stop displaying "Pack pack-$ID created." during git-gc
 + Teach prune-packed to use the standard progress meter
 + Change 'Deltifying objects' to 'Compressing objects'
 + fix for more minor memory leaks
 + fix const issues with some functions
 + pack-objects.c: fix some global variable abuse and memory leaks
 + pack-objects: no delta possible with only one object in the list
 + cope with multiple line breaks within sideband progress messages
 + more compact progress display

This would give us a good usability enhancement.  Will merge the
first half to 'master', cook the rest in 'next' and aim to merge
the whole thing before 1.5.4.

* jc/format-patch-encoding (Wed Oct 31 14:55:17 2007 -0700) 1 commit
 - format-patch -s: add MIME encoding header if signer's name
   requires so

Topic appeared today.  I think this is a safe and sane
fix to a real problem.  Needs cherry-pick to 'maint'.

* jc/spht (Tue Oct 2 18:00:27 2007 -0700) 1 commit
 - git-diff: complain about >=8 consecutive spaces in initial indent

This is a counterpart of an earlier patch from J. Bruce Fields
to change "git-apply --whitespace" to make SP{8,} at the
beginning of line a whitespace error.

Personally, I am in favor of the stricter check, but I had to
reject the "git-apply" patch because there was no way to disable
the additional check without disabling the existing check for
trailing whitespaces.  We probably would want to revisit that
one (perhaps with a new option and/or config to selectively
enable different kinds of whitespace check).

* dz/color-addi (Tue Oct 16 21:42:23 2007 -0400) 1 commit
 - Add color support to git-add--interactive

I am not a big fan of color, and Shawn's "What's cooking"
mentioned issues with the implementation.  Will not merge to
'next'.

* sp/push-refspec (Sun Oct 28 18:46:20 2007 +0100) 6 commits
 - push: teach push to pass --verbose option to transport layer
 - push: teach push to accept --verbose option
 - push: use same rules as git-rev-parse to resolve refspecs
 - add ref_abbrev_matches_full_with_rev_parse_rules() comparing
   abbrev with full ref name
 - rename ref_matches_abbrev() to
   ref_abbrev_matches_full_with_fetch_rules()
 - push: support pushing HEAD to real branch name

I have been meaning to review these again and merge to 'next'
but it seems I've been spending more time discussing the ones I
did not even pick up for 'pu'.  Will try to find time to do so.

* jk/terse-fetch (Fri Oct 19 03:40:57 2007 -0400) 2 commits
 - park
 - git-fetch: mega-terse fetch output

No change ;-)

* jc/nu (Sun Oct 14 22:07:34 2007 -0700) 3 commits
 - merge-nu: a new merge backend without using unpack_trees()
 - read_tree: take an explicit index structure
 - gcc 4.2.1 -Werror -Wall -ansi -pedantic -std=c99: minimum fix

I was hoping that I can work on this series while in Japan, but
attending funeral and helping others to deal with the fallout
sucked all my energy and time.  This is still a wip and not
progressing.

* jc/pathspec (Thu Sep 13 13:38:19 2007 -0700) 3 commits
 - pathspec_can_match(): move it from builtin-ls-tree.c to tree.c
 - ls-tree.c: refactor show_recursive() and rename it.
 - tree-diff.c: split out a function to match a single pattern.

My pet project to unify the pathspec handling between tree-diff
family and ls-files family (one side only knows "in this
directory" match, and the other knows how to handle fnmatch
globs as well).  Stalled.

* jk/rename (Tue Oct 30 00:24:42 2007 -0400) 3 commits
 . handle renames using similarity engine
 . introduce generic similarity library
 . change hash table calling conventions

Aiming for a worthy goal, but not merged to 'pu' yet.

* tf/afs (Fri Oct 19 07:38:16 2007 -0500) 1 commit
 . Better support AFS hardlinking across object directories

Will drop from topic queue.  This is labelled as "AFS hack", but
it hacks around a problem AFS has by breaking the safety we had
from very early days of git for everybody else.
