From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: What's cooking in git/spearce.git (topics)
Date: Mon, 22 Oct 2007 02:32:22 -0400
Message-ID: <20071022063222.GS14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 08:32:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjqqB-0000J4-No
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 08:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbXJVGcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 02:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752330AbXJVGcb
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 02:32:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47607 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278AbXJVGc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 02:32:27 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ijqpr-0003EL-Sm
	for git@vger.kernel.org; Mon, 22 Oct 2007 02:32:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B846C20FBAE; Mon, 22 Oct 2007 02:32:22 -0400 (EDT)
Content-Disposition: inline
X-master-at: dd8175f83c725619d72d6bbaacf8eaafc158edea
X-next-at: a7925cfd582cd182c2d28d40f30760b1c89bce87
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61955>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* cc/skip (Mon Oct 22 07:49:39 2007 +0200) 9 commits
 - Bisect: add a "bisect replay" test case.
 - Bisect: add "bisect skip" to the documentation.
 - Bisect: factorise "bisect_{bad,good,skip}" into "bisect_state".
 - Bisect: factorise some logging into "bisect_write".
 - Bisect: factorise "bisect_write_*" functions.
 - Bisect: implement "bisect skip" to mark untestable revisions.
 - Bisect: fix some white spaces and empty lines breakages.
 - rev-list documentation: add "--bisect-all".
 - rev-list: implement --bisect-all

Recently updated to use "skip".  I haven't had a chance to look at
this series so it just parked in pu for now.

* ds/gitweb (Mon Oct 22 10:28:03 2007 +1000) 1 commit
 + gitweb: Provide title attributes for abbreviated author names.

* lt/rename (Sun Oct 21 16:59:03 2007 -0700) 2 commits
 - Linear-time/space rename logic (exact renames only)
 - Split out "exact content match" phase of rename detection

t4001-diff-rename.sh failed while running tests on pu.  I'm pretty
sure its this topic from Linus.  Need to look at it further.

* js/PATH (Sun Oct 21 22:59:01 2007 +0100) 1 commit
 - execv_git_cmd(): also try PATH if everything else fails.

I raised a concern about GIT_EXEC_PATH="" making $PATH search before
the compiled in path, which is certainly new behavior and I don't
think its quite what was intended.  Parked in pu until I hear back.

* sp/help-exit0 (Sun Oct 21 14:47:45 2007 -0700) 1 commit
 . "git help" and "git help -a" shouldn't exit(1) unless they error

Breaks things because "git" (no arguments) no exits successful,
which is less than ideal.  Only "git help" and "git help branch"
should be exiting successful.

* ja/shorthelp (Sun Oct 21 01:41:41 2007 +0300) 1 commit
 + On error, do not list all commands, but point to --help option

This I like.  We'll see what the list thinks while using next.  :)

* db/fetch-pack (Sat Oct 20 16:03:49 2007 -0400) 60 commits
 + Define compat version of mkdtemp for systems lacking it
 + Avoid scary errors about tagged trees/blobs during git-fetch
 + fetch: if not fetching from default remote, ignore default merge
 + Support 'push --dry-run' for http transport
 + Support 'push --dry-run' for rsync transport
 + Fix 'push --all branch...' error handling
 + Fix compilation when NO_CURL is defined
 + Added a test for fetching remote tags when there is not tags.
 + Fix a crash in ls-remote when refspec expands into nothing
 ... and many many more ...

I think this is just about ready to graduate to master.  I haven't
seen any major problems with it since the recent fixes were put in.
I'd like to see it move over soon as a number of other topics
are based upon the tip of this topic rather than master itself.
But obviously code quality is more important than topic organization.

* js/forkexec (Fri Oct 19 21:48:06 2007 +0200) 74 commits
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
 ... db/fetch-pack begins here ...

This looked sane to me and makes it easier for the MinGW port.
Plus its an overal reduction in code, reusing the run-command
framework to avoid lots of ugly pipe() and dup2() calls.  Its
parked in next for a while to get some testing but is probably
fine to move to master in the near future.

* tf/afs (Fri Oct 19 07:38:16 2007 -0500) 1 commit
 - Better support AFS hardlinking across object directories

I'd rather rewrite this by putting the temporary files directly into
their final object directory, then hardlinking within that directory.
This should work on Coda and AFS, leaving only the FAT filesystem
as the odd-duck that needs to use rename().  But maybe I'm just
being really paranoid about not allowing an object to be replaced.

* jk/terse-fetch (Fri Oct 19 03:40:57 2007 -0400) 62 commits
 - park
 - git-fetch: mega-terse fetch output
 ... db/fetch-pack begins here ...

Much discussion on the list about this topic.  I think we may have
come to an agreement about what the output should look like, but
this topic doesn't implement that output format.  Someone needs to
either update this topic or rewrite it.  Starting from Jeff King's
patch makes things a lot easier.

* np/progress (Fri Oct 19 01:01:40 2007 -0400) 9 commits
 + Stop displaying "Pack pack-$ID created." during git-gc
 + Teach prune-packed to use the standard progress meter
 + Change 'Deltifying objects' to 'Compressing objects'
 + fix for more minor memory leaks
 + fix const issues with some functions
 + pack-objects.c: fix some global variable abuse and memory leaks
 + pack-objects: no delta possible with only one object in the list
 + cope with multiple line breaks within sideband progress messages
 + more compact progress display

I really like the new progress display that Nico implemented here,
and also the terser and more user friendly output from git-repack.
Needs more time for testing, but its pretty obvious code changes
and should be able to graduate to master in the near future.

* sp/mergetool (Thu Oct 18 12:25:34 2007 +0200) 3 commits
 + mergetool: avoid misleading message "Resetting to default..."
 + mergetool: add support for ECMerge
 + mergetool: use path to mergetool in config var
   mergetool.<tool>.path

Probably fine for master as-is.  I personally don't use mergetool so
I'd appreciate an Ack from someone who does that these are working
well for them.

* jk/send-pack (Thu Oct 18 02:17:46 2007 -0400) 2 commits
 + t5516: test update of local refs on push
 + send-pack: don't update tracking refs on error

This probably should graduate to master soon.  It just delays
updating the tracking refs until after we've made sure all refs
were updated.  I'll give it a few more days and then likely kick
it over to master.

* js/rebase (Wed Oct 17 10:31:35 2007 +0100) 1 commit
 + Fixing path quoting in git-rebase

Simple change, but rebase is a key tool.  I'll probably give this
a few more days and then kick it over.

* js/reflog-delete (Wed Oct 17 02:50:45 2007 +0100) 1 commit
 + Teach "git reflog" a subcommand to delete single entries

Waiting to hear if we're doing anything further with this.  it was
originally created to help "git stash" perform a pop, but nobody
has come forth with a patch for git-stash that uses this feature.
I'd like to have a real use for it that actually tests this code
in a more production setting before it merges to master.

* dz/color-addi (Tue Oct 16 21:42:23 2007 -0400) 1 commit
 - Add color support to git-add--interactive

I'm just parking this here in case anyone wants to pick this up and
continue it further.  I described on list to the original author
a number of problems with why this isn't in next yet; the author
said they will need a little bit of time before they can address
that list.

* ph/parseopt (Mon Oct 15 23:06:02 2007 +0200) 22 commits
 - Make builtin-pack-refs.c use parse_options.
 - Make builtin-name-rev.c use parse_options.
 - Make builtin-count-objects.c use parse_options.
 - Make builtin-fsck.c use parse_options.
 - Update manpages to reflect new short and long option aliases
 - Make builtin-for-each-ref.c use parse-opts.
 - Make builtin-symbolic-ref.c use parse_options.
 - Make builtin-update-ref.c use parse_options
 - Make builtin-revert.c use parse_options.
 - Make builtin-describe.c use parse_options
 - Make builtin-branch.c use parse_options.
 - Make builtin-mv.c use parse-options
 - Make builtin-rm.c use parse_options.
 - Port builtin-add.c to use the new option parser.
 - parse-options: allow callbacks to take no arguments at all.
 - parse-options: Allow abbreviated options when unambiguous
 - Add shortcuts for very often used options.
 - parse-options: make some arguments optional, add callbacks.
 - Rework make_usage to print the usage message immediately
 - Add tests for parse-options.c
 - parse-options: be able to generate usages automatically
 - Add a simple option parser.

There's actually a few other commits (3?) missing from the above
list that are safely parked away in my tree.  I'm most of the way
through reviewing these and have made a few bug fixes and style
nit corrections in the earlier parts of the series.  I'm going to
try and finish working through this series tomorrow and then will
probably merge it to next.

The other 3 commits are hanging off to the side as 2 of them are
for the top of db/fetch-pack (to port builtin-fetch and friends
to the new option parser) and the 3rd is a somewhat questionable
change due to needing to rename a "-h" to a "-H".  I just got
tired of rebasing these 3 other commits onto the respective topics.
I'm waiting for the core option parser (above) to freeze on a commit
SHA-1 before I deal with these again.

* sp/push-refspec (Sun Oct 14 10:54:45 2007 +0200) 6 commits
 - push, send-pack: use same rules as git-rev-parse to resolve
   refspecs
 - add ref_cmp_full_short() comparing full ref name with a short name
 - push, send-pack: support pushing HEAD to real ref name
 - rev-parse: teach "git rev-parse --symbolic" to print the full ref
   name
 - add get_sha1_with_real_ref() returning full name of ref on demand
 - push, send-pack: fix test if remote branch exists for colon-less
   refspec

I've briefly looked at this series and there's reasons why its not
in next yet.  Its actually something that I'm interested in seeing
fixed as the current behavior of how git-push matches refs on the
remote side is just plain nuts.  I'll look at it further after I
get ph/parseopt and cc/skip into next.

* jc/spht (Tue Oct 2 18:00:27 2007 -0700) 1 commit
 - git-diff: complain about >=8 consecutive spaces in initial indent
* jc/nu (Mon Oct 1 19:35:12 2007 -0700) 2 commits
 - PARK a bit more work
 - (PARK) WIP

I inherited these from Junio.  No change.

* kh/commit (Mon Sep 17 20:06:47 2007 -0400) 4 commits
 + Export rerere() and launch_editor().
 + Introduce entry point add_interactive and add_files_to_cache
 + Enable wt-status to run against non-standard index file.
 + Enable wt-status output to a given FILE pointer.

Waiting on ph/parseopt (above) and other stuff for builtin-commit.

* jc/pathspec (Thu Sep 13 13:38:19 2007 -0700) 3 commits
 - pathspec_can_match(): move it from builtin-ls-tree.c to tree.c
 - ls-tree.c: refactor show_recursive() and rename it.
 - tree-diff.c: split out a function to match a single pattern.

Also inherited from Junio.  No change.

* js/stash-create (Mon Jul 9 00:51:23 2007 -0700) 2 commits
 + rebase: allow starting from a dirty tree.
 + stash: implement "stash create"

I actually had the "dirty work tree stash in rebase" thing trip on
me recently and I got a little pissed off about it.  The behavior
was not what I expected, nor what I wanted, at that particular point
in time.  Actually I wanted git-rebase to stop and *not* attempt
the rebase because of the dirty work tree.  So I'm not feeling the
"auto stash" love right now.

-- 
Shawn.
